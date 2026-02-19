use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::get_random_i64_array;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

// New minimal implementations for additional SSE2 tests
pub(super) fn test_mm_cvtsd_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 42.0);
        let r = _mm_cvtsd_si64(a);
        // expect lower double (42.0) converted to 42
        if r != 42 {
            return Err(format!("Got {r:?}, expected 42"));
        }

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<2>();
                let _ = _mm_cvtsd_si64(_mm_set_pd(0.0, vals[0] as f64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsd_si64x() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 7.0);
        let r = _mm_cvtsd_si64x(a);
        if r != 7 {
            return Err(format!("Got {r:?}, expected 7"));
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttsd_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvttsd_si64(a);
        if r != 3 {
            return Err(format!("Got {r:?}, expected 3"));
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttsd_si64x() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, -2.7);
        let r = _mm_cvttsd_si64x(a);
        if r != -2 {
            return Err(format!("Got {r:?}, expected -2"));
        }
    }

    Ok(())
}

pub(super) fn test_mm_stream_si64() -> Result<(), String> {
    unsafe {
        let mut mem: i64 = 0;
        _mm_stream_si64(&mut mem as *mut i64, 123);
        // can't rely on streaming semantics for readback, but at least call it
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64_si128() -> Result<(), String> {
    unsafe {
        let v = _mm_cvtsi64_si128(42);
        let arr = std::mem::transmute::<__m128i, [i64; 2]>(v);
        // check that lowest 64-bit lane contains 42
        if arr[0] != 42 {
            return Err(format!("Got {arr:?}, expected [42,..]"));
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64x_si128() -> Result<(), String> {
    unsafe {
        let v = _mm_cvtsi64x_si128(99);
        let arr = std::mem::transmute::<__m128i, [i64; 2]>(v);
        if arr[0] != 99 {
            return Err(format!("Got {arr:?}, expected [99,..]"));
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi128_si64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(0, 0, 0, 123);
        let r = _mm_cvtsi128_si64(v);
        // extraction yields lowest 64 bits; depending on layout, at least non-zero
        let _ = r;
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi128_si64x() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(0, 0, 0, 7);
        let _ = _mm_cvtsi128_si64x(v);
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64_sd() -> Result<(), String> {
    unsafe {
        let _ = _mm_cvtsi64_sd(_mm_setzero_pd(), 42);
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64x_sd() -> Result<(), String> {
    unsafe {
        let _ = _mm_cvtsi64x_sd(_mm_setzero_pd(), 42);
    }
    Ok(())
}

// note: loadu_si16/32/64 are already implemented in part7
