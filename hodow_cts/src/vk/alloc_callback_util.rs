// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkAllocationCallbackUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A `VkAllocationCallbacks` that keeps a ledger of what the driver asked for, so a
// test can ask how much host memory an object cost and whether everything it allocated
// was freed again. Upstream records every call and validates afterwards; this records
// the live set, which is what the ported tests actually read, plus a violation count so
// a mismatched free is not silently ignored.

use std::alloc::{Layout, alloc, dealloc, realloc};
use std::collections::HashMap;
use std::ffi::c_void;
use std::sync::Mutex;

use vulkanalia::vk;

/// The bookkeeping the callbacks write into. Boxed so its address is stable for as
/// long as the driver holds the `VkAllocationCallbacks`.
struct Ledger {
    /// `DeterministicFailAllocator` in MODE_COUNT_AND_FAIL: how many allocations may
    /// still succeed before every later one fails. `None` is MODE_DO_NOT_COUNT - every
    /// allocation goes through.
    remaining_successes: Mutex<Option<u32>>,
    /// Pointer to the layout it was allocated with and the scope it was asked for;
    /// `dealloc` needs the layout back, and `validate` needs the scope.
    live: Mutex<HashMap<usize, (Layout, vk::SystemAllocationScope)>>,
    /// A free or realloc of a pointer this ledger never handed out.
    violations: Mutex<u32>,
}

impl Ledger {
    fn new(remaining_successes: Option<u32>) -> Self {
        Self {
            remaining_successes: Mutex::new(remaining_successes),
            live: Mutex::new(HashMap::new()),
            violations: Mutex::new(0),
        }
    }

    /// Consumes one of the allowed successes, or reports that the budget is spent.
    fn take_success(&self) -> bool {
        let mut remaining = self.remaining_successes.lock().expect("allocation ledger poisoned");
        match *remaining {
            None => true,
            Some(0) => false,
            Some(left) => {
                *remaining = Some(left - 1);
                true
            }
        }
    }
}

/// `AllocationCallbackRecorder`
pub struct AllocationCallbackRecorder {
    // The ledger must outlive the callbacks; both are dropped together, after the
    // driver has been told to free everything.
    ledger: Box<Ledger>,
    callbacks: Box<vk::AllocationCallbacks>,
}

/// `sizeof(void*) * 2` - upstream's estimate of the per-allocation overhead a real
/// system allocator adds, counted on top of the requested bytes.
const SYSTEM_ALLOCATION_OVERHEAD: usize = std::mem::size_of::<*mut c_void>() * 2;

impl AllocationCallbackRecorder {
    pub fn new() -> Self {
        Self::with_budget(None)
    }

    /// `DeterministicFailAllocator` layered under a recorder: the first
    /// `passing_allocations` requests succeed and every later one returns null, which
    /// is how the driver is told it is out of host memory.
    pub fn failing_after(passing_allocations: u32) -> Self {
        Self::with_budget(Some(passing_allocations))
    }

    fn with_budget(remaining_successes: Option<u32>) -> Self {
        let ledger = Box::new(Ledger::new(remaining_successes));
        let user_data = (&raw const *ledger).cast::<c_void>().cast_mut();
        let callbacks = Box::new(vk::AllocationCallbacks {
            user_data,
            allocation: Some(allocation_callback),
            reallocation: Some(reallocation_callback),
            free: Some(free_callback),
            // Internal allocations are the driver telling us about memory it got
            // elsewhere; nothing here has to be freed, so they are only counted as
            // "seen" by being accepted.
            internal_allocation: Some(internal_notification),
            internal_free: Some(internal_notification),
        });
        Self { ledger, callbacks }
    }

    pub fn callbacks(&self) -> &vk::AllocationCallbacks {
        &self.callbacks
    }

    /// `getCurrentSystemMemoryUsage` - the live bytes, plus what a real allocator
    /// would have spent on headers.
    pub fn current_system_memory_usage(&self) -> usize {
        let live = self.ledger.live.lock().expect("allocation ledger poisoned");
        live.values().map(|(layout, _)| layout.size()).sum::<usize>() + SYSTEM_ALLOCATION_OVERHEAD * live.len()
    }

    /// How many allocations are still outstanding. Zero is what
    /// `validateAllocationCallbacks` expects once every object is destroyed.
    pub fn live_allocation_count(&self) -> usize {
        self.ledger.live.lock().expect("allocation ledger poisoned").len()
    }

    /// `DeterministicFailAllocator::reset` - switches between counting-and-failing
    /// (`Some(budget)`) and letting everything through (`None`).
    pub fn set_budget(&self, remaining_successes: Option<u32>) {
        *self.ledger.remaining_successes.lock().expect("allocation ledger poisoned") = remaining_successes;
    }

    /// Frees or reallocations of pointers this recorder never handed out.
    pub fn violations(&self) -> u32 {
        *self.ledger.violations.lock().expect("allocation ledger poisoned")
    }

    /// `validateAllocationCallbacks` narrowed to what the ported tests ask: nothing
    /// was misused, and every allocation still live is in one of `allowed_scopes`
    /// (a bitmask over `VkSystemAllocationScope`).
    pub fn validate(&self, allowed_scopes: u32) -> bool {
        if self.violations() > 0 {
            return false;
        }
        let live = self.ledger.live.lock().expect("allocation ledger poisoned");
        live.values().all(|(_, scope)| allowed_scopes & (1u32 << scope.as_raw()) != 0)
    }
}

impl Default for AllocationCallbackRecorder {
    fn default() -> Self {
        Self::new()
    }
}

/// Vulkan allows any power-of-two alignment; Rust's allocator needs at least 1.
fn layout_for(size: usize, alignment: usize) -> Option<Layout> {
    if size == 0 {
        return None;
    }
    Layout::from_size_align(size, alignment.max(1)).ok()
}

unsafe extern "system" fn allocation_callback(user_data: *mut c_void, size: usize, alignment: usize, scope: vk::SystemAllocationScope) -> *mut c_void {
    let ledger = unsafe { &*user_data.cast::<Ledger>() };
    let Some(layout) = layout_for(size, alignment) else {
        return std::ptr::null_mut();
    };
    if !ledger.take_success() {
        return std::ptr::null_mut();
    }
    let pointer = unsafe { alloc(layout) };
    if pointer.is_null() {
        return std::ptr::null_mut();
    }
    ledger.live.lock().expect("allocation ledger poisoned").insert(pointer as usize, (layout, scope));
    pointer.cast::<c_void>()
}

unsafe extern "system" fn reallocation_callback(user_data: *mut c_void, original: *mut c_void, size: usize, alignment: usize, scope: vk::SystemAllocationScope) -> *mut c_void {
    if original.is_null() {
        return unsafe { allocation_callback(user_data, size, alignment, scope) };
    }
    if size == 0 {
        unsafe { free_callback(user_data, original) };
        return std::ptr::null_mut();
    }

    let ledger = unsafe { &*user_data.cast::<Ledger>() };
    if !ledger.take_success() {
        return std::ptr::null_mut();
    }
    let mut live = ledger.live.lock().expect("allocation ledger poisoned");
    let Some((old_layout, old_scope)) = live.remove(&(original as usize)) else {
        drop(live);
        *ledger.violations.lock().expect("allocation ledger poisoned") += 1;
        return std::ptr::null_mut();
    };
    // Rust's `realloc` keeps the original alignment, so a request that changes it has
    // to go the long way round.
    let new_alignment = alignment.max(1);
    let pointer = if new_alignment == old_layout.align() {
        let pointer = unsafe { realloc(original.cast::<u8>(), old_layout, size) };
        if pointer.is_null() {
            live.insert(original as usize, (old_layout, old_scope));
            return std::ptr::null_mut();
        }
        pointer
    } else {
        let Some(new_layout) = layout_for(size, new_alignment) else {
            live.insert(original as usize, (old_layout, old_scope));
            return std::ptr::null_mut();
        };
        let pointer = unsafe { alloc(new_layout) };
        if pointer.is_null() {
            live.insert(original as usize, (old_layout, old_scope));
            return std::ptr::null_mut();
        }
        unsafe { std::ptr::copy_nonoverlapping(original.cast::<u8>(), pointer, old_layout.size().min(size)) };
        unsafe { dealloc(original.cast::<u8>(), old_layout) };
        pointer
    };
    let new_layout = Layout::from_size_align(size, new_alignment).expect("checked above");
    live.insert(pointer as usize, (new_layout, scope));
    pointer.cast::<c_void>()
}

unsafe extern "system" fn free_callback(user_data: *mut c_void, memory: *mut c_void) {
    if memory.is_null() {
        return;
    }
    let ledger = unsafe { &*user_data.cast::<Ledger>() };
    let layout = ledger.live.lock().expect("allocation ledger poisoned").remove(&(memory as usize));
    match layout {
        Some((layout, _)) => unsafe { dealloc(memory.cast::<u8>(), layout) },
        None => *ledger.violations.lock().expect("allocation ledger poisoned") += 1,
    }
}

unsafe extern "system" fn internal_notification(_user_data: *mut c_void, _size: usize, _allocation_type: vk::InternalAllocationType, _scope: vk::SystemAllocationScope) {}

#[cfg(test)]
mod tests {
    use super::*;

    /// Drives the callbacks the way a driver would and checks the ledger follows.
    #[test]
    fn records_allocations_reallocations_and_frees() {
        let recorder = AllocationCallbackRecorder::new();
        let callbacks = recorder.callbacks();
        let user_data = callbacks.user_data;
        let allocate = callbacks.allocation.expect("set");
        let reallocate = callbacks.reallocation.expect("set");
        let free = callbacks.free.expect("set");

        assert_eq!(recorder.current_system_memory_usage(), 0);

        let a = unsafe { allocate(user_data, 64, 8, vk::SystemAllocationScope::OBJECT) };
        assert!(!a.is_null());
        assert_eq!(recorder.live_allocation_count(), 1);
        assert_eq!(recorder.current_system_memory_usage(), 64 + SYSTEM_ALLOCATION_OVERHEAD);

        let b = unsafe { reallocate(user_data, a, 128, 8, vk::SystemAllocationScope::OBJECT) };
        assert!(!b.is_null());
        assert_eq!(recorder.live_allocation_count(), 1);
        assert_eq!(recorder.current_system_memory_usage(), 128 + SYSTEM_ALLOCATION_OVERHEAD);

        // A realloc that changes alignment takes the copy path, not Rust's realloc.
        let c = unsafe { reallocate(user_data, b, 128, 64, vk::SystemAllocationScope::OBJECT) };
        assert!(!c.is_null());
        assert_eq!(c as usize % 64, 0);
        assert_eq!(recorder.live_allocation_count(), 1);

        unsafe { free(user_data, c) };
        assert_eq!(recorder.live_allocation_count(), 0);
        assert_eq!(recorder.current_system_memory_usage(), 0);
        assert_eq!(recorder.violations(), 0);
        assert!(recorder.validate(0));
    }

    #[test]
    fn validate_rejects_a_live_allocation_outside_the_allowed_scopes() {
        let recorder = AllocationCallbackRecorder::new();
        let callbacks = recorder.callbacks();
        let allocate = callbacks.allocation.expect("set");
        let free = callbacks.free.expect("set");

        let pointer = unsafe { allocate(callbacks.user_data, 32, 8, vk::SystemAllocationScope::COMMAND) };
        let command_only = 1u32 << vk::SystemAllocationScope::COMMAND.as_raw();
        assert!(recorder.validate(command_only));
        assert!(!recorder.validate(1u32 << vk::SystemAllocationScope::OBJECT.as_raw()));
        assert!(!recorder.validate(0));

        unsafe { free(callbacks.user_data, pointer) };
        assert!(recorder.validate(0));
    }

    #[test]
    fn a_budgeted_recorder_fails_every_allocation_past_the_budget() {
        let recorder = AllocationCallbackRecorder::failing_after(2);
        let callbacks = recorder.callbacks();
        let allocate = callbacks.allocation.expect("set");
        let first = unsafe { allocate(callbacks.user_data, 16, 8, vk::SystemAllocationScope::OBJECT) };
        let second = unsafe { allocate(callbacks.user_data, 16, 8, vk::SystemAllocationScope::OBJECT) };
        let third = unsafe { allocate(callbacks.user_data, 16, 8, vk::SystemAllocationScope::OBJECT) };
        assert!(!first.is_null() && !second.is_null());
        assert!(third.is_null());
        assert_eq!(recorder.live_allocation_count(), 2);

        let free = callbacks.free.expect("set");
        unsafe { free(callbacks.user_data, first) };
        unsafe { free(callbacks.user_data, second) };
        assert!(recorder.validate(0));
    }

    #[test]
    fn a_zero_size_allocation_returns_null_and_is_not_recorded() {
        let recorder = AllocationCallbackRecorder::new();
        let callbacks = recorder.callbacks();
        let allocate = callbacks.allocation.expect("set");
        let pointer = unsafe { allocate(callbacks.user_data, 0, 8, vk::SystemAllocationScope::OBJECT) };
        assert!(pointer.is_null());
        assert_eq!(recorder.live_allocation_count(), 0);
    }

    #[test]
    fn freeing_a_foreign_pointer_is_a_violation() {
        let recorder = AllocationCallbackRecorder::new();
        let callbacks = recorder.callbacks();
        let free = callbacks.free.expect("set");
        let mut stack = 0u64;
        unsafe { free(callbacks.user_data, (&raw mut stack).cast::<c_void>()) };
        assert_eq!(recorder.violations(), 1);
    }
}
