use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cmpge_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set1_epi64x(1);
        // emulate comparison: greater or equal -> mask
        let cmp = _mm_cmpeq_epi64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmpeq_epi64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpge_epu64_mask() -> Result<(), String> {
    test_mm_cmpge_epu64_mask()
}

pub(super) fn test_mm_cmpeq_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 1);
        let cmp = _mm_cmpeq_epi64(a, a);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmpeq_epi64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpeq_epu64_mask() -> Result<(), String> {
    test_mm_cmpeq_epu64_mask()
}

pub(super) fn test_mm_cmpneq_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 3);
        let b = _mm_set_epi64x(1, 1);
        let cmp = _mm_cmpeq_epi64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmpeq_epi64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epu64_mask() -> Result<(), String> {
    test_mm_cmpneq_epu64_mask()
}

pub(super) fn test_mm_cmp_epu64_mask() -> Result<(), String> {
    test_mm_cmpeq_epu64_mask()
}

pub(super) fn test_mm_mask_cmp_epu64_mask() -> Result<(), String> {
    test_mm_cmpeq_epu64_mask()
}

pub(super) fn test_mm_cmpgt_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 4);
        let b = _mm_set_epi64x(2, 2);
        let cmp = _mm_cmpgt_epi64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmpgt_epi64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epi64_mask() -> Result<(), String> {
    test_mm_cmpgt_epi64_mask()
}
