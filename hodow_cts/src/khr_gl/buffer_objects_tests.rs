// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcBufferObjectsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the roots that register this group). `BufferObjectsTestBase` is `Resources`, created by each case's `iterate` after `init`'s steps (state reset, program, window-size dependent vertex data, `build_buffers`) and released when it is dropped. The projection matrix is `tcu::ortho2DMatrix`, whose translation sits in the last row, written out row-major as upstream memcpy's it. The vertex-attribute set-up that each case repeats with its own error checks is `setup_attrib`: one error check at the end, which catches the same errors.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

const BUFOBJ_TEXTURES: usize = 2;

const BUFFER_TRIANGLES: usize = 0;
const BUFFER_TRI_NORMALS: usize = 1;
const BUFFER_TRI_COLORS: usize = 2;
const BUFFER_ELEMENT_VERTICES: usize = 3;
const BUFFER_ELEMENT_INDICES: usize = 4;
const BUFFER_ELEMENT_COLORS: usize = 5;
const BUFFER_TEXTURE0: usize = 6;
const BUFFER_TEXTURE1: usize = 7;
const BUFFER_LAST_ENUM: usize = 8;

const TRI_NORMAL_ARRAY: [f32; 18] = [
    0.0, 0.0, 1.0, 0.0, 0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
];

const TRI_COLOR_ARRAY: [f32; 24] = [
    1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0,
    1.0,
];

const TRI_TEX_COORD_ARRAY: [f32; 12] = [0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0];

const CHECKER2_REPEATS: f32 = 4.0;
const TRI_TEX_COORD_ARRAY2: [f32; 12] = [
    0.0,
    0.0,
    CHECKER2_REPEATS,
    0.0,
    CHECKER2_REPEATS,
    CHECKER2_REPEATS,
    0.0,
    0.0,
    CHECKER2_REPEATS,
    CHECKER2_REPEATS,
    0.0,
    CHECKER2_REPEATS,
];

const ELEMENT_COLORS: [f32; 24] = [1.0; 24];

const ELEMENT_INDICES: [u16; 6] = [0, 1, 5, 2, 3, 1];

const ELEMENT_INDEX_SUB_DATA: [u16; 3] = [3, 4, 5];

const CHECKER_TEXTURE_DATA: [u8; 16] = [
    0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff,
];

const CHECKER2_TEXTURE_DATA: [u8; 16] = [
    0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff,
];

const DEFAULT_VERT: &str = "${VERSION}\n        uniform mat4 uModelViewProjectionMatrix;\n        in vec4 inColor;\n        in vec4 inVertex;\n        out vec4 color;\n\n        void main (void)\n        {\n            color = inColor;\n            gl_Position = uModelViewProjectionMatrix * inVertex;\n            gl_PointSize = 1.0;\n        }\n        ";

const DEFAULT_FRAG: &str = "\n        ${VERSION}\n        ${PRECISION}\n\n        in vec4 color;\n        out vec4 fragColor;\n\n        void main (void)\n        {\n            fragColor = color;\n        }\n        ";

const TRIANGLES_VERT: &str = "${VERSION}\n\n        in vec4 inColor;\n        in vec4 inVertex;\n        in vec3 inNormal;\n        in vec4 inMultiTexCoord0;\n\n        uniform mat4 uModelViewProjectionMatrix;\n        uniform mat3 uNormalMatrix;\n\n        out vec4 texCoord[1];\n        out vec4 color;\n\n        vec4 Ambient;\n        vec4 Diffuse;\n        vec4 Specular;\n\n        const vec3 lightPosition = vec3(0.0, 0.0, 1.0);\n        const vec3 spotDirection = vec3(0.0, 0.0, -1.0);\n        const float spotCutoff = 180.0;\n        const float spotExponent = 0.0;\n\n        const float lightAttenuationConstant = 1.0;\n        const float lightAttenuationLinear = 0.0;\n        const float lightAttenuationQuadratic = 0.0;\n\n        const vec4 lightAmbient = vec4(0.0, 0.0, 0.0, 0.0);\n        vec4 lightDiffuse = vec4(1.0, 1.0, 1.0, 1.0);\n        vec4 lightSpecular = vec4(1.0, 1.0, 1.0, 1.0);\n\n        const float materialShininess = 0.0;\n\n        const vec4 sceneColor = vec4(0.0, 0.0, 0.0, 0.0);\n\n        void spotLight(in int i, in vec3 normal, in vec3 eye, in vec3 ecPosition3)\n        {\n            float nDotVP;           // normal . light direction\n            float nDotHV;           // normal . light half vector\n            float pf;               // power factor\n            float spotDot;          // cosine of angle between spotlight\n            float spotAttenuation;  // spotlight attenuation factor\n            float attenuation;      // computed attenuation factor\n            float d;                // distance from surface to light source\n            vec3 VP;                // direction from surface to light position\n            vec3 halfVector;        // direction of maximum highlights\n\n            // Compute vector from surface to light position\n            VP = lightPosition - ecPosition3;\n\n            // Compute distance between surface and light position\n            d = length(VP);\n\n            // Normalize the vector from surface to light position\n            VP = normalize(VP);\n\n            // Compute attenuation\n            attenuation = 1.0 / (lightAttenuationConstant +\n            lightAttenuationLinear * d +\n            lightAttenuationQuadratic * d * d);\n\n            // See if point on surface is inside cone of illumination\n            spotDot = dot(-VP, normalize(spotDirection));\n\n            if (spotDot < cos(radians(spotCutoff)))\n                spotAttenuation = 0.0; // light adds no contribution\n            else\n                spotAttenuation = pow(spotDot, spotExponent);\n\n            // Combine the spotlight and distance attenuation.\n            attenuation *= spotAttenuation;\n\n            halfVector = normalize(VP + eye);\n\n            nDotVP = max(0.0, dot(normal, VP));\n            nDotHV = max(0.0, dot(normal, halfVector));\n\n            if (nDotVP == 0.0)\n                pf = 0.0;\n            else\n                pf = pow(nDotHV, materialShininess);\n\n            Ambient  += lightAmbient * attenuation;\n            Diffuse  += lightDiffuse * nDotVP * attenuation;\n            Specular += lightSpecular * pf * attenuation;\n        }\n\n        vec3 fnormal(void)\n        {\n            //Compute the normal\n            vec3 normal = uNormalMatrix * inNormal;\n            normal = normalize(normal);\n\n            return normal;\n        }\n\n        void flight(in vec3 normal, in vec4 ecPosition, float alphaFade)\n        {\n            vec3 ecPosition3;\n            vec3 eye;\n\n            ecPosition3 = (vec3 (ecPosition)) / ecPosition.w;\n            eye = vec3 (0.0, 0.0, 1.0);\n\n            // Clear the light intensity accumulators\n            Ambient  = vec4 (0.0);\n            Diffuse  = vec4 (0.0);\n            Specular = vec4 (0.0);\n\n            spotLight(0, normal, eye, ecPosition3);\n\n            color = sceneColor +\n            Ambient  * inColor +\n            Diffuse  * inColor;\n            color += Specular * inColor;\n            color = clamp( color, 0.0, 1.0 );\n\n            color.a *= alphaFade;\n        }\n\n        void main (void)\n        {\n            vec3  transformedNormal;\n            float alphaFade = 1.0;\n\n            vec4 ecPosition = inVertex;\n\n            color = inColor;\n            texCoord[0] = inMultiTexCoord0;\n            gl_Position = uModelViewProjectionMatrix * inVertex;\n            transformedNormal = fnormal();\n            flight(transformedNormal, ecPosition, alphaFade);\n        }\n        ";

const TRIANGLES_FRAG: &str = "\n        ${VERSION}\n        ${PRECISION}\n\n        uniform sampler2D uTexture0;\n        in vec4 color;\n        in vec4 texCoord[1];\n        out vec4 fragColor;\n\n        void main (void)\n        {\n            fragColor = texture(uTexture0, texCoord[0].st, 1.0) * color;\n        }\n        ";

const MULTI_VERT: &str = "${VERSION}\n        uniform mat4 uModelViewProjectionMatrix;\n\n        in vec4 inColor;\n        in vec4 inVertex;\n        in vec4 inMultiTexCoord0;\n        in vec4 inMultiTexCoord1;\n\n        out vec4 color;\n        out vec4 texCoord[2];\n\n        void main (void)\n        {\n            color = inColor;\n            texCoord[0] = inMultiTexCoord0;\n            texCoord[1] = inMultiTexCoord1;\n            gl_Position = uModelViewProjectionMatrix * inVertex;\n        }\n        ";

const MULTI_FRAG: &str = "\n        ${VERSION}\n        ${PRECISION}\n\n        uniform sampler2D uTexture0;\n        uniform sampler2D uTexture1;\n\n        in vec4 color;\n        in vec4 texCoord[2];\n        out vec4 fragColor;\n\n        void main (void)\n        {\n            fragColor = texture(uTexture0, texCoord[0].st, 1.0);\n            fragColor += texture(uTexture1, texCoord[1].st, 1.0);\n        }\n        ";

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

/// `tcu_fail_msg` for the rasterization checks
fn elements_error(prefix: &str, expected: [f32; 3], got: [u8; 3]) -> TestError {
    TestError::Fail(format!(
        "{prefix}Incorrectly rasterized buffer object: expected [{:.6}, {:.6}, {:.6}], got [{:.6}, {:.6}, {:.6}]",
        expected[0],
        expected[1],
        expected[2],
        f32::from(got[0]),
        f32::from(got[1]),
        f32::from(got[2])
    ))
}

fn fail<T>(message: &str) -> Result<T, TestError> {
    Err(TestError::Fail(message.to_string()))
}

/// `BufferObjectsTestBase::check_support`'s condition: `iterate` reports NotSupported unless GL_ARB_ES2_compatibility or a 3.0 context.
fn check_support(context: &Context) -> Result<(), TestError> {
    if !(context.context_info.is_extension_supported("GL_ARB_ES2_compatibility")
        || context.context_type().supports_core(3, 0))
    {
        return Err(TestError::NotSupported(
            "GL_ARB_ES2_compatibility is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `BufferObjectsTestBase` after `init` - what the render cases share.
struct Resources<'a> {
    gl: &'a glw::Functions,
    program: ShaderProgram<'a>,
    window_size: [i32; 2],
    mat_projection: [f32; 16],
    buffers: [glw::GLuint; BUFFER_LAST_ENUM],
    textures: [glw::GLuint; BUFOBJ_TEXTURES],
    vao: glw::GLuint,
}

impl Drop for Resources<'_> {
    /// `release_buffers`
    fn drop(&mut self) {
        // SAFETY: names this struct generated, deleted exactly once.
        unsafe {
            self.gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            self.gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
            self.gl.delete_buffers(BUFFER_LAST_ENUM as i32, self.buffers.as_ptr());
            self.gl.delete_textures(BUFOBJ_TEXTURES as i32, self.textures.as_ptr());
            if self.vao != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
        }
    }
}

fn buffer_data<T>(gl: &glw::Functions, target: GLenum, buffer: glw::GLuint, data: &[T]) -> Result<(), TestError> {
    // SAFETY: `data` outlives the upload.
    unsafe {
        gl.bind_buffer(target, buffer);
        glu::expect_no_error(gl, "bindBuffer")?;
        gl.buffer_data(
            target,
            std::mem::size_of_val(data) as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "bufferData")
}

/// The window-size dependent vertex data of `init`: the two triangles and the elements' vertices.
fn vertex_arrays(window_size: [i32; 2]) -> ([f32; 12], [f32; 12]) {
    let w = window_size[0] as f32;
    let h = window_size[1] as f32;

    let tri_vertex_array = [
        w / 4.0,
        h / 4.0,
        3.0 * w / 4.0,
        h / 4.0,
        3.0 * w / 4.0,
        3.0 * h / 4.0,
        w / 4.0,
        h / 4.0,
        3.0 * w / 4.0,
        3.0 * h / 4.0,
        w / 4.0,
        3.0 * h / 4.0,
    ];
    let element_vertices = [
        w / 4.0,
        h / 4.0,
        w / 2.0,
        h / 2.0,
        3.0 * w / 4.0,
        h / 4.0,
        3.0 * w / 4.0,
        3.0 * h / 4.0,
        w / 2.0,
        h / 2.0,
        w / 4.0,
        3.0 * h / 4.0,
    ];
    (tri_vertex_array, element_vertices)
}

impl<'a> Resources<'a> {
    /// `init` followed by `build_buffers`
    fn new(context: &'a Context, vert: &str, frag: &str) -> Result<Self, TestError> {
        let gl = context.gl();

        glu::reset_state_core(context);

        let version = context.context_type().glsl_version().declaration();
        let specialization_map = [("VERSION", version.to_string()), ("PRECISION", String::new())];

        let vshader = StringTemplate::new(vert).specialize(&specialization_map)?;
        let fshader = StringTemplate::new(frag).specialize(&specialization_map)?;
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vshader, fshader));
        if !program.is_ok() {
            return fail("Compile failed");
        }

        let target = context.render_target();
        let window_size = [target.width, target.height];
        let (tri_vertex_array, element_vertices) = vertex_arrays(window_size);

        // build_buffers
        // SAFETY: plain state setter.
        unsafe { gl.clear_color(0.0, 0.0, 0.0, 1.0) };
        glu::expect_no_error(gl, "clearColor")?;

        // tcu::ortho2DMatrix(0, w, 0, h, 1, -1), row-major
        let (l, r, b, t, n, f) = (
            0.0f32,
            window_size[0] as f32,
            0.0f32,
            window_size[1] as f32,
            1.0f32,
            -1.0f32,
        );
        let (inv_width, inv_height, inv_depth) = (1.0 / (r - l), 1.0 / (t - b), 1.0 / (f - n));
        let mut mat_projection = [0.0f32; 16];
        mat_projection[0] = 2.0 * inv_width;
        mat_projection[5] = 2.0 * inv_height;
        mat_projection[10] = 2.0 * inv_depth;
        mat_projection[12] = -(r + l) * inv_width;
        mat_projection[13] = -(t + b) * inv_height;
        mat_projection[14] = -(f + n) * inv_depth;
        mat_projection[15] = 1.0;

        let mut resources = Resources {
            gl,
            program,
            window_size,
            mat_projection,
            buffers: [0; BUFFER_LAST_ENUM],
            textures: [0; BUFOBJ_TEXTURES],
            vao: 0,
        };

        // SAFETY: the name is stored for `Drop` to delete.
        unsafe {
            gl.gen_vertex_arrays(1, &mut resources.vao);
            glu::expect_no_error(gl, "genVertexArrays")?;
            gl.bind_vertex_array(resources.vao);
            glu::expect_no_error(gl, "bindVertexArray")?;

            gl.gen_buffers(BUFFER_LAST_ENUM as i32, resources.buffers.as_mut_ptr());
            glu::expect_no_error(gl, "genBuffers")?;

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.buffers[BUFFER_TRIANGLES]);
            glu::expect_no_error(gl, "bindBuffer")?;

            let verts_sizeof = std::mem::size_of_val(&tri_vertex_array);
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                verts_sizeof as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "bufferData")?;

            let mut buf_size = 0;
            gl.get_buffer_parameteriv(glw::GL_ARRAY_BUFFER, glw::GL_BUFFER_SIZE, &mut buf_size);
            glu::expect_no_error(gl, "getBufferParameteriv")?;
            if buf_size as usize != verts_sizeof {
                return fail("BufferObjectsTestBase::build_buffers: Failed to create buffer store of correct size.");
            }

            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                verts_sizeof as isize,
                tri_vertex_array.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "bufferData")?;
        }

        let buffers = resources.buffers;
        buffer_data(gl, glw::GL_ARRAY_BUFFER, buffers[BUFFER_TRI_NORMALS], &TRI_NORMAL_ARRAY)?;
        buffer_data(gl, glw::GL_ARRAY_BUFFER, buffers[BUFFER_TRI_COLORS], &TRI_COLOR_ARRAY)?;
        buffer_data(gl, glw::GL_ARRAY_BUFFER, buffers[BUFFER_TEXTURE0], &TRI_TEX_COORD_ARRAY)?;
        buffer_data(
            gl,
            glw::GL_ARRAY_BUFFER,
            buffers[BUFFER_TEXTURE1],
            &TRI_TEX_COORD_ARRAY2,
        )?;
        buffer_data(
            gl,
            glw::GL_ARRAY_BUFFER,
            buffers[BUFFER_ELEMENT_VERTICES],
            &element_vertices,
        )?;
        buffer_data(
            gl,
            glw::GL_ARRAY_BUFFER,
            buffers[BUFFER_ELEMENT_COLORS],
            &ELEMENT_COLORS,
        )?;
        buffer_data(
            gl,
            glw::GL_ELEMENT_ARRAY_BUFFER,
            buffers[BUFFER_ELEMENT_INDICES],
            &ELEMENT_INDICES,
        )?;

        // SAFETY: state setters, and texture uploads from the two 2x2 RGBA8 arrays.
        unsafe {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
            glu::expect_no_error(gl, "bindBuffer")?;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            glu::expect_no_error(gl, "bindBuffer")?;

            gl.active_texture(glw::GL_TEXTURE0);
            glu::expect_no_error(gl, "activeTexture")?;

            gl.gen_textures(BUFOBJ_TEXTURES as i32, resources.textures.as_mut_ptr());
            glu::expect_no_error(gl, "genTextures")?;

            for (unit, data, wrap) in [
                (glw::GL_TEXTURE0, &CHECKER_TEXTURE_DATA, glw::GL_CLAMP_TO_EDGE),
                (glw::GL_TEXTURE1, &CHECKER2_TEXTURE_DATA, glw::GL_REPEAT),
            ] {
                let index = (unit - glw::GL_TEXTURE0) as usize;
                if index == 1 {
                    gl.active_texture(unit);
                    glu::expect_no_error(gl, "activeTexture")?;
                }
                gl.bind_texture(glw::GL_TEXTURE_2D, resources.textures[index]);
                glu::expect_no_error(gl, "bindTexture")?;
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA as i32,
                    2,
                    2,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage2D")?;
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, wrap as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, wrap as i32);
                glu::expect_no_error(gl, "texParameteri")?;
            }

            gl.active_texture(glw::GL_TEXTURE0);
            glu::expect_no_error(gl, "activeTexture")?;
        }

        Ok(resources)
    }

    fn program_id(&self) -> glw::GLuint {
        self.program.program()
    }

    /// The `uModelViewProjectionMatrix` upload every render case starts with.
    fn use_program_and_projection(&self) -> Result<(), TestError> {
        let gl = self.gl;
        // SAFETY: a program that built; a 4x4 matrix for a mat4 uniform.
        unsafe {
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "clear")?;

            gl.use_program(self.program_id());
            glu::expect_no_error(gl, "useProgram")?;

            let loc_mat_projection = gl.get_uniform_location(self.program_id(), c"uModelViewProjectionMatrix".as_ptr());
            glu::expect_no_error(gl, "getUniformLocation")?;
            if loc_mat_projection != -1 {
                gl.uniform_matrix_4fv(loc_mat_projection, 1, 0, self.mat_projection.as_ptr());
                glu::expect_no_error(gl, "uniformMatrix4fv")?;
            }
        }
        Ok(())
    }

    fn attrib_location(&self, name: &std::ffi::CStr) -> Result<glw::GLint, TestError> {
        // SAFETY: a linked program and a NUL-terminated name.
        let location = unsafe { self.gl.get_attrib_location(self.program_id(), name.as_ptr()) };
        glu::expect_no_error(self.gl, "getAttribLocation")?;
        Ok(location)
    }

    /// enableVertexAttribArray, bindBuffer and vertexAttribPointer for one attribute, as every case repeats them.
    fn setup_attrib(&self, location: glw::GLint, buffer: glw::GLuint, components: i32) -> Result<(), TestError> {
        let gl = self.gl;
        // SAFETY: an attribute location the program reported, and a buffer this struct made.
        unsafe {
            gl.enable_vertex_attrib_array(location as u32);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
            gl.vertex_attrib_pointer(
                location as u32,
                components,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null(),
            );
        }
        glu::expect_no_error(gl, "vertexAttribPointer")
    }

    fn disable_attrib(&self, location: glw::GLint) -> Result<(), TestError> {
        // SAFETY: an attribute location the program reported.
        unsafe { self.gl.disable_vertex_attrib_array(location as u32) };
        glu::expect_no_error(self.gl, "disableVertexAttribArray")
    }

    fn unbind_buffers(&self) -> Result<(), TestError> {
        // SAFETY: unbinding.
        unsafe {
            self.gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            self.gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        }
        glu::expect_no_error(self.gl, "bindBuffer")
    }
}

fn pass() -> TestOutcome {
    Ok(TestStatus::pass("Pass"))
}

/// `BufferObjectsTestGenBuffersCase::run_test` - needs no shaders and builds no buffers.
fn gen_buffers_case(context: &Context) -> TestOutcome {
    let gl = context.gl();
    const N_TESTED_BUFS: usize = 2;
    let targets: [GLenum; 2] = [glw::GL_ARRAY_BUFFER, glw::GL_ELEMENT_ARRAY_BUFFER];
    let usages: [GLenum; 2] = [glw::GL_STATIC_DRAW, glw::GL_DYNAMIC_DRAW];
    let mut bufs = [0u32; N_TESTED_BUFS];
    let mut twin_bufs = [0u32; 2];
    let dummy0: u32 = 0;
    let buf: u32 = 128;

    glu::reset_state_core(context);

    let window = context.render_target();
    let (tri_vertex_array, _) = vertex_arrays([window.width, window.height]);

    // SAFETY: names generated here; the data pointers outlive the calls; the calls that are meant to fail write nothing.
    unsafe {
        gl.gen_buffers(N_TESTED_BUFS as i32, bufs.as_mut_ptr());
        glu::expect_no_error(gl, "genBuffers")?;

        for usage in usages {
            // Loop both usage types
            for target in targets {
                // Loop both target types
                for buffer in bufs {
                    gl.bind_buffer(target, buffer);
                    glu::expect_no_error(gl, "bindBuffer")?;

                    if gl.is_buffer(buffer) == 0 {
                        return fail("BufferObjectsTestGenBuffersCase::run_test: glIs buffer not functioning properly");
                    }
                }

                gl.bind_buffer(target, 0); // Must free the target.
                glu::expect_no_error(gl, "bindBuffer")?;

                let vec_sizeof = std::mem::size_of_val(&tri_vertex_array);
                gl.buffer_data(target, vec_sizeof as isize, tri_vertex_array.as_ptr().cast(), usage);
                if gl.get_error() == glw::GL_NO_ERROR {
                    return fail(
                        "BufferObjectsTestGenBuffersCase::run_test: glBufferData not returning failure state.",
                    );
                }

                gl.buffer_sub_data(target, 0, vec_sizeof as isize, tri_vertex_array.as_ptr().cast());
                if gl.get_error() == glw::GL_NO_ERROR {
                    return fail(
                        "BufferObjectsTestGenBuffersCase::run_test: glBufferSubData not returning failure state.",
                    );
                }
            }
        }

        gl.delete_buffers(N_TESTED_BUFS as i32, bufs.as_ptr());
        glu::expect_no_error(gl, "deleteBuffers")?;

        gl.gen_buffers(2, twin_bufs.as_mut_ptr());
        glu::expect_no_error(gl, "genBuffers")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, twin_bufs[0]);
        glu::expect_no_error(gl, "bindBuffer")?;
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, twin_bufs[1]);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.delete_buffers(N_TESTED_BUFS as i32, twin_bufs.as_ptr());
        glu::expect_no_error(gl, "deleteBuffers")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.delete_buffers(N_TESTED_BUFS as i32, bufs.as_ptr());
        glu::expect_no_error(gl, "deleteBuffers")?;

        gl.gen_buffers(-1, bufs.as_mut_ptr());
        if gl.get_error() == glw::GL_NO_ERROR {
            return fail("BufferObjectsTestGenBuffersCase::run_test: No error on invalid number of generated buffers.");
        }

        gl.delete_buffers(-1, bufs.as_ptr());
        if gl.get_error() == glw::GL_NO_ERROR {
            return fail("BufferObjectsTestGenBuffersCase::run_test: No error on invalid number of generated buffers.");
        }

        gl.delete_buffers(1, &dummy0); // Quiet ignore
        glu::expect_no_error(gl, "deleteBuffers")?;

        for target in targets {
            // Loop both target types
            gl.bind_buffer(target, buf);
            if context.context_type().supports_core(3, 1) && gl.get_error() != glw::GL_INVALID_OPERATION {
                return fail("BufferObjectsTestGenBuffersCase::run_test: No error when binding not generated buffer");
            }
        }
    }

    pass()
}

/// `BufferObjectsTestTrianglesCase::run_test`
fn triangles_case(context: &Context) -> TestOutcome {
    let resources = Resources::new(context, TRIANGLES_VERT, TRIANGLES_FRAG)?;
    let gl = resources.gl;
    let window_width = resources.window_size[0];
    let window_height = resources.window_size[1];
    let mut buf = [0u8; 4];
    let mut buf_cmp = [0u8; 4];

    resources.use_program_and_projection()?;

    // SAFETY: a program that built; a 3x3 identity for a mat3 uniform.
    unsafe {
        let loc_mat_normal = gl.get_uniform_location(resources.program_id(), c"uNormalMatrix".as_ptr());
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc_mat_normal != -1 {
            let mut mat_normal = [0.0f32; 9];
            mat_normal[0] = 1.0;
            mat_normal[4] = 1.0;
            mat_normal[8] = 1.0;
            gl.uniform_matrix_3fv(loc_mat_normal, 1, glw::FALSE, mat_normal.as_ptr());
            glu::expect_no_error(gl, "uniformMatrix3fv")?;
        }
    }

    let loc_vertices = resources.attrib_location(c"inVertex")?;
    let loc_colors = resources.attrib_location(c"inColor")?;
    let loc_normals = resources.attrib_location(c"inNormal")?;
    let loc_tex_coords = resources.attrib_location(c"inMultiTexCoord0")?;

    // SAFETY: attribute locations the program reported.
    unsafe {
        gl.enable_vertex_attrib_array(loc_vertices as u32);
        gl.enable_vertex_attrib_array(loc_colors as u32);
        gl.enable_vertex_attrib_array(loc_normals as u32);
        gl.enable_vertex_attrib_array(loc_tex_coords as u32);
    }
    glu::expect_no_error(gl, "enableVertexAttribArray")?;

    // SAFETY: a program that built; a texture this struct made.
    unsafe {
        let loc_textures0 = gl.get_uniform_location(resources.program_id(), c"uTexture0".as_ptr());
        glu::expect_no_error(gl, "getUniformLocation")?;
        if loc_textures0 != -1 {
            gl.active_texture(glw::GL_TEXTURE0);
            glu::expect_no_error(gl, "activeTexture")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, resources.textures[0]);
            glu::expect_no_error(gl, "bindTexture")?;

            gl.uniform_1i(loc_textures0, 0);
            glu::expect_no_error(gl, "uniform1i")?;
        }
    }

    let buffers = resources.buffers;
    resources.setup_attrib(loc_normals, buffers[BUFFER_TRI_NORMALS], 3)?;
    resources.setup_attrib(loc_colors, buffers[BUFFER_TRI_COLORS], 4)?;
    resources.setup_attrib(loc_tex_coords, buffers[BUFFER_TEXTURE0], 2)?;
    resources.setup_attrib(loc_vertices, buffers[BUFFER_TRIANGLES], 2)?;

    // SAFETY: a draw from the attributes set up above.
    unsafe {
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        glu::expect_no_error(gl, "drawArrays")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }
    glu::expect_no_error(gl, "bindBuffer")?;

    for location in [loc_vertices, loc_colors, loc_normals, loc_tex_coords] {
        resources.disable_attrib(location)?;
    }

    // The vertices are contained correctly and (at least) a triangle is rendered, the texture is applied correctly and the colors have been applied correctly.
    let elements_error_prefix = "BufferObjectsTestTrianglesCase::run_test: ";
    read_screen(
        gl,
        window_width / 4 + 1,
        3 * window_height / 4 - 1,
        1,
        1,
        glw::GL_RGBA,
        &mut buf,
    )?;
    if (f32::from(buf[0]) - 0.0).abs() > 8.0
        || (f32::from(buf[1]) - 255.0).abs() > 8.0
        || (f32::from(buf[2]) - 0.0).abs() > 8.0
    {
        return Err(elements_error(
            elements_error_prefix,
            [0.0, 1.0, 0.0],
            [buf[0], buf[1], buf[2]],
        ));
    }

    read_screen(
        gl,
        3 * window_width / 8 + 1,
        3 * window_height / 8 + 1,
        1,
        1,
        glw::GL_RGBA,
        &mut buf,
    )?;
    if (f32::from(buf[0]) - 0.0).abs() > 8.0
        || (f32::from(buf[1]) - 0.0).abs() > 8.0
        || (f32::from(buf[2]) - 0.0).abs() > 8.0
    {
        return Err(elements_error(
            elements_error_prefix,
            [0.0, 1.0, 0.0],
            [buf[0], buf[1], buf[2]],
        ));
    }

    read_screen(
        gl,
        3 * window_width / 4 - 1,
        window_height / 4 + 1,
        1,
        1,
        glw::GL_RGBA,
        &mut buf,
    )?;
    read_screen(
        gl,
        5 * window_width / 8,
        3 * window_height / 8 + 1,
        1,
        1,
        glw::GL_RGBA,
        &mut buf_cmp,
    )?;
    if (f32::from(buf_cmp[0]) - f32::from(buf[0])) < 2.0 * 8.0
        || f32::from(buf_cmp[0]) < 2.0 * 8.0
        || (f32::from(buf[1]) - 0.0).abs() > 8.0
        || (f32::from(buf[2]) - 0.0).abs() > 8.0
    {
        return fail("BufferObjectsTestTrianglesCase::run_test: Buffer object incorrectly wraps a normal.");
    }

    pass()
}

/// `BufferObjectsTestElementsCase::run_test`
fn elements_case(context: &Context) -> TestOutcome {
    let resources = Resources::new(context, DEFAULT_VERT, DEFAULT_FRAG)?;
    let gl = resources.gl;
    let window_width = resources.window_size[0];
    let window_height = resources.window_size[1];
    let mut buf = [0u8; 4];

    resources.use_program_and_projection()?;

    let loc_vertices = resources.attrib_location(c"inVertex")?;
    if loc_vertices != -1 {
        resources.setup_attrib(loc_vertices, resources.buffers[BUFFER_ELEMENT_VERTICES], 2)?;
    }

    let loc_colors = resources.attrib_location(c"inColor")?;
    if loc_colors != -1 {
        resources.setup_attrib(loc_colors, resources.buffers[BUFFER_ELEMENT_COLORS], 4)?;
    }

    // SAFETY: a draw from the attributes and the element buffer set up above.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, resources.buffers[BUFFER_ELEMENT_INDICES]);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());
        glu::expect_no_error(gl, "drawElements")?;
    }

    resources.unbind_buffers()?;

    if loc_vertices != -1 {
        resources.disable_attrib(loc_vertices)?;
    }
    if loc_colors != -1 {
        resources.disable_attrib(loc_colors)?;
    }

    // The center of the shape and the middle of the bottom edge are black, the sides of the shape white.
    let elements_error_prefix = "BufferObjectsTestElementsCase::run_test: ";
    for (x, y, expected) in [
        (window_width / 2, 3 * window_height / 4 - 1, 0u8),
        (window_width / 2, window_height / 4, 0),
        (window_width / 4 + 1, window_height / 2, 255),
        (3 * window_width / 4 - 1, window_height / 2, 255),
    ] {
        read_screen(gl, x, y, 1, 1, glw::GL_RGBA, &mut buf)?;
        if (0..3).any(|channel| (i32::from(buf[channel]) - i32::from(expected)).abs() > 8) {
            let expected_float = f32::from(expected) / 255.0;
            return Err(elements_error(
                elements_error_prefix,
                [expected_float; 3],
                [buf[0], buf[1], buf[2]],
            ));
        }
    }

    pass()
}

/// `BufferObjectsTestMultiTexturingCase::run_test`
fn multi_texturing_case(context: &Context) -> TestOutcome {
    let resources = Resources::new(context, MULTI_VERT, MULTI_FRAG)?;
    let gl = resources.gl;
    let window_width = resources.window_size[0];
    let window_height = resources.window_size[1];
    let mut buf_colors = vec![0u8; ((window_width + 3) / 2 * 4) as usize];

    resources.use_program_and_projection()?;

    let attribs = [
        (c"inVertex", BUFFER_TRIANGLES, 2),
        (c"inColor", BUFFER_TRI_COLORS, 4),
        (c"inMultiTexCoord0", BUFFER_TEXTURE0, 2),
        (c"inMultiTexCoord1", BUFFER_TEXTURE1, 2),
    ];
    let mut locations = Vec::new();
    for (name, buffer, components) in attribs {
        let location = resources.attrib_location(name)?;
        if location != -1 {
            resources.setup_attrib(location, resources.buffers[buffer], components)?;
        }
        locations.push(location);
    }

    for (name, unit, texture_index) in [
        (c"uTexture0", glw::GL_TEXTURE0, 0usize),
        (c"uTexture1", glw::GL_TEXTURE1, 1usize),
    ] {
        // SAFETY: a program that built; textures this struct made.
        unsafe {
            let location = gl.get_uniform_location(resources.program_id(), name.as_ptr());
            glu::expect_no_error(gl, "getUniformLocation")?;
            if location != -1 {
                gl.active_texture(unit);
                glu::expect_no_error(gl, "activeTexture")?;

                // checker texture. Set the ClientActiveTexture accordingly. Set the pointer.
                gl.bind_texture(glw::GL_TEXTURE_2D, resources.textures[texture_index]);
                glu::expect_no_error(gl, "bindTexture")?;

                gl.uniform_1i(location, texture_index as i32);
                glu::expect_no_error(gl, "uniform1i")?;
            }
        }
    }

    // SAFETY: a draw from the attributes set up above, then unbinding.
    unsafe {
        gl.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        glu::expect_no_error(gl, "drawArrays")?;

        gl.active_texture(glw::GL_TEXTURE1);
        glu::expect_no_error(gl, "activeTexture")?;
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        glu::expect_no_error(gl, "bindTexture")?;

        gl.active_texture(glw::GL_TEXTURE0);
        glu::expect_no_error(gl, "activeTexture")?;
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        glu::expect_no_error(gl, "bindTexture")?;
    }

    resources.unbind_buffers()?;

    for location in locations {
        if location != -1 {
            resources.disable_attrib(location)?;
        }
    }

    read_screen(
        gl,
        window_width / 4 + 1,
        3 * window_height / 4 - 3,
        (window_width + 3) / 2,
        1,
        glw::GL_RGBA,
        &mut buf_colors,
    )?;

    let mut prev_px = 1; // We should start from a black pixel
    let mut white_count = 0;
    let mut black_count = 0;
    for i in 0..((window_width + 3) / 2) as usize {
        if i32::from(buf_colors[i * 4]).abs() < 8 && prev_px != 0 {
            prev_px = 0;
            black_count += 1;
        }
        if (i32::from(buf_colors[i * 4]) - 255).abs() < 8 && prev_px != 1 {
            prev_px = 1;
            white_count += 1;
        }
    }

    if black_count != 3 || white_count != 2 {
        return fail("BufferObjectsTestMultiTexturingCase::run_test: Multitexturing with buffer objects failed.");
    }

    pass()
}

/// `BufferObjectsTestSubDataCase::run_test`
fn sub_data_case(context: &Context) -> TestOutcome {
    let resources = Resources::new(context, DEFAULT_VERT, DEFAULT_FRAG)?;
    let gl = resources.gl;
    let window_width = resources.window_size[0];
    let window_height = resources.window_size[1];
    let mut buf = [0u8; 4];
    let mut temp_object: glw::GLuint = 0;

    resources.use_program_and_projection()?;

    let loc_vertices = resources.attrib_location(c"inVertex")?;
    if loc_vertices != -1 {
        resources.setup_attrib(loc_vertices, resources.buffers[BUFFER_TRIANGLES], 2)?;
    }

    let loc_colors = resources.attrib_location(c"inColor")?;
    if loc_colors != -1 {
        resources.setup_attrib(loc_colors, resources.buffers[BUFFER_TRI_COLORS], 4)?;
    }

    // SAFETY: a temporary element buffer filled, patched and drawn from; deleted below.
    unsafe {
        gl.gen_buffers(1, &mut temp_object);
        glu::expect_no_error(gl, "genBuffers")?;

        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, temp_object);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            std::mem::size_of_val(&ELEMENT_INDICES) as isize,
            ELEMENT_INDICES.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        glu::expect_no_error(gl, "bufferData")?;

        gl.buffer_sub_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            3 * std::mem::size_of::<u16>() as isize,
            3 * std::mem::size_of::<u16>() as isize,
            ELEMENT_INDEX_SUB_DATA.as_ptr().cast(),
        );
        glu::expect_no_error(gl, "bufferSubData")?;

        gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());
        glu::expect_no_error(gl, "drawElements")?;

        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.delete_buffers(1, &temp_object);
        glu::expect_no_error(gl, "deleteBuffers")?;
    }

    resources.disable_attrib(loc_vertices)?;
    resources.disable_attrib(loc_colors)?;

    // If the glBufferSubData call did not actually do anything, then the geometry is a different one and the pixel at 1 is black, the one at 2 is not.
    let is_black = |b: &[u8; 4]| b[0] == 0 && b[1] == 0 && b[2] == 0;
    read_screen(
        gl,
        window_width / 2,
        2 * window_height / 3,
        1,
        1,
        glw::GL_RGBA,
        &mut buf,
    )?;
    if is_black(&buf) {
        return fail(
            "BufferObjectsTestSubDataCase::run_test: BufferSubData did not replace buffer object data correctly (not black).",
        );
    }

    read_screen(
        gl,
        2 * window_width / 3,
        window_height / 2,
        1,
        1,
        glw::GL_RGBA,
        &mut buf,
    )?;
    if !is_black(&buf) {
        return fail(
            "BufferObjectsTestSubDataCase::run_test: BufferSubData did not replace buffer object data correctly (not black).",
        );
    }

    pass()
}

/// The cases of `BufferObjectsTests`.
struct BufferObjectsCase {
    name: &'static str,
    run: fn(&Context) -> TestOutcome,
}

impl TestCase for BufferObjectsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        (self.run)(context)
    }
}

/// `BufferObjectsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_objects");
    for (name, run) in [
        ("gen_buffers", gen_buffers_case as fn(&Context) -> TestOutcome),
        ("triangles", triangles_case),
        ("elements", elements_case),
        ("multi_texture", multi_texturing_case),
        ("sub_data", sub_data_case),
    ] {
        group.add_child(Box::new(BufferObjectsCase { name, run }) as Box<dyn TestCase>);
    }
    group
}
