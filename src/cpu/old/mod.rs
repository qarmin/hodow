#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "aes"))]
pub mod aes;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx"))]
pub mod avx;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx2"))]
pub mod avx2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512bitalg"))]
pub mod avx512bitalg;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512cd"))]
pub mod avx512cd;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512f"))]
pub mod avx512f;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512ifma"))]
pub mod avx512ifma;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512vbmi"))]
pub mod avx512vbmi;
// TODO - unstable
// #[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512bf16"))]
// pub mod avx512bf16;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512vbmi2"))]
pub mod avx512vbmi2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512vnni"))]
pub mod avx512vnni;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512vpopcntdq"))]
pub mod avx512vpopcntdq;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avxneconvert"))]
pub mod avxneconvert;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "gfni"))]
pub mod gfni;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sha"))]
pub mod sha;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse"))]
pub mod sse;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4a"))]
pub mod sse4a;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "ssse3"))]
pub mod ssse3;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "fma"))]
pub mod fma;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "kl"))]
pub mod kl;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse"))]
pub mod sse1;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse2"))]
pub mod sse2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse3"))]
pub mod sse3;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.1"))]
pub mod sse41;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.2"))]
pub mod sse42;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.1"))]
pub mod sse4_1;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "sse4.2"))]
pub mod sse4_2;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "f16c"))]
pub mod f16c;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "pclmulqdq"))]
pub mod pclmulqdq;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "bmi2"))]
pub mod bmi;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "bmi1"))]
pub mod bmi1;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512bw"))]
pub mod avx512bw;
#[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512f"))]
pub mod avx512dq;
// Unstable
// #[cfg(all(any(target_arch = "x86", target_arch = "x86_64"), target_feature = "avx512fp16"))]
// pub mod avx512fp16;
