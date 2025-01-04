// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTextureSwizzleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The texture format table (71 entries and the arrays they point at) is generated from the C++ by `scripts/gen_khr_texture_swizzle_tables.py` (`generated::khr_texture_swizzle_tables`). `SmokeTest` and `FunctionalTest` are one `Runner` whose `functional` flag selects what upstream does through virtual functions (`fillSourceTexture`, `verifyOutputImage`, `iterate`); `Utils::programInfo` is a `ShaderProgram`. `Utils::replaceToken` is gone: each template is filled in the one order upstream replaces its tokens in, which gives the same text. Upstream's `wrongResults` exception is a `false` result that unwinds to `FunctionalTest::iterate`, where it is caught; `SmokeTest::verifyOutputImage` throws `TCU_FAIL` instead, which is an error here.

mod runner;

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `_sampler` - the GLSL basic type and sampler prefix of a texture format.
#[derive(Clone, Copy)]
pub struct SamplerDesc {
    pub basic_type: &'static str,
    pub sampler_prefix: &'static str,
}

/// `_out_ch_desc` - the format of the output texture for one channel, and the value it is expected to hold when that does not depend on the source data.
#[derive(Clone, Copy)]
pub struct OutChDesc {
    pub internal_format: GLenum,
    pub expected_data: Option<&'static [u8]>,
}

/// `_texture_format`
#[derive(Clone, Copy)]
pub struct TextureFormat {
    pub minimum_gl_context: (i32, i32),
    pub internal_format: GLenum,
    pub format: GLenum,
    pub type_: GLenum,
    pub ds_mode: GLenum,
    pub sampler: SamplerDesc,
    pub red_ch: OutChDesc,
    pub green_ch: OutChDesc,
    pub blue_ch: OutChDesc,
    pub alpha_ch: OutChDesc,
    pub source_data: &'static [u8],
    pub zero_ch: OutChDesc,
    pub one_ch: OutChDesc,
}

/// `_texture_access` - a texture access routine.
pub struct TextureAccess {
    pub name: &'static str,
    pub n_coordinates: usize,
    pub use_derivatives: bool,
    pub use_integral_coordinates: bool,
    pub use_lod: bool,
    pub use_offsets: bool,
    pub support_multisampling: bool,
}

const fn access(
    name: &'static str,
    n_coordinates: usize,
    use_derivatives: bool,
    use_integral_coordinates: bool,
    use_lod: bool,
    use_offsets: bool,
    support_multisampling: bool,
) -> TextureAccess {
    TextureAccess {
        name,
        n_coordinates,
        use_derivatives,
        use_integral_coordinates,
        use_lod,
        use_offsets,
        support_multisampling,
    }
}

pub const TEXTURE_ACCESS: [TextureAccess; 14] = [
    access("texture", 0, false, false, false, false, false),
    access("textureProj", 1, false, false, false, false, false),
    access("textureLod", 0, false, false, true, false, false),
    access("textureOffset", 0, false, false, false, true, false),
    access("texelFetch", 0, false, true, true, false, true),
    access("texelFetchOffset", 0, false, true, true, true, false),
    access("textureProjOffset", 1, false, false, false, true, false),
    access("textureLodOffset", 0, false, false, true, true, false),
    access("textureProjLod", 1, false, false, true, false, false),
    access("textureProjLodOffset", 1, false, false, true, true, false),
    access("textureGrad", 0, true, false, false, false, false),
    access("textureGradOffset", 0, true, false, false, true, false),
    access("textureProjGrad", 1, true, false, false, false, false),
    access("textureProjGradOffset", 1, true, false, false, true, false),
];

/// `_texture_target`
pub struct TextureTarget {
    pub n_array_coordinates: usize,
    pub n_coordinates: usize,
    pub n_derivatives: usize,
    pub sampler_type: &'static str,
    pub support_integral_coordinates: bool,
    pub support_lod: bool,
    pub support_offset: bool,
    pub supports_proj: bool,
    pub require_multisampling: bool,
    pub target: GLenum,
}

#[allow(clippy::too_many_arguments)]
const fn target(
    n_array_coordinates: usize,
    n_coordinates: usize,
    n_derivatives: usize,
    sampler_type: &'static str,
    support_integral_coordinates: bool,
    support_lod: bool,
    support_offset: bool,
    supports_proj: bool,
    require_multisampling: bool,
    target: GLenum,
) -> TextureTarget {
    TextureTarget {
        n_array_coordinates,
        n_coordinates,
        n_derivatives,
        sampler_type,
        support_integral_coordinates,
        support_lod,
        support_offset,
        supports_proj,
        require_multisampling,
        target,
    }
}

pub const TEXTURE_TARGETS: [TextureTarget; 9] = [
    target(0, 1, 1, "1D", true, true, true, true, false, glw::GL_TEXTURE_1D),
    target(0, 2, 2, "2D", true, true, true, true, false, glw::GL_TEXTURE_2D),
    target(0, 3, 3, "3D", true, true, true, true, false, glw::GL_TEXTURE_3D),
    target(
        1,
        1,
        1,
        "1DArray",
        true,
        true,
        true,
        false,
        false,
        glw::GL_TEXTURE_1D_ARRAY,
    ),
    target(
        1,
        2,
        2,
        "2DArray",
        true,
        true,
        true,
        false,
        false,
        glw::GL_TEXTURE_2D_ARRAY,
    ),
    target(
        0,
        2,
        2,
        "2DRect",
        true,
        false,
        true,
        true,
        false,
        glw::GL_TEXTURE_RECTANGLE,
    ),
    target(
        0,
        3,
        3,
        "Cube",
        false,
        true,
        false,
        false,
        false,
        glw::GL_TEXTURE_CUBE_MAP,
    ),
    target(
        0,
        2,
        2,
        "2DMS",
        true,
        false,
        true,
        true,
        true,
        glw::GL_TEXTURE_2D_MULTISAMPLE,
    ),
    target(
        1,
        2,
        2,
        "2DMSArray",
        true,
        false,
        true,
        true,
        true,
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
    ),
];

/// Swizzle valid values
pub const VALID_VALUES: [i32; 6] = [
    glw::GL_RED as i32,
    glw::GL_GREEN as i32,
    glw::GL_BLUE as i32,
    glw::GL_ALPHA as i32,
    glw::GL_ONE as i32,
    glw::GL_ZERO as i32,
];

/// Swizzle states
pub const STATES: [GLenum; 4] = [
    glw::GL_TEXTURE_SWIZZLE_R,
    glw::GL_TEXTURE_SWIZZLE_G,
    glw::GL_TEXTURE_SWIZZLE_B,
    glw::GL_TEXTURE_SWIZZLE_A,
];

/// Which of the four kinds of case in the group this is.
enum Kind {
    ApiErrors,
    InitialState,
    Smoke { access_idx: usize, channel_idx: usize },
    Functional { format_idx: usize, tgt_idx: usize },
}

struct TextureSwizzleCase {
    name: String,
    kind: Kind,
}

impl TestCase for TextureSwizzleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::ApiErrors => api_errors(context),
            Kind::InitialState => initial_state(context),
            Kind::Smoke {
                access_idx,
                channel_idx,
            } => runner::iterate_smoke(context, access_idx, channel_idx),
            Kind::Functional { format_idx, tgt_idx } => runner::iterate_functional(context, format_idx, tgt_idx),
        }
    }
}

/// `APIErrorsTest::verifyError`
fn verify_error(gl: &glw::Functions, expected_error: GLenum) -> Result<(), TestError> {
    // SAFETY: glGetError needs nothing but a current context.
    let error = unsafe { gl.get_error() };
    if expected_error != error {
        return Err(TestError::Fail("Got invalid error".to_string()));
    }
    Ok(())
}

/// `APIErrorsTest::iterate`
fn api_errors(context: &Context) -> TestOutcome {
    const INVALID_VALUES: [i32; 4] = [0x1902, 0x1907, -1, 2];

    let gl = context.gl();
    let id = crate::glu::Texture::new(gl);
    crate::glu::expect_no_error(gl, "GenTextures")?;

    // SAFETY: the texture is the guard's own.
    unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, id.get()) };
    crate::glu::expect_no_error(gl, "BindTexture")?;

    for state in STATES {
        for value in VALID_VALUES {
            // SAFETY: plain state setter.
            unsafe { gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, state, value) };
            verify_error(gl, glw::GL_NO_ERROR)?;
        }

        for value in INVALID_VALUES {
            // SAFETY: plain state setter.
            unsafe { gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP, state, value) };
            verify_error(gl, glw::GL_INVALID_ENUM)?;
        }
    }

    for i in 0..4 {
        // number of channels
        for value in VALID_VALUES {
            let mut param = [
                glw::GL_RED as i32,
                glw::GL_GREEN as i32,
                glw::GL_BLUE as i32,
                glw::GL_ALPHA as i32,
            ];
            param[i] = value;
            // SAFETY: four GLints for GL_TEXTURE_SWIZZLE_RGBA.
            unsafe { gl.tex_parameteriv(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_SWIZZLE_RGBA, param.as_ptr()) };
            verify_error(gl, glw::GL_NO_ERROR)?;
        }

        for value in INVALID_VALUES {
            let mut param = [
                glw::GL_RED as i32,
                glw::GL_GREEN as i32,
                glw::GL_BLUE as i32,
                glw::GL_ALPHA as i32,
            ];
            param[i] = value;
            // SAFETY: four GLints for GL_TEXTURE_SWIZZLE_RGBA.
            unsafe { gl.tex_parameteriv(glw::GL_TEXTURE_CUBE_MAP, glw::GL_TEXTURE_SWIZZLE_RGBA, param.as_ptr()) };
            verify_error(gl, glw::GL_INVALID_ENUM)?;
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `IntialStateTest::iterate` (sic)
fn initial_state(context: &Context) -> TestOutcome {
    let gl = context.gl();

    for texture_target in &TEXTURE_TARGETS {
        let target = texture_target.target;
        // `deinit` after every target: a fresh texture name for each
        let id = crate::glu::Texture::new(gl);
        crate::glu::expect_no_error(gl, "GenTextures")?;

        // SAFETY: the texture is the guard's own.
        unsafe { gl.bind_texture(target, id.get()) };
        crate::glu::expect_no_error(gl, "BindTexture")?;

        // verifyValues
        let mut red = 0;
        let mut green = 0;
        let mut blue = 0;
        let mut alpha = 0;
        let mut param = [0i32; 4];
        // SAFETY: one GLint out per query, four for the RGBA one.
        unsafe {
            gl.get_tex_parameter_iiv(target, glw::GL_TEXTURE_SWIZZLE_R, &mut red);
            crate::glu::expect_no_error(gl, "GetTexParameterIiv")?;
            gl.get_tex_parameter_iiv(target, glw::GL_TEXTURE_SWIZZLE_G, &mut green);
            crate::glu::expect_no_error(gl, "GetTexParameterIiv")?;
            gl.get_tex_parameter_iiv(target, glw::GL_TEXTURE_SWIZZLE_B, &mut blue);
            crate::glu::expect_no_error(gl, "GetTexParameterIiv")?;
            gl.get_tex_parameter_iiv(target, glw::GL_TEXTURE_SWIZZLE_A, &mut alpha);
            crate::glu::expect_no_error(gl, "GetTexParameterIiv")?;
            gl.get_tex_parameter_iiv(target, glw::GL_TEXTURE_SWIZZLE_RGBA, param.as_mut_ptr());
            crate::glu::expect_no_error(gl, "GetTexParameterIiv")?;
        }

        let fail = |message: &str| -> TestOutcome { Err(TestError::Fail(message.to_string())) };
        if glw::GL_RED as i32 != red {
            return fail("Got invalid initial state for TEXTURE_SWIZZLE_R");
        }
        if glw::GL_GREEN as i32 != green {
            return fail("Got invalid initial state for TEXTURE_SWIZZLE_G");
        }
        if glw::GL_BLUE as i32 != blue {
            return fail("Got invalid initial state for TEXTURE_SWIZZLE_B");
        }
        if glw::GL_ALPHA as i32 != alpha {
            return fail("Got invalid initial state for TEXTURE_SWIZZLE_A");
        }
        if glw::GL_RED as i32 != param[0] {
            return fail("Got invalid initial red state for TEXTURE_SWIZZLE_RGBA");
        }
        if glw::GL_GREEN as i32 != param[1] {
            return fail("Got invalid initial green state for TEXTURE_SWIZZLE_RGBA");
        }
        if glw::GL_BLUE as i32 != param[2] {
            return fail("Got invalid initial blue state for TEXTURE_SWIZZLE_RGBA");
        }
        if glw::GL_ALPHA as i32 != param[3] {
            return fail("Got invalid initial alpha state for TEXTURE_SWIZZLE_RGBA");
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TextureSwizzleTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_swizzle");

    group.add_child(Box::new(TextureSwizzleCase {
        name: "api_errors".to_string(),
        kind: Kind::ApiErrors,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(TextureSwizzleCase {
        name: "intial_state".to_string(),
        kind: Kind::InitialState,
    }) as Box<dyn TestCase>);

    // addSmokeTest
    for access_idx in 0..TEXTURE_ACCESS.len() {
        for channel_idx in 0..4 {
            group.add_child(Box::new(TextureSwizzleCase {
                name: format!("smoke_access_idx_{access_idx}_channel_idx_{channel_idx}"),
                kind: Kind::Smoke {
                    access_idx,
                    channel_idx,
                },
            }) as Box<dyn TestCase>);
        }
    }

    // addFunctionalTest: all formats, all targets
    for format_idx in 0..crate::generated::khr_texture_swizzle_tables::TEXTURE_FORMATS.len() {
        for tgt_idx in 0..TEXTURE_TARGETS.len() {
            group.add_child(Box::new(TextureSwizzleCase {
                name: format!("functional_format_idx_{format_idx}_target_idx_{tgt_idx}"),
                kind: Kind::Functional { format_idx, tgt_idx },
            }) as Box<dyn TestCase>);
        }
    }

    group
}
