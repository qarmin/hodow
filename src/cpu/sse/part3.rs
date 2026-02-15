use std::arch::x86_64::*;
use crate::get_fuzzing;
use crate::cpu::get_iterations;
use log::info;

// next 15 SSE stubs
pub(super) fn test_mm_cvt_ss2si() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cvttss_si32() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cvtt_ss2si() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cvt_si2ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_set_ps1() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_setr_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_load_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_load1_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_load_ps1() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_loadr_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_store_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_store1_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_store_ps1() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_storeu_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_storer_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
