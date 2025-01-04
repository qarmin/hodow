// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp   (`ShaderTests`, `ShaderLinkageTests`,
//                                                         `ShaderLibraryGroup`, `ShaderLibraryTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds each of these groups by parsing a `.test` shader-library file at run time;
// here the same trees come out of `src/generated/shader_library/`, which
// `scripts/gen_shader_library.py` produced from those very files. Only the shader-library
// sub-groups of `ShaderTests` are registered as such - `builtin_var`, `sample_variables`,
// `multisample_interpolation`, `helper_invocation`, `builtin_constants`, `opaque_type_indexing`
// and `builtin_functions` (its `precision.add` slice only - see `builtin_precision_tests`) are
// the ones that are. `framebuffer_fetch` is a real port too, just not a shader-library one -
// see `shader_framebuffer_fetch_tests.rs` (needs real render-to-texture plus
// `gl_LastFragData`/`EXT_shader_framebuffer_fetch` readback, unlike everything else in this
// file).

use crate::generated::shader_library as lib;
use crate::gls::shader_library::{Group, create_group};
use crate::glu::TestCaseGroup;

/// `ShaderLibraryGroup` - one child group per upstream `.test` file.
fn library_group(name: &str, files: &[(&str, &'static Group)]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &(child_name, root) in files {
        group.add_child(create_group(child_name, root));
    }
    group
}

/// `ShaderTests::init`, restricted to the shader-library groups and the few real ones.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shaders");

    // `ShaderBuiltinVarTests` - upstream's own single child (`ComputeShaderBuiltinVarTests`).
    {
        let mut builtin_var = TestCaseGroup::new("builtin_var");
        builtin_var.add_child(super::compute_shader_builtin_var_tests::create_tests());
        group.add_child(builtin_var);
    }
    // `builtin_functions` - upstream nests `precision` and `common` under the one node,
    // exactly as `gles3::functional::shader_tests` does for its own two.
    {
        let mut builtin_functions = super::builtin_precision_tests::create_tests();
        builtin_functions.add_child(super::shader_common_function_tests::create_tests());
        builtin_functions.add_child(super::shader_integer_function_tests::create_tests());
        builtin_functions.add_child(super::shader_packing_function_tests::create_tests());
        builtin_functions.add_child(super::shader_uniform_integer_function_tests::create_tests());
        builtin_functions.add_child(super::shader_texture_size_tests::create_tests());
        group.add_child(builtin_functions);
    }
    group.add_child(super::shader_framebuffer_fetch_tests::create_tests());
    group.add_child(super::sample_variable_tests::create_tests());
    group.add_child(super::shader_multisample_interpolation_tests::create_tests());
    group.add_child(super::opaque_type_indexing_tests::create_tests());
    group.add_child(library_group(
        "functions",
        &[
            ("es31", &lib::es31_functions::ROOT),
            ("es32", &lib::es32_functions::ROOT),
        ],
    ));
    group.add_child(library_group(
        "arrays",
        &[("es31", &lib::es31_arrays::ROOT), ("es32", &lib::es32_arrays::ROOT)],
    ));
    group.add_child(library_group(
        "arrays_of_arrays",
        &[
            ("es31", &lib::es31_arrays_of_arrays::ROOT),
            ("es32", &lib::es32_arrays_of_arrays::ROOT),
        ],
    ));
    group.add_child(create_linkage_tests());
    group.add_child(super::builtin_constant_tests::create_tests());
    group.add_child(super::shader_helper_invocation_tests::create_tests());
    group.add_child(library_group(
        "implicit_conversions",
        &[
            ("es31", &lib::es31_implicit_conversions::ROOT),
            ("es32", &lib::es32_implicit_conversions::ROOT),
        ],
    ));
    group.add_child(library_group(
        "uniform_block",
        &[
            ("es31", &lib::es31_uniform_block::ROOT),
            ("es32", &lib::es32_uniform_block::ROOT),
        ],
    ));

    group
}

/// `ShaderLinkageTests::init`
fn create_linkage_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("linkage");

    group.add_child(library_group(
        "es31",
        &[
            ("declarations", &lib::es31_declarations::ROOT),
            ("geometry", &lib::es31_linkage_geometry::ROOT),
            ("tessellation", &lib::es31_linkage_tessellation::ROOT),
            ("tessellation_geometry", &lib::es31_linkage_tessellation_geometry::ROOT),
            ("shader_storage_block", &lib::es31_linkage_shader_storage_block::ROOT),
            ("io_block", &lib::es31_linkage_io_block::ROOT),
            ("uniform", &lib::es31_linkage_uniform::ROOT),
        ],
    ));
    group.add_child(library_group(
        "es32",
        &[
            ("geometry", &lib::es32_linkage_geometry::ROOT),
            ("tessellation", &lib::es32_linkage_tessellation::ROOT),
            ("tessellation_geometry", &lib::es32_linkage_tessellation_geometry::ROOT),
            ("shader_storage_block", &lib::es32_linkage_shader_storage_block::ROOT),
            ("io_block", &lib::es32_linkage_io_block::ROOT),
            ("uniform", &lib::es32_linkage_uniform::ROOT),
        ],
    ));

    group
}
