// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (ImageLoadStoreMultipleUniformsTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `verify*` template routines are the `Verifier` enum, `Integer<T, SIZE, OFFSET>` is `integer_get`/`integer_get_negated`; `GLU_EXPECT_NO_ERROR` is `glu::expect_no_error(..)?`, `tcu::InternalError` and `TCU_FAIL` are `TestError::Fail`. Written without compiling.

use super::base::*;
use crate::glu::{self, Context};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};
use crate::tcu::TestError;

const MIN_REQUIRED_IMAGE_UNIFORMS: GLint = 2;

/// `shaderStage`
#[derive(Clone, Copy, PartialEq)]
enum ShaderStage {
    Fragment = 2,
    Geometry = 4,
    TesselationControl = 8,
    TesselationEvaluation = 16,
    Vertex = 32,
}

const STAGES: [ShaderStage; 5] = [
    ShaderStage::Fragment,
    ShaderStage::Geometry,
    ShaderStage::TesselationControl,
    ShaderStage::TesselationEvaluation,
    ShaderStage::Vertex,
];

/// `testResult`
#[derive(PartialEq)]
enum StageResult {
    Failed,
    NotSupported,
    Passed,
}

/// The `verificationRoutine` of one image format.
#[derive(Clone, Copy)]
enum Verifier {
    /// `verifyFloat<T>` with the element size in bytes.
    Float(usize),
    /// `verifyFloatSignedNorm<T>` with the element size in bytes.
    FloatSignedNorm(usize),
    /// `verifyInteger<R, G, B, A, T>`; `signed` is whether T is GLint.
    IntegerChannels(u32, u32, u32, u32, bool),
    /// `verifyFloatUnsigned<T>`
    FloatUnsigned,
    /// `verifyInteger(GLint, GLint, GLint)`
    IntegerPlain,
}

/// `imageFormatDetails`
#[derive(Clone, Copy)]
struct ImageFormatDetails {
    image_format: &'static str,
    image_type: &'static str,
    color_type: &'static str,
    image_unit_format: GLenum,
    verifier: Verifier,
}

/// `getImageUniformDeclarationDetails`
fn get_image_uniform_declaration_details(index: u32) -> ImageFormatDetails {
    use Verifier::*;
    let d = |image_format, image_type, color_type, image_unit_format, verifier| ImageFormatDetails {
        image_format,
        image_type,
        color_type,
        image_unit_format,
        verifier,
    };
    let format_details = [
        d("rg16f", "image2D", "vec4", glw::GL_RG16F, Float(2)),
        d(
            "r11f_g11f_b10f",
            "image2D",
            "vec4",
            glw::GL_R11F_G11F_B10F,
            FloatUnsigned,
        ),
        d("r32f", "image2D", "vec4", glw::GL_R32F, Float(4)),
        d("rgb10_a2", "image2D", "vec4", glw::GL_RGB10_A2, FloatUnsigned),
        d("rgba8", "image2D", "vec4", glw::GL_RGBA8, FloatUnsigned),
        d("rg16", "image2D", "vec4", glw::GL_RG16, FloatUnsigned),
        d(
            "rgba8_snorm",
            "image2D",
            "vec4",
            glw::GL_RGBA8_SNORM,
            FloatSignedNorm(1),
        ),
        d("rg16_snorm", "image2D", "vec4", glw::GL_RG16_SNORM, FloatSignedNorm(2)),
        d(
            "rgb10_a2ui",
            "uimage2D",
            "uvec4",
            glw::GL_RGB10_A2UI,
            IntegerChannels(10, 10, 10, 2, false),
        ),
        d(
            "rgba8ui",
            "uimage2D",
            "uvec4",
            glw::GL_RGBA8UI,
            IntegerChannels(8, 8, 8, 8, false),
        ),
        d(
            "rg16ui",
            "uimage2D",
            "uvec4",
            glw::GL_RG16UI,
            IntegerChannels(16, 16, 0, 0, false),
        ),
        d("r32ui", "uimage2D", "uvec4", glw::GL_R32UI, IntegerPlain),
        d(
            "rgba8i",
            "iimage2D",
            "ivec4",
            glw::GL_RGBA8I,
            IntegerChannels(8, 8, 8, 8, true),
        ),
        d(
            "rg16i",
            "iimage2D",
            "ivec4",
            glw::GL_RG16I,
            IntegerChannels(16, 16, 0, 0, true),
        ),
    ];
    let default_format_details = d("r32i", "iimage2D", "ivec4", glw::GL_R32I, IntegerPlain);
    format_details
        .get(index as usize)
        .copied()
        .unwrap_or(default_format_details)
}

/// `Integer<T, SIZE, OFFSET>::Get`
fn integer_get(raw: i32, size: u32, offset: u32) -> i64 {
    let value_mask = (1u32 << size) - 1;
    let bits = (raw as u32) & (value_mask << offset);
    (bits >> offset) as i64
}

/// `Integer<T, SIZE, OFFSET>::GetNegated`; `signed` is whether T is GLint (GLuint otherwise).
fn integer_get_negated(raw: i32, size: u32, offset: u32, signed: bool) -> i64 {
    let mask = (1i64 << size) - 1;
    let value = integer_get(raw, size, offset);
    let negated = if signed {
        -value
    } else {
        ((!(value as u32)).wrapping_add(1)) as i64
    };
    let (min, max) = if signed {
        (-(1i64 << (size - 1)), (1i64 << (size - 1)) - 1)
    } else {
        (0, (1i64 << size) - 1)
    };
    let clamped = if negated > max { max } else { negated };
    let clamped = if clamped < min { min } else { clamped };
    clamped & mask
}

/// The elements of `value` as `elem_size`-byte unsigned integers.
fn elements(value: GLint, elem_size: usize) -> Vec<u32> {
    value
        .to_ne_bytes()
        .chunks(elem_size)
        .map(|chunk| chunk.iter().rev().fold(0u32, |all, &byte| (all << 8) | byte as u32))
        .collect()
}

impl Verifier {
    fn verify(self, original_value: GLint, positive_value: GLint, negated_value: GLint) -> bool {
        if original_value != positive_value {
            return false;
        }
        match self {
            Verifier::Float(elem_size) => {
                let sign_bit_mask = 1u32 << (elem_size * 8 - 1);
                let sign_bit_inv_mask = !sign_bit_mask & (u32::MAX >> (32 - elem_size * 8));
                for (&positive_element, &negated_element) in elements(positive_value, elem_size)
                    .iter()
                    .zip(&elements(negated_value, elem_size))
                {
                    if positive_element & sign_bit_inv_mask != negated_element & sign_bit_inv_mask {
                        return false;
                    }
                    if positive_element & sign_bit_mask == negated_element & sign_bit_mask {
                        return false;
                    }
                }
                true
            }
            Verifier::FloatSignedNorm(elem_size) => {
                let sign_extend = |element: u32| {
                    if elem_size == 1 {
                        element as u8 as i8 as i32
                    } else {
                        element as u16 as i16 as i32
                    }
                };
                for (&positive_element, &negated_element) in elements(positive_value, elem_size)
                    .iter()
                    .zip(&elements(negated_value, elem_size))
                {
                    if sign_extend(positive_element) != -sign_extend(negated_element) {
                        return false;
                    }
                }
                true
            }
            Verifier::IntegerChannels(r, g, b, a, signed) => {
                let channels = [(r, 0), (g, r), (b, r + g), (a, r + g + b)];
                for (size, offset) in channels {
                    if size != 0
                        && integer_get_negated(positive_value, size, offset, signed)
                            != integer_get(negated_value, size, offset)
                    {
                        return false;
                    }
                }
                true
            }
            Verifier::FloatUnsigned => negated_value == 0,
            Verifier::IntegerPlain => positive_value == negated_value.wrapping_neg(),
        }
    }
}

/// `getExpectedValue`: one bit in the exponent of each component sidesteps denorm issues with r32f, rg16f and r11f_g11f_b10f.
fn get_expected_value(index: GLint) -> GLint {
    0x40104200 + index
}

/// `getMaximumImageUniformsForStage`
fn get_maximum_image_uniforms_for_stage(gl: &glw::Functions, stage: ShaderStage) -> Result<GLint, TestError> {
    let pname = match stage {
        ShaderStage::Fragment => glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
        ShaderStage::Geometry => glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS,
        ShaderStage::TesselationControl => glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
        ShaderStage::TesselationEvaluation => glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
        ShaderStage::Vertex => glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
    };
    let max_image_uniforms = get_integer(gl, pname);
    glu::expect_no_error(gl, "GetIntegerv")?;
    Ok(max_image_uniforms)
}

/// `prepareShaderForTestedShaderStage`: empty when the stage has too few image uniforms.
fn prepare_shader_for_tested_shader_stage(gl: &glw::Functions, stage: ShaderStage) -> Result<String, TestError> {
    let max_image_uniforms = get_maximum_image_uniforms_for_stage(gl, stage)?;
    if MIN_REQUIRED_IMAGE_UNIFORMS > max_image_uniforms {
        return Ok(String::new());
    }

    let (stage_specific_layout, stage_specific_predicate) = match stage {
        ShaderStage::Fragment | ShaderStage::Vertex => ("", "true"),
        ShaderStage::Geometry => ("layout(points) in;\nlayout(points, max_vertices = 1) out;\n\n", "true"),
        ShaderStage::TesselationControl => ("layout(vertices = 4) out;\n\n", "gl_InvocationID == 0"),
        // execute exactly once, given isolines with min tess factor
        ShaderStage::TesselationEvaluation => ("layout(isolines) in;\n\n", "gl_TessCoord.x < 0.5"),
    };

    let mut out = format!(
        "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\n{stage_specific_layout}"
    );
    for i in 0..max_image_uniforms as u32 {
        let details = get_image_uniform_declaration_details(i);
        out.push_str(&format!(
            "layout({}) uniform {} u_image_{i};\n",
            details.image_format, details.image_type
        ));
    }
    out.push_str(&format!(
        "\nvoid main()\n{{\n    if ({stage_specific_predicate})\n    {{\n"
    ));
    for i in 0..max_image_uniforms as u32 {
        let details = get_image_uniform_declaration_details(i);
        out.push_str(&format!("        const ivec2 row_0_coordinates_{i} = ivec2({i}, 0);\n"));
        out.push_str(&format!(
            "        const ivec2 row_1_coordinates_{i} = ivec2({i}, 1);\n\n"
        ));
        out.push_str(&format!(
            "        {} loaded_value_{i} = imageLoad(u_image_{i}, row_0_coordinates_{i});\n\n",
            details.color_type
        ));
        out.push_str(&format!(
            "        imageStore(u_image_{i}, row_0_coordinates_{i}, -loaded_value_{i});\n"
        ));
        out.push_str(&format!(
            "        imageStore(u_image_{i}, row_1_coordinates_{i}, loaded_value_{i});\n"
        ));
        if max_image_uniforms > i as GLint + 1 {
            out.push('\n');
        }
    }
    out.push_str("    }\n}\n\n");
    Ok(out)
}

const BOILERPLATE_FRAGMENT_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nvoid main()\n{\n    discard;\n}\n";
const BOILERPLATE_TESSELATION_EVALUATION_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(isolines) in;\n\nvoid main()\n{\n\n}\n";
const BOILERPLATE_VERTEX_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(location = 0) in vec4 i_position;\n\nvoid main()\n{\n  gl_Position = i_position;\n}\n";

/// `buildProgramToTestShaderStage`: 0 when the stage has too few image uniforms.
fn build_program_to_test_shader_stage(gl: &glw::Functions, stage: ShaderStage) -> Result<GLuint, TestError> {
    let tested = prepare_shader_for_tested_shader_stage(gl, stage)?;
    if tested.is_empty() {
        return Ok(0);
    }
    let (mut vs, mut tcs, mut tes, mut gs, mut fs): (&str, Option<&str>, Option<&str>, Option<&str>, &str) = (
        BOILERPLATE_VERTEX_SHADER_CODE,
        None,
        None,
        None,
        BOILERPLATE_FRAGMENT_SHADER_CODE,
    );
    match stage {
        ShaderStage::Fragment => fs = &tested,
        ShaderStage::Geometry => gs = Some(&tested),
        ShaderStage::TesselationControl => {
            tcs = Some(&tested);
            tes = Some(BOILERPLATE_TESSELATION_EVALUATION_SHADER_CODE);
        }
        ShaderStage::TesselationEvaluation => tes = Some(&tested),
        ShaderStage::Vertex => vs = &tested,
    }
    let mut is_program_built = true;
    let program_object_id = build_program_5(gl, Some(vs), tcs, tes, gs, Some(fs), Some(&mut is_program_built));
    if !is_program_built {
        return Err(TestError::Fail("Failed to build program".to_string()));
    }
    Ok(program_object_id)
}

/// `createTextureToTestShaderStage`: 0 when the stage has too few image uniforms.
fn create_texture_to_test_shader_stage(gl: &glw::Functions, stage: ShaderStage) -> Result<GLuint, TestError> {
    let max_image_uniforms = get_maximum_image_uniforms_for_stage(gl, stage)?;
    if MIN_REQUIRED_IMAGE_UNIFORMS > max_image_uniforms {
        return Ok(0);
    }
    let height: GLint = 2;
    let width = max_image_uniforms;

    let mut texture_id: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture_id));
    glu::expect_no_error(gl, "GenTextures")?;
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
    let check = |gl: &glw::Functions, message: &str| {
        glu::expect_no_error(gl, message).inspect_err(|_| {
            gl!(gl.delete_textures(1, &texture_id));
        })
    };
    check(gl, "BindTexture")?;

    let mut texture_data = vec![0 as GLint; (width * height) as usize];
    for i in 0..max_image_uniforms {
        texture_data[i as usize] = get_expected_value(i);
        texture_data[(i + width) as usize] = 0;
    }
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_R32I as GLint,
        width,
        height,
        0,
        glw::GL_RED_INTEGER,
        glw::GL_INT,
        texture_data.as_ptr().cast()
    ));
    check(gl, "TexImage2D")?;

    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    check(gl, "TexParameteri")?;

    Ok(texture_id)
}

/// 4 ImageLoadStoreMultipleUniformsTest
#[derive(Default)]
pub(super) struct ImageLoadStoreMultipleUniformsTest {
    /// Programs and textures in the order of `STAGES`.
    programs: [GLuint; 5],
    textures: [GLuint; 5],
    vertex_array_object_id: GLuint,
}

impl ImageLoadStoreMultipleUniformsTest {
    /// `testShaderStage`
    fn test_shader_stage(&self, context: &Context, stage_index: usize) -> Result<StageResult, TestError> {
        let gl = context.gl();
        let stage = STAGES[stage_index];
        let max_image_uniforms = get_maximum_image_uniforms_for_stage(gl, stage)?;
        let height = 2u32;
        let width = max_image_uniforms as u32;
        let positive_value_index = width as usize;
        let negated_value_index = 0usize;
        let mut result = StageResult::Passed;

        if MIN_REQUIRED_IMAGE_UNIFORMS > max_image_uniforms {
            return Ok(StageResult::NotSupported);
        }

        let primitive_mode = if matches!(
            stage,
            ShaderStage::TesselationControl | ShaderStage::TesselationEvaluation
        ) {
            glw::GL_PATCHES
        } else {
            glw::GL_POINTS
        };
        let (program_id, texture_id) = (self.programs[stage_index], self.textures[stage_index]);

        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "UseProgram")?;

        for i in 0..max_image_uniforms {
            let details = get_image_uniform_declaration_details(i as u32);
            gl!(gl.bind_image_texture(
                i as GLuint,
                texture_id,
                0,
                glw::FALSE,
                0,
                glw::GL_READ_WRITE,
                details.image_unit_format
            ));
            glu::expect_no_error(gl, "BindImageTexture")?;
        }

        for i in 0..max_image_uniforms {
            let image_uniform_name = format!("u_image_{i}");
            let image_uniform_location = uniform_location(gl, program_id, &image_uniform_name);
            glu::expect_no_error(gl, "GetUniformLocation")?;
            if image_uniform_location == -1 {
                return Err(TestError::Fail(format!(
                    "Uniform location is not available: {image_uniform_name}"
                )));
            }
            gl!(gl.uniform_1i(image_uniform_location, i));
            glu::expect_no_error(gl, "Uniform1i")?;
        }

        gl!(gl.draw_arrays(primitive_mode, 0, 1));
        glu::expect_no_error(gl, "DrawArrays")?;

        gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));

        let mut texture_data = vec![0 as GLint; (width * height) as usize];
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
        glu::expect_no_error(gl, "BindTexture")?;
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_INT,
            texture_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "GetTexImage")?;

        for i in 0..max_image_uniforms {
            let details = get_image_uniform_declaration_details(i as u32);
            let (positive, negated) = (
                texture_data[positive_value_index + i as usize],
                texture_data[negated_value_index + i as usize],
            );
            if !details.verifier.verify(get_expected_value(i), positive, negated) {
                log::info!(
                    "Invalid result! Image format: {} Original value: 0x{:08x} Copied value: 0x{:08x} Negated value: 0x{:08x}",
                    details.image_format,
                    get_expected_value(i),
                    positive,
                    negated
                );
                result = StageResult::Failed;
            }
        }
        Ok(result)
    }
}

impl Subcase for ImageLoadStoreMultipleUniformsTest {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for (index, stage) in STAGES.into_iter().enumerate() {
            self.programs[index] = build_program_to_test_shader_stage(gl, stage)?;
        }
        for (index, stage) in STAGES.into_iter().enumerate() {
            self.textures[index] = create_texture_to_test_shader_stage(gl, stage)?;
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array_object_id));
        glu::expect_no_error(gl, "GenVertexArrays")?;
        gl!(gl.bind_vertex_array(self.vertex_array_object_id));
        glu::expect_no_error(gl, "BindVertexArray")?;

        // set vertices number for patches
        gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let mut result = true;
        for (index, name) in [
            "fragment",
            "geometry",
            "tesselation control",
            "tesselation evaluation",
            "vertex",
        ]
        .into_iter()
        .enumerate()
        {
            if self.test_shader_stage(context, index)? == StageResult::Failed {
                log::info!("Problems with {name} shader stage!");
                result = false;
            }
        }
        Ok(if result { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in &mut self.programs {
            if *program != 0 {
                gl!(gl.delete_program(*program));
                *program = 0;
            }
        }
        for texture in &mut self.textures {
            if *texture != 0 {
                gl!(gl.delete_textures(1, texture));
                *texture = 0;
            }
        }
        if self.vertex_array_object_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array_object_id));
            self.vertex_array_object_id = 0;
        }
        Ok(NO_ERROR)
    }
}
