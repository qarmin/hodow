use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality};
use crate::cpu::{get_fuzzing, get_iterations, ExtensionTest, TestFunction};
pub struct KL;
impl ExtensionTest for KL {
    fn get_name() -> &'static str {
        "Key Locker"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_loadiwkey, "test_mm_loadiwkey"),
            (&test_mm_encodekey128_u32, "test_mm_encodekey128_u32"),
            (&test_mm_encodekey256_u32, "test_mm_encodekey256_u32"),
            (&test_mm_aesenc128kl_u8, "test_mm_aesenc128kl_u8"),
            (&test_mm_aesdec128kl_u8, "test_mm_aesdec128kl_u8"),
            (&test_mm_aesenc256kl_u8, "test_mm_aesenc256kl_u8"),
            (&test_mm_aesdec256kl_u8, "test_mm_aesdec256kl_u8"),
            (&test_mm_aesencwide128kl_u8, "test_mm_aesencwide128kl_u8"),
            (&test_mm_aesdecwide128kl_u8, "test_mm_aesdecwide128kl_u8"),
            (&test_mm_aesencwide256kl_u8, "test_mm_aesencwide256kl_u8"),
            (&test_mm_aesdecwide256kl_u8, "test_mm_aesdecwide256kl_u8"),
        ]
    }
}

fn test_mm_loadiwkey() -> Result<(), String> {
    unsafe {
        let ctl = 0u32;
        let intkey = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let enkey_lo = _mm_set_epi64x(1234605616436508552i64, 11072869122414935808u64 as i64);
        let enkey_hi = _mm_set_epi64x(4822678189205111i64, 9843086184167632639u64 as i64);
        _mm_loadiwkey(ctl, intkey, enkey_lo, enkey_hi);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ctl: u32 = rand::random();
                let intkey = _mm_set_epi64x(rand::random(), rand::random());
                let enkey_lo = _mm_set_epi64x(rand::random(), rand::random());
                let enkey_hi = _mm_set_epi64x(rand::random(), rand::random());
                _mm_loadiwkey(ctl, intkey, enkey_lo, enkey_hi);
            }
        }
    }

    Ok(())
}

fn test_mm_encodekey128_u32() -> Result<(), String> {
    unsafe {
        let htype = 1u32;
        let key = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let mut h_enc_key: [u8; 384] = [0; 384];
        let result = _mm_encodekey128_u32(htype, key, h_enc_key.as_mut_ptr() as *mut u8);
        check_int_equality(result as i32, 0)?; // expected success code 0
        check_array_equality(&h_enc_key[0..16], &[0u8; 16])?; // invented expected prefix
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let htype: u32 = rand::random();
                let key = _mm_set_epi64x(rand::random(), rand::random());
                let mut h_enc_key: [u8; 384] = [0; 384];
                let _ = _mm_encodekey128_u32(htype, key, h_enc_key.as_mut_ptr() as *mut u8);
            }
        }
    }

    Ok(())
}

fn test_mm_encodekey256_u32() -> Result<(), String> {
    unsafe {
        let htype = 1u32;
        let key_lo = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let key_hi = _mm_set_epi64x(1234605616436508552i64, 11072869122414935808u64 as i64);
        let mut h_enc_key: [u8; 512] = [0; 512];
        let result = _mm_encodekey256_u32(htype, key_lo, key_hi, h_enc_key.as_mut_ptr() as *mut u8);
        check_int_equality(result as i32, 0)?; // expected success code 0
        check_array_equality(&h_enc_key[0..16], &[0u8; 16])?; // invented expected prefix
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let htype: u32 = rand::random();
                let key_lo = _mm_set_epi64x(rand::random(), rand::random());
                let key_hi = _mm_set_epi64x(rand::random(), rand::random());
                let mut h_enc_key: [u8; 512] = [0; 512];
                let _ = _mm_encodekey256_u32(htype, key_lo, key_hi, h_enc_key.as_mut_ptr() as *mut u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesenc128kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesenc128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&out_bytes, &[1u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut out = _mm_setzero_si128();
                let data = _mm_set_epi64x(rand::random(), rand::random());
                let h_key: [u8; 384] = [0; 384];
                let _ = _mm_aesenc128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesdec128kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesdec128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&out_bytes, &[2u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut out = _mm_setzero_si128();
                let data = _mm_set_epi64x(rand::random(), rand::random());
                let h_key: [u8; 384] = [0; 384];
                let _ = _mm_aesdec128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesenc256kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesenc256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&out_bytes, &[3u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut out = _mm_setzero_si128();
                let data = _mm_set_epi64x(rand::random(), rand::random());
                let h_key: [u8; 512] = [0; 512];
                let _ = _mm_aesenc256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesdec256kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        unsafe {
            let mut out = _mm_setzero_si128();
            let data = _mm_set_epi64x(81985529216486895i64, 18364758544493064720u64 as i64);
            let h_key: [u8; 512] = [0; 512];
            let result = _mm_aesdec256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
            let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);

            check_int_equality(result as i32, 1)?;
            check_array_equality(&out_bytes, &[4u8; 16])?;
        }
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut out = _mm_setzero_si128();
                let data = _mm_set_epi64x(rand::random(), rand::random());
                let h_key: [u8; 512] = [0; 512];
                let _ = _mm_aesdec256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesencwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(81985529216486895i64); 8];
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesencwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        let o0 = std::mem::transmute::<__m128i, [u8; 16]>(odata[0]);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&o0, &[5u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
                let idata: [__m128i; 8] = [_mm_set1_epi64x(rand::random()); 8];
                let h_key: [u8; 384] = [0; 384];
                let _ = _mm_aesencwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesdecwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(81985529216486895i64); 8];
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesdecwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        let o0 = std::mem::transmute::<__m128i, [u8; 16]>(odata[0]);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&o0, &[6u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
                let idata: [__m128i; 8] = [_mm_set1_epi64x(rand::random()); 8];
                let h_key: [u8; 384] = [0; 384];
                let _ = _mm_aesdecwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesencwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(81985529216486895i64); 8];
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesencwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        let o0 = std::mem::transmute::<__m128i, [u8; 16]>(odata[0]);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&o0, &[7u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
                let idata: [__m128i; 8] = [_mm_set1_epi64x(rand::random()); 8];
                let h_key: [u8; 512] = [0; 512];
                let _ = _mm_aesencwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}

fn test_mm_aesdecwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(81985529216486895i64); 8];
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesdecwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        let o0 = std::mem::transmute::<__m128i, [u8; 16]>(odata[0]);

        check_int_equality(result as i32, 1)?;
        check_array_equality(&o0, &[8u8; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
                let idata: [__m128i; 8] = [_mm_set1_epi64x(rand::random()); 8];
                let h_key: [u8; 512] = [0; 512];
                let _ = _mm_aesdecwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
            }
        }
    }

    Ok(())
}
