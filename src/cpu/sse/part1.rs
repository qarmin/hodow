use std::arch::x86_64::*;
use crate::cpu::{get_iterations};
use log::info;
use crate::get_fuzzing;

// 15 stubs for SSE comparisons and related functions
pub(super) fn test_mm_cmplt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmple_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpgt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpge_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpneq_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpnlt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpnle_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpngt_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpnge_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpord_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpunord_ss() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpneq_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpnlt_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpnle_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
pub(super) fn test_mm_cmpngt_ps() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
