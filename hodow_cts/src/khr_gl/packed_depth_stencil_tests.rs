// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcPackedDepthStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`isContextES` is always false in the roots that register this group): the ES target/type/format tables, `esAttachmentParams` and the ES branches of `checkErrors`, `renderToTextures` and `BlitTest` are absent. `BaseTest` is `Base`, built by each case's `iterate`; its GL objects are deleted when it is dropped, so the explicit `destroyTextures` of the early-return paths is not needed. `glu::Shader` + manual link is `ShaderProgram`, which also fails on a link error that upstream ignores. The test classes are functions over `Base`, picked per case by `Kind`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// A GL call with a current context and pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const TEX_SIZE: i32 = 256;
const TOLERANCE_LOW: f64 = 0.48;
const TOLERANCE_HIGH: f64 = 0.52;
const EPSILON: f64 = 0.01;

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawMode {
    Default,
    DepthSpan1,
    DepthSpan2,
}

// Reference texture names for the described 5 textures and framebuffers and also for identifying other cases' reference textures
const PACKED_TEX_IMAGE: usize = 0;
const PACKED_TEX_RENDER: usize = 1;
const PACKED_TEX_RENDER_INIT_STENCIL: usize = 2;
const PACKED_TEX_RENDER_DEPTH_STEP: usize = 3;
const PACKED_TEX_RENDER_STENCIL_STEP: usize = 4;
const NUM_TEXTURES: usize = 5;
const VERIFY_COPY_TEX_IMAGE: usize = 6;
const VERIFY_PARTIAL_ATTACHMENTS: usize = 7;
const VERIFY_MIXED_ATTACHMENTS: usize = 8;
const VERIFY_CLEAR_BUFFER_DEPTH: usize = 9;
const VERIFY_CLEAR_BUFFER_STENCIL: usize = 10;
const VERIFY_CLEAR_BUFFER_DEPTH_STENCIL: usize = 11;
const VERIFY_BLIT: usize = 12;

#[derive(Clone, Copy, PartialEq, Eq)]
enum ColorFunction {
    Default,
    Depth,
    Stencil,
}

struct TypeFormat {
    type_: GLenum,
    format: GLenum,
    format_name: &'static str,
    size: usize,
    d: i32,
    s: i32,
}

const NUM_TEXTURE_TYPES: usize = 2;
static TEXTURE_TYPES: [TypeFormat; NUM_TEXTURE_TYPES] = [
    TypeFormat {
        type_: glw::GL_UNSIGNED_INT_24_8,
        format: glw::GL_DEPTH24_STENCIL8,
        format_name: "depth24_stencil8",
        size: 4,
        d: 24,
        s: 8,
    },
    TypeFormat {
        type_: glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
        format: glw::GL_DEPTH32F_STENCIL8,
        format_name: "depth32f_stencil8",
        size: 8,
        d: 32,
        s: 8,
    },
];

// Texture targets for initial state checking
const CORE_TEX_TARGETS: [GLenum; 25] = [
    glw::GL_TEXTURE_2D,
    glw::GL_TEXTURE_3D,
    glw::GL_TEXTURE_2D_ARRAY,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_1D,
    glw::GL_TEXTURE_1D_ARRAY,
    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
    glw::GL_TEXTURE_RECTANGLE,
    glw::GL_TEXTURE_2D_MULTISAMPLE,
    glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
    glw::GL_PROXY_TEXTURE_1D,
    glw::GL_PROXY_TEXTURE_2D,
    glw::GL_PROXY_TEXTURE_3D,
    glw::GL_PROXY_TEXTURE_1D_ARRAY,
    glw::GL_PROXY_TEXTURE_2D_ARRAY,
    glw::GL_PROXY_TEXTURE_CUBE_MAP_ARRAY,
    glw::GL_PROXY_TEXTURE_RECTANGLE,
    glw::GL_PROXY_TEXTURE_CUBE_MAP,
    glw::GL_PROXY_TEXTURE_2D_MULTISAMPLE,
    glw::GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY,
];

// Listing of non-depth_stencil types for error tests
const CORE_NON_DEPTH_STENCIL_TYPES: [GLenum; 22] = [
    glw::GL_UNSIGNED_BYTE,
    glw::GL_BYTE,
    glw::GL_UNSIGNED_SHORT,
    glw::GL_SHORT,
    glw::GL_UNSIGNED_INT,
    glw::GL_INT,
    glw::GL_HALF_FLOAT,
    glw::GL_FLOAT,
    glw::GL_UNSIGNED_SHORT_5_6_5,
    glw::GL_UNSIGNED_SHORT_4_4_4_4,
    glw::GL_UNSIGNED_SHORT_5_5_5_1,
    glw::GL_UNSIGNED_INT_2_10_10_10_REV,
    glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
    glw::GL_UNSIGNED_INT_5_9_9_9_REV,
    glw::GL_UNSIGNED_BYTE_3_3_2,
    glw::GL_UNSIGNED_BYTE_2_3_3_REV,
    glw::GL_UNSIGNED_SHORT_5_6_5_REV,
    glw::GL_UNSIGNED_SHORT_4_4_4_4_REV,
    glw::GL_UNSIGNED_SHORT_1_5_5_5_REV,
    glw::GL_UNSIGNED_INT_8_8_8_8,
    glw::GL_UNSIGNED_INT_8_8_8_8_REV,
    glw::GL_UNSIGNED_INT_10_10_10_2,
];

// Listing of non-depth_stencil formats for error tests
const CORE_NON_DEPTH_STENCIL_FORMATS: [GLenum; 17] = [
    glw::GL_STENCIL_INDEX,
    glw::GL_RED,
    glw::GL_GREEN,
    glw::GL_BLUE,
    glw::GL_RG,
    glw::GL_RGB,
    glw::GL_RGBA,
    glw::GL_BGR,
    glw::GL_BGRA,
    glw::GL_RED_INTEGER,
    glw::GL_GREEN_INTEGER,
    glw::GL_BLUE_INTEGER,
    glw::GL_RG_INTEGER,
    glw::GL_RGB_INTEGER,
    glw::GL_RGBA_INTEGER,
    glw::GL_BGR_INTEGER,
    glw::GL_BGRA_INTEGER,
];

// Listing of non-depth_stencil base formats for error tests
const CORE_OTHER_BASE_FORMATS: [GLenum; 4] = [glw::GL_RED, glw::GL_RG, glw::GL_RGB, glw::GL_RGBA];

struct AttachmentParam {
    pname: GLenum,
    value: i32,
}

const fn attachment_param(pname: GLenum, value: i32) -> AttachmentParam {
    AttachmentParam { pname, value }
}

const NUM_ATTACHMENT_PARAMS_CORE: usize = 13;
static CORE_ATTACHMENT_PARAMS: [[AttachmentParam; NUM_ATTACHMENT_PARAMS_CORE]; NUM_TEXTURE_TYPES] = [
    [
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE, 24),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE, 8),
        attachment_param(
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            glw::GL_UNSIGNED_NORMALIZED as i32,
        ),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING, glw::GL_LINEAR as i32),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME, -1),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED, 0),
    ],
    [
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE, 32),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE, 8),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE, glw::GL_FLOAT as i32),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING, glw::GL_LINEAR as i32),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME, -1),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER, 0),
        attachment_param(glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED, 0),
    ],
];

const COLOR_VS: &str = "\nprecision highp float;\nin vec4 pos;\nvoid main() {\n  gl_Position = pos;\n}\n";
const COLOR_FS: &str =
    "\nprecision highp float;\nout vec4 color;\nuniform vec4 uColor;\nvoid main() {\n  color = uColor;\n}\n";
const TEXTURE_VS: &str = "\nprecision highp float;\nin vec4 pos;\nin vec2 UV;\nout vec2 vUV;\nvoid main() {\n  gl_Position = pos;\n  vUV = UV;\n}\n";
const TEXTURE_FS: &str = "\nprecision highp float;\nin vec2 vUV;\nout vec4 color;\nuniform sampler2D tex;\nvoid main() {\n  color = texture(tex, vUV).rrra;\n}\n";
const STENCIL_FS: &str = "\nprecision highp float;\nin vec2 vUV;\nout vec4 color;\nuniform highp usampler2D tex;\nvoid main() {\n  float s = float(texture(tex, vUV).r);\n  s /= 255.0;\n  color = vec4(s, s, s, 1);\n}\n";

const VERTICES_DEFAULT: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];
const VERTICES_DEPTH_SPAN1: [f32; 16] = [
    -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
];
const VERTICES_DEPTH_SPAN2: [f32; 16] = [
    -1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0,
];
const TEX_COORDS: [f32; 8] = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];
const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

/// `BaseTest`
struct Base<'a> {
    context: &'a Context,
    gl: &'a glw::Functions,
    type_format: &'static TypeFormat,
    default_fbo: GLuint,
    draw_buffer: GLuint,
    read_buffer: GLuint,
    texture_program: Option<ShaderProgram<'a>>,
    color_program: Option<ShaderProgram<'a>>,
    stencil_program: Option<ShaderProgram<'a>>,
    textures: [GLuint; NUM_TEXTURES],
    framebuffers: [GLuint; NUM_TEXTURES],
}

impl Drop for Base<'_> {
    fn drop(&mut self) {
        self.destroy_textures();
    }
}

fn color_ref(channel: i32) -> u32 {
    0xff000000u32.wrapping_add((channel as u32).wrapping_mul(0x00010101))
}

impl<'a> Base<'a> {
    fn new(context: &'a Context, type_format: &'static TypeFormat) -> Self {
        Self {
            context,
            gl: context.gl(),
            type_format,
            default_fbo: 0,
            draw_buffer: glw::GL_COLOR_ATTACHMENT0,
            read_buffer: glw::GL_COLOR_ATTACHMENT0,
            texture_program: None,
            color_program: None,
            stencil_program: None,
            textures: [0; NUM_TEXTURES],
            framebuffers: [0; NUM_TEXTURES],
        }
    }

    /// `getAttachmentParams`
    fn attachment_params(&self) -> Res<&'static [AttachmentParam; NUM_ATTACHMENT_PARAMS_CORE]> {
        // find type index
        match TEXTURE_TYPES.iter().position(|t| t.format == self.type_format.format) {
            Some(index) => Ok(&CORE_ATTACHMENT_PARAMS[index]),
            None => Err(TestError::Fail("Missing attachment definition".to_string())),
        }
    }

    /// Creates a gradient texture data in the given type parameter format
    fn create_gradient(&self) -> Res<Vec<u8>> {
        let tex_size = TEX_SIZE as usize;
        match self.type_format.type_ {
            glw::GL_UNSIGNED_INT_24_8 => {
                let mut data = Vec::with_capacity(tex_size * tex_size * 4);
                for _j in 0..TEX_SIZE {
                    for i in 0..TEX_SIZE {
                        let d = (i as f32 / (TEX_SIZE - 1) as f32 * 0x00ffffff as f32) as u32;
                        let s = (i & 0xff) as u8;
                        data.extend_from_slice(&((d << 8).wrapping_add(u32::from(s))).to_ne_bytes());
                    }
                }
                Ok(data)
            }
            glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => {
                let mut data = Vec::with_capacity(tex_size * tex_size * 8);
                for _j in 0..TEX_SIZE {
                    for i in 0..TEX_SIZE {
                        data.extend_from_slice(&(i as f32 / (TEX_SIZE - 1) as f32).to_ne_bytes());
                        data.extend_from_slice(&((i & 0xff) as u32).to_ne_bytes());
                    }
                }
                Ok(data)
            }
            _ => Err(TestError::Fail("Unsuported type".to_string())),
        }
    }

    fn set_draw_read_buffer(&mut self, draw: GLenum, read: GLenum) -> Res<()> {
        let gl = self.gl;
        let mut draw_buffer: GLint = 0;
        gl!(gl.get_integerv(glw::GL_DRAW_BUFFER0, &mut draw_buffer));
        self.draw_buffer = draw_buffer as GLuint;

        let mut read_buffer: GLint = 0;
        gl!(gl.get_integerv(glw::GL_READ_BUFFER, &mut read_buffer));
        self.read_buffer = read_buffer as GLuint;

        gl!(gl.draw_buffers(1, &draw));
        gl!(gl.read_buffer(read));
        glu::expect_no_error(gl, "glReadBuffer")
    }

    fn restore_draw_read_buffer(&self) -> Res<()> {
        let gl = self.gl;
        gl!(gl.draw_buffers(1, &self.draw_buffer));
        gl!(gl.read_buffer(self.read_buffer));
        glu::expect_no_error(gl, "glReadBuffer")
    }

    /// Creates all the textures and framebuffers
    fn create_textures(&mut self) -> Res<()> {
        let gl = self.gl;
        let tf = self.type_format;
        gl!(gl.gen_textures(NUM_TEXTURES as i32, self.textures.as_mut_ptr()));
        gl!(gl.gen_framebuffers(NUM_TEXTURES as i32, self.framebuffers.as_mut_ptr()));

        // (index, initialised with the gradient)
        let layout = [
            (PACKED_TEX_IMAGE, true),
            (PACKED_TEX_RENDER, false),
            (PACKED_TEX_RENDER_INIT_STENCIL, true),
            (PACKED_TEX_RENDER_DEPTH_STEP, false),
            (PACKED_TEX_RENDER_STENCIL_STEP, false),
        ];
        for (index, with_gradient) in layout {
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffers[index]));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.textures[index]));
            self.setup_texture()?;
            let data = if with_gradient {
                Some(self.create_gradient()?)
            } else {
                None
            };
            let pixels = data.as_ref().map_or(std::ptr::null(), |d| d.as_ptr().cast());
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                tf.format as GLint,
                TEX_SIZE,
                TEX_SIZE,
                0,
                glw::GL_DEPTH_STENCIL,
                tf.type_,
                pixels
            ));
            gl!(gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_TEXTURE_2D,
                self.textures[index],
                0
            ));
            gl!(gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_TEXTURE_2D,
                self.textures[index],
                0
            ));
        }

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.default_fbo));
        glu::expect_no_error(gl, "glBindFramebuffer")
    }

    fn setup_texture(&self) -> Res<()> {
        let gl = self.gl;
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_CLAMP_TO_EDGE as GLint
        ));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_CLAMP_TO_EDGE as GLint
        ));
        glu::expect_no_error(gl, "glTexParameteri")
    }

    /// Destroys all the textures and framebuffers
    fn destroy_textures(&mut self) {
        let gl = self.gl;
        gl!(gl.delete_framebuffers(NUM_TEXTURES as i32, self.framebuffers.as_ptr()));
        gl!(gl.delete_textures(NUM_TEXTURES as i32, self.textures.as_ptr()));
        self.framebuffers = [0; NUM_TEXTURES];
        self.textures = [0; NUM_TEXTURES];
    }

    fn create_program(&self, vs_code: &str, fs_code: &str) -> Res<ShaderProgram<'a>> {
        let version = self.context.context_type().glsl_version().declaration();
        let sources = ProgramSources::vtx_frag(format!("{version}{vs_code}"), format!("{version}{fs_code}"));
        let program = ShaderProgram::new(self.gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail(
                "Shader compilation or program linking failed".to_string(),
            ));
        }
        Ok(program)
    }

    fn setup_color_program(&mut self) -> Res<GLint> {
        let gl = self.gl;

        // setup shader program
        if self.color_program.is_none() {
            self.color_program = Some(self.create_program(COLOR_VS, COLOR_FS)?);
        }
        let program = self.color_program_id();
        gl!(gl.use_program(program));

        // Setup program uniforms
        let u_color = gl!(gl.get_uniform_location(program, c"uColor".as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation")?;
        if u_color == -1 {
            return Err(TestError::Fail("Error getting uniform uColor".to_string()));
        }
        gl!(gl.uniform_4f(u_color, 1.0, 1.0, 1.0, 1.0));
        Ok(u_color)
    }

    fn color_program_id(&self) -> GLuint {
        self.color_program.as_ref().map_or(0, |p| p.program())
    }

    /// Common code for default and stencil texture rendering shaders
    fn set_texture_uniform(&self, program_id: GLuint) -> Res<bool> {
        let gl = self.gl;
        gl!(gl.use_program(program_id));
        let uniform_tex = gl!(gl.get_uniform_location(program_id, c"tex".as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation")?;
        if uniform_tex == -1 {
            log::info!("Error getting uniform tex");
            return Ok(false);
        }
        gl!(gl.uniform_1i(uniform_tex, 0));
        Ok(true)
    }

    /// Loads texture rendering shader
    fn setup_texture_program(&mut self) -> Res<bool> {
        if self.texture_program.is_none() {
            self.texture_program = Some(self.create_program(TEXTURE_VS, TEXTURE_FS)?);
        }
        let program = self.texture_program.as_ref().map_or(0, |p| p.program());
        self.set_texture_uniform(program)
    }

    /// Loads texture stencil rendering shader
    fn setup_stencil_program(&mut self) -> Res<bool> {
        if self.stencil_program.is_none() {
            self.stencil_program = Some(self.create_program(TEXTURE_VS, STENCIL_FS)?);
        }
        let program = self.stencil_program.as_ref().map_or(0, |p| p.program());
        self.set_texture_uniform(program)
    }

    fn texture_program_id(&self) -> GLuint {
        self.texture_program.as_ref().map_or(0, |p| p.program())
    }

    fn stencil_program_id(&self) -> GLuint {
        self.stencil_program.as_ref().map_or(0, |p| p.program())
    }

    fn draw_quad(&self, draw_mode: DrawMode, program: GLuint) -> Res<()> {
        let render_context = &self.context.render_context;
        let quad_primitive = pr::triangle_strip(&QUAD_INDICES);
        match draw_mode {
            DrawMode::DepthSpan1 => glu::draw(
                render_context,
                program,
                &[va::float("pos", 4, 4, 0, &VERTICES_DEPTH_SPAN1)],
                &quad_primitive,
            ),
            DrawMode::DepthSpan2 => glu::draw(
                render_context,
                program,
                &[va::float("pos", 4, 4, 0, &VERTICES_DEPTH_SPAN2)],
                &quad_primitive,
            ),
            DrawMode::Default => glu::draw(
                render_context,
                program,
                &[
                    va::float("pos", 4, 4, 0, &VERTICES_DEFAULT),
                    va::float("UV", 2, 4, 0, &TEX_COORDS),
                ],
                &quad_primitive,
            ),
        }
    }

    /// Renders all non-trivial startup textures
    fn render_to_textures(&mut self) -> Res<()> {
        let gl = self.gl;
        self.setup_color_program()?;
        let color_program = self.color_program_id();

        gl!(gl.enable(glw::GL_DEPTH_TEST));
        // depth writing must be enabled as it is disabled in places like doReadPixels
        gl!(gl.depth_mask(glw::TRUE));
        gl!(gl.clear_depth(1.0));
        gl!(gl.depth_func(glw::GL_LEQUAL));
        gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
        self.draw_quad(DrawMode::DepthSpan1, color_program)?;

        // packedTexRender
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffers[PACKED_TEX_RENDER]));
        self.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
        gl!(gl.enable(glw::GL_STENCIL_TEST));
        gl!(gl.stencil_func(glw::GL_ALWAYS, 0x0, 0xFF));
        gl!(gl.stencil_op(glw::GL_ZERO, glw::GL_INCR, glw::GL_INCR));
        gl!(gl.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        self.draw_quad(DrawMode::DepthSpan1, color_program)?;
        gl!(gl.disable(glw::GL_STENCIL_TEST));
        self.restore_draw_read_buffer()?;

        // packedTexRenderInitStencil
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffers[PACKED_TEX_RENDER_INIT_STENCIL]));
        self.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
        gl!(gl.clear(glw::GL_DEPTH_BUFFER_BIT));
        self.draw_quad(DrawMode::DepthSpan1, color_program)?;
        self.restore_draw_read_buffer()?;

        // packedTexRenderDepthStep
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffers[PACKED_TEX_RENDER_DEPTH_STEP]));
        self.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
        gl!(gl.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        self.draw_quad(DrawMode::DepthSpan2, color_program)?;
        self.draw_quad(DrawMode::DepthSpan1, color_program)?;
        self.restore_draw_read_buffer()?;

        // packedTexRenderStencilStep
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffers[PACKED_TEX_RENDER_STENCIL_STEP]));
        self.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
        gl!(gl.clear(glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
        gl!(gl.enable(glw::GL_SCISSOR_TEST));
        gl!(gl.scissor(0, 0, TEX_SIZE, TEX_SIZE / 2));
        gl!(gl.enable(glw::GL_STENCIL_TEST));
        gl!(gl.stencil_func(glw::GL_ALWAYS, 0x0, 0xFF));
        gl!(gl.stencil_op(glw::GL_ZERO, glw::GL_INCR, glw::GL_INCR));
        for _i in 0..256 {
            self.draw_quad(DrawMode::DepthSpan2, color_program)?;
        }
        gl!(gl.disable(glw::GL_SCISSOR_TEST));
        gl!(gl.stencil_func(glw::GL_EQUAL, 0xFF, 0xFF));
        gl!(gl.clear(glw::GL_DEPTH_BUFFER_BIT));
        self.draw_quad(DrawMode::DepthSpan1, color_program)?;
        gl!(gl.disable(glw::GL_STENCIL_TEST));
        glu::expect_no_error(gl, "glDisable")?;
        self.restore_draw_read_buffer()?;

        // end
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.default_fbo));
        glu::expect_no_error(gl, "glBindFramebuffer")
    }

    /// Verifies DepthStencil buffer data against reference values
    fn verify_depth_stencil_gradient(&self, data: &[u8], tex_index: usize, width: i32, height: i32) -> bool {
        let mut result = true;
        let mut index = 0usize;
        let mut count_d = 0;
        let mut count_s = 0;
        let low = f64::from(height) * TOLERANCE_LOW;
        let high = f64::from(height) * TOLERANCE_HIGH;

        for j in 0..height {
            for i in 0..width {
                let (d, s): (f32, i32) = match self.type_format.type_ {
                    glw::GL_UNSIGNED_INT_24_8 => {
                        let v = u32::from_ne_bytes(data[index * 4..index * 4 + 4].try_into().expect("four bytes"));
                        (((v >> 8) as f32) / 0xffffff as f32, (v & 0xff) as i32)
                    }
                    glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => {
                        let d = f32::from_ne_bytes(data[index * 8..index * 8 + 4].try_into().expect("four bytes"));
                        let s = u32::from_ne_bytes(data[index * 8 + 4..index * 8 + 8].try_into().expect("four bytes"));
                        (d, (s & 0xff) as i32)
                    }
                    _ => (-1.0, -1),
                };

                let mut dref = 0.0f32;
                let mut sref = 0i32;
                let mut skip = false;
                let jf = j as f32 / (height - 1) as f32;
                let jd = f64::from(j);

                match tex_index {
                    PACKED_TEX_IMAGE => {
                        dref = i as f32 / (width - 1) as f32;
                        sref = (dref * 255.0) as i32;
                    }
                    PACKED_TEX_RENDER => {
                        dref = jf;
                        sref = 1;
                    }
                    PACKED_TEX_RENDER_INIT_STENCIL => {
                        dref = jf;
                        sref = (i as f32 / (width - 1) as f32 * 255.0) as i32;
                    }
                    PACKED_TEX_RENDER_DEPTH_STEP => {
                        if jd < low {
                            dref = jf;
                            sref = 0;
                        } else if jd > high {
                            dref = 1.0 - jf;
                            sref = 0;
                        } else {
                            skip = true; // give some tolerance to pixels in the middle
                        }
                    }
                    PACKED_TEX_RENDER_STENCIL_STEP => {
                        if jd < low {
                            dref = jf;
                            sref = 255;
                        } else if jd > high {
                            dref = 1.0;
                            sref = 0;
                        } else {
                            skip = true;
                        }
                    }
                    VERIFY_COPY_TEX_IMAGE => {
                        if jd < low {
                            dref = jf;
                            sref = 1;
                        } else if jd > high {
                            dref = 0.5;
                            sref = 1;
                        } else {
                            skip = true;
                        }
                    }
                    _ => {
                        dref = -2.0;
                        sref = -2;
                    }
                }

                if !skip {
                    if f64::from((d - dref).abs()) > EPSILON {
                        result = false;
                        count_d += 1;
                    }
                    if s != sref {
                        result = false;
                        count_s += 1;
                    }
                }

                index += 1;
            }
        }

        if count_d > 0 || count_s > 0 {
            log::info!("DEPTH_STENCIL comparison failed");
        }

        result
    }

    /// Verifies Color buffer data against reference values
    fn verify_color_gradient(
        &self,
        data: &[u32],
        tex_index: usize,
        function: ColorFunction,
        width: i32,
        height: i32,
    ) -> bool {
        let mut result = true;
        let mut index = 0usize;
        let mut channel = 0i32;
        let mut count = 0;
        let low = f64::from(height) * TOLERANCE_LOW;
        let high = f64::from(height) * TOLERANCE_HIGH;
        let wlow = f64::from(width) * TOLERANCE_LOW;
        let whigh = f64::from(width) * TOLERANCE_HIGH;

        for j in 0..height {
            for i in 0..width {
                let mut skip = false;
                let color = data[index];
                let mut colorref = 0u32;
                let jd = f64::from(j);
                let id = f64::from(i);
                let jf = j as f32 / (height - 1) as f32;
                let i_gradient = (i as f32 / (width - 1) as f32 * 255.0) as i32;
                let j_gradient = (jf * 255.0) as i32;

                match tex_index {
                    PACKED_TEX_IMAGE => {
                        channel = i_gradient;
                        colorref = color_ref(channel);
                    }
                    PACKED_TEX_RENDER => {
                        channel = if function == ColorFunction::Depth {
                            j_gradient
                        } else {
                            1
                        };
                        colorref = color_ref(channel);
                    }
                    PACKED_TEX_RENDER_INIT_STENCIL => {
                        channel = if function == ColorFunction::Depth {
                            j_gradient
                        } else {
                            i_gradient
                        };
                        colorref = color_ref(channel);
                    }
                    PACKED_TEX_RENDER_DEPTH_STEP => {
                        if function == ColorFunction::Depth {
                            if jd < low {
                                channel = j_gradient;
                            } else if jd > high {
                                channel = 255 - j_gradient;
                            } else {
                                skip = true; // give some tolerance to pixels in the middle
                            }
                        } else {
                            channel = 0;
                        }
                        colorref = color_ref(channel);
                    }
                    PACKED_TEX_RENDER_STENCIL_STEP => {
                        if jd < low {
                            channel = if function == ColorFunction::Depth {
                                j_gradient
                            } else {
                                255
                            };
                        } else if jd > high {
                            channel = if function == ColorFunction::Depth { 255 } else { 0 };
                        } else {
                            skip = true; // give some tolerance to pixels in the middle
                        }
                        colorref = color_ref(channel);
                    }
                    VERIFY_COPY_TEX_IMAGE => {
                        if jd < low {
                            channel = if function == ColorFunction::Depth {
                                j_gradient
                            } else {
                                1
                            };
                        } else if jd > high {
                            channel = if function == ColorFunction::Depth { 127 } else { 1 };
                        } else {
                            skip = true; // give some tolerance to pixels in the middle
                        }
                        colorref = color_ref(channel);
                    }
                    VERIFY_PARTIAL_ATTACHMENTS => colorref = 0xffffffff,
                    VERIFY_MIXED_ATTACHMENTS => {
                        if jd > high {
                            colorref = 0xffffffff;
                        } else if jd < low {
                            colorref = 0xcccccccc;
                        } else {
                            skip = true;
                        }
                    }
                    VERIFY_CLEAR_BUFFER_DEPTH => {
                        colorref = if (i & 0xff) == 0xff { 0xffffffff } else { 0xcccccccc };
                    }
                    VERIFY_CLEAR_BUFFER_STENCIL => {
                        if id > whigh {
                            colorref = 0xffffffff;
                        } else if id < wlow {
                            colorref = 0xcccccccc;
                        } else {
                            skip = true;
                        }
                    }
                    VERIFY_CLEAR_BUFFER_DEPTH_STENCIL => colorref = 0xffffffff,
                    VERIFY_BLIT => {
                        if jd > high {
                            colorref = 0xffffffff;
                        } else if jd < low {
                            colorref = 0xcccccccc;
                        } else {
                            skip = true;
                        }
                    }
                    _ => colorref = 0xdeadbeef,
                }

                if !skip && color != colorref {
                    let d = (color & 0xff) as f32 / 0xff as f32;
                    let dref = (colorref & 0xff) as f32 / 0xff as f32;
                    if !(function == ColorFunction::Depth && f64::from((d - dref).abs()) < EPSILON) {
                        result = false;
                        count += 1;
                    }
                }

                index += 1;
            }
        }

        if count > 0 {
            log::info!("*** Color comparison failed");
            result = false;
        }

        result
    }

    /// Verify DepthStencil texture by replicating it to color channels so it can be read using ReadPixels in Halti.
    fn do_read_pixels(&mut self, texture: GLuint, function: usize) -> Res<bool> {
        let gl = self.gl;
        let mut result = true;

        let mut fbo: GLuint = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));

        let mut tex_color: GLuint = 0;
        gl!(gl.gen_textures(1, &mut tex_color));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
        self.setup_texture()?;
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            TEX_SIZE,
            TEX_SIZE,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null()
        ));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex_color,
            0
        ));
        self.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;

        // Step 1: Verify depth values
        let mut status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("Framebuffer is incomplete: {status}");
            result = false;
        } else {
            self.setup_texture_program()?;
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.disable(glw::GL_DEPTH_TEST));
            gl!(gl.depth_mask(glw::FALSE));
            gl!(gl.disable(glw::GL_STENCIL_TEST));
            gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            self.draw_quad(DrawMode::Default, self.texture_program_id())?;

            let mut data_color = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data_color.as_mut_ptr().cast()
            ));
            result &= self.verify_color_gradient(&data_color, function, ColorFunction::Depth, TEX_SIZE, TEX_SIZE);

            // Step 2: Verify stencil values
            gl!(gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_TEXTURE_2D,
                texture,
                0
            ));
            status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer is incomplete: {status}");
                result = false;
            } else {
                let u_color = self.setup_color_program()?;
                gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
                gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
                gl!(gl.enable(glw::GL_STENCIL_TEST));
                for i in 0..256 {
                    let v = i as f32 / 255.0;
                    gl!(gl.uniform_4f(u_color, v, v, v, 1.0));
                    gl!(gl.stencil_func(glw::GL_EQUAL, i, 0xFF));
                    gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
                    self.draw_quad(DrawMode::Default, self.color_program_id())?;
                }
                gl!(gl.disable(glw::GL_STENCIL_TEST));

                data_color.fill(0);
                gl!(gl.read_pixels(
                    0,
                    0,
                    TEX_SIZE,
                    TEX_SIZE,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data_color.as_mut_ptr().cast()
                ));
                result &= self.verify_color_gradient(&data_color, function, ColorFunction::Stencil, TEX_SIZE, TEX_SIZE);
            }
        }

        // clean up
        self.restore_draw_read_buffer()?;
        gl!(gl.delete_framebuffers(1, &fbo));
        gl!(gl.delete_textures(1, &tex_color));
        Ok(result)
    }

    fn bind_default_fbo(&self) {
        gl!(self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.default_fbo));
    }

    fn get_error(&self) -> GLenum {
        gl!(self.gl.get_error())
    }
}

/// `InitialStateTest::iterate`
fn initial_state(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let mut pass = true;

    for target in CORE_TEX_TARGETS {
        let mut fp: f32 = 0.0;
        gl!(gl.get_tex_level_parameterfv(target, 0, glw::GL_TEXTURE_STENCIL_SIZE, &mut fp));
        if fp != 0.0 {
            log::info!("gl.getTexLevelParameterfv: Parameter is not 0");
            pass = false;
        }

        let mut ip: GLint = 0;
        gl!(gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_STENCIL_SIZE, &mut ip));
        if ip as f32 != 0.0 {
            log::info!("gl.getTexLevelParameteriv: Parameter is not 0");
            pass = false;
        }
    }

    Ok(if pass {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `ValidateErrorsTest::checkErrors`, desktop branch
fn check_errors(base: &mut Base<'_>) -> Res<bool> {
    let mut result = true;
    let gl = base.gl;
    let tf = base.type_format;
    let mut data = vec![0.0f32; 4 * (TEX_SIZE * TEX_SIZE) as usize];

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, base.textures[PACKED_TEX_IMAGE]));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.framebuffers[PACKED_TEX_IMAGE]));
    base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;

    for type_ in CORE_NON_DEPTH_STENCIL_TYPES {
        gl!(gl.read_pixels(
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            glw::GL_DEPTH_STENCIL,
            type_,
            data.as_mut_ptr().cast()
        ));
        if base.get_error() != glw::GL_INVALID_ENUM {
            result = false;
        }
    }

    for format in CORE_NON_DEPTH_STENCIL_FORMATS {
        gl!(gl.read_pixels(0, 0, TEX_SIZE, TEX_SIZE, format, tf.type_, data.as_mut_ptr().cast()));
        if base.get_error() != glw::GL_INVALID_OPERATION {
            result = false;
        }
    }

    for i in 0..2 {
        // setup texture/fbo
        let mut tex_color: GLuint = 0;
        let mut fbo: GLuint = 0;
        gl!(gl.gen_textures(1, &mut tex_color));
        gl!(gl.gen_framebuffers(1, &mut fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        let attachment_type = if i == 0 {
            glw::GL_DEPTH_ATTACHMENT
        } else {
            glw::GL_STENCIL_ATTACHMENT
        };
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            attachment_type,
            glw::GL_TEXTURE_2D,
            base.textures[PACKED_TEX_IMAGE],
            0
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
        base.setup_texture()?;
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            TEX_SIZE,
            TEX_SIZE,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null()
        ));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex_color,
            0
        ));

        gl!(gl.read_pixels(
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            glw::GL_DEPTH_STENCIL,
            tf.type_,
            data.as_mut_ptr().cast()
        ));
        if base.get_error() != glw::GL_INVALID_OPERATION {
            result = false;
        }

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.default_fbo));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.delete_framebuffers(1, &fbo));
        gl!(gl.delete_textures(1, &tex_color));
    }

    for format in CORE_OTHER_BASE_FORMATS {
        let mut tex_color: GLuint = 0;
        gl!(gl.gen_textures(1, &mut tex_color));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
        base.setup_texture()?;
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            format as GLint,
            TEX_SIZE,
            TEX_SIZE,
            0,
            format,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null()
        ));

        if format != glw::GL_DEPTH_COMPONENT {
            gl!(gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_UNSIGNED_SHORT,
                data.as_mut_ptr().cast()
            ));
            if base.get_error() != glw::GL_INVALID_OPERATION {
                result = false;
            }
        }

        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_STENCIL,
            glw::GL_UNSIGNED_INT_24_8,
            data.as_mut_ptr().cast()
        ));
        if base.get_error() != glw::GL_INVALID_OPERATION {
            result = false;
        }

        gl!(gl.delete_textures(1, &tex_color));
    }

    for i in 0..4 {
        let limit = if i < 2 {
            CORE_NON_DEPTH_STENCIL_FORMATS.len()
        } else {
            CORE_OTHER_BASE_FORMATS.len()
        };

        for j in 0..limit {
            let mut tex_color: GLuint = 0;
            gl!(gl.gen_textures(1, &mut tex_color));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
            base.setup_texture()?;

            let (internal_format, format) = match i {
                0 => (glw::GL_DEPTH_COMPONENT, CORE_NON_DEPTH_STENCIL_FORMATS[j]),
                1 => (glw::GL_DEPTH_STENCIL, CORE_NON_DEPTH_STENCIL_FORMATS[j]),
                2 => (CORE_OTHER_BASE_FORMATS[j], glw::GL_DEPTH_COMPONENT),
                _ => (CORE_OTHER_BASE_FORMATS[j], glw::GL_DEPTH_STENCIL),
            };

            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal_format as GLint,
                TEX_SIZE,
                TEX_SIZE,
                0,
                format,
                if format == glw::GL_DEPTH_STENCIL {
                    glw::GL_UNSIGNED_INT_24_8
                } else {
                    glw::GL_UNSIGNED_BYTE
                },
                std::ptr::null()
            ));

            let expected_error = glw::GL_INVALID_OPERATION;
            if format == glw::GL_STENCIL_INDEX {
                // The OpenGL 4.3 spec is imprecise about what error this should generate (Bugzilla 10134); ARB_texture_stencil8 removes the error, so any error, or none, is allowed for this case.
                base.get_error();
            } else if base.get_error() != expected_error {
                result = false;
            }

            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
            gl!(gl.delete_textures(1, &tex_color));
        }
    }

    let mut fbo: GLuint = 0;
    let mut fbo2: GLuint = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_TEXTURE_2D,
        base.textures[PACKED_TEX_IMAGE],
        0
    ));

    gl!(gl.gen_framebuffers(1, &mut fbo2));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo2));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_TEXTURE_2D,
        base.textures[PACKED_TEX_IMAGE],
        0
    ));

    let mut tex: GLuint = 0;
    gl!(gl.gen_textures(1, &mut tex));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex));
    base.setup_texture()?;
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        tf.format as GLint,
        TEX_SIZE,
        TEX_SIZE,
        0,
        glw::GL_DEPTH_STENCIL,
        tf.type_,
        std::ptr::null()
    ));

    for i in 0..2 {
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, if i == 0 { fbo } else { fbo2 }));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex));
        base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;

        gl!(gl.copy_tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_STENCIL,
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            0
        ));
        let error = base.get_error();
        if error != glw::GL_INVALID_OPERATION && error != glw::GL_INVALID_ENUM {
            gl!(gl.copy_tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_DEPTH_STENCIL,
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                0
            ));
            if base.get_error() != glw::GL_INVALID_OPERATION {
                result = false;
            }
        }

        base.restore_draw_read_buffer()?;
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.default_fbo));
    }

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    gl!(gl.delete_textures(1, &tex));
    gl!(gl.delete_framebuffers(1, &fbo));
    gl!(gl.delete_framebuffers(1, &fbo2));

    Ok(result)
}

/// `ValidateErrorsTest::iterate`
fn validate_errors(base: &mut Base<'_>) -> Res<bool> {
    base.create_textures()?;
    let result = check_errors(base)?;
    base.destroy_textures();
    Ok(result)
}

/// `VerifyReadPixelsTest::iterate`
fn verify_read_pixels(base: &mut Base<'_>) -> Res<bool> {
    // Use readpixels to verify the results for the 5 textures above are correct.
    // - ReadPixel DEPTH_STENCIL value to buffer. Verify gradient.
    // - Create FBO with color/depth/stencil attachment. Draw a quad with depth texture bound. Verify gradient. Draw 256 times using stencil test and gradient color. Verify gradient.
    let gl = base.gl;
    let tf = base.type_format;
    let data_size = TEX_SIZE as usize * TEX_SIZE as usize * tf.size;
    let mut data = vec![0u8; data_size];

    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    for i in 0..NUM_TEXTURES {
        // Read DEPTH_STENCIL value
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.framebuffers[i]));
        base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;

        data.fill(0);
        gl!(gl.read_pixels(
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            glw::GL_DEPTH_STENCIL,
            tf.type_,
            data.as_mut_ptr().cast()
        ));
        result &= base.verify_depth_stencil_gradient(&data, i, TEX_SIZE, TEX_SIZE);
        base.restore_draw_read_buffer()?;

        // On ES3.2 we have to render to color buffer to verify. We can run this also on desktop.
        let texture = base.textures[i];
        result &= base.do_read_pixels(texture, i)?;
    }

    base.bind_default_fbo();
    base.destroy_textures();
    Ok(result)
}

/// `VerifyGetTexImageTest::iterate`
fn verify_get_tex_image(base: &mut Base<'_>) -> Res<bool> {
    let gl = base.gl;
    let tf = base.type_format;
    let mut data = vec![0u8; TEX_SIZE as usize * TEX_SIZE as usize * tf.size];

    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    for i in 0..NUM_TEXTURES {
        data.fill(0);
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, base.textures[i]));
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_STENCIL,
            tf.type_,
            data.as_mut_ptr().cast()
        ));
        result &= base.verify_depth_stencil_gradient(&data, i, TEX_SIZE, TEX_SIZE);
    }

    base.destroy_textures();
    Ok(result)
}

/// `VerifyCopyTexImageTest::iterate`
fn verify_copy_tex_image(base: &mut Base<'_>) -> Res<bool> {
    // After rendering to depth and stencil, CopyTexImage the results to a new DEPTH_STENCIL texture. Attach this texture to a new FBO. Verify that depth and stencil tests work with the copied data.
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    let gl = base.gl;
    let tf = base.type_format;

    // setup shader
    base.setup_color_program()?;

    // setup and copy texture/fbo
    let mut tex: GLuint = 0;
    gl!(gl.gen_textures(1, &mut tex));
    let mut fbo: GLuint = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo));

    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.framebuffers[PACKED_TEX_RENDER]));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex));
    base.setup_texture()?;
    base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        tf.format as GLint,
        TEX_SIZE,
        TEX_SIZE,
        0,
        glw::GL_DEPTH_STENCIL,
        tf.type_,
        std::ptr::null()
    ));
    gl!(gl.copy_tex_image_2d(glw::GL_TEXTURE_2D, 0, tf.format, 0, 0, TEX_SIZE, TEX_SIZE, 0));
    base.restore_draw_read_buffer()?;

    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_DEPTH_ATTACHMENT,
        glw::GL_TEXTURE_2D,
        tex,
        0
    ));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_STENCIL_ATTACHMENT,
        glw::GL_TEXTURE_2D,
        tex,
        0
    ));
    base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;

    let status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
    if status != glw::GL_FRAMEBUFFER_COMPLETE {
        log::info!("Framebuffer is incomplete: {status}");
        result = false;
        base.restore_draw_read_buffer()?;
    } else {
        // render
        gl!(gl.enable(glw::GL_DEPTH_TEST));
        gl!(gl.depth_func(glw::GL_LEQUAL));
        gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
        gl!(gl.enable(glw::GL_STENCIL_TEST));
        gl!(gl.stencil_func(glw::GL_EQUAL, 0x1, 0xFF));
        gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
        base.draw_quad(DrawMode::Default, base.color_program_id())?;
        gl!(gl.disable(glw::GL_STENCIL_TEST));

        // verify
        let mut data = vec![0u8; TEX_SIZE as usize * TEX_SIZE as usize * tf.size];
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_STENCIL,
            tf.type_,
            data.as_mut_ptr().cast()
        ));
        result &= base.verify_depth_stencil_gradient(&data, VERIFY_COPY_TEX_IMAGE, TEX_SIZE, TEX_SIZE);
        base.restore_draw_read_buffer()?;

        result &= base.do_read_pixels(tex, VERIFY_COPY_TEX_IMAGE)?;
    }

    // clean up
    gl!(gl.delete_framebuffers(1, &fbo));
    gl!(gl.delete_textures(1, &tex));
    base.destroy_textures();
    Ok(result)
}

/// `VerifyPartialAttachmentsTest::iterate`
fn verify_partial_attachments(base: &mut Base<'_>) -> Res<bool> {
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;

    // - Create an FBO with a packed depth stencil renderbuffer attached to DEPTH_ATTACHMENT only. If this FBO is complete, stencil test must act as if there is no stencil buffer (always pass.)
    // - Create an FBO with a packed depth stencil renderbuffer attached to STENCIL_ATTACHMENT only. If this FBO is complete, depth test must act as if there is no depth buffer (always pass.)
    // - Create an FBO with a packed depth stencil renderbuffer attached to STENCIL_ATTACHMENT only. If this FBO is complete, occlusion query must act as if there is no depth buffer (always pass.)
    let gl = base.gl;
    let tf = base.type_format;

    // setup shader
    base.setup_color_program()?;

    let mut occ: GLuint = 0;
    gl!(gl.gen_queries(1, &mut occ));

    for i in 0..3 {
        // setup fbo
        let mut fbo: GLuint = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));

        let mut rbo: [GLuint; 2] = [0; 2]; // color, D/S
        gl!(gl.gen_renderbuffers(2, rbo.as_mut_ptr()));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, TEX_SIZE, TEX_SIZE));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, tf.format, TEX_SIZE, TEX_SIZE));
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo[0]
        ));
        base.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;

        let attachment = if i == 0 {
            glw::GL_DEPTH_ATTACHMENT
        } else {
            glw::GL_STENCIL_ATTACHMENT
        };
        gl!(gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, rbo[1]));

        let status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("Framebuffer is incomplete: {status}");
            result = false;
        } else {
            // render
            gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
            gl!(gl.clear_depth(1.0));
            gl!(gl.clear_stencil(0));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));

            match i {
                0 => {
                    gl!(gl.disable(glw::GL_DEPTH_TEST));
                    gl!(gl.enable(glw::GL_STENCIL_TEST));
                    gl!(gl.stencil_func(glw::GL_NEVER, 0xFF, 0xFF));
                    gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
                }
                1 => {
                    gl!(gl.enable(glw::GL_DEPTH_TEST));
                    gl!(gl.depth_func(glw::GL_NEVER));
                    gl!(gl.disable(glw::GL_STENCIL_TEST));
                }
                _ => {
                    gl!(gl.enable(glw::GL_DEPTH_TEST));
                    gl!(gl.depth_func(glw::GL_NEVER));
                    gl!(gl.disable(glw::GL_STENCIL_TEST));
                    gl!(gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, occ));
                }
            }

            base.draw_quad(DrawMode::Default, base.color_program_id())?;

            if i == 2 {
                let mut n: GLuint = 0;
                gl!(gl.end_query(glw::GL_ANY_SAMPLES_PASSED));
                gl!(gl.get_query_objectuiv(occ, glw::GL_QUERY_RESULT, &mut n));
                if n > 0 {
                    base.draw_quad(DrawMode::Default, base.color_program_id())?;
                }
            }

            let mut data = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_mut_ptr().cast()
            ));
            result &= base.verify_color_gradient(
                &data,
                VERIFY_PARTIAL_ATTACHMENTS,
                ColorFunction::Default,
                TEX_SIZE,
                TEX_SIZE,
            );
        }

        base.restore_draw_read_buffer()?;
        base.bind_default_fbo();

        // clean up
        gl!(gl.delete_framebuffers(1, &fbo));
        gl!(gl.delete_renderbuffers(2, rbo.as_ptr()));
    }

    gl!(gl.delete_queries(1, &occ));
    base.destroy_textures();
    Ok(result)
}

/// `VerifyMixedAttachmentsTest::iterate`
fn verify_mixed_attachments(base: &mut Base<'_>) -> Res<bool> {
    // Create FBOs that mix DEPTH_STENCIL renderbuffers with DEPTH or STENCIL renderbuffers. If these FBOs are complete, depth and stencil test must work properly.
    // Create an FBO with two different packed depth stencil renderbuffers, one attached to DEPTH_ATTACHMENT and the other attached to STENCIL_ATTACHMENT. Querying DEPTH_STENCIL_ATTACHMENT must fail with INVALID_OPERATION. If this FBO is complete, depth and stencil tests must work properly.
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    let gl = base.gl;
    let tf = base.type_format;

    base.setup_color_program()?;

    for i in 0..3 {
        // set up FBO/RBOs
        let mut fbo: GLuint = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));

        let mut rbo: [GLuint; 3] = [0; 3]; // color, DEPTH_STENCIL, DEPTH/STENCIL
        gl!(gl.gen_renderbuffers(3, rbo.as_mut_ptr()));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, TEX_SIZE, TEX_SIZE));
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo[0]
        ));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, tf.format, TEX_SIZE, TEX_SIZE));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[2]));

        match i {
            0 => {
                gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, TEX_SIZE, TEX_SIZE));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[1]
                ));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[2]
                ));
            }
            1 => {
                gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_STENCIL_INDEX8, TEX_SIZE, TEX_SIZE));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[1]
                ));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[2]
                ));
            }
            _ => {
                gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, tf.format, TEX_SIZE, TEX_SIZE));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[1]
                ));
                gl!(gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo[2]
                ));

                let mut param: GLint = 0;
                gl!(gl.get_framebuffer_attachment_parameteriv(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
                    &mut param
                ));
                if base.get_error() != glw::GL_INVALID_OPERATION {
                    log::info!("Expected INVALID_OPERATION for DEPTH_STENCIL_ATTACHMENT query");
                    result = false;
                }
            }
        }

        let status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            // The spec only requires "when both depth and stencil attachments are present, implementations are only required to support framebuffer objects where both attachments refer to the same image", so GL_FRAMEBUFFER_UNSUPPORTED is acceptable.
            if status != glw::GL_FRAMEBUFFER_UNSUPPORTED {
                log::info!("Framebuffer is incomplete");
                result = false;
            }
        } else {
            // render, step 1
            gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
            gl!(gl.enable(glw::GL_DEPTH_TEST));
            gl!(gl.depth_func(glw::GL_LEQUAL));
            gl!(gl.clear_depth(1.0));
            gl!(gl.enable(glw::GL_STENCIL_TEST));
            gl!(gl.stencil_func(glw::GL_ALWAYS, 0x1, 0xFF));
            gl!(gl.stencil_op(glw::GL_REPLACE, glw::GL_REPLACE, glw::GL_REPLACE));
            gl!(gl.clear_stencil(0));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
            base.draw_quad(DrawMode::DepthSpan1, base.color_program_id())?;

            // step 2
            gl!(gl.stencil_func(glw::GL_EQUAL, 0x1, 0xFF));
            gl!(gl.stencil_op(glw::GL_REPLACE, glw::GL_REPLACE, glw::GL_REPLACE));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            base.draw_quad(DrawMode::Default, base.color_program_id())?;

            let mut data = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_mut_ptr().cast()
            ));
            result &= base.verify_color_gradient(
                &data,
                VERIFY_MIXED_ATTACHMENTS,
                ColorFunction::Default,
                TEX_SIZE,
                TEX_SIZE,
            );
        }

        // clean up
        gl!(gl.delete_renderbuffers(3, rbo.as_ptr()));
        gl!(gl.delete_framebuffers(1, &fbo));
    }

    base.destroy_textures();
    Ok(result)
}

/// `VerifyParametersTest::iterate`
fn verify_parameters(base: &mut Base<'_>) -> Res<bool> {
    // Verify GetFramebufferAttachmentParameter queries of each <pname> on DEPTH_STENCIL_ATTACHMENT work correctly if both attachments are populated with the same object.
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    let gl = base.gl;

    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.framebuffers[PACKED_TEX_IMAGE]));

    let mut param: GLint = 0;
    gl!(gl.get_framebuffer_attachment_parameteriv(
        glw::GL_FRAMEBUFFER,
        glw::GL_DEPTH_STENCIL_ATTACHMENT,
        glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
        &mut param
    ));
    if param != glw::GL_TEXTURE as GLint {
        log::info!("Invalid value for GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE: {param}");
        return Ok(false);
    }

    for attachment_param in base.attachment_params()? {
        let pname = attachment_param.pname;

        if glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE == pname {
            gl!(gl.get_framebuffer_attachment_parameteriv(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                pname,
                &mut param
            ));
            if base.get_error() != glw::GL_INVALID_OPERATION {
                result = false;
            }
            continue;
        }

        gl!(gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            pname,
            &mut param
        ));
        let mut reference = attachment_param.value;
        if pname == glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME {
            reference = base.textures[PACKED_TEX_IMAGE] as i32;
        }

        if param != reference {
            log::info!("Invalid value for pname {pname}: {param} ( expected {reference})");
            result = false;
        }
    }

    base.destroy_textures();
    Ok(result)
}

/// `RenderbuffersTest::iterate`
fn renderbuffers(base: &mut Base<'_>) -> Res<bool> {
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;

    // Verify RENDERBUFFER_DEPTH_SIZE and RENDERBUFFER_STENCIL_SIZE report appropriate values for for DEPTH_STENCIL renderbuffers.
    let gl = base.gl;
    let tf = base.type_format;
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.framebuffers[PACKED_TEX_IMAGE]));

    let mut rbo: GLuint = 0;
    gl!(gl.gen_renderbuffers(1, &mut rbo));
    gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo));
    gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, tf.format, TEX_SIZE, TEX_SIZE));
    gl!(gl.framebuffer_renderbuffer(
        glw::GL_FRAMEBUFFER,
        glw::GL_DEPTH_STENCIL_ATTACHMENT,
        glw::GL_RENDERBUFFER,
        rbo
    ));

    let mut param: GLint = 0;
    gl!(gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, glw::GL_RENDERBUFFER_DEPTH_SIZE, &mut param));
    if param != tf.d {
        log::info!("Invalid depth: {param}, expected: {}", tf.d);
        result = false;
    }

    gl!(gl.get_renderbuffer_parameteriv(glw::GL_RENDERBUFFER, glw::GL_RENDERBUFFER_STENCIL_SIZE, &mut param));
    if param != tf.s {
        log::info!("Invalid stencil: {param}, expected: {}", tf.s);
        result = false;
    }

    gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0));
    gl!(gl.delete_renderbuffers(1, &rbo));
    base.bind_default_fbo();

    base.destroy_textures();
    Ok(result)
}

/// `StencilSizeTest::iterate`
fn stencil_size(base: &mut Base<'_>) -> Res<bool> {
    // Verify TEXTURE_STENCIL_SIZE reports 8 for DEPTH_STENCIL textures, and 0 for RGBA and DEPTH_COMPONENT textures.
    base.create_textures()?;
    base.render_to_textures()?;

    let gl = base.gl;
    let mut result = true;
    let mut param: GLint = 0;

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, base.textures[PACKED_TEX_IMAGE]));
    gl!(gl.get_tex_level_parameteriv(glw::GL_TEXTURE_2D, 0, glw::GL_TEXTURE_STENCIL_SIZE, &mut param));
    if param != 8 {
        log::info!("Invalid value for DEPTH_STENCIL stencil size: {param}");
        result = false;
    }

    let mut tex_rgba: GLuint = 0;
    gl!(gl.gen_textures(1, &mut tex_rgba));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_rgba));
    base.setup_texture()?;
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RGBA8 as GLint,
        TEX_SIZE,
        TEX_SIZE,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        std::ptr::null()
    ));
    gl!(gl.get_tex_level_parameteriv(glw::GL_TEXTURE_2D, 0, glw::GL_TEXTURE_STENCIL_SIZE, &mut param));
    if param != 0 {
        log::info!("Invalid value for RGBA stencil size: {param}");
        result = false;
    }
    gl!(gl.delete_textures(1, &tex_rgba));

    let mut tex_depth: GLuint = 0;
    gl!(gl.gen_textures(1, &mut tex_depth));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_depth));
    base.setup_texture()?;
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_DEPTH_COMPONENT16 as GLint,
        TEX_SIZE,
        TEX_SIZE,
        0,
        glw::GL_DEPTH_COMPONENT,
        glw::GL_UNSIGNED_SHORT,
        std::ptr::null()
    ));
    gl!(gl.get_tex_level_parameteriv(glw::GL_TEXTURE_2D, 0, glw::GL_TEXTURE_STENCIL_SIZE, &mut param));
    if param != 0 {
        log::info!("Invalid value for DEPTH_COMPONENT stencil size: {param}");
        result = false;
    }
    gl!(gl.delete_textures(1, &tex_depth));

    base.destroy_textures();
    Ok(result)
}

/// `ClearBufferTest::iterate`
fn clear_buffer(base: &mut Base<'_>) -> Res<bool> {
    // Verify ClearBufferfv correctly clears the depth channel of a DEPTH_STENCIL FBO attachment (and does not touch the stencil channel.)
    // Verify ClearBufferiv correctly clears the stencil channel of a DEPTH_STENCIL FBO attachment (and does not touch the depth channel.)
    // Verify ClearBufferfi correctly clears the depth and stencil channels of a DEPTH_STENCIL FBO attachment.
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    let gl = base.gl;
    let tf = base.type_format;

    // setup shader
    base.setup_color_program()?;

    for i in 0..3 {
        // setup texture/fbo
        let mut tex: GLuint = 0;
        let mut tex_color: GLuint = 0;
        let mut fbo: GLuint = 0;
        gl!(gl.gen_textures(1, &mut tex));
        gl!(gl.gen_textures(1, &mut tex_color));
        gl!(gl.gen_framebuffers(1, &mut fbo));

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex));
        base.setup_texture()?;
        let data = base.create_gradient()?;
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            tf.format as GLint,
            TEX_SIZE,
            TEX_SIZE,
            0,
            glw::GL_DEPTH_STENCIL,
            tf.type_,
            data.as_ptr().cast()
        ));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            tex,
            0
        ));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
        base.setup_texture()?;
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            TEX_SIZE,
            TEX_SIZE,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null()
        ));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex_color,
            0
        ));
        base.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;

        let status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("Framebuffer is incomplete: {status}");
            result = false;
        } else {
            // clear relevant buffers
            match i {
                0 => {
                    let valuef = 1.0f32;
                    gl!(gl.clear_bufferfv(glw::GL_DEPTH, 0, &valuef));
                }
                1 => {
                    let valuei = 0xffi32;
                    gl!(gl.clear_bufferiv(glw::GL_STENCIL, 0, &valuei));
                }
                _ => {
                    gl!(gl.clear_bufferfi(glw::GL_DEPTH_STENCIL, 0, 1.0, 0xff));
                }
            }

            // render reference image
            gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
            gl!(gl.enable(glw::GL_DEPTH_TEST));
            gl!(gl.depth_func(glw::GL_LEQUAL));
            gl!(gl.enable(glw::GL_STENCIL_TEST));
            gl!(gl.stencil_func(glw::GL_EQUAL, 0xFF, 0xFF));
            gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            base.draw_quad(DrawMode::Default, base.color_program_id())?;

            // verify
            let mut read_data = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                read_data.as_mut_ptr().cast()
            ));
            result &= base.verify_color_gradient(
                &read_data,
                VERIFY_CLEAR_BUFFER_DEPTH + i,
                ColorFunction::Default,
                TEX_SIZE,
                TEX_SIZE,
            );
        }

        // destroy texture/fbo
        base.restore_draw_read_buffer()?;
        base.bind_default_fbo();
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.delete_framebuffers(1, &fbo));
        gl!(gl.delete_textures(1, &tex));
        gl!(gl.delete_textures(1, &tex_color));
    }

    base.destroy_textures();
    Ok(result)
}

/// `BlitTest::iterate`
fn blit(base: &mut Base<'_>) -> Res<bool> {
    // Verify that NEAREST filtered blits of DEPTH and/or STENCIL between two FBOs with the same format packed depth stencil attachment work. Test non-multisample [1->1], multisample resolve [N->1], and multisample replicate [1->N] blits, for each supported value of N up to MAX_SAMPLES.
    base.create_textures()?;
    base.render_to_textures()?;

    let mut fbo: [GLuint; 3] = [0; 3]; // Framebuffers: source, dest, downsample
    let mut rbo: [GLuint; 4] = [0; 4]; // Renderbuffers: source D/S, dest D/S, dest color, downsample color
    let mut max_samples: GLint = 0;
    let mut result = true;
    let gl = base.gl;
    let tf = base.type_format;
    let mut data = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];

    base.setup_color_program()?;

    gl!(gl.get_integerv(glw::GL_MAX_SAMPLES, &mut max_samples));

    for j in 0..2 {
        for i in 0..=max_samples {
            // Create FBO/RBO
            gl!(gl.gen_framebuffers(3, fbo.as_mut_ptr()));
            gl!(gl.gen_renderbuffers(4, rbo.as_mut_ptr()));

            let (src_samples, dest_samples) = if j == 0 { (i, 0) } else { (0, i) };

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]));
            gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[0]));
            gl!(gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, src_samples, tf.format, TEX_SIZE, TEX_SIZE));
            gl!(gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                rbo[0]
            ));

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[1]));
            gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[1]));
            gl!(gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, dest_samples, tf.format, TEX_SIZE, TEX_SIZE));
            gl!(gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                rbo[1]
            ));
            gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[2]));
            gl!(gl.renderbuffer_storage_multisample(
                glw::GL_RENDERBUFFER,
                dest_samples,
                glw::GL_RGBA8,
                TEX_SIZE,
                TEX_SIZE
            ));
            gl!(gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo[2]
            ));

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[2]));
            gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo[3]));
            gl!(gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 0, glw::GL_RGBA8, TEX_SIZE, TEX_SIZE));
            gl!(gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo[3]
            ));

            // Render
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]));
            base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
            gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
            gl!(gl.enable(glw::GL_DEPTH_TEST));
            gl!(gl.depth_func(glw::GL_LEQUAL));
            gl!(gl.clear_depth(1.0));
            gl!(gl.enable(glw::GL_STENCIL_TEST));
            gl!(gl.stencil_func(glw::GL_ALWAYS, 0x1, 0xFF));
            gl!(gl.stencil_op(glw::GL_REPLACE, glw::GL_REPLACE, glw::GL_REPLACE));
            gl!(gl.clear_stencil(0));
            gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT));
            base.draw_quad(DrawMode::DepthSpan1, base.color_program_id())?;
            base.restore_draw_read_buffer()?;

            // Blit
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo[0]));
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[1]));
            base.set_draw_read_buffer(glw::GL_NONE, glw::GL_NONE)?;
            gl!(gl.blit_framebuffer(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                glw::GL_NEAREST
            ));
            base.restore_draw_read_buffer()?;

            // Verify
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[1]));
            base.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;
            gl!(gl.stencil_func(glw::GL_EQUAL, 0x1, 0xFF));
            gl!(gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            base.draw_quad(DrawMode::Default, base.color_program_id())?;
            base.restore_draw_read_buffer()?;

            // Downsample blit
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo[1]));
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo[2]));
            base.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;
            gl!(gl.blit_framebuffer(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_NEAREST
            ));
            base.restore_draw_read_buffer()?;

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[2]));
            gl!(gl.read_pixels(
                0,
                0,
                TEX_SIZE,
                TEX_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_mut_ptr().cast()
            ));
            result &= base.verify_color_gradient(&data, VERIFY_BLIT, ColorFunction::Default, TEX_SIZE, TEX_SIZE);

            // Clean up
            base.bind_default_fbo();
            gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0));
            gl!(gl.delete_renderbuffers(4, rbo.as_ptr()));
            gl!(gl.delete_framebuffers(3, fbo.as_ptr()));
        }
    }

    base.destroy_textures();
    Ok(result)
}

/// `StencilTexturingTest::iterate`, after the support check done in `check_support`
fn stencil_texturing(base: &mut Base<'_>) -> Res<bool> {
    // Verifies that either depth or stencil can be sampled depending on GL_DEPTH_STENCIL_TEXTURE_MODE
    base.create_textures()?;
    base.render_to_textures()?;

    let mut result = true;
    let gl = base.gl;

    let mut fbo: GLuint = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));

    let mut tex_color: GLuint = 0;
    gl!(gl.gen_textures(1, &mut tex_color));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex_color));
    base.setup_texture()?;
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RGBA8 as GLint,
        TEX_SIZE,
        TEX_SIZE,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        std::ptr::null()
    ));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D,
        tex_color,
        0
    ));
    base.set_draw_read_buffer(glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0)?;

    // Step 1: Verify depth values
    let status = gl!(gl.check_framebuffer_status(glw::GL_FRAMEBUFFER));
    if status != glw::GL_FRAMEBUFFER_COMPLETE {
        log::info!("Framebuffer is incomplete: {status}");
        result = false;
    } else {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, base.textures[PACKED_TEX_IMAGE]));
        gl!(gl.disable(glw::GL_DEPTH_TEST));
        gl!(gl.depth_mask(glw::FALSE));
        gl!(gl.disable(glw::GL_STENCIL_TEST));
        gl!(gl.viewport(0, 0, TEX_SIZE, TEX_SIZE));
        gl!(gl.clear_color(0.8, 0.8, 0.8, 0.8));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
            glw::GL_DEPTH_COMPONENT as GLint
        ));
        base.setup_texture_program()?;
        base.draw_quad(DrawMode::Default, base.texture_program_id())?;

        let mut data_color = vec![0u32; (TEX_SIZE * TEX_SIZE) as usize];
        gl!(gl.read_pixels(
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            data_color.as_mut_ptr().cast()
        ));
        result &= base.verify_color_gradient(&data_color, PACKED_TEX_IMAGE, ColorFunction::Depth, TEX_SIZE, TEX_SIZE);

        // Step 2: Verify stencil values
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
            glw::GL_STENCIL_INDEX as GLint
        ));
        base.setup_stencil_program()?;
        base.draw_quad(DrawMode::Default, base.stencil_program_id())?;

        data_color.fill(0);
        gl!(gl.read_pixels(
            0,
            0,
            TEX_SIZE,
            TEX_SIZE,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            data_color.as_mut_ptr().cast()
        ));
        result &= base.verify_color_gradient(
            &data_color,
            PACKED_TEX_IMAGE,
            ColorFunction::Default,
            TEX_SIZE,
            TEX_SIZE,
        );
    }

    base.restore_draw_read_buffer()?;
    gl!(gl.delete_framebuffers(1, &fbo));
    gl!(gl.delete_textures(1, &tex_color));
    base.destroy_textures();
    Ok(result)
}

type RunFn = fn(&mut Base<'_>) -> Res<bool>;

enum Kind {
    InitialState,
    Run {
        type_format: &'static TypeFormat,
        run: RunFn,
        needs_core_43: bool,
    },
}

struct PackedDepthStencilCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for PackedDepthStencilCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if let Kind::Run {
            needs_core_43: true, ..
        } = self.kind
            && !context.context_type().supports_core(4, 3)
        {
            return Err(TestError::NotSupported(
                "stencil_texturing extension is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match &self.kind {
            Kind::InitialState => initial_state(context),
            Kind::Run { type_format, run, .. } => {
                let mut base = Base::new(context, type_format);
                Ok(if run(&mut base)? {
                    TestStatus::pass("Pass")
                } else {
                    TestStatus::fail("Fail")
                })
            }
        }
    }
}

/// `PackedDepthStencilTests::init`, desktop
pub fn create_tests() -> TestCaseGroup {
    // (group, test, needs 4.3, only on desktop - always true here)
    let groups: [(&str, RunFn, bool); 12] = [
        ("validate_errors", validate_errors, false),
        ("verify_read_pixels", verify_read_pixels, false),
        ("verify_get_tex_image", verify_get_tex_image, false),
        ("verify_copy_tex_image", verify_copy_tex_image, false),
        ("verify_partial_attachments", verify_partial_attachments, false),
        ("verify_mixed_attachments", verify_mixed_attachments, false),
        ("verify_parameters", verify_parameters, false),
        ("renderbuffers", renderbuffers, false),
        ("clear_buffer", clear_buffer, false),
        ("blit", blit, false),
        ("stencil_texturing", stencil_texturing, true),
        ("stencil_size", stencil_size, false),
    ];

    let mut root = TestCaseGroup::new("packed_depth_stencil");
    for (group_name, run, needs_core_43) in groups {
        let mut group = TestCaseGroup::new(group_name);
        if group_name == "validate_errors" {
            group.add_child(Box::new(PackedDepthStencilCase {
                name: "initial_state",
                kind: Kind::InitialState,
            }) as Box<dyn TestCase>);
        }
        for type_format in &TEXTURE_TYPES {
            group.add_child(Box::new(PackedDepthStencilCase {
                name: type_format.format_name,
                kind: Kind::Run {
                    type_format,
                    run,
                    needs_core_43,
                },
            }) as Box<dyn TestCase>);
        }
        root.add_child(group);
    }
    root
}
