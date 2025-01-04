// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderConstExprTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Unlike `gls::shader_const_expr_tests` (shader-library cases, vertex and fragment only) these cases run the expression through `ShaderExecUtil` in every stage a desktop 4.3+ context has, so the case names carry a stage suffix. The ES branches of upstream's `createTestCasesForAllShaderTypes` are dropped: the roots here are desktop only.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::shader_util::{DataType, get_data_type_vector};
use crate::glu::{Context, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// `ShaderConstExpr::TestParams`
struct TestParams {
    name: &'static str,
    expression: &'static str,
    in_type: DataType,
    min_components: i32,
    max_components: i32,
    out_type: DataType,
    output: f32,
}

const fn params(
    name: &'static str,
    expression: &'static str,
    in_type: DataType,
    min_components: i32,
    max_components: i32,
    out_type: DataType,
    output: f32,
) -> TestParams {
    TestParams {
        name,
        expression,
        in_type,
        min_components,
        max_components,
        out_type,
        output,
    }
}

const SHADER_TYPES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Compute,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
];

/// `getShaderTypeName`
fn shader_type_name(shader_type: ShaderType) -> &'static str {
    match shader_type {
        ShaderType::Vertex => "vertex",
        ShaderType::Fragment => "fragment",
        ShaderType::Compute => "compute",
        ShaderType::Geometry => "geometry",
        ShaderType::TessControl => "tess_control",
        ShaderType::TessEvaluation => "tess_eval",
    }
}

/// `deFloatRsq`
fn rsq(a: f32) -> f32 {
    let s = a.sqrt();
    if s == 0.0 { 0.0 } else { 1.0 / s }
}

fn sign(a: f32) -> f32 {
    if a == 0.0 {
        0.0
    } else if a > 0.0 {
        1.0
    } else {
        -1.0
    }
}

/// `deFloatRadians`
fn radians(a: f32) -> f32 {
    a * (std::f32::consts::PI / 180.0)
}

/// `deFloatDegrees`
fn degrees(a: f32) -> f32 {
    a * (180.0 / std::f32::consts::PI)
}

/// `deFloatRound`
fn round(a: f32) -> f32 {
    (a + 0.5).floor()
}

/// `deFloatMod` - `fmod`
fn modulo(a: f32, b: f32) -> f32 {
    a % b
}

struct ExecutorTestCase {
    case_name: String,
    shader_type: ShaderType,
    source: String,
    out_type: DataType,
    output: f32,
}

impl ExecutorTestCase {
    /// `ExecutorTestCase<float>::validateOutput`
    fn validate_float(&self, executor: &shader_exec_util::ShaderExecutor) -> TestOutcome {
        let mut bytes = 0.0f32.to_ne_bytes();
        {
            let mut out_slice: &mut [u8] = &mut bytes;
            executor.execute(1, &[], std::slice::from_mut(&mut out_slice))?;
        }
        let result = f32::from_ne_bytes(bytes);

        let epsilon = 0.01f32;
        if (self.output - result).abs() > epsilon {
            log::warn!(
                "Expected: {} ({:#010x}) but constant expresion returned: {result} ({:#010x}), used {epsilon} epsilon for comparison",
                self.output,
                self.output.to_bits(),
                result.to_bits()
            );
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `ExecutorTestCase<int>::validateOutput`
    fn validate_int(&self, executor: &shader_exec_util::ShaderExecutor) -> TestOutcome {
        let expected = self.output as i32;
        let mut bytes = 0i32.to_ne_bytes();
        {
            let mut out_slice: &mut [u8] = &mut bytes;
            executor.execute(1, &[], std::slice::from_mut(&mut out_slice))?;
        }
        let result = i32::from_ne_bytes(bytes);

        if result == expected {
            return Ok(TestStatus::pass("Pass"));
        }

        log::warn!("Expected: {expected} but constant expresion returned: {result}");
        Ok(TestStatus::fail("Fail"))
    }
}

impl TestCase for ExecutorTestCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut shader_spec = ShaderSpec::new(context.context_type().glsl_version());
        shader_spec.source = self.source.clone();
        shader_spec.outputs.push(Symbol::new(
            "out0",
            VarType::basic(self.out_type, Some(Precision::HighP)),
        ));
        shader_spec.global_declarations.push_str("precision highp float;\n");

        let executor = shader_exec_util::create_executor(&context.render_context, self.shader_type, &shader_spec)?;

        if !executor.is_ok() {
            return Err(TestError::Fail("Compilation failed".to_string()));
        }

        executor.use_program(context.gl());

        if self.out_type == DataType::Float {
            self.validate_float(&executor)
        } else {
            self.validate_int(&executor)
        }
    }
}

/// `createTestCasesForAllShaderTypes`, for a desktop 4.3+ context. The `ShaderSpec` (whose GLSL version is the context's) is built when the case runs, since the tree exists before any context does.
fn create_test_cases_for_all_shader_types(
    case_name: &str,
    source: &str,
    out_type: DataType,
    output: f32,
    output_tests: &mut Vec<Box<dyn TestCase>>,
) {
    for shader_type in SHADER_TYPES {
        output_tests.push(Box::new(ExecutorTestCase {
            case_name: format!("{case_name}_{}", shader_type_name(shader_type)),
            shader_type,
            source: source.to_string(),
            out_type,
            output,
        }));
    }
}

/// `ShaderConstExpr::createTests`
fn create_tests_from(
    cases: &[TestParams],
    shader_template_src: &str,
    case_prefix: &str,
    output_tests: &mut Vec<Box<dyn TestCase>>,
) {
    let shader_template = StringTemplate::new(shader_template_src);
    let component_access = ["", ".y", ".z", ".w"];

    for test_case in cases {
        let always_scalar = test_case.expression.contains("${MT}");
        let expression_template = StringTemplate::new(test_case.expression);
        let case_base_type = test_case.out_type.name().to_string();

        for component in test_case.min_components - 1..test_case.max_components {
            let type_name = get_data_type_vector(test_case.in_type, component + 1).name();
            let access = component_access[component as usize];

            let specialize = |mt: &str| -> String {
                let expression = expression_template
                    .specialize(&[("T", type_name.to_string()), ("MT", mt.to_string())])
                    .expect("every placeholder has a value");
                shader_template
                    .specialize(&[
                        ("CASE_BASE_TYPE", case_base_type.clone()),
                        ("CASE_EXPRESSION", format!("{expression}{access}")),
                    ])
                    .expect("every placeholder has a value")
            };

            let mut case_name = format!("{case_prefix}{}", test_case.name);
            if test_case.min_components != test_case.max_components {
                case_name.push_str(&format!("_{type_name}"));
            }
            create_test_cases_for_all_shader_types(
                &case_name,
                &specialize(type_name),
                test_case.out_type,
                test_case.output,
                output_tests,
            );

            // Deal with functions that allways accept one ore more scalar parameters even when others are vectors
            if always_scalar && component > 0 {
                let scalar_name = test_case.in_type.name();
                let case_name = format!("{case_prefix}{}_{type_name}_{scalar_name}", test_case.name);
                create_test_cases_for_all_shader_types(
                    &case_name,
                    &specialize(scalar_name),
                    test_case.out_type,
                    test_case.output,
                    output_tests,
                );
            }
        }
    }
}

fn base_cases() -> Vec<TestParams> {
    use DataType::{Float, Int};
    vec![
        params("radians", "radians(${T} (90.0))", Float, 1, 4, Float, radians(90.0)),
        params("degrees", "degrees(${T} (2.0))", Float, 1, 4, Float, degrees(2.0)),
        params("sin", "sin(${T} (3.0))", Float, 1, 4, Float, 3.0f32.sin()),
        params("cos", "cos(${T} (3.2))", Float, 1, 4, Float, 3.2f32.cos()),
        params("asin", "asin(${T} (0.0))", Float, 1, 4, Float, 0.0f32.asin()),
        params("acos", "acos(${T} (1.0))", Float, 1, 4, Float, 1.0f32.acos()),
        params(
            "pow",
            "pow(${T} (1.7), ${T} (3.5))",
            Float,
            1,
            4,
            Float,
            1.7f32.powf(3.5),
        ),
        params("exp", "exp(${T} (4.2))", Float, 1, 4, Float, 4.2f32.exp()),
        params("log", "log(${T} (42.12))", Float, 1, 4, Float, 42.12f32.ln()),
        params("exp2", "exp2(${T} (6.7))", Float, 1, 4, Float, 6.7f32.exp2()),
        params("log2", "log2(${T} (100.0))", Float, 1, 4, Float, 100.0f32.log2()),
        params("sqrt", "sqrt(${T} (10.0))", Float, 1, 4, Float, 10.0f32.sqrt()),
        params("inversesqrt", "inversesqrt(${T} (10.0))", Float, 1, 4, Float, rsq(10.0)),
        params("abs", "abs(${T} (-42))", Int, 1, 4, Int, 42.0),
        params("sign", "sign(${T} (-18.0))", Float, 1, 4, Float, -1.0),
        params("floor", "floor(${T} (37.3))", Float, 1, 4, Float, 37.3f32.floor()),
        params("trunc", "trunc(${T} (-1.8))", Float, 1, 4, Float, -1.0),
        params("round", "round(${T} (42.1))", Float, 1, 4, Float, 42.0),
        params("ceil", "ceil(${T} (82.2))", Float, 1, 4, Float, 82.2f32.ceil()),
        params(
            "mod",
            "mod(${T} (87.65), ${MT} (3.7))",
            Float,
            1,
            4,
            Float,
            modulo(87.65, 3.7),
        ),
        params("min", "min(${T} (12.3), ${MT} (32.1))", Float, 1, 4, Float, 12.3),
        params("max", "max(${T} (12.3), ${MT} (32.1))", Float, 1, 4, Float, 32.1),
        params(
            "clamp",
            "clamp(${T} (42.1), ${MT} (10.0), ${MT} (15.0))",
            Float,
            1,
            4,
            Float,
            15.0,
        ),
        params("length_float", "length(1.0)", Float, 1, 1, Float, 1.0),
        params("length_vec2", "length(vec2(1.0))", Float, 1, 1, Float, 2.0f32.sqrt()),
        params("length_vec3", "length(vec3(1.0))", Float, 1, 1, Float, 3.0f32.sqrt()),
        params("length_vec4", "length(vec4(1.0))", Float, 1, 1, Float, 4.0f32.sqrt()),
        params("dot_float", "dot(1.0, 1.0)", Float, 1, 1, Float, 1.0),
        params("dot_vec2", "dot(vec2(1.0), vec2(1.0))", Float, 1, 1, Float, 2.0),
        params("dot_vec3", "dot(vec3(1.0), vec3(1.0))", Float, 1, 1, Float, 3.0),
        params("dot_vec4", "dot(vec4(1.0), vec4(1.0))", Float, 1, 1, Float, 4.0),
        params("normalize_float", "normalize(1.0)", Float, 1, 1, Float, 1.0),
        params("normalize_vec2", "normalize(vec2(1.0)).x", Float, 1, 1, Float, rsq(2.0)),
        params("normalize_vec3", "normalize(vec3(1.0)).x", Float, 1, 1, Float, rsq(3.0)),
        params("normalize_vec4", "normalize(vec4(1.0)).x", Float, 1, 1, Float, rsq(4.0)),
    ]
}

fn array_cases() -> Vec<TestParams> {
    use DataType::{Float, Int};
    vec![
        params("radians", "radians(${T} (60.0))", Float, 1, 4, Int, radians(60.0)),
        params("degrees", "degrees(${T} (0.11))", Float, 1, 4, Int, degrees(0.11)),
        params(
            "sin",
            "${T} (1.0) + sin(${T} (0.7))",
            Float,
            1,
            4,
            Int,
            1.0 + 0.7f32.sin(),
        ),
        params(
            "cos",
            "${T} (1.0) + cos(${T} (0.7))",
            Float,
            1,
            4,
            Int,
            1.0 + 0.7f32.cos(),
        ),
        params("asin", "asin(${T} (0.9))", Float, 1, 4, Int, 0.9f32.asin()),
        params("acos", "acos(${T} (-0.5))", Float, 1, 4, Int, (-0.5f32).acos()),
        params("pow", "pow(${T} (2.0), ${T} (2.0))", Float, 1, 4, Int, 2.0f32.powf(2.0)),
        params("exp", "exp(${T} (1.2))", Float, 1, 4, Int, 1.2f32.exp()),
        params("log", "log(${T} (8.0))", Float, 1, 4, Int, 8.0f32.ln()),
        params("exp2", "exp2(${T} (2.1))", Float, 1, 4, Int, 2.1f32.exp2()),
        params("log2", "log2(${T} (9.0))", Float, 1, 4, Int, 9.0f32.log2()),
        params("sqrt", "sqrt(${T} (4.5))", Float, 1, 4, Int, 4.5f32.sqrt()),
        params("inversesqrt", "inversesqrt(${T} (0.26))", Float, 1, 4, Int, rsq(0.26)),
        params("abs", "abs(${T} (-2))", Int, 1, 4, Int, 2.0),
        params("sign", "sign(${T} (18.0))", Float, 1, 4, Int, sign(18.0)),
        params("floor", "floor(${T} (3.3))", Float, 1, 4, Int, 3.3f32.floor()),
        params("trunc", "trunc(${T} (2.8))", Float, 1, 4, Int, 2.0),
        params("round", "round(${T} (2.2))", Float, 1, 4, Int, round(2.2)),
        params("ceil", "ceil(${T} (2.2))", Float, 1, 4, Int, 2.2f32.ceil()),
        params(
            "mod",
            "mod(${T} (7.1), ${MT} (4.0))",
            Float,
            1,
            4,
            Int,
            modulo(7.1, 4.0),
        ),
        params("min", "min(${T} (2.3), ${MT} (3.1))", Float, 1, 4, Int, 2.3f32.min(3.1)),
        params("max", "max(${T} (2.3), ${MT} (3.1))", Float, 1, 4, Int, 2.3f32.max(3.1)),
        params(
            "clamp",
            "clamp(${T} (4.1), ${MT} (2.1), ${MT} (3.1))",
            Float,
            1,
            4,
            Int,
            3.0,
        ),
        params("length_float", "length(2.1)", Float, 1, 1, Int, 2.0),
        params("length_vec2", "length(vec2(1.0))", Float, 1, 1, Int, 2.0f32.sqrt()),
        params("length_vec3", "length(vec3(1.0))", Float, 1, 1, Int, 3.0f32.sqrt()),
        params("length_vec4", "length(vec4(1.0))", Float, 1, 1, Int, 4.0f32.sqrt()),
        params("dot_float", "dot(1.0, 1.0)", Float, 1, 1, Int, 1.0),
        params("dot_vec2", "dot(vec2(1.0), vec2(1.01))", Float, 1, 1, Int, 2.0),
        params("dot_vec3", "dot(vec3(1.0), vec3(1.1))", Float, 1, 1, Int, 3.0),
        params("dot_vec4", "dot(vec4(1.0), vec4(1.1))", Float, 1, 1, Int, 4.0),
        params("normalize_float", "${T} (1.0) + normalize(2.0)", Float, 1, 1, Int, 2.0),
        params(
            "normalize_vec2",
            "${T} (1.0) + normalize(vec2(1.0)).x",
            Float,
            1,
            1,
            Int,
            1.0 + rsq(2.0),
        ),
        params(
            "normalize_vec3",
            "${T} (1.0) + normalize(vec3(1.0)).x",
            Float,
            1,
            1,
            Int,
            1.0 + rsq(3.0),
        ),
        params(
            "normalize_vec4",
            "${T} (1.0) + normalize(vec4(1.0)).x",
            Float,
            1,
            1,
            Int,
            1.0 + rsq(4.0),
        ),
    ]
}

/// `ShaderConstExprTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("constant_expressions");
    let mut children: Vec<Box<dyn TestCase>> = Vec::new();

    let basic_shader_template = "const ${CASE_BASE_TYPE} cval = ${CASE_EXPRESSION};\nout0 = cval;\n";
    create_tests_from(&base_cases(), basic_shader_template, "basic_", &mut children);

    let array_shader_template = "float array[int(${CASE_EXPRESSION})];\nout0 = array.length();\n";
    create_tests_from(&array_cases(), array_shader_template, "array_", &mut children);

    for child in children {
        group.add_child(child);
    }
    group
}
