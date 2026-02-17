#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cmple_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 2, 4);
        let b = _mm_set_epi32(2, 2, 3, 3);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        // masked mask-to-mask intrinsic takes (k, a, b) and returns a mask
        let result = _mm_mask_cmple_epi32_mask(k, a, b);
        check_int_equality(result as i32, 0b0111)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmple_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpge_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k = _mm_cmpge_epi32_mask(a, b);
        check_int_equality(k as i32, 0b1111)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpge_epi32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpge_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmpge_epi32_mask(k, a, b);
        check_int_equality(result as i32, 0b1111)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpge_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmpeq_epi32_mask(a, b);
        check_int_equality(k as i32, 0b0101)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpeq_epi32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpeq_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmpeq_epi32_mask(k, a, b);
        check_int_equality(result as i32, 0b0101)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpeq_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpneq_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmpneq_epi32_mask(a, b);
        check_int_equality(k as i32, 0b1010)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpneq_epi32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmpneq_epi32_mask(k, a, b);
        check_int_equality(result as i32, 0b1010)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpneq_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmp_epi32_mask::<0>(a, b);
        // follow same assumption as other cmp tests in repo
        check_int_equality(k as i32, 0b1010)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmp_epi32_mask::<0>(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmp_epi32_mask::<0>(k, a, b);
        check_int_equality(result as i32, 0b1010)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmp_epi32_mask::<0>(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set_epi64x(2, 2);
        let cmp = _mm_cmplt_epu64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmplt_epu64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set_epi64x(2, 2);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmplt_epu64_mask(k, a, b);
        check_int_equality(result as i32, 0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cmplt_epu64_mask(k, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 4);
        let b = _mm_set_epi64x(2, 2);
        let cmp = _mm_cmpgt_epu64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmpgt_epu64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 4);
        let b = _mm_set_epi64x(2, 2);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmpgt_epu64_mask(k, a, b);
        check_int_equality(result as i32, 0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cmpgt_epu64_mask(k, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmple_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 2);
        let b = _mm_set_epi64x(2, 3);
        let cmp = _mm_cmple_epu64(a, b);
        let r = _mm_movemask_epi8(cmp);
        check_int_equality(r as i32, 0)?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cmple_epu64(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmple_epu64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 2);
        let b = _mm_set_epi64x(2, 3);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result = _mm_mask_cmple_epu64_mask(k, a, b);
        check_int_equality(result as i32, 0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cmple_epu64_mask(k, a_r, a_r);
            }
        }
    }
    Ok(())
}
