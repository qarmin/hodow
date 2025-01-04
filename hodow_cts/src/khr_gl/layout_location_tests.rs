// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcLayoutLocationTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream keys its `create<target, internalFormat>` specializations by template arguments; a row here carries the same texture description (`TextureSpec`) and one generic `create_texture` builds it. The ES-only branches are dropped (desktop roots), so image uniforms are updated with glUniform1i like the samplers.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::{RGBA, StringTemplate, Surface, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const WIDTH: i32 = 2;
const HEIGHT: i32 = 2;

/// The element type `generateData` is instantiated with. The value written is always 255.
#[derive(Clone, Copy)]
enum Element {
    U8,
    U16,
    I32,
    U32,
    F32,
}

impl Element {
    fn push_255(self, bytes: &mut Vec<u8>) {
        match self {
            Self::U8 => bytes.push(255),
            Self::U16 => bytes.extend_from_slice(&255u16.to_ne_bytes()),
            Self::I32 => bytes.extend_from_slice(&255i32.to_ne_bytes()),
            Self::U32 => bytes.extend_from_slice(&255u32.to_ne_bytes()),
            Self::F32 => bytes.extend_from_slice(&255.0f32.to_ne_bytes()),
        }
    }

    fn zero_size(self) -> usize {
        match self {
            Self::U8 => 1,
            Self::U16 => 2,
            Self::I32 | Self::U32 | Self::F32 => 4,
        }
    }
}

/// `generateData`: zeros with 255 in the first component of every texel.
fn generate_data(element: Element, width: i32, height: i32, components: usize) -> Vec<u8> {
    debug_assert!(components == 1 || components == 4);
    let size = width as usize * height as usize * components;
    let mut bytes = Vec::with_capacity(size * element.zero_size());
    for i in 0..size {
        if i % components == 0 {
            element.push_255(&mut bytes);
        } else {
            bytes.extend(std::iter::repeat_n(0u8, element.zero_size()));
        }
    }
    bytes
}

#[derive(Clone, Copy)]
enum Shape {
    Tex1D,
    /// `createTexture2D` with a target: GL_TEXTURE_2D or GL_TEXTURE_1D_ARRAY.
    Tex2D(GLenum),
    Tex3D,
    Cube,
    Tex2DArray,
    Buffer,
}

/// The arguments of one `create<target, internalFormat>` specialization.
#[derive(Clone, Copy)]
struct TextureSpec {
    shape: Shape,
    element: Element,
    components: usize,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
}

/// `ResultData`
struct ResultData {
    texture_id: GLuint,
    /// used only by GL_TEXTURE_BUFFER
    buffer_id: GLuint,
}

/// `setTexParameters`
fn set_tex_parameters(gl: &glw::Functions, target: GLenum, depth_texture: bool) {
    // SAFETY: plain parameter setters on the texture bound to `target`.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        if depth_texture {
            gl.tex_parameteri(
                target,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as i32,
            );
            gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as i32);
        }
    }
}

/// `createTexture1D`, `createTexture2D`, `createTexture3D`, `createCubeMap`, `createTexture2DArray` and `createTextureBuffer`.
fn create_texture(gl: &glw::Functions, spec: TextureSpec) -> ResultData {
    let TextureSpec {
        shape,
        element,
        components,
        internal_format,
        format,
        type_,
    } = spec;
    let internal_format_int = internal_format as i32;
    let depth_texture = components == 1;
    let mut id: GLuint = 0;

    // SAFETY: every call below passes pointers into `data`, which is sized for the texels the call reads, and operates on the texture generated and bound here.
    unsafe {
        match shape {
            Shape::Tex1D => {
                let data = generate_data(element, WIDTH, 1, components);
                gl.gen_textures(1, &mut id);
                gl.bind_texture(glw::GL_TEXTURE_1D, id);
                gl.tex_image_1d(
                    glw::GL_TEXTURE_1D,
                    0,
                    internal_format_int,
                    WIDTH,
                    0,
                    format,
                    type_,
                    data.as_ptr().cast(),
                );
                set_tex_parameters(gl, glw::GL_TEXTURE_1D, depth_texture);
            }
            Shape::Tex2D(target) => {
                let data = generate_data(element, WIDTH, HEIGHT, components);
                gl.gen_textures(1, &mut id);
                gl.bind_texture(target, id);
                gl.tex_storage_2d(target, 1, internal_format, WIDTH, HEIGHT);
                gl.tex_sub_image_2d(target, 0, 0, 0, WIDTH, HEIGHT, format, type_, data.as_ptr().cast());
                set_tex_parameters(gl, target, depth_texture);
            }
            Shape::Tex3D => {
                let data = generate_data(element, WIDTH, HEIGHT, components);
                gl.gen_textures(1, &mut id);
                gl.bind_texture(glw::GL_TEXTURE_3D, id);
                gl.tex_storage_3d(glw::GL_TEXTURE_3D, 1, internal_format, WIDTH, HEIGHT, 1);
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    0,
                    0,
                    0,
                    WIDTH,
                    HEIGHT,
                    1,
                    format,
                    type_,
                    data.as_ptr().cast(),
                );
                set_tex_parameters(gl, glw::GL_TEXTURE_3D, depth_texture);
            }
            Shape::Cube => {
                let data = generate_data(element, WIDTH, HEIGHT, components);
                gl.gen_textures(1, &mut id);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, id);
                let faces = [
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                ];
                gl.tex_storage_2d(glw::GL_TEXTURE_CUBE_MAP, 1, internal_format, WIDTH, HEIGHT);
                for face in faces {
                    gl.tex_sub_image_2d(face, 0, 0, 0, WIDTH, HEIGHT, format, type_, data.as_ptr().cast());
                }
                set_tex_parameters(gl, glw::GL_TEXTURE_CUBE_MAP, depth_texture);
            }
            Shape::Tex2DArray => {
                let data = generate_data(element, WIDTH, HEIGHT, components);
                gl.gen_textures(1, &mut id);
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, id);
                gl.tex_storage_3d(glw::GL_TEXTURE_2D_ARRAY, 1, internal_format, WIDTH, HEIGHT, 1);
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    0,
                    WIDTH,
                    HEIGHT,
                    1,
                    format,
                    type_,
                    data.as_ptr().cast(),
                );
                set_tex_parameters(gl, glw::GL_TEXTURE_2D_ARRAY, depth_texture);
            }
            Shape::Buffer => {
                let data = generate_data(element, WIDTH, HEIGHT, 4);
                let mut buffer_id: GLuint = 0;
                gl.gen_buffers(1, &mut buffer_id);
                gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer_id);
                gl.buffer_data(
                    glw::GL_TEXTURE_BUFFER,
                    data.len() as isize,
                    data.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                gl.gen_textures(1, &mut id);
                gl.bind_texture(glw::GL_TEXTURE_BUFFER, id);
                gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, buffer_id);
                return ResultData {
                    texture_id: id,
                    buffer_id,
                };
            }
        }
    }

    ResultData {
        texture_id: id,
        buffer_id: 0,
    }
}

const fn spec(
    shape: Shape,
    element: Element,
    components: usize,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
) -> TextureSpec {
    TextureSpec {
        shape,
        element,
        components,
        internal_format,
        format,
        type_,
    }
}

/// `SamplerCaseData`
struct SamplerCaseData {
    /// description of the texture to create
    create: TextureSpec,
    /// test case name
    name: &'static str,
    /// sampler or image
    opaque_type: &'static str,
    /// operation that determines fragment color
    out_assignment: &'static str,
    /// the number of required fragment image uniform
    #[allow(dead_code)]
    num_frag_image_uniforms: i32,
}

const fn case(
    create: TextureSpec,
    name: &'static str,
    opaque_type: &'static str,
    out_assignment: &'static str,
    num_frag_image_uniforms: i32,
) -> SamplerCaseData {
    SamplerCaseData {
        create,
        name,
        opaque_type,
        out_assignment,
        num_frag_image_uniforms,
    }
}

/// `SpecifiedLocationCase`
struct SpecifiedLocationCase {
    data: SamplerCaseData,
}

impl TestCase for SpecifiedLocationCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
        const POSITIONS: [f32; 8] = [-1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0];

        const VS_TEMPLATE: &str = "${VERSION}\nprecision highp float;\nlayout(location=0) in highp vec2 inPosition;\nlayout(location=0) out highp vec2 coords;\nvoid main(void)\n{\n  coords = vec2(max(0.0, inPosition.x), max(0.0, inPosition.y));\n  gl_Position = vec4(inPosition, 0.0, 1.0);\n}\n";
        const FS_TEMPLATE: &str = "${VERSION}\nprecision highp float;\nlayout(location=0) in vec2 coords;\nlayout(location=0) out vec4 fragColor;\nlayout(${OPAQUE_TYPE_QUALIFIERS}) ${ACCESS} uniform highp ${OPAQUE_TYPE} ${OPAQUE_TYPE_NAME};\nvoid main(void)\n{\n  fragColor = ${OUT_ASSIGNMENT};\n}\n";

        let gl = context.gl();
        let data = &self.data;

        let is_image_case = !data.opaque_type.contains("sampler");
        let (opaque_type_name, access) = if is_image_case {
            ("image", "readonly")
        } else {
            ("sampler", "")
        };
        let (image_format_qualifier, image_format) = if data.opaque_type.contains("iimage") {
            ("rgba32i", glw::GL_RGBA32I)
        } else if data.opaque_type.contains("uimage") {
            ("rgba32ui", glw::GL_RGBA32UI)
        } else {
            ("rgba8", glw::GL_RGBA8)
        };

        let expected_location = 2;
        let defined_binding = 1;

        let mut layout_specification = format!("location={expected_location}");
        if is_image_case {
            layout_specification.push_str(&format!(", {image_format_qualifier}"));
        }

        let specialization = [
            ("OPAQUE_TYPE", data.opaque_type.to_string()),
            ("OUT_ASSIGNMENT", data.out_assignment.to_string()),
            ("OPAQUE_TYPE_NAME", opaque_type_name.to_string()),
            ("ACCESS", access.to_string()),
            (
                "VERSION",
                context.context_type().glsl_version().declaration().to_string(),
            ),
            ("OPAQUE_TYPE_QUALIFIERS", layout_specification),
        ];
        let vs = StringTemplate::new(VS_TEMPLATE).specialize(&specialization)?;
        let fs = StringTemplate::new(FS_TEMPLATE).specialize(&specialization)?;

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));
        if !program.is_ok() {
            log::warn!(
                "Creation of program failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Ok(TestStatus::fail("Fail"));
        }

        let program_id = program.program();
        let c_name = std::ffi::CString::new(opaque_type_name).expect("no nul byte");
        // SAFETY: a NUL-terminated name and a linked program.
        let location = unsafe { gl.get_uniform_location(program_id, c_name.as_ptr()) };
        if location != expected_location {
            log::warn!("Expected uniform to be at location {expected_location}, not at {location}.");
            return Ok(TestStatus::fail("Fail"));
        }

        gl_call!(gl, "glUseProgram", gl.use_program(program_id));

        // Prepare texture/buffer
        // SAFETY: a plain state setter.
        unsafe { gl.active_texture(glw::GL_TEXTURE1) };
        let result_data = create_texture(gl, data.create);
        glu::expect_no_error(gl, "GL object creation failed.")?;

        if is_image_case {
            gl_call!(
                gl,
                "glBindImageTexture",
                gl.bind_image_texture(
                    defined_binding,
                    result_data.texture_id,
                    0,
                    glw::TRUE,
                    0,
                    glw::GL_READ_ONLY,
                    image_format
                )
            );
        }

        gl_call!(
            gl,
            "glUniform1i",
            gl.uniform_1i(expected_location, defined_binding as i32)
        );

        // Create FBO with RBO
        let mut rbo_id: GLuint = 0;
        let mut fbo_id: GLuint = 0;
        // SAFETY: generates and configures a renderbuffer and a framebuffer owned by this case.
        unsafe {
            gl.gen_renderbuffers(1, &mut rbo_id);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_id);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, WIDTH, HEIGHT);
            gl.gen_framebuffers(1, &mut fbo_id);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo_id,
            );
        }

        // Render
        // SAFETY: a plain state setter.
        unsafe { gl.viewport(0, 0, WIDTH, HEIGHT) };
        let vertex_arrays = [va::float("inPosition", 2, 4, 0, &POSITIONS)];
        glu::draw(
            &context.render_context,
            program_id,
            &vertex_arrays,
            &pr::triangle_strip(&QUAD_INDICES),
        )?;

        // Grab surface
        let mut result_frame = Surface::new(WIDTH, HEIGHT);
        glu::read_pixels(&context.render_context, 0, 0, &mut result_frame.get_access())?;

        // Verify color of just first pixel
        let expected_color = RGBA::new(255, 0, 0, 0);
        let pixel = result_frame.get_pixel(0, 0);
        let status = if pixel != expected_color {
            log::warn!(
                "Incorrect color was generated, expected: [{}, {}, {}, {}], got [{}, {}, {}, {}]",
                expected_color.get_red(),
                expected_color.get_green(),
                expected_color.get_blue(),
                expected_color.get_alpha(),
                pixel.get_red(),
                pixel.get_green(),
                pixel.get_blue(),
                pixel.get_alpha()
            );
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        };

        // Cleanup
        // SAFETY: the objects created above, each deleted once.
        unsafe {
            if result_data.buffer_id != 0 {
                gl.delete_buffers(1, &result_data.buffer_id);
            }
            gl.delete_framebuffers(1, &fbo_id);
            gl.delete_renderbuffers(1, &rbo_id);
            gl.delete_textures(1, &result_data.texture_id);
        }

        Ok(status)
    }
}

/// `NegativeLocationCase`
struct NegativeLocationCase;

impl TestCase for NegativeLocationCase {
    fn name(&self) -> &str {
        "invalid_cases"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const CS_TEMPLATE: &str = "${VERSION}\nlayout(location=2, binding=0) uniform atomic_uint u_atomic;\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout(binding=0) buffer Output {\n  uint value;\n} sb_out;\n\nvoid main (void) {\n  sb_out.value = atomicCounterIncrement(u_atomic);\n}";

        let gl = context.gl();
        let cs = StringTemplate::new(CS_TEMPLATE).specialize(&[(
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        )])?;

        let program = ShaderProgram::new_expecting_build_failure(gl, &ProgramSources::compute(cs));
        if program.is_ok() {
            log::warn!("layout(location = N) is not allowed for atomic counters");
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `LayoutLocationTests::init`
pub fn create_tests() -> TestCaseGroup {
    use Element::{F32, I32, U8, U16, U32};
    use Shape::{Buffer, Cube, Tex1D, Tex2D, Tex2DArray, Tex3D};
    let rgba8 = |shape| spec(shape, U8, 4, glw::GL_RGBA8, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);
    let rgba32i = |shape| spec(shape, I32, 4, glw::GL_RGBA32I, glw::GL_RGBA_INTEGER, glw::GL_INT);
    let rgba32ui = |shape| {
        spec(
            shape,
            U32,
            4,
            glw::GL_RGBA32UI,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
        )
    };
    let depth16 = |shape| {
        spec(
            shape,
            U16,
            1,
            glw::GL_DEPTH_COMPONENT16,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_UNSIGNED_SHORT,
        )
    };
    let buffer = |element, internal_format| spec(Buffer, element, 4, internal_format, 0, 0);

    let common_arguments = [
        case(
            rgba8(Tex2D(glw::GL_TEXTURE_2D)),
            "sampler_2d",
            "sampler2D",
            "texture(sampler, coords)",
            0,
        ),
        case(
            rgba8(Tex3D),
            "sampler_3d",
            "sampler3D",
            "texture(sampler, vec3(coords, 0.0))",
            0,
        ),
        case(
            rgba8(Cube),
            "sampler_cube",
            "samplerCube",
            "texture(sampler, vec3(coords, 0.0))",
            0,
        ),
        case(
            depth16(Cube),
            "sampler_cube_shadow",
            "samplerCubeShadow",
            "vec4(texture(sampler, vec4(coords, 0.0, 0.0)), 0.0, 0.0, 0.0)",
            0,
        ),
        case(
            depth16(Tex2D(glw::GL_TEXTURE_2D)),
            "sampler_2d_shadow",
            "sampler2DShadow",
            "vec4(texture(sampler, vec3(coords, 0.0)), 0.0, 0.0, 0.0)",
            0,
        ),
        case(
            rgba8(Tex2DArray),
            "sampler_2d_array",
            "sampler2DArray",
            "texture(sampler, vec3(coords, 0.0))",
            0,
        ),
        case(
            depth16(Tex2DArray),
            "sampler_2d_array_shadow",
            "sampler2DArrayShadow",
            "vec4(texture(sampler, vec4(coords, 0.0, 0.0)), 0.0, 0.0, 0.0)",
            0,
        ),
        case(
            rgba32i(Tex2D(glw::GL_TEXTURE_2D)),
            "isampler_2d",
            "isampler2D",
            "vec4(texture(sampler, coords))/255.0",
            0,
        ),
        case(
            rgba32i(Tex3D),
            "isampler_3d",
            "isampler3D",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba32i(Cube),
            "isampler_cube",
            "isamplerCube",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba32i(Tex2DArray),
            "isampler_2d_array",
            "isampler2DArray",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba32ui(Tex2D(glw::GL_TEXTURE_2D)),
            "usampler_2d",
            "usampler2D",
            "vec4(texture(sampler, coords))/255.0",
            0,
        ),
        case(
            rgba32ui(Tex3D),
            "usampler_3d",
            "usampler3D",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba32ui(Cube),
            "usampler_cube",
            "usamplerCube",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba32ui(Tex2DArray),
            "usampler_2d_array",
            "usampler2DArray",
            "vec4(texture(sampler, vec3(coords, 0.0)))/255.0",
            0,
        ),
        case(
            rgba8(Tex2D(glw::GL_TEXTURE_2D)),
            "image_2d",
            "image2D",
            "imageLoad(image, ivec2(0, 0))",
            1,
        ),
        case(
            rgba32i(Tex2D(glw::GL_TEXTURE_2D)),
            "iimage_2d",
            "iimage2D",
            "vec4(imageLoad(image, ivec2(0, 0)))/255.0",
            1,
        ),
        case(
            rgba32ui(Tex2D(glw::GL_TEXTURE_2D)),
            "uimage_2d",
            "uimage2D",
            "vec4(imageLoad(image, ivec2(0, 0)))/255.0",
            1,
        ),
        case(
            rgba8(Tex3D),
            "image_3d",
            "image3D",
            "imageLoad(image, ivec3(0, 0, 0))",
            1,
        ),
        case(
            rgba32i(Tex3D),
            "iimage_3d",
            "iimage3D",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
        case(
            rgba32ui(Tex3D),
            "uimage_3d",
            "uimage3D",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
        case(
            rgba8(Cube),
            "image_cube",
            "imageCube",
            "imageLoad(image, ivec3(0, 0, 0))",
            1,
        ),
        case(
            rgba32i(Cube),
            "iimage_cube",
            "iimageCube",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
        case(
            rgba32ui(Cube),
            "uimage_cube",
            "uimageCube",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
        case(
            rgba8(Tex2DArray),
            "image_2d_array",
            "image2DArray",
            "imageLoad(image, ivec3(0, 0, 0))",
            1,
        ),
        case(
            rgba32i(Tex2DArray),
            "iimage_2d_array",
            "iimage2DArray",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
        case(
            rgba32ui(Tex2DArray),
            "uimage_2d_array",
            "uimage2DArray",
            "vec4(imageLoad(image, ivec3(0, 0, 0)))/255.0",
            1,
        ),
    ];

    // Additional array containing entries for core gl
    let core_arguments = [
        case(
            buffer(F32, glw::GL_RGBA32F),
            "sampler_buffer",
            "samplerBuffer",
            "texelFetch(sampler, 1)",
            0,
        ),
        case(
            buffer(I32, glw::GL_RGBA32I),
            "isampler_buffer",
            "isamplerBuffer",
            "vec4(texelFetch(sampler, 1))/255.0",
            0,
        ),
        case(
            buffer(U32, glw::GL_RGBA32UI),
            "usampler_buffer",
            "usamplerBuffer",
            "vec4(texelFetch(sampler, 1))/255.0",
            0,
        ),
        case(rgba8(Tex1D), "sampler_1d", "sampler1D", "texture(sampler, coords.x)", 0),
        case(
            depth16(Tex1D),
            "sampler_1d_shadow",
            "sampler1DShadow",
            "vec4(texture(sampler, vec3(coords, 0.0)), 0.0, 0.0, 0.0)",
            0,
        ),
        case(
            rgba8(Tex2D(glw::GL_TEXTURE_1D_ARRAY)),
            "sampler_1d_array",
            "sampler1DArray",
            "texture(sampler, coords, 0.0)",
            0,
        ),
        case(
            depth16(Tex2D(glw::GL_TEXTURE_1D_ARRAY)),
            "sampler_1d_array_shadow",
            "sampler1DArrayShadow",
            "vec4(texture(sampler, vec3(coords, 0.0)), 0.0, 0.0, 0.0)",
            0,
        ),
    ];

    let mut group = TestCaseGroup::new("layout_location");
    for data in common_arguments.into_iter().chain(core_arguments) {
        group.add_child(Box::new(SpecifiedLocationCase { data }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(NegativeLocationCase) as Box<dyn TestCase>);
    group
}
