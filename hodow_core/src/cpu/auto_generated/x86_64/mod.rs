pub mod abm;
#[cfg(target_feature = "adx")]
pub mod adx;

#[cfg(target_feature = "avx")]
pub mod avx;

#[cfg(target_feature = "avx512bw")]
pub mod avx512bw;

#[cfg(target_feature = "avx512f")]
pub mod avx512f;

#[cfg(target_feature = "avx512fp16")]
pub mod avx512fp16;

#[cfg(target_feature = "bmi1")]
pub mod bmi;

#[cfg(target_feature = "bmi2")]
pub mod bmi2;

pub mod bswap;
pub mod bt;
#[cfg(target_feature = "cmpxchg16b")]
pub mod cmpxchg16b;

#[cfg(target_feature = "fxsr")]
pub mod fxsr;

#[cfg(target_feature = "rdrand")]
pub mod rdrand;

#[cfg(target_feature = "sse")]
pub mod sse;

#[cfg(target_feature = "sse2")]
pub mod sse2;

#[cfg(target_feature = "sse4.1")]
pub mod sse41;

#[cfg(target_feature = "sse4.2")]
pub mod sse42;

#[cfg(target_feature = "tbm")]
pub mod tbm;

#[cfg(target_feature = "xsave")]
pub mod xsave;
