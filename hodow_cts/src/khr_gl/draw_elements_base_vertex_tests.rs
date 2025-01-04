// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/draw_elements_base_vertex/esextcDrawElementsBaseVertexTests.cpp
//   external/openglcts/modules/glesext/draw_elements_base_vertex/esextcDrawElementsBaseVertexTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop GL only: upstream skips every iteration that uses client-side index or vertex data when the context is not ES, so the `use_clientside_*` flags are always false here, the pointers upstream keeps in the test cases (`const GLuint *index_offset` and friends) are byte offsets into the one buffer object, and `valid_active_tf` ("this test doesn't apply to OpenGL contexts") ends as not supported. The twelve test classes are `Kind`s of one `DrawElementsBaseVertexTest`; the base class state is `Fixture`.

use std::ffi::c_void;
use std::mem::size_of_val;

use super::esext::{ExtParameters, TestCaseBase};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLintptr, GLsizei, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

static FUNCTIONAL_INDEX_DATA: [u32; 23] = [
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
];

static FUNCTIONAL2_INDEX_DATA: [u32; 40] = [
    10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 0, 1, 2, 3, 4, 5, 6, 7,
    8, 9, 10, 11, 12, 13, 14, 15, 16,
];

static FUNCTIONAL3_INDEX_DATA: [u8; 12] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

static FUNCTIONAL4_INDEX_DATA: [u16; 12] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

static FUNCTIONAL5_INDEX_DATA: [u32; 48] = [
    2147483650, 2147483651, 2147483652, 2147483653, 2147483654, 2147483655, 2147483656, 2147483657, 2147483658,
    2147483659, 2147483660, 2147483661, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 65537, 65538,
    65539, 65540, 65541, 65542, 65543, 65544, 65545, 65546, 65547, 65548, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
];

static FUNCTIONAL_COLOR_DATA: [f32; 66] = [
    0.1, 0.2, 0.2, 0.3, 0.3, 0.4, 0.4, 0.5, 0.5, 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 1.0, 1.0, 0.9, 0.9, 0.8, 0.8,
    0.7, 0.7, 0.6, 0.6, 0.5, 0.5, 0.4, 0.4, 0.3, 0.3, 0.2, 0.2, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.2, 0.2, 0.4, 0.3, 0.9,
    0.4, 0.8, 0.5, 1.0, 0.6, 0.8, 0.7, 0.1, 0.8, 0.3, 0.9, 0.5, 1.0, 0.0, 0.2, 0.0, 0.0, 0.3, 0.1, 1.0,
];

static FUNCTIONAL_VERTEX_DATA: [f32; 66] = [
    0.0, 0.0, -0.1, -0.1, 0.2, 0.8, -0.3, -0.3, 0.4, -0.4, 0.5, 0.5, -0.6, 0.6, 0.7, -0.7, -0.8, 0.8, 0.9, -0.9, -1.0,
    -1.0, 1.0, -1.0, 0.0, 1.0, -0.9, 0.1, 0.8, -0.2, -0.7, 0.3, -0.6, -0.4, 0.5, -0.5, -0.4, -0.6, 0.3, 0.7, -0.2,
    -0.8, -0.1, -0.9, 0.0, 0.0, 0.5, 0.5, -0.6, 0.6, 0.7, -0.7, -0.8, 0.8, 0.9, -0.9, -1.0, -1.0, 1.0, -1.0, 0.0, 1.0,
    -0.9, 0.1, 0.8, -0.2,
];

static FUNCTIONAL2_VERTEX_DATA: [f32; 46] = [
    -1.0, -1.0, 1.0, -1.0, 0.0, 1.0, 0.3, 0.3, 0.4, 0.4, 0.5, 0.5, 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 0.1, 0.2,
    0.2, 0.1, 0.1, 0.2, 0.9, 0.1, 0.8, 0.2, 0.7, 0.3, 0.6, 0.4, 0.5, 0.5, 0.4, 0.6, 0.3, 0.7, 0.2, 0.8, 0.1, 0.9, 0.0,
    0.0,
];

static NEGATIVE_INDEX_DATA: [u32; 3] = [0, 1, 2];

static NEGATIVE_VERTEX_DATA: [f32; 6] = [-1.0, -1.0, 1.0, -1.0, 0.0, 1.0];

const FUNCTIONAL_INDEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL_INDEX_DATA);
const FUNCTIONAL2_INDEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL2_INDEX_DATA);
const FUNCTIONAL3_INDEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL3_INDEX_DATA);
const FUNCTIONAL4_INDEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL4_INDEX_DATA);
const FUNCTIONAL5_INDEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL5_INDEX_DATA);
const FUNCTIONAL_COLOR_DATA_SIZE: usize = size_of_val(&FUNCTIONAL_COLOR_DATA);
const FUNCTIONAL_VERTEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL_VERTEX_DATA);
const FUNCTIONAL2_VERTEX_DATA_SIZE: usize = size_of_val(&FUNCTIONAL2_VERTEX_DATA);
const NEGATIVE_INDEX_DATA_SIZE: usize = size_of_val(&NEGATIVE_INDEX_DATA);
const NEGATIVE_VERTEX_DATA_SIZE: usize = size_of_val(&NEGATIVE_VERTEX_DATA);

/// `computeVBODataOffsets(false, false)`: byte offsets into the buffer object `setUpFunctionalTestObjects` fills (vertex, vertex2, index, index2, index3, index4, index5, color).
const INDEX_OFFSET: usize = FUNCTIONAL_VERTEX_DATA_SIZE + FUNCTIONAL2_VERTEX_DATA_SIZE;
const INDEX2_OFFSET: usize = INDEX_OFFSET + FUNCTIONAL_INDEX_DATA_SIZE;
const INDEX3_OFFSET: usize = INDEX2_OFFSET + FUNCTIONAL2_INDEX_DATA_SIZE;
const INDEX4_OFFSET: usize = INDEX3_OFFSET + FUNCTIONAL3_INDEX_DATA_SIZE;
const INDEX5_OFFSET: usize = INDEX4_OFFSET + FUNCTIONAL4_INDEX_DATA_SIZE;
const COLOR_OFFSET: usize = INDEX5_OFFSET + FUNCTIONAL5_INDEX_DATA_SIZE;
const VERTEX_OFFSET: usize = 0;
const U32_SIZE: usize = 4;

const TO_WIDTH: usize = 128;
const TO_HEIGHT: usize = 128;

/// `_function_type`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Function {
    DrawElementsBaseVertex,
    DrawElementsInstancedBaseVertex,
    DrawRangeElementsBaseVertex,
    MultiDrawElementsBaseVertex,
}

impl Function {
    const ALL: [Function; 4] = [
        Function::DrawElementsBaseVertex,
        Function::DrawElementsInstancedBaseVertex,
        Function::DrawRangeElementsBaseVertex,
        Function::MultiDrawElementsBaseVertex,
    ];

    /// `getFunctionName` for a GL context
    fn name(self) -> &'static str {
        match self {
            Function::DrawElementsBaseVertex => "glDrawElementsBaseVertex()",
            Function::DrawElementsInstancedBaseVertex => "glDrawElementsInstancedBaseVertex()",
            Function::DrawRangeElementsBaseVertex => "glDrawRangeElementsBaseVertex()",
            Function::MultiDrawElementsBaseVertex => "glMultiDrawElementsBaseVertex()",
        }
    }
}

/// `_test_case`; every `const GLuint *` of upstream is a byte offset into the element array buffer.
#[derive(Clone, Copy)]
struct Case {
    basevertex: GLint,
    function_type: Function,
    index_offset: usize,
    index_type: GLenum,
    range_start: GLuint,
    range_end: GLuint,
    multi_draw_call_count_array: [GLsizei; 3],
    multi_draw_call_indices_array: [usize; 3],
    primitive_mode: GLenum,
    regular_draw_call_offset: GLuint,
    regular_draw_call_offset2: usize,
    regular_draw_call_index_type: GLenum,
    regular_multi_draw_call_offseted_array: [usize; 3],
    should_base_texture_match_reference_texture: bool,
    use_geometry_shader_stage: bool,
    use_tessellation_shader_stage: bool,
    use_vertex_attrib_binding: bool,
    use_overflow_test_vertices: bool,
}

impl Case {
    fn new(function_type: Function) -> Self {
        Self {
            basevertex: 0,
            function_type,
            index_offset: 0,
            index_type: 0,
            range_start: 0,
            range_end: 0,
            multi_draw_call_count_array: [0; 3],
            multi_draw_call_indices_array: [0; 3],
            primitive_mode: GLenum::MAX,
            regular_draw_call_offset: 0,
            regular_draw_call_offset2: 0,
            regular_draw_call_index_type: 0,
            regular_multi_draw_call_offseted_array: [0; 3],
            should_base_texture_match_reference_texture: false,
            use_geometry_shader_stage: false,
            use_tessellation_shader_stage: false,
            use_vertex_attrib_binding: false,
            use_overflow_test_vertices: false,
        }
    }
}

#[derive(Clone, Copy)]
enum Kind {
    BasevertexBehavior1,
    BasevertexBehavior2,
    AepShaderStages,
    Underflow,
    Overflow,
    ValidActiveTf,
    InvalidCountArgument,
    InvalidInstanceCountArgument,
    InvalidModeArgument,
    InvalidPrimcountArgument,
    InvalidStartEndArguments,
    InvalidTypeArgument,
}

struct DrawElementsBaseVertexTest {
    name: &'static str,
    kind: Kind,
    ext_params: ExtParameters,
}

/// The GL objects of `DrawElementsBaseVertexTestBase`
struct Objects {
    bo_id: GLuint,
    bo_id_2: GLuint,
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    po_color_attribute_location: GLint,
    po_uses_gs_stage: bool,
    po_uses_tc_te_stages: bool,
    po_uses_vertex_attrib_binding: bool,
    po_vertex_attribute_location: GLint,
    tc_id: GLuint,
    te_id: GLuint,
    to_base_id: GLuint,
    to_ref_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

/// `DrawElementsBaseVertexTestBase` after `init`
struct Fixture {
    base: TestCaseBase,
    is_ext_multi_draw_arrays_supported: bool,
    is_geometry_shader_supported: bool,
    is_tessellation_shader_supported: bool,
    is_vertex_attrib_binding_supported: bool,
    o: Objects,
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

fn index_size_of(index_type: GLenum) -> Result<usize, TestError> {
    match index_type {
        glw::GL_UNSIGNED_BYTE => Ok(1),
        glw::GL_UNSIGNED_SHORT => Ok(2),
        glw::GL_UNSIGNED_INT => Ok(4),
        _ => Err(TestError::Fail("Unrecognized index type".to_string())),
    }
}

fn as_pointer(offset: usize) -> *const c_void {
    offset as *const c_void
}

const FUNCTIONAL_FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nin  vec4 FS_COLOR_INPUT_NAME;\nout vec4 result;\n\nvoid main()\n{\n    result = FS_COLOR_INPUT_NAME;\n}\n";

const FUNCTIONAL_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(triangles)                        in;\nlayout(triangle_strip, max_vertices = 3) out;\n\nin  vec4 GS_COLOR_INPUT_NAME[];\nout vec4 FS_COLOR_INPUT_NAME;\n\nvoid main()\n{\n    for (int n = 0; n < 3; ++n)\n    {\n        gl_Position         = vec4(gl_in[n].gl_Position.x, -gl_in[n].gl_Position.y, gl_in[n].gl_Position.zw);\n        FS_COLOR_INPUT_NAME = GS_COLOR_INPUT_NAME[n];\n\n        EmitVertex();\n    }\n\n    EndPrimitive();\n}\n";

const FUNCTIONAL_TC_CODE: &str = "${VERSION}\n${TESSELLATION_SHADER_REQUIRE}\n\nin  vec4 TC_COLOR_INPUT_NAME[];\nout vec4 TE_COLOR_INPUT_NAME[];\n\nlayout(vertices = 3) out;\n\nvoid main()\n{\n    gl_out             [gl_InvocationID].gl_Position = gl_in              [gl_InvocationID].gl_Position;\n    TE_COLOR_INPUT_NAME[gl_InvocationID]             = TC_COLOR_INPUT_NAME[gl_InvocationID];\n\n    gl_TessLevelInner[0] = 3.0;\n    gl_TessLevelOuter[0] = 3.0;\n    gl_TessLevelOuter[1] = 3.0;\n    gl_TessLevelOuter[2] = 3.0;\n}\n";

const FUNCTIONAL_TE_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(triangles, equal_spacing, cw) in;\n\nin  vec4 TE_COLOR_INPUT_NAME[];\nout vec4 TE_COLOR_OUTPUT_NAME;\n\nvoid main()\n{\n    vec2 p1 = gl_in[0].gl_Position.xy;\n    vec2 p2 = gl_in[1].gl_Position.xy;\n    vec2 p3 = gl_in[2].gl_Position.xy;\n\n    TE_COLOR_OUTPUT_NAME = TE_COLOR_INPUT_NAME[0] + TE_COLOR_INPUT_NAME[1] + TE_COLOR_INPUT_NAME[2];\n    gl_Position          = vec4(gl_TessCoord.x * p1.x + gl_TessCoord.y * p2.x + gl_TessCoord.z * p3.x,\n                                gl_TessCoord.x * p1.y + gl_TessCoord.y * p2.y + gl_TessCoord.z * p3.y,\n                                0.0,\n                                1.0);\n}\n";

const FUNCTIONAL_VS_CODE: &str = "${VERSION}\n\nout vec4 VS_COLOR_OUTPUT_NAME;\nin  vec4 vertex;\n\nOPTIONAL_USE_VERTEX_ATTRIB_BINDING_DEFINITIONS\n\nvoid main()\n{\n    float vertex_id_float = float(gl_VertexID);\n\n#ifdef USE_VERTEX_ATTRIB_BINDING\n    vec4  color           = in_color;\n#else\n    vec4  color           = vec4(vertex_id_float / 7.0,\n                                 vertex_id_float / 3.0,\n                                 vertex_id_float / 17.0,\n                                 1.0);\n#endif\n    float scale           = (gl_InstanceID == 0) ? 1.0 :\n                            (gl_InstanceID == 1) ? 0.8 :\n                                                   0.5;\n\n    VS_COLOR_OUTPUT_NAME = color;\n    gl_Position          = vec4(vertex.xy * scale, vertex.zw);\n}\n";

const NEGATIVE_FS_CODE: &str =
    "${VERSION}\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1.0);\n}\n";

const NEGATIVE_VS_CODE: &str = "${VERSION}\n\nin vec4 vertex;\n\nvoid main()\n{\n    gl_Position = vertex;\n}\n";

impl Fixture {
    /// `DrawElementsBaseVertexTestBase::init` (desktop branch)
    fn init(context: &Context, ext_params: ExtParameters) -> Result<Self, TestError> {
        let base = TestCaseBase::init(context, ext_params);
        let context_info = &context.context_info;

        let mut fixture = Self {
            base,
            is_ext_multi_draw_arrays_supported: false,
            is_geometry_shader_supported: false,
            is_tessellation_shader_supported: false,
            is_vertex_attrib_binding_supported: false,
            o: Objects {
                bo_id: 0,
                bo_id_2: 0,
                fbo_id: 0,
                fs_id: 0,
                gs_id: 0,
                po_id: 0,
                po_color_attribute_location: -1,
                po_uses_gs_stage: false,
                po_uses_tc_te_stages: false,
                po_uses_vertex_attrib_binding: false,
                po_vertex_attribute_location: -1,
                tc_id: 0,
                te_id: 0,
                to_base_id: 0,
                to_ref_id: 0,
                vao_id: 0,
                vs_id: 0,
            },
        };

        let is_draw_elements_base_vertex_supported =
            context_info.is_extension_supported("GL_ARB_draw_elements_base_vertex");
        if is_draw_elements_base_vertex_supported {
            // glMultiDrawElementsBaseVertex() is a part of the draw_elements_base_vertex extension in GL.
            fixture.is_ext_multi_draw_arrays_supported = true;
            fixture.is_vertex_attrib_binding_supported =
                context_info.is_extension_supported("GL_ARB_vertex_attrib_binding");
        }
        fixture.is_geometry_shader_supported = context_info.is_extension_supported("GL_ARB_geometry_shader4");
        fixture.is_tessellation_shader_supported = context_info.is_extension_supported("GL_ARB_tessellation_shader");

        if !is_draw_elements_base_vertex_supported {
            return Err(TestError::NotSupported(
                "draw_elements_base_vertex functionality is not supported".to_string(),
            ));
        }
        Ok(fixture)
    }

    /// `deinitProgramAndShaderObjects`
    fn deinit_program_and_shader_objects(&mut self, gl: &glw::Functions) {
        let o = &mut self.o;
        // SAFETY: deletes names this case created, on the current context.
        unsafe {
            if o.fs_id != 0 {
                gl.delete_shader(o.fs_id);
                o.fs_id = 0;
            }
            if o.gs_id != 0 {
                gl.delete_shader(o.gs_id);
                o.gs_id = 0;
            }
            if o.po_id != 0 {
                gl.delete_program(o.po_id);
                o.po_id = 0;
            }
            if o.tc_id != 0 {
                gl.delete_shader(o.tc_id);
                o.tc_id = 0;
            }
            if o.te_id != 0 {
                gl.delete_shader(o.te_id);
                o.te_id = 0;
            }
        }
    }

    /// `deinitPerTestObjects`
    fn deinit_per_test_objects(&mut self, gl: &glw::Functions) {
        self.deinit_program_and_shader_objects(gl);

        let o = &mut self.o;
        // SAFETY: deletes names this case created, on the current context.
        unsafe {
            if o.bo_id != 0 {
                gl.delete_buffers(1, &o.bo_id);
                o.bo_id = 0;
            }
            if o.bo_id_2 != 0 {
                gl.delete_buffers(1, &o.bo_id_2);
                o.bo_id_2 = 0;
            }
            if o.fbo_id != 0 {
                gl.delete_framebuffers(1, &o.fbo_id);
                o.fbo_id = 0;
            }
            if o.to_base_id != 0 {
                gl.delete_textures(1, &o.to_base_id);
                o.to_base_id = 0;
            }
            if o.to_ref_id != 0 {
                gl.delete_textures(1, &o.to_ref_id);
                o.to_ref_id = 0;
            }
            if o.vao_id != 0 {
                gl.delete_vertex_arrays(1, &o.vao_id);
                o.vao_id = 0;
            }
            if o.vs_id != 0 {
                gl.delete_shader(o.vs_id);
                o.vs_id = 0;
            }

            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
        }
    }

    /// `buildProgram`
    fn build_program(
        &mut self,
        context: &Context,
        fs_code: &str,
        vs_code: &str,
        tc_code: Option<&str>,
        te_code: Option<&str>,
        gs_code: Option<&str>,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let o = &mut self.o;

        // SAFETY: object creation on the current context.
        unsafe {
            o.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            o.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            if tc_code.is_some() {
                o.tc_id = gl.create_shader(glw::GL_TESS_CONTROL_SHADER);
            }
            if te_code.is_some() {
                o.te_id = gl.create_shader(glw::GL_TESS_EVALUATION_SHADER);
            }
            if gs_code.is_some() {
                o.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            }
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        // SAFETY: object creation on the current context.
        o.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let stages = [
            (o.fs_id, Some(fs_code)),
            (o.vs_id, Some(vs_code)),
            (o.tc_id, tc_code),
            (o.te_id, te_code),
            (o.gs_id, gs_code),
        ];
        for (shader_id, code) in stages {
            if let Some(code) = code {
                let pointer = code.as_ptr().cast::<glw::GLchar>();
                let length = code.len() as GLint;
                // SAFETY: the source outlives the call and its length is passed explicitly.
                unsafe { gl.shader_source(shader_id, 1, &pointer, &length) };
            }
        }
        glu::expect_no_error(gl, "glShaderSource() call(s) failed.")?;

        for (shader_id, _) in stages {
            if shader_id == 0 {
                continue;
            }
            let mut compile_status: GLint = glw::GL_FALSE as GLint;
            gl_call!(gl, "glCompileShader() call failed", gl.compile_shader(shader_id));
            gl_call!(
                gl,
                "glGetShaderiv() call failed.",
                gl.get_shaderiv(shader_id, glw::GL_COMPILE_STATUS, &mut compile_status)
            );
            if compile_status == glw::GL_FALSE as GLint {
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }
        }

        for (shader_id, _) in stages {
            if shader_id != 0 {
                // SAFETY: a program and a shader object this case created.
                unsafe { gl.attach_shader(o.po_id, shader_id) };
            }
        }
        glu::expect_no_error(gl, "glAttachShader() call failed.")?;

        let tf_varyings = [c"gl_Position".as_ptr()];
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed.",
            gl.transform_feedback_varyings(o.po_id, 1, tf_varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS)
        );

        let mut link_status: GLint = glw::GL_FALSE as GLint;
        gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(o.po_id));
        gl_call!(
            gl,
            "glGetProgramiv() call failed.",
            gl.get_programiv(o.po_id, glw::GL_LINK_STATUS, &mut link_status)
        );
        if link_status == glw::GL_FALSE as GLint {
            return Err(TestError::Fail("Program linking failed.".to_string()));
        }

        // SAFETY: a linked program and NUL-terminated names.
        unsafe {
            o.po_color_attribute_location = gl.get_attrib_location(o.po_id, c"in_color".as_ptr());
            o.po_vertex_attribute_location = gl.get_attrib_location(o.po_id, c"vertex".as_ptr());
        }
        Ok(())
    }

    /// `compareBaseAndReferenceTextures`
    fn compare_base_and_reference_textures(&self, gl: &glw::Functions, should_be_equal: bool) -> Result<(), TestError> {
        let mut base_data = vec![0u8; TO_WIDTH * TO_HEIGHT * 4];
        let mut ref_data = vec![0u8; TO_WIDTH * TO_HEIGHT * 4];

        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.o.to_base_id,
                0
            )
        );
        gl_call!(
            gl,
            "glReadPixels() call failed.",
            gl.read_pixels(
                0,
                0,
                TO_WIDTH as GLsizei,
                TO_HEIGHT as GLsizei,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                base_data.as_mut_ptr().cast()
            )
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.o.to_ref_id,
                0
            )
        );
        gl_call!(
            gl,
            "glReadPixels() call failed.",
            gl.read_pixels(
                0,
                0,
                TO_WIDTH as GLsizei,
                TO_HEIGHT as GLsizei,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                ref_data.as_mut_ptr().cast()
            )
        );

        let mut all_base_rgb_texels_zero = true;
        let mut all_reference_rgb_texels_zero = true;
        let mut textures_identical = true;

        for (n_texel, (base_texel, ref_texel)) in base_data.chunks_exact(4).zip(ref_data.chunks_exact(4)).enumerate() {
            if base_texel[0] != 0 || base_texel[1] != 0 || base_texel[2] != 0 {
                all_base_rgb_texels_zero = false;
            }
            if ref_texel[0] != 0 || ref_texel[1] != 0 || ref_texel[2] != 0 {
                all_reference_rgb_texels_zero = false;
            }

            if base_texel != ref_texel {
                if should_be_equal {
                    let y = n_texel / TO_WIDTH;
                    let x = n_texel % TO_WIDTH;
                    log::info!(
                        "Pixels at ({x}, {y}) do not match. Found:({}, {}, {}, {}), expected:({}, {}, {}, {}).",
                        base_texel[0],
                        base_texel[1],
                        base_texel[2],
                        base_texel[3],
                        ref_texel[0],
                        ref_texel[1],
                        ref_texel[2],
                        ref_texel[3]
                    );
                    return Err(TestError::Fail("Pixel mismatch".to_string()));
                }
                textures_identical = false;
            }
        }

        if all_base_rgb_texels_zero {
            return Err(TestError::Fail(
                "Draw call used to render contents of the base texture did not change the texture".to_string(),
            ));
        }
        if all_reference_rgb_texels_zero {
            return Err(TestError::Fail(
                "Draw call used to render contents of the reference texture did not change the texture".to_string(),
            ));
        }
        if !should_be_equal && textures_identical {
            return Err(TestError::Fail(
                "Textures are a match, even though they should not be identical.".to_string(),
            ));
        }
        Ok(())
    }

    /// `setUpFunctionalTestObjects` with `use_clientside_vertex_data` and `use_clientside_index_data` false
    #[allow(unused_assignments)]
    fn set_up_functional_test_objects(
        &mut self,
        context: &Context,
        use_tessellation_shader_stage: bool,
        use_geometry_shader_stage: bool,
        use_vertex_attrib_binding: bool,
        use_overflow_test_vertices: bool,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        gl_call!(gl, "glGenTextures() call(s) failed.", {
            gl.gen_textures(1, &mut self.o.to_base_id);
            gl.gen_textures(1, &mut self.o.to_ref_id);
        });

        for to_id in [self.o.to_base_id, self.o.to_ref_id] {
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, to_id)
            );
            gl_call!(
                gl,
                "glTexStorage2D() call failed.",
                gl.tex_storage_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    glw::GL_RGBA8,
                    TO_WIDTH as GLsizei,
                    TO_HEIGHT as GLsizei
                )
            );
        }

        gl_call!(
            gl,
            "glPixelStorei() call failed.",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1)
        );

        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut self.o.fbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebufer() call failed",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.o.fbo_id)
        );
        gl_call!(
            gl,
            "glViewport() call failed",
            gl.viewport(0, 0, TO_WIDTH as GLsizei, TO_HEIGHT as GLsizei)
        );

        if self.o.bo_id == 0 {
            let mut current_offset: usize = 0;

            gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.o.bo_id));
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.o.bo_id)
            );

            let total_size = FUNCTIONAL_INDEX_DATA_SIZE
                + FUNCTIONAL_VERTEX_DATA_SIZE
                + FUNCTIONAL2_VERTEX_DATA_SIZE
                + FUNCTIONAL2_INDEX_DATA_SIZE
                + FUNCTIONAL3_INDEX_DATA_SIZE
                + FUNCTIONAL4_INDEX_DATA_SIZE
                + FUNCTIONAL5_INDEX_DATA_SIZE
                + FUNCTIONAL_COLOR_DATA_SIZE;
            gl_call!(
                gl,
                "glBufferData() call failed.",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    total_size as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                )
            );

            let uploads: [(usize, *const c_void); 8] = [
                (FUNCTIONAL_VERTEX_DATA_SIZE, FUNCTIONAL_VERTEX_DATA.as_ptr().cast()),
                (FUNCTIONAL2_VERTEX_DATA_SIZE, FUNCTIONAL2_VERTEX_DATA.as_ptr().cast()),
                (FUNCTIONAL_INDEX_DATA_SIZE, FUNCTIONAL_INDEX_DATA.as_ptr().cast()),
                (FUNCTIONAL2_INDEX_DATA_SIZE, FUNCTIONAL2_INDEX_DATA.as_ptr().cast()),
                (FUNCTIONAL3_INDEX_DATA_SIZE, FUNCTIONAL3_INDEX_DATA.as_ptr().cast()),
                (FUNCTIONAL4_INDEX_DATA_SIZE, FUNCTIONAL4_INDEX_DATA.as_ptr().cast()),
                (FUNCTIONAL5_INDEX_DATA_SIZE, FUNCTIONAL5_INDEX_DATA.as_ptr().cast()),
                (FUNCTIONAL_COLOR_DATA_SIZE, FUNCTIONAL_COLOR_DATA.as_ptr().cast()),
            ];
            for (size, data) in uploads {
                // SAFETY: the data are statics of the stated size and the store was allocated large enough above.
                unsafe {
                    gl.buffer_sub_data(
                        glw::GL_ARRAY_BUFFER,
                        current_offset as GLintptr,
                        size as GLsizeiptr,
                        data,
                    )
                };
                current_offset += size;
            }
            glu::expect_no_error(gl, "glBufferSubData() call(s) failed.")?;
        }

        if use_overflow_test_vertices && self.o.bo_id_2 == 0 {
            gl_call!(gl, "glGenBuffers() call failed", gl.gen_buffers(1, &mut self.o.bo_id_2));

            // SAFETY: plain buffer calls on the buffer just generated.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.o.bo_id_2);
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    (2 * 65550 * size_of::<f32>()) as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW,
                );
            }
            glu::expect_no_error(gl, "glBufferData() call failed")?;

            // Upload to offset 0: regular draw call indices for making sure ubyte and ushort indices don't wrap around too early;
            // to offset 256: base draw call indices of type ubyte; to offset 65536: base draw call indices of type ushort.
            let bad_vtx: [f32; 24] = [
                0.9, 0.9, -0.9, 0.9, -0.9, -0.9, 0.9, -0.9, 0.9, 0.9, -0.9, 0.9, -0.9, -0.9, 0.9, -0.9, 0.9, 0.9, -0.9,
                0.9, -0.9, -0.9, 0.9, -0.9,
            ];
            // SAFETY: the sizes are those of the arrays and fit the store allocated above.
            unsafe {
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    0,
                    size_of_val(&bad_vtx) as GLsizeiptr,
                    bad_vtx.as_ptr().cast(),
                );
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    (2 * 256 * size_of::<f32>()) as GLintptr,
                    (2 * 12 * size_of::<f32>()) as GLsizeiptr,
                    FUNCTIONAL_VERTEX_DATA.as_ptr().cast(),
                );
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    (2 * 65536 * size_of::<f32>()) as GLintptr,
                    (2 * 12 * size_of::<f32>()) as GLsizeiptr,
                    FUNCTIONAL_VERTEX_DATA.as_ptr().cast(),
                );
            }
            glu::expect_no_error(gl, "glBufferSubData() call failed")?;
        }

        if self.o.po_id == 0
            || self.o.po_uses_gs_stage != use_geometry_shader_stage
            || self.o.po_uses_tc_te_stages != use_tessellation_shader_stage
            || self.o.po_uses_vertex_attrib_binding != use_vertex_attrib_binding
        {
            self.deinit_program_and_shader_objects(gl);

            let mut fs_body = self.base.specialize_shader(&[FUNCTIONAL_FS_CODE]);
            let mut gs_body = self.base.specialize_shader(&[FUNCTIONAL_GS_CODE]);
            let mut tc_body = self.base.specialize_shader(&[FUNCTIONAL_TC_CODE]);
            let mut te_body = self.base.specialize_shader(&[FUNCTIONAL_TE_CODE]);
            let mut vs_body = self.base.specialize_shader(&[FUNCTIONAL_VS_CODE]);

            let mut fs_color_input_name = "";
            let mut gs_color_input_name = "";
            let mut tc_color_input_name = "";
            let mut te_color_input_name = "";
            let mut te_color_output_name = "";
            let mut vs_color_output_name = "";
            let mut vs_optional_use_vertex_attrib_binding_definitions = "";

            if !use_tessellation_shader_stage {
                if !use_geometry_shader_stage {
                    vs_color_output_name = "out_vs_color";
                    fs_color_input_name = vs_color_output_name;

                    if use_vertex_attrib_binding {
                        vs_optional_use_vertex_attrib_binding_definitions =
                            "#define USE_VERTEX_ATTRIB_BINDING\nin vec4 in_color;\n";
                    }
                } else {
                    fs_color_input_name = "out_fs_color";
                    gs_color_input_name = "out_vs_color";
                    vs_color_output_name = "out_vs_color";
                }
            } else if !use_geometry_shader_stage {
                fs_color_input_name = "out_fs_color";
                tc_color_input_name = "out_vs_color";
                te_color_input_name = "out_tc_color";
                te_color_output_name = "out_fs_color";
                vs_color_output_name = "out_vs_color";
            } else {
                fs_color_input_name = "out_fs_color";
                gs_color_input_name = "out_te_color";
                tc_color_input_name = "out_vs_color";
                te_color_input_name = "out_tc_color";
                te_color_output_name = "out_te_color";
                vs_color_output_name = "out_vs_color";
            }

            let token_value_pairs = [
                ("FS_COLOR_INPUT_NAME", fs_color_input_name),
                ("GS_COLOR_INPUT_NAME", gs_color_input_name),
                ("TC_COLOR_INPUT_NAME", tc_color_input_name),
                ("TE_COLOR_INPUT_NAME", te_color_input_name),
                ("TE_COLOR_OUTPUT_NAME", te_color_output_name),
                ("VS_COLOR_OUTPUT_NAME", vs_color_output_name),
                (
                    "OPTIONAL_USE_VERTEX_ATTRIB_BINDING_DEFINITIONS",
                    vs_optional_use_vertex_attrib_binding_definitions,
                ),
            ];
            for body in [&mut fs_body, &mut gs_body, &mut tc_body, &mut te_body, &mut vs_body] {
                for (token, value) in token_value_pairs {
                    *body = body.replace(token, value);
                }
            }

            self.build_program(
                context,
                &fs_body,
                &vs_body,
                use_tessellation_shader_stage.then_some(tc_body.as_str()),
                use_tessellation_shader_stage.then_some(te_body.as_str()),
                use_geometry_shader_stage.then_some(gs_body.as_str()),
            )?;

            self.o.po_uses_gs_stage = use_geometry_shader_stage;
            self.o.po_uses_tc_te_stages = use_tessellation_shader_stage;
            self.o.po_uses_vertex_attrib_binding = use_vertex_attrib_binding;
        }

        if self.o.vao_id != 0 {
            gl_call!(
                gl,
                "glDeleteVertexArrays() call failed.",
                gl.delete_vertex_arrays(1, &self.o.vao_id)
            );
            self.o.vao_id = 0;
        }

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.o.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.o.vao_id)
        );

        if self.o.po_color_attribute_location != -1 {
            // SAFETY: a location the linked program reported.
            unsafe { gl.enable_vertex_attrib_array(self.o.po_color_attribute_location as GLuint) };
        }
        gl_call!(
            gl,
            "glEnableVertexAttribArray() call(s) failed.",
            gl.enable_vertex_attrib_array(self.o.po_vertex_attribute_location as GLuint)
        );

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.o.bo_id)
        );
        let vertex_bo_id = if use_overflow_test_vertices {
            self.o.bo_id_2
        } else {
            self.o.bo_id
        };
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_bo_id)
        );

        if !use_vertex_attrib_binding {
            gl_call!(
                gl,
                "glVertexAttribPointer() call failed.",
                gl.vertex_attrib_pointer(
                    self.o.po_vertex_attribute_location as GLuint,
                    2,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                    as_pointer(VERTEX_OFFSET)
                )
            );
        } else {
            // SAFETY: attribute locations the linked program reported.
            unsafe {
                gl.vertex_attrib_format(
                    self.o.po_color_attribute_location as GLuint,
                    2,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (COLOR_OFFSET - VERTEX_OFFSET) as GLuint,
                );
                gl.vertex_attrib_format(
                    self.o.po_vertex_attribute_location as GLuint,
                    2,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                );
            }
            glu::expect_no_error(gl, "glVertexAttribFormat() call(s) failed.")?;

            // SAFETY: as above.
            unsafe {
                gl.vertex_attrib_binding(self.o.po_color_attribute_location as GLuint, 0);
                gl.vertex_attrib_binding(self.o.po_vertex_attribute_location as GLuint, 0);
            }
            glu::expect_no_error(gl, "glVertexAttribBinding() call(s) failed.")?;

            gl_call!(
                gl,
                "glBindVertexBuffer() call failed.",
                gl.bind_vertex_buffer(
                    0,
                    vertex_bo_id,
                    VERTEX_OFFSET as GLintptr,
                    (size_of::<f32>() * 2) as GLsizei
                )
            );
        }

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.o.po_id));
        Ok(())
    }

    /// `setUpNegativeTestObjects` with `use_clientside_vertex_data` and `use_clientside_index_data` false; returns the `m_draw_call_index_offset` of the iteration.
    fn set_up_negative_test_objects(&mut self, context: &Context) -> Result<usize, TestError> {
        let gl = context.gl();

        if self.o.bo_id == 0 {
            gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.o.bo_id));
            gl_call!(
                gl,
                "glBindBuffer() call failed.",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.o.bo_id)
            );
            gl_call!(
                gl,
                "glBufferData() call failed.",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    (NEGATIVE_INDEX_DATA_SIZE + NEGATIVE_VERTEX_DATA_SIZE) as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW
                )
            );

            // SAFETY: the sizes are those of the statics and fit the store allocated above.
            unsafe {
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    0,
                    NEGATIVE_VERTEX_DATA_SIZE as GLsizeiptr,
                    NEGATIVE_VERTEX_DATA.as_ptr().cast(),
                );
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    NEGATIVE_VERTEX_DATA_SIZE as GLintptr,
                    NEGATIVE_INDEX_DATA_SIZE as GLsizeiptr,
                    NEGATIVE_INDEX_DATA.as_ptr().cast(),
                );
            }
            glu::expect_no_error(gl, "glBufferSubData() call(s) failed.")?;
        }

        let index_offset = NEGATIVE_VERTEX_DATA_SIZE;
        let vertex_offset = 0;

        if self.o.po_id == 0 {
            let fs_specialized_code = self.base.specialize_shader(&[NEGATIVE_FS_CODE]);
            let vs_specialized_code = self.base.specialize_shader(&[NEGATIVE_VS_CODE]);
            self.build_program(context, &fs_specialized_code, &vs_specialized_code, None, None, None)?;
        }

        if self.o.vao_id == 0 {
            gl_call!(
                gl,
                "glGenVertexArrays() call failed.",
                gl.gen_vertex_arrays(1, &mut self.o.vao_id)
            );
            gl_call!(
                gl,
                "glBindVertexArray() call failed.",
                gl.bind_vertex_array(self.o.vao_id)
            );
            gl_call!(
                gl,
                "glEnableVertexAttribArray() call failed.",
                gl.enable_vertex_attrib_array(self.o.po_vertex_attribute_location as GLuint)
            );
        }

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.o.bo_id)
        );
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.o.bo_id)
        );

        gl_call!(
            gl,
            "glVertexAttribPointer() call failed.",
            gl.vertex_attrib_pointer(
                self.o.po_vertex_attribute_location as GLuint,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                as_pointer(vertex_offset)
            )
        );

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.o.po_id));
        Ok(index_offset)
    }

    /// `executeTestCases`
    fn execute_test_cases(&mut self, context: &Context, test_cases: &[Case]) -> Result<(), TestError> {
        let gl = context.gl();

        for test_case in test_cases {
            let mut index_size = index_size_of(test_case.index_type)?;

            self.set_up_functional_test_objects(
                context,
                test_case.use_tessellation_shader_stage,
                test_case.use_geometry_shader_stage,
                test_case.use_vertex_attrib_binding,
                test_case.use_overflow_test_vertices,
            )?;

            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    self.o.to_base_id,
                    0
                )
            );
            gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            match test_case.function_type {
                Function::DrawElementsBaseVertex => {
                    // SAFETY: draws from the element array buffer bound by the set-up.
                    unsafe {
                        gl.draw_elements_base_vertex(
                            test_case.primitive_mode,
                            3,
                            test_case.index_type,
                            as_pointer(test_case.index_offset),
                            test_case.basevertex,
                        )
                    };
                }
                Function::DrawElementsInstancedBaseVertex => {
                    // SAFETY: as above.
                    unsafe {
                        gl.draw_elements_instanced_base_vertex(
                            test_case.primitive_mode,
                            3,
                            test_case.index_type,
                            as_pointer(test_case.index_offset),
                            3,
                            test_case.basevertex,
                        )
                    };
                }
                Function::DrawRangeElementsBaseVertex => {
                    // SAFETY: as above.
                    unsafe {
                        gl.draw_range_elements_base_vertex(
                            test_case.primitive_mode,
                            test_case.range_start,
                            test_case.range_end,
                            3,
                            test_case.index_type,
                            as_pointer(test_case.index_offset),
                            test_case.basevertex,
                        )
                    };
                }
                Function::MultiDrawElementsBaseVertex => {
                    let basevertex_array = [test_case.basevertex; 3];
                    let indices = test_case.multi_draw_call_indices_array.map(as_pointer);
                    // SAFETY: three counts, three index offsets and three basevertex values.
                    unsafe {
                        gl.multi_draw_elements_base_vertex(
                            test_case.primitive_mode,
                            test_case.multi_draw_call_count_array.as_ptr(),
                            test_case.index_type,
                            indices.as_ptr(),
                            3,
                            basevertex_array.as_ptr(),
                        )
                    };
                }
            }

            // SAFETY: plain error query.
            if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                return Err(TestError::Fail(format!(
                    "{} call failed",
                    test_case.function_type.name()
                )));
            }

            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    self.o.to_ref_id,
                    0
                )
            );
            gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            let mut regular_draw_call_index_type = test_case.index_type;
            if test_case.regular_draw_call_index_type != 0 {
                regular_draw_call_index_type = test_case.regular_draw_call_index_type;
                index_size = index_size_of(test_case.regular_draw_call_index_type)?;
            }

            let mut regular_draw_call_offset =
                test_case.index_offset + index_size * test_case.regular_draw_call_offset as usize;
            if test_case.use_overflow_test_vertices {
                regular_draw_call_offset = test_case.regular_draw_call_offset2;
            }

            match test_case.function_type {
                Function::DrawElementsBaseVertex | Function::DrawRangeElementsBaseVertex => {
                    gl_call!(
                        gl,
                        "glDrawElements() call failed",
                        gl.draw_elements(
                            test_case.primitive_mode,
                            3,
                            regular_draw_call_index_type,
                            as_pointer(regular_draw_call_offset)
                        )
                    );
                }
                Function::DrawElementsInstancedBaseVertex => {
                    gl_call!(
                        gl,
                        "glDrawElementsInstanced() call failed",
                        gl.draw_elements_instanced(
                            test_case.primitive_mode,
                            3,
                            regular_draw_call_index_type,
                            as_pointer(regular_draw_call_offset),
                            3
                        )
                    );
                }
                Function::MultiDrawElementsBaseVertex => {
                    for n_draw_call in 0..3 {
                        gl_call!(
                            gl,
                            "glDrawElements() call failed.",
                            gl.draw_elements(
                                test_case.primitive_mode,
                                test_case.multi_draw_call_count_array[n_draw_call],
                                regular_draw_call_index_type,
                                as_pointer(test_case.regular_multi_draw_call_offseted_array[n_draw_call])
                            )
                        );
                    }
                }
            }

            self.compare_base_and_reference_textures(gl, test_case.should_base_texture_match_reference_texture)?;

            self.deinit_per_test_objects(gl);
        }
        Ok(())
    }

    /// The rest of a negative test iteration: one call that has to fail with `expected_error` (`getError` is read once, as upstream does).
    fn expect_error(
        gl: &glw::Functions,
        function: Function,
        expected_error: GLenum,
        expected_name: &str,
    ) -> Result<(), TestError> {
        // SAFETY: plain error query.
        let error_code = unsafe { gl.get_error() };
        if error_code != expected_error {
            let message = format!("Invalid error code reported for an invalid {} call", function.name());
            log::info!("{message}: expected {expected_name}, got:[{error_code}]");
            return Err(TestError::Fail(message));
        }
        Ok(())
    }
}

/// `DrawElementsBaseVertexFunctionalCorrectBaseVertexBehavior::setUpTestCases`
fn set_up_basevertex_behavior1_test_cases(f: &Fixture) -> Vec<Case> {
    let mut test_cases = Vec::new();
    let basevertex_values: [GLint; 2] = [10, 0];

    for current_index_offset in [INDEX_OFFSET, INDEX2_OFFSET] {
        let n_index_offset = usize::from(current_index_offset == INDEX2_OFFSET);

        for function_type in Function::ALL {
            if !f.is_ext_multi_draw_arrays_supported && function_type == Function::MultiDrawElementsBaseVertex {
                continue;
            }

            for basevertex in basevertex_values {
                for use_vertex_attrib_binding in [false, true] {
                    if !f.is_vertex_attrib_binding_supported && use_vertex_attrib_binding {
                        continue;
                    }

                    let multi_draw_call_indices_array = [
                        current_index_offset,
                        current_index_offset + 3 * U32_SIZE,
                        current_index_offset + 9 * U32_SIZE,
                    ];
                    let regular_draw_call_offset = basevertex_values[0] as GLuint;
                    let regular_multi_draw_call_offseted_array = multi_draw_call_indices_array
                        .map(|offset| offset + regular_draw_call_offset as usize * U32_SIZE);

                    let mut new_test_case = Case::new(function_type);
                    new_test_case.basevertex = basevertex;
                    new_test_case.index_offset = current_index_offset;
                    new_test_case.range_start = if n_index_offset == 0 { 0 } else { 10 };
                    new_test_case.range_end = if n_index_offset == 0 { 22 } else { 32 };
                    new_test_case.index_type = glw::GL_UNSIGNED_INT;
                    new_test_case.primitive_mode = glw::GL_TRIANGLES;
                    new_test_case.regular_draw_call_offset = regular_draw_call_offset;
                    new_test_case.should_base_texture_match_reference_texture =
                        new_test_case.basevertex as GLuint == new_test_case.regular_draw_call_offset;
                    new_test_case.use_vertex_attrib_binding = use_vertex_attrib_binding;
                    new_test_case.multi_draw_call_count_array = [3, 6, 3];
                    new_test_case.multi_draw_call_indices_array = multi_draw_call_indices_array;
                    new_test_case.regular_multi_draw_call_offseted_array = regular_multi_draw_call_offseted_array;
                    test_cases.push(new_test_case);
                }
            }
        }
    }
    test_cases
}

/// `DrawElementsBaseVertexFunctionalCorrectBaseVertexBehavior2::setUpTestCases`
fn set_up_basevertex_behavior2_test_cases(f: &Fixture) -> Vec<Case> {
    let mut test_cases = Vec::new();
    let basevertex: GLint = 5;

    for function_type in Function::ALL {
        if !f.is_ext_multi_draw_arrays_supported && function_type == Function::MultiDrawElementsBaseVertex {
            continue;
        }

        let multi_draw_call_indices_array = [INDEX_OFFSET, INDEX_OFFSET + 3 * U32_SIZE, INDEX_OFFSET + 9 * U32_SIZE];
        let regular_draw_call_offset: GLuint = 0;
        let regular_multi_draw_call_offseted_array =
            multi_draw_call_indices_array.map(|offset| offset + regular_draw_call_offset as usize * U32_SIZE);

        let mut new_test_case = Case::new(function_type);
        new_test_case.basevertex = basevertex;
        new_test_case.index_offset = INDEX_OFFSET;
        new_test_case.range_start = 0;
        new_test_case.range_end = 22;
        new_test_case.index_type = glw::GL_UNSIGNED_INT;
        new_test_case.primitive_mode = glw::GL_TRIANGLES;
        new_test_case.regular_draw_call_offset = regular_draw_call_offset;
        new_test_case.should_base_texture_match_reference_texture =
            new_test_case.basevertex as GLuint == new_test_case.regular_draw_call_offset;
        new_test_case.multi_draw_call_count_array = [3, 6, 3];
        new_test_case.multi_draw_call_indices_array = multi_draw_call_indices_array;
        new_test_case.regular_multi_draw_call_offseted_array = regular_multi_draw_call_offseted_array;
        test_cases.push(new_test_case);
    }
    test_cases
}

/// `DrawElementsBaseVertexFunctionalCorrectBaseVertexBehaviorUnderflow::setUpTestCases`
fn set_up_underflow_test_cases(f: &Fixture) -> Vec<Case> {
    let mut test_cases = Vec::new();
    let basevertex: GLint = -10;

    for function_type in Function::ALL {
        if !f.is_ext_multi_draw_arrays_supported && function_type == Function::MultiDrawElementsBaseVertex {
            continue;
        }

        // this offset moves us from the start index of 10 to a zero index, given the second index data set
        let offset_from_10_to_0_index: usize = 23;

        let multi_draw_call_indices_array = [
            INDEX2_OFFSET,
            INDEX2_OFFSET + 3 * U32_SIZE,
            INDEX2_OFFSET + 9 * U32_SIZE,
        ];
        let regular_multi_draw_call_offseted_array =
            multi_draw_call_indices_array.map(|offset| offset + offset_from_10_to_0_index * U32_SIZE);

        let mut new_test_case = Case::new(function_type);
        new_test_case.basevertex = basevertex;
        new_test_case.index_offset = INDEX2_OFFSET;
        new_test_case.range_start = 10;
        new_test_case.range_end = 32;
        new_test_case.index_type = glw::GL_UNSIGNED_INT;
        new_test_case.primitive_mode = glw::GL_TRIANGLES;
        new_test_case.regular_draw_call_offset = offset_from_10_to_0_index as GLuint;
        new_test_case.should_base_texture_match_reference_texture = true;
        new_test_case.multi_draw_call_count_array = [3, 6, 3];
        new_test_case.multi_draw_call_indices_array = multi_draw_call_indices_array;
        new_test_case.regular_multi_draw_call_offseted_array = regular_multi_draw_call_offseted_array;
        test_cases.push(new_test_case);
    }
    test_cases
}

/// `DrawElementsBaseVertexFunctionalCorrectBaseVertexBehaviorOverflow::setUpTestCases`
fn set_up_overflow_test_cases(f: &Fixture) -> Result<Vec<Case>, TestError> {
    let mut test_cases = Vec::new();

    for function_type in Function::ALL {
        if !f.is_ext_multi_draw_arrays_supported && function_type == Function::MultiDrawElementsBaseVertex {
            continue;
        }

        for index_type in [glw::GL_UNSIGNED_BYTE, glw::GL_UNSIGNED_SHORT, glw::GL_UNSIGNED_INT] {
            for basevertex_delta in [0, 1] {
                let mut regular_draw_call_offset: GLuint = 0;
                let mut regular_draw_call_offset2: usize = 0;
                let basevertex: GLint;
                let index_offset: usize;
                let index_size: usize;
                let range_start: GLuint;
                let range_end: GLuint;
                let regular_draw_call_index_type: GLenum;
                let regular_draw_call_index_size: usize;
                let should_match: bool;
                let use_overflow_test_vertices: bool;

                match index_type {
                    // UBYTE base draw indices 0, 1, 2 with baseVertex 256+delta: ubyte indices do not wrap around at 8-bit width (delta 0, no match);
                    // with delta 1 the regular draw uses uint indices 257, 258, 259 and has to match.
                    glw::GL_UNSIGNED_BYTE => {
                        basevertex = 256 + basevertex_delta;
                        index_offset = INDEX3_OFFSET;
                        index_size = 1;
                        range_start = 0;
                        range_end = 2;
                        regular_draw_call_index_type = if basevertex_delta == 0 {
                            glw::GL_UNSIGNED_BYTE
                        } else {
                            glw::GL_UNSIGNED_INT
                        };
                        regular_draw_call_index_size = if regular_draw_call_index_type == glw::GL_UNSIGNED_BYTE {
                            1
                        } else {
                            4
                        };
                        regular_draw_call_offset2 = if basevertex_delta == 0 {
                            INDEX3_OFFSET
                        } else {
                            INDEX5_OFFSET + 12 * U32_SIZE
                        };
                        should_match = basevertex_delta == 1;
                        use_overflow_test_vertices = true;
                    }
                    // USHORT base draw indices 0, 1, 2 with baseVertex 65536+delta: as above for 16-bit width and uint indices 65537, 65538, 65539.
                    glw::GL_UNSIGNED_SHORT => {
                        basevertex = 65536 + basevertex_delta;
                        index_offset = INDEX4_OFFSET;
                        index_size = 2;
                        range_start = 0;
                        range_end = 2;
                        regular_draw_call_index_type = if basevertex_delta == 0 {
                            glw::GL_UNSIGNED_SHORT
                        } else {
                            glw::GL_UNSIGNED_INT
                        };
                        regular_draw_call_index_size = if regular_draw_call_index_type == glw::GL_UNSIGNED_SHORT {
                            2
                        } else {
                            4
                        };
                        regular_draw_call_offset2 = if basevertex_delta == 0 {
                            INDEX4_OFFSET
                        } else {
                            INDEX5_OFFSET + 24 * U32_SIZE
                        };
                        should_match = basevertex_delta == 1;
                        use_overflow_test_vertices = true;
                    }
                    // UINT base draw indices 2^31+2, 2^31+3, 2^31+4 with baseVertex 2^31-2+delta wrap to {0, 1, 2} (delta 0, match) or {1, 2, 3} (delta 1, no match).
                    glw::GL_UNSIGNED_INT => {
                        basevertex = 2147483647 - 1 + basevertex_delta;
                        index_offset = INDEX5_OFFSET;
                        index_size = 4;
                        range_start = 2147483647 + 3;
                        range_end = 2147483647 + 5;
                        regular_draw_call_index_type = glw::GL_UNSIGNED_INT;
                        regular_draw_call_index_size = 4;
                        regular_draw_call_offset = 36;
                        should_match = basevertex_delta == 0;
                        use_overflow_test_vertices = false;
                    }
                    _ => return Err(TestError::Fail("Unrecognized index type".to_string())),
                }

                let multi_draw_call_indices_array = [
                    index_offset,
                    index_offset + 3 * index_size,
                    index_offset + 9 * index_size,
                ];
                let regular_multi_draw_call_offseted_array = if use_overflow_test_vertices {
                    [
                        regular_draw_call_offset2,
                        regular_draw_call_offset2 + 3 * regular_draw_call_index_size,
                        regular_draw_call_offset2 + 9 * regular_draw_call_index_size,
                    ]
                } else {
                    multi_draw_call_indices_array.map(|offset| offset + index_size * regular_draw_call_offset as usize)
                };

                let mut new_test_case = Case::new(function_type);
                new_test_case.basevertex = basevertex;
                new_test_case.index_offset = index_offset;
                new_test_case.range_start = range_start;
                new_test_case.range_end = range_end;
                new_test_case.index_type = index_type;
                new_test_case.primitive_mode = glw::GL_TRIANGLES;
                new_test_case.regular_draw_call_offset = regular_draw_call_offset;
                new_test_case.regular_draw_call_offset2 = regular_draw_call_offset2;
                new_test_case.regular_draw_call_index_type = regular_draw_call_index_type;
                new_test_case.should_base_texture_match_reference_texture = should_match;
                new_test_case.use_overflow_test_vertices = use_overflow_test_vertices;
                new_test_case.multi_draw_call_count_array = [3, 6, 3];
                new_test_case.multi_draw_call_indices_array = multi_draw_call_indices_array;
                new_test_case.regular_multi_draw_call_offseted_array = regular_multi_draw_call_offseted_array;
                test_cases.push(new_test_case);
            }
        }
    }
    Ok(test_cases)
}

/// `DrawElementsBaseVertexFunctionalCorrectBaseVertexBehaviorAEPShaderStages::setUpTestCases`
fn set_up_aep_shader_stages_test_cases(f: &Fixture) -> Vec<Case> {
    let mut test_cases = Vec::new();
    let basevertex_values: [GLint; 2] = [10, 0];

    for (n_index_offset, current_index_offset) in [INDEX_OFFSET, INDEX2_OFFSET].into_iter().enumerate() {
        for function_type in Function::ALL {
            for basevertex in basevertex_values {
                for n_stage_combination in 0..4 {
                    let should_include_gs = (n_stage_combination & 1) != 0;
                    let should_include_tc_te = (n_stage_combination & 2) != 0;

                    if should_include_gs && !f.is_geometry_shader_supported {
                        continue;
                    }
                    if should_include_tc_te && !f.is_tessellation_shader_supported {
                        continue;
                    }
                    if !f.is_ext_multi_draw_arrays_supported && function_type == Function::MultiDrawElementsBaseVertex {
                        continue;
                    }

                    let multi_draw_call_indices_array = [
                        current_index_offset,
                        current_index_offset + 3 * U32_SIZE,
                        current_index_offset + 9 * U32_SIZE,
                    ];
                    let regular_draw_call_offset = basevertex_values[0] as GLuint;
                    let regular_multi_draw_call_offseted_array = multi_draw_call_indices_array
                        .map(|offset| offset + regular_draw_call_offset as usize * U32_SIZE);

                    let mut new_test_case = Case::new(function_type);
                    new_test_case.basevertex = basevertex;
                    new_test_case.index_offset = current_index_offset;
                    new_test_case.range_start = if n_index_offset == 0 { 0 } else { 10 };
                    new_test_case.range_end = if n_index_offset == 0 { 22 } else { 32 };
                    new_test_case.index_type = glw::GL_UNSIGNED_INT;
                    new_test_case.primitive_mode = if should_include_tc_te {
                        glw::GL_PATCHES
                    } else {
                        glw::GL_TRIANGLES
                    };
                    new_test_case.regular_draw_call_offset = regular_draw_call_offset;
                    new_test_case.should_base_texture_match_reference_texture =
                        new_test_case.basevertex as GLuint == new_test_case.regular_draw_call_offset;
                    new_test_case.use_geometry_shader_stage = should_include_gs;
                    new_test_case.use_tessellation_shader_stage = should_include_tc_te;
                    new_test_case.multi_draw_call_count_array = [3, 6, 3];
                    new_test_case.multi_draw_call_indices_array = multi_draw_call_indices_array;
                    new_test_case.regular_multi_draw_call_offseted_array = regular_multi_draw_call_offseted_array;
                    test_cases.push(new_test_case);
                }
            }
        }
    }
    test_cases
}

impl DrawElementsBaseVertexTest {
    /// `iterate` of the functional tests
    fn run_functional(&self, context: &Context, fixture: &mut Fixture) -> Result<(), TestError> {
        let test_cases = match self.kind {
            Kind::BasevertexBehavior1 => set_up_basevertex_behavior1_test_cases(fixture),
            Kind::BasevertexBehavior2 => set_up_basevertex_behavior2_test_cases(fixture),
            Kind::AepShaderStages => {
                if !fixture.is_geometry_shader_supported && !fixture.is_tessellation_shader_supported {
                    return Err(TestError::NotSupported(
                        "Geometry shader and tessellation shader functionality is not supported".to_string(),
                    ));
                }
                set_up_aep_shader_stages_test_cases(fixture)
            }
            Kind::Underflow => set_up_underflow_test_cases(fixture),
            Kind::Overflow => set_up_overflow_test_cases(fixture)?,
            _ => unreachable!("not a functional test"),
        };
        fixture.execute_test_cases(context, &test_cases)
    }

    /// `iterate` of the negative tests
    fn run_negative(&self, context: &Context, fixture: &mut Fixture) -> Result<(), TestError> {
        let gl = context.gl();

        // The four iterations of upstream differ only in the client-side data flags; all but the first are skipped for a GL context.
        let index_offset = as_pointer(fixture.set_up_negative_test_objects(context)?);
        let multi_draw = fixture.is_ext_multi_draw_arrays_supported;

        match self.kind {
            Kind::InvalidCountArgument => {
                // SAFETY: the calls are made to fail validation; the buffers bound by the set-up are live.
                unsafe { gl.draw_elements_base_vertex(glw::GL_TRIANGLES, -1, glw::GL_UNSIGNED_INT, index_offset, 0) };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;

                // SAFETY: as above; the start argument is upstream's -1.
                unsafe {
                    gl.draw_range_elements_base_vertex(
                        glw::GL_TRIANGLES,
                        -1i32 as GLuint,
                        2,
                        1,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        0,
                    )
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawRangeElementsBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;

                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_vertex(
                        glw::GL_TRIANGLES,
                        -1,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        1,
                        0,
                    )
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsInstancedBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;

                if multi_draw {
                    let count: GLsizei = -1;
                    let offsets = [index_offset];
                    // SAFETY: as above; upstream passes 0 (a null pointer) for the basevertex array.
                    unsafe {
                        gl.multi_draw_elements_base_vertex(
                            glw::GL_TRIANGLES,
                            &count,
                            glw::GL_UNSIGNED_INT,
                            offsets.as_ptr(),
                            1,
                            std::ptr::null(),
                        )
                    };
                    Fixture::expect_error(
                        gl,
                        Function::MultiDrawElementsBaseVertex,
                        glw::GL_INVALID_VALUE,
                        "GL_INVALID_VALUE",
                    )?;
                }
            }
            Kind::InvalidInstanceCountArgument => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_vertex(
                        glw::GL_TRIANGLES,
                        3,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        -1,
                        0,
                    )
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsInstancedBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;
            }
            Kind::InvalidModeArgument => {
                // SAFETY: as above.
                unsafe { gl.draw_elements_base_vertex(glw::GL_GREATER, 3, glw::GL_UNSIGNED_INT, index_offset, 0) };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                // SAFETY: as above.
                unsafe {
                    gl.draw_range_elements_base_vertex(glw::GL_GREATER, 0, 2, 3, glw::GL_UNSIGNED_INT, index_offset, 0)
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawRangeElementsBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_vertex(glw::GL_GREATER, 3, glw::GL_UNSIGNED_INT, index_offset, 1, 0)
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsInstancedBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                if multi_draw {
                    let count: GLsizei = 3;
                    let offsets = [index_offset];
                    // SAFETY: as above; the basevertex array is a null pointer as upstream's literal 0.
                    unsafe {
                        gl.multi_draw_elements_base_vertex(
                            glw::GL_GREATER,
                            &count,
                            glw::GL_UNSIGNED_INT,
                            offsets.as_ptr(),
                            1,
                            std::ptr::null(),
                        )
                    };
                    Fixture::expect_error(
                        gl,
                        Function::MultiDrawElementsBaseVertex,
                        glw::GL_INVALID_ENUM,
                        "GL_INVALID_ENUM",
                    )?;
                }
            }
            Kind::InvalidPrimcountArgument => {
                let count: GLsizei = 3;
                let offsets = [index_offset];
                // SAFETY: as above; the basevertex array is a null pointer as upstream's literal 0.
                unsafe {
                    gl.multi_draw_elements_base_vertex(
                        glw::GL_TRIANGLES,
                        &count,
                        glw::GL_UNSIGNED_INT,
                        offsets.as_ptr(),
                        -1,
                        std::ptr::null(),
                    )
                };
                Fixture::expect_error(
                    gl,
                    Function::MultiDrawElementsBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;
            }
            Kind::InvalidStartEndArguments => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_range_elements_base_vertex(
                        glw::GL_TRIANGLES,
                        3,
                        0,
                        3,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        0,
                    )
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawRangeElementsBaseVertex,
                    glw::GL_INVALID_VALUE,
                    "GL_INVALID_VALUE",
                )?;
            }
            Kind::InvalidTypeArgument => {
                // SAFETY: as above.
                unsafe { gl.draw_elements_base_vertex(glw::GL_TRIANGLES, 3, glw::GL_NONE, index_offset, 0) };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                // SAFETY: as above.
                unsafe {
                    gl.draw_range_elements_base_vertex(glw::GL_TRIANGLES, 0, 2, 3, glw::GL_NONE, index_offset, 0)
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawRangeElementsBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_vertex(glw::GL_TRIANGLES, 3, glw::GL_NONE, index_offset, 1, 0)
                };
                Fixture::expect_error(
                    gl,
                    Function::DrawElementsInstancedBaseVertex,
                    glw::GL_INVALID_ENUM,
                    "GL_INVALID_ENUM",
                )?;

                if multi_draw {
                    let count: GLsizei = 3;
                    let offsets = [index_offset];
                    // SAFETY: as above; the basevertex array is a null pointer as upstream's literal 0.
                    unsafe {
                        gl.multi_draw_elements_base_vertex(
                            glw::GL_TRIANGLES,
                            &count,
                            glw::GL_NONE,
                            offsets.as_ptr(),
                            1,
                            std::ptr::null(),
                        )
                    };
                    Fixture::expect_error(
                        gl,
                        Function::MultiDrawElementsBaseVertex,
                        glw::GL_INVALID_ENUM,
                        "GL_INVALID_ENUM",
                    )?;
                }
            }
            _ => unreachable!("not a negative test"),
        }
        Ok(())
    }
}

impl TestCase for DrawElementsBaseVertexTest {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fixture = Fixture::init(context, self.ext_params)?;

        let result = match self.kind {
            Kind::BasevertexBehavior1
            | Kind::BasevertexBehavior2
            | Kind::AepShaderStages
            | Kind::Underflow
            | Kind::Overflow => self.run_functional(context, &mut fixture),
            Kind::ValidActiveTf => Err(TestError::NotSupported("Not Supported".to_string())),
            _ => self.run_negative(context, &mut fixture),
        };
        fixture.deinit_per_test_objects(gl);

        result.map(|()| TestStatus::pass("Pass"))
    }
}

/// `DrawElementsBaseVertexTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_elements_base_vertex_tests");
    for (name, kind) in [
        ("basevertex_behavior1", Kind::BasevertexBehavior1),
        ("basevertex_behavior2", Kind::BasevertexBehavior2),
        ("AEP_shader_stages", Kind::AepShaderStages),
        ("underflow", Kind::Underflow),
        ("overflow", Kind::Overflow),
        ("valid_active_tf", Kind::ValidActiveTf),
        ("invalid_count_argument", Kind::InvalidCountArgument),
        ("invalid_instancecount_argument", Kind::InvalidInstanceCountArgument),
        ("invalid_mode_argument", Kind::InvalidModeArgument),
        ("invalid_primcount_argument", Kind::InvalidPrimcountArgument),
        ("invalid_start_end_arguments", Kind::InvalidStartEndArguments),
        ("invalid_type_argument", Kind::InvalidTypeArgument),
    ] {
        group.add_child(Box::new(DrawElementsBaseVertexTest { name, kind, ext_params }) as Box<dyn TestCase>);
    }
    group
}
