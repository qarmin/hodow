// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkAllocationCallbackUtil.cpp (getNumRecords)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `AllocationCallbackRecorder::getNumRecords` counts every callback the driver makes,
// frees and internal notifications included. `crate::vk::alloc_callback_util` only
// keeps the live set, which cannot tell "never called" from "allocated and freed again";
// the null-handle tests ask exactly that, so this layers a call counter over it.

use std::ffi::c_void;
use std::sync::atomic::{AtomicUsize, Ordering};

use vulkanalia::vk;

use crate::vk::alloc_callback_util::AllocationCallbackRecorder;

struct Shared {
    records: AtomicUsize,
    inner: vk::AllocationCallbacks,
}

/// An `AllocationCallbackRecorder` that also counts the calls made through it.
pub struct CountingAllocator {
    // Kept alive because `shared.inner.user_data` points into it.
    _inner: AllocationCallbackRecorder,
    shared: Box<Shared>,
    callbacks: Box<vk::AllocationCallbacks>,
}

impl CountingAllocator {
    pub fn new() -> Self {
        let inner = AllocationCallbackRecorder::new();
        let shared = Box::new(Shared {
            records: AtomicUsize::new(0),
            inner: *inner.callbacks(),
        });
        let user_data = (&raw const *shared).cast::<c_void>().cast_mut();
        let callbacks = Box::new(vk::AllocationCallbacks {
            user_data,
            allocation: Some(allocation_callback),
            reallocation: Some(reallocation_callback),
            free: Some(free_callback),
            internal_allocation: Some(internal_allocation_callback),
            internal_free: Some(internal_free_callback),
        });
        Self {
            _inner: inner,
            shared,
            callbacks,
        }
    }

    pub fn callbacks(&self) -> &vk::AllocationCallbacks {
        &self.callbacks
    }

    /// `AllocationCallbackRecorder::getNumRecords`
    pub fn get_num_records(&self) -> usize {
        self.shared.records.load(Ordering::SeqCst)
    }
}

impl Default for CountingAllocator {
    fn default() -> Self {
        Self::new()
    }
}

unsafe fn shared<'a>(user_data: *mut c_void) -> &'a Shared {
    let shared = unsafe { &*user_data.cast::<Shared>() };
    shared.records.fetch_add(1, Ordering::SeqCst);
    shared
}

unsafe extern "system" fn allocation_callback(
    user_data: *mut c_void,
    size: usize,
    alignment: usize,
    scope: vk::SystemAllocationScope,
) -> *mut c_void {
    let shared = unsafe { shared(user_data) };
    match shared.inner.allocation {
        Some(f) => unsafe { f(shared.inner.user_data, size, alignment, scope) },
        None => std::ptr::null_mut(),
    }
}

unsafe extern "system" fn reallocation_callback(
    user_data: *mut c_void,
    original: *mut c_void,
    size: usize,
    alignment: usize,
    scope: vk::SystemAllocationScope,
) -> *mut c_void {
    let shared = unsafe { shared(user_data) };
    match shared.inner.reallocation {
        Some(f) => unsafe { f(shared.inner.user_data, original, size, alignment, scope) },
        None => std::ptr::null_mut(),
    }
}

unsafe extern "system" fn free_callback(user_data: *mut c_void, memory: *mut c_void) {
    let shared = unsafe { shared(user_data) };
    if let Some(f) = shared.inner.free {
        unsafe { f(shared.inner.user_data, memory) };
    }
}

unsafe extern "system" fn internal_allocation_callback(
    user_data: *mut c_void,
    size: usize,
    allocation_type: vk::InternalAllocationType,
    scope: vk::SystemAllocationScope,
) {
    let shared = unsafe { shared(user_data) };
    if let Some(f) = shared.inner.internal_allocation {
        unsafe { f(shared.inner.user_data, size, allocation_type, scope) };
    }
}

unsafe extern "system" fn internal_free_callback(
    user_data: *mut c_void,
    size: usize,
    allocation_type: vk::InternalAllocationType,
    scope: vk::SystemAllocationScope,
) {
    let shared = unsafe { shared(user_data) };
    if let Some(f) = shared.inner.internal_free {
        unsafe { f(shared.inner.user_data, size, allocation_type, scope) };
    }
}
