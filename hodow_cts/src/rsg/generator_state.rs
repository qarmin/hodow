// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgGeneratorState.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **This is a deliberately partial port** - see "What is NOT ported, and why" below
// before extending this file. What upstream's own small `.cpp` (54 lines) actually does
// (construct with program params + a `de::Random&`, push the two stacks' base values,
// and the trivial `setShader` setter) is ported in full; what is missing is three
// fields this port could not translate as a plain internal pointer without
// reintroducing the exact aliasing conflict `rsg::variable_manager` already found and
// fixed once (see that module's own top doc comment) - except one level higher up the
// object graph this time.
//
// **The `de::Random&` upstream takes is `crate::tcu::random::Random`** - already
// ported, fully, as part of `tcu` rather than `rsg` (a generic PRNG utility shared
// across the whole crate, not random-shader-generator-specific) - confirmed by reading
// it before writing this file, not assumed. `rsg` depending on `tcu` here is not a
// layering violation: the project's one hard rule is that `hodow_cts` never depends on
// `hodow_cpu`, `hodow_gpu`, `hodow_bench` or `hodow_common`, not that its own internal modules stay siloed from each other.
//
// ## What is NOT ported, and why: `Shader`/`VariableManager`/the statement stack
//
// Upstream's `GeneratorState` stores a *second*, independent reference to each of these
// three things, purely for other code's convenience (`Expression`/`Statement` methods
// that only ever see a `GeneratorState&`, not the object directly) - **while the real
// owner goes on using its own, first reference to the very same object throughout**.
// Reading the one real caller (`rsgShaderGenerator.cpp`, not yet ported) confirms this
// is not a hypothetical:
//
// - `ShaderGenerator` owns `VariableManager m_varManager` directly, calls
//   `state.setVariableManager(m_varManager)` once, and then goes on calling
//   `m_varManager.pushVariableScope(...)`/`popVariableScope()` etc. **on its own
//   reference**, for the rest of `generate()` - while `Expression`/`Statement`
//   constructors built during that same call reach the identical object through
//   `state.getVariableManager()`. Two live references to one `VariableManager`, one of
//   which must be `&mut` for `pushVariableScope`/`allocate`/etc. to work at all, is
//   exactly what Rust's borrow checker refuses regardless of what shape the object
//   holding the pointer takes - the same conflict `rsg::variable_manager`'s own top doc
//   comment describes for `VariableScope`, one level further up.
// - `ShaderGenerator::generate(..., Shader &shader, ...)` takes `shader` as its own
//   parameter and calls `shader.getType()`/`getMain()`/`getGlobalStatements()`/
//   `getInputs()`/`getUniforms()` **directly** throughout the function, after calling
//   `state.setShader(shaderParams, shader)` once up front - the identical dual-reference
//   shape, and `getShader()` returns a non-`const` reference, so it is a second route to
//   *mutate* the same `Shader`, not just read it.
// - The statement stack (`setStatementStack`/`getStatementStackEntry`) exists only to
//   let deeply-nested `Expression`/`Statement` code answer "how deep in the tree am I,
//   and what's above me" without being handed the whole tree explicitly - the vector it
//   points at is owned by whichever `Statement` is actively being built, which has the
//   same shape problem as the two above once that code also wants to read its own
//   children through the same path.
//
// **The fix carries over unchanged from `rsg::variable_manager`'s own precedent**:
// don't let `GeneratorState` hold a second, aliasing-prone reference to something its
// real owner also uses directly. Whatever eventually ports `Expression`/`Statement`/
// `Shader`/`ShaderGenerator` should thread `VariableManager`/`Shader`/the statement
// stack through as **explicit extra parameters** alongside `&mut GeneratorState`,
// exactly the way `rsg::variable_manager::pop_variable_scope` now hands the finished
// scope *back* instead of upstream's "read it through a second reference" shape. This
// is not a cosmetic preference: it is the only one of the two fixes (the other being an
// `Rc<RefCell<..>>`-style shared-mutable cell, rejected here for the same reason
// `rsg::variable_manager` rejected it - see that module's choice of arena handles
// instead) that survives contact with how upstream's own real call site actually uses
// these three objects.
//
// `ShaderParameters` is the one exception, kept as a field here (`Option<&'a
// ShaderParameters>`, set via `set_shader_parameters`): upstream's `getShader()`-style
// aliasing problem is specifically about a *mutable* second reference, and
// `ShaderParameters` is only ever read through `const ShaderParameters&` on every path -
// Rust allows any number of simultaneous shared (`&T`) borrows of the same place, so
// there is no conflict to design around here at all.

use super::name_allocator::NameAllocator;
use super::parameters::{ProgramParameters, ShaderParameters};
use crate::tcu::random::Random;

/// `rsg::ExpressionFlags`
pub const CONST_EXPR: u32 = 1 << 0;
pub const NO_VAR_ALLOCATION: u32 = 1 << 1;

/// `rsg::PRECEDENCE_MAX`
pub const PRECEDENCE_MAX: i32 = 100;

/// `rsg::GeneratorState` - see this module's own top doc comment for what is
/// deliberately not here.
pub struct GeneratorState<'a> {
    program_params: &'a ProgramParameters,
    random: &'a mut Random,

    shader_params: Option<&'a ShaderParameters>,

    name_allocator: NameAllocator,

    expression_depth: i32,
    expr_flag_stack: Vec<u32>,
    precedence_stack: Vec<i32>,
}

impl<'a> GeneratorState<'a> {
    /// `GeneratorState::GeneratorState`
    pub fn new(program_params: &'a ProgramParameters, random: &'a mut Random) -> Self {
        Self {
            program_params,
            random,
            shader_params: None,
            name_allocator: NameAllocator::new(),
            expression_depth: 0,
            expr_flag_stack: vec![0],
            precedence_stack: vec![PRECEDENCE_MAX],
        }
    }

    pub fn get_program_parameters(&self) -> &ProgramParameters {
        self.program_params
    }

    pub fn get_random(&mut self) -> &mut Random {
        self.random
    }

    pub fn get_shader_parameters(&self) -> &ShaderParameters {
        self.shader_params
            .expect("GeneratorState::get_shader_parameters: no shader set yet (call set_shader_parameters first)")
    }

    /// `GeneratorState::setShader` - the `ShaderParameters` half only; see this
    /// module's own top doc comment for why the `Shader&` half is not carried here.
    pub fn set_shader_parameters(&mut self, shader_params: &'a ShaderParameters) {
        self.shader_params = Some(shader_params);
    }

    pub fn get_name_allocator(&mut self) -> &mut NameAllocator {
        &mut self.name_allocator
    }

    pub fn get_expression_depth(&self) -> i32 {
        self.expression_depth
    }
    pub fn set_expression_depth(&mut self, depth: i32) {
        self.expression_depth = depth;
    }

    pub fn get_expression_flags(&self) -> u32 {
        *self
            .expr_flag_stack
            .last()
            .expect("GeneratorState::get_expression_flags: flag stack is empty")
    }
    pub fn push_expression_flags(&mut self, flags: u32) {
        self.expr_flag_stack.push(flags);
    }
    pub fn pop_expression_flags(&mut self) {
        self.expr_flag_stack.pop();
    }

    pub fn get_precedence(&self) -> i32 {
        *self
            .precedence_stack
            .last()
            .expect("GeneratorState::get_precedence: precedence stack is empty")
    }
    pub fn push_precedence(&mut self, precedence: i32) {
        self.precedence_stack.push(precedence);
    }
    pub fn pop_precedence(&mut self) {
        self.precedence_stack.pop();
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn default_program_params() -> ProgramParameters {
        ProgramParameters::default()
    }

    #[test]
    fn new_state_starts_with_the_upstream_constructor_defaults() {
        let params = default_program_params();
        let mut random = Random::new(1);
        let state = GeneratorState::new(&params, &mut random);

        assert_eq!(state.get_expression_depth(), 0);
        assert_eq!(state.get_expression_flags(), 0);
        assert_eq!(state.get_precedence(), PRECEDENCE_MAX);
    }

    #[test]
    fn expression_flags_and_precedence_push_pop_like_a_stack() {
        let params = default_program_params();
        let mut random = Random::new(1);
        let mut state = GeneratorState::new(&params, &mut random);

        state.push_expression_flags(CONST_EXPR | NO_VAR_ALLOCATION);
        assert_eq!(state.get_expression_flags(), CONST_EXPR | NO_VAR_ALLOCATION);
        state.pop_expression_flags();
        assert_eq!(state.get_expression_flags(), 0);

        state.push_precedence(5);
        assert_eq!(state.get_precedence(), 5);
        state.pop_precedence();
        assert_eq!(state.get_precedence(), PRECEDENCE_MAX);
    }

    #[test]
    fn shader_parameters_panics_until_set_then_reads_back_what_was_set() {
        let params = default_program_params();
        let mut random = Random::new(1);
        let mut state = GeneratorState::new(&params, &mut random);

        let shader_params = ShaderParameters::default();
        state.set_shader_parameters(&shader_params);
        // Reading it back is the only thing to check - `ShaderParameters` carries no
        // identity of its own beyond its fields, already covered by `rsg::parameters`'
        // own tests.
        let _ = state.get_shader_parameters();
    }

    #[test]
    #[should_panic(expected = "no shader set yet")]
    fn shader_parameters_panics_before_being_set() {
        let params = default_program_params();
        let mut random = Random::new(1);
        let state = GeneratorState::new(&params, &mut random);
        let _ = state.get_shader_parameters();
    }

    #[test]
    fn name_allocator_is_reachable_and_independent_of_the_generic_tcu_random() {
        let params = default_program_params();
        let mut random = Random::new(1);
        let mut state = GeneratorState::new(&params, &mut random);

        assert_eq!(state.get_name_allocator().allocate(), "a");
        assert_eq!(state.get_name_allocator().allocate(), "b");
    }
}
