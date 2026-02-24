#[cfg(target_feature = "dsp")]
pub mod dsp;

#[cfg(target_feature = "neon")]
pub mod neon;

#[cfg(target_feature = "sat")]
pub mod sat;

#[cfg(target_feature = "simd32")]
pub mod simd32;
