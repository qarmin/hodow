// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTessellationGeometryInteractionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Ported: the whole `feedback` group (`FeedbackPrimitiveTypeCase`, `FeedbackRecordVariableSelectionCase`)
// the whole `point_size` group and the whole `render` group (`IdentityGeometryShaderCase`,
// `IdentityTessellationShaderCase`, `GridRenderCase`) - that is, everything upstream has.
// Upstream's `intThresholdPositionDeviationCompare` is the `...ErrorThresholdCompare` of `gls::draw_test`
// with no failing pixel allowed; its `fuzzyCompare` verdict is `fuzzy_compare_ok`.
// `${VERSION_DECL}` and the `${EXTENSION_*}` entries are substituted by `specialize_shader`; the
// desktop `core(4, 5)` branches are not written, since this port only creates ES contexts.

use std::mem::size_of_val;

use crate::gls::draw_test::compare::int_threshold_position_deviation_error_threshold_compare;
use crate::glu::{
    self, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, Texture,
    VertexArray,
};
use crate::glw::{self, GLsizeiptr};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::IVec3;
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `specializeShader`
fn specialize_shader(source: &str, context: &Context) -> String {
    let supports_es32 = context.context_type().supports(3, 2);

    source
        .replace("${VERSION_DECL}", context.context_type().glsl_version().declaration())
        .replace(
            "${EXTENSION_GEOMETRY_SHADER}",
            if supports_es32 {
                ""
            } else {
                "#extension GL_EXT_geometry_shader : require\n"
            },
        )
        .replace(
            "${EXTENSION_TESSELATION_SHADER}",
            if supports_es32 {
                ""
            } else {
                "#extension GL_EXT_tessellation_shader : require\n"
            },
        )
        .replace(
            "${EXTENSION_TESSELATION_POINT_SIZE}",
            "#extension GL_EXT_tessellation_point_size : require\n",
        )
        .replace(
            "${EXTENSION_GEOMETRY_POINT_SIZE}",
            "#extension GL_EXT_geometry_point_size : require\n",
        )
}

const WHITE_OUTPUT_FRAGMENT_SHADER: &str = "${VERSION_DECL}\n\
    layout(location = 0) out mediump vec4 fragColor;\n\
    void main (void)\n\
    {\n\
    \x20   fragColor = vec4(1.0);\n\
    }\n";

fn is_black(c: RGBA) -> bool {
    c.get_red() == 0 && c.get_green() == 0 && c.get_blue() == 0
}

// ---------------------------------------------------------------------------------------
// PointSizeCase
// ---------------------------------------------------------------------------------------

const FLAG_VERTEX_SET: i32 = 0x01; // !< set gl_PointSize in vertex shader
const FLAG_TESSELLATION_CONTROL_SET: i32 = 0x02; // !< set gl_PointSize in tessellation evaluation shader
const FLAG_TESSELLATION_EVALUATION_SET: i32 = 0x04; // !< set gl_PointSize in tessellation control shader
const FLAG_TESSELLATION_ADD: i32 = 0x08; // !< read and add to gl_PointSize in tessellation shader pair
const FLAG_TESSELLATION_DONT_SET: i32 = 0x10; // !< don't set gl_PointSize in tessellation shader
const FLAG_GEOMETRY_SET: i32 = 0x20; // !< set gl_PointSize in geometry shader
const FLAG_GEOMETRY_ADD: i32 = 0x40; // !< read and add to gl_PointSize in geometry shader
const FLAG_GEOMETRY_DONT_SET: i32 = 0x80; // !< don't set gl_PointSize in geometry shader

const TESSELLATION_FLAGS: i32 = FLAG_TESSELLATION_CONTROL_SET
    | FLAG_TESSELLATION_EVALUATION_SET
    | FLAG_TESSELLATION_ADD
    | FLAG_TESSELLATION_DONT_SET;
const GEOMETRY_FLAGS: i32 = FLAG_GEOMETRY_SET | FLAG_GEOMETRY_ADD | FLAG_GEOMETRY_DONT_SET;

const POINT_SIZE_RENDER_SIZE: i32 = 32;

/// `PointSizeCase`
struct PointSizeCase {
    name: String,
    flags: i32,
}

impl PointSizeCase {
    /// `PointSizeCase::genTestCaseName`
    fn gen_test_case_name(flags: i32) -> String {
        let parts: [(i32, &str); 8] = [
            (FLAG_VERTEX_SET, "vertex_set"),
            (FLAG_TESSELLATION_CONTROL_SET, "control_set"),
            (FLAG_TESSELLATION_EVALUATION_SET, "evaluation_set"),
            (FLAG_TESSELLATION_ADD, "control_pass_eval_add"),
            (FLAG_TESSELLATION_DONT_SET, "eval_default"),
            (FLAG_GEOMETRY_SET, "geometry_set"),
            (FLAG_GEOMETRY_ADD, "geometry_add"),
            (FLAG_GEOMETRY_DONT_SET, "geometry_default"),
        ];

        // join per-bit descriptions into a single string with '_' separator
        let mut buf = String::new();
        for (flag, text) in parts {
            if flags & flag != 0 {
                if flags & (flag - 1) != 0 {
                    buf.push('_');
                }
                buf.push_str(text);
            }
        }
        buf
    }

    /// `getExpectedPointSize`
    fn get_expected_point_size(&self) -> i32 {
        let flags = self.flags;
        let mut addition = 0;

        // geometry
        if flags & FLAG_GEOMETRY_DONT_SET != 0 {
            return 1;
        } else if flags & FLAG_GEOMETRY_SET != 0 {
            return 6;
        } else if flags & FLAG_GEOMETRY_ADD != 0 {
            addition += 2;
        }

        // tessellation
        if flags & FLAG_TESSELLATION_EVALUATION_SET != 0 {
            return 4 + addition;
        } else if flags & FLAG_TESSELLATION_ADD != 0 {
            addition += 2;
        } else if flags & (FLAG_TESSELLATION_CONTROL_SET | FLAG_TESSELLATION_DONT_SET) != 0 {
            debug_assert!(flags & FLAG_GEOMETRY_ADD == 0); // reading pointSize undefined
            return 1;
        }

        // vertex
        if flags & FLAG_VERTEX_SET != 0 {
            return 2 + addition;
        }

        // undefined
        debug_assert!(false);
        -1
    }

    /// `checkExtensions`
    fn check_extensions(&self, context: &Context) -> Result<(), TestError> {
        let supports_es32 = context.context_type().supports(3, 2);
        let mut required_extensions: Vec<&str> = Vec::new();

        if self.flags & TESSELLATION_FLAGS != 0 && !supports_es32 {
            required_extensions.push("GL_EXT_tessellation_shader");
        }

        if self.flags & (FLAG_TESSELLATION_CONTROL_SET | FLAG_TESSELLATION_EVALUATION_SET | FLAG_TESSELLATION_ADD) != 0
        {
            required_extensions.push("GL_EXT_tessellation_point_size");
        }

        if self.flags & GEOMETRY_FLAGS != 0 && !supports_es32 {
            required_extensions.push("GL_EXT_geometry_shader");
        }

        if self.flags & (FLAG_GEOMETRY_SET | FLAG_GEOMETRY_ADD) != 0 {
            required_extensions.push("GL_EXT_geometry_point_size");
        }

        let all_ok = required_extensions
            .iter()
            .all(|ext| context.context_info.is_extension_supported(ext));

        if !all_ok {
            return Err(TestError::NotSupported(format!(
                "Test requires {{{}}} extension(s)",
                required_extensions.join(", ")
            )));
        }
        Ok(())
    }

    /// `checkPointSizeRequirements`
    fn check_point_size_requirements(&self, context: &Context) -> Result<(), TestError> {
        let gl = context.gl();
        let mut aliased_size_range = [0.0f32; 2];
        let required_size = self.get_expected_point_size();

        // SAFETY: two floats of output for a two-float query.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, aliased_size_range.as_mut_ptr()) };

        if required_size as f32 > aliased_size_range[1] {
            return Err(TestError::NotSupported(format!(
                "Test requires point size {required_size}"
            )));
        }
        Ok(())
    }

    fn gen_vertex_source(&self, context: &Context) -> String {
        let mut buf = String::from(
            "${VERSION_DECL}\nin highp vec4 a_position;\nvoid main ()\n{\n    gl_Position = a_position;\n",
        );

        if self.flags & FLAG_VERTEX_SET != 0 {
            buf.push_str("    gl_PointSize = 2.0;\n");
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn gen_fragment_source(&self, context: &Context) -> String {
        specialize_shader(WHITE_OUTPUT_FRAGMENT_SHADER, context)
    }

    fn gen_tessellation_control_source(&self, context: &Context) -> String {
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_TESSELATION_SHADER}");
        if self.flags & FLAG_TESSELLATION_DONT_SET == 0 {
            buf.push_str("${EXTENSION_TESSELATION_POINT_SIZE}");
        }
        buf.push_str(
            "layout(vertices = 1) out;\n\
             void main ()\n\
             {\n\
             \x20   gl_TessLevelOuter[0] = 3.0;\n\
             \x20   gl_TessLevelOuter[1] = 3.0;\n\
             \x20   gl_TessLevelOuter[2] = 3.0;\n\
             \x20   gl_TessLevelInner[0] = 3.0;\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n",
        );

        if self.flags & FLAG_TESSELLATION_ADD != 0 {
            buf.push_str("    // pass as is to eval\n    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;\n");
        } else if self.flags & FLAG_TESSELLATION_CONTROL_SET != 0 {
            buf.push_str("    // thrown away\n    gl_out[gl_InvocationID].gl_PointSize = 4.0;\n");
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn gen_tessellation_evaluation_source(&self, context: &Context) -> String {
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_TESSELATION_SHADER}");
        if self.flags & FLAG_TESSELLATION_DONT_SET == 0 {
            buf.push_str("${EXTENSION_TESSELATION_POINT_SIZE}");
        }
        buf.push_str(
            "layout(triangles, point_mode) in;\n\
             void main ()\n\
             {\n\
             \x20   // hide all but one vertex\n\
             \x20   if (gl_TessCoord.x < 0.99)\n\
             \x20       gl_Position = vec4(-2.0, 0.0, 0.0, 1.0);\n\
             \x20   else\n\
             \x20       gl_Position = gl_in[0].gl_Position;\n",
        );

        if self.flags & FLAG_TESSELLATION_ADD != 0 {
            buf.push_str("\n    // add to point size\n    gl_PointSize = gl_in[0].gl_PointSize + 2.0;\n");
        } else if self.flags & FLAG_TESSELLATION_EVALUATION_SET != 0 {
            buf.push_str("\n    // set point size\n    gl_PointSize = 4.0;\n");
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn gen_geometry_source(&self, context: &Context) -> String {
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_GEOMETRY_SHADER}");
        if self.flags & FLAG_GEOMETRY_DONT_SET == 0 {
            buf.push_str("${EXTENSION_GEOMETRY_POINT_SIZE}");
        }
        buf.push_str("layout (points) in;\nlayout (points, max_vertices=1) out;\n\nvoid main ()\n{\n");

        if self.flags & FLAG_GEOMETRY_SET != 0 {
            buf.push_str("    gl_Position = gl_in[0].gl_Position;\n    gl_PointSize = 6.0;\n");
        } else if self.flags & FLAG_GEOMETRY_ADD != 0 {
            buf.push_str("    gl_Position = gl_in[0].gl_Position;\n    gl_PointSize = gl_in[0].gl_PointSize + 2.0;\n");
        } else if self.flags & FLAG_GEOMETRY_DONT_SET != 0 {
            buf.push_str("    gl_Position = gl_in[0].gl_Position;\n");
        }

        buf.push_str("    EmitVertex();\n}\n");

        specialize_shader(&buf, context)
    }

    /// `verifyImage`
    fn verify_image(&self, context: &Context, src: &Surface) -> bool {
        let msaa_target = context.render_target().num_samples > 1;
        let expected_size = self.get_expected_point_size();

        log::info!("Verifying rendered point size. Expecting {expected_size} pixels.");

        let mut result_area: Option<[i32; 4]> = None;

        // Find rasterization output area
        for y in 0..src.get_height() {
            for x in 0..src.get_width() {
                if !is_black(src.get_pixel(x, y)) {
                    result_area = Some(match result_area {
                        // first fragment
                        None => [x, y, x + 1, y + 1],
                        // union area
                        Some(area) => [area[0].min(x), area[1].min(y), area[2].max(x + 1), area[3].max(y + 1)],
                    });
                }
            }
        }

        let Some(result_area) = result_area else {
            log::warn!("Verification failed, could not find any point fragments.");
            return false;
        };

        let point_size = [result_area[2] - result_area[0], result_area[3] - result_area[1]];

        // verify area size
        if msaa_target {
            // MSAA: edges may be a little fuzzy
            if (point_size[0] - point_size[1]).abs() > 1 {
                log::warn!("ERROR! Rasterized point is not a square. Detected point size was {point_size:?}");
                return false;
            }

            // MSAA may produce larger areas, allow one pixel larger
            let max_size = point_size[0].max(point_size[1]);
            if expected_size != max_size && expected_size + 1 != max_size {
                log::warn!("ERROR! Point size invalid, expected {expected_size}, got {max_size}");
                return false;
            }
        } else {
            if point_size[0] != point_size[1] {
                log::warn!("ERROR! Rasterized point is not a square. Point size was {point_size:?}");
                return false;
            }

            if point_size[0] != expected_size {
                log::warn!(
                    "ERROR! Point size invalid, expected {expected_size}, got {}",
                    point_size[0]
                );
                return false;
            }
        }

        true
    }
}

impl TestCase for PointSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The first half of `init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        self.check_extensions(context)?;
        self.check_point_size_requirements(context)
    }

    /// The program half of `init`, then `iterate` and `renderTo`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // log
        if self.flags & FLAG_VERTEX_SET != 0 {
            log::info!("Setting point size in vertex shader to 2.0.");
        }
        if self.flags & FLAG_TESSELLATION_CONTROL_SET != 0 {
            log::info!("Setting point size in tessellation control shader to 4.0. (And ignoring it in evaluation).");
        }
        if self.flags & FLAG_TESSELLATION_EVALUATION_SET != 0 {
            log::info!("Setting point size in tessellation evaluation shader to 4.0.");
        }
        if self.flags & FLAG_TESSELLATION_ADD != 0 {
            log::info!("Reading point size in tessellation control shader and adding 2.0 to it in evaluation.");
        }
        if self.flags & FLAG_TESSELLATION_DONT_SET != 0 {
            log::info!(
                "Not setting point size in tessellation evaluation shader (resulting in the default point size)."
            );
        }
        if self.flags & FLAG_GEOMETRY_SET != 0 {
            log::info!("Setting point size in geometry shader to 6.0.");
        }
        if self.flags & FLAG_GEOMETRY_ADD != 0 {
            log::info!("Reading point size in geometry shader and adding 2.0.");
        }
        if self.flags & FLAG_GEOMETRY_DONT_SET != 0 {
            log::info!("Not setting point size in geometry shader (resulting in the default point size).");
        }

        // program
        let mut sources = ProgramSources::default()
            .with(ShaderType::Vertex, self.gen_vertex_source(context))
            .with(ShaderType::Fragment, self.gen_fragment_source(context));

        if self.flags & TESSELLATION_FLAGS != 0 {
            sources = sources
                .with(ShaderType::TessControl, self.gen_tessellation_control_source(context))
                .with(
                    ShaderType::TessEvaluation,
                    self.gen_tessellation_evaluation_source(context),
                );
        }

        if self.flags & GEOMETRY_FLAGS != 0 {
            sources = sources.with(ShaderType::Geometry, self.gen_geometry_source(context));
        }

        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        // renderTo
        let mut result_image = Surface::new(POINT_SIZE_RENDER_SIZE, POINT_SIZE_RENDER_SIZE);
        let tessellation_active = self.flags & TESSELLATION_FLAGS != 0;
        // SAFETY: a NUL-terminated name against the program just built.
        let position_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
        let vao = VertexArray::new(gl);

        log::info!("Rendering single point.");

        if position_location == -1 {
            return Err(TestError::Fail("Attribute a_position location was -1".to_string()));
        }

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, POINT_SIZE_RENDER_SIZE, POINT_SIZE_RENDER_SIZE);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "clear")?;

        // SAFETY: a vertex array this case generated.
        unsafe { gl.bind_vertex_array(vao.get()) };
        glu::expect_no_error(gl, "bind vao")?;

        // SAFETY: a program just built.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "use program")?;

        // SAFETY: a plain generic vertex attribute value.
        unsafe { gl.vertex_attrib_4f(position_location as u32, 0.0, 0.0, 0.0, 1.0) };

        if tessellation_active {
            // SAFETY: plain state setting and a one-vertex patch draw.
            unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1) };
            glu::expect_no_error(gl, "set patch param")?;

            // SAFETY: as above.
            unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 1) };
            glu::expect_no_error(gl, "draw patches")?;
        } else {
            // SAFETY: a one-vertex point draw.
            unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
            glu::expect_no_error(gl, "draw points")?;
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut result_image.get_access())?;

        if self.verify_image(context, &result_image) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

// ---------------------------------------------------------------------------------------
// FeedbackRecordVariableSelectionCase
// ---------------------------------------------------------------------------------------

/// `FeedbackRecordVariableSelectionCase`
struct FeedbackRecordVariableSelectionCase {
    name: &'static str,
}

impl FeedbackRecordVariableSelectionCase {
    fn get_vertex_source(context: &Context) -> String {
        let source = "${VERSION_DECL}\n\
            in highp vec4 a_position;\n\
            out highp vec4 tf_feedback;\n\
            void main()\n\
            {\n\
            \x20   gl_Position = a_position;\n\
            \x20   tf_feedback = vec4(1.0, 1.0, 1.0, 1.0);\n\
            }\n";

        specialize_shader(source, context)
    }

    fn get_fragment_source(context: &Context) -> String {
        specialize_shader(WHITE_OUTPUT_FRAGMENT_SHADER, context)
    }

    fn get_tessellation_control_source(context: &Context) -> String {
        let source = "${VERSION_DECL}\n\
            ${EXTENSION_TESSELATION_SHADER}\
            layout(vertices=3) out;\n\
            void main()\n\
            {\n\
            \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
            \x20   gl_TessLevelOuter[0] = 1.0;\n\
            \x20   gl_TessLevelOuter[1] = 1.0;\n\
            \x20   gl_TessLevelOuter[2] = 1.0;\n\
            \x20   gl_TessLevelInner[0] = 1.0;\n\
            }\n";

        specialize_shader(source, context)
    }

    fn get_tessellation_evaluation_source(context: &Context) -> String {
        let source = "${VERSION_DECL}\n\
            ${EXTENSION_TESSELATION_SHADER}\
            layout(triangles) in;\n\
            out highp vec4 tf_feedback;\n\
            void main()\n\
            {\n\
            \x20   gl_Position = gl_in[0].gl_Position * gl_TessCoord.x + gl_in[1].gl_Position * gl_TessCoord.y + gl_in[2].gl_Position * gl_TessCoord.z;\n\
            \x20   tf_feedback = vec4(2.0, 2.0, 2.0, 2.0);\n\
            }\n";

        specialize_shader(source, context)
    }

    fn get_geometry_source(context: &Context) -> String {
        let source = "${VERSION_DECL}\n\
            ${EXTENSION_GEOMETRY_SHADER}\
            layout (triangles) in;\n\
            layout (triangle_strip, max_vertices=3) out;\n\
            out highp vec4 tf_feedback;\n\
            void main()\n\
            {\n\
            \x20   for (int ndx = 0; ndx < 3; ++ndx)\n\
            \x20   {\n\
            \x20       gl_Position = gl_in[ndx].gl_Position + vec4(float(ndx), float(ndx)*float(ndx), 0.0, 0.0);\n\
            \x20       tf_feedback = vec4(3.0, 3.0, 3.0, 3.0);\n\
            \x20       EmitVertex();\n\
            \x20   }\n\
            \x20   EndPrimitive();\n\
            }\n";

        specialize_shader(source, context)
    }
}

impl TestCase for FeedbackRecordVariableSelectionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports(3, 2)
            && (!context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
                || !context.context_info.is_extension_supported("GL_EXT_geometry_shader"))
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader and GL_EXT_geometry_shader extensions".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        log::info!(
            "Declaring multiple output variables with the same name in multiple shader stages. Capturing the value of the varying using transform feedback."
        );

        // gen feedback buffer fit for 1 triangle (4 components)
        let initial_data: [[f32; 4]; 3] = [[-1.0; 4]; 3];

        log::info!("Creating buffer for transform feedback. Allocating storage for one triangle. Filling with -1.0");

        let xfb_buf = Buffer::new(gl);
        // SAFETY: a buffer this case generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, xfb_buf.get());
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                size_of_val(&initial_data) as GLsizeiptr,
                initial_data.as_ptr().cast(),
                glw::GL_DYNAMIC_READ,
            );
        }
        glu::expect_no_error(gl, "gen xfb buf")?;

        // gen shader
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, Self::get_vertex_source(context))
                .with(ShaderType::Fragment, Self::get_fragment_source(context))
                .with(ShaderType::TessControl, Self::get_tessellation_control_source(context))
                .with(
                    ShaderType::TessEvaluation,
                    Self::get_tessellation_evaluation_source(context),
                )
                .with(ShaderType::Geometry, Self::get_geometry_source(context))
                .with_transform_feedback(&["tf_feedback".to_string()], glw::GL_INTERLEAVED_ATTRIBS),
        );

        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        // SAFETY: a NUL-terminated name against the program just built.
        let pos_loc = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
        let vao = VertexArray::new(gl);

        if pos_loc == -1 {
            return Err(TestError::Fail("a_position attribute location was -1".to_string()));
        }

        let mut status = TestStatus::pass("Pass");

        log::info!("Rendering a patch of size 3.");

        // Render and feed back
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, 1, 1);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "clear")?;

        // SAFETY: a vertex array this case generated.
        unsafe { gl.bind_vertex_array(vao.get()) };
        glu::expect_no_error(gl, "bindVertexArray")?;

        // SAFETY: a plain generic vertex attribute value.
        unsafe { gl.vertex_attrib_4f(pos_loc as u32, 0.0, 0.0, 0.0, 1.0) };
        glu::expect_no_error(gl, "vertexAttrib4f")?;

        // SAFETY: a program just built.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "use program")?;

        // SAFETY: plain state setting.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3) };
        glu::expect_no_error(gl, "set patch param")?;

        // SAFETY: a buffer this case generated.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, xfb_buf.get()) };
        glu::expect_no_error(gl, "bind xfb buf")?;

        // SAFETY: transform feedback around a three-vertex patch draw.
        unsafe { gl.begin_transform_feedback(glw::GL_TRIANGLES) };
        glu::expect_no_error(gl, "beginTransformFeedback")?;

        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 3) };
        glu::expect_no_error(gl, "drawArrays")?;

        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "beginTransformFeedback")?;

        log::info!("Verifying the value of tf_feedback using transform feedback, expecting (3.0, 3.0, 3.0, 3.0).");

        // Read back result (one triangle)
        {
            let mut feedback_values = [[0.0f32; 4]; 3];
            let byte_size = size_of_val(&feedback_values);
            // SAFETY: a read mapping of the whole buffer, which holds exactly `byte_size` bytes.
            let map_ptr = unsafe {
                gl.map_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    byte_size as GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            };
            glu::expect_no_error(gl, "mapBufferRange")?;

            if map_ptr.is_null() {
                return Err(TestError::Fail("mapBufferRange returned null".to_string()));
            }

            // SAFETY: the mapping is `byte_size` bytes and the destination is exactly that large.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    map_ptr.cast::<u8>(),
                    feedback_values.as_mut_ptr().cast::<u8>(),
                    byte_size,
                )
            };

            // SAFETY: unmapping the mapping made above.
            if unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) } != glw::TRUE {
                return Err(TestError::Fail("unmapBuffer did not return TRUE".to_string()));
            }

            for (ndx, value) in feedback_values.iter().enumerate() {
                if !value.iter().all(|c| (c - 3.0).abs() < 0.001) {
                    log::warn!("Feedback vertex {ndx}: expected (3.0, 3.0, 3.0, 3.0), got {value:?}");
                    status = TestStatus::fail("got unexpected feedback results");
                }
            }
        }

        Ok(status)
    }
}

// ---------------------------------------------------------------------------------------
// IdentityShaderCase and its two subclasses
// ---------------------------------------------------------------------------------------

/// `IdentityShaderCase::getVertexSource`
fn identity_vertex_source(context: &Context) -> String {
    let source = "${VERSION_DECL}\n\
        in highp vec4 a_position;\n\
        out highp vec4 v_vertex_color;\n\
        void main (void)\n\
        {\n\
        \x20   gl_Position = a_position;\n\
        \x20   v_vertex_color = vec4(a_position.x * 0.5 + 0.5, a_position.y * 0.5 + 0.5, 1.0, 0.4);\n\
        }\n";

    specialize_shader(source, context)
}

/// `IdentityShaderCase::getFragmentSource`
fn identity_fragment_source(context: &Context) -> String {
    let source = "${VERSION_DECL}\n\
        in mediump vec4 v_fragment_color;\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main (void)\n\
        {\n\
        \x20   fragColor = v_fragment_color;\n\
        }\n";

    specialize_shader(source, context)
}

/// The requirements both identity cases check in `init`, for a `render_size` square target.
fn check_identity_requirements(context: &Context, render_size: i32) -> Result<(), TestError> {
    if !context.context_type().supports(3, 2)
        && (!context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
            || !context.context_info.is_extension_supported("GL_EXT_geometry_shader"))
    {
        return Err(TestError::NotSupported(
            "Test requires GL_EXT_tessellation_shader and GL_EXT_geometry_shader extensions".to_string(),
        ));
    }

    let render_target = context.render_target();
    if render_target.width < render_size || render_target.height < render_size {
        return Err(TestError::NotSupported(format!(
            "Test requires {render_size}x{render_size} or larger render target."
        )));
    }
    Ok(())
}

fn set_additive_blending(gl: &glw::Functions) -> Result<(), TestError> {
    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.enable(glw::GL_BLEND);
        gl.blend_func(glw::GL_SRC_ALPHA, glw::GL_ONE);
        gl.blend_equation(glw::GL_FUNC_ADD);
    }
    glu::expect_no_error(gl, "set blend")
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum IdentityGeometryCaseType {
    Triangles,
    Quads,
    Isolines,
}

/// `IdentityGeometryShaderCase`
struct IdentityGeometryShaderCase {
    name: &'static str,
    case: IdentityGeometryCaseType,
}

impl IdentityGeometryShaderCase {
    const RENDER_SIZE: i32 = 128;

    fn get_tessellation_control_source(&self, context: &Context) -> String {
        let mut buf = String::from(
            "${VERSION_DECL}\n\
             ${EXTENSION_TESSELATION_SHADER}\
             layout(vertices = 4) out;\n\
             \n\
             uniform highp float u_innerTessellationLevel;\n\
             uniform highp float u_outerTessellationLevel;\n\
             in highp vec4 v_vertex_color[];\n\
             out highp vec4 v_patch_color[];\n\
             \n\
             void main (void)\n\
             {\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
             \x20   v_patch_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];\n\
             \n",
        );

        match self.case {
            IdentityGeometryCaseType::Triangles => buf.push_str(
                "    gl_TessLevelOuter[0] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[1] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[2] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelInner[0] = u_innerTessellationLevel;\n",
            ),
            IdentityGeometryCaseType::Quads => buf.push_str(
                "    gl_TessLevelOuter[0] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[1] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[2] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[3] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelInner[0] = u_innerTessellationLevel;\n\
                 \x20   gl_TessLevelInner[1] = u_innerTessellationLevel;\n",
            ),
            IdentityGeometryCaseType::Isolines => buf.push_str(
                "    gl_TessLevelOuter[0] = u_outerTessellationLevel;\n\
                 \x20   gl_TessLevelOuter[1] = u_outerTessellationLevel;\n",
            ),
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn get_tessellation_evaluation_source(&self, context: &Context, geometry_active: bool) -> String {
        let color_output_name = if geometry_active {
            "v_evaluated_color"
        } else {
            "v_fragment_color"
        };
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_TESSELATION_SHADER}layout(");
        buf.push_str(match self.case {
            IdentityGeometryCaseType::Triangles => "triangles",
            IdentityGeometryCaseType::Quads => "quads",
            IdentityGeometryCaseType::Isolines => "isolines",
        });
        buf.push_str(") in;\n\nin highp vec4 v_patch_color[];\nout highp vec4 ");
        buf.push_str(color_output_name);
        buf.push_str(
            ";\n\
             \n\
             // note: No need to use precise gl_Position since we do not require gapless geometry\n\
             void main (void)\n\
             {\n",
        );

        match self.case {
            IdentityGeometryCaseType::Triangles => {
                buf.push_str(
                    "    vec3 weights = vec3(pow(gl_TessCoord.x, 1.3), pow(gl_TessCoord.y, 1.3), pow(gl_TessCoord.z, 1.3));\n\
                     \x20   vec3 cweights = gl_TessCoord;\n\
                     \x20   gl_Position = vec4(weights.x * gl_in[0].gl_Position.xyz + weights.y * gl_in[1].gl_Position.xyz + weights.z * gl_in[2].gl_Position.xyz, 1.0);\n\
                     \x20   ",
                );
                buf.push_str(color_output_name);
                buf.push_str(" = cweights.x * v_patch_color[0] + cweights.y * v_patch_color[1] + cweights.z * v_patch_color[2];\n");
            }
            IdentityGeometryCaseType::Quads | IdentityGeometryCaseType::Isolines => {
                buf.push_str(
                    "    vec2 normalizedCoord = (gl_TessCoord.xy * 2.0 - vec2(1.0));\n\
                     \x20   vec2 normalizedWeights = normalizedCoord * (vec2(1.0) - 0.3 * cos(normalizedCoord.yx * 1.57));\n\
                     \x20   vec2 weights = normalizedWeights * 0.5 + vec2(0.5);\n\
                     \x20   vec2 cweights = gl_TessCoord.xy;\n\
                     \x20   gl_Position = mix(mix(gl_in[0].gl_Position, gl_in[1].gl_Position, weights.y), mix(gl_in[2].gl_Position, gl_in[3].gl_Position, weights.y), weights.x);\n\
                     \x20   ",
                );
                buf.push_str(color_output_name);
                buf.push_str(" = mix(mix(v_patch_color[0], v_patch_color[1], cweights.y), mix(v_patch_color[2], v_patch_color[3], cweights.y), cweights.x);\n");
            }
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn get_geometry_source(&self, context: &Context) -> String {
        let isolines = self.case == IdentityGeometryCaseType::Isolines;
        let geometry_input_primitive = if isolines { "lines" } else { "triangles" };
        let geometry_output_primitive = if isolines { "line_strip" } else { "triangle_strip" };
        let num_emit_vertices = if isolines { 2 } else { 3 };

        let buf = format!(
            "${{VERSION_DECL}}\n\
             ${{EXTENSION_GEOMETRY_SHADER}}\
             layout({geometry_input_primitive}) in;\n\
             layout({geometry_output_primitive}, max_vertices={num_emit_vertices}) out;\n\
             \n\
             in highp vec4 v_evaluated_color[];\n\
             out highp vec4 v_fragment_color;\n\
             \n\
             void main (void)\n\
             {{\n\
             \x20   for (int ndx = 0; ndx < gl_in.length(); ++ndx)\n\
             \x20   {{\n\
             \x20       gl_Position = gl_in[ndx].gl_Position;\n\
             \x20       v_fragment_color = v_evaluated_color[ndx];\n\
             \x20       EmitVertex();\n\
             \x20   }}\n\
             }}\n"
        );

        specialize_shader(&buf, context)
    }
}

impl TestCase for IdentityGeometryShaderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_identity_requirements(context, Self::RENDER_SIZE)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let inner_tessellation_level = 14.0f32;
        let outer_tessellation_level = 14.0f32;
        let render_size = Self::RENDER_SIZE;

        log::info!(
            "Testing tessellating shader program output does not change when a passthrough geometry shader is attached.\n\
             Rendering two images, first with and second without a geometry shader. Expecting similar results.\n\
             Using additive blending to detect overlap.\n"
        );

        // Resources
        let patch_buffer_data: [[f32; 4]; 4] = [
            [-0.9, -0.9, 0.0, 1.0],
            [-0.9, 0.9, 0.0, 1.0],
            [0.9, -0.9, 0.0, 1.0],
            [0.9, 0.9, 0.0, 1.0],
        ];
        let patch_buffer = Buffer::new(gl);
        // SAFETY: a buffer this case generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, patch_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&patch_buffer_data) as GLsizeiptr,
                patch_buffer_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buffer")?;

        let mut result_with_geometry = Surface::new(render_size, render_size);
        let mut result_without_geometry = Surface::new(render_size, render_size);

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, render_size, render_size);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
        }
        glu::expect_no_error(gl, "set viewport")?;

        set_additive_blending(gl)?;

        log::info!("Tessellation level: inner {inner_tessellation_level}, outer {outer_tessellation_level}");

        // render with and without geometry shader
        for contains_geometry_shader in [true, false] {
            log::info!(
                "{}",
                if contains_geometry_shader {
                    "Render with geometry shader"
                } else {
                    "Render without geometry shader"
                }
            );

            let mut sources = ProgramSources::default()
                .with(ShaderType::Vertex, identity_vertex_source(context))
                .with(ShaderType::Fragment, identity_fragment_source(context))
                .with(ShaderType::TessControl, self.get_tessellation_control_source(context))
                .with(
                    ShaderType::TessEvaluation,
                    self.get_tessellation_evaluation_source(context, contains_geometry_shader),
                );

            if contains_geometry_shader {
                sources = sources.with(ShaderType::Geometry, self.get_geometry_source(context));
            }

            let program = ShaderProgram::new(gl, &sources);
            let vao = VertexArray::new(gl);
            // SAFETY: NUL-terminated names against the program just built.
            let (pos_location, inner_tessellation_loc, outer_tessellation_loc) = unsafe {
                (
                    gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                    gl.get_uniform_location(program.program(), c"u_innerTessellationLevel".as_ptr()),
                    gl.get_uniform_location(program.program(), c"u_outerTessellationLevel".as_ptr()),
                )
            };

            if !program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            if pos_location == -1 {
                return Err(TestError::Fail("a_position location was -1".to_string()));
            }
            if outer_tessellation_loc == -1 {
                return Err(TestError::Fail("u_outerTessellationLevel location was -1".to_string()));
            }

            // SAFETY: names this case generated.
            unsafe {
                gl.bind_vertex_array(vao.get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, patch_buffer.get());
                gl.vertex_attrib_pointer(pos_location as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(pos_location as u32);
            }
            glu::expect_no_error(gl, "setup attribs")?;

            // SAFETY: a program just built; \note upstream's `== -1` test on the inner level is kept as written.
            unsafe {
                gl.use_program(program.program());
                gl.uniform_1f(outer_tessellation_loc, outer_tessellation_level);

                if inner_tessellation_loc == -1 {
                    gl.uniform_1f(inner_tessellation_loc, inner_tessellation_level);
                }
            }
            glu::expect_no_error(gl, "use program")?;

            // SAFETY: plain state setting.
            unsafe {
                gl.patch_parameteri(
                    glw::GL_PATCH_VERTICES,
                    if self.case == IdentityGeometryCaseType::Triangles {
                        3
                    } else {
                        4
                    },
                )
            };
            glu::expect_no_error(gl, "set patch param")?;

            // SAFETY: as above.
            unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
            glu::expect_no_error(gl, "clear")?;

            // SAFETY: a four-vertex patch draw.
            unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 4) };
            glu::expect_no_error(gl, "draw patches")?;

            let target = if contains_geometry_shader {
                &mut result_with_geometry
            } else {
                &mut result_without_geometry
            };
            glu::read_pixels(&context.render_context, 0, 0, &mut target.get_access())?;
        }

        if int_threshold_position_deviation_error_threshold_compare(
            &result_without_geometry,
            &result_with_geometry,
            [8, 8, 8, 255],
            IVec3::from_array([1, 1, 0]),
            true,
            0,
        ) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum IdentityTessellationCaseType {
    Triangles,
    Isolines,
}

/// `IdentityTessellationShaderCase`
struct IdentityTessellationShaderCase {
    name: &'static str,
    case: IdentityTessellationCaseType,
}

impl IdentityTessellationShaderCase {
    const RENDER_SIZE: i32 = 256;

    fn get_tessellation_control_source(&self, context: &Context) -> String {
        let triangles = self.case == IdentityTessellationCaseType::Triangles;
        let mut buf = format!(
            "${{VERSION_DECL}}\n\
             ${{EXTENSION_TESSELATION_SHADER}}\
             layout(vertices = {}) out;\n\
             \n\
             in highp vec4 v_vertex_color[];\n\
             out highp vec4 v_control_color[];\n\
             \n\
             void main (void)\n\
             {{\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
             \x20   v_control_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];\n\
             \n",
            if triangles { 3 } else { 2 }
        );

        if triangles {
            buf.push_str(
                "    gl_TessLevelOuter[0] = 1.0;\n\
                 \x20   gl_TessLevelOuter[1] = 1.0;\n\
                 \x20   gl_TessLevelOuter[2] = 1.0;\n\
                 \x20   gl_TessLevelInner[0] = 1.0;\n",
            );
        } else {
            buf.push_str(
                "    gl_TessLevelOuter[0] = 1.0;\n\
                 \x20   gl_TessLevelOuter[1] = 1.0;\n",
            );
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn get_tessellation_evaluation_source(&self, context: &Context) -> String {
        let triangles = self.case == IdentityTessellationCaseType::Triangles;
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_TESSELATION_SHADER}layout(");
        buf.push_str(if triangles { "triangles" } else { "isolines" });
        buf.push_str(
            ") in;\n\
             \n\
             in highp vec4 v_control_color[];\n\
             out highp vec4 v_evaluated_color;\n\
             \n\
             // note: No need to use precise gl_Position since we do not require gapless geometry\n\
             void main (void)\n\
             {\n",
        );

        if triangles {
            buf.push_str(
                "    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;\n\
                 \x20   v_evaluated_color = gl_TessCoord.x * v_control_color[0] + gl_TessCoord.y * v_control_color[1] + gl_TessCoord.z * v_control_color[2];\n",
            );
        } else {
            buf.push_str(
                "    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);\n\
                 \x20   v_evaluated_color = mix(v_control_color[0], v_control_color[1], gl_TessCoord.x);\n",
            );
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn get_geometry_source(&self, context: &Context, tessellation_active: bool) -> String {
        let triangles = self.case == IdentityTessellationCaseType::Triangles;
        let color_source_name = if tessellation_active {
            "v_evaluated_color"
        } else {
            "v_vertex_color"
        };
        let geometry_input_primitive = if triangles { "triangles" } else { "lines" };
        let geometry_output_primitive = if triangles { "triangle_strip" } else { "line_strip" };
        let num_emit_vertices = if triangles { 8 } else { 11 };

        let mut buf = format!(
            "${{VERSION_DECL}}\n\
             ${{EXTENSION_GEOMETRY_SHADER}}\
             layout({geometry_input_primitive}) in;\n\
             layout({geometry_output_primitive}, max_vertices={num_emit_vertices}) out;\n\
             \n\
             in highp vec4 {color_source_name}[];\n\
             out highp vec4 v_fragment_color;\n\
             \n\
             void main (void)\n\
             {{\n"
        );

        if triangles {
            buf.push_str(&format!(
                "    vec4 centerPos = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0f;\n\
                 \n\
                 \x20   for (int ndx = 0; ndx < 4; ++ndx)\n\
                 \x20   {{\n\
                 \x20       gl_Position = centerPos + (centerPos - gl_in[ndx % 3].gl_Position);\n\
                 \x20       v_fragment_color = {color_source_name}[ndx % 3];\n\
                 \x20       EmitVertex();\n\
                 \n\
                 \x20       gl_Position = centerPos + 0.7 * (centerPos - gl_in[ndx % 3].gl_Position);\n\
                 \x20       v_fragment_color = {color_source_name}[ndx % 3];\n\
                 \x20       EmitVertex();\n\
                 \x20   }}\n"
            ));
        } else {
            buf.push_str(&format!(
                "    vec4 mdir = vec4(gl_in[0].gl_Position.y - gl_in[1].gl_Position.y, gl_in[1].gl_Position.x - gl_in[0].gl_Position.x, 0.0, 0.0);\n\
                 \x20   for (int i = 0; i <= 10; ++i)\n\
                 \x20   {{\n\
                 \x20       float xweight = cos(float(i) / 10.0 * 6.28) * 0.5 + 0.5;\n\
                 \x20       float mweight = sin(float(i) / 10.0 * 6.28) * 0.1 + 0.1;\n\
                 \x20       gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, xweight) + mweight * mdir;\n\
                 \x20       v_fragment_color = mix({color_source_name}[0], {color_source_name}[1], xweight);\n\
                 \x20       EmitVertex();\n\
                 \x20   }}\n"
            ));
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }
}

impl TestCase for IdentityTessellationShaderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_identity_requirements(context, Self::RENDER_SIZE)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_size = Self::RENDER_SIZE;
        let triangles = self.case == IdentityTessellationCaseType::Triangles;
        let num_primitive_vertices = if triangles { 3 } else { 2 };

        log::info!(
            "Testing geometry shading shader program output does not change when a passthrough tessellation shader is attached.\n\
             Rendering two images, first with and second without a tessellation shader. Expecting similar results.\n\
             Using additive blending to detect overlap.\n"
        );

        // Resources
        let point_data: [[f32; 4]; 3] = [[-0.4, 0.4, 0.0, 1.0], [0.0, -0.5, 0.0, 1.0], [0.4, 0.4, 0.0, 1.0]];
        let data_buffer = Buffer::new(gl);
        // SAFETY: a buffer this case generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, data_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&point_data) as GLsizeiptr,
                point_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buffer")?;

        let mut result_with_tessellation = Surface::new(render_size, render_size);
        let mut result_without_tessellation = Surface::new(render_size, render_size);

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, render_size, render_size);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
        }
        glu::expect_no_error(gl, "set viewport")?;

        set_additive_blending(gl)?;

        // render with and without tessellation shader
        for contains_tessellation_shaders in [true, false] {
            log::info!(
                "{}",
                if contains_tessellation_shaders {
                    "Render with tessellation shader"
                } else {
                    "Render without tessellation shader"
                }
            );

            let mut sources = ProgramSources::default()
                .with(ShaderType::Vertex, identity_vertex_source(context))
                .with(ShaderType::Fragment, identity_fragment_source(context))
                .with(
                    ShaderType::Geometry,
                    self.get_geometry_source(context, contains_tessellation_shaders),
                );

            if contains_tessellation_shaders {
                sources = sources
                    .with(ShaderType::TessControl, self.get_tessellation_control_source(context))
                    .with(
                        ShaderType::TessEvaluation,
                        self.get_tessellation_evaluation_source(context),
                    );
            }

            let program = ShaderProgram::new(gl, &sources);
            let vao = VertexArray::new(gl);
            // SAFETY: a NUL-terminated name against the program just built.
            let pos_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };

            if !program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            if pos_location == -1 {
                return Err(TestError::Fail("a_position location was -1".to_string()));
            }

            // SAFETY: names this case generated.
            unsafe {
                gl.bind_vertex_array(vao.get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, data_buffer.get());
                gl.vertex_attrib_pointer(pos_location as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(pos_location as u32);
            }
            glu::expect_no_error(gl, "setup attribs")?;

            // SAFETY: a program just built.
            unsafe { gl.use_program(program.program()) };
            glu::expect_no_error(gl, "use program")?;

            // SAFETY: plain state setting.
            unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
            glu::expect_no_error(gl, "clear")?;

            if contains_tessellation_shaders {
                // SAFETY: plain state setting and a patch draw.
                unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, num_primitive_vertices) };
                glu::expect_no_error(gl, "set patch param")?;

                // SAFETY: as above.
                unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, num_primitive_vertices) };
                glu::expect_no_error(gl, "draw patches")?;
            } else {
                // SAFETY: a plain draw.
                unsafe {
                    gl.draw_arrays(
                        if triangles { glw::GL_TRIANGLES } else { glw::GL_LINES },
                        0,
                        num_primitive_vertices,
                    )
                };
                glu::expect_no_error(gl, "draw primitives")?;
            }

            let target = if contains_tessellation_shaders {
                &mut result_with_tessellation
            } else {
                &mut result_without_tessellation
            };
            glu::read_pixels(&context.render_context, 0, 0, &mut target.get_access())?;
        }

        // compare
        let image_ok = if context.render_target().num_samples > 1 {
            fuzzy_compare_ok(
                &result_without_tessellation.get_const_access(),
                &result_with_tessellation.get_const_access(),
                0.03,
            )
            .unwrap_or(false)
        } else {
            // 3x3 search kernel; fragments may end up over the viewport, just ignore them
            int_threshold_position_deviation_error_threshold_compare(
                &result_without_tessellation,
                &result_with_tessellation,
                [8, 8, 8, 255],
                IVec3::from_array([1, 1, 0]),
                true,
                0,
            )
        };

        if image_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

// ---------------------------------------------------------------------------------------
// GridRenderCase
// ---------------------------------------------------------------------------------------

const GRID_FLAG_TESSELLATION_MAX_SPEC: i32 = 0x0001;
const GRID_FLAG_TESSELLATION_MAX_IMPLEMENTATION: i32 = 0x0002;
const GRID_FLAG_GEOMETRY_MAX_SPEC: i32 = 0x0004;
const GRID_FLAG_GEOMETRY_MAX_IMPLEMENTATION: i32 = 0x0008;
const GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_SPEC: i32 = 0x0010;
const GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_IMPLEMENTATION: i32 = 0x0020;

const GRID_FLAG_GEOMETRY_SCATTER_INSTANCES: i32 = 0x0040;
const GRID_FLAG_GEOMETRY_SCATTER_PRIMITIVES: i32 = 0x0080;
/// If set, geometry shader outputs separate grid cells and not continuous slices.
const GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES: i32 = 0x0100;
const GRID_FLAG_GEOMETRY_SCATTER_LAYERS: i32 = 0x0200;

/// Allow draw command to set `GL_OUT_OF_MEMORY`.
const GRID_FLAG_ALLOW_OUT_OF_MEMORY: i32 = 0x0400;

const GRID_RENDER_SIZE: i32 = 256;

/// `GridRenderCase`
struct GridRenderCase {
    name: &'static str,
    description: &'static str,
    flags: i32,
}

impl GridRenderCase {
    fn new(name: &'static str, description: &'static str, flags: i32) -> Self {
        debug_assert!(
            flags & GRID_FLAG_TESSELLATION_MAX_SPEC == 0 || flags & GRID_FLAG_TESSELLATION_MAX_IMPLEMENTATION == 0
        );
        debug_assert!(flags & GRID_FLAG_GEOMETRY_MAX_SPEC == 0 || flags & GRID_FLAG_GEOMETRY_MAX_IMPLEMENTATION == 0);
        debug_assert!(
            flags & GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_SPEC == 0
                || flags & GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_IMPLEMENTATION == 0
        );
        debug_assert!(
            (flags & (GRID_FLAG_GEOMETRY_SCATTER_PRIMITIVES | GRID_FLAG_GEOMETRY_SCATTER_LAYERS) != 0)
                == (flags & GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES != 0)
        );

        Self {
            name,
            description,
            flags,
        }
    }

    fn num_layers(&self) -> i32 {
        if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS != 0 {
            8
        } else {
            1
        }
    }

    fn get_vertex_source(context: &Context) -> String {
        specialize_shader(POSITION_VERTEX_SHADER, context)
    }

    fn get_fragment_source(context: &Context) -> String {
        let source = "${VERSION_DECL}\n\
            flat in mediump vec4 v_color;\n\
            layout(location = 0) out mediump vec4 fragColor;\n\
            void main (void)\n\
            {\n\
            \x20   fragColor = v_color;\n\
            }\n";

        specialize_shader(source, context)
    }

    fn get_tessellation_control_source(context: &Context, tess_level: i32) -> String {
        let source = format!(
            "${{VERSION_DECL}}\n\
             ${{EXTENSION_TESSELATION_SHADER}}\
             layout(vertices=1) out;\n\
             \n\
             void main()\n\
             {{\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
             \x20   gl_TessLevelOuter[0] = {tess_level}.0;\n\
             \x20   gl_TessLevelOuter[1] = {tess_level}.0;\n\
             \x20   gl_TessLevelOuter[2] = {tess_level}.0;\n\
             \x20   gl_TessLevelOuter[3] = {tess_level}.0;\n\
             \x20   gl_TessLevelInner[0] = {tess_level}.0;\n\
             \x20   gl_TessLevelInner[1] = {tess_level}.0;\n\
             }}\n"
        );

        specialize_shader(&source, context)
    }

    fn get_tessellation_evaluation_source(&self, context: &Context, tess_level: i32) -> String {
        let mut buf = String::from(
            "${VERSION_DECL}\n\
             ${EXTENSION_TESSELATION_SHADER}\
             layout(quads) in;\n\
             \n\
             out mediump ivec2 v_tessellationGridPosition;\n\
             \n\
             // note: No need to use precise gl_Position since position does not depend on order\n\
             void main (void)\n\
             {\n",
        );

        if self.flags
            & (GRID_FLAG_GEOMETRY_SCATTER_INSTANCES
                | GRID_FLAG_GEOMETRY_SCATTER_PRIMITIVES
                | GRID_FLAG_GEOMETRY_SCATTER_LAYERS)
            != 0
        {
            buf.push_str(
                "    // Cover only a small area in a corner. The area will be expanded in geometry shader to cover whole viewport\n\
                 \x20   gl_Position = vec4(gl_TessCoord.x * 0.3 - 1.0, gl_TessCoord.y * 0.3 - 1.0, 0.0, 1.0);\n",
            );
        } else {
            buf.push_str(
                "    // Fill the whole viewport\n\
                 \x20   gl_Position = vec4(gl_TessCoord.x * 2.0 - 1.0, gl_TessCoord.y * 2.0 - 1.0, 0.0, 1.0);\n",
            );
        }

        buf.push_str(&format!(
            "    // Calculate position in tessellation grid\n\
             \x20   v_tessellationGridPosition = ivec2(round(gl_TessCoord.xy * float({tess_level})));\n\
             }}\n"
        ));

        specialize_shader(&buf, context)
    }

    fn get_geometry_shader_source(
        &self,
        context: &Context,
        num_primitives: i32,
        num_instances: i32,
        tess_level: i32,
    ) -> String {
        let num_layers = self.num_layers();
        let max_vertices = if self.flags & GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES != 0 {
            4 * num_primitives
        } else {
            num_primitives + 2
        };

        let mut buf = format!(
            "${{VERSION_DECL}}\n\
             ${{EXTENSION_GEOMETRY_SHADER}}\
             layout(triangles, invocations={num_instances}) in;\n\
             layout(triangle_strip, max_vertices={max_vertices}) out;\n\
             \n\
             in mediump ivec2 v_tessellationGridPosition[];\n\
             flat out highp vec4 v_color;\n\
             \n\
             void main ()\n\
             {{\n\
             \x20   const float equalThreshold = 0.001;\n\
             \x20   const float gapOffset = 0.0001; // subdivision performed by the geometry shader might produce gaps. Fill potential gaps by enlarging the output slice a little.\n\
             \n\
             \x20   // Input triangle is generated from an axis-aligned rectangle by splitting it in half\n\
             \x20   // Original rectangle can be found by finding the bounding AABB of the triangle\n\
             \x20   vec4 aabb = vec4(min(gl_in[0].gl_Position.x, min(gl_in[1].gl_Position.x, gl_in[2].gl_Position.x)),\n\
             \x20                    min(gl_in[0].gl_Position.y, min(gl_in[1].gl_Position.y, gl_in[2].gl_Position.y)),\n\
             \x20                    max(gl_in[0].gl_Position.x, max(gl_in[1].gl_Position.x, gl_in[2].gl_Position.x)),\n\
             \x20                    max(gl_in[0].gl_Position.y, max(gl_in[1].gl_Position.y, gl_in[2].gl_Position.y)));\n\
             \n\
             \x20   // Location in tessellation grid\n\
             \x20   ivec2 gridPosition = ivec2(min(v_tessellationGridPosition[0], min(v_tessellationGridPosition[1], v_tessellationGridPosition[2])));\n\
             \n\
             \x20   // Which triangle of the two that split the grid cell\n\
             \x20   int numVerticesOnBottomEdge = 0;\n\
             \x20   for (int ndx = 0; ndx < 3; ++ndx)\n\
             \x20       if (abs(gl_in[ndx].gl_Position.y - aabb.w) < equalThreshold)\n\
             \x20           ++numVerticesOnBottomEdge;\n\
             \x20   bool isBottomTriangle = numVerticesOnBottomEdge == 2;\n\
             \n"
        );

        let emit_corner = |position: &str, layer: bool| -> String {
            let mut s = format!("        gl_Position = vec4({position}, 0.0, 1.0);\n        v_color = outputColor;\n");
            if layer {
                s.push_str(&format!(
                    "        gl_Layer = ((baseLayer + ndx) * 11) % {num_layers};\n"
                ));
            }
            s.push_str("        EmitVertex();\n");
            s
        };

        if self.flags & GRID_FLAG_GEOMETRY_SCATTER_PRIMITIVES != 0 {
            // scatter primitives
            buf.push_str(&format!(
                "    // Draw grid cells\n\
                 \x20   int inputTriangleNdx = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));\n\
                 \x20   for (int ndx = 0; ndx < {num_primitives}; ++ndx)\n\
                 \x20   {{\n\
                 \x20       ivec2 dstGridSize = ivec2({tess_level} * {num_primitives}, 2 * {tess_level} * {num_instances});\n\
                 \x20       ivec2 dstGridNdx = ivec2({tess_level} * ndx + gridPosition.x, {tess_level} * inputTriangleNdx + 2 * gridPosition.y + ndx * 127) % dstGridSize;\n\
                 \x20       vec4 dstArea;\n\
                 \x20       dstArea.x = float(dstGridNdx.x) / float(dstGridSize.x) * 2.0 - 1.0 - gapOffset;\n\
                 \x20       dstArea.y = float(dstGridNdx.y) / float(dstGridSize.y) * 2.0 - 1.0 - gapOffset;\n\
                 \x20       dstArea.z = float(dstGridNdx.x+1) / float(dstGridSize.x) * 2.0 - 1.0 + gapOffset;\n\
                 \x20       dstArea.w = float(dstGridNdx.y+1) / float(dstGridSize.y) * 2.0 - 1.0 + gapOffset;\n\
                 \n\
                 \x20       vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 outputColor = (((dstGridNdx.y + dstGridNdx.x) % 2) == 0) ? (green) : (yellow);\n\
                 \n"
            ));
            buf.push_str(&emit_corner("dstArea.x, dstArea.y", false));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.x, dstArea.w", false));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.z, dstArea.y", false));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.z, dstArea.w", false));
            buf.push_str("        EndPrimitive();\n    }\n");
        } else if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS != 0 {
            // Number of subrectangle instances = num layers
            debug_assert!(num_layers == num_instances * 2);

            buf.push_str(&format!(
                "    // Draw grid cells, send each primitive to a separate layer\n\
                 \x20   int baseLayer = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));\n\
                 \x20   for (int ndx = 0; ndx < {num_primitives}; ++ndx)\n\
                 \x20   {{\n\
                 \x20       ivec2 dstGridSize = ivec2({tess_level} * {num_primitives}, {tess_level});\n\
                 \x20       ivec2 dstGridNdx = ivec2((gridPosition.x * {num_primitives} * 7 + ndx)*13, (gridPosition.y * 127 + ndx) * 19) % dstGridSize;\n\
                 \x20       vec4 dstArea;\n\
                 \x20       dstArea.x = float(dstGridNdx.x) / float(dstGridSize.x) * 2.0 - 1.0 - gapOffset;\n\
                 \x20       dstArea.y = float(dstGridNdx.y) / float(dstGridSize.y) * 2.0 - 1.0 - gapOffset;\n\
                 \x20       dstArea.z = float(dstGridNdx.x+1) / float(dstGridSize.x) * 2.0 - 1.0 + gapOffset;\n\
                 \x20       dstArea.w = float(dstGridNdx.y+1) / float(dstGridSize.y) * 2.0 - 1.0 + gapOffset;\n\
                 \n\
                 \x20       vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 outputColor = (((dstGridNdx.y + dstGridNdx.x) % 2) == 0) ? (green) : (yellow);\n\
                 \n"
            ));
            buf.push_str(&emit_corner("dstArea.x, dstArea.y", true));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.x, dstArea.w", true));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.z, dstArea.y", true));
            buf.push('\n');
            buf.push_str(&emit_corner("dstArea.z, dstArea.w", true));
            buf.push_str("        EndPrimitive();\n    }\n");
        } else {
            if self.flags & GRID_FLAG_GEOMETRY_SCATTER_INSTANCES != 0 {
                buf.push_str(&format!(
                    "    // Scatter slices\n\
                     \x20   int inputTriangleNdx = gl_InvocationID * 2 + ((isBottomTriangle) ? (1) : (0));\n\
                     \x20   ivec2 srcSliceNdx = ivec2(gridPosition.x, gridPosition.y * {} + inputTriangleNdx);\n\
                     \x20   ivec2 dstSliceNdx = ivec2(7 * srcSliceNdx.x, 127 * srcSliceNdx.y) % ivec2({tess_level}, {tess_level} * {});\n\
                     \n\
                     \x20   // Draw slice to the dstSlice slot\n\
                     \x20   vec4 outputSliceArea;\n\
                     \x20   outputSliceArea.x = float(dstSliceNdx.x) / float({tess_level}) * 2.0 - 1.0 - gapOffset;\n\
                     \x20   outputSliceArea.y = float(dstSliceNdx.y) / float({}) * 2.0 - 1.0 - gapOffset;\n\
                     \x20   outputSliceArea.z = float(dstSliceNdx.x+1) / float({tess_level}) * 2.0 - 1.0 + gapOffset;\n\
                     \x20   outputSliceArea.w = float(dstSliceNdx.y+1) / float({}) * 2.0 - 1.0 + gapOffset;\n",
                    num_instances * 2,
                    num_instances * 2,
                    tess_level * num_instances * 2,
                    tess_level * num_instances * 2
                ));
            } else {
                buf.push_str(&format!(
                    "    // Fill the input area with slices\n\
                     \x20   // Upper triangle produces slices only to the upper half of the quad and vice-versa\n\
                     \x20   float triangleOffset = (isBottomTriangle) ? ((aabb.w + aabb.y) / 2.0) : (aabb.y);\n\
                     \x20   // Each slice is a invocation\n\
                     \x20   float sliceHeight = (aabb.w - aabb.y) / float(2 * {num_instances});\n\
                     \x20   float invocationOffset = float(gl_InvocationID) * sliceHeight;\n\
                     \n\
                     \x20   vec4 outputSliceArea;\n\
                     \x20   outputSliceArea.x = aabb.x - gapOffset;\n\
                     \x20   outputSliceArea.y = triangleOffset + invocationOffset - gapOffset;\n\
                     \x20   outputSliceArea.z = aabb.z + gapOffset;\n\
                     \x20   outputSliceArea.w = triangleOffset + invocationOffset + sliceHeight + gapOffset;\n"
                ));
            }

            buf.push_str(&format!(
                "\n\
                 \x20   // Draw slice\n\
                 \x20   for (int ndx = 0; ndx < {}; ++ndx)\n\
                 \x20   {{\n\
                 \x20       vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
                 \x20       vec4 outputColor = (((gl_InvocationID + ndx) % 2) == 0) ? (green) : (yellow);\n\
                 \x20       float xpos = mix(outputSliceArea.x, outputSliceArea.z, float(ndx) / float({}));\n\
                 \n\
                 \x20       gl_Position = vec4(xpos, outputSliceArea.y, 0.0, 1.0);\n\
                 \x20       v_color = outputColor;\n\
                 \x20       EmitVertex();\n\
                 \n\
                 \x20       gl_Position = vec4(xpos, outputSliceArea.w, 0.0, 1.0);\n\
                 \x20       v_color = outputColor;\n\
                 \x20       EmitVertex();\n\
                 \x20   }}\n",
                (num_primitives + 2) / 2,
                num_primitives / 2
            ));
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    /// `verifyResultLayer`
    fn verify_result_layer(layer_ndx: i32, image: &Surface) -> bool {
        let mut found_error = false;

        log::info!("Verifying output layer {layer_ndx}");

        for y in 0..image.get_height() {
            for x in 0..image.get_width() {
                let threshold = 8;
                let color = image.get_pixel(x, y);

                // Color must be a linear combination of green and yellow
                if color.get_green() < 255 - threshold || color.get_blue() > threshold {
                    found_error = true;
                }
            }
        }

        if !found_error {
            log::info!("Image valid.");
            true
        } else {
            log::warn!("Image verification failed, found invalid pixels.");
            false
        }
    }
}

impl TestCase for GridRenderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports(3, 2)
            && (!context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
                || !context.context_info.is_extension_supported("GL_EXT_geometry_shader"))
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader and GL_EXT_geometry_shader extensions".to_string(),
            ));
        }

        if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS == 0 {
            let render_target = context.render_target();
            if render_target.width < GRID_RENDER_SIZE || render_target.height < GRID_RENDER_SIZE {
                return Err(TestError::NotSupported(format!(
                    "Test requires {GRID_RENDER_SIZE}x{GRID_RENDER_SIZE} or larger render target."
                )));
            }
        }
        Ok(())
    }

    /// `init`, `iterate` and `renderTo`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let num_layers = self.num_layers();
        let get_integer = |pname: glw::GLenum| -> i32 {
            let mut value = -1;
            // SAFETY: one integer of output for a single-value query.
            unsafe { gl.get_integerv(pname, &mut value) };
            value
        };

        log::info!(
            "Testing tessellation and geometry shaders that output a large number of primitives.\n{}",
            self.description
        );

        // Render target
        let texture = Texture::new(gl);
        if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS != 0 {
            log::info!("Rendering to 2d texture array, numLayers = {num_layers}");

            // SAFETY: a texture this case generated.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.get());
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    1,
                    glw::GL_RGBA8,
                    GRID_RENDER_SIZE,
                    GRID_RENDER_SIZE,
                    num_layers,
                );

                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_MIN_FILTER,
                    glw::GL_NEAREST as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_MAG_FILTER,
                    glw::GL_NEAREST as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_WRAP_S,
                    glw::GL_CLAMP_TO_EDGE as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D_ARRAY,
                    glw::GL_TEXTURE_WRAP_T,
                    glw::GL_CLAMP_TO_EDGE as i32,
                );
            }

            glu::expect_no_error(gl, "gen texture")?;
        }

        // Gen program
        let mut sources = ProgramSources::default()
            .with(ShaderType::Vertex, Self::get_vertex_source(context))
            .with(ShaderType::Fragment, Self::get_fragment_source(context));

        // Tessellation limits
        let tess_gen_level = if self.flags & GRID_FLAG_TESSELLATION_MAX_IMPLEMENTATION != 0 {
            let level = get_integer(glw::GL_MAX_TESS_GEN_LEVEL);
            glu::expect_no_error(gl, "query tessellation limits")?;
            level
        } else if self.flags & GRID_FLAG_TESSELLATION_MAX_SPEC != 0 {
            64
        } else {
            5
        };

        log::info!(
            "Tessellation level: {tess_gen_level}, mode = quad.\n\tEach input patch produces {} ({} triangles)\n",
            tess_gen_level * tess_gen_level,
            tess_gen_level * tess_gen_level * 2
        );

        sources = sources
            .with(
                ShaderType::TessControl,
                Self::get_tessellation_control_source(context, tess_gen_level),
            )
            .with(
                ShaderType::TessEvaluation,
                self.get_tessellation_evaluation_source(context, tess_gen_level),
            );

        // Geometry limits
        {
            let geometry_output_components;
            let geometry_output_vertices;
            let geometry_total_output_components;
            let geometry_shader_invocations;
            let mut log_geometry_limits = false;
            let mut log_invocation_limits = false;

            if self.flags & GRID_FLAG_GEOMETRY_MAX_IMPLEMENTATION != 0 {
                log::info!("Using implementation maximum geometry shader output limits.");

                geometry_output_components = get_integer(glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS);
                geometry_output_vertices = get_integer(glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES);
                geometry_total_output_components = get_integer(glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS);
                glu::expect_no_error(gl, "query geometry limits")?;

                log_geometry_limits = true;
            } else if self.flags & GRID_FLAG_GEOMETRY_MAX_SPEC != 0 {
                log::info!("Using geometry shader extension minimum maximum output limits.");

                geometry_output_components = 128;
                geometry_output_vertices = 256;
                geometry_total_output_components = 1024;
                log_geometry_limits = true;
            } else {
                geometry_output_components = 128;
                geometry_output_vertices = 16;
                geometry_total_output_components = 1024;
            }

            if self.flags & GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_IMPLEMENTATION != 0 {
                geometry_shader_invocations = get_integer(glw::GL_MAX_GEOMETRY_SHADER_INVOCATIONS);
                glu::expect_no_error(gl, "query geometry invocation limits")?;

                log_invocation_limits = true;
            } else if self.flags & GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_SPEC != 0 {
                geometry_shader_invocations = 32;
                log_invocation_limits = true;
            } else {
                geometry_shader_invocations = 4;
            }

            if log_geometry_limits || log_invocation_limits {
                let mut msg = String::from("Geometry shader, targeting following limits:\n");

                if log_geometry_limits {
                    msg.push_str(&format!(
                        "\tGL_MAX_GEOMETRY_OUTPUT_COMPONENTS = {geometry_output_components}\n\tGL_MAX_GEOMETRY_OUTPUT_VERTICES = {geometry_output_vertices}\n\tGL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = {geometry_total_output_components}\n"
                    ));
                }

                if log_invocation_limits {
                    msg.push_str(&format!(
                        "\tGL_MAX_GEOMETRY_SHADER_INVOCATIONS = {geometry_shader_invocations}"
                    ));
                }

                log::info!("{msg}");
            }

            let separate_primitives = self.flags & GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES != 0;
            let num_components_per_vertex = 8; // vec4 pos, vec4 color
            let num_vertices_per_invocation;
            let num_primitives_per_invocation;

            if separate_primitives {
                let num_component_limit = geometry_total_output_components / (4 * num_components_per_vertex);
                let num_output_limit = geometry_output_vertices / 4;

                num_primitives_per_invocation = num_component_limit.min(num_output_limit);
                num_vertices_per_invocation = num_primitives_per_invocation * 4;
            } else {
                // If FLAG_GEOMETRY_SEPARATE_PRIMITIVES is not set, geometry shader fills a rectangle area in slices.
                // Each slice is a triangle strip and is generated by a single shader invocation.
                // One slice with 4 segment ends (nodes) and 3 segments:
                //    .__.__.__.
                //    |\ |\ |\ |
                //    |_\|_\|_\|
                let num_slice_nodes_component_limit =
                    geometry_total_output_components / (2 * num_components_per_vertex); // each node 2 vertices
                let num_slice_nodes_output_limit = geometry_output_vertices / 2; // each node 2 vertices
                let num_slice_nodes = num_slice_nodes_component_limit.min(num_slice_nodes_output_limit);

                num_vertices_per_invocation = num_slice_nodes * 2;
                num_primitives_per_invocation = (num_slice_nodes - 1) * 2;
            }

            let geometry_vertices_per_primitive = num_vertices_per_invocation * geometry_shader_invocations;
            let geometry_primitives_out_per_primitive = num_primitives_per_invocation * geometry_shader_invocations;

            log::info!(
                "Geometry shader:\n\tTotal output vertex count per invocation: {num_vertices_per_invocation}\n\tTotal output primitive count per invocation: {num_primitives_per_invocation}\n\tNumber of invocations per primitive: {geometry_shader_invocations}\n\tTotal output vertex count per input primitive: {geometry_vertices_per_primitive}\n\tTotal output primitive count per input primitive: {geometry_primitives_out_per_primitive}\n"
            );

            sources = sources.with(
                ShaderType::Geometry,
                self.get_geometry_shader_source(
                    context,
                    num_primitives_per_invocation,
                    geometry_shader_invocations,
                    tess_gen_level,
                ),
            );

            log::info!(
                "Program:\n\tTotal program output vertices count per input patch: {}\n\tTotal program output primitive count per input patch: {}\n",
                tess_gen_level * tess_gen_level * 2 * geometry_vertices_per_primitive,
                tess_gen_level * tess_gen_level * 2 * geometry_primitives_out_per_primitive
            );
        }

        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        // iterate
        let mut rendered_layers: Vec<Surface> = (0..num_layers)
            .map(|_| Surface::new(GRID_RENDER_SIZE, GRID_RENDER_SIZE))
            .collect();

        log::info!(
            "Rendering single point at the origin. Expecting yellow and green colored grid-like image. (High-frequency grid may appear unicolored)."
        );

        // renderTo
        // SAFETY: a NUL-terminated name against the program just built.
        let position_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
        let vao = VertexArray::new(gl);

        if position_location == -1 {
            return Err(TestError::Fail("Attribute a_position location was -1".to_string()));
        }

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, rendered_layers[0].get_width(), rendered_layers[0].get_height());
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
        }
        glu::expect_no_error(gl, "viewport")?;

        // SAFETY: a vertex array this case generated.
        unsafe { gl.bind_vertex_array(vao.get()) };
        glu::expect_no_error(gl, "bind vao")?;

        // SAFETY: a program just built.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "use program")?;

        // SAFETY: plain state setting.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1) };
        glu::expect_no_error(gl, "set patch param")?;

        // SAFETY: a plain generic vertex attribute value.
        unsafe { gl.vertex_attrib_4f(position_location as u32, 0.0, 0.0, 0.0, 1.0) };

        let _fbo = if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS != 0 {
            // clear texture contents
            {
                let clear_fbo = Framebuffer::new(gl);
                // SAFETY: names this case generated.
                unsafe {
                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, clear_fbo.get());

                    for layer_ndx in 0..num_layers {
                        gl.framebuffer_texture_layer(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            texture.get(),
                            0,
                            layer_ndx,
                        );
                        gl.clear(glw::GL_COLOR_BUFFER_BIT);
                    }
                }

                glu::expect_no_error(gl, "clear tex contents")?;
            }

            // create and bind layered fbo
            let fbo = Framebuffer::new(gl);

            // SAFETY: names this case generated.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
                gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
            }
            glu::expect_no_error(gl, "gen fbo")?;
            Some(fbo)
        } else {
            // clear viewport
            // SAFETY: plain clear.
            unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
            None
        };

        // draw
        {
            // SAFETY: a one-vertex patch draw.
            unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 1) };

            // SAFETY: a plain error query.
            let glerror = unsafe { gl.get_error() };
            if glerror == glw::GL_OUT_OF_MEMORY && self.flags & GRID_FLAG_ALLOW_OUT_OF_MEMORY != 0 {
                // Got accepted failure
                log::info!("Could not render, reason: got GL_OUT_OF_MEMORY while drawing\nFailure is allowed.");

                return Ok(TestStatus::pass("Pass"));
            }

            if glerror != glw::GL_NO_ERROR {
                return Err(TestError::Fail(format!("draw patches: got GL error {glerror:#x}")));
            }
        }

        // Read layers
        if self.flags & GRID_FLAG_GEOMETRY_SCATTER_LAYERS != 0 {
            let read_fbo = Framebuffer::new(gl);
            // SAFETY: a framebuffer this case generated.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, read_fbo.get()) };

            for (layer_ndx, layer) in rendered_layers.iter_mut().enumerate() {
                // SAFETY: a texture layer this case created.
                unsafe {
                    gl.framebuffer_texture_layer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        texture.get(),
                        0,
                        layer_ndx as i32,
                    )
                };
                glu::read_pixels(&context.render_context, 0, 0, &mut layer.get_access())?;
                glu::expect_no_error(gl, "read pixels")?;
            }
        } else {
            glu::read_pixels(&context.render_context, 0, 0, &mut rendered_layers[0].get_access())?;
            glu::expect_no_error(gl, "read pixels")?;
        }

        let mut all_layers_ok = true;
        for (ndx, layer) in rendered_layers.iter().enumerate() {
            all_layers_ok &= Self::verify_result_layer(ndx as i32, layer);
        }

        if all_layers_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

// ---------------------------------------------------------------------------------------
// FeedbackPrimitiveTypeCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TessellationOutputType {
    Triangles,
    Quads,
    Isolines,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum GeometryOutputType {
    Points,
    Lines,
    Triangles,
}

const FEEDBACK_RENDER_SIZE: i32 = 128;

const POSITION_VERTEX_SHADER: &str = "${VERSION_DECL}\n\
    in highp vec4 a_position;\n\
    void main (void)\n\
    {\n\
    \x20   gl_Position = a_position;\n\
    }\n";

/// `getTriangleNumOutputPrimitives`
fn get_triangle_num_output_primitives(tessellation_level: i32) -> i32 {
    if tessellation_level == 1 {
        1
    } else if tessellation_level == 2 {
        6
    } else {
        3 * (2 + 2 * (tessellation_level - 2)) + get_triangle_num_output_primitives(tessellation_level - 2)
    }
}

/// `getTriangleNumOutputPrimitivesPoints`
fn get_triangle_num_output_primitives_points(tessellation_level: i32) -> i32 {
    if tessellation_level == 0 {
        1
    } else if tessellation_level == 1 {
        3
    } else {
        3 + 3 * (tessellation_level - 1) + get_triangle_num_output_primitives_points(tessellation_level - 2)
    }
}

/// `FeedbackPrimitiveTypeCase`
struct FeedbackPrimitiveTypeCase {
    name: &'static str,
    tessellation_output: TessellationOutputType,
    tessellation_point_mode: bool,
    geometry_output_type: GeometryOutputType,
}

impl FeedbackPrimitiveTypeCase {
    fn tessellation_output_description(&self) -> &'static str {
        match (self.tessellation_output, self.tessellation_point_mode) {
            (TessellationOutputType::Triangles, true) => "points (triangles in point mode)",
            (TessellationOutputType::Triangles, false) => "triangles",
            (TessellationOutputType::Quads, true) => "points (quads in point mode)",
            (TessellationOutputType::Quads, false) => "quads",
            (TessellationOutputType::Isolines, true) => "points (isolines in point mode)",
            (TessellationOutputType::Isolines, false) => "isolines",
        }
    }

    fn geometry_input_description(&self) -> &'static str {
        match (self.tessellation_output, self.tessellation_point_mode) {
            (_, true) => "points",
            (TessellationOutputType::Isolines, false) => "lines",
            (_, false) => "triangles",
        }
    }

    fn geometry_output_description(&self) -> &'static str {
        match self.geometry_output_type {
            GeometryOutputType::Points => "points",
            GeometryOutputType::Lines => "lines",
            GeometryOutputType::Triangles => "triangles",
        }
    }

    /// `getNumGeneratedElementsPerPrimitive`
    fn get_num_generated_elements_per_primitive(&self) -> i32 {
        match self.geometry_output_type {
            GeometryOutputType::Triangles => 3,
            GeometryOutputType::Lines => 2,
            GeometryOutputType::Points => 1,
        }
    }

    /// `getNumTessellatedPrimitives`
    fn get_num_tessellated_primitives(&self) -> i32 {
        let tessellation_level = 3;

        if !self.tessellation_point_mode {
            match self.tessellation_output {
                TessellationOutputType::Triangles => get_triangle_num_output_primitives(tessellation_level),
                TessellationOutputType::Quads => tessellation_level * tessellation_level * 2, // tessellated as triangles
                TessellationOutputType::Isolines => tessellation_level * tessellation_level,
            }
        } else {
            match self.tessellation_output {
                TessellationOutputType::Triangles => get_triangle_num_output_primitives_points(tessellation_level),
                TessellationOutputType::Quads => (tessellation_level + 1) * (tessellation_level + 1),
                TessellationOutputType::Isolines => tessellation_level * (tessellation_level + 1),
            }
        }
    }

    /// `getGeometryAmplification`
    fn get_geometry_amplification(&self) -> i32 {
        let output_amplification = if self.geometry_output_type == GeometryOutputType::Lines {
            2
        } else {
            1
        };
        let num_input_vertices = if self.tessellation_point_mode {
            1
        } else if self.tessellation_output == TessellationOutputType::Isolines {
            2
        } else {
            3
        };

        output_amplification * num_input_vertices
    }

    /// `getNumGeneratedPrimitives`
    fn get_num_generated_primitives(&self) -> i32 {
        self.get_num_tessellated_primitives() * self.get_geometry_amplification()
    }

    /// `getOutputPrimitiveGLType`
    fn get_output_primitive_gl_type(&self) -> glw::GLenum {
        match self.geometry_output_type {
            GeometryOutputType::Triangles => glw::GL_TRIANGLES,
            GeometryOutputType::Lines => glw::GL_LINES,
            GeometryOutputType::Points => glw::GL_POINTS,
        }
    }

    fn get_vertex_source(context: &Context) -> String {
        specialize_shader(POSITION_VERTEX_SHADER, context)
    }

    fn get_fragment_source(context: &Context) -> String {
        specialize_shader(WHITE_OUTPUT_FRAGMENT_SHADER, context)
    }

    fn get_tessellation_control_source(&self, context: &Context) -> String {
        let mut buf = String::from(
            "${VERSION_DECL}\n\
             ${EXTENSION_TESSELATION_SHADER}\
             layout(vertices = 9) out;\n\
             \n\
             uniform highp float u_innerTessellationLevel;\n\
             uniform highp float u_outerTessellationLevel;\n\
             \n\
             void main (void)\n\
             {\n\
             \x20   if (gl_PatchVerticesIn != 4)\n\
             \x20       return;\n\
             \n\
             \x20   // Convert input 2x2 grid to 3x3 grid\n\
             \x20   float xweight = float(gl_InvocationID % 3) / 2.0f;\n\
             \x20   float yweight = float(gl_InvocationID / 3) / 2.0f;\n\
             \n\
             \x20   vec4 y0 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, yweight);\n\
             \x20   vec4 y1 = mix(gl_in[2].gl_Position, gl_in[3].gl_Position, yweight);\n\
             \n\
             \x20   gl_out[gl_InvocationID].gl_Position = mix(y0, y1, xweight);\n\
             \n",
        );

        match self.tessellation_output {
            TessellationOutputType::Triangles => buf.push_str(
                "    gl_TessLevelOuter[0] = 3.0;\n\
                 \x20   gl_TessLevelOuter[1] = 3.0;\n\
                 \x20   gl_TessLevelOuter[2] = 3.0;\n\
                 \x20   gl_TessLevelInner[0] = 3.0;\n",
            ),
            TessellationOutputType::Quads => buf.push_str(
                "    gl_TessLevelOuter[0] = 3.0;\n\
                 \x20   gl_TessLevelOuter[1] = 3.0;\n\
                 \x20   gl_TessLevelOuter[2] = 3.0;\n\
                 \x20   gl_TessLevelOuter[3] = 3.0;\n\
                 \x20   gl_TessLevelInner[0] = 3.0;\n\
                 \x20   gl_TessLevelInner[1] = 3.0;\n",
            ),
            TessellationOutputType::Isolines => buf.push_str(
                "    gl_TessLevelOuter[0] = 3.0;\n\
                 \x20   gl_TessLevelOuter[1] = 3.0;\n",
            ),
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    fn get_tessellation_evaluation_source(&self, context: &Context) -> String {
        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_TESSELATION_SHADER}layout(");
        buf.push_str(match self.tessellation_output {
            TessellationOutputType::Triangles => "triangles",
            TessellationOutputType::Quads => "quads",
            TessellationOutputType::Isolines => "isolines",
        });
        if self.tessellation_point_mode {
            buf.push_str(", point_mode");
        }
        buf.push_str(
            ") in;\n\
             \n\
             out highp vec4 v_tessellationCoords;\n\
             \n\
             // note: No need to use precise gl_Position since we do not require gapless geometry\n\
             void main (void)\n\
             {\n\
             \x20   if (gl_PatchVerticesIn != 9)\n\
             \x20       return;\n\
             \n\
             \x20   vec4 patchCentroid = vec4(0.0);\n\
             \x20   for (int ndx = 0; ndx < gl_PatchVerticesIn; ++ndx)\n\
             \x20       patchCentroid += gl_in[ndx].gl_Position;\n\
             \x20   patchCentroid /= patchCentroid.w;\n\
             \n",
        );

        match self.tessellation_output {
            TessellationOutputType::Triangles => buf.push_str(
                "    // map barycentric coords to 2d coords\n\
                 \x20   const vec3 tessDirX = vec3( 0.4,  0.4, 0.0);\n\
                 \x20   const vec3 tessDirY = vec3( 0.0, -0.4, 0.0);\n\
                 \x20   const vec3 tessDirZ = vec3(-0.4,  0.4, 0.0);\n\
                 \x20   gl_Position = patchCentroid + vec4(gl_TessCoord.x * tessDirX + gl_TessCoord.y * tessDirY + gl_TessCoord.z * tessDirZ, 0.0);\n",
            ),
            TessellationOutputType::Quads | TessellationOutputType::Isolines => {
                buf.push_str("    gl_Position = patchCentroid + vec4(gl_TessCoord.x * 0.8 - 0.4, gl_TessCoord.y * 0.8 - 0.4, 0.0, 0.0);\n");
            }
        }

        buf.push_str("    v_tessellationCoords = vec4(gl_TessCoord, 0.0);\n}\n");

        specialize_shader(&buf, context)
    }

    fn get_geometry_source(&self, context: &Context) -> String {
        let geometry_input_primitive = if self.tessellation_point_mode {
            "points"
        } else if self.tessellation_output == TessellationOutputType::Isolines {
            "lines"
        } else {
            "triangles"
        };
        let geometry_output_primitive = match self.geometry_output_type {
            GeometryOutputType::Points => "points",
            GeometryOutputType::Lines => "line_strip",
            GeometryOutputType::Triangles => "triangle_strip",
        };
        let num_input_vertices = if self.tessellation_point_mode {
            1
        } else if self.tessellation_output == TessellationOutputType::Isolines {
            2
        } else {
            3
        };
        let num_single_vertex_output_vertices = match self.geometry_output_type {
            GeometryOutputType::Points => 1,
            GeometryOutputType::Lines => 4,
            GeometryOutputType::Triangles => 3,
        };
        let num_emit_vertices = num_input_vertices * num_single_vertex_output_vertices;

        let mut buf = String::from("${VERSION_DECL}\n${EXTENSION_GEOMETRY_SHADER}layout(");
        buf.push_str(geometry_input_primitive);
        buf.push_str(") in;\nlayout(");
        buf.push_str(geometry_output_primitive);
        buf.push_str(&format!(", max_vertices={num_emit_vertices}"));
        buf.push_str(
            ") out;\n\
             \n\
             in highp vec4 v_tessellationCoords[];\n\
             out highp vec4 tf_someVertexPosition;\n\
             \n\
             void main (void)\n\
             {\n\
             \x20   // Emit primitive\n\
             \x20   for (int ndx = 0; ndx < gl_in.length(); ++ndx)\n\
             \x20   {\n",
        );

        let emit = |offset: &str| {
            format!(
                "        gl_Position = gl_in[ndx].gl_Position + vec4({offset}, 0.0, 0.0);\n\
                 \x20       tf_someVertexPosition = gl_in[gl_in.length() - 1].gl_Position;\n\
                 \x20       EmitVertex();\n"
            )
        };

        match self.geometry_output_type {
            GeometryOutputType::Points => buf.push_str(
                "        // Draw point on vertex\n\
                 \x20       gl_Position = gl_in[ndx].gl_Position;\n\
                 \x20       tf_someVertexPosition = gl_in[gl_in.length() - 1].gl_Position;\n\
                 \x20       EmitVertex();\n",
            ),
            GeometryOutputType::Lines => {
                buf.push_str("        // Draw cross on vertex\n");
                buf.push_str(&emit("-0.02, -0.02"));
                buf.push_str(&emit(" 0.02,  0.02"));
                buf.push_str("        EndPrimitive();\n");
                buf.push_str(&emit(" 0.02, -0.02"));
                buf.push_str(&emit("-0.02,  0.02"));
                buf.push_str("        EndPrimitive();\n");
            }
            GeometryOutputType::Triangles => {
                buf.push_str("        // Draw triangle on vertex\n");
                buf.push_str(&emit("  0.00, -0.02"));
                buf.push_str(&emit("  0.02,  0.00"));
                buf.push_str(&emit(" -0.02,  0.00"));
                buf.push_str("        EndPrimitive();\n");
            }
        }

        buf.push_str("    }\n}\n");

        specialize_shader(&buf, context)
    }

    /// `verifyFeedbackResults`
    fn verify_feedback_results(&self, feedback_result: &[[f32; 4]], failure: &mut Option<&'static str>) {
        let geometry_amplification = self.get_geometry_amplification();
        let elements_per_primitive = self.get_num_generated_elements_per_primitive();
        let error_flood_threshold = 8;
        let mut read_ndx = 0usize;
        let mut num_errors = 0;

        log::info!("Verifying feedback results.");

        for tessellated_primitive_ndx in 0..self.get_num_tessellated_primitives() {
            let primitive_vertex = feedback_result[read_ndx];

            // check the generated vertices are in the proper range (range: -0.4 <-> 0.4)
            {
                let equal_threshold = 1.0e-6f32;
                let centroid_ok = primitive_vertex[0] >= -0.4 - equal_threshold
                    && primitive_vertex[0] <= 0.4 + equal_threshold
                    && primitive_vertex[1] >= -0.4 - equal_threshold
                    && primitive_vertex[1] <= 0.4 + equal_threshold
                    && primitive_vertex[2].abs() < equal_threshold
                    && (primitive_vertex[3] - 1.0).abs() < equal_threshold;

                if !centroid_ok {
                    let report = num_errors < error_flood_threshold;
                    num_errors += 1;
                    if report {
                        log::warn!(
                            "Element at index {read_ndx} (tessellation invocation {tessellated_primitive_ndx})\n\texpected vertex in range: ( [-0.4, 0.4], [-0.4, 0.4], 0.0, 1.0 )\n\tgot: {primitive_vertex:?}"
                        );

                        *failure = Some("invalid feedback output");

                        read_ndx += 1;
                        continue;
                    }
                }
            }

            // check all other primitives generated from this tessellated primitive have the same feedback value
            for generated_primitive_ndx in 0..geometry_amplification {
                for primitive_vertex_ndx in 0..elements_per_primitive {
                    let generated_element_vertex = feedback_result[read_ndx];
                    let equal_threshold = 1.0e-6f32;

                    if (0..4).any(|c| (primitive_vertex[c] - generated_element_vertex[c]).abs() > equal_threshold) {
                        let report = num_errors < error_flood_threshold;
                        num_errors += 1;
                        if report {
                            log::warn!(
                                "Element at index {read_ndx} (tessellation invocation {tessellated_primitive_ndx}, geometry primitive {generated_primitive_ndx}, emitted vertex {primitive_vertex_ndx}):\n\tfeedback result was not contant over whole primitive.\n\tfirst emitted value: {primitive_vertex:?}\n\tcurrent emitted value:{generated_element_vertex:?}\n"
                            );
                        }

                        *failure = Some("got multiple different feedback values for a single primitive");
                    }

                    read_ndx += 1;
                }
            }
        }

        if num_errors > error_flood_threshold {
            log::warn!("Omitted {} error(s).", num_errors - error_flood_threshold);
        }
    }

    /// `verifyRenderedImage`
    #[allow(clippy::if_same_then_else)]
    fn verify_rendered_image(&self, image: &Surface, tf_vertices: &[[f32; 4]], failure: &mut Option<&'static str>) {
        log::info!("Comparing result image against feedback results.");

        // Check only unique vertices
        let mut vertices: Vec<[f32; 4]> = tf_vertices.to_vec();
        vertices.dedup();
        vertices.sort_by(|a, b| {
            a[0].partial_cmp(&b[0])
                .unwrap_or(std::cmp::Ordering::Equal)
                .then_with(|| a[1].partial_cmp(&b[1]).unwrap_or(std::cmp::Ordering::Equal))
        });
        vertices.dedup();

        // Verifying vertices recorded with feedback actually ended up on the result image
        for vertex in &vertices {
            // Rasterization (of lines) may deviate by one pixel. In addition to that, allow minimal errors in rasterized position vs. feedback result.
            // This minimal error could result in a difference in rounding => allow one additional pixel in deviation
            let raster_deviation = 2;
            let raster_pos = [
                ((vertex[0] * 0.5 + 0.5) * image.get_width() as f32 + 0.5).floor() as i32,
                ((vertex[1] * 0.5 + 0.5) * image.get_height() as f32 + 0.5).floor() as i32,
            ];

            // Find produced rasterization results
            let mut found = false;

            'search: for dy in -raster_deviation..=raster_deviation {
                for dx in -raster_deviation..=raster_deviation {
                    // Raster result could end up outside the viewport
                    if raster_pos[0] + dx < 0
                        || raster_pos[0] + dx >= image.get_width()
                        || raster_pos[1] + dy < 0
                        || raster_pos[1] + dy >= image.get_height()
                    {
                        found = true;
                    } else if !is_black(image.get_pixel(raster_pos[0] + dx, raster_pos[1] + dy)) {
                        found = true;
                    }

                    if found {
                        break 'search;
                    }
                }
            }

            if !found {
                log::warn!(
                    "Vertex {vertex:?}\n\tCould not find rasterization output for vertex.\n\tExpected non-black pixels near {raster_pos:?}"
                );

                *failure = Some("invalid result image");
            }
        }
    }

    /// `renderWithFeedback`
    fn render_with_feedback(
        &self,
        context: &Context,
        program: &ShaderProgram<'_>,
        patch_buffer: &Buffer<'_>,
        dst: &mut Surface,
        failure: &mut Option<&'static str>,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let vao = VertexArray::new(gl);
        let primitives_generated_query = glu::objects::Query::new(gl);
        // SAFETY: a NUL-terminated name against a built program.
        let pos_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
        let feedback_primitive_mode = self.get_output_primitive_gl_type();

        if pos_location == -1 {
            return Err(TestError::Fail("a_position was -1".to_string()));
        }

        log::info!("Rendering with transform feedback");

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, dst.get_width(), dst.get_height());
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "clear")?;

        // SAFETY: names this case generated.
        unsafe {
            gl.bind_vertex_array(vao.get());
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, patch_buffer.get());
            gl.vertex_attrib_pointer(pos_location as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(pos_location as u32);
        }
        glu::expect_no_error(gl, "setup attribs")?;

        // SAFETY: a program built by the caller.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "use program")?;

        // SAFETY: plain state setting.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 4) };
        glu::expect_no_error(gl, "set patch param")?;

        // SAFETY: a query this case generated.
        unsafe { gl.begin_query(glw::GL_PRIMITIVES_GENERATED, primitives_generated_query.get()) };
        glu::expect_no_error(gl, "begin GL_PRIMITIVES_GENERATED query")?;

        log::info!("Begin transform feedback with mode {feedback_primitive_mode:#x}");

        // SAFETY: transform feedback around a four-vertex patch draw, with the buffer bound by the caller.
        unsafe { gl.begin_transform_feedback(feedback_primitive_mode) };
        glu::expect_no_error(gl, "begin xfb")?;

        log::info!("Calling drawArrays with mode GL_PATCHES");

        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 4) };
        glu::expect_no_error(gl, "draw patches")?;

        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "end xfb")?;

        // SAFETY: ends the query begun above.
        unsafe { gl.end_query(glw::GL_PRIMITIVES_GENERATED) };
        glu::expect_no_error(gl, "end GL_PRIMITIVES_GENERATED query")?;

        glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
        glu::expect_no_error(gl, "readPixels")?;

        // verify GL_PRIMITIVES_GENERATED
        {
            let mut primitives_generated_result: u32 = 0;
            // SAFETY: one GLuint of output.
            unsafe {
                gl.get_query_objectuiv(
                    primitives_generated_query.get(),
                    glw::GL_QUERY_RESULT,
                    &mut primitives_generated_result,
                )
            };
            glu::expect_no_error(gl, "get GL_PRIMITIVES_GENERATED value")?;

            log::info!(
                "Verifying GL_PRIMITIVES_GENERATED, expecting {}",
                self.get_num_generated_primitives()
            );

            if primitives_generated_result as i32 != self.get_num_generated_primitives() {
                log::warn!("Error, GL_PRIMITIVES_GENERATED was {primitives_generated_result}");
                *failure = Some("Got unexpected GL_PRIMITIVES_GENERATED");
            } else {
                log::info!("GL_PRIMITIVES_GENERATED valid.");
            }
        }

        // feedback
        {
            let count =
                (self.get_num_generated_elements_per_primitive() * self.get_num_generated_primitives()) as usize;
            let mut feedback_results = vec![[0.0f32; 4]; count];
            let byte_size = count * std::mem::size_of::<[f32; 4]>();
            // SAFETY: a read mapping of `byte_size` bytes of the transform feedback buffer.
            let mapped_ptr = unsafe {
                gl.map_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    byte_size as GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            };

            glu::expect_no_error(gl, "mapBufferRange")?;

            log::info!("Reading transform feedback buffer.");
            if mapped_ptr.is_null() {
                return Err(TestError::Fail("mapBufferRange returned null".to_string()));
            }

            // SAFETY: the mapping is `byte_size` bytes and the destination is exactly that large.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    mapped_ptr.cast::<u8>(),
                    feedback_results.as_mut_ptr().cast::<u8>(),
                    byte_size,
                )
            };

            // SAFETY: unmapping the mapping made above.
            let unmap_result = unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) };
            glu::expect_no_error(gl, "unmapBuffer")?;

            if unmap_result != glw::TRUE {
                return Err(TestError::Fail("unmapBuffer failed, did not return true".to_string()));
            }

            // verify transform results
            self.verify_feedback_results(&feedback_results, failure);

            // verify feedback results are consistent with rendered image
            self.verify_rendered_image(dst, &feedback_results, failure);
        }

        Ok(())
    }

    /// `renderWithoutFeedback`
    fn render_without_feedback(
        &self,
        context: &Context,
        program: &ShaderProgram<'_>,
        patch_buffer: &Buffer<'_>,
        dst: &mut Surface,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let vao = VertexArray::new(gl);
        // SAFETY: a NUL-terminated name against a built program.
        let pos_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };

        if pos_location == -1 {
            return Err(TestError::Fail("a_position was -1".to_string()));
        }

        log::info!("Rendering without transform feedback");

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.viewport(0, 0, dst.get_width(), dst.get_height());
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::expect_no_error(gl, "clear")?;

        // SAFETY: names this case generated.
        unsafe {
            gl.bind_vertex_array(vao.get());
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, patch_buffer.get());
            gl.vertex_attrib_pointer(pos_location as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(pos_location as u32);
        }
        glu::expect_no_error(gl, "setup attribs")?;

        // SAFETY: a program built by the caller.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "use program")?;

        // SAFETY: plain state setting.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 4) };
        glu::expect_no_error(gl, "set patch param")?;

        log::info!("Calling drawArrays with mode GL_PATCHES");

        // SAFETY: a four-vertex patch draw.
        unsafe { gl.draw_arrays(glw::GL_PATCHES, 0, 4) };
        glu::expect_no_error(gl, "draw patches")?;

        glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
        glu::expect_no_error(gl, "readPixels")
    }
}

impl TestCase for FeedbackPrimitiveTypeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports(3, 2)
            && (!context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
                || !context.context_info.is_extension_supported("GL_EXT_geometry_shader"))
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader and GL_EXT_geometry_shader extensions".to_string(),
            ));
        }

        let render_target = context.render_target();
        if render_target.width < FEEDBACK_RENDER_SIZE || render_target.height < FEEDBACK_RENDER_SIZE {
            return Err(TestError::NotSupported(format!(
                "Test requires {FEEDBACK_RENDER_SIZE}x{FEEDBACK_RENDER_SIZE} or larger render target."
            )));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        log::info!(
            "Testing {}->{} primitive conversion with and without transform feedback.\n\
             Sending a patch of 4 vertices (2x2 uniform grid) to tessellation control shader.\n\
             Control shader emits a patch of 9 vertices (3x3 uniform grid).\n\
             Setting outer tessellation level = 3, inner = 3.\n\
             Primitive generator emits {}\n\
             Geometry shader transforms emitted primitives to {}\n\
             Reading back vertex positions of generated primitives using transform feedback.\n\
             Verifying rendered image and feedback vertices are consistent.\n\
             Rendering scene again with identical shader program, but without setting feedback varying. Expecting similar output image.",
            self.tessellation_output_description(),
            self.geometry_input_description(),
            self.tessellation_output_description(),
            self.geometry_output_description()
        );

        // Resources
        let patch_buffer_data: [[f32; 4]; 4] = [
            [-0.9, -0.9, 0.0, 1.0],
            [-0.9, 0.9, 0.0, 1.0],
            [0.9, -0.9, 0.0, 1.0],
            [0.9, 0.9, 0.0, 1.0],
        ];
        let patch_buffer = Buffer::new(gl);
        // SAFETY: a buffer this case generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, patch_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&patch_buffer_data) as GLsizeiptr,
                patch_buffer_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buffer")?;

        let tessellation_sources = |sources: ProgramSources| {
            sources
                .with(ShaderType::Vertex, Self::get_vertex_source(context))
                .with(ShaderType::Fragment, Self::get_fragment_source(context))
                .with(ShaderType::TessControl, self.get_tessellation_control_source(context))
                .with(
                    ShaderType::TessEvaluation,
                    self.get_tessellation_evaluation_source(context),
                )
                .with(ShaderType::Geometry, self.get_geometry_source(context))
        };

        let feedback_program = ShaderProgram::new(
            gl,
            &tessellation_sources(ProgramSources::default())
                .with_transform_feedback(&["tf_someVertexPosition".to_string()], glw::GL_INTERLEAVED_ATTRIBS),
        );
        if !feedback_program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        let non_feedback_program = ShaderProgram::new(gl, &tessellation_sources(ProgramSources::default()));
        if !non_feedback_program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        // genTransformFeedback
        let elements_per_primitive = self.get_num_generated_elements_per_primitive();
        let feedback_primitives = self.get_num_generated_primitives();
        let feedback_elements = (elements_per_primitive * feedback_primitives) as usize;
        let initial_buffer = vec![[-1.0f32; 4]; feedback_elements];

        let feedback_id = glu::TransformFeedback::new(gl);
        // SAFETY: a transform feedback object this case generated.
        unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, feedback_id.get()) };
        glu::expect_no_error(gl, "gen transform feedback")?;

        let feedback_buffer = Buffer::new(gl);
        // SAFETY: a buffer this case generated and a vector that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buffer.get());
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (std::mem::size_of::<[f32; 4]>() * initial_buffer.len()) as GLsizeiptr,
                initial_buffer.as_ptr().cast(),
                glw::GL_STATIC_COPY,
            );
        }
        glu::expect_no_error(gl, "gen feedback buffer")?;

        // SAFETY: as above.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buffer.get()) };
        glu::expect_no_error(gl, "bind feedback buffer")?;

        let mut feedback_result = Surface::new(FEEDBACK_RENDER_SIZE, FEEDBACK_RENDER_SIZE);
        let mut non_feedback_result = Surface::new(FEEDBACK_RENDER_SIZE, FEEDBACK_RENDER_SIZE);
        let mut failure: Option<&'static str> = None;

        // render with and without XFB
        self.render_with_feedback(
            context,
            &feedback_program,
            &patch_buffer,
            &mut feedback_result,
            &mut failure,
        )?;
        self.render_without_feedback(context, &non_feedback_program, &patch_buffer, &mut non_feedback_result)?;

        // compare
        {
            log::info!(
                "Comparing the image rendered with no transform feedback against the image rendered with enabled transform feedback."
            );

            let image_ok = if context.render_target().num_samples > 1 {
                fuzzy_compare_ok(
                    &feedback_result.get_const_access(),
                    &non_feedback_result.get_const_access(),
                    0.03,
                )
                .unwrap_or(false)
            } else {
                // 3x3 search kernel; fragments may end up over the viewport, just ignore them
                int_threshold_position_deviation_error_threshold_compare(
                    &feedback_result,
                    &non_feedback_result,
                    [8, 8, 8, 255],
                    IVec3::from_array([1, 1, 0]),
                    true,
                    0,
                )
            };

            if !image_ok {
                failure = Some("Image comparison failed");
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}

// ---------------------------------------------------------------------------------------
// group
// ---------------------------------------------------------------------------------------

/// `TessellationGeometryInteractionTests::init`, restricted to what is ported.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tessellation_geometry_interaction");

    // .render
    {
        let mut render_group = TestCaseGroup::new("render");

        // .passthrough
        {
            let mut passthrough_group = TestCaseGroup::new("passthrough");

            passthrough_group.add_child(Box::new(IdentityGeometryShaderCase {
                name: "tessellate_tris_passthrough_geometry_no_change",
                case: IdentityGeometryCaseType::Triangles,
            }) as Box<dyn TestCase>);
            passthrough_group.add_child(Box::new(IdentityGeometryShaderCase {
                name: "tessellate_quads_passthrough_geometry_no_change",
                case: IdentityGeometryCaseType::Quads,
            }) as Box<dyn TestCase>);
            passthrough_group.add_child(Box::new(IdentityGeometryShaderCase {
                name: "tessellate_isolines_passthrough_geometry_no_change",
                case: IdentityGeometryCaseType::Isolines,
            }) as Box<dyn TestCase>);

            passthrough_group.add_child(Box::new(IdentityTessellationShaderCase {
                name: "passthrough_tessellation_geometry_shade_triangles_no_change",
                case: IdentityTessellationCaseType::Triangles,
            }) as Box<dyn TestCase>);
            passthrough_group.add_child(Box::new(IdentityTessellationShaderCase {
                name: "passthrough_tessellation_geometry_shade_lines_no_change",
                case: IdentityTessellationCaseType::Isolines,
            }) as Box<dyn TestCase>);

            render_group.add_child(passthrough_group);
        }

        // .limits
        {
            let mut limit_group = TestCaseGroup::new("limits");

            let cases: [(&'static str, &'static str, i32); 6] = [
                // Test single limit
                (
                    "output_required_max_tessellation",
                    "Minimum maximum tessellation level",
                    GRID_FLAG_TESSELLATION_MAX_SPEC,
                ),
                (
                    "output_implementation_max_tessellation",
                    "Maximum tessellation level supported by the implementation",
                    GRID_FLAG_TESSELLATION_MAX_IMPLEMENTATION,
                ),
                (
                    "output_required_max_geometry",
                    "Output minimum maximum number of vertices the geometry shader",
                    GRID_FLAG_GEOMETRY_MAX_SPEC,
                ),
                (
                    "output_implementation_max_geometry",
                    "Output maximum number of vertices in the geometry shader supported by the implementation",
                    GRID_FLAG_GEOMETRY_MAX_IMPLEMENTATION,
                ),
                (
                    "output_required_max_invocations",
                    "Minimum maximum number of geometry shader invocations",
                    GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_SPEC,
                ),
                (
                    "output_implementation_max_invocations",
                    "Maximum number of geometry shader invocations supported by the implementation",
                    GRID_FLAG_GEOMETRY_INVOCATIONS_MAX_IMPLEMENTATION,
                ),
            ];

            for (name, desc, flags) in cases {
                limit_group.add_child(Box::new(GridRenderCase::new(name, desc, flags)) as Box<dyn TestCase>);
            }

            render_group.add_child(limit_group);
        }

        // .scatter
        {
            let mut scatter_group = TestCaseGroup::new("scatter");

            scatter_group.add_child(Box::new(GridRenderCase::new(
                "geometry_scatter_instances",
                "Each geometry shader instance outputs its primitives far from other instances of the same execution",
                GRID_FLAG_GEOMETRY_SCATTER_INSTANCES,
            )) as Box<dyn TestCase>);
            scatter_group.add_child(Box::new(GridRenderCase::new(
                "geometry_scatter_primitives",
                "Each geometry shader instance outputs its primitives far from other primitives of the same instance",
                GRID_FLAG_GEOMETRY_SCATTER_PRIMITIVES | GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES,
            )) as Box<dyn TestCase>);
            scatter_group.add_child(Box::new(GridRenderCase::new(
                "geometry_scatter_layers",
                "Each geometry shader instance outputs its primitives to multiple layers and far from other primitives of the same instance",
                GRID_FLAG_GEOMETRY_SCATTER_LAYERS | GRID_FLAG_GEOMETRY_SEPARATE_PRIMITIVES,
            )) as Box<dyn TestCase>);

            render_group.add_child(scatter_group);
        }

        group.add_child(render_group);
    }

    // .feedback
    {
        let mut feedback_group = TestCaseGroup::new("feedback");

        let case_configs: [(&'static str, TessellationOutputType, bool, GeometryOutputType); 6] = [
            // tess output triangles -> geo input triangles, output points
            (
                "tessellation_output_triangles_geometry_output_points",
                TessellationOutputType::Triangles,
                false,
                GeometryOutputType::Points,
            ),
            // tess output quads <-> geo input triangles, output points
            (
                "tessellation_output_quads_geometry_output_points",
                TessellationOutputType::Quads,
                false,
                GeometryOutputType::Points,
            ),
            // tess output isolines <-> geo input lines, output points
            (
                "tessellation_output_isolines_geometry_output_points",
                TessellationOutputType::Isolines,
                false,
                GeometryOutputType::Points,
            ),
            // tess output triangles, point_mode <-> geo input points, output lines
            (
                "tessellation_output_triangles_point_mode_geometry_output_lines",
                TessellationOutputType::Triangles,
                true,
                GeometryOutputType::Lines,
            ),
            // tess output quads, point_mode <-> geo input points, output lines
            (
                "tessellation_output_quads_point_mode_geometry_output_lines",
                TessellationOutputType::Quads,
                true,
                GeometryOutputType::Lines,
            ),
            // tess output isolines, point_mode <-> geo input points, output triangles
            (
                "tessellation_output_isolines_point_mode_geometry_output_triangles",
                TessellationOutputType::Isolines,
                true,
                GeometryOutputType::Triangles,
            ),
        ];

        for (name, tessellation_output, tessellation_point_mode, geometry_output_type) in case_configs {
            feedback_group.add_child(Box::new(FeedbackPrimitiveTypeCase {
                name,
                tessellation_output,
                tessellation_point_mode,
                geometry_output_type,
            }) as Box<dyn TestCase>);
        }

        feedback_group.add_child(Box::new(FeedbackRecordVariableSelectionCase {
            name: "record_variable_selection",
        }) as Box<dyn TestCase>);

        group.add_child(feedback_group);
    }

    // .point_size
    {
        let mut point_size_group = TestCaseGroup::new("point_size");

        let case_masks: [i32; 10] = [
            FLAG_VERTEX_SET,
            FLAG_TESSELLATION_EVALUATION_SET,
            FLAG_GEOMETRY_SET,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_CONTROL_SET,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_EVALUATION_SET,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_DONT_SET,
            FLAG_VERTEX_SET | FLAG_GEOMETRY_SET,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_EVALUATION_SET | FLAG_GEOMETRY_SET,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_ADD | FLAG_GEOMETRY_ADD,
            FLAG_VERTEX_SET | FLAG_TESSELLATION_EVALUATION_SET | FLAG_GEOMETRY_DONT_SET,
        ];

        for flags in case_masks {
            let name = PointSizeCase::gen_test_case_name(flags);
            point_size_group.add_child(Box::new(PointSizeCase { name, flags }) as Box<dyn TestCase>);
        }

        group.add_child(point_size_group);
    }

    group
}
