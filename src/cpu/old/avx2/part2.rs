use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};

test_simd!(
    test_mm256_hsub_epi32,
    {
        let result = unpack__m256i_to_i32_array(_mm256_hsub_epi32(
            create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
            create__m256i_from_i32_array([16, 15, 14, 13, 12, 11, 10, 9]),
        ));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    },
    _mm256_hsub_epi32(create_random__m256i(), create_random__m256i())
);

test_simd!(
    test_mm256_broadcastd_epi32,
    {
        let result = unpack__m256i_to_i32_array(_mm256_broadcastd_epi32(create__m128i_from_i32_array([42, 0, 0, 0])));
        check_array_equality(&result, &[42, 42, 42, 42, 42, 42, 42, 42])?;
    },
    _mm256_broadcastd_epi32(create_random__m128i())
);

test_simd!(
    test_mm256_permutevar8x32_epi32,
    {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(
            create__m256i_from_i32_array([0, 1, 2, 3, 4, 5, 6, 7]),
            create__m256i_from_i32_array([7, 6, 5, 4, 3, 2, 1, 0]),
        ));
        check_array_equality(&result, &[7, 6, 5, 4, 3, 2, 1, 0])?;
    },
    _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i())
);

test_simd!(
    test_mm_blend_epi32,
    {
        let result = unpack__m128i_to_i32_array(_mm_blend_epi32::<10>(
            create__m128i_from_i32_array([1, 2, 3, 4]),
            create__m128i_from_i32_array([5, 6, 7, 8]),
        ));
        check_array_equality(&result, &[5, 2, 7, 4])?;
    },
    _mm_blend_epi32::<10>(create_random__m128i(), create_random__m128i())
);

test_simd!(
    test_mm_broadcastb_epi8,
    {
        let result = unpack__m128i_to_i8_array(_mm_broadcastb_epi8(create__m128i_from_i32_array([42, 0, 0, 0])));
        check_array_equality(&result, &[42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])?;
    },
    _mm_broadcastb_epi8(create_random__m128i())
);

test_simd!(
    test_mm_broadcastq_epi64,
    {
        let result = unpack__m128i_to_i64_array(_mm_broadcastq_epi64(create__m128i_from_i64_array([42, 0])));
        check_array_equality(&result, &[42, 42])?;
    },
    _mm_broadcastq_epi64(create_random__m128i())
);

test_simd!(
    test_mm_broadcastsd_pd,
    {
        let result: [f64; 2] = std::mem::transmute(_mm_broadcastsd_pd(create__m128d_from_f64_array([42.5, 0.0])));
        check_float_array_equality(&result, &[42.5, 42.5])?;
    },
    _mm_broadcastsd_pd(create_random__m128d())
);

test_simd!(
    test_mm_broadcastsi128_si256,
    {
        let result = unpack__m256i_to_i32_array(_mm_broadcastsi128_si256(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4])?;
    },
    _mm_broadcastsi128_si256(create_random__m128i())
);

test_simd!(
    test_mm_broadcastss_ps,
    {
        let result: [f32; 4] = std::mem::transmute(_mm_broadcastss_ps(create__m128_from_f32_array([42.5, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[42.5, 42.5, 42.5, 42.5])?;
    },
    _mm_broadcastss_ps(create_random__m128())
);

test_simd!(
    test_mm_broadcastw_epi16,
    {
        let result = unpack__m128i_to_i16_array(_mm_broadcastw_epi16(create__m128i_from_i32_array([42, 0, 0, 0])));
        check_array_equality(&result, &[42, 0, 0, 0, 0, 0, 0, 0])?;
    },
    _mm_broadcastw_epi16(create_random__m128i())
);

test_simd!(
    test_mm_i32gather_epi32,
    {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi32::<4>(arr.as_ptr(), create__m128i_from_i32_array([3, 2, 1, 0])));
        check_array_equality(&result, &[40, 30, 20, 10])?;
    },
    {
        // let base = get_random_i32_array::<4>();
        // _mm_i32gather_epi32::<4>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i32gather_epi32,
    {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi32::<4>(
            create__m128i_from_i32_array([99, 99, 99, 99]),
            arr.as_ptr(),
            create__m128i_from_i32_array([0, 1, 2, 3]),
            create__m128i_from_i32_array([0, -1, 0, -1]),
        ));
        check_array_equality(&result, &[99, 30, 99, 10])?;
    },
    {
        let base = get_random_i32_array::<4>();
        _mm_mask_i32gather_epi32::<4>(create_random__m128i(), base.as_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_i32gather_ps,
    {
        let arr: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f32; 4] = std::mem::transmute(_mm_i32gather_ps::<4>(arr.as_ptr(), create__m128i_from_i32_array([0, 1, 2, 3])));
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    },
    {
        let base = get_random_float32_array::<4>();
        _mm_i32gather_ps::<4>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i32gather_ps,
    {
        let arr: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f32; 4] = std::mem::transmute(_mm_mask_i32gather_ps::<4>(
            create__m128_from_f32_array([99.0, 99.0, 99.0, 99.0]),
            arr.as_ptr(),
            create__m128i_from_i32_array([0, 1, 2, 3]),
            create__m128_from_f32_array([0.0, -1.0, 0.0, -1.0]),
        ));
        check_float_array_equality(&result, &[99.0, 3.0, 99.0, 1.0])?;
    },
    {
        let base = get_random_float32_array::<4>();
        _mm_mask_i32gather_ps::<4>(create_random__m128(), base.as_ptr(), create_random__m128i(), create_random__m128())
    }
);

test_simd!(
    test_mm_i32gather_epi64,
    {
        let arr: [i64; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i64_array(_mm_i32gather_epi64::<8>(arr.as_ptr(), create__m128i_from_i32_array([3, 1, 0, 0])));
        check_array_equality(&result, &[40, 20])?;
    },
    {
        let base = get_random_i64_array::<4>();
        _mm_i32gather_epi64::<8>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i32gather_epi64,
    {
        let arr: [i64; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i64_array(_mm_mask_i32gather_epi64::<8>(
            create__m128i_from_i64_array([99, 99]),
            arr.as_ptr(),
            create__m128i_from_i32_array([3, 1, 0, 0]),
            create__m128i_from_i64_array([0, -1]),
        ));
        check_array_equality(&result, &[99, 20])?;
    },
    {
        let base = get_random_i64_array::<4>();
        _mm_mask_i32gather_epi64::<8>(create_random__m128i(), base.as_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_i32gather_pd,
    {
        let arr: [f64; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f64; 2] = std::mem::transmute(_mm_i32gather_pd::<8>(arr.as_ptr(), create__m128i_from_i32_array([3, 1, 0, 0])));
        check_float_array_equality(&result, &[4.0, 2.0])?;
    },
    {
        let base = get_random_float64_array::<4>();
        _mm_i32gather_pd::<8>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i32gather_pd,
    {
        let arr: [f64; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f64; 2] = std::mem::transmute(_mm_mask_i32gather_pd::<8>(
            create__m128d_from_f64_array([99.0, 99.0]),
            arr.as_ptr(),
            create__m128i_from_i32_array([3, 1, 0, 0]),
            create__m128d_from_f64_array([0.0, -1.0]),
        ));
        check_float_array_equality(&result, &[99.0, 2.0])?;
    },
    {
        let base = get_random_float64_array::<4>();
        _mm_mask_i32gather_pd::<8>(create_random__m128d(), base.as_ptr(), create_random__m128i(), create_random__m128d())
    }
);

test_simd!(
    test_mm_i64gather_epi32,
    {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi32::<4>(arr.as_ptr(), create__m128i_from_i64_array([2, 0])));
        check_array_equality(&result, &[30, 10, 0, 0])?;
    },
    {
        let base = get_random_i32_array::<4>();
        _mm_i64gather_epi32::<4>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i64gather_epi32,
    {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi32::<4>(
            create__m128i_from_i32_array([99, 99, 0, 0]),
            arr.as_ptr(),
            create__m128i_from_i64_array([2, 0]),
            create__m128i_from_i32_array([0, -1, 0, 0]),
        ));
        check_array_equality(&result, &[99, 10, 0, 0])?;
    },
    {
        let base = get_random_i32_array::<4>();
        _mm_mask_i64gather_epi32::<4>(create_random__m128i(), base.as_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_i64gather_ps,
    {
        let arr: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f32; 4] = std::mem::transmute(_mm_i64gather_ps::<4>(arr.as_ptr(), create__m128i_from_i64_array([2, 0])));
        check_float_array_equality(&result, &[3.0, 1.0, 0.0, 0.0])?;
    },
    {
        let base = get_random_float32_array::<4>();
        _mm_i64gather_ps::<4>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i64gather_ps,
    {
        let arr: [f32; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f32; 4] = std::mem::transmute(_mm_mask_i64gather_ps::<4>(
            create__m128_from_f32_array([99.0, 99.0, 0.0, 0.0]),
            arr.as_ptr(),
            create__m128i_from_i64_array([2, 0]),
            create__m128_from_f32_array([0.0, -1.0, 0.0, 0.0]),
        ));
        check_float_array_equality(&result, &[99.0, 1.0, 0.0, 0.0])?;
    },
    {
        let base = get_random_float32_array::<4>();
        _mm_mask_i64gather_ps::<4>(create_random__m128(), base.as_ptr(), create_random__m128i(), create_random__m128())
    }
);

test_simd!(
    test_mm_i64gather_epi64,
    {
        let arr: [i64; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i64_array(_mm_i64gather_epi64::<8>(arr.as_ptr(), create__m128i_from_i64_array([3, 0])));
        check_array_equality(&result, &[40, 10])?;
    },
    {
        let base = get_random_i64_array::<4>();
        _mm_i64gather_epi64::<8>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i64gather_epi64,
    {
        let arr: [i64; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i64_array(_mm_mask_i64gather_epi64::<8>(
            create__m128i_from_i64_array([99, 99]),
            arr.as_ptr(),
            create__m128i_from_i64_array([3, 0]),
            create__m128i_from_i64_array([0, -1]),
        ));
        check_array_equality(&result, &[99, 10])?;
    },
    {
        let base = get_random_i64_array::<4>();
        _mm_mask_i64gather_epi64::<8>(create_random__m128i(), base.as_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_i64gather_pd,
    {
        let arr: [f64; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f64; 2] = std::mem::transmute(_mm_i64gather_pd::<8>(arr.as_ptr(), create__m128i_from_i64_array([3, 0])));
        check_float_array_equality(&result, &[4.0, 1.0])?;
    },
    {
        let base = get_random_float64_array::<4>();
        _mm_i64gather_pd::<8>(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_mask_i64gather_pd,
    {
        let arr: [f64; 4] = [1.0, 2.0, 3.0, 4.0];
        let result: [f64; 2] = std::mem::transmute(_mm_mask_i64gather_pd::<8>(
            create__m128d_from_f64_array([99.0, 99.0]),
            arr.as_ptr(),
            create__m128i_from_i64_array([3, 0]),
            create__m128d_from_f64_array([0.0, -1.0]),
        ));
        check_float_array_equality(&result, &[99.0, 1.0])?;
    },
    {
        let base = get_random_float64_array::<4>();
        _mm_mask_i64gather_pd::<8>(create_random__m128d(), base.as_ptr(), create_random__m128i(), create_random__m128d())
    }
);

test_simd!(
    test_mm_maskload_epi32,
    {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let result = unpack__m128i_to_i32_array(_mm_maskload_epi32(arr.as_ptr(), create__m128i_from_i32_array([0, -1, 0, -1])));
        check_array_equality(&result, &[0, 20, 0, 40])?;
    },
    {
        let base = get_random_i32_array::<4>();
        _mm_maskload_epi32(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_maskload_epi64,
    {
        let arr: [i64; 2] = [10, 20];
        let result = unpack__m128i_to_i64_array(_mm_maskload_epi64(arr.as_ptr(), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 20])?;
    },
    {
        let base = get_random_i64_array::<2>();
        _mm_maskload_epi64(base.as_ptr(), create_random__m128i())
    }
);

test_simd!(
    test_mm_maskstore_epi32,
    {
        let mut arr: [i32; 4] = [0; 4];
        _mm_maskstore_epi32(
            arr.as_mut_ptr(),
            create__m128i_from_i32_array([0, -1, 0, -1]),
            create__m128i_from_i32_array([10, 20, 30, 40]),
        );
        check_array_equality(&arr, &[0, 20, 0, 40])?;
    },
    {
        let mut arr: [i32; 4] = [0; 4];
        _mm_maskstore_epi32(arr.as_mut_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_maskstore_epi64,
    {
        let mut arr: [i64; 2] = [0; 2];
        _mm_maskstore_epi64(arr.as_mut_ptr(), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 20]));
        check_array_equality(&arr, &[0, 20])?;
    },
    {
        let mut arr: [i64; 2] = [0; 2];
        _mm_maskstore_epi64(arr.as_mut_ptr(), create_random__m128i(), create_random__m128i())
    }
);

test_simd!(
    test_mm_sllv_epi32,
    {
        let result = unpack__m128i_to_i32_array(_mm_sllv_epi32(create__m128i_from_i32_array([1, 1, 1, 1]), create__m128i_from_i32_array([0, 1, 2, 3])));
        check_array_equality(&result, &[1, 2, 4, 8])?;
    },
    _mm_sllv_epi32(create_random__m128i(), create_random__m128i())
);

test_simd!(
    test_mm_sllv_epi64,
    {
        let result = unpack__m128i_to_i64_array(_mm_sllv_epi64(create__m128i_from_i64_array([1, 1]), create__m128i_from_i64_array([0, 2])));
        check_array_equality(&result, &[1, 4])?;
    },
    _mm_sllv_epi64(create_random__m128i(), create_random__m128i())
);

test_simd!(
    test_mm_srav_epi32,
    {
        let result = unpack__m128i_to_i32_array(_mm_srav_epi32(create__m128i_from_i32_array([-1, -2, -4, -8]), create__m128i_from_i32_array([0, 1, 2, 3])));
        check_array_equality(&result, &[-1, -1, -1, -1])?;
    },
    _mm_srav_epi32(create_random__m128i(), create_random__m128i())
);

test_simd!(
    test_mm_srlv_epi32,
    {
        let result = unpack__m128i_to_i32_array(_mm_srlv_epi32(create__m128i_from_i32_array([8, 8, 8, 8]), create__m128i_from_i32_array([0, 1, 2, 3])));
        check_array_equality(&result, &[8, 4, 2, 1])?;
    },
    _mm_srlv_epi32(create_random__m128i(), create_random__m128i())
);

test_simd!(
    test_mm_srlv_epi64,
    {
        let result = unpack__m128i_to_i64_array(_mm_srlv_epi64(create__m128i_from_i64_array([8, 8]), create__m128i_from_i64_array([0, 2])));
        check_array_equality(&result, &[8, 2])?;
    },
    _mm_srlv_epi64(create_random__m128i(), create_random__m128i())
);
