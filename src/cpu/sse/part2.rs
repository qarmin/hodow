use std::arch::x86_64::*;
use crate::get_fuzzing;
use crate::cpu::get_iterations;
use log::info;

// next 15 SSE stubs
pub(super) fn test_mm_cmpnge_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpord_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpunord_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comieq_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comilt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comile_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comigt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comige_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_comineq_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomieq_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomilt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomile_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomigt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomige_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_ucomineq_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
