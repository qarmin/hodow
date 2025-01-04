// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferOperations.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six subclasses are one struct with a `Variant`; the per-variant members live in one `Objects` and
// are released by one `deinit`, which is what the chain of overridden `deinit`s amounts to. Desktop contexts only, so the ES-only `disableVertexAttribArray` calls are left out.

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLboolean, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TextureBufferOperations::m_n_vector_components`
const N_VECTOR_COMPONENTS: usize = 4;

const FULL_SCREEN_QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "layout(rgba32i, binding = 0) uniform readonly highp iimageBuffer image_buffer;\n",
    "\n",
    "buffer ComputeSSBO\n",
    "{\n",
    "    ivec4 value[];\n",
    "} computeSSBO;\n",
    "\n",
    "layout (local_size_x = @N@ ) in;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    int index = int(gl_LocalInvocationID.x);\n",
    "    computeSSBO.value[index] = imageLoad( image_buffer, index);\n",
    "}\n",
);

const FRAGMENT_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "in float fs_index;\n",
    "\n",
    "layout(location = 0) out ivec4 color;\n",
    "\n",
    "uniform highp isamplerBuffer sampler_buffer;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    color = texelFetch( sampler_buffer, int(fs_index) );\n ",
    "}\n",
);

const VERTEX_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "in vec4 vs_position;\n",
    "in float  vs_index;\n",
    "\n",
    "out float fs_index;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    gl_Position = vs_position;\n",
    "    fs_index    = vs_index;\n",
    "}\n",
);

const FB_FRAGMENT_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "out ivec4 color;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    color = ivec4(0, 1, 0, 1);\n",
    "}\n",
);

const FB_VERTEX_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "in vec4 inPosition;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    gl_Position = inPosition;\n",
    "}\n",
);

const TF_FRAGMENT_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "in flat ivec4 outPosition;\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "}\n",
);

const TF_VERTEX_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "in ivec4 inPosition;\n",
    "\n",
    "flat out ivec4 outPosition;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    gl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n",
    "    outPosition = inPosition;\n",
    "}\n",
);

const IS_COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "layout(rgba32i, binding = 0) uniform writeonly highp iimageBuffer image_buffer;\n",
    "\n",
    "layout (local_size_x = @N@ ) in;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    imageStore(image_buffer, int(gl_LocalInvocationID.x), ivec4(gl_LocalInvocationID.x) );\n",
    "}\n",
);

const SSBO_COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "buffer ComputeSSBO\n",
    "{\n",
    "    ivec4 value[];\n",
    "} computeSSBO;\n",
    "\n",
    "layout (local_size_x = @N@ ) in;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    computeSSBO.value[gl_LocalInvocationID.x] = ivec4(gl_LocalInvocationID.x);\n",
    "}\n",
);

/// Which of the six subclasses a case is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Variant {
    BufferObjectLoad,
    CpuWrites,
    FramebufferReadBack,
    TransformFeedback,
    ImageStore,
    SsboWrites,
}

/// `TextureBufferOperations` and its subclasses
pub(super) struct Operations {
    pub(super) ext_params: ExtParameters,
    pub(super) variant: Variant,
}

/// Every member of the base class and of all subclasses.
struct Objects {
    n_vectors_in_buffer_texture: GLint,
    tb_bo_id: GLuint,
    texbuff_id: GLuint,
    cs_id: GLuint,
    po_cs_id: GLuint,
    ssbo_bo_id: GLuint,
    fbo_id: GLuint,
    fs_id: GLuint,
    po_vs_fs_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
    vbo_indicies_id: GLuint,
    vs_id: GLuint,
    vertex_location: GLint,
    index_location: GLint,
    fb_fbo_id: GLuint,
    fb_fs_id: GLuint,
    fb_po_id: GLuint,
    fb_to_id: GLuint,
    fb_vao_id: GLuint,
    fb_vbo_id: GLuint,
    fb_vs_id: GLuint,
    tf_fs_id: GLuint,
    tf_po_id: GLuint,
    tf_vao_id: GLuint,
    tf_vbo_id: GLuint,
    tf_vs_id: GLuint,
    is_cs_id: GLuint,
    is_po_id: GLuint,
    ssbo_cs_id: GLuint,
    ssbo_po_id: GLuint,
    position_location: GLint,
}

impl Objects {
    fn new() -> Self {
        Objects {
            n_vectors_in_buffer_texture: 0,
            tb_bo_id: 0,
            texbuff_id: 0,
            cs_id: 0,
            po_cs_id: 0,
            ssbo_bo_id: 0,
            fbo_id: 0,
            fs_id: 0,
            po_vs_fs_id: 0,
            to_id: 0,
            vao_id: 0,
            vbo_id: 0,
            vbo_indicies_id: 0,
            vs_id: 0,
            vertex_location: -1,
            index_location: -1,
            fb_fbo_id: 0,
            fb_fs_id: 0,
            fb_po_id: 0,
            fb_to_id: 0,
            fb_vao_id: 0,
            fb_vbo_id: 0,
            fb_vs_id: 0,
            tf_fs_id: 0,
            tf_po_id: 0,
            tf_vao_id: 0,
            tf_vbo_id: 0,
            tf_vs_id: 0,
            is_cs_id: 0,
            is_po_id: 0,
            ssbo_cs_id: 0,
            ssbo_po_id: 0,
            position_location: -1,
        }
    }

    fn n_entries(&self) -> usize {
        self.n_vectors_in_buffer_texture as usize * N_VECTOR_COMPONENTS
    }

    fn n_bytes(&self) -> GLsizeiptr {
        (self.n_entries() * size_of::<GLint>()) as GLsizeiptr
    }
}

fn create_program(gl: &glw::Functions, message: &str) -> Result<GLuint, TestError> {
    // SAFETY: object creation on the current context.
    let id = unsafe { gl.create_program() };
    glu::expect_no_error(gl, message)?;
    Ok(id)
}

fn create_shader(gl: &glw::Functions, shader_type: glw::GLenum, message: &str) -> Result<GLuint, TestError> {
    // SAFETY: object creation on the current context.
    let id = unsafe { gl.create_shader(shader_type) };
    glu::expect_no_error(gl, message)?;
    Ok(id)
}

fn delete_program(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a program this case created.
        unsafe { gl.delete_program(*id) };
        *id = 0;
    }
}

fn delete_shader(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a shader this case created.
        unsafe { gl.delete_shader(*id) };
        *id = 0;
    }
}

fn delete_buffer(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a buffer this case created.
        unsafe { gl.delete_buffers(1, id) };
        *id = 0;
    }
}

fn delete_texture(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a texture this case created.
        unsafe { gl.delete_textures(1, id) };
        *id = 0;
    }
}

fn delete_framebuffer(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a framebuffer this case created.
        unsafe { gl.delete_framebuffers(1, id) };
        *id = 0;
    }
}

fn delete_vertex_array(gl: &glw::Functions, id: &mut GLuint) {
    if *id != 0 {
        // SAFETY: a vertex array this case created.
        unsafe { gl.delete_vertex_arrays(1, id) };
        *id = 0;
    }
}

fn attrib_location(gl: &glw::Functions, program: GLuint, name: &std::ffi::CStr) -> Result<GLuint, TestError> {
    // SAFETY: a NUL-terminated name on a linked program.
    let location = unsafe { gl.get_attrib_location(program, name.as_ptr()) };
    glu::expect_no_error(gl, "Could not get attribute location!")?;
    if location == -1 {
        return Err(TestError::Fail("Could not get uniform location".to_string()));
    }
    Ok(location as GLuint)
}

impl Operations {
    /// `fillBufferWithData`, per variant
    fn fill_buffer_with_data(&self, buffer: &mut [GLint]) {
        for (i, value) in buffer.iter_mut().enumerate() {
            *value = match self.variant {
                Variant::FramebufferReadBack => (i % 2) as GLint,
                Variant::ImageStore | Variant::SsboWrites => (i / N_VECTOR_COMPONENTS) as GLint,
                _ => i as GLint,
            };
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, o: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        gl_call!(
            gl,
            "Error getting GL_MAX_COMPUTE_WORK_GROUP_SIZE parameter value!",
            gl.get_integeri_v(
                glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE,
                0,
                &mut o.n_vectors_in_buffer_texture
            )
        );

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut o.tb_bo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object !",
            gl.bind_buffer(tokens.texture_buffer, o.tb_bo_id)
        );
        gl_call!(
            gl,
            "Error allocating data store for buffer object!",
            gl.buffer_data(
                tokens.texture_buffer,
                o.n_bytes(),
                std::ptr::null(),
                glw::GL_DYNAMIC_DRAW
            )
        );

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut o.texbuff_id)
        );
        gl_call!(
            gl,
            "Error setting active texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(tokens.texture_buffer, o.texbuff_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object to texture buffer!",
            gl.tex_buffer(tokens.texture_buffer, glw::GL_RGBA32I, o.tb_bo_id)
        );

        self.initialize_buffer_object_data(context, base, o)?;
        self.init_first_phase(context, base, o)?;
        self.init_second_phase(context, base, o)?;
        Ok(())
    }

    fn init_first_phase(&self, context: &Context, base: &TestCaseBase, o: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();

        o.po_cs_id = create_program(gl, "Error creating program object!")?;
        o.cs_id = create_shader(gl, glw::GL_COMPUTE_SHADER, "Error creating shader object!")?;

        let cs_source = COMPUTE_SHADER_CODE.replace("@N@", &o.n_vectors_in_buffer_texture.to_string());
        let parts = [cs_source.as_str()];
        if !base
            .build_program(context, o.po_cs_id, &[ShaderBody::Source(o.cs_id, &parts)])?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program from valid compute shader code!".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut o.ssbo_bo_id)
        );
        gl_call!(
            gl,
            "Error binding  buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.ssbo_bo_id)
        );
        gl_call!(
            gl,
            "Error allocating data store for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                o.n_bytes(),
                std::ptr::null(),
                glw::GL_DYNAMIC_DRAW
            )
        );
        gl_call!(
            gl,
            "Error binding  buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0)
        );
        Ok(())
    }

    fn init_second_phase(&self, context: &Context, base: &TestCaseBase, o: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "Error generating vertex array object!",
            gl.gen_vertex_arrays(1, &mut o.vao_id)
        );
        gl_call!(
            gl,
            "Error genertaing framebuffer object!",
            gl.gen_framebuffers(1, &mut o.fbo_id)
        );

        gl_call!(gl, "Error genertaing texture buffer!", gl.gen_textures(1, &mut o.to_id));
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, o.to_id)
        );
        gl_call!(
            gl,
            "Error allocating texture object's texel data!",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32I, o.n_vectors_in_buffer_texture, 1)
        );
        gl_call!(
            gl,
            "Error setting value for GL_TEXTURE_MAG_FILTER parameter!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "Error setting value for GL_TEXTURE_MIN_FILTER parameter!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, 0)
        );

        o.po_vs_fs_id = create_program(gl, "Error creating program object!")?;
        o.fs_id = create_shader(gl, glw::GL_FRAGMENT_SHADER, "Error creating fragment shader object!")?;
        o.vs_id = create_shader(gl, glw::GL_VERTEX_SHADER, "Error creating vertex shader object!")?;

        let fs_parts = [FRAGMENT_SHADER_CODE];
        let vs_parts = [VERTEX_SHADER_CODE];
        if !base
            .build_program(
                context,
                o.po_vs_fs_id,
                &[
                    ShaderBody::Source(o.fs_id, &fs_parts),
                    ShaderBody::Source(o.vs_id, &vs_parts),
                ],
            )?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/fragment shader source!".to_string(),
            ));
        }

        gl_call!(gl, "Error generating buffer object!", gl.gen_buffers(1, &mut o.vbo_id));
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo_id)
        );
        gl_call!(
            gl,
            "Error setting data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&FULL_SCREEN_QUAD) as GLsizeiptr,
                FULL_SCREEN_QUAD.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        let n = o.n_vectors_in_buffer_texture as f32;
        let indicies: [f32; 4] = [0.0, 0.0, n, n];
        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut o.vbo_indicies_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo_indicies_id)
        );
        gl_call!(
            gl,
            "Error seting data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&indicies) as GLsizeiptr,
                indicies.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0)
        );
        Ok(())
    }

    /// `initializeBufferObjectData`, per variant
    fn initialize_buffer_object_data(
        &self,
        context: &Context,
        base: &TestCaseBase,
        o: &mut Objects,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        let mut data = vec![0 as GLint; o.n_entries()];
        self.fill_buffer_with_data(&mut data);

        match self.variant {
            Variant::BufferObjectLoad => {
                gl_call!(
                    gl,
                    "Error setting buffer object data!",
                    gl.buffer_sub_data(tokens.texture_buffer, 0, o.n_bytes(), data.as_ptr().cast())
                );
            }
            Variant::CpuWrites => {
                // SAFETY: a write mapping of the whole store allocated in init_test.
                let mapped =
                    unsafe { gl.map_buffer_range(tokens.texture_buffer, 0, o.n_bytes(), glw::GL_MAP_WRITE_BIT) };
                glu::expect_no_error(
                    gl,
                    "Error mapping buffer object's data store to client's address space!",
                )?;
                if mapped.is_null() {
                    return Err(TestError::Fail(
                        "Error mapping buffer object's data store to client's address space!".to_string(),
                    ));
                }
                // SAFETY: the mapping holds `data.len()` GLints until it is unmapped below.
                unsafe { std::slice::from_raw_parts_mut(mapped.cast::<GLint>(), data.len()) }.copy_from_slice(&data);
                gl_call!(
                    gl,
                    "Error ummapping buffer object's data store from client's address space!",
                    gl.unmap_buffer(tokens.texture_buffer)
                );
            }
            Variant::FramebufferReadBack => self.initialize_framebuffer_read_back(context, base, o)?,
            Variant::TransformFeedback => self.initialize_transform_feedback(context, base, o, &data)?,
            Variant::ImageStore => {
                o.is_po_id = create_program(gl, "Error creating program object!")?;
                o.is_cs_id = create_shader(gl, glw::GL_COMPUTE_SHADER, "Error creating compute shader object!")?;

                let source = IS_COMPUTE_SHADER_CODE.replace("@N@", &o.n_vectors_in_buffer_texture.to_string());
                let parts = [source.as_str()];
                if !base
                    .build_program(context, o.is_po_id, &[ShaderBody::Source(o.is_cs_id, &parts)])?
                    .0
                {
                    return Err(TestError::Fail(
                        "Could not create a program from valid compute shader source!".to_string(),
                    ));
                }

                gl_call!(gl, "Error setting active program object!", gl.use_program(o.is_po_id));
                gl_call!(
                    gl,
                    "Error binding texture object to image unit!",
                    gl.bind_image_texture(
                        0,
                        o.texbuff_id,
                        0,
                        glw::GL_FALSE as GLboolean,
                        0,
                        glw::GL_WRITE_ONLY,
                        glw::GL_RGBA32I
                    )
                );
                gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
                gl_call!(
                    gl,
                    "Error setting memory barrier!",
                    gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT)
                );
                // SAFETY: state reset.
                unsafe { gl.use_program(0) };
            }
            Variant::SsboWrites => {
                o.ssbo_po_id = create_program(gl, "Error creating program object!")?;
                o.ssbo_cs_id = create_shader(gl, glw::GL_COMPUTE_SHADER, "Error creating compute shader object!")?;

                let source = SSBO_COMPUTE_SHADER_CODE.replace("@N@", &o.n_vectors_in_buffer_texture.to_string());
                let parts = [source.as_str()];
                if !base
                    .build_program(context, o.ssbo_po_id, &[ShaderBody::Source(o.ssbo_cs_id, &parts)])?
                    .0
                {
                    return Err(TestError::Fail(
                        "Could not create a program from valid compute shader source!".to_string(),
                    ));
                }

                gl_call!(
                    gl,
                    "Could not bind buffer object to shader storage binding point!",
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, o.tb_bo_id)
                );
                gl_call!(gl, "Error setting active program object!", gl.use_program(o.ssbo_po_id));
                gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
                gl_call!(
                    gl,
                    "Error setting memory barrier!",
                    gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT)
                );
                // SAFETY: state resets.
                unsafe {
                    gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
                    gl.use_program(0);
                }
            }
        }
        Ok(())
    }

    /// `TextureBufferOperationsViaFrambufferReadBack::initializeBufferObjectData`
    fn initialize_framebuffer_read_back(
        &self,
        context: &Context,
        base: &TestCaseBase,
        o: &mut Objects,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        gl_call!(
            gl,
            "Error generating vertex array object!",
            gl.gen_vertex_arrays(1, &mut o.fb_vao_id)
        );
        gl_call!(
            gl,
            "Error binding vertex array object!",
            gl.bind_vertex_array(o.fb_vao_id)
        );

        gl_call!(
            gl,
            "Error genertaing framebuffer object!",
            gl.gen_framebuffers(1, &mut o.fb_fbo_id)
        );
        gl_call!(
            gl,
            "Error binding framebuffer object!",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, o.fb_fbo_id)
        );

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut o.fb_to_id)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, o.fb_to_id)
        );
        gl_call!(
            gl,
            "Error allocating texture object's data store!",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32I, o.n_vectors_in_buffer_texture, 1)
        );

        gl_call!(
            gl,
            "Error attaching texture to framebuffer's color attachment!",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                o.fb_to_id,
                0
            )
        );
        TestCaseBase::check_framebuffer_status(context, glw::GL_DRAW_FRAMEBUFFER)?;

        gl_call!(
            gl,
            "Error setting viewport!",
            gl.viewport(0, 0, o.n_vectors_in_buffer_texture, 1)
        );

        o.fb_po_id = create_program(gl, "Error creating program object!")?;
        o.fb_fs_id = create_shader(gl, glw::GL_FRAGMENT_SHADER, "Error creating fragment shader object!")?;
        o.fb_vs_id = create_shader(gl, glw::GL_VERTEX_SHADER, "Error creating vertex shader object!")?;

        let fs_parts = [FB_FRAGMENT_SHADER_CODE];
        let vs_parts = [FB_VERTEX_SHADER_CODE];
        if !base
            .build_program(
                context,
                o.fb_po_id,
                &[
                    ShaderBody::Source(o.fb_fs_id, &fs_parts),
                    ShaderBody::Source(o.fb_vs_id, &vs_parts),
                ],
            )?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/fragment shader code!".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut o.fb_vbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.fb_vbo_id)
        );
        gl_call!(
            gl,
            "Error setting data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&FULL_SCREEN_QUAD) as GLsizeiptr,
                FULL_SCREEN_QUAD.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(gl, "Error setting active program object!", gl.use_program(o.fb_po_id));

        let position_location = attrib_location(gl, o.fb_po_id, c"inPosition")?;
        o.position_location = position_location as GLint;
        gl_call!(
            gl,
            "Could not set vertex attribute pointer!",
            gl.vertex_attrib_pointer(
                position_location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(position_location)
        );

        gl_call!(gl, "Error clearing color buffer", {
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT)
        });
        gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        gl_call!(
            gl,
            "Error binding frame buffer object!",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, o.fb_fbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object !",
            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, o.tb_bo_id)
        );
        gl_call!(
            gl,
            "Error setting GL_UNPACK_ALIGNMENT parameter to 1",
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1)
        );
        gl_call!(
            gl,
            "Error setting GL_PACK_ALIGNMENT parameter to 1",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1)
        );

        gl_call!(
            gl,
            "Error reading pixels !",
            gl.read_pixels(
                0,
                0,
                o.n_vectors_in_buffer_texture,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                std::ptr::null_mut()
            )
        );

        gl_call!(
            gl,
            "Error setting GL_UNPACK_ALIGNMENT parameter to default value",
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4)
        );
        gl_call!(
            gl,
            "Error setting GL_PACK_ALIGNMENT parameter to default value",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(tokens.texture_buffer, o.tb_bo_id)
        );

        // SAFETY: state resets.
        unsafe {
            gl.bind_vertex_array(0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.use_program(0);
        }
        o.position_location = -1;
        Ok(())
    }

    /// `TextureBufferOperationsViaTransformFeedback::initializeBufferObjectData`
    fn initialize_transform_feedback(
        &self,
        context: &Context,
        base: &TestCaseBase,
        o: &mut Objects,
        data: &[GLint],
    ) -> Result<(), TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "Error generating vertex array object!",
            gl.gen_vertex_arrays(1, &mut o.tf_vao_id)
        );
        gl_call!(
            gl,
            "Error binding vertex array object!",
            gl.bind_vertex_array(o.tf_vao_id)
        );

        gl_call!(
            gl,
            "Error generating vertex buffer object!",
            gl.gen_buffers(1, &mut o.tf_vbo_id)
        );
        gl_call!(
            gl,
            "Error binding vertex buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.tf_vbo_id)
        );
        gl_call!(
            gl,
            "Error allocating buffer object's data store!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                o.n_bytes(),
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            )
        );

        o.tf_po_id = create_program(gl, "Error creating program object!")?;

        let varyings = [c"outPosition".as_ptr()];
        gl_call!(
            gl,
            "Error specifying transform feedback varyings!",
            gl.transform_feedback_varyings(o.tf_po_id, 1, varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS)
        );

        o.tf_fs_id = create_shader(gl, glw::GL_FRAGMENT_SHADER, "Error creating fragment shader object!")?;
        o.tf_vs_id = create_shader(gl, glw::GL_VERTEX_SHADER, "Error creating vertex shader object!")?;

        let fs_parts = [TF_FRAGMENT_SHADER_CODE];
        let vs_parts = [TF_VERTEX_SHADER_CODE];
        if !base
            .build_program(
                context,
                o.tf_po_id,
                &[
                    ShaderBody::Source(o.tf_fs_id, &fs_parts),
                    ShaderBody::Source(o.tf_vs_id, &vs_parts),
                ],
            )?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/fragment shader code!".to_string(),
            ));
        }

        gl_call!(gl, "Error setting active program object!", gl.use_program(o.tf_po_id));

        // SAFETY: a NUL-terminated name on the linked program.
        o.position_location = unsafe { gl.get_attrib_location(o.tf_po_id, c"inPosition".as_ptr()) };
        glu::expect_no_error(gl, "Error getting attrib location!")?;

        gl_call!(
            gl,
            "Error setting vertex attrib pointer!",
            gl.vertex_attrib_i_pointer(
                o.position_location as GLuint,
                N_VECTOR_COMPONENTS as GLint,
                glw::GL_INT,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Error enabling vertex attrib array!",
            gl.enable_vertex_attrib_array(o.position_location as GLuint)
        );

        gl_call!(
            gl,
            "Error binding buffer object to transform feedback binding point!",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, o.tb_bo_id)
        );
        gl_call!(
            gl,
            "Error starting transform feedback!",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );
        gl_call!(
            gl,
            "Error during rendering!",
            gl.draw_arrays(glw::GL_POINTS, 0, o.n_vectors_in_buffer_texture)
        );
        gl_call!(gl, "Error ending transform feedback!", gl.end_transform_feedback());

        // SAFETY: state resets.
        unsafe {
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_vertex_array(0);
            gl.use_program(0);
            gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
        }
        o.position_location = -1;
        Ok(())
    }

    /// `iterateFirstPhase`
    fn iterate_first_phase(&self, context: &Context, o: &Objects, result: &mut [GLint]) -> Result<(), TestError> {
        let gl = context.gl();
        let size = o.n_bytes();

        gl_call!(
            gl,
            "Error binding  buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.ssbo_bo_id)
        );
        gl_call!(
            gl,
            "Could not bind buffer object to shader storage binding point!",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, o.ssbo_bo_id)
        );
        gl_call!(gl, "Error setting active program!", gl.use_program(o.po_cs_id));
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT)
        );
        gl_call!(
            gl,
            "Error binding texture to image unit!",
            gl.bind_image_texture(
                0,
                o.texbuff_id,
                0,
                glw::GL_FALSE as GLboolean,
                0,
                glw::GL_READ_ONLY,
                glw::GL_RGBA32I
            )
        );
        gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
        );

        // SAFETY: a read mapping of the whole store the compute shader wrote.
        let mapped = unsafe { gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, size, glw::GL_MAP_READ_BIT) };
        glu::expect_no_error(
            gl,
            "Error mapping buffer object's data store to client's address space!",
        )?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object's data store to client's address space!".to_string(),
            ));
        }
        // SAFETY: the mapping holds `result.len()` GLints until it is unmapped below.
        result.copy_from_slice(unsafe { std::slice::from_raw_parts(mapped.cast::<GLint>(), result.len()) });
        gl_call!(
            gl,
            "Error unmapping buffer object's data store from client's address space!",
            gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER)
        );

        // SAFETY: state resets.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);
            gl.use_program(0);
        }
        Ok(())
    }

    /// `iterateSecondPhase`
    fn iterate_second_phase(&self, context: &Context, o: &mut Objects, result: &mut [GLint]) -> Result<(), TestError> {
        let gl = context.gl();

        gl_call!(gl, "Error binding vertex array object!", gl.bind_vertex_array(o.vao_id));
        gl_call!(
            gl,
            "Error binding framebuffer object!",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, o.fbo_id)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, o.to_id)
        );
        gl_call!(
            gl,
            "Error attaching texture to framebuffer's color attachment",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                o.to_id,
                0
            )
        );
        TestCaseBase::check_framebuffer_status(context, glw::GL_DRAW_FRAMEBUFFER)?;

        gl_call!(
            gl,
            "Error setting viewport!",
            gl.viewport(0, 0, o.n_vectors_in_buffer_texture, 1)
        );
        gl_call!(gl, "Error using program object!", gl.use_program(o.po_vs_fs_id));

        // SAFETY: a NUL-terminated name on the program in use.
        let sampler_location = unsafe { gl.get_uniform_location(o.po_vs_fs_id, c"sampler_buffer".as_ptr()) };
        glu::expect_no_error(gl, "Could not get attribute location!")?;
        if sampler_location == -1 {
            return Err(TestError::Fail("Could not get uniform location".to_string()));
        }
        gl_call!(
            gl,
            "Error binding sampler with texture unit!",
            gl.uniform_1i(sampler_location, 0)
        );

        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo_id)
        );
        let vertex_location = attrib_location(gl, o.po_vs_fs_id, c"vs_position")?;
        o.vertex_location = vertex_location as GLint;
        gl_call!(
            gl,
            "Could not set vertex attribute pointer!",
            gl.vertex_attrib_pointer(
                vertex_location,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(vertex_location)
        );

        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo_indicies_id)
        );
        let index_location = attrib_location(gl, o.po_vs_fs_id, c"vs_index")?;
        o.index_location = index_location as GLint;
        gl_call!(
            gl,
            "Could not set vertex attribute pointer!",
            gl.vertex_attrib_pointer(
                index_location,
                1,
                glw::GL_FLOAT,
                glw::GL_FALSE as GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(index_location)
        );

        gl_call!(gl, "Error clearing color buffer", {
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT)
        });
        gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        gl_call!(
            gl,
            "Error binding framebuffer object !",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, o.fbo_id)
        );
        gl_call!(
            gl,
            "Error reading pixels !",
            gl.read_pixels(
                0,
                0,
                o.n_vectors_in_buffer_texture,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                result.as_mut_ptr().cast()
            )
        );

        // SAFETY: state resets.
        unsafe {
            gl.bind_vertex_array(0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.disable_vertex_attrib_array(vertex_location);
            gl.disable_vertex_attrib_array(index_location);
            gl.use_program(0);
        }
        o.vertex_location = -1;
        o.index_location = -1;
        Ok(())
    }

    /// `verifyResults`
    fn verify_results(reference: &[GLint], result: &[GLint], message: &str) -> bool {
        if reference != result {
            log::info!(
                "{message}Result buffer contains different data than reference buffer\nReference Buffer: {reference:?}\nResult Buffer: {result:?}\n"
            );
            return false;
        }
        true
    }

    fn run(&self, context: &Context, base: &TestCaseBase, o: &mut Objects) -> TestOutcome {
        self.init_test(context, base, o)?;

        let mut test_result = true;

        let mut reference = vec![0 as GLint; o.n_entries()];
        self.fill_buffer_with_data(&mut reference);

        let mut result = vec![0 as GLint; o.n_entries()];
        self.iterate_first_phase(context, o, &mut result)?;
        if !Self::verify_results(&reference, &result, "1st Phase Compute Shader\n") {
            test_result = false;
        }

        self.iterate_second_phase(context, o, &mut result)?;
        if !Self::verify_results(&reference, &result, "2st Phase Vertex + Fragment Shader\n") {
            test_result = false;
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }

    /// `deinit` of the base class and of every subclass
    fn deinit(context: &Context, base: &TestCaseBase, o: &mut Objects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets of what this case bound.
        unsafe {
            gl.bind_vertex_array(0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.use_program(0);
            for location in [&mut o.position_location, &mut o.vertex_location, &mut o.index_location] {
                if *location != -1 {
                    gl.disable_vertex_attrib_array(*location as GLuint);
                    *location = -1;
                }
            }
            gl.bind_buffer(tokens.texture_buffer, 0);
            gl.bind_texture(tokens.texture_buffer, 0);
        }

        delete_program(gl, &mut o.fb_po_id);
        delete_shader(gl, &mut o.fb_fs_id);
        delete_shader(gl, &mut o.fb_vs_id);
        delete_framebuffer(gl, &mut o.fb_fbo_id);
        delete_texture(gl, &mut o.fb_to_id);
        delete_buffer(gl, &mut o.fb_vbo_id);
        delete_vertex_array(gl, &mut o.fb_vao_id);

        delete_program(gl, &mut o.tf_po_id);
        delete_shader(gl, &mut o.tf_vs_id);
        delete_shader(gl, &mut o.tf_fs_id);
        delete_buffer(gl, &mut o.tf_vbo_id);
        delete_vertex_array(gl, &mut o.tf_vao_id);

        delete_program(gl, &mut o.is_po_id);
        delete_shader(gl, &mut o.is_cs_id);

        delete_program(gl, &mut o.ssbo_po_id);
        delete_shader(gl, &mut o.ssbo_cs_id);

        delete_texture(gl, &mut o.texbuff_id);
        delete_buffer(gl, &mut o.tb_bo_id);

        delete_program(gl, &mut o.po_cs_id);
        delete_shader(gl, &mut o.cs_id);
        delete_buffer(gl, &mut o.ssbo_bo_id);

        delete_program(gl, &mut o.po_vs_fs_id);
        delete_shader(gl, &mut o.fs_id);
        delete_shader(gl, &mut o.vs_id);
        delete_framebuffer(gl, &mut o.fbo_id);
        delete_texture(gl, &mut o.to_id);
        delete_vertex_array(gl, &mut o.vao_id);
        delete_buffer(gl, &mut o.vbo_id);
        delete_buffer(gl, &mut o.vbo_indicies_id);
    }
}

impl TestCase for Operations {
    fn name(&self) -> &str {
        match self.variant {
            Variant::BufferObjectLoad => "texture_buffer_operations_buffer_load",
            Variant::CpuWrites => "texture_buffer_operations_cpu_writes",
            Variant::FramebufferReadBack => "texture_buffer_operations_framebuffer_readback",
            Variant::TransformFeedback => "texture_buffer_operations_transform_feedback",
            Variant::ImageStore => "texture_buffer_operations_image_store",
            Variant::SsboWrites => "texture_buffer_operations_ssbo_writes",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::new();

        let outcome = self.run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}
