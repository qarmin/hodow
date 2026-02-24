#[cfg(target_feature = "abm")]
pub mod abm;

#[cfg(target_feature = "adx")]
pub mod adx;

#[cfg(target_feature = "aes")]
pub mod aes;

#[cfg(target_feature = "avx")]
pub mod avx;

#[cfg(target_feature = "avx2")]
pub mod avx2;

#[cfg(target_feature = "avx512bf16")]
pub mod avx512bf16;

#[cfg(target_feature = "avx512bitalg")]
pub mod avx512bitalg;

#[cfg(target_feature = "avx512bw")]
pub mod avx512bw;

#[cfg(target_feature = "avx512cd")]
pub mod avx512cd;

#[cfg(target_feature = "avx512dq")]
pub mod avx512dq;

#[cfg(target_feature = "avx512f")]
pub mod avx512f;

#[cfg(target_feature = "avx512fp16")]
pub mod avx512fp16;

#[cfg(target_feature = "avx512ifma")]
pub mod avx512ifma;

#[cfg(target_feature = "avx512vbmi")]
pub mod avx512vbmi;

#[cfg(target_feature = "avx512vbmi2")]
pub mod avx512vbmi2;

#[cfg(target_feature = "avx512vnni")]
pub mod avx512vnni;

#[cfg(target_feature = "avx512vpopcntdq")]
pub mod avx512vpopcntdq;

#[cfg(target_feature = "avxneconvert")]
pub mod avxneconvert;

#[cfg(target_feature = "bmi1")]
pub mod bmi1;

#[cfg(target_feature = "bmi2")]
pub mod bmi2;

#[cfg(target_feature = "bswap")]
pub mod bswap;

#[cfg(target_feature = "bt")]
pub mod bt;

#[cfg(target_feature = "cpuid")]
pub mod cpuid;

#[cfg(target_feature = "eflags")]
pub mod eflags;

#[cfg(target_feature = "f16c")]
pub mod f16c;

#[cfg(target_feature = "fma")]
pub mod fma;

#[cfg(target_feature = "fxsr")]
pub mod fxsr;

#[cfg(target_feature = "gfni")]
pub mod gfni;

#[cfg(target_feature = "kl")]
pub mod kl;

#[cfg(target_feature = "pclmulqdq")]
pub mod pclmulqdq;

#[cfg(target_feature = "rdrand")]
pub mod rdrand;

#[cfg(target_feature = "rdtsc")]
pub mod rdtsc;

#[cfg(target_feature = "rtm")]
pub mod rtm;

#[cfg(target_feature = "sha")]
pub mod sha;

#[cfg(target_feature = "sse")]
pub mod sse;

#[cfg(target_feature = "sse2")]
pub mod sse2;

#[cfg(target_feature = "sse3")]
pub mod sse3;

#[cfg(target_feature = "sse4.1")]
pub mod sse41;

#[cfg(target_feature = "sse4.2")]
pub mod sse42;

#[cfg(target_feature = "sse4a")]
pub mod sse4a;

#[cfg(target_feature = "ssse3")]
pub mod ssse3;

#[cfg(target_feature = "tbm")]
pub mod tbm;

#[cfg(target_feature = "vaes")]
pub mod vaes;

#[cfg(target_feature = "vpclmulqdq")]
pub mod vpclmulqdq;

#[cfg(target_feature = "xsave")]
pub mod xsave;
