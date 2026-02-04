#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;
pub struct KL;
impl ExtensionTest for KL {
    fn get_name() -> &'static str {
        "Key Locker"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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
        let intkey = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let enkey_lo = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let enkey_hi = _mm_set_epi64x(0x0011223344556677i64, 0x8899aabbccddeeffi64);
        _mm_loadiwkey(ctl, intkey, enkey_lo, enkey_hi);
        Ok(())
    }
}
fn test_mm_encodekey128_u32() -> Result<(), String> {
    unsafe {
        let htype = 1u32;
        let key = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let mut h_enc_key: [u8; 384] = [0; 384];
        let result = _mm_encodekey128_u32(htype, key, h_enc_key.as_mut_ptr() as *mut u8);
        if result > 1 {
            return Err(format!("Encode key returned unexpected value: {}", result));
        }
        Ok(())
    }
}
fn test_mm_encodekey256_u32() -> Result<(), String> {
    unsafe {
        let htype = 1u32;
        let key_lo = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let key_hi = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let mut h_enc_key: [u8; 512] = [0; 512];
        let result = _mm_encodekey256_u32(htype, key_lo, key_hi, h_enc_key.as_mut_ptr() as *mut u8);
        if result > 1 {
            return Err(format!("Encode key returned unexpected value: {}", result));
        }
        Ok(())
    }
}
fn test_mm_aesenc128kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesenc128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);
        // check result is a byte value (u8)
        if result == 0 {
            return Err(format!("AESENC128KL returned zero"));
        }
        let _ = out_bytes;
        Ok(())
    }
}
fn test_mm_aesdec128kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesdec128kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);
        if result == 0 {
            return Err(format!("AESDEC128KL returned zero"));
        }
        let _ = out_bytes;
        Ok(())
    }
}
fn test_mm_aesenc256kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesenc256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);
        if result == 0 {
            return Err(format!("AESENC256KL returned zero"));
        }
        let _ = out_bytes;
        Ok(())
    }
}
fn test_mm_aesdec256kl_u8() -> Result<(), String> {
    unsafe {
        let mut out = _mm_setzero_si128();
        let data = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesdec256kl_u8(&mut out, data, h_key.as_ptr() as *const u8);
        let out_bytes = std::mem::transmute::<__m128i, [u8; 16]>(out);
        if result == 0 {
            return Err(format!("AESDEC256KL returned zero"));
        }
        let _ = out_bytes;
        Ok(())
    }
}
fn test_mm_aesencwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(0x0123456789abcdefi64); 8];
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesencwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        if result == 0 {
            return Err(format!("AESENCWIDE128KL returned zero"));
        }
        let _ = odata;
        Ok(())
    }
}
fn test_mm_aesdecwide128kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(0x0123456789abcdefi64); 8];
        let h_key: [u8; 384] = [0; 384];
        let result = _mm_aesdecwide128kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        if result == 0 {
            return Err(format!("AESDECWIDE128KL returned zero"));
        }
        let _ = odata;
        Ok(())
    }
}
fn test_mm_aesencwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(0x0123456789abcdefi64); 8];
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesencwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        if result == 0 {
            return Err(format!("AESENCWIDE256KL returned zero"));
        }
        let _ = odata;
        Ok(())
    }
}
fn test_mm_aesdecwide256kl_u8() -> Result<(), String> {
    unsafe {
        let mut odata: [__m128i; 8] = [_mm_setzero_si128(); 8];
        let idata: [__m128i; 8] = [_mm_set1_epi64x(0x0123456789abcdefi64); 8];
        let h_key: [u8; 512] = [0; 512];
        let result = _mm_aesdecwide256kl_u8(odata.as_mut_ptr(), idata.as_ptr(), h_key.as_ptr() as *const u8);
        if result == 0 {
            return Err(format!("AESDECWIDE256KL returned zero"));
        }
        let _ = odata;
        Ok(())
    }
}
