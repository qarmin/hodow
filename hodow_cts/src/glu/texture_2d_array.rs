// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTexture.hpp / .cpp  (glu::Texture2DArray, non-compressed path only)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glu::Texture2DArray` - the array counterpart of `glu::Texture2D`/`glu::Texture3D`: a
// real `GL_TEXTURE_2D_ARRAY` object paired with a host-side mip-pyramid mirror
// (`tcu::texture_2d_array::Texture2DArray`) a test fills in, then uploads with one
// `upload()` call. Upstream's own `upload` goes through `glTexImage3D` with target
// `GL_TEXTURE_2D_ARRAY` (confirmed directly - the array's own "depth" axis is its layer
// count, and a 2D-array upload is layered exactly the way a 3D one is, API-wise), so
// this reuses the identical shape `glu::texture_3d::Texture3D::upload` already has.
// Needed by `texture.filtering`/`texture.mipmap`/`texture.format`/`texture.vertex`'s own
// `TEXTURETYPE_2D_ARRAY` cases.
//
// Narrowed exactly like `glu::Texture2D`/`glu::TextureCube`/`glu::Texture3D`: only the
// two non-compressed constructors at first, `upload()` only (no `loadCompressed`).
//
// `new_compressed`/`upload_compressed` close that gap the same way `glu::Texture2D`'s
// own pair does - see that module's top doc comment for the full reasoning (the
// compressed-data constructor needs no test-data archive after all). `loadCompressed`'s
// own body here is one `glCompressedTexImage3D` call per level, covering every layer at
// once (`level.getDepth()` is the array's own layer count, confirmed directly against
// `gluTexture.cpp`), which is exactly what `tcu::compressed_texture::decompress`'s own
// `block_z` loop over `dst.size()[2]` already supports in a single call - no per-layer
// loop needed on either the decode or the upload side.

use vulkanalia::vk;

use crate::glu::context_info::ContextInfo;
use crate::glu::objects::Texture;
use crate::glu::render_context::RenderContext;
use crate::glu::texture_util::{
    get_gl_format_for_compressed, get_transfer_format, map_gl_internal_format, map_gl_transfer_format,
};
use crate::glw::{self, GLenum};
use crate::tcu::compressed_texture::{decompress, get_uncompressed_format};
use crate::tcu::defs::TestError;
use crate::tcu::texture_2d_array::Texture2DArray as RefTexture2DArray;

fn compute_pixel_store(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

/// `glu::Texture2DArray`, narrowed per this module's top doc comment.
pub struct Texture2DArray<'gl> {
    gl: &'gl glw::Functions,
    format: GLenum,
    ref_texture: RefTexture2DArray,
    gl_texture: Texture<'gl>,
    /// See `glu::Texture2D`'s identically-named field for what this holds and why.
    compressed_levels: Vec<Vec<u8>>,
}

impl<'gl> Texture2DArray<'gl> {
    /// `Texture2DArray::Texture2DArray(context, format, dataType, width, height, numLayers)`.
    pub fn new(
        context: &'gl RenderContext,
        format: GLenum,
        data_type: GLenum,
        width: u32,
        height: u32,
        num_layers: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_transfer_format(format, data_type)
            .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
        Ok(Self {
            gl: context.functions(),
            format,
            ref_texture: RefTexture2DArray::new(tex_format, width, height, num_layers),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `Texture2DArray::Texture2DArray(context, sizedFormat, width, height, numLayers)`.
    pub fn new_sized(
        context: &'gl RenderContext,
        sized_format: GLenum,
        width: u32,
        height: u32,
        num_layers: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_internal_format(sized_format)
            .ok_or_else(|| TestError::Fail(format!("unsupported sized internal format {sized_format:#x}")))?;
        Ok(Self {
            gl: context.functions(),
            format: sized_format,
            ref_texture: RefTexture2DArray::new(tex_format, width, height, num_layers),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `Texture2DArray::Texture2DArray(context, contextInfo, numLevels, levels,
    /// decompressionParams)` folded with `loadCompressed` - see `glu::Texture2D::
    /// new_compressed`'s own doc comment for the shape this mirrors. `level_data[n]` is
    /// level `n`'s compressed bytes for *every* layer concatenated (layer-major, the same
    /// layout a real `glCompressedTexImage3D` upload and `tcu::compressed_texture::
    /// decompress`'s own `block_z` loop both already expect).
    pub fn new_compressed(
        context: &'gl RenderContext,
        info: &ContextInfo,
        vk_format: vk::Format,
        width: u32,
        height: u32,
        num_layers: u32,
        level_data: &[&[u8]],
    ) -> Result<Self, TestError> {
        let gl = context.functions();
        let gl_format = get_gl_format_for_compressed(vk_format)
            .ok_or_else(|| TestError::Fail(format!("no GL enum for compressed format {vk_format:?}")))?;
        if !info.is_compressed_texture_format_supported(gl, gl_format) {
            return Err(TestError::NotSupported(format!(
                "compressed texture format {gl_format:#x} not supported"
            )));
        }
        let uncompressed_format = get_uncompressed_format(vk_format)
            .ok_or_else(|| TestError::Fail(format!("no decoder for compressed format {vk_format:?}")))?;

        let mut ref_texture = RefTexture2DArray::new(uncompressed_format, width, height, num_layers);
        let mut compressed_levels = Vec::with_capacity(level_data.len());
        for (level, data) in level_data.iter().enumerate() {
            ref_texture.alloc_level(level);
            if !decompress(&mut ref_texture.level_mut(level), vk_format, data) {
                return Err(TestError::Fail(format!(
                    "no decoder for compressed format {vk_format:?}"
                )));
            }
            compressed_levels.push(data.to_vec());
        }

        Ok(Self {
            gl,
            format: gl_format,
            ref_texture,
            gl_texture: Texture::new(gl),
            compressed_levels,
        })
    }

    pub fn ref_texture(&self) -> &RefTexture2DArray {
        &self.ref_texture
    }

    pub fn ref_texture_mut(&mut self) -> &mut RefTexture2DArray {
        &mut self.ref_texture
    }

    pub fn gl_texture(&self) -> glw::GLuint {
        self.gl_texture.get()
    }

    /// `Texture2DArray::upload` (non-compressed path only).
    ///
    /// # Safety
    /// A valid, current GL context and a `self.gl` whose entry points it loaded.
    pub unsafe fn upload(&self) -> Result<(), TestError> {
        debug_assert!(
            self.compressed_levels.is_empty(),
            "upload() on a texture built through new_compressed - call upload_compressed() instead"
        );
        let gl = self.gl;
        let transfer = get_transfer_format(self.ref_texture.format())?;
        let pixel_size = self
            .ref_texture
            .format()
            .pixel_size()
            .ok_or_else(|| TestError::Fail("texture format has no defined pixel size".into()))?;

        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.gl_texture.get());
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, compute_pixel_store(pixel_size));
            check_gl_error(gl, "Texture upload failed (bind/pixelStorei)")?;

            for level in 0..self.ref_texture.num_levels() {
                if self.ref_texture.is_level_empty(level) {
                    continue; // Don't upload.
                }
                let access = self.ref_texture.level(level);
                let size = access.size();
                gl.tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
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

    /// `Texture2DArray::loadCompressed`'s own upload half - see `glu::Texture2D::
    /// upload_compressed`'s doc comment for the shape this mirrors. One
    /// `glCompressedTexImage3D` call per level, covering every layer at once.
    ///
    /// # Safety
    /// A valid, current GL context and a `self.gl` whose entry points it loaded.
    pub unsafe fn upload_compressed(&self) -> Result<(), TestError> {
        debug_assert!(
            !self.compressed_levels.is_empty(),
            "upload_compressed() on a texture not built through new_compressed"
        );
        let gl = self.gl;
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.gl_texture.get());
            check_gl_error(gl, "Texture upload failed (bind)")?;

            for (level, data) in self.compressed_levels.iter().enumerate() {
                let access = self.ref_texture.level(level);
                let size = access.size();
                gl.compressed_tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    level as i32,
                    self.format,
                    size[0] as i32,
                    size[1] as i32,
                    size[2] as i32,
                    0,
                    data.len() as i32,
                    data.as_ptr().cast(),
                );
            }
            check_gl_error(gl, "Texture upload failed (compressedTexImage3D)")?;
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

    /// The array counterpart of `glu::texture_3d`'s own
    /// `texture3d_uploads_and_a_textured_quad_draw_reads_each_slice_back`: a 1x1-per-layer,
    /// 2-layer array with a distinct colour per layer, sampled through a real
    /// `sampler2DArray` draw and read back. Skips (prints, does not panic) with no live
    /// GL context, same established precedent.
    #[test]
    fn texture2darray_uploads_and_a_textured_quad_draw_reads_each_layer_back() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping texture2darray_uploads_and_a_textured_quad_draw_reads_each_layer_back: no live GL context available"
            );
            return;
        };
        let gl = context.functions();

        let mut tex = Texture2DArray::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 1, 1, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be a supported transfer format");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // layer 0: red
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // layer 1: blue
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let vertex_src = "#version 300 es\nin vec4 a_position;\nin vec3 a_texCoord;\nout vec3 v_texCoord;\nvoid main() {\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        let fragment_src = "#version 300 es\nprecision mediump float;\nprecision mediump sampler2DArray;\nin vec3 v_texCoord;\nuniform sampler2DArray u_sampler;\nout vec4 o_color;\nvoid main() {\n    o_color = texture(u_sampler, v_texCoord);\n}\n";
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
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, tex.gl_texture());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.uniform_1i(loc, 0);
        }

        // x=-1 (left) vertices get layer 0, x=+1 (right) vertices get layer 1.
        #[rustfmt::skip]
        let position: [f32; 12] = [
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ];
        #[rustfmt::skip]
        let texcoord: [f32; 18] = [
            0.5, 0.5, 0.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0,
            0.5, 0.5, 0.0, 0.5, 0.5, 1.0, 0.5, 0.5, 0.0,
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
            "left half should sample layer 0 (red)"
        );
        assert_eq!(
            access.get_pixel(3, 0, 0),
            [0.0, 0.0, 1.0, 1.0],
            "right half should sample layer 1 (blue)"
        );
    }

    /// `new_compressed`'s decode half, same oracle `glu::texture::tests` uses
    /// (`tcu::compressed_texture`'s own `etc2_zero_block_decodes_to_the_first_modifier`,
    /// `[2/255, 2/255, 2/255, 1.0]`) - two layers' worth of all-zero ETC2 blocks, laid
    /// out layer-major the way this module's own top doc comment says `decompress`'s
    /// `block_z` loop expects, must both decode to that same flat colour with no driver
    /// touched at all. `upload_compressed` then proves a real ES3 driver accepts the
    /// bytes this produced for a layered compressed upload - `glCompressedTexImage3D`
    /// erroring on a size/format mismatch here would mean the wiring is wrong, not the
    /// driver. Skips (prints, does not panic) with no live GL context or no ETC2 support,
    /// same established precedent as `glu::texture::tests`.
    #[test]
    fn new_compressed_decodes_known_zero_blocks_per_layer_and_uploads_them() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping new_compressed_decodes_known_zero_blocks_per_layer_and_uploads_them: no live GL context available"
            );
            return;
        };
        let gl = context.functions();
        let info = ContextInfo::create(gl);

        // 4x4 = one ETC2 block per layer, two layers, concatenated layer-major.
        let zero_blocks = [0u8; 8 * 2];
        let tex = match Texture2DArray::new_compressed(
            &context,
            &info,
            vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
            4,
            4,
            2,
            &[&zero_blocks],
        ) {
            Ok(tex) => tex,
            Err(TestError::NotSupported(reason)) => {
                eprintln!("skipping new_compressed_decodes_known_zero_blocks_per_layer_and_uploads_them: {reason}");
                return;
            }
            Err(e) => panic!("new_compressed failed: {e:?}"),
        };

        let expected = 2.0 / 255.0;
        let ref_access = tex.ref_texture().level(0);
        for layer in 0..2 {
            for y in 0..4 {
                for x in 0..4 {
                    assert_eq!(
                        ref_access.get_pixel(x, y, layer),
                        [expected, expected, expected, 1.0],
                        "ref_texture at ({x}, {y}, layer {layer})"
                    );
                }
            }
        }

        unsafe { tex.upload_compressed() }
            .expect("compressed array upload must succeed against a real ES3 driver's ETC2 decoder");
    }

    /// Same early-return shape as `glu::texture::tests::
    /// new_compressed_rejects_a_format_with_no_gl_mapping` - no GL call happens before
    /// the format-mapping check runs.
    #[test]
    fn new_compressed_rejects_a_format_with_no_gl_mapping() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping new_compressed_rejects_a_format_with_no_gl_mapping: no live GL context available");
            return;
        };
        let info = ContextInfo::create(context.functions());
        let block = [0u8; 8];
        let result =
            Texture2DArray::new_compressed(&context, &info, vk::Format::BC1_RGB_UNORM_BLOCK, 4, 4, 1, &[&block]);
        assert!(
            matches!(result, Err(TestError::Fail(_))),
            "BC1 has no GL enum: {:?}",
            result.err()
        );
    }
}
