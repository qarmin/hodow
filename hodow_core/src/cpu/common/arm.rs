#![allow(non_snake_case)]
#![allow(dead_code)]

// Basic ARM/AArch64 helper functions
// TODO: Add proper type helpers for ARM SIMD types when needed

use crate::cpu::common;

// ARM-specific types are not yet fully supported
// This file serves as a placeholder for future ARM test helpers
//
// When ARM types need to be supported, add helper functions similar to x86.rs:
// - create_*_from() functions for creating SIMD types from arrays
// - create_random_*() functions for creating random SIMD values
// - unpack_*_to_*_array() functions for extracting values from SIMD types
