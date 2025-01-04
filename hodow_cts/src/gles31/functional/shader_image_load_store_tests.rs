// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `store`, `load_store`, `format_reinterpret`, `qualifiers.restrict` and `image_size`
// sub-groups of each texture type are ported. What is left is `atomic` (and the
// `coherent`/`volatile` half of `qualifiers`) plus `early_fragment_tests`. Despite
// upstream including `glsTextureTestUtil.hpp`, nothing here samples a texture through a
// rasterised reference: the file uses that header for the `TextureType` enum alone, and
// its image comparisons are `tcu::intThresholdCompare`/`floatThresholdCompare` against a
// reference the test itself fills in on the host. Both comparators are already ported.

use std::collections::HashMap;
use std::ffi::CString;

use crate::gles31::functional::multisample_shader_render_case::glsl_version_decl;
use crate::glu::objects::BufferMemMap;
use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{
    self, ApiCase, Context, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case,
    get_program_interface_variable_info, get_program_resource_int, get_transfer_format,
};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, f32_to_f16_bits};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::UVec4;
use crate::tcu::{Random, TestError, de_string_hash, to_string_f32};

/// `glu::TextureTestUtil::TextureType`, the subset this family uses.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TextureType {
    Type2D,
    Cube,
    Type2DArray,
    Type3D,
    Buffer,
}

impl TextureType {
    /// The `imageType` name upstream registers the per-type group under.
    fn group_name(self) -> &'static str {
        match self {
            Self::Type2D => "2d",
            Self::Cube => "cube",
            Self::Type2DArray => "2d_array",
            Self::Type3D => "3d",
            Self::Buffer => "buffer",
        }
    }
}

/// `s_texBufExtString`
const TEX_BUF_EXT_STRING: &str = "GL_EXT_texture_buffer";

/// `supportsES32orGL45`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached and is not written out.
fn supports_es32(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

/// `checkTextureTypeExtensions`
fn check_texture_type_extensions(case: &mut ApiCase<'_>, texture_type: TextureType) -> bool {
    if texture_type == TextureType::Buffer
        && !case.context().context_info.is_extension_supported(TEX_BUF_EXT_STRING)
        && !supports_es32(case.context())
    {
        case.not_supported(format!("Test requires {TEX_BUF_EXT_STRING} extension"));
        return false;
    }
    true
}

/// `textureTypeExtensionShaderRequires`
fn texture_type_extension_shader_requires(texture_type: TextureType, context: &Context) -> String {
    if !supports_es32(context) && texture_type == TextureType::Buffer {
        format!("#extension {TEX_BUF_EXT_STRING} : require\n")
    } else {
        String::new()
    }
}

/// `getGLTextureTarget`
fn get_gl_texture_target(texture_type: TextureType) -> GLenum {
    match texture_type {
        TextureType::Buffer => glw::GL_TEXTURE_BUFFER,
        TextureType::Type2D => glw::GL_TEXTURE_2D,
        TextureType::Type3D => glw::GL_TEXTURE_3D,
        TextureType::Cube => glw::GL_TEXTURE_CUBE_MAP,
        TextureType::Type2DArray => glw::GL_TEXTURE_2D_ARRAY,
    }
}

/// `isFormatTypeUnsignedInteger`
fn is_format_type_unsigned_integer(type_: ChannelType) -> bool {
    matches!(
        type_,
        ChannelType::UNSIGNED_INT8 | ChannelType::UNSIGNED_INT16 | ChannelType::UNSIGNED_INT32
    )
}

/// `isFormatTypeSignedInteger`
fn is_format_type_signed_integer(type_: ChannelType) -> bool {
    matches!(
        type_,
        ChannelType::SIGNED_INT8 | ChannelType::SIGNED_INT16 | ChannelType::SIGNED_INT32
    )
}

/// `isFormatTypeInteger`
fn is_format_type_integer(type_: ChannelType) -> bool {
    is_format_type_unsigned_integer(type_) || is_format_type_signed_integer(type_)
}

/// `isFormatTypeUnorm`
fn is_format_type_unorm(type_: ChannelType) -> bool {
    matches!(
        type_,
        ChannelType::UNORM_INT8 | ChannelType::UNORM_INT16 | ChannelType::UNORM_INT32
    )
}

/// `isFormatTypeSnorm`
fn is_format_type_snorm(type_: ChannelType) -> bool {
    matches!(
        type_,
        ChannelType::SNORM_INT8 | ChannelType::SNORM_INT16 | ChannelType::SNORM_INT32
    )
}

/// `isFormatSupportedForTextureBuffer`
fn is_format_supported_for_texture_buffer(format: TextureFormat) -> bool {
    match format.order {
        ChannelOrder::RGB => matches!(
            format.type_,
            ChannelType::FLOAT | ChannelType::SIGNED_INT32 | ChannelType::UNSIGNED_INT32
        ),
        ChannelOrder::R | ChannelOrder::RG | ChannelOrder::RGBA => matches!(
            format.type_,
            ChannelType::UNORM_INT8
                | ChannelType::HALF_FLOAT
                | ChannelType::FLOAT
                | ChannelType::SIGNED_INT8
                | ChannelType::SIGNED_INT16
                | ChannelType::SIGNED_INT32
                | ChannelType::UNSIGNED_INT8
                | ChannelType::UNSIGNED_INT16
                | ChannelType::UNSIGNED_INT32
        ),
        _ => false,
    }
}

/// `defaultImageSize`
fn default_image_size(type_: TextureType) -> [i32; 3] {
    match type_ {
        TextureType::Buffer => [64, 1, 1],
        TextureType::Type2D | TextureType::Cube => [64, 64, 1],
        TextureType::Type3D | TextureType::Type2DArray => [64, 64, 8],
    }
}

/// `textureLayerType` - the type one layer of a multi-layer texture has.
fn texture_layer_type(entire_texture_type: TextureType) -> TextureType {
    match entire_texture_type {
        TextureType::Buffer | TextureType::Type2D => entire_texture_type,
        TextureType::Type3D | TextureType::Cube | TextureType::Type2DArray => TextureType::Type2D,
    }
}

/// `getShaderImageFormatQualifier`
fn get_shader_image_format_qualifier(format: TextureFormat) -> String {
    let order_part = match format.order {
        ChannelOrder::R => "r",
        ChannelOrder::RGBA => "rgba",
        other => panic!("{other:?} is not an image channel order"),
    };

    let type_part = match format.type_ {
        ChannelType::FLOAT => "32f",
        ChannelType::HALF_FLOAT => "16f",
        ChannelType::UNSIGNED_INT32 => "32ui",
        ChannelType::UNSIGNED_INT16 => "16ui",
        ChannelType::UNSIGNED_INT8 => "8ui",
        ChannelType::SIGNED_INT32 => "32i",
        ChannelType::SIGNED_INT16 => "16i",
        ChannelType::SIGNED_INT8 => "8i",
        ChannelType::UNORM_INT16 => "16",
        ChannelType::UNORM_INT8 => "8",
        ChannelType::SNORM_INT16 => "16_snorm",
        ChannelType::SNORM_INT8 => "8_snorm",
        other => panic!("{other:?} is not an image channel type"),
    };

    format!("{order_part}{type_part}")
}

/// `getShaderSamplerOrImageType`
fn get_shader_sampler_or_image_type(format_type: ChannelType, texture_type: TextureType, is_sampler: bool) -> String {
    let format_part = if is_format_type_unsigned_integer(format_type) {
        "u"
    } else if is_format_type_signed_integer(format_type) {
        "i"
    } else {
        ""
    };

    let image_type_part = match texture_type {
        TextureType::Buffer => "Buffer",
        TextureType::Type2D => "2D",
        TextureType::Type3D => "3D",
        TextureType::Cube => "Cube",
        TextureType::Type2DArray => "2DArray",
    };

    let kind = if is_sampler { "sampler" } else { "image" };
    format!("{format_part}{kind}{image_type_part}")
}

/// `getShaderImageType`
fn get_shader_image_type(format_type: ChannelType, image_type: TextureType) -> String {
    get_shader_sampler_or_image_type(format_type, image_type, false)
}

/// `getShaderSamplerType`
fn get_shader_sampler_type(format_type: ChannelType, image_type: TextureType) -> String {
    get_shader_sampler_or_image_type(format_type, image_type, true)
}

/// `glu::getInternalFormat`, restricted to the formats this family declares.
fn get_internal_format(format: TextureFormat) -> GLenum {
    match (format.order, format.type_) {
        (ChannelOrder::RGBA, ChannelType::FLOAT) => glw::GL_RGBA32F,
        (ChannelOrder::RGBA, ChannelType::HALF_FLOAT) => glw::GL_RGBA16F,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32) => glw::GL_RGBA32UI,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT16) => glw::GL_RGBA16UI,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8) => glw::GL_RGBA8UI,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT32) => glw::GL_RGBA32I,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT16) => glw::GL_RGBA16I,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT8) => glw::GL_RGBA8I,
        (ChannelOrder::RGBA, ChannelType::UNORM_INT8) => glw::GL_RGBA8,
        (ChannelOrder::RGBA, ChannelType::SNORM_INT8) => glw::GL_RGBA8_SNORM,
        (ChannelOrder::R, ChannelType::FLOAT) => glw::GL_R32F,
        (ChannelOrder::R, ChannelType::UNSIGNED_INT32) => glw::GL_R32UI,
        (ChannelOrder::R, ChannelType::SIGNED_INT32) => glw::GL_R32I,
        other => panic!("{other:?} has no internal format in this family's table"),
    }
}

/// `setTexParameteri`
///
/// # Safety
/// A current context, and `target` bound to the texture being set up.
unsafe fn set_tex_parameteri(gl: &glw::Functions, target: GLenum) {
    if target != glw::GL_TEXTURE_BUFFER {
        unsafe {
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        }
    }
}

/// `setTextureStorage`
///
/// # Safety
/// A current context, with the texture already bound to `imageType`'s target.
unsafe fn set_texture_storage(
    gl: &glw::Functions,
    image_type: TextureType,
    internal_format: GLenum,
    image_size: [i32; 3],
    texture_buf_gl: GLuint,
) {
    let texture_target = get_gl_texture_target(image_type);

    unsafe {
        match image_type {
            TextureType::Buffer => {
                let format = map_gl_internal_format(internal_format).expect("an internal format this family declares");
                let num_bytes =
                    i32::try_from(format.pixel_size().expect("a sized format")).unwrap_or(i32::MAX) * image_size[0];
                gl.bind_buffer(glw::GL_TEXTURE_BUFFER, texture_buf_gl);
                gl.buffer_data(
                    glw::GL_TEXTURE_BUFFER,
                    num_bytes as isize,
                    std::ptr::null(),
                    glw::GL_STATIC_DRAW,
                );
                gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, texture_buf_gl);
            }
            TextureType::Type2D | TextureType::Cube => {
                gl.tex_storage_2d(texture_target, 1, internal_format, image_size[0], image_size[1]);
            }
            TextureType::Type3D | TextureType::Type2DArray => {
                gl.tex_storage_3d(
                    texture_target,
                    1,
                    internal_format,
                    image_size[0],
                    image_size[1],
                    image_size[2],
                );
            }
        }
    }
}

/// `glslImageFuncZToCubeFace` - the `tcu::CubeFace` ordinal the GLSL cube-image z
/// coordinate names. GLSL numbers the layers +X, -X, +Y, -Y, +Z, -Z while `tcu::CubeFace`
/// counts -X, +X, -Y, +Y, -Z, +Z, so the two orders differ by a swap within each axis and
/// this is *not* the identity. Everything that indexes a cube face by a shader z
/// coordinate has to go through it; the upload path, which walks `tcu::CubeFace` order
/// directly, must not.
fn glsl_image_func_z_to_cube_face(z: i32) -> usize {
    const FACES: [usize; 6] = [
        CUBEFACE_POSITIVE_X,
        CUBEFACE_NEGATIVE_X,
        CUBEFACE_POSITIVE_Y,
        CUBEFACE_NEGATIVE_Y,
        CUBEFACE_POSITIVE_Z,
        CUBEFACE_NEGATIVE_Z,
    ];
    FACES[usize::try_from(z).expect("a cube face index")]
}

/// `tcu::CubeFace`, which the port has no enum for - the ordinal is the slice index a
/// `LayeredImage` stores that face in.
const CUBEFACE_NEGATIVE_X: usize = 0;
const CUBEFACE_POSITIVE_X: usize = 1;
const CUBEFACE_NEGATIVE_Y: usize = 2;
const CUBEFACE_POSITIVE_Y: usize = 3;
const CUBEFACE_NEGATIVE_Z: usize = 4;
const CUBEFACE_POSITIVE_Z: usize = 5;
const CUBEFACE_LAST: usize = 6;

/// `cubeFaceToGLFace`
fn cube_face_to_gl_face(face: usize) -> GLenum {
    match face {
        CUBEFACE_NEGATIVE_X => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        CUBEFACE_POSITIVE_X => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        CUBEFACE_NEGATIVE_Y => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        CUBEFACE_POSITIVE_Y => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        CUBEFACE_NEGATIVE_Z => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        CUBEFACE_POSITIVE_Z => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        other => panic!("{other} is not a cube face"),
    }
}

/// `glu::getCubeMapFaceName`, for the comparison description only.
fn cube_map_face_name(face: usize) -> &'static str {
    match face {
        CUBEFACE_NEGATIVE_X => "GL_TEXTURE_CUBE_MAP_NEGATIVE_X",
        CUBEFACE_POSITIVE_X => "GL_TEXTURE_CUBE_MAP_POSITIVE_X",
        CUBEFACE_NEGATIVE_Y => "GL_TEXTURE_CUBE_MAP_NEGATIVE_Y",
        CUBEFACE_POSITIVE_Y => "GL_TEXTURE_CUBE_MAP_POSITIVE_Y",
        CUBEFACE_NEGATIVE_Z => "GL_TEXTURE_CUBE_MAP_NEGATIVE_Z",
        CUBEFACE_POSITIVE_Z => "GL_TEXTURE_CUBE_MAP_POSITIVE_Z",
        other => panic!("{other} is not a cube face"),
    }
}

/// `computeQuadTexCoordCube`, the four corners of a full-face quad.
fn compute_quad_tex_coord_cube(face: usize) -> [f32; 12] {
    match face {
        CUBEFACE_NEGATIVE_X => [-1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0],
        CUBEFACE_POSITIVE_X => [1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0],
        CUBEFACE_NEGATIVE_Y => [-1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0],
        CUBEFACE_POSITIVE_Y => [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0],
        CUBEFACE_NEGATIVE_Z => [1.0, 1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0],
        CUBEFACE_POSITIVE_Z => [-1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0],
        other => panic!("{other} is not a cube face"),
    }
}

/// `UniformAccessLogger` - assigns a uniform by name, logging what it assigned, and
/// remembers the location it looked up.
struct UniformAccessLogger<'gl> {
    gl: &'gl glw::Functions,
    program_gl: GLuint,
    uniform_locations: HashMap<String, i32>,
}

impl<'gl> UniformAccessLogger<'gl> {
    fn new(gl: &'gl glw::Functions, program_gl: GLuint) -> Self {
        Self {
            gl,
            program_gl,
            uniform_locations: HashMap::new(),
        }
    }

    fn get_location(&mut self, name: &str) -> i32 {
        if let Some(&loc) = self.uniform_locations.get(name) {
            return loc;
        }
        let c_name = CString::new(name).expect("a uniform name with no interior nul");
        // SAFETY: a linked program of this case's own and a nul-terminated name.
        let loc = unsafe { self.gl.get_uniform_location(self.program_gl, c_name.as_ptr()) };
        self.uniform_locations.insert(name.to_string(), loc);
        loc
    }

    fn assign_1i(&mut self, name: &str, x: i32) {
        let loc = self.get_location(name);
        log::debug!("// Assigning to uniform {name}: {x}");
        // SAFETY: the program the location came from is the one in use.
        unsafe { self.gl.uniform_1i(loc, x) };
    }

    fn assign_3f(&mut self, name: &str, x: f32, y: f32, z: f32) {
        let loc = self.get_location(name);
        log::debug!("// Assigning to uniform {name}: ({x}, {y}, {z})");
        // SAFETY: the program the location came from is the one in use.
        unsafe { self.gl.uniform_3f(loc, x, y, z) };
    }
}

/// `LayeredImage` - a single-level texture of a given type, whose pixels are addressed
/// with the coordinate convention `imageStore()`/`imageLoad()` use.
///
/// Upstream holds one of five `tcu::Texture*` objects; one `TextureLevel` of depth
/// `numSlicesOrFaces` does the same job here, since every layer has the same size and
/// format. **A cube map's slice index is the `tcu::CubeFace` ordinal**, which is the order
/// the upload path walks; a shader z coordinate reaches it through
/// `glsl_image_func_z_to_cube_face` and the two differ.
struct LayeredImage {
    type_: TextureType,
    size: [i32; 3],
    format: TextureFormat,
    level: TextureLevel,
}

impl LayeredImage {
    fn new(type_: TextureType, format: TextureFormat, w: i32, h: i32, d: i32) -> Result<Self, TestError> {
        let num_slices_or_faces = if type_ == TextureType::Cube {
            CUBEFACE_LAST as i32
        } else {
            d
        };
        let level = TextureLevel::new(format, w as u32, h as u32, num_slices_or_faces as u32)?;
        Ok(Self {
            type_,
            size: [w, h, d],
            format,
            level,
        })
    }

    fn image_type(&self) -> TextureType {
        self.type_
    }

    fn size(&self) -> [i32; 3] {
        self.size
    }

    fn format(&self) -> TextureFormat {
        self.format
    }

    /// The slice a shader z coordinate lands in.
    fn storage_slice(&self, z: i32) -> u32 {
        if self.type_ == TextureType::Cube {
            glsl_image_func_z_to_cube_face(z) as u32
        } else {
            z as u32
        }
    }

    fn set_pixel(&mut self, x: i32, y: i32, z: i32, color: [f32; 4]) {
        let slice = self.storage_slice(z);
        self.level.get_access().set_pixel(color, x as u32, y as u32, slice);
    }

    fn set_pixel_int(&mut self, x: i32, y: i32, z: i32, color: [i32; 4]) {
        let slice = self.storage_slice(z);
        let stored = self.level.get_access().set_pixel_int(color, x as u32, y as u32, slice);
        debug_assert!(stored, "every format in this family is storable");
    }

    fn get_pixel(&self, x: i32, y: i32, z: i32) -> [f32; 4] {
        let slice = self.storage_slice(z);
        self.level.get_const_access().get_pixel(x as u32, y as u32, slice)
    }

    fn get_pixel_int(&self, x: i32, y: i32, z: i32) -> [i32; 4] {
        let slice = self.storage_slice(z);
        self.level.get_const_access().get_pixel_int(x as u32, y as u32, slice)
    }

    fn data(&self) -> &[u8] {
        self.level.data()
    }

    /// `getSliceAccess` / `getCubeFaceAccess` - both index the storage directly.
    fn slice_access(&self, slice: usize) -> ConstPixelBufferAccess<'_> {
        let (off, len) = self.slice_range(slice);
        let size = [self.size[0] as u32, self.size[1] as u32, 1];
        ConstPixelBufferAccess::new(self.format, size, &self.level.data()[off..off + len])
    }

    fn slice_bytes_mut(&mut self, slice: usize) -> &mut [u8] {
        let (off, len) = self.slice_range(slice);
        &mut self.level.data_mut()[off..off + len]
    }

    fn slice_range(&self, slice: usize) -> (usize, usize) {
        let pixel_size = self.format.pixel_size().expect("a sized format") as usize;
        let len = self.size[0] as usize * self.size[1] as usize * pixel_size;
        (slice * len, len)
    }
}

/// `uploadTexture`
///
/// # Safety
/// A current context, with the destination texture bound to its own target.
unsafe fn upload_texture(gl: &glw::Functions, src: &LayeredImage, texture_buf_gl: GLuint) -> Result<(), TestError> {
    let internal_format = get_internal_format(src.format());
    let transfer_format = get_transfer_format(src.format())?;
    let image_size = src.size();

    // SAFETY: the caller's texture is bound, and every pointer below is into `src`'s own
    // tightly-packed level data, whose length matches the region being uploaded.
    unsafe {
        set_texture_storage(gl, src.image_type(), internal_format, image_size, texture_buf_gl);

        {
            let pixel_size = src.format().pixel_size().expect("a sized format");
            let unpack_alignment = if pixel_size.is_power_of_two() { 8 } else { 1 };
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, unpack_alignment);
        }

        match src.image_type() {
            TextureType::Buffer => {
                gl.bind_buffer(glw::GL_TEXTURE_BUFFER, texture_buf_gl);
                gl.buffer_data(
                    glw::GL_TEXTURE_BUFFER,
                    src.data().len() as isize,
                    src.data().as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }
            TextureType::Type2D => gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                image_size[0],
                image_size[1],
                transfer_format.format,
                transfer_format.data_type,
                src.data().as_ptr().cast(),
            ),
            TextureType::Cube => {
                for face in 0..CUBEFACE_LAST {
                    gl.tex_sub_image_2d(
                        cube_face_to_gl_face(face),
                        0,
                        0,
                        0,
                        image_size[0],
                        image_size[1],
                        transfer_format.format,
                        transfer_format.data_type,
                        src.slice_access(face).raw().as_ptr().cast(),
                    );
                }
            }
            TextureType::Type3D | TextureType::Type2DArray => {
                gl.tex_sub_image_3d(
                    get_gl_texture_target(src.image_type()),
                    0,
                    0,
                    0,
                    0,
                    image_size[0],
                    image_size[1],
                    image_size[2],
                    transfer_format.format,
                    transfer_format.data_type,
                    src.data().as_ptr().cast(),
                );
            }
        }
    }

    Ok(())
}

/// `readPixelsRGBAInteger32`
///
/// # Safety
/// A current context with a complete framebuffer bound.
unsafe fn read_pixels_rgba_integer32(gl: &glw::Functions, dst: &mut TextureLevel, origin_x: i32, origin_y: i32) {
    let size = dst.size();
    let (width, height) = (size[0], size[1]);
    let is_unsigned = is_format_type_unsigned_integer(dst.format().type_);
    let mut data = vec![[0i32; 4]; (width * height) as usize];
    let gl_type = if is_unsigned { glw::GL_UNSIGNED_INT } else { glw::GL_INT };

    // SAFETY: the buffer holds exactly width*height four-component 32-bit pixels, which
    // is what both GL_UNSIGNED_INT and GL_INT write there.
    unsafe {
        gl.read_pixels(
            origin_x,
            origin_y,
            width as i32,
            height as i32,
            glw::GL_RGBA_INTEGER,
            gl_type,
            data.as_mut_ptr().cast(),
        );
    }

    let mut access = dst.get_access();
    for y in 0..height {
        for x in 0..width {
            // Upstream's `setPixel(UVec4)` casts straight to `IVec4`, so an unsigned value
            // above 2^31 takes the same path here as it does there.
            let stored = access.set_pixel_int(data[(y * width + x) as usize], x, y, 0);
            debug_assert!(stored, "a 32-bit integer format is storable");
        }
    }
}

/// `ImageLayerVerifier` - a functor for verifying one 2d layer of a result texture.
trait ImageLayerVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool;
}

/// `R32UIImageSingleValueVerifier`
struct R32UIImageSingleValueVerifier {
    min: u32,
    max: u32,
}

impl R32UIImageSingleValueVerifier {
    fn exactly(value: u32) -> Self {
        Self { min: value, max: value }
    }
}

impl ImageLayerVerifier for R32UIImageSingleValueVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, _slice_or_face_ndx: i32) -> bool {
        if self.min == self.max {
            log::debug!("// Note: expecting to get value {}", self.min);
        } else {
            log::debug!("// Note: expecting to get value in range [{}, {}]", self.min, self.max);
        }

        let value = result_slice.get_pixel_int(0, 0, 0)[0] as u32;
        if (self.min..=self.max).contains(&value) {
            log::debug!("// Success: got value {value}");
            true
        } else {
            log::warn!("// Failure: got value {value}");
            false
        }
    }
}

/// `ImageLayerComparer` - compares each result slice against the same slice of a
/// reference image.
struct ImageLayerComparer<'a> {
    reference: &'a LayeredImage,
    /// `m_relevantRegion` - only this corner of each slice is checked.
    relevant_region: [u32; 2],
}

impl<'a> ImageLayerComparer<'a> {
    fn new(reference: &'a LayeredImage) -> Self {
        let size = reference.size();
        Self {
            reference,
            relevant_region: [size[0] as u32, size[1] as u32],
        }
    }
}

impl ImageLayerVerifier for ImageLayerComparer<'_> {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool {
        let is_cube = self.reference.image_type() == TextureType::Cube;
        let storage_slice = if is_cube {
            glsl_image_func_z_to_cube_face(slice_or_face_ndx)
        } else {
            slice_or_face_ndx as usize
        };
        let reference_slice = self.reference.slice_access(storage_slice);
        let reference_region =
            reference_slice.get_subregion(0, 0, 0, self.relevant_region[0], self.relevant_region[1], 1);
        let result_region = result_slice.get_subregion(0, 0, 0, self.relevant_region[0], self.relevant_region[1], 1);

        let comparison_desc = if is_cube {
            format!("Image Comparison, face {}", cube_map_face_name(storage_slice))
        } else {
            format!("Image Comparison, slice {slice_or_face_ndx}")
        };

        if is_format_type_integer(self.reference.format().type_) {
            let result = int_threshold_compare(&reference_region, &result_region, UVec4::from_array([0; 4]));
            if !result.ok {
                log::warn!(
                    "// Failure: {comparison_desc}, max difference {:?}",
                    result.max_diff.m_data
                );
            }
            result.ok
        } else {
            let result = float_threshold_compare(&reference_region, &result_region, [0.01; 4]);
            if !result.ok {
                log::warn!("// Failure: {comparison_desc}, max difference {:?}", result.max_diff);
            }
            result.ok
        }
    }
}

/// `readIntegerTextureViaFBOAndVerify`
///
/// Binds the texture one layer at a time to an FBO colour attachment and reads it back
/// with `glReadPixels`. Not for buffer textures - upstream asserts the same.
fn read_integer_texture_via_fbo_and_verify(
    case: &mut ApiCase<'_>,
    texture_gl: GLuint,
    texture_type: TextureType,
    texture_format: TextureFormat,
    texture_size: [i32; 3],
    verify_layer: &dyn ImageLayerVerifier,
) -> bool {
    let gl = case.gl();
    let num_slices_or_faces = if texture_type == TextureType::Cube {
        6
    } else {
        texture_size[2]
    };
    let texture_target_gl = get_gl_texture_target(texture_type);
    let fbo = glu::Framebuffer::new(gl);

    let mut result_slice = match TextureLevel::new(texture_format, texture_size[0] as u32, texture_size[1] as u32, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Image verification failed");
            return false;
        }
    };

    // SAFETY: names this function owns or the case created, and a complete framebuffer is
    // checked for before every read.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        // The compute shader wrote through an image binding, so its stores are only
        // visible to the framebuffer read after this barrier.
        gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT);
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, texture_gl);
        set_tex_parameteri(gl, texture_target_gl);

        for slice_or_face_ndx in 0..num_slices_or_faces {
            match texture_type {
                TextureType::Cube => gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    cube_face_to_gl_face(glsl_image_func_z_to_cube_face(slice_or_face_ndx)),
                    texture_gl,
                    0,
                ),
                TextureType::Type2D => gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    texture_gl,
                    0,
                ),
                TextureType::Type3D | TextureType::Type2DArray => {
                    gl.framebuffer_texture_layer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        texture_gl,
                        0,
                        slice_or_face_ndx,
                    );
                }
                TextureType::Buffer => unreachable!("buffer textures cannot be attached to a framebuffer"),
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                case.fail("framebuffer is not complete".to_string(), "Image verification failed");
                return false;
            }

            read_pixels_rgba_integer32(gl, &mut result_slice, 0, 0);

            if !verify_layer.verify(&result_slice.get_const_access(), slice_or_face_ndx) {
                return false;
            }
        }
    }

    true
}

/// `readFloatOrNormTextureWithLookupsAndVerify`
///
/// Reads the texture with `texture()` in a compute shader, one layer at a time, putting
/// the values into an SSBO and reading that back with a mapping. Not for buffer textures -
/// upstream asserts the same.
fn read_float_or_norm_texture_with_lookups_and_verify(
    case: &mut ApiCase<'_>,
    texture_gl: GLuint,
    texture_type: TextureType,
    texture_format: TextureFormat,
    texture_size: [i32; 3],
    verify_layer: &dyn ImageLayerVerifier,
) -> bool {
    let context = case.context();
    let gl = case.gl();
    let sampler_type = get_shader_sampler_type(texture_format.type_, texture_type);
    let num_texels = texture_size[0] * texture_size[1];
    let width = texture_size[0];
    // A cube face is square, so its t divisor is the face's width and not the logical
    // depth the other types use.
    let t_divisor = if texture_type == TextureType::Cube {
        texture_size[0]
    } else {
        texture_size[1]
    };
    let coord_swizzle = if texture_type == TextureType::Type2D { ".xy" } else { "" };

    let source = format!(
        "{version}\n\
         layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
         layout (binding = 0) buffer Output\n\
         {{\n\
         \x20   vec4 color[{num_texels}];\n\
         }} sb_out;\n\
         \n\
         precision highp {sampler_type};\n\
         \n\
         uniform highp {sampler_type} u_texture;\n\
         uniform highp vec3 u_texCoordLD;\n\
         uniform highp vec3 u_texCoordRD;\n\
         uniform highp vec3 u_texCoordLU;\n\
         uniform highp vec3 u_texCoordRU;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   int gx = int(gl_GlobalInvocationID.x);\n\
         \x20   int gy = int(gl_GlobalInvocationID.y);\n\
         \x20   highp float s = (float(gx) + 0.5) / float({width});\n\
         \x20   highp float t = (float(gy) + 0.5) / float({t_divisor});\n\
         \x20   highp vec3 texCoord = u_texCoordLD*(1.0-s)*(1.0-t)\n\
         \x20                       + u_texCoordRD*(    s)*(1.0-t)\n\
         \x20                       + u_texCoordLU*(1.0-s)*(    t)\n\
         \x20                       + u_texCoordRU*(    s)*(    t);\n\
         \x20   int ndx = gy*{width} + gx;\n\
         \x20   sb_out.color[ndx] = texture(u_texture, texCoord{coord_swizzle});\n\
         }}\n",
        version = glsl_version_decl(context),
    );

    let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
    if !program.is_ok() {
        case.fail("failed to compile program".to_string(), "Program compilation failed");
        return false;
    }

    let texture_target_gl = get_gl_texture_target(texture_type);
    let output_buffer = glu::Buffer::new(gl);
    let mut uniforms = UniformAccessLogger::new(gl, program.program());

    // SAFETY: a linked program, the caller's texture and this function's own buffer.
    unsafe {
        gl.use_program(program.program());
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, texture_gl);
        set_tex_parameteri(gl, texture_target_gl);
    }

    uniforms.assign_1i("u_texture", 0);

    // Setup output buffer.
    let (block_size, value_info) = {
        // SAFETY: a linked program and a nul-terminated resource name.
        let block_index = unsafe {
            gl.get_program_resource_index(program.program(), glw::GL_SHADER_STORAGE_BLOCK, c"Output".as_ptr())
        };
        let block_size = match get_program_resource_int(
            gl,
            program.program(),
            glw::GL_SHADER_STORAGE_BLOCK,
            block_index,
            glw::GL_BUFFER_DATA_SIZE,
        ) {
            Ok(size) => size,
            Err(e) => {
                case.fail(e.to_string(), "Image verification failed");
                return false;
            }
        };

        log::debug!("// Got buffer data size = {block_size}");
        if block_size <= 0 {
            case.fail("the output block has no size".to_string(), "Image verification failed");
            return false;
        }

        // SAFETY: a nul-terminated resource name and a linked program.
        let value_index = unsafe {
            gl.get_program_resource_index(program.program(), glw::GL_BUFFER_VARIABLE, c"Output.color".as_ptr())
        };
        let value_info =
            match get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index) {
                Ok(info) => info,
                Err(e) => {
                    case.fail(e.to_string(), "Image verification failed");
                    return false;
                }
            };

        if value_info.array_size != num_texels as GLuint {
            case.fail(
                format!(
                    "Output.color has {} elements, expected {num_texels}",
                    value_info.array_size
                ),
                "Image verification failed",
            );
            return false;
        }

        // SAFETY: the buffer is this function's own and the size is the driver's answer.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                block_size as isize,
                std::ptr::null(),
                glw::GL_STREAM_READ,
            );
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
        }
        if let Err(e) = glu::expect_no_error(gl, "SSB setup failed") {
            case.fail(e.to_string(), "Image verification failed");
            return false;
        }

        (block_size, value_info)
    };

    // Dispatch one layer at a time, read back and verify.
    let num_slices_or_faces = if texture_type == TextureType::Cube {
        6
    } else {
        texture_size[2]
    };
    let mut result_slice = match TextureLevel::new(texture_format, texture_size[0] as u32, texture_size[1] as u32, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Image verification failed");
            return false;
        }
    };

    // SAFETY: the image stores are only visible to a texture fetch after this barrier.
    unsafe { gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT) };

    for slice_or_face_ndx in 0..num_slices_or_faces {
        if texture_type == TextureType::Cube {
            let coords = compute_quad_tex_coord_cube(glsl_image_func_z_to_cube_face(slice_or_face_ndx));
            uniforms.assign_3f("u_texCoordLD", coords[0], coords[1], coords[2]);
            uniforms.assign_3f("u_texCoordRD", coords[6], coords[7], coords[8]);
            uniforms.assign_3f("u_texCoordLU", coords[3], coords[4], coords[5]);
            uniforms.assign_3f("u_texCoordRU", coords[9], coords[10], coords[11]);
        } else {
            let z = if texture_type == TextureType::Type3D {
                (slice_or_face_ndx as f32 + 0.5) / num_slices_or_faces as f32
            } else {
                slice_or_face_ndx as f32
            };
            uniforms.assign_3f("u_texCoordLD", 0.0, 0.0, z);
            uniforms.assign_3f("u_texCoordRD", 1.0, 0.0, z);
            uniforms.assign_3f("u_texCoordLU", 0.0, 1.0, z);
            uniforms.assign_3f("u_texCoordRU", 1.0, 1.0, z);
        }

        // SAFETY: the program is in use and the SSBO is bound to binding point 0.
        unsafe { gl.dispatch_compute(texture_size[0] as GLuint, texture_size[1] as GLuint, 1) };

        {
            log::debug!("// Note: mapping buffer and reading color values written");

            let Some(buf_map) = BufferMemMap::new(
                gl,
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                block_size as isize,
                glw::GL_MAP_READ_BIT,
            ) else {
                case.fail(
                    "glMapBufferRange() returned null".to_string(),
                    "Image verification failed",
                );
                return false;
            };
            // SAFETY: the driver mapped `block_size` bytes at this address and the map
            // outlives the slice.
            let mapped = unsafe { std::slice::from_raw_parts(buf_map.get().cast::<u8>(), block_size as usize) };

            let mut access = result_slice.get_access();
            for y in 0..texture_size[1] {
                for x in 0..texture_size[0] {
                    let ndx = y * texture_size[0] + x;
                    let offset = value_info.offset as usize + value_info.array_stride as usize * ndx as usize;
                    let read = |c: usize| {
                        f32::from_ne_bytes(
                            mapped[offset + 4 * c..offset + 4 * c + 4]
                                .try_into()
                                .expect("four bytes"),
                        )
                    };

                    let color = match texture_format.order {
                        ChannelOrder::R => [read(0); 4],
                        ChannelOrder::RGBA => [read(0), read(1), read(2), read(3)],
                        other => panic!("{other:?} is not a format order this family reads back"),
                    };
                    access.set_pixel(color, x as u32, y as u32, 0);
                }
            }
        }

        if !verify_layer.verify(&result_slice.get_const_access(), slice_or_face_ndx) {
            return false;
        }
    }

    true
}

/// `readBufferTextureWithMappingAndVerify` - reads a buffer texture by mapping the
/// buffer behind it.
fn read_buffer_texture_with_mapping_and_verify(
    case: &mut ApiCase<'_>,
    buffer_gl: GLuint,
    texture_format: TextureFormat,
    image_size: i32,
    verify_layer: &dyn ImageLayerVerifier,
) -> bool {
    let gl = case.gl();
    let mut result = match TextureLevel::new(texture_format, image_size as u32, 1, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Image verification failed");
            return false;
        }
    };
    let data_size = image_size * texture_format.pixel_size().expect("a sized format") as i32;

    // SAFETY: the buffer is one the case created.
    unsafe { gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer_gl) };

    {
        let Some(buf_map) = BufferMemMap::new(gl, glw::GL_TEXTURE_BUFFER, 0, data_size as isize, glw::GL_MAP_READ_BIT)
        else {
            case.fail(
                "glMapBufferRange() returned null".to_string(),
                "Image verification failed",
            );
            return false;
        };
        // SAFETY: the driver mapped `data_size` bytes at this address and the map outlives
        // the copy.
        let mapped = unsafe { std::slice::from_raw_parts(buf_map.get().cast::<u8>(), data_size as usize) };
        result.data_mut()[..data_size as usize].copy_from_slice(mapped);
    }

    verify_layer.verify(&result.get_const_access(), 0)
}

/// `readTextureAndVerify` - picks the reader the texture's format and type call for.
fn read_texture_and_verify(
    case: &mut ApiCase<'_>,
    texture_gl: GLuint,
    buffer_gl: GLuint,
    texture_type: TextureType,
    texture_format: TextureFormat,
    image_size: [i32; 3],
    verify_layer: &dyn ImageLayerVerifier,
) -> bool {
    if texture_type == TextureType::Buffer {
        read_buffer_texture_with_mapping_and_verify(case, buffer_gl, texture_format, image_size[0], verify_layer)
    } else if is_format_type_integer(texture_format.type_) {
        read_integer_texture_via_fbo_and_verify(
            case,
            texture_gl,
            texture_type,
            texture_format,
            image_size,
            verify_layer,
        )
    } else {
        read_float_or_norm_texture_with_lookups_and_verify(
            case,
            texture_gl,
            texture_type,
            texture_format,
            image_size,
            verify_layer,
        )
    }
}

/// `ImageSizeCase::ImageAccess`
///
/// clippy refuses upstream's shared `*Only` suffix (`enum_variant_names`); the variants
/// are `IMAGEACCESS_READ_ONLY` / `_WRITE_ONLY` / `_READ_ONLY_WRITE_ONLY` upstream.
#[derive(Clone, Copy)]
#[allow(clippy::enum_variant_names)]
enum ImageAccess {
    ReadOnly,
    WriteOnly,
    ReadOnlyWriteOnly,
}

impl ImageAccess {
    /// The memory qualifiers it puts on the image uniform.
    fn shader_qualifier(self) -> &'static str {
        match self {
            Self::ReadOnly => "readonly",
            Self::WriteOnly => "writeonly",
            Self::ReadOnlyWriteOnly => "readonly writeonly",
        }
    }

    /// The name part upstream builds the case name from.
    fn name(self) -> &'static str {
        match self {
            Self::ReadOnly => "readonly",
            Self::WriteOnly => "writeonly",
            Self::ReadOnlyWriteOnly => "readonly_writeonly",
        }
    }
}

/// `ImageSizeCase::iterate`
///
/// Tests the `imageSize()` GLSL function. The result is packed into one integer and stored
/// in a 1x1 R32UI image; the image `imageSize()` is called on is never read or written, so
/// this says nothing about the image's contents.
fn image_size_case(
    case: &mut ApiCase<'_>,
    format: TextureFormat,
    image_type: TextureType,
    image_size: [i32; 3],
    image_access: ImageAccess,
) {
    if !check_texture_type_extensions(case, image_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let internal_format_gl = get_internal_format(format);
    let texture_target_gl = get_gl_texture_target(image_type);

    let main_texture_buf = glu::Buffer::new(gl);
    let main_texture = glu::Texture::new(gl);
    let shader_out_result_texture = glu::Texture::new(gl);

    // SAFETY: every name below is one this function just created.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, main_texture.get());
        set_tex_parameteri(gl, texture_target_gl);
        set_texture_storage(gl, image_type, internal_format_gl, image_size, main_texture_buf.get());
        gl.bind_image_texture(
            0,
            main_texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_WRITE,
            internal_format_gl,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }

        gl.active_texture(glw::GL_TEXTURE1);
        gl.bind_texture(glw::GL_TEXTURE_2D, shader_out_result_texture.get());
        set_tex_parameteri(gl, glw::GL_TEXTURE_2D);
        set_texture_storage(gl, TextureType::Type2D, glw::GL_R32UI, [1, 1, 1], 0);
        gl.bind_image_texture(
            1,
            shader_out_result_texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_R32UI,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }
    }

    // Read texture size in compute shader.
    {
        let shader_image_format_str = get_shader_image_format_qualifier(format);
        let shader_image_type_str = get_shader_image_type(format.type_, image_type);
        let size_expression = match image_type {
            TextureType::Buffer => "\tint result = imageSize(u_image);\n".to_string(),
            TextureType::Type2D | TextureType::Cube => {
                "\tivec2 size = imageSize(u_image);\n\tint result = size.y*1000 + size.x;\n".to_string()
            }
            TextureType::Type3D | TextureType::Type2DArray => {
                "\tivec3 size = imageSize(u_image);\n\tint result = size.z*1000000 + size.y*1000 + size.x;\n"
                    .to_string()
            }
        };

        let source = format!(
            "{}\n{}\nprecision highp {shader_image_type_str};\n\
             precision highp uimage2D;\n\
             \n\
             layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
             layout ({shader_image_format_str}, binding=0) {} uniform {shader_image_type_str} u_image;\n\
             layout (r32ui, binding=1) writeonly uniform uimage2D u_result;\n\
             void main (void)\n\
             {{\n\
             {size_expression}\
             \timageStore(u_result, ivec2(0, 0), uvec4(result));\n\
             }}\n",
            glsl_version_decl(context),
            texture_type_extension_shader_requires(image_type, context),
            image_access.shader_qualifier()
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // SAFETY: a program that linked, and the image bindings set up above.
        unsafe {
            gl.use_program(program.program());
            gl.dispatch_compute(1, 1, 1);
            if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                case.fail(e.to_string(), "glDispatchCompute failed");
                return;
            }
        }
    }

    // Read texture and compare to reference.
    let reference_output = match image_type {
        TextureType::Buffer => image_size[0] as u32,
        TextureType::Type2D | TextureType::Cube => (image_size[1] * 1000 + image_size[0]) as u32,
        TextureType::Type3D | TextureType::Type2DArray => {
            (image_size[2] * 1000000 + image_size[1] * 1000 + image_size[0]) as u32
        }
    };

    let verifier = R32UIImageSingleValueVerifier::exactly(reference_output);
    let result_format = TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32);
    if !read_integer_texture_via_fbo_and_verify(
        case,
        shader_out_result_texture.get(),
        TextureType::Type2D,
        result_format,
        [1, 1, 1],
        &verifier,
    ) {
        case.fail("Image comparison failed".to_string(), "Image comparison failed");
    }
}

/// `ShaderImageLoadStoreTests::init`'s `imageSize()` cases, for one texture type.
fn image_size_group(image_type: TextureType) -> TestCaseGroup {
    /// `baseImageSizes`
    const BASE_IMAGE_SIZES: [[i32; 3]; 4] = [[32, 32, 32], [12, 34, 56], [1, 1, 1], [7, 1, 1]];

    let mut group = TestCaseGroup::new("image_size");

    for image_access in [
        ImageAccess::ReadOnly,
        ImageAccess::WriteOnly,
        ImageAccess::ReadOnlyWriteOnly,
    ] {
        for base_size in BASE_IMAGE_SIZES {
            let image_size = match image_type {
                TextureType::Buffer => [base_size[0], 1, 1],
                TextureType::Type2D => [base_size[0], base_size[1], 1],
                TextureType::Cube => [base_size[0], base_size[0], 1],
                TextureType::Type3D | TextureType::Type2DArray => base_size,
            };

            let size_str = match image_type {
                TextureType::Buffer => format!("{}", image_size[0]),
                TextureType::Type2D | TextureType::Cube => format!("{}x{}", image_size[0], image_size[1]),
                TextureType::Type3D | TextureType::Type2DArray => {
                    format!("{}x{}x{}", image_size[0], image_size[1], image_size[2])
                }
            };

            let name = format!("{}_{size_str}", image_access.name());
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                image_size_case(
                    case,
                    TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT),
                    image_type,
                    image_size,
                    image_access,
                );
            });
        }
    }

    group
}

/// The xor pattern both cases fill the reference with.
fn xor_pattern_color(x: i32, y: i32, z: i32, image_size: [i32; 3]) -> [i32; 4] {
    [
        x ^ y ^ z,
        (image_size[0] - 1 - x) ^ y ^ z,
        x ^ (image_size[1] - 1 - y) ^ z,
        (image_size[0] - 1 - x) ^ (image_size[1] - 1 - y) ^ z,
    ]
}

/// The `*storeColorScale` / `+ float(storeColorBias)` tail both cases append to their
/// colour expression, and the scale and bias the host reference uses with it.
fn store_color_scale_and_bias(format: TextureFormat, max_image_dimension: i32) -> (f32, f32) {
    let scale = if is_format_type_unorm(format.type_) {
        1.0 / (max_image_dimension - 1) as f32
    } else if is_format_type_snorm(format.type_) {
        2.0 / (max_image_dimension - 1) as f32
    } else {
        1.0
    };
    let bias = if is_format_type_snorm(format.type_) { -1.0 } else { 0.0 };
    (scale, bias)
}

/// `ImageStoreCase::iterate` - stores a computed pattern into an image and reads the
/// texture back.
fn image_store_case(case: &mut ApiCase<'_>, format: TextureFormat, texture_type: TextureType, single_layer_bind: bool) {
    if !check_texture_type_extensions(case, texture_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let internal_format_gl = get_internal_format(format);
    let texture_target_gl = get_gl_texture_target(texture_type);
    let image_size = default_image_size(texture_type);
    let num_slices_or_faces = if texture_type == TextureType::Cube {
        6
    } else {
        image_size[2]
    };
    let max_image_dimension = image_size[0].max(image_size[1]).max(image_size[2]);
    let (store_color_scale, store_color_bias) = store_color_scale_and_bias(format, max_image_dimension);
    let texture_buf = glu::Buffer::new(gl);
    let texture = glu::Texture::new(gl);

    // Setup texture.
    // SAFETY: names this function just created, on a current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, texture.get());
        set_tex_parameteri(gl, texture_target_gl);
        set_texture_storage(gl, texture_type, internal_format_gl, image_size, texture_buf.get());
    }

    // Perform image stores in compute shader.
    {
        let shader_image_format_str = get_shader_image_format_qualifier(format);
        let shader_image_type = if single_layer_bind {
            texture_layer_type(texture_type)
        } else {
            texture_type
        };
        let shader_image_type_str = get_shader_image_type(format.type_, shader_image_type);
        let is_uint_format = is_format_type_unsigned_integer(format.type_);
        let is_int_format = is_format_type_signed_integer(format.type_);
        let vec_prefix = if is_uint_format {
            "u"
        } else if is_int_format {
            "i"
        } else {
            ""
        };
        let color_base_expr = format!(
            "{vec_prefix}vec4(gx^gy^gz, ({w}-gx)^gy^gz, gx^({h}-gy)^gz, ({w}-gx)^({h}-gy)^gz)",
            w = image_size[0] - 1,
            h = image_size[1] - 1
        );
        let scale_part = if store_color_scale == 1.0 {
            String::new()
        } else {
            format!("*{}", to_string_f32(store_color_scale))
        };
        let bias_part = if store_color_bias == 0.0 {
            String::new()
        } else {
            format!(" + float({})", to_string_f32(store_color_bias))
        };
        let color_expr = format!("{color_base_expr}{scale_part}{bias_part}");

        let gz_expr = if single_layer_bind {
            "u_layerNdx"
        } else {
            "int(gl_GlobalInvocationID.z)"
        };
        let layer_uniform = if single_layer_bind {
            "uniform int u_layerNdx;\n"
        } else {
            ""
        };
        let store_stmt = match shader_image_type {
            TextureType::Buffer => format!("    imageStore(u_image, gx, {color_expr});\n"),
            TextureType::Type2D => format!("    imageStore(u_image, ivec2(gx, gy), {color_expr});\n"),
            TextureType::Type3D | TextureType::Cube | TextureType::Type2DArray => {
                format!("    imageStore(u_image, ivec3(gx, gy, gz), {color_expr});\n")
            }
        };

        let source = format!(
            "{version}\n{extension}\nprecision highp {shader_image_type_str};\n\
             \n\
             layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
             layout ({shader_image_format_str}, binding=0) writeonly uniform {shader_image_type_str} u_image;\n\
             {layer_uniform}\
             \n\
             void main (void)\n\
             {{\n\
             \x20   int gx = int(gl_GlobalInvocationID.x);\n\
             \x20   int gy = int(gl_GlobalInvocationID.y);\n\
             \x20   int gz = {gz_expr};\n\
             {store_stmt}\
             }}\n",
            version = glsl_version_decl(context),
            extension = texture_type_extension_shader_requires(shader_image_type, context),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        let mut uniforms = UniformAccessLogger::new(gl, program.program());

        // SAFETY: a linked program and this function's own texture.
        unsafe {
            gl.use_program(program.program());

            if single_layer_bind {
                for layer_ndx in 0..num_slices_or_faces {
                    if layer_ndx > 0 {
                        gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
                    }

                    uniforms.assign_1i("u_layerNdx", layer_ndx);

                    gl.bind_image_texture(
                        0,
                        texture.get(),
                        0,
                        glw::GL_FALSE as u8,
                        layer_ndx,
                        glw::GL_WRITE_ONLY,
                        internal_format_gl,
                    );
                    if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                        case.fail(e.to_string(), "glBindImageTexture failed");
                        return;
                    }

                    gl.dispatch_compute(image_size[0] as GLuint, image_size[1] as GLuint, 1);
                    if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                        case.fail(e.to_string(), "glDispatchCompute failed");
                        return;
                    }
                }
            } else {
                gl.bind_image_texture(
                    0,
                    texture.get(),
                    0,
                    glw::GL_TRUE as u8,
                    0,
                    glw::GL_WRITE_ONLY,
                    internal_format_gl,
                );
                if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                    case.fail(e.to_string(), "glBindImageTexture failed");
                    return;
                }

                gl.dispatch_compute(
                    image_size[0] as GLuint,
                    image_size[1] as GLuint,
                    num_slices_or_faces as GLuint,
                );
                if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                    case.fail(e.to_string(), "glDispatchCompute failed");
                    return;
                }
            }
        }
    }

    // Create reference, read texture and compare to reference.
    {
        let is_integer_format = is_format_type_integer(format.type_);
        let mut reference = match LayeredImage::new(texture_type, format, image_size[0], image_size[1], image_size[2]) {
            Ok(image) => image,
            Err(e) => {
                case.fail(e.to_string(), "Image comparison failed");
                return;
            }
        };

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] {
                    let color = xor_pattern_color(x, y, z, image_size);
                    if is_integer_format {
                        reference.set_pixel_int(x, y, z, color);
                    } else {
                        reference.set_pixel(x, y, z, color.map(|c| c as f32 * store_color_scale + store_color_bias));
                    }
                }
            }
        }

        let comparer = ImageLayerComparer::new(&reference);
        let compare_ok = read_texture_and_verify(
            case,
            texture.get(),
            texture_buf.get(),
            texture_type,
            format,
            image_size,
            &comparer,
        );
        if !compare_ok {
            case.fail("Image comparison failed".to_string(), "Image comparison failed");
        }
    }
}

/// `ImageLoadAndStoreCase::replaceBadFloatReinterpretValues`
///
/// Upstream is templated on `tcu::Float16`/`tcu::Float32`; the two instantiations differ
/// only in how wide a channel is and where its exponent sits.
fn replace_bad_float_reinterpret_values(image: &mut LayeredImage, image_format: TextureFormat) {
    let pixel_size = image_format.pixel_size().expect("a sized format") as usize;
    let image_num_channels = match image_format.order {
        ChannelOrder::R => 1usize,
        ChannelOrder::RGBA => 4,
        other => panic!("{other:?} is not a format order this family reinterprets"),
    };
    let image_size = image.size();
    let num_slices_or_faces = if image.image_type() == TextureType::Cube {
        CUBEFACE_LAST as i32
    } else {
        image_size[2]
    };
    let channel_size = pixel_size / image_num_channels;
    let row_pitch = image_size[0] as usize * pixel_size;
    let is_half = image_format.type_ == ChannelType::HALF_FLOAT;

    for z in 0..num_slices_or_faces {
        let data = image.slice_bytes_mut(z as usize);

        for y in 0..image_size[1] {
            for x in 0..image_size[0] {
                let pixel_off = y as usize * row_pitch + x as usize * pixel_size;

                for c in 0..image_num_channels {
                    let off = pixel_off + c * channel_size;
                    if is_half {
                        let bits = u16::from_ne_bytes(data[off..off + 2].try_into().expect("two bytes"));
                        if is_bad_float16(bits) {
                            data[off..off + 2].copy_from_slice(&f32_to_f16_bits(0.0).to_ne_bytes());
                        }
                    } else {
                        let bits = u32::from_ne_bytes(data[off..off + 4].try_into().expect("four bytes"));
                        if is_bad_float32(bits) {
                            data[off..off + 4].copy_from_slice(&0.0f32.to_ne_bytes());
                        }
                    }
                }
            }
        }
    }
}

/// `tcu::Float16::isDenorm() || isInf() || isNaN()`
fn is_bad_float16(bits: u16) -> bool {
    let exponent = (bits >> 10) & 0x1f;
    let mantissa = bits & 0x3ff;
    (exponent == 0 && mantissa != 0) || exponent == 0x1f
}

/// `tcu::Float32::isDenorm() || isInf() || isNaN()`
fn is_bad_float32(bits: u32) -> bool {
    let exponent = (bits >> 23) & 0xff;
    let mantissa = bits & 0x7f_ffff;
    (exponent == 0 && mantissa != 0) || exponent == 0xff
}

/// `ImageLoadAndStoreCase::iterate` - copies one image into another with `imageLoad()`
/// and `imageStore()`, mirroring it in x. The texture and image formats need not match.
fn image_load_and_store_case(
    case: &mut ApiCase<'_>,
    texture_format: TextureFormat,
    image_format: TextureFormat,
    texture_type: TextureType,
    restrict_images: bool,
    single_layer_bind: bool,
) {
    if !check_texture_type_extensions(case, texture_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let texture_internal_format_gl = get_internal_format(texture_format);
    let image_internal_format_gl = get_internal_format(image_format);
    let texture_target_gl = get_gl_texture_target(texture_type);
    let image_size = default_image_size(texture_type);
    let max_image_dimension = image_size[0].max(image_size[1]).max(image_size[2]);
    let (store_color_scale, store_color_bias) = store_color_scale_and_bias(texture_format, max_image_dimension);
    let num_slices_or_faces = if texture_type == TextureType::Cube {
        6
    } else {
        image_size[2]
    };
    let is_integer_texture_format = is_format_type_integer(texture_format.type_);
    let texture0_buf = glu::Buffer::new(gl);
    let texture1_buf = glu::Buffer::new(gl);
    let texture0 = glu::Texture::new(gl);
    let texture1 = glu::Texture::new(gl);
    let mut reference = match LayeredImage::new(
        texture_type,
        texture_format,
        image_size[0],
        image_size[1],
        image_size[2],
    ) {
        Ok(image) => image,
        Err(e) => {
            case.fail(e.to_string(), "Image comparison failed");
            return;
        }
    };

    // First, fill reference with a fairly arbitrary initial pattern. It is both the
    // texture upload source and the starting point of the reference computation.
    for z in 0..num_slices_or_faces {
        for y in 0..image_size[1] {
            for x in 0..image_size[0] {
                let color = xor_pattern_color(x, y, z, image_size);
                if is_integer_texture_format {
                    reference.set_pixel_int(x, y, z, color);
                } else {
                    reference.set_pixel(x, y, z, color.map(|c| c as f32 * store_color_scale + store_color_bias));
                }
            }
        }
    }

    // If re-interpreting the texture contents as floating point values, get rid of inf,
    // nan and denormals first.
    // Upstream writes this as two branches, one per `tcu::Float` instantiation; the
    // helper here reads the channel width out of `image_format`, so they collapse.
    if matches!(image_format.type_, ChannelType::HALF_FLOAT | ChannelType::FLOAT)
        && texture_format.type_ != image_format.type_
    {
        replace_bad_float_reinterpret_values(&mut reference, image_format);
    }

    // Upload initial pattern to texture 0, and give texture 1 storage.
    // SAFETY: names this function just created, on a current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, texture0.get());
        set_tex_parameteri(gl, texture_target_gl);

        if let Err(e) = upload_texture(gl, &reference, texture0_buf.get()) {
            case.fail(e.to_string(), "Texture upload failed");
            return;
        }

        gl.active_texture(glw::GL_TEXTURE1);
        gl.bind_texture(texture_target_gl, texture1.get());
        set_tex_parameteri(gl, texture_target_gl);
        set_texture_storage(
            gl,
            texture_type,
            texture_internal_format_gl,
            image_size,
            texture1_buf.get(),
        );
    }

    // Perform image loads and stores in compute shader and finalize reference computation.
    {
        let maybe_restrict = if restrict_images { "restrict" } else { "" };
        let shader_image_format_str = get_shader_image_format_qualifier(image_format);
        let shader_image_type = if single_layer_bind {
            texture_layer_type(texture_type)
        } else {
            texture_type
        };
        let shader_image_type_str = get_shader_image_type(image_format.type_, shader_image_type);
        let last_x = image_size[0] - 1;
        let body = match shader_image_type {
            TextureType::Buffer => format!(
                "    int pos = int(gl_GlobalInvocationID.x);\n    imageStore(u_image1, pos, imageLoad(u_image0, {last_x}-pos));\n"
            ),
            TextureType::Type2D => format!(
                "    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);\n    imageStore(u_image1, pos, imageLoad(u_image0, ivec2({last_x}-pos.x, pos.y)));\n"
            ),
            TextureType::Type3D | TextureType::Cube | TextureType::Type2DArray => format!(
                "    ivec3 pos = ivec3(gl_GlobalInvocationID);\n    imageStore(u_image1, pos, imageLoad(u_image0, ivec3({last_x}-pos.x, pos.y, pos.z)));\n"
            ),
        };

        let source = format!(
            "{version}\n{extension}\nprecision highp {shader_image_type_str};\n\
             \n\
             layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
             layout ({shader_image_format_str}, binding=0) {maybe_restrict} readonly uniform {shader_image_type_str} u_image0;\n\
             layout ({shader_image_format_str}, binding=1) {maybe_restrict} writeonly uniform {shader_image_type_str} u_image1;\n\
             \n\
             void main (void)\n\
             {{\n\
             {body}\
             }}\n",
            version = glsl_version_decl(context),
            extension = texture_type_extension_shader_requires(shader_image_type, context),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // SAFETY: a linked program and this function's own textures.
        unsafe {
            gl.use_program(program.program());

            if single_layer_bind {
                for layer_ndx in 0..num_slices_or_faces {
                    if layer_ndx > 0 {
                        gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
                    }

                    gl.bind_image_texture(
                        0,
                        texture0.get(),
                        0,
                        glw::GL_FALSE as u8,
                        layer_ndx,
                        glw::GL_READ_ONLY,
                        image_internal_format_gl,
                    );
                    gl.bind_image_texture(
                        1,
                        texture1.get(),
                        0,
                        glw::GL_FALSE as u8,
                        layer_ndx,
                        glw::GL_WRITE_ONLY,
                        image_internal_format_gl,
                    );
                    if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                        case.fail(e.to_string(), "glBindImageTexture failed");
                        return;
                    }

                    gl.dispatch_compute(image_size[0] as GLuint, image_size[1] as GLuint, 1);
                    if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                        case.fail(e.to_string(), "glDispatchCompute failed");
                        return;
                    }
                }
            } else {
                gl.bind_image_texture(
                    0,
                    texture0.get(),
                    0,
                    glw::GL_TRUE as u8,
                    0,
                    glw::GL_READ_ONLY,
                    image_internal_format_gl,
                );
                gl.bind_image_texture(
                    1,
                    texture1.get(),
                    0,
                    glw::GL_TRUE as u8,
                    0,
                    glw::GL_WRITE_ONLY,
                    image_internal_format_gl,
                );
                if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                    case.fail(e.to_string(), "glBindImageTexture failed");
                    return;
                }

                gl.dispatch_compute(
                    image_size[0] as GLuint,
                    image_size[1] as GLuint,
                    num_slices_or_faces as GLuint,
                );
                if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                    case.fail(e.to_string(), "glDispatchCompute failed");
                    return;
                }
            }
        }

        // Finalize reference.
        if texture_format != image_format {
            // Format re-interpretation case. Read the data back with the image format and
            // write it out again with the same image format, because the values may change
            // a little during lookups - not every unorm8 is exactly representable as a
            // float.
            let pixel_size = image_format.pixel_size().expect("a sized format") as usize;
            let row_pitch = image_size[0] as usize * pixel_size;
            let mut scratch = match TextureLevel::new(image_format, 1, 1, 1) {
                Ok(level) => level,
                Err(e) => {
                    case.fail(e.to_string(), "Image comparison failed");
                    return;
                }
            };
            let image_format_is_integer = is_format_type_integer(image_format.type_);

            for z in 0..num_slices_or_faces {
                let data = reference.slice_bytes_mut(z as usize);

                for y in 0..image_size[1] {
                    for x in 0..image_size[0] {
                        let off = y as usize * row_pitch + x as usize * pixel_size;
                        scratch.data_mut()[..pixel_size].copy_from_slice(&data[off..off + pixel_size]);

                        if image_format_is_integer {
                            let value = scratch.get_const_access().get_pixel_int(0, 0, 0);
                            let stored = scratch.get_access().set_pixel_int(value, 0, 0, 0);
                            debug_assert!(stored, "every format in this family is storable");
                        } else {
                            let value = scratch.get_const_access().get_pixel(0, 0, 0);
                            scratch.get_access().set_pixel(value, 0, 0, 0);
                        }

                        data[off..off + pixel_size].copy_from_slice(&scratch.data()[..pixel_size]);
                    }
                }
            }
        }

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] / 2 {
                    if is_integer_texture_format {
                        let temp = reference.get_pixel_int(image_size[0] - 1 - x, y, z);
                        let other = reference.get_pixel_int(x, y, z);
                        reference.set_pixel_int(image_size[0] - 1 - x, y, z, other);
                        reference.set_pixel_int(x, y, z, temp);
                    } else {
                        let temp = reference.get_pixel(image_size[0] - 1 - x, y, z);
                        let other = reference.get_pixel(x, y, z);
                        reference.set_pixel(image_size[0] - 1 - x, y, z, other);
                        reference.set_pixel(x, y, z, temp);
                    }
                }
            }
        }
    }

    // Read texture 1 and compare to reference.
    let comparer = ImageLayerComparer::new(&reference);
    let compare_ok = read_texture_and_verify(
        case,
        texture1.get(),
        texture1_buf.get(),
        texture_type,
        texture_format,
        image_size,
        &comparer,
    );
    if !compare_ok {
        case.fail("Image comparison failed".to_string(), "Image comparison failed");
    }
}

/// `AtomicOperation`
#[derive(Clone, Copy, PartialEq, Eq)]
enum AtomicOperation {
    Add,
    Min,
    Max,
    And,
    Or,
    Xor,
    Exchange,
    CompSwap,
}

/// `ATOMIC_OPERATION_LAST`, as the loop upstream writes over it.
const ATOMIC_OPERATIONS: [AtomicOperation; 8] = [
    AtomicOperation::Add,
    AtomicOperation::Min,
    AtomicOperation::Max,
    AtomicOperation::And,
    AtomicOperation::Or,
    AtomicOperation::Xor,
    AtomicOperation::Exchange,
    AtomicOperation::CompSwap,
];

/// `AtomicOperationCaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum AtomicOperationCaseType {
    /// Checks the end result of the operations, not the return values.
    EndResult,
    /// Checks the return values of the atomic function, not the end result.
    ReturnValues,
}

/// `isOrderIndependentAtomicOperation` - both commutative and associative, so the end
/// result does not depend on the order the invocations ran in.
fn is_order_independent_atomic_operation(op: AtomicOperation) -> bool {
    matches!(
        op,
        AtomicOperation::Add
            | AtomicOperation::Min
            | AtomicOperation::Max
            | AtomicOperation::And
            | AtomicOperation::Or
            | AtomicOperation::Xor
    )
}

/// `computeBinaryAtomicOperationResult`, the integer overload.
fn compute_binary_atomic_operation_result_int(op: AtomicOperation, a: i32, b: i32) -> i32 {
    match op {
        AtomicOperation::Add => a.wrapping_add(b),
        AtomicOperation::Min => a.min(b),
        AtomicOperation::Max => a.max(b),
        AtomicOperation::And => a & b,
        AtomicOperation::Or => a | b,
        AtomicOperation::Xor => a ^ b,
        AtomicOperation::Exchange => b,
        AtomicOperation::CompSwap => panic!("comp_swap has its own case"),
    }
}

/// `computeBinaryAtomicOperationResult`, the float overload - only exchange is supported.
fn compute_binary_atomic_operation_result_float(op: AtomicOperation, _a: f32, b: f32) -> f32 {
    match op {
        AtomicOperation::Exchange => b,
        _ => panic!("only exchange is defined for a float image"),
    }
}

/// `getAtomicOperationCaseName`
fn atomic_operation_case_name(op: AtomicOperation) -> &'static str {
    match op {
        AtomicOperation::Add => "add",
        AtomicOperation::Min => "min",
        AtomicOperation::Max => "max",
        AtomicOperation::And => "and",
        AtomicOperation::Or => "or",
        AtomicOperation::Xor => "xor",
        AtomicOperation::Exchange => "exchange",
        AtomicOperation::CompSwap => "comp_swap",
    }
}

/// `getAtomicOperationShaderFuncName`
fn atomic_operation_shader_func_name(op: AtomicOperation) -> &'static str {
    match op {
        AtomicOperation::Add => "imageAtomicAdd",
        AtomicOperation::Min => "imageAtomicMin",
        AtomicOperation::Max => "imageAtomicMax",
        AtomicOperation::And => "imageAtomicAnd",
        AtomicOperation::Or => "imageAtomicOr",
        AtomicOperation::Xor => "imageAtomicXor",
        AtomicOperation::Exchange => "imageAtomicExchange",
        AtomicOperation::CompSwap => "imageAtomicCompSwap",
    }
}

/// `s_imageAtomicExtString`
const IMAGE_ATOMIC_EXT_STRING: &str = "GL_OES_shader_image_atomic";

/// `imageAtomicExtensionShaderRequires`
fn image_atomic_extension_shader_requires(context: &Context) -> String {
    if supports_es32(context) {
        String::new()
    } else {
        format!("#extension {IMAGE_ATOMIC_EXT_STRING} : require\n")
    }
}

/// The `init()` both atomic cases share.
fn check_image_atomic_support(case: &mut ApiCase<'_>, image_type: TextureType) -> bool {
    if !case
        .context()
        .context_info
        .is_extension_supported(IMAGE_ATOMIC_EXT_STRING)
        && !supports_es32(case.context())
    {
        case.not_supported(format!("Test requires {IMAGE_ATOMIC_EXT_STRING} extension"));
        return false;
    }
    check_texture_type_extensions(case, image_type)
}

/// `getGLTextureMaxSize`
fn get_gl_texture_max_size(case: &ApiCase<'_>, tex_type: TextureType) -> i32 {
    let pname = match tex_type {
        TextureType::Buffer => glw::GL_MAX_TEXTURE_BUFFER_SIZE,
        TextureType::Type3D | TextureType::Type2DArray => glw::GL_MAX_3D_TEXTURE_SIZE,
        TextureType::Type2D | TextureType::Cube => glw::GL_MAX_TEXTURE_SIZE,
    };
    case.get_int(pname)
}

/// `BinaryAtomicOperationCase::getOperationInitialValue` - the value the texture starts
/// at. 18 is just an arbitrary small nonzero value.
fn binary_atomic_operation_initial_value(op: AtomicOperation) -> i32 {
    match op {
        AtomicOperation::Add => 18,
        AtomicOperation::Min => (1 << 15) - 1,
        AtomicOperation::Max => 18,
        AtomicOperation::And => (1 << 15) - 1,
        AtomicOperation::Or => 18,
        AtomicOperation::Xor => 18,
        AtomicOperation::Exchange => 18,
        AtomicOperation::CompSwap => panic!("comp_swap has its own case"),
    }
}

/// `BinaryAtomicOperationCase::getAtomicFuncArgument`
fn binary_atomic_func_argument(op: AtomicOperation, invocation_id: [i32; 3], dispatch_size_xy: [i32; 2]) -> i32 {
    let [x, y, z] = invocation_id;
    let [wid, hei] = dispatch_size_xy;

    match op {
        AtomicOperation::Add
        | AtomicOperation::Min
        | AtomicOperation::Max
        | AtomicOperation::And
        | AtomicOperation::Or
        | AtomicOperation::Xor => x * x + y * y + z * z,
        AtomicOperation::Exchange => (z * wid + x) * hei + y,
        AtomicOperation::CompSwap => panic!("comp_swap has its own case"),
    }
}

/// `BinaryAtomicOperationCase::getAtomicFuncArgumentShaderStr`
fn binary_atomic_func_argument_shader_str(
    op: AtomicOperation,
    x: &str,
    y: &str,
    z: &str,
    dispatch_size_xy: [i32; 2],
) -> String {
    match op {
        AtomicOperation::Add
        | AtomicOperation::Min
        | AtomicOperation::Max
        | AtomicOperation::And
        | AtomicOperation::Or
        | AtomicOperation::Xor => {
            format!("({x}*{x} + {y}*{y} + {z}*{z})")
        }
        AtomicOperation::Exchange => format!("(({z}*{} + {x})*{} + {y})", dispatch_size_xy[0], dispatch_size_xy[1]),
        AtomicOperation::CompSwap => panic!("comp_swap has its own case"),
    }
}

/// `BinaryAtomicOperationCase::EndResultVerifier`
struct BinaryAtomicEndResultVerifier {
    operation: AtomicOperation,
    num_invocations_per_pixel: i32,
}

impl ImageLayerVerifier for BinaryAtomicEndResultVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool {
        let is_integer_format = is_format_type_integer(result_slice.get_format().type_);
        let [width, height, _] = result_slice.size();
        let dispatch_size_xy = [self.num_invocations_per_pixel * width as i32, height as i32];

        for y in 0..height as i32 {
            for x in 0..width as i32 {
                let mut invocation_global_ids = Vec::with_capacity(self.num_invocations_per_pixel as usize);
                let mut atomic_args = Vec::with_capacity(self.num_invocations_per_pixel as usize);

                for i in 0..self.num_invocations_per_pixel {
                    let gid = [x + i * width as i32, y, slice_or_face_ndx];
                    invocation_global_ids.push(gid);
                    atomic_args.push(binary_atomic_func_argument(self.operation, gid, dispatch_size_xy));
                }

                if is_order_independent_atomic_operation(self.operation) {
                    // Just accumulate the atomic args (and the initial value) according to
                    // the operation, and compare.
                    let result = result_slice.get_pixel_int(x as u32, y as u32, 0)[0];
                    let mut reference = binary_atomic_operation_initial_value(self.operation);

                    for &arg in &atomic_args {
                        reference = compute_binary_atomic_operation_result_int(self.operation, reference, arg);
                    }

                    if result != reference {
                        log::warn!("// Failure: end result at pixel ({x}, {y}) of current layer is {result}");
                        log::warn!("// Note: relevant shader invocation global IDs are {invocation_global_ids:?}");
                        log::warn!("// Note: data expression values for the IDs are {atomic_args:?}");
                        log::warn!("// Note: reference value is {reference}");
                        return false;
                    }
                } else if self.operation == AtomicOperation::Exchange {
                    // Check that the end result equals one of the atomic args.
                    let match_found = if is_integer_format {
                        let result = result_slice.get_pixel_int(x as u32, y as u32, 0)[0];
                        atomic_args.contains(&result)
                    } else {
                        let result = result_slice.get_pixel(x as u32, y as u32, 0)[0];
                        atomic_args.iter().any(|&arg| (result - arg as f32).abs() <= 0.01)
                    };

                    if !match_found {
                        log::warn!("// Failure: invalid value at pixel ({x}, {y})");
                        log::warn!("// Note: expected one of {atomic_args:?}");
                        return false;
                    }
                } else {
                    panic!("only order-independent operations and exchange reach the end-result verifier");
                }
            }
        }

        true
    }
}

/// `verifyRecursive` - a depth-first search for an ordering of `args` under which
/// `return_values` is the sequence of intermediate results.
fn verify_atomic_recursive<T: Copy>(
    index: usize,
    value_so_far: T,
    args_used: &mut [bool],
    args: &[T],
    return_values: &[T],
    compute: &dyn Fn(T, T) -> T,
    compare: &dyn Fn(T, T) -> bool,
) -> bool {
    if index >= args.len() {
        return true;
    }

    for i in 0..args.len() {
        if !args_used[i] && compare(return_values[i], value_so_far) {
            args_used[i] = true;
            if verify_atomic_recursive(
                index + 1,
                compute(value_so_far, args[i]),
                args_used,
                args,
                return_values,
                compute,
                compare,
            ) {
                return true;
            }
            args_used[i] = false;
        }
    }

    false
}

/// The four operations `ReturnValueVerifier::checkPixel` is templated over upstream -
/// how a value is read out of a slice, how an argument is built from an int, how the
/// atomic combines two of them, and how two are compared.
struct AtomicValueOps<'a, T> {
    pixel_value_x: &'a dyn Fn(&ConstPixelBufferAccess<'_>, i32, i32) -> T,
    from_int: &'a dyn Fn(i32) -> T,
    compute: &'a dyn Fn(T, T) -> T,
    compare: &'a dyn Fn(T, T) -> bool,
}

/// `BinaryAtomicOperationCase::ReturnValueVerifier`
struct BinaryAtomicReturnValueVerifier {
    operation: AtomicOperation,
    /// `m_endResultImageLayerSize` - the size of the image the atomics operate on, not of
    /// the image the return values are stored in.
    end_result_image_layer_size: [i32; 2],
    num_invocations_per_pixel: i32,
}

impl BinaryAtomicReturnValueVerifier {
    fn check_pixel<T: Copy + std::fmt::Debug>(
        &self,
        result_slice: &ConstPixelBufferAccess<'_>,
        (x, y, slice_or_face_ndx): (i32, i32, i32),
        dispatch_size_xy: [i32; 2],
        ops: &AtomicValueOps<'_, T>,
    ) -> bool {
        let AtomicValueOps {
            pixel_value_x,
            from_int,
            compute,
            compare,
        } = ops;
        let count = self.num_invocations_per_pixel as usize;
        let mut return_values = Vec::with_capacity(count);
        let mut atomic_args = Vec::with_capacity(count);
        let mut invocation_global_ids = Vec::with_capacity(count);
        let mut pixel_coords = Vec::with_capacity(count);

        for i in 0..self.num_invocations_per_pixel {
            let pix_coord = [x + i * self.end_result_image_layer_size[0], y];
            let gid = [pix_coord[0], pix_coord[1], slice_or_face_ndx];

            invocation_global_ids.push(gid);
            pixel_coords.push(pix_coord);
            return_values.push(pixel_value_x(result_slice, gid[0], y));
            atomic_args.push(from_int(binary_atomic_func_argument(
                self.operation,
                gid,
                dispatch_size_xy,
            )));
        }

        let init = from_int(binary_atomic_operation_initial_value(self.operation));
        let mut args_used = vec![false; count];
        let success = verify_atomic_recursive(0, init, &mut args_used, &atomic_args, &return_values, compute, compare);

        if !success {
            log::warn!(
                "// Failure: intermediate return values at pixels {pixel_coords:?} of current layer are {return_values:?}"
            );
            log::warn!("// Note: relevant shader invocation global IDs are {invocation_global_ids:?}");
            log::warn!(
                "// Note: data expression values for the IDs are {atomic_args:?}; return values are not a valid result for any order of operations"
            );
        }

        success
    }
}

impl ImageLayerVerifier for BinaryAtomicReturnValueVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool {
        let is_integer_format = is_format_type_integer(result_slice.get_format().type_);
        let [width, height, _] = result_slice.size();
        let dispatch_size_xy = [width as i32, height as i32];

        for y in 0..self.end_result_image_layer_size[1] {
            for x in 0..self.end_result_image_layer_size[0] {
                let ok = if is_integer_format {
                    self.check_pixel(
                        result_slice,
                        (x, y, slice_or_face_ndx),
                        dispatch_size_xy,
                        &AtomicValueOps {
                            pixel_value_x: &|slice: &ConstPixelBufferAccess<'_>, px, py| {
                                slice.get_pixel_int(px as u32, py as u32, 0)[0]
                            },
                            from_int: &|v| v,
                            compute: &|a, b| compute_binary_atomic_operation_result_int(self.operation, a, b),
                            compare: &|a: i32, b: i32| a == b,
                        },
                    )
                } else {
                    self.check_pixel(
                        result_slice,
                        (x, y, slice_or_face_ndx),
                        dispatch_size_xy,
                        &AtomicValueOps {
                            pixel_value_x: &|slice: &ConstPixelBufferAccess<'_>, px, py| {
                                slice.get_pixel(px as u32, py as u32, 0)[0]
                            },
                            from_int: &|v| v as f32,
                            compute: &|a, b| compute_binary_atomic_operation_result_float(self.operation, a, b),
                            compare: &|a: f32, b: f32| (a - b).abs() <= 0.01,
                        },
                    )
                };

                if !ok {
                    return false;
                }
            }
        }

        true
    }
}

/// `BinaryAtomicOperationCase::iterate`
fn binary_atomic_operation_case(
    case: &mut ApiCase<'_>,
    format: TextureFormat,
    image_type: TextureType,
    operation: AtomicOperation,
    case_type: AtomicOperationCaseType,
) {
    if !check_image_atomic_support(case, image_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let internal_format_gl = get_internal_format(format);
    let texture_target_gl = get_gl_texture_target(image_type);
    let image_size = default_image_size(image_type);
    let num_slices_or_faces = if image_type == TextureType::Cube {
        6
    } else {
        image_size[2]
    };
    let is_uint_format = is_format_type_unsigned_integer(format.type_);
    let is_int_format = is_format_type_signed_integer(format.type_);
    let end_result_texture_buf = glu::Buffer::new(gl);
    let return_value_texture_buf = glu::Buffer::new(gl);
    let end_result_texture = glu::Texture::new(gl);
    let return_value_texture = glu::Texture::new(gl);

    // Adjust result image size for result image.
    let mut num_invocations_per_pixel = 5;
    if case_type == AtomicOperationCaseType::ReturnValues {
        let max_width = get_gl_texture_max_size(case, image_type);
        while max_width < num_invocations_per_pixel * image_size[0] {
            num_invocations_per_pixel -= 1;
        }
    }

    // Fill endResultTexture with initial pattern.
    {
        let mut image_data = match LayeredImage::new(image_type, format, image_size[0], image_size[1], image_size[2]) {
            Ok(image) => image,
            Err(e) => {
                case.fail(e.to_string(), "Image verification failed");
                return;
            }
        };
        let initial = binary_atomic_operation_initial_value(operation);

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] {
                    image_data.set_pixel_int(x, y, z, [initial; 4]);
                }
            }
        }

        // SAFETY: names this function just created, on a current context.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(texture_target_gl, end_result_texture.get());
            set_tex_parameteri(gl, texture_target_gl);

            if let Err(e) = upload_texture(gl, &image_data, end_result_texture_buf.get()) {
                case.fail(e.to_string(), "Texture upload failed");
                return;
            }
        }
    }

    // SAFETY: the textures are this function's own.
    unsafe {
        gl.bind_image_texture(
            0,
            end_result_texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_WRITE,
            internal_format_gl,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }

        if case_type == AtomicOperationCaseType::ReturnValues {
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(texture_target_gl, return_value_texture.get());
            set_tex_parameteri(gl, texture_target_gl);
            set_texture_storage(
                gl,
                image_type,
                internal_format_gl,
                return_value_texture_size(image_type, image_size, num_invocations_per_pixel),
                return_value_texture_buf.get(),
            );

            gl.bind_image_texture(
                1,
                return_value_texture.get(),
                0,
                glw::GL_TRUE as u8,
                0,
                glw::GL_WRITE_ONLY,
                internal_format_gl,
            );
            if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                case.fail(e.to_string(), "glBindImageTexture failed");
                return;
            }
        }
    }

    // Perform the atomic operations in a compute shader.
    {
        let color_vec_type_name = format!("{}vec4", scalar_type_prefix(is_uint_format, is_int_format));
        let atomic_coord = atomic_coord_expr(image_type, image_size[0]);
        let invocation_coord = invocation_coord_expr(image_type);
        let atomic_arg_expr = format!(
            "{}{}",
            if is_uint_format {
                "uint"
            } else if is_int_format {
                ""
            } else {
                "float"
            },
            binary_atomic_func_argument_shader_str(
                operation,
                "gx",
                "gy",
                "gz",
                [num_invocations_per_pixel * image_size[0], image_size[1]]
            )
        );
        let atomic_invocation = format!(
            "{}(u_results, {atomic_coord}, {atomic_arg_expr})",
            atomic_operation_shader_func_name(operation)
        );
        let shader_image_format_str = get_shader_image_format_qualifier(format);
        let shader_image_type_str = get_shader_image_type(format.type_, image_type);
        let return_value_uniform = if case_type == AtomicOperationCaseType::ReturnValues {
            format!(
                "layout ({shader_image_format_str}, binding=1) writeonly uniform {shader_image_type_str} u_returnValues;\n"
            )
        } else {
            String::new()
        };
        let body = match case_type {
            AtomicOperationCaseType::ReturnValues => format!(
                "    imageStore(u_returnValues, {invocation_coord}, {color_vec_type_name}({atomic_invocation}));\n"
            ),
            AtomicOperationCaseType::EndResult => format!("    {atomic_invocation};\n"),
        };

        let source = format!(
            "{version}\n{atomic_ext}{texture_ext}\nprecision highp {shader_image_type_str};\n\
             \n\
             layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
             layout ({shader_image_format_str}, binding=0) coherent uniform {shader_image_type_str} u_results;\n\
             {return_value_uniform}\
             \n\
             void main (void)\n\
             {{\n\
             \x20   int gx = int(gl_GlobalInvocationID.x);\n\
             \x20   int gy = int(gl_GlobalInvocationID.y);\n\
             \x20   int gz = int(gl_GlobalInvocationID.z);\n\
             {body}\
             }}\n",
            version = glsl_version_decl(context),
            atomic_ext = image_atomic_extension_shader_requires(context),
            texture_ext = texture_type_extension_shader_requires(image_type, context),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // SAFETY: a linked program and the image bindings set up above.
        unsafe {
            gl.use_program(program.program());
            gl.dispatch_compute(
                (num_invocations_per_pixel * image_size[0]) as GLuint,
                image_size[1] as GLuint,
                num_slices_or_faces as GLuint,
            );
            if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                case.fail(e.to_string(), "glDispatchCompute failed");
                return;
            }
        }
    }

    // Read texture and check.
    {
        let (texture_to_check_gl, texture_to_check_buf_gl) = match case_type {
            AtomicOperationCaseType::EndResult => (end_result_texture.get(), end_result_texture_buf.get()),
            AtomicOperationCaseType::ReturnValues => (return_value_texture.get(), return_value_texture_buf.get()),
        };
        let width_multiplier = match case_type {
            AtomicOperationCaseType::EndResult => 1,
            AtomicOperationCaseType::ReturnValues => num_invocations_per_pixel,
        };
        let texture_to_check_size = [image_size[0] * width_multiplier, image_size[1], image_size[2]];

        let end_result_verifier = BinaryAtomicEndResultVerifier {
            operation,
            num_invocations_per_pixel,
        };
        let return_value_verifier = BinaryAtomicReturnValueVerifier {
            operation,
            end_result_image_layer_size: [image_size[0], image_size[1]],
            num_invocations_per_pixel,
        };
        let verifier: &dyn ImageLayerVerifier = match case_type {
            AtomicOperationCaseType::EndResult => &end_result_verifier,
            AtomicOperationCaseType::ReturnValues => &return_value_verifier,
        };

        if !read_texture_and_verify(
            case,
            texture_to_check_gl,
            texture_to_check_buf_gl,
            image_type,
            format,
            texture_to_check_size,
            verifier,
        ) {
            case.fail("Image verification failed".to_string(), "Image verification failed");
        }
    }
}

/// The `imageSize * IVec3(...)` the return-value texture is given. A cube map must be
/// square, so its height is scaled too and the extra pixels go unused.
fn return_value_texture_size(
    image_type: TextureType,
    image_size: [i32; 3],
    num_invocations_per_pixel: i32,
) -> [i32; 3] {
    if image_type == TextureType::Cube {
        [
            image_size[0] * num_invocations_per_pixel,
            image_size[1] * num_invocations_per_pixel,
            image_size[2],
        ]
    } else {
        [image_size[0] * num_invocations_per_pixel, image_size[1], image_size[2]]
    }
}

/// The `u`/`i`/`` prefix an integer or float image's GLSL scalar and vector types take.
fn scalar_type_prefix(is_uint_format: bool, is_int_format: bool) -> &'static str {
    if is_uint_format {
        "u"
    } else if is_int_format {
        "i"
    } else {
        ""
    }
}

/// `atomicCoord` - the coordinate of the pixel the atomic operates on, wrapped so that
/// several invocations land on the same one.
fn atomic_coord_expr(image_type: TextureType, image_width: i32) -> String {
    match image_type {
        TextureType::Buffer => format!("gx % {image_width}"),
        TextureType::Type2D => format!("ivec2(gx % {image_width}, gy)"),
        _ => format!("ivec3(gx % {image_width}, gy, gz)"),
    }
}

/// `invocationCoord` - where this invocation's own return value is stored.
fn invocation_coord_expr(image_type: TextureType) -> &'static str {
    match image_type {
        TextureType::Buffer => "gx",
        TextureType::Type2D => "ivec2(gx, gy)",
        _ => "ivec3(gx, gy, gz)",
    }
}

/// `AtomicCompSwapCase::getCompareArg`
fn comp_swap_compare_arg(invocation_id: [i32; 3], image_width: i32) -> i32 {
    let [x, y, z] = invocation_id;
    let wrap_x = x % image_width;
    let cur_pixel_invocation_ndx = x / image_width;

    wrap_x * wrap_x + y * y + z * z + cur_pixel_invocation_ndx * 42
}

/// `AtomicCompSwapCase::getAssignArg`
fn comp_swap_assign_arg(invocation_id: [i32; 3], image_width: i32) -> i32 {
    comp_swap_compare_arg(
        [invocation_id[0] + image_width, invocation_id[1], invocation_id[2]],
        image_width,
    )
}

/// `AtomicCompSwapCase::getCompareArgShaderStr`
fn comp_swap_compare_arg_shader_str(x: &str, y: &str, z: &str, image_width: i32) -> String {
    let wrap_x = format!("({x}%{image_width})");
    let cur_pixel_invocation_ndx = format!("({x}/{image_width})");
    format!("({wrap_x}*{wrap_x} + {y}*{y} + {z}*{z} + {cur_pixel_invocation_ndx}*42)")
}

/// `AtomicCompSwapCase::getAssignArgShaderStr`
fn comp_swap_assign_arg_shader_str(x: &str, y: &str, z: &str, image_width: i32) -> String {
    let wrap_x = format!("({x}%{image_width})");
    let cur_pixel_invocation_ndx = format!("({x}/{image_width} + 1)");
    format!("({wrap_x}*{wrap_x} + {y}*{y} + {z}*{z} + {cur_pixel_invocation_ndx}*42)")
}

/// `AtomicCompSwapCase::EndResultVerifier`
struct CompSwapEndResultVerifier {
    image_width: i32,
    num_invocations_per_pixel: i32,
}

impl ImageLayerVerifier for CompSwapEndResultVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool {
        let [width, height, _] = result_slice.size();

        for y in 0..height as i32 {
            for x in 0..width as i32 {
                // Compute the value-to-assign arguments the contributing invocations gave
                // the atomic function. One of them has to be the result.
                let result = result_slice.get_pixel_int(x as u32, y as u32, 0)[0];
                let mut invocation_global_ids = Vec::with_capacity(self.num_invocations_per_pixel as usize);
                let mut assign_args = Vec::with_capacity(self.num_invocations_per_pixel as usize);

                for i in 0..self.num_invocations_per_pixel {
                    let gid = [x + i * width as i32, y, slice_or_face_ndx];
                    invocation_global_ids.push(gid);
                    assign_args.push(comp_swap_assign_arg(gid, self.image_width));
                }

                if !assign_args.contains(&result) {
                    log::warn!("// Failure: invalid value at pixel ({x}, {y}): got {result}");
                    log::warn!("// Note: relevant shader invocation global IDs are {invocation_global_ids:?}");
                    log::warn!(
                        "// Note: expected one of {assign_args:?} (the values given as the 'data' argument in the invocations that contribute to this pixel)"
                    );
                    return false;
                }
            }
        }

        true
    }
}

/// `AtomicCompSwapCase::ReturnValueVerifier`
struct CompSwapReturnValueVerifier {
    end_result_image_width: i32,
    num_invocations_per_pixel: i32,
}

impl ImageLayerVerifier for CompSwapReturnValueVerifier {
    fn verify(&self, result_slice: &ConstPixelBufferAccess<'_>, slice_or_face_ndx: i32) -> bool {
        let [_, height, _] = result_slice.size();

        for y in 0..height as i32 {
            for x in 0..self.end_result_image_width {
                let count = self.num_invocations_per_pixel as usize;
                let mut return_values = Vec::with_capacity(count);
                let mut compare_args = Vec::with_capacity(count);
                let mut invocation_global_ids = Vec::with_capacity(count);
                let mut pixel_coords = Vec::with_capacity(count);

                for i in 0..self.num_invocations_per_pixel {
                    let pix_coord = [x + i * self.end_result_image_width, y];
                    let gid = [pix_coord[0], pix_coord[1], slice_or_face_ndx];

                    pixel_coords.push(pix_coord);
                    invocation_global_ids.push(gid);
                    return_values.push(result_slice.get_pixel_int(gid[0] as u32, y as u32, 0)[0]);
                    compare_args.push(comp_swap_compare_arg(gid, self.end_result_image_width));
                }

                // The compare and assign arguments are organized so that one invocation
                // compares to A and assigns B, another compares to B and assigns C, and so
                // on with A<B<C; so the only valid return value sequence is A B C D E...,
                // each value either the one before it or the next one up.
                let mut failing_ndx: i32 = -1;
                {
                    let mut current_atomic_value_ndx = 0usize;
                    for (i, &return_value) in return_values.iter().enumerate() {
                        if return_value == compare_args[current_atomic_value_ndx] {
                            continue;
                        }
                        if i > 0
                            && current_atomic_value_ndx + 1 < count
                            && return_value == compare_args[current_atomic_value_ndx + 1]
                        {
                            current_atomic_value_ndx += 1;
                            continue;
                        }
                        failing_ndx = i as i32;
                        break;
                    }
                }

                if failing_ndx >= 0 {
                    log::warn!(
                        "// Failure: intermediate return values at pixels {pixel_coords:?} of current layer are {return_values:?}"
                    );
                    log::warn!("// Note: relevant shader invocation global IDs are {invocation_global_ids:?}");
                    log::warn!("// Note: 'compare' argument values for the IDs are {compare_args:?}");
                    log::warn!(
                        "// Note: expected the first value to be {} and each later one to be either the one before it or the smallest value bigger than it",
                        compare_args[0]
                    );
                    return false;
                }
            }
        }

        true
    }
}

/// `AtomicCompSwapCase::iterate`
fn atomic_comp_swap_case(
    case: &mut ApiCase<'_>,
    format: TextureFormat,
    image_type: TextureType,
    case_type: AtomicOperationCaseType,
) {
    if !check_image_atomic_support(case, image_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let internal_format_gl = get_internal_format(format);
    let texture_target_gl = get_gl_texture_target(image_type);
    let image_size = default_image_size(image_type);
    let num_slices_or_faces = if image_type == TextureType::Cube {
        6
    } else {
        image_size[2]
    };
    let is_uint_format = is_format_type_unsigned_integer(format.type_);
    let is_int_format = is_format_type_signed_integer(format.type_);
    let end_result_texture_buf = glu::Buffer::new(gl);
    let return_value_texture_buf = glu::Buffer::new(gl);
    let end_result_texture = glu::Texture::new(gl);
    let return_value_texture = glu::Texture::new(gl);

    // Adjust result image size for result image.
    let mut num_invocations_per_pixel = 5;
    if case_type == AtomicOperationCaseType::ReturnValues {
        let max_width = get_gl_texture_max_size(case, image_type);
        while max_width < num_invocations_per_pixel * image_size[0] {
            num_invocations_per_pixel -= 1;
        }
    }

    // Fill endResultTexture with initial pattern.
    {
        let mut image_data = match LayeredImage::new(image_type, format, image_size[0], image_size[1], image_size[2]) {
            Ok(image) => image,
            Err(e) => {
                case.fail(e.to_string(), "Image verification failed");
                return;
            }
        };

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] {
                    image_data.set_pixel_int(x, y, z, [comp_swap_compare_arg([x, y, z], image_size[0]); 4]);
                }
            }
        }

        // SAFETY: names this function just created, on a current context.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(texture_target_gl, end_result_texture.get());
            set_tex_parameteri(gl, texture_target_gl);

            if let Err(e) = upload_texture(gl, &image_data, end_result_texture_buf.get()) {
                case.fail(e.to_string(), "Texture upload failed");
                return;
            }
        }
    }

    // SAFETY: the textures are this function's own.
    unsafe {
        gl.bind_image_texture(
            0,
            end_result_texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_WRITE,
            internal_format_gl,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }

        if case_type == AtomicOperationCaseType::ReturnValues {
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(texture_target_gl, return_value_texture.get());
            set_tex_parameteri(gl, texture_target_gl);
            set_texture_storage(
                gl,
                image_type,
                internal_format_gl,
                return_value_texture_size(image_type, image_size, num_invocations_per_pixel),
                return_value_texture_buf.get(),
            );

            gl.bind_image_texture(
                1,
                return_value_texture.get(),
                0,
                glw::GL_TRUE as u8,
                0,
                glw::GL_WRITE_ONLY,
                internal_format_gl,
            );
            if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
                case.fail(e.to_string(), "glBindImageTexture failed");
                return;
            }
        }
    }

    // Perform the atomics in a compute shader.
    {
        let color_scalar_type_name = if is_uint_format { "uint" } else { "int" };
        let color_vec_type_name = format!("{}vec4", scalar_type_prefix(is_uint_format, is_int_format));
        let atomic_coord = atomic_coord_expr(image_type, image_size[0]);
        let invocation_coord = invocation_coord_expr(image_type);
        let shader_image_format_str = get_shader_image_format_qualifier(format);
        let shader_image_type_str = get_shader_image_type(format.type_, image_type);
        let return_value_uniform = if case_type == AtomicOperationCaseType::ReturnValues {
            format!(
                "layout ({shader_image_format_str}, binding=1) writeonly uniform {shader_image_type_str} u_returnValues;\n"
            )
        } else {
            String::new()
        };
        // Storing only when the compare succeeded keeps the stored values in ascending
        // order, which is what the return-value verifier checks for.
        let store_return_value = if case_type == AtomicOperationCaseType::ReturnValues {
            format!(
                "    if(compare == status) imageStore(u_returnValues, {invocation_coord}, {color_vec_type_name}(status));\n"
            )
        } else {
            String::new()
        };

        let source = format!(
            "{version}\n{atomic_ext}{texture_ext}\nprecision highp {shader_image_type_str};\n\
             \n\
             layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
             layout ({shader_image_format_str}, binding=0) coherent uniform {shader_image_type_str} u_results;\n\
             {return_value_uniform}\
             uniform int offset;\n\
             void main (void)\n\
             {{\n\
             \x20   int gx = int(gl_GlobalInvocationID.x) + offset * {image_width};\n\
             \x20   int gy = int(gl_GlobalInvocationID.y);\n\
             \x20   int gz = int(gl_GlobalInvocationID.z);\n\
             \x20   {color_scalar_type_name} compare = {color_scalar_type_name}{compare_arg};\n\
             \x20   {color_scalar_type_name} data    = {color_scalar_type_name}{assign_arg};\n\
             \x20   {color_scalar_type_name} status  = {color_scalar_type_name}(-1);\n\
             \x20   status = imageAtomicCompSwap(u_results, {atomic_coord}, compare, data);\n\
             {store_return_value}\
             }}\n",
            version = glsl_version_decl(context),
            atomic_ext = image_atomic_extension_shader_requires(context),
            texture_ext = texture_type_extension_shader_requires(image_type, context),
            image_width = image_size[0],
            compare_arg = comp_swap_compare_arg_shader_str("gx", "gy", "gz", image_size[0]),
            assign_arg = comp_swap_assign_arg_shader_str("gx", "gy", "gz", image_size[0]),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // SAFETY: a linked program and the image bindings set up above.
        unsafe {
            gl.use_program(program.program());

            let offset_location = gl.get_uniform_location(program.program(), c"offset".as_ptr());
            let dispatch_count = match case_type {
                AtomicOperationCaseType::ReturnValues => num_invocations_per_pixel,
                AtomicOperationCaseType::EndResult => 1,
            };

            for i in 0..dispatch_count {
                // Each pass leaves the next compare value in place, so the stored return
                // values come out in order.
                gl.uniform_1i(offset_location, i);
                gl.dispatch_compute(
                    ((dispatch_count - i) * image_size[0]) as GLuint,
                    image_size[1] as GLuint,
                    num_slices_or_faces as GLuint,
                );
                if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                    case.fail(e.to_string(), "glDispatchCompute failed");
                    return;
                }
                gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
                if let Err(e) = glu::expect_no_error(gl, "glMemoryBarrier") {
                    case.fail(e.to_string(), "glMemoryBarrier failed");
                    return;
                }
            }
        }
    }

    // Create reference, read texture and compare.
    {
        let (texture_to_check_gl, texture_to_check_buf_gl) = match case_type {
            AtomicOperationCaseType::EndResult => (end_result_texture.get(), end_result_texture_buf.get()),
            AtomicOperationCaseType::ReturnValues => (return_value_texture.get(), return_value_texture_buf.get()),
        };
        // The relevant region can differ from the texture size, because a cube map is
        // square and so has unused pixels.
        let width_multiplier = match case_type {
            AtomicOperationCaseType::EndResult => 1,
            AtomicOperationCaseType::ReturnValues => num_invocations_per_pixel,
        };
        let relevant_region = [image_size[0] * width_multiplier, image_size[1], image_size[2]];

        let end_result_verifier = CompSwapEndResultVerifier {
            image_width: image_size[0],
            num_invocations_per_pixel,
        };
        let return_value_verifier = CompSwapReturnValueVerifier {
            end_result_image_width: image_size[0],
            num_invocations_per_pixel,
        };
        let verifier: &dyn ImageLayerVerifier = match case_type {
            AtomicOperationCaseType::EndResult => &end_result_verifier,
            AtomicOperationCaseType::ReturnValues => &return_value_verifier,
        };

        if !read_texture_and_verify(
            case,
            texture_to_check_gl,
            texture_to_check_buf_gl,
            image_type,
            format,
            relevant_region,
            verifier,
        ) {
            case.fail("Image verification failed".to_string(), "Image verification failed");
        }
    }
}

/// `CoherenceCase::Qualifier`
#[derive(Clone, Copy, PartialEq, Eq)]
enum CoherenceQualifier {
    Coherent,
    Volatile,
}

impl CoherenceQualifier {
    fn name(self) -> &'static str {
        match self {
            Self::Coherent => "coherent",
            Self::Volatile => "volatile",
        }
    }
}

/// `CoherenceCase::SHADER_READ_OFFSETS_{X,Y,Z}` and their shader-source spellings.
const SHADER_READ_OFFSETS_X: [i32; 4] = [1, 4, 7, 10];
const SHADER_READ_OFFSETS_Y: [i32; 4] = [2, 5, 8, 11];
const SHADER_READ_OFFSETS_Z: [i32; 4] = [3, 6, 9, 12];
const SHADER_READ_OFFSETS_X_STR: &str = "int[]( 1, 4, 7, 10 )";
const SHADER_READ_OFFSETS_Y_STR: &str = "int[]( 2, 5, 8, 11 )";
const SHADER_READ_OFFSETS_Z_STR: &str = "int[]( 3, 6, 9, 12 )";

/// `CoherenceCase::iterate` - tests the `coherent` or `volatile` qualifier, along with
/// `memoryBarrier()` and `barrier()`.
fn coherence_case(
    case: &mut ApiCase<'_>,
    format: TextureFormat,
    image_type: TextureType,
    qualifier: CoherenceQualifier,
) {
    if !check_texture_type_extensions(case, image_type) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let internal_format_gl = get_internal_format(format);
    let texture_target_gl = get_gl_texture_target(image_type);
    let image_size = default_image_size(image_type);
    let num_slices_or_faces = if image_type == TextureType::Cube {
        6
    } else {
        image_size[2]
    };
    let is_uint_format = is_format_type_unsigned_integer(format.type_);
    let is_int_format = is_format_type_signed_integer(format.type_);
    let texture_buf = glu::Buffer::new(gl);
    let texture = glu::Texture::new(gl);
    let num_groups = [16, 16.min(image_size[1]), 2.min(num_slices_or_faces)];
    let work_item_size = [image_size[0], image_size[1], num_slices_or_faces];
    let local_size = [
        work_item_size[0] / num_groups[0],
        work_item_size[1] / num_groups[1],
        work_item_size[2] / num_groups[2],
    ];

    // Setup texture.
    // SAFETY: names this function just created, on a current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target_gl, texture.get());
        set_tex_parameteri(gl, texture_target_gl);
        set_texture_storage(gl, image_type, internal_format_gl, image_size, texture_buf.get());
        gl.bind_image_texture(
            0,
            texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_WRITE,
            internal_format_gl,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }
    }

    // Perform computations in compute shader.
    {
        let color_vec_type_name = format!("{}vec4", scalar_type_prefix(is_uint_format, is_int_format));
        let color_scalar_type_name = if is_uint_format {
            "uint"
        } else if is_int_format {
            "int"
        } else {
            "float"
        };
        let invocation_coord = invocation_coord_expr(image_type);
        let shader_image_format_str = get_shader_image_format_qualifier(format);
        let shader_image_type_str = get_shader_image_type(format.type_, image_type);
        let [local_size_x, local_size_y, local_size_z] = local_size;
        let read_coord = match image_type {
            TextureType::Buffer => "readX",
            TextureType::Type2D => "ivec2(readX, readY)",
            _ => "ivec3(readX, readY, readZ)",
        };

        let source = format!(
            "{version}\n{extension}\nprecision highp {shader_image_type_str};\n\
             \n\
             layout (local_size_x = {local_size_x}, local_size_y = {local_size_y}, local_size_z = {local_size_z}) in;\n\
             layout ({shader_image_format_str}, binding=0) {qualifier_name} uniform {shader_image_type_str} u_image;\n\
             void main (void)\n\
             {{\n\
             \x20   int gx = int(gl_GlobalInvocationID.x);\n\
             \x20   int gy = int(gl_GlobalInvocationID.y);\n\
             \x20   int gz = int(gl_GlobalInvocationID.z);\n\
             \x20   imageStore(u_image, {invocation_coord}, {color_vec_type_name}(gx^gy^gz));\n\
             \n\
             \x20   memoryBarrier();\n\
             \x20   barrier();\n\
             \n\
             \x20   {color_scalar_type_name} sum = {color_scalar_type_name}(0);\n\
             \x20   int groupBaseX = gx/{local_size_x}*{local_size_x};\n\
             \x20   int groupBaseY = gy/{local_size_y}*{local_size_y};\n\
             \x20   int groupBaseZ = gz/{local_size_z}*{local_size_z};\n\
             \x20   int xOffsets[] = {SHADER_READ_OFFSETS_X_STR};\n\
             \x20   int yOffsets[] = {SHADER_READ_OFFSETS_Y_STR};\n\
             \x20   int zOffsets[] = {SHADER_READ_OFFSETS_Z_STR};\n\
             \x20   for (int i = 0; i < {num_offsets}; i++)\n\
             \x20   {{\n\
             \x20       int readX = groupBaseX + (gx + xOffsets[i]) % {local_size_x};\n\
             \x20       int readY = groupBaseY + (gy + yOffsets[i]) % {local_size_y};\n\
             \x20       int readZ = groupBaseZ + (gz + zOffsets[i]) % {local_size_z};\n\
             \x20       sum += imageLoad(u_image, {read_coord}).x;\n\
             \x20   }}\n\
             \n\
             \x20   memoryBarrier();\n\
             \x20   barrier();\n\
             \n\
             \x20   imageStore(u_image, {invocation_coord}, {color_vec_type_name}(sum));\n\
             }}\n",
            version = glsl_version_decl(context),
            extension = texture_type_extension_shader_requires(image_type, context),
            qualifier_name = qualifier.name(),
            num_offsets = SHADER_READ_OFFSETS_X.len(),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::compute(&source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // SAFETY: a linked program and the image binding set up above.
        unsafe {
            gl.use_program(program.program());
            gl.dispatch_compute(
                num_groups[0] as GLuint,
                num_groups[1] as GLuint,
                num_groups[2] as GLuint,
            );
            if let Err(e) = glu::expect_no_error(gl, "glDispatchCompute") {
                case.fail(e.to_string(), "glDispatchCompute failed");
                return;
            }
        }
    }

    // Create reference, read texture and compare.
    {
        let (mut reference, mut base) = match (
            LayeredImage::new(image_type, format, image_size[0], image_size[1], image_size[2]),
            LayeredImage::new(image_type, format, image_size[0], image_size[1], image_size[2]),
        ) {
            (Ok(reference), Ok(base)) => (reference, base),
            (Err(e), _) | (_, Err(e)) => {
                case.fail(e.to_string(), "Image comparison failed");
                return;
            }
        };

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] {
                    base.set_pixel_int(x, y, z, [x ^ y ^ z; 4]);
                }
            }
        }

        for z in 0..num_slices_or_faces {
            for y in 0..image_size[1] {
                for x in 0..image_size[0] {
                    let group_base_x = x / local_size[0] * local_size[0];
                    let group_base_y = y / local_size[1] * local_size[1];
                    let group_base_z = z / local_size[2] * local_size[2];
                    let mut sum = 0;

                    for i in 0..SHADER_READ_OFFSETS_X.len() {
                        sum += base.get_pixel_int(
                            group_base_x + (x + SHADER_READ_OFFSETS_X[i]) % local_size[0],
                            group_base_y + (y + SHADER_READ_OFFSETS_Y[i]) % local_size[1],
                            group_base_z + (z + SHADER_READ_OFFSETS_Z[i]) % local_size[2],
                        )[0];
                    }

                    reference.set_pixel_int(x, y, z, [sum; 4]);
                }
            }
        }

        let comparer = ImageLayerComparer::new(&reference);
        if !read_texture_and_verify(
            case,
            texture.get(),
            texture_buf.get(),
            image_type,
            format,
            image_size,
            &comparer,
        ) {
            case.fail("Image comparison failed".to_string(), "Image comparison failed");
        }
    }
}

/// `EarlyFragmentTestsCase::TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum EarlyFragmentTestType {
    Depth,
    Stencil,
}

impl EarlyFragmentTestType {
    fn name(self) -> &'static str {
        match self {
            Self::Depth => "depth",
            Self::Stencil => "stencil",
        }
    }
}

/// `EarlyFragmentTestsCase::RenderTargetType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum EarlyFragmentRenderTarget {
    Default,
    Fbo,
    FboWithoutTestAttachment,
}

/// `EarlyFragmentTestsCase::RENDER_SIZE`
const EARLY_FRAGMENT_RENDER_SIZE: i32 = 32;

/// `EarlyFragmentTestsCase::iterate`
///
/// Draws a quad half of which fails the depth or stencil test, with the fragment shader
/// counting its own invocations through an atomic image increment. With
/// `layout(early_fragment_tests)` only the surviving half may run it.
fn early_fragment_tests_case(
    case: &mut ApiCase<'_>,
    name: &str,
    type_: EarlyFragmentTestType,
    use_early_tests: bool,
    render_target: EarlyFragmentRenderTarget,
) {
    // init()
    {
        if case.get_int(glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS) == 0 {
            case.not_supported("GL_MAX_FRAGMENT_IMAGE_UNIFORMS is zero");
            return;
        }
        if !case
            .context()
            .context_info
            .is_extension_supported(IMAGE_ATOMIC_EXT_STRING)
            && !supports_es32(case.context())
        {
            case.not_supported(format!("Test requires {IMAGE_ATOMIC_EXT_STRING} extension"));
            return;
        }

        let target = case.context().render_target();
        if render_target == EarlyFragmentRenderTarget::Default {
            if type_ == EarlyFragmentTestType::Depth && target.depth_bits == 0 {
                case.not_supported("Test requires depth buffer");
                return;
            }
            if type_ == EarlyFragmentTestType::Stencil && target.stencil_bits == 0 {
                case.not_supported("Test requires stencil buffer");
                return;
            }
            if target.width < EARLY_FRAGMENT_RENDER_SIZE || target.height < EARLY_FRAGMENT_RENDER_SIZE {
                case.not_supported(format!(
                    "Render target must have at least {EARLY_FRAGMENT_RENDER_SIZE} width and height"
                ));
                return;
            }
        }
    }

    let context = case.context();
    let gl = case.gl();
    let mut rnd = Random::new(de_string_hash(name));
    let expect_partial_result = use_early_tests && render_target != EarlyFragmentRenderTarget::FboWithoutTestAttachment;
    let viewport_width = EARLY_FRAGMENT_RENDER_SIZE;
    let viewport_height = EARLY_FRAGMENT_RENDER_SIZE;
    let target = context.render_target();
    let (viewport_x, viewport_y) = if render_target == EarlyFragmentRenderTarget::Default {
        (
            rnd.get_int(0, target.width - viewport_width),
            rnd.get_int(0, target.height - viewport_height),
        )
    } else {
        (0, 0)
    };
    let texture = glu::Texture::new(gl);

    // Setup texture.
    // SAFETY: the texture is this function's own, on a current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
        set_tex_parameteri(gl, glw::GL_TEXTURE_2D);

        let mut src = match LayeredImage::new(
            TextureType::Type2D,
            TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32),
            1,
            1,
            1,
        ) {
            Ok(image) => image,
            Err(e) => {
                case.fail(e.to_string(), "Got wrong value");
                return;
            }
        };
        src.set_pixel_int(0, 0, 0, [0; 4]);
        // Always a 2d texture, so no buffer is needed.
        if let Err(e) = upload_texture(gl, &src, 0) {
            case.fail(e.to_string(), "Texture upload failed");
            return;
        }

        gl.bind_image_texture(
            0,
            texture.get(),
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_WRITE,
            glw::GL_R32UI,
        );
        if let Err(e) = glu::expect_no_error(gl, "glBindImageTexture") {
            case.fail(e.to_string(), "glBindImageTexture failed");
            return;
        }
    }

    // Set up framebuffer.
    let _fbo_objects = if render_target == EarlyFragmentRenderTarget::Default {
        None
    } else {
        let fbo = glu::Framebuffer::new(gl);
        let color_attachment = glu::Renderbuffer::new(gl);
        let test_attachment = glu::Renderbuffer::new(gl);

        // SAFETY: names this function just created.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_attachment.get());
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                glw::GL_RGBA8,
                EARLY_FRAGMENT_RENDER_SIZE,
                EARLY_FRAGMENT_RENDER_SIZE,
            );

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                color_attachment.get(),
            );

            if render_target == EarlyFragmentRenderTarget::Fbo {
                let (internal_format, attachment) = match type_ {
                    EarlyFragmentTestType::Depth => (glw::GL_DEPTH_COMPONENT16, glw::GL_DEPTH_ATTACHMENT),
                    EarlyFragmentTestType::Stencil => (glw::GL_STENCIL_INDEX8, glw::GL_STENCIL_ATTACHMENT),
                };
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, test_attachment.get());
                gl.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    internal_format,
                    EARLY_FRAGMENT_RENDER_SIZE,
                    EARLY_FRAGMENT_RENDER_SIZE,
                );
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    attachment,
                    glw::GL_RENDERBUFFER,
                    test_attachment.get(),
                );
            }

            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                color_attachment.get(),
            );
            if let Err(e) = glu::expect_no_error(gl, "setup fbo") {
                case.fail(e.to_string(), "Got wrong value");
                return;
            }
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                case.fail("framebuffer is not complete".to_string(), "Got wrong value");
                return;
            }
        }

        Some((fbo, color_attachment, test_attachment))
    };

    // Set up appropriate conditions for the test.
    // SAFETY: plain state setting on a current context.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);

        match type_ {
            EarlyFragmentTestType::Depth => {
                gl.clear_depthf(0.5);
                gl.clear(glw::GL_DEPTH_BUFFER_BIT);
                gl.enable(glw::GL_DEPTH_TEST);
            }
            EarlyFragmentTestType::Stencil => {
                gl.clear_stencil(0);
                gl.clear(glw::GL_STENCIL_BUFFER_BIT);
                gl.scissor(viewport_x, viewport_y, viewport_width / 2, viewport_height);
                gl.enable(glw::GL_SCISSOR_TEST);
                gl.clear_stencil(1);
                gl.clear(glw::GL_STENCIL_BUFFER_BIT);
                gl.disable(glw::GL_SCISSOR_TEST);
                gl.stencil_func(glw::GL_EQUAL, 1, 1);
                gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
                gl.enable(glw::GL_STENCIL_TEST);
            }
        }
    }

    // Perform image stores in fragment shader.
    {
        let version = glsl_version_decl(context);
        let vertex_source = format!(
            "{version}\n\
             \n\
             highp in vec3 a_position;\n\
             \n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = vec4(a_position, 1.0);\n\
             }}\n"
        );
        let early_tests_layout = if use_early_tests {
            "layout (early_fragment_tests) in;\n\n"
        } else {
            ""
        };
        let fragment_source = format!(
            "{version}\n{atomic_ext}\n{early_tests_layout}\
             layout (location = 0) out highp vec4 o_color;\n\
             \n\
             precision highp uimage2D;\n\
             \n\
             layout (r32ui, binding=0) coherent uniform uimage2D u_image;\n\
             \n\
             void main (void)\n\
             {{\n\
             \x20   imageAtomicAdd(u_image, ivec2(0, 0), uint(1));\n\
             \x20   o_color = vec4(1.0);\n\
             }}\n",
            atomic_ext = image_atomic_extension_shader_requires(context),
        );

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(&vertex_source, &fragment_source));
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }

        // Setup and draw full-viewport quad. The two z extremes straddle the cleared
        // depth of 0.5, so half the quad fails the depth test.
        const VERTEX_POSITIONS: [f32; 4 * 3] = [-1.0, -1.0, -1.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: a linked program on a current context.
        unsafe {
            gl.use_program(program.program());
            gl.viewport(viewport_x, viewport_y, viewport_width, viewport_height);
        }

        let attr_bindings = [glu::va::float("a_position", 3, 4, 0, &VERTEX_POSITIONS)];
        if let Err(e) = glu::draw(
            &context.render_context,
            program.program(),
            &attr_bindings,
            &glu::pr::triangles(&INDICES),
        ) {
            case.fail(e.to_string(), "Draw failed");
            return;
        }
    }

    // Read counter value and check.
    {
        let num_samples = 1.max(target.num_samples);
        let expected_counter = if expect_partial_result {
            viewport_width * viewport_height / 2
        } else {
            viewport_width * viewport_height
        };
        let tolerance = if expect_partial_result {
            viewport_width.max(viewport_height) * 3
        } else {
            0
        };
        let expected_min = 0.max(expected_counter - tolerance) as u32;
        let expected_max = ((expected_counter + tolerance) * num_samples) as u32;

        let verifier = R32UIImageSingleValueVerifier {
            min: expected_min,
            max: expected_max,
        };
        let format = TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32);
        if !read_integer_texture_via_fbo_and_verify(
            case,
            texture.get(),
            TextureType::Type2D,
            format,
            [1, 1, 1],
            &verifier,
        ) {
            case.fail("Got wrong value".to_string(), "Got wrong value");
        }
    }
}

/// The `formats` table `ShaderImageLoadStoreTests::init` walks, in its own order.
const FORMATS: [TextureFormat; 13] = [
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::HALF_FLOAT),
    TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT16),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8),
    TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT16),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT8),
    TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT32),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT8),
];

/// `ShaderImageLoadStoreTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("image_load_store");

    // Upstream's per-type group order, from its `s_imageTypes` loop.
    for image_type in [
        TextureType::Type2D,
        TextureType::Cube,
        TextureType::Type2DArray,
        TextureType::Type3D,
        TextureType::Buffer,
    ] {
        let mut type_group = TestCaseGroup::new(image_type.group_name());
        let mut store_group = TestCaseGroup::new("store");
        let mut load_store_group = TestCaseGroup::new("load_store");
        let mut atomic_group = TestCaseGroup::new("atomic");
        let mut qualifier_group = TestCaseGroup::new("qualifiers");
        let mut reinterpret_group = TestCaseGroup::new("format_reinterpret");
        let layered = texture_layer_type(image_type) != image_type;

        for format in FORMATS {
            let format_name = get_shader_image_format_qualifier(format);

            if image_type == TextureType::Buffer && !is_format_supported_for_texture_buffer(format) {
                continue;
            }

            // Store cases.
            add_api_case(&mut store_group, format_name.clone(), move |case: &mut ApiCase<'_>| {
                image_store_case(case, format, image_type, false);
            });
            if layered {
                add_api_case(
                    &mut store_group,
                    format!("{format_name}_single_layer"),
                    move |case: &mut ApiCase<'_>| {
                        image_store_case(case, format, image_type, true);
                    },
                );
            }

            // Load & store.
            add_api_case(
                &mut load_store_group,
                format_name.clone(),
                move |case: &mut ApiCase<'_>| {
                    image_load_and_store_case(case, format, format, image_type, false, false);
                },
            );
            if layered {
                add_api_case(
                    &mut load_store_group,
                    format!("{format_name}_single_layer"),
                    move |case: &mut ApiCase<'_>| {
                        image_load_and_store_case(case, format, format, image_type, false, true);
                    },
                );
            }

            if format.order == ChannelOrder::R {
                // Atomic operations, then the `coherent`/`volatile` half of `qualifiers` below.
                for operation in ATOMIC_OPERATIONS {
                    for case_type in [
                        AtomicOperationCaseType::EndResult,
                        AtomicOperationCaseType::ReturnValues,
                    ] {
                        if format.type_ == ChannelType::FLOAT && operation != AtomicOperation::Exchange {
                            continue;
                        }

                        let case_type_name = match case_type {
                            AtomicOperationCaseType::EndResult => "result",
                            AtomicOperationCaseType::ReturnValues => "return_value",
                        };
                        let case_name = format!(
                            "{}_{format_name}_{case_type_name}",
                            atomic_operation_case_name(operation)
                        );

                        if operation == AtomicOperation::CompSwap {
                            add_api_case(&mut atomic_group, case_name, move |case: &mut ApiCase<'_>| {
                                atomic_comp_swap_case(case, format, image_type, case_type);
                            });
                        } else {
                            add_api_case(&mut atomic_group, case_name, move |case: &mut ApiCase<'_>| {
                                binary_atomic_operation_case(case, format, image_type, operation, case_type);
                            });
                        }
                    }
                }

                // Coherence.
                for coherence_qualifier in [CoherenceQualifier::Coherent, CoherenceQualifier::Volatile] {
                    let case_name = format!("{}_{format_name}", coherence_qualifier.name());
                    add_api_case(&mut qualifier_group, case_name, move |case: &mut ApiCase<'_>| {
                        coherence_case(case, format, image_type, coherence_qualifier);
                    });
                }
            }
        }

        // Restrict.
        {
            let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32);
            add_api_case(&mut qualifier_group, "restrict", move |case: &mut ApiCase<'_>| {
                image_load_and_store_case(case, format, format, image_type, true, false);
            });
        }

        // Format re-interpretation.
        for tex_fmt in FORMATS {
            for img_fmt in FORMATS {
                if image_type == TextureType::Buffer && !is_format_supported_for_texture_buffer(tex_fmt) {
                    continue;
                }

                if tex_fmt != img_fmt && tex_fmt.pixel_size() == img_fmt.pixel_size() {
                    let name = format!(
                        "{}_{}",
                        get_shader_image_format_qualifier(tex_fmt),
                        get_shader_image_format_qualifier(img_fmt)
                    );
                    add_api_case(&mut reinterpret_group, name, move |case: &mut ApiCase<'_>| {
                        image_load_and_store_case(case, tex_fmt, img_fmt, image_type, false, false);
                    });
                }
            }
        }

        type_group.add_child(store_group);
        type_group.add_child(load_store_group);
        type_group.add_child(atomic_group);
        type_group.add_child(qualifier_group);
        type_group.add_child(reinterpret_group);
        type_group.add_child(image_size_group(image_type));
        group.add_child(type_group);
    }

    // early_fragment_tests cases.
    {
        let mut early_tests_group = TestCaseGroup::new("early_fragment_tests");

        for target_type in [
            EarlyFragmentRenderTarget::Default,
            EarlyFragmentRenderTarget::Fbo,
            EarlyFragmentRenderTarget::FboWithoutTestAttachment,
        ] {
            for use_early_tests in [false, true] {
                for test_type in [EarlyFragmentTestType::Depth, EarlyFragmentTestType::Stencil] {
                    let test_type_name = test_type.name();
                    let target_name = match target_type {
                        EarlyFragmentRenderTarget::Fbo => "_fbo".to_string(),
                        EarlyFragmentRenderTarget::FboWithoutTestAttachment => format!("_fbo_with_no_{test_type_name}"),
                        EarlyFragmentRenderTarget::Default => String::new(),
                    };
                    let case_name = format!(
                        "{}early_fragment_tests_{test_type_name}{target_name}",
                        if use_early_tests { "" } else { "no_" }
                    );

                    add_api_case(
                        &mut early_tests_group,
                        case_name.clone(),
                        move |case: &mut ApiCase<'_>| {
                            early_fragment_tests_case(case, &case_name, test_type, use_early_tests, target_type);
                        },
                    );
                }
            }
        }

        group.add_child(early_tests_group);
    }

    group
}
