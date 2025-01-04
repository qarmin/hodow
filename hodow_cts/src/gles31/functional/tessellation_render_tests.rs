// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTessellationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The groups here are the ones whose verdict is a
// comparison against a pre-rendered reference PNG: `shader_input_output` (`PatchVertexCountCase`,
// `PerPatchDataCase`, `GLPositionCase`, `BarrierCase`), `misc_draw` (`BasicVariousTessLevelsPosAttrCase`
// and its three subclasses) and `user_defined_io` (`UserDefinedIOCase` plus the two negative shader
// library files). The PNGs are upstream's `data/gles31/data/tessellation/*.png`, copied verbatim into
// `hodow_cts/data/tessellation/`, `include_bytes!`d and decoded by `tcu::png`.
//
// Each case here is a plain `glu::TestCase` (upstream's `init` + `iterate` in one `iterate`), sharing
// the program/enum helpers of `tessellation_tests`.

use std::sync::Arc;

use super::tessellation_tests::{
    SpacingMode, TessPrimitiveType, TransformFeedbackHandler, get_clamped_rounded_tess_level, output_primitive_type_gl,
    reference_vertex_count, specialize_shader, supports_es32,
};
use crate::gls::shader_library::create_group;
use crate::gls::texture_test_util::RandomViewport;
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::var_type::{
    StructType, VarType, VarTypeComponent, basic_type_paths, declare_struct, declare_var, type_access_name,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::png::load_png;
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus, de_string_hash};

/// `Box<dyn TestCase>`, which `add_child` needs (it does not unsize a `Box<Concrete>` itself).
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

const RENDER_SIZE: i32 = 256;

/// `&'static [u8]` out of an `include_bytes!` array.
fn bytes(b: &'static [u8]) -> &'static [u8] {
    b
}

macro_rules! png {
    ($($name:tt)*) => {
        bytes(include_bytes!(concat!("../../../data/tessellation/", $($name)*)))
    };
}

macro_rules! refs3 {
    ($name:literal) => {
        [
            png!(concat!($name, "_ref_0.png")),
            png!(concat!($name, "_ref_1.png")),
            png!(concat!($name, "_ref_2.png")),
        ]
    };
}

/// The three reference images of one `misc_draw` case, by case name.
fn misc_draw_refs(name: &str) -> [&'static [u8]; 3] {
    match name {
        "fill_cover_triangles_equal_spacing" => refs3!("fill_cover_triangles_equal_spacing"),
        "fill_cover_triangles_fractional_odd_spacing" => refs3!("fill_cover_triangles_fractional_odd_spacing"),
        "fill_cover_triangles_fractional_even_spacing" => refs3!("fill_cover_triangles_fractional_even_spacing"),
        "fill_cover_quads_equal_spacing" => refs3!("fill_cover_quads_equal_spacing"),
        "fill_cover_quads_fractional_odd_spacing" => refs3!("fill_cover_quads_fractional_odd_spacing"),
        "fill_cover_quads_fractional_even_spacing" => refs3!("fill_cover_quads_fractional_even_spacing"),
        "fill_overlap_triangles_equal_spacing" => refs3!("fill_overlap_triangles_equal_spacing"),
        "fill_overlap_triangles_fractional_odd_spacing" => refs3!("fill_overlap_triangles_fractional_odd_spacing"),
        "fill_overlap_triangles_fractional_even_spacing" => refs3!("fill_overlap_triangles_fractional_even_spacing"),
        "fill_overlap_quads_equal_spacing" => refs3!("fill_overlap_quads_equal_spacing"),
        "fill_overlap_quads_fractional_odd_spacing" => refs3!("fill_overlap_quads_fractional_odd_spacing"),
        "fill_overlap_quads_fractional_even_spacing" => refs3!("fill_overlap_quads_fractional_even_spacing"),
        "isolines_equal_spacing" => refs3!("isolines_equal_spacing"),
        "isolines_fractional_odd_spacing" => refs3!("isolines_fractional_odd_spacing"),
        "isolines_fractional_even_spacing" => refs3!("isolines_fractional_even_spacing"),
        _ => unreachable!("every misc_draw case name has a reference"),
    }
}

/// `checkTessellationSupport`
fn check_tessellation_support(context: &Context) -> Result<(), TestError> {
    if supports_es32(context)
        || context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
    {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_tessellation_shader is not supported".to_string(),
        ))
    }
}

/// `checkGPUShader5Support`
fn check_gpu_shader5_support(context: &Context) -> Result<(), TestError> {
    if supports_es32(context) || context.context_info.is_extension_supported("GL_EXT_gpu_shader5") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_gpu_shader5 is not supported".to_string(),
        ))
    }
}

/// `checkRenderTargetSize`
fn check_render_target_size(context: &Context, min_size: i32) -> Result<(), TestError> {
    let render_target = context.render_target();
    if render_target.width < min_size || render_target.height < min_size {
        return Err(TestError::NotSupported(format!(
            "Render target width and height must be at least {min_size}"
        )));
    }
    Ok(())
}

/// `getPixels(renderCtx, viewport)`
fn get_pixels(context: &Context, vp: &RandomViewport) -> Result<Surface, TestError> {
    let mut result = Surface::new(vp.width, vp.height);
    glu::read_pixels(&context.render_context, vp.x, vp.y, &mut result.get_access())?;
    Ok(result)
}

/// `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))` + `setViewport`
fn set_random_viewport(context: &Context, name: &str) -> RandomViewport {
    let vp = RandomViewport::new(&context.render_target(), RENDER_SIZE, RENDER_SIZE, de_string_hash(name));
    // SAFETY: plain state setter with a current context.
    unsafe { context.gl().viewport(vp.x, vp.y, vp.width, vp.height) };
    vp
}

/// Builds a program from the four (or three, without a control shader) templates.
fn build_program<'gl>(
    context: &'gl Context,
    vertex: &str,
    tess_control: Option<&str>,
    tess_eval: &str,
    fragment: &str,
    feedback_varying: Option<&str>,
) -> Result<ShaderProgram<'gl>, TestError> {
    let mut sources = ProgramSources::default().with(ShaderType::Vertex, specialize_shader(context, vertex));
    if let Some(tcs) = tess_control {
        sources = sources.with(ShaderType::TessControl, specialize_shader(context, tcs));
    }
    sources = sources
        .with(ShaderType::TessEvaluation, specialize_shader(context, tess_eval))
        .with(ShaderType::Fragment, specialize_shader(context, fragment));
    if let Some(varying) = feedback_varying {
        sources = sources.with_transform_feedback(&[varying.to_string()], glw::GL_INTERLEAVED_ATTRIBS);
    }

    let program = ShaderProgram::new(context.gl(), &sources);
    if !program.is_ok() {
        return Err(TestError::Fail("Program compilation failed".to_string()));
    }
    Ok(program)
}

/// `tcu::fuzzyCompare` against a reference PNG, as a verdict.
fn compare_image(rendered: &Surface, reference: &'static [u8], threshold: f32) -> Result<bool, TestError> {
    let reference = load_png(reference).map_err(TestError::InternalError)?;
    fuzzy_compare_ok(&reference.get_const_access(), &rendered.get_const_access(), threshold)
        .ok_or_else(|| TestError::InternalError("fuzzy comparison of unsupported formats".to_string()))
}

const SIMPLE_VERTEX_TEMPLATE_FLOAT_ATTR: &str = "${GLSL_VERSION_DECL}\n\
    ${GLSL_PER_VERTEX_OUT}\n\
    \n\
    in highp float in_v_attr;\n\
    \n\
    out highp float in_tc_attr;\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   in_tc_attr = in_v_attr;\n\
    }\n";

/// The fragment shader `PatchVertexCountCase`/`PerPatchDataCase`/`UserDefinedIOCase`/`GLPositionCase` share.
const COLOR_PASSTHROUGH_FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
    \n\
    layout (location = 0) out mediump vec4 o_color;\n\
    \n\
    in highp vec4 in_f_color;\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   o_color = in_f_color;\n\
    }\n";

const MEDIUMP_COLOR_FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
    \n\
    layout (location = 0) out mediump vec4 o_color;\n\
    \n\
    in mediump vec4 in_f_color;\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   o_color = in_f_color;\n\
    }\n";

/// `getTessellationEvaluationInLayoutString(primitiveType)` (and with a spacing mode)
fn tes_layout(primitive_type: TessPrimitiveType, spacing: Option<SpacingMode>) -> String {
    match spacing {
        Some(spacing) => format!(
            "layout ({}, {}) in;\n",
            primitive_type.shader_name(),
            spacing.shader_name()
        ),
        None => format!("layout ({}) in;\n", primitive_type.shader_name()),
    }
}

/// Draws `attribute_data` as one `in_v_attr` float attribute with `GL_PATCH_VERTICES = patch_size`.
fn draw_float_attr_patches(
    context: &Context,
    program: u32,
    attribute_data: &[f32],
    patch_size: i32,
    num_vertices: i32,
) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: plain state setters with a current context.
    unsafe {
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, patch_size);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let binding = glu::va::float("in_v_attr", 1, attribute_data.len() as i32, 0, attribute_data);
    glu::draw(
        &context.render_context,
        program,
        &[binding],
        &glu::pr::list(glu::PrimitiveType::Patches, num_vertices),
    )?;
    glu::expect_no_error(gl, "Draw failed")
}

fn pass_or_fail(ok: bool, fail_message: &str) -> TestOutcome {
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail(fail_message)
    })
}

// ---------------------------------------------------------------------------------------
// PatchVertexCountCase
// ---------------------------------------------------------------------------------------

/// Test potentially differing input and output patch sizes.
struct PatchVertexCountCase {
    name: String,
    input_patch_size: i32,
    output_patch_size: i32,
    reference: &'static [u8],
}

impl TestCase for PatchVertexCountCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;

        let in_size_str = self.input_patch_size.to_string();
        let out_size_str = self.output_patch_size.to_string();

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = ");
        tcs.push_str(&out_size_str);
        tcs.push_str(") out;\n\nin highp float in_tc_attr[];\n\nout highp float in_te_attr[];\n\nvoid main (void)\n{\n    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID*");
        tcs.push_str(&in_size_str);
        tcs.push('/');
        tcs.push_str(&out_size_str);
        tcs.push_str("];\n\n    gl_TessLevelInner[0] = 5.0;\n    gl_TessLevelInner[1] = 5.0;\n\n    gl_TessLevelOuter[0] = 5.0;\n    gl_TessLevelOuter[1] = 5.0;\n    gl_TessLevelOuter[2] = 5.0;\n    gl_TessLevelOuter[3] = 5.0;\n}\n");

        let mut tes = String::new();
        tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
        tes.push_str(&tes_layout(TessPrimitiveType::Quads, None));
        tes.push_str("\nin highp float in_te_attr[];\n\nout mediump vec4 in_f_color;\n\nvoid main (void)\n{\n    highp float x = gl_TessCoord.x*2.0 - 1.0;\n    highp float y = gl_TessCoord.y - in_te_attr[int(round(gl_TessCoord.x*float(");
        tes.push_str(&out_size_str);
        tes.push_str("-1)))];\n    gl_Position = vec4(x, y, 0.0, 1.0);\n    in_f_color = vec4(1.0);\n}\n");

        let program = build_program(
            context,
            SIMPLE_VERTEX_TEMPLATE_FLOAT_ATTR,
            Some(tcs.as_str()),
            &tes,
            MEDIUMP_COLOR_FRAGMENT_TEMPLATE,
            None,
        )?;
        let program_gl = program.program();
        let gl = context.gl();

        let viewport = set_random_viewport(context, &self.name);
        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(program_gl);
        }

        log::info!(
            "Note: input patch size is {}, output patch size is {}",
            self.input_patch_size,
            self.output_patch_size
        );

        let attribute_data: Vec<f32> = (0..self.input_patch_size)
            .map(|i| {
                let f = i as f32 / (self.input_patch_size - 1) as f32;
                f * f
            })
            .collect();
        draw_float_attr_patches(
            context,
            program_gl,
            &attribute_data,
            self.input_patch_size,
            self.input_patch_size,
        )?;

        let rendered = get_pixels(context, &viewport)?;
        pass_or_fail(
            compare_image(&rendered, self.reference, 0.02)?,
            "Image comparison failed",
        )
    }
}

// ---------------------------------------------------------------------------------------
// PerPatchDataCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum PerPatchCaseType {
    PrimitiveIdTcs,
    PrimitiveIdTes,
    PatchVerticesInTcs,
    PatchVerticesInTes,
    TessLevelInner0Tes,
    TessLevelInner1Tes,
    TessLevelOuter0Tes,
    TessLevelOuter1Tes,
    TessLevelOuter2Tes,
    TessLevelOuter3Tes,
}

impl PerPatchCaseType {
    const ALL: [Self; 10] = [
        Self::PrimitiveIdTcs,
        Self::PrimitiveIdTes,
        Self::PatchVerticesInTcs,
        Self::PatchVerticesInTes,
        Self::TessLevelInner0Tes,
        Self::TessLevelInner1Tes,
        Self::TessLevelOuter0Tes,
        Self::TessLevelOuter1Tes,
        Self::TessLevelOuter2Tes,
        Self::TessLevelOuter3Tes,
    ];

    /// `PerPatchDataCase::getCaseTypeName`
    fn name(self) -> &'static str {
        match self {
            Self::PrimitiveIdTcs => "primitive_id_tcs",
            Self::PrimitiveIdTes => "primitive_id_tes",
            Self::PatchVerticesInTcs => "patch_vertices_in_tcs",
            Self::PatchVerticesInTes => "patch_vertices_in_tes",
            Self::TessLevelInner0Tes => "tess_level_inner_0_tes",
            Self::TessLevelInner1Tes => "tess_level_inner_1_tes",
            Self::TessLevelOuter0Tes => "tess_level_outer_0_tes",
            Self::TessLevelOuter1Tes => "tess_level_outer_1_tes",
            Self::TessLevelOuter2Tes => "tess_level_outer_2_tes",
            Self::TessLevelOuter3Tes => "tess_level_outer_3_tes",
        }
    }

    /// `PerPatchDataCase::caseTypeUsesRefImageFromFile`
    fn reference(self) -> Option<&'static [u8]> {
        match self {
            Self::PrimitiveIdTcs => Some(png!("primitive_id_tcs_ref.png")),
            Self::PrimitiveIdTes => Some(png!("primitive_id_tes_ref.png")),
            _ => None,
        }
    }
}

/// Test per-patch inputs/outputs.
struct PerPatchDataCase {
    case_type: PerPatchCaseType,
}

const PER_PATCH_INPUT_PATCH_SIZE: i32 = 10;
const PER_PATCH_OUTPUT_PATCH_SIZE: i32 = 5;

impl TestCase for PerPatchDataCase {
    fn name(&self) -> &str {
        self.case_type.name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        use PerPatchCaseType as T;

        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;

        let case_type = self.case_type;
        let in_size_str = PER_PATCH_INPUT_PATCH_SIZE.to_string();
        let out_size_str = PER_PATCH_OUTPUT_PATCH_SIZE.to_string();

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = ");
        tcs.push_str(&out_size_str);
        tcs.push_str(") out;\n\nin highp float in_tc_attr[];\n\nout highp float in_te_attr[];\n");
        tcs.push_str(match case_type {
            T::PrimitiveIdTcs => "patch out mediump int in_te_primitiveIDFromTCS;\n",
            T::PatchVerticesInTcs => "patch out mediump int in_te_patchVerticesInFromTCS;\n",
            _ => "",
        });
        tcs.push_str("\nvoid main (void)\n{\n    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];\n");
        tcs.push_str(match case_type {
            T::PrimitiveIdTcs => "\tin_te_primitiveIDFromTCS = gl_PrimitiveID;\n",
            T::PatchVerticesInTcs => "\tin_te_patchVerticesInFromTCS = gl_PatchVerticesIn;\n",
            _ => "",
        });
        tcs.push_str("\n    gl_TessLevelInner[0] = 9.0;\n    gl_TessLevelInner[1] = 8.0;\n\n    gl_TessLevelOuter[0] = 7.0;\n    gl_TessLevelOuter[1] = 6.0;\n    gl_TessLevelOuter[2] = 5.0;\n    gl_TessLevelOuter[3] = 4.0;\n}\n");

        let mut tes = String::new();
        tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
        tes.push_str(&tes_layout(TessPrimitiveType::Quads, None));
        tes.push_str("\nin highp float in_te_attr[];\n");
        tes.push_str(match case_type {
            T::PrimitiveIdTcs => "patch in mediump int in_te_primitiveIDFromTCS;\n",
            T::PatchVerticesInTcs => "patch in mediump int in_te_patchVerticesInFromTCS;\n",
            _ => "",
        });
        tes.push_str("\nout mediump vec4 in_f_color;\n\nuniform highp float u_xScale;\n\nvoid main (void)\n{\n    highp float x = (gl_TessCoord.x*u_xScale + in_te_attr[0]) * 2.0 - 1.0;\n    highp float y = gl_TessCoord.y*2.0 - 1.0;\n    gl_Position = vec4(x, y, 0.0, 1.0);\n");
        match case_type {
            T::PrimitiveIdTcs => tes.push_str("\tbool ok = in_te_primitiveIDFromTCS == 3;\n"),
            T::PrimitiveIdTes => tes.push_str("\tbool ok = gl_PrimitiveID == 3;\n"),
            T::PatchVerticesInTcs => {
                tes.push_str(&format!("\tbool ok = in_te_patchVerticesInFromTCS == {in_size_str};\n"))
            }
            T::PatchVerticesInTes => tes.push_str(&format!("\tbool ok = gl_PatchVerticesIn == {out_size_str};\n")),
            T::TessLevelInner0Tes => tes.push_str("\tbool ok = abs(gl_TessLevelInner[0] - 9.0) < 0.1f;\n"),
            T::TessLevelInner1Tes => tes.push_str("\tbool ok = abs(gl_TessLevelInner[1] - 8.0) < 0.1f;\n"),
            T::TessLevelOuter0Tes => tes.push_str("\tbool ok = abs(gl_TessLevelOuter[0] - 7.0) < 0.1f;\n"),
            T::TessLevelOuter1Tes => tes.push_str("\tbool ok = abs(gl_TessLevelOuter[1] - 6.0) < 0.1f;\n"),
            T::TessLevelOuter2Tes => tes.push_str("\tbool ok = abs(gl_TessLevelOuter[2] - 5.0) < 0.1f;\n"),
            T::TessLevelOuter3Tes => tes.push_str("\tbool ok = abs(gl_TessLevelOuter[3] - 4.0) < 0.1f;\n"),
        }
        tes.push_str("    in_f_color = ok ? vec4(1.0) : vec4(vec3(0.0), 1.0);\n}\n");

        let program = build_program(
            context,
            SIMPLE_VERTEX_TEMPLATE_FLOAT_ATTR,
            Some(tcs.as_str()),
            &tes,
            MEDIUMP_COLOR_FRAGMENT_TEMPLATE,
            None,
        )?;
        let program_gl = program.program();
        let gl = context.gl();

        let viewport = set_random_viewport(context, self.name());
        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(program_gl);
        }

        log::info!(
            "Note: input patch size is {PER_PATCH_INPUT_PATCH_SIZE}, output patch size is {PER_PATCH_OUTPUT_PATCH_SIZE}"
        );

        {
            let num_primitives = if matches!(case_type, T::PrimitiveIdTcs | T::PrimitiveIdTes) {
                8
            } else {
                1
            };

            let mut attribute_data: Vec<f32> =
                Vec::with_capacity((num_primitives * PER_PATCH_INPUT_PATCH_SIZE) as usize);
            for i in 0..num_primitives {
                attribute_data.push(i as f32 / num_primitives as f32);
                attribute_data.extend(std::iter::repeat_n(0.0, (PER_PATCH_INPUT_PATCH_SIZE - 1) as usize));
            }

            // SAFETY: a uniform of the program in use; -1 would be a no-op.
            unsafe {
                gl.patch_parameteri(glw::GL_PATCH_VERTICES, PER_PATCH_INPUT_PATCH_SIZE);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_xScale".as_ptr()),
                    1.0 / num_primitives as f32,
                );
            }

            let binding = glu::va::float("in_v_attr", 1, attribute_data.len() as i32, 0, &attribute_data);
            glu::draw(
                &context.render_context,
                program_gl,
                &[binding],
                &glu::pr::list(glu::PrimitiveType::Patches, num_primitives * PER_PATCH_INPUT_PATCH_SIZE),
            )?;
            glu::expect_no_error(gl, "Draw failed")?;
        }

        let rendered = get_pixels(context, &viewport)?;

        if let Some(reference) = case_type.reference() {
            return pass_or_fail(compare_image(&rendered, reference, 0.02)?, "Image comparison failed");
        }

        for y in 0..rendered.get_height() {
            for x in 0..rendered.get_width() {
                if rendered.get_pixel(x, y) != crate::tcu::rgba::RGBA::white() {
                    log::warn!("Failure: expected all white pixels");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------
// GLPositionCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum GlPositionCaseType {
    VsToTcs,
    TcsToTes,
    VsToTcsToTes,
}

impl GlPositionCaseType {
    /// `GLPositionCase::getCaseTypeName`
    fn name(self) -> &'static str {
        match self {
            Self::VsToTcs => "gl_position_vs_to_tcs",
            Self::TcsToTes => "gl_position_tcs_to_tes",
            Self::VsToTcsToTes => "gl_position_vs_to_tcs_to_tes",
        }
    }
}

/// Pass gl_Position between VS and TCS, or between TCS and TES.
///
/// In TCS gl_Position is in the gl_out[] block and in TES in the gl_in[] block, and has no special
/// semantics in those. Arbitrary vec4 data can thus be passed there.
struct GlPositionCase {
    case_type: GlPositionCaseType,
}

impl TestCase for GlPositionCase {
    fn name(&self) -> &str {
        self.case_type.name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;

        let vs_to_tcs = matches!(
            self.case_type,
            GlPositionCaseType::VsToTcs | GlPositionCaseType::VsToTcsToTes
        );
        let tcs_to_tes = matches!(
            self.case_type,
            GlPositionCaseType::TcsToTes | GlPositionCaseType::VsToTcsToTes
        );

        let tes_in0 = if tcs_to_tes {
            "gl_in[0].gl_Position"
        } else {
            "in_te_attr[0]"
        };
        let tes_in1 = if tcs_to_tes {
            "gl_in[1].gl_Position"
        } else {
            "in_te_attr[1]"
        };
        let tes_in2 = if tcs_to_tes {
            "gl_in[2].gl_Position"
        } else {
            "in_te_attr[2]"
        };

        let mut vertex = String::new();
        vertex.push_str("${GLSL_VERSION_DECL}\n${GLSL_PER_VERTEX_OUT}\n\nin highp vec4 in_v_attr;\n");
        if !vs_to_tcs {
            vertex.push_str("out highp vec4 in_tc_attr;\n");
        }
        vertex.push_str("\nvoid main (void)\n{\n    ");
        vertex.push_str(if vs_to_tcs { "gl_Position" } else { "in_tc_attr" });
        vertex.push_str(" = in_v_attr;\n}\n");

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = 3) out;\n\n");
        if !vs_to_tcs {
            tcs.push_str("in highp vec4 in_tc_attr[];\n");
        }
        tcs.push('\n');
        if !tcs_to_tes {
            tcs.push_str("out highp vec4 in_te_attr[];\n");
        }
        tcs.push_str("\nvoid main (void)\n{\n    ");
        tcs.push_str(if tcs_to_tes {
            "gl_out[gl_InvocationID].gl_Position"
        } else {
            "in_te_attr[gl_InvocationID]"
        });
        tcs.push_str(" = ");
        tcs.push_str(if vs_to_tcs {
            "gl_in[gl_InvocationID].gl_Position"
        } else {
            "in_tc_attr[gl_InvocationID]"
        });
        tcs.push_str(";\n\n    gl_TessLevelInner[0] = 2.0;\n    gl_TessLevelInner[1] = 3.0;\n\n    gl_TessLevelOuter[0] = 4.0;\n    gl_TessLevelOuter[1] = 5.0;\n    gl_TessLevelOuter[2] = 6.0;\n    gl_TessLevelOuter[3] = 7.0;\n}\n");

        let mut tes = String::new();
        tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
        tes.push_str(&tes_layout(TessPrimitiveType::Triangles, None));
        tes.push('\n');
        if !tcs_to_tes {
            tes.push_str("in highp vec4 in_te_attr[];\n");
        }
        tes.push_str("\nout highp vec4 in_f_color;\n\nvoid main (void)\n{\n");
        tes.push_str(&format!("    highp vec2 xy = gl_TessCoord.x * {tes_in0}.xy\n"));
        tes.push_str(&format!("                  + gl_TessCoord.y * {tes_in1}.xy\n"));
        tes.push_str(&format!("                  + gl_TessCoord.z * {tes_in2}.xy;\n"));
        tes.push_str("    gl_Position = vec4(xy, 0.0, 1.0);\n");
        tes.push_str(&format!("    in_f_color = vec4({tes_in0}.z + {tes_in1}.w,\n"));
        tes.push_str(&format!("                      {tes_in2}.z + {tes_in0}.w,\n"));
        tes.push_str(&format!("                      {tes_in1}.z + {tes_in2}.w,\n"));
        tes.push_str("                      1.0);\n}\n");

        let program = build_program(
            context,
            &vertex,
            Some(tcs.as_str()),
            &tes,
            COLOR_PASSTHROUGH_FRAGMENT_TEMPLATE,
            None,
        )?;
        let program_gl = program.program();
        let gl = context.gl();

        let viewport = set_random_viewport(context, self.name());

        const ATTRIBUTES: [f32; 12] = [-0.8, -0.7, 0.1, 0.7, -0.5, 0.4, 0.2, 0.5, 0.3, 0.2, 0.3, 0.45];

        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.use_program(program_gl);
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        log::info!("Note: input data for in_v_attr: {ATTRIBUTES:?}");

        let binding = glu::va::float("in_v_attr", 4, 3, 0, &ATTRIBUTES);
        glu::draw(
            &context.render_context,
            program_gl,
            &[binding],
            &glu::pr::list(glu::PrimitiveType::Patches, 3),
        )?;

        let pixels = get_pixels(context, &viewport)?;
        pass_or_fail(
            compare_image(&pixels, png!("gl_position_ref.png"), 0.02)?,
            "Image comparison failed",
        )
    }
}

// ---------------------------------------------------------------------------------------
// BarrierCase
// ---------------------------------------------------------------------------------------

/// Basic barrier() usage in TCS.
struct BarrierCase;

const BARRIER_NUM_VERTICES: i32 = 32;

impl TestCase for BarrierCase {
    fn name(&self) -> &str {
        "barrier"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;

        let num_verts_str = BARRIER_NUM_VERTICES.to_string();

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = ");
        tcs.push_str(&num_verts_str);
        tcs.push_str(") out;\n\nin highp float in_tc_attr[];\n\nout highp float in_te_attr[];\npatch out highp float in_te_patchAttr;\n\nvoid main (void)\n{\n");
        tcs.push_str("    in_te_attr[gl_InvocationID] = in_tc_attr[gl_InvocationID];\n");
        tcs.push_str("    in_te_patchAttr = 0.0f;\n");
        tcs.push_str("    barrier();\n");
        tcs.push_str("    if (gl_InvocationID == 5)\n");
        tcs.push_str("        in_te_patchAttr = float(gl_InvocationID)*0.1;\n");
        tcs.push_str("    barrier();\n");
        tcs.push_str("    highp float temp = in_te_patchAttr + in_te_attr[gl_InvocationID];\n");
        tcs.push_str("    barrier();\n");
        tcs.push_str(&format!("    if (gl_InvocationID == {num_verts_str}-1)\n"));
        tcs.push_str("        in_te_patchAttr = float(gl_InvocationID);\n");
        tcs.push_str("    barrier();\n");
        tcs.push_str("    in_te_attr[gl_InvocationID] = temp;\n");
        tcs.push_str("    barrier();\n");
        tcs.push_str(&format!(
            "    temp = temp + in_te_attr[(gl_InvocationID+1) % {num_verts_str}];\n"
        ));
        tcs.push_str("    barrier();\n");
        tcs.push_str("    in_te_attr[gl_InvocationID] = 0.25*temp;\n");
        tcs.push_str("\n    gl_TessLevelInner[0] = 32.0;\n    gl_TessLevelInner[1] = 32.0;\n\n    gl_TessLevelOuter[0] = 32.0;\n    gl_TessLevelOuter[1] = 32.0;\n    gl_TessLevelOuter[2] = 32.0;\n    gl_TessLevelOuter[3] = 32.0;\n}\n");

        let mut tes = String::new();
        tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
        tes.push_str(&tes_layout(TessPrimitiveType::Quads, None));
        tes.push_str("\nin highp float in_te_attr[];\npatch in highp float in_te_patchAttr;\n\nout highp float in_f_blue;\n\nvoid main (void)\n{\n    highp float x = gl_TessCoord.x*2.0 - 1.0;\n    highp float y = gl_TessCoord.y - in_te_attr[int(round(gl_TessCoord.x*float(");
        tes.push_str(&num_verts_str);
        tes.push_str("-1)))];\n    gl_Position = vec4(x, y, 0.0, 1.0);\n    in_f_blue = abs(in_te_patchAttr - float(");
        tes.push_str(&num_verts_str);
        tes.push_str("-1));\n}\n");

        let fragment = "${GLSL_VERSION_DECL}\n\nlayout (location = 0) out mediump vec4 o_color;\n\nin highp float in_f_blue;\n\nvoid main (void)\n{\n    o_color = vec4(1.0, 0.0, in_f_blue, 1.0);\n}\n";

        let program = build_program(
            context,
            SIMPLE_VERTEX_TEMPLATE_FLOAT_ATTR,
            Some(tcs.as_str()),
            &tes,
            fragment,
            None,
        )?;
        let program_gl = program.program();
        let gl = context.gl();

        let viewport = set_random_viewport(context, "barrier");
        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(program_gl);
        }

        let attribute_data: Vec<f32> = (0..BARRIER_NUM_VERTICES)
            .map(|i| i as f32 / (BARRIER_NUM_VERTICES - 1) as f32)
            .collect();
        draw_float_attr_patches(
            context,
            program_gl,
            &attribute_data,
            BARRIER_NUM_VERTICES,
            BARRIER_NUM_VERTICES,
        )?;

        let rendered = get_pixels(context, &viewport)?;
        pass_or_fail(
            compare_image(&rendered, png!("barrier_ref.png"), 0.02)?,
            "Image comparison failed",
        )
    }
}

/// `TessellationTests::init`'s `shader_input_output` group.
pub fn shader_input_output_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_input_output");

    for (in_size, out_size, reference) in [
        (5, 10, png!("patch_vertices_5_in_10_out_ref.png")),
        (10, 5, png!("patch_vertices_10_in_5_out_ref.png")),
    ] {
        group.add_child(boxed(PatchVertexCountCase {
            name: format!("patch_vertices_{in_size}_in_{out_size}_out"),
            input_patch_size: in_size,
            output_patch_size: out_size,
            reference,
        }));
    }

    for case_type in PerPatchCaseType::ALL {
        group.add_child(boxed(PerPatchDataCase { case_type }));
    }

    for case_type in [
        GlPositionCaseType::VsToTcs,
        GlPositionCaseType::TcsToTes,
        GlPositionCaseType::VsToTcsToTes,
    ] {
        group.add_child(boxed(GlPositionCase { case_type }));
    }

    group.add_child(boxed(BarrierCase));
    group
}

// ---------------------------------------------------------------------------------------
// misc_draw: BasicVariousTessLevelsPosAttrCase and its subclasses
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum BasicRenderKind {
    /// `BasicTriangleFillCoverCase`
    FillCover,
    /// `BasicTriangleFillNonOverlapCase`
    FillOverlap,
    /// `IsolinesRenderCase`
    Isolines,
}

/// A case with one input attribute (in_v_position) and a TCS; tests with a couple of different sets of
/// tessellation levels.
struct BasicVariousTessLevelsPosAttrCase {
    name: String,
    kind: BasicRenderKind,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
}

const BASIC_VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
    ${GLSL_PER_VERTEX_OUT}\n\
    \n\
    in highp vec2 in_v_position;\n\
    \n\
    out highp vec2 in_tc_position;\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   in_tc_position = in_v_position;\n\
    }\n";

const BASIC_FRAGMENT_COVER_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
    \n\
    layout (location = 0) out mediump vec4 o_color;\n\
    \n\
    void main (void)\n\
    {\n\
    \x20   o_color = vec4(1.0);\n\
    }\n";

const QUAD_POSITION_LINES: &str = "    highp vec2 corner0 = in_te_position[0];\n\
    \x20   highp vec2 corner1 = in_te_position[1];\n\
    \x20   highp vec2 corner2 = in_te_position[2];\n\
    \x20   highp vec2 corner3 = in_te_position[3];\n\
    \x20   highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*corner0\n\
    \x20                  + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*corner1\n\
    \x20                  + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*corner2\n\
    \x20                  + (    gl_TessCoord.x)*(    gl_TessCoord.y)*corner3;\n";

impl BasicVariousTessLevelsPosAttrCase {
    /// `makeSources`: the TES and the fragment shader of the subclass.
    fn tes_and_fragment(&self) -> (String, &'static str) {
        let mut tes = String::new();
        match self.kind {
            BasicRenderKind::FillCover => {
                tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GPU_SHADER5_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PRECISE_PER_VERTEX_OUT}\n\n");
                tes.push_str(&tes_layout(self.primitive_type, Some(self.spacing)));
                tes.push_str("\nin highp vec2 in_te_position[];\n\nprecise gl_Position;\nvoid main (void)\n{\n");
                if self.primitive_type == TessPrimitiveType::Triangles {
                    tes.push_str(
                        "\n    highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));\n\
                         \x20   highp vec2 corner0 = in_te_position[0];\n\
                         \x20   highp vec2 corner1 = in_te_position[1];\n\
                         \x20   highp vec2 corner2 = in_te_position[2];\n\
                         \x20   highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;\n\
                         \x20   highp vec2 fromCenter = pos - (corner0 + corner1 + corner2) / 3.0;\n\
                         \x20   highp float f = (1.0 - length(fromCenter)) * (1.5 - d);\n\
                         \x20   pos += 0.75 * f * fromCenter / (length(fromCenter) + 0.3);\n\
                         \x20   gl_Position = vec4(pos, 0.0, 1.0);\n",
                    );
                } else {
                    tes.push_str(QUAD_POSITION_LINES);
                    tes.push_str(
                        "    highp float d = 2.0 * min(abs(gl_TessCoord.x-0.5), abs(gl_TessCoord.y-0.5));\n\
                         \x20   highp vec2 fromCenter = pos - (corner0 + corner1 + corner2 + corner3) / 4.0;\n\
                         \x20   highp float f = (1.0 - length(fromCenter)) * sqrt(1.7 - d);\n\
                         \x20   pos += 0.75 * f * fromCenter / (length(fromCenter) + 0.3);\n\
                         \x20   gl_Position = vec4(pos, 0.0, 1.0);\n",
                    );
                }
                tes.push_str("}\n");
                (tes, BASIC_FRAGMENT_COVER_TEMPLATE)
            }
            BasicRenderKind::FillOverlap => {
                tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
                tes.push_str(&tes_layout(self.primitive_type, Some(self.spacing)));
                tes.push_str("\nin highp vec2 in_te_position[];\n\nout mediump vec4 in_f_color;\n\nuniform mediump float u_tessLevelInner0;\nuniform mediump float u_tessLevelInner1;\n\nvoid main (void)\n{\n");
                if self.primitive_type == TessPrimitiveType::Triangles {
                    tes.push_str(
                        "\n    highp vec2 corner0 = in_te_position[0];\n\
                         \x20   highp vec2 corner1 = in_te_position[1];\n\
                         \x20   highp vec2 corner2 = in_te_position[2];\n\
                         \x20   highp vec2 pos =  corner0*gl_TessCoord.x + corner1*gl_TessCoord.y + corner2*gl_TessCoord.z;\n\
                         \x20   gl_Position = vec4(pos, 0.0, 1.0);\n\
                         \x20   highp int numConcentricTriangles = int(round(u_tessLevelInner0)) / 2 + 1;\n\
                         \x20   highp float d = 3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z));\n\
                         \x20   highp int phase = int(d*float(numConcentricTriangles)) % 3;\n\
                         \x20   in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)\n\
                         \x20              : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)\n\
                         \x20              :              vec4(0.0, 0.0, 1.0, 1.0);\n",
                    );
                } else {
                    tes.push_str(QUAD_POSITION_LINES);
                    tes.push_str(
                        "    gl_Position = vec4(pos, 0.0, 1.0);\n\
                         \x20   highp int phaseX = int(round((0.5 - abs(gl_TessCoord.x-0.5)) * u_tessLevelInner0));\n\
                         \x20   highp int phaseY = int(round((0.5 - abs(gl_TessCoord.y-0.5)) * u_tessLevelInner1));\n\
                         \x20   highp int phase = min(phaseX, phaseY) % 3;\n\
                         \x20   in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)\n\
                         \x20              : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)\n\
                         \x20              :              vec4(0.0, 0.0, 1.0, 1.0);\n",
                    );
                }
                tes.push_str("}\n");
                (tes, MEDIUMP_COLOR_FRAGMENT_TEMPLATE)
            }
            BasicRenderKind::Isolines => {
                tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
                tes.push_str(&tes_layout(TessPrimitiveType::Isolines, Some(self.spacing)));
                tes.push_str("\nin highp vec2 in_te_position[];\n\nout mediump vec4 in_f_color;\n\nuniform mediump float u_tessLevelOuter0;\nuniform mediump float u_tessLevelOuter1;\n\nvoid main (void)\n{\n");
                tes.push_str(QUAD_POSITION_LINES);
                tes.push_str(
                    "    pos.y += 0.15*sin(gl_TessCoord.x*10.0);\n\
                     \x20   gl_Position = vec4(pos, 0.0, 1.0);\n\
                     \x20   highp int phaseX = int(round(gl_TessCoord.x*u_tessLevelOuter1));\n\
                     \x20   highp int phaseY = int(round(gl_TessCoord.y*u_tessLevelOuter0));\n\
                     \x20   highp int phase = (phaseX + phaseY) % 3;\n\
                     \x20   in_f_color = phase == 0 ? vec4(1.0, 0.0, 0.0, 1.0)\n\
                     \x20              : phase == 1 ? vec4(0.0, 1.0, 0.0, 1.0)\n\
                     \x20              :              vec4(0.0, 0.0, 1.0, 1.0);\n\
                     }\n",
                );
                (tes, MEDIUMP_COLOR_FRAGMENT_TEMPLATE)
            }
        }
    }
}

impl TestCase for BasicVariousTessLevelsPosAttrCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;
        if self.kind == BasicRenderKind::FillCover {
            check_gpu_shader5_support(context)?;
        }

        let references = misc_draw_refs(&self.name);
        let (tes, fragment) = self.tes_and_fragment();

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = ");
        tcs.push_str(if self.primitive_type == TessPrimitiveType::Triangles {
            "3"
        } else {
            "4"
        });
        tcs.push_str(") out;\n\nin highp vec2 in_tc_position[];\n\nout highp vec2 in_te_position[];\n\nuniform mediump float u_tessLevelInner0;\nuniform mediump float u_tessLevelInner1;\nuniform mediump float u_tessLevelOuter0;\nuniform mediump float u_tessLevelOuter1;\nuniform mediump float u_tessLevelOuter2;\nuniform mediump float u_tessLevelOuter3;\n\nvoid main (void)\n{\n    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];\n\n    gl_TessLevelInner[0] = u_tessLevelInner0;\n    gl_TessLevelInner[1] = u_tessLevelInner1;\n\n    gl_TessLevelOuter[0] = u_tessLevelOuter0;\n    gl_TessLevelOuter[1] = u_tessLevelOuter1;\n    gl_TessLevelOuter[2] = u_tessLevelOuter2;\n    gl_TessLevelOuter[3] = u_tessLevelOuter3;\n}\n");

        let program = build_program(context, BASIC_VERTEX_TEMPLATE, Some(tcs.as_str()), &tes, fragment, None)?;
        let program_gl = program.program();
        let gl = context.gl();

        struct TessLevelCase {
            inner: [f32; 2],
            outer: [f32; 4],
        }
        const TESS_LEVEL_CASES: [TessLevelCase; 3] = [
            TessLevelCase {
                inner: [9.0, 9.0],
                outer: [9.0, 9.0, 9.0, 9.0],
            },
            TessLevelCase {
                inner: [8.0, 11.0],
                outer: [13.0, 15.0, 18.0, 21.0],
            },
            TessLevelCase {
                inner: [17.0, 14.0],
                outer: [3.0, 6.0, 9.0, 12.0],
            },
        ];

        let viewport = set_random_viewport(context, &self.name);
        let patch_size = if self.primitive_type == TessPrimitiveType::Triangles {
            3
        } else {
            4
        };

        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(program_gl);
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, patch_size);
        }

        for (tess_level_case_ndx, tess_level_case) in TESS_LEVEL_CASES.iter().enumerate() {
            let inner_levels: [f32; 2] =
                std::array::from_fn(|i| get_clamped_rounded_tess_level(self.spacing, tess_level_case.inner[i]) as f32);
            let outer_levels: [f32; 4] =
                std::array::from_fn(|i| get_clamped_rounded_tess_level(self.spacing, tess_level_case.outer[i]) as f32);

            log::info!("Tessellation levels: inner {inner_levels:?}, outer {outer_levels:?}");

            // SAFETY: locations queried from this program; -1 is a no-op.
            unsafe {
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelInner0".as_ptr()),
                    inner_levels[0],
                );
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelInner1".as_ptr()),
                    inner_levels[1],
                );
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelOuter0".as_ptr()),
                    outer_levels[0],
                );
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelOuter1".as_ptr()),
                    outer_levels[1],
                );
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelOuter2".as_ptr()),
                    outer_levels[2],
                );
                gl.uniform_1f(
                    gl.get_uniform_location(program_gl, c"u_tessLevelOuter3".as_ptr()),
                    outer_levels[3],
                );
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            {
                let positions: Vec<f32> = if self.primitive_type == TessPrimitiveType::Triangles {
                    vec![0.8, 0.6, 0.0, -0.786, -0.8, 0.6]
                } else {
                    vec![-0.8, -0.8, 0.8, -0.8, -0.8, 0.8, 0.8, 0.8]
                };
                debug_assert_eq!(positions.len() as i32, patch_size * 2);

                let binding = glu::va::float("in_v_position", 2, patch_size, 0, &positions);
                glu::draw(
                    &context.render_context,
                    program_gl,
                    &[binding],
                    &glu::pr::list(glu::PrimitiveType::Patches, patch_size),
                )?;
                glu::expect_no_error(gl, "Draw failed")?;
            }

            let rendered = get_pixels(context, &viewport)?;
            if !compare_image(&rendered, references[tess_level_case_ndx], 0.002)? {
                return Ok(TestStatus::fail("Image comparison failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `TessellationTests::init`'s `misc_draw` group.
pub fn misc_draw_group() -> TestCaseGroup {
    const SPACINGS: [SpacingMode; 3] = [
        SpacingMode::Equal,
        SpacingMode::FractionalOdd,
        SpacingMode::FractionalEven,
    ];

    let mut group = TestCaseGroup::new("misc_draw");

    for (prefix, kind) in [
        ("fill_cover", BasicRenderKind::FillCover),
        ("fill_overlap", BasicRenderKind::FillOverlap),
    ] {
        for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
            for spacing in SPACINGS {
                group.add_child(boxed(BasicVariousTessLevelsPosAttrCase {
                    name: format!("{prefix}_{}_{}", primitive_type.shader_name(), spacing.shader_name()),
                    kind,
                    primitive_type,
                    spacing,
                }));
            }
        }
    }

    for spacing in SPACINGS {
        group.add_child(boxed(BasicVariousTessLevelsPosAttrCase {
            name: format!("isolines_{}", spacing.shader_name()),
            kind: BasicRenderKind::Isolines,
            primitive_type: TessPrimitiveType::Isolines,
            spacing,
        }));
    }

    group
}

// ---------------------------------------------------------------------------------------
// user_defined_io: UserDefinedIOCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
#[allow(clippy::enum_variant_names)]
enum IoType {
    PerPatch,
    PerPatchArray,
    PerPatchBlock,
    PerPatchBlockArray,
    PerVertex,
    PerVertexBlock,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexIoArraySize {
    Implicit,
    /// Use gl_MaxPatchVertices as size for per-vertex input array.
    ExplicitShaderBuiltin,
    /// Query GL_MAX_PATCH_VERTICES, and use that as size for per-vertex input array.
    ExplicitQuery,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TessControlOutArraySize {
    Implicit,
    Layout,
    #[allow(dead_code)]
    Query,
    #[allow(dead_code)]
    ShaderBuiltin,
}

const NUM_OUTPUT_VERTICES: i32 = 5;
const NUM_PER_PATCH_ARRAY_ELEMS: i32 = 3;
const NUM_PER_PATCH_BLOCKS: i32 = 2;

/// `UserDefinedIOCase::BasicTypeVisitFunc`
type BasicTypeVisitFunc = fn(&str, DataType, i32) -> String;

/// `UserDefinedIOCase::TopLevelObject`, with its two subclasses `Variable` and `IOBlock`.
#[derive(Clone)]
enum TopLevelObject {
    Variable {
        name: String,
        /// If this Variable is an array element, the element type; otherwise just the variable type.
        ty: VarType,
        is_array: bool,
    },
    IoBlock {
        block_name: String,
        interface_name: String,
        members: Vec<(String, VarType)>,
    },
}

/// `numBasicSubobjects`
fn num_basic_subobjects(ty: &VarType) -> i32 {
    match ty {
        VarType::Basic(..) => 1,
        VarType::Array(elem, size) => size * num_basic_subobjects(elem),
        VarType::Struct(s) => s.members.iter().map(|m| num_basic_subobjects(&m.ty)).sum(),
    }
}

/// `UserDefinedIOCase::glslTraverseBasicTypes` - GLSL code that traverses the basic-type subobjects in a
/// `root_type`-typed object named `root_name`. Arrays are traversed with loops and struct members are
/// each traversed separately; the code for each basic-type subobject is generated by `visit`.
fn glsl_traverse_basic_types(
    root_name: &str,
    root_type: &VarType,
    array_nesting_depth: i32,
    indentation_depth: i32,
    visit: BasicTypeVisitFunc,
) -> String {
    match root_type {
        VarType::Basic(basic_type, _) => visit(root_name, *basic_type, indentation_depth),
        VarType::Array(elem, size) => {
            let indentation = "\t".repeat(indentation_depth as usize);
            let loop_index_name = format!("i{array_nesting_depth}");
            format!(
                "{indentation}for (int {loop_index_name} = 0; {loop_index_name} < {size}; {loop_index_name}++)\n{indentation}{{\n{}{indentation}}}\n",
                glsl_traverse_basic_types(
                    &format!("{root_name}[{loop_index_name}]"),
                    elem,
                    array_nesting_depth + 1,
                    indentation_depth + 1,
                    visit
                )
            )
        }
        VarType::Struct(struct_type) => {
            let mut result = String::new();
            for member in &struct_type.members {
                result.push_str(&glsl_traverse_basic_types(
                    &format!("{root_name}.{}", member.name),
                    &member.ty,
                    array_nesting_depth,
                    indentation_depth,
                    visit,
                ));
            }
            result
        }
    }
}

/// `UserDefinedIOCase::glslAssignBasicTypeObject` - used as the `visit` argument for `glsl_traverse_basic_types`.
fn glsl_assign_basic_type_object(name: &str, ty: DataType, indentation_depth: i32) -> String {
    let scalar_size = ty.scalar_size();
    let indentation = "\t".repeat(indentation_depth as usize);
    let mut result = format!("{indentation}{name} = ");

    if ty != DataType::Float {
        result.push_str(ty.name());
        result.push('(');
    }
    for i in 0..scalar_size {
        if i > 0 {
            result.push_str(&format!(", v+{:.1}", 0.8f32 * i as f32));
        } else {
            result.push('v');
        }
    }
    if ty != DataType::Float {
        result.push(')');
    }
    result.push_str(&format!(";\n{indentation}v += 0.4;\n"));
    result
}

/// `UserDefinedIOCase::glslCheckBasicTypeObject` - used as the `visit` argument for `glsl_traverse_basic_types`.
fn glsl_check_basic_type_object(name: &str, ty: DataType, indentation_depth: i32) -> String {
    let scalar_size = ty.scalar_size();
    let indentation = "\t".repeat(indentation_depth as usize);
    let mut result = format!("{indentation}allOk = allOk && compare_{}({name}, ", ty.name());

    if ty != DataType::Float {
        result.push_str(ty.name());
        result.push('(');
    }
    for i in 0..scalar_size {
        if i > 0 {
            result.push_str(&format!(", v+{:.1}", 0.8f32 * i as f32));
        } else {
            result.push('v');
        }
    }
    if ty != DataType::Float {
        result.push(')');
    }
    result.push_str(&format!(
        ");\n{indentation}v += 0.4;\n{indentation}if (allOk) firstFailedInputIndex++;\n"
    ));
    result
}

impl TopLevelObject {
    fn name(&self) -> &str {
        match self {
            Self::Variable { name, .. } => name,
            Self::IoBlock { interface_name, .. } => interface_name,
        }
    }

    fn block_body(block_name: &str, members: &[(String, VarType)]) -> String {
        let mut buf = format!("{block_name}\n{{\n");
        for (name, ty) in members {
            buf.push_str(&format!("\t{};\n", declare_var(ty, name, 0)));
        }
        buf
    }

    fn declare(&self) -> String {
        match self {
            Self::Variable { name, ty, is_array } => {
                debug_assert!(!is_array);
                format!("{};\n", declare_var(ty, name, 0))
            }
            Self::IoBlock {
                block_name,
                interface_name,
                members,
            } => format!("{}}} {interface_name};\n", Self::block_body(block_name, members)),
        }
    }

    fn declare_array(&self, array_size_expr: &str) -> String {
        match self {
            Self::Variable { name, ty, is_array } => {
                debug_assert!(*is_array);
                format!("{}[{array_size_expr}];\n", declare_var(ty, name, 0))
            }
            Self::IoBlock {
                block_name,
                interface_name,
                members,
            } => {
                format!(
                    "{}}} {interface_name}[{array_size_expr}];\n",
                    Self::block_body(block_name, members)
                )
            }
        }
    }

    /// `numArrayElements` negative: traverse just `array[gl_InvocationID]`, not all indices.
    fn glsl_traverse_basic_type_array(
        &self,
        num_array_elements: i32,
        indentation_depth: i32,
        visit: BasicTypeVisitFunc,
    ) -> String {
        match self {
            Self::Variable { name, ty, is_array } => {
                debug_assert!(*is_array);
                let traverse_as_array = num_array_elements >= 0;
                let traversed_name = if traverse_as_array {
                    name.clone()
                } else {
                    format!("{name}[gl_InvocationID]")
                };
                let ty = if traverse_as_array {
                    VarType::array(ty.clone(), num_array_elements)
                } else {
                    ty.clone()
                };
                glsl_traverse_basic_types(&traversed_name, &ty, 0, indentation_depth, visit)
            }
            Self::IoBlock {
                interface_name,
                members,
                ..
            } => {
                if num_array_elements >= 0 {
                    let indentation = "\t".repeat(indentation_depth as usize);
                    let mut result =
                        format!("{indentation}for (int i0 = 0; i0 < {num_array_elements}; i0++)\n{indentation}{{\n");
                    for (name, ty) in members {
                        result.push_str(&glsl_traverse_basic_types(
                            &format!("{interface_name}[i0].{name}"),
                            ty,
                            1,
                            indentation_depth + 1,
                            visit,
                        ));
                    }
                    result.push_str(&format!("{indentation}}}\n"));
                    result
                } else {
                    let mut result = String::new();
                    for (name, ty) in members {
                        result.push_str(&glsl_traverse_basic_types(
                            &format!("{interface_name}[gl_InvocationID].{name}"),
                            ty,
                            0,
                            indentation_depth,
                            visit,
                        ));
                    }
                    result
                }
            }
        }
    }

    fn glsl_traverse_basic_type(&self, indentation_depth: i32, visit: BasicTypeVisitFunc) -> String {
        match self {
            Self::Variable { name, ty, is_array } => {
                debug_assert!(!is_array);
                glsl_traverse_basic_types(name, ty, 0, indentation_depth, visit)
            }
            Self::IoBlock {
                interface_name,
                members,
                ..
            } => {
                let mut result = String::new();
                for (name, ty) in members {
                    result.push_str(&glsl_traverse_basic_types(
                        &format!("{interface_name}.{name}"),
                        ty,
                        0,
                        indentation_depth,
                        visit,
                    ));
                }
                result
            }
        }
    }

    fn num_basic_subobjects_in_element_type(&self) -> i32 {
        match self {
            Self::Variable { ty, .. } => num_basic_subobjects(ty),
            Self::IoBlock { members, .. } => members.iter().map(|(_, ty)| num_basic_subobjects(ty)).sum(),
        }
    }

    fn basic_subobject_at_index(&self, subobject_index: i32, array_size: i32) -> String {
        match self {
            Self::Variable { name, ty, is_array } => {
                let ty = if *is_array {
                    VarType::array(ty.clone(), array_size)
                } else {
                    ty.clone()
                };
                let paths: Vec<Vec<VarTypeComponent>> = basic_type_paths(&ty);
                match paths.get(subobject_index as usize) {
                    Some(path) => format!("{name}{}", type_access_name("", &ty, path)),
                    None => String::new(),
                }
            }
            Self::IoBlock {
                interface_name,
                members,
                ..
            } => {
                let mut current_index = 0;
                for array_ndx in 0..array_size {
                    for (member_name, member_type) in members {
                        for path in basic_type_paths(member_type) {
                            if current_index == subobject_index {
                                return format!(
                                    "{interface_name}[{array_ndx}].{member_name}{}",
                                    type_access_name("", member_type, &path)
                                );
                            }
                            current_index += 1;
                        }
                    }
                }
                String::new()
            }
        }
    }
}

/// `UserDefinedIOCase::numBasicSubobjectsInElementType`
fn num_basic_subobjects_in_objects(objects: &[TopLevelObject]) -> i32 {
    objects
        .iter()
        .map(TopLevelObject::num_basic_subobjects_in_element_type)
        .sum()
}

/// `UserDefinedIOCase::basicSubobjectAtIndex`
fn basic_subobject_at_index(subobject_index: i32, objects: &[TopLevelObject], top_level_array_size: i32) -> String {
    let mut current_index = 0;
    let mut object_index = 0;
    while current_index < subobject_index && object_index < objects.len() {
        current_index += objects[object_index].num_basic_subobjects_in_element_type() * top_level_array_size;
        object_index += 1;
    }
    if current_index > subobject_index {
        object_index -= 1;
        current_index -= objects[object_index].num_basic_subobjects_in_element_type() * top_level_array_size;
    }
    match objects.get(object_index) {
        Some(object) => object.basic_subobject_at_index(subobject_index - current_index, top_level_array_size),
        None => String::new(),
    }
}

/// Case testing user-defined IO between TCS and TES.
///
/// TCS outputs various values to TES, including aggregates. The outputs can be per-patch or per-vertex,
/// and if per-vertex, they can also be in an IO block. Per-vertex input array size can be left implicit
/// (i.e. inputArray[]) or explicit either by gl_MaxPatchVertices or an integer literal whose value is
/// queried from GL.
///
/// The values output are generated in TCS and verified in TES against similarly generated values. In case
/// a verification of a value fails, the index of the invalid value is output with TF. As a quick check,
/// also the rendering result is verified (against pre-rendered reference).
struct UserDefinedIoCase {
    name: String,
    primitive_type: TessPrimitiveType,
    io_type: IoType,
    vertex_io_array_size: VertexIoArraySize,
    tess_control_out_array_size: TessControlOutArraySize,
}

impl TestCase for UserDefinedIoCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_tessellation_support(context)?;
        check_render_target_size(context, RENDER_SIZE)?;

        let gl = context.gl();
        let io_type = self.io_type;

        let is_per_patch_io = matches!(
            io_type,
            IoType::PerPatch | IoType::PerPatchArray | IoType::PerPatchBlock | IoType::PerPatchBlockArray
        );
        let is_explicit_vertex_array_size = matches!(
            self.vertex_io_array_size,
            VertexIoArraySize::ExplicitShaderBuiltin | VertexIoArraySize::ExplicitQuery
        );

        let max_patch_vertices = || context.context_info.get_int(gl, glw::GL_MAX_PATCH_VERTICES).to_string();

        let vertex_attr_array_input_size = match self.vertex_io_array_size {
            VertexIoArraySize::Implicit => String::new(),
            VertexIoArraySize::ExplicitShaderBuiltin => "gl_MaxPatchVertices".to_string(),
            VertexIoArraySize::ExplicitQuery => max_patch_vertices(),
        };

        let maybe_patch = if is_per_patch_io { "patch " } else { "" };
        let out_maybe_patch = format!("{maybe_patch}out ");
        let in_maybe_patch = format!("{maybe_patch}in ");
        let use_block = matches!(
            io_type,
            IoType::PerVertexBlock | IoType::PerPatchBlock | IoType::PerPatchBlockArray
        );

        let mut tcs_declarations = String::new();
        let mut tcs_statements = String::new();
        let mut tes_declarations = String::new();
        let mut tes_statements = String::new();
        let mut tcs_outputs: Vec<TopLevelObject> = Vec::new();
        let mut tes_inputs: Vec<TopLevelObject> = Vec::new();

        {
            let highp_float = VarType::basic(DataType::Float, Some(Precision::HighP));
            let mut struct_type = StructType::new("S");
            let mut used_struct = false;

            struct_type.add_member("x", VarType::basic(DataType::Int, Some(Precision::HighP)));
            struct_type.add_member("y", VarType::basic(DataType::FloatVec4, Some(Precision::HighP)));

            if use_block {
                // It is illegal to have a structure containing an array as an output variable
                struct_type.add_member("z", VarType::array(highp_float.clone(), 2));
            }

            let struct_type = Arc::new(struct_type);
            let struct_var_type = VarType::structure(&struct_type);

            if use_block {
                // use leaner block to make sure it is not larger than allowed (per-patch storage is very limited)
                let use_lightweight_block = io_type == IoType::PerPatchBlockArray;
                let mut block_members: Vec<(String, VarType)> = Vec::new();

                if !use_lightweight_block {
                    block_members.push(("blockS".to_string(), struct_var_type.clone()));
                }

                block_members.push(("blockFa".to_string(), VarType::array(highp_float.clone(), 3)));
                block_members.push(("blockSa".to_string(), VarType::array(struct_var_type.clone(), 2)));
                block_members.push(("blockF".to_string(), highp_float.clone()));

                tcs_outputs.push(TopLevelObject::IoBlock {
                    block_name: "TheBlock".to_string(),
                    interface_name: "tcBlock".to_string(),
                    members: block_members.clone(),
                });
                tes_inputs.push(TopLevelObject::IoBlock {
                    block_name: "TheBlock".to_string(),
                    interface_name: "teBlock".to_string(),
                    members: block_members,
                });

                used_struct = true;
            } else {
                let is_array = io_type != IoType::PerPatch;
                let var0 = TopLevelObject::Variable {
                    name: "in_te_s".to_string(),
                    ty: struct_var_type.clone(),
                    is_array,
                };
                let var1 = TopLevelObject::Variable {
                    name: "in_te_f".to_string(),
                    ty: highp_float.clone(),
                    is_array,
                };

                if io_type != IoType::PerPatchArray {
                    // Arrays of structures are disallowed, add struct cases only if not arrayed variable
                    tcs_outputs.push(var0.clone());
                    tes_inputs.push(var0);

                    used_struct = true;
                }

                tcs_outputs.push(var1.clone());
                tes_inputs.push(var1);
            }

            tcs_declarations.push_str("in ");
            tcs_declarations.push_str(
                &TopLevelObject::Variable {
                    name: "in_tc_attr".to_string(),
                    ty: highp_float.clone(),
                    is_array: true,
                }
                .declare_array(&vertex_attr_array_input_size),
            );

            if used_struct {
                tcs_declarations.push_str(&declare_struct(&struct_type, 0));
                tcs_declarations.push_str(";\n");
            }

            tcs_statements.push_str("\t{\n\t\thighp float v = 1.3;\n");

            for output in &tcs_outputs {
                // -1 means indexing with gl_InvocationID
                let num_elements = if !is_per_patch_io {
                    -1
                } else {
                    match io_type {
                        IoType::PerPatch | IoType::PerPatchBlock => 1,
                        IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS,
                        IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS,
                        _ => unreachable!("per-patch types only"),
                    }
                };
                let is_array = num_elements != 1;

                if is_array {
                    let size = match io_type {
                        IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS.to_string(),
                        IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS.to_string(),
                        _ => match self.tess_control_out_array_size {
                            TessControlOutArraySize::Layout => NUM_OUTPUT_VERTICES.to_string(),
                            TessControlOutArraySize::Query => max_patch_vertices(),
                            TessControlOutArraySize::ShaderBuiltin => "gl_MaxPatchVertices".to_string(),
                            TessControlOutArraySize::Implicit => String::new(),
                        },
                    };
                    tcs_declarations.push_str(&out_maybe_patch);
                    tcs_declarations.push_str(&output.declare_array(&size));
                } else {
                    tcs_declarations.push_str(&out_maybe_patch);
                    tcs_declarations.push_str(&output.declare());
                }

                let step = 0.4f32 * output.num_basic_subobjects_in_element_type() as f32;
                if !is_per_patch_io {
                    tcs_statements.push_str(&format!("\t\tv += float(gl_InvocationID)*{step:.1};\n"));
                }

                tcs_statements.push_str(&format!("\n\t\t// Assign values to output {}\n", output.name()));
                if is_array {
                    tcs_statements.push_str(&output.glsl_traverse_basic_type_array(
                        num_elements,
                        2,
                        glsl_assign_basic_type_object,
                    ));
                } else {
                    tcs_statements.push_str(&output.glsl_traverse_basic_type(2, glsl_assign_basic_type_object));
                }

                if !is_per_patch_io {
                    tcs_statements.push_str(&format!(
                        "\t\tv += float({NUM_OUTPUT_VERTICES}-gl_InvocationID-1)*{step:.1};\n"
                    ));
                }
            }
            tcs_statements.push_str("\t}\n");

            if used_struct {
                tes_declarations.push_str(&declare_struct(&struct_type, 0));
                tes_declarations.push_str(";\n");
            }

            tes_statements.push_str(
                "\tbool allOk = true;\n\thighp uint firstFailedInputIndex = 0u;\n\t{\n\t\thighp float v = 1.3;\n",
            );
            for input in &tes_inputs {
                let num_elements = if !is_per_patch_io {
                    NUM_OUTPUT_VERTICES
                } else {
                    match io_type {
                        IoType::PerPatch | IoType::PerPatchBlock => 1,
                        IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS,
                        IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS,
                        _ => unreachable!("per-patch types only"),
                    }
                };
                let is_array = num_elements != 1;

                if is_array {
                    let size = match io_type {
                        IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS.to_string(),
                        IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS.to_string(),
                        _ if is_explicit_vertex_array_size => vertex_attr_array_input_size.clone(),
                        _ => String::new(),
                    };
                    tes_declarations.push_str(&in_maybe_patch);
                    tes_declarations.push_str(&input.declare_array(&size));
                } else {
                    tes_declarations.push_str(&in_maybe_patch);
                    tes_declarations.push_str(&input.declare());
                }

                tes_statements.push_str(&format!("\n\t\t// Check values in input {}\n", input.name()));
                if is_array {
                    tes_statements.push_str(&input.glsl_traverse_basic_type_array(
                        num_elements,
                        2,
                        glsl_check_basic_type_object,
                    ));
                } else {
                    tes_statements.push_str(&input.glsl_traverse_basic_type(2, glsl_check_basic_type_object));
                }
            }
            tes_statements.push_str("\t}\n");
        }

        let vertex = "${GLSL_VERSION_DECL}\n${GLSL_PER_VERTEX_OUT}\n\nin highp float in_v_attr;\nout highp float in_tc_attr;\n\nvoid main (void)\n{\n    in_tc_attr = in_v_attr;\n}\n";

        let mut tcs = String::new();
        tcs.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT_ARR}\n\nlayout (vertices = ");
        tcs.push_str(&NUM_OUTPUT_VERTICES.to_string());
        tcs.push_str(") out;\n\n");
        tcs.push_str(&tcs_declarations);
        tcs.push_str("\npatch out highp vec2 in_te_positionScale;\npatch out highp vec2 in_te_positionOffset;\n\nvoid main (void)\n{\n");
        tcs.push_str(&tcs_statements);
        tcs.push_str("\n    in_te_positionScale  = vec2(in_tc_attr[6], in_tc_attr[7]);\n    in_te_positionOffset = vec2(in_tc_attr[8], in_tc_attr[9]);\n\n    gl_TessLevelInner[0] = in_tc_attr[0];\n    gl_TessLevelInner[1] = in_tc_attr[1];\n\n    gl_TessLevelOuter[0] = in_tc_attr[2];\n    gl_TessLevelOuter[1] = in_tc_attr[3];\n    gl_TessLevelOuter[2] = in_tc_attr[4];\n    gl_TessLevelOuter[3] = in_tc_attr[5];\n}\n");

        let mut tes = String::new();
        tes.push_str("${GLSL_VERSION_DECL}\n${TESSELLATION_SHADER_REQUIRE}\n${GLSL_PER_VERTEX_IN_ARR}\n${GLSL_PER_VERTEX_OUT}\n\n");
        tes.push_str(&tes_layout(self.primitive_type, None));
        tes.push('\n');
        tes.push_str(&tes_declarations);
        tes.push_str(
            "\npatch in highp vec2 in_te_positionScale;\n\
             patch in highp vec2 in_te_positionOffset;\n\
             \n\
             out highp vec4 in_f_color;\n\
             // Will contain the index of the first incorrect input,\n\
             // or the number of inputs if all are correct\n\
             flat out highp uint out_te_firstFailedInputIndex;\n\
             \n\
             bool compare_int   (int   a, int   b) { return a == b; }\n\
             bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }\n\
             bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }\n\
             \n\
             void main (void)\n\
             {\n",
        );
        tes.push_str(&tes_statements);
        tes.push_str(
            "\n    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);\n\
             \x20   in_f_color = allOk ? vec4(0.0, 1.0, 0.0, 1.0)\n\
             \x20                      : vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   out_te_firstFailedInputIndex = firstFailedInputIndex;\n\
             }\n",
        );

        let program = build_program(
            context,
            vertex,
            Some(tcs.as_str()),
            &tes,
            COLOR_PASSTHROUGH_FRAGMENT_TEMPLATE,
            Some("out_te_firstFailedInputIndex"),
        )?;
        let program_gl = program.program();

        let viewport = set_random_viewport(context, &self.name);
        const ATTRIBUTES: [f32; 6 + 2 + 2] = [
            /* inner */ 3.0, 4.0, /* outer */ 5.0, 6.0, 7.0, 8.0, /* pos. scale */ 1.2, 1.3,
            /* pos. offset */ -0.3, -0.4,
        ];
        let inner: [f32; 2] = [ATTRIBUTES[0], ATTRIBUTES[1]];
        let outer: [f32; 4] = [ATTRIBUTES[2], ATTRIBUTES[3], ATTRIBUTES[4], ATTRIBUTES[5]];
        let num_vertices = reference_vertex_count(self.primitive_type, SpacingMode::Equal, false, &inner, &outer);
        let tf_handler = TransformFeedbackHandler::new(gl, 1, num_vertices);

        // SAFETY: plain state setters on a program that linked.
        unsafe {
            gl.use_program(program_gl);
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, ATTRIBUTES.len() as i32);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        let mut failure: Option<&'static str> = None;

        {
            let binding = glu::va::float("in_v_attr", 1, ATTRIBUTES.len() as i32, 0, &ATTRIBUTES);
            let tf_result = tf_handler.render_and_get_primitives(
                context,
                program_gl,
                output_primitive_type_gl(self.primitive_type, false),
                &[binding],
                ATTRIBUTES.len() as i32,
            )?;

            {
                let pixels = get_pixels(context, &viewport)?;
                let reference = match self.primitive_type {
                    TessPrimitiveType::Triangles => png!("user_defined_io_triangles_ref.png"),
                    TessPrimitiveType::Quads => png!("user_defined_io_quads_ref.png"),
                    TessPrimitiveType::Isolines => png!("user_defined_io_isolines_ref.png"),
                };
                if !compare_image(&pixels, reference, 0.02)? {
                    failure.get_or_insert("Image comparison failed");
                }
            }

            if tf_result.varying.len() != num_vertices as usize {
                log::warn!(
                    "Failure: transform feedback returned {} vertices; expected {num_vertices}",
                    tf_result.varying.len()
                );
                failure.get_or_insert("Wrong number of vertices");
            } else {
                let top_level_array_size = match io_type {
                    IoType::PerPatch | IoType::PerPatchBlock => 1,
                    IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS,
                    IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS,
                    IoType::PerVertex | IoType::PerVertexBlock => NUM_OUTPUT_VERTICES,
                };
                let num_te_inputs = num_basic_subobjects_in_objects(&tes_inputs) * top_level_array_size;

                for varying in &tf_result.varying {
                    // The varying is a `uint` fed back through a float-typed readback; only its bits matter.
                    let value = varying.to_bits();
                    if value > num_te_inputs as u32 {
                        log::warn!(
                            "Failure: out_te_firstFailedInputIndex has value {value}, should be in range [0, {num_te_inputs}]"
                        );
                        failure.get_or_insert("Invalid transform feedback output");
                    } else if value != num_te_inputs as u32 {
                        log::warn!(
                            "Failure: in tessellation evaluation shader, check for input {} failed",
                            basic_subobject_at_index(value as i32, &tes_inputs, top_level_array_size)
                        );
                        failure.get_or_insert("Invalid input value in tessellation evaluation shader");
                    }
                }
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}

/// `TessellationTests::init`'s `user_defined_io` group.
pub fn user_defined_io_group() -> TestCaseGroup {
    const IO_CASES: [(&str, IoType); 6] = [
        ("per_patch", IoType::PerPatch),
        ("per_patch_array", IoType::PerPatchArray),
        ("per_patch_block", IoType::PerPatchBlock),
        ("per_patch_block_array", IoType::PerPatchBlockArray),
        ("per_vertex", IoType::PerVertex),
        ("per_vertex_block", IoType::PerVertexBlock),
    ];
    const VERTEX_ARRAY_SIZES: [(&str, VertexIoArraySize); 3] = [
        ("vertex_io_array_size_implicit", VertexIoArraySize::Implicit),
        (
            "vertex_io_array_size_shader_builtin",
            VertexIoArraySize::ExplicitShaderBuiltin,
        ),
        ("vertex_io_array_size_query", VertexIoArraySize::ExplicitQuery),
    ];
    const PRIMITIVE_TYPES: [TessPrimitiveType; 3] = [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ];

    let mut user_defined_io_group = TestCaseGroup::new("user_defined_io");

    for (io_name, io_type) in IO_CASES {
        let mut io_type_group = TestCaseGroup::new(io_name);

        for (size_name, vertex_array_size) in VERTEX_ARRAY_SIZES {
            let mut vertex_array_size_group = TestCaseGroup::new(size_name);

            for primitive_type in PRIMITIVE_TYPES {
                vertex_array_size_group.add_child(boxed(UserDefinedIoCase {
                    name: primitive_type.shader_name().to_string(),
                    primitive_type,
                    io_type,
                    vertex_io_array_size: vertex_array_size,
                    tess_control_out_array_size: TessControlOutArraySize::Implicit,
                }));
            }

            if matches!(io_type, IoType::PerVertex | IoType::PerVertexBlock) {
                for primitive_type in PRIMITIVE_TYPES {
                    vertex_array_size_group.add_child(boxed(UserDefinedIoCase {
                        name: format!("{}_explicit_tcs_out_size", primitive_type.shader_name()),
                        primitive_type,
                        io_type,
                        vertex_io_array_size: vertex_array_size,
                        tess_control_out_array_size: TessControlOutArraySize::Layout,
                    }));
                }
            }

            io_type_group.add_child(vertex_array_size_group);
        }

        user_defined_io_group.add_child(io_type_group);
    }

    // ES only
    let mut negative_group = TestCaseGroup::new("negative");
    negative_group.add_child(create_group(
        "es31",
        &crate::generated::shader_library::es31_tessellation_negative_user_defined_io::ROOT,
    ));
    negative_group.add_child(create_group(
        "es32",
        &crate::generated::shader_library::es32_tessellation_negative_user_defined_io::ROOT,
    ));
    user_defined_io_group.add_child(negative_group);

    user_defined_io_group
}
