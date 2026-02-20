# WorkTester - Devices testing tool

This is a hobby project, to validate specific cpu(at least for now) features/functions, to check if they don't crash and if produces correct results.

The first requirement, is that code should be easily cross-compilable, without needing any additional dependencies.

For now it checks specific cpu features, runs them to find crashes(initially validated this with miri to avoid spurious crashes) and use 1 check for (almost)every function to find any possible issues with the implementation.

Project was created, basing on Rust 1.93 and later updates, may add other cpu features.

## Usage
### Default(not recommended - uses very basic cpu features)
`cargo run`
```
Feature   Run  Skipped  Errors
----------------------------
SSE     88        0       0
SSE2   208        0       0
----------------------------
TOTAL   296        0       0
```
### Native target cpu(not recommended, due random features enabled in build)
`RUSTFLAGS="-C target-cpu=native" cargo run`
```
Feature        Run  Skipped  Errors
------------------------------------
SSE             88        0       0
SSE2           208        0       0
SSE3            11        0       0
SSSE3           16        0       0
SSE41           60        0       0
SSE42           19        0       0
AVX            174        0       0
AVX2           192        0       0
AES              5        0       0
------------------------------------
TOTAL          773        0       0
```
### All features enabled(recommended, because not supported features are skipped in runtime)
`RUSTFLAGS="-C target-feature=+aes,+amx-bf16,+amx-complex,+amx-fp16,+amx-int8,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512fp16,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vp2intersect,+avx512vpopcntdq,+avxifma,+avxneconvert,+avxvnni,+avxvnniint16,+avxvnniint8,+f16c,+fma,+gfni,+kl,+pclmulqdq,+sha,+sha512,+sm3,+sm4,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+widekl,+xop,+xsave,+xsavec,+xsaveopt,+xsaves" +nightly build --release;target/release/work_tester`
```
Feature        Run  Skipped  Errors
------------------------------------
SSE             88        0       0
SSE2           208        0       0
SSE3            11        0       0
SSSE3           16        0       0
SSE41           60        0       0
SSE42           19        0       0
AVX            174        0       0
AVX2           192        0       0
FMA             32        0       0
AVX512F       1478        0       0
AVX512BITALG    18        0       0
AVX512CD        24        0       0
AES              5        0       0
------------------------------------
TOTAL         2325        0       0
```



## AI Usage
This project heavily relies on AI for code generation, bug fixing, refactoring, so if you have any objections to this, don't use it.

## Implemented

| Feature    | Implemented |
|------------|------------:|
| CPU x86_64 |           ✅ |
| CPU arm    |           ❌ |
| OpenGL     |           ❌ |
| Vulkan     |           ❌ |
