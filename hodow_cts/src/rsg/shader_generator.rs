// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgShaderGenerator.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `generate` ports `ShaderGenerator::generate` - the real per-shader driver that fills in
// a `Shader`'s inputs/uniforms/outputs/global declarations and main-function body, either
// by random generation (`shaderParams.randomize`) or by a trivial passthrough shader.
//
// **This is a free function, not a struct**, unlike upstream's `ShaderGenerator` class -
// every one of its would-be fields is either reconstructed fresh per call (`m_varManager`,
// a brand new `VariableManager` every time, confirmed by `ProgramGenerator::generate`'s own
// two separate `ShaderGenerator shaderGen(state);` constructions, one per shader) or
// already an explicit parameter by this cluster's own standing convention
// (`&mut GeneratorState`, never stored - see `rsg::generator_state`'s own top doc comment,
// and `rsg::function_generator`'s own doc comment for why its sibling made the identical
// choice). A struct wrapping nothing but a one-shot constructor plus a single `generate`
// method would add a type with no real state of its own.
//
// **`outputs` is `&[(VariableType, String, ValueRange)]`, not upstream's
// `&[ShaderInput*]`** - a genuine, confirmed fix, not a style choice. Upstream's
// `ShaderInput` holds a raw `const Variable*` that stays valid regardless of which
// `VariableManager` originally allocated it (that manager's own destructor is empty -
// confirmed by reading `rsgVariableManager.cpp` - the real ownership of `Variable` objects
// lives elsewhere in the object graph). This port's `rsg::shader::ShaderInput` instead
// holds a `VariableId`, which is only ever resolvable against the *specific*
// `VariableManager` that allocated it - and `ProgramGenerator::generate`'s own real call
// shape feeds *one* shader's already-finished `ShaderInput` list (and its now-dropped
// per-shader `VariableManager`, see this cluster's own `name_allocator` finding below) as
// another, separately-generated shader's `outputs` parameter. Resolving each `ShaderInput`
// down to its own owned `(VariableType, name, ValueRange)` triple *before* the producing
// shader's `VariableManager` goes out of scope - which `rsg::program_generator` does -
// sidesteps the dangling-handle hazard entirely; nothing downstream of that point ever
// needs the original `VariableId` again, confirmed by reading every real use of `outputs`
// below (type, name, and value range are the whole of what "Init shader outputs" reads).
//
// **One shared `NameAllocator`, passed in explicitly rather than reached through
// `state.get_name_allocator()`** - upstream's own `ShaderGenerator(GeneratorState& state) :
// m_varManager(state.getNameAllocator())` ties `m_varManager`'s name source to the *same*
// `GeneratorState` object for the whole call, which this port's established test
// convention already avoids for a real lifetime reason: `GeneratorState::get_name_
// allocator(&mut self) -> &mut NameAllocator` borrows the *entire* `GeneratorState`
// for as long as the returned reference (and therefore anything built from it, like a
// `VariableManager<'a>`) is alive - incompatible with this cluster's whole threading
// convention of passing `&mut GeneratorState` and `&mut VariableManager` as two
// *independent* parameters everywhere else (`BlockStatement::new`, `FunctionGenerator::
// generate`, ...). Every existing test in this cluster already sidesteps this by
// constructing its own standalone `NameAllocator` rather than going through `state`
// at all (e.g. `rsg::statement_generator`'s own `new_var_manager` helper) - `rsg::
// program_generator::generate` follows the identical, already-established pattern:
// one `NameAllocator` owned by the real top-level driver, threaded through both shader
// generations in turn (sequentially, so only ever one `&mut` borrow of it at a time),
// which reproduces upstream's real cross-shader name-uniqueness property exactly (one
// shared counter) without the lifetime conflict `state.get_name_allocator()` would cause
// here. `GeneratorState::get_name_allocator` itself stays exactly as ported - this is
// simply not the call site that uses it.
//
// **`findByName`/`AnyEntry::Iterator` collapse onto `VariableManager::entries_matching
// (any_entry)`** - the same `Iterator::filter`-based translation `rsg::variable_manager`'s
// own top doc comment already established for the whole `FilteredIterator` apparatus;
// nothing new needed here beyond calling it.
//
// **`fillUndefinedComponents`/`fillUndefinedShaderInputs` need no `VariableManager` at
// all** - upstream's own `(*i)->getVariable()->getType().isSampler()` and this port's
// `input.get_value_range().get_type().is_sampler()` read the identical fact (a
// `ShaderInput`'s own stored `ValueRange` already carries a clone of its variable's type,
// confirmed in `rsg::shader::ShaderInput`'s own doc comment), so resolving through a
// manager was never actually necessary even in the upstream shape - this port's version
// simply makes that explicit by not taking one.
//
// **`StridedValueAccess::operator=(const tcu::Vector<float,4>&)` is not ported** (see
// `rsg::variable_value`'s own top doc comment for the specific upstream UB this port
// deliberately does not reproduce) - the two call sites that would have used it
// (`fragColorVar`'s default `[0,1]` range, `gl_Position`'s `[-1,1]x[-1,1]x{0}x{1}` range)
// instead set each of the four components explicitly via `set_float_vec4_range` below, the
// same "spell out the loop" translation every other vector-range construction in this
// cluster already uses.
//
// **`BlockStatement::new_empty` is this file's one real non-random-dispatch caller**
// (alongside `FunctionGenerator::generate`'s own root-block case, which *does* randomize) -
// `genVertexPassthrough`/`genFragmentPassthrough` need a real, already-existing root block
// to `add_child` into without ever touching `statement_generator`'s weighted dispatch, the
// same role upstream's always-present-but-possibly-uninitialized `m_functionBlock` plays
// in that code path. See `BlockStatement::new_empty`'s own doc comment.
//
// **`generate` takes `shader: &mut Shader` as its only shader-related parameter (no
// separate `arena: &mut StatementArena`)** - a genuine Rust-only wrinkle, not an upstream
// behaviour question: `Shader` owns its own `StatementArena` as a field (see `rsg::shader`'s
// own top doc comment), but this function also needs `shader`'s `main_function` mutably at
// the same time as its `statement_arena` (building a function body's root block touches
// both). Calling `shader.get_main_mut()` and `shader.statement_arena_mut()` as two separate
// top-level calls on the same `&mut Shader` does not borrow-check - each accessor method's
// signature conservatively ties up all of `*shader` for as long as its result lives, since
// the borrow checker does not look inside a called method's body to see it only touches one
// field. `Shader::fields_mut` (added alongside this file, see its own doc comment) returns
// every field needed at once via direct field-projection expressions, which the borrow
// checker *does* understand as disjoint - `generate` calls it exactly once, into `fields`,
// and never touches `shader` directly again afterward (only `shader.get_type()`, captured
// into the `Copy` local `shader_type` *before* `fields_mut()` is called, needs a read of
// `shader` at all past that point).
//
// **The final "tokenize shader and write source" block is now ported too**, once
// `rsg::pretty_printer` existed (added alongside this change - see its own top doc
// comment). One real wrinkle: by this point `generate` still holds `fields` (the
// `ShaderFieldsMut` from `shader.fields_mut()`, see above) - `fields.inputs`/
// `fields.uniforms` are the *last* use of it (`fill_undefined_shader_inputs`'s own two
// calls), so `fields`'s own mutable borrow of `shader` ends right there (Rust drops a
// borrow at its last use, not at the end of its lexical scope) and `shader.tokenize(...)`
// below - needing a fresh *shared* borrow of the whole `Shader` - is reachable in the same
// function body only because of that. `PrettyPrinter` owns its own output `String` rather
// than upstream's `std::ostringstream&` (see that module's own doc comment for why), so
// the `"#version 300 es\n"` prefix upstream writes directly to the shared stream becomes a
// plain `String::push_str` onto `PrettyPrinter::finish()`'s own returned string instead.

use super::expression::{Expression, VariableRead};
use super::function_generator::FunctionGenerator;
use super::generator_state::{CONST_EXPR, GeneratorState, NO_VAR_ALLOCATION};
use super::name_allocator::NameAllocator;
use super::parameters::{ShaderParameters, Version};
use super::pretty_printer::PrettyPrinter;
use super::shader::{Function, Shader, ShaderInput};
use super::statement::{AssignStatement, BlockStatement, DeclarationStatement, Statement, StatementArena, StatementId};
use super::token::TokenStream;
use super::utils::is_undefined_value_range;
use super::variable::{ShaderType, Storage};
use super::variable_manager::{ReservedScalars, ValueScope, VariableId, VariableManager, any_entry};
use super::variable_type::{Type, VariableType};
use super::variable_value::{ValueRange, ValueRangeAccess};

/// `getFragColorName` (file-local upstream).
fn get_frag_color_name(state: &GeneratorState<'_>) -> &'static str {
    match state.get_program_parameters().version {
        Version::Version100 => "gl_FragColor",
        Version::Version300 => "dEQP_FragColor",
    }
}

/// Sets all four components of a float vector `ValueRangeAccess`'s own `(min, max)` pair
/// explicitly - see this module's own top doc comment for why, in place of upstream's
/// `valueRange.getMin() = tcu::Vec4(...)`.
fn set_float_vec4_range(mut range: ValueRangeAccess<'_>, min: [f32; 4], max: [f32; 4]) {
    for i in 0..4 {
        range.component(i).get_min().set_float(min[i as usize]);
        range.component(i).get_max().set_float(max[i as usize]);
    }
}

/// `createAssignment` (file-local upstream) - `block_id` must already name a
/// `Statement::Block` in `arena`.
fn create_assignment(arena: &mut StatementArena, block_id: StatementId, dst_var: VariableId, src_var: VariableId) {
    let read_expr = Expression::VariableRead(VariableRead::from_variable(src_var));
    let assign_id = arena.insert(Statement::Assign(AssignStatement::from_expression(dst_var, read_expr)));
    match arena.get_mut(block_id) {
        Statement::Block(block) => block.add_child(assign_id),
        _ => unreachable!("create_assignment: block_id must name a Statement::Block"),
    }
}

/// `genVertexPassthrough` (file-local upstream) - copies every live `ShaderOut` variable
/// from a fresh `a_<name>` (`v_`-prefix stripped) shader input. Takes `main_function`
/// directly rather than `shader: &mut Shader` - see `Shader::fields_mut`'s own doc
/// comment for why a free function needing both a shader's `main_function` and its
/// `statement_arena` at once cannot get them from two separate accessor calls on the
/// same `&mut Shader`.
fn gen_vertex_passthrough(
    arena: &mut StatementArena,
    main_function: &mut Function,
    var_manager: &mut VariableManager<'_>,
) {
    let body_id = arena.insert(Statement::Block(BlockStatement::new_empty()));
    main_function.get_body_mut().push(body_id);

    let entries: Vec<_> = var_manager.entries_matching(any_entry).collect();

    for entry_id in entries {
        let (out_var, out_range) = {
            let entry = var_manager.get_entry(entry_id);
            (
                entry.get_variable(),
                ValueRange::from_access(&entry.get_value_range_const()),
            )
        };

        if var_manager.get_variable(out_var).get_storage() != Storage::ShaderOut {
            continue;
        }

        let out_name = var_manager.get_variable(out_var).get_name().to_string();
        let in_name = match out_name.strip_prefix("v_") {
            Some(stripped) => format!("a_{stripped}"),
            None => format!("a_{out_name}"),
        };

        let out_type = var_manager.get_variable(out_var).get_type().clone();
        let in_var = var_manager.allocate_named(out_type, Storage::ShaderIn, &in_name);
        var_manager.set_value(in_var, &out_range.as_const_access());

        create_assignment(arena, body_id, out_var, in_var);
    }
}

/// `genFragmentPassthrough` (file-local upstream) - a single `gl_FragColor = v_color;`
/// (or `dEQP_FragColor`, see `get_frag_color_name`). See `gen_vertex_passthrough`'s own
/// doc comment for why this takes `main_function` directly rather than `&mut Shader`.
fn gen_fragment_passthrough(
    arena: &mut StatementArena,
    main_function: &mut Function,
    state: &GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
) {
    let body_id = arena.insert(Statement::Block(BlockStatement::new_empty()));
    main_function.get_body_mut().push(body_id);

    let frag_color_name = get_frag_color_name(state);
    let frag_color_entry_id = var_manager
        .entries_matching(any_entry)
        .find(|&id| {
            var_manager
                .get_variable(var_manager.get_entry(id).get_variable())
                .get_name()
                == frag_color_name
        })
        .expect("TCU_CHECK(fragColorEntry)");

    let (frag_color_var, frag_color_range) = {
        let entry = var_manager.get_entry(frag_color_entry_id);
        (
            entry.get_variable(),
            ValueRange::from_access(&entry.get_value_range_const()),
        )
    };
    let frag_color_type = var_manager.get_variable(frag_color_var).get_type().clone();

    let in_color_var = var_manager.allocate_named(frag_color_type, Storage::ShaderIn, "v_color");
    var_manager.set_value(in_color_var, &frag_color_range.as_const_access());

    create_assignment(arena, body_id, frag_color_var, in_color_var);
}

/// `fillUndefinedComponents` (file-local upstream).
fn fill_undefined_components(mut value_range: ValueRangeAccess<'_>) {
    let base_type = value_range.get_type().base_type();
    assert!(
        matches!(base_type, Type::Float | Type::Int | Type::Bool),
        "TCU_CHECK(baseType == TYPE_FLOAT || baseType == TYPE_INT || baseType == TYPE_BOOL)"
    );

    for elem_ndx in 0..value_range.get_type().num_elements() {
        let mut component = value_range.component(elem_ndx);
        if is_undefined_value_range(&component.as_const()) {
            match base_type {
                Type::Float => {
                    component.get_min().set_float(0.0);
                    component.get_max().set_float(1.0);
                }
                Type::Int => {
                    component.get_min().set_int(0);
                    component.get_max().set_int(1);
                }
                Type::Bool => {
                    component.get_min().set_bool(false);
                    component.get_max().set_bool(true);
                }
                _ => unreachable!(),
            }
        }
    }
}

/// `fillUndefinedShaderInputs` (file-local upstream) - samplers are assigned at the
/// program level (`rsg::program_generator`), not here.
fn fill_undefined_shader_inputs(inputs: &mut [ShaderInput]) {
    for input in inputs.iter_mut() {
        if !input.get_value_range().get_type().is_sampler() {
            fill_undefined_components(input.get_value_range_mut());
        }
    }
}

/// `rsg::ShaderGenerator::generate` - see this module's own top doc comment for the full
/// account of every mechanical (not behavioural) difference from upstream's own body,
/// most load-bearingly the `outputs` parameter shape and the lack of a `rsgPrettyPrinter`-
/// backed final tokenize/source step.
pub fn generate<'a>(
    shader_params: &'a ShaderParameters,
    shader: &mut Shader,
    state: &mut GeneratorState<'a>,
    name_allocator: &mut NameAllocator,
    outputs: &[(VariableType, String, ValueRange)],
) {
    // Captured once, up front: every later use is read-only and `ShaderType` is `Copy`,
    // so there is no need to keep re-borrowing `shader` for it once `fields_mut()`
    // (below) ties up the whole object - see that method's own doc comment.
    let shader_type = shader.get_type();

    let mut var_manager = VariableManager::new(name_allocator);

    // Init state.
    state.set_shader_parameters(shader_params);
    debug_assert_eq!(state.get_expression_flags(), 0);

    // Reserve some scalars for gl_Position & dEQP_Position.
    let mut reserved_scalars = ReservedScalars::default();
    if shader_type == ShaderType::Vertex {
        var_manager.reserve(&mut reserved_scalars, 4 * 2);
    }

    // See `Shader::fields_mut`'s own doc comment for why this one call, rather than
    // several separate accessor calls, is what lets the rest of this function hold
    // `fields.main_function`/`fields.statement_arena`/etc. mutably at the same time.
    let fields = shader.fields_mut();

    // Push global scopes - taking `shader`'s own global scope by value (see
    // `rsg::variable_manager`'s own top doc comment for why `push_variable_scope`
    // always works this way in this port) and writing the finished scope back once
    // this function is done with it.
    let global_variable_scope = std::mem::take(fields.global_scope);
    var_manager.push_variable_scope(global_variable_scope);
    var_manager.push_value_scope(ValueScope::new());

    // Init shader outputs.
    {
        for (output_type, output_name, output_range) in outputs {
            let variable = var_manager.allocate_named(output_type.clone(), Storage::ShaderOut, output_name);
            var_manager.set_value(variable, &output_range.as_const_access());
        }

        if shader_type == ShaderType::Fragment {
            // gl_FragColor / dEQP_FragColor. \todo [2011-11-22 pyry] Multiple outputs
            // from fragment shader! - upstream's own `\todo`, carried over unfixed.
            let frag_color_name = get_frag_color_name(state).to_string();
            let frag_color_var = var_manager.allocate_named(
                VariableType::new_basic(Type::Float, 4),
                Storage::ShaderOut,
                &frag_color_name,
            );

            let mut value_range = ValueRange::new(var_manager.get_variable(frag_color_var).get_type().clone());
            set_float_vec4_range(value_range.as_access(), [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 1.0]);

            // Bind color output to location 0 (applies to GLSL ES 3.0 onwards).
            var_manager.get_variable_mut(frag_color_var).set_layout_location(0);

            var_manager.set_value(frag_color_var, &value_range.as_const_access());
        }
    }

    // Construct shader code.
    {
        fields.main_function.set_return_type(VariableType::default());

        if shader_params.randomize {
            let live_vars: Vec<VariableId> = var_manager.get_live_variables().to_vec();

            let mut func_gen = FunctionGenerator::new(fields.main_function);
            // Mandate assignment into all shader outputs in main().
            for &variable in &live_vars {
                if var_manager.get_variable(variable).get_storage() == Storage::ShaderOut {
                    func_gen.require_assignment(variable);
                }
            }
            func_gen.generate(fields.statement_arena, state, &mut var_manager);
        } else if shader_type == ShaderType::Vertex {
            gen_vertex_passthrough(fields.statement_arena, fields.main_function, &mut var_manager);
        } else {
            debug_assert_eq!(shader_type, ShaderType::Fragment);
            gen_fragment_passthrough(fields.statement_arena, fields.main_function, state, &mut var_manager);
        }

        if shader_type == ShaderType::Vertex {
            // Add gl_Position = dEQP_Position;
            var_manager.release(&mut reserved_scalars);

            let gl_pos_var = var_manager.allocate_named(
                VariableType::new_basic(Type::Float, 4),
                Storage::ShaderOut,
                "gl_Position",
            );
            let deqp_pos_var = var_manager.allocate_named(
                VariableType::new_basic(Type::Float, 4),
                Storage::ShaderIn,
                "dEQP_Position",
            );

            let mut value_range = ValueRange::new(var_manager.get_variable(gl_pos_var).get_type().clone());
            set_float_vec4_range(value_range.as_access(), [-1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0]);

            // \todo [2011-05-24 pyry] No expression should be able to use gl_Position
            // or dEQP_Position.. - upstream's own `\todo`, carried over unfixed.
            var_manager.set_value(deqp_pos_var, &value_range.as_const_access());

            let main_body_id = *fields
                .main_function
                .get_body()
                .last()
                .expect("the main function always has a root block by this point");
            create_assignment(fields.statement_arena, main_body_id, gl_pos_var, deqp_pos_var);
        }
    }

    // Declare live global variables.
    {
        let live_variables: Vec<VariableId> = var_manager.get_live_variables().to_vec();
        let mut create_declaration_statement_vars: Vec<VariableId> = Vec::new();

        for &variable in &live_variables {
            let name = var_manager.get_variable(variable).get_name().to_string();
            let declare = !name.starts_with("gl_"); // Do not declare built-in types.

            match var_manager.get_variable(variable).get_storage() {
                Storage::ShaderIn => {
                    let value_range = ValueRange::from_access(
                        &var_manager
                            .get_value(variable)
                            .expect("just-allocated variable must have a value entry")
                            .get_value_range_const(),
                    );
                    fields
                        .inputs
                        .push(ShaderInput::new(variable, name.clone(), &value_range.as_const_access()));
                }
                Storage::Uniform => {
                    let value_range = ValueRange::from_access(
                        &var_manager
                            .get_value(variable)
                            .expect("just-allocated variable must have a value entry")
                            .get_value_range_const(),
                    );
                    fields
                        .uniforms
                        .push(ShaderInput::new(variable, name.clone(), &value_range.as_const_access()));
                }
                _ => {}
            }

            if declare {
                create_declaration_statement_vars.push(variable);
            } else {
                // Just move to global scope without declaration statement.
                var_manager.declare_variable(variable);
            }
        }

        // All global initializers must be constant expressions, no variable allocation
        // is allowed.
        debug_assert_eq!(state.get_expression_flags(), 0);
        state.push_expression_flags(CONST_EXPR | NO_VAR_ALLOCATION);

        for &variable in &create_declaration_statement_vars {
            let decl = DeclarationStatement::new(state, &mut var_manager, Some(variable));
            let decl_id = fields.statement_arena.insert(Statement::Declaration(decl));
            fields.global_statements.push(decl_id);
        }

        state.pop_expression_flags();
    }

    // Pop global scopes.
    let final_global_scope = var_manager.pop_variable_scope();
    let _ = var_manager.pop_value_scope();
    *fields.global_scope = final_global_scope;

    // Fill undefined (unused) components in inputs with unused values.
    fill_undefined_shader_inputs(fields.inputs);
    fill_undefined_shader_inputs(fields.uniforms);

    // Tokenize shader and write source. `fields`'s own mutable borrow of `shader` ends
    // at the two calls just above (its own last use) - see this module's own top doc
    // comment for why that is exactly what makes `shader.tokenize(...)` below (needing
    // a fresh shared borrow of the whole `Shader`) reachable here at all.
    {
        let mut token_stream = TokenStream::new();
        let mut random = *state.get_random();
        super::expression::with_tokenize_random(&mut random, || {
            shader.tokenize(&var_manager, state, &mut token_stream)
        });
        *state.get_random() = random;

        let mut printer = PrettyPrinter::new();
        printer.append(&token_stream);

        let mut source = String::new();
        if state.get_program_parameters().version == Version::Version300 {
            source.push_str("#version 300 es\n");
        }
        source.push_str(&printer.finish());

        shader.set_source(source);
    }

    shader.set_variables(var_manager.into_variables());
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::parameters::ProgramParameters;
    use crate::tcu::random::Random;

    fn new_params(randomize: bool) -> (ProgramParameters, ShaderParameters) {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            randomize,
            max_statement_depth: 3,
            max_statements_per_block: 2,
            ..ShaderParameters::default()
        };
        (program_params, shader_params)
    }

    #[test]
    fn passthrough_fragment_shader_declares_v_color_and_assigns_frag_color() {
        let (program_params, shader_params) = new_params(false);
        let mut random = Random::new(5);
        let mut state = GeneratorState::new(&program_params, &mut random);
        let mut name_alloc = NameAllocator::new();
        let mut shader = Shader::new(ShaderType::Fragment);

        generate(&shader_params, &mut shader, &mut state, &mut name_alloc, &[]);

        // `v_color` is the one shader input the passthrough path creates.
        assert_eq!(shader.get_inputs().len(), 1);

        // Exactly one statement in main's body: `gl_FragColor = v_color;`.
        let body_id = *shader.get_main().get_body().last().unwrap();
        match shader.statement_arena().get(body_id) {
            Statement::Block(b) => assert_eq!(b.get_children_for_test().len(), 1),
            _ => unreachable!(),
        }
    }

    #[test]
    fn passthrough_vertex_shader_adds_gl_position_assignment_after_its_own_passthrough_body() {
        let (program_params, shader_params) = new_params(false);
        let mut random = Random::new(6);
        let mut state = GeneratorState::new(&program_params, &mut random);
        let mut name_alloc = NameAllocator::new();
        let mut shader = Shader::new(ShaderType::Vertex);

        // One shader-output `outputs` entry, matching what `ProgramGenerator` would
        // have resolved from the fragment shader's own `v_color` input.
        let out_type = VariableType::new_basic(Type::Float, 4);
        let mut out_range = ValueRange::new(out_type.clone());
        set_float_vec4_range(out_range.as_access(), [0.0; 4], [1.0; 4]);
        let outputs = vec![(out_type, "v_color".to_string(), out_range)];

        generate(&shader_params, &mut shader, &mut state, &mut name_alloc, &outputs);

        // The passthrough path creates exactly one assignment for `v_color` (from a
        // fresh `a_color` input), and the `gl_Position = dEQP_Position;` assignment is
        // appended afterward, into the *same* root block - two children total.
        let body_id = *shader.get_main().get_body().last().unwrap();
        match shader.statement_arena().get(body_id) {
            Statement::Block(b) => assert_eq!(b.get_children_for_test().len(), 2),
            _ => unreachable!(),
        }

        // Two `ShaderIn` inputs end up declared: `a_color` (from the passthrough) and
        // `dEQP_Position` (added by the `gl_Position` block afterward).
        assert_eq!(shader.get_inputs().len(), 2);
    }

    #[test]
    fn randomized_fragment_shader_builds_without_panicking_across_several_seeds() {
        let (program_params, shader_params) = new_params(true);

        for seed in 0..5 {
            let mut random = Random::new(seed);
            let mut state = GeneratorState::new(&program_params, &mut random);
            let mut name_alloc = NameAllocator::new();
            let mut shader = Shader::new(ShaderType::Fragment);

            generate(&shader_params, &mut shader, &mut state, &mut name_alloc, &[]);

            // Exactly one root block in main, regardless of what randomized content it
            // holds - `FunctionGenerator::generate` always pushes exactly one.
            assert_eq!(shader.get_main().get_body().len(), 1, "seed {seed}");
            let body_id = shader.get_main().get_body()[0];
            assert!(
                matches!(shader.statement_arena().get(body_id), Statement::Block(_)),
                "seed {seed}"
            );
        }
    }

    #[test]
    fn randomized_vertex_shader_builds_without_panicking_and_keeps_exactly_one_root_block() {
        let (program_params, shader_params) = new_params(true);

        for seed in 0..5 {
            let mut random = Random::new(seed);
            let mut state = GeneratorState::new(&program_params, &mut random);
            let mut name_alloc = NameAllocator::new();
            let mut shader = Shader::new(ShaderType::Vertex);

            let out_type = VariableType::new_basic(Type::Float, 4);
            let mut out_range = ValueRange::new(out_type.clone());
            set_float_vec4_range(out_range.as_access(), [0.0; 4], [1.0; 4]);
            let outputs = vec![(out_type, "v_color".to_string(), out_range)];

            generate(&shader_params, &mut shader, &mut state, &mut name_alloc, &outputs);

            // The randomized path still produces exactly one root block in `main` -
            // `gl_Position`'s own assignment is appended into that *same* block (see
            // `create_assignment`'s call site in `generate`), never a second one.
            assert_eq!(shader.get_main().get_body().len(), 1, "seed {seed}");

            // `dEQP_Position` must be present among the declared shader inputs.
            assert!(!shader.get_inputs().is_empty(), "seed {seed}");
        }
    }
}
