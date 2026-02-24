#![allow(unused_imports)]
#![allow(unreachable_code)]

use crate::cpu::{ExtensionTest, FeatureStats, TestStatistics, ProgressCallback};
use crate::cpu::{reset_stop_flag, should_stop};

/// Count how many CPU features/extensions are available on this machine
pub fn count_available_features() -> usize {
    let mut count = 0;

    #[cfg(target_arch = "aarch64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(target_arch = "arm")]
    {
        #[cfg(target_feature = "neon")]
        if false /* feature detection not yet implemented */ {
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

    #[cfg(all() /* nvptx not supported */)]
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

    }

    #[cfg(target_arch = "riscv64")]
    {
        if false /* no runtime detection available */ {
            count += 1;
        }

    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
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
pub fn available_modes() -> Vec<&'static str> {
    let mut modes = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
        if false /* no runtime detection available */ {
            modes.push("mte");
        }
        if false /* no runtime detection available */ {
            modes.push("prefetch");
        }
    }

    #[cfg(target_arch = "arm")]
    {
        #[cfg(target_feature = "neon")]
        if false /* feature detection not yet implemented */ {
            modes.push("neon");
        }
    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
    }

    #[cfg(target_arch = "mips")]
    {
        if false /* no runtime detection available */ {
            modes.push("msa");
        }
    }

    #[cfg(all() /* nvptx not supported */)]
    {
        if false /* no runtime detection available */ {
            modes.push("packed");
        }
    }

    #[cfg(target_arch = "powerpc")]
    {
        if false /* no runtime detection available */ {
            modes.push("altivec");
        }
        if false /* no runtime detection available */ {
            modes.push("vsx");
        }
    }

    #[cfg(target_arch = "powerpc64")]
    {
        if false /* no runtime detection available */ {
            modes.push("vsx");
        }
    }

    #[cfg(target_arch = "riscv32")]
    {
        if false /* no runtime detection available */ {
            modes.push("zk");
        }
    }

    #[cfg(target_arch = "riscv64")]
    {
        if false /* no runtime detection available */ {
            modes.push("zk");
        }
    }

    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    {
        if false /* no runtime detection available */ {
            modes.push("p");
        }
        if false /* no runtime detection available */ {
            modes.push("zb");
        }
        if false /* no runtime detection available */ {
            modes.push("zk");
        }
    }

    #[cfg(target_arch = "s390x")]
    {
        if false /* no runtime detection available */ {
            modes.push("vector");
        }
    }

    #[cfg(target_arch = "wasm32")]
    {
        if false /* no runtime detection available */ {
            modes.push("atomic");
        }
        if false /* no runtime detection available */ {
            modes.push("memory");
        }
        if false /* no runtime detection available */ {
            modes.push("relaxed_simd");
        }
        if false /* no runtime detection available */ {
            modes.push("simd128");
        }
    }

    #[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
    {
        if false /* no runtime detection available */ {
            modes.push("abm");
        }
        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            modes.push("adx");
        }
        #[cfg(target_feature = "aes")]
        if std::arch::is_x86_feature_detected!("aes") {
            modes.push("aes");
        }
        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            modes.push("avx");
        }
        #[cfg(target_feature = "avx2")]
        if std::arch::is_x86_feature_detected!("avx2") {
            modes.push("avx2");
        }
        #[cfg(target_feature = "avx512bf16")]
        if std::arch::is_x86_feature_detected!("avx512bf16") {
            modes.push("avx512bf16");
        }
        #[cfg(target_feature = "avx512bitalg")]
        if std::arch::is_x86_feature_detected!("avx512bitalg") {
            modes.push("avx512bitalg");
        }
        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.push("avx512bw");
        }
        #[cfg(target_feature = "avx512cd")]
        if std::arch::is_x86_feature_detected!("avx512cd") {
            modes.push("avx512cd");
        }
        #[cfg(target_feature = "avx512dq")]
        if std::arch::is_x86_feature_detected!("avx512dq") {
            modes.push("avx512dq");
        }
        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.push("avx512f");
        }
        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.push("avx512fp16");
        }
        #[cfg(target_feature = "avx512ifma")]
        if std::arch::is_x86_feature_detected!("avx512ifma") {
            modes.push("avx512ifma");
        }
        #[cfg(target_feature = "avx512vbmi")]
        if std::arch::is_x86_feature_detected!("avx512vbmi") {
            modes.push("avx512vbmi");
        }
        #[cfg(target_feature = "avx512vbmi2")]
        if std::arch::is_x86_feature_detected!("avx512vbmi2") {
            modes.push("avx512vbmi2");
        }
        #[cfg(target_feature = "avx512vnni")]
        if std::arch::is_x86_feature_detected!("avx512vnni") {
            modes.push("avx512vnni");
        }
        #[cfg(target_feature = "avx512vpopcntdq")]
        if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
            modes.push("avx512vpopcntdq");
        }
        #[cfg(target_feature = "avxneconvert")]
        if std::arch::is_x86_feature_detected!("avxneconvert") {
            modes.push("avxneconvert");
        }
        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.push("bmi1");
        }
        #[cfg(target_feature = "bmi2")]
        if std::arch::is_x86_feature_detected!("bmi2") {
            modes.push("bmi2");
        }
        if false /* no runtime detection available */ {
            modes.push("bswap");
        }
        if false /* no runtime detection available */ {
            modes.push("bt");
        }
        if false /* no runtime detection available */ {
            modes.push("cpuid");
        }
        if false /* no runtime detection available */ {
            modes.push("eflags");
        }
        #[cfg(target_feature = "f16c")]
        if std::arch::is_x86_feature_detected!("f16c") {
            modes.push("f16c");
        }
        #[cfg(target_feature = "fma")]
        if std::arch::is_x86_feature_detected!("fma") {
            modes.push("fma");
        }
        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.push("fxsr");
        }
        #[cfg(target_feature = "gfni")]
        if std::arch::is_x86_feature_detected!("gfni") {
            modes.push("gfni");
        }
        #[cfg(target_feature = "kl")]
        if std::arch::is_x86_feature_detected!("kl") {
            modes.push("kl");
        }
        #[cfg(target_feature = "pclmulqdq")]
        if std::arch::is_x86_feature_detected!("pclmulqdq") {
            modes.push("pclmulqdq");
        }
        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.push("rdrand");
        }
        if false /* no runtime detection available */ {
            modes.push("rdtsc");
        }
        #[cfg(target_feature = "rtm")]
        if std::arch::is_x86_feature_detected!("rtm") {
            modes.push("rtm");
        }
        #[cfg(target_feature = "sha")]
        if std::arch::is_x86_feature_detected!("sha") {
            modes.push("sha");
        }
        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            modes.push("sse");
        }
        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.push("sse2");
        }
        #[cfg(target_feature = "sse3")]
        if std::arch::is_x86_feature_detected!("sse3") {
            modes.push("sse3");
        }
        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.push("sse4.1");
        }
        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.push("sse4.2");
        }
        #[cfg(target_feature = "sse4a")]
        if std::arch::is_x86_feature_detected!("sse4a") {
            modes.push("sse4a");
        }
        #[cfg(target_feature = "ssse3")]
        if std::arch::is_x86_feature_detected!("ssse3") {
            modes.push("ssse3");
        }
        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.push("tbm");
        }
        #[cfg(target_feature = "vaes")]
        if std::arch::is_x86_feature_detected!("vaes") {
            modes.push("vaes");
        }
        #[cfg(target_feature = "vpclmulqdq")]
        if std::arch::is_x86_feature_detected!("vpclmulqdq") {
            modes.push("vpclmulqdq");
        }
        #[cfg(target_feature = "xsave")]
        if std::arch::is_x86_feature_detected!("xsave") {
            modes.push("xsave");
        }
    }

    #[cfg(target_arch = "x86_64")]
    {
        if false /* no runtime detection available */ {
            modes.push("abm");
        }
        #[cfg(target_feature = "adx")]
        if std::arch::is_x86_feature_detected!("adx") {
            modes.push("adx");
        }
        #[cfg(target_feature = "avx")]
        if std::arch::is_x86_feature_detected!("avx") {
            modes.push("avx");
        }
        #[cfg(target_feature = "avx512bw")]
        if std::arch::is_x86_feature_detected!("avx512bw") {
            modes.push("avx512bw");
        }
        #[cfg(target_feature = "avx512f")]
        if std::arch::is_x86_feature_detected!("avx512f") {
            modes.push("avx512f");
        }
        #[cfg(target_feature = "avx512fp16")]
        if std::arch::is_x86_feature_detected!("avx512fp16") {
            modes.push("avx512fp16");
        }
        #[cfg(target_feature = "bmi1")]
        if std::arch::is_x86_feature_detected!("bmi1") {
            modes.push("bmi1");
        }
        #[cfg(target_feature = "bmi2")]
        if std::arch::is_x86_feature_detected!("bmi2") {
            modes.push("bmi2");
        }
        if false /* no runtime detection available */ {
            modes.push("bswap");
        }
        if false /* no runtime detection available */ {
            modes.push("bt");
        }
        #[cfg(target_feature = "cmpxchg16b")]
        if std::arch::is_x86_feature_detected!("cmpxchg16b") {
            modes.push("cmpxchg16b");
        }
        #[cfg(target_feature = "fxsr")]
        if std::arch::is_x86_feature_detected!("fxsr") {
            modes.push("fxsr");
        }
        #[cfg(target_feature = "rdrand")]
        if std::arch::is_x86_feature_detected!("rdrand") {
            modes.push("rdrand");
        }
        #[cfg(target_feature = "sse")]
        if std::arch::is_x86_feature_detected!("sse") {
            modes.push("sse");
        }
        #[cfg(target_feature = "sse2")]
        if std::arch::is_x86_feature_detected!("sse2") {
            modes.push("sse2");
        }
        #[cfg(target_feature = "sse4.1")]
        if std::arch::is_x86_feature_detected!("sse4.1") {
            modes.push("sse4.1");
        }
        #[cfg(target_feature = "sse4.2")]
        if std::arch::is_x86_feature_detected!("sse4.2") {
            modes.push("sse4.2");
        }
        #[cfg(target_feature = "tbm")]
        if std::arch::is_x86_feature_detected!("tbm") {
            modes.push("tbm");
        }
        #[cfg(target_feature = "xsave")]
        if std::arch::is_x86_feature_detected!("xsave") {
            modes.push("xsave");
        }
    }

    modes
}

/// Test all available CPU extensions with progress callback
pub fn test_all_extensions(progress_callback: Option<&ProgressCallback>) -> Result<TestStatistics, String> {
    reset_stop_flag();

    let total_features = count_available_features();
    let mut completed_features = 0;
    let mut features = Vec::new();

    #[cfg(target_arch = "aarch64")]
    {
            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
        #[cfg(target_feature = "neon")]
        {
            if false /* feature detection not yet implemented */ {
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

    }

    #[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
    {
    }

    #[cfg(target_arch = "mips")]
    {
            if false /* no runtime detection available */ {
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

    #[cfg(all() /* nvptx not supported */)]
    {
            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
            if false /* no runtime detection available */ {
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
            if std::arch::is_x86_feature_detected!("adx") {
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
            if std::arch::is_x86_feature_detected!("aes") {
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
            if std::arch::is_x86_feature_detected!("avx") {
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
            if std::arch::is_x86_feature_detected!("avx2") {
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
            if std::arch::is_x86_feature_detected!("avx512bf16") {
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
            if std::arch::is_x86_feature_detected!("avx512bitalg") {
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
            if std::arch::is_x86_feature_detected!("avx512bw") {
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
            if std::arch::is_x86_feature_detected!("avx512cd") {
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
            if std::arch::is_x86_feature_detected!("avx512dq") {
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
            if std::arch::is_x86_feature_detected!("avx512f") {
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
            if std::arch::is_x86_feature_detected!("avx512fp16") {
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
            if std::arch::is_x86_feature_detected!("avx512ifma") {
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
            if std::arch::is_x86_feature_detected!("avx512vbmi") {
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
            if std::arch::is_x86_feature_detected!("avx512vbmi2") {
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
            if std::arch::is_x86_feature_detected!("avx512vnni") {
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
            if std::arch::is_x86_feature_detected!("avx512vpopcntdq") {
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
            if std::arch::is_x86_feature_detected!("avxneconvert") {
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
            if std::arch::is_x86_feature_detected!("bmi1") {
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
            if std::arch::is_x86_feature_detected!("bmi2") {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
            if std::arch::is_x86_feature_detected!("f16c") {
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
            if std::arch::is_x86_feature_detected!("fma") {
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
            if std::arch::is_x86_feature_detected!("fxsr") {
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
            if std::arch::is_x86_feature_detected!("gfni") {
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
            if std::arch::is_x86_feature_detected!("kl") {
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
            if std::arch::is_x86_feature_detected!("pclmulqdq") {
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
            if std::arch::is_x86_feature_detected!("rdrand") {
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

            if false /* no runtime detection available */ {
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
            if std::arch::is_x86_feature_detected!("rtm") {
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
            if std::arch::is_x86_feature_detected!("sha") {
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
            if std::arch::is_x86_feature_detected!("sse") {
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
            if std::arch::is_x86_feature_detected!("sse2") {
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
            if std::arch::is_x86_feature_detected!("sse3") {
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
            if std::arch::is_x86_feature_detected!("sse4.1") {
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
            if std::arch::is_x86_feature_detected!("sse4.2") {
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
            if std::arch::is_x86_feature_detected!("sse4a") {
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
            if std::arch::is_x86_feature_detected!("ssse3") {
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
            if std::arch::is_x86_feature_detected!("tbm") {
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
            if std::arch::is_x86_feature_detected!("vaes") {
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
            if std::arch::is_x86_feature_detected!("vpclmulqdq") {
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
            if std::arch::is_x86_feature_detected!("xsave") {
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
            if false /* no runtime detection available */ {
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
            if std::arch::is_x86_feature_detected!("adx") {
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
            if std::arch::is_x86_feature_detected!("avx") {
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
            if std::arch::is_x86_feature_detected!("avx512bw") {
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
            if std::arch::is_x86_feature_detected!("avx512f") {
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
            if std::arch::is_x86_feature_detected!("avx512fp16") {
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
            if std::arch::is_x86_feature_detected!("bmi1") {
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
            if std::arch::is_x86_feature_detected!("bmi2") {
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

            if false /* no runtime detection available */ {
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

            if false /* no runtime detection available */ {
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
            if std::arch::is_x86_feature_detected!("cmpxchg16b") {
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
            if std::arch::is_x86_feature_detected!("fxsr") {
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
            if std::arch::is_x86_feature_detected!("rdrand") {
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
            if std::arch::is_x86_feature_detected!("sse") {
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
            if std::arch::is_x86_feature_detected!("sse2") {
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
            if std::arch::is_x86_feature_detected!("sse4.1") {
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
            if std::arch::is_x86_feature_detected!("sse4.2") {
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
            if std::arch::is_x86_feature_detected!("tbm") {
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
            if std::arch::is_x86_feature_detected!("xsave") {
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
        #[cfg(target_feature = "neon")]
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

    #[cfg(all() /* nvptx not supported */)]
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
