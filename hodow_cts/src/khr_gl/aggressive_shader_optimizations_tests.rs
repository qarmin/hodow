// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcAggressiveShaderOptimizationsTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Each case renders a quad twice, once with a hand-written sin/cos approximation and once with the builtin, and requires the two images to agree under `fuzzyCompare` at 0.05. The ES and GLSL 1.x branches of upstream's specialization map are dropped: the roots here are desktop core only.

use std::collections::BTreeMap;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::{StringTemplate, Surface, TestError, TestOutcome, TestStatus};

const VS_DEFAULT: &str = "${VERSION}\n${ATTRIBUTE} highp vec2 position;\n${ATTRIBUTE} highp vec3 baseColor;\n${OUT} vec4 color;\nvoid main (void) {\n  color = vec4(baseColor, 1.0);\n  gl_Position = vec4(position, 0.0, 1.0);\n}\n";

const FS_DEFAULT: &str = "${VERSION}\nprecision mediump float;\n${IN} vec4 color;\n${FS_OUT_COLOR_DECLARATION}\nvoid main (void) {\n  ${FS_OUT_COLOR_NAME} = color;\n}\n";

const VS_CALCULATE_SIN: &str = "${VERSION}\n${ATTRIBUTE} highp vec2 position;\n${ATTRIBUTE} highp vec3 baseColor;\n${OUT} vec4 color;\n${SIN_FUNCTION_DEFINITION_VS}\nvoid main (void) {\n  const float M_2PI = 2.0 * 3.14159265358979323846;\n  ${TYPE} c = baseColor.${COLOR_COMPONENTS} * M_2PI;\n  ${TYPE} sin_c = ${SIN_FUNCTION_NAME}(c);\n  \n  color = vec4(0.0, 0.0, 0.0, 1.0);\n  color.${COLOR_COMPONENTS} = sin_c * 0.5 + 0.5;\n  gl_Position = vec4(position, 0.0, 1.0);\n}\n";

const FS_CALCULATE_SIN: &str = "${VERSION}\nprecision mediump float;\n${IN} vec4 color;\n${FS_OUT_COLOR_DECLARATION}\n\n${SIN_FUNCTION_DEFINITION_FS}\nvoid main (void) {\n  const float M_2PI = 2.0 * 3.14159265358979323846;\n  ${TYPE} c = color.${COLOR_COMPONENTS};\n  ${TYPE} sin_c = ${SIN_FUNCTION_NAME}(c * M_2PI);\n  \n  ${FS_OUT_COLOR_NAME} =vec4(0.0, 0.0, 0.0, 1.0);\n  ${FS_OUT_COLOR_NAME}.${COLOR_COMPONENTS} = sin_c * 0.5 + 0.5;\n}\n";

const SIN_FUNCTION_DEFINITION_VS: &str = "${TYPE} ${SIN_FUNCTION_NAME}(${TYPE} c) {\n  ${TYPE} sin_c = ${TYPE}(0.0);\n  float sign = 1.0;\n  float fact;\n  float fact_of;\n  \n  // Taylors series expansion for sin \n  for(int i = 0; i < 12; i++) {\n    fact = 1.0;\n    for(int j = 2; j <= 23; j++)\n      if (j <= 2 * i + 1)\n        fact *= float(j);\n    \n    sin_c += sign * pow(c, ${TYPE}(2.0 * float(i) + 1.0)) / fact;\n    sign *= -1.0;\n  }\n  return sin_c;\n}";

const SIN_FUNCTION_DEFINITION_FS: &str = "float lerpHelper(float a, float b, float weight) {\n  return a + (b - a) * weight;\n}\nfloat sinLerpHelper(int index, float weight) {\n  float sArray[17];\n  sArray[0] = 0.0;\n  sArray[1] = 0.382683;\n  sArray[2] = 0.707107;\n  sArray[3] = 0.92388;\n  sArray[4] = 1.0;\n  sArray[5] = 0.92388;\n  sArray[6] = 0.707107;\n  sArray[7] = 0.382683;\n  sArray[8] = 0.0;\n  sArray[9] = -0.382683;\n  sArray[10] = -0.707107;\n  sArray[11] = -0.92388;\n  sArray[12] = -1.0;\n  sArray[13] = -0.923879;\n  sArray[14] = -0.707107;\n  sArray[15] = -0.382683;\n  sArray[16] = 0.0;\n  \n  if (index == 0)\n    return lerpHelper(sArray[0], sArray[1], weight);\n  if (index == 1)\n    return lerpHelper(sArray[1], sArray[2], weight);\n  if (index == 2)\n    return lerpHelper(sArray[2], sArray[3], weight);\n  if (index == 3)\n    return lerpHelper(sArray[3], sArray[4], weight);\n  if (index == 4)\n    return lerpHelper(sArray[4], sArray[5], weight);\n  if (index == 5)\n    return lerpHelper(sArray[5], sArray[6], weight);\n  if (index == 6)\n    return lerpHelper(sArray[6], sArray[7], weight);\n  if (index == 7)\n    return lerpHelper(sArray[7], sArray[8], weight);\n  if (index == 8)\n    return lerpHelper(sArray[8], sArray[9], weight);\n  if (index == 9)\n    return lerpHelper(sArray[9], sArray[10], weight);\n  if (index == 10)\n    return lerpHelper(sArray[10], sArray[11], weight);\n  if (index == 11)\n    return lerpHelper(sArray[11], sArray[12], weight);\n  if (index == 12)\n    return lerpHelper(sArray[12], sArray[13], weight);\n  if (index == 13)\n    return lerpHelper(sArray[13], sArray[14], weight);\n  if (index == 14)\n    return lerpHelper(sArray[14], sArray[15], weight);\n  if (index == 15)\n    return lerpHelper(sArray[15], sArray[16], weight);\n  return sArray[16];\n}\n${TYPE} ${SIN_FUNCTION_NAME}(${TYPE} c) {\n  ${TYPE} arrVal = c * 2.546478971;\n  ${TYPE} weight = arrVal - floor(arrVal);\n  ${TYPE} sin_c = ${TYPE}(0.0);\n  ${INTERPOLATE_SIN}  return sin_c;\n}";

const VS_CALCULATE_COS: &str = "${VERSION}\n${ATTRIBUTE} highp vec2 position;\n${ATTRIBUTE} highp vec3 baseColor;\n${OUT} vec4 color;\n${COS_FUNCTION_DEFINITION_VS}\nvoid main (void) {\n  const float M_2PI = 2.0 * 3.14159265358979323846;\n  ${TYPE} c = baseColor.${COLOR_COMPONENTS};\n  ${TYPE} cos_c = ${COS_FUNCTION_NAME}(c * M_2PI);\n  \n  color = vec4(0.0, 0.0, 0.0, 1.0);\n  color.${COLOR_COMPONENTS} = cos_c * 0.5 + 0.5;\n  gl_Position = vec4(position, 0.0, 1.0);\n}\n";

const FS_CALCULATE_COS: &str = "${VERSION}\nprecision mediump float;\n${IN} vec4 color;\n${FS_OUT_COLOR_DECLARATION}\n\n// function definitions \n${COS_FUNCTION_DEFINITION_FS}\n${TYPE} preprocessColor(${TYPE} c) {\n  ${PREPROCESS_COLOR};\n  return c;\n}\n\nvoid main (void) {\n  const float M_2PI = 2.0 * 3.14159265358979323846;\n  ${TYPE} c = preprocessColor(color.${COLOR_COMPONENTS});\n  ${TYPE} cos_c = ${COS_FUNCTION_NAME}(c * M_2PI);\n  \n  ${FS_OUT_COLOR_NAME} = vec4(0.0, 0.0, 0.0, 1.0);\n  ${FS_OUT_COLOR_NAME}.${COLOR_COMPONENTS} = cos_c * 0.5 + 0.5;\n}\n";

const COS_FUNCTION_DEFINITION_VS: &str = "${TYPE} ${COS_FUNCTION_NAME}(${TYPE} c) {\n  ${TYPE} cos_c = ${TYPE}(1.0);\n  float sign = -1.0;\n  float fact =  1.0;\n  \n  for(int i = 2; i <= 20; i += 2) {\n    fact  *= float(i)*float(i-1);\n    cos_c += sign*pow(c, ${TYPE}(float(i)))/fact;\n    sign = -sign;\n  }\n  return cos_c;\n}";

const COS_FUNCTION_DEFINITION_FS: &str = "${TYPE} ${COS_FUNCTION_NAME}(${TYPE} c) {\n  ${TYPE} cos_c = ${TYPE}(-1.0);\n  float sign      = 1.0;\n  float fact_even = 1.0;\n  float fact_odd  = 1.0;\n  ${TYPE} sum;\n  ${TYPE} exp;\n  \n  for(int i = 2; i <= 10; i += 2) {\n    fact_even *= float(i);\n    fact_odd  *= float(i-1);\n    exp = ${TYPE}(float(i/2));\n    sum = sign * pow(abs(c), exp)/fact_even;\n    cos_c += pow(abs(c), exp)*(sum/fact_odd);\n    sign = -sign;\n  }\n  return cos_c;\n}";

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Vertex,
    Fragment,
}

struct TrigonometryCase {
    case_name: String,
    tested_function: &'static str,
    tested_type: &'static str,
    color_components: &'static str,
    shader_type: ShaderType,
}

type SpecializationMap = BTreeMap<&'static str, String>;

fn specialize(template: &str, map: &SpecializationMap) -> Result<String, TestError> {
    let params: Vec<(&str, String)> = map.iter().map(|(key, value)| (*key, value.clone())).collect();
    StringTemplate::new(template).specialize(&params)
}

impl TrigonometryCase {
    fn specialization_map(&self, context: &Context) -> SpecializationMap {
        let mut map = SpecializationMap::new();
        map.insert(
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        );
        map.insert("TYPE", self.tested_type.to_string());
        map.insert("COLOR_COMPONENTS", self.color_components.to_string());
        map.insert("IN", "in".to_string());
        map.insert("OUT", "out".to_string());
        map.insert("ATTRIBUTE", "in".to_string());
        map.insert("FS_OUT_COLOR_NAME", "fragColor".to_string());
        map.insert("FS_OUT_COLOR_DECLARATION", "out vec4 fragColor;".to_string());
        map
    }

    /// `prepareSineSources`
    fn prepare_sine_sources(&self, context: &Context, use_builtin_sin: bool) -> Result<ProgramSources, TestError> {
        let mut map = self.specialization_map(context);

        let (vs_template, fs_template) = if self.shader_type == ShaderType::Vertex {
            (VS_CALCULATE_SIN, FS_DEFAULT)
        } else {
            (VS_DEFAULT, FS_CALCULATE_SIN)
        };

        if use_builtin_sin {
            map.insert("SIN_FUNCTION_NAME", "sin".to_string());
            map.insert("SIN_FUNCTION_DEFINITION_VS", String::new());
            map.insert("SIN_FUNCTION_DEFINITION_FS", String::new());
        } else {
            let interpolate_sin = match self.tested_type {
                "float" => "\n  int index = int(floor(arrVal));\n  sin_c = sinLerpHelper(index, weight);\n",
                "vec2" => {
                    "\n  int indexX = int(floor(arrVal.x));\n  sin_c.x = sinLerpHelper(indexX, weight.x);\n  int indexY = int(floor(arrVal.y));\n  sin_c.y = sinLerpHelper(indexY, weight.y);\n"
                }
                "vec3" => {
                    "\n  int indexX = int(floor(arrVal.x));\n  sin_c.x = sinLerpHelper(indexX, weight.x);\n  int indexY = int(floor(arrVal.y));\n  sin_c.y = sinLerpHelper(indexY, weight.y);\n  int indexZ = int(floor(arrVal.z));\n  sin_c.z = sinLerpHelper(indexZ, weight.z);\n"
                }
                _ => "",
            };
            map.insert("INTERPOLATE_SIN", interpolate_sin.to_string());
            map.insert("SIN_FUNCTION_NAME", "calculateSin".to_string());
            let definition_vs = specialize(SIN_FUNCTION_DEFINITION_VS, &map)?;
            map.insert("SIN_FUNCTION_DEFINITION_VS", definition_vs);
            let definition_fs = specialize(SIN_FUNCTION_DEFINITION_FS, &map)?;
            map.insert("SIN_FUNCTION_DEFINITION_FS", definition_fs);
        }

        Ok(ProgramSources::vtx_frag(
            specialize(vs_template, &map)?,
            specialize(fs_template, &map)?,
        ))
    }

    /// `prepareCosineSources`
    fn prepare_cosine_sources(&self, context: &Context, use_builtin_cos: bool) -> Result<ProgramSources, TestError> {
        let mut map = self.specialization_map(context);

        let (vs_template, fs_template) = if self.shader_type == ShaderType::Vertex {
            (VS_CALCULATE_COS, FS_DEFAULT)
        } else {
            (VS_DEFAULT, FS_CALCULATE_COS)
        };

        if use_builtin_cos {
            map.insert("PREPROCESS_COLOR", String::new());
            map.insert("COS_FUNCTION_NAME", "cos".to_string());
            map.insert("COS_FUNCTION_DEFINITION_VS", String::new());
            map.insert("COS_FUNCTION_DEFINITION_FS", String::new());
        } else {
            map.insert("PREPROCESS_COLOR", "c = (fract(abs(c)) - 0.5)".to_string());
            map.insert("COS_FUNCTION_NAME", "calculateCos".to_string());
            let definition_vs = specialize(COS_FUNCTION_DEFINITION_VS, &map)?;
            map.insert("COS_FUNCTION_DEFINITION_VS", definition_vs);
            let definition_fs = specialize(COS_FUNCTION_DEFINITION_FS, &map)?;
            map.insert("COS_FUNCTION_DEFINITION_FS", definition_fs);
        }

        Ok(ProgramSources::vtx_frag(
            specialize(vs_template, &map)?,
            specialize(fs_template, &map)?,
        ))
    }

    /// `renderAndGrabSurface`
    fn render_and_grab_surface(
        &self,
        context: &Context,
        sources: &ProgramSources,
        width: i32,
        height: i32,
    ) -> Result<Surface, TestError> {
        const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
        const POSITIONS: [f32; 8] = [-1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0];
        const BASE_COLORS: [f32; 12] = [1.0, 0.0, 0.25, 0.75, 0.25, 1.0, 0.0, 1.0, 0.75, 0.25, 0.5, 0.0];

        let gl = context.gl();
        let test_program = ShaderProgram::new(gl, sources);
        if !test_program.is_ok() {
            return Err(TestError::Fail(format!(
                "Test program compilation failed: {}",
                test_program.build_failure_summary().unwrap_or_default()
            )));
        }

        // SAFETY: the program was just built and linked.
        unsafe { gl.use_program(test_program.program()) };
        let vertex_arrays = [
            va::float("position", 2, 4, 0, &POSITIONS),
            va::float("baseColor", 3, 4, 0, &BASE_COLORS),
        ];
        glu::draw(
            &context.render_context,
            test_program.program(),
            &vertex_arrays,
            &pr::triangle_strip(&QUAD_INDICES),
        )?;

        let mut result = Surface::new(width, height);
        glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
        Ok(result)
    }
}

impl TestCase for TrigonometryCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_context.render_target();
        let render_width = 64.min(render_target.width);
        let render_height = 64.min(render_target.height);
        let is_sin = self.tested_function == "sin";

        // SAFETY: a current context and a plain state setter.
        unsafe { gl.viewport(0, 0, render_width, render_height) };

        // Use program that will call trigonometric function aproximation
        let test_sources = if is_sin {
            self.prepare_sine_sources(context, false)?
        } else {
            self.prepare_cosine_sources(context, false)?
        };
        let test_surface = self.render_and_grab_surface(context, &test_sources, render_width, render_height)?;

        // Use reference program that will call builtin function
        let reference_sources = if is_sin {
            self.prepare_sine_sources(context, true)?
        } else {
            self.prepare_cosine_sources(context, true)?
        };
        let reference_surface =
            self.render_and_grab_surface(context, &reference_sources, render_width, render_height)?;

        let is_ok = fuzzy_compare_ok(
            &reference_surface.get_const_access(),
            &test_surface.get_const_access(),
            0.05,
        )
        .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `AggressiveShaderOptimizationsTests::init`
pub fn create_tests() -> TestCaseGroup {
    use ShaderType::{Fragment, Vertex};
    let cases = [
        ("sin", "float", "r", Vertex),
        ("sin", "float", "r", Fragment),
        ("sin", "vec2", "rg", Vertex),
        ("sin", "vec2", "rg", Fragment),
        ("sin", "vec3", "rgb", Vertex),
        ("sin", "vec3", "rgb", Fragment),
        ("cos", "float", "r", Vertex),
        ("cos", "float", "r", Fragment),
        ("cos", "vec2", "rg", Vertex),
        ("cos", "vec2", "rg", Fragment),
        ("cos", "vec3", "rgb", Vertex),
        ("cos", "vec3", "rgb", Fragment),
    ];

    let mut group = TestCaseGroup::new("aggressive_optimizations");
    for (tested_function, tested_type, color_components, shader_type) in cases {
        let suffix = if shader_type == Vertex { "_vert" } else { "_frag" };
        group.add_child(Box::new(TrigonometryCase {
            case_name: format!("{tested_function}_{tested_type}{suffix}"),
            tested_function,
            tested_type,
            color_components,
            shader_type,
        }) as Box<dyn TestCase>);
    }
    group
}
