// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTexture.hpp / .cpp  (glu::Texture3D, non-compressed path only)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glu::Texture3D` - the 3D counterpart of `glu::Texture2D`/`glu::TextureCube`: a real
// `GL_TEXTURE_3D` object paired with a host-side mip-pyramid mirror
// (`tcu::texture_3d::Texture3D`) a test fills in, then uploads with one `upload()` call
// (one `glTexImage3D` call per allocated level, each with its own width/height/depth -
// see that module's own doc comment for why a 3D mip chain's depth is not constant the
// way a cube's or an array's is). Needed by `texture.filtering`/`texture.mipmap`/
// `texture.format`/`texture.vertex`'s own `TEXTURETYPE_3D` cases - see
// `tcu::texture_3d`'s own doc comment for the grep evidence.
//
// Narrowed exactly like `glu::Texture2D`/`glu::TextureCube`: only the two non-compressed
// constructors, `upload()` only (no `loadCompressed`).

use crate::glu::objects::Texture;
use crate::glu::render_context::RenderContext;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glw::{self, GLenum};
use crate::tcu::defs::TestError;
use crate::tcu::texture_3d::Texture3D as RefTexture3D;

/// `computePixelStore` - same formula as `glu::texture::compute_pixel_store`/
/// `glu::texture_cube`'s own copy; not shared across the three modules since each is a
/// private one-line helper on upstream's own precedent (every `glu::Texture*` wrapper
/// in C++ has its own file-local `computePixelStore` too).
fn compute_pixel_store(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

/// `glu::Texture3D`, narrowed per this module's top doc comment.
pub struct Texture3D<'gl> {
    gl: &'gl glw::Functions,
    format: GLenum,
    ref_texture: RefTexture3D,
    gl_texture: Texture<'gl>,
}

impl<'gl> Texture3D<'gl> {
    /// `Texture3D::Texture3D(context, format, dataType, width, height, depth)`.
    pub fn new(
        context: &'gl RenderContext,
        format: GLenum,
        data_type: GLenum,
        width: u32,
        height: u32,
        depth: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_transfer_format(format, data_type)
            .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
        Ok(Self {
            gl: context.functions(),
            format,
            ref_texture: RefTexture3D::new(tex_format, width, height, depth),
            gl_texture: Texture::new(context.functions()),
        })
    }

    /// `Texture3D::Texture3D(context, sizedFormat, width, height, depth)`.
    pub fn new_sized(
        context: &'gl RenderContext,
        sized_format: GLenum,
        width: u32,
        height: u32,
        depth: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_internal_format(sized_format)
            .ok_or_else(|| TestError::Fail(format!("unsupported sized internal format {sized_format:#x}")))?;
        Ok(Self {
            gl: context.functions(),
            format: sized_format,
            ref_texture: RefTexture3D::new(tex_format, width, height, depth),
            gl_texture: Texture::new(context.functions()),
        })
    }

    pub fn ref_texture(&self) -> &RefTexture3D {
        &self.ref_texture
    }

    pub fn ref_texture_mut(&mut self) -> &mut RefTexture3D {
        &mut self.ref_texture
    }

    pub fn gl_texture(&self) -> glw::GLuint {
        self.gl_texture.get()
    }

    /// `Texture3D::upload` (non-compressed path only).
    ///
    /// # Safety
    /// A valid, current GL context and a `self.gl` whose entry points it loaded.
    pub unsafe fn upload(&self) -> Result<(), TestError> {
        let gl = self.gl;
        let transfer = get_transfer_format(self.ref_texture.format())?;
        let pixel_size = self
            .ref_texture
            .format()
            .pixel_size()
            .ok_or_else(|| TestError::Fail("texture format has no defined pixel size".into()))?;

        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_3D, self.gl_texture.get());
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, compute_pixel_store(pixel_size));
            check_gl_error(gl, "Texture upload failed (bind/pixelStorei)")?;

            for level in 0..self.ref_texture.num_levels() {
                if self.ref_texture.is_level_empty(level) {
                    continue; // Don't upload.
                }
                let access = self.ref_texture.level(level);
                let size = access.size();
                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    level as i32,
                    self.format as i32,
                    size[0] as i32,
                    size[1] as i32,
                    size[2] as i32,
                    0, // border
                    transfer.format,
                    transfer.data_type,
                    access.raw().as_ptr().cast(),
                );
            }
            check_gl_error(gl, "Texture upload failed (texImage3D)")?;
        }
        Ok(())
    }
}

/// `GLU_EXPECT_NO_ERROR(gl.getError(), ...)`
///
/// # Safety
/// A valid, current GL context.
unsafe fn check_gl_error(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    let err = unsafe { gl.get_error() };
    if err == glw::GL_NO_ERROR {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{message}: glGetError() = {err:#x}")))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::glu::draw_util::{self, pr, va};
    use crate::glu::pixel_transfer;
    use crate::glu::render_context::ApiType;
    use crate::glu::shader_program::{ProgramSources, ShaderProgram};
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    /// The 3D counterpart of `glu::texture::tests::texture2d_uploads_and_a_textured_quad_draw_reads_it_back`:
    /// a 2x2x2 texture with a distinct colour per depth slice, sampled at `z=0.25`
    /// (slice 0) and `z=0.75` (slice 1) through a real `sampler3D` draw and read back.
    /// Skips (prints, does not panic) with no live GL context, same established
    /// precedent.
    #[test]
    fn texture3d_uploads_and_a_textured_quad_draw_reads_each_slice_back() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping texture3d_uploads_and_a_textured_quad_draw_reads_each_slice_back: no live GL context available"
            );
            return;
        };
        let gl = context.functions();

        let mut tex = Texture3D::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 1, 1, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be a supported transfer format");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // slice 0: red
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // slice 1: blue
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let vertex_src = "#version 300 es\nin vec4 a_position;\nin vec3 a_texCoord;\nout vec3 v_texCoord;\nvoid main() {\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        let fragment_src = "#version 300 es\nprecision mediump float;\nprecision mediump sampler3D;\nin vec3 v_texCoord;\nuniform sampler3D u_sampler;\nout vec4 o_color;\nvoid main() {\n    o_color = texture(u_sampler, v_texCoord);\n}\n";
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_src, fragment_src));
        assert!(
            program.is_ok(),
            "shader build failed: {:?}",
            program.build_failure_summary()
        );

        let sampler_name = std::ffi::CString::new("u_sampler").unwrap();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.use_program(program.program());
            let loc = gl.get_uniform_location(program.program(), sampler_name.as_ptr());
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_3D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
            gl.uniform_1i(loc, 0);
        }

        // x=-1 (left) vertices get z=0.25 (slice 0), x=+1 (right) vertices get z=0.75
        // (slice 1) - consistent on both triangles since only the shared diagonal
        // interpolates between the two.
        #[rustfmt::skip]
        let position: [f32; 12] = [
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ];
        #[rustfmt::skip]
        let texcoord: [f32; 18] = [
            0.5, 0.5, 0.25, 0.5, 0.5, 0.75, 0.5, 0.5, 0.75,
            0.5, 0.5, 0.25, 0.5, 0.5, 0.75, 0.5, 0.5, 0.25,
        ];
        let bindings = [
            va::float("a_position", 2, 6, 0, &position),
            va::float("a_texCoord", 3, 6, 0, &texcoord),
        ];
        draw_util::draw(
            &context,
            program.program(),
            &bindings,
            &pr::list(draw_util::PrimitiveType::Triangles, 6),
        )
        .expect("draw must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        pixel_transfer::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let access = result.get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "left half should sample slice 0 (red)"
        );
        assert_eq!(
            access.get_pixel(3, 0, 0),
            [0.0, 0.0, 1.0, 1.0],
            "right half should sample slice 1 (blue)"
        );
    }
}
