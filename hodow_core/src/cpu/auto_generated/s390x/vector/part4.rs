use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_s390x_vector_vec_cmpnrg_or_0_idx_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmpnrg_or_0_idx_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpeq() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpeq(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpeq(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpne() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpne(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpne(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpgt() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpgt(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpgt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpge() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpge(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpge(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmplt() -> Result<(), String> {
    unsafe {
        let _result = vec_cmplt(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmplt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmple() -> Result<(), String> {
    unsafe {
        let _result = vec_cmple(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmple(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpeq_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpeq_idx(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpeq_idx(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpne_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpne_idx(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpne_idx(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpeq_idx_cc() -> Result<(), String> {
    unsafe {
        vec_cmpeq_idx_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmpeq_idx_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpne_idx_cc() -> Result<(), String> {
    unsafe {
        vec_cmpne_idx_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmpne_idx_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpeq_or_0_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpeq_or_0_idx(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpeq_or_0_idx(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpne_or_0_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpne_or_0_idx(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpne_or_0_idx(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpeq_or_0_idx_cc() -> Result<(), String> {
    unsafe {
        vec_cmpeq_or_0_idx_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmpeq_or_0_idx_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpne_or_0_idx_cc() -> Result<(), String> {
    unsafe {
        vec_cmpne_or_0_idx_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmpne_or_0_idx_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_eq() -> Result<(), String> {
    unsafe {
        let result = vec_all_eq(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_eq(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_ne() -> Result<(), String> {
    unsafe {
        let result = vec_all_ne(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_ne(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_eq() -> Result<(), String> {
    unsafe {
        let result = vec_any_eq(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_eq(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_ne() -> Result<(), String> {
    unsafe {
        let result = vec_any_ne(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_ne(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_lt() -> Result<(), String> {
    unsafe {
        let result = vec_all_lt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_lt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_le() -> Result<(), String> {
    unsafe {
        let result = vec_all_le(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_le(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_gt() -> Result<(), String> {
    unsafe {
        let result = vec_all_gt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_gt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_ge() -> Result<(), String> {
    unsafe {
        let result = vec_all_ge(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_ge(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_nlt() -> Result<(), String> {
    unsafe {
        let result = vec_all_nlt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nlt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_nle() -> Result<(), String> {
    unsafe {
        let result = vec_all_nle(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nle(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_ngt() -> Result<(), String> {
    unsafe {
        let result = vec_all_ngt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_ngt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_nge() -> Result<(), String> {
    unsafe {
        let result = vec_all_nge(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nge(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_lt() -> Result<(), String> {
    unsafe {
        let result = vec_any_lt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_lt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_le() -> Result<(), String> {
    unsafe {
        let result = vec_any_le(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_le(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_gt() -> Result<(), String> {
    unsafe {
        let result = vec_any_gt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_gt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_ge() -> Result<(), String> {
    unsafe {
        let result = vec_any_ge(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_ge(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_nlt() -> Result<(), String> {
    unsafe {
        let result = vec_any_nlt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nlt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_nle() -> Result<(), String> {
    unsafe {
        let result = vec_any_nle(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nle(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_ngt() -> Result<(), String> {
    unsafe {
        let result = vec_any_ngt(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_ngt(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_nge() -> Result<(), String> {
    unsafe {
        let result = vec_any_nge(0 /* T */, 0 /* T */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nge(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_extract() -> Result<(), String> {
    unsafe {
        let _result = vec_extract(0 /* T */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_extract(0 /* T */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_insert() -> Result<(), String> {
    unsafe {
        let _result = vec_insert(0 /* ElementType */, 0 /* T */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_insert(0 /* ElementType */, 0 /* T */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_insert_and_zero() -> Result<(), String> {
    unsafe {
        let _result = vec_insert_and_zero(0 /* ElementType */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_insert_and_zero(0 /* ElementType */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_promote() -> Result<(), String> {
    unsafe {
        let _result = vec_promote(0 /* ElementType */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_promote(0 /* ElementType */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}
