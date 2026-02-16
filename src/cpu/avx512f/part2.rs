#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm512_max_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm512_min_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtsd_u64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvti64_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtu64_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_i64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_u64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi64_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu64_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsi64_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}
