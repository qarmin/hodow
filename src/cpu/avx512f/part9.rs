
use log::info;

fn test_mm_mask3_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask3_fmadd_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fmadd_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_mask_fmadd_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmadd_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_maskz_fmadd_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmadd_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask3_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_mask3_fmadd_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fmadd_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask_fmsub_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmsub_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_maskz_fmsub_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmsub_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask3_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask3_fmsub_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fmsub_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_mask_fmsub_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmsub_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_maskz_fmsub_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmsub_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask3_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_mask3_fmsub_pd(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fmsub_pd(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_mask_fmaddsub_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmaddsub_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}

fn test_mm_maskz_fmaddsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_maskz_fmaddsub_ps(a, a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmaddsub_ps(a, a, a, a);
            }
        }
    }
    Ok(())
}
