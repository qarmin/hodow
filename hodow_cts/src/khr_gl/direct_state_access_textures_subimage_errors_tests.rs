//! `Textures::SubImageErrorsTest` of `gl4cDirectStateAccessTexturesTests.cpp`.

use std::ffi::c_void;

use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome};

static REFERENCE: [glw::GLushort; 256] = [
    0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff,
    0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe,
    0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2,
    0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff, 0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff,
    0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff,
    0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4,
    0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff, 0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f,
    0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff, 0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f,
    0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe, 0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5,
    0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff,
    0x0, 0x0, 0x0, 0xff, 0x7f, 0x7f, 0x7f, 0xff, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff, 0x88, 0x0, 0x15, 0xff,
    0xed, 0x1c, 0x24, 0xff, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x0, 0xff, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92, 0xbe,
    0xff, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0xff, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0xff, 0x0, 0xa2,
    0xe8, 0xff, 0x22, 0xb1, 0x4c, 0xff,
];

const REFERENCE_SIZE: glw::GLsizei = 512;
const REFERENCE_WIDTH: glw::GLsizei = 4;
const REFERENCE_HEIGHT: glw::GLsizei = 4;
const REFERENCE_DEPTH: glw::GLsizei = 4;
const REFERENCE_INTERNALFORMAT: glw::GLenum = glw::GL_RG8;
const REFERENCE_INTERNALFORMAT_COMPRESSED: glw::GLenum = glw::GL_COMPRESSED_RG;
const REFERENCE_FORMAT: glw::GLenum = glw::GL_RG;
const REFERENCE_TYPE: glw::GLenum = glw::GL_UNSIGNED_SHORT;

/// No format and no type constant has the value 1, which is what upstream's search for an unused value ends with.
const FORMAT_INVALID: glw::GLenum = 1;
const TYPE_INVALID: glw::GLenum = 1;

const RGB_ONLY_TYPES: [glw::GLenum; 4] = [
    glw::GL_UNSIGNED_BYTE_3_3_2,
    glw::GL_UNSIGNED_BYTE_2_3_3_REV,
    glw::GL_UNSIGNED_SHORT_5_6_5,
    glw::GL_UNSIGNED_SHORT_5_6_5_REV,
];
const RGBA_ONLY_TYPES: [glw::GLenum; 8] = [
    glw::GL_UNSIGNED_SHORT_4_4_4_4,
    glw::GL_UNSIGNED_SHORT_4_4_4_4_REV,
    glw::GL_UNSIGNED_SHORT_5_5_5_1,
    glw::GL_UNSIGNED_SHORT_1_5_5_5_REV,
    glw::GL_UNSIGNED_INT_8_8_8_8,
    glw::GL_UNSIGNED_INT_8_8_8_8_REV,
    glw::GL_UNSIGNED_INT_10_10_10_2,
    glw::GL_UNSIGNED_INT_2_10_10_10_REV,
];

/// `ErrorsUtilities::CheckErrorAndLog`
fn check_error_and_log(gl: &glw::Functions, expected_error: glw::GLenum, function_name: &str, log: &str) -> bool {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    if error != expected_error {
        log::info!(
            "{function_name} generated error {} but, {} was expected if {log}",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        return false;
    }
    true
}

/// A compressed reference image read back from the driver (`m_reference_compressed_*`); empty `data` is upstream's nullptr.
#[derive(Default)]
struct CompressedReference {
    format: glw::GLint,
    size: glw::GLint,
    data: Vec<glw::GLubyte>,
}

#[derive(Default)]
struct SubImageErrorsObjects {
    to_1d_empty: glw::GLuint,
    to_2d_empty: glw::GLuint,
    to_3d_empty: glw::GLuint,
    to_1d: glw::GLuint,
    to_2d: glw::GLuint,
    to_3d: glw::GLuint,
    to_1d_compressed: glw::GLuint,
    to_2d_compressed: glw::GLuint,
    to_3d_compressed: glw::GLuint,
    to_rectangle_compressed: glw::GLuint,
    bo: glw::GLuint,
}

struct SubImageErrorsState {
    to_invalid: glw::GLuint,
    max_texture_size: glw::GLint,
    reference_1d: CompressedReference,
    reference_2d: CompressedReference,
    reference_3d: CompressedReference,
    reference_rectangle: CompressedReference,
    not_matching_1d: (glw::GLint, glw::GLint),
    not_matching_2d: (glw::GLint, glw::GLint),
    not_matching_3d: (glw::GLint, glw::GLint),
}

/// `Textures::SubImageErrorsTest`
struct TexturesSubImageErrorsTest;

impl TexturesSubImageErrorsTest {
    #[allow(dead_code)]
    fn texture_target(dimensions: u32) -> glw::GLenum {
        match dimensions {
            1 => glw::GL_TEXTURE_1D,
            2 => glw::GL_TEXTURE_2D,
            _ => glw::GL_TEXTURE_3D,
        }
    }

    /// `glTexImage{1,2,3}D` of the reference data with the given internal format and format.
    fn tex_image(
        gl: &glw::Functions,
        target: glw::GLenum,
        internalformat: glw::GLenum,
        format: glw::GLenum,
    ) -> Result<(), TestError> {
        let data = REFERENCE.as_ptr().cast::<c_void>();
        let internalformat = internalformat as glw::GLint;
        // SAFETY: the data pointer refers to the live static array.
        unsafe {
            match target {
                glw::GL_TEXTURE_1D => gl.tex_image_1d(
                    target,
                    0,
                    internalformat,
                    REFERENCE_WIDTH,
                    0,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => gl.tex_image_3d(
                    target,
                    0,
                    internalformat,
                    REFERENCE_WIDTH,
                    REFERENCE_HEIGHT,
                    REFERENCE_DEPTH,
                    0,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                _ => gl.tex_image_2d(
                    target,
                    0,
                    internalformat,
                    REFERENCE_WIDTH,
                    REFERENCE_HEIGHT,
                    0,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
            }
        }
        glu::expect_no_error(gl, "glTexImage has failed")
    }

    /// Creates a texture with a compressed internal format; the compressed image, its format and size are read back when the driver really compressed it.
    fn create_compressed(
        gl: &glw::Functions,
        id: &mut glw::GLuint,
        target: glw::GLenum,
        internalformat: glw::GLenum,
        format: glw::GLenum,
        read_data: bool,
    ) -> Result<CompressedReference, TestError> {
        // SAFETY: the name is written to the live field and then bound.
        unsafe {
            gl.create_textures(target, 1, id);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.bind_texture(target, *id);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
        }
        Self::tex_image(gl, target, internalformat, format)?;

        let mut reference = CompressedReference::default();
        let mut is_compressed: glw::GLint = 0;
        // SAFETY: each query writes one integer to a live local.
        unsafe { gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_COMPRESSED, &mut is_compressed) };
        glu::expect_no_error(gl, "glTetTexLevelParameteriv has failed")?;
        if is_compressed != 0 {
            // SAFETY: as above.
            unsafe { gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_INTERNAL_FORMAT, &mut reference.format) };
            glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;
            reference.size = 0;
            // SAFETY: as above.
            unsafe {
                gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE, &mut reference.size)
            };
            glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;
            if read_data && reference.size != 0 {
                reference.data = vec![0; reference.size as usize];
                // SAFETY: the vector holds the compressed image size reported by the driver.
                unsafe { gl.get_compressed_tex_image(target, 0, reference.data.as_mut_ptr().cast()) };
                glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
            }
        }
        Ok(reference)
    }

    /// The textures of the "format does not match" cases: only the format and size of the compressed image matter.
    fn not_matching(
        gl: &glw::Functions,
        target: glw::GLenum,
        format: glw::GLenum,
    ) -> Result<(glw::GLint, glw::GLint), TestError> {
        let mut texture: glw::GLuint = 0;
        let mut result = (0, 0);
        // SAFETY: the name is written to the live local and then bound.
        unsafe {
            gl.create_textures(target, 1, &mut texture);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.bind_texture(target, texture);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
        }
        Self::tex_image(gl, target, glw::GL_COMPRESSED_RED, format)?;
        let mut is_compressed: glw::GLint = 0;
        // SAFETY: each query writes one integer to a live local.
        unsafe { gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_COMPRESSED, &mut is_compressed) };
        glu::expect_no_error(gl, "glTetTexLevelParameteriv has failed")?;
        if is_compressed != 0 {
            // SAFETY: as above.
            unsafe { gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_INTERNAL_FORMAT, &mut result.0) };
            glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;
            result.1 = 0;
            // SAFETY: as above.
            unsafe { gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE, &mut result.1) };
            glu::expect_no_error(gl, "glGetTexLevelParameteriv has failed")?;
        }
        // SAFETY: deletes the name created above.
        unsafe { gl.delete_textures(1, &texture) };
        glu::expect_no_error(gl, "glCreateTextures has failed")?;
        Ok(result)
    }

    fn prepare(gl: &glw::Functions, o: &mut SubImageErrorsObjects) -> Result<SubImageErrorsState, TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.create_textures(glw::GL_TEXTURE_1D, 1, &mut o.to_1d_empty);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.create_textures(glw::GL_TEXTURE_2D, 1, &mut o.to_2d_empty);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
            gl.create_textures(glw::GL_TEXTURE_3D, 1, &mut o.to_3d_empty);
            glu::expect_no_error(gl, "glCreateTextures has failed")?;
        }

        for (id, target) in [
            (&mut o.to_1d, glw::GL_TEXTURE_1D),
            (&mut o.to_2d, glw::GL_TEXTURE_2D),
            (&mut o.to_3d, glw::GL_TEXTURE_3D),
        ] {
            // SAFETY: the name is written to the live field and then bound.
            unsafe {
                gl.create_textures(target, 1, id);
                glu::expect_no_error(gl, "glCreateTextures has failed")?;
                gl.bind_texture(target, *id);
                glu::expect_no_error(gl, "glBindTexture has failed")?;
            }
            Self::tex_image(gl, target, REFERENCE_INTERNALFORMAT, REFERENCE_FORMAT)?;
        }

        let reference_1d = Self::create_compressed(
            gl,
            &mut o.to_1d_compressed,
            glw::GL_TEXTURE_1D,
            REFERENCE_INTERNALFORMAT_COMPRESSED,
            REFERENCE_FORMAT,
            true,
        )?;
        let reference_2d = Self::create_compressed(
            gl,
            &mut o.to_2d_compressed,
            glw::GL_TEXTURE_2D,
            REFERENCE_INTERNALFORMAT_COMPRESSED,
            REFERENCE_FORMAT,
            true,
        )?;
        let reference_3d = Self::create_compressed(
            gl,
            &mut o.to_3d_compressed,
            glw::GL_TEXTURE_2D_ARRAY,
            REFERENCE_INTERNALFORMAT_COMPRESSED,
            REFERENCE_FORMAT,
            true,
        )?;
        let reference_rectangle = Self::create_compressed(
            gl,
            &mut o.to_rectangle_compressed,
            glw::GL_TEXTURE_RECTANGLE,
            REFERENCE_INTERNALFORMAT_COMPRESSED,
            REFERENCE_FORMAT,
            true,
        )?;

        // SAFETY: the name is written to the live field; the data pointer refers to the live static array.
        unsafe {
            gl.create_buffers(1, &mut o.bo);
            glu::expect_no_error(gl, "glCreateBuffers has failed")?;
            gl.named_buffer_data(
                o.bo,
                REFERENCE_SIZE as glw::GLsizeiptr,
                REFERENCE.as_ptr().cast(),
                glw::GL_STATIC_COPY,
            );
            glu::expect_no_error(gl, "glNamedBufferData has failed")?;
        }

        let mut to_invalid: glw::GLuint = 0;
        loop {
            to_invalid += 1;
            // SAFETY: plain query.
            if unsafe { gl.is_texture(to_invalid) } == glw::FALSE {
                break;
            }
        }
        glu::expect_no_error(gl, "glIsTexture has failed")?;

        let mut max_texture_size: glw::GLint = 1;
        // SAFETY: writes one integer to the live local.
        unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_texture_size) };
        glu::expect_no_error(gl, "glGetIntegerv has failed")?;

        // The 1D texture is created with the reference format, the others with RED.
        let not_matching_1d = Self::not_matching(gl, glw::GL_TEXTURE_1D, REFERENCE_FORMAT)?;
        let not_matching_2d = Self::not_matching(gl, glw::GL_TEXTURE_2D, glw::GL_RED)?;
        let not_matching_3d = Self::not_matching(gl, glw::GL_TEXTURE_3D, glw::GL_RED)?;

        Ok(SubImageErrorsState {
            to_invalid,
            max_texture_size,
            reference_1d,
            reference_2d,
            reference_3d,
            reference_rectangle,
            not_matching_1d,
            not_matching_2d,
            not_matching_3d,
        })
    }

    /// One call of `glTextureSubImage{1,2,3}D`; `offset` and `size` are used up to the number of dimensions.
    #[allow(clippy::too_many_arguments)]
    fn sub_image(
        gl: &glw::Functions,
        dimensions: u32,
        texture: glw::GLuint,
        level: glw::GLint,
        offset: [glw::GLint; 3],
        size: [glw::GLsizei; 3],
        format: glw::GLenum,
        type_: glw::GLenum,
        pixels: *const c_void,
    ) {
        // SAFETY: the calls are expected to fail validation, or read the live reference data.
        unsafe {
            match dimensions {
                1 => gl.texture_sub_image_1d(texture, level, offset[0], size[0], format, type_, pixels),
                2 => gl.texture_sub_image_2d(
                    texture, level, offset[0], offset[1], size[0], size[1], format, type_, pixels,
                ),
                _ => gl.texture_sub_image_3d(
                    texture, level, offset[0], offset[1], offset[2], size[0], size[1], size[2], format, type_, pixels,
                ),
            }
        }
    }

    /// `Test1D`, `Test2D` and `Test3D`.
    fn test_uncompressed(
        gl: &glw::Functions,
        o: &SubImageErrorsObjects,
        s: &SubImageErrorsState,
        dimensions: u32,
    ) -> Result<bool, TestError> {
        let name = format!("glTextureSubImage{dimensions}D");
        let mut is_ok = true;
        let texture = match dimensions {
            1 => o.to_1d,
            2 => o.to_2d,
            _ => o.to_3d,
        };
        let size = [REFERENCE_WIDTH, REFERENCE_HEIGHT, REFERENCE_DEPTH];
        let wider = [REFERENCE_WIDTH + 1, REFERENCE_HEIGHT, REFERENCE_DEPTH];
        let pixels = REFERENCE.as_ptr().cast::<c_void>();
        let none = [0; 3];

        // (texture, level, offset, size, format, type, expected error, log)
        let mut cases: Vec<(
            glw::GLuint,
            glw::GLint,
            [glw::GLint; 3],
            [glw::GLsizei; 3],
            glw::GLenum,
            glw::GLenum,
            glw::GLenum,
            &str,
        )> = vec![
            (
                s.to_invalid,
                0,
                none,
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_OPERATION,
                "texture is not the name of an existing texture object.",
            ),
            (
                texture,
                0,
                none,
                size,
                FORMAT_INVALID,
                REFERENCE_TYPE,
                glw::GL_INVALID_ENUM,
                "format is not an accepted format constant.",
            ),
            (
                texture,
                0,
                none,
                size,
                REFERENCE_FORMAT,
                TYPE_INVALID,
                glw::GL_INVALID_ENUM,
                "type is not an accepted type constant.",
            ),
            (
                texture,
                -1,
                none,
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "level is less than 0.",
            ),
            (
                texture,
                s.max_texture_size,
                none,
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "level is greater than log2 max, where max is the returned value of MAX_TEXTURE_SIZE.",
            ),
            (
                texture,
                0,
                [-1, 0, 0],
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "xoffset<-b, where b is the width of the TEXTURE_BORDER.",
            ),
            (
                texture,
                0,
                [1, 0, 0],
                wider,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "(xoffset+width)>(w-b), where w is the TEXTURE_WIDTH, b is the width of the TEXTURE_BORDER.",
            ),
        ];
        if dimensions >= 2 {
            cases.push((
                texture,
                0,
                [0, -1, 0],
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "yoffset<-b, where b is the width of the TEXTURE_BORDER.",
            ));
            cases.push((
                texture,
                0,
                [0, 1, 0],
                wider,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "(yoffset+height)>(h-b), where h is the TEXTURE_HEIGHT, b is the width of the TEXTURE_BORDER.",
            ));
        }
        if dimensions == 3 {
            cases.push((
                texture,
                0,
                [0, 0, -1],
                size,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "zoffset<-b, where b is the width of the TEXTURE_BORDER.",
            ));
            cases.push((
                texture,
                0,
                [0, 0, 1],
                wider,
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "(zoffset+depth)>(d-b), where d is the TEXTURE_DEPTH, b is the width of the TEXTURE_BORDER.",
            ));
        }
        cases.push((
            texture,
            0,
            none,
            [-1, REFERENCE_HEIGHT, REFERENCE_DEPTH],
            REFERENCE_FORMAT,
            REFERENCE_TYPE,
            glw::GL_INVALID_VALUE,
            "width is less than 0.",
        ));
        if dimensions >= 2 {
            cases.push((
                texture,
                0,
                none,
                [REFERENCE_WIDTH, -1, REFERENCE_DEPTH],
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "height is less than 0.",
            ));
        }
        if dimensions == 3 {
            cases.push((
                texture,
                0,
                none,
                [REFERENCE_WIDTH, REFERENCE_HEIGHT, -1],
                REFERENCE_FORMAT,
                REFERENCE_TYPE,
                glw::GL_INVALID_VALUE,
                "depth is less than 0.",
            ));
        }
        for type_ in RGB_ONLY_TYPES {
            cases.push((texture, 0, none, size, REFERENCE_FORMAT, type_, glw::GL_INVALID_OPERATION, "type is one of UNSIGNED_BYTE_3_3_2, UNSIGNED_BYTE_2_3_3_REV, UNSIGNED_SHORT_5_6_5 or UNSIGNED_SHORT_5_6_5_REV and format is not RGB."));
        }
        for type_ in RGBA_ONLY_TYPES {
            cases.push((
                texture,
                0,
                none,
                size,
                REFERENCE_FORMAT,
                type_,
                glw::GL_INVALID_OPERATION,
                "type is a packed 4/5/8/10 bit type and format is neither RGBA nor BGRA.",
            ));
        }

        for (texture, level, offset, size, format, type_, expected_error, log_message) in cases {
            Self::sub_image(gl, dimensions, texture, level, offset, size, format, type_, pixels);
            is_ok &= check_error_and_log(gl, expected_error, &name, log_message);
        }

        // A mapped pixel unpack buffer, a read beyond the end of the buffer and an unaligned offset.
        // SAFETY: plain state changes; the buffer offsets are relative to the bound pixel unpack buffer.
        unsafe {
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, o.bo);
            glu::expect_no_error(gl, "glBindBuffer has failed")?;
            gl.map_buffer(glw::GL_PIXEL_UNPACK_BUFFER, glw::GL_READ_WRITE);
            if gl.get_error() == glw::GL_NO_ERROR {
                Self::sub_image(
                    gl,
                    dimensions,
                    texture,
                    0,
                    none,
                    size,
                    REFERENCE_FORMAT,
                    REFERENCE_TYPE,
                    std::ptr::null(),
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    &name,
                    "the buffer object's data store is currently mapped.",
                );
                gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
            }

            for (offset, log_message) in [
                ((REFERENCE_SIZE * 2) as usize, "would exceed the data store size."),
                (1, "indicated by type."),
            ] {
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, o.bo);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                Self::sub_image(
                    gl,
                    dimensions,
                    texture,
                    0,
                    none,
                    size,
                    REFERENCE_FORMAT,
                    REFERENCE_TYPE,
                    offset as *const c_void,
                );
                is_ok &= check_error_and_log(gl, glw::GL_INVALID_OPERATION, &name, log_message);
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
            }
        }
        Ok(is_ok)
    }

    #[allow(clippy::too_many_arguments)]
    fn compressed_sub_image(
        gl: &glw::Functions,
        dimensions: u32,
        texture: glw::GLuint,
        format: glw::GLenum,
        image_size: glw::GLsizei,
        data: *const c_void,
    ) {
        // SAFETY: the calls are expected to fail validation, or read the live reference data.
        unsafe {
            match dimensions {
                1 => gl.compressed_texture_sub_image_1d(texture, 0, 0, REFERENCE_WIDTH, format, image_size, data),
                2 => gl.compressed_texture_sub_image_2d(
                    texture,
                    0,
                    0,
                    0,
                    REFERENCE_WIDTH,
                    REFERENCE_HEIGHT,
                    format,
                    image_size,
                    data,
                ),
                _ => gl.compressed_texture_sub_image_3d(
                    texture,
                    0,
                    0,
                    0,
                    0,
                    REFERENCE_WIDTH,
                    REFERENCE_HEIGHT,
                    REFERENCE_DEPTH,
                    format,
                    image_size,
                    data,
                ),
            }
        }
    }

    /// `Test1DCompressed`, `Test2DCompressed` and `Test3DCompressed`.
    fn test_compressed(
        context: &Context,
        o: &SubImageErrorsObjects,
        s: &SubImageErrorsState,
        dimensions: u32,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let name = format!("glCompressedTextureSubImage{dimensions}D");
        let mut is_ok = true;
        let (texture, reference, not_matching, generic_format) = match dimensions {
            1 => (
                o.to_1d_compressed,
                &s.reference_1d,
                s.not_matching_1d,
                glw::GL_COMPRESSED_RG_RGTC2,
            ),
            2 => (
                o.to_2d_compressed,
                &s.reference_2d,
                s.not_matching_2d,
                glw::GL_COMPRESSED_RG,
            ),
            _ => (
                o.to_3d_compressed,
                &s.reference_3d,
                s.not_matching_3d,
                glw::GL_COMPRESSED_RG,
            ),
        };

        if !reference.data.is_empty() {
            let data = reference.data.as_ptr().cast::<c_void>();
            let (format, size) = (reference.format as glw::GLenum, reference.size);

            Self::compressed_sub_image(gl, dimensions, s.to_invalid, format, size, data);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                &name,
                "texture is not the name of an existing texture object.",
            );

            Self::compressed_sub_image(gl, dimensions, texture, generic_format, size, data);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_ENUM,
                &name,
                "internalformat is of the generic compressed internal formats: COMPRESSED_RED, COMPRESSED_RG, COMPRESSED_RGB, COMPRESSED_RGBA. COMPRESSED_SRGB, or COMPRESSED_SRGB_ALPHA.",
            );

            Self::compressed_sub_image(
                gl,
                dimensions,
                texture,
                not_matching.0 as glw::GLenum,
                not_matching.1,
                data,
            );
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_OPERATION,
                &name,
                "format does not match the internal format of the texture image being modified, since these commands do not provide for image format conversion.",
            );

            Self::compressed_sub_image(gl, dimensions, texture, format, size - 1, data);
            is_ok &= check_error_and_log(
                gl,
                glw::GL_INVALID_VALUE,
                &name,
                "imageSize is not consistent with the format, dimensions, and contents of the specified compressed image data.",
            );

            // SAFETY: plain state changes; the buffer offsets are relative to the bound pixel unpack buffer.
            unsafe {
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, o.bo);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                gl.map_buffer(glw::GL_PIXEL_UNPACK_BUFFER, glw::GL_READ_WRITE);
                if gl.get_error() == glw::GL_NO_ERROR {
                    Self::compressed_sub_image(gl, dimensions, texture, format, size, std::ptr::null());
                    is_ok &= check_error_and_log(
                        gl,
                        glw::GL_INVALID_OPERATION,
                        &name,
                        "a non-zero buffer object name is bound to the PIXEL_UNPACK_BUFFER target and the buffer object's data store is currently mapped.",
                    );
                    gl.unmap_buffer(glw::GL_PIXEL_UNPACK_BUFFER);
                    glu::expect_no_error(gl, "glBindBuffer has failed")?;
                    gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
                    glu::expect_no_error(gl, "glBindBuffer has failed")?;
                }

                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, o.bo);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
                Self::compressed_sub_image(
                    gl,
                    dimensions,
                    texture,
                    format,
                    size,
                    (REFERENCE_SIZE * 2) as usize as *const c_void,
                );
                is_ok &= check_error_and_log(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    &name,
                    "a non-zero buffer object name is bound to the PIXEL_UNPACK_BUFFER target and the buffer object's data store is currently mapped.",
                );
                gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
                glu::expect_no_error(gl, "glBindBuffer has failed")?;
            }

            // Only when the implementation supports compressed rectangle textures.
            if dimensions == 2 && !s.reference_rectangle.data.is_empty() {
                let rectangle = &s.reference_rectangle;
                Self::compressed_sub_image(
                    gl,
                    2,
                    o.to_rectangle_compressed,
                    rectangle.format as glw::GLenum,
                    rectangle.size,
                    rectangle.data.as_ptr().cast(),
                );
                let expected = if context
                    .context_info
                    .is_extension_supported("GL_NV_texture_rectangle_compressed")
                {
                    glw::GL_NO_ERROR
                } else {
                    glw::GL_INVALID_OPERATION
                };
                is_ok &= check_error_and_log(
                    gl,
                    expected,
                    &name,
                    "a rectangle texture object is used with this function.",
                );
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for TexturesSubImageErrorsTest {
    fn name(&self) -> &str {
        "textures_subimage_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = SubImageErrorsObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let state = Self::prepare(gl, &mut o)?;
            for dimensions in 1..=3 {
                is_ok &= Self::test_uncompressed(gl, &o, &state, dimensions)?;
            }
            for dimensions in 1..=3 {
                is_ok &= Self::test_compressed(context, &o, &state, dimensions)?;
            }
            Ok(is_ok)
        });

        // SAFETY: deletes names created above.
        unsafe {
            for texture in [
                o.to_1d_empty,
                o.to_2d_empty,
                o.to_3d_empty,
                o.to_1d,
                o.to_2d,
                o.to_3d,
                o.to_1d_compressed,
                o.to_2d_compressed,
                o.to_3d_compressed,
                o.to_rectangle_compressed,
            ] {
                if texture != 0 {
                    gl.delete_textures(1, &texture);
                }
            }
            if o.bo != 0 {
                gl.delete_buffers(1, &o.bo);
            }
        }
        clean_errors(gl);
        outcome
    }
}

pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(TexturesSubImageErrorsTest) as Box<dyn TestCase>);
}
