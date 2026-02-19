use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvttss_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_ss2si() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_f32() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtss_f32(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_f32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi32_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi32_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi32_ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_si2ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_si2ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_si2ss(create_random__m128(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_set_ss(1.0f32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_ss(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set1_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_set1_ps(1.0f32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set1_ps(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_ps1() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_set_ps1(1.0f32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_ps1(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_set_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_set_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_set_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setr_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_setr_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setr_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_setzero_ps());
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setzero_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_shuffle_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_shuffle_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_shuffle_ps::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_unpackhi_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_unpackhi_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_unpacklo_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_unpacklo_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movehl_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_movehl_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_movehl_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movelh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_movelh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_movelh_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movemask_ps() -> Result<(), String> {
    unsafe {
        let result = _mm_movemask_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_movemask_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_load_ss() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_load_ss(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_load1_ps() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_load1_ps(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_ps1() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_load_ps1(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_ps() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_load_ps(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_ps() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_loadu_ps(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadr_ps() -> Result<(), String> {
    unsafe {
        let ptr_p = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_loadr_ps(ptr_p.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_store_ss() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_store_ss(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store1_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_store1_ps(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_ps1() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_store_ps1(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_store_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_store_ps(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_storeu_ps(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storer_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_storer_ps(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_move_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_move_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_move_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}
