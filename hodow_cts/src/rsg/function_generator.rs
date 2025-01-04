// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgFunctionGenerator.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `FunctionGenerator::generate` is the real "drive a whole function body to completion"
// loop - `rsg::statement_generator::drive_to_completion` already mirrors its statement-
// stack-popping shape (see that function's own doc comment, which named this file as the
// one remaining piece needed to turn it into a wired, real driver). What is actually new
// here, beyond calling that function, is the two things wrapped around it: initializing
// `function`'s own root `BlockStatement` before driving it, and appending the "required
// assignments" (shader outputs, function outputs that must end up with *some* concrete
// value no matter what the random walk produced) after.
//
// **`rsg::shader::Function` needed no type change at all to support this** - its own top
// doc comment already anticipated replacing `body: Vec<StatementId>` with a single root
// `StatementId`, but re-reading upstream's real `Function::Function(void)`/`Function(const
// char*)` shows *both* constructors default-construct `m_functionBlock` via `BlockStatement
// (void)` (`m_numChildrenToCreate(0)`, no scope pushed) - a C++-only requirement (a class
// member must be constructible at object-construction time, long before any
// `GeneratorState&` exists to build a *real* randomized block with) that this port's
// arena-based `BlockStatement` has no equivalent need for: an empty `Vec<StatementId>` is
// already exactly upstream's own "not yet generated" state (a `BlockStatement` with zero
// children and `numChildrenToCreate == 0` tokenizes/executes identically to one that was
// simply never touched). So `Function::new`/`Default` stay exactly as `rsg::shader` already
// has them, and `generate` below does what upstream's `FunctionGenerator::generate` does
// to `m_function.getBody()` (call `init`, matching `BlockStatement::BlockStatement
// (GeneratorState&)`'s own real body exactly - see `rsg::statement`'s own doc comment on
// `BlockStatement::new`, already folded `init` into it) by building a *fresh*,
// already-initialized `BlockStatement` via the existing `BlockStatement::new(state,
// var_manager)` (the very same constructor `chooseStatement`'s own dispatch table uses for
// every *nested* block - upstream's `init` has no special-cased behaviour that would make
// a function's root block different from any other), inserting it into the arena, and
// pushing its id into `function.get_body_mut()` (always exactly one push - the resulting
// `Vec` holds the same single `StatementId` upstream's own single `m_functionBlock` field
// is, just addressed through the arena rather than embedded by value).
//
// **`BlockStatement::addChild` needed one new method, `rsg::statement::BlockStatement::
// add_child`** - see that method's own doc comment for why its C++ exception-safety
// wrapper has no Rust equivalent. This is its first and so far only real caller, matching
// upstream exactly: `FunctionGenerator::generate`'s own "required assignments" loop is the
// one place outside `createNextChild`'s weighted dispatch that ever appends a child
// directly.
//
// **`m_requiredAssignments`/`requireAssignment` are ported as a plain owned
// `Vec<VariableId>`**, not upstream's `Variable*` - the same `VariableId`-not-`&Variable`
// substitution every other module in this cluster already makes (see
// `rsg::execution_context`'s own top doc comment for why: a `VariableId` is `Copy` and
// carries no borrow, so storing a list of them never ties up `VariableManager`).
//
// **`FunctionGenerator` does not store `&mut GeneratorState`**, unlike upstream's own
// `m_state` field - see `rsg::generator_state`'s own top doc comment's standing rule
// (whatever ports `Shader`/`ShaderGenerator` threads `GeneratorState`/`VariableManager`/
// the statement stack through as *explicit extra parameters*, never retrieves them through
// a second stored reference). Nothing here needs `state` between the constructor and the
// one `generate` call, so there is no aliasing hazard to design around in the first place -
// simply taking it as a parameter of `generate` itself is both simpler and already
// consistent with that rule, not a deviation requiring special justification.
//
// **`ValueRange::from_access` replaces upstream's own three-statement copy**
// (`ValueRange valueRange(variable->getType()); valueRange.getMin() = entry->
// getValueRange().getMin().value(); valueRange.getMax() = ...`) - the same simplification
// `rsg::shader::ShaderInput::new`'s own doc comment already made for an identical copy,
// not a new deviation.

use super::generator_state::GeneratorState;
use super::shader::Function;
use super::statement::{AssignStatement, BlockStatement, Statement, StatementArena, StatementId};
use super::statement_generator;
use super::utils::is_undefined_value_range;
use super::variable_manager::{VariableId, VariableManager};
use super::variable_value::ValueRange;

/// `rsg::FunctionGenerator`.
pub struct FunctionGenerator<'f> {
    function: &'f mut Function,
    required_assignments: Vec<VariableId>,
}

impl<'f> FunctionGenerator<'f> {
    /// `FunctionGenerator::FunctionGenerator(GeneratorState&, Function&)` - see this
    /// module's own top doc comment for why `state` is not stored here.
    pub fn new(function: &'f mut Function) -> Self {
        Self {
            function,
            required_assignments: Vec::new(),
        }
    }

    /// `FunctionGenerator::requireAssignment`.
    pub fn require_assignment(&mut self, variable: VariableId) {
        self.required_assignments.push(variable);
    }

    /// `FunctionGenerator::generate` - see this module's own top doc comment for the
    /// full account of how this differs mechanically (not behaviourally) from upstream's
    /// own body.
    pub fn generate(
        &mut self,
        arena: &mut StatementArena,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) {
        // Initialize: build the function's own root block and start the statement
        // stack with it - matching `statementStack.push_back(&m_function.getBody());
        // m_function.getBody().init(m_state);`, just in the opposite order (this port's
        // `BlockStatement::new` already performs upstream's `init` as part of
        // construction, so there is no separate already-existing node to initialize in
        // place - see this module's own top doc comment).
        let body_id: StatementId = arena.insert(Statement::Block(BlockStatement::new(state, var_manager)));
        self.function.get_body_mut().push(body_id);

        // Process until statement stack is empty.
        statement_generator::drive_to_completion(arena, body_id, state, var_manager);

        // Create assignments for variables that still have a bound value range.
        for &variable in &self.required_assignments {
            let value_range = {
                let entry = var_manager.get_value(variable).expect(
                    "FunctionGenerator::generate: a required-assignment variable must still have a bound value \
                     range in the current scope",
                );
                ValueRange::from_access(&entry.get_value_range_const())
            };

            // Remove value entry from this scope. After this, re-reading it would be
            // this port's `Option<&ValueEntry>` equivalent of upstream's now-dangling
            // `entry` pointer - `value_range` above was the copy taken before this call
            // for exactly that reason, matching upstream's own comment ("After this
            // entry ptr is invalid").
            var_manager.remove_value_from_current_scope(variable);

            if !is_undefined_value_range(&value_range.as_const_access()) {
                let assign_statement =
                    AssignStatement::new_random(state, var_manager, variable, &value_range.as_const_access());
                let assign_id = arena.insert(Statement::Assign(assign_statement));
                match arena.get_mut(body_id) {
                    Statement::Block(block) => block.add_child(assign_id),
                    _ => unreachable!("body_id was just inserted as Statement::Block above"),
                }
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::{ProgramParameters, ShaderParameters};
    use crate::rsg::variable::Storage;
    use crate::rsg::variable_manager::{ValueScope, VariableScope};
    use crate::rsg::variable_type::{Type, VariableType};
    use crate::tcu::random::Random;

    fn new_state<'a>(
        program_params: &'a ProgramParameters,
        shader_params: &'a ShaderParameters,
        random: &'a mut Random,
    ) -> GeneratorState<'a> {
        let mut state = GeneratorState::new(program_params, random);
        state.set_shader_parameters(shader_params);
        state
    }

    fn new_var_manager(alloc: &mut NameAllocator) -> VariableManager<'_> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    #[test]
    fn generate_populates_exactly_one_root_block_into_the_functions_own_body() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_statement_depth: 2,
            max_statements_per_block: 3,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();

        for seed in 0..10 {
            let mut random = Random::new(seed);
            let mut state = new_state(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);
            let mut arena = StatementArena::new();
            let mut function = Function::new("main");

            let mut generator = FunctionGenerator::new(&mut function);
            generator.generate(&mut arena, &mut state, &mut mgr);

            // Exactly one child in `Function::body` - the function's own root block -
            // matching upstream's own single `m_functionBlock` field.
            assert_eq!(function.get_body().len(), 1, "seed {seed}");
            let body_id = function.get_body()[0];
            assert!(
                matches!(arena.get(body_id), Statement::Block(_)),
                "seed {seed}: root must be a Block"
            );
        }
    }

    #[test]
    fn generate_terminates_the_statement_stack_with_a_tight_depth_budget() {
        // A 0-statement-per-block budget means the root block's own `createNextChild`
        // immediately sees `children.len() (0) < num_children_to_create (also always 0,
        // since `get_int(0, 0) == 0`)` as false on its very first call, pops the
        // variable scope, and the stack empties after exactly one `drive_to_completion`
        // iteration - the smallest possible non-panicking tree.
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_statement_depth: 4,
            max_statements_per_block: 0,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();
        let mut random = Random::new(42);
        let mut state = new_state(&program_params, &shader_params, &mut random);
        let mut mgr = new_var_manager(&mut alloc);
        let mut arena = StatementArena::new();
        let mut function = Function::new("main");

        let mut generator = FunctionGenerator::new(&mut function);
        generator.generate(&mut arena, &mut state, &mut mgr);

        let body_id = function.get_body()[0];
        match arena.get(body_id) {
            Statement::Block(b) => assert!(b.get_children_for_test().is_empty()),
            _ => unreachable!(),
        }
    }

    #[test]
    fn required_assignment_with_a_bound_point_range_appends_an_assign_statement() {
        let program_params = ProgramParameters::default();
        // Zero-size blocks keep the generated tree trivial so this test is only about
        // the required-assignment machinery, not the random statement walk.
        let shader_params = ShaderParameters {
            max_statement_depth: 4,
            max_statements_per_block: 0,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();
        let mut random = Random::new(3);
        let mut state = new_state(&program_params, &shader_params, &mut random);
        let mut mgr = new_var_manager(&mut alloc);
        let mut arena = StatementArena::new();
        let mut function = Function::new("main");

        // A shader-output variable with a concrete point range (min == max == 7) bound
        // over `VariableManager::allocate_named`'s own default zero-range entry -
        // `allocate_named` already allocates a value entry for every variable (see
        // `rsg::variable_manager`'s own doc comment on `VariableManager::allocate`'s
        // real body), so only overwriting it via `set_value` is needed, matching what a
        // real generator's own uniform/output value-tracking does before calling
        // `require_assignment`.
        let out_var = mgr.allocate_named(VariableType::new_basic(Type::Int, 1), Storage::ShaderOut, "o_result");
        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(7);
        range.get_max().set_int(7);
        mgr.set_value(out_var, &range.as_const_access());

        let mut generator = FunctionGenerator::new(&mut function);
        generator.require_assignment(out_var);
        generator.generate(&mut arena, &mut state, &mut mgr);

        let body_id = function.get_body()[0];
        let children = match arena.get(body_id) {
            Statement::Block(b) => b.get_children_for_test(),
            _ => unreachable!(),
        };
        // The required assignment is appended to the same root block's children, after
        // whatever the random walk already built (none, with a 0-sized budget), so it
        // must be the one and only child and it must be an `Assign` statement.
        assert_eq!(children.len(), 1);
        assert!(matches!(arena.get(children[0]), Statement::Assign(_)));

        // The value entry must have been removed from the current scope - a second
        // `require_assignment`-style read would now find nothing there.
        assert!(mgr.get_value(out_var).is_none());
    }

    #[test]
    fn required_assignment_with_an_undefined_range_is_silently_dropped() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_statement_depth: 4,
            max_statements_per_block: 0,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();
        let mut random = Random::new(9);
        let mut state = new_state(&program_params, &shader_params, &mut random);
        let mut mgr = new_var_manager(&mut alloc);
        let mut arena = StatementArena::new();
        let mut function = Function::new("main");

        // An int variable whose bound range is exactly `[i32::MIN, i32::MAX]` -
        // `is_undefined_value_range` (see `rsg::utils`) reports this as "no real
        // constraint was ever placed on it", so `FunctionGenerator::generate` must not
        // manufacture an assignment for it at all.
        let out_var = mgr.allocate_named(
            VariableType::new_basic(Type::Int, 1),
            Storage::ShaderOut,
            "o_unconstrained",
        );
        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range
            .get_min()
            .set_scalar(crate::rsg::variable_value::Scalar::min_int());
        range
            .get_max()
            .set_scalar(crate::rsg::variable_value::Scalar::max_int());
        mgr.set_value(out_var, &range.as_const_access());

        let mut generator = FunctionGenerator::new(&mut function);
        generator.require_assignment(out_var);
        generator.generate(&mut arena, &mut state, &mut mgr);

        let body_id = function.get_body()[0];
        let children = match arena.get(body_id) {
            Statement::Block(b) => b.get_children_for_test(),
            _ => unreachable!(),
        };
        assert!(
            children.is_empty(),
            "an undefined value range must not produce an AssignStatement"
        );
        // Still removed from scope either way, matching upstream's own unconditional
        // `removeValueFromCurrentScope` call (it runs *before* the `isUndefinedValueRange`
        // check, not inside its branch).
        assert!(mgr.get_value(out_var).is_none());
    }
}
