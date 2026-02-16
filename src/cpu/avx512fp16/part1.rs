use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvti64_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.0);
        let r = _mm_cvti64_sh(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvti64_sh(_mm_set1_ps(get_random_i64_array::<1>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.5);
        let r = _mm_cvt_roundi64_sh(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundi64_sh(_mm_set1_ps(get_random_i64_array::<1>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(5.0);
        let r = _mm_cvtu64_sh(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtu64_sh(_mm_set1_ps(get_random_i64_array::<1>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(6.0);
        let r = _mm_cvt_roundu64_sh(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundu64_sh(_mm_set1_ps(get_random_i64_array::<1>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(3);
        let r = _mm_cvtsh_i64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_i64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(4);
        let r = _mm_cvt_roundsh_i64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundsh_i64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsh_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(5);
        let r = _mm_cvtsh_u64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_u64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(6);
        let r = _mm_cvt_roundsh_u64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundsh_u64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(7);
        let r = _mm_cvttsh_i64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttsh_i64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(8);
        let r = _mm_cvtt_roundsh_i64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtt_roundsh_i64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(9);
        let r = _mm_cvttsh_u64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttsh_u64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(10);
        let r = _mm_cvtt_roundsh_u64(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtt_roundsh_u64(_mm_set1_epi64x(get_random_i64_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_array_equality(&out, &[1.0f32, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_i64_array::<1>()[0] as f32,
                    get_random_i64_array::<1>()[0] as f32,
                    get_random_i64_array::<1>()[0] as f32,
                    get_random_i64_array::<1>()[0] as f32,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_sh() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(3.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_array_equality(&out, &[3.0f32, 3.0, 3.0, 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_i64_array::<1>()[0] as f32);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set1_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(7.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_array_equality(&out, &[7.0f32, 7.0, 7.0, 7.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_i64_array::<1>()[0] as f32);
            }
        }
    }
    Ok(())
}
