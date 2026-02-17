#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_div_round_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_ss(8.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_maskz_div_round_ss(k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_maskz_div_round_ss(k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_div_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(8.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_div_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_div_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_round_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(8.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_div_round_sd(src, k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_pd();
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_mask_div_round_sd(src, k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_round_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_sd(8.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_maskz_div_round_sd(k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_maskz_div_round_sd(k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_max_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_max_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_round_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_max_round_ss(src, k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_ps();
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_mask_max_round_ss(src, k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_round_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_maskz_max_round_ss(k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_maskz_max_round_ss(k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_max_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_max_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_round_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_max_round_sd(src, k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_pd();
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_mask_max_round_sd(src, k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_round_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_maskz_max_round_sd(k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_maskz_max_round_sd(k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_min_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_min_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_round_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_min_round_ss(src, k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_ps();
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_mask_min_round_ss(src, k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_round_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_maskz_min_round_ss(k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_maskz_min_round_ss(k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_min_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_min_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_round_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_min_round_sd(src, k, a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_pd();
                let k: __mmask8 = 0xFFu8 as __mmask8;
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_mask_min_round_sd(src, k, a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}
