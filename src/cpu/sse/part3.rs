use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_int_equality, get_random_float, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvt_ss2si() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.13);
        let result = _mm_cvt_ss2si(a);
        check_int_equality(result, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float() as i32;
                let vec = _mm_set_ss(value as f32);
                let _ = _mm_cvt_ss2si(vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttss_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.99);
        let result = _mm_cvttss_si32(a);
        check_int_equality(result, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float();
                let vec = _mm_set_ss(value);
                let _ = _mm_cvttss_si32(vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtt_ss2si() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(-2.7);
        let result = _mm_cvttss_si32(a);
        check_int_equality(result, -2)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float();
                let vec = _mm_set_ss(value);
                let _ = _mm_cvttss_si32(vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvt_si2ss() -> Result<(), String> {
    unsafe {
        let a = _mm_cvt_si2ss(_mm_setzero_ps(), 42);
        let result = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality_with_error(&result, &[42.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float() as i32;
                let _ = _mm_cvt_si2ss(_mm_setzero_ps(), v);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_ps1() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ps1(3.13f32);
        let arr = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&arr, &[3.13, 3.13, 3.13, 3.13])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let value = get_random_float();
                let _ = _mm_set_ps1(value);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setr_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_ps(1.0, 2.0, 3.0, 4.0);
        let arr = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&arr, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let _ = _mm_setr_ps(v[0], v[1], v[2], v[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load_ss() -> Result<(), String> {
    unsafe {
        let mem = [42.5f32];
        let a = _mm_load_ss(mem.as_ptr());
        let arr = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality_with_error(&arr, &[42.5, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let m = [get_random_float()];
                let _ = _mm_load_ss(m.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load1_ps() -> Result<(), String> {
    unsafe {
        let mem = [2.0f32];
        let a = _mm_load1_ps(mem.as_ptr());
        let arr = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality_with_error(&arr, &[2.0, 2.0, 2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let m = [get_random_float()];
                let _ = _mm_load1_ps(m.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load_ps1() -> Result<(), String> {
    unsafe {
        let mem = [3.0f32];
        let a = _mm_load_ps1(mem.as_ptr());
        let arr = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality_with_error(&arr, &[3.0, 3.0, 3.0, 3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let m = [get_random_float()];
                let _ = _mm_load_ps1(m.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadr_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0f32, 2.0f32, 3.0f32, 4.0f32];
        let a = _mm_loadr_ps(data.as_ptr());
        let arr = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality_with_error(&arr, &[4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let d = get_random_float32_array::<4>();
                let _ = _mm_loadr_ps(d.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_ss() -> Result<(), String> {
    unsafe {
        let vec = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let mut mem = [0.0f32];
        _mm_store_ss(mem.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&mem, &[4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = _mm_set_ss(get_random_float());
                let mut m = [0.0f32];
                _mm_store_ss(m.as_mut_ptr(), v);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store1_ps() -> Result<(), String> {
    unsafe {
        let vec = _mm_set1_ps(7.0);
        let mut mem = [0.0f32; 4];
        _mm_store1_ps(mem.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&mem, &[7.0, 7.0, 7.0, 7.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = _mm_set1_ps(get_random_float());
                let mut m = [0.0f32; 4];
                _mm_store1_ps(m.as_mut_ptr(), v);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_ps1() -> Result<(), String> {
    unsafe {
        let vec = _mm_set1_ps(5.0);
        let mut mem = [0.0f32; 4];
        _mm_store_ps1(mem.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&mem, &[5.0, 5.0, 5.0, 5.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = _mm_set1_ps(get_random_float());
                let mut m = [0.0f32; 4];
                _mm_store_ps1(m.as_mut_ptr(), v);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0f32, 2.0f32, 3.0f32, 4.0f32];
        let vec = _mm_loadu_ps(data.as_ptr());
        let mut result = [0.0f32; 4];
        _mm_storeu_ps(result.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&result, &data)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v = _mm_loadu_ps(arr.as_ptr());
                let mut r = [0.0f32; 4];
                _mm_storeu_ps(r.as_mut_ptr(), v);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storer_ps() -> Result<(), String> {
    unsafe {
        let vec = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let mut mem = [0.0f32; 4];
        _mm_storer_ps(mem.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&mem, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = _mm_loadu_ps(get_random_float32_array::<4>().as_ptr());
                let mut m = [0.0f32; 4];
                _mm_storer_ps(m.as_mut_ptr(), v);
            }
        }
    }

    Ok(())
}
