// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgExecutionContext.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ExecutionContext` is the generator's host-side SIMD-lane store: the (not yet
// ported) reference interpreter evaluates a generated shader's AST once per
// `EXEC_VEC_WIDTH` (64) simulated "lanes" at a time rather than once per real
// invocation, so every `Variable`'s runtime value is stored not as one scalar/vector
// but as 64 parallel copies (`ValueStorage`'s `stride` field, here always 64) -
// **this is the genuine `Stride > 1` consumer `rsg::variable_value`'s own top doc
// comment predicted would eventually show up**, confirming that module's choice to
// keep `Stride` a plain runtime field rather than a const generic. A per-lane
// "execution mask" stack (`andExecutionMask`/`push`/`popExecutionMask`) is how the
// interpreter fakes per-lane divergent control flow (an `if` with a non-uniform
// condition): lanes where the mask is false are simply not written to by
// `assign_masked` below, exactly mirroring how a real GPU executes divergent branches
// across a SIMD warp/wavefront.
//
// Confirmed a genuine leaf by its own real `#include`s (`rsgVariable`/
// `rsgVariableValue`/`rsgSamplers`, all already ported) - **not** `rsgVariableManager`,
// despite conceptually being "the other half" of variable storage; the two are
// independent in upstream too (`ExecutionContext` is populated on demand by whatever
// drives evaluation, not by the manager itself).
//
// **Keyed by `VariableId`, not `&'a Variable`** - this module's own history is worth
// keeping, because the reasoning that forced the change applies to anything else that
// might be tempted to key a map by `&Variable` again. The first version of this file
// held `&'a Variable` directly (a pointer-identity wrapper, `VarKey`, replacing
// upstream's raw `const Variable*` key, `Variable` having no reason to gain a
// structural `Hash`/`Eq` of its own). That required `VariableManager::variables` to
// become `Vec<Box<Variable>>` instead of plain `Vec<Variable>` so a `&'a Variable`
// survived a *later* `allocate()` call reallocating the arena's own spine (see
// `variable_manager`'s own doc comment on that field) - necessary, but not sufficient:
// the real wall hit was a lifetime one, found only once `rsg::expression`'s
// `VariableRead`/`VariableWrite` were actually written against it. Extracting `&'a
// Variable` out of a `&'a mut VariableManager` ties up *exclusive* access to the whole
// `VariableManager` for as long as any `Expression` holding that reference is alive -
// which is the entire rest of shader generation, since building the *next* expression
// routinely needs to call `allocate` on the very same manager again. A design that only
// ever constructs one `Expression` ever could have lived with that; a shader generator
// cannot. `VariableId` is `Copy` and carries no borrow at all, so storing it instead
// removes the conflict entirely - the `Vec<Box<Variable>>` fix stays (worth having
// regardless, and now exercised by a dedicated regression test in
// `variable_manager`'s own test module), but it is no longer load-bearing for *this*
// file. `get_value`/`get_sampler_2d`/`get_sampler_cube` take the variable's
// `VariableType` as an explicit second argument rather than deriving it from a
// `Variable` reference this file no longer holds - cheap for a caller that already has
// `var_manager.get_variable(id).get_type()` in hand.

use std::collections::HashMap;

use super::samplers::{Sampler2D, Sampler2DMap, SamplerCube, SamplerCubeMap};
use super::variable_manager::VariableId;
use super::variable_type::{Type, VariableType};
use super::variable_value::{ConstStridedValueAccess, Scalar, StridedValueAccess, ValueStorage};

/// `rsg::EXEC_VEC_WIDTH`
pub const EXEC_VEC_WIDTH: usize = 64;

/// `rsg::ExecConstValueAccess` (`ConstStridedValueAccess<EXEC_VEC_WIDTH>`)
pub type ExecConstValueAccess<'a> = ConstStridedValueAccess<'a>;
/// `rsg::ExecValueAccess` (`StridedValueAccess<EXEC_VEC_WIDTH>`)
pub type ExecValueAccess<'a> = StridedValueAccess<'a>;

/// `rsg::ExecMaskStorage`
pub struct ExecMaskStorage {
    data: [Scalar; EXEC_VEC_WIDTH],
}

impl ExecMaskStorage {
    pub fn new(init_val: bool) -> Self {
        Self {
            data: [Scalar::from_bool(init_val); EXEC_VEC_WIDTH],
        }
    }

    pub fn get_value(&mut self) -> ExecValueAccess<'_> {
        ExecValueAccess::new(VariableType::scalar_type(Type::Bool), &mut self.data, EXEC_VEC_WIDTH)
    }

    pub fn get_value_const(&self) -> ExecConstValueAccess<'_> {
        ExecConstValueAccess::new(VariableType::scalar_type(Type::Bool), &self.data, EXEC_VEC_WIDTH)
    }
}

impl Default for ExecMaskStorage {
    /// `ExecMaskStorage(bool initVal = true)`'s default argument.
    fn default() -> Self {
        Self::new(true)
    }
}

/// `rsg::ExecutionContext`
pub struct ExecutionContext<'a> {
    var_values: HashMap<VariableId, ValueStorage>,
    samplers_2d: &'a Sampler2DMap<'a>,
    samplers_cube: &'a SamplerCubeMap<'a>,
    exec_mask_stack: Vec<ExecMaskStorage>,
}

impl<'a> ExecutionContext<'a> {
    pub fn new(samplers_2d: &'a Sampler2DMap<'a>, samplers_cube: &'a SamplerCubeMap<'a>) -> Self {
        let mut ctx = Self {
            var_values: HashMap::new(),
            samplers_2d,
            samplers_cube,
            exec_mask_stack: Vec::new(),
        };

        // Initialize execution mask to true.
        let init = ExecMaskStorage::default();
        ctx.push_execution_mask(&init.get_value_const());

        ctx
    }

    /// `ExecutionContext::getValue` - lazily allocates per-lane storage for
    /// `variable_id` on first access, matching upstream's `m_varValues[variable]`
    /// default-insert. `type_` is only consulted on that first access, to size the
    /// storage - see this module's own top doc comment for why the caller supplies it
    /// explicitly rather than this file resolving it from a `Variable` reference.
    pub fn get_value(&mut self, variable_id: VariableId, type_: &VariableType) -> ExecValueAccess<'_> {
        let storage = self
            .var_values
            .entry(variable_id)
            .or_insert_with(|| ValueStorage::with_type(EXEC_VEC_WIDTH, type_));
        storage.get_value(type_)
    }

    /// `ExecutionContext::getSampler2D`
    pub fn get_sampler_2d(&self, sampler_id: VariableId, sampler_type: &VariableType) -> &Sampler2D<'a> {
        let storage = self
            .var_values
            .get(&sampler_id)
            .expect("ExecutionContext::get_sampler_2d: sampler has no stored value");
        let sampler_ndx = storage.get_value_const(sampler_type).as_int_at(0);
        self.samplers_2d
            .get(&sampler_ndx)
            .expect("ExecutionContext::get_sampler_2d: no such sampler index")
    }

    /// `ExecutionContext::getSamplerCube`
    pub fn get_sampler_cube(&self, sampler_id: VariableId, sampler_type: &VariableType) -> &SamplerCube<'a> {
        let storage = self
            .var_values
            .get(&sampler_id)
            .expect("ExecutionContext::get_sampler_cube: sampler has no stored value");
        let sampler_ndx = storage.get_value_const(sampler_type).as_int_at(0);
        self.samplers_cube
            .get(&sampler_ndx)
            .expect("ExecutionContext::get_sampler_cube: no such sampler index")
    }

    /// `ExecutionContext::getExecutionMask`
    pub fn get_execution_mask(&self) -> ExecConstValueAccess<'_> {
        self.exec_mask_stack
            .last()
            .expect("ExecutionContext::get_execution_mask: mask stack is empty")
            .get_value_const()
    }

    /// `ExecutionContext::andExecutionMask` - pushes the elementwise AND of the current
    /// mask and `value`.
    pub fn and_execution_mask(&mut self, value: &ExecConstValueAccess<'_>) {
        let mut tmp = ExecMaskStorage::default();
        {
            let old_value = self.get_execution_mask();
            let mut new_value = tmp.get_value();
            for i in 0..EXEC_VEC_WIDTH {
                new_value.set_bool_at(i, old_value.as_bool_at(i) && value.as_bool_at(i));
            }
        }
        self.push_execution_mask(&tmp.get_value_const());
    }

    /// `ExecutionContext::pushExecutionMask`
    pub fn push_execution_mask(&mut self, value: &ExecConstValueAccess<'_>) {
        let mut tmp = ExecMaskStorage::default();
        {
            let src = value.value();
            tmp.get_value().assign_from(&src);
        }
        self.exec_mask_stack.push(tmp);
    }

    /// `ExecutionContext::popExecutionMask`
    pub fn pop_execution_mask(&mut self) {
        self.exec_mask_stack.pop();
    }
}

/// `rsg::assignMasked` - lane-wise masked copy of `src` into `dst`: for every scalar
/// component and every one of the `EXEC_VEC_WIDTH` lanes, `dst` is overwritten only
/// where `mask` is true, recursing through arrays/structs exactly like
/// `rsg::variable_value`'s own `compare_value_ranges_all_true`/`compute_intersection`
/// recurse through a `VariableType`'s shape.
pub fn assign_masked(mut dst: ExecValueAccess<'_>, src: &ExecConstValueAccess<'_>, mask: &ExecConstValueAccess<'_>) {
    if dst.get_type().is_array() {
        for elem_ndx in 0..dst.get_type().num_elements() {
            assign_masked(dst.array_element(elem_ndx), &src.array_element(elem_ndx), mask);
        }
    } else if dst.get_type().is_struct() {
        for member_ndx in 0..dst.get_type().members().len() as i32 {
            assign_masked(dst.member(member_ndx), &src.member(member_ndx), mask);
        }
    } else {
        match dst.get_type().base_type() {
            Type::Float | Type::Int | Type::Bool | Type::Sampler2D | Type::SamplerCube => {
                for elem_ndx in 0..dst.get_type().num_elements() {
                    let mut dst_elem = dst.component(elem_ndx);
                    let src_elem = src.component(elem_ndx);
                    for comp_ndx in 0..EXEC_VEC_WIDTH {
                        if mask.as_bool_at(comp_ndx) {
                            dst_elem.set_scalar_at(comp_ndx, src_elem.as_scalar_at(comp_ndx));
                        }
                    }
                }
            }
            _ => unreachable!("rsg::assign_masked: unsupported base type"),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::variable::Storage;
    use crate::rsg::variable_manager::{ValueScope, VariableManager, VariableScope};

    fn ctx_with_no_samplers<'a>(
        empty_2d: &'a Sampler2DMap<'a>,
        empty_cube: &'a SamplerCubeMap<'a>,
    ) -> ExecutionContext<'a> {
        ExecutionContext::new(empty_2d, empty_cube)
    }

    /// A `VariableManager` with one pushed scope pair, ready to `allocate` from - the
    /// only way anything outside `variable_manager` itself can obtain a real
    /// `VariableId` to drive these tests with.
    fn var_manager(alloc: &mut NameAllocator) -> VariableManager<'_> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    #[test]
    fn execution_mask_starts_all_true_and_and_narrows_it() {
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ctx_with_no_samplers(&empty_2d, &empty_cube);

        let initial = ctx.get_execution_mask();
        for i in 0..EXEC_VEC_WIDTH {
            assert!(initial.as_bool_at(i));
        }

        // AND in a mask that is false for every even lane.
        let mut even_false = ExecMaskStorage::new(true);
        {
            let mut v = even_false.get_value();
            for i in (0..EXEC_VEC_WIDTH).step_by(2) {
                v.set_bool_at(i, false);
            }
        }
        ctx.and_execution_mask(&even_false.get_value_const());

        let narrowed = ctx.get_execution_mask();
        for i in 0..EXEC_VEC_WIDTH {
            assert_eq!(narrowed.as_bool_at(i), i % 2 == 1);
        }

        ctx.pop_execution_mask();
        let restored = ctx.get_execution_mask();
        for i in 0..EXEC_VEC_WIDTH {
            assert!(restored.as_bool_at(i));
        }
    }

    #[test]
    fn get_value_lazily_allocates_and_is_stable_across_calls() {
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ctx_with_no_samplers(&empty_2d, &empty_cube);

        let mut alloc = NameAllocator::new();
        let mut mgr = var_manager(&mut alloc);
        let type_ = VariableType::new_basic(Type::Int, 1);
        let v = mgr.allocate_named(type_.clone(), Storage::Local, "x");
        let w = mgr.allocate_named(type_.clone(), Storage::Local, "x"); // Same name, different identity.

        ctx.get_value(v, &type_).set_int_at(0, 42);
        assert_eq!(ctx.get_value(v, &type_).as_int_at(0), 42);

        // A second, distinct variable gets its own, independent storage.
        ctx.get_value(w, &type_).set_int_at(0, 7);
        assert_eq!(ctx.get_value(v, &type_).as_int_at(0), 42); // `v`'s own value is untouched.
        assert_eq!(ctx.get_value(w, &type_).as_int_at(0), 7);
    }

    #[test]
    fn assign_masked_only_overwrites_lanes_where_the_mask_is_true() {
        // `assign_masked` itself needs no `ExecutionContext` - it operates directly on
        // `ExecValueAccess`/`ExecConstValueAccess`, so this test drives it with two
        // standalone `ValueStorage`s rather than going through one context's map (which
        // cannot hand out two simultaneous entries' storage anyway, same as any
        // `HashMap`).
        let type_ = VariableType::new_basic(Type::Int, 1);

        let mut dst_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let mut dst = dst_storage.get_value(&type_);
            for i in 0..EXEC_VEC_WIDTH {
                dst.set_int_at(i, -1);
            }
        }

        let mut src_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let mut src = src_storage.get_value(&type_);
            for i in 0..EXEC_VEC_WIDTH {
                src.set_int_at(i, i as i32);
            }
        }

        let mut mask_storage = ExecMaskStorage::new(true);
        {
            let mut mask = mask_storage.get_value();
            for i in 0..EXEC_VEC_WIDTH {
                mask.set_bool_at(i, i % 2 == 0); // Only even lanes copy through.
            }
        }

        assign_masked(
            dst_storage.get_value(&type_),
            &src_storage.get_value_const(&type_),
            &mask_storage.get_value_const(),
        );

        let result = dst_storage.get_value_const(&type_);
        for i in 0..EXEC_VEC_WIDTH {
            if i % 2 == 0 {
                assert_eq!(result.as_int_at(i), i as i32);
            } else {
                assert_eq!(result.as_int_at(i), -1);
            }
        }
    }
}
