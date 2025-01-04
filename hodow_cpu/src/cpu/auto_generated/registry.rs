#![allow(unused_imports)]
#![allow(unreachable_code)]

use crate::cpu::{ExtensionStatus, ExtensionTest, FeatureStats, TestStatistics, ProgressCallback, TestFunction};
use crate::cpu::{reset_stop_flag, should_stop, should_skip_feature};

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_aes() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("aes"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("aes"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_bf16() -> bool {
    #[cfg(target_arch = "arm")]
    { return false; /* no is_arm_feature_detected! string for "bf16" */ }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("bf16"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_crc() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("crc"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("crc"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_dotprod() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("dotprod"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("dotprod"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_fp_armv8() -> bool {
    #[cfg(target_arch = "arm")]
    { return false; /* no is_arm_feature_detected! string for "fp-armv8" */ }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("neon"); /* plain NEON here; "fp-armv8" is a 32-bit ARM requirement */ }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_fp16() -> bool {
    #[cfg(target_arch = "arm")]
    { return false; /* no is_arm_feature_detected! string for "fp16" */ }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("fp16"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_i8mm() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("i8mm"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("i8mm"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_neon() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("neon"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("neon"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_sha2() -> bool {
    #[cfg(target_arch = "arm")]
    { return std::arch::is_arm_feature_detected!("sha2"); }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("sha2"); }
}

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
fn detect_arm_shared_vfp4() -> bool {
    #[cfg(target_arch = "arm")]
    { return false; /* no is_arm_feature_detected! string for "vfp4" */ }
    #[cfg(target_arch = "aarch64")]
    { return std::arch::is_aarch64_feature_detected!("neon"); /* plain NEON here; "vfp4" is a 32-bit ARM requirement */ }
}

/// Count how many CPU features/extensions are available on this machine
pub fn count_available_features() -> usize {
    let mut count = 0;

    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("aes") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("crc") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("faminmax") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("fcma") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("fp16") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("fp8") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("frintts") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("jsconv") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("lut") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("mte") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("neon") {
            count += 1;
        }

        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("rand") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("rcpc3") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("rdm") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("sha3") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("sm4") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("sve") {
            count += 1;
        }

        if std::arch::is_aarch64_feature_detected!("sve2") {
            count += 1;
        }

    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("aes") {
            count += 1;
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
        if detect_arm_shared_aes() {
            count += 1;
        }

        if detect_arm_shared_bf16() {
            count += 1;
        }

        if detect_arm_shared_crc() {
            count += 1;
        }

        if detect_arm_shared_dotprod() {
            count += 1;
        }

        if detect_arm_shared_fp16() {
            count += 1;
        }

        if detect_arm_shared_fp_armv8() {
            count += 1;
        }

        if detect_arm_shared_i8mm() {
            count += 1;
        }

        if detect_arm_shared_neon() {
            count += 1;
        }

        if detect_arm_shared_sha2() {
            count += 1;
        }

        if detect_arm_shared_vfp4() {
            count += 1;
        }

    }

    #[cfg(target_arch = "loongarch64")]
    {
        if false /* feature detection not yet implemented */ {
            count += 1;
        }

        if false /* feature detection not yet implemented */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "mips")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "powerpc")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "powerpc64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "riscv32")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            count += 1;
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            count += 1;
        }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        if std::arch::is_riscv_feature_detected!("p") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            count += 1;
        }

    }

    #[cfg(target_arch = "s390x")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "wasm32")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("adx") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("aes") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("avx") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("avx2") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("avxneconvert") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("bmi1") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("bmi2") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("f16c") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("fma") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("fxsr") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("gfni") {
            count += 1;
        }

        if crate::cpu::common::x86::keylocker_usable() {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("rdrand") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sha") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse2") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse3") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse4.1") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse4.2") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse4a") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("ssse3") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("tbm") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("vaes") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("xsave") {
            count += 1;
        }

    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("adx") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("avx") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            count += 1;
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("bmi1") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("bmi2") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("fxsr") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("rdrand") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse2") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse4.1") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("sse4.2") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("tbm") {
            count += 1;
        }

        if std::arch::is_x86_feature_detected!("xsave") {
            count += 1;
        }

    }

    count
}

/// Get list of available CPU features/extensions on this machine
/// Returns a sorted, deduplicated list with architecture prefixes
pub fn available_modes() -> Vec<String> {
    use std::collections::BTreeSet;
    let mut modes = BTreeSet::new();

    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("aes") {
            modes.insert(format!("{}:{}", "aarch64", "aes"));
        }
        if std::arch::is_aarch64_feature_detected!("crc") {
            modes.insert(format!("{}:{}", "aarch64", "crc"));
        }
        if std::arch::is_aarch64_feature_detected!("faminmax") {
            modes.insert(format!("{}:{}", "aarch64", "faminmax"));
        }
        if std::arch::is_aarch64_feature_detected!("fcma") {
            modes.insert(format!("{}:{}", "aarch64", "fcma"));
        }
        if std::arch::is_aarch64_feature_detected!("fp16") {
            modes.insert(format!("{}:{}", "aarch64", "fp16"));
        }
        if std::arch::is_aarch64_feature_detected!("fp8") {
            modes.insert(format!("{}:{}", "aarch64", "fp8"));
        }
        if std::arch::is_aarch64_feature_detected!("frintts") {
            modes.insert(format!("{}:{}", "aarch64", "frintts"));
        }
        if std::arch::is_aarch64_feature_detected!("jsconv") {
            modes.insert(format!("{}:{}", "aarch64", "jsconv"));
        }
        if std::arch::is_aarch64_feature_detected!("lut") {
            modes.insert(format!("{}:{}", "aarch64", "lut"));
        }
        if std::arch::is_aarch64_feature_detected!("mte") {
            modes.insert(format!("{}:{}", "aarch64", "mte"));
        }
        if std::arch::is_aarch64_feature_detected!("neon") {
            modes.insert(format!("{}:{}", "aarch64", "neon"));
        }
        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            modes.insert(format!("{}:{}", "aarch64", "prefetch"));
        }
        if std::arch::is_aarch64_feature_detected!("rand") {
            modes.insert(format!("{}:{}", "aarch64", "rand"));
        }
        if std::arch::is_aarch64_feature_detected!("rcpc3") {
            modes.insert(format!("{}:{}", "aarch64", "rcpc3"));
        }
        if std::arch::is_aarch64_feature_detected!("rdm") {
            modes.insert(format!("{}:{}", "aarch64", "rdm"));
        }
        if std::arch::is_aarch64_feature_detected!("sha3") {
            modes.insert(format!("{}:{}", "aarch64", "sha3"));
        }
        if std::arch::is_aarch64_feature_detected!("sm4") {
            modes.insert(format!("{}:{}", "aarch64", "sm4"));
        }
        if std::arch::is_aarch64_feature_detected!("sve") {
            modes.insert(format!("{}:{}", "aarch64", "sve"));
        }
        if std::arch::is_aarch64_feature_detected!("sve2") {
            modes.insert(format!("{}:{}", "aarch64", "sve2"));
        }
    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("aes") {
            modes.insert(format!("{}:{}", "arm", "aes"));
        }
    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
        if detect_arm_shared_aes() {
            modes.insert(format!("{}:{}", "arm", "aes"));
        }
        if detect_arm_shared_bf16() {
            modes.insert(format!("{}:{}", "arm", "bf16"));
        }
        if detect_arm_shared_crc() {
            modes.insert(format!("{}:{}", "arm", "crc"));
        }
        if detect_arm_shared_dotprod() {
            modes.insert(format!("{}:{}", "arm", "dotprod"));
        }
        if detect_arm_shared_fp16() {
            modes.insert(format!("{}:{}", "arm", "fp16"));
        }
        if detect_arm_shared_fp_armv8() {
            modes.insert(format!("{}:{}", "arm", "fp-armv8"));
        }
        if detect_arm_shared_i8mm() {
            modes.insert(format!("{}:{}", "arm", "i8mm"));
        }
        if detect_arm_shared_neon() {
            modes.insert(format!("{}:{}", "arm", "neon"));
        }
        if detect_arm_shared_sha2() {
            modes.insert(format!("{}:{}", "arm", "sha2"));
        }
        if detect_arm_shared_vfp4() {
            modes.insert(format!("{}:{}", "arm", "vfp4"));
        }
    }

    #[cfg(target_arch = "loongarch64")]
    {
        if false /* feature detection not yet implemented */ {
            modes.insert(format!("{}:{}", "loongarch64", "lasx"));
        }
        if false /* feature detection not yet implemented */ {
            modes.insert(format!("{}:{}", "loongarch64", "lsx"));
        }
    }

    #[cfg(target_arch = "mips")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "mips", "msa"));
        }
    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "nvptx", "packed"));
        }
    }

    #[cfg(target_arch = "powerpc")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "powerpc", "altivec"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "powerpc", "vsx"));
        }
    }

    #[cfg(target_arch = "powerpc64")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "powerpc64", "vsx"));
        }
    }

    #[cfg(target_arch = "riscv32")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "riscv32", "zb"));
        }
        if std::arch::is_riscv_feature_detected!("zk") {
            modes.insert(format!("{}:{}", "riscv32", "zk"));
        }
    }

    #[cfg(target_arch = "riscv64")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "riscv64", "zb"));
        }
        if std::arch::is_riscv_feature_detected!("zk") {
            modes.insert(format!("{}:{}", "riscv64", "zk"));
        }
    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        if std::arch::is_riscv_feature_detected!("p") {
            modes.insert(format!("{}:{}", "riscv", "p"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "riscv", "zb"));
        }
        if std::arch::is_riscv_feature_detected!("zk") {
            modes.insert(format!("{}:{}", "riscv", "zk"));
        }
    }

    #[cfg(target_arch = "s390x")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "s390x", "vector"));
        }
    }

    #[cfg(target_arch = "wasm32")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "wasm32", "atomic"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "wasm32", "memory"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "wasm32", "relaxed_simd"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "wasm32", "simd128"));
        }
    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "abm"));
        }
        if std::arch::is_x86_feature_detected!("adx") {
            modes.insert(format!("{}:{}", "x86", "adx"));
        }
        if std::arch::is_x86_feature_detected!("aes") {
            modes.insert(format!("{}:{}", "x86", "aes"));
        }
        if std::arch::is_x86_feature_detected!("avx") {
            modes.insert(format!("{}:{}", "x86", "avx"));
        }
        if std::arch::is_x86_feature_detected!("avx2") {
            modes.insert(format!("{}:{}", "x86", "avx2"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            modes.insert(format!("{}:{}", "x86", "avx512bf16"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            modes.insert(format!("{}:{}", "x86", "avx512bitalg"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.insert(format!("{}:{}", "x86", "avx512bw"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            modes.insert(format!("{}:{}", "x86", "avx512cd"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            modes.insert(format!("{}:{}", "x86", "avx512dq"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.insert(format!("{}:{}", "x86", "avx512f"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.insert(format!("{}:{}", "x86", "avx512fp16"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            modes.insert(format!("{}:{}", "x86", "avx512ifma"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            modes.insert(format!("{}:{}", "x86", "avx512vbmi"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            modes.insert(format!("{}:{}", "x86", "avx512vbmi2"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            modes.insert(format!("{}:{}", "x86", "avx512vnni"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            modes.insert(format!("{}:{}", "x86", "avx512vpopcntdq"));
        }
        if std::arch::is_x86_feature_detected!("avxneconvert") {
            modes.insert(format!("{}:{}", "x86", "avxneconvert"));
        }
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.insert(format!("{}:{}", "x86", "bmi1"));
        }
        if std::arch::is_x86_feature_detected!("bmi2") {
            modes.insert(format!("{}:{}", "x86", "bmi2"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "bswap"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "bt"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "cpuid"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "eflags"));
        }
        if std::arch::is_x86_feature_detected!("f16c") {
            modes.insert(format!("{}:{}", "x86", "f16c"));
        }
        if std::arch::is_x86_feature_detected!("fma") {
            modes.insert(format!("{}:{}", "x86", "fma"));
        }
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.insert(format!("{}:{}", "x86", "fxsr"));
        }
        if std::arch::is_x86_feature_detected!("gfni") {
            modes.insert(format!("{}:{}", "x86", "gfni"));
        }
        if crate::cpu::common::x86::keylocker_usable() {
            modes.insert(format!("{}:{}", "x86", "kl"));
        }
        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            modes.insert(format!("{}:{}", "x86", "pclmulqdq"));
        }
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.insert(format!("{}:{}", "x86", "rdrand"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "rdtsc"));
        }
        if std::arch::is_x86_feature_detected!("sha") {
            modes.insert(format!("{}:{}", "x86", "sha"));
        }
        if std::arch::is_x86_feature_detected!("sse") {
            modes.insert(format!("{}:{}", "x86", "sse"));
        }
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.insert(format!("{}:{}", "x86", "sse2"));
        }
        if std::arch::is_x86_feature_detected!("sse3") {
            modes.insert(format!("{}:{}", "x86", "sse3"));
        }
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.insert(format!("{}:{}", "x86", "sse4.1"));
        }
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.insert(format!("{}:{}", "x86", "sse4.2"));
        }
        if std::arch::is_x86_feature_detected!("sse4a") {
            modes.insert(format!("{}:{}", "x86", "sse4a"));
        }
        if std::arch::is_x86_feature_detected!("ssse3") {
            modes.insert(format!("{}:{}", "x86", "ssse3"));
        }
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.insert(format!("{}:{}", "x86", "tbm"));
        }
        if std::arch::is_x86_feature_detected!("vaes") {
            modes.insert(format!("{}:{}", "x86", "vaes"));
        }
        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            modes.insert(format!("{}:{}", "x86", "vpclmulqdq"));
        }
        if std::arch::is_x86_feature_detected!("xsave") {
            modes.insert(format!("{}:{}", "x86", "xsave"));
        }
    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "abm"));
        }
        if std::arch::is_x86_feature_detected!("adx") {
            modes.insert(format!("{}:{}", "x86_64", "adx"));
        }
        if std::arch::is_x86_feature_detected!("avx") {
            modes.insert(format!("{}:{}", "x86_64", "avx"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.insert(format!("{}:{}", "x86_64", "avx512bw"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.insert(format!("{}:{}", "x86_64", "avx512f"));
        }
        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.insert(format!("{}:{}", "x86_64", "avx512fp16"));
        }
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.insert(format!("{}:{}", "x86_64", "bmi1"));
        }
        if std::arch::is_x86_feature_detected!("bmi2") {
            modes.insert(format!("{}:{}", "x86_64", "bmi2"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "bswap"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "bt"));
        }
        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            modes.insert(format!("{}:{}", "x86_64", "cmpxchg16b"));
        }
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.insert(format!("{}:{}", "x86_64", "fxsr"));
        }
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.insert(format!("{}:{}", "x86_64", "rdrand"));
        }
        if std::arch::is_x86_feature_detected!("sse") {
            modes.insert(format!("{}:{}", "x86_64", "sse"));
        }
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.insert(format!("{}:{}", "x86_64", "sse2"));
        }
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.insert(format!("{}:{}", "x86_64", "sse4.1"));
        }
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.insert(format!("{}:{}", "x86_64", "sse4.2"));
        }
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.insert(format!("{}:{}", "x86_64", "tbm"));
        }
        if std::arch::is_x86_feature_detected!("xsave") {
            modes.insert(format!("{}:{}", "x86_64", "xsave"));
        }
    }

    modes.into_iter().collect()
}

/// Test all available CPU extensions with progress callback
pub fn test_all_extensions(progress_callback: Option<&ProgressCallback>) -> Result<TestStatistics, String> {
    reset_stop_flag();

    let total_features = count_available_features();
    let mut completed_features = 0;
    let mut features = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
            if std::arch::is_aarch64_feature_detected!("aes") && !should_skip_feature("aes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::aes::AES::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("crc") && !should_skip_feature("crc") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::crc::CRC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::crc::CRC::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("faminmax") && !should_skip_feature("faminmax") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::faminmax::FAMINMAX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::faminmax::FAMINMAX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("fcma") && !should_skip_feature("fcma") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::fcma::FCMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::fcma::FCMA::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("fp16") && !should_skip_feature("fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::fp16::FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::fp16::FP16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("fp8") && !should_skip_feature("fp8") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::fp8::FP8::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::fp8::FP8::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("frintts") && !should_skip_feature("frintts") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::frintts::FRINTTS::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::frintts::FRINTTS::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("jsconv") && !should_skip_feature("jsconv") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::jsconv::JSCONV::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::jsconv::JSCONV::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("lut") && !should_skip_feature("lut") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::lut::LUT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::lut::LUT::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("mte") && !should_skip_feature("mte") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::mte::MTE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::mte::MTE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("neon") && !should_skip_feature("neon") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::neon::NEON::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::neon::NEON::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ && !should_skip_feature("prefetch") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("rand") && !should_skip_feature("rand") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::rand::RAND::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::rand::RAND::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("rcpc3") && !should_skip_feature("rcpc3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::rcpc3::RCPC3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::rcpc3::RCPC3::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("rdm") && !should_skip_feature("rdm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::rdm::RDM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::rdm::RDM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("sha3") && !should_skip_feature("sha3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::sha3::SHA3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::sha3::SHA3::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("sm4") && !should_skip_feature("sm4") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::sm4::SM4::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::sm4::SM4::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("sve") && !should_skip_feature("sve") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::sve::SVE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::sve::SVE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_aarch64_feature_detected!("sve2") && !should_skip_feature("sve2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::aarch64::sve2::SVE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::sve2::SVE2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "arm")]
    {
            if std::arch::is_arm_feature_detected!("aes") && !should_skip_feature("aes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm::aes::AES::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
            if detect_arm_shared_aes() && !should_skip_feature("aes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::aes::AES::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_bf16() && !should_skip_feature("bf16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::bf16::BF16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::bf16::BF16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_crc() && !should_skip_feature("crc") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::crc::CRC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::crc::CRC::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_dotprod() && !should_skip_feature("dotprod") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::dotprod::DOTPROD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::dotprod::DOTPROD::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_fp16() && !should_skip_feature("fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::fp16::FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::fp16::FP16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_fp_armv8() && !should_skip_feature("fp_armv8") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::fp_armv8::FP_ARMV8::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::fp_armv8::FP_ARMV8::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_i8mm() && !should_skip_feature("i8mm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::i8mm::I8MM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::i8mm::I8MM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_neon() && !should_skip_feature("neon") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::neon::NEON::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::neon::NEON::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_sha2() && !should_skip_feature("sha2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::sha2::SHA2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::sha2::SHA2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if detect_arm_shared_vfp4() && !should_skip_feature("vfp4") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::arm_shared::vfp4::VFP4::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm_shared::vfp4::VFP4::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "loongarch64")]
    {
            if false /* feature detection not yet implemented */ && !should_skip_feature("lasx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::loongarch64::lasx::LASX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::loongarch64::lasx::LASX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* feature detection not yet implemented */ && !should_skip_feature("lsx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::loongarch64::lsx::LSX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::loongarch64::lsx::LSX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "mips")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("msa") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::mips::msa::MSA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::mips::msa::MSA::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
            if false /* no runtime detection available */ && !should_skip_feature("packed") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::nvptx::packed::PACKED::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::nvptx::packed::PACKED::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "powerpc")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("altivec") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("vsx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::powerpc::vsx::VSX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc::vsx::VSX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "powerpc64")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("vsx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::powerpc64::vsx::VSX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc64::vsx::VSX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "riscv32")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("zb") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv32::zb::ZB::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv32::zb::ZB::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv32::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv32::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "riscv64")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("zb") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv64::zb::ZB::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv64::zb::ZB::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv64::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv64::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
            if std::arch::is_riscv_feature_detected!("p") && !should_skip_feature("p") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv_shared::p::P::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::p::P::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("zb") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv_shared::zb::ZB::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::zb::ZB::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::riscv_shared::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "s390x")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("vector") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::s390x::vector::VECTOR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::s390x::vector::VECTOR::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "wasm32")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("atomic") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::wasm32::atomic::ATOMIC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("memory") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::wasm32::memory::MEMORY::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::memory::MEMORY::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("relaxed_simd") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("simd128") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::wasm32::simd128::SIMD128::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
            if false /* no runtime detection available */ && !should_skip_feature("abm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::abm::ABM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::abm::ABM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("adx") && !should_skip_feature("adx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::adx::ADX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::adx::ADX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("aes") && !should_skip_feature("aes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::aes::AES::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("avx") && !should_skip_feature("avx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx::AVX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx::AVX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("avx2") && !should_skip_feature("avx2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx2::AVX2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx2::AVX2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512bf16") && !should_skip_feature("avx512bf16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512bitalg") && !should_skip_feature("avx512bitalg") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512bw") && !should_skip_feature("avx512bw") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512bw::AVX512BW::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512cd") && !should_skip_feature("avx512cd") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512cd::AVX512CD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512dq") && !should_skip_feature("avx512dq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512f") && !should_skip_feature("avx512f") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512f::AVX512F::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512fp16") && !should_skip_feature("avx512fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512ifma") && !should_skip_feature("avx512ifma") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512vbmi") && !should_skip_feature("avx512vbmi") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512vbmi2") && !should_skip_feature("avx512vbmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512vnni") && !should_skip_feature("avx512vnni") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512vpopcntdq") && !should_skip_feature("avx512vpopcntdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("avxneconvert") && !should_skip_feature("avxneconvert") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("bmi1") && !should_skip_feature("bmi1") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::bmi1::BMI1::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("bmi2") && !should_skip_feature("bmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::bmi2::BMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bmi2::BMI2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bswap") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::bswap::BSWAP::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bswap::BSWAP::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bt") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::bt::BT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bt::BT::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("cpuid") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::cpuid::CPUID::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::cpuid::CPUID::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("eflags") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::eflags::EFLAGS::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::eflags::EFLAGS::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("f16c") && !should_skip_feature("f16c") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::f16c::F16C::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::f16c::F16C::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("fma") && !should_skip_feature("fma") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::fma::FMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::fma::FMA::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("fxsr") && !should_skip_feature("fxsr") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::fxsr::FXSR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("gfni") && !should_skip_feature("gfni") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::gfni::GFNI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::gfni::GFNI::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if crate::cpu::common::x86::keylocker_usable() && !should_skip_feature("kl") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::kl::KL::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::kl::KL::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("pclmulqdq") && !should_skip_feature("pclmulqdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("rdrand") && !should_skip_feature("rdrand") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::rdrand::RDRAND::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::rdrand::RDRAND::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("rdtsc") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::rdtsc::RDTSC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sha") && !should_skip_feature("sha") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sha::SHA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sha::SHA::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse") && !should_skip_feature("sse") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse::SSE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse::SSE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse2") && !should_skip_feature("sse2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse2::SSE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse2::SSE2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse3") && !should_skip_feature("sse3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse3::SSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse3::SSE3::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse4.1") && !should_skip_feature("sse41") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse41::SSE41::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse41::SSE41::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse4.2") && !should_skip_feature("sse42") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse42::SSE42::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse42::SSE42::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse4a") && !should_skip_feature("sse4a") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::sse4a::SSE4A::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("ssse3") && !should_skip_feature("ssse3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::ssse3::SSSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("tbm") && !should_skip_feature("tbm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::tbm::TBM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::tbm::TBM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("vaes") && !should_skip_feature("vaes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::vaes::VAES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::vaes::VAES::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("vpclmulqdq") && !should_skip_feature("vpclmulqdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("xsave") && !should_skip_feature("xsave") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86::xsave::XSAVE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::xsave::XSAVE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "x86_64")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("abm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::abm::ABM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::abm::ABM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("adx") && !should_skip_feature("adx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::adx::ADX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::adx::ADX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("avx") && !should_skip_feature("avx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::avx::AVX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx::AVX::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512bw") && !should_skip_feature("avx512bw") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512f") && !should_skip_feature("avx512f") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::avx512f::AVX512F::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            #[cfg(feature = "avx512")]
            if std::arch::is_x86_feature_detected!("avx512fp16") && !should_skip_feature("avx512fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("bmi1") && !should_skip_feature("bmi") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::bmi::BMI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("bmi2") && !should_skip_feature("bmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::bmi2::BMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bswap") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::bswap::BSWAP::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bt") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::bt::BT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bt::BT::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("cmpxchg16b") && !should_skip_feature("cmpxchg16b") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("fxsr") && !should_skip_feature("fxsr") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::fxsr::FXSR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("rdrand") && !should_skip_feature("rdrand") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::rdrand::RDRAND::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse") && !should_skip_feature("sse") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::sse::SSE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse::SSE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse2") && !should_skip_feature("sse2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::sse2::SSE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse4.1") && !should_skip_feature("sse41") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::sse41::SSE41::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("sse4.2") && !should_skip_feature("sse42") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::sse42::SSE42::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("tbm") && !should_skip_feature("tbm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::tbm::TBM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

            if std::arch::is_x86_feature_detected!("xsave") && !should_skip_feature("xsave") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    features.push(crate::cpu::auto_generated::x86_64::xsave::XSAVE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests().len(),
                    progress_callback,
                    )?);
                    completed_features += 1;
            }

    }

    Ok(TestStatistics {
        features,
        was_cancelled: false,
    })
}

/// List all available test functions across all extensions
pub fn list_all_functions() -> Vec<String> {
    let mut functions = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::aarch64::aes::AES::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::crc::CRC::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::faminmax::FAMINMAX::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::fcma::FCMA::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::fp16::FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::fp8::FP8::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::frintts::FRINTTS::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::jsconv::JSCONV::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::lut::LUT::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::mte::MTE::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::neon::NEON::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::rand::RAND::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::rcpc3::RCPC3::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::rdm::RDM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::sha3::SHA3::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::sm4::SM4::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::sve::SVE::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::sve2::SVE2::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "arm")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::arm::aes::AES::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::aes::AES::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::bf16::BF16::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::crc::CRC::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::dotprod::DOTPROD::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::fp16::FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::fp_armv8::FP_ARMV8::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::i8mm::I8MM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::neon::NEON::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::sha2::SHA2::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::arm_shared::vfp4::VFP4::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "loongarch64")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::loongarch64::lasx::LASX::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::loongarch64::lsx::LSX::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "mips")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::mips::msa::MSA::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
        {
            for (_, name) in crate::cpu::auto_generated::nvptx::packed::PACKED::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "powerpc")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::powerpc::vsx::VSX::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "powerpc64")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::powerpc64::vsx::VSX::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "riscv32")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::riscv32::zb::ZB::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::riscv32::zk::ZK::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::riscv64::zb::ZB::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::riscv64::zk::ZK::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        {
            for (_, name) in crate::cpu::auto_generated::riscv_shared::p::P::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::riscv_shared::zb::ZB::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::riscv_shared::zk::ZK::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "s390x")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::s390x::vector::VECTOR::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "wasm32")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::wasm32::memory::MEMORY::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        {
            for (_, name) in crate::cpu::auto_generated::x86::abm::ABM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::adx::ADX::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::aes::AES::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::avx::AVX::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::avx2::AVX2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::bmi2::BMI2::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::bswap::BSWAP::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::bt::BT::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::cpuid::CPUID::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::eflags::EFLAGS::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::f16c::F16C::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::fma::FMA::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::gfni::GFNI::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::kl::KL::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::rdrand::RDRAND::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sha::SHA::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse::SSE::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse2::SSE2::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse3::SSE3::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse41::SSE41::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse42::SSE42::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::tbm::TBM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::vaes::VAES::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86::xsave::XSAVE::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "x86_64")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::abm::ABM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::adx::ADX::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx::AVX::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(feature = "avx512")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::bt::BT::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse::SSE::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    functions
}

/// Every extension this binary was built with, whether or not this machine has it -
/// the whole suite is always compiled in (see target_feature_attr in the generator),
/// so this is the only place the difference is visible.
pub fn extension_status() -> Vec<ExtensionStatus> {
    #[allow(unused_mut)]
    let mut exts: Vec<ExtensionStatus> = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
        exts.push(ExtensionStatus { arch: "aarch64", ext: "aes",
            test_count: crate::cpu::auto_generated::aarch64::aes::AES::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("aes"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "crc",
            test_count: crate::cpu::auto_generated::aarch64::crc::CRC::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("crc"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "faminmax",
            test_count: crate::cpu::auto_generated::aarch64::faminmax::FAMINMAX::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("faminmax"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "fcma",
            test_count: crate::cpu::auto_generated::aarch64::fcma::FCMA::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("fcma"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "fp16",
            test_count: crate::cpu::auto_generated::aarch64::fp16::FP16::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("fp16"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "fp8",
            test_count: crate::cpu::auto_generated::aarch64::fp8::FP8::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("fp8"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "frintts",
            test_count: crate::cpu::auto_generated::aarch64::frintts::FRINTTS::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("frintts"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "jsconv",
            test_count: crate::cpu::auto_generated::aarch64::jsconv::JSCONV::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("jsconv"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "lut",
            test_count: crate::cpu::auto_generated::aarch64::lut::LUT::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("lut"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "mte",
            test_count: crate::cpu::auto_generated::aarch64::mte::MTE::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("mte"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "neon",
            test_count: crate::cpu::auto_generated::aarch64::neon::NEON::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("neon"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "prefetch",
            test_count: crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests().len(),
            supported: true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */, detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "rand",
            test_count: crate::cpu::auto_generated::aarch64::rand::RAND::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("rand"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "rcpc3",
            test_count: crate::cpu::auto_generated::aarch64::rcpc3::RCPC3::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("rcpc3"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "rdm",
            test_count: crate::cpu::auto_generated::aarch64::rdm::RDM::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("rdm"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "sha3",
            test_count: crate::cpu::auto_generated::aarch64::sha3::SHA3::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("sha3"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "sm4",
            test_count: crate::cpu::auto_generated::aarch64::sm4::SM4::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("sm4"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "sve",
            test_count: crate::cpu::auto_generated::aarch64::sve::SVE::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("sve"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "aarch64", ext: "sve2",
            test_count: crate::cpu::auto_generated::aarch64::sve2::SVE2::get_tests().len(),
            supported: std::arch::is_aarch64_feature_detected!("sve2"), detectable: true, compiled_out: false });
    }

    #[cfg(target_arch = "arm")]
    {
        exts.push(ExtensionStatus { arch: "arm", ext: "aes",
            test_count: crate::cpu::auto_generated::arm::aes::AES::get_tests().len(),
            supported: std::arch::is_arm_feature_detected!("aes"), detectable: true, compiled_out: false });
    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "aes",
            test_count: crate::cpu::auto_generated::arm_shared::aes::AES::get_tests().len(),
            supported: detect_arm_shared_aes(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "bf16",
            test_count: crate::cpu::auto_generated::arm_shared::bf16::BF16::get_tests().len(),
            supported: detect_arm_shared_bf16(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "crc",
            test_count: crate::cpu::auto_generated::arm_shared::crc::CRC::get_tests().len(),
            supported: detect_arm_shared_crc(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "dotprod",
            test_count: crate::cpu::auto_generated::arm_shared::dotprod::DOTPROD::get_tests().len(),
            supported: detect_arm_shared_dotprod(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "fp16",
            test_count: crate::cpu::auto_generated::arm_shared::fp16::FP16::get_tests().len(),
            supported: detect_arm_shared_fp16(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "fp_armv8",
            test_count: crate::cpu::auto_generated::arm_shared::fp_armv8::FP_ARMV8::get_tests().len(),
            supported: detect_arm_shared_fp_armv8(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "i8mm",
            test_count: crate::cpu::auto_generated::arm_shared::i8mm::I8MM::get_tests().len(),
            supported: detect_arm_shared_i8mm(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "neon",
            test_count: crate::cpu::auto_generated::arm_shared::neon::NEON::get_tests().len(),
            supported: detect_arm_shared_neon(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "sha2",
            test_count: crate::cpu::auto_generated::arm_shared::sha2::SHA2::get_tests().len(),
            supported: detect_arm_shared_sha2(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "arm_shared", ext: "vfp4",
            test_count: crate::cpu::auto_generated::arm_shared::vfp4::VFP4::get_tests().len(),
            supported: detect_arm_shared_vfp4(), detectable: true, compiled_out: false });
    }

    #[cfg(target_arch = "loongarch64")]
    {
        exts.push(ExtensionStatus { arch: "loongarch64", ext: "lasx",
            test_count: crate::cpu::auto_generated::loongarch64::lasx::LASX::get_tests().len(),
            supported: false /* feature detection not yet implemented */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "loongarch64", ext: "lsx",
            test_count: crate::cpu::auto_generated::loongarch64::lsx::LSX::get_tests().len(),
            supported: false /* feature detection not yet implemented */, detectable: false, compiled_out: false });
    }

    #[cfg(target_arch = "mips")]
    {
        exts.push(ExtensionStatus { arch: "mips", ext: "msa",
            test_count: crate::cpu::auto_generated::mips::msa::MSA::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
        exts.push(ExtensionStatus { arch: "nvptx", ext: "packed",
            test_count: crate::cpu::auto_generated::nvptx::packed::PACKED::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    #[cfg(target_arch = "powerpc")]
    {
        exts.push(ExtensionStatus { arch: "powerpc", ext: "altivec",
            test_count: crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "powerpc", ext: "vsx",
            test_count: crate::cpu::auto_generated::powerpc::vsx::VSX::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    #[cfg(target_arch = "powerpc64")]
    {
        exts.push(ExtensionStatus { arch: "powerpc64", ext: "vsx",
            test_count: crate::cpu::auto_generated::powerpc64::vsx::VSX::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    #[cfg(target_arch = "riscv32")]
    {
        exts.push(ExtensionStatus { arch: "riscv32", ext: "zb",
            test_count: crate::cpu::auto_generated::riscv32::zb::ZB::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "riscv32", ext: "zk",
            test_count: crate::cpu::auto_generated::riscv32::zk::ZK::get_tests().len(),
            supported: std::arch::is_riscv_feature_detected!("zk"), detectable: true, compiled_out: false });
    }

    #[cfg(target_arch = "riscv64")]
    {
        exts.push(ExtensionStatus { arch: "riscv64", ext: "zb",
            test_count: crate::cpu::auto_generated::riscv64::zb::ZB::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "riscv64", ext: "zk",
            test_count: crate::cpu::auto_generated::riscv64::zk::ZK::get_tests().len(),
            supported: std::arch::is_riscv_feature_detected!("zk"), detectable: true, compiled_out: false });
    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        exts.push(ExtensionStatus { arch: "riscv_shared", ext: "p",
            test_count: crate::cpu::auto_generated::riscv_shared::p::P::get_tests().len(),
            supported: std::arch::is_riscv_feature_detected!("p"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "riscv_shared", ext: "zb",
            test_count: crate::cpu::auto_generated::riscv_shared::zb::ZB::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "riscv_shared", ext: "zk",
            test_count: crate::cpu::auto_generated::riscv_shared::zk::ZK::get_tests().len(),
            supported: std::arch::is_riscv_feature_detected!("zk"), detectable: true, compiled_out: false });
    }

    #[cfg(target_arch = "s390x")]
    {
        exts.push(ExtensionStatus { arch: "s390x", ext: "vector",
            test_count: crate::cpu::auto_generated::s390x::vector::VECTOR::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    #[cfg(target_arch = "wasm32")]
    {
        exts.push(ExtensionStatus { arch: "wasm32", ext: "atomic",
            test_count: crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "wasm32", ext: "memory",
            test_count: crate::cpu::auto_generated::wasm32::memory::MEMORY::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "wasm32", ext: "relaxed_simd",
            test_count: crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "wasm32", ext: "simd128",
            test_count: crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        exts.push(ExtensionStatus { arch: "x86", ext: "abm",
            test_count: crate::cpu::auto_generated::x86::abm::ABM::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "adx",
            test_count: crate::cpu::auto_generated::x86::adx::ADX::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("adx"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "aes",
            test_count: crate::cpu::auto_generated::x86::aes::AES::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("aes"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "avx",
            test_count: crate::cpu::auto_generated::x86::avx::AVX::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "avx2",
            test_count: crate::cpu::auto_generated::x86::avx2::AVX2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx2"), detectable: true, compiled_out: false });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bf16",
            test_count: crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512bf16"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bf16",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512bf16"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bitalg",
            test_count: crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512bitalg"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bitalg",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512bitalg"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bw",
            test_count: crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512bw"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512bw",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512bw"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512cd",
            test_count: crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512cd"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512cd",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512cd"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512dq",
            test_count: crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512dq"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512dq",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512dq"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512f",
            test_count: crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512f"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512f",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512f"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512fp16",
            test_count: crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512fp16"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512fp16",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512fp16"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512ifma",
            test_count: crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512ifma"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512ifma",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512ifma"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vbmi",
            test_count: crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512vbmi"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vbmi",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512vbmi"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vbmi2",
            test_count: crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512vbmi2"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vbmi2",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512vbmi2"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vnni",
            test_count: crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512vnni"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vnni",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512vnni"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vpopcntdq",
            test_count: crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512vpopcntdq"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86", ext: "avx512vpopcntdq",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512vpopcntdq"), detectable: true, compiled_out: true });
        exts.push(ExtensionStatus { arch: "x86", ext: "avxneconvert",
            test_count: crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avxneconvert"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "bmi1",
            test_count: crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("bmi1"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "bmi2",
            test_count: crate::cpu::auto_generated::x86::bmi2::BMI2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("bmi2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "bswap",
            test_count: crate::cpu::auto_generated::x86::bswap::BSWAP::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "bt",
            test_count: crate::cpu::auto_generated::x86::bt::BT::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "cpuid",
            test_count: crate::cpu::auto_generated::x86::cpuid::CPUID::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "eflags",
            test_count: crate::cpu::auto_generated::x86::eflags::EFLAGS::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "f16c",
            test_count: crate::cpu::auto_generated::x86::f16c::F16C::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("f16c"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "fma",
            test_count: crate::cpu::auto_generated::x86::fma::FMA::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("fma"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "fxsr",
            test_count: crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("fxsr"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "gfni",
            test_count: crate::cpu::auto_generated::x86::gfni::GFNI::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("gfni"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "kl",
            test_count: crate::cpu::auto_generated::x86::kl::KL::get_tests().len(),
            supported: crate::cpu::common::x86::keylocker_usable(), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "pclmulqdq",
            test_count: crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("pclmulqdq"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "rdrand",
            test_count: crate::cpu::auto_generated::x86::rdrand::RDRAND::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("rdrand"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "rdtsc",
            test_count: crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sha",
            test_count: crate::cpu::auto_generated::x86::sha::SHA::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sha"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse",
            test_count: crate::cpu::auto_generated::x86::sse::SSE::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse2",
            test_count: crate::cpu::auto_generated::x86::sse2::SSE2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse3",
            test_count: crate::cpu::auto_generated::x86::sse3::SSE3::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse3"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse41",
            test_count: crate::cpu::auto_generated::x86::sse41::SSE41::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse4.1"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse42",
            test_count: crate::cpu::auto_generated::x86::sse42::SSE42::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse4.2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "sse4a",
            test_count: crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse4a"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "ssse3",
            test_count: crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("ssse3"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "tbm",
            test_count: crate::cpu::auto_generated::x86::tbm::TBM::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("tbm"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "vaes",
            test_count: crate::cpu::auto_generated::x86::vaes::VAES::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("vaes"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "vpclmulqdq",
            test_count: crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("vpclmulqdq"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86", ext: "xsave",
            test_count: crate::cpu::auto_generated::x86::xsave::XSAVE::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("xsave"), detectable: true, compiled_out: false });
    }

    #[cfg(target_arch = "x86_64")]
    {
        exts.push(ExtensionStatus { arch: "x86_64", ext: "abm",
            test_count: crate::cpu::auto_generated::x86_64::abm::ABM::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "adx",
            test_count: crate::cpu::auto_generated::x86_64::adx::ADX::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("adx"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx",
            test_count: crate::cpu::auto_generated::x86_64::avx::AVX::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx"), detectable: true, compiled_out: false });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512bw",
            test_count: crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512bw"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512bw",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512bw"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512f",
            test_count: crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512f"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512f",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512f"), detectable: true, compiled_out: true });
        #[cfg(feature = "avx512")]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512fp16",
            test_count: crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("avx512fp16"), detectable: true, compiled_out: false });
        #[cfg(not(feature = "avx512"))]
        exts.push(ExtensionStatus { arch: "x86_64", ext: "avx512fp16",
            test_count: 0, supported: std::arch::is_x86_feature_detected!("avx512fp16"), detectable: true, compiled_out: true });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "bmi",
            test_count: crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("bmi1"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "bmi2",
            test_count: crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("bmi2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "bswap",
            test_count: crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "bt",
            test_count: crate::cpu::auto_generated::x86_64::bt::BT::get_tests().len(),
            supported: false /* no runtime detection available */, detectable: false, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "cmpxchg16b",
            test_count: crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("cmpxchg16b"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "fxsr",
            test_count: crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("fxsr"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "rdrand",
            test_count: crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("rdrand"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "sse",
            test_count: crate::cpu::auto_generated::x86_64::sse::SSE::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "sse2",
            test_count: crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "sse41",
            test_count: crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse4.1"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "sse42",
            test_count: crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("sse4.2"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "tbm",
            test_count: crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("tbm"), detectable: true, compiled_out: false });
        exts.push(ExtensionStatus { arch: "x86_64", ext: "xsave",
            test_count: crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests().len(),
            supported: std::arch::is_x86_feature_detected!("xsave"), detectable: true, compiled_out: false });
    }

    exts
}

/// Flat list of (test_name, feature, test_fn) for every feature detected at runtime
/// on this machine, in the canonical execution order. Used by the isolated subprocess
/// runner (so a crashing/hanging test can be attributed and skipped instead of
/// aborting the run) and by the stress runner. `feature` is the extension name (e.g.
/// "sse2", "avx2") a caller can filter on without re-detecting it per test.
pub fn all_tests() -> Vec<(&'static str, &'static str, TestFunction)> {
    let mut tests: Vec<(&'static str, &'static str, TestFunction)> = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("aes") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::aes::AES::get_tests() {
                tests.push((n, "aes", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("crc") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::crc::CRC::get_tests() {
                tests.push((n, "crc", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("faminmax") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::faminmax::FAMINMAX::get_tests() {
                tests.push((n, "faminmax", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("fcma") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::fcma::FCMA::get_tests() {
                tests.push((n, "fcma", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("fp16") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::fp16::FP16::get_tests() {
                tests.push((n, "fp16", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("fp8") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::fp8::FP8::get_tests() {
                tests.push((n, "fp8", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("frintts") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::frintts::FRINTTS::get_tests() {
                tests.push((n, "frintts", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("jsconv") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::jsconv::JSCONV::get_tests() {
                tests.push((n, "jsconv", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("lut") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::lut::LUT::get_tests() {
                tests.push((n, "lut", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("mte") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::mte::MTE::get_tests() {
                tests.push((n, "mte", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("neon") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::neon::NEON::get_tests() {
                tests.push((n, "neon", f));
            }
        }

        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            for &(f, n) in crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests() {
                tests.push((n, "prefetch", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("rand") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::rand::RAND::get_tests() {
                tests.push((n, "rand", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("rcpc3") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::rcpc3::RCPC3::get_tests() {
                tests.push((n, "rcpc3", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("rdm") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::rdm::RDM::get_tests() {
                tests.push((n, "rdm", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("sha3") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::sha3::SHA3::get_tests() {
                tests.push((n, "sha3", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("sm4") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::sm4::SM4::get_tests() {
                tests.push((n, "sm4", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("sve") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::sve::SVE::get_tests() {
                tests.push((n, "sve", f));
            }
        }

        if std::arch::is_aarch64_feature_detected!("sve2") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::sve2::SVE2::get_tests() {
                tests.push((n, "sve2", f));
            }
        }

    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("aes") {
            for &(f, n) in crate::cpu::auto_generated::arm::aes::AES::get_tests() {
                tests.push((n, "aes", f));
            }
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
        if detect_arm_shared_aes() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::aes::AES::get_tests() {
                tests.push((n, "aes", f));
            }
        }

        if detect_arm_shared_bf16() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::bf16::BF16::get_tests() {
                tests.push((n, "bf16", f));
            }
        }

        if detect_arm_shared_crc() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::crc::CRC::get_tests() {
                tests.push((n, "crc", f));
            }
        }

        if detect_arm_shared_dotprod() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::dotprod::DOTPROD::get_tests() {
                tests.push((n, "dotprod", f));
            }
        }

        if detect_arm_shared_fp16() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::fp16::FP16::get_tests() {
                tests.push((n, "fp16", f));
            }
        }

        if detect_arm_shared_fp_armv8() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::fp_armv8::FP_ARMV8::get_tests() {
                tests.push((n, "fp_armv8", f));
            }
        }

        if detect_arm_shared_i8mm() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::i8mm::I8MM::get_tests() {
                tests.push((n, "i8mm", f));
            }
        }

        if detect_arm_shared_neon() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::neon::NEON::get_tests() {
                tests.push((n, "neon", f));
            }
        }

        if detect_arm_shared_sha2() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::sha2::SHA2::get_tests() {
                tests.push((n, "sha2", f));
            }
        }

        if detect_arm_shared_vfp4() {
            for &(f, n) in crate::cpu::auto_generated::arm_shared::vfp4::VFP4::get_tests() {
                tests.push((n, "vfp4", f));
            }
        }

    }

    #[cfg(target_arch = "loongarch64")]
    {
        if false /* feature detection not yet implemented */ {
            for &(f, n) in crate::cpu::auto_generated::loongarch64::lasx::LASX::get_tests() {
                tests.push((n, "lasx", f));
            }
        }

        if false /* feature detection not yet implemented */ {
            for &(f, n) in crate::cpu::auto_generated::loongarch64::lsx::LSX::get_tests() {
                tests.push((n, "lsx", f));
            }
        }

    }

    #[cfg(target_arch = "mips")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::mips::msa::MSA::get_tests() {
                tests.push((n, "msa", f));
            }
        }

    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::nvptx::packed::PACKED::get_tests() {
                tests.push((n, "packed", f));
            }
        }

    }

    #[cfg(target_arch = "powerpc")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_tests() {
                tests.push((n, "altivec", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::powerpc::vsx::VSX::get_tests() {
                tests.push((n, "vsx", f));
            }
        }

    }

    #[cfg(target_arch = "powerpc64")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::powerpc64::vsx::VSX::get_tests() {
                tests.push((n, "vsx", f));
            }
        }

    }

    #[cfg(target_arch = "riscv32")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::riscv32::zb::ZB::get_tests() {
                tests.push((n, "zb", f));
            }
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            for &(f, n) in crate::cpu::auto_generated::riscv32::zk::ZK::get_tests() {
                tests.push((n, "zk", f));
            }
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::riscv64::zb::ZB::get_tests() {
                tests.push((n, "zb", f));
            }
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            for &(f, n) in crate::cpu::auto_generated::riscv64::zk::ZK::get_tests() {
                tests.push((n, "zk", f));
            }
        }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        if std::arch::is_riscv_feature_detected!("p") {
            for &(f, n) in crate::cpu::auto_generated::riscv_shared::p::P::get_tests() {
                tests.push((n, "p", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::riscv_shared::zb::ZB::get_tests() {
                tests.push((n, "zb", f));
            }
        }

        if std::arch::is_riscv_feature_detected!("zk") {
            for &(f, n) in crate::cpu::auto_generated::riscv_shared::zk::ZK::get_tests() {
                tests.push((n, "zk", f));
            }
        }

    }

    #[cfg(target_arch = "s390x")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::s390x::vector::VECTOR::get_tests() {
                tests.push((n, "vector", f));
            }
        }

    }

    #[cfg(target_arch = "wasm32")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_tests() {
                tests.push((n, "atomic", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::wasm32::memory::MEMORY::get_tests() {
                tests.push((n, "memory", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_tests() {
                tests.push((n, "relaxed_simd", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_tests() {
                tests.push((n, "simd128", f));
            }
        }

    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::abm::ABM::get_tests() {
                tests.push((n, "abm", f));
            }
        }

        if std::arch::is_x86_feature_detected!("adx") {
            for &(f, n) in crate::cpu::auto_generated::x86::adx::ADX::get_tests() {
                tests.push((n, "adx", f));
            }
        }

        if std::arch::is_x86_feature_detected!("aes") {
            for &(f, n) in crate::cpu::auto_generated::x86::aes::AES::get_tests() {
                tests.push((n, "aes", f));
            }
        }

        if std::arch::is_x86_feature_detected!("avx") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx::AVX::get_tests() {
                tests.push((n, "avx", f));
            }
        }

        if std::arch::is_x86_feature_detected!("avx2") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx2::AVX2::get_tests() {
                tests.push((n, "avx2", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests() {
                tests.push((n, "avx512bf16", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests() {
                tests.push((n, "avx512bitalg", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests() {
                tests.push((n, "avx512bw", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests() {
                tests.push((n, "avx512cd", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests() {
                tests.push((n, "avx512dq", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests() {
                tests.push((n, "avx512f", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests() {
                tests.push((n, "avx512fp16", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests() {
                tests.push((n, "avx512ifma", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests() {
                tests.push((n, "avx512vbmi", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests() {
                tests.push((n, "avx512vbmi2", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests() {
                tests.push((n, "avx512vnni", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests() {
                tests.push((n, "avx512vpopcntdq", f));
            }
        }

        if std::arch::is_x86_feature_detected!("avxneconvert") {
            for &(f, n) in crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests() {
                tests.push((n, "avxneconvert", f));
            }
        }

        if std::arch::is_x86_feature_detected!("bmi1") {
            for &(f, n) in crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests() {
                tests.push((n, "bmi1", f));
            }
        }

        if std::arch::is_x86_feature_detected!("bmi2") {
            for &(f, n) in crate::cpu::auto_generated::x86::bmi2::BMI2::get_tests() {
                tests.push((n, "bmi2", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::bswap::BSWAP::get_tests() {
                tests.push((n, "bswap", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::bt::BT::get_tests() {
                tests.push((n, "bt", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::cpuid::CPUID::get_tests() {
                tests.push((n, "cpuid", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::eflags::EFLAGS::get_tests() {
                tests.push((n, "eflags", f));
            }
        }

        if std::arch::is_x86_feature_detected!("f16c") {
            for &(f, n) in crate::cpu::auto_generated::x86::f16c::F16C::get_tests() {
                tests.push((n, "f16c", f));
            }
        }

        if std::arch::is_x86_feature_detected!("fma") {
            for &(f, n) in crate::cpu::auto_generated::x86::fma::FMA::get_tests() {
                tests.push((n, "fma", f));
            }
        }

        if std::arch::is_x86_feature_detected!("fxsr") {
            for &(f, n) in crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests() {
                tests.push((n, "fxsr", f));
            }
        }

        if std::arch::is_x86_feature_detected!("gfni") {
            for &(f, n) in crate::cpu::auto_generated::x86::gfni::GFNI::get_tests() {
                tests.push((n, "gfni", f));
            }
        }

        if crate::cpu::common::x86::keylocker_usable() {
            for &(f, n) in crate::cpu::auto_generated::x86::kl::KL::get_tests() {
                tests.push((n, "kl", f));
            }
        }

        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests() {
                tests.push((n, "pclmulqdq", f));
            }
        }

        if std::arch::is_x86_feature_detected!("rdrand") {
            for &(f, n) in crate::cpu::auto_generated::x86::rdrand::RDRAND::get_tests() {
                tests.push((n, "rdrand", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_tests() {
                tests.push((n, "rdtsc", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sha") {
            for &(f, n) in crate::cpu::auto_generated::x86::sha::SHA::get_tests() {
                tests.push((n, "sha", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse::SSE::get_tests() {
                tests.push((n, "sse", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse2") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse2::SSE2::get_tests() {
                tests.push((n, "sse2", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse3") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse3::SSE3::get_tests() {
                tests.push((n, "sse3", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse4.1") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse41::SSE41::get_tests() {
                tests.push((n, "sse41", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse4.2") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse42::SSE42::get_tests() {
                tests.push((n, "sse42", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse4a") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests() {
                tests.push((n, "sse4a", f));
            }
        }

        if std::arch::is_x86_feature_detected!("ssse3") {
            for &(f, n) in crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests() {
                tests.push((n, "ssse3", f));
            }
        }

        if std::arch::is_x86_feature_detected!("tbm") {
            for &(f, n) in crate::cpu::auto_generated::x86::tbm::TBM::get_tests() {
                tests.push((n, "tbm", f));
            }
        }

        if std::arch::is_x86_feature_detected!("vaes") {
            for &(f, n) in crate::cpu::auto_generated::x86::vaes::VAES::get_tests() {
                tests.push((n, "vaes", f));
            }
        }

        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests() {
                tests.push((n, "vpclmulqdq", f));
            }
        }

        if std::arch::is_x86_feature_detected!("xsave") {
            for &(f, n) in crate::cpu::auto_generated::x86::xsave::XSAVE::get_tests() {
                tests.push((n, "xsave", f));
            }
        }

    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86_64::abm::ABM::get_tests() {
                tests.push((n, "abm", f));
            }
        }

        if std::arch::is_x86_feature_detected!("adx") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::adx::ADX::get_tests() {
                tests.push((n, "adx", f));
            }
        }

        if std::arch::is_x86_feature_detected!("avx") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx::AVX::get_tests() {
                tests.push((n, "avx", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests() {
                tests.push((n, "avx512bw", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests() {
                tests.push((n, "avx512f", f));
            }
        }

        #[cfg(feature = "avx512")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests() {
                tests.push((n, "avx512fp16", f));
            }
        }

        if std::arch::is_x86_feature_detected!("bmi1") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests() {
                tests.push((n, "bmi", f));
            }
        }

        if std::arch::is_x86_feature_detected!("bmi2") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_tests() {
                tests.push((n, "bmi2", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_tests() {
                tests.push((n, "bswap", f));
            }
        }

        if false /* no runtime detection available */ {
            for &(f, n) in crate::cpu::auto_generated::x86_64::bt::BT::get_tests() {
                tests.push((n, "bt", f));
            }
        }

        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests() {
                tests.push((n, "cmpxchg16b", f));
            }
        }

        if std::arch::is_x86_feature_detected!("fxsr") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests() {
                tests.push((n, "fxsr", f));
            }
        }

        if std::arch::is_x86_feature_detected!("rdrand") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests() {
                tests.push((n, "rdrand", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse::SSE::get_tests() {
                tests.push((n, "sse", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse2") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests() {
                tests.push((n, "sse2", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse4.1") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests() {
                tests.push((n, "sse41", f));
            }
        }

        if std::arch::is_x86_feature_detected!("sse4.2") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests() {
                tests.push((n, "sse42", f));
            }
        }

        if std::arch::is_x86_feature_detected!("tbm") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests() {
                tests.push((n, "tbm", f));
            }
        }

        if std::arch::is_x86_feature_detected!("xsave") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests() {
                tests.push((n, "xsave", f));
            }
        }

    }

    tests
}
