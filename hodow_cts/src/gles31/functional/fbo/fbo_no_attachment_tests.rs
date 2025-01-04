// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFboNoAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Both of the file's entry points are
// ported: `createFboNoAttachmentTests` (the `no_attachments` group) and
// `createFboNoAttachmentCompletenessTests` (the single `completeness.no_attachments`
// case).
//
// Upstream's `TestLog` messages are dropped, as everywhere else in this port - the
// verdict is what is compared against `deqp-gles31`, and a case that fails says which
// of the three occlusion queries disagreed through its own failure string instead.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, expect_no_error};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{IVec2, Random, TestError, TestOutcome, TestStatus};

/// `FboSpec`
#[derive(Debug, Clone, Copy)]
struct FboSpec {
    width: i32,
    height: i32,
    samples: i32,
}

impl FboSpec {
    const fn new(width: i32, height: i32, samples: i32) -> Self {
        Self { width, height, samples }
    }
}

/// `SizeCase::USE_MAXIMUM` - ask the implementation for the dimension instead of
/// naming one.
const USE_MAXIMUM: i32 = -1;

/// The quad both checks below render: two triangles covering the whole viewport.
const QUAD_POSITIONS: [f32; 12] = [1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0, -1.0];

const POSITION_ONLY_VERTEX_SOURCE: &str = concat!(
    "#version 310 es\n",
    "in layout(location = 0) highp vec2 a_position;\n\n",
    "void main()\n",
    "{\n",
    "    gl_Position = vec4(a_position, 0.0, 1.0);\n",
    "}\n"
);

/// Draws `QUAD_POSITIONS` once through attribute location 0, from a throwaway VAO and
/// buffer, exactly as both of upstream's checks do inline.
///
/// # Safety
/// A program that takes `a_position` at location 0 must be current.
unsafe fn draw_quad(gl: &glw::Functions) {
    let mut vertex_array: GLuint = 0;
    let mut vertex_buffer: GLuint = 0;

    // SAFETY: the caller has a current program; every object created here is deleted
    // again below.
    unsafe {
        gl.gen_vertex_arrays(1, &mut vertex_array);
        gl.bind_vertex_array(vertex_array);

        gl.gen_buffers(1, &mut vertex_buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer);
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(&QUAD_POSITIONS) as glw::GLsizeiptr,
            QUAD_POSITIONS.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        gl.enable_vertex_attrib_array(0);
        gl.vertex_attrib_pointer(
            0,
            2,
            glw::GL_FLOAT,
            glw::GL_FALSE as glw::GLboolean,
            0,
            std::ptr::null(),
        );

        gl.draw_arrays(glw::GL_TRIANGLES, 0, 6);

        gl.disable_vertex_attrib_array(0);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.bind_vertex_array(0);
        gl.delete_buffers(1, &vertex_buffer);
        gl.delete_vertex_arrays(1, &vertex_array);
    }
}

/// `checkFramebufferSize`
///
/// Renders the quad three times through a fragment shader that discards everything but
/// one pixel, and asks an occlusion query whether anything survived: at the last pixel
/// inside the framebuffer something must, one pixel past it in x or in y nothing may.
fn check_framebuffer_size(context: &Context, framebuffer: GLuint, size: IVec2) -> Result<bool, TestError> {
    let gl = context.gl();

    const FRAGMENT_SOURCE: &str = concat!(
        "#version 310 es\n",
        "uniform layout(location = 0) highp ivec2 u_expectedSize;\n",
        "out layout(location = 0) mediump vec4 f_color;\n\n",
        "void main()\n",
        "{\n",
        "    if (ivec2(gl_FragCoord.xy) != u_expectedSize) discard;\n",
        "    f_color = vec4(1.0, 0.5, 0.25, 1.0);\n",
        "}\n"
    );

    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(POSITION_ONLY_VERTEX_SOURCE, FRAGMENT_SOURCE),
    );
    let mut query: GLuint = 0;
    let mut inside_passed: GLuint = 0;
    let mut outside_x_passed: GLuint = 0;
    let mut outside_y_passed: GLuint = 0;

    if !program.is_ok() {
        return Err(TestError::Fail(
            "Failed to build the framebuffer size check program".to_string(),
        ));
    }

    // SAFETY: a built program, a framebuffer this case owns, and an oversized viewport
    // so that the viewport itself cannot be what limits rendering to the right size.
    unsafe {
        gl.use_program(program.program());
        gl.enable(glw::GL_DEPTH_TEST);
        gl.depth_func(glw::GL_ALWAYS);
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer);
        gl.viewport(0, 0, size.x() * 2, size.y() * 2);

        if gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "Framebuffer was not complete for the size check".to_string(),
            ));
        }

        // Render
        gl.gen_queries(1, &mut query);

        for (x, y, result) in [
            (size.x() - 1, size.y() - 1, &mut inside_passed),
            (size.x(), size.y() - 1, &mut outside_x_passed),
            (size.x() - 1, size.y(), &mut outside_y_passed),
        ] {
            gl.uniform_2i(0, x, y);
            gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, query);
            draw_quad(gl);
            gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            gl.get_query_objectuiv(query, glw::GL_QUERY_RESULT, result);
        }

        gl.delete_queries(1, &query);
    }

    expect_no_error(gl, "Query failed")?;

    Ok(inside_passed != 0 && outside_x_passed == 0 && outside_y_passed == 0)
}

/// `checkFramebufferRenderable`
fn check_framebuffer_renderable(context: &Context, framebuffer: GLuint, size: IVec2) -> Result<bool, TestError> {
    let gl = context.gl();

    const FRAGMENT_SOURCE: &str = concat!(
        "#version 310 es\n",
        "out layout(location = 0) mediump vec4 f_color;\n\n",
        "void main()\n",
        "{\n",
        "    f_color = vec4(1.0, 0.5, 0.25, 1.0);\n",
        "}\n"
    );

    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(POSITION_ONLY_VERTEX_SOURCE, FRAGMENT_SOURCE),
    );
    let mut query: GLuint = 0;

    if !program.is_ok() {
        return Err(TestError::Fail(
            "Failed to build the framebuffer renderable check program".to_string(),
        ));
    }

    // SAFETY: as in `check_framebuffer_size`, with the viewport at the framebuffer's
    // own size this time.
    let passed = unsafe {
        gl.use_program(program.program());
        gl.enable(glw::GL_DEPTH_TEST);
        gl.depth_func(glw::GL_ALWAYS);
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer);
        gl.viewport(0, 0, size.x(), size.y());

        if gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "Framebuffer was not complete for the renderable check".to_string(),
            ));
        }

        // Render
        gl.gen_queries(1, &mut query);
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, query);
        draw_quad(gl);
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);

        // Read
        let mut passed: GLuint = 0;
        gl.get_query_objectuiv(query, glw::GL_QUERY_RESULT, &mut passed);
        gl.delete_queries(1, &query);
        passed
    };

    expect_no_error(gl, "Query failed")?;

    Ok(passed != 0)
}

/// `FramebufferCompletenessCase`
struct FramebufferCompletenessCase {
    name: &'static str,
}

impl TestCase for FramebufferCompletenessCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut results = ResultCollector::new("");
        let mut framebuffer: GLuint = 0;

        // SAFETY: one framebuffer, created and deleted here, with no attachments by
        // construction - the state under test.
        unsafe {
            gl.gen_framebuffers(1, &mut framebuffer);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer);

            results.check(
                gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE,
                "Framebuffer was incorrectly reported as complete when it had no width, height or attachments",
            );

            gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, 16);
            results.check(
                gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE,
                "Framebuffer was incorrectly reported as complete when it only had a width",
            );

            gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT, 16);
            results.check(
                gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) == glw::GL_FRAMEBUFFER_COMPLETE,
                "Framebuffer not reported as complete when it had width and height set",
            );

            gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, 0);
            results.check(
                gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE,
                "Framebuffer was incorrectly reported as complete when it only had a height",
            );

            gl.delete_framebuffers(1, &framebuffer);
        }

        Ok(results.to_status())
    }
}

/// `SizeCase`
struct SizeCase {
    name: String,
    spec: FboSpec,
}

impl SizeCase {
    /// `SizeCase::getWidth` / `getHeight` / `getSamples` - one function here, since the
    /// three differ only in which limit they query.
    fn resolve(&self, gl: &glw::Functions, value: i32, maximum_pname: glw::GLenum) -> i32 {
        if value != USE_MAXIMUM {
            return value;
        }

        let mut maximum: GLint = 0;
        // SAFETY: an integer state query writing one integer.
        unsafe { gl.get_integerv(maximum_pname, &mut maximum) };
        maximum
    }
}

impl TestCase for SizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut framebuffer: GLuint = 0;
        let width = self.resolve(gl, self.spec.width, glw::GL_MAX_FRAMEBUFFER_WIDTH);
        let height = self.resolve(gl, self.spec.height, glw::GL_MAX_FRAMEBUFFER_HEIGHT);
        let mut samples = self.resolve(gl, self.spec.samples, glw::GL_MAX_FRAMEBUFFER_SAMPLES);

        loop {
            // SAFETY: a framebuffer this case owns, given default width/height/samples
            // and nothing else.
            let status = unsafe {
                gl.gen_framebuffers(1, &mut framebuffer);
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer);
                gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, width);
                gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT, height);
                gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES, samples);

                gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER)
            };

            if status == glw::GL_FRAMEBUFFER_COMPLETE {
                break;
            }

            // SAFETY: deleting the framebuffer created immediately above.
            unsafe { gl.delete_framebuffers(1, &framebuffer) };
            framebuffer = 0;

            if status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
                if samples >= 2 {
                    samples /= 2;
                } else {
                    break;
                }
            } else {
                return Ok(TestStatus::fail("Unexpected no-attachment framebuffer status"));
            }
        }

        if framebuffer == 0 {
            return Ok(TestStatus::fail(
                "Unable to find a supported no-attachment framebuffer width/height/samples",
            ));
        }

        let size = IVec2::new(width, height);
        let ok = check_framebuffer_renderable(context, framebuffer, size)?
            && check_framebuffer_size(context, framebuffer, size)?;

        // SAFETY: deleting this case's own framebuffer.
        unsafe { gl.delete_framebuffers(1, &framebuffer) };

        if ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Framebuffer did not behave as expected"))
        }
    }
}

/// `AttachmentInteractionCase`
struct AttachmentInteractionCase {
    name: String,
    default_spec: FboSpec,
    attachment_spec: FboSpec,
}

impl TestCase for AttachmentInteractionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut framebuffer: GLuint = 0;
        let mut renderbuffer: GLuint = 0;

        // SAFETY: a framebuffer and a renderbuffer this case owns; the defaults are set
        // to one size and an attachment of a different size is added, so that what the
        // two checks below see says which of the two won.
        unsafe {
            gl.gen_framebuffers(1, &mut framebuffer);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer);
            gl.framebuffer_parameteri(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_WIDTH,
                self.default_spec.width,
            );
            gl.framebuffer_parameteri(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT,
                self.default_spec.height,
            );
            gl.framebuffer_parameteri(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES,
                self.default_spec.samples,
            );

            gl.gen_renderbuffers(1, &mut renderbuffer);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer);
            gl.renderbuffer_storage_multisample(
                glw::GL_RENDERBUFFER,
                self.attachment_spec.samples,
                glw::GL_RGBA8,
                self.attachment_spec.width,
                self.attachment_spec.height,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                renderbuffer,
            );
        }

        let size = IVec2::new(self.attachment_spec.width, self.attachment_spec.height);
        let ok = check_framebuffer_renderable(context, framebuffer, size)?
            && check_framebuffer_size(context, framebuffer, size)?;

        // SAFETY: deleting this case's own objects.
        unsafe {
            gl.delete_renderbuffers(1, &renderbuffer);
            gl.delete_framebuffers(1, &framebuffer);
        }

        if ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Framebuffer did not behave as expected"))
        }
    }
}

fn add_size_case(group: &mut TestCaseGroup, name: String, spec: FboSpec) {
    group.add_child(Box::new(SizeCase { name, spec }) as Box<dyn TestCase>);
}

/// `createFboNoAttachmentTests`
pub fn create_tests() -> TestCaseGroup {
    const MAX_WIDTH: i32 = 2048; // MAX_FRAMEBUFFER_WIDTH in ES 3.1
    const MAX_HEIGHT: i32 = 2048; // MAX_FRAMEBUFFER_HEIGHT in ES 3.1
    const MAX_SAMPLES: i32 = 4;

    let mut root = TestCaseGroup::new("no_attachments");

    // Size
    {
        let mut group = TestCaseGroup::new("size");

        let mut width = 16;
        while width <= MAX_WIDTH {
            let mut height = 16;
            while height <= MAX_HEIGHT {
                add_size_case(&mut group, format!("{width}x{height}"), FboSpec::new(width, height, 0));
                height *= 4;
            }
            width *= 4;
        }

        root.add_child(group);
    }

    // NPOT size
    {
        const SPECS: &[FboSpec] = &[
            // Square
            FboSpec::new(1, 1, 0),
            FboSpec::new(3, 3, 0),
            FboSpec::new(15, 15, 0),
            FboSpec::new(17, 17, 0),
            FboSpec::new(31, 31, 0),
            FboSpec::new(33, 33, 0),
            FboSpec::new(63, 63, 0),
            FboSpec::new(65, 65, 0),
            FboSpec::new(127, 127, 0),
            FboSpec::new(129, 129, 0),
            FboSpec::new(255, 255, 0),
            FboSpec::new(257, 257, 0),
            FboSpec::new(511, 511, 0),
            FboSpec::new(513, 513, 0),
            FboSpec::new(1023, 1023, 0),
            FboSpec::new(1025, 1025, 0),
            FboSpec::new(2047, 2047, 0),
            // Non-square
            FboSpec::new(15, 511, 0),
            FboSpec::new(127, 15, 0),
            FboSpec::new(129, 127, 0),
            FboSpec::new(511, 127, 0),
            FboSpec::new(2047, 1025, 0),
        ];
        let mut group = TestCaseGroup::new("npot_size");

        for spec in SPECS {
            add_size_case(&mut group, format!("{}x{}", spec.width, spec.height), *spec);
        }

        root.add_child(group);
    }

    // Multisample
    {
        let mut group = TestCaseGroup::new("multisample");

        for samples in 0..=MAX_SAMPLES {
            add_size_case(&mut group, format!("samples{samples}"), FboSpec::new(128, 128, samples));
        }

        root.add_child(group);
    }

    // Randomized
    //
    // Upstream seeds this with `0xF0E1E2D3 ^ testCtx.getCommandLine().getBaseSeed()`;
    // there is no `--deqp-base-seed` equivalent here, and upstream's default for it is
    // 0, so the stream - and with it every case's size - is the one a plain
    // `deqp-gles31` run uses.
    {
        let mut group = TestCaseGroup::new("random");
        let mut rng = Random::new(0xF0E1_E2D3);

        for case_ndx in 0..16 {
            let width = rng.get_int(1, MAX_WIDTH);
            let height = rng.get_int(1, MAX_HEIGHT);
            let samples = rng.get_int(0, MAX_SAMPLES);

            add_size_case(&mut group, case_ndx.to_string(), FboSpec::new(width, height, samples));
        }

        root.add_child(group);
    }

    // Normal fbo with defaults set
    {
        const SPECS: &[[FboSpec; 2]] = &[
            [FboSpec::new(256, 256, 0), FboSpec::new(128, 128, 1)],
            [FboSpec::new(256, 256, 1), FboSpec::new(128, 128, 0)],
            [FboSpec::new(256, 256, 0), FboSpec::new(512, 512, 2)],
            [FboSpec::new(256, 256, 2), FboSpec::new(128, 512, 0)],
            [FboSpec::new(127, 127, 0), FboSpec::new(129, 129, 0)],
            [FboSpec::new(17, 512, 4), FboSpec::new(16, 16, 2)],
            [FboSpec::new(2048, 2048, 4), FboSpec::new(1, 1, 0)],
            [FboSpec::new(1, 1, 0), FboSpec::new(2048, 2048, 4)],
        ];
        let mut group = TestCaseGroup::new("interaction");

        for spec in SPECS {
            let base_spec = spec[0];
            let alt_spec = spec[1];
            let base_spec_name = format!("{}x{}ms{}", base_spec.width, base_spec.height, base_spec.samples);
            let alt_spec_name = format!("{}x{}ms{}", alt_spec.width, alt_spec.height, alt_spec.samples);
            let name = format!("{base_spec_name}_default_{alt_spec_name}");

            group.add_child(Box::new(AttachmentInteractionCase {
                name,
                default_spec: alt_spec,
                attachment_spec: base_spec,
            }) as Box<dyn TestCase>);
        }

        root.add_child(group);
    }

    // Maximums
    {
        let mut group = TestCaseGroup::new("maximums");

        add_size_case(&mut group, "width".to_string(), FboSpec::new(USE_MAXIMUM, 128, 0));
        add_size_case(&mut group, "height".to_string(), FboSpec::new(128, USE_MAXIMUM, 0));
        add_size_case(
            &mut group,
            "size".to_string(),
            FboSpec::new(USE_MAXIMUM, USE_MAXIMUM, 0),
        );
        add_size_case(&mut group, "samples".to_string(), FboSpec::new(128, 128, USE_MAXIMUM));
        add_size_case(
            &mut group,
            "all".to_string(),
            FboSpec::new(USE_MAXIMUM, USE_MAXIMUM, USE_MAXIMUM),
        );

        root.add_child(group);
    }

    root
}

/// `createFboNoAttachmentCompletenessTests`
pub fn create_completeness_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("completeness");
    group.add_child(Box::new(FramebufferCompletenessCase { name: "no_attachments" }) as Box<dyn TestCase>);
    group
}
