// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fIndexedStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `getVerifierSuffix`
// here spells the entry point in full (`getbooleani_v`/`getintegeri_v`/
// `getinteger64i_v`) rather than `query_util`'s `getboolean`/... postfixes, so the
// suffix table is local. The desktop GL 4.5 branches of `isExtensionSupported` and
// `ImageBindingFormatCase` are dropped - this port is ES-only.

use crate::gls::state_query_util::{
    QueryType, verify_state_indexed_boolean, verify_state_indexed_boolean_vec4, verify_state_indexed_integer,
    verify_state_indexed_integer_min,
};
use crate::glu::{ApiCase, Buffer, TestCaseGroup, Texture, add_api_case};
use crate::glw::{self, GLenum, GLint, GLintptr, GLuint};
use crate::tcu::Random;

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::IndexedBoolean | QueryType::IndexedBooleanVec4 => "getbooleani_v",
        QueryType::IndexedInteger | QueryType::IndexedIntegerVec4 => "getintegeri_v",
        QueryType::IndexedInteger64 | QueryType::IndexedInteger64Vec4 => "getinteger64i_v",
        QueryType::IndexedIsEnabled => "isenabledi",
        _ => unreachable!("indexed state queries only"),
    }
}

/// `isExtensionSupported` - the two extensions upstream special-cases are also core
/// in ES 3.2.
fn require_extension(case: &mut ApiCase<'_>, extension: &str) -> bool {
    let core_in_es32 = extension == "GL_EXT_draw_buffers_indexed" || extension == "GL_KHR_blend_equation_advanced";
    if core_in_es32 && case.context().context_type().supports(3, 2) {
        return true;
    }
    if case.context().context_info.is_extension_supported(extension) {
        return true;
    }
    case.not_supported(format!("Extension {extension} not supported."));
    false
}

/// `SampleMaskCase::init` + `iterate`
fn sample_mask_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_sample_mask_words = case.get_int(glw::GL_MAX_SAMPLE_MASK_WORDS);
    if max_sample_mask_words <= 0 {
        case.fail(
            format!("Minimum value of GL_MAX_SAMPLE_MASK_WORDS is 1. Got {max_sample_mask_words}"),
            "Invalid GL_MAX_SAMPLE_MASK_WORDS",
        );
        return;
    }

    {
        case.section("Initial values");
        for ndx in 0..max_sample_mask_words {
            verify_state_indexed_integer(case, glw::GL_SAMPLE_MASK_VALUE, ndx as GLuint, -1, verifier);
        }
    }

    {
        case.section("Fixed values");
        for ndx in 0..max_sample_mask_words {
            // SAFETY: a plain enum/index setter.
            unsafe { case.gl().sample_maski(ndx as GLuint, 0) };
            case.expect_error(glw::GL_NO_ERROR);

            verify_state_indexed_integer(case, glw::GL_SAMPLE_MASK_VALUE, ndx as GLuint, 0, verifier);
        }
    }

    {
        const NUM_RANDOM_TEST: i32 = 20;
        case.section("Random values");
        let mut rnd = Random::new(0x4312);

        for _ in 0..NUM_RANDOM_TEST {
            let mask_index = rnd.get_uint32() % max_sample_mask_words as u32;
            #[expect(clippy::cast_possible_wrap, reason = "upstream casts the raw u32 draw to GLint")]
            let mask = rnd.get_uint32() as GLint;

            // SAFETY: a plain enum/index setter.
            unsafe { case.gl().sample_maski(mask_index, mask as glw::GLbitfield) };
            case.expect_error(glw::GL_NO_ERROR);

            verify_state_indexed_integer(case, glw::GL_SAMPLE_MASK_VALUE, mask_index, mask, verifier);
        }
    }
}

/// `MinValueIndexed3Case::iterate`
fn min_value_indexed3_case(case: &mut ApiCase<'_>, target: GLenum, reference: [GLint; 3], verifier: QueryType) {
    for (ndx, reference) in reference.iter().enumerate() {
        case.section(&format!("Element {ndx}"));
        verify_state_indexed_integer_min(case, target, ndx as GLuint, *reference, verifier);
    }
}

/// `BufferBindingCase::iterate`
fn buffer_binding_case(
    case: &mut ApiCase<'_>,
    query_target: GLenum,
    buffer_target: GLenum,
    num_bindings_target: GLenum,
    verifier: QueryType,
) {
    let max_bindings = case.get_int(num_bindings_target);

    {
        case.section("Initial value");
        for ndx in 0..max_bindings {
            verify_state_indexed_integer(case, query_target, ndx as GLuint, 0, verifier);
        }
    }

    {
        case.section("After setting");
        let buffer_a = Buffer::new(case.gl());
        let buffer_b = Buffer::new(case.gl());
        let ndx_a: GLuint = 0;
        let ndx_b = (max_bindings / 2) as GLuint;

        case.section("After setting generic binding point");
        // SAFETY: a name this case owns.
        unsafe { case.gl().bind_buffer(buffer_target, buffer_a.get()) };
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, 0, 0, verifier);

        case.section("After setting with glBindBufferBase");
        // SAFETY: as above.
        unsafe { case.gl().bind_buffer_base(buffer_target, ndx_a, buffer_a.get()) };
        case.expect_error(glw::GL_NO_ERROR);
        #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
        let name_a = buffer_a.get() as GLint;
        verify_state_indexed_integer(case, query_target, ndx_a, name_a, verifier);

        case.section("After setting with glBindBufferRange");
        // SAFETY: as above; the range is within nothing yet allocated, which is what
        // upstream does too - only the binding state is under test.
        unsafe { case.gl().bind_buffer_range(buffer_target, ndx_b, buffer_b.get(), 0, 8) };
        case.expect_error(glw::GL_NO_ERROR);
        #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
        let name_b = buffer_b.get() as GLint;
        verify_state_indexed_integer(case, query_target, ndx_b, name_b, verifier);

        if ndx_a != ndx_b {
            case.section("Original state did not change");
            verify_state_indexed_integer(case, query_target, ndx_a, name_a, verifier);
        }
    }
}

/// `BufferStartCase::iterate`
fn buffer_start_case(
    case: &mut ApiCase<'_>,
    query_target: GLenum,
    buffer_target: GLenum,
    num_bindings_target: GLenum,
    verifier: QueryType,
) {
    let max_bindings = case.get_int(num_bindings_target);

    {
        case.section("Initial value");
        for ndx in 0..max_bindings {
            verify_state_indexed_integer(case, query_target, ndx as GLuint, 0, verifier);
        }
    }

    {
        case.section("After setting");
        let buffer_a = Buffer::new(case.gl());
        let buffer_b = Buffer::new(case.gl());
        let ndx_a: GLuint = 0;
        let ndx_b = (max_bindings / 2) as GLuint;

        let offset = if buffer_target == glw::GL_ATOMIC_COUNTER_BUFFER {
            4
        } else {
            case.get_int(glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT)
        };
        if offset < 0 {
            case.fail(format!("Invalid offset alignment {offset}"), "Invalid offset alignment");
            return;
        }

        case.section("After setting generic binding point");
        // SAFETY: names this case owns; both buffers are sized before they are bound
        // as a range.
        unsafe {
            case.gl().bind_buffer(buffer_target, buffer_a.get());
            case.gl()
                .buffer_data(buffer_target, 16, std::ptr::null(), glw::GL_DYNAMIC_READ);
            case.gl().bind_buffer(buffer_target, buffer_b.get());
            case.gl()
                .buffer_data(buffer_target, 32, std::ptr::null(), glw::GL_DYNAMIC_READ);
        }
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, 0, 0, verifier);

        case.section("After setting with glBindBufferBase");
        // SAFETY: as above.
        unsafe { case.gl().bind_buffer_base(buffer_target, ndx_a, buffer_a.get()) };
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, ndx_a, 0, verifier);

        case.section("After setting with glBindBufferRange");
        // SAFETY: as above.
        unsafe {
            case.gl()
                .bind_buffer_range(buffer_target, ndx_b, buffer_b.get(), offset as GLintptr, 8)
        };
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, ndx_b, offset, verifier);

        if ndx_a != ndx_b {
            case.section("Original state did not change");
            verify_state_indexed_integer(case, query_target, ndx_a, 0, verifier);
        }
    }
}

/// `BufferSizeCase::iterate`
fn buffer_size_case(
    case: &mut ApiCase<'_>,
    query_target: GLenum,
    buffer_target: GLenum,
    num_bindings_target: GLenum,
    verifier: QueryType,
) {
    let max_bindings = case.get_int(num_bindings_target);

    {
        case.section("Initial value");
        for ndx in 0..max_bindings {
            verify_state_indexed_integer(case, query_target, ndx as GLuint, 0, verifier);
        }
    }

    {
        case.section("After setting");
        let buffer_a = Buffer::new(case.gl());
        let buffer_b = Buffer::new(case.gl());
        let ndx_a: GLuint = 0;
        let ndx_b = (max_bindings / 2) as GLuint;

        case.section("After setting generic binding point");
        // SAFETY: names this case owns.
        unsafe {
            case.gl().bind_buffer(buffer_target, buffer_a.get());
            case.gl()
                .buffer_data(buffer_target, 16, std::ptr::null(), glw::GL_DYNAMIC_READ);
            case.gl().bind_buffer(buffer_target, buffer_b.get());
            case.gl()
                .buffer_data(buffer_target, 32, std::ptr::null(), glw::GL_DYNAMIC_READ);
        }
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, 0, 0, verifier);

        case.section("After setting with glBindBufferBase");
        // SAFETY: as above.
        unsafe { case.gl().bind_buffer_base(buffer_target, ndx_a, buffer_a.get()) };
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, ndx_a, 0, verifier);

        case.section("After setting with glBindBufferRange");
        // SAFETY: as above.
        unsafe { case.gl().bind_buffer_range(buffer_target, ndx_b, buffer_b.get(), 0, 8) };
        case.expect_error(glw::GL_NO_ERROR);
        verify_state_indexed_integer(case, query_target, ndx_b, 8, verifier);

        if ndx_a != ndx_b {
            case.section("Original state did not change");
            verify_state_indexed_integer(case, query_target, ndx_a, 0, verifier);
        }
    }
}

/// Which pair of textures the six `ImageBinding*Case`s bind, and how. Upstream
/// repeats this block per case with only the two `glBindImageTexture` argument rows
/// and the storage call differing.
struct ImageBindSetup {
    /// `(target, levels, internalformat, is_3d)` for texture B.
    b_target: GLenum,
    b_levels: GLint,
    b_format: GLenum,
    /// `glBindImageTexture(ndxB, textureB, level, layered, layer, access, format)`
    b_level: GLint,
    b_layered: bool,
    b_layer: GLint,
    b_access: GLenum,
    b_bind_format: GLenum,
}

/// The `glBindTexture`/`glTexStorage*`/`glBindImageTexture` prologue every
/// `ImageBinding*Case` shares. Returns `(ndx_a, ndx_b, name_a, name_b)`.
fn bind_image_pair<'gl>(
    case: &mut ApiCase<'gl>,
    max_images: GLint,
    setup: &ImageBindSetup,
    texture_a: &Texture<'gl>,
    texture_b: &Texture<'gl>,
) -> (GLuint, GLuint) {
    let ndx_a: GLuint = 0;
    let ndx_b = (max_images / 2) as GLuint;

    // SAFETY: both textures are this case's own; the storage call matches the target.
    unsafe {
        case.gl().bind_texture(glw::GL_TEXTURE_2D, texture_a.get());
        case.gl().tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 32, 32);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        case.gl().bind_image_texture(
            ndx_a,
            texture_a.get(),
            0,
            glw::FALSE,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA8UI,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        case.gl().bind_texture(setup.b_target, texture_b.get());
        if setup.b_target == glw::GL_TEXTURE_2D_ARRAY {
            case.gl()
                .tex_storage_3d(setup.b_target, setup.b_levels, setup.b_format, 32, 32, 4);
        } else {
            case.gl()
                .tex_storage_2d(setup.b_target, setup.b_levels, setup.b_format, 32, 32);
        }
    }
    case.expect_error(glw::GL_NO_ERROR);

    let layered = if setup.b_layered { glw::TRUE } else { glw::FALSE };
    // SAFETY: as above.
    unsafe {
        case.gl().bind_image_texture(
            ndx_b,
            texture_b.get(),
            setup.b_level,
            layered,
            setup.b_layer,
            setup.b_access,
            setup.b_bind_format,
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    (ndx_a, ndx_b)
}

/// `ImageBindingNameCase::iterate`
fn image_binding_name_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_NAME, ndx as GLuint, 0, verifier);
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D_ARRAY,
        b_levels: 1,
        b_format: glw::GL_RGBA8,
        b_level: 0,
        b_layered: false,
        b_layer: 2,
        b_access: glw::GL_READ_ONLY,
        b_bind_format: glw::GL_RGBA8UI,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
    let name_a = texture_a.get() as GLint;
    #[expect(clippy::cast_possible_wrap, reason = "a GL object name always fits in a GLint")]
    let name_b = texture_b.get() as GLint;
    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_NAME, ndx_a, name_a, verifier);
    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_NAME, ndx_b, name_b, verifier);
}

/// `ImageBindingLevelCase::iterate`
fn image_binding_level_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LEVEL, ndx as GLuint, 0, verifier);
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    // Texture B is a 3-level 2D texture here, not a 2D array - this is the one case
    // whose second texture is not layered.
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D,
        b_levels: 3,
        b_format: glw::GL_RGBA8,
        b_level: 2,
        b_layered: false,
        b_layer: 0,
        b_access: glw::GL_READ_ONLY,
        b_bind_format: glw::GL_RGBA8UI,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LEVEL, ndx_a, 0, verifier);
    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LEVEL, ndx_b, 2, verifier);
}

/// `ImageBindingLayeredCase::iterate`
fn image_binding_layered_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_boolean(case, glw::GL_IMAGE_BINDING_LAYERED, ndx as GLuint, false, verifier);
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D_ARRAY,
        b_levels: 1,
        b_format: glw::GL_RGBA8,
        b_level: 0,
        b_layered: true,
        b_layer: 2,
        b_access: glw::GL_READ_ONLY,
        b_bind_format: glw::GL_RGBA8UI,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    verify_state_indexed_boolean(case, glw::GL_IMAGE_BINDING_LAYERED, ndx_a, false, verifier);
    verify_state_indexed_boolean(case, glw::GL_IMAGE_BINDING_LAYERED, ndx_b, true, verifier);
}

/// `ImageBindingLayerCase::iterate`
fn image_binding_layer_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LAYER, ndx as GLuint, 0, verifier);
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D_ARRAY,
        b_levels: 1,
        b_format: glw::GL_RGBA8,
        b_level: 0,
        b_layered: true,
        b_layer: 2,
        b_access: glw::GL_READ_ONLY,
        b_bind_format: glw::GL_RGBA8UI,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LAYER, ndx_a, 0, verifier);
    verify_state_indexed_integer(case, glw::GL_IMAGE_BINDING_LAYER, ndx_b, 2, verifier);
}

/// `ImageBindingAccessCase::iterate`
fn image_binding_access_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_integer(
                case,
                glw::GL_IMAGE_BINDING_ACCESS,
                ndx as GLuint,
                glw::GL_READ_ONLY as GLint,
                verifier,
            );
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D_ARRAY,
        b_levels: 1,
        b_format: glw::GL_RGBA8,
        b_level: 0,
        b_layered: true,
        b_layer: 2,
        b_access: glw::GL_READ_WRITE,
        b_bind_format: glw::GL_RGBA8UI,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    verify_state_indexed_integer(
        case,
        glw::GL_IMAGE_BINDING_ACCESS,
        ndx_a,
        glw::GL_READ_ONLY as GLint,
        verifier,
    );
    verify_state_indexed_integer(
        case,
        glw::GL_IMAGE_BINDING_ACCESS,
        ndx_b,
        glw::GL_READ_WRITE as GLint,
        verifier,
    );
}

/// `ImageBindingFormatCase::iterate` - the initial value is `GL_R32UI` on ES (the
/// desktop `GL_R8` branch is dropped).
fn image_binding_format_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let max_images = case.get_int(glw::GL_MAX_IMAGE_UNITS);

    {
        case.section("Initial value");
        for ndx in 0..max_images {
            verify_state_indexed_integer(
                case,
                glw::GL_IMAGE_BINDING_FORMAT,
                ndx as GLuint,
                glw::GL_R32UI as GLint,
                verifier,
            );
        }
    }

    case.section("After setting");
    let texture_a = Texture::new(case.gl());
    let texture_b = Texture::new(case.gl());
    let setup = ImageBindSetup {
        b_target: glw::GL_TEXTURE_2D_ARRAY,
        b_levels: 1,
        b_format: glw::GL_R32F,
        b_level: 0,
        b_layered: true,
        b_layer: 2,
        b_access: glw::GL_READ_WRITE,
        b_bind_format: glw::GL_R32F,
    };
    let (ndx_a, ndx_b) = bind_image_pair(case, max_images, &setup, &texture_a, &texture_b);

    verify_state_indexed_integer(
        case,
        glw::GL_IMAGE_BINDING_FORMAT,
        ndx_a,
        glw::GL_RGBA8UI as GLint,
        verifier,
    );
    verify_state_indexed_integer(
        case,
        glw::GL_IMAGE_BINDING_FORMAT,
        ndx_b,
        glw::GL_R32F as GLint,
        verifier,
    );
}

/// `ColorMaskCase::init` + `iterate`
fn color_mask_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_boolean_vec4(case, glw::GL_COLOR_WRITEMASK, ndx as GLuint, [true; 4], verifier);
        }
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().color_mask(glw::FALSE, glw::TRUE, glw::TRUE, glw::FALSE) };
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_boolean_vec4(
                case,
                glw::GL_COLOR_WRITEMASK,
                ndx as GLuint,
                [false, true, true, false],
                verifier,
            );
        }
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            set_color_maski(case, ndx);
        }
        for ndx in 0..max_draw_buffers {
            let expected = if ndx % 2 == 0 {
                [true, false, true, false]
            } else {
                [false, true, false, true]
            };
            verify_state_indexed_boolean_vec4(case, glw::GL_COLOR_WRITEMASK, ndx as GLuint, expected, verifier);
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            set_color_maski(case, ndx);
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().color_mask(glw::FALSE, glw::TRUE, glw::TRUE, glw::FALSE) };
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_boolean_vec4(
                case,
                glw::GL_COLOR_WRITEMASK,
                ndx as GLuint,
                [false, true, true, false],
                verifier,
            );
        }
    }
}

/// The `glColorMaski` row upstream writes out twice, verbatim.
fn set_color_maski(case: &mut ApiCase<'_>, ndx: GLint) {
    let even = ndx % 2 == 0;
    let a = if even { glw::TRUE } else { glw::FALSE };
    let b = if even { glw::FALSE } else { glw::TRUE };
    // SAFETY: a plain index/state setter.
    unsafe { case.gl().color_maski(ndx as GLuint, a, b, a, b) };
}

const BLEND_FUNCS: [GLenum; 15] = [
    glw::GL_ZERO,
    glw::GL_ONE,
    glw::GL_SRC_COLOR,
    glw::GL_ONE_MINUS_SRC_COLOR,
    glw::GL_DST_COLOR,
    glw::GL_ONE_MINUS_DST_COLOR,
    glw::GL_SRC_ALPHA,
    glw::GL_ONE_MINUS_SRC_ALPHA,
    glw::GL_DST_ALPHA,
    glw::GL_ONE_MINUS_DST_ALPHA,
    glw::GL_CONSTANT_COLOR,
    glw::GL_ONE_MINUS_CONSTANT_COLOR,
    glw::GL_CONSTANT_ALPHA,
    glw::GL_ONE_MINUS_CONSTANT_ALPHA,
    glw::GL_SRC_ALPHA_SATURATE,
];

const BLEND_EQUATIONS: [GLenum; 5] = [
    glw::GL_FUNC_ADD,
    glw::GL_FUNC_SUBTRACT,
    glw::GL_FUNC_REVERSE_SUBTRACT,
    glw::GL_MIN,
    glw::GL_MAX,
];

const BLEND_EQUATION_ADVANCED: [GLenum; 15] = [
    glw::GL_MULTIPLY,
    glw::GL_SCREEN,
    glw::GL_OVERLAY,
    glw::GL_DARKEN,
    glw::GL_LIGHTEN,
    glw::GL_COLORDODGE,
    glw::GL_COLORBURN,
    glw::GL_HARDLIGHT,
    glw::GL_SOFTLIGHT,
    glw::GL_DIFFERENCE,
    glw::GL_EXCLUSION,
    glw::GL_HSL_HUE,
    glw::GL_HSL_SATURATION,
    glw::GL_HSL_COLOR,
    glw::GL_HSL_LUMINOSITY,
];

fn func_at(ndx: GLint, offset: usize) -> GLenum {
    BLEND_FUNCS[(ndx as usize + offset) % BLEND_FUNCS.len()]
}

fn equation_at(ndx: GLint, offset: usize) -> GLenum {
    BLEND_EQUATIONS[(ndx as usize + offset) % BLEND_EQUATIONS.len()]
}

fn advanced_at(ndx: GLint) -> GLenum {
    BLEND_EQUATION_ADVANCED[ndx as usize % BLEND_EQUATION_ADVANCED.len()]
}

/// The four `GL_BLEND_{SRC,DST}_{RGB,ALPHA}` verifications upstream writes as four
/// separate loops.
fn verify_blend_funcs(case: &mut ApiCase<'_>, max_draw_buffers: GLint, expected: [GLenum; 4], verifier: QueryType) {
    for (target, value) in [
        (glw::GL_BLEND_SRC_RGB, expected[0]),
        (glw::GL_BLEND_DST_RGB, expected[1]),
        (glw::GL_BLEND_SRC_ALPHA, expected[2]),
        (glw::GL_BLEND_DST_ALPHA, expected[3]),
    ] {
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
        }
    }
}

/// `BlendFuncCase::init` + `iterate`
fn blend_func_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [glw::GL_ONE, glw::GL_ZERO, glw::GL_ONE, glw::GL_ZERO],
            verifier,
        );
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_func(glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA) };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After setting common separate");
        // SAFETY: a plain state setter.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_funci(ndx as GLuint, func_at(ndx, 0), func_at(ndx, 1)) };
        }
        for ndx in 0..max_draw_buffers {
            for (target, value) in [
                (glw::GL_BLEND_SRC_RGB, func_at(ndx, 0)),
                (glw::GL_BLEND_DST_RGB, func_at(ndx, 1)),
                (glw::GL_BLEND_SRC_ALPHA, func_at(ndx, 0)),
                (glw::GL_BLEND_DST_ALPHA, func_at(ndx, 1)),
            ] {
                verify_state_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
            }
        }
    }
    {
        case.section("After setting indexed separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl().blend_func_separatei(
                    ndx as GLuint,
                    func_at(ndx, 3),
                    func_at(ndx, 2),
                    func_at(ndx, 1),
                    func_at(ndx, 0),
                )
            };
        }
        for ndx in 0..max_draw_buffers {
            for (target, value) in [
                (glw::GL_BLEND_SRC_RGB, func_at(ndx, 3)),
                (glw::GL_BLEND_DST_RGB, func_at(ndx, 2)),
                (glw::GL_BLEND_SRC_ALPHA, func_at(ndx, 1)),
                (glw::GL_BLEND_DST_ALPHA, func_at(ndx, 0)),
            ] {
                verify_state_indexed_integer(case, target, ndx as GLuint, value as GLint, verifier);
            }
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_funci(ndx as GLuint, func_at(ndx, 0), func_at(ndx, 1)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_func(glw::GL_SRC_ALPHA, glw::GL_DST_ALPHA) };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
                glw::GL_SRC_ALPHA,
                glw::GL_DST_ALPHA,
            ],
            verifier,
        );
    }
    {
        case.section("After resetting indexed with common separate");
        // SAFETY: a plain state setter. Upstream sets the common separate func both
        // before and after the indexed loop; kept as-is.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl().blend_func_separatei(
                    ndx as GLuint,
                    func_at(ndx, 3),
                    func_at(ndx, 2),
                    func_at(ndx, 1),
                    func_at(ndx, 0),
                )
            };
        }
        // SAFETY: a plain state setter.
        unsafe {
            case.gl().blend_func_separate(
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            )
        };
        verify_blend_funcs(
            case,
            max_draw_buffers,
            [
                glw::GL_SRC_COLOR,
                glw::GL_ONE_MINUS_SRC_ALPHA,
                glw::GL_DST_COLOR,
                glw::GL_ONE_MINUS_DST_ALPHA,
            ],
            verifier,
        );
    }
}

/// The two `GL_BLEND_EQUATION_{RGB,ALPHA}` loops upstream writes out separately.
fn verify_blend_equations(
    case: &mut ApiCase<'_>,
    max_draw_buffers: GLint,
    rgb: GLenum,
    alpha: GLenum,
    verifier: QueryType,
) {
    for ndx in 0..max_draw_buffers {
        verify_state_indexed_integer(case, glw::GL_BLEND_EQUATION_RGB, ndx as GLuint, rgb as GLint, verifier);
    }
    for ndx in 0..max_draw_buffers {
        verify_state_indexed_integer(
            case,
            glw::GL_BLEND_EQUATION_ALPHA,
            ndx as GLuint,
            alpha as GLint,
            verifier,
        );
    }
}

/// `BlendEquationCase::init` + `iterate`
fn blend_equation_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("Initial value");
        verify_blend_equations(case, max_draw_buffers, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD, verifier);
    }
    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_FUNC_SUBTRACT) };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After setting common separate");
        // SAFETY: a plain state setter.
        unsafe {
            case.gl()
                .blend_equation_separate(glw::GL_FUNC_REVERSE_SUBTRACT, glw::GL_FUNC_SUBTRACT)
        };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_REVERSE_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, equation_at(ndx, 0)) };
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After setting indexed separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                equation_at(ndx, 0) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                equation_at(ndx, 1) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, equation_at(ndx, 0)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_FUNC_SUBTRACT) };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
    {
        case.section("After resetting indexed with common separate");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        // SAFETY: a plain state setter.
        unsafe {
            case.gl()
                .blend_equation_separate(glw::GL_FUNC_REVERSE_SUBTRACT, glw::GL_FUNC_SUBTRACT)
        };
        verify_blend_equations(
            case,
            max_draw_buffers,
            glw::GL_FUNC_REVERSE_SUBTRACT,
            glw::GL_FUNC_SUBTRACT,
            verifier,
        );
    }
}

/// `BlendEquationAdvancedCase::init` + `iterate`
fn blend_equation_advanced_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_extension(case, "GL_EXT_draw_buffers_indexed") {
        return;
    }
    if !require_extension(case, "GL_KHR_blend_equation_advanced") {
        return;
    }

    let max_draw_buffers = case.get_int(glw::GL_MAX_DRAW_BUFFERS);

    {
        case.section("After setting common");
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_SCREEN) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_SCREEN, glw::GL_SCREEN, verifier);
    }
    {
        case.section("After setting indexed");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, advanced_at(ndx)) };
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_RGB,
                ndx as GLuint,
                advanced_at(ndx) as GLint,
                verifier,
            );
        }
        for ndx in 0..max_draw_buffers {
            verify_state_indexed_integer(
                case,
                glw::GL_BLEND_EQUATION_ALPHA,
                ndx as GLuint,
                advanced_at(ndx) as GLint,
                verifier,
            );
        }
    }
    {
        case.section("After resetting indexed with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe { case.gl().blend_equationi(ndx as GLuint, advanced_at(ndx)) };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_MULTIPLY) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_MULTIPLY, glw::GL_MULTIPLY, verifier);
    }
    {
        case.section("After resetting indexed separate with common");
        for ndx in 0..max_draw_buffers {
            // SAFETY: a plain index/state setter.
            unsafe {
                case.gl()
                    .blend_equation_separatei(ndx as GLuint, equation_at(ndx, 0), equation_at(ndx, 1))
            };
        }
        // SAFETY: a plain state setter.
        unsafe { case.gl().blend_equation(glw::GL_LIGHTEN) };
        verify_blend_equations(case, max_draw_buffers, glw::GL_LIGHTEN, glw::GL_LIGHTEN, verifier);
    }
}

/// `IndexedStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indexed");

    const VERIFIERS: [QueryType; 3] = [
        QueryType::IndexedBoolean,
        QueryType::IndexedInteger,
        QueryType::IndexedInteger64,
    ];

    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("sample_mask_value_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                sample_mask_case(case, verifier);
            },
        );
    }

    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("max_compute_work_group_count_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                min_value_indexed3_case(
                    case,
                    glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT,
                    [65535, 65535, 65535],
                    verifier,
                );
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("max_compute_work_group_size_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                min_value_indexed3_case(case, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, [128, 128, 64], verifier);
            },
        );
    }

    for (name, query_target, buffer_target, num_bindings_target, kind) in [
        (
            "atomic_counter_buffer_binding",
            glw::GL_ATOMIC_COUNTER_BUFFER_BINDING,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            0,
        ),
        (
            "atomic_counter_buffer_start",
            glw::GL_ATOMIC_COUNTER_BUFFER_START,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            1,
        ),
        (
            "atomic_counter_buffer_size",
            glw::GL_ATOMIC_COUNTER_BUFFER_SIZE,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            2,
        ),
        (
            "shader_storage_buffer_binding",
            glw::GL_SHADER_STORAGE_BUFFER_BINDING,
            glw::GL_SHADER_STORAGE_BUFFER,
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            0,
        ),
        (
            "shader_storage_buffer_start",
            glw::GL_SHADER_STORAGE_BUFFER_START,
            glw::GL_SHADER_STORAGE_BUFFER,
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            1,
        ),
        (
            "shader_storage_buffer_size",
            glw::GL_SHADER_STORAGE_BUFFER_SIZE,
            glw::GL_SHADER_STORAGE_BUFFER,
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            2,
        ),
    ] {
        for verifier in VERIFIERS {
            let suffix = verifier_suffix(verifier);
            add_api_case(
                &mut group,
                format!("{name}_{suffix}"),
                move |case: &mut ApiCase<'_>| match kind {
                    0 => buffer_binding_case(case, query_target, buffer_target, num_bindings_target, verifier),
                    1 => buffer_start_case(case, query_target, buffer_target, num_bindings_target, verifier),
                    _ => buffer_size_case(case, query_target, buffer_target, num_bindings_target, verifier),
                },
            );
        }
    }

    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_name_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_name_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_level_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_level_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_layered_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_layered_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_layer_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_layer_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_access_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_access_case(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        let suffix = verifier_suffix(verifier);
        add_api_case(
            &mut group,
            format!("image_binding_format_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                image_binding_format_case(case, verifier);
            },
        );
    }

    // All non-boolean verifiers are tested in the ES 3.0 test module.
    add_api_case(&mut group, "color_mask_getbooleani_v", |case: &mut ApiCase<'_>| {
        color_mask_case(case, QueryType::IndexedBooleanVec4);
    });
    add_api_case(&mut group, "blend_func_getbooleani_v", |case: &mut ApiCase<'_>| {
        blend_func_case(case, QueryType::IndexedBoolean);
    });
    add_api_case(&mut group, "blend_equation_getbooleani_v", |case: &mut ApiCase<'_>| {
        blend_equation_case(case, QueryType::IndexedBoolean);
    });
    add_api_case(
        &mut group,
        "blend_equation_advanced_getbooleani_v",
        |case: &mut ApiCase<'_>| {
            blend_equation_advanced_case(case, QueryType::IndexedBoolean);
        },
    );

    group
}
