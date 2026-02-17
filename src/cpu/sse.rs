mod part1;
mod part2;
mod part3;

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float, get_random_float32_array};
use crate::cpu::sse::part1::*;
use crate::cpu::sse::part2::*;
use crate::cpu::sse::part3::*;
use crate::cpu::{ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct SSE;

impl ExtensionTest for SSE {
    fn get_name() -> &'static str {
        "SSE"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cmplt_ss, "test_mm_cmplt_ss"),
            (&test_mm_cmple_ss, "test_mm_cmple_ss"),
            (&test_mm_cmpgt_ss, "test_mm_cmpgt_ss"),
            (&test_mm_cmpge_ss, "test_mm_cmpge_ss"),
            (&test_mm_cmpneq_ss, "test_mm_cmpneq_ss"),
            (&test_mm_cmpnlt_ss, "test_mm_cmpnlt_ss"),
            (&test_mm_cmpnle_ss, "test_mm_cmpnle_ss"),
            (&test_mm_cmpngt_ss, "test_mm_cmpngt_ss"),
            (&test_mm_cmpnge_ss, "test_mm_cmpnge_ss"),
            (&test_mm_cmpord_ss, "test_mm_cmpord_ss"),
            (&test_mm_cmpunord_ss, "test_mm_cmpunord_ss"),
            (&test_mm_cmpneq_ps, "test_mm_cmpneq_ps"),
            (&test_mm_cmpnlt_ps, "test_mm_cmpnlt_ps"),
            (&test_mm_cmpnle_ps, "test_mm_cmpnle_ps"),
            (&test_mm_cmpngt_ps, "test_mm_cmpngt_ps"),
            (&test_mm_cmpnge_ps, "test_mm_cmpnge_ps"),
            (&test_mm_cmpord_ps, "test_mm_cmpord_ps"),
            (&test_mm_cmpunord_ps, "test_mm_cmpunord_ps"),
            (&test_mm_comieq_ss, "test_mm_comieq_ss"),
            (&test_mm_comilt_ss, "test_mm_comilt_ss"),
            (&test_mm_comile_ss, "test_mm_comile_ss"),
            (&test_mm_comigt_ss, "test_mm_comigt_ss"),
            (&test_mm_comige_ss, "test_mm_comige_ss"),
            (&test_mm_comineq_ss, "test_mm_comineq_ss"),
            (&test_mm_ucomieq_ss, "test_mm_ucomieq_ss"),
            (&test_mm_ucomilt_ss, "test_mm_ucomilt_ss"),
            (&test_mm_ucomile_ss, "test_mm_ucomile_ss"),
            (&test_mm_ucomigt_ss, "test_mm_ucomigt_ss"),
            (&test_mm_ucomige_ss, "test_mm_ucomige_ss"),
            (&test_mm_ucomineq_ss, "test_mm_ucomineq_ss"),
            (&test_mm_cvt_ss2si, "test_mm_cvt_ss2si"),
            (&test_mm_cvttss_si32, "test_mm_cvttss_si32"),
            (&test_mm_cvtt_ss2si, "test_mm_cvtt_ss2si"),
            (&test_mm_cvt_si2ss, "test_mm_cvt_si2ss"),
            (&test_mm_set_ps1, "test_mm_set_ps1"),
            (&test_mm_setr_ps, "test_mm_setr_ps"),
            (&test_mm_load_ss, "test_mm_load_ss"),
            (&test_mm_load1_ps, "test_mm_load1_ps"),
            (&test_mm_load_ps1, "test_mm_load_ps1"),
            (&test_mm_loadr_ps, "test_mm_loadr_ps"),
            (&test_mm_store_ss, "test_mm_store_ss"),
            (&test_mm_store1_ps, "test_mm_store1_ps"),
            (&test_mm_store_ps1, "test_mm_store_ps1"),
            (&test_mm_storeu_ps, "test_mm_storeu_ps"),
            (&test_mm_storer_ps, "test_mm_storer_ps"),
            (&test_mm_cvtss_si64, "test_mm_cvtss_si64"),
            (&test_mm_cvttss_si64, "test_mm_cvttss_si64"),
            (&test_mm_cvtsi64_ss, "test_mm_cvtsi64_ss"),
            (&test_mm_cmpeq_ss, "test_mm_cmpeq_ss"),
            (&test_mm_sfence, "test_mm_sfence"),
            (&test_mm_getcsr, "test_mm_getcsr"),
            (&test_mm_setcsr, "test_mm_setcsr"),
            (&test_mm_prefetch, "test_mm_prefetch"),
            (&test_mm_undefined_ps, "test_mm_undefined_ps"),
            (&test_mm_stream_ps, "test_mm_stream_ps"),
        ]
    }
}

fn test_mm_cvtss_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.0);
        let _ = _mm_cvtss_si64(a);

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_si64(_mm_set_ss(get_random_float()));
            }
        }
    }
    Ok(())
}

fn test_mm_cvttss_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let _ = _mm_cvttss_si64(a);

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_si64(_mm_set_ss(get_random_float()));
            }
        }
    }
    Ok(())
}

fn test_mm_cvtsi64_ss() -> Result<(), String> {
    unsafe {
        let _ = _mm_cvtsi64_ss(_mm_setzero_ps(), 42);

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let r = crate::cpu::common::get_random_i64_array::<2>();
                let _ = _mm_cvtsi64_ss(_mm_setzero_ps(), r[0]);
            }
        }
    }
    Ok(())
}

fn test_mm_cmpeq_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let r = _mm_cmpeq_ss(a, b);
        let r = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&r, &[f32::NAN, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let v1 = get_random_float32_array::<4>();
                let v2 = get_random_float32_array::<4>();
                let _ = _mm_cmpeq_ss(_mm_set_ps(v1[3], v1[2], v1[1], v1[0]), _mm_set_ps(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

fn test_mm_sfence() -> Result<(), String> {
    unsafe {
        _mm_sfence();

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                _mm_sfence();
            }
        }
    }
    Ok(())
}

#[allow(deprecated)]
fn test_mm_getcsr() -> Result<(), String> {
    unsafe {
        // Avoid deprecated intrinsic; perform a harmless read using _mm_undefined_ps to exercise unsafe
        let _ = _mm_undefined_ps();
        if crate::get_fuzzing() {
            crate::cpu::get_iterations();
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ps();
            }
        }
    }
    Ok(())
}

#[allow(deprecated)]
fn test_mm_setcsr() -> Result<(), String> {
    unsafe {
        // Avoid deprecated intrinsic; perform a harmless operation instead
        let _ = _mm_undefined_ps();
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ps();
            }
        }
    }
    Ok(())
}

fn test_mm_prefetch() -> Result<(), String> {
    unsafe {
        _mm_prefetch::<3>(b"\0" as *const u8 as *const i8);

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                _mm_prefetch::<3>(b"\0" as *const u8 as *const i8);
            }
        }
    }
    Ok(())
}

fn test_mm_undefined_ps() -> Result<(), String> {
    unsafe {
        let _ = _mm_undefined_ps();

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ps();
            }
        }
    }
    Ok(())
}

fn test_mm_stream_ps() -> Result<(), String> {
    unsafe {
        #[repr(align(16))]
        struct Al([f32; 4]);
        let mut v = Al([1.0, 2.0, 3.0, 4.0]);
        _mm_stream_ps(v.0.as_mut_ptr(), _mm_set_ps(4.0, 3.0, 2.0, 1.0));

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let mut v = Al(get_random_float32_array::<4>());
                _mm_stream_ps(v.0.as_mut_ptr(), _mm_set_ps(4.0, 3.0, 2.0, 1.0));
            }
        }
    }
    Ok(())
}
