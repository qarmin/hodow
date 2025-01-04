// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSparseTextureTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `SparseTextureUtils::getTextureTargetString`/`getTextureFormatString` are tables here (every target and format the group uses has a name). The `std::stringstream mLog` of each case is a `String` that is logged when the case fails.
//
// Written without compiling.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus, TextureFormat};

/// One GL call; the pointers it is given point into live locals.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

pub(super) const SPARSE_TEXTURE_COMMITMENT_TARGETS: [GLenum; 6] = [
    glw::GL_TEXTURE_2D,
    glw::GL_TEXTURE_2D_ARRAY,
    glw::GL_TEXTURE_CUBE_MAP,
    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
    glw::GL_TEXTURE_3D,
    glw::GL_TEXTURE_RECTANGLE,
];

pub(super) const SPARSE_TEXTURE_COMMITMENT_FORMATS: [(GLenum, &str); 40] = [
    (glw::GL_R8, "r8"),
    (glw::GL_R8_SNORM, "r8_snorm"),
    (glw::GL_R16, "r16"),
    (glw::GL_R16_SNORM, "r16_snorm"),
    (glw::GL_RG8, "rg8"),
    (glw::GL_RG8_SNORM, "rg8_snorm"),
    (glw::GL_RG16, "rg16"),
    (glw::GL_RG16_SNORM, "rg16_snorm"),
    (glw::GL_RGB565, "rgb565"),
    (glw::GL_RGBA8, "rgba8"),
    (glw::GL_RGBA8_SNORM, "rgba8_snorm"),
    (glw::GL_RGB10_A2, "rgb10_a2"),
    (glw::GL_RGB10_A2UI, "rgb10_a2ui"),
    (glw::GL_RGBA16, "rgba16"),
    (glw::GL_RGBA16_SNORM, "rgba16_snorm"),
    (glw::GL_R16F, "r16f"),
    (glw::GL_RG16F, "rg16f"),
    (glw::GL_RGBA16F, "rgba16f"),
    (glw::GL_R32F, "r32f"),
    (glw::GL_RG32F, "rg32f"),
    (glw::GL_RGBA32F, "rgba32f"),
    (glw::GL_R11F_G11F_B10F, "r11f_g11f_b10f"),
    (glw::GL_RGB9_E5, "rgb9_e5"),
    (glw::GL_R8I, "r8i"),
    (glw::GL_R8UI, "r8ui"),
    (glw::GL_R16I, "r16i"),
    (glw::GL_R16UI, "r16ui"),
    (glw::GL_R32I, "r32i"),
    (glw::GL_R32UI, "r32ui"),
    (glw::GL_RG8I, "rg8i"),
    (glw::GL_RG8UI, "rg8ui"),
    (glw::GL_RG16I, "rg16i"),
    (glw::GL_RG16UI, "rg16ui"),
    (glw::GL_RG32I, "rg32i"),
    (glw::GL_RG32UI, "rg32ui"),
    (glw::GL_RGBA8I, "rgba8i"),
    (glw::GL_RGBA8UI, "rgba8ui"),
    (glw::GL_RGBA16I, "rgba16i"),
    (glw::GL_RGBA16UI, "rgba16ui"),
    (glw::GL_RGBA32I, "rgba32i"),
];

/// `SparseTextureUtils::getTextureTargetString`
pub(super) fn texture_target_string(target: GLenum) -> &'static str {
    match target {
        glw::GL_TEXTURE_1D => "texture_1d",
        glw::GL_TEXTURE_2D => "texture_2d",
        glw::GL_TEXTURE_3D => "texture_3d",
        glw::GL_TEXTURE_CUBE_MAP => "texture_cube_map",
        glw::GL_TEXTURE_2D_ARRAY => "texture_2d_array",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "texture_cube_map_array",
        glw::GL_TEXTURE_2D_MULTISAMPLE => "texture_2d_multisample",
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => "texture_2d_multisample_array",
        0x8C18 => "texture_1d_array",
        0x84F5 => "texture_rectangle",
        0x8D41 => "renderbuffer",
        _ => "null",
    }
}

/// `SparseTextureUtils::getTextureFormatString` over the formats this group registers.
fn texture_format_string(format: GLenum) -> &'static str {
    SPARSE_TEXTURE_COMMITMENT_FORMATS
        .iter()
        .find(|(value, _)| *value == format)
        .map(|(_, name)| *name)
        .unwrap_or("null")
}

/// `TextureState`
#[derive(Clone, Copy, Default)]
pub(super) struct TextureState {
    pub width: GLint,
    pub height: GLint,
    pub depth: GLint,
    pub levels: GLint,
    pub samples: GLint,
    pub format: Option<TextureFormat>,
    pub min_depth: GLint,
    pub page_size_x: GLint,
    pub page_size_y: GLint,
    pub page_size_z: GLint,
}

/// `SparseTextureUtils::verifyQueryError`
pub(super) fn verify_query_error(
    log: &mut String,
    func_name: &str,
    target: GLenum,
    pname: GLenum,
    error: GLenum,
    expected_error: GLenum,
) -> bool {
    if error != expected_error {
        log.push_str(&format!("QueryError [{func_name} return wrong error code, target: {target}, pname: {pname}, expected: {expected_error}, returned: {error}] - "));
        return false;
    }
    true
}

/// `SparseTextureUtils::verifyError`
pub(super) fn verify_error(log: &mut String, func_name: &str, error: GLenum, expected_error: GLenum) -> bool {
    if error != expected_error {
        log.push_str(&format!(
            "Error [{func_name} return wrong error code , expectedError: {expected_error}, returnedError: {error}] - "
        ));
        return false;
    }
    true
}

/// `glGetError` for the `verify*Error` calls.
fn get_error(gl: &glw::Functions) -> GLenum {
    gl!(gl.get_error())
}

/// `SparseTextureUtils::getTargetDepth`
pub(super) fn get_target_depth(target: GLenum) -> GLint {
    if target == glw::GL_TEXTURE_3D
        || target == glw::GL_TEXTURE_1D_ARRAY
        || target == glw::GL_TEXTURE_2D_ARRAY
        || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        || target == glw::GL_TEXTURE_2D
        || target == glw::GL_TEXTURE_RECTANGLE
        || target == glw::GL_TEXTURE_CUBE_MAP
    {
        1
    } else if target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
        6
    } else {
        0
    }
}

/// `SparseTextureUtils::getTexturePageSizes`, as `(x, y, z)`.
pub(super) fn get_texture_page_sizes(
    gl: &glw::Functions,
    target: GLenum,
    format: GLenum,
) -> Result<(GLint, GLint, GLint), TestError> {
    let mut page_size_x: GLint = 0;
    let mut page_size_y: GLint = 0;
    let mut page_size_z: GLint = 0;

    gl!(gl.get_internalformativ(target, format, glw::GL_VIRTUAL_PAGE_SIZE_X_ARB, 1, &mut page_size_x));
    glu::expect_no_error(gl, "getInternalformativ error occurred for GL_VIRTUAL_PAGE_SIZE_X_ARB")?;

    gl!(gl.get_internalformativ(target, format, glw::GL_VIRTUAL_PAGE_SIZE_Y_ARB, 1, &mut page_size_y));
    glu::expect_no_error(gl, "getInternalformativ error occurred for GL_VIRTUAL_PAGE_SIZE_Y_ARB")?;

    gl!(gl.get_internalformativ(target, format, glw::GL_VIRTUAL_PAGE_SIZE_Z_ARB, 1, &mut page_size_z));
    glu::expect_no_error(gl, "getInternalformativ error occurred for GL_VIRTUAL_PAGE_SIZE_Z_ARB")?;

    Ok((page_size_x, page_size_y, page_size_z))
}

/// `SparseTextureUtils::getTextureLevelSize`, as `(width, height, depth)`.
pub(super) fn get_texture_level_size(target: GLenum, state: &TextureState, level: GLint) -> (GLint, GLint, GLint) {
    let divisor = 1 << level;
    let width = state.width / divisor;
    let height = if target == glw::GL_TEXTURE_1D || target == glw::GL_TEXTURE_1D_ARRAY {
        1
    } else {
        state.height / divisor
    };

    let depth = if target == glw::GL_TEXTURE_3D {
        state.depth / divisor
    } else if target == glw::GL_TEXTURE_1D_ARRAY
        || target == glw::GL_TEXTURE_2D_ARRAY
        || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    {
        state.depth
    } else {
        1
    };

    (width, height, depth)
}

/// `Texture::Bind`
pub(super) fn texture_bind(gl: &glw::Functions, id: GLuint, target: GLenum) -> Result<(), TestError> {
    gl!(gl.bind_texture(target, id));
    glu::expect_no_error(gl, "BindTexture")
}

/// `Texture::Generate`
pub(super) fn texture_generate(gl: &glw::Functions) -> Result<GLuint, TestError> {
    let mut id: GLuint = GLuint::MAX;

    gl!(gl.gen_textures(1, &mut id));
    glu::expect_no_error(gl, "GenTextures")?;

    if id == GLuint::MAX {
        return Err(TestError::Fail("Invalid id".to_string()));
    }

    Ok(id)
}

/// `Texture::Delete`
pub(super) fn texture_delete(gl: &glw::Functions, id: GLuint) -> Result<(), TestError> {
    gl!(gl.delete_textures(1, &id));
    glu::expect_no_error(gl, "GenTextures")
}

/// `Texture::Storage`
pub(super) fn texture_storage(
    gl: &glw::Functions,
    target: GLenum,
    levels: GLint,
    internal_format: GLenum,
    width: GLint,
    height: GLint,
    depth: GLint,
) -> Result<(), TestError> {
    match target {
        glw::GL_TEXTURE_1D => gl!(gl.tex_storage_1d(target, levels, internal_format, width)),
        glw::GL_TEXTURE_1D_ARRAY => gl!(gl.tex_storage_2d(target, levels, internal_format, width, depth)),
        glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE | glw::GL_TEXTURE_CUBE_MAP => {
            gl!(gl.tex_storage_2d(target, levels, internal_format, width, height))
        }
        glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
            gl!(gl.tex_storage_3d(target, levels, internal_format, width, height, depth))
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE => {
            gl!(gl.tex_storage_2d_multisample(target, levels, internal_format, width, height, glw::TRUE))
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
            gl!(gl.tex_storage_3d_multisample(target, levels, internal_format, width, height, depth, glw::TRUE))
        }
        _ => return Err(TestError::Fail("Invliad enum".to_string())),
    }
    Ok(())
}

/// `Texture::SubImage`
pub(super) fn texture_sub_image(
    gl: &glw::Functions,
    target: GLenum,
    level: GLint,
    x: GLint,
    y: GLint,
    z: GLint,
    width: GLint,
    height: GLint,
    depth: GLint,
    format: GLenum,
    type_: GLenum,
    pixels: *const std::ffi::c_void,
) -> Result<(), TestError> {
    match target {
        glw::GL_TEXTURE_1D => gl!(gl.tex_sub_image_1d(target, level, x, width, format, type_, pixels)),
        glw::GL_TEXTURE_1D_ARRAY => gl!(gl.tex_sub_image_2d(target, level, x, y, width, depth, format, type_, pixels)),
        glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
            gl!(gl.tex_sub_image_2d(target, level, x, y, width, height, format, type_, pixels))
        }
        glw::GL_TEXTURE_CUBE_MAP => {
            for face in [
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            ] {
                gl!(gl.tex_sub_image_2d(face, level, x, y, width, height, format, type_, pixels));
            }
        }
        glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
            gl!(gl.tex_sub_image_3d(target, level, x, y, z, width, height, depth, format, type_, pixels))
        }
        _ => return Err(TestError::Fail("Invliad enum".to_string())),
    }
    Ok(())
}

pub(super) fn check_sparse_texture_support(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }
    Ok(())
}

pub(super) fn fail_with_log(log: &str, verdict: &str) -> TestOutcome {
    log::info!("{log}{verdict}");
    Ok(TestStatus::fail("Fail"))
}

enum Kind {
    SimpleQueries,
    TextureParameterQueries {
        supported_target: Option<GLenum>,
        not_supported_target: Option<GLenum>,
    },
    InternalFormatQueries {
        target: GLenum,
        format: GLenum,
    },
    SparseTextureAllocation {
        target: Option<GLenum>,
        full_array_target: Option<GLenum>,
        format: GLenum,
    },
    SparseTextureCommitment {
        target: GLenum,
        format: GLenum,
        dsa: bool,
    },
}

struct SparseTextureCase {
    name: String,
    kind: Kind,
}

impl TestCase for SparseTextureCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match &self.kind {
            Kind::SimpleQueries => simple_queries(context),
            Kind::TextureParameterQueries {
                supported_target,
                not_supported_target,
            } => texture_parameter_queries(context, *supported_target, *not_supported_target),
            Kind::InternalFormatQueries { target, format } => internal_format_queries(context, *target, *format),
            Kind::SparseTextureAllocation {
                target,
                full_array_target,
                format,
            } => sparse_texture_allocation(context, *target, *full_array_target, *format),
            Kind::SparseTextureCommitment { target, format, dsa } => {
                sparse_texture_commitment(context, *target, *format, *dsa)
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// SimpleQueriesTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn simple_queries(context: &Context) -> TestOutcome {
    check_sparse_texture_support(context)?;
    let gl = context.gl();

    test_simple_queries(gl, glw::GL_MAX_SPARSE_TEXTURE_SIZE_ARB)?;
    test_simple_queries(gl, glw::GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB)?;
    test_simple_queries(gl, glw::GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB)?;
    test_simple_queries(gl, glw::GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB)?;

    Ok(TestStatus::pass("Pass"))
}

/// `SimpleQueriesTestCase::testSipmleQueries`
fn test_simple_queries(gl: &glw::Functions, pname: GLenum) -> Result<(), TestError> {
    let mut log = format!("Testing simple query for pname: {pname} - ");

    let mut value_int: GLint = 0;
    let mut value_int64: glw::GLint64 = 0;
    let mut value_float: f32 = 0.0;
    let mut value_double: f64 = 0.0;
    let mut value_bool: glw::GLboolean = 0;

    gl!(gl.get_integerv(pname, &mut value_int));
    let mut result = verify_error(&mut log, "getIntegerv", get_error(gl), glw::GL_NO_ERROR);

    if result {
        gl!(gl.get_integer_64v(pname, &mut value_int64));
        result = verify_error(&mut log, "getInteger64v", get_error(gl), glw::GL_NO_ERROR);

        if result {
            gl!(gl.get_floatv(pname, &mut value_float));
            result = verify_error(&mut log, "getFloatv", get_error(gl), glw::GL_NO_ERROR);

            if result {
                gl!(gl.get_doublev(pname, &mut value_double));
                result = verify_error(&mut log, "getDoublev", get_error(gl), glw::GL_NO_ERROR);

                if result {
                    gl!(gl.get_booleanv(pname, &mut value_bool));
                    result = verify_error(&mut log, "getBooleanv", get_error(gl), glw::GL_NO_ERROR);
                }
            }
        }
    }

    if !result {
        return Err(TestError::Fail(log));
    }
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// TextureParameterQueriesTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn texture_parameter_queries(
    context: &Context,
    supported_target: Option<GLenum>,
    not_supported_target: Option<GLenum>,
) -> TestOutcome {
    check_sparse_texture_support(context)?;
    let gl = context.gl();
    let mut log = String::new();

    if let Some(target) = supported_target {
        log.clear();

        let texture = texture_generate(gl)?;
        texture_bind(gl, texture, target)?;

        let result = test_texture_sparse_arb(gl, &mut log, target, glw::GL_NO_ERROR)?
            && test_virtual_page_size_index_arb(gl, &mut log, target, glw::GL_NO_ERROR)?
            && test_num_sparse_levels_arb(gl, &mut log, target);

        texture_delete(gl, texture)?;

        if !result {
            return fail_with_log(&log, "Fail [positive tests]");
        }
    }

    if context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    } else if let Some(target) = not_supported_target {
        log.clear();

        let texture = texture_generate(gl)?;
        texture_bind(gl, texture, target)?;

        let result = test_texture_sparse_arb(gl, &mut log, target, glw::GL_INVALID_VALUE)?;

        texture_delete(gl, texture)?;

        if !result {
            log::info!("{log}Fail [positive tests]");
            return Ok(TestStatus::fail("Fail on negative tests"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// The six `glTexParameter*` setters, with the value each one is given, shared by `testTextureSparseARB` and `testVirtualPageSizeIndexARB`.
fn test_tex_parameter_setters(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    pname: GLenum,
    values: [GLint; 6],
    default_value: GLint,
    reset_value: GLint,
    expected_error: GLenum,
) -> Result<bool, TestError> {
    let mut result = true;

    if expected_error == glw::GL_NO_ERROR {
        result = check_get_tex_parameter(gl, log, target, pname, default_value)?;
    }

    const NAMES: [&str; 6] = [
        "glTexParameteri",
        "glTexParameterf",
        "glTexParameteriv",
        "glTexParameterfv",
        "glTexParameterIiv",
        "glTexParameterIuiv",
    ];

    for (index, name) in NAMES.iter().enumerate() {
        if !result {
            break;
        }

        let value = values[index];
        match index {
            0 => gl!(gl.tex_parameteri(target, pname, value)),
            1 => gl!(gl.tex_parameterf(target, pname, value as f32)),
            2 => gl!(gl.tex_parameteriv(target, pname, &value)),
            3 => {
                let value_float = value as f32;
                gl!(gl.tex_parameterfv(target, pname, &value_float));
            }
            4 => gl!(gl.tex_parameter_iiv(target, pname, &value)),
            _ => {
                let value_uint = value as GLuint;
                gl!(gl.tex_parameter_iuiv(target, pname, &value_uint));
            }
        }

        if expected_error == glw::GL_NO_ERROR {
            glu::expect_no_error(gl, &format!("{name} error occurred."))?;
            result = check_get_tex_parameter(gl, log, target, pname, value)?;

            gl!(gl.tex_parameteri(target, pname, reset_value));
            glu::expect_no_error(gl, "glTexParameteri error occurred.")?;
        } else {
            result = verify_query_error(log, name, target, pname, get_error(gl), expected_error);
        }
    }

    Ok(result)
}

/// `TextureParameterQueriesTestCase::testTextureSparseARB`
fn test_texture_sparse_arb(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    expected_error: GLenum,
) -> Result<bool, TestError> {
    log.push_str(&format!("Testing TEXTURE_SPARSE_ARB for target: {target} - "));

    let true_value = glw::GL_TRUE as GLint;
    test_tex_parameter_setters(
        gl,
        log,
        target,
        glw::GL_TEXTURE_SPARSE_ARB,
        [true_value; 6],
        glw::GL_FALSE as GLint,
        glw::GL_FALSE as GLint,
        expected_error,
    )
}

/// `TextureParameterQueriesTestCase::testVirtualPageSizeIndexARB`
fn test_virtual_page_size_index_arb(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    expected_error: GLenum,
) -> Result<bool, TestError> {
    log.push_str(&format!("Testing VIRTUAL_PAGE_SIZE_INDEX_ARB for target: {target} - "));

    test_tex_parameter_setters(
        gl,
        log,
        target,
        glw::GL_VIRTUAL_PAGE_SIZE_INDEX_ARB,
        [1, 2, 8, 10, 6, 16],
        0,
        0,
        expected_error,
    )
}

/// `TextureParameterQueriesTestCase::testNumSparseLevelsARB`
fn test_num_sparse_levels_arb(gl: &glw::Functions, log: &mut String, target: GLenum) -> bool {
    let pname = glw::GL_NUM_SPARSE_LEVELS_ARB;

    let mut value_int: GLint = 0;
    let mut value_uint: GLuint = 0;
    let mut value_float: f32 = 0.0;

    log.push_str(&format!("Testing NUM_SPARSE_LEVELS_ARB for target: {target} - "));

    gl!(gl.get_tex_parameteriv(target, pname, &mut value_int));
    let mut result = verify_error(log, "glGetTexParameteriv", get_error(gl), glw::GL_NO_ERROR);

    if result {
        gl!(gl.get_tex_parameterfv(target, pname, &mut value_float));
        result = verify_error(log, "glGetTexParameterfv", get_error(gl), glw::GL_NO_ERROR);

        if result {
            gl!(gl.get_tex_parameter_iiv(target, pname, &mut value_int));
            result = verify_error(log, "glGetGexParameterIiv", get_error(gl), glw::GL_NO_ERROR);

            if result {
                gl!(gl.get_tex_parameter_iuiv(target, pname, &mut value_uint));
                result = verify_error(log, "getTexParameterIuiv", get_error(gl), glw::GL_NO_ERROR);
            }
        }
    }

    result
}

/// `TextureParameterQueriesTestCase::checkGetTexParameter`
fn check_get_tex_parameter(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    pname: GLenum,
    expected: GLint,
) -> Result<bool, TestError> {
    let mut result = true;

    let mut value_int: GLint = 0;
    let mut value_uint: GLuint = 0;
    let mut value_float: f32 = 0.0;

    log.push_str(&format!("Testing GetTexParameter for target: {target} - "));

    gl!(gl.get_tex_parameteriv(target, pname, &mut value_int));
    glu::expect_no_error(gl, "glGetTexParameteriv error occurred")?;
    if value_int != expected {
        log.push_str(&format!("glGetTexParameteriv return wrong value, target: {target}, pname: {pname}, expected: {expected}, returned: {value_int} - "));
        result = false;
    }

    gl!(gl.get_tex_parameterfv(target, pname, &mut value_float));
    glu::expect_no_error(gl, "glGetTexParameterfv error occurred")?;
    if value_float as GLint != expected {
        log.push_str(&format!("glGetTexParameterfv return wrong value, target: {target}, pname: {pname}, expected: {expected}, returned: {} - ", value_float as GLint));
        result = false;
    }

    gl!(gl.get_tex_parameter_iiv(target, pname, &mut value_int));
    glu::expect_no_error(gl, "glGetGexParameterIiv error occurred")?;
    if value_int != expected {
        log.push_str(&format!("glGetGexParameterIiv return wrong value, target: {target}, pname: {pname}, expected: {expected}, returned: {value_int} - "));
        result = false;
    }

    gl!(gl.get_tex_parameter_iuiv(target, pname, &mut value_uint));
    glu::expect_no_error(gl, "glGetGexParameterIui error occurred")?;
    if value_uint as GLint != expected {
        log.push_str(&format!("glGetGexParameterIui return wrong value, target: {target}, pname: {pname}, expected: {expected}, returned: {} - ", value_uint as GLint));
        result = false;
    }

    Ok(result)
}

// ---------------------------------------------------------------------------------------------------------------------
// InternalFormatQueriesTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn internal_format_queries(context: &Context, target: GLenum, format: GLenum) -> TestOutcome {
    check_sparse_texture_support(context)?;
    let gl = context.gl();

    let mut log = String::from("Testing getInternalformativ - ");
    let mut value: GLint = 0;

    gl!(gl.get_internalformativ(target, format, glw::GL_NUM_VIRTUAL_PAGE_SIZES_ARB, 1, &mut value));
    glu::expect_no_error(
        gl,
        "getInternalformativ error occurred for GL_NUM_VIRTUAL_PAGE_SIZES_ARB",
    )?;
    if value == 0 {
        log.push_str(&format!("getInternalformativ for GL_NUM_VIRTUAL_PAGE_SIZES_ARB, target: {target}, format: {format} returns wrong value: {value} - "));
        return fail_with_log(&log, "Fail");
    }

    get_texture_page_sizes(gl, target, format)?;

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTextureAllocationTestCase
// ---------------------------------------------------------------------------------------------------------------------

pub(super) fn sparse_texture_allocation(
    context: &Context,
    target: Option<GLenum>,
    full_array_target: Option<GLenum>,
    format: GLenum,
) -> TestOutcome {
    check_sparse_texture_support(context)?;
    let gl = context.gl();
    let mut log = String::new();

    if let Some(target) = target {
        log.clear();
        log.push_str(&format!(
            "Testing sparse texture allocation for target: {target}, format: {format} - "
        ));

        let result = allocation_positive_testing(gl, &mut log, target, format)?
            && allocation_verify_tex_parameter_errors(gl, &mut log, target, format)?
            && allocation_verify_virtual_page_size_index_error(gl, &mut log, target, format)?
            && allocation_verify_full_array_cube_mipmaps_error(gl, &mut log, target, format)?
            && allocation_verify_invalid_value_errors(context, &mut log, target, format)?;

        if !result {
            return fail_with_log(&log, "Fail");
        }
    }

    if let Some(full_array_target) = full_array_target {
        log.clear();
        log.push_str(&format!(
            "Testing sparse texture allocation for target [full array]: {full_array_target}, format: {format} - "
        ));

        let result = allocation_verify_full_array_cube_mipmaps_error(gl, &mut log, full_array_target, format)?;

        if !result {
            return fail_with_log(&log, "Fail");
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `SparseTextureAllocationTestCase::positiveTesting`
fn allocation_positive_testing(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    format: GLenum,
) -> Result<bool, TestError> {
    log.push_str("Positive Testing - ");

    let texture = texture_generate(gl)?;
    texture_bind(gl, texture, target)?;

    let depth = get_target_depth(target);
    let (mut page_size_x, mut page_size_y, page_size_z) = get_texture_page_sizes(gl, target, format)?;

    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));
    if !verify_error(log, "texParameteri", get_error(gl), glw::GL_NO_ERROR) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    if target == glw::GL_TEXTURE_CUBE_MAP || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
        if page_size_x > page_size_y {
            page_size_y = page_size_x;
        } else if page_size_x < page_size_y {
            page_size_x = page_size_y;
        }
    }

    texture_storage(gl, target, 1, format, page_size_x, page_size_y, depth * page_size_z)?;
    if !verify_error(log, "Texture::Storage", get_error(gl), glw::GL_NO_ERROR) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    texture_delete(gl, texture)?;
    Ok(true)
}

/// The six `glTexParameter*` calls of `verifyTexParameterErrors`, each expected to raise `GL_INVALID_OPERATION`.
fn allocation_verify_tex_parameter_errors(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    format: GLenum,
) -> Result<bool, TestError> {
    log.push_str("Verify TexParameter errors - ");

    let mut result = true;

    let texture = texture_generate(gl)?;
    texture_bind(gl, texture, target)?;

    let depth = get_target_depth(target);

    texture_storage(gl, target, 1, format, 8, 8, depth)?;
    if !verify_error(log, "TexStorage", get_error(gl), glw::GL_NO_ERROR) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    let mut immutable_format: GLint = 0;

    gl!(gl.get_tex_parameteriv(target, glw::GL_TEXTURE_IMMUTABLE_FORMAT, &mut immutable_format));
    if !verify_query_error(
        log,
        "getTexParameteriv",
        target,
        glw::GL_TEXTURE_IMMUTABLE_FORMAT,
        get_error(gl),
        glw::GL_NO_ERROR,
    ) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    if immutable_format == glw::GL_TRUE as GLint {
        const NAMES: [&str; 6] = [
            "glTexParameteri",
            "glTexParameterf",
            "glTexParameteriv",
            "glTexParameterfv",
            "glTexParameterIiv",
            "glTexParameterIuiv",
        ];

        for (pname, value) in [
            (glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint),
            (glw::GL_VIRTUAL_PAGE_SIZE_INDEX_ARB, 1),
        ] {
            for (index, name) in NAMES.iter().enumerate() {
                if !result {
                    break;
                }

                match index {
                    0 => gl!(gl.tex_parameteri(target, pname, value)),
                    1 => gl!(gl.tex_parameterf(target, pname, value as f32)),
                    2 => gl!(gl.tex_parameteriv(target, pname, &value)),
                    3 => {
                        let value_float = value as f32;
                        gl!(gl.tex_parameterfv(target, pname, &value_float));
                    }
                    4 => gl!(gl.tex_parameter_iiv(target, pname, &value)),
                    _ => {
                        let value_uint = value as GLuint;
                        gl!(gl.tex_parameter_iuiv(target, pname, &value_uint));
                    }
                }
                result = verify_query_error(log, name, target, pname, get_error(gl), glw::GL_INVALID_OPERATION);
            }
        }
    }

    texture_delete(gl, texture)?;
    Ok(result)
}

/// `SparseTextureAllocationTestCase::verifyTexStorageVirtualPageSizeIndexError`
fn allocation_verify_virtual_page_size_index_error(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    format: GLenum,
) -> Result<bool, TestError> {
    log.push_str("Verify VirtualPageSizeIndex errors - ");

    let texture = texture_generate(gl)?;
    texture_bind(gl, texture, target)?;

    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));
    if !verify_query_error(
        log,
        "texParameteri",
        target,
        glw::GL_TEXTURE_SPARSE_ARB,
        get_error(gl),
        glw::GL_NO_ERROR,
    ) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    let mut num_page_sizes: GLint = 0;
    gl!(gl.get_internalformativ(
        target,
        format,
        glw::GL_NUM_VIRTUAL_PAGE_SIZES_ARB,
        1,
        &mut num_page_sizes
    ));
    if !verify_query_error(
        log,
        "getInternalformativ",
        target,
        glw::GL_NUM_VIRTUAL_PAGE_SIZES_ARB,
        get_error(gl),
        glw::GL_NO_ERROR,
    ) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    num_page_sizes += 1;
    gl!(gl.tex_parameteri(target, glw::GL_VIRTUAL_PAGE_SIZE_INDEX_ARB, num_page_sizes));
    if !verify_query_error(
        log,
        "texParameteri",
        target,
        glw::GL_VIRTUAL_PAGE_SIZE_INDEX_ARB,
        get_error(gl),
        glw::GL_NO_ERROR,
    ) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    let depth = get_target_depth(target);

    texture_storage(gl, target, 1, format, 8, 8, depth)?;
    if !verify_error(log, "TexStorage", get_error(gl), glw::GL_INVALID_OPERATION) {
        texture_delete(gl, texture)?;
        return Ok(false);
    }

    texture_delete(gl, texture)?;
    Ok(true)
}

/// `SparseTextureAllocationTestCase::verifyTexStorageFullArrayCubeMipmapsError`
fn allocation_verify_full_array_cube_mipmaps_error(
    gl: &glw::Functions,
    log: &mut String,
    target: GLenum,
    format: GLenum,
) -> Result<bool, TestError> {
    log.push_str("Verify FullArrayCubeMipmaps errors - ");

    let mut result = true;

    let depth = get_target_depth(target);

    let mut full_array_cube_mipmaps: glw::GLboolean = 0;

    gl!(gl.get_booleanv(
        glw::GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB,
        &mut full_array_cube_mipmaps
    ));
    if !verify_query_error(
        log,
        "getBooleanv",
        target,
        glw::GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB,
        get_error(gl),
        glw::GL_NO_ERROR,
    ) {
        return Ok(false);
    }

    if full_array_cube_mipmaps == glw::FALSE
        && (target == glw::GL_TEXTURE_2D_ARRAY
            || target == glw::GL_TEXTURE_CUBE_MAP
            || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY)
    {
        let texture = texture_generate(gl)?;
        texture_bind(gl, texture, target)?;

        let (page_size_x, page_size_y, _page_size_z) = get_texture_page_sizes(gl, target, format)?;

        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));

        let levels: GLint = 4;
        let width = page_size_x * (1 << (levels - 1));
        let height = page_size_y * (1 << (levels - 1));

        if target == glw::GL_TEXTURE_CUBE_MAP || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            let width_height = width.max(height);
            let page_size = page_size_x.max(page_size_y);
            texture_storage(
                gl,
                target,
                levels,
                format,
                width_height + page_size,
                width_height + page_size,
                depth,
            )?;
            result = verify_error(
                log,
                "TexStorage [wrong width]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            );
        } else {
            texture_storage(gl, target, levels, format, width + page_size_x, height, depth)?;
            result = verify_error(
                log,
                "TexStorage [wrong width]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            );

            if result {
                texture_storage(gl, target, levels, format, width, height + page_size_y, depth)?;
                result = verify_error(
                    log,
                    "TexStorage [wrong height]",
                    get_error(gl),
                    glw::GL_INVALID_OPERATION,
                );
            }
        }

        texture_delete(gl, texture)?;
    }

    Ok(result)
}

/// `SparseTextureAllocationTestCase::verifyTexStorageInvalidValueErrors`
fn allocation_verify_invalid_value_errors(
    context: &Context,
    log: &mut String,
    target: GLenum,
    format: GLenum,
) -> Result<bool, TestError> {
    let gl = context.gl();
    log.push_str("Verify Invalid Value errors - ");

    let texture = texture_generate(gl)?;
    texture_bind(gl, texture, target)?;

    let (page_size_x, page_size_y, page_size_z) = get_texture_page_sizes(gl, target, format)?;

    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));

    let width = page_size_x;
    let height = page_size_y;
    let depth = get_target_depth(target) * page_size_z;

    if target == glw::GL_TEXTURE_3D {
        let mut max_3d_texture_size: GLint = 0;

        gl!(gl.get_integerv(glw::GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB, &mut max_3d_texture_size));
        if !verify_query_error(
            log,
            "getIntegerv",
            target,
            glw::GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB,
            get_error(gl),
            glw::GL_NO_ERROR,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        texture_storage(gl, target, 1, format, width + max_3d_texture_size, height, depth)?;
        if !verify_error(
            log,
            "TexStorage [GL_TEXTURE_3D wrong width]",
            get_error(gl),
            glw::GL_INVALID_VALUE,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        texture_storage(gl, target, 1, format, width, height + max_3d_texture_size, depth)?;
        if !verify_error(
            log,
            "TexStorage [GL_TEXTURE_3D wrong height]",
            get_error(gl),
            glw::GL_INVALID_VALUE,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        if context.context_info.is_extension_supported("GL_NV_deep_texture3D") {
            let mut max_texture_width_height: GLint = 0;
            gl!(gl.get_integerv(glw::GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV, &mut max_texture_width_height));

            if width < max_texture_width_height && height < max_texture_width_height {
                gl!(gl.get_integerv(glw::GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV, &mut max_3d_texture_size));
            }
        }

        texture_storage(gl, target, 1, format, width, height, depth + max_3d_texture_size)?;
        if !verify_error(
            log,
            "TexStorage [GL_TEXTURE_3D wrong depth]",
            get_error(gl),
            glw::GL_INVALID_VALUE,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }
    } else {
        let mut max_texture_size: GLint = 0;

        gl!(gl.get_integerv(glw::GL_MAX_SPARSE_TEXTURE_SIZE_ARB, &mut max_texture_size));
        if !verify_query_error(
            log,
            "getIntegerv",
            target,
            glw::GL_MAX_SPARSE_TEXTURE_SIZE_ARB,
            get_error(gl),
            glw::GL_NO_ERROR,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        texture_storage(gl, target, 1, format, width + max_texture_size, height, depth)?;
        if !verify_error(
            log,
            "TexStorage [!GL_TEXTURE_3D wrong width]",
            get_error(gl),
            glw::GL_INVALID_VALUE,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        if target != glw::GL_TEXTURE_1D_ARRAY {
            texture_storage(gl, target, 1, format, width, height + max_texture_size, depth)?;
            if !verify_error(
                log,
                "TexStorage [!GL_TEXTURE_3D wrong height]",
                get_error(gl),
                glw::GL_INVALID_VALUE,
            ) {
                texture_delete(gl, texture)?;
                return Ok(false);
            }
        }

        let mut max_array_texture_layers: GLint = 0;

        gl!(gl.get_integerv(
            glw::GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB,
            &mut max_array_texture_layers
        ));
        if !verify_query_error(
            log,
            "getIntegerv",
            target,
            glw::GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB,
            get_error(gl),
            glw::GL_NO_ERROR,
        ) {
            texture_delete(gl, texture)?;
            return Ok(false);
        }

        if target == glw::GL_TEXTURE_1D_ARRAY
            || target == glw::GL_TEXTURE_2D_ARRAY
            || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        {
            texture_storage(gl, target, 1, format, width, height, depth + max_array_texture_layers)?;
            if !verify_error(
                log,
                "TexStorage [ARRAY wrong depth]",
                get_error(gl),
                glw::GL_INVALID_VALUE,
            ) {
                texture_delete(gl, texture)?;
                return Ok(false);
            }
        }
    }

    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        if page_size_x > 1 {
            texture_storage(gl, target, 1, format, page_size_x + 1, height, depth)?;
            if !verify_error(log, "TexStorage [wrong width]", get_error(gl), glw::GL_INVALID_VALUE) {
                texture_delete(gl, texture)?;
                return Ok(false);
            }
        }

        if page_size_y > 1 {
            texture_storage(gl, target, 1, format, width, page_size_y + 1, depth)?;
            if !verify_error(log, "TexStorage [wrong height]", get_error(gl), glw::GL_INVALID_VALUE) {
                texture_delete(gl, texture)?;
                return Ok(false);
            }
        }

        if page_size_z > 1 {
            texture_storage(gl, target, 1, format, width, height, page_size_z + 1)?;
            if !verify_error(log, "TexStorage [wrong depth]", get_error(gl), glw::GL_INVALID_VALUE) {
                texture_delete(gl, texture)?;
                return Ok(false);
            }
        }
    }

    texture_delete(gl, texture)?;
    Ok(true)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTextureCommitmentTestCase / SparseDSATextureCommitmentTestCase
// ---------------------------------------------------------------------------------------------------------------------

/// The members of `SparseTextureCommitmentTestCase` that `iterate` mutates, with the DSA subclass reduced to a flag on `tex_page_commitment`.
pub(super) struct Commitment<'a> {
    pub gl: &'a glw::Functions,
    pub target: GLenum,
    pub format: GLenum,
    pub dsa: bool,
    pub log: String,
    pub state: TextureState,
    /// The `SparseTexture2CommitmentTestCase` overrides of `sparseAllocateTexture`/`allocateTexture` (multisample targets).
    pub v2: bool,
    /// Page-size multiple of the allocated size: 2 here, 4 in `SparseTextureClampLookupColorTestCase::prepareTexture`.
    pub scale: GLint,
}

fn sparse_texture_commitment(context: &Context, target: GLenum, format: GLenum, dsa: bool) -> TestOutcome {
    check_sparse_texture_support(context)?;

    if dsa
        && !context
            .context_info
            .is_extension_supported("GL_EXT_direct_state_access")
    {
        return Err(TestError::NotSupported(
            "GL_EXT_direct_state_access extension is not supported.".to_string(),
        ));
    }

    let mut case = Commitment {
        gl: context.gl(),
        target,
        format,
        dsa,
        log: String::new(),
        state: TextureState::default(),
        v2: false,
        scale: 2,
    };
    let gl = case.gl;

    if dsa {
        case.log.push_str(&format!(
            "Testing DSA sparse texture commitment for target: {target}, format: {format} - "
        ));
    } else {
        case.log.push_str(&format!(
            "Testing sparse texture commitment for target: {target}, format: {format} - "
        ));
    }

    let mut result = true;

    let mut texture = case.sparse_allocate_texture(3)?;
    if !dsa {
        for level in 0..case.state.levels {
            case.write_data_to_texture(level)?;
        }
    }

    for level in 0..case.state.levels {
        if case.commit_texture_page(texture, level)? {
            case.write_data_to_texture(level)?;
            result = case.verify_texture_data(level)?;
        }

        if !result {
            break;
        }
    }

    texture_delete(gl, texture)?;

    result = result && case.verify_invalid_operation_errors(&mut texture)?;
    result = result && case.verify_invalid_value_errors(&mut texture)?;

    if !result {
        return fail_with_log(&case.log, "Fail");
    }

    Ok(TestStatus::pass("Pass"))
}

impl Commitment<'_> {
    /// `texPageCommitment`, both the `glTexPageCommitmentARB` and the `glTexturePageCommitmentEXT` form.
    pub(super) fn tex_page_commitment(
        &self,
        texture: GLuint,
        level: GLint,
        x_offset: GLint,
        y_offset: GLint,
        z_offset: GLint,
        width: GLint,
        height: GLint,
        depth: GLint,
        commit: bool,
    ) -> Result<(), TestError> {
        let gl = self.gl;
        let commit = if commit { glw::TRUE } else { glw::FALSE };

        if self.dsa {
            gl!(gl.texture_page_commitment_ext(
                texture, level, x_offset, y_offset, z_offset, width, height, depth, commit
            ));
        } else {
            texture_bind(gl, texture, self.target)?;
            gl!(gl.tex_page_commitment_arb(
                self.target,
                level,
                x_offset,
                y_offset,
                z_offset,
                width,
                height,
                depth,
                commit
            ));
        }
        Ok(())
    }

    pub(super) fn pixel_size(&self) -> Result<GLint, TestError> {
        let format = self
            .state
            .format
            .ok_or_else(|| TestError::Fail("texture format is not mapped".to_string()))?;
        format
            .pixel_size()
            .map(|size| size as GLint)
            .ok_or_else(|| TestError::Fail("texture format has no pixel size".to_string()))
    }

    /// `prepareTexture`
    pub(super) fn prepare_texture(&mut self) -> Result<GLuint, TestError> {
        let gl = self.gl;
        let texture = texture_generate(gl)?;
        texture_bind(gl, texture, self.target)?;

        self.state.min_depth = get_target_depth(self.target);
        let (page_size_x, page_size_y, page_size_z) = get_texture_page_sizes(gl, self.target, self.format)?;
        self.state.page_size_x = page_size_x;
        self.state.page_size_y = page_size_y;
        self.state.page_size_z = page_size_z;

        if self.target == glw::GL_TEXTURE_CUBE_MAP || self.target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            if self.state.page_size_x > self.state.page_size_y {
                self.state.page_size_y = self.state.page_size_x;
            } else if self.state.page_size_x < self.state.page_size_y {
                self.state.page_size_x = self.state.page_size_y;
            }
        }

        self.state.width = self.scale * self.state.page_size_x;
        self.state.height = self.scale * self.state.page_size_y;
        self.state.depth = self.scale * self.state.page_size_z * self.state.min_depth;

        self.state.format = glu::texture_util::map_gl_internal_format(self.format);

        Ok(texture)
    }

    /// `sparseAllocateTexture`
    pub(super) fn sparse_allocate_texture(&mut self, levels: GLint) -> Result<GLuint, TestError> {
        let gl = self.gl;
        self.log.push_str(&format!("Sparse Allocate [levels: {levels}] - "));

        let texture = self.prepare_texture()?;

        gl!(gl.tex_parameteri(self.target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));
        glu::expect_no_error(gl, "texParameteri error occurred for GL_TEXTURE_SPARSE_ARB")?;

        if self.v2 {
            self.state.levels = if self.target != glw::GL_TEXTURE_RECTANGLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                levels
            } else {
                1
            };
            self.state.samples = if self.target != glw::GL_TEXTURE_2D_MULTISAMPLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                1
            } else {
                2
            };
            texture_storage(
                gl,
                self.target,
                self.state.levels.max(self.state.samples),
                self.format,
                self.state.width,
                self.state.height,
                self.state.depth,
            )?;
            glu::expect_no_error(gl, "TexStorage")?;
            return Ok(texture);
        }

        self.state.levels = if self.target == glw::GL_TEXTURE_RECTANGLE {
            1
        } else {
            levels
        };

        texture_storage(
            gl,
            self.target,
            self.state.levels,
            self.format,
            self.state.width,
            self.state.height,
            self.state.depth,
        )?;
        glu::expect_no_error(gl, "TexStorage")?;

        Ok(texture)
    }

    /// `allocateTexture`
    pub(super) fn allocate_texture(&mut self, levels: GLint) -> Result<GLuint, TestError> {
        let gl = self.gl;
        self.log.push_str(&format!("Allocate [levels: {levels}] - "));

        let texture = self.prepare_texture()?;

        if self.v2 {
            self.state.levels = if self.target != glw::GL_TEXTURE_RECTANGLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                levels
            } else {
                1
            };
            self.state.samples = if self.target != glw::GL_TEXTURE_2D_MULTISAMPLE
                && self.target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                1
            } else {
                2
            };
            texture_storage(
                gl,
                self.target,
                self.state.levels.max(self.state.samples),
                self.format,
                self.state.width,
                self.state.height,
                self.state.depth,
            )?;
            glu::expect_no_error(gl, "TexStorage")?;
            return Ok(texture);
        }

        self.state.levels = if self.target != glw::GL_TEXTURE_RECTANGLE {
            levels
        } else {
            1
        };

        texture_storage(
            gl,
            self.target,
            self.state.levels,
            self.format,
            self.state.width,
            self.state.height,
            self.state.depth,
        )?;
        glu::expect_no_error(gl, "TexStorage")?;

        Ok(texture)
    }

    /// `writeDataToTexture`
    fn write_data_to_texture(&mut self, level: GLint) -> Result<(), TestError> {
        let gl = self.gl;
        self.log.push_str(&format!("Fill texture [level: {level}] - "));

        if level > self.state.levels - 1 {
            return Err(TestError::Fail("Invalid level".to_string()));
        }

        let format = self
            .state
            .format
            .ok_or_else(|| TestError::Fail("texture format is not mapped".to_string()))?;
        let transfer_format = glu::get_transfer_format(format)?;

        let (width, height, depth) = get_texture_level_size(self.target, &self.state, level);

        if width > 0 && height > 0 && depth >= self.state.min_depth {
            let tex_size = (width * height * depth * self.pixel_size()?) as usize;

            let data = vec![(16 + 16 * level) as u8; tex_size];

            texture_sub_image(
                gl,
                self.target,
                level,
                0,
                0,
                0,
                width,
                height,
                depth,
                transfer_format.format,
                transfer_format.data_type,
                data.as_ptr().cast(),
            )?;
            glu::expect_no_error(gl, "SubImage")?;
        }

        Ok(())
    }

    /// `verifyTextureData`
    fn verify_texture_data(&mut self, level: GLint) -> Result<bool, TestError> {
        let gl = self.gl;
        self.log.push_str(&format!("Verify Texture [level: {level}] - "));

        if level > self.state.levels - 1 {
            return Err(TestError::Fail("Invalid level".to_string()));
        }

        let format = self
            .state
            .format
            .ok_or_else(|| TestError::Fail("texture format is not mapped".to_string()))?;
        let transfer_format = glu::get_transfer_format(format)?;

        let (width, height, depth) = get_texture_level_size(self.target, &self.state, level);

        let width_committed = width / 2;

        if width_committed == 0 || height == 0 || depth < self.state.min_depth {
            return Ok(true);
        }

        let pixel_size = self.pixel_size()?;
        let mut result = true;

        if self.target != glw::GL_TEXTURE_CUBE_MAP {
            let tex_size = (width * height * depth * pixel_size) as usize;

            let exp_data = vec![(16 + 16 * level) as u8; tex_size];
            let mut out_data = vec![255u8; tex_size];

            gl!(gl.get_tex_image(
                self.target,
                level,
                transfer_format.format,
                transfer_format.data_type,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            result = Self::compare_committed(
                &exp_data,
                &out_data,
                width,
                height,
                depth,
                width_committed,
                pixel_size as usize,
            );
        } else {
            let sub_targets = [
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            ];

            let tex_size = (width * height * pixel_size) as usize;

            let exp_data = vec![(16 + 16 * level) as u8; tex_size];
            let mut out_data = vec![255u8; tex_size];

            for sub_target in sub_targets {
                self.log
                    .push_str(&format!("Verify Subtarget [subtarget: {sub_target}] - "));

                out_data.fill(255);

                gl!(gl.get_tex_image(
                    sub_target,
                    level,
                    transfer_format.format,
                    transfer_format.data_type,
                    out_data.as_mut_ptr().cast()
                ));
                glu::expect_no_error(gl, "Texture::GetData")?;

                result = Self::compare_committed(
                    &exp_data,
                    &out_data,
                    width,
                    height,
                    depth,
                    width_committed,
                    pixel_size as usize,
                );

                if !result {
                    break;
                }
            }
        }

        Ok(result)
    }

    /// The x/y/z comparison loop of `verifyTextureData`; the z loop only repeats the same window, as upstream's does.
    fn compare_committed(
        exp_data: &[u8],
        out_data: &[u8],
        width: GLint,
        height: GLint,
        depth: GLint,
        width_committed: GLint,
        pixel_size: usize,
    ) -> bool {
        let mut result = true;

        for x in 0..width_committed {
            for y in 0..height {
                for _z in 0..depth {
                    let offset = (x + y * width) as usize * pixel_size;
                    if exp_data[offset..offset + pixel_size] != out_data[offset..offset + pixel_size] {
                        result = false;
                    }
                }
            }
        }

        result
    }

    /// `commitTexturePage`
    pub(super) fn commit_texture_page(&mut self, texture: GLuint, level: GLint) -> Result<bool, TestError> {
        let gl = self.gl;
        self.log.push_str(&format!("Commit Region [level: {level}] - "));

        if level > self.state.levels - 1 {
            return Err(TestError::Fail("Invalid level".to_string()));
        }

        if !self.is_in_page_sizes_range(level) || !self.is_page_sizes_multiplication(level) {
            self.log.push_str(&format!("Skip commitment [level: {level}] - "));
            return Ok(false);
        }

        let (width, height, mut depth) = get_texture_level_size(self.target, &self.state, level);

        if self.target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }

        let width_committed = width / 2;

        texture_bind(gl, texture, self.target)?;
        self.tex_page_commitment(texture, level, 0, 0, 0, width_committed, height, depth, true)?;
        glu::expect_no_error(gl, "texPageCommitment")?;

        Ok(true)
    }

    /// `isInPageSizesRange`
    pub(super) fn is_in_page_sizes_range(&self, level: GLint) -> bool {
        let (width, height, mut depth) = get_texture_level_size(self.target, &self.state, level);

        if self.target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }

        let width_committed = width / 2;
        width_committed >= self.state.page_size_x
            && height >= self.state.page_size_y
            && (self.state.min_depth == 0 || depth >= self.state.page_size_z)
    }

    /// `isPageSizesMultiplication`
    pub(super) fn is_page_sizes_multiplication(&self, level: GLint) -> bool {
        let (width, height, mut depth) = get_texture_level_size(self.target, &self.state, level);

        if self.target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }

        let width_committed = width / 2;
        (width_committed % self.state.page_size_x) == 0
            && (height % self.state.page_size_y) == 0
            && (depth % self.state.page_size_z) == 0
    }

    /// `verifyInvalidOperationErrors`
    pub(super) fn verify_invalid_operation_errors(&mut self, texture: &mut GLuint) -> Result<bool, TestError> {
        let gl = self.gl;
        let target = self.target;
        self.log.push_str("Verify INVALID_OPERATION Errors - ");

        // Case 1 - texture is not GL_TEXTURE_IMMUTABLE_FORMAT
        *texture = texture_generate(gl)?;
        texture_bind(gl, *texture, target)?;

        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_SPARSE_ARB, glw::GL_TRUE as GLint));
        glu::expect_no_error(gl, "texParameteri error occurred for GL_TEXTURE_SPARSE_ARB")?;

        let mut immutable_format: GLint = 0;

        gl!(gl.get_tex_parameteriv(target, glw::GL_TEXTURE_IMMUTABLE_FORMAT, &mut immutable_format));
        glu::expect_no_error(gl, "getTexParameteriv error occurred for GL_TEXTURE_IMMUTABLE_FORMAT")?;

        let result = self.invalid_operation_cases(texture, immutable_format)?;

        texture_delete(gl, *texture)?;

        Ok(result)
    }

    /// The part of `verifyInvalidOperationErrors` between its first case and the `verifing_invalid_operation_end` label.
    fn invalid_operation_cases(&mut self, texture: &mut GLuint, immutable_format: GLint) -> Result<bool, TestError> {
        let gl = self.gl;
        let target = self.target;
        let state = self.state;

        if immutable_format == glw::GL_FALSE as GLint {
            self.tex_page_commitment(
                *texture,
                0,
                0,
                0,
                0,
                state.page_size_x,
                state.page_size_y,
                state.page_size_z,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [GL_TEXTURE_IMMUTABLE_FORMAT texture]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            ) {
                return Ok(false);
            }
        }

        texture_delete(gl, *texture)?;

        // Case 2 - texture is not TEXTURE_SPARSE_ARB
        *texture = self.allocate_texture(1)?;

        let state = self.state;
        self.tex_page_commitment(
            *texture,
            0,
            0,
            0,
            0,
            state.page_size_x,
            state.page_size_y,
            state.page_size_z,
            true,
        )?;
        if !verify_error(
            &mut self.log,
            "texPageCommitment [not TEXTURE_SPARSE_ARB texture]",
            get_error(gl),
            glw::GL_INVALID_OPERATION,
        ) {
            return Ok(false);
        }

        // Sparse allocate texture
        texture_delete(gl, *texture)?;
        *texture = self.sparse_allocate_texture(1)?;
        let state = self.state;

        // Case 3 - commitment sizes greater than expected
        self.tex_page_commitment(
            *texture,
            0,
            0,
            0,
            0,
            state.width + state.page_size_x,
            state.height,
            state.depth,
            true,
        )?;
        if !verify_error(
            &mut self.log,
            "texPageCommitment [commitment width greater than expected]",
            get_error(gl),
            glw::GL_INVALID_OPERATION,
        ) {
            return Ok(false);
        }

        self.tex_page_commitment(
            *texture,
            0,
            0,
            0,
            0,
            state.width,
            state.height + state.page_size_y,
            state.depth,
            true,
        )?;
        if !verify_error(
            &mut self.log,
            "texPageCommitment [commitment height greater than expected]",
            get_error(gl),
            glw::GL_INVALID_OPERATION,
        ) {
            return Ok(false);
        }

        if target == glw::GL_TEXTURE_3D
            || target == glw::GL_TEXTURE_2D_ARRAY
            || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        {
            self.tex_page_commitment(
                *texture,
                0,
                0,
                0,
                0,
                state.width,
                state.height,
                state.depth + state.page_size_z,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment depth greater than expected]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            ) {
                return Ok(false);
            }
        }

        // Case 4 - commitment sizes not multiple of corresponding page sizes
        if state.page_size_x > 1 {
            self.tex_page_commitment(*texture, 0, 0, 0, 0, 1, state.page_size_y, state.page_size_z, true)?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment width not multiple of page sizes X]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            ) {
                return Ok(false);
            }
        }

        if state.page_size_y > 1 {
            self.tex_page_commitment(*texture, 0, 0, 0, 0, state.page_size_x, 1, state.page_size_z, true)?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment height not multiple of page sizes Y]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            ) {
                return Ok(false);
            }
        }

        if state.page_size_z > 1
            && (target == glw::GL_TEXTURE_3D
                || target == glw::GL_TEXTURE_2D_ARRAY
                || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY)
        {
            self.tex_page_commitment(
                *texture,
                0,
                0,
                0,
                0,
                state.page_size_x,
                state.page_size_y,
                state.min_depth,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment depth not multiple of page sizes Z]",
                get_error(gl),
                glw::GL_INVALID_OPERATION,
            ) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `verifyInvalidValueErrors`
    pub(super) fn verify_invalid_value_errors(&mut self, texture: &mut GLuint) -> Result<bool, TestError> {
        let gl = self.gl;
        self.log.push_str("Verify INVALID_VALUE Errors - ");

        *texture = self.sparse_allocate_texture(1)?;

        let result = self.invalid_value_cases(*texture)?;

        texture_delete(gl, *texture)?;

        Ok(result)
    }

    /// The part of `verifyInvalidValueErrors` between `sparseAllocateTexture` and the `verifing_invalid_value_end` label.
    fn invalid_value_cases(&mut self, texture: GLuint) -> Result<bool, TestError> {
        let gl = self.gl;
        let target = self.target;
        let state = self.state;

        // Case 1 - commitment offset not multiple of page size in corresponding dimension
        if state.page_size_x > 1 {
            self.tex_page_commitment(
                texture,
                0,
                1,
                0,
                0,
                state.page_size_x,
                state.page_size_y,
                state.page_size_z,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment offsetX not multiple of page size X]",
                get_error(gl),
                glw::GL_INVALID_VALUE,
            ) {
                return Ok(false);
            }
        }

        if state.page_size_y > 1 {
            self.tex_page_commitment(
                texture,
                0,
                0,
                1,
                0,
                state.page_size_x,
                state.page_size_y,
                state.page_size_z,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment offsetY not multiple of page size Y]",
                get_error(gl),
                glw::GL_INVALID_VALUE,
            ) {
                return Ok(false);
            }
        }

        if (target == glw::GL_TEXTURE_3D
            || target == glw::GL_TEXTURE_2D_ARRAY
            || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY)
            && (state.min_depth % state.page_size_z) != 0
        {
            self.tex_page_commitment(
                texture,
                0,
                0,
                0,
                state.min_depth,
                state.page_size_x,
                state.page_size_y,
                state.page_size_z,
                true,
            )?;
            if !verify_error(
                &mut self.log,
                "texPageCommitment [commitment offsetZ not multiple of page size Z]",
                get_error(gl),
                glw::GL_INVALID_VALUE,
            ) {
                return Ok(false);
            }
        }

        Ok(true)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTextureTests
// ---------------------------------------------------------------------------------------------------------------------

fn add_case(group: &mut TestCaseGroup, name: String, kind: Kind) {
    group.add_child(Box::new(SparseTextureCase { name, kind }) as Box<dyn TestCase>);
}

/// `SparseTextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparse_texture_tests");

    add_case(&mut group, "SimpleQueries".to_string(), Kind::SimpleQueries);

    // addTextureParameterQueriesTestCase
    for target in [
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_3D,
        glw::GL_TEXTURE_RECTANGLE,
    ] {
        let name = format!("TextureParameterQueries_{}", texture_target_string(target));
        add_case(
            &mut group,
            name,
            Kind::TextureParameterQueries {
                supported_target: Some(target),
                not_supported_target: None,
            },
        );
    }
    for target in [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY] {
        let name = format!("TextureParameterQueries_{}", texture_target_string(target));
        add_case(
            &mut group,
            name,
            Kind::TextureParameterQueries {
                supported_target: None,
                not_supported_target: Some(target),
            },
        );
    }

    // addInternalFormatQueriesTestCase
    let query_targets = [
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_3D,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_RECTANGLE,
    ];
    let formats = || SPARSE_TEXTURE_COMMITMENT_FORMATS.iter().map(|(format, _)| *format);

    for format in formats() {
        for target in query_targets {
            let name = format!(
                "InternalFormatQueries_{}_{}",
                texture_target_string(target),
                texture_format_string(format)
            );
            add_case(&mut group, name, Kind::InternalFormatQueries { target, format });
        }
    }

    // addSparseTextureAllocationTestCase
    let full_array_targets = [
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
    ];

    for format in formats() {
        for target in SPARSE_TEXTURE_COMMITMENT_TARGETS {
            let name = format!(
                "SparseTextureAllocation_{}_{}",
                texture_target_string(target),
                texture_format_string(format)
            );
            add_case(
                &mut group,
                name,
                Kind::SparseTextureAllocation {
                    target: Some(target),
                    full_array_target: None,
                    format,
                },
            );
        }
        for target in full_array_targets {
            let name = format!(
                "SparseTextureAllocation_fullArray_{}_{}",
                texture_target_string(target),
                texture_format_string(format)
            );
            add_case(
                &mut group,
                name,
                Kind::SparseTextureAllocation {
                    target: None,
                    full_array_target: Some(target),
                    format,
                },
            );
        }
    }

    // addSparseTextureCommitmentTestCase
    for target in SPARSE_TEXTURE_COMMITMENT_TARGETS {
        for format in formats() {
            let name = format!(
                "SparseTextureCommitment_{}_{}",
                texture_target_string(target),
                texture_format_string(format)
            );
            add_case(
                &mut group,
                name,
                Kind::SparseTextureCommitment {
                    target,
                    format,
                    dsa: false,
                },
            );
        }
    }

    // addSparseDSATextureCommitmentTestCase
    for target in SPARSE_TEXTURE_COMMITMENT_TARGETS {
        for format in formats() {
            let name = format!(
                "SparseDSATextureCommitment_{}_{}",
                texture_target_string(target),
                texture_format_string(format)
            );
            add_case(
                &mut group,
                name,
                Kind::SparseTextureCommitment {
                    target,
                    format,
                    dsa: true,
                },
            );
        }
    }

    group
}
