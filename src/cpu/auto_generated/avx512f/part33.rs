use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_mask_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_mask_unpacklo_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_array_equality(&result, &[5.0, 2.0, 7.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_unpacklo_pd(create_random__m256d(), create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_maskz_unpacklo_pd(create__mmask8_from(0b01010101), create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 0.0, 3.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_unpacklo_pd(create_random__mmask8(), create_random__m256d(), create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_unpacklo_pd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_array_equality(&result, &[3.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_unpacklo_pd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_unpacklo_pd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_array_equality(&result, &[1.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_unpacklo_pd(create_random__mmask8(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps128_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castps128_ps512(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps128_ps512(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps256_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castps256_ps512(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps256_ps512(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextps128_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_zextps128_ps512(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextps128_ps512(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextps256_ps512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_zextps256_ps512(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextps256_ps512(create_random__m256());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps512_ps128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm512_castps512_ps128(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps512_ps128(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps512_ps256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm512_castps512_ps256(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps512_ps256(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castps_pd(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[2.000000473111868, 512.0001225471497, 8192.001972198486, 131072.0316772461, 524288.1270751953, 2097152.5092773438, 8388610.041015625, 33554440.1796875])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps_pd(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castps_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castps_si512(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432, 1084227584, 1086324736, 1088421888, 1090519040, 1091567616, 1092616192, 1093664768, 1094713344, 1095761920, 1096810496, 1097859072, 1098907648])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castps_si512(create_random__m512());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd128_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castpd128_pd512(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd128_pd512(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd256_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castpd256_pd512(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd256_pd512(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextpd128_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_zextpd128_pd512(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextpd128_pd512(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextpd256_pd512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_zextpd256_pd512(create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextpd256_pd512(create_random__m256d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd512_pd128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm512_castpd512_pd128(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 2.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd512_pd128(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd512_pd256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm512_castpd512_pd256(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd512_pd256(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castpd_ps(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0, 1.875, 0.0, 2.0, 0.0, 2.125, 0.0, 2.25, 0.0, 2.3125, 0.0, 2.375, 0.0, 2.4375, 0.0, 2.5])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd_ps(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castpd_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castpd_si512(create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0, 1072693248, 0, 1073741824, 0, 1074266112, 0, 1074790400, 0, 1075052544, 0, 1075314688, 0, 1075576832, 0, 1075838976])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castpd_si512(create_random__m512d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi128_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi128_si512(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi256_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi256_si512(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi256_si512(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextsi128_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_zextsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextsi128_si512(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_zextsi256_si512() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_zextsi256_si512(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_zextsi256_si512(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm512_castsi512_si128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_si128(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_si256() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm512_castsi512_si256(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_si256(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_castsi512_ps(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45, 7e-45, 8e-45, 1e-44, 1.1e-44, 1.3e-44, 1.4e-44, 1.5e-44, 1.7e-44, 1.8e-44, 2e-44, 2.1e-44, 2.2e-44])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_ps(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_castsi512_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_castsi512_pd(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314, 1.27319747483e-313, 1.6975966331e-313, 2.1219957914e-313, 2.5463949497e-313, 2.970794108e-313, 3.3951932663e-313])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_castsi512_pd(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtsi512_si32() -> Result<(), String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result as i32, 1)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtsi512_si32(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtss_f32() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtss_f32(create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtss_f32(create_random__m512());
            }
        }
    }
    Ok(())
}
