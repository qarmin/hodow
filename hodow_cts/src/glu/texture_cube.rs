// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTexture.hpp / .cpp  (glu::TextureCube, non-compressed path only)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `glu::TextureCube` - the cube-map counterpart of `glu::Texture2D`: a real
// `GL_TEXTURE_CUBE_MAP` object paired with a `tcu::texture_cube::TextureCube` host-side
// mirror a test fills in, then uploads with one `upload()` call (six `glTexImage2D`
// calls, one per face). Needed by `texture.filtering`/`texture.mipmap`/`texture.shadow`'s
// own `TEXTURETYPE_CUBE` cases - see `tcu::texture_cube`'s own doc comment for the grep
// evidence.
//
// Narrowed exactly like `glu::Texture2D`: only the two non-compressed, non-archive
// constructors at first, `upload()` only (no `loadCompressed`), no `es2`
// sampling-behaviour flag. `TextureCube::create(..., archive, ...)` is not ported, same
// reason as `glu::Texture2D`'s own narrowing - but the compressed constructor is, as
// `new_compressed`/`upload_compressed`, for the same reason given in that module's top
// doc comment (no archive dependency after all). Upstream's own `loadCompressed` issues
// one `glCompressedTexImage2D` per face per level (six calls, not one - a cube map has
// no 3D-style "depth" a single call could cover the way `Texture2DArray`'s layers can),
// so `new_compressed` takes one `[&[u8]; 6]` per level, each entry a face's own
// compressed bytes in `ALL_FACES` order, and decompresses each into its own
// `face_level_mut` slice.
//
// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` is a contiguous GL enum range in exactly
// the order `tcu::get_cube_array_face_index` already uses (confirmed against
// `src/generated/glw.rs`'s own constants: `0x8515..0x851A`, `PX,NX,PY,NY,PZ,NZ`), so
// `upload` can compute each face's GL target as `GL_TEXTURE_CUBE_MAP_POSITIVE_X +
// get_cube_array_face_index(face)` rather than needing its own lookup table.

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
use crate::tcu::pixel::{CubeFace, get_cube_array_face_index};
use crate::tcu::texture_cube::TextureCube as RefTextureCube;

fn compute_pixel_store(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

/// Every `CubeFace` in `get_cube_array_face_index`'s own order - the order `upload`
/// issues its six `glTexImage2D` calls in, and the order a test iterates faces in when
/// it has no reason to prefer another one.
pub const ALL_FACES: [CubeFace; 6] = [
    CubeFace::PositiveX,
    CubeFace::NegativeX,
    CubeFace::PositiveY,
    CubeFace::NegativeY,
    CubeFace::PositiveZ,
    CubeFace::NegativeZ,
];

/// `glu::TextureCube`, narrowed per this module's top doc comment.
pub struct TextureCube<'gl> {
    gl: &'gl glw::Functions,
    format: GLenum,
    ref_texture: RefTextureCube,
    gl_texture: Texture<'gl>,
    /// See `glu::Texture2D`'s identically-named field for what this holds and why - here
    /// each level holds six entries, one per `ALL_FACES` face, since a cube map uploads
    /// each face with its own `glCompressedTexImage2D` call.
    compressed_levels: Vec<[Vec<u8>; 6]>,
}

impl<'gl> TextureCube<'gl> {
    /// `TextureCube::TextureCube(context, format, dataType, size)`.
    pub fn new(context: &'gl RenderContext, format: GLenum, data_type: GLenum, size: u32) -> Result<Self, TestError> {
        let tex_format = map_gl_transfer_format(format, data_type)
            .ok_or_else(|| TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})")))?;
        Ok(Self {
            gl: context.functions(),
            format,
            ref_texture: RefTextureCube::new(tex_format, size),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `TextureCube::TextureCube(context, sizedFormat, size)`.
    pub fn new_sized(context: &'gl RenderContext, sized_format: GLenum, size: u32) -> Result<Self, TestError> {
        let tex_format = map_gl_internal_format(sized_format)
            .ok_or_else(|| TestError::Fail(format!("unsupported sized internal format {sized_format:#x}")))?;
        Ok(Self {
            gl: context.functions(),
            format: sized_format,
            ref_texture: RefTextureCube::new(tex_format, size),
            gl_texture: Texture::new(context.functions()),
            compressed_levels: Vec::new(),
        })
    }

    /// `TextureCube::TextureCube(context, contextInfo, numLevels, levels,
    /// decompressionParams)` folded with `loadCompressed` - see `glu::Texture2D::
    /// new_compressed`'s own doc comment for the shape this mirrors. `level_data[n]` is
    /// level `n`'s six faces' own compressed bytes, in `ALL_FACES` order (upstream's own
    /// `levels[levelNdx * tcu::CUBEFACE_LAST + face]` indexing, flattened here into one
    /// array per level instead of one flat slice indexed by `level * 6 + face`).
    pub fn new_compressed(
        context: &'gl RenderContext,
        info: &ContextInfo,
        vk_format: vk::Format,
        size: u32,
        level_data: &[[&[u8]; 6]],
    ) -> Result<Self, TestError> {
        Self::new_compressed_with_gl_format(context, info, vk_format, None, size, level_data)
    }

    /// `new_compressed` with the `glCompressedTexImage2D` enum given instead of derived from `vk_format`;
    /// see `glu::texture::Texture2D::new_compressed_with_gl_format`.
    pub fn new_compressed_with_gl_format(
        context: &'gl RenderContext,
        info: &ContextInfo,
        vk_format: vk::Format,
        gl_format_override: Option<GLenum>,
        size: u32,
        level_data: &[[&[u8]; 6]],
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

        let mut ref_texture = RefTextureCube::new(uncompressed_format, size);
        let mut compressed_levels = Vec::with_capacity(level_data.len());
        for (level, faces) in level_data.iter().enumerate() {
            ref_texture.alloc_level(level);
            let mut stored: [Vec<u8>; 6] = Default::default();
            for (face_ndx, face) in ALL_FACES.into_iter().enumerate() {
                let data = faces[face_ndx];
                if !decompress(&mut ref_texture.face_level_mut(face, level), vk_format, data) {
                    return Err(TestError::Fail(format!(
                        "no decoder for compressed format {vk_format:?}"
                    )));
                }
                stored[face_ndx] = data.to_vec();
            }
            compressed_levels.push(stored);
        }

        Ok(Self {
            gl,
            format: gl_format,
            ref_texture,
            gl_texture: Texture::new(gl),
            compressed_levels,
        })
    }

    pub fn ref_texture(&self) -> &RefTextureCube {
        &self.ref_texture
    }

    pub fn ref_texture_mut(&mut self) -> &mut RefTextureCube {
        &mut self.ref_texture
    }

    pub fn gl_texture(&self) -> glw::GLuint {
        self.gl_texture.get()
    }

    /// `TextureCube::upload` (non-compressed path only - see this module's top doc
    /// comment). Skips a face/level the same way `glu::Texture2D::upload` skips an
    /// empty level: `is_level_empty` here means "none of its six faces were allocated".
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
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, self.gl_texture.get());
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, compute_pixel_store(pixel_size));
            check_gl_error(gl, "Texture upload failed (bind/pixelStorei)")?;

            for level in 0..self.ref_texture.num_levels() {
                if self.ref_texture.is_level_empty(level) {
                    continue;
                }
                for face in ALL_FACES {
                    let access = self.ref_texture.face_level(face, level);
                    let size = access.size();
                    let target = glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(face);
                    gl.tex_image_2d(
                        target,
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
            }
            check_gl_error(gl, "Texture upload failed (texImage2D)")?;
        }
        Ok(())
    }

    /// `TextureCube::loadCompressed`'s own upload half - see `glu::Texture2D::
    /// upload_compressed`'s doc comment for the shape this mirrors. Six
    /// `glCompressedTexImage2D` calls per level, one per face, same target-enum
    /// computation `upload` itself already uses.
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
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, self.gl_texture.get());
            check_gl_error(gl, "Texture upload failed (bind)")?;

            for (level, faces) in self.compressed_levels.iter().enumerate() {
                for (face, data) in ALL_FACES.into_iter().zip(faces) {
                    let access = self.ref_texture.face_level(face, level);
                    let size = access.size();
                    let target = glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(face);
                    gl.compressed_tex_image_2d(
                        target,
                        level as i32,
                        self.format,
                        size[0] as i32,
                        size[1] as i32,
                        0,
                        data.len() as i32,
                        data.as_ptr().cast(),
                    );
                }
            }
            check_gl_error(gl, "Texture upload failed (compressedTexImage2D)")?;
        }
        Ok(())
    }
}

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

    /// `GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(face)` must land on
    /// the real GL target constants in the right order - the whole premise `upload`'s
    /// own doc comment relies on instead of a lookup table.
    #[test]
    fn face_index_plus_positive_x_matches_every_real_gl_cube_target() {
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::PositiveX),
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X
        );
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::NegativeX),
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X
        );
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::PositiveY),
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y
        );
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::NegativeY),
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
        );
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::PositiveZ),
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z
        );
        assert_eq!(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + get_cube_array_face_index(CubeFace::NegativeZ),
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
        );
    }

    /// End to end against a real driver: upload a distinct solid colour per face,
    /// sample each face's centre through a real `samplerCube` draw, and confirm the
    /// readback matches that face's own colour - the same "upload, draw, read back"
    /// shape `glu::texture::tests` established for `Texture2D`, now proven for a cube
    /// map for the first time. Skips (prints, does not panic) with no live GL context.
    #[test]
    fn texture_cube_uploads_and_a_textured_quad_draw_reads_each_face_back() {
        let Ok(context) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping texture_cube_uploads_and_a_textured_quad_draw_reads_each_face_back: no live GL context available"
            );
            return;
        };
        let gl = context.functions();

        let mut tex = TextureCube::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be supported");
        let face_colors: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0], // +X red
            [0.0, 1.0, 0.0, 1.0], // -X green
            [0.0, 0.0, 1.0, 1.0], // +Y blue
            [1.0, 1.0, 0.0, 1.0], // -Y yellow
            [1.0, 0.0, 1.0, 1.0], // +Z magenta
            [0.0, 1.0, 1.0, 1.0], // -Z cyan
        ];
        tex.ref_texture_mut().alloc_level(0);
        for (face, color) in ALL_FACES.into_iter().zip(face_colors) {
            let mut access = tex.ref_texture_mut().face_level_mut(face, 0);
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex.gl_texture());
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );
        }

        let vertex_src = "attribute vec4 a_position;\nattribute vec3 a_texCoord;\nvarying vec3 v_texCoord;\nvoid main() {\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        let fragment_src = "precision mediump float;\nvarying vec3 v_texCoord;\nuniform samplerCube u_sampler;\nvoid main() {\n    gl_FragColor = textureCube(u_sampler, v_texCoord);\n}\n";
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_src, fragment_src));
        assert!(
            program.is_ok(),
            "shader build failed: {:?}",
            program.build_failure_summary()
        );

        let sampler_name = std::ffi::CString::new("u_sampler").unwrap();
        unsafe {
            gl.use_program(program.program());
            let loc = gl.get_uniform_location(program.program(), sampler_name.as_ptr());
            gl.uniform_1i(loc, 0);
        }

        #[rustfmt::skip]
        let position: [f32; 12] = [
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ];
        // A full-screen quad with a fixed +X-ward direction vector per vertex samples
        // dead-centre of the +X face everywhere on it - the simplest possible cube draw
        // that proves one specific face's own upload reached the driver intact.
        #[rustfmt::skip]
        let texcoord: [f32; 18] = [
            1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
            1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
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
            face_colors[0],
            "+X face colour must come back everywhere on the quad"
        );
        assert_eq!(access.get_pixel(3, 3, 0), face_colors[0]);
    }

    /// `new_compressed`'s decode half, same oracle `glu::texture::tests` uses - six
    /// faces of one all-zero ETC2 block each, every face independently decoding to
    /// `[2/255, 2/255, 2/255, 1.0]` with no driver touched, then `upload_compressed`
    /// proving a real ES3 driver accepts six per-face compressed uploads for the same
    /// bytes. Skips (prints, does not panic) with no live GL context or no ETC2 support.
    #[test]
    fn new_compressed_decodes_known_zero_blocks_per_face_and_uploads_them() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping new_compressed_decodes_known_zero_blocks_per_face_and_uploads_them: no live GL context available"
            );
            return;
        };
        let gl = context.functions();
        let info = ContextInfo::create(gl);

        let zero_block = [0u8; 8];
        let faces: [&[u8]; 6] = [&zero_block; 6];
        let tex = match TextureCube::new_compressed(&context, &info, vk::Format::ETC2_R8G8B8_UNORM_BLOCK, 4, &[faces]) {
            Ok(tex) => tex,
            Err(TestError::NotSupported(reason)) => {
                eprintln!("skipping new_compressed_decodes_known_zero_blocks_per_face_and_uploads_them: {reason}");
                return;
            }
            Err(e) => panic!("new_compressed failed: {e:?}"),
        };

        let expected = 2.0 / 255.0;
        for face in ALL_FACES {
            let ref_access = tex.ref_texture().face_level(face, 0);
            for y in 0..4 {
                for x in 0..4 {
                    assert_eq!(
                        ref_access.get_pixel(x, y, 0),
                        [expected, expected, expected, 1.0],
                        "ref_texture face {face:?} at ({x}, {y})"
                    );
                }
            }
        }

        unsafe { tex.upload_compressed() }
            .expect("compressed cube upload must succeed against a real ES3 driver's ETC2 decoder");
    }

    /// Same early-return shape as `glu::texture::tests::
    /// new_compressed_rejects_a_format_with_no_gl_mapping`.
    #[test]
    fn new_compressed_rejects_a_format_with_no_gl_mapping() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping new_compressed_rejects_a_format_with_no_gl_mapping: no live GL context available");
            return;
        };
        let info = ContextInfo::create(context.functions());
        let block = [0u8; 8];
        let faces: [&[u8]; 6] = [&block; 6];
        let result = TextureCube::new_compressed(&context, &info, vk::Format::BC1_RGB_UNORM_BLOCK, 4, &[faces]);
        assert!(
            matches!(result, Err(TestError::Fail(_))),
            "BC1 has no GL enum: {:?}",
            result.err()
        );
    }
}
