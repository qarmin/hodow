// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrReferenceContext.hpp
//     (the `rc::NamedObject` / `rc::ObjectManager<T>` template)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream splits this into two pieces: `NamedObject`, a base class every GL object
// type inherits for its name + reference count, and `ObjectManager<T>`, a
// `std::map<uint32_t, T*>` that owns the objects and exposes `find`/`acquireReference`/
// `releaseReference` which mutate through the pointers it handed out (`T*`) - the same
// "shared mutable aliasing via a raw pointer into a map I also own" pattern seen
// throughout `rr::Renderer`'s own port. Here, one `ObjectManager<T>` owns `T` by value
// and keeps the reference count itself (`HashMap<u32, (T, refcount)>`), and every
// binding point elsewhere in `sglr::reference_context` stores the object's `u32` name
// instead of a pointer - the same "index into an arena the owner holds `&mut` to"
// translation `rr::primitive_assembler` already uses, for the same reason: looking an
// object up by name, mutate it, and the borrow ends before the next lookup, rather than
// several live aliases needing to agree.

use std::collections::HashMap;

/// `rc::ObjectManager<T>`
pub struct ObjectManager<T> {
    last_name: u32,
    objects: HashMap<u32, (T, u32)>,
}

impl<T> Default for ObjectManager<T> {
    fn default() -> Self {
        Self::new()
    }
}

impl<T> ObjectManager<T> {
    pub fn new() -> Self {
        Self {
            last_name: 0,
            objects: HashMap::new(),
        }
    }

    /// `ObjectManager::allocateName` - upstream's `TCU_CHECK(m_lastName != 0xffffffff)`
    /// becomes a panic: exhausting 4 billion names is not a condition any caller here
    /// can recover from differently.
    pub fn allocate_name(&mut self) -> u32 {
        assert_ne!(self.last_name, u32::MAX, "GL object name space exhausted");
        self.last_name += 1;
        self.last_name
    }

    /// `ObjectManager::insert` - the object starts with a reference count of 1,
    /// matching `NamedObject`'s own constructor.
    pub fn insert(&mut self, name: u32, object: T) {
        debug_assert_ne!(name, 0);
        if name > self.last_name {
            self.last_name = name;
        }
        self.objects.insert(name, (object, 1));
    }

    /// `ObjectManager::find`
    pub fn find(&self, name: u32) -> Option<&T> {
        self.objects.get(&name).map(|(o, _)| o)
    }

    /// `ObjectManager::find`, mutable.
    pub fn find_mut(&mut self, name: u32) -> Option<&mut T> {
        self.objects.get_mut(&name).map(|(o, _)| o)
    }

    /// `ObjectManager::acquireReference`
    pub fn acquire_reference(&mut self, name: u32) {
        let (_, refcount) = self
            .objects
            .get_mut(&name)
            .expect("acquire_reference on an unknown name");
        *refcount += 1;
    }

    /// `ObjectManager::releaseReference` - drops and deallocates the object once its
    /// count reaches zero, same as upstream's `delete object`.
    pub fn release_reference(&mut self, name: u32) {
        let done = {
            let (_, refcount) = self
                .objects
                .get_mut(&name)
                .expect("release_reference on an unknown name");
            debug_assert!(*refcount > 0);
            *refcount -= 1;
            *refcount == 0
        };
        if done {
            self.objects.remove(&name);
        }
    }

    pub fn ref_count(&self, name: u32) -> Option<u32> {
        self.objects.get(&name).map(|(_, rc)| *rc)
    }

    /// `ObjectManager::getCount`
    pub fn count(&self) -> usize {
        self.objects.len()
    }

    /// `ObjectManager::getAll` - names only; the caller already has `find` to get the
    /// object back, and borrowing every object at once is what upstream's raw-pointer
    /// vector could do but a safe Rust iterator over `&T` cannot while also allowing
    /// the caller to mutate the manager in the same loop (`deleteBuffer` does exactly
    /// that - see `reference_context::delete_buffer`).
    pub fn names(&self) -> Vec<u32> {
        self.objects.keys().copied().collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn allocate_name_increments_and_never_repeats() {
        let mut mgr: ObjectManager<i32> = ObjectManager::new();
        assert_eq!(mgr.allocate_name(), 1);
        assert_eq!(mgr.allocate_name(), 2);
        assert_eq!(mgr.allocate_name(), 3);
    }

    #[test]
    fn insert_and_find_round_trips() {
        let mut mgr: ObjectManager<i32> = ObjectManager::new();
        mgr.insert(5, 42);
        assert_eq!(mgr.find(5), Some(&42));
        assert_eq!(mgr.find(6), None);
    }

    #[test]
    fn inserting_a_higher_name_advances_allocate_name() {
        let mut mgr: ObjectManager<i32> = ObjectManager::new();
        mgr.insert(100, 1);
        assert_eq!(mgr.allocate_name(), 101);
    }

    #[test]
    fn reference_counting_frees_at_zero() {
        let mut mgr: ObjectManager<i32> = ObjectManager::new();
        mgr.insert(1, 7);
        mgr.acquire_reference(1); // refcount now 2
        mgr.release_reference(1); // back to 1
        assert!(mgr.find(1).is_some());
        mgr.release_reference(1); // drops to 0, removed
        assert!(mgr.find(1).is_none());
    }

    #[test]
    fn count_reflects_live_objects() {
        let mut mgr: ObjectManager<i32> = ObjectManager::new();
        mgr.insert(1, 1);
        mgr.insert(2, 2);
        assert_eq!(mgr.count(), 2);
        mgr.release_reference(1);
        assert_eq!(mgr.count(), 1);
    }
}
