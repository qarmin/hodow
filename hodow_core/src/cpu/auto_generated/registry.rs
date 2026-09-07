#![allow(unused_imports)]
#![allow(unreachable_code)]

use crate::cpu::{ExtensionTest, FeatureStats, TestStatistics, ProgressCallback, TestFunction};
use crate::cpu::{reset_stop_flag, should_stop, should_skip_feature};

/// Count how many CPU features/extensions are available on this machine
pub fn count_available_features() -> usize {
    let mut count = 0;

    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("mte") {
            count += 1;
        }

        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("neon") {
            count += 1;
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
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
        if std::arch::is_riscv_feature_detected!("zk") {
            count += 1;
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
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

        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            count += 1;
        }

        #[cfg(target_feature = "aes")]
        if std::arch::is_x86_feature_detected!("aes") {
            count += 1;
        }

        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            count += 1;
        }

        #[cfg(target_feature = "avx2")]
        if std::arch::is_x86_feature_detected!("avx2") {
            count += 1;
        }

        #[cfg(target_feature = "avx512bf16")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            count += 1;
        }

        #[cfg(target_feature = "avx512bitalg")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            count += 1;
        }

        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            count += 1;
        }

        #[cfg(target_feature = "avx512cd")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            count += 1;
        }

        #[cfg(target_feature = "avx512dq")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            count += 1;
        }

        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            count += 1;
        }

        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            count += 1;
        }

        #[cfg(target_feature = "avx512ifma")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            count += 1;
        }

        #[cfg(target_feature = "avx512vbmi")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            count += 1;
        }

        #[cfg(target_feature = "avx512vbmi2")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            count += 1;
        }

        #[cfg(target_feature = "avx512vnni")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            count += 1;
        }

        #[cfg(target_feature = "avx512vpopcntdq")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            count += 1;
        }

        #[cfg(target_feature = "avxneconvert")]
        if std::arch::is_x86_feature_detected!("avxneconvert") {
            count += 1;
        }

        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            count += 1;
        }

        #[cfg(target_feature = "bmi2")]
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

        #[cfg(target_feature = "f16c")]
        if std::arch::is_x86_feature_detected!("f16c") {
            count += 1;
        }

        #[cfg(target_feature = "fma")]
        if std::arch::is_x86_feature_detected!("fma") {
            count += 1;
        }

        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            count += 1;
        }

        #[cfg(target_feature = "gfni")]
        if std::arch::is_x86_feature_detected!("gfni") {
            count += 1;
        }

        #[cfg(target_feature = "kl")]
        if std::arch::is_x86_feature_detected!("kl") {
            count += 1;
        }

        #[cfg(target_feature = "pclmulqdq")]
        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            count += 1;
        }

        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        #[cfg(target_feature = "rtm")]
        if std::arch::is_x86_feature_detected!("rtm") {
            count += 1;
        }

        #[cfg(target_feature = "sha")]
        if std::arch::is_x86_feature_detected!("sha") {
            count += 1;
        }

        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            count += 1;
        }

        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            count += 1;
        }

        #[cfg(target_feature = "sse3")]
        if std::arch::is_x86_feature_detected!("sse3") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            count += 1;
        }

        #[cfg(target_feature = "sse4a")]
        if std::arch::is_x86_feature_detected!("sse4a") {
            count += 1;
        }

        #[cfg(target_feature = "ssse3")]
        if std::arch::is_x86_feature_detected!("ssse3") {
            count += 1;
        }

        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            count += 1;
        }

        #[cfg(target_feature = "vaes")]
        if std::arch::is_x86_feature_detected!("vaes") {
            count += 1;
        }

        #[cfg(target_feature = "vpclmulqdq")]
        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            count += 1;
        }

        #[cfg(target_feature = "xsave")]
        if std::arch::is_x86_feature_detected!("xsave") {
            count += 1;
        }

    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            count += 1;
        }

        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            count += 1;
        }

        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            count += 1;
        }

        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            count += 1;
        }

        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            count += 1;
        }

        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            count += 1;
        }

        #[cfg(target_feature = "bmi2")]
        if std::arch::is_x86_feature_detected!("bmi2") {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

        #[cfg(target_feature = "cmpxchg16b")]
        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            count += 1;
        }

        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            count += 1;
        }

        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            count += 1;
        }

        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            count += 1;
        }

        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            count += 1;
        }

        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            count += 1;
        }

        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            count += 1;
        }

        #[cfg(target_feature = "xsave")]
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
        if std::arch::is_aarch64_feature_detected!("mte") {
            modes.insert(format!("{}:{}", "aarch64", "mte"));
        }
        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            modes.insert(format!("{}:{}", "aarch64", "prefetch"));
        }
    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("neon") {
            modes.insert(format!("{}:{}", "arm", "neon"));
        }
    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
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
        if std::arch::is_riscv_feature_detected!("zk") {
            modes.insert(format!("{}:{}", "riscv32", "zk"));
        }
    }

    #[cfg(target_arch = "riscv64")]
    {
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
        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            modes.insert(format!("{}:{}", "x86", "adx"));
        }
        #[cfg(target_feature = "aes")]
        if std::arch::is_x86_feature_detected!("aes") {
            modes.insert(format!("{}:{}", "x86", "aes"));
        }
        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            modes.insert(format!("{}:{}", "x86", "avx"));
        }
        #[cfg(target_feature = "avx2")]
        if std::arch::is_x86_feature_detected!("avx2") {
            modes.insert(format!("{}:{}", "x86", "avx2"));
        }
        #[cfg(target_feature = "avx512bf16")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            modes.insert(format!("{}:{}", "x86", "avx512bf16"));
        }
        #[cfg(target_feature = "avx512bitalg")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            modes.insert(format!("{}:{}", "x86", "avx512bitalg"));
        }
        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.insert(format!("{}:{}", "x86", "avx512bw"));
        }
        #[cfg(target_feature = "avx512cd")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            modes.insert(format!("{}:{}", "x86", "avx512cd"));
        }
        #[cfg(target_feature = "avx512dq")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            modes.insert(format!("{}:{}", "x86", "avx512dq"));
        }
        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.insert(format!("{}:{}", "x86", "avx512f"));
        }
        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.insert(format!("{}:{}", "x86", "avx512fp16"));
        }
        #[cfg(target_feature = "avx512ifma")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            modes.insert(format!("{}:{}", "x86", "avx512ifma"));
        }
        #[cfg(target_feature = "avx512vbmi")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            modes.insert(format!("{}:{}", "x86", "avx512vbmi"));
        }
        #[cfg(target_feature = "avx512vbmi2")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            modes.insert(format!("{}:{}", "x86", "avx512vbmi2"));
        }
        #[cfg(target_feature = "avx512vnni")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            modes.insert(format!("{}:{}", "x86", "avx512vnni"));
        }
        #[cfg(target_feature = "avx512vpopcntdq")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            modes.insert(format!("{}:{}", "x86", "avx512vpopcntdq"));
        }
        #[cfg(target_feature = "avxneconvert")]
        if std::arch::is_x86_feature_detected!("avxneconvert") {
            modes.insert(format!("{}:{}", "x86", "avxneconvert"));
        }
        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.insert(format!("{}:{}", "x86", "bmi1"));
        }
        #[cfg(target_feature = "bmi2")]
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
        #[cfg(target_feature = "f16c")]
        if std::arch::is_x86_feature_detected!("f16c") {
            modes.insert(format!("{}:{}", "x86", "f16c"));
        }
        #[cfg(target_feature = "fma")]
        if std::arch::is_x86_feature_detected!("fma") {
            modes.insert(format!("{}:{}", "x86", "fma"));
        }
        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.insert(format!("{}:{}", "x86", "fxsr"));
        }
        #[cfg(target_feature = "gfni")]
        if std::arch::is_x86_feature_detected!("gfni") {
            modes.insert(format!("{}:{}", "x86", "gfni"));
        }
        #[cfg(target_feature = "kl")]
        if std::arch::is_x86_feature_detected!("kl") {
            modes.insert(format!("{}:{}", "x86", "kl"));
        }
        #[cfg(target_feature = "pclmulqdq")]
        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            modes.insert(format!("{}:{}", "x86", "pclmulqdq"));
        }
        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.insert(format!("{}:{}", "x86", "rdrand"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86", "rdtsc"));
        }
        #[cfg(target_feature = "rtm")]
        if std::arch::is_x86_feature_detected!("rtm") {
            modes.insert(format!("{}:{}", "x86", "rtm"));
        }
        #[cfg(target_feature = "sha")]
        if std::arch::is_x86_feature_detected!("sha") {
            modes.insert(format!("{}:{}", "x86", "sha"));
        }
        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            modes.insert(format!("{}:{}", "x86", "sse"));
        }
        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.insert(format!("{}:{}", "x86", "sse2"));
        }
        #[cfg(target_feature = "sse3")]
        if std::arch::is_x86_feature_detected!("sse3") {
            modes.insert(format!("{}:{}", "x86", "sse3"));
        }
        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.insert(format!("{}:{}", "x86", "sse4.1"));
        }
        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.insert(format!("{}:{}", "x86", "sse4.2"));
        }
        #[cfg(target_feature = "sse4a")]
        if std::arch::is_x86_feature_detected!("sse4a") {
            modes.insert(format!("{}:{}", "x86", "sse4a"));
        }
        #[cfg(target_feature = "ssse3")]
        if std::arch::is_x86_feature_detected!("ssse3") {
            modes.insert(format!("{}:{}", "x86", "ssse3"));
        }
        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.insert(format!("{}:{}", "x86", "tbm"));
        }
        #[cfg(target_feature = "vaes")]
        if std::arch::is_x86_feature_detected!("vaes") {
            modes.insert(format!("{}:{}", "x86", "vaes"));
        }
        #[cfg(target_feature = "vpclmulqdq")]
        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            modes.insert(format!("{}:{}", "x86", "vpclmulqdq"));
        }
        #[cfg(target_feature = "xsave")]
        if std::arch::is_x86_feature_detected!("xsave") {
            modes.insert(format!("{}:{}", "x86", "xsave"));
        }
    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "abm"));
        }
        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            modes.insert(format!("{}:{}", "x86_64", "adx"));
        }
        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            modes.insert(format!("{}:{}", "x86_64", "avx"));
        }
        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.insert(format!("{}:{}", "x86_64", "avx512bw"));
        }
        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.insert(format!("{}:{}", "x86_64", "avx512f"));
        }
        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.insert(format!("{}:{}", "x86_64", "avx512fp16"));
        }
        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.insert(format!("{}:{}", "x86_64", "bmi1"));
        }
        #[cfg(target_feature = "bmi2")]
        if std::arch::is_x86_feature_detected!("bmi2") {
            modes.insert(format!("{}:{}", "x86_64", "bmi2"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "bswap"));
        }
        if false /* no runtime detection available */ {
            modes.insert(format!("{}:{}", "x86_64", "bt"));
        }
        #[cfg(target_feature = "cmpxchg16b")]
        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            modes.insert(format!("{}:{}", "x86_64", "cmpxchg16b"));
        }
        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.insert(format!("{}:{}", "x86_64", "fxsr"));
        }
        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.insert(format!("{}:{}", "x86_64", "rdrand"));
        }
        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            modes.insert(format!("{}:{}", "x86_64", "sse"));
        }
        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.insert(format!("{}:{}", "x86_64", "sse2"));
        }
        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.insert(format!("{}:{}", "x86_64", "sse4.1"));
        }
        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.insert(format!("{}:{}", "x86_64", "sse4.2"));
        }
        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.insert(format!("{}:{}", "x86_64", "tbm"));
        }
        #[cfg(target_feature = "xsave")]
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
            if std::arch::is_aarch64_feature_detected!("mte") && !should_skip_feature("mte") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::aarch64::mte::MTE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::mte::MTE::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::aarch64::mte::MTE::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ && !should_skip_feature("prefetch") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "arm")]
    {
            if std::arch::is_arm_feature_detected!("neon") && !should_skip_feature("neon") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::arm::neon::NEON::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::arm::neon::NEON::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::arm::neon::NEON::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
    }

    #[cfg(target_arch = "mips")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("msa") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::mips::msa::MSA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::mips::msa::MSA::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::mips::msa::MSA::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    // nvptx is not a standard rust target_arch, so this is always compiled
    {
            if false /* no runtime detection available */ && !should_skip_feature("packed") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::nvptx::packed::PACKED::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::nvptx::packed::PACKED::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::nvptx::packed::PACKED::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "powerpc")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("altivec") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::powerpc::altivec::ALTIVEC::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("vsx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::powerpc::vsx::VSX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc::vsx::VSX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::powerpc::vsx::VSX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "powerpc64")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("vsx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::powerpc64::vsx::VSX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::powerpc64::vsx::VSX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::powerpc64::vsx::VSX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "riscv32")]
    {
            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::riscv32::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv32::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::riscv32::zk::ZK::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "riscv64")]
    {
            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::riscv64::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv64::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::riscv64::zk::ZK::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
            if std::arch::is_riscv_feature_detected!("p") && !should_skip_feature("p") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::riscv_shared::p::P::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::p::P::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::riscv_shared::p::P::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("zb") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::riscv_shared::zb::ZB::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::zb::ZB::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::riscv_shared::zb::ZB::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if std::arch::is_riscv_feature_detected!("zk") && !should_skip_feature("zk") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::riscv_shared::zk::ZK::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::riscv_shared::zk::ZK::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::riscv_shared::zk::ZK::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "s390x")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("vector") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::s390x::vector::VECTOR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::s390x::vector::VECTOR::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::s390x::vector::VECTOR::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(target_arch = "wasm32")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("atomic") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::wasm32::atomic::ATOMIC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::wasm32::atomic::ATOMIC::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("memory") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::wasm32::memory::MEMORY::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::memory::MEMORY::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::wasm32::memory::MEMORY::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("relaxed_simd") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::wasm32::relaxed_simd::RELAXED_SIMD::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("simd128") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::wasm32::simd128::SIMD128::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::wasm32::simd128::SIMD128::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
            if false /* no runtime detection available */ && !should_skip_feature("abm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::abm::ABM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::abm::ABM::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::abm::ABM::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

        #[cfg(target_feature = "adx")]
        {
            if std::arch::is_x86_feature_detected!("adx") && !should_skip_feature("adx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::adx::ADX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::adx::ADX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::adx::ADX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "aes")]
        {
            if std::arch::is_x86_feature_detected!("aes") && !should_skip_feature("aes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::aes::AES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::aes::AES::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::aes::AES::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx")]
        {
            if std::arch::is_x86_feature_detected!("avx") && !should_skip_feature("avx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx::AVX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx::AVX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx::AVX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx2")]
        {
            if std::arch::is_x86_feature_detected!("avx2") && !should_skip_feature("avx2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx2::AVX2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx2::AVX2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx2::AVX2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512bf16")]
        {
            if std::arch::is_x86_feature_detected!("avx512bf16") && !should_skip_feature("avx512bf16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        {
            if std::arch::is_x86_feature_detected!("avx512bitalg") && !should_skip_feature("avx512bitalg") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512bw")]
        {
            if std::arch::is_x86_feature_detected!("avx512bw") && !should_skip_feature("avx512bw") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512bw::AVX512BW::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512cd")]
        {
            if std::arch::is_x86_feature_detected!("avx512cd") && !should_skip_feature("avx512cd") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512cd::AVX512CD::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512dq")]
        {
            if std::arch::is_x86_feature_detected!("avx512dq") && !should_skip_feature("avx512dq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            if std::arch::is_x86_feature_detected!("avx512f") && !should_skip_feature("avx512f") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512f::AVX512F::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512f::AVX512F::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        {
            if std::arch::is_x86_feature_detected!("avx512fp16") && !should_skip_feature("avx512fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        {
            if std::arch::is_x86_feature_detected!("avx512ifma") && !should_skip_feature("avx512ifma") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        {
            if std::arch::is_x86_feature_detected!("avx512vbmi") && !should_skip_feature("avx512vbmi") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512vbmi2")]
        {
            if std::arch::is_x86_feature_detected!("avx512vbmi2") && !should_skip_feature("avx512vbmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512vnni")]
        {
            if std::arch::is_x86_feature_detected!("avx512vnni") && !should_skip_feature("avx512vnni") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512vpopcntdq")]
        {
            if std::arch::is_x86_feature_detected!("avx512vpopcntdq") && !should_skip_feature("avx512vpopcntdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avxneconvert")]
        {
            if std::arch::is_x86_feature_detected!("avxneconvert") && !should_skip_feature("avxneconvert") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "bmi1")]
        {
            if std::arch::is_x86_feature_detected!("bmi1") && !should_skip_feature("bmi1") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::bmi1::BMI1::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::bmi1::BMI1::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "bmi2")]
        {
            if std::arch::is_x86_feature_detected!("bmi2") && !should_skip_feature("bmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::bmi2::BMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bmi2::BMI2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::bmi2::BMI2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

            if false /* no runtime detection available */ && !should_skip_feature("bswap") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::bswap::BSWAP::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bswap::BSWAP::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::bswap::BSWAP::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bt") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::bt::BT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::bt::BT::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::bt::BT::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("cpuid") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::cpuid::CPUID::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::cpuid::CPUID::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::cpuid::CPUID::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("eflags") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::eflags::EFLAGS::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::eflags::EFLAGS::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::eflags::EFLAGS::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

        #[cfg(target_feature = "f16c")]
        {
            if std::arch::is_x86_feature_detected!("f16c") && !should_skip_feature("f16c") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::f16c::F16C::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::f16c::F16C::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::f16c::F16C::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "fma")]
        {
            if std::arch::is_x86_feature_detected!("fma") && !should_skip_feature("fma") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::fma::FMA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::fma::FMA::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::fma::FMA::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "fxsr")]
        {
            if std::arch::is_x86_feature_detected!("fxsr") && !should_skip_feature("fxsr") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::fxsr::FXSR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::fxsr::FXSR::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "gfni")]
        {
            if std::arch::is_x86_feature_detected!("gfni") && !should_skip_feature("gfni") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::gfni::GFNI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::gfni::GFNI::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::gfni::GFNI::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "kl")]
        {
            if std::arch::is_x86_feature_detected!("kl") && !should_skip_feature("kl") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::kl::KL::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::kl::KL::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::kl::KL::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "pclmulqdq")]
        {
            if std::arch::is_x86_feature_detected!("pclmulqdq") && !should_skip_feature("pclmulqdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "rdrand")]
        {
            if std::arch::is_x86_feature_detected!("rdrand") && !should_skip_feature("rdrand") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::rdrand::RDRAND::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::rdrand::RDRAND::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::rdrand::RDRAND::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

            if false /* no runtime detection available */ && !should_skip_feature("rdtsc") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::rdtsc::RDTSC::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::rdtsc::RDTSC::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

        #[cfg(target_feature = "rtm")]
        {
            if std::arch::is_x86_feature_detected!("rtm") && !should_skip_feature("rtm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::rtm::RTM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::rtm::RTM::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::rtm::RTM::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sha")]
        {
            if std::arch::is_x86_feature_detected!("sha") && !should_skip_feature("sha") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sha::SHA::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sha::SHA::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sha::SHA::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse")]
        {
            if std::arch::is_x86_feature_detected!("sse") && !should_skip_feature("sse") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse::SSE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse::SSE::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse::SSE::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            if std::arch::is_x86_feature_detected!("sse2") && !should_skip_feature("sse2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse2::SSE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse2::SSE2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse2::SSE2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse3")]
        {
            if std::arch::is_x86_feature_detected!("sse3") && !should_skip_feature("sse3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse3::SSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse3::SSE3::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse3::SSE3::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            if std::arch::is_x86_feature_detected!("sse4.1") && !should_skip_feature("sse41") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse41::SSE41::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse41::SSE41::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse41::SSE41::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            if std::arch::is_x86_feature_detected!("sse4.2") && !should_skip_feature("sse42") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse42::SSE42::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse42::SSE42::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse42::SSE42::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4a")]
        {
            if std::arch::is_x86_feature_detected!("sse4a") && !should_skip_feature("sse4a") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::sse4a::SSE4A::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::sse4a::SSE4A::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "ssse3")]
        {
            if std::arch::is_x86_feature_detected!("ssse3") && !should_skip_feature("ssse3") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::ssse3::SSSE3::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::ssse3::SSSE3::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "tbm")]
        {
            if std::arch::is_x86_feature_detected!("tbm") && !should_skip_feature("tbm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::tbm::TBM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::tbm::TBM::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::tbm::TBM::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "vaes")]
        {
            if std::arch::is_x86_feature_detected!("vaes") && !should_skip_feature("vaes") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::vaes::VAES::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::vaes::VAES::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::vaes::VAES::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "vpclmulqdq")]
        {
            if std::arch::is_x86_feature_detected!("vpclmulqdq") && !should_skip_feature("vpclmulqdq") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "xsave")]
        {
            if std::arch::is_x86_feature_detected!("xsave") && !should_skip_feature("xsave") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86::xsave::XSAVE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86::xsave::XSAVE::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86::xsave::XSAVE::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

    }

    #[cfg(target_arch = "x86_64")]
    {
            if false /* no runtime detection available */ && !should_skip_feature("abm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::abm::ABM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::abm::ABM::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::abm::ABM::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

        #[cfg(target_feature = "adx")]
        {
            if std::arch::is_x86_feature_detected!("adx") && !should_skip_feature("adx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::adx::ADX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::adx::ADX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::adx::ADX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx")]
        {
            if std::arch::is_x86_feature_detected!("avx") && !should_skip_feature("avx") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::avx::AVX::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx::AVX::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::avx::AVX::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512bw")]
        {
            if std::arch::is_x86_feature_detected!("avx512bw") && !should_skip_feature("avx512bw") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            if std::arch::is_x86_feature_detected!("avx512f") && !should_skip_feature("avx512f") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::avx512f::AVX512F::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        {
            if std::arch::is_x86_feature_detected!("avx512fp16") && !should_skip_feature("avx512fp16") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "bmi1")]
        {
            if std::arch::is_x86_feature_detected!("bmi1") && !should_skip_feature("bmi") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::bmi::BMI::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::bmi::BMI::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "bmi2")]
        {
            if std::arch::is_x86_feature_detected!("bmi2") && !should_skip_feature("bmi2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::bmi2::BMI2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::bmi2::BMI2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

            if false /* no runtime detection available */ && !should_skip_feature("bswap") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::bswap::BSWAP::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::bswap::BSWAP::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

            if false /* no runtime detection available */ && !should_skip_feature("bt") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::bt::BT::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::bt::BT::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::bt::BT::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }

        #[cfg(target_feature = "cmpxchg16b")]
        {
            if std::arch::is_x86_feature_detected!("cmpxchg16b") && !should_skip_feature("cmpxchg16b") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "fxsr")]
        {
            if std::arch::is_x86_feature_detected!("fxsr") && !should_skip_feature("fxsr") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::fxsr::FXSR::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "rdrand")]
        {
            if std::arch::is_x86_feature_detected!("rdrand") && !should_skip_feature("rdrand") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::rdrand::RDRAND::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse")]
        {
            if std::arch::is_x86_feature_detected!("sse") && !should_skip_feature("sse") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::sse::SSE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse::SSE::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::sse::SSE::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            if std::arch::is_x86_feature_detected!("sse2") && !should_skip_feature("sse2") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::sse2::SSE2::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::sse2::SSE2::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            if std::arch::is_x86_feature_detected!("sse4.1") && !should_skip_feature("sse41") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::sse41::SSE41::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::sse41::SSE41::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            if std::arch::is_x86_feature_detected!("sse4.2") && !should_skip_feature("sse42") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::sse42::SSE42::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::sse42::SSE42::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "tbm")]
        {
            if std::arch::is_x86_feature_detected!("tbm") && !should_skip_feature("tbm") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::tbm::TBM::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::tbm::TBM::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
        }

        #[cfg(target_feature = "xsave")]
        {
            if std::arch::is_x86_feature_detected!("xsave") && !should_skip_feature("xsave") {
                    if should_stop() {
                        return Ok(TestStatistics { features, was_cancelled: true });
                    }
                    let (r, s, e) = crate::cpu::auto_generated::x86_64::xsave::XSAVE::test_with_progress(
                    total_features,
                    completed_features,
                    crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests().len(),
                    progress_callback,
                    )?;
                    features.push(FeatureStats {
                        feature_name: crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_name(),
                        tests_run: r,
                        tests_skipped: s,
                        tests_errored: e,
                    });
                    completed_features += 1;
            }
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
            for (_, name) in crate::cpu::auto_generated::aarch64::mte::MTE::get_tests() {
                functions.push(name.to_string());
            }
        }

        {
            for (_, name) in crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "arm")]
    {
        {
            for (_, name) in crate::cpu::auto_generated::arm::neon::NEON::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
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
            for (_, name) in crate::cpu::auto_generated::riscv32::zk::ZK::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
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

        #[cfg(target_feature = "adx")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::adx::ADX::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "aes")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::aes::AES::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx::AVX::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx2::AVX2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512bf16")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512bw")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512cd")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512dq")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512vbmi2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512vnni")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512vpopcntdq")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avxneconvert")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "bmi1")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "bmi2")]
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

        #[cfg(target_feature = "f16c")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::f16c::F16C::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "fma")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::fma::FMA::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "fxsr")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "gfni")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::gfni::GFNI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "kl")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::kl::KL::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "pclmulqdq")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "rdrand")]
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

        #[cfg(target_feature = "rtm")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::rtm::RTM::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sha")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sha::SHA::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse::SSE::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse2::SSE2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse3")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse3::SSE3::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse41::SSE41::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse42::SSE42::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse4a")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "ssse3")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "tbm")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::tbm::TBM::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "vaes")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::vaes::VAES::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "vpclmulqdq")]
        {
            for (_, name) in crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "xsave")]
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

        #[cfg(target_feature = "adx")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::adx::ADX::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx::AVX::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512bw")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512f")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "bmi1")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "bmi2")]
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

        #[cfg(target_feature = "cmpxchg16b")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "fxsr")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "rdrand")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse::SSE::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse4.1")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "sse4.2")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "tbm")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests() {
                functions.push(name.to_string());
            }
        }

        #[cfg(target_feature = "xsave")]
        {
            for (_, name) in crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests() {
                functions.push(name.to_string());
            }
        }

    }

    functions
}

/// Flat list of (test_name, feature, test_fn) for every feature detected at runtime
/// on this machine, in the canonical execution order. Used by the isolated subprocess
/// runner (so a crashing/hanging test can be attributed and skipped instead of
/// aborting the run) and by the stress runner. `feature` is the extension name (e.g.
/// "sse2", "avx2") a caller can filter on without re-detecting it per test.
pub fn all_tests() -> Vec<(&'static str, &'static str, &'static TestFunction)> {
    let mut tests: Vec<(&'static str, &'static str, &'static TestFunction)> = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
        if std::arch::is_aarch64_feature_detected!("mte") {
            for &(f, n) in crate::cpu::auto_generated::aarch64::mte::MTE::get_tests() {
                tests.push((n, "mte", f));
            }
        }

        if true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */ {
            for &(f, n) in crate::cpu::auto_generated::aarch64::prefetch::PREFETCH::get_tests() {
                tests.push((n, "prefetch", f));
            }
        }

    }

    #[cfg(target_arch = "arm")]
    {
        if std::arch::is_arm_feature_detected!("neon") {
            for &(f, n) in crate::cpu::auto_generated::arm::neon::NEON::get_tests() {
                tests.push((n, "neon", f));
            }
        }

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
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
        if std::arch::is_riscv_feature_detected!("zk") {
            for &(f, n) in crate::cpu::auto_generated::riscv32::zk::ZK::get_tests() {
                tests.push((n, "zk", f));
            }
        }

    }

    #[cfg(target_arch = "riscv64")]
    {
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

        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            for &(f, n) in crate::cpu::auto_generated::x86::adx::ADX::get_tests() {
                tests.push((n, "adx", f));
            }
        }

        #[cfg(target_feature = "aes")]
        if std::arch::is_x86_feature_detected!("aes") {
            for &(f, n) in crate::cpu::auto_generated::x86::aes::AES::get_tests() {
                tests.push((n, "aes", f));
            }
        }

        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx::AVX::get_tests() {
                tests.push((n, "avx", f));
            }
        }

        #[cfg(target_feature = "avx2")]
        if std::arch::is_x86_feature_detected!("avx2") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx2::AVX2::get_tests() {
                tests.push((n, "avx2", f));
            }
        }

        #[cfg(target_feature = "avx512bf16")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bf16::AVX512BF16::get_tests() {
                tests.push((n, "avx512bf16", f));
            }
        }

        #[cfg(target_feature = "avx512bitalg")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bitalg::AVX512BITALG::get_tests() {
                tests.push((n, "avx512bitalg", f));
            }
        }

        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512bw::AVX512BW::get_tests() {
                tests.push((n, "avx512bw", f));
            }
        }

        #[cfg(target_feature = "avx512cd")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512cd::AVX512CD::get_tests() {
                tests.push((n, "avx512cd", f));
            }
        }

        #[cfg(target_feature = "avx512dq")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512dq::AVX512DQ::get_tests() {
                tests.push((n, "avx512dq", f));
            }
        }

        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512f::AVX512F::get_tests() {
                tests.push((n, "avx512f", f));
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512fp16::AVX512FP16::get_tests() {
                tests.push((n, "avx512fp16", f));
            }
        }

        #[cfg(target_feature = "avx512ifma")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512ifma::AVX512IFMA::get_tests() {
                tests.push((n, "avx512ifma", f));
            }
        }

        #[cfg(target_feature = "avx512vbmi")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vbmi::AVX512VBMI::get_tests() {
                tests.push((n, "avx512vbmi", f));
            }
        }

        #[cfg(target_feature = "avx512vbmi2")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vbmi2::AVX512VBMI2::get_tests() {
                tests.push((n, "avx512vbmi2", f));
            }
        }

        #[cfg(target_feature = "avx512vnni")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vnni::AVX512VNNI::get_tests() {
                tests.push((n, "avx512vnni", f));
            }
        }

        #[cfg(target_feature = "avx512vpopcntdq")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::avx512vpopcntdq::AVX512VPOPCNTDQ::get_tests() {
                tests.push((n, "avx512vpopcntdq", f));
            }
        }

        #[cfg(target_feature = "avxneconvert")]
        if std::arch::is_x86_feature_detected!("avxneconvert") {
            for &(f, n) in crate::cpu::auto_generated::x86::avxneconvert::AVXNECONVERT::get_tests() {
                tests.push((n, "avxneconvert", f));
            }
        }

        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            for &(f, n) in crate::cpu::auto_generated::x86::bmi1::BMI1::get_tests() {
                tests.push((n, "bmi1", f));
            }
        }

        #[cfg(target_feature = "bmi2")]
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

        #[cfg(target_feature = "f16c")]
        if std::arch::is_x86_feature_detected!("f16c") {
            for &(f, n) in crate::cpu::auto_generated::x86::f16c::F16C::get_tests() {
                tests.push((n, "f16c", f));
            }
        }

        #[cfg(target_feature = "fma")]
        if std::arch::is_x86_feature_detected!("fma") {
            for &(f, n) in crate::cpu::auto_generated::x86::fma::FMA::get_tests() {
                tests.push((n, "fma", f));
            }
        }

        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            for &(f, n) in crate::cpu::auto_generated::x86::fxsr::FXSR::get_tests() {
                tests.push((n, "fxsr", f));
            }
        }

        #[cfg(target_feature = "gfni")]
        if std::arch::is_x86_feature_detected!("gfni") {
            for &(f, n) in crate::cpu::auto_generated::x86::gfni::GFNI::get_tests() {
                tests.push((n, "gfni", f));
            }
        }

        #[cfg(target_feature = "kl")]
        if std::arch::is_x86_feature_detected!("kl") {
            for &(f, n) in crate::cpu::auto_generated::x86::kl::KL::get_tests() {
                tests.push((n, "kl", f));
            }
        }

        #[cfg(target_feature = "pclmulqdq")]
        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::pclmulqdq::PCLMULQDQ::get_tests() {
                tests.push((n, "pclmulqdq", f));
            }
        }

        #[cfg(target_feature = "rdrand")]
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

        #[cfg(target_feature = "rtm")]
        if std::arch::is_x86_feature_detected!("rtm") {
            for &(f, n) in crate::cpu::auto_generated::x86::rtm::RTM::get_tests() {
                tests.push((n, "rtm", f));
            }
        }

        #[cfg(target_feature = "sha")]
        if std::arch::is_x86_feature_detected!("sha") {
            for &(f, n) in crate::cpu::auto_generated::x86::sha::SHA::get_tests() {
                tests.push((n, "sha", f));
            }
        }

        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse::SSE::get_tests() {
                tests.push((n, "sse", f));
            }
        }

        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse2::SSE2::get_tests() {
                tests.push((n, "sse2", f));
            }
        }

        #[cfg(target_feature = "sse3")]
        if std::arch::is_x86_feature_detected!("sse3") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse3::SSE3::get_tests() {
                tests.push((n, "sse3", f));
            }
        }

        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse41::SSE41::get_tests() {
                tests.push((n, "sse41", f));
            }
        }

        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse42::SSE42::get_tests() {
                tests.push((n, "sse42", f));
            }
        }

        #[cfg(target_feature = "sse4a")]
        if std::arch::is_x86_feature_detected!("sse4a") {
            for &(f, n) in crate::cpu::auto_generated::x86::sse4a::SSE4A::get_tests() {
                tests.push((n, "sse4a", f));
            }
        }

        #[cfg(target_feature = "ssse3")]
        if std::arch::is_x86_feature_detected!("ssse3") {
            for &(f, n) in crate::cpu::auto_generated::x86::ssse3::SSSE3::get_tests() {
                tests.push((n, "ssse3", f));
            }
        }

        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            for &(f, n) in crate::cpu::auto_generated::x86::tbm::TBM::get_tests() {
                tests.push((n, "tbm", f));
            }
        }

        #[cfg(target_feature = "vaes")]
        if std::arch::is_x86_feature_detected!("vaes") {
            for &(f, n) in crate::cpu::auto_generated::x86::vaes::VAES::get_tests() {
                tests.push((n, "vaes", f));
            }
        }

        #[cfg(target_feature = "vpclmulqdq")]
        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            for &(f, n) in crate::cpu::auto_generated::x86::vpclmulqdq::VPCLMULQDQ::get_tests() {
                tests.push((n, "vpclmulqdq", f));
            }
        }

        #[cfg(target_feature = "xsave")]
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

        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::adx::ADX::get_tests() {
                tests.push((n, "adx", f));
            }
        }

        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx::AVX::get_tests() {
                tests.push((n, "avx", f));
            }
        }

        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512bw::AVX512BW::get_tests() {
                tests.push((n, "avx512bw", f));
            }
        }

        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512f::AVX512F::get_tests() {
                tests.push((n, "avx512f", f));
            }
        }

        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::avx512fp16::AVX512FP16::get_tests() {
                tests.push((n, "avx512fp16", f));
            }
        }

        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::bmi::BMI::get_tests() {
                tests.push((n, "bmi", f));
            }
        }

        #[cfg(target_feature = "bmi2")]
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

        #[cfg(target_feature = "cmpxchg16b")]
        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::cmpxchg16b::CMPXCHG16B::get_tests() {
                tests.push((n, "cmpxchg16b", f));
            }
        }

        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::fxsr::FXSR::get_tests() {
                tests.push((n, "fxsr", f));
            }
        }

        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::rdrand::RDRAND::get_tests() {
                tests.push((n, "rdrand", f));
            }
        }

        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse::SSE::get_tests() {
                tests.push((n, "sse", f));
            }
        }

        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse2::SSE2::get_tests() {
                tests.push((n, "sse2", f));
            }
        }

        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse41::SSE41::get_tests() {
                tests.push((n, "sse41", f));
            }
        }

        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::sse42::SSE42::get_tests() {
                tests.push((n, "sse42", f));
            }
        }

        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::tbm::TBM::get_tests() {
                tests.push((n, "tbm", f));
            }
        }

        #[cfg(target_feature = "xsave")]
        if std::arch::is_x86_feature_detected!("xsave") {
            for &(f, n) in crate::cpu::auto_generated::x86_64::xsave::XSAVE::get_tests() {
                tests.push((n, "xsave", f));
            }
        }

    }

    tests
}
