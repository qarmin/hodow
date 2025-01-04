// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp   (`ShaderTests`, `ShaderLibraryTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `gls::ShaderLibrary`-driven sub-groups are each a `.test` file that
// `scripts/gen_shader_library.py` turned into `src/generated/shader_library/`; the rest
// are `gls::ShaderRenderCase` consumers. `random` is `gls::random_shader_tests`; `builtin_functions` has all of `precision` (`gls::
// builtin_precision_tests`, shared with `gles31`'s own) plus `common.abs`/`common.sign`
// (`shader_common_function_tests`, `gles3`-only) - see each module's own header for
// what remains; `operator` is partial - see `shader_operator_tests.rs`'s own header for
// exactly which of its sub-groups are ported and why the rest still need a framework
// change.
//
// `metamorphic` embeds the GraphicsFuzz shaders (`data/graphicsfuzz/`) with `include_str!`.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::glu::TestCaseGroup;

/// `ShaderTests::init`, restricted to the shader-library groups.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shaders");

    group.add_child(create_group("preprocessor", &lib::gles3_preprocessor::ROOT));
    group.add_child(create_group("constants", &lib::gles3_constants::ROOT));
    group.add_child(create_group("linkage", &lib::gles3_linkage::ROOT));
    group.add_child(create_group("conversions", &lib::gles3_conversions::ROOT));
    group.add_child(create_group("conditionals", &lib::gles3_conditionals::ROOT));
    group.add_child(create_group("declarations", &lib::gles3_declarations::ROOT));
    group.add_child(create_group("swizzles", &lib::gles3_swizzles::ROOT));
    group.add_child(create_group(
        "swizzle_math_operations",
        &lib::gles3_swizzle_math_operations::ROOT,
    ));
    group.add_child(create_group("functions", &lib::gles3_functions::ROOT));
    group.add_child(create_group("arrays", &lib::gles3_arrays::ROOT));
    group.add_child(create_group(
        "large_constant_arrays",
        &lib::gles3_large_constant_arrays::ROOT,
    ));
    group.add_child(create_group("keywords", &lib::gles3_keywords::ROOT));
    group.add_child(create_group(
        "qualification_order",
        &lib::gles3_qualification_order::ROOT,
    ));
    group.add_child(create_group("scoping", &lib::gles3_scoping::ROOT));
    group.add_child(create_group("negative", &lib::gles3_negative::ROOT));
    group.add_child(create_group("uniform_block", &lib::gles3_uniform_block::ROOT));
    group.add_child(create_group(
        "invalid_implicit_conversions",
        &lib::gles3_invalid_implicit_conversions::ROOT,
    ));

    group.add_child(super::shader_builtin_var_tests::create_tests());
    group.add_child(super::shader_discard_tests::create_tests());
    group.add_child(super::frag_depth_tests::create_tests());
    group.add_child(super::shader_precision_tests::create_tests());
    group.add_child(super::shader_frag_data_tests::create_tests());
    group.add_child(super::shader_function_tests::create_tests());
    group.add_child(super::shader_indexing_tests::create_tests());
    group.add_child(super::shader_loop_tests::create_tests());
    group.add_child(super::shader_matrix_tests::create_tests());
    group.add_child(super::shader_operator_tests::create_tests());
    group.add_child(super::shader_return_tests::create_tests());
    group.add_child(super::shader_struct_tests::create_tests());
    group.add_child(super::shader_switch_tests::create_tests());
    group.add_child(super::shader_texture_function_tests::create_tests());
    group.add_child(super::shader_derivate_tests::create_tests());
    // Upstream's `ShaderBuiltinFunctionTests` - `precision` (`builtin_precision_tests`)
    // plus `common` (`shader_common_function_tests`, `abs`/`sign` only so far) share the
    // one `builtin_functions` node, exactly as upstream nests both under the same
    // `TestCaseGroup`.
    {
        let mut builtin_functions = super::builtin_precision_tests::create_tests();
        builtin_functions.add_child(super::shader_common_function_tests::create_tests());
        builtin_functions.add_child(super::shader_packing_function_tests::create_tests());
        group.add_child(builtin_functions);
    }
    group.add_child(super::shader_invariance_tests::create_tests());
    group.add_child(super::shader_metamorphic_tests::create_tests());
    group.add_child(super::shader_const_expr_tests::create_tests());
    group.add_child(crate::gls::random_shader_tests::create_tests(
        crate::rsg::parameters::Version::Version300,
    ));

    group
}
