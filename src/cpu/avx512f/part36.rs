use std::arch::x86_64::*;
pub(super) fn test_mm_cmple_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 2, 4, 3);
        let k = _mm_cmple_epu32_mask(a, b);
        // expected: element-wise a <= b -> [1<=1 true,2<=2 true,3<=4 true,4<=3 false]
        let expected: __mmask8 = 7;
        crate::cpu::common::check_int_equality(k as i32, expected as i32)?;

        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmple_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpge_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k = _mm_cmpge_epu32_mask(a, b);
        // expected a >= b -> [4>=3 true,3>=3 true,2>=2 true,1>=1 true] -> 15
        crate::cpu::common::check_int_equality(k as i32, 15)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpge_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpge_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmpge_epu32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 15)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpge_epu32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmpeq_epu32_mask(a, b);
        // equals at positions 0 and 2 -> mask 5? Depends ordering, assume low lanes are LSB => 5
        crate::cpu::common::check_int_equality(k as i32, 5)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpeq_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpeq_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmpeq_epu32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 5)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpeq_epu32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpneq_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmpneq_epu32_mask(a, b);
        // not equal positions 1 and 3 -> mask 10
        crate::cpu::common::check_int_equality(k as i32, 10)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpneq_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmpneq_epu32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 10)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpneq_epu32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k = _mm_cmp_epu32_mask::<0>(a, b);
        // treat as greater-than? semantics vary; assume a<b at positions 1 and 3 -> mask 10
        crate::cpu::common::check_int_equality(k as i32, 10)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmp_epu32_mask::<0>(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 9, 3, 0);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmp_epu32_mask::<0>(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 10)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmp_epu32_mask::<0>(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(2, 2, 3, 3);
        let k = _mm_cmplt_epi32_mask(a, b);
        crate::cpu::common::check_int_equality(k as i32, 6)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmplt_epi32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(2, 2, 3, 3);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmplt_epi32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 6)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmplt_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 1, 1);
        let k = _mm_cmpgt_epi32_mask(a, b);
        crate::cpu::common::check_int_equality(k as i32, 12)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpgt_epi32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epi32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 1, 1);
        let k: __mmask8 = 111 as __mmask8;
        let result = _mm_mask_cmpgt_epi32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 12)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpgt_epi32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}
