use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512VNNI;

impl ExtensionTest for AVX512VNNI {
    fn get_name() -> &'static str {
        "AVX512VNNI"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_dpwssd_avx_epi32, "test_mm_dpwssd_avx_epi32"),
            (&test_mm_dpwssd_epi32, "test_mm_dpwssd_epi32"),
            (&test_mm_mask_dpwssd_epi32, "test_mm_mask_dpwssd_epi32"),
            (&test_mm_maskz_dpwssd_epi32, "test_mm_maskz_dpwssd_epi32"),
            (&test_mm_dpwssds_avx_epi32, "test_mm_dpwssds_avx_epi32"),
            (&test_mm_dpwssds_epi32, "test_mm_dpwssds_epi32"),
            (&test_mm_mask_dpwssds_epi32, "test_mm_mask_dpwssds_epi32"),
            (&test_mm_maskz_dpwssds_epi32, "test_mm_maskz_dpwssds_epi32"),
            (&test_mm_dpbusd_avx_epi32, "test_mm_dpbusd_avx_epi32"),
            (&test_mm_dpbusd_epi32, "test_mm_dpbusd_epi32"),
            (&test_mm_mask_dpbusd_epi32, "test_mm_mask_dpbusd_epi32"),
            (&test_mm_maskz_dpbusd_epi32, "test_mm_maskz_dpbusd_epi32"),
            (&test_mm_dpbusds_avx_epi32, "test_mm_dpbusds_avx_epi32"),
            (&test_mm_dpbusds_epi32, "test_mm_dpbusds_epi32"),
            (&test_mm_mask_dpbusds_epi32, "test_mm_mask_dpbusds_epi32"),
            (&test_mm_maskz_dpbusds_epi32, "test_mm_maskz_dpbusds_epi32"),
            (&test_mm_dpbssd_epi32, "test_mm_dpbssd_epi32"),
            (&test_mm_dpbssds_epi32, "test_mm_dpbssds_epi32"),
            (&test_mm_dpbsud_epi32, "test_mm_dpbsud_epi32"),
            (&test_mm_dpbsuds_epi32, "test_mm_dpbsuds_epi32"),
            (&test_mm_dpbuud_epi32, "test_mm_dpbuud_epi32"),
            (&test_mm_dpbuuds_epi32, "test_mm_dpbuuds_epi32"),
            (&test_mm_dpwsud_epi32, "test_mm_dpwsud_epi32"),
            (&test_mm_dpwsuds_epi32, "test_mm_dpwsuds_epi32"),
            (&test_mm_dpwusd_epi32, "test_mm_dpwusd_epi32"),
            (&test_mm_dpwusds_epi32, "test_mm_dpwusds_epi32"),
            (&test_mm_dpwuud_epi32, "test_mm_dpwuud_epi32"),
            (&test_mm_dpwuuds_epi32, "test_mm_dpwuuds_epi32"),
        ]
    }
}

fn test_mm_dpwssd_avx_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwssd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(8, 7, 6, 5);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[8, 7, 6, 5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_dpwssd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(1, 1, 1, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[1, 1, 1, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_dpwssd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(-1, -2, -3, -4);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[-1, -2, -3, -4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwssds_avx_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(10, 20, 30, 40);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[10, 20, 30, 40])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwssds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(2, 4, 6, 8);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[2, 4, 6, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_dpwssds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(3, 3, 3, 3);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[3, 3, 3, 3])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_dpwssds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(5, 5, 5, 5);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[5, 5, 5, 5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbusd_avx_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(11, 12, 13, 14);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[11, 12, 13, 14])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbusd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(21, 22, 23, 24);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[21, 22, 23, 24])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_dpbusd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(31, 32, 33, 34);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[31, 32, 33, 34])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_dpbusd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(41, 42, 43, 44);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[41, 42, 43, 44])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbusds_avx_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(51, 52, 53, 54);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[51, 52, 53, 54])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbusds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(61, 62, 63, 64);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[61, 62, 63, 64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_dpbusds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(71, 72, 73, 74);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[71, 72, 73, 74])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_dpbusds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(81, 82, 83, 84);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[81, 82, 83, 84])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbssd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(91, 92, 93, 94);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[91, 92, 93, 94])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbssds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(101, 102, 103, 104);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[101, 102, 103, 104])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbsud_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(111, 112, 113, 114);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[111, 112, 113, 114])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbsuds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(121, 122, 123, 124);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[121, 122, 123, 124])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbuud_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(131, 132, 133, 134);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[131, 132, 133, 134])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpbuuds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(141, 142, 143, 144);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[141, 142, 143, 144])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwsud_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(151, 152, 153, 154);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[151, 152, 153, 154])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwsuds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(161, 162, 163, 164);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[161, 162, 163, 164])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwusd_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(171, 172, 173, 174);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[171, 172, 173, 174])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwusds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(181, 182, 183, 184);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[181, 182, 183, 184])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwuud_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(191, 192, 193, 194);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[191, 192, 193, 194])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_dpwuuds_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(201, 202, 203, 204);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[201, 202, 203, 204])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
