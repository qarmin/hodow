// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsStateQueryUtil.hpp / .cpp
//   (deqp::gls::StateQueryUtil::StateQueryMemoryWriteGuard)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::ApiCase;

/// The byte every guarded query buffer starts out filled with.
const WRITE_GUARD_VALUE: u8 = 0xDE;

/// Types a `glGet*v` may write. The bound exists so `Guarded` cannot be instantiated
/// for something where filling every byte with `0xDE` would not be a valid value.
///
/// # Safety
/// Every bit pattern must be a valid value of the type, and it must contain no
/// padding - which holds for the GL scalar types and arrays of them.
pub unsafe trait QueryValue: Copy + PartialEq {}

// SAFETY: all plain-old-data GL query outputs.
unsafe impl QueryValue for u8 {}
unsafe impl QueryValue for i32 {}
unsafe impl QueryValue for f32 {}
unsafe impl QueryValue for u32 {}
unsafe impl QueryValue for i64 {}
unsafe impl<T: QueryValue, const N: usize> QueryValue for [T; N] {}
// SAFETY: `glGetVertexAttribPointerv`'s output. The pointer is only ever compared, never
// dereferenced, so a guard byte pattern in it is as valid as any other address.
unsafe impl QueryValue for *mut std::ffi::c_void {}

/// `gls::StateQueryUtil::StateQueryMemoryWriteGuard` - a query output buffer with a
/// copy of itself on each side.
///
/// The whole thing starts filled with `0xDE`, so afterwards three questions can be
/// asked that a plain output variable cannot answer: did the driver write anything at
/// all, did it write *before* the buffer, and did it write *past* it. All three are
/// real driver bugs and all three are silent without this.
#[repr(C)]
pub struct Guarded<T: QueryValue> {
    preguard: T,
    value: T,
    postguard: T,
}

impl<T: QueryValue> Guarded<T> {
    pub fn new() -> Self {
        // SAFETY: `QueryValue`'s contract is that every bit pattern is valid and the
        // type has no padding, so filling all three fields byte-wise initialises them.
        let mut guard = std::mem::MaybeUninit::<Self>::uninit();
        unsafe {
            std::ptr::write_bytes(guard.as_mut_ptr(), WRITE_GUARD_VALUE, 1);
            guard.assume_init()
        }
    }

    /// The pointer to hand to `glGet*v` - the middle field, so an overrun in either
    /// direction lands in a guard.
    pub fn as_mut_ptr(&mut self) -> *mut T {
        &raw mut self.value
    }

    pub fn value(&self) -> T {
        self.value
    }

    /// `isUndefined` - the driver wrote nothing at all.
    pub fn is_undefined(&self) -> bool {
        self.is_all_guard_bytes(&self.value)
    }

    /// `isPreguardContaminated`
    pub fn is_preguard_contaminated(&self) -> bool {
        !self.is_all_guard_bytes(&self.preguard)
    }

    /// `isPostguardContaminated`
    pub fn is_postguard_contaminated(&self) -> bool {
        !self.is_all_guard_bytes(&self.postguard)
    }

    fn is_all_guard_bytes(&self, field: &T) -> bool {
        // SAFETY: reading a `QueryValue` as bytes is sound - it is plain data of a
        // known size with no padding.
        let bytes = unsafe { std::slice::from_raw_parts((field as *const T).cast::<u8>(), size_of::<T>()) };
        bytes.iter().all(|byte| *byte == WRITE_GUARD_VALUE)
    }

    /// `verifyValidity` - returns false when the value cannot be trusted, in which
    /// case the caller must not compare it against anything.
    pub fn verify_validity(&self, case: &mut ApiCase<'_>) -> bool {
        if self.is_undefined() {
            case.fail("// ERROR: Get* did not return a value".to_string(), "Get* did not return a value");
            return false;
        }
        if self.is_preguard_contaminated() {
            case.fail("// ERROR: Get* wrote over bounds (before)".to_string(), "Get* wrote over bounds");
            return false;
        }
        if self.is_postguard_contaminated() {
            case.fail("// ERROR: Get* wrote over bounds (after)".to_string(), "Get* wrote over bounds");
            return false;
        }
        true
    }
}

impl<T: QueryValue> Default for Guarded<T> {
    fn default() -> Self {
        Self::new()
    }
}
