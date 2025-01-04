// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferActiveUniformValidation.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// Buffer size for uniform variable name
const PARAM_VALUE_SIZE: usize = 100;

const FRAGMENT_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "uniform highp samplerBuffer  sampler_buffer;\n",
    "uniform highp isamplerBuffer isampler_buffer;\n",
    "uniform highp usamplerBuffer usampler_buffer;\n",
    "\n",
    "layout(location = 0) out vec4 outColor;\n",
    "void main(void)\n",
    "{\n",
    "    outColor =  texelFetch(sampler_buffer, 0);\n",
    "    outColor += vec4(texelFetch(isampler_buffer, 0));\n",
    "    outColor += vec4(texelFetch(usampler_buffer, 0));\n",
    "}\n",
);

const VERTEX_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n",
    "}\n",
);

const COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "layout(r32f)  uniform highp imageBuffer    image_buffer;\n",
    "layout(r32i)  uniform highp iimageBuffer   iimage_buffer;\n",
    "layout(r32ui) uniform highp uimageBuffer   uimage_buffer;\n",
    "\n",
    "layout (local_size_x = 1) in;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    imageStore(image_buffer,  0, vec4 (1.0, 1.0, 1.0, 1.0));\n",
    "    imageStore(iimage_buffer, 0, ivec4(1,   1,   1,   1)  );\n",
    "    imageStore(uimage_buffer, 0, uvec4(1,   1,   1,   1)  );\n",
    "}\n",
);

/// `TextureParameters`
struct TextureParameters {
    texture_buffer_size: GLuint,
    texture_format: GLenum,
    texture_uniform_type: GLenum,
    uniform_name: &'static str,
}

/// Which of upstream's two derived classes this case is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Variant {
    /// `TextureBufferActiveUniformValidationVSFS`
    VertexFragment,
    /// `TextureBufferActiveUniformValidationCS`
    Compute,
}

/// `TextureBufferActiveUniformValidation`
pub(super) struct ActiveUniformValidation {
    pub(super) ext_params: ExtParameters,
    pub(super) variant: Variant,
}

/// The members `initTest` fills and `deinit` releases.
#[derive(Default)]
struct Objects {
    po_id: GLuint,
    fs_id: GLuint,
    vs_id: GLuint,
    cs_id: GLuint,
    tbo_ids: Vec<GLuint>,
    tbo_tex_ids: Vec<GLuint>,
    texture_params: Vec<TextureParameters>,
}

impl ActiveUniformValidation {
    /// `configureParams`
    fn configure_params(&self, base: &TestCaseBase) -> Vec<TextureParameters> {
        let tokens = &base.gl_ext_tokens;
        let param =
            |texture_uniform_type, texture_format, texture_buffer_size: usize, uniform_name| TextureParameters {
                texture_buffer_size: texture_buffer_size as GLuint,
                texture_format,
                texture_uniform_type,
                uniform_name,
            };

        match self.variant {
            Variant::VertexFragment => vec![
                param(
                    tokens.sampler_buffer,
                    glw::GL_R32F,
                    size_of::<glw::GLfloat>(),
                    "sampler_buffer",
                ),
                param(
                    tokens.int_sampler_buffer,
                    glw::GL_R32I,
                    size_of::<GLint>(),
                    "isampler_buffer",
                ),
                param(
                    tokens.unsigned_int_sampler_buffer,
                    glw::GL_R32UI,
                    size_of::<GLuint>(),
                    "usampler_buffer",
                ),
            ],
            Variant::Compute => vec![
                param(
                    tokens.image_buffer,
                    glw::GL_R32F,
                    size_of::<glw::GLfloat>(),
                    "image_buffer",
                ),
                param(
                    tokens.int_image_buffer,
                    glw::GL_R32I,
                    size_of::<GLint>(),
                    "iimage_buffer",
                ),
                param(
                    tokens.unsigned_int_image_buffer,
                    glw::GL_R32UI,
                    size_of::<GLuint>(),
                    "uimage_buffer",
                ),
            ],
        }
    }

    /// `createProgram`
    fn create_program(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();

        // SAFETY: object creation on the current context.
        unsafe { objects.po_id = gl.create_program() };
        glu::expect_no_error(gl, "Error creating program object!")?;

        match self.variant {
            Variant::VertexFragment => {
                // SAFETY: as above.
                unsafe { objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER) };
                glu::expect_no_error(gl, "Error creating shader object!")?;

                // SAFETY: as above.
                unsafe { objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER) };
                glu::expect_no_error(gl, "Error creating shader object!")?;

                let fs_parts = [FRAGMENT_SHADER_CODE];
                let vs_parts = [VERTEX_SHADER_CODE];
                let stages = [
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                ];
                if !base.build_program(context, objects.po_id, &stages)?.0 {
                    return Err(TestError::Fail("Error building a program!".to_string()));
                }
            }
            Variant::Compute => {
                // SAFETY: as above.
                unsafe { objects.cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
                glu::expect_no_error(gl, "Error creating shader object!")?;

                let cs_parts = [COMPUTE_SHADER_CODE];
                if !base
                    .build_program(context, objects.po_id, &[ShaderBody::Source(objects.cs_id, &cs_parts)])?
                    .0
                {
                    return Err(TestError::Fail("Error building a program!".to_string()));
                }
            }
        }
        Ok(())
    }

    /// `configureProgram`
    fn configure_program(&self, context: &Context, base: &TestCaseBase, objects: &Objects) -> Result<(), TestError> {
        let gl = context.gl();

        for (i, param) in objects.texture_params.iter().enumerate() {
            match self.variant {
                Variant::VertexFragment => {
                    let name = CString::new(param.uniform_name).expect("uniform names have no NUL");
                    // SAFETY: a NUL-terminated name on the program in use.
                    let location = unsafe { gl.get_uniform_location(objects.po_id, name.as_ptr()) };
                    glu::expect_no_error(gl, "Error getting uniform location!")?;
                    if location == -1 {
                        return Err(TestError::Fail(
                            "Could not get uniform location for active uniform variable".to_string(),
                        ));
                    }

                    // SAFETY: plain state calls on texture names created in init_test.
                    unsafe { gl.active_texture(glw::GL_TEXTURE0 + i as GLenum) };
                    glu::expect_no_error(gl, "Error activating texture unit!")?;
                    // SAFETY: as above.
                    unsafe { gl.bind_texture(base.gl_ext_tokens.texture_buffer, objects.tbo_tex_ids[i]) };
                    glu::expect_no_error(gl, "Error binding texture object!")?;
                    // SAFETY: as above.
                    unsafe { gl.uniform_1i(location, i as GLint) };
                    glu::expect_no_error(gl, "Error setting value for uniform location!")?;
                }
                Variant::Compute => {
                    // SAFETY: plain state call on a texture name created in init_test.
                    unsafe {
                        gl.bind_image_texture(
                            i as GLuint,
                            objects.tbo_tex_ids[i],
                            0,
                            glw::FALSE,
                            0,
                            glw::GL_WRITE_ONLY,
                            param.texture_format,
                        )
                    };
                    glu::expect_no_error(gl, "Error binding texture to image unit!")?;
                }
            }
        }
        Ok(())
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        objects.texture_params = self.configure_params(base);
        let count = objects.texture_params.len();
        objects.tbo_tex_ids = vec![0; count];
        objects.tbo_ids = vec![0; count];

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        for i in 0..count {
            let param = &objects.texture_params[i];

            gl_call!(
                gl,
                "Error generating buffer object!",
                gl.gen_buffers(1, &mut objects.tbo_ids[i])
            );
            gl_call!(
                gl,
                "Error binding buffer object !",
                gl.bind_buffer(tokens.texture_buffer, objects.tbo_ids[i])
            );
            gl_call!(
                gl,
                "Error allocating buffer object's data store!",
                gl.buffer_data(
                    tokens.texture_buffer,
                    param.texture_buffer_size as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_DRAW
                )
            );

            gl_call!(
                gl,
                "Error generating texture object!",
                gl.gen_textures(1, &mut objects.tbo_tex_ids[i])
            );
            gl_call!(
                gl,
                "Error activating texture unit!",
                gl.active_texture(glw::GL_TEXTURE0 + i as GLenum)
            );
            gl_call!(
                gl,
                "Error binding texture object!",
                gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_ids[i])
            );
            gl_call!(
                gl,
                "Error setting buffer object as data store for texture buffer!",
                gl.tex_buffer(tokens.texture_buffer, param.texture_format, objects.tbo_ids[i])
            );
        }

        self.create_program(context, base, objects)
    }

    /// `deinit`, including the derived classes' part that runs first.
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.use_program(0);

            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
                objects.po_id = 0;
            }
            for shader in [&mut objects.fs_id, &mut objects.vs_id, &mut objects.cs_id] {
                if *shader != 0 {
                    gl.delete_shader(*shader);
                    *shader = 0;
                }
            }

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(tokens.texture_buffer, 0);

            for i in 0..objects.texture_params.len() {
                gl.active_texture(glw::GL_TEXTURE0 + i as GLenum);
                gl.bind_texture(tokens.texture_buffer, 0);
            }
            gl.active_texture(glw::GL_TEXTURE0);

            if !objects.tbo_tex_ids.is_empty() {
                gl.delete_textures(objects.texture_params.len() as GLsizei, objects.tbo_tex_ids.as_ptr());
                objects.tbo_tex_ids.clear();
            }
            if !objects.tbo_ids.is_empty() {
                gl.delete_buffers(objects.texture_params.len() as GLsizei, objects.tbo_ids.as_ptr());
                objects.tbo_ids.clear();
            }
        }
        objects.texture_params.clear();
    }

    /// `getUniformTypeName`
    fn uniform_type_name(base: &TestCaseBase, uniform_type: GLenum) -> &'static str {
        let tokens = &base.gl_ext_tokens;
        if uniform_type == tokens.sampler_buffer {
            "GL_SAMPLER_BUFFER_EXT"
        } else if uniform_type == tokens.int_sampler_buffer {
            "GL_INT_SAMPLER_BUFFER_EXT"
        } else if uniform_type == tokens.unsigned_int_sampler_buffer {
            "GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT"
        } else if uniform_type == tokens.image_buffer {
            "GL_IMAGE_BUFFER_EXT"
        } else if uniform_type == tokens.int_image_buffer {
            "GL_INT_IMAGE_BUFFER_EXT"
        } else if uniform_type == tokens.unsigned_int_image_buffer {
            "GL_UNSIGNED_INT_IMAGE_BUFFER_EXT"
        } else {
            "UNKNOWN"
        }
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        self.init_test(context, base, objects)?;

        let gl = context.gl();
        let mut test_result = true;

        gl_call!(
            gl,
            "Error setting active program object!",
            gl.use_program(objects.po_id)
        );

        self.configure_program(context, base, objects)?;

        let mut n_active_uniforms: GLint = 0;
        gl_call!(
            gl,
            "Error getting value of GL_ACTIVE_UNIFORMS!",
            gl.get_programiv(objects.po_id, glw::GL_ACTIVE_UNIFORMS, &mut n_active_uniforms)
        );

        if n_active_uniforms as usize != objects.texture_params.len() {
            log::info!(
                "Result is different than expected!\nExpected number of active uniforms: {}\nResult   number of active uniforms: {n_active_uniforms}\n",
                objects.texture_params.len()
            );
            test_result = false;
        }

        let mut name_value = vec![0u8; PARAM_VALUE_SIZE];
        let mut result_types: Vec<GLenum> = Vec::new();

        for i in 0..n_active_uniforms as GLuint {
            let mut param_length: GLsizei = 0;
            let mut uniform_size: GLint = 0;
            let mut uniform_type: GLenum = 0;

            // SAFETY: the name buffer holds PARAM_VALUE_SIZE bytes and at most one byte less is requested.
            unsafe {
                gl.get_active_uniform(
                    objects.po_id,
                    i,
                    (PARAM_VALUE_SIZE - 1) as GLsizei,
                    &mut param_length,
                    &mut uniform_size,
                    &mut uniform_type,
                    name_value.as_mut_ptr().cast(),
                )
            };
            glu::expect_no_error(gl, "Error getting information about active uniform variable!")?;

            let name_end = name_value.iter().position(|&b| b == 0).unwrap_or(name_value.len());
            let returned_name = String::from_utf8_lossy(&name_value[..name_end]).into_owned();

            match objects
                .texture_params
                .iter()
                .find(|param| param.texture_uniform_type == uniform_type)
            {
                None => {
                    log::info!(
                        "Following uniform type was not expected to be defined in current program : \n{}\n",
                        Self::uniform_type_name(base, uniform_type)
                    );
                    test_result = false;
                }
                Some(param) if returned_name != param.uniform_name => {
                    log::info!(
                        "For :{} type name \nexpected  uniform name is: {}\nresult    uniform name is: {returned_name}\n",
                        Self::uniform_type_name(base, uniform_type),
                        param.uniform_name
                    );
                    test_result = false;
                }
                Some(_) => {}
            }

            result_types.push(uniform_type);
        }

        for i in 0..n_active_uniforms as usize {
            let Some(param) = objects.texture_params.get(i) else {
                continue;
            };

            if !result_types.contains(&param.texture_uniform_type) {
                log::info!(
                    "Following uniform type is missing from active uniforms list: {}\n",
                    Self::uniform_type_name(base, param.texture_uniform_type)
                );
                test_result = false;
            }
        }

        let indices: Vec<GLuint> = (0..n_active_uniforms as GLuint).collect();
        let mut types: Vec<GLint> = vec![0; n_active_uniforms as usize];

        // SAFETY: `indices` and `types` both hold n_active_uniforms entries.
        unsafe {
            gl.get_active_uniformsiv(
                objects.po_id,
                n_active_uniforms,
                indices.as_ptr(),
                glw::GL_UNIFORM_TYPE,
                types.as_mut_ptr(),
            )
        };
        glu::expect_no_error(gl, "Error getting information about active uniform variables!")?;

        for (i, &uniform_type) in types.iter().enumerate() {
            if result_types[i] != uniform_type as GLuint {
                log::info!(
                    "Wrong uniform type for index({i})\nexpected uniform type: {}\nresult   uniform type: {}\n",
                    Self::uniform_type_name(base, result_types[i]),
                    Self::uniform_type_name(base, uniform_type as GLenum)
                );
                test_result = false;
            }
        }

        let param_val: GLenum = glw::GL_TYPE;
        for i in 0..n_active_uniforms as usize {
            let mut uniform_type: GLint = -1;

            // SAFETY: one property in, one GLint out.
            unsafe {
                gl.get_program_resourceiv(
                    objects.po_id,
                    glw::GL_UNIFORM,
                    i as GLuint,
                    1,
                    &param_val,
                    1,
                    std::ptr::null_mut(),
                    &mut uniform_type,
                )
            };
            glu::expect_no_error(gl, "Error getting information about one of program resources!")?;

            if result_types[i] != uniform_type as GLuint {
                log::info!(
                    "Wrong uniform type for index({i})\nexpected uniform type: {}\nresult   uniform type: {}\n",
                    Self::uniform_type_name(base, result_types[i]),
                    Self::uniform_type_name(base, uniform_type as GLenum)
                );
                test_result = false;
            }
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for ActiveUniformValidation {
    fn name(&self) -> &str {
        match self.variant {
            Variant::VertexFragment => "texture_buffer_active_uniform_validation_fragment_shader",
            Variant::Compute => "texture_buffer_active_uniform_validation_compute_shader",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = self.run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}
