// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgVariableManager.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's own file-top doc comment states its memory model outright: "Variable
// manager owns variable objects until they are either explicitly removed or moved to
// currently active scope. After that the ownership is transferred to Scope...". In
// C++ that means a `Variable*`/`ValueEntry*` is handed between owning
// `std::vector<T*>`s at runtime (`VariableScope`/`ValueScope`'s own `m_declared
// Variables`/`m_liveVariables`/`m_entries`), each scope's destructor deleting whatever
// it still holds.
//
// **This port replaces that with the index/handle-into-one-owned-arena shape this
// project's own `rr::primitive_assembler` redesign already established as the fix for
// the same class of problem**: `VariableManager` owns two arenas, `Vec<Box<Variable>>`
// (see that field's own doc comment for why `Box<Variable>`, not plain `Variable` -
// needed once a `&Variable` reference has to outlive a *later* `allocate` call, which
// `rsg::expression`'s `VariableRead`/`VariableWrite` do) and `Vec<ValueEntry>`, indexed by the
// opaque `VariableId`/`ValueEntryId` newtypes defined below. Neither arena ever frees
// an individual slot - everything is dropped together when the owning
// `VariableManager` itself is - which is a deliberate, acceptable simplification for a
// tool that builds one shader's worth of AST per run, not a long-running service:
// upstream's own explicit `delete`s exist only because C++ has no other way to reclaim
// memory, not because anything here depends on reclaiming it promptly. `VariableScope`/
// `ValueScope` hold `Vec<VariableId>`/`Vec<ValueEntryId>` instead of owning pointers, so
// "ownership transferred to Scope" becomes "the handle
// is copied into a different index list" - a plain `Copy`, never a move of owned data,
// which is what makes `popVariableScope`'s live-variable migration (moving entries
// between two scopes' own lists) trivial to translate directly below.
//
// **`VariableScope`/`ValueScope` are pushed/popped *by value*, not held as a `&mut`
// borrow for the scope's own lifetime like upstream's raw pointer.** This is not just
// a style choice - it is required by a real aliasing pattern confirmed by reading the
// one call site upstream actually has (`rsgShaderGenerator.cpp::ShaderGenerator::
// generate`, not yet ported): `VariableScope &globalVariableScope = shader.
// getGlobalScope(); m_varManager.pushVariableScope(globalVariableScope); ... /* still
// pushed */ ... globalVariableScope.getLiveVariables() /* read directly, concurrently
// with the manager's own pointer to the same object */ ... m_varManager.
// popVariableScope();`. A Rust translation that stores `&'a mut VariableScope` inside
// the manager for the whole push/pop span cannot also let the external owner read the
// same object while it is pushed - the borrow checker will not allow two live
// references, mutable-and-shared, to the same place, regardless of what is stored
// inside the scope. Taking the scope by value instead (the manager owns a `Vec
// <VariableScope>`/`Vec<ValueScope>` stack of its own) and handing the finished scope
// *back* from `pop_variable_scope`/`pop_value_scope` removes the aliasing problem
// entirely, at the cost of the caller no longer being able to read the scope's
// contents through its own local variable while it is still pushed - **whoever ports
// `ShaderGenerator` next should route that read through `VariableManager::
// get_live_variables()` instead** (already present below, and already what `upstream`'s
// own `VariableManager::getLiveVariables()` forwards to internally), not keep a second,
// separately-held reference to the same scope.
//
// **`NameAllocator` is held as `&'a mut`, matching its only real ownership chain**:
// `GeneratorState` (`rsg::generator_state`, ported since - see that module's own doc
// comment, including the `name_allocator` field this exact ownership chain predicted)
// owns one `NameAllocator` by value and lends it exclusively to the one
// `VariableManager` it constructs
// (`ShaderGenerator::ShaderGenerator`'s own `m_varManager(state.getNameAllocator())`,
// confirmed by grep - nothing else reads it concurrently), so a plain mutable borrow is
// the direct, safe translation here, unlike the scope-stack case above.
//
// **`SubValueRangeIterator` (defined at the top of the upstream `.cpp`) is dead code,
// not ported**: declared, defined, and never called anywhere in `framework/
// randomshaders/` at all (confirmed by grep across the whole directory, not just this
// file) - it has no reachable call site even from the file that defines it. This is the
// same class of finding as `Variable::isWritable` (declared, never defined) noted in
// `rsg::variable`'s own doc comment, just the opposite shape (defined, never called).
//
// **The `FilteredIterator`/`ValueEntryIterator` custom-iterator template plus the
// `AnyEntry`/`IsWritableEntry`/`EntryStorageFilter<Storage>` "common filters" collapse
// onto `Iterator::filter`**, exactly as predicted before this file was read: `
// VariableManager::entries_matching`/`has_entry` take a plain `Fn(&VariableManager,
// ValueEntryId) -> bool`, and the free functions `any_entry`/`is_writable_entry`/
// `entry_storage_filter`/`local_entry_filter`/`shader_in_entry_filter`/
// `shader_out_entry_filter` below are that same shape, replacing upstream's generic
// `EntryStorageFilter<Variable::Storage>` instantiations (`Storage` is a plain enum
// here, not a type needing its own monomorphised filter class per value).
//
// **`VariableScope::allocate`/`ValueScope::allocate` are ported as instance methods
// that take the relevant arena as an explicit parameter**, rather than folded away -
// both still need to mutate their own `live_variables`/`entries` index list *and*
// append to an arena neither of them owns outright, so threading the arena through as
// a parameter (the common Rust pattern for this exact shape, e.g. `petgraph`'s
// `NodeIndex` against a `Graph`) keeps both as genuine methods on their own types,
// matching upstream's public API shape, rather than inlining their bodies into
// `VariableManager` just because it is their only caller today.

use std::collections::{HashMap, HashSet};

use super::name_allocator::NameAllocator;
use super::variable::{Storage, Variable};
use super::variable_type::VariableType;
use super::variable_value::{ConstValueRangeAccess, ValueRange, ValueRangeAccess};

/// Opaque handle into `VariableManager`'s own `Variable` arena - see this module's top
/// doc comment for why this replaces upstream's `Variable*`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct VariableId(usize);

/// Opaque handle into `VariableManager`'s own `ValueEntry` arena - see this module's
/// top doc comment for why this replaces upstream's `ValueEntry*`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ValueEntryId(usize);

/// `rsg::ValueEntry`
pub struct ValueEntry {
    variable: VariableId,
    value_range: ValueRange,
}

impl ValueEntry {
    fn new(variable_id: VariableId, variable: &Variable) -> Self {
        Self {
            variable: variable_id,
            value_range: ValueRange::new(variable.get_type().clone()),
        }
    }

    pub fn get_variable(&self) -> VariableId {
        self.variable
    }

    pub fn get_value_range(&mut self) -> ValueRangeAccess<'_> {
        self.value_range.as_access()
    }

    pub fn get_value_range_const(&self) -> ConstValueRangeAccess<'_> {
        self.value_range.as_const_access()
    }
}

/// `rsg::VariableScope` - manages variable allocation within one lexical scope. See
/// this module's top doc comment for why this holds `VariableId` handles rather than
/// owning `Variable` objects, and why it is pushed/popped by value.
#[derive(Debug, Clone, Default)]
pub struct VariableScope {
    /// Variables declared in this scope. Not available for expressions.
    declared_variables: Vec<VariableId>,
    /// Live variables (available for expressions) that can be declared in this scope.
    live_variables: Vec<VariableId>,
}

impl VariableScope {
    pub fn new() -> Self {
        Self::default()
    }

    /// `VariableScope::allocate` - constructs a new `Variable` in `arena`, registers it
    /// as live in this scope, and returns its handle.
    ///
    /// `Vec<Box<Variable>>`, not `Vec<Variable>` - see the field doc comment on
    /// `VariableManager::variables` for why the extra indirection is deliberate here,
    /// not the redundant one `clippy::vec_box` normally warns about.
    #[allow(clippy::vec_box)]
    pub fn allocate(
        &mut self,
        arena: &mut Vec<Box<Variable>>,
        type_: VariableType,
        storage: Storage,
        name: &str,
    ) -> VariableId {
        let id = VariableId(arena.len());
        arena.push(Box::new(Variable::new(type_, storage, name)));
        self.live_variables.push(id);
        id
    }

    /// `VariableScope::declare` - move from live set to declared set.
    pub fn declare(&mut self, variable_id: VariableId) {
        self.declared_variables.push(variable_id);
        self.remove_live(variable_id);
    }

    /// `VariableScope::removeLive` - just remove from live set (when migrating to parent).
    pub fn remove_live(&mut self, variable_id: VariableId) {
        let pos = self
            .live_variables
            .iter()
            .position(|&id| id == variable_id)
            .expect("VariableScope::remove_live: variable not in live set");
        self.live_variables.remove(pos);
    }

    pub fn get_declared_variables(&self) -> &[VariableId] {
        &self.declared_variables
    }

    pub fn get_live_variables(&self) -> &[VariableId] {
        &self.live_variables
    }
}

/// `rsg::ValueScope` - see `VariableScope`'s own doc comment for the same handle-based
/// reasoning, applied to `ValueEntry`/`ValueEntryId`.
#[derive(Debug, Clone, Default)]
pub struct ValueScope {
    entries: Vec<ValueEntryId>,
}

impl ValueScope {
    pub fn new() -> Self {
        Self::default()
    }

    /// `ValueScope::allocate`
    pub fn allocate(
        &mut self,
        arena: &mut Vec<ValueEntry>,
        variable_id: VariableId,
        variable: &Variable,
    ) -> ValueEntryId {
        let id = ValueEntryId(arena.len());
        arena.push(ValueEntry::new(variable_id, variable));
        self.entries.push(id);
        id
    }

    /// `ValueScope::findEntry`
    pub fn find_entry(&self, arena: &[ValueEntry], variable_id: VariableId) -> Option<ValueEntryId> {
        self.entries
            .iter()
            .copied()
            .find(|&id| arena[id.0].variable == variable_id)
    }

    /// `ValueScope::setValue`
    pub fn set_value(&self, arena: &mut [ValueEntry], variable_id: VariableId, value: &ConstValueRangeAccess<'_>) {
        let id = self
            .find_entry(arena, variable_id)
            .expect("ValueScope::set_value: entry must exist");
        let entry = &mut arena[id.0];
        let mut dst = entry.get_value_range();
        dst.get_min().assign_from(&value.get_min().value());
        dst.get_max().assign_from(&value.get_max().value());
    }

    /// `ValueScope::removeValue`
    pub fn remove_value(&mut self, arena: &[ValueEntry], variable_id: VariableId) {
        if let Some(pos) = self.entries.iter().position(|&id| arena[id.0].variable == variable_id) {
            self.entries.remove(pos);
        }
    }

    pub fn get_values(&self) -> &[ValueEntryId] {
        &self.entries
    }

    pub fn clear(&mut self) {
        self.entries.clear();
    }
}

/// `rsg::ReservedScalars`
#[derive(Debug, Clone, Copy, Default)]
pub struct ReservedScalars {
    pub num_scalars: i32,
}

/// `rsg::VariableManager`
pub struct VariableManager<'a> {
    variable_scope_stack: Vec<VariableScope>,
    value_scope_stack: Vec<ValueScope>,

    // `Box<Variable>` (not `Variable`), so a `&Variable` handed out via `get_variable`
    // stays valid even if this `Vec` itself reallocates on a later `allocate` - the
    // heap slot the `Box` points at never moves, matching upstream's own
    // individually-`new`-allocated, pointer-stable `Variable` objects. Needed by
    // `rsg::execution_context`'s pointer-identity `VarKey` (see that module's own top
    // doc comment for the caveat this resolves) once `rsg::expression`'s
    // `VariableRead`/`VariableWrite` hold a variable across more than one `allocate`
    // call.
    #[allow(clippy::vec_box)]
    variables: Vec<Box<Variable>>,
    value_entries: Vec<ValueEntry>,

    /// For faster value entry access.
    entry_cache: Vec<ValueEntryId>,

    num_allocated_scalars: i32,
    num_allocated_shader_in_scalars: i32,
    num_allocated_shader_in_variables: i32,
    num_allocated_uniform_scalars: i32,

    name_allocator: &'a mut NameAllocator,
}

impl<'a> VariableManager<'a> {
    pub fn new(name_allocator: &'a mut NameAllocator) -> Self {
        Self {
            variable_scope_stack: Vec::new(),
            value_scope_stack: Vec::new(),
            variables: Vec::new(),
            value_entries: Vec::new(),
            entry_cache: Vec::new(),
            num_allocated_scalars: 0,
            num_allocated_shader_in_scalars: 0,
            num_allocated_shader_in_variables: 0,
            num_allocated_uniform_scalars: 0,
            name_allocator,
        }
    }

    /// Rebuilds a manager around an arena `into_variables` handed out earlier, so a finished
    /// shader's `VariableId`s resolve again after the generator's own manager is gone.
    #[allow(clippy::vec_box)]
    pub fn from_variables(name_allocator: &'a mut NameAllocator, variables: Vec<Box<Variable>>) -> Self {
        let mut manager = Self::new(name_allocator);
        manager.variables = variables;
        manager
    }

    /// Gives the variable arena back, see `rsg::shader::Shader::set_variables`.
    #[allow(clippy::vec_box)]
    pub fn into_variables(self) -> Vec<Box<Variable>> {
        self.variables
    }

    pub fn get_num_allocated_scalars(&self) -> i32 {
        self.num_allocated_scalars
    }
    pub fn get_num_allocated_shader_in_scalars(&self) -> i32 {
        self.num_allocated_shader_in_scalars
    }
    pub fn get_num_allocated_shader_in_variables(&self) -> i32 {
        self.num_allocated_shader_in_variables
    }
    pub fn get_num_allocated_uniform_scalars(&self) -> i32 {
        self.num_allocated_uniform_scalars
    }

    pub fn get_variable(&self, id: VariableId) -> &Variable {
        self.variables[id.0].as_ref()
    }

    /// `VariableManager::allocate`'s own return type is a non-`const Variable*`, so
    /// every real upstream call site that just allocated a variable can mutate it
    /// in place (`rsgShaderGenerator.cpp`'s `fragColorVar->setLayoutLocation(0)` is the
    /// one real caller this port has so far). Not needed until `rsg::shader_generator`
    /// reached for it - every earlier module in this cluster only ever needed the
    /// shared `get_variable` above.
    pub fn get_variable_mut(&mut self, id: VariableId) -> &mut Variable {
        self.variables[id.0].as_mut()
    }

    pub fn get_entry(&self, id: ValueEntryId) -> &ValueEntry {
        &self.value_entries[id.0]
    }

    /// `VariableManager::reserve`
    pub fn reserve(&mut self, store: &mut ReservedScalars, num_scalars: i32) {
        debug_assert_eq!(store.num_scalars, 0);
        store.num_scalars = num_scalars;
        self.num_allocated_scalars += num_scalars;
    }

    /// `VariableManager::release`
    pub fn release(&mut self, store: &mut ReservedScalars) {
        self.num_allocated_scalars -= store.num_scalars;
        store.num_scalars = 0;
    }

    /// `VariableManager::allocate(const VariableType&)` - names the variable itself via
    /// the shared `NameAllocator` and defaults it to local storage.
    pub fn allocate(&mut self, type_: VariableType) -> VariableId {
        let name = self.name_allocator.allocate();
        self.allocate_named(type_, Storage::Local, &name)
    }

    /// `VariableManager::allocate(const VariableType&, Storage, const char*)`
    pub fn allocate_named(&mut self, type_: VariableType, storage: Storage, name: &str) -> VariableId {
        let num_scalars = type_.scalar_size();

        // Allocate in current scope (always as local storage first - matches upstream,
        // which hardcodes `Variable::STORAGE_LOCAL` here regardless of `storage` and
        // only applies the real request afterward via `setStorage`).
        let variable_id = {
            let scope = self
                .variable_scope_stack
                .last_mut()
                .expect("VariableManager::allocate_named: no active variable scope");
            scope.allocate(&mut self.variables, type_, Storage::Local, name)
        };

        // Allocate value entry.
        let value_entry_id = {
            let variable_ref = &self.variables[variable_id.0];
            let scope = self
                .value_scope_stack
                .last_mut()
                .expect("VariableManager::allocate_named: no active value scope");
            scope.allocate(&mut self.value_entries, variable_id, variable_ref)
        };

        // Add to cache.
        self.entry_cache.push(value_entry_id);

        self.num_allocated_scalars += num_scalars;

        // Set actual storage - affects uniform/shader-in allocations.
        self.set_storage(variable_id, storage);

        variable_id
    }

    /// `VariableManager::setStorage`
    pub fn set_storage(&mut self, variable_id: VariableId, storage: Storage) {
        let num_scalars = self.variables[variable_id.0].get_type().scalar_size();

        // Decrement old.
        match self.variables[variable_id.0].get_storage() {
            Storage::ShaderIn => {
                self.num_allocated_shader_in_scalars -= num_scalars;
                self.num_allocated_shader_in_variables -= 1;
            }
            Storage::Uniform => self.num_allocated_uniform_scalars -= num_scalars,
            _ => {}
        }

        // Add new.
        match storage {
            Storage::ShaderIn => {
                self.num_allocated_shader_in_scalars += num_scalars;
                self.num_allocated_shader_in_variables += 1;
            }
            Storage::Uniform => self.num_allocated_uniform_scalars += num_scalars,
            _ => {}
        }

        self.variables[variable_id.0].set_storage(storage);
    }

    /// `VariableManager::setValue`
    pub fn set_value(&mut self, variable_id: VariableId, value: &ConstValueRangeAccess<'_>) {
        let has_entry = self
            .value_scope_stack
            .last()
            .expect("VariableManager::set_value: no active value scope")
            .find_entry(&self.value_entries, variable_id)
            .is_some();

        if !has_entry {
            // New value, allocate and update cache.
            let new_entry_id = {
                let variable_ref = &self.variables[variable_id.0];
                let scope = self
                    .value_scope_stack
                    .last_mut()
                    .expect("VariableManager::set_value: no active value scope");
                scope.allocate(&mut self.value_entries, variable_id, variable_ref)
            };

            if let Some(pos) = self
                .entry_cache
                .iter()
                .position(|&id| self.value_entries[id.0].variable == variable_id)
            {
                self.entry_cache[pos] = new_entry_id;
            } else {
                self.entry_cache.push(new_entry_id);
            }
        }

        let scope = self
            .value_scope_stack
            .last()
            .expect("VariableManager::set_value: no active value scope");
        scope.set_value(&mut self.value_entries, variable_id, value);
    }

    /// `VariableManager::getValue`
    pub fn get_value(&self, variable_id: VariableId) -> Option<&ValueEntry> {
        self.entry_cache
            .iter()
            .find(|&&id| self.value_entries[id.0].variable == variable_id)
            .map(|&id| &self.value_entries[id.0])
    }

    /// `VariableManager::getParentValue`
    pub fn get_parent_value(&self, variable_id: VariableId) -> Option<&ValueEntry> {
        if self.value_scope_stack.len() < 2 {
            return None; // Only a single value scope.
        }

        for scope in self.value_scope_stack[..self.value_scope_stack.len() - 1].iter().rev() {
            if let Some(id) = scope.find_entry(&self.value_entries, variable_id) {
                return Some(&self.value_entries[id.0]);
            }
        }

        None // Not found in stack.
    }

    /// `VariableManager::removeValueFromCurrentScope`
    pub fn remove_value_from_current_scope(&mut self, variable_id: VariableId) {
        let pos = self
            .entry_cache
            .iter()
            .position(|&id| self.value_entries[id.0].variable == variable_id)
            .expect("VariableManager::remove_value_from_current_scope: variable has no cached value entry");
        self.entry_cache.remove(pos);

        // Remove from current scope - \note may not exist in there.
        let scope = self
            .value_scope_stack
            .last_mut()
            .expect("VariableManager::remove_value_from_current_scope: no active value scope");
        scope.remove_value(&self.value_entries, variable_id);
    }

    /// `VariableManager::declareVariable`
    pub fn declare_variable(&mut self, variable_id: VariableId) {
        // Remove from cache if it exists there.
        if let Some(pos) = self
            .entry_cache
            .iter()
            .position(|&id| self.value_entries[id.0].variable == variable_id)
        {
            self.entry_cache.remove(pos);
        }
        debug_assert!(
            self.entry_cache
                .iter()
                .all(|&id| self.value_entries[id.0].variable != variable_id)
        );

        // Remove from scope stack.
        for scope in &mut self.value_scope_stack {
            scope.remove_value(&self.value_entries, variable_id);
        }

        // Declare in current scope.
        let scope = self
            .variable_scope_stack
            .last_mut()
            .expect("VariableManager::declare_variable: no active variable scope");
        scope.declare(variable_id);
    }

    /// `VariableManager::canDeclareInCurrentScope`
    pub fn can_declare_in_current_scope(&self, variable_id: VariableId) -> bool {
        self.variable_scope_stack
            .last()
            .expect("VariableManager::can_declare_in_current_scope: no active variable scope")
            .get_live_variables()
            .contains(&variable_id)
    }

    /// `VariableManager::getLiveVariables`
    pub fn get_live_variables(&self) -> &[VariableId] {
        self.variable_scope_stack
            .last()
            .expect("VariableManager::get_live_variables: no active variable scope")
            .get_live_variables()
    }

    /// `VariableManager::pushVariableScope` - see this module's top doc comment for why
    /// this takes the scope by value rather than by reference.
    pub fn push_variable_scope(&mut self, scope: VariableScope) {
        debug_assert!(scope.get_declared_variables().is_empty());
        debug_assert!(scope.get_live_variables().is_empty());
        self.variable_scope_stack.push(scope);
    }

    /// `VariableManager::popVariableScope` - returns the popped scope (now holding its
    /// final declared-variable list) back to the caller, in place of upstream handing
    /// back nothing and leaving the caller's own reference to read afterward.
    pub fn pop_variable_scope(&mut self) -> VariableScope {
        // Migrate live variables to parent scope.
        // Variables allocated in child scopes can be declared in any parent scope but
        // not the other way around.
        if self.variable_scope_stack.len() > 1 {
            let len = self.variable_scope_stack.len();
            let (rest, last) = self.variable_scope_stack.split_at_mut(len - 1);
            let parent = &mut rest[len - 2];
            let cur = &mut last[0];

            while let Some(live_var) = cur.live_variables.pop() {
                parent.live_variables.push(live_var);
            }
        }

        let scope = self
            .variable_scope_stack
            .pop()
            .expect("VariableManager::pop_variable_scope: no active variable scope");

        // All variables should be either migrated to parent or declared (in case of
        // the root scope).
        debug_assert!(scope.get_live_variables().is_empty());

        scope
    }

    /// `VariableManager::pushValueScope`
    pub fn push_value_scope(&mut self, scope: ValueScope) {
        debug_assert!(scope.get_values().is_empty());
        self.value_scope_stack.push(scope);
    }

    /// `VariableManager::popValueScope` - rebuilds the entry cache from the remaining
    /// scope stack, intersecting any value the popped scope shares with an
    /// already-set-elsewhere variable, exactly as upstream does.
    pub fn pop_value_scope(&mut self) -> ValueScope {
        let old_scope = self
            .value_scope_stack
            .pop()
            .expect("VariableManager::pop_value_scope: no active value scope");

        // Pop scope and clear cache.
        self.entry_cache.clear();

        if !self.value_scope_stack.is_empty() {
            // Speed up computing intersections.
            let mut old_values: HashMap<VariableId, ValueEntryId> = HashMap::new();
            for &id in &old_scope.entries {
                old_values.insert(self.value_entries[id.0].variable, id);
            }

            let mut added_vars: HashSet<VariableId> = HashSet::new();

            // Re-build based on current stack, from the new top scope down to the root.
            for scope_ndx in (0..self.value_scope_stack.len()).rev() {
                let entry_ids = self.value_scope_stack[scope_ndx].entries.clone();

                for entry_id in entry_ids {
                    let var = self.value_entries[entry_id.0].variable;

                    if added_vars.contains(&var) {
                        continue; // Already in cache, set deeper in the scope stack.
                    }

                    if let Some(&old_entry_id) = old_values.get(&var) {
                        // Build new intersected value and store into current (top) scope.
                        let intersected = {
                            let entry_range = self.value_entries[entry_id.0].get_value_range_const();
                            let old_range = self.value_entries[old_entry_id.0].get_value_range_const();
                            debug_assert!(old_range.intersects(&entry_range)); // Must intersect.

                            let mut dst = ValueRange::new(self.variables[var.0].get_type().clone());
                            ValueRange::compute_intersection(&mut dst, &entry_range, &old_range);
                            dst
                        };

                        let top_ndx = self.value_scope_stack.len() - 1;
                        let top_entry_id = match self.value_scope_stack[top_ndx].find_entry(&self.value_entries, var) {
                            Some(id) => id,
                            None => {
                                let variable_ref = &self.variables[var.0];
                                self.value_scope_stack[top_ndx].allocate(&mut self.value_entries, var, variable_ref)
                            }
                        };

                        {
                            let src_min = intersected.get_min_const().value();
                            let src_max = intersected.get_max_const().value();
                            let entry = &mut self.value_entries[top_entry_id.0];
                            let mut dst = entry.get_value_range();
                            dst.get_min().assign_from(&src_min);
                            dst.get_max().assign_from(&src_max);
                        }

                        // Add entry from top scope to cache.
                        self.entry_cache.push(top_entry_id);
                    } else {
                        self.entry_cache.push(entry_id); // Just add to cache.
                    }

                    added_vars.insert(var); // Record as cached variable.
                }
            }

            // Copy entries from popped scope that don't yet exist in the stack.
            for &entry_id in &old_scope.entries {
                let var = self.value_entries[entry_id.0].variable;
                if !added_vars.contains(&var) {
                    let owned_range = ValueRange::from_access(&self.value_entries[entry_id.0].get_value_range_const());
                    self.set_value(var, &owned_range.as_const_access());
                }
            }
        }

        old_scope
    }

    /// `VariableManager::getBegin`/`getEnd` - upstream's custom `FilteredIterator`
    /// apparatus collapses directly onto `Iterator::filter`, see this module's top doc
    /// comment.
    pub fn entries_matching<'m>(
        &'m self,
        filter: impl Fn(&VariableManager, ValueEntryId) -> bool + 'm,
    ) -> impl Iterator<Item = ValueEntryId> + 'm {
        self.entry_cache.iter().copied().filter(move |&id| filter(self, id))
    }

    /// `VariableManager::hasEntry`
    pub fn has_entry(&self, filter: impl Fn(&VariableManager, ValueEntryId) -> bool) -> bool {
        self.entry_cache.iter().any(|&id| filter(self, id))
    }
}

// Common filters - see this module's top doc comment for why these are plain functions
// rather than upstream's `AnyEntry`/`IsWritableEntry`/`EntryStorageFilter<Storage>`
// function-object classes.

/// `rsg::AnyEntry`
pub fn any_entry(_mgr: &VariableManager, _id: ValueEntryId) -> bool {
    true
}

/// `rsg::IsWritableEntry`
pub fn is_writable_entry(mgr: &VariableManager, id: ValueEntryId) -> bool {
    matches!(
        mgr.get_variable(mgr.get_entry(id).get_variable()).get_storage(),
        Storage::Local | Storage::ShaderOut | Storage::ParameterIn | Storage::ParameterOut | Storage::ParameterInout
    )
}

/// `rsg::EntryStorageFilter<Storage>` - parameterised directly over a `Storage` value
/// rather than a const-generic/type-template instantiation per storage class.
pub fn entry_storage_filter(mgr: &VariableManager, id: ValueEntryId, storage: Storage) -> bool {
    mgr.get_variable(mgr.get_entry(id).get_variable()).get_storage() == storage
}

/// `rsg::LocalEntryFilter`
pub fn local_entry_filter(mgr: &VariableManager, id: ValueEntryId) -> bool {
    entry_storage_filter(mgr, id, Storage::Local)
}
/// `rsg::ShaderInEntryFilter`
pub fn shader_in_entry_filter(mgr: &VariableManager, id: ValueEntryId) -> bool {
    entry_storage_filter(mgr, id, Storage::ShaderIn)
}
/// `rsg::ShaderOutEntryFilter`
pub fn shader_out_entry_filter(mgr: &VariableManager, id: ValueEntryId) -> bool {
    entry_storage_filter(mgr, id, Storage::ShaderOut)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::variable_type::Type;

    fn setup<'a>(alloc: &'a mut NameAllocator) -> VariableManager<'a> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    #[test]
    fn allocate_set_value_and_get_value_round_trip() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate(VariableType::new_basic(Type::Float, 1));
        assert_eq!(mgr.get_variable(v).get_name(), "a"); // First name_allocator.allocate().

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        range.get_min().set_float(1.0);
        range.get_max().set_float(2.0);
        mgr.set_value(v, &range.as_const_access());

        let entry = mgr.get_value(v).expect("value must exist after set_value");
        let access = entry.get_value_range_const();
        assert_eq!(access.get_min().as_float(), 1.0);
        assert_eq!(access.get_max().as_float(), 2.0);
    }

    /// Regression test for the `Vec<Box<Variable>>` fix: a `&Variable` taken before a
    /// later `allocate` call (which may reallocate the backing `Vec`'s own spine) must
    /// still point at the same, valid `Variable` afterwards - this is exactly the
    /// guarantee `rsg::execution_context`'s pointer-identity `VarKey` depends on once a
    /// `VariableRead`/`VariableWrite` holds a `&Variable` across further allocations.
    #[test]
    fn a_borrowed_variable_reference_survives_further_allocations_that_may_reallocate_the_arena() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let first = mgr.allocate(VariableType::new_basic(Type::Int, 1));
        let first_ptr: *const Variable = mgr.get_variable(first);

        // Allocate enough further variables to force the arena's own `Vec` to grow
        // and reallocate its spine at least once.
        for _ in 0..64 {
            mgr.allocate(VariableType::new_basic(Type::Float, 1));
        }

        // The earlier pointer must still resolve to the very same `Variable` - its
        // address must not have moved, and its contents must be untouched.
        assert!(std::ptr::eq(first_ptr, mgr.get_variable(first)));
        assert_eq!(
            mgr.get_variable(first).get_type(),
            &VariableType::new_basic(Type::Int, 1)
        );
    }

    #[test]
    fn allocate_named_defaults_to_local_then_applies_the_requested_storage() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate_named(VariableType::new_basic(Type::Float, 4), Storage::ShaderIn, "a_in");
        assert_eq!(mgr.get_variable(v).get_storage(), Storage::ShaderIn);
        assert_eq!(mgr.get_num_allocated_scalars(), 4);
        assert_eq!(mgr.get_num_allocated_shader_in_scalars(), 4);
        assert_eq!(mgr.get_num_allocated_shader_in_variables(), 1);

        // Re-pointing the same variable to uniform storage decrements shader-in and
        // increments uniform, matching `VariableManager::setStorage`'s own symmetric
        // decrement-old/add-new shape.
        mgr.set_storage(v, Storage::Uniform);
        assert_eq!(mgr.get_num_allocated_shader_in_scalars(), 0);
        assert_eq!(mgr.get_num_allocated_shader_in_variables(), 0);
        assert_eq!(mgr.get_num_allocated_uniform_scalars(), 4);
    }

    /// `get_variable_mut` is what `rsgShaderGenerator.cpp`'s
    /// `fragColorVar->setLayoutLocation(0)` needs in this port's own handle-based
    /// design (see that accessor's own doc comment) - a just-allocated variable has no
    /// layout location until something mutates it in place through the handle.
    #[test]
    fn get_variable_mut_allows_mutating_a_just_allocated_variable_in_place() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate_named(VariableType::new_basic(Type::Float, 4), Storage::ShaderOut, "o_color");
        assert!(!mgr.get_variable(v).has_layout_location());

        mgr.get_variable_mut(v).set_layout_location(0);

        assert!(mgr.get_variable(v).has_layout_location());
        assert_eq!(mgr.get_variable(v).get_layout_location(), 0);
    }

    #[test]
    fn declare_variable_moves_from_live_to_declared_and_drops_its_value() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate(VariableType::new_basic(Type::Int, 1));
        assert!(mgr.can_declare_in_current_scope(v));
        assert!(mgr.get_value(v).is_some());

        mgr.declare_variable(v);

        assert!(!mgr.can_declare_in_current_scope(v)); // No longer live.
        assert!(mgr.get_value(v).is_none()); // Removed from cache and from its value scope.

        let scope = mgr.pop_variable_scope();
        assert_eq!(scope.get_declared_variables(), &[v]);
        assert!(scope.get_live_variables().is_empty());
    }

    #[test]
    fn pop_variable_scope_migrates_live_variables_to_the_parent() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let a = mgr.allocate(VariableType::new_basic(Type::Float, 1));
        let b = mgr.allocate(VariableType::new_basic(Type::Float, 1));

        mgr.push_variable_scope(VariableScope::new());
        let c = mgr.allocate(VariableType::new_basic(Type::Float, 1));
        assert_eq!(mgr.get_live_variables(), &[c]);

        let popped = mgr.pop_variable_scope();
        assert!(popped.get_live_variables().is_empty()); // All migrated away.

        // Upstream's own pop-until-empty migration loop appends in reverse order (see
        // this module's `pop_variable_scope` doc comment) - with only one variable `c`
        // to migrate, that reversal is unobservable, so the parent's own two original
        // variables simply keep their order with `c` appended last.
        assert_eq!(mgr.get_live_variables(), &[a, b, c]);
    }

    #[test]
    fn get_parent_value_finds_a_value_set_in_an_outer_scope() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate(VariableType::new_basic(Type::Int, 1));
        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(0);
        range.get_max().set_int(10);
        mgr.set_value(v, &range.as_const_access());

        assert!(mgr.get_parent_value(v).is_none()); // Only one value scope so far.

        mgr.push_value_scope(ValueScope::new());
        // `entry_cache` is manager-global and the fresh child scope has not touched
        // `v` at all, so `get_value` still finds the parent's own entry through it -
        // `get_parent_value` is a different query (walk the scope stack directly,
        // skipping the current top scope) that agrees here only because nothing has
        // shadowed `v` in the child yet.
        assert!(mgr.get_value(v).is_some());
        let parent_entry = mgr.get_parent_value(v).expect("must find it in the parent scope");
        assert_eq!(parent_entry.get_value_range_const().get_min().as_int(), 0);
        assert_eq!(parent_entry.get_value_range_const().get_max().as_int(), 10);

        mgr.pop_value_scope();
    }

    #[test]
    fn pop_value_scope_intersects_a_value_set_in_both_scopes() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let v = mgr.allocate(VariableType::new_basic(Type::Int, 1));
        let mut parent_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        parent_range.get_min().set_int(0);
        parent_range.get_max().set_int(10);
        mgr.set_value(v, &parent_range.as_const_access());

        mgr.push_value_scope(ValueScope::new());
        let mut child_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        child_range.get_min().set_int(5);
        child_range.get_max().set_int(20);
        mgr.set_value(v, &child_range.as_const_access());

        mgr.pop_value_scope();

        // Hand-computed: intersection of [0,10] and [5,20] is [max(0,5), min(10,20)] =
        // [5, 10].
        let entry = mgr.get_value(v).expect("value must survive the pop, intersected");
        let access = entry.get_value_range_const();
        assert_eq!(access.get_min().as_int(), 5);
        assert_eq!(access.get_max().as_int(), 10);
    }

    #[test]
    fn pop_value_scope_promotes_a_value_only_set_in_the_child_scope() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        // A variable visible in both scopes (declared in the root) but only ever given
        // a value inside the child - exercises the "copy entries that don't yet exist
        // in the stack" tail of `pop_value_scope`.
        let v = mgr.allocate(VariableType::new_basic(Type::Float, 1));
        // `allocate` already called `set_value`-equivalent machinery implicitly? No -
        // `allocate` only creates an (unset, zeroed) ValueEntry via `ValueScope::
        // allocate`, so `v` already has a root-scope entry at (0, 0); exercise the tail
        // path with a second, never-allocated-in-root variable instead by declaring `v`
        // out of the root scope's cache first.
        mgr.declare_variable(v);

        mgr.push_value_scope(ValueScope::new());
        let mut only_child = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        only_child.get_min().set_float(1.5);
        only_child.get_max().set_float(2.5);
        mgr.set_value(v, &only_child.as_const_access());

        mgr.pop_value_scope();

        let entry = mgr.get_value(v).expect("promoted straight through to the parent scope");
        let access = entry.get_value_range_const();
        assert_eq!(access.get_min().as_float(), 1.5);
        assert_eq!(access.get_max().as_float(), 2.5);
    }

    #[test]
    fn entries_matching_filters_by_storage() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let local = mgr.allocate(VariableType::new_basic(Type::Float, 1));
        let shader_in = mgr.allocate_named(VariableType::new_basic(Type::Float, 1), Storage::ShaderIn, "a_in");
        let shader_out = mgr.allocate_named(VariableType::new_basic(Type::Float, 1), Storage::ShaderOut, "o_out");

        let locals: Vec<ValueEntryId> = mgr.entries_matching(local_entry_filter).collect();
        assert_eq!(locals.len(), 1);
        assert_eq!(mgr.get_entry(locals[0]).get_variable(), local);

        assert!(mgr.has_entry(shader_in_entry_filter));
        let shader_ins: Vec<ValueEntryId> = mgr.entries_matching(shader_in_entry_filter).collect();
        assert_eq!(mgr.get_entry(shader_ins[0]).get_variable(), shader_in);

        // Local + ShaderOut are writable, ShaderIn is not.
        let writable: Vec<VariableId> = mgr
            .entries_matching(is_writable_entry)
            .map(|id| mgr.get_entry(id).get_variable())
            .collect();
        assert!(writable.contains(&local));
        assert!(writable.contains(&shader_out));
        assert!(!writable.contains(&shader_in));

        assert_eq!(mgr.entries_matching(any_entry).count(), 3);
    }

    #[test]
    fn reserve_and_release_track_the_scalar_budget_without_allocating_a_variable() {
        let mut alloc = NameAllocator::new();
        let mut mgr = setup(&mut alloc);

        let mut reserved = ReservedScalars::default();
        mgr.reserve(&mut reserved, 8);
        assert_eq!(mgr.get_num_allocated_scalars(), 8);
        assert_eq!(reserved.num_scalars, 8);

        mgr.release(&mut reserved);
        assert_eq!(mgr.get_num_allocated_scalars(), 0);
        assert_eq!(reserved.num_scalars, 0);
    }
}
