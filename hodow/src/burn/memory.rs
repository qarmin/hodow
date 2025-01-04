//! The memory phase: memtester's sixteen tests plus Moving Inversions and Block Copy,
//! written from their descriptions (memtester is GPL-2) and run by one pinned thread per
//! core over its own slice of one large buffer.
//!
//! A round is one write of the whole slice with one pattern and one read of it back.
//! Every expected word is a function of its index and the round, so a mismatch reports
//! the exact address, both values and the bits that differ.

use std::hint::black_box;
use std::sync::atomic::{AtomicU64, Ordering};
use std::time::Instant;

use super::protocol::{MemTest, Msg, send};
use super::worker::{Sink, WorkerError, run_pinned};

const CHECKER: u64 = 0x5555_5555_5555_5555;
const MLOCK_STEP: usize = 1 << 30;

pub fn run(
    test: MemTest,
    mb: u64,
    cores: &[usize],
    deadline: Instant,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) -> Result<String, WorkerError> {
    let threads = cores.len().max(1);
    let words_per_thread = ((mb << 20) / 8 / threads as u64) as usize & !1;
    if words_per_thread < 512 {
        return Err(WorkerError::Skip(format!(
            "{mb} MB is too little to split over {threads} threads"
        )));
    }
    let total = words_per_thread * threads;
    let mut buffer: Vec<u64> = Vec::new();
    buffer
        .try_reserve_exact(total)
        .map_err(|_| WorkerError::Skip(format!("could not allocate {mb} MB")))?;
    buffer.resize(total, 0);
    lock_in_ram(&mut buffer, work);

    let rounds = AtomicU64::new(u64::MAX);
    run_pinned(
        buffer.chunks_mut(words_per_thread).collect(),
        cores,
        work,
        |thread, region| {
            let mut round = 0u64;
            loop {
                one_round(test, round, region, inject && thread == 0 && round == 0, sink, work);
                round += 1;
                if Instant::now() >= deadline {
                    break;
                }
            }
            rounds.fetch_min(round, Ordering::Relaxed);
        },
    );
    let done = rounds.load(Ordering::Relaxed);
    let rounds = match rounds_in_cycle(test) {
        Some(cycle) if done < cycle => format!("{done}/{cycle} patterns"),
        Some(cycle) => format!("{done} rounds ({} full cycles)", done / cycle),
        None => format!("{done} rounds"),
    };
    Ok(format!("{} MB, {threads} threads, {rounds}", (total * 8) >> 20))
}

/// Without `mlock` part of the buffer may sit in swap and the test reads the disk instead.
/// Done in steps so a multi-gigabyte lock still shows progress.
fn lock_in_ram(buffer: &mut [u64], work: &AtomicU64) {
    let bytes = std::mem::size_of_val(buffer);
    let base = buffer.as_mut_ptr() as *mut u8;
    let mut offset = 0;
    while offset < bytes {
        let len = MLOCK_STEP.min(bytes - offset);
        if unsafe { libc::mlock(base.add(offset).cast(), len) } != 0 {
            let e = std::io::Error::last_os_error();
            send(&Msg::Warn {
                msg: format!(
                    "memory cannot be locked ({e}): the buffer may be swapped out, which tests the disk and slows the machine - raise `ulimit -l` or run with CAP_IPC_LOCK, or test less with --ram-mb"
                ),
            });
            return;
        }
        offset += len;
        work.fetch_add(1, Ordering::Relaxed);
    }
}

fn rounds_in_cycle(test: MemTest) -> Option<u64> {
    match test {
        MemTest::StuckAddress => Some(16),
        MemTest::SolidBits | MemTest::Checkerboard => Some(64),
        MemTest::BlockSequential => Some(256),
        MemTest::BitSpread | MemTest::WalkingOnes | MemTest::WalkingZeroes => Some(128),
        MemTest::BitFlip => Some(512),
        MemTest::MovingInversions => Some(8),
        _ => None,
    }
}

pub fn splitmix(x: u64) -> u64 {
    let mut z = x.wrapping_add(0x9E37_79B9_7F4A_7C15);
    z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    z ^ (z >> 31)
}

fn alternating(q: u64) -> impl Fn(usize) -> u64 {
    move |i| if i % 2 == 0 { q } else { !q }
}

fn walking_bit(round: u64) -> u32 {
    let j = (round % 128) as u32;
    if j < 64 { j } else { 127 - j }
}

fn one_round(test: MemTest, round: u64, region: &mut [u64], inject: bool, sink: &Sink, work: &AtomicU64) {
    let seed = splitmix(round ^ 0xB0BA_CAFE);
    let random = move |i: usize| splitmix(i as u64 ^ seed);
    let q = splitmix(seed);
    let sweep = |region: &mut [u64], expected: &dyn Fn(usize) -> u64| {
        fill(region, expected);
        if inject {
            corrupt(region);
        }
        verify(region, sink, expected);
        work.fetch_add(1, Ordering::Relaxed);
    };
    match test {
        MemTest::StuckAddress => {
            let base = region.as_ptr() as u64;
            sweep(region, &|i| {
                let address = base + i as u64 * 8;
                if (i as u64 + round).is_multiple_of(2) {
                    address
                } else {
                    !address
                }
            });
        }
        MemTest::RandomValue => sweep(region, &random),
        MemTest::CompareXor => compare(region, &random, |v| v ^ q, inject, sink, work),
        MemTest::CompareSub => compare(region, &random, |v| v.wrapping_sub(q), inject, sink, work),
        MemTest::CompareMul => compare(region, &random, |v| v.wrapping_mul(q | 1), inject, sink, work),
        MemTest::CompareDiv => compare(region, &random, |v| v / ((q >> 40) | 1), inject, sink, work),
        MemTest::CompareOr => compare(region, &random, |v| v | q, inject, sink, work),
        MemTest::CompareAnd => compare(region, &random, |v| v & q, inject, sink, work),
        MemTest::SequentialIncrement => sweep(region, &|i| (i as u64).wrapping_add(q)),
        MemTest::SolidBits => sweep(region, &alternating(if round.is_multiple_of(2) { !0 } else { 0 })),
        MemTest::BlockSequential => sweep(region, &|_| (round % 256) * 0x0101_0101_0101_0101),
        MemTest::Checkerboard => sweep(
            region,
            &alternating(if round.is_multiple_of(2) { CHECKER } else { !CHECKER }),
        ),
        MemTest::BitSpread => {
            let k = walking_bit(round);
            sweep(region, &alternating((1u64 << k) | (1u64 << ((k + 2) % 64))));
        }
        MemTest::BitFlip => {
            let bit = 1u64 << ((round / 8) % 64);
            sweep(region, &alternating(if round % 2 == 1 { !bit } else { bit }));
        }
        MemTest::WalkingOnes => sweep(region, &|_| 1u64 << walking_bit(round)),
        MemTest::WalkingZeroes => sweep(region, &|_| !(1u64 << walking_bit(round))),
        MemTest::MovingInversions => moving_inversions(region, round, q, inject, sink, work),
        MemTest::BlockCopy => block_copy(region, &random, seed, inject, sink, work),
    }
}

fn fill(region: &mut [u64], expected: &dyn Fn(usize) -> u64) {
    for (i, word) in region.iter_mut().enumerate() {
        *word = expected(i);
    }
    black_box(&mut *region);
}

/// The one word `--selftest` flips, after the write and before the read.
fn corrupt(region: &mut [u64]) {
    let middle = &mut region[region.len() / 2];
    unsafe { std::ptr::write_volatile(middle, *middle ^ (1 << 5)) };
}

fn verify(region: &mut [u64], sink: &Sink, expected: &dyn Fn(usize) -> u64) {
    let region = black_box(region);
    for (i, &got) in region.iter().enumerate() {
        let want = expected(i);
        if got != want {
            report(sink, &region[i], want, got);
        }
    }
}

fn report(sink: &Sink, word: &u64, want: u64, got: u64) {
    sink.record(|| {
        let address = word as *const u64 as usize;
        let physical = physical_address(address).map_or_default(|p| format!(" (phys {p:#x})"));
        let bits: Vec<String> = (0..64)
            .filter(|b| (want ^ got) & (1 << b) != 0)
            .map(|b| b.to_string())
            .collect();
        format!(
            "{address:#x}{physical}: expected {want:#018x} got {got:#018x} (bits {})",
            bits.join(",")
        )
    });
}

/// Fill with random words, rewrite every one through `op` in place, and check the result -
/// memtester's compare tests, against a computed value rather than a second copy.
fn compare(
    region: &mut [u64],
    random: &dyn Fn(usize) -> u64,
    op: impl Fn(u64) -> u64,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) {
    fill(region, random);
    for word in region.iter_mut() {
        *word = op(*word);
    }
    black_box(&mut *region);
    if inject {
        corrupt(region);
    }
    verify(region, sink, &|i| op(random(i)));
    work.fetch_add(1, Ordering::Relaxed);
}

/// Write a pattern upwards, then check-and-invert upwards, then check-and-restore downwards,
/// so a cell disturbed by its neighbours' writes in either direction shows up.
fn moving_inversions(region: &mut [u64], round: u64, random: u64, inject: bool, sink: &Sink, work: &AtomicU64) {
    let pattern = [
        0,
        !0,
        CHECKER,
        !CHECKER,
        0x0F0F_0F0F_0F0F_0F0F,
        0x00FF_00FF_00FF_00FF,
        random,
        !random,
    ][(round % 8) as usize];
    fill(region, &|_| pattern);
    if inject {
        corrupt(region);
    }
    for i in 0..region.len() {
        let got = black_box(region[i]);
        if got != pattern {
            report(sink, &region[i], pattern, got);
        }
        region[i] = !pattern;
    }
    black_box(&mut *region);
    for i in (0..region.len()).rev() {
        let got = black_box(region[i]);
        if got != !pattern {
            report(sink, &region[i], !pattern, got);
        }
        region[i] = pattern;
    }
    verify(region, sink, &|_| pattern);
    work.fetch_add(1, Ordering::Relaxed);
}

/// Copies between the two halves at memcpy speed, which is what saturates the bus.
fn block_copy(
    region: &mut [u64],
    random: &dyn Fn(usize) -> u64,
    seed: u64,
    inject: bool,
    sink: &Sink,
    work: &AtomicU64,
) {
    let (a, b) = region.split_at_mut(region.len() / 2);
    let b = &mut b[..a.len()];
    fill(a, random);
    b.copy_from_slice(black_box(&*a));
    if inject {
        corrupt(b);
    }
    verify(b, sink, random);
    let other = |i: usize| splitmix(i as u64 ^ !seed);
    fill(b, &other);
    a.copy_from_slice(black_box(&*b));
    verify(a, sink, &other);
    work.fetch_add(1, Ordering::Relaxed);
}

/// The physical address behind `virt` from /proc/self/pagemap - what a DRAM chip is found
/// by. Only root gets a page frame number; for anyone else this is `None`.
fn physical_address(virt: usize) -> Option<u64> {
    use std::os::unix::fs::FileExt;
    let page = 4096u64;
    let file = std::fs::File::open("/proc/self/pagemap").ok()?;
    let mut entry = [0u8; 8];
    file.read_exact_at(&mut entry, virt as u64 / page * 8).ok()?;
    let entry = u64::from_le_bytes(entry);
    let pfn = entry & ((1 << 55) - 1);
    (entry >> 63 == 1 && pfn != 0).then(|| pfn * page + virt as u64 % page)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn errors(test: MemTest, inject: bool) -> u64 {
        let sink = Sink::default();
        let work = AtomicU64::new(0);
        let mut region = vec![0u64; 4096];
        for round in 0..rounds_in_cycle(test).unwrap_or(4) {
            one_round(test, round, &mut region, inject && round == 0, &sink, &work);
        }
        sink.count()
    }

    #[test]
    fn every_test_is_clean_on_working_memory_and_catches_a_flipped_bit() {
        for test in MemTest::ALL {
            assert_eq!(errors(test, false), 0, "{test:?} reported an error on healthy memory");
            assert!(errors(test, true) >= 1, "{test:?} missed the injected bit flip");
        }
    }
}
