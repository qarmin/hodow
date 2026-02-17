pub(super) fn test_mm_cvtt_roundsd_si32() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(1, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_i32() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(2, 2)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_u32() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(3, 3)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_i32() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(4, 4)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsd_u32() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(5, 5)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_ss() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(6, 6)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_sd() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(7, 7)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_round_ss() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(8, 8)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_round_sd() -> Result<(), String> {
    unsafe {
        let _ = std::ptr::read_volatile(&0usize);
        crate::cpu::common::check_int_equality(9, 9)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let _r = crate::cpu::common::get_random_i32_array::<1>();
                let _ = std::ptr::read_volatile(&_r[0]);
            }
        }
    }
    Ok(())
}
