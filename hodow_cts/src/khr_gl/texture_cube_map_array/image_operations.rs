// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayImageOperations.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayImageOperations.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only: mutable storage is always exercised (upstream skips it on ES). The three element types share one `Texel` trait in place of upstream's templates.

use super::{StorageType, TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{EPSILON_FLOAT, ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED`
const GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Geometry shader functionality not supported, skipping";
/// `TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED`
const TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Tessellation shader functionality not supported, skipping";

const F_BASE: f32 = 1.5;
const I_BASE: i32 = -1;
const UI_BASE: u32 = 1;

const N_COMPONENTS: u32 = 4;
const N_IMAGE_FORMATS: GLuint = 3;

const IF_IMAGE: GLuint = 0;
const IF_IIMAGE: GLuint = 1;
const IF_UIMAGE: GLuint = 2;

/// `m_resolutions`: width, height, depth
const RESOLUTIONS: [[GLuint; 3]; 4] = [[16, 16, 12], [32, 32, 6], [4, 4, 18], [8, 8, 6]];

/// `SHADER_TO_CHECK`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum ShaderToCheck {
    Compute,
    Fragment,
    Geometry,
    TessellationControl,
    TessellationEvaluation,
    Vertex,
}

const IMAGE_DECLARATIONS: &str = "layout (rgba32f,  binding = 0) highp uniform readonly imageCubeArray  imageRead;\nlayout (rgba32i,  binding = 1) highp uniform readonly iimageCubeArray iimageRead;\nlayout (rgba32ui, binding = 2) highp uniform readonly uimageCubeArray uimageRead;\nlayout (rgba32f,  binding = 3) highp uniform writeonly imageCubeArray  imageWrite;\nlayout (rgba32i,  binding = 4) highp uniform writeonly iimageCubeArray iimageWrite;\nlayout (rgba32ui, binding = 5) highp uniform writeonly uimageCubeArray uimageWrite;\n";

const COPY_LOOP: &str = "    for(int w = 0; w < dimensions[0]; ++w)\n    {\n        for(int h = 0; h < dimensions[1]; ++h)\n        {\n            for(int d = 0; d < dimensions[2]; ++d)\n            {\n                ivec3  position  = ivec3(w,h,d);\n                imageStore(imageWrite,  position, imageLoad(imageRead,  position));\n                imageStore(iimageWrite, position, imageLoad(iimageRead, position));\n                imageStore(uimageWrite, position, imageLoad(uimageRead, position));\n            }\n        }\n    }\n";

const COMPUTE_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nlayout (rgba32f,  binding = 0) highp uniform readonly imageCubeArray  imageRead;\nlayout (rgba32i,  binding = 1) highp uniform readonly iimageCubeArray iimageRead;\nlayout (rgba32ui, binding = 2) highp uniform readonly uimageCubeArray uimageRead;\nlayout (rgba32f,  binding = 3) highp uniform writeonly imageCubeArray  imageWrite;\nlayout (rgba32i,  binding = 4) highp uniform writeonly iimageCubeArray iimageWrite;\nlayout (rgba32ui, binding = 5) highp uniform writeonly uimageCubeArray uimageWrite;\n\nvoid main(void)\n{\n    ivec3 position = ivec3(gl_GlobalInvocationID.xyz);\n    imageStore(imageWrite,  position, imageLoad(imageRead,  position));\n    imageStore(iimageWrite, position, imageLoad(iimageRead, position));\n    imageStore(uimageWrite, position, imageLoad(uimageRead, position));\n}\n";

const VERTEX_SHADER_BOILERPLATE_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position = vec4(0, 0, 0, 1.0f);\n    gl_PointSize = 1.0f;\n}\n";

const FRAGMENT_SHADER_BOILERPLATE_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";

const TESS_CONTROL_SHADER_BOILERPLATE_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_ENABLE}\n\nprecision highp float;\n\nlayout (vertices = 1) out;\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n}\n";

const TESS_EVALUATION_SHADER_BOILERPLATE_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_ENABLE}\n\nprecision highp float;\n\nlayout(isolines, point_mode) in;\nvoid main()\n{\n}\n";

const FLOATING_POINT_COPY_SHADER_CODE: &str = "${VERSION}\n\nlayout (local_size_x=1) in;\n\nlayout(binding=0, rgba32f) uniform highp readonly image2D src;\nlayout(binding=1, rgba32ui) uniform highp writeonly uimage2D dst;\n\nvoid main()\n{\nivec2 coord = ivec2(gl_WorkGroupID.xy);\nimageStore(dst, coord, floatBitsToUint(imageLoad(src, coord)));\n}\n";

fn vertex_shader_code() -> String {
    format!(
        "${{VERSION}}\n\n${{TEXTURE_CUBE_MAP_ARRAY_REQUIRE}}\n\nprecision highp float;\n\n{IMAGE_DECLARATIONS}\nuniform ivec3 dimensions;\n\nvoid main()\n{{\n\n    gl_PointSize = 1.0f;\n{COPY_LOOP}\n}}\n"
    )
}

/// Upstream's literal lacks the newlines after the three closing braces; the shader means the same.
fn fragment_shader_code() -> String {
    let copy_loop = COPY_LOOP.replace("            }\n        }\n    }\n", "            }        }    }");
    format!(
        "${{VERSION}}\n\n${{TEXTURE_CUBE_MAP_ARRAY_REQUIRE}}\n\nprecision highp float;\n\n{IMAGE_DECLARATIONS}\nuniform ivec3 dimensions;\n\nvoid main()\n{{\n\n{copy_loop}\n}}\n"
    )
}

fn geometry_shader_code() -> String {
    format!(
        "${{VERSION}}\n\n${{GEOMETRY_SHADER_ENABLE}}\n${{TEXTURE_CUBE_MAP_ARRAY_REQUIRE}}\n\nprecision highp float;\n\n{IMAGE_DECLARATIONS}\nuniform ivec3 dimensions;\n\nlayout(points) in;\nlayout(points, max_vertices=1) out;\n\nvoid main()\n{{\n\n{COPY_LOOP}\n}}\n"
    )
}

fn tess_control_shader_code() -> String {
    let copy_loop = COPY_LOOP
        .replace("imageLoad(imageRead,  position)", "imageLoad(imageRead,  position.xyz)")
        .replace("imageLoad(iimageRead, position)", "imageLoad(iimageRead, position.xyz)")
        .replace("imageLoad(uimageRead, position)", "imageLoad(uimageRead, position.xyz)");
    format!(
        "${{VERSION}}\n\n${{TEXTURE_CUBE_MAP_ARRAY_REQUIRE}}\n${{TESSELLATION_SHADER_ENABLE}}\n\nprecision highp float;\n\n{IMAGE_DECLARATIONS}\nuniform ivec3 dimensions;\n\nlayout (vertices = 1) out;\n\nvoid main()\n{{\n\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n\n{copy_loop}\n}}\n"
    )
}

fn tess_evaluation_shader_code() -> String {
    format!(
        "${{VERSION}}\n\n${{TESSELLATION_SHADER_ENABLE}}\n${{TEXTURE_CUBE_MAP_ARRAY_REQUIRE}}\n\nprecision highp float;\n\n{IMAGE_DECLARATIONS}\nuniform ivec3 dimensions;\n\nlayout(isolines, point_mode) in;\nvoid main()\n{{\n\n{COPY_LOOP}\n}}\n"
    )
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// The element types of the three image formats (`areBuffersEqual`, `fillData`'s `base + (T)i`).
trait Texel: Copy + Default {
    fn offset_by(self, layer: GLuint) -> Self;
    fn buffers_equal(a: &[Self], b: &[Self]) -> bool;
}

impl Texel for f32 {
    fn offset_by(self, layer: GLuint) -> Self {
        self + layer as f32
    }

    fn buffers_equal(a: &[Self], b: &[Self]) -> bool {
        a.iter().zip(b).all(|(x, y)| (x - y).abs() <= EPSILON_FLOAT)
    }
}

impl Texel for i32 {
    fn offset_by(self, layer: GLuint) -> Self {
        self.wrapping_add(layer as i32)
    }

    fn buffers_equal(a: &[Self], b: &[Self]) -> bool {
        a == b
    }
}

impl Texel for u32 {
    fn offset_by(self, layer: GLuint) -> Self {
        self.wrapping_add(layer)
    }

    fn buffers_equal(a: &[Self], b: &[Self]) -> bool {
        a == b
    }
}

/// `fillData`: every component of layer `i` holds `base + i`
fn fill_data<T: Texel>(width: GLuint, height: GLuint, depth: GLuint, components: GLuint, base: T) -> Vec<T> {
    let layer_len = (width * height * components) as usize;
    let mut data = Vec::with_capacity(layer_len * depth as usize);
    for layer in 0..depth {
        data.extend(std::iter::repeat_n(base.offset_by(layer), layer_len));
    }
    data
}

/// `TextureCubeMapArrayImageOpCompute` (Test 8)
pub(super) struct ImageOp {
    pub(super) name: &'static str,
    pub(super) ext_params: ExtParameters,
    pub(super) shader_to_check: ShaderToCheck,
}

#[derive(Default)]
struct Objects {
    cs_id: GLuint,
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
    copy_po_id: GLuint,
    copy_cs_id: GLuint,
    iimage_read_to_id: GLuint,
    iimage_write_to_id: GLuint,
    image_read_to_id: GLuint,
    image_write_to_id: GLuint,
    uimage_read_to_id: GLuint,
    uimage_write_to_id: GLuint,
}

struct Runner<'a> {
    context: &'a Context,
    test: &'a ImageOp,
    base: &'a TestCaseBase,
    o: Objects,
}

/// `checkResults`
#[allow(clippy::too_many_arguments)]
fn check_results<T: Texel>(
    context: &Context,
    copy_po_id: GLuint,
    id: GLuint,
    width: GLuint,
    height: GLuint,
    depth: GLuint,
    components: GLuint,
    format: GLenum,
    type_: GLenum,
    stor_type: StorageType,
    expected_data: &[T],
) -> Result<bool, TestError> {
    let gl = context.gl();
    let layer_len = (width * height * components) as usize;
    let mut result_data = vec![T::default(); layer_len];

    let mut old_program: GLint = 0;
    let mut uint_tex_id: GLuint = 0;

    // Floating point textures are not renderable, so their bits are copied to a temporary unsigned integer texture.
    if type_ == glw::GL_FLOAT {
        gl_call!(
            gl,
            "Error generating temporary texture object!",
            gl.gen_textures(1, &mut uint_tex_id)
        );

        gl_call!(
            gl,
            "Error binding temporary texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, uint_tex_id)
        );
        gl_call!(
            gl,
            "Error allocating temporary texture object!",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32UI, width as GLint, height as GLint)
        );

        gl_call!(
            gl,
            "Error setting texture object's filter mode!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "Error setting texture object's filter mode!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );

        gl_call!(
            gl,
            "Error attaching texture to frame buffer",
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                uint_tex_id,
                0
            )
        );

        gl_call!(
            gl,
            "Error binding integer texture for copy destination",
            gl.bind_image_texture(1, uint_tex_id, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA32UI)
        );

        gl_call!(
            gl,
            "Error querying old program!",
            gl.get_integerv(glw::GL_CURRENT_PROGRAM, &mut old_program)
        );
        gl_call!(gl, "Error setting active program object!", gl.use_program(copy_po_id));

        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT)
        );
    } else {
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT)
        );
    }

    let mut result = true;

    for i in 0..depth {
        if type_ == glw::GL_FLOAT {
            gl_call!(
                gl,
                "Error binding floating point texture for copy source",
                gl.bind_image_texture(0, id, 0, glw::FALSE, i as GLint, glw::GL_READ_ONLY, glw::GL_RGBA32F)
            );
            gl_call!(
                gl,
                "Error dispatching float-to-integer compute shader",
                gl.dispatch_compute(width, height, 1)
            );

            gl_call!(
                gl,
                "Error setting memory barrier!",
                gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT)
            );

            gl_call!(
                gl,
                "Error reading pixels from frame buffer!",
                gl.read_pixels(
                    0,
                    0,
                    width as GLint,
                    height as GLint,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    result_data.as_mut_ptr().cast()
                )
            );
        } else {
            gl_call!(
                gl,
                "Error attaching texture to frame buffer",
                gl.framebuffer_texture_layer(glw::GL_READ_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, id, 0, i as GLint)
            );

            gl_call!(
                gl,
                "Error reading pixels from frame buffer!",
                gl.read_pixels(
                    0,
                    0,
                    width as GLint,
                    height as GLint,
                    format,
                    type_,
                    result_data.as_mut_ptr().cast()
                )
            );
        }

        let layer_expected = &expected_data[i as usize * layer_len..(i as usize + 1) * layer_len];
        if !T::buffers_equal(&result_data, layer_expected) {
            let image_type = match type_ {
                glw::GL_FLOAT => "imageCubeArray",
                glw::GL_INT => "iimageCubeArray",
                _ => "uimageCubeArray",
            };
            let storage = if stor_type == StorageType::Mutable {
                "MUTABLE"
            } else {
                "IMMUTABLE"
            };
            log::info!(
                "Wrong value in result texture for {image_type} for resolution[w,h,d] = [{width},{height},{depth}] for layer[{i}] and {storage} storage!"
            );
            result = false;
            break;
        }
    }

    if type_ == glw::GL_FLOAT {
        gl_call!(
            gl,
            "Error setting active program object!",
            gl.use_program(old_program as GLuint)
        );
        gl_call!(
            gl,
            "Error deleting temporary texture!",
            gl.delete_textures(1, &uint_tex_id)
        );
    }

    Ok(result)
}

/// `configureTexture`
#[allow(clippy::too_many_arguments)]
fn configure_texture<T: Texel>(
    context: &Context,
    id: &mut GLuint,
    width: GLuint,
    height: GLuint,
    depth: GLuint,
    stor_type: StorageType,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
    data: &[T],
) -> Result<(), TestError> {
    let gl = context.gl();

    gl_call!(
        gl,
        "Error setting active texture unit!",
        gl.active_texture(glw::GL_TEXTURE0)
    );
    gl_call!(gl, "Error generating texture object!", gl.gen_textures(1, id));
    gl_call!(
        gl,
        "Error binding texture object!",
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, *id)
    );

    gl_call!(
        gl,
        "Error setting texture object's filter mode!",
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as GLint
        )
    );
    gl_call!(
        gl,
        "Error setting texture object's filter mode!",
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as GLint
        )
    );

    if stor_type == StorageType::Mutable {
        gl_call!(
            gl,
            "Error setting texture parameter.",
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_BASE_LEVEL, 0)
        );
        gl_call!(
            gl,
            "Error setting texture parameter.",
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_MAX_LEVEL, 0)
        );

        gl_call!(
            gl,
            "Error allocating texture object's data store",
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                internal_format as GLint,
                width as GLint,
                height as GLint,
                depth as GLint,
                0,
                format,
                type_,
                data.as_ptr().cast()
            )
        );
    } else {
        gl_call!(
            gl,
            "Error allocating texture object's data store",
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                internal_format,
                width as GLint,
                height as GLint,
                depth as GLint
            )
        );
        gl_call!(
            gl,
            "Error filling texture object's data store with data",
            gl.tex_sub_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                0,
                0,
                0,
                width as GLint,
                height as GLint,
                depth as GLint,
                format,
                type_,
                data.as_ptr().cast()
            )
        );
    }
    Ok(())
}

/// `getQueryPname`
fn query_pname(base: &TestCaseBase, stage: ShaderToCheck) -> GLenum {
    match stage {
        ShaderToCheck::Compute => glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS,
        ShaderToCheck::Vertex => glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
        ShaderToCheck::Fragment => glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
        ShaderToCheck::Geometry => base.gl_ext_tokens.max_geometry_image_uniforms,
        ShaderToCheck::TessellationControl => glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
        ShaderToCheck::TessellationEvaluation => glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
    }
}

impl Runner<'_> {
    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let stage = self.test.shader_to_check;

        if !self.base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !self.base.is_geometry_shader_extension_supported && stage == ShaderToCheck::Geometry {
            return Err(TestError::NotSupported(
                GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !self.base.is_tessellation_shader_supported
            && matches!(
                stage,
                ShaderToCheck::TessellationControl | ShaderToCheck::TessellationEvaluation
            )
        {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let mut max_images: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(query_pname(self.base, stage), &mut max_images) };
        if max_images < 6 {
            return Err(TestError::NotSupported(
                "Shader stage does not support at least 6 image uniforms".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Could not generate vertex array object",
            gl.gen_vertex_arrays(1, &mut self.o.vao_id)
        );
        gl_call!(
            gl,
            "Error binding vertex array object!",
            gl.bind_vertex_array(self.o.vao_id)
        );

        gl_call!(
            gl,
            "Error generating frame buffer object!",
            gl.gen_framebuffers(1, &mut self.o.fbo_id)
        );
        gl_call!(
            gl,
            "Error binding frame buffer object!",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.o.fbo_id)
        );

        // SAFETY: object creation on the current context.
        unsafe {
            self.o.copy_po_id = gl.create_program();
            self.o.copy_cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER);
        }
        let copy_parts = [FLOATING_POINT_COPY_SHADER_CODE];
        self.base.build_program(
            self.context,
            self.o.copy_po_id,
            &[ShaderBody::Source(self.o.copy_cs_id, &copy_parts)],
        )?;

        // SAFETY: as above.
        self.o.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "Error creating program object!")?;

        self.configure_program()
    }

    /// `configureProgram`
    fn configure_program(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let ext = &self.base.gl_ext_tokens;

        let fail_shader = "Could not create shader object!";
        let fail_program = "Could not create shader program.";

        match self.test.shader_to_check {
            ShaderToCheck::Compute => {
                // SAFETY: object creation on the current context.
                self.o.cs_id = unsafe { gl.create_shader(glw::GL_COMPUTE_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;

                let parts = [COMPUTE_SHADER_CODE];
                if !self
                    .base
                    .build_program(self.context, self.o.po_id, &[ShaderBody::Source(self.o.cs_id, &parts)])?
                    .0
                {
                    return Err(TestError::Fail(
                        "Could not create a program from valid compute shader code!".to_string(),
                    ));
                }
            }
            ShaderToCheck::Vertex | ShaderToCheck::Fragment => {
                // SAFETY: object creation on the current context.
                self.o.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.fs_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;

                let vs = self.test.shader_to_check == ShaderToCheck::Vertex;
                let vs_code = if vs {
                    vertex_shader_code()
                } else {
                    VERTEX_SHADER_BOILERPLATE_CODE.to_string()
                };
                let fs_code = if vs {
                    FRAGMENT_SHADER_BOILERPLATE_CODE.to_string()
                } else {
                    fragment_shader_code()
                };
                let (vs_parts, fs_parts) = ([vs_code.as_str()], [fs_code.as_str()]);

                if !self
                    .base
                    .build_program(
                        self.context,
                        self.o.po_id,
                        &[
                            ShaderBody::Source(self.o.fs_id, &fs_parts),
                            ShaderBody::Source(self.o.vs_id, &vs_parts),
                        ],
                    )?
                    .0
                {
                    return Err(TestError::Fail(fail_program.to_string()));
                }
            }
            ShaderToCheck::Geometry => {
                // SAFETY: object creation on the current context.
                self.o.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.gs_id = unsafe { gl.create_shader(ext.geometry_shader) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.fs_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;

                let gs_code = geometry_shader_code();
                let (vs_parts, gs_parts, fs_parts) = (
                    [VERTEX_SHADER_BOILERPLATE_CODE],
                    [gs_code.as_str()],
                    [FRAGMENT_SHADER_BOILERPLATE_CODE],
                );

                let stages = [
                    ShaderBody::Source(self.o.fs_id, &fs_parts),
                    ShaderBody::Source(self.o.gs_id, &gs_parts),
                    ShaderBody::Source(self.o.vs_id, &vs_parts),
                ];
                if !self.base.build_program(self.context, self.o.po_id, &stages)?.0 {
                    return Err(TestError::Fail(fail_program.to_string()));
                }
            }
            ShaderToCheck::TessellationControl | ShaderToCheck::TessellationEvaluation => {
                // SAFETY: object creation on the current context.
                self.o.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.tc_id = unsafe { gl.create_shader(ext.tess_control_shader) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.te_id = unsafe { gl.create_shader(ext.tess_evaluation_shader) };
                glu::expect_no_error(gl, fail_shader)?;
                // SAFETY: as above.
                self.o.fs_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
                glu::expect_no_error(gl, fail_shader)?;

                let tcs = self.test.shader_to_check == ShaderToCheck::TessellationControl;
                let tcs_code = if tcs {
                    tess_control_shader_code()
                } else {
                    TESS_CONTROL_SHADER_BOILERPLATE_CODE.to_string()
                };
                let tes_code = if tcs {
                    TESS_EVALUATION_SHADER_BOILERPLATE_CODE.to_string()
                } else {
                    tess_evaluation_shader_code()
                };
                let (vs_parts, tcs_parts, tes_parts, fs_parts) = (
                    [VERTEX_SHADER_BOILERPLATE_CODE],
                    [tcs_code.as_str()],
                    [tes_code.as_str()],
                    [FRAGMENT_SHADER_BOILERPLATE_CODE],
                );

                let stages = [
                    ShaderBody::Source(self.o.fs_id, &fs_parts),
                    ShaderBody::Source(self.o.tc_id, &tcs_parts),
                    ShaderBody::Source(self.o.te_id, &tes_parts),
                    ShaderBody::Source(self.o.vs_id, &vs_parts),
                ];
                if !self.base.build_program(self.context, self.o.po_id, &stages)?.0 {
                    return Err(TestError::Fail(fail_program.to_string()));
                }
            }
        }
        Ok(())
    }

    /// `removeTextures`
    fn remove_textures(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets bindings and deletes names this test created, on the current context.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);

            for id in [
                &mut self.o.iimage_read_to_id,
                &mut self.o.iimage_write_to_id,
                &mut self.o.image_read_to_id,
                &mut self.o.image_write_to_id,
                &mut self.o.uimage_read_to_id,
                &mut self.o.uimage_write_to_id,
            ] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
        }
    }

    /// `deinit`
    fn deinit(&mut self) {
        let gl = self.context.gl();
        // SAFETY: restores state and deletes names this test created, on the current context.
        unsafe {
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.use_program(0);
            gl.bind_vertex_array(0);

            for id in [&mut self.o.po_id, &mut self.o.copy_po_id] {
                if *id != 0 {
                    gl.delete_program(*id);
                    *id = 0;
                }
            }
            for id in [
                &mut self.o.cs_id,
                &mut self.o.fs_id,
                &mut self.o.gs_id,
                &mut self.o.tc_id,
                &mut self.o.te_id,
                &mut self.o.vs_id,
                &mut self.o.copy_cs_id,
            ] {
                if *id != 0 {
                    gl.delete_shader(*id);
                    *id = 0;
                }
            }
            if self.o.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.o.fbo_id);
                self.o.fbo_id = 0;
            }
            if self.o.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.o.vao_id);
                self.o.vao_id = 0;
            }
        }
        self.remove_textures();
    }

    /// `runShaders`
    fn run_shaders(&self, width: GLuint, height: GLuint, depth: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();

        if self.test.shader_to_check == ShaderToCheck::Compute {
            gl_call!(
                gl,
                "Error running compute shader!",
                gl.dispatch_compute(width, height, depth)
            );
            return Ok(());
        }

        // SAFETY: a linked program and a NUL-terminated name.
        let dimensions_location = unsafe { gl.get_uniform_location(self.o.po_id, c"dimensions".as_ptr()) };
        glu::expect_no_error(gl, "Error getting uniform location!")?;
        if dimensions_location == -1 {
            return Err(TestError::Fail(
                "Invalid location returned for active uniform!".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error setting value for uniform variable!",
            gl.uniform_3i(dimensions_location, width as GLint, height as GLint, depth as GLint)
        );

        if matches!(
            self.test.shader_to_check,
            ShaderToCheck::TessellationControl | ShaderToCheck::TessellationEvaluation
        ) {
            let ext = &self.base.gl_ext_tokens;
            gl_call!(
                gl,
                "Error setting patch parameter!",
                gl.patch_parameteri(ext.patch_vertices, 1)
            );
            gl_call!(gl, "Rendering failed!", gl.draw_arrays(ext.patches, 0, 1));
            gl_call!(
                gl,
                "Error setting patch parameter!",
                gl.patch_parameteri(ext.patch_vertices, 3)
            );
        } else {
            gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        }
        Ok(())
    }

    /// The texture setup, image unit binding, dispatch and verification of one resolution for one storage type.
    #[allow(clippy::too_many_arguments)]
    fn run_storage(
        &mut self,
        resolution: [GLuint; 3],
        stor_type: StorageType,
        float_data: &[f32],
        float_clean: &[f32],
        int_data: &[i32],
        int_clean: &[i32],
        uint_data: &[u32],
        uint_clean: &[u32],
    ) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let [width, height, depth] = resolution;
        let context = self.context;

        configure_texture::<f32>(
            context,
            &mut self.o.image_read_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32F,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            float_data,
        )?;
        configure_texture::<f32>(
            context,
            &mut self.o.image_write_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32F,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            float_clean,
        )?;

        configure_texture::<i32>(
            context,
            &mut self.o.iimage_read_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32I,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            int_data,
        )?;
        configure_texture::<i32>(
            context,
            &mut self.o.iimage_write_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32I,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            int_clean,
        )?;

        configure_texture::<u32>(
            context,
            &mut self.o.uimage_read_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32UI,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            uint_data,
        )?;
        configure_texture::<u32>(
            context,
            &mut self.o.uimage_write_to_id,
            width,
            height,
            depth,
            stor_type,
            glw::GL_RGBA32UI,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            uint_clean,
        )?;

        let bindings = [
            (IF_IMAGE, self.o.image_read_to_id, glw::GL_READ_ONLY, glw::GL_RGBA32F),
            (IF_IIMAGE, self.o.iimage_read_to_id, glw::GL_READ_ONLY, glw::GL_RGBA32I),
            (IF_UIMAGE, self.o.uimage_read_to_id, glw::GL_READ_ONLY, glw::GL_RGBA32UI),
            (
                IF_IMAGE + N_IMAGE_FORMATS,
                self.o.image_write_to_id,
                glw::GL_WRITE_ONLY,
                glw::GL_RGBA32F,
            ),
            (
                IF_IIMAGE + N_IMAGE_FORMATS,
                self.o.iimage_write_to_id,
                glw::GL_WRITE_ONLY,
                glw::GL_RGBA32I,
            ),
            (
                IF_UIMAGE + N_IMAGE_FORMATS,
                self.o.uimage_write_to_id,
                glw::GL_WRITE_ONLY,
                glw::GL_RGBA32UI,
            ),
        ];
        for (unit, texture, access, format) in bindings {
            gl_call!(
                gl,
                "Error binding texture object to image unit!",
                gl.bind_image_texture(unit, texture, 0, glw::TRUE, 0, access, format)
            );
        }

        self.run_shaders(width, height, depth)?;

        let copy_po_id = self.o.copy_po_id;
        let mut passed = true;
        if !check_results::<f32>(
            context,
            copy_po_id,
            self.o.image_write_to_id,
            width,
            height,
            depth,
            N_COMPONENTS,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            stor_type,
            float_data,
        )? {
            passed = false;
        }
        if !check_results::<i32>(
            context,
            copy_po_id,
            self.o.iimage_write_to_id,
            width,
            height,
            depth,
            N_COMPONENTS,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            stor_type,
            int_data,
        )? {
            passed = false;
        }
        if !check_results::<u32>(
            context,
            copy_po_id,
            self.o.uimage_write_to_id,
            width,
            height,
            depth,
            N_COMPONENTS,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            stor_type,
            uint_data,
        )? {
            passed = false;
        }

        self.remove_textures();
        Ok(passed)
    }

    fn run(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.init_test()?;

        gl_call!(gl, "Error setting active program object!", gl.use_program(self.o.po_id));

        let mut test_passed = true;

        for [width, height, depth] in RESOLUTIONS {
            let n = (width * height * depth * N_COMPONENTS) as usize;
            let float_clean = vec![0f32; n];
            let int_clean = vec![0i32; n];
            let uint_clean = vec![0u32; n];

            let float_data = fill_data::<f32>(width, height, depth, N_COMPONENTS, F_BASE);
            let int_data = fill_data::<i32>(width, height, depth, N_COMPONENTS, I_BASE);
            let uint_data = fill_data::<u32>(width, height, depth, N_COMPONENTS, UI_BASE);

            for stor_type in [StorageType::Mutable, StorageType::Immutable] {
                if !self.run_storage(
                    [width, height, depth],
                    stor_type,
                    &float_data,
                    &float_clean,
                    &int_data,
                    &int_clean,
                    &uint_data,
                    &uint_clean,
                )? {
                    test_passed = false;
                }
            }
        }

        Ok(test_passed)
    }
}

impl TestCase for ImageOp {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner {
            context,
            test: self,
            base: &base,
            o: Objects::default(),
        };

        let outcome = runner.run();
        runner.deinit();

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
