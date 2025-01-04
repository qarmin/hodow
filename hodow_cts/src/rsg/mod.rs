// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `rsg` is upstream's random shader generator (`framework/randomshaders`, namespace `rsg`), the part of the
// ES 2.0/3.0 tests that generates a random vertex and fragment shader pair and the reference image it must draw
// (`shaders.random`, `fragment_ops.interaction`). Each module ports the upstream file of the same name
// (`rsgFoo.hpp/.cpp`); its own top doc comment says how it differs from upstream and why.
//
// Modules, bottom up:
//   token, variable_type, name_allocator, parameters, samplers - leaves: lexical tokens, the GLSL type system, the
//     identifier counter, the configuration data, texture samplers for the reference interpreter
//   variable_value, execution_context, variable, variable_manager - values and variables
//   expression, statement, builtin_functions, utils - the AST and its evaluation
//   generator_state, expression_generator, statement_generator, function_generator, shader_generator,
//     program_generator - random generation
//   shader, pretty_printer, program_executor - the generated program, its GLSL text and the reference interpreter
//
// Decisions that cut across modules:
//   - Ownership. Upstream hands raw pointers between owning vectors; here `VariableManager` owns arenas indexed by
//     `VariableId`/`ValueEntryId`, and scopes hold ids.
//   - `GeneratorState` keeps no second reference to the `Shader`, the `VariableManager` or the statement stack
//     (upstream's would alias what their owners keep using). Code that needs them takes them as explicit parameters
//     next to `&mut GeneratorState`; `ShaderGenerator` is a free function for the same reason.
//   - A bug in upstream is ported as it is and recorded in `QUIRKS.md` (`ProgramParameters::declarationStatementBaseWeight`
//     is a `bool` read as a `float`).

pub mod builtin_functions;
pub mod execution_context;
pub mod expression;
pub mod expression_generator;
pub mod function_generator;
pub mod generator_state;
pub mod name_allocator;
pub mod parameters;
pub mod pretty_printer;
pub mod program_executor;
pub mod program_generator;
pub mod samplers;
pub mod shader;
pub mod shader_generator;
pub mod statement;
pub mod statement_generator;
pub mod token;
pub mod utils;
pub mod variable;
pub mod variable_manager;
pub mod variable_type;
pub mod variable_value;
