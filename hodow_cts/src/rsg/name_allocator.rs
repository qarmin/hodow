// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgNameAllocator.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `NameAllocator` hands out short, unique, deterministic identifier strings for
// generated variables/functions: "a".."z", then "aa".."az", "ba".."bz", and so on - a
// bijective base-26 counter over lowercase letters (there is no "a0"/digit column the
// way an ordinary base-26 numbering would have; 26 maps to "z" and 27 to "aa" directly,
// which is what upstream's own `nameNdxToStr` file-local helper (unexported, so this
// port keeps it private too) computes). Upstream's own `\todo` comment on the class
// ("name allocation should be done as a post-pass...") is carried over verbatim since
// nothing in this port addresses it either - it is a statement about a design
// limitation, not something this leaf module could fix on its own.

const ALPHABET_LEN: u32 = (b'z' - b'a') as u32 + 1; // 26

fn name_ndx_to_str(mut name: u32) -> String {
    let mut chars: Vec<char> = Vec::new();

    while name > ALPHABET_LEN {
        let c = b'a' as u32 + ((name - 1) % ALPHABET_LEN);
        chars.insert(0, c as u8 as char);
        name = (name - 1) / ALPHABET_LEN;
    }

    let c = b'a' as u32 + (name % (ALPHABET_LEN + 1)) - 1;
    chars.insert(0, c as u8 as char);

    chars.into_iter().collect()
}

#[derive(Debug, Clone)]
pub struct NameAllocator {
    next_name: u32,
}

impl Default for NameAllocator {
    fn default() -> NameAllocator {
        NameAllocator { next_name: 1 }
    }
}

impl NameAllocator {
    pub fn new() -> NameAllocator {
        NameAllocator::default()
    }

    /// Port of `NameAllocator::allocate` - returns the next name in sequence and
    /// advances the counter.
    pub fn allocate(&mut self) -> String {
        debug_assert!(self.next_name != 0);
        let name = self.next_name;
        self.next_name += 1;
        name_ndx_to_str(name)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn single_letter_names_count_up_from_a() {
        let mut alloc = NameAllocator::new();
        assert_eq!(alloc.allocate(), "a");
        assert_eq!(alloc.allocate(), "b");
        assert_eq!(alloc.allocate(), "c");
    }

    #[test]
    fn the_26th_name_is_z_and_the_27th_rolls_over_to_aa() {
        assert_eq!(name_ndx_to_str(26), "z");
        assert_eq!(name_ndx_to_str(27), "aa");
        assert_eq!(name_ndx_to_str(28), "ab");
    }

    #[test]
    fn two_letter_names_count_up_bijectively_not_like_an_ordinary_base_26_number() {
        // 52 = 27 ("aa") + 25, i.e. the last of the "a?" column, matching the same
        // a..z sequence a single-letter name goes through.
        assert_eq!(name_ndx_to_str(52), "az");
        assert_eq!(name_ndx_to_str(53), "ba");
    }

    #[test]
    fn each_call_allocates_the_next_name_in_sequence() {
        let mut alloc = NameAllocator::new();
        let names: Vec<String> = (0..30).map(|_| alloc.allocate()).collect();
        assert_eq!(names[25], "z");
        assert_eq!(names[26], "aa");
        assert_eq!(names[27], "ab");
        // No two allocations ever repeat.
        let mut sorted = names.clone();
        sorted.sort();
        sorted.dedup();
        assert_eq!(sorted.len(), names.len());
    }
}
