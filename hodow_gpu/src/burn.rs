//! What the GPU half of `hodow burn` hands back, shared by the OpenGL and Vulkan kernels.
//!
//! Every kernel here is built so its correct output is known without running anything
//! else: a pattern that is a pure function of the index and a seed, or an ALU round trip
//! that must return its own input. A wrong word is therefore the hardware or the driver,
//! never a reference value that drifted.

use std::time::Instant;

pub const MAX_ERROR_SAMPLES: usize = 10;

/// Constants of the ALU round trip. `K1_INV` is `K1`'s inverse mod 2^32, so a forward round
/// followed by an inverse one gives the input back exactly.
pub const ALU_K1: u32 = 0x9E37_79B1;
pub const ALU_K1_INV: u32 = mod_inverse(ALU_K1);
pub const ALU_K2: u32 = 0x7F4A_7C15;
pub const ALU_ROUNDS: u32 = 64;

const fn mod_inverse(a: u32) -> u32 {
    let mut x = a;
    let mut i = 0;
    while i < 5 {
        x = x.wrapping_mul(2u32.wrapping_sub(a.wrapping_mul(x)));
        i += 1;
    }
    x
}

/// The word the memory kernels write at `index` for `seed`; the GLSL/WGSL copies must match.
pub fn pattern_word(index: u32, seed: u32) -> u32 {
    let mut x = index.wrapping_mul(0x9E37_79B1) ^ seed;
    x ^= x >> 16;
    x = x.wrapping_mul(0x7FEB_352D);
    x ^= x >> 15;
    x
}

#[derive(Debug, Clone, Default)]
pub struct BurnReport {
    pub passes: u64,
    pub errors: u64,
    pub samples: Vec<String>,
    pub detail: String,
}

#[derive(Debug, Clone)]
pub enum BurnError {
    /// Nothing was tested: no driver, no compute, not enough memory to start.
    Unsupported(String),
    /// The API itself failed part-way - a finding, not a skip.
    Failed(String),
}

impl BurnReport {
    pub fn record(&mut self, describe: impl FnOnce() -> String) {
        self.errors += 1;
        if self.samples.len() < MAX_ERROR_SAMPLES {
            self.samples.push(describe());
        }
    }

    pub fn check_word(&mut self, location: impl Fn() -> String, expected: u32, got: u32) {
        if expected != got {
            self.record(|| {
                format!(
                    "{}: expected {expected:#010x} got {got:#010x} (bits {})",
                    location(),
                    bit_list(expected ^ got)
                )
            });
        }
    }
}

pub fn bit_list(diff: u32) -> String {
    (0..32)
        .filter(|b| diff & (1 << b) != 0)
        .map(|b| b.to_string())
        .collect::<Vec<_>>()
        .join(",")
}

/// Calls `pass` with the pass index until `deadline`, always at least once. Returns how many ran.
pub fn until(deadline: Instant, mut pass: impl FnMut(u64) -> Result<(), BurnError>) -> Result<u64, BurnError> {
    let mut done = 0;
    loop {
        pass(done)?;
        done += 1;
        if Instant::now() >= deadline {
            return Ok(done);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn alu_round_trip_is_identity() {
        assert_eq!(ALU_K1.wrapping_mul(ALU_K1_INV), 1);
        for seed in [0u32, 1, 0xDEAD_BEEF, u32::MAX] {
            let mut x = seed;
            for r in 0..ALU_ROUNDS {
                x = x.wrapping_mul(ALU_K1);
                x ^= x >> 17;
                x = x.wrapping_add(ALU_K2.wrapping_add(r));
                x = x.rotate_left(5);
            }
            for r in (0..ALU_ROUNDS).rev() {
                x = x.rotate_right(5);
                x = x.wrapping_sub(ALU_K2.wrapping_add(r));
                x ^= x >> 17;
                x = x.wrapping_mul(ALU_K1_INV);
            }
            assert_eq!(x, seed);
        }
    }
}
