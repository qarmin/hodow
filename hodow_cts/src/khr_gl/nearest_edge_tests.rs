// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcNearestEdgeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's constructor reads the render target and maps its pixel format; the case tree is built here before any context
// exists, so that moved into `iterate`, where a format with no mapping is a Fail as `TCU_FAIL` makes it. The `TestLog::Image` calls have no counterpart: the first mismatch
// and the sizes are logged instead.

use std::ffi::CString;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, get_texture_format_info};
use crate::tcu::{ChannelOrder, ChannelType, PixelFormat, TestError, TestOutcome, TestStatus, TextureFormat};

const TEXTURE_TYPE: GLenum = glw::GL_TEXTURE_2D;

#[derive(Clone, Copy)]
enum OffsetDirection {
    Left,
    Right,
}

/// `NearestEdgeTestCase`
struct NearestEdgeTestCase {
    direction: OffsetDirection,
}

/// `NearestEdgeTestCase::toTextureFormat` - the pixel format in the frame buffer as a texture format, and whether BGRA is the format to read it back in.
fn to_texture_format(context: &Context, pixel_format: PixelFormat) -> Result<(TextureFormat, bool), TestError> {
    use ChannelOrder::{RGB, RGBA};
    use ChannelType::*;

    let pixel_format_map = [
        (PixelFormat::new(8, 8, 8, 8), TextureFormat::new(RGBA, UNORM_INT8)),
        (PixelFormat::new(8, 8, 8, 0), TextureFormat::new(RGB, UNORM_INT8)),
        (PixelFormat::new(4, 4, 4, 4), TextureFormat::new(RGBA, UNORM_SHORT_4444)),
        (PixelFormat::new(5, 5, 5, 1), TextureFormat::new(RGBA, UNORM_SHORT_5551)),
        (PixelFormat::new(5, 6, 5, 0), TextureFormat::new(RGB, UNORM_SHORT_565)),
        (
            PixelFormat::new(10, 10, 10, 2),
            TextureFormat::new(RGBA, UNORM_INT_1010102_REV),
        ),
        (
            PixelFormat::new(10, 10, 10, 0),
            TextureFormat::new(RGBA, UNORM_INT_1010102_REV),
        ),
        (PixelFormat::new(16, 16, 16, 16), TextureFormat::new(RGBA, HALF_FLOAT)),
        (PixelFormat::new(16, 16, 16, 0), TextureFormat::new(RGB, HALF_FLOAT)),
    ];

    let gl = context.gl();
    for (map_pixel_format, tex_format) in pixel_format_map {
        if map_pixel_format != pixel_format {
            continue;
        }

        let mut impl_format = glw::GL_NONE as i32;
        let mut impl_type = glw::GL_NONE as i32;
        // SAFETY: two GLint outs.
        unsafe {
            gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &mut impl_format);
            gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &mut impl_type);
        }
        let (impl_format, impl_type) = (impl_format as GLenum, impl_type as GLenum);

        // Some implementations treat GL_RGB8 as GL_RGBA8888, so the test should pass the implementation format to ReadPixels.
        if pixel_format == PixelFormat::new(8, 8, 8, 0)
            && impl_format == glw::GL_RGBA
            && impl_type == glw::GL_UNSIGNED_BYTE
        {
            return Ok((TextureFormat::new(RGBA, UNORM_INT8), false));
        }
        let mut preferred_bgra = false;
        if pixel_format == PixelFormat::new(5, 5, 5, 1) && tex_format.order == RGBA {
            let read_format_bgra_supported = context.context_info.is_extension_supported("GL_EXT_read_format_bgra");
            if read_format_bgra_supported && impl_format == glw::GL_BGRA_EXT {
                preferred_bgra = true;
            }
        }
        if (pixel_format == PixelFormat::new(16, 16, 16, 16) || pixel_format == PixelFormat::new(16, 16, 16, 0))
            && impl_type == glw::GL_UNSIGNED_SHORT
        {
            return Ok((TextureFormat::new(RGBA, UNORM_INT16), false));
        }
        return Ok((tex_format, preferred_bgra));
    }

    Err(TestError::Fail(
        "Unable to map pixel format to texture format".to_string(),
    ))
}

impl TestCase for NearestEdgeTestCase {
    fn name(&self) -> &str {
        match self.direction {
            OffsetDirection::Left => "offset_left",
            OffsetDirection::Right => "offset_right",
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let target = context.render_target();
        if target.width < 2 || target.height < 2 {
            return Err(TestError::NotSupported("Render target size too small".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let target = context.render_target();
        let (width, height) = (target.width, target.height);
        let offset_sign: f32 = match self.direction {
            OffsetDirection::Left => -1.0,
            OffsetDirection::Right => 1.0,
        };

        let (tex_format, preferred_bgra) = to_texture_format(context, target.pixel_format())?;
        let tex_format_info = get_texture_format_info(tex_format);
        let trans_format = glu::get_transfer_format(tex_format)?;
        let pixel_size = tex_format
            .pixel_size()
            .ok_or_else(|| TestError::InternalError("texture format has no pixel size".to_string()))?
            as usize;

        // Shader sources: the template's `${VERSION}` is "130" on a core context, as upstream picks it.
        let vert_shader = "#version 130\n\nin highp vec2 position;\n\nvoid main()\n{\n    gl_Position = vec4(position, 0.0, 1.0);\n}\n".to_string();
        let frag_shader = "#version 130\n\nprecision highp float;\nout highp vec4 fragColor;\n\nuniform highp sampler2D texSampler;\nuniform float texOffset;\nuniform float texWidth;\nuniform float texHeight;\n\nvoid main()\n{\n    float texCoordX;\n    float texCoordY;\n    texCoordX = (gl_FragCoord.x + texOffset) / texWidth;\n     texCoordY = (gl_FragCoord.y + texOffset) / texHeight;\n    vec2 sampleCoord = vec2(texCoordX, texCoordY);\n    fragColor = texture(texSampler, sampleCoord);\n}\n\n".to_string();

        // createTexture
        let mut texture: GLuint = 0;
        // SAFETY: a texture name out and parameter setters on the texture just bound.
        unsafe {
            gl.gen_textures(1, &mut texture);
            glu::expect_no_error(gl, "glGenTextures")?;
            gl.bind_texture(TEXTURE_TYPE, texture);
            glu::expect_no_error(gl, "glBindTexture")?;

            for (pname, value) in [
                (glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST),
                (glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST),
                (glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT),
                (glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT),
                (glw::GL_TEXTURE_MAX_LEVEL, 0),
            ] {
                gl.tex_parameteri(TEXTURE_TYPE, pname, value as i32);
                glu::expect_no_error(gl, "glTexParameteri")?;
            }
        }

        // fillTexture: a gradient over the whole texture.
        let mut tex_data = vec![0u8; width as usize * height as usize * pixel_size];
        let div_x = (width - 1) as f32;
        let div_y = (height - 1) as f32;
        {
            let mut tex_access = PixelBufferAccess::new(tex_format, [width as u32, height as u32, 1], &mut tex_data);
            for x in 0..width {
                for y in 0..height {
                    let color_x = x as f32 / div_x;
                    let color_y = y as f32 / div_y;
                    let color_z = color_x.min(color_y);

                    let color = [color_x, color_y, color_z, 1.0];
                    let final_color: [f32; 4] = std::array::from_fn(|c| {
                        (color[c] - tex_format_info.look_up_bias[c]) / tex_format_info.look_up_scale[c]
                    });
                    tex_access.set_pixel(final_color, x as u32, y as u32, 0);
                }
            }
        }
        let internal_format = glu::get_internal_format(tex_format)?;
        // SAFETY: `tex_data` holds width x height texels of `tex_format`, which is what the transfer format describes.
        unsafe {
            if pixel_size < 4 {
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
            }
            gl.tex_image_2d(
                TEXTURE_TYPE,
                0,
                internal_format as i32,
                width,
                height,
                0,
                trans_format.format,
                trans_format.data_type,
                tex_data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "glTexImage2D")?;

        // renderQuad: a full screen quad with an offset of almost half a texel, so sampling happens near the texel border and truncation is verified.
        let offset = 0.5 - 2.0f32.powf(-8.0);
        let positions: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
        let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
        let vertex_arrays = [va::float("position", 2, 4, 0, &positions)];

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_shader, frag_shader));
        if !program.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }
        let uniform = |name: &str| -> glw::GLint {
            let name = CString::new(name).expect("a uniform name without NUL");
            // SAFETY: a program that built, and a NUL-terminated name that outlives the call.
            unsafe { gl.get_uniform_location(program.program(), name.as_ptr()) }
        };
        // SAFETY: state setters and uniform writes on the program just made current.
        unsafe {
            gl.use_program(program.program());
            glu::expect_no_error(gl, "glUseProgram failed")?;

            gl.uniform_1i(uniform("texSampler"), 0);
            glu::expect_no_error(gl, "glUniform1i failed")?;

            gl.uniform_1f(uniform("texOffset"), offset_sign * offset);
            gl.uniform_1f(uniform("texWidth"), width as f32);
            gl.uniform_1f(uniform("texHeight"), height as f32);
            glu::expect_no_error(gl, "glUniform1i failed")?;

            gl.disable(glw::GL_DITHER);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        glu::draw(
            &context.render_context,
            program.program(),
            &vertex_arrays,
            &pr::triangle_strip(&quad_indices),
        )?;

        // verifyResults
        let mut impl_format = glw::GL_NONE as i32;
        let mut impl_type = glw::GL_NONE as i32;
        // SAFETY: two GLint outs.
        unsafe {
            gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT, &mut impl_format);
            gl.get_integerv(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE, &mut impl_type);
        }
        let (impl_format, mut impl_type) = (impl_format as GLenum, impl_type as GLenum);
        if preferred_bgra
            && impl_format == glw::GL_BGRA_EXT
            && trans_format.data_type == glw::GL_UNSIGNED_SHORT_5_5_5_1
            && trans_format.format == glw::GL_RGBA
        {
            impl_type = glw::GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT;
        }

        let mut fb_data = vec![0u8; width as usize * height as usize * pixel_size];
        // SAFETY: `fb_data` holds width x height pixels of the format and type read back.
        unsafe {
            if pixel_size < 4 {
                gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            }
            if preferred_bgra {
                gl.read_pixels(0, 0, width, height, impl_format, impl_type, fb_data.as_mut_ptr().cast());
            } else {
                gl.read_pixels(
                    0,
                    0,
                    width,
                    height,
                    trans_format.format,
                    trans_format.data_type,
                    fb_data.as_mut_ptr().cast(),
                );
            }
        }
        glu::expect_no_error(gl, "glReadPixels")?;

        let tex_access = ConstPixelBufferAccess::new(tex_format, [width as u32, height as u32, 1], &tex_data);
        let fb_format = if preferred_bgra {
            TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_SHORT_1555)
        } else {
            tex_format
        };
        let fb_access = ConstPixelBufferAccess::new(fb_format, [width as u32, height as u32, 1], &fb_data);

        let mut mismatches = 0usize;
        let mut first_mismatch = None;
        for x in 0..width as u32 {
            for y in 0..height as u32 {
                let tex_pixel = tex_access.get_pixel(x, y, 0);
                let mut fb_pixel = fb_access.get_pixel(x, y, 0);
                if preferred_bgra {
                    fb_pixel = [fb_pixel[1], fb_pixel[0], fb_pixel[3], fb_pixel[2]];
                }

                // Require perfect pixel match.
                if tex_pixel != fb_pixel {
                    mismatches += 1;
                    first_mismatch.get_or_insert((x, y, tex_pixel, fb_pixel));
                }
            }
        }

        // deleteTexture
        // SAFETY: the name generated above.
        unsafe { gl.delete_textures(1, &texture) };
        glu::expect_no_error(gl, "glDeleteTextures")?;

        match first_mismatch {
            None => Ok(TestStatus::pass("Pass")),
            Some((x, y, tex_pixel, fb_pixel)) => {
                log::info!(
                    "Width: {width}, Height: {height}, {mismatches} mismatched pixel(s); first at ({x}, {y}): texture {tex_pixel:?}, frame buffer {fb_pixel:?}"
                );
                Ok(TestStatus::fail("Pixel mismatch; check the generated images"))
            }
        }
    }
}

/// `NearestEdgeCases`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("nearest_edge");
    for direction in [OffsetDirection::Left, OffsetDirection::Right] {
        group.add_child(Box::new(NearestEdgeTestCase { direction }) as Box<dyn TestCase>);
    }
    group
}
