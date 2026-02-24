use std::arch::arm::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_qadd8() -> Result<(), String> {
    unsafe {
        let _result = __qadd8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qadd8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_qsub8() -> Result<(), String> {
    unsafe {
        let _result = __qsub8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qsub8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_qsub16() -> Result<(), String> {
    unsafe {
        let _result = __qsub16(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qsub16(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_qadd16() -> Result<(), String> {
    unsafe {
        let _result = __qadd16(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qadd16(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_qasx() -> Result<(), String> {
    unsafe {
        let _result = __qasx(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qasx(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_qsax() -> Result<(), String> {
    unsafe {
        let _result = __qsax(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __qsax(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_sadd16() -> Result<(), String> {
    unsafe {
        let _result = __sadd16(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __sadd16(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_sadd8() -> Result<(), String> {
    unsafe {
        let _result = __sadd8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __sadd8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_smlad() -> Result<(), String> {
    unsafe {
        let result = __smlad(0 /* int16x2_t */, 0 /* int16x2_t */, 1i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smlad(0 /* int16x2_t */, 0 /* int16x2_t */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_smlsd() -> Result<(), String> {
    unsafe {
        let result = __smlsd(0 /* int16x2_t */, 0 /* int16x2_t */, 1i32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smlsd(0 /* int16x2_t */, 0 /* int16x2_t */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_sasx() -> Result<(), String> {
    unsafe {
        let _result = __sasx(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __sasx(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_sel() -> Result<(), String> {
    unsafe {
        let _result = __sel(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __sel(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_shadd8() -> Result<(), String> {
    unsafe {
        let _result = __shadd8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __shadd8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_shadd16() -> Result<(), String> {
    unsafe {
        let _result = __shadd16(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __shadd16(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_shsub8() -> Result<(), String> {
    unsafe {
        let _result = __shsub8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __shsub8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_usub8() -> Result<(), String> {
    unsafe {
        let _result = __usub8(0 /* uint8x4_t */, 0 /* uint8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __usub8(0 /* uint8x4_t */, 0 /* uint8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_ssub8() -> Result<(), String> {
    unsafe {
        let _result = __ssub8(0 /* int8x4_t */, 0 /* int8x4_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __ssub8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_shsub16() -> Result<(), String> {
    unsafe {
        let _result = __shsub16(0 /* int16x2_t */, 0 /* int16x2_t */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __shsub16(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_smuad() -> Result<(), String> {
    unsafe {
        let result = __smuad(0 /* int16x2_t */, 0 /* int16x2_t */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smuad(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_smuadx() -> Result<(), String> {
    unsafe {
        let result = __smuadx(0 /* int16x2_t */, 0 /* int16x2_t */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smuadx(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_smusd() -> Result<(), String> {
    unsafe {
        let result = __smusd(0 /* int16x2_t */, 0 /* int16x2_t */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smusd(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_smusdx() -> Result<(), String> {
    unsafe {
        let result = __smusdx(0 /* int16x2_t */, 0 /* int16x2_t */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __smusdx(0 /* int16x2_t */, 0 /* int16x2_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_usad8() -> Result<(), String> {
    unsafe {
        let result = __usad8(0 /* int8x4_t */, 0 /* int8x4_t */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __usad8(0 /* int8x4_t */, 0 /* int8x4_t */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_usada8() -> Result<(), String> {
    unsafe {
        let result = __usada8(0 /* int8x4_t */, 0 /* int8x4_t */, 1u32);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __usada8(0 /* int8x4_t */, 0 /* int8x4_t */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}
