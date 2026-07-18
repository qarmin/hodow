use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_any_gt() -> Result<(), String> {
    unsafe {
        vec_any_gt(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_any_gt(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_in() -> Result<(), String> {
    unsafe {
        let _result = vec_all_in(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_in(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_le() -> Result<(), String> {
    unsafe {
        vec_all_le(0 /* U */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_all_le(0 /* U */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_le() -> Result<(), String> {
    unsafe {
        vec_any_le(0 /* U */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_any_le(0 /* U */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_lt() -> Result<(), String> {
    unsafe {
        vec_all_lt(0 /* U */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_all_lt(0 /* U */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_lt() -> Result<(), String> {
    unsafe {
        vec_any_lt(0 /* U */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_any_lt(0 /* U */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_nan() -> Result<(), String> {
    unsafe {
        let _result = vec_all_nan(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nan(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_nan() -> Result<(), String> {
    unsafe {
        let _result = vec_any_nan(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nan(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_ne() -> Result<(), String> {
    unsafe {
        vec_all_ne(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_all_ne(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_ne() -> Result<(), String> {
    unsafe {
        vec_any_ne(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_any_ne(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_nge() -> Result<(), String> {
    unsafe {
        let _result = vec_all_nge(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nge(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_ngt() -> Result<(), String> {
    unsafe {
        let _result = vec_all_ngt(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_ngt(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_nle() -> Result<(), String> {
    unsafe {
        let _result = vec_all_nle(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nle(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_nlt() -> Result<(), String> {
    unsafe {
        let _result = vec_all_nlt(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nlt(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_numeric() -> Result<(), String> {
    unsafe {
        let _result = vec_all_numeric(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_numeric(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_nge() -> Result<(), String> {
    unsafe {
        let _result = vec_any_nge(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nge(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_ngt() -> Result<(), String> {
    unsafe {
        let _result = vec_any_ngt(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_ngt(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_nle() -> Result<(), String> {
    unsafe {
        let _result = vec_any_nle(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nle(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_nlt() -> Result<(), String> {
    unsafe {
        let _result = vec_any_nlt(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nlt(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_numeric() -> Result<(), String> {
    unsafe {
        let _result = vec_any_numeric(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_numeric(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cntlz() -> Result<(), String> {
    unsafe {
        vec_cntlz(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cntlz(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_out() -> Result<(), String> {
    unsafe {
        let _result = vec_any_out(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_out(0 /* vector_float */);
            }
        }
    }
    Ok(())
}
