// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cPrimitiveRestart.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The index lists upstream ends with a `TERMINATOR_INDEX` sentinel are slices here, so `getIndicesLength` is `len`; `setRestartIndex` is a no-op for the only index the test passes (`RESTART_INDEX`, the one the lists already use) and is not ported. `m_context.getRenderContext().postIterate()` (a buffer swap) has no counterpart: the next draw clears the target first. The case's `init` (programs) runs at the top of `iterate`. `tcu::ortho2DMatrix` is written out row-major as upstream hands it to `glUniformMatrix4fv`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

const RESTART_INDEX: u32 = 0xFFFF_FFFF;
const POINT_SIZE: f32 = 4.0;
const TEST_TOLERANCE: u8 = 24;

#[rustfmt::skip]
const VERTICES: [f32; 51] = [
    /* quad vertices */
    1.0, -1.0, -2.0,
    1.0, 1.0, -2.0,
    -1.0, -1.0, -2.0,
    -1.0, 1.0, -2.0,
    /* mid-screen point for LINES primitives */
    0.0, 0.0, -2.0,
    /* spot-check points for POINTS */
    0.5, -0.5, -2.0,
    -0.5, 0.5, -2.0,
    /* extra vertices for triple-check */
    1.0, 0.5, -2.0,
    0.5, 1.0, -2.0,
    1.0, 0.0, -2.0,
    -1.0, 0.0, -2.0,
    0.0, 1.0, -2.0,
    0.0, -1.0, -2.0,
    /* duplicated quad for *BaseVertex calls */
    1.0, -1.0, -2.0,
    1.0, 1.0, -2.0,
    -1.0, -1.0, -2.0,
    -1.0, 1.0, -2.0
];

const TRIANGLES: [u32; 7] = [0, 1, 2, RESTART_INDEX, 2, 1, 3];

const GC_WHITE: [u8; 3] = [255, 255, 255];

const VERT_SHADER: &str = "\n    ${VERSION}\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform vec4 testcolor;\n\n    in vec4 vertex;\n    out vec4 color;\n\n    void main (void)\n    {\n            color = testcolor;\n            gl_Position = ModelViewProjectionMatrix * vertex;\n            gl_PointSize = 4.0;\n    }\n    ";

const FRAG_SHADER: &str = "\n    ${VERSION}\n    in vec4 color;\n    out vec4 frag_color;\n\n    void main()\n    {\n        frag_color = color;\n    }\n    ";

const TESS_VERT_SHADER: &str = "\n    ${VERSION}\n    uniform mat4 ModelViewProjectionMatrix;\n    uniform vec4 testcolor;\n\n    in vec4 vertex;\n    out vec4 color;\n\n    void main (void)\n    {\n            color = testcolor;\n            gl_Position = ModelViewProjectionMatrix * vertex;\n            gl_PointSize = 1.0;\n    }\n    ";

const TESS_CTRL_SHADER: &str = "\n    ${VERSION}\n    #extension GL_ARB_tessellation_shader : require\n    #define ID gl_InvocationID\n\n    in vec4 color[];\n\n    layout(vertices = 3) out;\n\n    out vec4 frontColor[3];\n\n    void main()\n    {\n            gl_out[ID].gl_Position = gl_in[ID].gl_Position;\n            frontColor[ID] = color[ID];\n\n            gl_TessLevelInner[0] = 0;\n            gl_TessLevelOuter[0] = 1;\n            gl_TessLevelOuter[1] = 1;\n            gl_TessLevelOuter[2] = 1;\n    }\n    ";

const TESS_EVAL_SHADER: &str = "\n    ${VERSION}\n    #extension GL_ARB_tessellation_shader : require\n\n    uniform mat4 ModelViewMatrix;\n\n    in vec4 frontColor[gl_MaxPatchVertices];\n\n    out vec4 color;\n\n    layout(triangles, equal_spacing) in;\n\n    void main()\n    {\n            color = vec4(\n                gl_TessCoord.x * frontColor[0].xyz +\n                gl_TessCoord.y * frontColor[1].xyz +\n                gl_TessCoord.z * frontColor[2].xyz,\n                1.0);\n            gl_Position = ModelViewMatrix * vec4(\n                gl_TessCoord.x * gl_in[0].gl_Position.xyz +\n                gl_TessCoord.y * gl_in[1].gl_Position.xyz +\n                gl_TessCoord.z * gl_in[2].gl_Position.xyz,\n                1.0);\n    }\n    ";

/// `Spot`
struct Spot {
    u: f32,
    v: f32,
    rgb: [u8; 3],
}

/// `ReadScreen`
fn read_screen(
    gl: &glw::Functions,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    type_: GLenum,
    buf: &mut [u8],
) -> Result<(), TestError> {
    let repeat = match type_ {
        glw::GL_ALPHA | glw::GL_LUMINANCE => 1,
        glw::GL_LUMINANCE_ALPHA => 2,
        glw::GL_RGB => 3,
        glw::GL_RGBA | glw::GL_BGRA => 4,
        _ => 1,
    };
    buf[..(w * h * repeat) as usize].fill(0);

    // SAFETY: `buf` holds w x h pixels of the format read.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
        glu::expect_no_error(gl, "pixelStorei")?;

        gl.read_pixels(x, y, w, h, type_, glw::GL_UNSIGNED_BYTE, buf.as_mut_ptr().cast());
    }
    glu::expect_no_error(gl, "readPixels")
}

/// `map_coord`
fn map_coord(c: f32, n: u32) -> i32 {
    if !(0.0..=1.0).contains(&c) {
        return -1;
    }
    (0.5 + (c * (n - 1) as f32)) as i32
}

/// `checkPixel`
fn check_pixel(y: i32, x: i32, buf_w: u32, buf_h: u32, buf: &[u8], reference: &[u8; 3], tolerance: u8) -> bool {
    if y as u32 > buf_h {
        return false;
    }
    let index = (buf_w as i32 * y + x) * 4;
    let Some(pixel) = usize::try_from(index).ok().and_then(|index| buf.get(index..index + 3)) else {
        return false;
    };
    (0..3).all(|channel| (i32::from(pixel[channel]) - i32::from(reference[channel])).abs() <= i32::from(tolerance))
}

/// `testSpotLine`
fn test_spot_line(screen_y: i32, screen_x: i32, buf_w: u32, buf_h: u32, buf: &[u8], reference: &[u8; 3]) -> bool {
    if check_pixel(screen_y, screen_x, buf_w, buf_h, buf, reference, TEST_TOLERANCE) {
        return true;
    }

    // The GL spec allows a line fragment to be "no more than one unit in either x or y window coordinates from a corresponding fragment produced by the diamond-exit rule", so we need to search for a hit compared to our expected result.
    let points = [
        [screen_x - 1, screen_y],
        [screen_x + 1, screen_y],
        [screen_x, screen_y - 1],
        [screen_x, screen_y + 1],
    ];
    for point in points {
        if point[0] >= 0
            && point[0] < buf_w as i32
            && point[1] >= 0
            && point[1] < buf_h as i32
            && check_pixel(point[1], point[0], buf_w, buf_h, buf, reference, TEST_TOLERANCE)
        {
            return true;
        }
    }
    false
}

/// `PrimitiveRestartModeTestCase`
struct PrimitiveRestartModeTestCase;

fn make_program<'gl>(
    gl: &'gl glw::Functions,
    specialization_map: &[(&str, String)],
    vs: &str,
    fs: &str,
    cs: Option<&str>,
    es: Option<&str>,
) -> Result<ShaderProgram<'gl>, TestError> {
    let mut sources = ProgramSources::default()
        .with(
            ShaderType::Vertex,
            StringTemplate::new(vs).specialize(specialization_map)?,
        )
        .with(
            ShaderType::Fragment,
            StringTemplate::new(fs).specialize(specialization_map)?,
        );
    if let Some(cs) = cs {
        sources = sources.with(
            ShaderType::TessControl,
            StringTemplate::new(cs).specialize(specialization_map)?,
        );
    }
    if let Some(es) = es {
        sources = sources.with(
            ShaderType::TessEvaluation,
            StringTemplate::new(es).specialize(specialization_map)?,
        );
    }

    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        return Err(TestError::Fail("Invalid program".to_string()));
    }
    Ok(program)
}

/// `initDraw`; the buffers are returned for `uninit_draw`.
fn init_draw(
    context: &Context,
    active_program: glw::GLuint,
    indices: &[u32],
) -> Result<(glw::GLuint, [glw::GLuint; 3], glw::GLint), TestError> {
    let gl = context.gl();
    let default_indirect_command: [u32; 5] = [TRIANGLES.len() as u32, 1, 0, 0, 0];
    let mut vao = 0;
    let mut buffer_objects = [0u32; 3];

    // SAFETY: plain state setters and uploads of data that outlives the calls.
    unsafe {
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        glu::expect_no_error(gl, "clear")?;

        gl.gen_vertex_arrays(1, &mut vao);
        glu::expect_no_error(gl, "genVertexArrays")?;

        gl.bind_vertex_array(vao);
        glu::expect_no_error(gl, "bindVertexArray")?;

        gl.enable(glw::GL_PRIMITIVE_RESTART);
        glu::expect_no_error(gl, "enable")?;

        gl.primitive_restart_index(RESTART_INDEX);
        glu::expect_no_error(gl, "primitiveRestartIndex")?;

        gl.point_size(POINT_SIZE);
        glu::expect_no_error(gl, "pointSize")?;

        gl.disable(glw::GL_LINE_SMOOTH);
        glu::expect_no_error(gl, "disable")?;

        gl.use_program(active_program);
        glu::expect_no_error(gl, "useProgram")?;

        let loc_model_view_proj = gl.get_uniform_location(active_program, c"ModelViewProjectionMatrix".as_ptr());
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc_model_view_proj != -1 {
            // tcu::ortho2DMatrix<GLfloat, 4, 4>(-1.0, 1.0, -1.0, 1.0, -1.0, -30.0), row-major
            let (l, r, b, t, n, f) = (-1.0f32, 1.0f32, -1.0f32, 1.0f32, -1.0f32, -30.0f32);
            let (inv_width, inv_height, inv_depth) = (1.0 / (r - l), 1.0 / (t - b), 1.0 / (f - n));
            let mut mat = [0.0f32; 16];
            mat[0] = 2.0 * inv_width;
            mat[5] = 2.0 * inv_height;
            mat[10] = 2.0 * inv_depth;
            mat[12] = -(r + l) * inv_width;
            mat[13] = -(t + b) * inv_height;
            mat[14] = -(f + n) * inv_depth;
            mat[15] = 1.0;
            gl.uniform_matrix_4fv(loc_model_view_proj, 1, 0, mat.as_ptr());
            glu::expect_no_error(gl, "uniformMatrix4fv")?;
        }

        let loc_model_view = gl.get_uniform_location(active_program, c"ModelViewMatrix".as_ptr());
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc_model_view != -1 {
            let mut mat = [0.0f32; 16];
            for diagonal in [0, 5, 10, 15] {
                mat[diagonal] = 1.0;
            }
            gl.uniform_matrix_4fv(loc_model_view, 1, 0, mat.as_ptr());
            glu::expect_no_error(gl, "uniformMatrix4fv")?;
        }

        let loc_test_color = gl.get_uniform_location(active_program, c"testcolor".as_ptr());
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc_test_color != -1 {
            let color = [1.0f32, 1.0, 1.0, 1.0];
            gl.uniform_4fv(loc_test_color, 1, color.as_ptr());
            glu::expect_no_error(gl, "uniform4fv")?;
        }

        gl.gen_buffers(3, buffer_objects.as_mut_ptr());
        glu::expect_no_error(gl, "genBuffers")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_objects[0]);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&VERTICES) as isize,
            VERTICES.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        glu::expect_no_error(gl, "bufferData")?;
    }

    // SAFETY: a linked program and a NUL-terminated name.
    let loc_positions = unsafe { gl.get_attrib_location(active_program, c"vertex".as_ptr()) };
    glu::expect_no_error(gl, "getAttribLocation")?;

    // SAFETY: an attribute location the program reported; uploads of data that outlives the calls.
    unsafe {
        if loc_positions != -1 {
            gl.enable_vertex_attrib_array(loc_positions as u32);
            glu::expect_no_error(gl, "enableVertexAttribArray")?;

            gl.vertex_attrib_pointer(loc_positions as u32, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            glu::expect_no_error(gl, "vertexAttribPointer")?;
        }

        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffer_objects[1]);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            std::mem::size_of_val(indices) as isize,
            indices.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        glu::expect_no_error(gl, "bufferData")?;

        if context.context_info.is_extension_supported("GL_ARB_draw_indirect") {
            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, buffer_objects[2]);
            glu::expect_no_error(gl, "bindBuffer")?;

            gl.buffer_data(
                glw::GL_DRAW_INDIRECT_BUFFER,
                std::mem::size_of_val(&default_indirect_command) as isize,
                default_indirect_command.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "bufferData")?;
        }
    }

    Ok((vao, buffer_objects, loc_positions))
}

/// `uninitDraw`
fn uninit_draw(
    context: &Context,
    vao: glw::GLuint,
    buffer_objects: &[glw::GLuint; 3],
    loc_positions: glw::GLint,
) -> Result<(), TestError> {
    let gl = context.gl();

    // SAFETY: names `init_draw` generated, deleted once; `locPositions` may be -1 and is passed as it is, as upstream does.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_objects[0]);
        glu::expect_no_error(gl, "bufferData")?;

        gl.disable_vertex_attrib_array(loc_positions as u32);
        glu::expect_no_error(gl, "disableVertexAttribArray")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;

        if context.context_info.is_extension_supported("GL_ARB_draw_indirect") {
            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, 0);
            glu::expect_no_error(gl, "bindBuffer")?;
        }

        gl.delete_buffers(3, buffer_objects.as_ptr());
        glu::expect_no_error(gl, "deleteBuffers")?;

        gl.point_size(1.0);
        glu::expect_no_error(gl, "pointSize")?;

        gl.disable(glw::GL_LINE_SMOOTH);
        glu::expect_no_error(gl, "disable")?;

        gl.use_program(0);
        glu::expect_no_error(gl, "useProgram")?;

        gl.primitive_restart_index(0);
        glu::expect_no_error(gl, "primitiveRestartIndex")?;

        gl.disable(glw::GL_PRIMITIVE_RESTART);
        glu::expect_no_error(gl, "disable")?;

        if vao != 0 {
            gl.delete_vertex_arrays(1, &vao);
            glu::expect_no_error(gl, "deleteVertexArrays")?;
        }
    }
    Ok(())
}

/// `testSpots`
fn test_spots(spots: &[Spot], is_line_test: bool, buf: &[u8], buf_w: u32, buf_h: u32) -> bool {
    let mut result = true;

    for spot in spots {
        let screen_x = map_coord(spot.u, buf_w);
        let screen_y = map_coord(spot.v, buf_h);

        if screen_x == -1 {
            log::info!("GL3SpotTestApply:Out of range [0,1] spot u coordinate.");
            return false;
        }

        if screen_y == -1 {
            log::info!("GL3SpotTestApply:Out of range [0,1] spot v coordinate.");
            return false;
        }

        if is_line_test {
            result &= test_spot_line(screen_y, screen_x, buf_w, buf_h, buf, &spot.rgb);
        } else {
            result &= check_pixel(screen_y, screen_x, buf_w, buf_h, buf, &spot.rgb, TEST_TOLERANCE);
        }
    }
    result
}

/// `testApply` with `expectedError` GL_NO_ERROR and the three default spots
fn test_apply(context: &Context, is_line_test: bool) -> Result<bool, TestError> {
    let gl = context.gl();

    let default_spots = [
        Spot {
            u: 2.0 / 4.0,
            v: 2.0 / 4.0,
            rgb: GC_WHITE,
        },
        Spot {
            u: 1.0 / 4.0,
            v: 3.0 / 4.0,
            rgb: GC_WHITE,
        },
        Spot {
            u: 3.0 / 4.0,
            v: 1.0 / 4.0,
            rgb: GC_WHITE,
        },
    ];

    // GL3AssertError
    // SAFETY: glGetError needs nothing but a current context.
    let error = unsafe { gl.get_error() };
    let mut result = error == glw::GL_NO_ERROR;
    if !result {
        log::info!(
            "GL3AssertError:expected {} but got {}",
            glw::error_name(glw::GL_NO_ERROR),
            glw::error_name(error)
        );
    }

    if result {
        let target = context.render_target();
        let (screen_w, screen_h) = (target.width as u32, target.height as u32);
        let mut buf = vec![0u8; (screen_w * screen_h * 4) as usize];
        read_screen(gl, 0, 0, screen_w as i32, screen_h as i32, glw::GL_RGBA, &mut buf)?;
        result = test_spots(&default_spots, is_line_test, &buf, screen_w, screen_h);
    }

    // SAFETY: a clear of the bound framebuffer.
    unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT) };
    glu::expect_no_error(gl, "clear")?;
    Ok(result)
}

/// `testDrawElements`
fn test_draw_elements(
    context: &Context,
    active_program: glw::GLuint,
    mode: GLenum,
    indices: &[u32],
    error_message: &str,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut result = true;

    let is_line_test = matches!(
        mode,
        glw::GL_LINES | glw::GL_LINE_STRIP | glw::GL_LINE_LOOP | glw::GL_LINES_ADJACENCY | glw::GL_LINE_STRIP_ADJACENCY
    );

    let (vao, buffer_objects, loc_positions) = init_draw(context, active_program, indices)?;

    // SAFETY: a draw from the element buffer `init_draw` set up.
    unsafe { gl.draw_elements(mode, indices.len() as i32, glw::GL_UNSIGNED_INT, std::ptr::null()) };
    glu::expect_no_error(gl, "drawElements")?;

    if !test_apply(context, is_line_test)? {
        log::info!("Test fail: \n{error_message}\n");
        result = false;
    }

    uninit_draw(context, vao, &buffer_objects, loc_positions)?;
    Ok(result)
}

impl TestCase for PrimitiveRestartModeTestCase {
    fn name(&self) -> &str {
        "restart_mode"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut result = true;

        // init
        let version = context.context_type().glsl_version().declaration();
        let specialization_map = [("VERSION", version.to_string())];
        let program = make_program(gl, &specialization_map, VERT_SHADER, FRAG_SHADER, None, None)?;
        let tess_program = if context.context_type().supports_core(4, 4) {
            Some(make_program(
                gl,
                &specialization_map,
                TESS_VERT_SHADER,
                FRAG_SHADER,
                Some(TESS_CTRL_SHADER),
                Some(TESS_EVAL_SHADER),
            )?)
        } else {
            None
        };

        let indices_points: [u32; 5] = [5, RESTART_INDEX, 6, RESTART_INDEX, 4];
        let indices_lines: [u32; 5] = [4, 3, RESTART_INDEX, 4, 0];
        let indices_lines_adjacency: [u32; 9] = [4, 4, 3, 3, RESTART_INDEX, 4, 4, 0, 0];
        let indices_triangles_adjacency: [u32; 13] = [0, 0, 1, 1, 2, 2, RESTART_INDEX, 2, 2, 1, 1, 3, 3];

        // SAFETY: a clear of the bound framebuffer.
        unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT) };
        glu::expect_no_error(gl, "clear")?;

        let active_program = program.program();
        result &= test_draw_elements(context, active_program, glw::GL_POINTS, &indices_points, "POINTS")?;
        result &= test_draw_elements(context, active_program, glw::GL_LINES, &indices_lines, "LINES")?;
        result &= test_draw_elements(
            context,
            active_program,
            glw::GL_LINE_STRIP,
            &indices_lines,
            "LINE_STRIP",
        )?;
        result &= test_draw_elements(context, active_program, glw::GL_LINE_LOOP, &indices_lines, "LINE_LOOP")?;
        result &= test_draw_elements(
            context,
            active_program,
            glw::GL_TRIANGLE_STRIP,
            &TRIANGLES,
            "TRIANGLE_STRIP",
        )?;
        result &= test_draw_elements(
            context,
            active_program,
            glw::GL_TRIANGLE_FAN,
            &TRIANGLES,
            "TRIANGLE_FAN",
        )?;
        result &= test_draw_elements(context, active_program, glw::GL_TRIANGLES, &TRIANGLES, "TRIANGLES")?;

        if context.context_type().supports_core(3, 2) {
            // core geometry shader support
            result &= test_draw_elements(
                context,
                active_program,
                glw::GL_LINES_ADJACENCY,
                &indices_lines_adjacency,
                "LINES_ADJACENCY",
            )?;
            result &= test_draw_elements(
                context,
                active_program,
                glw::GL_LINE_STRIP_ADJACENCY,
                &indices_lines_adjacency,
                "LINE_STRIP_ADJACENCY",
            )?;
            result &= test_draw_elements(
                context,
                active_program,
                glw::GL_TRIANGLES_ADJACENCY,
                &indices_triangles_adjacency,
                "TRIANGLES_ADJACENCY",
            )?;
            result &= test_draw_elements(
                context,
                active_program,
                glw::GL_TRIANGLE_STRIP_ADJACENCY,
                &indices_triangles_adjacency,
                "TRIANGLE_STRIP_ADJACENCY",
            )?;
        }

        if let (true, Some(tess_program)) = (context.context_type().supports_core(4, 4), &tess_program) {
            let mut primitive_restart_for_patches_supported: glw::GLboolean = glw::FALSE;
            // SAFETY: one GLboolean out.
            unsafe {
                gl.get_booleanv(
                    glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
                    &mut primitive_restart_for_patches_supported,
                )
            };
            glu::expect_no_error(gl, "getBooleanv")?;

            if primitive_restart_for_patches_supported != glw::FALSE {
                result &= test_draw_elements(context, tess_program.program(), glw::GL_PATCHES, &TRIANGLES, "PATCHES")?;
            }
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `PrimitiveRestartTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("primitive_restart");
    group.add_child(Box::new(PrimitiveRestartModeTestCase) as Box<dyn TestCase>);
    group
}
