// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsShaderConstExprTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These cases are `gls::ShaderLibraryCase`s built in code rather than parsed out of a
// `.test` file, which is the one thing that makes this awkward here: `CaseSpec` and
// everything it holds is `&'static`, because every other shader-library case comes from
// `src/generated/shader_library/`. The specialized shader source and the expected value
// are computed, so they are leaked - the case tree is built once per process and lives
// as long as it, exactly like the heap objects upstream's `createTests` hands to the
// test hierarchy and never frees.

use crate::gls::shader_library::{
    CaseSpec, CaseType, Elements, ExpectResult, ProgramSpec, ShaderLibraryCase, Value, ValueBlock,
};
use crate::glu::shader_util::{DataType, get_data_type_vector};
use crate::glu::{GlslVersion, ShaderType, TestCase};
use crate::tcu::StringTemplate;

/// `gls::ShaderConstExpr::TestParams`
pub struct TestParams {
    pub name: &'static str,
    pub expression: &'static str,
    pub in_type: DataType,
    pub min_components: i32,
    pub max_components: i32,
    pub out_type: DataType,
    pub output: f32,
}

/// `gls::ShaderConstExpr::TestShaderStage`
pub const SHADER_VERTEX: u32 = 1 << 0;
pub const SHADER_FRAGMENT: u32 = 1 << 1;
pub const SHADER_BOTH: u32 = SHADER_VERTEX | SHADER_FRAGMENT;

/// `shaderTemplateSrc`. `${DECLARATIONS}` and `${OUTPUT}` are deliberately re-emitted
/// unchanged - the shader-library case fills those in itself, later.
const SHADER_TEMPLATE_SRC: &str = "#version ${GLES_VERSION}\n\
    precision highp float;\n\
    precision highp int;\n\
    ${DECLARATIONS}\n\
    void main()\n\
    {\n\
    \x20   const ${CASE_BASE_TYPE} cval = ${CASE_EXPRESSION};\n\
    \x20   out0 = cval;\n\
    \x20   ${OUTPUT}\n\
    }\n";

/// `componentAccess`
const COMPONENT_ACCESS: [&str; 4] = ["", ".y", ".z", ".w"];

/// `addOutputVar` - the expected value, in whatever the output type's own scalar is.
fn output_var(out_type: DataType, output: f32) -> &'static [Value] {
    let elements = match out_type {
        DataType::Int => Elements::Int(Box::leak(Box::new([output as i32]))),
        DataType::Uint => Elements::Int(Box::leak(Box::new([output as u32 as i32]))),
        DataType::Bool => Elements::Int(Box::leak(Box::new([i32::from(output != 0.0)]))),
        DataType::Float => Elements::Float(Box::leak(Box::new([output]))),
        other => panic!("{} is not a valid const-expression output type", other.name()),
    };

    Box::leak(Box::new([Value {
        data_type: out_type,
        name: "out0",
        elements,
    }]))
}

fn case_spec(
    case_type: CaseType,
    shader_type: ShaderType,
    source: &'static str,
    version: GlslVersion,
    out_type: DataType,
    output: f32,
) -> CaseSpec {
    CaseSpec {
        case_type,
        expect_result: ExpectResult::Pass,
        target_version: version,
        required_caps: &[],
        values: ValueBlock {
            inputs: &[],
            outputs: output_var(out_type, output),
            uniforms: &[],
        },
        programs: Box::leak(Box::new([ProgramSpec {
            sources: Box::leak(Box::new([(shader_type, source)])),
            required_extensions: &[],
            active_stages: 0,
            separable: false,
        }])),
    }
}

/// Both stage variants of one specialized shader, named after `case_name`.
fn push_stage_cases(
    out: &mut Vec<Box<dyn TestCase>>,
    case_name: &str,
    source: String,
    version: GlslVersion,
    test_stage: u32,
    out_type: DataType,
    output: f32,
) {
    let source: &'static str = Box::leak(source.into_boxed_str());

    if test_stage & SHADER_VERTEX != 0 {
        let spec = case_spec(
            CaseType::VertexOnly,
            ShaderType::Vertex,
            source,
            version,
            out_type,
            output,
        );
        out.push(Box::new(ShaderLibraryCase::new(format!("{case_name}_vertex"), spec)));
    }

    if test_stage & SHADER_FRAGMENT != 0 {
        let spec = case_spec(
            CaseType::FragmentOnly,
            ShaderType::Fragment,
            source,
            version,
            out_type,
            output,
        );
        out.push(Box::new(ShaderLibraryCase::new(format!("{case_name}_fragment"), spec)));
    }
}

/// `gls::ShaderConstExpr::createTests`
///
/// `${T}` is the final type; `${MT}` is the final type too, except in the extra variant a
/// function that always accepts a scalar parameter gets, where it becomes the scalar.
pub fn create_tests(cases: &[TestParams], version: GlslVersion, test_stage: u32) -> Vec<Box<dyn TestCase>> {
    let shader_template = StringTemplate::new(SHADER_TEMPLATE_SRC);
    let gles_version = match version {
        GlslVersion::Es100 => "100",
        _ => "300 es",
    };

    let mut ret: Vec<Box<dyn TestCase>> = Vec::new();

    for case in cases {
        // Check for presence of func(vec, scalar) style specialization, use as gatekeeper
        // for applying said specialization.
        let always_scalar = case.expression.contains("${MT}");
        let expression_template = StringTemplate::new(case.expression);

        for comp_count in case.min_components - 1..case.max_components {
            // results in float, vec2, vec3, vec4 progression (same for other primitive types)
            let type_name = get_data_type_vector(case.in_type, comp_count + 1).name();
            // Add type to case name if we are generating multiple versions
            let case_name = if case.min_components == case.max_components {
                case.name.to_string()
            } else {
                format!("{}_{type_name}", case.name)
            };

            let specialize = |mt: &str| {
                let expression = expression_template
                    .specialize(&[("T", type_name.to_string()), ("MT", mt.to_string())])
                    .expect("every placeholder has a value");
                // Add vector access to expression as needed
                shader_template
                    .specialize(&[
                        ("GLES_VERSION", gles_version.to_string()),
                        ("CASE_BASE_TYPE", case.out_type.name().to_string()),
                        ("DECLARATIONS", "${DECLARATIONS}".to_string()),
                        ("OUTPUT", "${OUTPUT}".to_string()),
                        (
                            "CASE_EXPRESSION",
                            format!("{expression}{}", COMPONENT_ACCESS[comp_count as usize]),
                        ),
                    ])
                    .expect("every placeholder has a value")
            };

            push_stage_cases(
                &mut ret,
                &case_name,
                specialize(type_name),
                version,
                test_stage,
                case.out_type,
                case.output,
            );

            // Deal with functions that allways accept one ore more scalar parameters even
            // when others are vectors.
            if always_scalar && comp_count > 0 {
                let scalar_case_name = format!("{}_{type_name}_{}", case.name, case.in_type.name());
                push_stage_cases(
                    &mut ret,
                    &scalar_case_name,
                    specialize(case.in_type.name()),
                    version,
                    test_stage,
                    case.out_type,
                    case.output,
                );
            }
        }
    }

    ret
}
