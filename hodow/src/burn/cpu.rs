//! The CPU phase. Every thread is pinned to its own core, and every result is compared with
//! what another core - or the same core earlier - computed for the same input, so a single
//! core that goes wrong under load is named.

use std::collections::HashMap;
use std::hint::black_box;
use std::sync::Mutex;
use std::sync::atomic::{AtomicU64, Ordering};
use std::time::Instant;

use hodow_cpu::Verdict;

use super::memory::splitmix;
use super::protocol::CpuTest;
use super::worker::{Sink, WorkerError, run_pinned};

pub fn run(
    test: CpuTest,
    cores: &[usize],
    deadline: Instant,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) -> Result<String, WorkerError> {
    let cores: Vec<usize> = if cores.is_empty() { vec![0] } else { cores.to_vec() };
    match test {
        CpuTest::InstructionSuite => instruction_suite(&cores, deadline, inject, sink, work),
        CpuTest::MaxPower => max_power(&cores, deadline, inject, sink, work),
        CpuTest::IntegerCache => integer_cache(&cores, deadline, inject, sink, work),
    }
}

/// Results whose value is a fact about the moment or the core they ran on, not about
/// their input.
fn is_nondeterministic(name: &str) -> bool {
    ["rdrand", "rdseed", "rdtsc", "rdpid", "cpuid", "xgetbv"]
        .iter()
        .any(|n| name.contains(n))
}

#[derive(Clone, PartialEq, Debug)]
enum Seen {
    Checked,
    Value(String),
    Nothing,
    Failed(String),
}

fn observe(f: hodow_cpu::TestFunction) -> Seen {
    match std::panic::catch_unwind(std::panic::AssertUnwindSafe(f)) {
        Ok(Ok(Verdict::Checked)) => Seen::Checked,
        Ok(Ok(Verdict::Unverified(Some(v)))) => Seen::Value(v),
        Ok(Ok(_)) => Seen::Nothing,
        Ok(Err(e)) => Seen::Failed(e),
        Err(_) => Seen::Failed("panicked".into()),
    }
}

/// The whole generated suite on every core. A captured expectation is checked by the test
/// itself; an unverified value has to match what the reference runs observed - twice on
/// one core and once on another, so anything that varies by itself is left out.
fn instruction_suite(
    cores: &[usize],
    deadline: Instant,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) -> Result<String, WorkerError> {
    let tests: Vec<_> = hodow_cpu::all_tests()
        .into_iter()
        .filter(|(n, _, _)| !is_nondeterministic(n))
        .map(|(n, _, f)| (n, f))
        .collect();
    if tests.is_empty() {
        return Err(WorkerError::Skip("no CPU tests for this machine".into()));
    }
    let reference_on = |core: usize| {
        crate::stress::pin_current_thread(core);
        let seen: Vec<Seen> = tests.iter().map(|(_, f)| observe(*f)).collect();
        work.fetch_add(1, Ordering::Relaxed);
        seen
    };
    let (first, second, other) = (
        reference_on(cores[0]),
        reference_on(cores[0]),
        reference_on(cores[cores.len() - 1]),
    );
    let reference: Vec<Option<Seen>> = (0..tests.len())
        .map(|i| {
            (first[i] == second[i] && first[i] == other[i] && !matches!(first[i], Seen::Failed(_)))
                .then(|| first[i].clone())
        })
        .collect();
    let ignored = reference.iter().filter(|r| r.is_none()).count();
    let first_compared = reference.iter().position(Option::is_some).unwrap_or(usize::MAX);

    let iterations = AtomicU64::new(0);
    run_pinned(cores.to_vec(), cores, work, |thread, core| {
        let mut round = 0u64;
        loop {
            for (i, (name, f)) in tests.iter().enumerate() {
                let Some(want) = &reference[i] else { continue };
                let mut got = observe(*f);
                if inject && thread == 0 && round == 0 && i == first_compared {
                    got = Seen::Failed("injected fault".into());
                }
                if &got != want {
                    sink.record(|| format!("core {core}: {name}: expected {want:?} got {got:?}"));
                }
                if i % 256 == 0 {
                    work.fetch_add(1, Ordering::Relaxed);
                }
            }
            round += 1;
            iterations.fetch_add(1, Ordering::Relaxed);
            if Instant::now() >= deadline {
                break;
            }
        }
    });
    Ok(format!(
        "{} cores, {} suite runs of {} tests ({ignored} left out: vary between runs or cores, or fail everywhere)",
        cores.len(),
        iterations.load(Ordering::Relaxed),
        tests.len()
    ))
}

/// Every pass result, keyed by pass and part, as whichever core got there first saw it.
#[derive(Default)]
struct CrossCheck {
    seen: Mutex<HashMap<(u64, usize), Vec<u64>>>,
}

impl CrossCheck {
    fn check(&self, key: (u64, usize), got: &[u64], sink: &Sink, describe: impl Fn(usize, u64, u64) -> String) {
        let mut seen = self.seen.lock().unwrap_or_else(|e| e.into_inner());
        let want = seen.entry(key).or_insert_with(|| got.to_vec());
        for (lane, (&w, &g)) in want.iter().zip(got).enumerate() {
            if w != g {
                sink.record(|| describe(lane, w, g));
            }
        }
    }
}

const LANES: usize = 64;
const MULTIPLIER: f64 = 0.999_999_5;

fn addend(lane: usize) -> f64 {
    (lane + 1) as f64 * 1e-7
}

fn initial(pass: u64) -> [f64; LANES] {
    std::array::from_fn(|lane| (pass as f64 * 0.37 + lane as f64) * 1e-3)
}

fn scalar_kernel(state: &mut [f64; LANES], iterations: u64) {
    for _ in 0..iterations {
        for (lane, x) in state.iter_mut().enumerate() {
            *x = x.mul_add(MULTIPLIER, addend(lane));
        }
    }
}

#[cfg(target_arch = "x86_64")]
mod simd {
    use std::arch::x86_64::*;

    use super::{LANES, MULTIPLIER, addend};

    #[target_feature(enable = "avx512f")]
    pub unsafe fn avx512(state: &mut [f64; LANES], iterations: u64) {
        unsafe {
            let m = _mm512_set1_pd(MULTIPLIER);
            let c: [__m512d; 8] = std::array::from_fn(|g| {
                _mm512_loadu_pd(std::array::from_fn::<f64, 8, _>(|l| addend(g * 8 + l)).as_ptr())
            });
            let mut acc: [__m512d; 8] = std::array::from_fn(|g| _mm512_loadu_pd(state[g * 8..].as_ptr()));
            for _ in 0..iterations {
                for g in 0..8 {
                    acc[g] = _mm512_fmadd_pd(acc[g], m, c[g]);
                }
            }
            for g in 0..8 {
                _mm512_storeu_pd(state[g * 8..].as_mut_ptr(), acc[g]);
            }
        }
    }

    #[target_feature(enable = "avx2,fma")]
    pub unsafe fn avx2(state: &mut [f64; LANES], iterations: u64) {
        unsafe {
            let m = _mm256_set1_pd(MULTIPLIER);
            for half in 0..2 {
                let base = half * 32;
                let c: [__m256d; 8] = std::array::from_fn(|g| {
                    _mm256_loadu_pd(std::array::from_fn::<f64, 4, _>(|l| addend(base + g * 4 + l)).as_ptr())
                });
                let mut acc: [__m256d; 8] = std::array::from_fn(|g| _mm256_loadu_pd(state[base + g * 4..].as_ptr()));
                for _ in 0..iterations {
                    for g in 0..8 {
                        acc[g] = _mm256_fmadd_pd(acc[g], m, c[g]);
                    }
                }
                for g in 0..8 {
                    _mm256_storeu_pd(state[base + g * 4..].as_mut_ptr(), acc[g]);
                }
            }
        }
    }
}

#[cfg(target_arch = "aarch64")]
mod simd {
    use std::arch::aarch64::*;

    use super::{LANES, MULTIPLIER, addend};

    pub fn neon(state: &mut [f64; LANES], iterations: u64) {
        unsafe {
            let m = vdupq_n_f64(MULTIPLIER);
            for quarter in 0..4 {
                let base = quarter * 16;
                let c: [float64x2_t; 8] =
                    std::array::from_fn(|g| vld1q_f64([addend(base + g * 2), addend(base + g * 2 + 1)].as_ptr()));
                let mut acc: [float64x2_t; 8] = std::array::from_fn(|g| vld1q_f64(state[base + g * 2..].as_ptr()));
                for _ in 0..iterations {
                    for g in 0..8 {
                        acc[g] = vfmaq_f64(c[g], acc[g], m);
                    }
                }
                for g in 0..8 {
                    vst1q_f64(state[base + g * 2..].as_mut_ptr(), acc[g]);
                }
            }
        }
    }
}

type Kernel = fn(&mut [f64; LANES], u64);

/// The widest fused multiply-add this CPU has, and how many iterations make a pass.
fn pick_kernel() -> (&'static str, Kernel, u64) {
    #[cfg(target_arch = "x86_64")]
    {
        if is_x86_feature_detected!("avx512f") {
            return ("AVX-512 FMA", |s, n| unsafe { simd::avx512(s, n) }, 1 << 20);
        }
        if is_x86_feature_detected!("avx2") && is_x86_feature_detected!("fma") {
            return ("AVX2 FMA", |s, n| unsafe { simd::avx2(s, n) }, 1 << 19);
        }
    }
    #[cfg(target_arch = "aarch64")]
    {
        ("NEON FMA", simd::neon, 1 << 18)
    }
    #[cfg(not(target_arch = "aarch64"))]
    ("scalar FMA", scalar_kernel, 1 << 13)
}

/// Long chains of fused multiply-adds on the widest vector unit - the most power a core
/// draws. IEEE fma is correctly rounded, so every core must land on the same bits, and a
/// short run must equal the scalar `mul_add` exactly.
fn max_power(
    cores: &[usize],
    deadline: Instant,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) -> Result<String, WorkerError> {
    let (unit, kernel, iterations) = pick_kernel();
    crate::stress::pin_current_thread(cores[0]);
    let (mut vector, mut scalar) = (initial(0), initial(0));
    kernel(&mut vector, 1000);
    scalar_kernel(&mut scalar, 1000);
    for lane in 0..LANES {
        if vector[lane].to_bits() != scalar[lane].to_bits() {
            sink.record(|| {
                format!(
                    "{unit} lane {lane} disagrees with scalar mul_add: {:e} vs {:e}",
                    vector[lane], scalar[lane]
                )
            });
        }
    }
    let check = CrossCheck::default();
    let mut reference = initial(0);
    kernel(&mut reference, iterations);
    check
        .seen
        .lock()
        .unwrap_or_else(|e| e.into_inner())
        .insert((0, 0), reference.map(f64::to_bits).to_vec());
    work.fetch_add(1, Ordering::Relaxed);

    let passes = AtomicU64::new(0);
    run_pinned(cores.to_vec(), cores, work, |thread, core| {
        let mut pass = 0u64;
        loop {
            let mut state = initial(pass);
            kernel(black_box(&mut state), iterations);
            let mut bits = state.map(f64::to_bits);
            if inject && thread == 0 && pass == 0 {
                bits[3] ^= 1;
            }
            check.check((pass, 0), &bits, sink, |lane, w, g| {
                format!(
                    "core {core} pass {pass} lane {lane}: expected {:e} got {:e} (bits {:#x})",
                    f64::from_bits(w),
                    f64::from_bits(g),
                    w ^ g
                )
            });
            work.fetch_add(1, Ordering::Relaxed);
            pass += 1;
            if Instant::now() >= deadline {
                break;
            }
        }
        passes.fetch_add(pass, Ordering::Relaxed);
    });
    Ok(format!(
        "{unit}, {} cores, {:.2}G FMA lanes",
        cores.len(),
        (passes.load(Ordering::Relaxed) * iterations * LANES as u64) as f64 / 1e9
    ))
}

/// Buffer sizes that sit in L1, L2 and a thread's share of L3.
fn cache_sizes(threads: usize) -> Vec<(String, usize)> {
    let mut sizes = Vec::new();
    for index in 0..8 {
        let dir = format!("/sys/devices/system/cpu/cpu0/cache/index{index}");
        let read = |f: &str| {
            std::fs::read_to_string(format!("{dir}/{f}"))
                .map(|s| s.trim().to_string())
                .ok()
        };
        let (Some(level), Some(kind), Some(size)) = (read("level"), read("type"), read("size")) else {
            break;
        };
        if kind == "Instruction" {
            continue;
        }
        let bytes = size
            .trim_end_matches('K')
            .parse::<usize>()
            .map(|k| k * 1024)
            .unwrap_or(0);
        let share = if level == "3" { bytes / threads.max(1) } else { bytes };
        if share > 0 {
            sizes.push((format!("L{level}"), (share / 2).max(4096)));
        }
    }
    if sizes.is_empty() {
        sizes = vec![
            ("L1".into(), 16 << 10),
            ("L2".into(), 256 << 10),
            ("L3".into(), 2 << 20),
        ];
    }
    sizes
}

const HASH_WORK: usize = 4 << 20;

fn fill_and_hash(buffer: &mut [u64], seed: u64, corrupt: bool) -> u64 {
    for (i, word) in buffer.iter_mut().enumerate() {
        *word = splitmix(i as u64 ^ seed);
    }
    if corrupt {
        let middle = buffer.len() / 2;
        buffer[middle] ^= 1 << 7;
    }
    let buffer = black_box(buffer);
    let mut hash = seed;
    for repeat in 0..(HASH_WORK / buffer.len()).max(1) as u64 {
        for &x in buffer.iter() {
            hash = (hash ^ x).rotate_left(29).wrapping_mul(0x9E37_79B9_7F4A_7C15) ^ repeat;
        }
    }
    hash
}

/// Fill a buffer the size of each cache level and hash it over and over: integer ALUs plus
/// the load path of every level, with one hash per level and pass to compare across cores.
fn integer_cache(
    cores: &[usize],
    deadline: Instant,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) -> Result<String, WorkerError> {
    let sizes = cache_sizes(cores.len());
    let check = CrossCheck::default();
    crate::stress::pin_current_thread(cores[0]);
    for (part, (_, bytes)) in sizes.iter().enumerate() {
        let mut buffer = vec![0u64; bytes / 8];
        let hash = fill_and_hash(&mut buffer, splitmix(part as u64), false);
        check
            .seen
            .lock()
            .unwrap_or_else(|e| e.into_inner())
            .insert((0, part), vec![hash]);
    }
    work.fetch_add(1, Ordering::Relaxed);

    let passes = AtomicU64::new(0);
    run_pinned(cores.to_vec(), cores, work, |thread, core| {
        let mut buffers: Vec<Vec<u64>> = sizes.iter().map(|(_, bytes)| vec![0u64; bytes / 8]).collect();
        let mut pass = 0u64;
        loop {
            for (part, buffer) in buffers.iter_mut().enumerate() {
                let corrupt = inject && thread == 0 && pass == 0 && part == 0;
                let hash = fill_and_hash(buffer, splitmix(pass * 16 + part as u64), corrupt);
                let level = &sizes[part].0;
                check.check((pass, part), &[hash], sink, |_, w, g| {
                    format!("core {core} pass {pass} {level}: hash {w:#018x} vs {g:#018x}")
                });
                work.fetch_add(1, Ordering::Relaxed);
            }
            pass += 1;
            if Instant::now() >= deadline {
                break;
            }
        }
        passes.fetch_add(pass, Ordering::Relaxed);
    });
    let levels: Vec<String> = sizes.iter().map(|(l, b)| format!("{l} {}K", b >> 10)).collect();
    Ok(format!(
        "{} cores, {} passes over {}",
        cores.len(),
        passes.load(Ordering::Relaxed),
        levels.join(" / ")
    ))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_selected_kernel_matches_scalar_fma_bit_for_bit() {
        let (_, kernel, _) = pick_kernel();
        let (mut vector, mut scalar) = (initial(3), initial(3));
        kernel(&mut vector, 5000);
        scalar_kernel(&mut scalar, 5000);
        assert_eq!(vector.map(f64::to_bits), scalar.map(f64::to_bits));
    }
}
