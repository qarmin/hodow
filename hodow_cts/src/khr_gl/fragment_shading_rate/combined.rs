// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateCombinedTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{
    FRAGMENT_SHADING_RATE_NOT_SUPPORTED, TRIANGLE_COUNT, available_shading_rates, not_supported, pack_shading_rate,
    random_vertices, reset_shading_rate_state,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const SHADING_RATE_COUNT: u32 = 16;
const FRAMEBUFFER_SAMPLES: GLsizei = 4;
const ALLOWED_FRAMEBUFFER_FORMATS: [GLenum; 2] = [glw::GL_RGBA32F, glw::GL_RGBA16F];
const CHANNELS: u32 = 4;

/// `FragmentShadingRateCombined::TestcaseParam`
#[derive(Clone, Copy)]
pub(super) struct TestcaseParam {
    pub use_shading_rate_api: bool,
    pub use_shading_rate_primitive: bool,
    pub use_shading_rate_attachment: bool,
    pub combiner_op0: GLenum,
    pub combiner_op1: GLenum,
    pub msaa: bool,
    pub framebuffer_size: i32,
}

#[derive(Clone, Copy)]
struct Extent2D {
    width: u32,
    height: u32,
}

/// `isTrivialCombiner`
fn is_trivial_combiner(combine_op: GLenum) -> bool {
    combine_op == glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT
        || combine_op == glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT
}

fn expect(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    glu::expect_no_error(gl, message)
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("no nul byte");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

/// `FragmentShadingRateCombined`
pub(super) struct Combined {
    ext_params: ExtParameters,
    param: TestcaseParam,
    name: String,
}

#[derive(Default)]
struct Resources {
    to_id: GLuint,
    sr_to_id: GLuint,
    fbo_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
}

/// What the simulation of the reference rates reads: the available rates, the attachment's texel size and the cache of `simulate`.
struct Simulation {
    param: TestcaseParam,
    available_shading_rates: Vec<GLenum>,
    sr_texel_width: GLint,
    sr_texel_height: GLint,
    cache: Vec<u32>,
}

impl Simulation {
    fn translate_draw_id_to_shading_rate(&self, draw_id: u32) -> GLenum {
        self.available_shading_rates[draw_id as usize % self.available_shading_rates.len()]
    }

    fn translate_prim_id_to_shading_rate(&self, prim_id: u32) -> GLenum {
        self.available_shading_rates[(prim_id as usize * 7) % self.available_shading_rates.len()]
    }

    fn translate_coords_to_shading_rate(&self, srx: u32, sry: u32) -> GLenum {
        self.available_shading_rates[(srx + sry) as usize % self.available_shading_rates.len()]
    }

    fn packed_shading_rate_to_extent(packed_rate: u32) -> Extent2D {
        Extent2D {
            width: 1 << ((packed_rate / 4) & 3),
            height: 1 << (packed_rate & 3),
        }
    }

    /// `combine`
    fn combine(extent0: Extent2D, extent1: Extent2D, combine_op: GLenum) -> Extent2D {
        match combine_op {
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT => extent0,
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT => extent1,
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MIN_EXT => Extent2D {
                width: extent0.width.min(extent1.width),
                height: extent0.height.min(extent1.height),
            },
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MAX_EXT => Extent2D {
                width: extent0.width.max(extent1.width),
                height: extent0.height.max(extent1.height),
            },
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MUL_EXT => Extent2D {
                width: extent0.width * extent1.width,
                height: extent0.height * extent1.height,
            },
            _ => extent0,
        }
    }

    /// `shadingRateExtentToClampedMask`: map an extent to a mask of all modes smaller than or equal to it in either dimension.
    fn shading_rate_extent_to_clamped_mask(&self, ext: Extent2D, allow_swap: bool) -> u32 {
        let mut desired_size = ext.width * ext.height;

        let mut mask = 0u32;

        while desired_size > 0 {
            // First, find modes that maximize the area
            for &rate in &self.available_shading_rates {
                let packed_shading_rate = pack_shading_rate(rate);
                let fragment_size = Self::packed_shading_rate_to_extent(packed_shading_rate);

                if fragment_size.width * fragment_size.height == desired_size
                    && ((fragment_size.width <= ext.width && fragment_size.height <= ext.height)
                        || (fragment_size.height <= ext.width && fragment_size.width <= ext.height && allow_swap))
                {
                    let candidate = (fragment_size.width.trailing_zeros() << 2) | fragment_size.height.trailing_zeros();
                    mask |= 1 << candidate;
                }
            }
            if mask != 0 {
                // Amongst the modes that maximize the area, pick the ones that minimize the aspect ratio. Prefer ratio of 1, then 2, then 4.
                // 1x1 = 0, 2x2 = 5, 4x4 = 10
                const ASPECT_MASK_RATIO1: u32 = 0x421;
                // 2x1 = 4, 1x2 = 1, 4x2 = 9, 2x4 = 6
                const ASPECT_MASK_RATIO2: u32 = 0x252;
                // 4x1 = 8, 1x4 = 2,
                const ASPECT_MASK_RATIO4: u32 = 0x104;

                if mask & ASPECT_MASK_RATIO1 != 0 {
                    mask &= ASPECT_MASK_RATIO1;
                    break;
                }
                if mask & ASPECT_MASK_RATIO2 != 0 {
                    mask &= ASPECT_MASK_RATIO2;
                    break;
                }
                if mask & ASPECT_MASK_RATIO4 != 0 {
                    mask &= ASPECT_MASK_RATIO4;
                    break;
                }
            }
            desired_size /= 2;
        }

        mask
    }

    /// `simulate`: software simulate to compare with the GPU result.
    fn simulate(&mut self, draw_id: u32, prim_id: u32, x: u32, y: u32) -> u32 {
        let rate0 = if self.param.use_shading_rate_api {
            pack_shading_rate(self.translate_draw_id_to_shading_rate(draw_id))
        } else {
            0
        };
        let rate1 = if self.param.use_shading_rate_primitive {
            pack_shading_rate(self.translate_prim_id_to_shading_rate(prim_id))
        } else {
            0
        };
        let rate2 = if self.param.use_shading_rate_attachment {
            pack_shading_rate(
                self.translate_coords_to_shading_rate(x / self.sr_texel_width as u32, y / self.sr_texel_height as u32),
            )
        } else {
            0
        };

        let cache_index = ((rate2 * SHADING_RATE_COUNT + rate1) * SHADING_RATE_COUNT + rate0) as usize;
        if self.cache[cache_index] != 0xFFFF_FFFF {
            return self.cache[cache_index];
        }

        let extent0 = Self::packed_shading_rate_to_extent(rate0);
        let extent1 = Self::packed_shading_rate_to_extent(rate1);
        let extent2 = Self::packed_shading_rate_to_extent(rate2);

        let mut final_mask = 0u32;
        // Simulate once for implementations that don't allow swapping rate xy, and once for those that do. Any of those results is allowed.
        for allow_swap in [false, true] {
            // Combine rate 0 and 1, get a mask of possible clamped rates
            let intermediate = Self::combine(extent0, extent1, self.param.combiner_op0);
            let intermediate_mask = self.shading_rate_extent_to_clamped_mask(intermediate, allow_swap);

            // For each clamped rate, combine that with rate 2 and accumulate the possible clamped rates
            for i in 0..SHADING_RATE_COUNT {
                if intermediate_mask & (1 << i) != 0 {
                    let final_extent =
                        Self::combine(Self::packed_shading_rate_to_extent(i), extent2, self.param.combiner_op1);
                    final_mask |= self.shading_rate_extent_to_clamped_mask(final_extent, allow_swap);
                }
            }
            {
                // unclamped intermediate value is also permitted
                let final_extent = Self::combine(intermediate, extent2, self.param.combiner_op1);
                final_mask |= self.shading_rate_extent_to_clamped_mask(final_extent, allow_swap);
            }
        }

        self.cache[cache_index] = final_mask;
        final_mask
    }
}

impl Combined {
    pub(super) fn new(ext_params: ExtParameters, param: TestcaseParam, name: String) -> Self {
        Self {
            ext_params,
            param,
            name,
        }
    }

    /// `FragmentShadingRateCombined::init`, which also picks the framebuffer format.
    fn init(&self, context: &Context, base: &TestCaseBase) -> Result<GLenum, TestError> {
        let param = &self.param;
        let gl = context.gl();

        if !base.is_fragment_shading_rate_supported {
            return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
        }

        if !base.is_fragment_shading_rate_primitive_supported {
            if param.use_shading_rate_primitive {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }

            if param.combiner_op0 != glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }
        }

        if !base.is_fragment_shading_rate_attachment_supported {
            if param.use_shading_rate_attachment {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }

            if param.combiner_op1 != glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }
        }

        if !is_trivial_combiner(param.combiner_op0) || !is_trivial_combiner(param.combiner_op1) {
            let mut support_non_trivial_combiner: glw::GLboolean = 0;
            gl!(gl.get_booleanv(
                glw::GL_FRAGMENT_SHADING_RATE_NON_TRIVIAL_COMBINERS_SUPPORTED_EXT,
                &mut support_non_trivial_combiner
            ));
            expect(gl, "Error getBooleanv non trivial combiner")?;

            if support_non_trivial_combiner == 0 {
                return Err(not_supported("Non trivial combiner is not supported"));
            }
        }

        if param.msaa {
            for format in ALLOWED_FRAMEBUFFER_FORMATS {
                let mut max_samples: GLint = 1;
                gl!(gl.get_internalformativ(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    format,
                    glw::GL_SAMPLES,
                    1,
                    &mut max_samples
                ));

                if max_samples >= FRAMEBUFFER_SAMPLES {
                    return Ok(format);
                }
            }
            return Err(not_supported("MSAA not supported for any allowed format"));
        }
        Ok(ALLOWED_FRAMEBUFFER_FORMATS[0])
    }

    fn deinit(gl: &glw::Functions, base: &TestCaseBase, resources: &Resources) {
        reset_shading_rate_state(gl, base);

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, 0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        gl!(gl.delete_textures(1, &resources.to_id));
        gl!(gl.delete_textures(1, &resources.sr_to_id));
        gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        gl!(gl.delete_buffers(1, &resources.vbo_id));
    }

    fn gen_vs(&self) -> String {
        let mut os = String::from(
            "#version 310 es                        \n#extension GL_EXT_fragment_shading_rate : enable\nprecision highp float;                 \nprecision highp int;                   \nlayout(location = 0) in vec4 position; \nuniform int primShadingRate;           \nvoid main() {                          \n    gl_Position = position;            \n",
        );

        if self.param.use_shading_rate_primitive {
            os.push_str("    gl_PrimitiveShadingRateEXT = primShadingRate;\n");
        }
        os.push('}');
        os
    }

    fn gen_fs(&self) -> String {
        let mut os = String::from(
            "#version 310 es\n#extension GL_EXT_fragment_shading_rate : enable\nprecision highp float;\nprecision highp int;\nlayout(location = 0) out vec4 color0;\nuniform int primID;\nuniform int drawID;\nvoid main() {\n    color0.x = float(gl_ShadingRateEXT);\n    color0.y = float(drawID);\n",
        );

        if self.param.use_shading_rate_primitive {
            os.push_str("    color0.z = float(primID);\n");
        }

        os.push_str("    color0.w = 0.0;\n}");
        os
    }

    fn gen_cs(&self) -> String {
        let samples: u32 = if self.param.msaa { 4 } else { 1 };
        let sampler = if self.param.msaa {
            "uniform highp sampler2DMS colorTex;\n"
        } else {
            "uniform highp sampler2D colorTex;\n"
        };
        format!(
            "#version 310 es\nprecision highp float;\nprecision highp int;\n{sampler}layout (binding = 0, std430) buffer ColorBuf {{\n    uvec4 values[];\n}} colorbuf;\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nvoid main()\n{{\n    for (uint i = 0u; i < {samples}u; ++i) \n    {{\n        uint index = ((gl_GlobalInvocationID.y * {size}u) + gl_GlobalInvocationID.x) * {samples}u + i;\n        colorbuf.values[index] = uvec4(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i))));\n    }}\n}}",
            size = self.param.framebuffer_size
        )
    }

    fn run(&self, context: &Context, framebuffer_format: GLenum, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let param = &self.param;
        let size = param.framebuffer_size;

        let sample_count: u32 = if param.msaa { 4 } else { 1 };
        let mut simulation = Simulation {
            param: *param,
            available_shading_rates: available_shading_rates(gl, sample_count as GLsizei)?,
            sr_texel_width: 0,
            sr_texel_height: 0,
            cache: vec![0xFFFF_FFFF; (SHADING_RATE_COUNT * SHADING_RATE_COUNT * SHADING_RATE_COUNT) as usize],
        };

        // setupTest
        let render_program =
            ShaderProgram::new_reporting_build_failure(gl, &ProgramSources::vtx_frag(self.gen_vs(), self.gen_fs()));
        if !render_program.is_ok() {
            if let Some(summary) = render_program.build_failure_summary() {
                log::info!("{summary}");
            }
            return Err(TestError::Fail("Shader creation failed".to_string()));
        }

        let compute_program = ShaderProgram::new_reporting_build_failure(gl, &ProgramSources::compute(self.gen_cs()));
        if !compute_program.is_ok() {
            if let Some(summary) = compute_program.build_failure_summary() {
                log::info!("{summary}");
            }
            return Err(TestError::Fail("Shader creation failed".to_string()));
        }

        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        expect(gl, "Error setting up framebuffer objects")?;

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo_id));
        expect(gl, "Error binding frame buffer object!")?;

        gl!(gl.gen_textures(1, &mut resources.to_id));
        expect(gl, "Error generating texture objects")?;

        gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1));
        expect(gl, "Error set pixelStorei for unpack alignment")?;

        let texture_target = if param.msaa {
            glw::GL_TEXTURE_2D_MULTISAMPLE
        } else {
            glw::GL_TEXTURE_2D
        };
        if param.msaa {
            gl!(gl.bind_texture(texture_target, resources.to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_storage_2d_multisample(texture_target, FRAMEBUFFER_SAMPLES, framebuffer_format, size, size, 1));
            expect(gl, "Error allocating texture object!")?;
        } else {
            gl!(gl.bind_texture(texture_target, resources.to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_storage_2d(texture_target, 1, framebuffer_format, size, size));
            expect(gl, "Error allocating texture object!")?;
        }

        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            texture_target,
            resources.to_id,
            0
        ));
        expect(gl, "Error attaching texture to frame buffer")?;

        if param.use_shading_rate_attachment {
            // generate shading rate texture
            gl!(gl.get_integerv(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT,
                &mut simulation.sr_texel_width
            ));
            expect(
                gl,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT!",
            )?;
            gl!(gl.get_integerv(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT,
                &mut simulation.sr_texel_height
            ));
            expect(
                gl,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT!",
            )?;

            let sr_width = ((size + simulation.sr_texel_width - 1) / simulation.sr_texel_width) as u32;
            let sr_height = ((size + simulation.sr_texel_height - 1) / simulation.sr_texel_height) as u32;

            gl!(gl.gen_textures(1, &mut resources.sr_to_id));
            expect(gl, "Error generating texture objects")?;

            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.sr_to_id));
            expect(gl, "Error binding texture object!")?;

            gl!(gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R8UI,
                sr_width as GLsizei,
                sr_height as GLsizei
            ));
            expect(gl, "Error allocating texture object!")?;

            let mut attachment_shading_rate_data: Vec<u8> = Vec::with_capacity((sr_width * sr_height) as usize);
            for sry in 0..sr_height {
                for srx in 0..sr_width {
                    attachment_shading_rate_data
                        .push(pack_shading_rate(simulation.translate_coords_to_shading_rate(srx, sry)) as u8);
                }
            }

            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                sr_width as GLsizei,
                sr_height as GLsizei,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_BYTE,
                attachment_shading_rate_data.as_ptr().cast()
            ));
            expect(gl, "Error updating shading rate data to texture")?;

            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                resources.sr_to_id,
                0,
                1,
                simulation.sr_texel_width,
                simulation.sr_texel_height
            ));
            expect(gl, "Error attaching shading rate attachment to frame buffer")?;
        }

        let vertices = random_vertices(0);

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        expect(gl, "Error generate vertex arrays")?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        expect(gl, "Error bind vertex array")?;

        gl!(gl.gen_buffers(1, &mut resources.vbo_id));
        expect(gl, "Error setting up buffer objects")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo_id));
        expect(gl, "Error binding buffer objects")?;

        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (vertices.len() * std::mem::size_of::<f32>()) as isize,
            vertices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        expect(gl, "Error uploading buffer data")?;

        gl!(gl.shading_rate_ext(glw::GL_SHADING_RATE_1X1_PIXELS_EXT));
        expect(gl, "Error to set shadingRateEXT as default")?;

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        gl!(gl.use_program(render_program.program()));
        expect(gl, "Error use program")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo_id));
        expect(gl, "Error bind buffer vertex data")?;

        gl!(gl.enable_vertex_attrib_array(0));
        expect(gl, "Error enabling vertex attrib pointer 0")?;

        gl!(gl.vertex_attrib_pointer(
            0,
            2,
            glw::GL_FLOAT,
            0,
            (std::mem::size_of::<f32>() * 2) as i32,
            std::ptr::null()
        ));
        expect(gl, "Error binding vertex attrib pointer 0")?;

        // primitive ID start from 1
        for draw_id in 1..TRIANGLE_COUNT {
            let prim_id = draw_id + 1;
            let packed_shading_rate = pack_shading_rate(simulation.translate_prim_id_to_shading_rate(prim_id));
            gl!(gl.uniform_1i(
                uniform_location(gl, render_program.program(), "primShadingRate"),
                packed_shading_rate as GLint
            ));
            expect(gl, "Error set uniform shadingRate value")?;

            gl!(gl.uniform_1i(
                uniform_location(gl, render_program.program(), "primID"),
                prim_id as GLint
            ));
            expect(gl, "Error set uniform primID value")?;

            gl!(gl.uniform_1i(
                uniform_location(gl, render_program.program(), "drawID"),
                draw_id as GLint
            ));
            expect(gl, "Error set uniform drawID value")?;

            if param.use_shading_rate_api {
                gl!(gl.shading_rate_ext(simulation.translate_draw_id_to_shading_rate(draw_id)));
                expect(gl, "Error set shading rate")?;
            }

            gl!(gl.shading_rate_combiner_ops_ext(param.combiner_op0, param.combiner_op1));
            expect(gl, "Error set Shading Rate combiner operations")?;

            gl!(gl.draw_arrays(glw::GL_TRIANGLES, (draw_id * 2) as GLint, 3));
            expect(gl, "Error draw a triangle")?;
        }

        let data_size = size as u32 * size as u32 * sample_count * std::mem::size_of::<u32>() as u32 * CHANNELS;

        // Copy the result color buffer to shader storage buffer to access for the msaa case
        let mut ssbo_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut ssbo_id));
        expect(gl, "Error generate buffer object")?;

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, ssbo_id));
        expect(gl, "Error bind buffer object")?;

        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            data_size as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY
        ));
        expect(gl, "Error allocate buffer object")?;

        gl!(gl.use_program(compute_program.program()));
        expect(gl, "Error use compute object")?;

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssbo_id));
        expect(gl, "Error bind buffer object to program")?;

        gl!(gl.uniform_1i(uniform_location(gl, compute_program.program(), "colorTex"), 0));
        expect(gl, "Error bind set colorTex uniform value")?;

        gl!(gl.bind_texture(texture_target, resources.to_id));
        expect(gl, "Error bind texture")?;

        gl!(gl.dispatch_compute(size as GLuint, size as GLuint, 1));
        expect(gl, "Error dispatching copy compute program")?;

        gl!(gl.flush());
        expect(gl, "Error for flushing")?;

        let res_ptr = gl!(gl.map_buffer_range(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            data_size as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<u32>();
        if res_ptr.is_null() {
            gl!(gl.delete_buffers(1, &ssbo_id));
            return Err(TestError::Fail("glMapBufferRange returned NULL".to_string()));
        }
        // SAFETY: `data_size` bytes were mapped for reading, and the mapping lives until the buffer is deleted below.
        let res =
            unsafe { std::slice::from_raw_parts(res_ptr, (data_size / std::mem::size_of::<u32>() as u32) as usize) };

        for y in 0..size as u32 {
            for x in 0..size as u32 {
                for s in 0..sample_count {
                    let index = (((y * size as u32 + x) * sample_count + s) * CHANNELS) as usize;
                    let sample = &res[index..index + CHANNELS as usize];
                    if sample[1] == 0 {
                        // nothing rendered
                        continue;
                    }

                    let shading_rate = sample[0];
                    let draw_id = sample[1];
                    let prim_id = sample[2];
                    let expected_shading_rate_mask = simulation.simulate(draw_id, prim_id, x, y);
                    if expected_shading_rate_mask & 1u32.checked_shl(shading_rate).unwrap_or(0) == 0 {
                        let message = format!(
                            "The draw ID is {draw_id}The primitive ID is {prim_id}Shading Rate is{shading_rate}, But we expect one mask of {expected_shading_rate_mask}"
                        );

                        gl!(gl.delete_buffers(1, &ssbo_id));
                        return Ok(TestStatus::fail(message));
                    }
                }
            }
        }

        gl!(gl.delete_buffers(1, &ssbo_id));

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Combined {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let framebuffer_format = self.init(context, &base)?;

        let mut resources = Resources::default();
        let outcome = self.run(context, framebuffer_format, &mut resources);
        Self::deinit(context.gl(), &base, &resources);
        outcome
    }
}
