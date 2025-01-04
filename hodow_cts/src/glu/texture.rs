// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTexture.hpp / .cpp  (glu::Texture2D, non-compressed path only)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glu::Texture2D` - a real GL texture object paired with a host-side mip-pyramid
// mirror (`tcu::texture_2d::Texture2D`) a test fills in, then uploads with one
// `upload()` call. It is the real-driver counterpart of `glu::texture_test_util`'s host-only
// reference sampler; together they are what the `texture.*` root
// (`dEQP-GLES2/3.functional.texture.{filtering,wrap,format,mipmap,size,specification,swizzle,units,
// vertex,shadow,compressed}`) needs on the real-texture-object side, and what `glsTextureTestUtil`'s own
// `TextureRenderer` (`gls::texture_test_util`, which needs a live driver the same way) builds on.
//
// Narrowed to exactly the slice a procedural (non-archive) 2D test needs, matching this
// project's own established narrowing conventions elsewhere (`sglr::ReferenceContext`'s
// `GL_TEXTURE_2D`-only texture objects, `glsInteractionTestUtil`'s dropped colour-mask
// vector type, ...):
//  - only the two non-compressed constructors (`Texture2D(context, format, dataType,
//    width, height)` and `Texture2D(context, internalFormat, width, height)`) at
//    first - the `create(..., archive, ...)` factory functions need upstream's
//    test-data archive, which this binary deliberately does not read (same reason
//    `shaders.struct.uniform.sampler*`/`shaders.discard.*_texture` stay excluded -
//    see `hodow_cts/src/gles2/functional/shader_struct_tests.rs`'s own doc comment).
//    The third, compressed-data constructor turned out *not* to share that
//    archive dependency - see the note below, added once that was confirmed - and is
//    ported as `new_compressed`,
//  - `upload()` only at first, no `loadCompressed` (now `upload_compressed`, see below),
//  - the `es2` sampling-behaviour flag `tcu::Texture2D::Texture2D` takes is dropped
//    entirely, matching `tcu::texture_2d::Texture2D`'s own narrowing (no sampling
//    methods at all - see that module's top doc comment for why) - nothing here reads
//    it.
//
// `ImmutableTexture2D` (the `glTexStorage2D`-based immutable-storage sibling) is not
// ported - no test reaches it yet.
//
// `new_compressed`/`upload_compressed` below close part of that narrowing: the third,
// compressed-data constructor (`Texture2D(context, contextInfo, numLevels, levels,
// decompressionParams)`) turned out *not* to need upstream's test-data archive at all -
// re-read directly against `gluTexture.cpp`, it only ever takes already-in-memory
// `tcu::CompressedTexture` objects; the archive dependency belongs solely to the
// `create(..., archive, levelFileNames)` factory this module still does not port. Folded
// with its own `loadCompressed` into one constructor (upstream's own ctor body calls
// `loadCompressed` unconditionally, so there is no intermediate "compressed but not yet
// loaded" state to preserve) plus a separate `upload_compressed` for the real
// `glCompressedTexImage2D` calls - two steps, matching every other constructor/`upload()`
// pair in this file, rather than upstream's single do-everything constructor. Each
// level's compressed bytes are a plain `&[u8]` rather than upstream's own
// `tcu::CompressedTexture` (not ported - see `tcu::compressed_texture`'s own top
// comment), and `TexDecompressionParams` is dropped entirely: `tcu::compressed_texture::
// decompress` takes none, there being no ASTC HDR/decode-mode axis anywhere in this port.

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
use crate::tcu::texture_2d::Texture2D as RefTexture2D;

/// `computePixelStore` - `GL_UNPACK_ALIGNMENT` for a tightly-packed row of this pixel
/// size: the largest power-of-two alignment the row start is guaranteed to already
/// satisfy, capped at GL's own maximum of 8, or 1 (no alignment guarantee at all) for a
/// pixel size that is not itself a power of two (e.g. 3-byte RGB8).
fn compute_pixel_store(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

/// `glu::Texture2D`, narrowed per this module's top doc comment.
pub struct Texture2D<'gl> {
    gl: &'gl glw::Functions,
    /// The GL format/internalformat this texture was constructed with - reused as the
    /// `internalformat` argument to every `glTexImage2D` call in `upload`, exactly as
    /// upstream's own `m_format` is.
    format: GLenum,
    ref_texture: RefTexture2D,
    gl_texture: Texture<'gl>,
    /// `Texture2D::m_isCompressed`. Empty for a texture built through `new`/`new_sized`;
    /// one entry per level, in level order, otherwise - holding exactly the bytes
    /// `upload_compressed` later hands to `glCompressedTexImage2D`. Kept alongside
    /// `ref_texture` (which only ever stores the *decompressed* reference pixels
    /// `new_compressed` wrote into it, never the original compressed bytes) because the
    /// real upload needs the compressed form again.
    compressed_levels: Vec<Vec<u8>>,
}

impl<'gl> Texture2D<'gl> {
    /// `Texture2D::Texture2D(context, format, dataType, width, height)` - an unsized
    /// `(format, type)` pair, e.g. `(GL_RGBA, GL_UNSIGNED_BYTE)`.
    pub fn new(
        context: &'gl RenderContext,
        format: GLenum,
        data_type: GLenum,
        width: u32,
        height: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_transfer_format(format, data_type)
            .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
        Ok(Self {
            gl: context.functions(),
            format,
            ref_texture: RefTexture2D::new(tex_format, width, height),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `Texture2D::Texture2D(context, sizedFormat, width, height)` - a sized internal
    /// format, e.g. `GL_RGBA8`.
    pub fn new_sized(
        context: &'gl RenderContext,
        sized_format: GLenum,
        width: u32,
        height: u32,
    ) -> Result<Self, TestError> {
        let tex_format = map_gl_internal_format(sized_format)
            .ok_or_else(|| TestError::Fail(format!("unsupported sized internal format {sized_format:#x}")))?;
        Ok(Self {
            gl: context.functions(),
            format: sized_format,
            ref_texture: RefTexture2D::new(tex_format, width, height),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `Texture2D::Texture2D(context, contextInfo, numLevels, levels, decompressionParams)`
    /// folded with `loadCompressed` - see this module's top doc comment for the full
    /// shape and what was narrowed. `level_data[n]` is level `n`'s raw compressed bytes;
    /// `width`/`height` are level 0's own size, exactly like the other two constructors.
    ///
    /// Decoding happens here, synchronously and without touching the driver at all - only
    /// `is_compressed_texture_format_supported` and `glGenTextures` (via `Texture::new`)
    /// reach `gl` before returning. The real `glCompressedTexImage2D` calls are
    /// `upload_compressed`'s job, matching every other constructor/`upload()` pair here.
    ///
    /// Upstream throws `NotSupportedError` when the driver has no compressed-format
    /// support and `InternalError` when a decoder is missing; both come back as
    /// `TestError::NotSupported`/`TestError::Fail` here respectively, following this
    /// crate's own `TestError` convention rather than upstream's exception hierarchy.
    pub fn new_compressed(
        context: &'gl RenderContext,
        info: &ContextInfo,
        vk_format: vk::Format,
        width: u32,
        height: u32,
        level_data: &[&[u8]],
    ) -> Result<Self, TestError> {
        Self::new_compressed_with_gl_format(context, info, vk_format, None, width, height, level_data)
    }

    /// `new_compressed` with the `glCompressedTexImage2D` enum given instead of derived from `vk_format`:
    /// `GL_ETC1_RGB8_OES` has no `vk::Format` of its own and is decoded as ETC2 RGB8 (see `glu::etc1`).
    #[allow(clippy::too_many_arguments)]
    pub fn new_compressed_with_gl_format(
        context: &'gl RenderContext,
        info: &ContextInfo,
        vk_format: vk::Format,
        gl_format_override: Option<GLenum>,
        width: u32,
        height: u32,
        level_data: &[&[u8]],
    ) -> Result<Self, TestError> {
        let gl = context.functions();
        let gl_format = gl_format_override
            .or_else(|| get_gl_format_for_compressed(vk_format))
            .ok_or_else(|| TestError::Fail(format!("no GL enum for compressed format {vk_format:?}")))?;
        if !info.is_compressed_texture_format_supported(gl, gl_format) {
            return Err(TestError::NotSupported(format!(
                "compressed texture format {gl_format:#x} not supported"
            )));
        }
        let uncompressed_format = get_uncompressed_format(vk_format)
            .ok_or_else(|| TestError::Fail(format!("no decoder for compressed format {vk_format:?}")))?;

        let mut ref_texture = RefTexture2D::new(uncompressed_format, width, height);
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

    pub fn ref_texture(&self) -> &RefTexture2D {
        &self.ref_texture
    }

    pub fn ref_texture_mut(&mut self) -> &mut RefTexture2D {
        &mut self.ref_texture
    }

    pub fn gl_texture(&self) -> glw::GLuint {
        self.gl_texture.get()
    }

    /// `Texture2D::upload` (non-compressed path only - see this module's top doc
    /// comment).
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
            gl.bind_texture(glw::GL_TEXTURE_2D, self.gl_texture.get());
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, compute_pixel_store(pixel_size));
            check_gl_error(gl, "Texture upload failed (bind/pixelStorei)")?;

            for level in 0..self.ref_texture.num_levels() {
                if self.ref_texture.is_level_empty(level) {
                    continue; // Don't upload.
                }
                let access = self.ref_texture.level(level);
                let size = access.size();
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    level as i32,
                    self.format as i32,
                    size[0] as i32,
                    size[1] as i32,
                    0, // border
                    transfer.format,
                    transfer.data_type,
                    access.raw().as_ptr().cast(),
                );
            }
            check_gl_error(gl, "Texture upload failed (texImage2D)")?;
        }
        Ok(())
    }

    /// `Texture2D::loadCompressed`'s own upload half - the decode half already ran in
    /// `new_compressed`. Uploads exactly the bytes that produced `ref_texture`'s own
    /// levels, so a driver that decodes them differently is what this exists to catch.
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
            gl.bind_texture(glw::GL_TEXTURE_2D, self.gl_texture.get());
            check_gl_error(gl, "Texture upload failed (bind)")?;

            for (level, data) in self.compressed_levels.iter().enumerate() {
                let access = self.ref_texture.level(level);
                let size = access.size();
                gl.compressed_tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    level as i32,
                    self.format,
                    size[0] as i32,
                    size[1] as i32,
                    0,
                    data.len() as i32,
                    data.as_ptr().cast(),
                );
            }
            check_gl_error(gl, "Texture upload failed (compressedTexImage2D)")?;
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

    #[test]
    fn pixel_store_alignment_matches_the_upstream_formula() {
        assert_eq!(compute_pixel_store(4), 4); // RGBA8: power of two, under the cap
        assert_eq!(compute_pixel_store(1), 1); // single-channel 8-bit
        assert_eq!(compute_pixel_store(2), 2); // RGB565/LA8
        assert_eq!(compute_pixel_store(8), 8); // RGBA16F
        assert_eq!(compute_pixel_store(16), 8); // RGBA32F: capped at GL's own maximum
        assert_eq!(compute_pixel_store(3), 1); // RGB8: not a power of two at all
        assert_eq!(compute_pixel_store(12), 1); // RGB32F: same
    }

    /// The first `#[test]` under `glu/` to touch a live driver - every other module
    /// here is exercised only through a registered dEQP case (see this crate's own
    /// established convention). `glu::Texture2D` has no architectural
    /// result a hand-computed value can check the way `tcu::texture_2d::Texture2D`'s
    /// own unit tests do above - its entire job is to hand bytes to a real driver - so
    /// the only genuine check is to actually do that: upload a tiny checkerboard,
    /// sample it back through a real textured-quad draw, and compare. Skips (prints
    /// and returns, does not panic) when no EGL/GL context is available at all, the
    /// same "no driver" shape `RenderContext::create` itself documents and every
    /// dEQP-case-driven test in this crate already handles via exit code 2 - a machine
    /// with no Mesa/EGL installed must still have `cargo test` report clean.
    #[test]
    fn texture2d_uploads_and_a_textured_quad_draw_reads_it_back() {
        let Ok(context) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping texture2d_uploads_and_a_textured_quad_draw_reads_it_back: no live GL context available"
            );
            return;
        };
        let gl = context.functions();

        let mut tex = Texture2D::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 2, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be a supported transfer format");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // texel (0,0): red
            level0.set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0); // texel (1,0): green
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 1, 0); // texel (0,1): blue
            level0.set_pixel([1.0, 1.0, 0.0, 1.0], 1, 1, 0); // texel (1,1): yellow
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let vertex_src = "attribute vec4 a_position;\nattribute vec2 a_texCoord;\nvarying vec2 v_texCoord;\nvoid main() {\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        let fragment_src = "precision mediump float;\nvarying vec2 v_texCoord;\nuniform sampler2D u_sampler;\nvoid main() {\n    gl_FragColor = texture2D(u_sampler, v_texCoord);\n}\n";
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
            gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.uniform_1i(loc, 0);
        }

        // Same full-screen-quad corner <-> texcoord pairing (and the same resulting
        // bottom-left/bottom-right/top-right/top-left <-> texel convention) as
        // `sglr::reference_context`'s own `drawing_a_textured_quad_samples_the_texture_during_fragment_shading`.
        #[rustfmt::skip]
        let position: [f32; 12] = [
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ];
        #[rustfmt::skip]
        let texcoord: [f32; 12] = [
            0.0, 0.0, 1.0, 0.0, 1.0, 1.0,
            0.0, 0.0, 1.0, 1.0, 0.0, 1.0,
        ];
        let bindings = [
            va::float("a_position", 2, 6, 0, &position),
            va::float("a_texCoord", 2, 6, 0, &texcoord),
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
            "bottom-left destination corner should read the texture's (0,0) (red) texel"
        );
        assert_eq!(
            access.get_pixel(3, 0, 0),
            [0.0, 1.0, 0.0, 1.0],
            "bottom-right destination corner should read the texture's (1,0) (green) texel"
        );
        assert_eq!(
            access.get_pixel(3, 3, 0),
            [1.0, 1.0, 0.0, 1.0],
            "top-right destination corner should read the texture's (1,1) (yellow) texel"
        );
        assert_eq!(
            access.get_pixel(0, 3, 0),
            [0.0, 0.0, 1.0, 1.0],
            "top-left destination corner should read the texture's (0,1) (blue) texel"
        );
    }

    /// No GL context is reached before the format-mapping check - `get_gl_format_for_compressed`
    /// runs first, so this proves the error path without needing a real driver that
    /// supports (or refuses) a format BC1-BC7 could never legally be, on any GLES
    /// context: those are desktop-only, per `tcu::compressed_texture`'s own top comment.
    #[test]
    fn new_compressed_rejects_a_format_with_no_gl_mapping() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping new_compressed_rejects_a_format_with_no_gl_mapping: no live GL context available");
            return;
        };
        let info = ContextInfo::create(context.functions());
        let block = [0u8; 8];
        let result = Texture2D::new_compressed(&context, &info, vk::Format::BC1_RGB_UNORM_BLOCK, 4, 4, &[&block]);
        assert!(
            matches!(result, Err(TestError::Fail(_))),
            "BC1 has no GL enum, so this must fail before ever reaching the driver: {:?}",
            result.err()
        );
    }

    /// End to end: an all-zero ETC2 block decodes to a known flat colour
    /// (`tcu::compressed_texture`'s own `etc2_zero_block_decodes_to_the_first_modifier`
    /// establishes `[2/255, 2/255, 2/255, 1.0]`) - `new_compressed` must reproduce
    /// exactly that in `ref_texture` with no driver involved at all, and
    /// `upload_compressed` must then get a *real* ES3 driver's own ETC2 decoder (ETC2 is
    /// core, unconditional, in every GLES 3.0 context) to agree when the same bytes are
    /// sampled back through an ordinary textured-quad draw - the same "upload, draw, read
    /// back" shape every other `glu::Texture*` test in this crate already uses, now
    /// proven for the compressed path this module's top doc comment describes wiring up.
    /// Skips (prints, does not panic) with no live GL context, same established
    /// precedent; also skips if the driver itself reports ETC2 unsupported (should not
    /// happen on a real ES3 context, but `is_compressed_texture_format_supported`'s own
    /// answer is what decides, not an assumption).
    #[test]
    fn new_compressed_decodes_known_zero_blocks_and_a_real_driver_agrees() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping new_compressed_decodes_known_zero_blocks_and_a_real_driver_agrees: no live GL context available"
            );
            return;
        };
        let gl = context.functions();
        let info = ContextInfo::create(gl);

        // 8x8 = four 4x4 ETC2 blocks, each the all-zero block.
        let zero_blocks = [0u8; 8 * 4];
        let tex = match Texture2D::new_compressed(
            &context,
            &info,
            vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
            8,
            8,
            &[&zero_blocks],
        ) {
            Ok(tex) => tex,
            Err(TestError::NotSupported(reason)) => {
                eprintln!("skipping new_compressed_decodes_known_zero_blocks_and_a_real_driver_agrees: {reason}");
                return;
            }
            Err(e) => panic!("new_compressed failed: {e:?}"),
        };

        let expected = 2.0 / 255.0;
        let ref_access = tex.ref_texture().level(0);
        for y in 0..8 {
            for x in 0..8 {
                assert_eq!(
                    ref_access.get_pixel(x, y, 0),
                    [expected, expected, expected, 1.0],
                    "ref_texture at ({x}, {y})"
                );
            }
        }

        unsafe { tex.upload_compressed() }
            .expect("compressed upload must succeed against a real ES3 driver's ETC2 decoder");

        let vertex_src = "#version 300 es\nin vec4 a_position;\nin vec2 a_texCoord;\nout vec2 v_texCoord;\nvoid main() {\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        let fragment_src = "#version 300 es\nprecision mediump float;\nin vec2 v_texCoord;\nuniform sampler2D u_sampler;\nout vec4 o_color;\nvoid main() {\n    o_color = texture(u_sampler, v_texCoord);\n}\n";
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
            gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.uniform_1i(loc, 0);
        }

        #[rustfmt::skip]
        let position: [f32; 12] = [
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ];
        #[rustfmt::skip]
        let texcoord: [f32; 12] = [
            0.0, 0.0, 1.0, 0.0, 1.0, 1.0,
            0.0, 0.0, 1.0, 1.0, 0.0, 1.0,
        ];
        let bindings = [
            va::float("a_position", 2, 6, 0, &position),
            va::float("a_texCoord", 2, 6, 0, &texcoord),
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
            [expected, expected, expected, 1.0],
            "a real driver's own ETC2 decode of the all-zero block must agree with tcu::compressed_texture's"
        );
        assert_eq!(access.get_pixel(3, 3, 0), [expected, expected, expected, 1.0]);
    }
}
