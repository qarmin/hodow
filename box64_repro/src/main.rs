//! Standalone repro cases for divergences found running hodow_cli's CPU suite under
//! box64 (github.com/ptitSeb/box64): the x86_64-host interpreter fallback, the real
//! ARM64 dynarec (cross-built, run under qemu-aarch64), and the real RISC-V64 dynarec
//! (cross-built, run under qemu-riscv64). Each case below is the minimal call that
//! reproduces one divergence, lifted straight out of hodow_core's generated CPU tests.
//!
//! One case runs per process invocation (see justfile) - several of these are expected
//! to SIGILL or SIGSEGV under box64, and that must never take any other case down with
//! it or get masked behind a shared exit code.
//!
//! Exit code convention: 0 = passed (matched what real hardware produces), 1 = ran but
//! produced a different value, anything else (128+signal, e.g. 132 = SIGILL, 139 =
//! SIGSEGV) = the process was killed outright.
//!
//! Two things `just matrix` will show that the original investigation did not, worth
//! reading before trusting a "pass" here as "not a bug":
//!
//! - Cases 8/9 (rdseed32_step/rdseed64_step) are genuinely flaky under box64, not a
//!   fixed wrong value: repeated runs return different nonzero garbage on every box64
//!   backend (2, 9, 14, 22 all observed across separate invocations of this exact
//!   binary), while native hardware passes reliably every time. A single `just matrix`
//!   row can show "pass" purely by chance - rerun a few times before concluding
//!   anything from one row.
//! - Cases 10-12 and 14-16 (six of the seven SHA-NI intrinsics) reliably SIGSEGV under
//!   box64's real RISC-V64 dynarec when called from *inside hodow_cli's own binary*
//!   (`qemu-riscv64 -L /usr/riscv64-linux-gnu <box64-riscv64 build>/box64
//!   <hodow_cli built with target-feature=+sha> cpu -t test_x86_sha_mm_sha1msg1_epu32
//!   -e sha`, reproduced 6/6 tries), but calling the exact same intrinsic on the exact
//!   same inputs from this minimal binary passes cleanly, every time, on every
//!   backend including riscv64. That means the crash depends on something about the
//!   JIT's state by the time it reaches the instruction (translation-cache contents,
//!   register allocation, whatever came before) rather than the instruction and its
//!   operands alone - a real bug, but not one this harness manages to isolate. Cases
//!   10-12/14-16 are kept here as the minimized-but-not-reproducing form, so anyone
//!   narrowing it further has a documented starting point instead of starting cold.

use std::arch::x86_64::*;
use std::process::ExitCode;

#[repr(align(64))]
struct Aligned64([u8; 4096]);

fn describe(n: u32) -> &'static str {
    match n {
        1 => "rdrand16_step | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        2 => "rdseed16_step | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        3 => "xgetbv | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        4 => "xsaveopt | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        5 => "xsavec | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        6 => "xsaveopt64 | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        7 => "xsavec64 | native: pass | box64 (every backend): SIGILL, opcode not implemented",
        8 => "rdseed32_step | native: reliably pass(1) | box64 (every backend): FLAKY, intermittently a wrong nonzero status (varies run to run and backend to backend - 2/9/14/22 all observed)",
        9 => "rdseed64_step | native: reliably pass(1) | box64 (every backend): FLAKY, same as rdseed32_step",
        10 => "sha1msg1_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        11 => "sha1msg2_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        12 => "sha1nexte_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        13 => "sha1rnds4_epu32 | control case: the one SHA-NI instruction that also passed inside hodow_cli's own box64-riscv64 run (see module doc comment)",
        14 => "sha256msg1_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        15 => "sha256msg2_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        16 => "sha256rnds2_epu32 | passes here on every backend - does NOT reproduce this instruction's real bug in isolation, see the module doc comment",
        _ => "unknown case",
    }
}

const NUM_CASES: u32 = 16;

fn main() -> ExitCode {
    let arg = std::env::args().nth(1);

    if arg.as_deref() == Some("--list") {
        for n in 1..=NUM_CASES {
            println!("{n:2}: {}", describe(n));
        }
        return ExitCode::SUCCESS;
    }

    let Some(n) = arg.and_then(|s| s.parse::<u32>().ok()) else {
        eprintln!("usage: box64_repro <case 1..={NUM_CASES}>");
        eprintln!("       box64_repro --list");
        return ExitCode::from(2);
    };

    let result = match n {
        1 => case_1(),
        2 => case_2(),
        3 => case_3(),
        4 => case_4(),
        5 => case_5(),
        6 => case_6(),
        7 => case_7(),
        8 => case_8(),
        9 => case_9(),
        10 => case_10(),
        11 => case_11(),
        12 => case_12(),
        13 => case_13(),
        14 => case_14(),
        15 => case_15(),
        16 => case_16(),
        _ => {
            eprintln!("no such case: {n} (valid range is 1..={NUM_CASES})");
            return ExitCode::from(2);
        }
    };

    match result {
        Ok(()) => {
            println!("[{n}] {}: PASS", describe(n));
            ExitCode::SUCCESS
        }
        Err(e) => {
            println!("[{n}] {}: FAIL - {e}", describe(n));
            ExitCode::from(1)
        }
    }
}

#[target_feature(enable = "rdrand")]
unsafe fn rdrand16_step() -> i32 {
    let mut val: u16 = 1;
    _rdrand16_step(&mut val)
}

fn case_1() -> Result<(), String> {
    let got = unsafe { rdrand16_step() };
    if got == 1 { Ok(()) } else { Err(format!("Got {got}, expected 1")) }
}

#[target_feature(enable = "rdseed")]
unsafe fn rdseed16_step() -> i32 {
    let mut val: u16 = 1;
    _rdseed16_step(&mut val)
}

fn case_2() -> Result<(), String> {
    let got = unsafe { rdseed16_step() };
    if got == 1 { Ok(()) } else { Err(format!("Got {got}, expected 1")) }
}

#[target_feature(enable = "xsave")]
unsafe fn xgetbv() -> u64 {
    unsafe { _xgetbv(1) }
}

fn case_3() -> Result<(), String> {
    // Expected value captured on the real machine used for this investigation
    // (scripts/cpu/capture_expected.py); box64's XCR0 emulation may legitimately
    // report something else even where it doesn't SIGILL outright.
    let got = unsafe { xgetbv() };
    if got == 674 { Ok(()) } else { Err(format!("Got {got}, expected 674")) }
}

#[target_feature(enable = "xsave,xsaveopt")]
unsafe fn xsaveopt() {
    let mut buf = Aligned64([1u8; 4096]);
    unsafe { _xsaveopt(buf.0.as_mut_ptr(), 2u64) }
}

fn case_4() -> Result<(), String> {
    unsafe { xsaveopt() };
    Ok(())
}

#[target_feature(enable = "xsave,xsavec")]
unsafe fn xsavec() {
    let mut buf = Aligned64([1u8; 4096]);
    unsafe { _xsavec(buf.0.as_mut_ptr(), 2u64) }
}

fn case_5() -> Result<(), String> {
    unsafe { xsavec() };
    Ok(())
}

#[target_feature(enable = "xsave,xsaveopt")]
unsafe fn xsaveopt64() {
    let mut buf = Aligned64([1u8; 4096]);
    unsafe { _xsaveopt64(buf.0.as_mut_ptr(), 2u64) }
}

fn case_6() -> Result<(), String> {
    unsafe { xsaveopt64() };
    Ok(())
}

#[target_feature(enable = "xsave,xsavec")]
unsafe fn xsavec64() {
    let mut buf = Aligned64([1u8; 4096]);
    unsafe { _xsavec64(buf.0.as_mut_ptr(), 2u64) }
}

fn case_7() -> Result<(), String> {
    unsafe { xsavec64() };
    Ok(())
}

#[target_feature(enable = "rdseed")]
unsafe fn rdseed32_step() -> i32 {
    let mut val: u32 = 1;
    _rdseed32_step(&mut val)
}

fn case_8() -> Result<(), String> {
    let got = unsafe { rdseed32_step() };
    if got == 1 { Ok(()) } else { Err(format!("Got {got}, expected 1")) }
}

#[target_feature(enable = "rdseed")]
unsafe fn rdseed64_step() -> i32 {
    let mut val: u64 = 1;
    _rdseed64_step(&mut val)
}

fn case_9() -> Result<(), String> {
    let got = unsafe { rdseed64_step() };
    if got == 1 { Ok(()) } else { Err(format!("Got {got}, expected 1")) }
}

fn m128i_from(vals: [i32; 4]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

fn m128i_to_array(v: __m128i) -> [i32; 4] {
    unsafe { std::mem::transmute(v) }
}

#[target_feature(enable = "sha")]
unsafe fn sha1msg1(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha1msg1_epu32(a, b)
}

fn case_10() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha1msg1(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [6, 10, 2, 6];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha1msg2(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha1msg2_epu32(a, b)
}

fn case_11() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha1msg2(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [14, 14, 10, 6];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha1nexte(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha1nexte_epu32(a, b)
}

fn case_12() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha1nexte(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [5, 6, 7, 9];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha1rnds4(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha1rnds4_epu32::<0>(a, b)
}

fn case_13() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha1rnds4(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [-694116728, -1431015549, 884620151, 877299341];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha256msg1(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha256msg1_epu32(a, b)
}

fn case_14() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha256msg1(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [67141633, 100712450, 134283267, 167854084];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha256msg2(a: __m128i, b: __m128i) -> __m128i {
    _mm_sha256msg2_epu32(a, b)
}

fn case_15() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha256msg2(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8])) });
    let expected = [221185, 327682, -603938596, 536953158];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}

#[target_feature(enable = "sha")]
unsafe fn sha256rnds2(a: __m128i, b: __m128i, c: __m128i) -> __m128i {
    _mm_sha256rnds2_epu32(a, b, c)
}

fn case_16() -> Result<(), String> {
    let got = m128i_to_array(unsafe { sha256rnds2(m128i_from([1, 2, 3, 4]), m128i_from([5, 6, 7, 8]), m128i_from([9, 10, 11, 12])) });
    let expected = [415236881, 1178701972, 419439380, 1689133364];
    if got == expected { Ok(()) } else { Err(format!("Got {got:?}, expected {expected:?}")) }
}
