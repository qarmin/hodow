// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgProgramGenerator.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `generate` ports `ProgramGenerator::generate` - the real top-level entry point of the
// whole `rsg` generator: builds the fragment shader, feeds its own inputs to the vertex
// shader as *its* outputs (so a varying the fragment stage declared gets a matching
// producer in the vertex stage), then assigns sequential sampler-unit indices across both
// shaders' uniforms.
//
// **A free function, not a struct** - upstream's `ProgramGenerator` class has no fields at
// all (`ProgramGenerator(void) {}`/`~ProgramGenerator(void) {}`, both empty, confirmed by
// reading the `.cpp`) beyond the deleted copy constructor/assignment operator (a C++-only
// idiom with no Rust equivalent need - nothing here is ever copied). A struct wrapping a
// single stateless method would add a type with nothing to hold.
//
// **One shared `de::Random`/`GeneratorState` and one shared `NameAllocator`, exactly
// matching upstream's own single `GeneratorState state(programParams, rnd);` constructed
// once and reused for both `ShaderGenerator shaderGen(state);` calls** - see
// `rsg::shader_generator`'s own top doc comment for why the `NameAllocator` is threaded
// explicitly here rather than reached through `state.get_name_allocator()` (a real
// lifetime conflict, not a style choice), and why `rsg::shader_generator::generate` is
// itself a free function taking `&mut GeneratorState` rather than owning one.
//
// **`fragmentShader.getInputs()` is resolved into an owned `Vec<(VariableType, String,
// ValueRange)>` *before* being passed as the vertex shader's `outputs`** - this is the one
// real call site that makes `rsg::shader_generator::generate`'s own `outputs` parameter
// shape *necessary*, not just defensive: by the time this function reaches the "Vertex
// shader" block, `fragment_shader`'s own `VariableManager` (built and dropped entirely
// inside the earlier `shader_generator::generate` call for the fragment shader) no longer
// exists, so a `VariableId` read off one of `fragment_shader`'s own `ShaderInput`s could
// never be resolved again - exactly the dangling-handle hazard `rsg::shader_generator`'s
// own top doc comment describes in the abstract. `ShaderInput::get_name`/`get_value_range`
// (the latter already carrying a clone of the variable's own type - see `rsg::shader`'s own
// doc comment on why `ShaderInput` gained a `name` field for precisely this call site) are
// exactly what's needed and nothing more, confirmed by reading every real use of `outputs`
// inside `rsg::shader_generator::generate`.
//
// **"Allocate samplers" needs no `VariableManager` either** - upstream's own
// `input->getVariable()->getType().isSampler()` and `input->getValueRange().getMin() =
// curSamplerNdx` both read/write exactly what a `ShaderInput`'s own stored `ValueRange`
// already carries (type and bounds), the same observation `rsg::shader_generator`'s own
// `fillUndefinedShaderInputs` doc comment already made for an identical pattern. The
// `\todo [pyry] Randomize allocation` upstream itself carries is reproduced unfixed - this
// is deliberately a fixed, deterministic assignment (vertex uniforms first, in declaration
// order, then fragment uniforms), not a random one.
//
// **One single-counter pass over each shader's uniforms in turn, not upstream's own
// build-a-unified-list-then-assign two-phase shape** - a confirmed-equivalent
// simplification, not a behaviour change: upstream's `unifiedSamplers` vector is built in
// exactly the order "every vertex uniform sampler, then every fragment uniform sampler"
// and immediately walked in that same order to assign indices, so collapsing the
// build-then-walk into a single pass per shader (threading one `&mut i32` counter across
// both calls) produces the identical index for every sampler - confirmed by tracing both
// shapes side by side, not assumed.

use super::generator_state::GeneratorState;
use super::name_allocator::NameAllocator;
use super::parameters::ProgramParameters;
use super::shader::{Shader, ShaderInput};
use super::shader_generator;
use super::variable_type::VariableType;
use super::variable_value::ValueRange;
use crate::tcu::random::Random;

/// `assignSamplerIndices` (file-local upstream, inlined into the "Allocate samplers"
/// block rather than named there) - assigns sequential sampler-unit indices to every
/// sampler-typed uniform in `uniforms`, starting from `*next_index` and leaving it just
/// past the last one assigned (so a second call, on a different shader's own uniforms,
/// continues the same sequence - see this module's own top doc comment for why this is
/// the identical assignment upstream's own two-phase build produces).
fn assign_sampler_indices(uniforms: &mut [ShaderInput], next_index: &mut i32) {
    for input in uniforms.iter_mut() {
        if input.get_value_range().get_type().is_sampler() {
            let mut range = input.get_value_range_mut();
            range.get_min().set_int(*next_index);
            range.get_max().set_int(*next_index);
            *next_index += 1;
        }
    }
}

/// `rsg::ProgramGenerator::generate` - see this module's own top doc comment for the full
/// account of every mechanical (not behavioural) difference from upstream's own body.
pub fn generate(program_params: &ProgramParameters, vertex_shader: &mut Shader, fragment_shader: &mut Shader) {
    // Random number generator.
    let mut rnd = Random::new(program_params.seed);

    let mut state = GeneratorState::new(program_params, &mut rnd);
    let mut name_allocator = NameAllocator::new();

    // Fragment shader. \note [pyry] gl_FragColor is added in ShaderGenerator.
    shader_generator::generate(
        &program_params.fragment_parameters,
        fragment_shader,
        &mut state,
        &mut name_allocator,
        &[],
    );

    // Vertex shader. \note gl_Position and dEQP_Position are handled in ShaderGenerator.
    {
        // Initialize outputs from fragment shader inputs - see this module's own top
        // doc comment for why this is resolved into an owned triple *before* crossing
        // into the vertex shader's own, separately-managed generation.
        let outputs: Vec<(VariableType, String, ValueRange)> = fragment_shader
            .get_inputs()
            .iter()
            .map(|input| {
                let range = ValueRange::from_access(&input.get_value_range());
                (range.get_type().clone(), input.get_name().to_string(), range)
            })
            .collect();

        shader_generator::generate(
            &program_params.vertex_parameters,
            vertex_shader,
            &mut state,
            &mut name_allocator,
            &outputs,
        );
    }

    // Allocate samplers. \todo [pyry] Randomize allocation. - upstream's own `\todo`,
    // carried over unfixed (see this module's own top doc comment).
    {
        let mut cur_sampler_ndx = 0;
        assign_sampler_indices(vertex_shader.get_uniforms_mut(), &mut cur_sampler_ndx);
        assign_sampler_indices(fragment_shader.get_uniforms_mut(), &mut cur_sampler_ndx);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::parameters::ShaderParameters;
    use crate::rsg::variable::ShaderType;
    use crate::rsg::variable_manager::{VariableManager, VariableScope};
    use crate::rsg::variable_type::Type;

    #[test]
    fn assign_sampler_indices_assigns_sequentially_and_skips_non_samplers() {
        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let mut mgr = VariableManager::new(&mut alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(crate::rsg::variable_manager::ValueScope::new());

        let sampler_type = VariableType::new_basic(Type::Sampler2D, 1);
        let non_sampler_type = VariableType::new_basic(Type::Float, 1);

        let s0 = mgr.allocate_named(sampler_type.clone(), crate::rsg::variable::Storage::Uniform, "u_tex0");
        let f0 = mgr.allocate_named(non_sampler_type, crate::rsg::variable::Storage::Uniform, "u_scale");
        let s1 = mgr.allocate_named(sampler_type, crate::rsg::variable::Storage::Uniform, "u_tex1");

        let zero_range = |mgr: &VariableManager<'_>, var| {
            ValueRange::from_access(&mgr.get_value(var).unwrap().get_value_range_const())
        };

        let mut uniforms = vec![
            ShaderInput::new(s0, "u_tex0", &zero_range(&mgr, s0).as_const_access()),
            ShaderInput::new(f0, "u_scale", &zero_range(&mgr, f0).as_const_access()),
            ShaderInput::new(s1, "u_tex1", &zero_range(&mgr, s1).as_const_access()),
        ];

        let mut next_index = 0;
        assign_sampler_indices(&mut uniforms, &mut next_index);

        assert_eq!(next_index, 2); // Two samplers consumed two indices.
        assert_eq!(uniforms[0].get_value_range().get_min().as_int(), 0);
        assert_eq!(uniforms[0].get_value_range().get_max().as_int(), 0);
        assert_eq!(uniforms[2].get_value_range().get_min().as_int(), 1);
        assert_eq!(uniforms[2].get_value_range().get_max().as_int(), 1);
        // The non-sampler uniform is left at its own, untouched (zero) range.
        assert_eq!(uniforms[1].get_value_range().get_min().as_int(), 0);
        assert_eq!(uniforms[1].get_value_range().get_max().as_int(), 0);
    }

    #[test]
    fn assign_sampler_indices_continues_a_shared_counter_across_two_calls() {
        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let mut mgr = VariableManager::new(&mut alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(crate::rsg::variable_manager::ValueScope::new());

        let sampler_type = VariableType::new_basic(Type::SamplerCube, 1);
        let a = mgr.allocate_named(sampler_type.clone(), crate::rsg::variable::Storage::Uniform, "u_a");
        let b = mgr.allocate_named(sampler_type, crate::rsg::variable::Storage::Uniform, "u_b");

        let zero_range = |mgr: &VariableManager<'_>, var| {
            ValueRange::from_access(&mgr.get_value(var).unwrap().get_value_range_const())
        };

        let mut first_shader_uniforms = vec![ShaderInput::new(a, "u_a", &zero_range(&mgr, a).as_const_access())];
        let mut second_shader_uniforms = vec![ShaderInput::new(b, "u_b", &zero_range(&mgr, b).as_const_access())];

        let mut next_index = 0;
        assign_sampler_indices(&mut first_shader_uniforms, &mut next_index);
        assign_sampler_indices(&mut second_shader_uniforms, &mut next_index);

        assert_eq!(first_shader_uniforms[0].get_value_range().get_min().as_int(), 0);
        assert_eq!(second_shader_uniforms[0].get_value_range().get_min().as_int(), 1);
    }

    #[test]
    fn generate_links_the_fragment_shaders_v_color_input_into_the_vertex_shaders_outputs() {
        let program_params = ProgramParameters {
            vertex_parameters: ShaderParameters {
                randomize: false,
                ..ShaderParameters::default()
            },
            fragment_parameters: ShaderParameters {
                randomize: false,
                ..ShaderParameters::default()
            },
            ..ProgramParameters::default()
        };

        let mut vertex_shader = Shader::new(ShaderType::Vertex);
        let mut fragment_shader = Shader::new(ShaderType::Fragment);

        generate(&program_params, &mut vertex_shader, &mut fragment_shader);

        // The fragment shader's own passthrough declares exactly one input, `v_color`.
        assert_eq!(fragment_shader.get_inputs().len(), 1);
        assert_eq!(fragment_shader.get_inputs()[0].get_name(), "v_color");

        // The vertex shader's passthrough must have produced a matching `a_color` input
        // (stripped `v_` prefix) for the `v_color` output it was fed as `outputs`, plus
        // `dEQP_Position` from its own `gl_Position` block - two inputs total, matching
        // `rsg::shader_generator`'s own dedicated passthrough test.
        assert_eq!(vertex_shader.get_inputs().len(), 2);
    }

    #[test]
    fn generate_builds_randomized_programs_without_panicking_across_several_seeds() {
        for seed in 0..5 {
            let program_params = ProgramParameters {
                seed,
                vertex_parameters: ShaderParameters {
                    randomize: true,
                    max_statement_depth: 3,
                    max_statements_per_block: 2,
                    ..ShaderParameters::default()
                },
                fragment_parameters: ShaderParameters {
                    randomize: true,
                    max_statement_depth: 3,
                    max_statements_per_block: 2,
                    ..ShaderParameters::default()
                },
                ..ProgramParameters::default()
            };

            let mut vertex_shader = Shader::new(ShaderType::Vertex);
            let mut fragment_shader = Shader::new(ShaderType::Fragment);

            generate(&program_params, &mut vertex_shader, &mut fragment_shader);

            // Both shaders end up with exactly one root block in `main`, regardless of
            // seed - `rsg::function_generator::generate` always produces exactly one.
            assert_eq!(vertex_shader.get_main().get_body().len(), 1, "seed {seed}");
            assert_eq!(fragment_shader.get_main().get_body().len(), 1, "seed {seed}");
        }
    }
}
