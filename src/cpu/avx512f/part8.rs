fn test_mm_mask_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask_min_ps(a, a, a);
        if crate::get_fuzzing() {
            crate::cpu::get_iterations();
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_ps(_mm_set1_ps(1.0), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_maskz_min_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_ps(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_mask_min_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_pd(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_maskz_min_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_pd(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_min_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let _ = _mm_mask_min_epu32(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_epu32(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_min_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let _ = _mm_maskz_min_epu32(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_epu32(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_min_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let _ = _mm_min_epu64(a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_epu64(a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_min_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let _ = _mm_mask_min_epu64(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_epu64(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_min_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let _ = _mm_maskz_min_epu64(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_epu64(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_sqrt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let _ = _mm_mask_sqrt_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_sqrt_ps(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_sqrt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let _ = _mm_maskz_sqrt_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_sqrt_ps(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(4.0);
        let _ = _mm_mask_sqrt_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_sqrt_pd(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(4.0);
        let _ = _mm_maskz_sqrt_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_sqrt_pd(a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask_fmadd_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmadd_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_maskz_fmadd_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmadd_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}
