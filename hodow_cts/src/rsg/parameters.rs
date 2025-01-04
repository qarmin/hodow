// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgParameters.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `.cpp` is `DE_EMPTY_CPP_FILE`
// upstream (a placeholder to satisfy a build system requiring one TU per header) - all
// of this is pure configuration data, confirmed by reading both files in full.
//
// **`ProgramParameters::declaration_statement_base_weight` is ported as `bool`,
// matching a genuine upstream bug rather than "fixing" it.** Upstream declares the
// field `bool declarationStatementBaseWeight` (`rsgParameters.hpp`'s own member list),
// default-constructed with the float literal `1.0f` (which the `bool` conversion turns
// into `true`), yet its one consumer, `DeclarationStatement::getWeight`
// (`rsgStatement.cpp:333`), reads it back as a `float` return value.
// The default round-trips by accident (`true -> 1.0f`), but the field can structurally
// never hold anything other than `0.0`/`1.0` - a fractional weight like `0.3f` would
// silently collapse to `1.0` through the `bool` conversion. This was found and
// documented (not fixed) by the session that ported `Token`/`VariableType`/
// `NameAllocator`, well before anything consumed the field; `DeclarationStatement`
// (`rsg::statement`) is ported now, by a later sibling stream, and its own
// `get_weight` does read this field exactly the way upstream's does - see
// `QUIRKS.md`'s matching entry, added once the bug actually had an observable effect.

/// `rsg::NUM_RESERVED_SHADER_INPUTS` - varying/attribute slots the generator reserves
/// for its own use (`dEQP_Position`) before handing any out to generated code.
pub const NUM_RESERVED_SHADER_INPUTS: usize = 1;

/// `rsg::Version`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Version {
    /// GLSL ES 1.0
    Version100,
    /// GLSL ES 3.0
    Version300,
}

/// `rsg::ShaderParameters`
#[derive(Debug, Clone)]
pub struct ShaderParameters {
    /// If not enabled, only a simple passthrough shader will be generated.
    pub randomize: bool,
    pub max_statement_depth: i32,
    pub max_statements_per_block: i32,
    pub max_expression_depth: i32,
    pub max_combined_variable_scalars: i32,
    pub max_uniform_scalars: i32,
    pub max_input_variables: i32,

    pub tex_lookup_base_weight: f32,
    pub max_samplers: i32,
    pub use_texture_2d: bool,
    pub use_texture_cube: bool,
}

impl Default for ShaderParameters {
    fn default() -> Self {
        Self {
            randomize: false,
            max_statement_depth: 2,
            max_statements_per_block: 10,
            max_expression_depth: 5,
            max_combined_variable_scalars: 32,
            max_uniform_scalars: 512,
            max_input_variables: 8,
            tex_lookup_base_weight: 0.0,
            max_samplers: 8,
            use_texture_2d: false,
            use_texture_cube: false,
        }
    }
}

/// `rsg::ProgramParameters`
#[derive(Debug, Clone)]
pub struct ProgramParameters {
    pub seed: u32,
    pub version: Version,
    pub vertex_parameters: ShaderParameters,
    pub fragment_parameters: ShaderParameters,

    /// See this module's own top doc comment - `bool` is upstream's own declared type
    /// here, not a translation mistake, despite the field being read back as a `float`
    /// weight by its one consumer, `DeclarationStatement::get_weight`.
    pub declaration_statement_base_weight: bool,
    pub use_scalar_conversions: bool,
    pub use_swizzle: bool,
    pub use_comparison_ops: bool,
    pub use_conditionals: bool,

    pub trigonometric_base_weight: f32,
    pub exponential_base_weight: f32,
}

impl Default for ProgramParameters {
    fn default() -> Self {
        Self {
            seed: 0,
            version: Version::Version100,
            vertex_parameters: ShaderParameters::default(),
            fragment_parameters: ShaderParameters::default(),
            declaration_statement_base_weight: true,
            use_scalar_conversions: false,
            use_swizzle: false,
            use_comparison_ops: false,
            use_conditionals: false,
            trigonometric_base_weight: 0.0,
            exponential_base_weight: 0.0,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn shader_parameters_defaults_match_upstream_constructor() {
        let p = ShaderParameters::default();
        assert!(!p.randomize);
        assert_eq!(p.max_statement_depth, 2);
        assert_eq!(p.max_statements_per_block, 10);
        assert_eq!(p.max_expression_depth, 5);
        assert_eq!(p.max_combined_variable_scalars, 32);
        assert_eq!(p.max_uniform_scalars, 512);
        assert_eq!(p.max_input_variables, 8);
        assert_eq!(p.tex_lookup_base_weight, 0.0);
        assert_eq!(p.max_samplers, 8);
        assert!(!p.use_texture_2d);
        assert!(!p.use_texture_cube);
    }

    #[test]
    fn program_parameters_defaults_match_upstream_constructor() {
        let p = ProgramParameters::default();
        assert_eq!(p.seed, 0);
        assert_eq!(p.version, Version::Version100);
        // The quirk this module's top doc comment documents: upstream's own default is
        // the float `1.0f`, which through the field's actual `bool` type becomes `true`.
        assert!(p.declaration_statement_base_weight);
        assert!(!p.use_scalar_conversions);
        assert!(!p.use_swizzle);
        assert!(!p.use_comparison_ops);
        assert!(!p.use_conditionals);
        assert_eq!(p.trigonometric_base_weight, 0.0);
        assert_eq!(p.exponential_base_weight, 0.0);
    }

    #[test]
    fn num_reserved_shader_inputs_is_one() {
        assert_eq!(NUM_RESERVED_SHADER_INPUTS, 1);
    }
}
