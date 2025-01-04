// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeSSBOBlockTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `SsboArgs` class is a mutable
// bag of eight strings plus a `StringTemplate` substitution; here it is a plain struct with
// a `Default` and one `set` per member, which is the same thing without the map.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram, ShaderType};
use crate::tcu::TestError;

/// `args::ArgMember`
#[derive(Clone, Copy)]
enum ArgMember {
    Format,
    BindingPoint,
    MatrixOrder,
    MemberType,
    Name,
    FixedArray,
    VariableArray,
    Reorder,
}

/// `args::SsboArgs`
#[derive(Clone)]
struct SsboArgs {
    std_format: String,
    binding_point: String,
    matrix_order: String,
    member_type: String,
    member_name: String,
    member_fixed_array: String,
    member_variable_array: String,
    member_reorder: bool,
}

impl Default for SsboArgs {
    /// `SsboArgs::setDefaultValues`
    fn default() -> Self {
        Self {
            std_format: "std430".to_string(),
            binding_point: "0".to_string(),
            matrix_order: "column_major".to_string(),
            member_type: "int".to_string(),
            member_name: "matrix".to_string(),
            member_fixed_array: "10".to_string(),
            member_variable_array: String::new(),
            member_reorder: false,
        }
    }
}

impl SsboArgs {
    /// `SsboArgs::setSingleValue`
    fn set(&mut self, member: ArgMember, data: &str) {
        match member {
            ArgMember::Format => self.std_format = data.to_string(),
            ArgMember::BindingPoint => self.binding_point = data.to_string(),
            ArgMember::MatrixOrder => self.matrix_order = data.to_string(),
            ArgMember::MemberType => self.member_type = data.to_string(),
            ArgMember::Name => self.member_name = data.to_string(),
            ArgMember::FixedArray => self.member_fixed_array = data.to_string(),
            ArgMember::VariableArray => self.member_variable_array = data.to_string(),
            ArgMember::Reorder => self.member_reorder = data == "true",
        }
    }

    /// The four block members, in whichever of the two orders `member_reorder` selects.
    fn block_members(&self) -> String {
        if self.member_reorder {
            format!(
                "    mediump vec4 array_1[{}];\n    highp mat4 {};\n    lowp {} data;\n    mediump float array_2[{}];\n",
                self.member_fixed_array, self.member_name, self.member_type, self.member_variable_array
            )
        } else {
            format!(
                "    lowp {} data;\n    highp mat4 {};\n    mediump vec4 array_1[{}];\n    mediump float array_2[{}];\n",
                self.member_type, self.member_name, self.member_fixed_array, self.member_variable_array
            )
        }
    }
}

/// `generateVaryingSSBOShader` - upstream leaves every stage but vertex and fragment as a
/// TODO returning an empty string, so only those two are here.
fn generate_varying_ssbo_shader(ctx: &NegativeTestContext<'_>, shader_type: ShaderType, args: &SsboArgs) -> String {
    let version = ctx.glsl_version_decl();
    let block = format!(
        "layout ({}, binding = {}, {}) buffer ssbo_block\n{{\n{}}} ssbo;\n",
        args.std_format,
        args.binding_point,
        args.matrix_order,
        args.block_members()
    );

    match shader_type {
        ShaderType::Vertex => format!(
            "{version}\nlayout (location = 0) in highp vec4 position;\nlayout (location = 1) in mediump vec4 colour;\nout mediump vec4 vertex_colour;\n{block}void main()\n{{\n    mediump vec4 variable;\n    gl_Position = ssbo.{name} * position;\n    for (int idx = 0; idx < {fixed}; idx++)\n    {{\n        variable += ssbo.array_1[idx];\n    }}\n    vertex_colour = colour + variable;\n}}\n",
            name = args.member_name,
            fixed = args.member_fixed_array
        ),
        ShaderType::Fragment => format!(
            "{version}\nin mediump vec4 vertex_colour;\nlayout (location = 0) out mediump vec4 fragment_colour;\n{block}void main()\n{{\n    mediump vec4 variable;\n    variable * ssbo.{name};\n    for (int idx = 0; idx < {fixed}; idx++)\n    {{\n        variable += ssbo.array_1[idx];\n    }}\n    fragment_colour = vertex_colour + variable;\n}}\n",
            name = args.member_name,
            fixed = args.member_fixed_array
        ),
        _ => String::new(),
    }
}

/// The body both cases share: one fixed vertex shader, then one fragment shader per
/// single-member change, each of which must fail to link against it.
fn link_each_variation(ctx: &mut NegativeTestContext<'_>, vertex_args: &SsboArgs, changes: &[(ArgMember, &str)]) {
    let vertex_source = generate_varying_ssbo_shader(ctx, ShaderType::Vertex, vertex_args);

    for &(member, data) in changes {
        ctx.begin_section("Multiple shaders created using SSBO's sharing the same name but not matching layouts");

        let mut fragment_args = vertex_args.clone();
        fragment_args.set(member, data);
        let fragment_source = generate_varying_ssbo_shader(ctx, ShaderType::Fragment, &fragment_args);

        let program = ShaderProgram::new(
            ctx.gl(),
            &ProgramSources::vtx_frag(vertex_source.clone(), fragment_source),
        );
        if program.program_info.ok {
            ctx.fail("Program should not have linked");
        }

        ctx.end_section();
    }
}

/// `ssbo_block_matching`
fn ssbo_block_interface_matching_tests(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let changes = [
        (ArgMember::Format, "std140"),
        (ArgMember::BindingPoint, "10"),
        (ArgMember::MatrixOrder, "row_major"),
        (ArgMember::MemberType, "vec2"),
        (ArgMember::Name, "name_changed"),
        (ArgMember::FixedArray, "20"),
        (ArgMember::VariableArray, "5"),
        (ArgMember::Reorder, "true"),
    ];

    link_each_variation(ctx, &SsboArgs::default(), &changes);
    Ok(())
}

/// `ssbo_block_shared_qualifier`
fn ssbo_using_shared_qualifier_tests(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut vertex_args = SsboArgs::default();
    for (member, data) in [
        (ArgMember::Format, "shared"),
        (ArgMember::BindingPoint, "0"),
        (ArgMember::MatrixOrder, "column_major"),
        (ArgMember::FixedArray, "10"),
        (ArgMember::VariableArray, "10"),
        (ArgMember::Reorder, "false"),
    ] {
        vertex_args.set(member, data);
    }

    let changes = [
        (ArgMember::MatrixOrder, "row_major"),
        (ArgMember::VariableArray, ""),
        (ArgMember::FixedArray, "20"),
    ];

    link_each_variation(ctx, &vertex_args, &changes);
    Ok(())
}

/// `getNegativeSSBOBlockTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: ssbo_block_interface_matching_tests,
        name: "ssbo_block_interface_matching_tests",
    },
    FunctionContainer {
        function: ssbo_using_shared_qualifier_tests,
        name: "ssbo_using_shared_qualifier_tests",
    },
];
