#![allow(incomplete_features)]
#![allow(dead_code)]
#![allow(unused_imports)]
#![allow(clippy::macro_metavars_in_unsafe)]
// MTE/prefetch intrinsics used by the generated aarch64 CPU tests are still unstable in
// std::arch - cfg_attr rather than a plain #![feature(...)] so this stays entirely inert
// (and the crate keeps building on stable) for every other target; only an aarch64 build,
// which already needs a cross-compile + nightly toolchain to reach this code at all, pulls
// it in. `is_arm_feature_detected!`/`is_riscv_feature_detected!` (used by registry.rs's
// generated runtime-detection calls for arm/riscv*, see generate_tests.py's
// get_feature_detect_fn) are separately unstable from the aarch64 ones above and from each
// other, gated the same way per architecture.
#![cfg_attr(
    target_arch = "aarch64",
    feature(
        // The rebucketed NEON groups (see rebucket_neon_by_feature) check features like
        // `faminmax`/`lut`/`frintts` whose detection strings are still unstable, unlike the
        // `neon`/`crc`/`aes` handful that was enough before.
        stdarch_aarch64_feature_detection,
        stdarch_aarch64_mte,
        stdarch_aarch64_prefetch,
        stdarch_aarch64_rand,
        faminmax,
        stdarch_neon_fcma,
        stdarch_neon_feat_lrcpc3,
        stdarch_neon_feat_lut,
        stdarch_neon_fp8,
        stdarch_neon_ftts,
        stdarch_neon_sm4,
        stdarch_neon_i8mm,
        stdarch_aarch64_sve,
    )
)]
#![cfg_attr(
    target_arch = "arm",
    feature(
        stdarch_arm_feature_detection,
        stdarch_aarch32_crc32,
        stdarch_arm_neon_intrinsics,
        stdarch_neon_i8mm,
    )
)]
#![cfg_attr(any(target_arch = "riscv32", target_arch = "riscv64"), feature(stdarch_riscv_feature_detection, riscv_ext_intrinsics))]

use std::sync::OnceLock;

pub mod cpu;

#[cfg(feature = "gpu")]
pub mod opengl;

#[cfg(feature = "vulkan")]
pub mod vulkan;

// Re-export main API
pub use cpu::{
    ExtensionStatus, ExtensionTest, FeatureStats, ProgressCallback, TestFunction, TestProgress, TestStatistics, all_tests, available_modes, extension_status, get_iterations,
    list_all_functions,
    request_stop,
    reset_stop_flag, set_iterations, set_only_features, set_only_tests, set_skip_tests, should_skip_feature, should_skip_test_or_feature, should_stop, test_all_extensions,
};
// Re-export OpenGL API only when the `gpu` feature is enabled
#[cfg(feature = "gpu")]
pub use opengl::memtest::{MemtestReport, run_memtest};
#[cfg(feature = "gpu")]
pub use opengl::tests::{run_single as run_single_gl_test, test_count as gl_test_count, test_name_at as gl_test_name_at};
pub use opengl::{DisplayApiHint, GLTestResult, GlApiHint, GlInfo, GpuOptions, OpenGLMode, available_opengl_modes, init_opengl, probe_opengl, test_all_opengl};

static FUZZING: OnceLock<bool> = OnceLock::new();

pub fn get_fuzzing() -> bool {
    // Fuzzing is enabled by default; reading it must not mutate the cell, otherwise a
    // later `set_fuzzing(false)` would be silently ignored (OnceLock only accepts the
    // first write) and concurrent readers could race on the initializing write.
    *FUZZING.get().unwrap_or(&true)
}

pub fn set_fuzzing(enabled: bool) {
    let _ = FUZZING.set(enabled);
}

pub fn get_fuzzer() -> bool {
    get_fuzzing()
}
