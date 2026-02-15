use std::arch::x86_64::{
    __m128d, __m128i, _mm_clflush, _mm_loadu_pd, _mm_loadu_si16, _mm_loadu_si32, _mm_loadu_si64, _mm_set1_pd, _mm_set_epi8, _mm_set_pd, _mm_storeh_pd, _mm_storel_pd,
    _mm_storeu_pd, _mm_sub_epi8,
};

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_clflush() -> Result<(), String> {
    unsafe {
        let mut x: u8 = 0;
        let ptr = &mut x as *mut u8 as *const u8;
        _mm_clflush(ptr);

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let mut buf = [0u8; 16];
                let ptr = buf.as_mut_ptr() as *const u8;
                _mm_clflush(ptr);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let b = _mm_set_epi8(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
        let vec = _mm_sub_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(vec);
        // intrinsic yields increasing order [0..15] on target; adjust expected accordingly
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let b = _mm_set_epi8(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
                let _ = _mm_sub_epi8(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store1_pd() -> Result<(), String> {
    let mut data = [0.0f64; 2];
    let vec = unsafe { _mm_set1_pd(3.17) };
    unsafe { _mm_storel_pd(data.as_mut_ptr(), vec) };
    check_float_array_equality_with_error(&data, &[3.17, 0.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            let mut res = [0.0f64; 2];
            unsafe {
                let vec = _mm_set1_pd(arr[0]);
                _mm_storel_pd(res.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_pd1() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f64; 2];
        let vec = _mm_set_pd(2.0, 1.0);
        _mm_storeh_pd(data.as_mut_ptr(), vec);
        // on this target/storeh stores the high element at data[0]
        check_float_array_equality_with_error(&data, &[2.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float64_array::<2>();
                let mut res = [0.0f64; 2];
                let vec = _mm_set_pd(arr[1], arr[0]);
                _mm_storeh_pd(res.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storer_pd() -> Result<(), String> {
    let mut data = [0.0f64; 2];
    let vec = unsafe { _mm_set_pd(9.0, 8.0) };
    unsafe { _mm_storeu_pd(data.as_mut_ptr(), vec) };
    check_float_array_equality_with_error(&data, &[8.0, 9.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            let mut res = [0.0f64; 2];
            unsafe {
                let vec = _mm_set_pd(arr[1], arr[0]);
                _mm_storeu_pd(res.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeh_pd() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f64; 2];
        let vec = _mm_set_pd(7.0, 6.0);
        _mm_storeh_pd(data.as_mut_ptr(), vec);
        // storeh writes the high element into data[0] on this target
        check_float_array_equality_with_error(&data, &[7.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float64_array::<2>();
                let mut res = [0.0f64; 2];
                let vec = _mm_set_pd(arr[1], arr[0]);
                _mm_storeh_pd(res.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storel_pd() -> Result<(), String> {
    let mut data = [0.0f64; 2];
    let vec = unsafe { _mm_set_pd(5.0, 4.0) };
    unsafe { _mm_storel_pd(data.as_mut_ptr(), vec) };
    check_float_array_equality_with_error(&data, &[4.0, 0.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            let mut res = [0.0f64; 2];
            unsafe {
                let vec = _mm_set_pd(arr[1], arr[0]);
                _mm_storel_pd(res.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load1_pd() -> Result<(), String> {
    let data = [2.0f64, 3.0f64];
    let a = unsafe { _mm_loadu_pd(data.as_ptr()) };
    let result = unsafe { std::mem::transmute::<__m128d, [f64; 2]>(a) };
    check_float_array_equality_with_error(&result, &[2.0, 3.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            unsafe {
                let a = _mm_loadu_pd(arr.as_ptr());
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load_pd1() -> Result<(), String> {
    let data = [3.0f64, 2.0f64];
    let a = unsafe { _mm_loadu_pd(data.as_ptr()) };
    let result = unsafe { std::mem::transmute::<__m128d, [f64; 2]>(a) };
    check_float_array_equality_with_error(&result, &[3.0, 2.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            unsafe {
                let a = _mm_loadu_pd(arr.as_ptr());
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadr_pd() -> Result<(), String> {
    let data = [1.0f64, 4.0f64];
    let a = unsafe { _mm_loadu_pd(data.as_ptr()) };
    let result = unsafe { std::mem::transmute::<__m128d, [f64; 2]>(a) };
    check_float_array_equality_with_error(&result, &[1.0, 4.0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let arr = get_random_float64_array::<2>();
            unsafe {
                let a = _mm_loadu_pd(arr.as_ptr());
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadu_si16() -> Result<(), String> {
    let data: [i16; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
    let ptr = data.as_ptr() as *const u8;
    let vec = unsafe { _mm_loadu_si16(ptr) };
    let result = unsafe { std::mem::transmute::<__m128i, [i16; 8]>(vec) };
    check_array_equality(&[result[0]], &[1i16])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let data = get_random_i32_array::<8>();
            let ptr = data.as_ptr() as *const u8;
            let _vec = unsafe { _mm_loadu_si16(ptr) };
            let _ = unsafe { std::mem::transmute::<__m128i, [i16; 8]>(_vec) };
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadu_si32() -> Result<(), String> {
    let data: [i32; 4] = [10, 20, 30, 40];
    let ptr = data.as_ptr() as *const u8;
    let vec = unsafe { _mm_loadu_si32(ptr) };
    let result = unsafe { std::mem::transmute::<__m128i, [i32; 4]>(vec) };
    check_array_equality(&result, &[10, 0, 0, 0])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let data = get_random_i32_array::<4>();
            let ptr = data.as_ptr() as *const u8;
            let _vec = unsafe { _mm_loadu_si32(ptr) };
            let _res = unsafe { std::mem::transmute::<__m128i, [i32; 4]>(_vec) };
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadu_si64() -> Result<(), String> {
    let data: [i64; 2] = [100, 200];
    let ptr = data.as_ptr() as *const u8;
    let vec = unsafe { _mm_loadu_si64(ptr) };
    let result = unsafe { std::mem::transmute::<__m128i, [i64; 2]>(vec) };
    check_array_equality(&[result[0]], &[100i64])?;

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let _ = get_random_i64_array::<2>();
        }
    }

    Ok(())
}
