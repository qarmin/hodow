// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderInvarianceTests.cpp
//   modules/gles3/functional/es3fShaderInvarianceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's two files are the *same* file: diffing them turns up nothing but the
// module comment, the fragment shader (`gl_FragColor` against a declared `out`) and
// three of the sixteen `FormatArgument`s (`VERSION`, `IN`, `OUT`). Every one of the
// eleven shader-pair templates, all three precision rows and the whole `InvarianceTest`
// class are byte-identical, so this one file carries both and `Flavour` is those four
// differences - the same direction of reuse `gles3::shader_frag_data_tests` already
// takes from this module. A re-sync that touches one upstream file has to touch the
// other identically, and this arrangement is what makes that visible rather than
// leaving one copy silently behind.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{Random, StringTemplate, Surface, TestError, TestOutcome, TestResult, TestStatus};

/// The four things that differ between upstream's ES 2.0 and ES 3.0 copies.
#[derive(Clone, Copy)]
pub struct Flavour {
    /// `${VERSION}`
    version: &'static str,
    /// `${IN}`
    input: &'static str,
    /// `${OUT}`
    output: &'static str,
    /// `BasicInvarianceTest::s_basicFragmentShader`
    fragment_shader: &'static str,
}

/// `es2fShaderInvarianceTests.cpp`'s argument set and fragment shader.
pub const ES2: Flavour = Flavour {
    version: "",
    input: "attribute",
    output: "varying",
    fragment_shader: concat!(
        "uniform mediump vec4 u_color;\n",
        "varying mediump vec4 v_unrelated;\n",
        "void main ()\n",
        "{\n",
        "    mediump float blue = dot(v_unrelated, vec4(1.0, 1.0, 1.0, 1.0));\n",
        "    gl_FragColor = vec4(u_color.r, u_color.g, blue, u_color.a);\n",
        "}\n",
    ),
};

/// `es3fShaderInvarianceTests.cpp`'s argument set and fragment shader.
pub const ES3: Flavour = Flavour {
    version: "#version 300 es\n",
    input: "in",
    output: "out",
    fragment_shader: concat!(
        "#version 300 es\n",
        "layout(location = 0) out mediump vec4 fragColor;\n",
        "uniform mediump vec4 u_color;\n",
        "in mediump vec4 v_unrelated;\n",
        "void main ()\n",
        "{\n",
        "    mediump float blue = dot(v_unrelated, vec4(1.0, 1.0, 1.0, 1.0));\n",
        "    fragColor = vec4(u_color.r, u_color.g, blue, u_color.a);\n",
        "}\n",
    ),
};

/// `genRandomVector`
fn gen_random_vector(rnd: &mut Random) -> [f32; 4] {
    [
        rnd.get_float_range(-1.0, 1.0),
        rnd.get_float_range(-1.0, 1.0),
        rnd.get_float_range(-1.0, 1.0),
        rnd.get_float_range(0.2, 1.0),
    ]
}

/// `formatGLSL`
fn format_glsl(template: &str, args: &[(&str, String)]) -> String {
    StringTemplate::new(template)
        .specialize(args)
        .expect("every placeholder in the template has an argument")
}

/// `InvarianceTest` + `BasicInvarianceTest`
///
/// Vertex shader invariance test: draw a test pattern twice, each time with a different
/// shader. Both shaders set identical values to the invariant `gl_Position` using
/// identical expressions, so no fragment from the first pass may remain visible.
struct InvarianceTest {
    name: String,
    /// `ShaderPair::vertexShaderSource0`
    vertex_shader_0: String,
    /// `ShaderPair::vertexShaderSource1`
    vertex_shader_1: String,
    /// `ShaderPair::fragmentShaderSource0` and `...1`, which are the same source.
    fragment_shader: &'static str,
}

/// `m_renderSize`
const RENDER_SIZE: i32 = 256;

/// `numTriangles`
const NUM_TRIANGLES: usize = 72;

impl TestCase for InvarianceTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_context.render_target();

        // Invariance tests require drawing to the screen and reading back results.
        // Tests results are not reliable if the resolution is too small
        if render_target.width < RENDER_SIZE || render_target.height < RENDER_SIZE {
            return Err(TestError::NotSupported(format!(
                "Render target size must be at least {RENDER_SIZE}x{RENDER_SIZE}"
            )));
        }

        // Gen shaders
        let shader_0 = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(self.vertex_shader_0.clone(), self.fragment_shader),
        );
        if !shader_0.is_ok() {
            return Err(TestError::Fail("Test shader compile failed.".to_string()));
        }
        let shader_1 = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(self.vertex_shader_1.clone(), self.fragment_shader),
        );
        if !shader_1.is_ok() {
            return Err(TestError::Fail("Test shader compile failed.".to_string()));
        }

        // Gen test pattern
        let mut rnd = Random::new(123);
        let mut triangles = [[0.0f32; 4]; NUM_TRIANGLES * 3 * 2];

        // Narrow triangle pattern
        for tri_ndx in 0..NUM_TRIANGLES {
            let vertex1 = gen_random_vector(&mut rnd);
            let vertex2 = gen_random_vector(&mut rnd);
            let offset = gen_random_vector(&mut rnd);
            // generate narrow triangles
            let vertex3 = std::array::from_fn(|i| offset[i].mul_add(0.01, vertex2[i]));

            triangles[tri_ndx * 3] = vertex1;
            triangles[tri_ndx * 3 + 1] = vertex2;
            triangles[tri_ndx * 3 + 2] = vertex3;
        }

        // Normal triangle pattern
        for tri_ndx in 0..NUM_TRIANGLES {
            triangles[(NUM_TRIANGLES + tri_ndx) * 3] = gen_random_vector(&mut rnd);
            triangles[(NUM_TRIANGLES + tri_ndx) * 3 + 1] = gen_random_vector(&mut rnd);
            triangles[(NUM_TRIANGLES + tri_ndx) * 3 + 2] = gen_random_vector(&mut rnd);
        }

        #[expect(clippy::cast_possible_wrap, reason = "432 vec4 is 6912 bytes")]
        let buffer_size = std::mem::size_of_val(&triangles) as GLsizeiptr;
        let mut array_buf: GLuint = 0;
        // SAFETY: one name in, one name out, deleted before this function returns; the
        // upload size is the array's own.
        unsafe {
            gl.gen_buffers(1, &raw mut array_buf);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf);
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                buffer_size,
                triangles.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "buffer gen")?;

        #[expect(clippy::cast_possible_wrap, reason = "216 vertices")]
        let vertices_in_pattern = (NUM_TRIANGLES * 3) as GLint;
        let result = self.run(context, &shader_0, &shader_1, array_buf, vertices_in_pattern);

        // SAFETY: a name this function created.
        unsafe { gl.delete_buffers(1, &raw const array_buf) };

        result
    }
}

impl InvarianceTest {
    /// `InvarianceTest::iterate`, after `init` has built the shaders and the pattern.
    fn run(
        &self,
        context: &Context,
        shader_0: &ShaderProgram<'_>,
        shader_1: &ShaderProgram<'_>,
        array_buf: GLuint,
        vertices_in_pattern: GLint,
    ) -> TestOutcome {
        let gl = context.gl();
        let depth_buffer_exists = context.render_context.render_target().depth_bits != 0;
        let mut result_surface = Surface::new(RENDER_SIZE, RENDER_SIZE);
        let mut error = false;

        // Prepare draw
        // SAFETY: plain state setters on a current context, and a buffer this case owns.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.viewport(0, 0, RENDER_SIZE, RENDER_SIZE);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf);
        }
        glu::expect_no_error(gl, "setup draw")?;

        log::debug!("Testing position invariance.");

        // Draw position check passes
        for pass_ndx in 0..2 {
            let shader = if pass_ndx == 0 { shader_0 } else { shader_1 };
            draw_pass(gl, shader, pass_ndx, None, 0, vertices_in_pattern);
            glu::expect_no_error(gl, "draw pass")?;
        }

        // Read result
        glu::read_pixels(&context.render_context, 0, 0, &mut result_surface.get_access())?;

        // Check there are no red pixels
        log::debug!("Verifying output. Expecting only green or background colored pixels.");
        error |= !check_image(&result_surface);

        if depth_buffer_exists {
            // Test with Z-test
            // SAFETY: as above.
            unsafe {
                gl.clear_depthf(1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
                gl.enable(glw::GL_DEPTH_TEST);
            }

            log::debug!("Testing position invariance with z-test. Enabling GL_DEPTH_TEST.");

            // Draw position check passes
            for pass_ndx in 0..2 {
                let shader = if pass_ndx == 0 { shader_0 } else { shader_1 };
                let depth_func = if pass_ndx == 0 { glw::GL_ALWAYS } else { glw::GL_EQUAL };
                // !< buffer contains 2 vertices_in_pattern-sized patterns
                draw_pass(
                    gl,
                    shader,
                    pass_ndx,
                    Some(depth_func),
                    vertices_in_pattern,
                    vertices_in_pattern,
                );
                glu::expect_no_error(gl, "draw pass")?;
            }

            // Read result
            glu::read_pixels(&context.render_context, 0, 0, &mut result_surface.get_access())?;

            // Check there are no red pixels
            log::debug!("Verifying output. Expecting only green or background colored pixels.");
            error |= !check_image(&result_surface);
        } else {
            log::debug!("Depth buffer not available, skipping z-test.");
        }

        // Report result
        Ok(if error {
            TestStatus::new(TestResult::Fail, "Detected variance between two invariant values")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

/// One of the two draws each pass makes, identical in the plain and the Z-test loop
/// apart from the depth function and the range of the vertex buffer.
fn draw_pass(
    gl: &glw::Functions,
    shader: &ShaderProgram<'_>,
    pass_ndx: i32,
    depth_func: Option<glw::GLenum>,
    first: GLint,
    count: GLint,
) {
    const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
    const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
    let color = if pass_ndx == 0 { RED } else { GREEN };

    // SAFETY: a linked program, the attribute/uniform it declares, and the buffer bound
    // by the caller; `first + count` stays inside it.
    unsafe {
        let position_loc = gl.get_attrib_location(shader.program(), c"a_input".as_ptr());
        let color_loc = gl.get_uniform_location(shader.program(), c"u_color".as_ptr());

        gl.use_program(shader.program());
        gl.uniform_4fv(color_loc, 1, color.as_ptr());
        if let Some(func) = depth_func {
            gl.depth_func(func);
        }
        #[expect(clippy::cast_possible_wrap, reason = "a vec4 is 16 bytes")]
        let stride = size_of::<[f32; 4]>() as GLint;
        #[expect(clippy::cast_sign_loss, reason = "the driver rejects a negative location itself")]
        let position_loc_u = position_loc as GLuint;
        gl.enable_vertex_attrib_array(position_loc_u);
        gl.vertex_attrib_pointer(position_loc_u, 4, glw::GL_FLOAT, glw::FALSE, stride, std::ptr::null());
        gl.draw_arrays(glw::GL_TRIANGLES, first, count);
        gl.disable_vertex_attrib_array(position_loc_u);
    }
}

/// `InvarianceTest::checkImage` - the error mask upstream also writes to the log is
/// dropped, since this port has no image log.
fn check_image(surface: &Surface) -> bool {
    let mut error = false;

    for y in 0..RENDER_SIZE {
        for x in 0..RENDER_SIZE {
            if surface.get_pixel(x, y).get_red() != 0 {
                error = true;
            }
        }
    }

    if error {
        log::warn!("Invalid pixels found (fragments from first render pass found). Variance detected.");
        false
    } else {
        log::debug!("No variance found.");
        true
    }
}

/// `PrecisionCase` - the literals each precision row substitutes into the templates,
/// chosen so every one of them is representable in that precision.
struct PrecisionCase {
    /// `prec` - the `glu::Precision` value, i.e. the index into `PRECISION_NAMES`. It is
    /// not the row's own index: upstream's table runs highp, mediump, lowp while the
    /// enum runs lowp, mediump, highp, and the `subexpression_precision_*` cases compare
    /// the two precisions as enum values.
    prec: usize,
    name: &'static str,
    /// `highValue < maxValue`
    high_value: &'static str,
    inv_high_value: &'static str,
    /// `mediumValue^2 < maxValue`
    medium_value: &'static str,
    /// `lowValue^4 < maxValue`
    low_value: &'static str,
    inv_low_value: &'static str,
    loop_iterations: i32,
    loop_partial_iterations: i32,
    loop_normalization_exponent: i32,
    loop_normalization_constant_literal: &'static str,
    loop_multiplier: &'static str,
    sum_loop_normalization_constant_literal: &'static str,
}

/// `precisions`
const PRECISIONS: [PrecisionCase; 3] = [
    PrecisionCase {
        prec: 2,
        name: "highp",
        high_value: "1.0e20",
        inv_high_value: "1.0e-20",
        medium_value: "1.0e14",
        low_value: "1.0e9",
        inv_low_value: "1.0e-9",
        loop_iterations: 14,
        loop_partial_iterations: 11,
        loop_normalization_exponent: 2,
        loop_normalization_constant_literal: "1.0e4",
        loop_multiplier: "1.9",
        sum_loop_normalization_constant_literal: "1.0e3",
    },
    PrecisionCase {
        prec: 1,
        name: "mediump",
        high_value: "1.0e4",
        inv_high_value: "1.0e-4",
        medium_value: "1.0e2",
        low_value: "1.0e1",
        inv_low_value: "1.0e-1",
        loop_iterations: 13,
        loop_partial_iterations: 11,
        loop_normalization_exponent: 2,
        loop_normalization_constant_literal: "1.0e4",
        loop_multiplier: "1.9",
        sum_loop_normalization_constant_literal: "1.0e3",
    },
    PrecisionCase {
        prec: 0,
        name: "lowp",
        high_value: "0.9",
        inv_high_value: "1.1",
        medium_value: "1.1",
        low_value: "1.15",
        inv_low_value: "0.87",
        loop_iterations: 6,
        loop_partial_iterations: 2,
        loop_normalization_exponent: 0,
        loop_normalization_constant_literal: "2.0",
        loop_multiplier: "1.1",
        sum_loop_normalization_constant_literal: "1.0",
    },
];

/// `glu::Precision`, in upstream's declaration order - `precisionOther` iterates over it
/// from `PRECISION_LOWP` to `PRECISION_LAST`, and the comparison against the row's own
/// precision decides which literals the shared subexpression gets.
const PRECISION_NAMES: [&str; 3] = ["lowp", "mediump", "highp"];

/// The eleven shader-pair templates, in upstream's registration order. The four
/// `common_subexpression_*` and five `loop_*` ones take the row's arguments as they are;
/// `subexpression_precision_*` adds four of its own, which is why it is separate.
const COMMON_SUBEXPRESSION_TEMPLATES: [(&str, &str, &str); 4] = [
    (
        "common_subexpression_0",
        // First shader shares "${HIGH_VALUE}*a_input.x*a_input.xxxx + ${HIGH_VALUE}*a_input.y*a_input.yyyy" with unrelated output variable. Reordering might result in accuracy loss
        // due to the high exponent. In the second shader, the high exponent may be removed during compilation.
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    v_unrelated = a_input.xzxz + (${HIGH_VALUE}*a_input.x*a_input.xxxx + ${HIGH_VALUE}*a_input.y*a_input.yyyy) * (1.08 * a_input.zyzy * a_input.xzxz) * ${HIGH_VALUE_INV} * (a_input.z * a_input.zzxz - a_input.z * a_input.zzxz) + (${HIGH_VALUE}*a_input.x*a_input.xxxx + ${HIGH_VALUE}*a_input.y*a_input.yyyy) / ${HIGH_VALUE};\n",
            "    gl_Position = a_input + (${HIGH_VALUE}*a_input.x*a_input.xxxx + ${HIGH_VALUE}*a_input.y*a_input.yyyy) * ${HIGH_VALUE_INV};\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    gl_Position = a_input + (${HIGH_VALUE}*a_input.x*a_input.xxxx + ${HIGH_VALUE}*a_input.y*a_input.yyyy) * ${HIGH_VALUE_INV};\n",
            "}\n",
        ),
    ),
    (
        "common_subexpression_1",
        // In the first shader, the unrelated variable "d" has mathematically the same expression as "e", but the different
        // order of calculation might cause different results.
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 a = ${HIGH_VALUE} * a_input.zzxx + a_input.xzxy - ${HIGH_VALUE} * a_input.zzxx;\n",
            "    ${IN_PREC} vec4 b = ${HIGH_VALUE} * a_input.zzxx;\n",
            "    ${IN_PREC} vec4 c = b - ${HIGH_VALUE} * a_input.zzxx + a_input.xzxy;\n",
            "    ${IN_PREC} vec4 d = (${LOW_VALUE} * a_input.yzxx) * (${LOW_VALUE} * a_input.yzzw) * (1.1*${LOW_VALUE_INV} * a_input.yzxx) * (${LOW_VALUE_INV} * a_input.xzzy);\n",
            "    ${IN_PREC} vec4 e = ((${LOW_VALUE} * a_input.yzxx) * (1.1*${LOW_VALUE_INV} * a_input.yzxx)) * ((${LOW_VALUE_INV} * a_input.xzzy) * (${LOW_VALUE} * a_input.yzzw));\n",
            "    v_unrelated = a + b + c + d + e;\n",
            "    gl_Position = a_input + fract(c) + e;\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 b = ${HIGH_VALUE} * a_input.zzxx;\n",
            "    ${IN_PREC} vec4 c = b - ${HIGH_VALUE} * a_input.zzxx + a_input.xzxy;\n",
            "    ${IN_PREC} vec4 e = ((${LOW_VALUE} * a_input.yzxx) * (1.1*${LOW_VALUE_INV} * a_input.yzxx)) * ((${LOW_VALUE_INV} * a_input.xzzy) * (${LOW_VALUE} * a_input.yzzw));\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    gl_Position = a_input + fract(c) + e;\n",
            "}\n",
        ),
    ),
    (
        "common_subexpression_2",
        // Intermediate values used by an unrelated output variable
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 a = ${MEDIUM_VALUE} * (a_input.xxxx + a_input.yyyy);\n",
            "    ${IN_PREC} vec4 b = (${MEDIUM_VALUE} * (a_input.xxxx + a_input.yyyy)) * (${MEDIUM_VALUE} * (a_input.xxxx + a_input.yyyy)) / ${MEDIUM_VALUE} / ${MEDIUM_VALUE};\n",
            "    ${IN_PREC} vec4 c = a * a;\n",
            "    ${IN_PREC} vec4 d = c / ${MEDIUM_VALUE} / ${MEDIUM_VALUE};\n",
            "    v_unrelated = a + b + c + d;\n",
            "    gl_Position = a_input + d;\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 a = ${MEDIUM_VALUE} * (a_input.xxxx + a_input.yyyy);\n",
            "    ${IN_PREC} vec4 c = a * a;\n",
            "    ${IN_PREC} vec4 d = c / ${MEDIUM_VALUE} / ${MEDIUM_VALUE};\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    gl_Position = a_input + d;\n",
            "}\n",
        ),
    ),
    (
        "common_subexpression_3",
        // Invariant value can be calculated using unrelated value
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} float x = a_input.x * 0.2;\n",
            "    ${IN_PREC} vec4 a = a_input.xxyx * 0.7;\n",
            "    ${IN_PREC} vec4 b = a_input.yxyz * 0.7;\n",
            "    ${IN_PREC} vec4 c = a_input.zxyx * 0.5;\n",
            "    ${IN_PREC} vec4 f = x*a + x*b + x*c;\n",
            "    v_unrelated = f;\n",
            "    ${IN_PREC} vec4 g = x * (a + b + c);\n",
            "    gl_Position = a_input + g;\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} float x = a_input.x * 0.2;\n",
            "    ${IN_PREC} vec4 a = a_input.xxyx * 0.7;\n",
            "    ${IN_PREC} vec4 b = a_input.yxyz * 0.7;\n",
            "    ${IN_PREC} vec4 c = a_input.zxyx * 0.5;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    ${IN_PREC} vec4 g = x * (a + b + c);\n",
            "    gl_Position = a_input + g;\n",
            "}\n",
        ),
    ),
];

/// `subexpression_precision_*`
const SUBEXPRESSION_PRECISION_SHADER_0: &str = concat!(
    "${VERSION}",
    "${IN} ${IN_PREC} vec4 a_input;\n",
    "${OUT} ${UNRELATED_PREC} vec4 v_unrelated;\n",
    "invariant gl_Position;\n",
    "void main ()\n",
    "{\n",
    "    ${UNRELATED_PREC} vec4 unrelated0 = a_input + vec4(0.1, 0.2, 0.3, 0.4);\n",
    "    ${UNRELATED_PREC} vec4 unrelated1 = vec4(${MULTIPLIER}) * unrelated0.xywz + unrelated0;\n",
    "    ${UNRELATED_PREC} vec4 unrelated2 = refract(unrelated1, unrelated0, distance(unrelated0, unrelated1));\n",
    "    v_unrelated = a_input + 0.02 * ${NORMALIZE_UNRELATED};\n",
    "    ${IN_PREC} vec4 used0 = a_input + vec4(0.1, 0.2, 0.3, 0.4);\n",
    "    ${IN_PREC} vec4 used1 = vec4(${MULTIPLIER}) * used0.xywz + used0;\n",
    "    ${IN_PREC} vec4 used2 = refract(used1, used0, distance(used0, used1));\n",
    "    gl_Position = a_input + 0.02 * ${NORMALIZE_USED};\n",
    "}\n",
);

const SUBEXPRESSION_PRECISION_SHADER_1: &str = concat!(
    "${VERSION}",
    "${IN} ${IN_PREC} vec4 a_input;\n",
    "${OUT} ${UNRELATED_PREC} vec4 v_unrelated;\n",
    "invariant gl_Position;\n",
    "void main ()\n",
    "{\n",
    "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
    "    ${IN_PREC} vec4 used0 = a_input + vec4(0.1, 0.2, 0.3, 0.4);\n",
    "    ${IN_PREC} vec4 used1 = vec4(${MULTIPLIER}) * used0.xywz + used0;\n",
    "    ${IN_PREC} vec4 used2 = refract(used1, used0, distance(used0, used1));\n",
    "    gl_Position = a_input + 0.02 * ${NORMALIZE_USED};\n",
    "}\n",
);

/// `loop_0` .. `loop_4`
const LOOP_TEMPLATES: [(&str, &str, &str); 5] = [
    (
        "loop_0",
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} highp vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        v_unrelated += value;\n",
            "    }\n",
            "    gl_Position = vec4(value.xyz / ${LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} highp vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "    }\n",
            "    gl_Position = vec4(value.xyz / ${LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "}\n",
        ),
    ),
    (
        "loop_1",
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        if (i == ${LOOP_ITERS_PARTIAL})\n",
            "            v_unrelated = value;\n",
            "    }\n",
            "    gl_Position = vec4(value.xyz / ${LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "    }\n",
            "    gl_Position = vec4(value.xyz / ${LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "}\n",
        ),
    ),
    (
        "loop_2",
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, -1.0, 1.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        if (i == ${LOOP_ITERS_PARTIAL})\n",
            "            gl_Position = a_input + 0.05 * vec4(fract(value.xyz / 1.0e${LOOP_NORM_FRACT_EXP}), 1.0);\n",
            "        else\n",
            "            v_unrelated = value + a_input;\n",
            "    }\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, -1.0, 1.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        if (i == ${LOOP_ITERS_PARTIAL})\n",
            "            gl_Position = a_input + 0.05 * vec4(fract(value.xyz / 1.0e${LOOP_NORM_FRACT_EXP}), 1.0);\n",
            "        else\n",
            "            v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    }\n",
            "}\n",
        ),
    ),
    (
        "loop_3",
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        gl_Position += vec4(value.xyz / ${SUM_LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "        v_unrelated = gl_Position.xyzx * a_input;\n",
            "    }\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 value = a_input;\n",
            "    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value *= ${LOOP_MULTIPLIER};\n",
            "        gl_Position += vec4(value.xyz / ${SUM_LOOP_NORM_LITERAL} + a_input.xyz * 0.1, 1.0);\n",
            "    }\n",
            "}\n",
        ),
    ),
    (
        "loop_4",
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 position = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    ${IN_PREC} vec4 value1 = a_input;\n",
            "    ${IN_PREC} vec4 value2 = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value1 *= ${LOOP_MULTIPLIER};\n",
            "        v_unrelated = v_unrelated*1.3 + a_input.xyzx * value1.xyxw;\n",
            "    }\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value2 *= ${LOOP_MULTIPLIER};\n",
            "        position = position*1.3 + a_input.xyzx * value2.xyxw;\n",
            "    }\n",
            "    gl_Position = a_input + 0.05 * vec4(fract(position.xyz / 1.0e${LOOP_NORM_FRACT_EXP}), 1.0);\n",
            "}\n",
        ),
        concat!(
            "${VERSION}",
            "${IN} ${IN_PREC} vec4 a_input;\n",
            "${OUT} mediump vec4 v_unrelated;\n",
            "invariant gl_Position;\n",
            "void main ()\n",
            "{\n",
            "    ${IN_PREC} vec4 position = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    ${IN_PREC} vec4 value2 = a_input;\n",
            "    v_unrelated = vec4(0.0, 0.0, 0.0, 0.0);\n",
            "    for (mediump int i = 0; i < ${LOOP_ITERS}; ++i)\n",
            "    {\n",
            "        value2 *= ${LOOP_MULTIPLIER};\n",
            "        position = position*1.3 + a_input.xyzx * value2.xyxw;\n",
            "    }\n",
            "    gl_Position = a_input + 0.05 * vec4(fract(position.xyz / 1.0e${LOOP_NORM_FRACT_EXP}), 1.0);\n",
            "}\n",
        ),
    ),
];

/// `ShaderInvarianceTests::init`
pub fn create_tests(flavour: Flavour) -> TestCaseGroup {
    let mut root = TestCaseGroup::new("invariance");

    for precision in &PRECISIONS {
        let mut group = TestCaseGroup::new(precision.name);

        let args: Vec<(&str, String)> = vec![
            ("VERSION", flavour.version.to_string()),
            ("IN", flavour.input.to_string()),
            ("OUT", flavour.output.to_string()),
            ("IN_PREC", precision.name.to_string()),
            ("HIGH_VALUE", precision.high_value.to_string()),
            ("HIGH_VALUE_INV", precision.inv_high_value.to_string()),
            ("MEDIUM_VALUE", precision.medium_value.to_string()),
            ("LOW_VALUE", precision.low_value.to_string()),
            ("LOW_VALUE_INV", precision.inv_low_value.to_string()),
            ("LOOP_ITERS", precision.loop_iterations.to_string()),
            ("LOOP_ITERS_PARTIAL", precision.loop_partial_iterations.to_string()),
            ("LOOP_NORM_FRACT_EXP", precision.loop_normalization_exponent.to_string()),
            (
                "LOOP_NORM_LITERAL",
                precision.loop_normalization_constant_literal.to_string(),
            ),
            ("LOOP_MULTIPLIER", precision.loop_multiplier.to_string()),
            (
                "SUM_LOOP_NORM_LITERAL",
                precision.sum_loop_normalization_constant_literal.to_string(),
            ),
        ];

        // subexpression cases
        for (name, shader_0, shader_1) in COMMON_SUBEXPRESSION_TEMPLATES {
            group.add_child(Box::new(InvarianceTest {
                name: name.to_string(),
                vertex_shader_0: format_glsl(shader_0, &args),
                vertex_shader_1: format_glsl(shader_1, &args),
                fragment_shader: flavour.fragment_shader,
            }) as Box<dyn TestCase>);
        }

        // shared subexpression of different precision
        for (other_ndx, unrelated_prec) in PRECISION_NAMES.iter().enumerate() {
            // `PRECISION_NAMES` is upstream's `glu::Precision` order, so the *index*
            // comparison is upstream's `precisionOther < (int)precision`.
            let min_is_lowp = other_ndx.min(precision.prec) == 0;
            let multiplier_str = if min_is_lowp {
                "0.8, 0.4, -0.2, 0.3"
            } else {
                "1.0e1, 5.0e2, 2.0e2, 1.0"
            };
            let normalization_str_used = if min_is_lowp {
                "vec4(fract(used2).xyz, 0.0)"
            } else {
                "vec4(fract(used2 / 1.0e2).xyz - fract(used2 / 1.0e3).xyz, 0.0)"
            };
            let normalization_str_unrelated = if min_is_lowp {
                "vec4(fract(unrelated2).xyz, 0.0)"
            } else {
                "vec4(fract(unrelated2 / 1.0e2).xyz - fract(unrelated2 / 1.0e3).xyz, 0.0)"
            };

            let mut sub_args = args.clone();
            sub_args.push(("UNRELATED_PREC", (*unrelated_prec).to_string()));
            sub_args.push(("MULTIPLIER", multiplier_str.to_string()));
            sub_args.push(("NORMALIZE_USED", normalization_str_used.to_string()));
            sub_args.push(("NORMALIZE_UNRELATED", normalization_str_unrelated.to_string()));

            group.add_child(Box::new(InvarianceTest {
                name: format!("subexpression_precision_{unrelated_prec}"),
                vertex_shader_0: format_glsl(SUBEXPRESSION_PRECISION_SHADER_0, &sub_args),
                vertex_shader_1: format_glsl(SUBEXPRESSION_PRECISION_SHADER_1, &sub_args),
                fragment_shader: flavour.fragment_shader,
            }) as Box<dyn TestCase>);
        }

        // loops
        for (name, shader_0, shader_1) in LOOP_TEMPLATES {
            group.add_child(Box::new(InvarianceTest {
                name: name.to_string(),
                vertex_shader_0: format_glsl(shader_0, &args),
                vertex_shader_1: format_glsl(shader_1, &args),
                fragment_shader: flavour.fragment_shader,
            }) as Box<dyn TestCase>);
        }

        root.add_child(group);
    }

    root
}
