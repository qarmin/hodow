// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureBufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All five sub-groups (`state_query`,
// `render`, `modify`, `modify_render`, `render_modify`) are ported, through
// `gls::TextureBufferCase`, which renders the buffer's contents and compares against a
// reference built on the host.

use crate::gls::state_query_util::{
    QueryType, verify_state_integer, verify_state_integer_max, verify_state_integer_min,
    verify_state_texture_level_integer,
};
use crate::gls::texture_buffer_case::{ModifyBits, RenderBits, render_case, run_case};
use crate::glu::{ApiCase, Buffer, Context, TestCaseGroup, Texture, add_api_case};
use crate::glw::{self, GLenum, GLsizeiptr};

/// `checkSupport`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached and is not written out.
fn check_support(case: &mut ApiCase<'_>) -> bool {
    let context: &Context = case.context();
    if context.context_type().supports(3, 2) || context.context_info.is_extension_supported("GL_EXT_texture_buffer") {
        return true;
    }
    case.not_supported("GL_EXT_texture_buffer is not supported");
    false
}

/// `LimitQueryCase::iterate`
fn limit_query_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, verifier: QueryType) {
    if !check_support(case) {
        return;
    }
    verify_state_integer_min(case, target, min_value, verifier);
}

/// `AlignmentQueryCase::iterate`
fn alignment_query_case(case: &mut ApiCase<'_>, target: GLenum, max_value: i32, verifier: QueryType) {
    if !check_support(case) {
        return;
    }
    verify_state_integer_max(case, target, max_value, verifier);
}

/// `TextureBufferBindingQueryCase::iterate`
fn texture_buffer_binding_query_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }

    // initial
    case.section("Initial value");
    verify_state_integer(case, glw::GL_TEXTURE_BUFFER_BINDING, 0, verifier);

    // bind
    case.section("After bind");
    let buffer = Buffer::new(case.gl());
    // SAFETY: a name this case generated.
    unsafe { case.gl().bind_buffer(glw::GL_TEXTURE_BUFFER, buffer.get()) };
    case.expect_no_error("bind buffer");

    #[expect(
        clippy::cast_possible_wrap,
        reason = "upstream compares the GLuint name against a GLint state"
    )]
    let name = buffer.get() as i32;
    verify_state_integer(case, glw::GL_TEXTURE_BUFFER_BINDING, name, verifier);

    drop(buffer);

    // after delete
    case.section("After delete");
    verify_state_integer(case, glw::GL_TEXTURE_BUFFER_BINDING, 0, verifier);
}

/// `TextureBindingBufferQueryCase::iterate`
fn texture_binding_buffer_query_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }

    // initial
    case.section("Initial value");
    verify_state_integer(case, glw::GL_TEXTURE_BINDING_BUFFER, 0, verifier);

    // bind
    case.section("After bind");
    let texture = Texture::new(case.gl());
    // SAFETY: a name this case generated.
    unsafe { case.gl().bind_texture(glw::GL_TEXTURE_BUFFER, texture.get()) };
    case.expect_no_error("bind texture");

    #[expect(
        clippy::cast_possible_wrap,
        reason = "upstream compares the GLuint name against a GLint state"
    )]
    let name = texture.get() as i32;
    verify_state_integer(case, glw::GL_TEXTURE_BINDING_BUFFER, name, verifier);

    drop(texture);

    // after delete
    case.section("After delete");
    verify_state_integer(case, glw::GL_TEXTURE_BINDING_BUFFER, 0, verifier);
}

/// The "non-buffer" section the three texture-level query cases share: a plain 2D texture
/// answers 0 for every texture-buffer property.
fn check_non_buffer_texture_level(case: &mut ApiCase<'_>, pname: GLenum, verifier: QueryType) {
    case.section("Non-buffer");
    let texture = Texture::new(case.gl());
    // SAFETY: a name this case generated, given a complete 2D storage.
    unsafe {
        case.gl().bind_texture(glw::GL_TEXTURE_2D, texture.get());
        case.gl().tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 32, 32);
    }
    case.expect_no_error("gen texture");

    verify_state_texture_level_integer(case, glw::GL_TEXTURE_2D, 0, pname, 0, verifier);
}

/// The "texture buffer" section's setup: a texture buffer backed by `size` bytes.
fn bind_texture_buffer<'gl>(case: &mut ApiCase<'gl>, size: GLsizeiptr) -> (Texture<'gl>, Buffer<'gl>) {
    let gl = case.gl();
    let texture = Texture::new(gl);
    // SAFETY: a name this case generated.
    unsafe { gl.bind_texture(glw::GL_TEXTURE_BUFFER, texture.get()) };
    case.expect_no_error("bind texture");

    let buffer = Buffer::new(gl);
    // SAFETY: an uninitialised store of `size` bytes, which is what upstream allocates.
    unsafe {
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer.get());
        gl.buffer_data(glw::GL_TEXTURE_BUFFER, size, std::ptr::null(), glw::GL_STATIC_DRAW);
    }
    case.expect_no_error("bind buf");

    (texture, buffer)
}

/// `TextureBufferDataStoreQueryCase::iterate`
fn texture_buffer_data_store_query_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case) {
        return;
    }

    check_non_buffer_texture_level(case, glw::GL_TEXTURE_BUFFER_DATA_STORE_BINDING, verifier);

    case.section("Texture buffer");
    let (_texture, buffer) = bind_texture_buffer(case, 32);

    // SAFETY: the buffer is bound to GL_TEXTURE_BUFFER and outlives the query.
    unsafe {
        case.gl()
            .tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, buffer.get())
    };
    case.expect_no_error("tex buffer");

    #[expect(
        clippy::cast_possible_wrap,
        reason = "upstream compares the GLuint name against a GLint state"
    )]
    let name = buffer.get() as i32;
    verify_state_texture_level_integer(
        case,
        glw::GL_TEXTURE_BUFFER,
        0,
        glw::GL_TEXTURE_BUFFER_DATA_STORE_BINDING,
        name,
        verifier,
    );
}

/// `TextureBufferOffsetQueryCase::iterate` and `TextureBufferSizeQueryCase::iterate`.
///
/// The two are the same case with a different `pname` and a different pair of expected
/// values: offset answers 0 then 256, size answers the whole 1024 then the 512 of the range.
fn texture_buffer_range_query_case(
    case: &mut ApiCase<'_>,
    pname: GLenum,
    whole: i32,
    ranged: i32,
    verifier: QueryType,
) {
    if !check_support(case) {
        return;
    }

    check_non_buffer_texture_level(case, pname, verifier);

    case.section("Texture buffer");
    let (_texture, buffer) = bind_texture_buffer(case, 1024);

    // SAFETY: the buffer is bound to GL_TEXTURE_BUFFER and outlives both queries.
    unsafe {
        case.gl()
            .tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, buffer.get())
    };
    case.expect_no_error("tex buffer");
    verify_state_texture_level_integer(case, glw::GL_TEXTURE_BUFFER, 0, pname, whole, verifier);

    // SAFETY: as above; 256 is the alignment every implementation is allowed to require.
    unsafe {
        case.gl()
            .tex_buffer_range(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, buffer.get(), 256, 512)
    };
    case.expect_no_error("tex buffer");
    verify_state_texture_level_integer(case, glw::GL_TEXTURE_BUFFER, 0, pname, ranged, verifier);
}

/// `FOR_ALL_TYPES`'s order in this file: boolean, integer, integer64, float.
const ALL_TYPES: [(&str, QueryType); 4] = [
    ("getboolean", QueryType::Boolean),
    ("getinteger", QueryType::Integer),
    ("getinteger64", QueryType::Integer64),
    ("getfloat", QueryType::Float),
];

/// `createTextureBufferTests`' `state_query` sub-group.
fn state_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");

    for (suffix, verifier) in ALL_TYPES {
        add_api_case(
            &mut group,
            format!("max_texture_buffer_size_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                limit_query_case(case, glw::GL_MAX_TEXTURE_BUFFER_SIZE, 65536, verifier);
            },
        );
    }
    for (suffix, verifier) in ALL_TYPES {
        add_api_case(
            &mut group,
            format!("texture_buffer_offset_alignment_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                alignment_query_case(case, glw::GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT, 256, verifier);
            },
        );
    }
    for (suffix, verifier) in ALL_TYPES {
        add_api_case(
            &mut group,
            format!("texture_buffer_binding_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                texture_buffer_binding_query_case(case, verifier);
            },
        );
    }
    for (suffix, verifier) in ALL_TYPES {
        add_api_case(
            &mut group,
            format!("texture_binding_buffer_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                texture_binding_buffer_query_case(case, verifier);
            },
        );
    }

    for (suffix, verifier) in [
        ("integer", QueryType::TextureLevelInteger),
        ("float", QueryType::TextureLevelFloat),
    ] {
        add_api_case(
            &mut group,
            format!("texture_buffer_data_store_binding_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                texture_buffer_data_store_query_case(case, verifier);
            },
        );
    }
    for (suffix, verifier) in [
        ("integer", QueryType::TextureLevelInteger),
        ("float", QueryType::TextureLevelFloat),
    ] {
        add_api_case(
            &mut group,
            format!("texture_buffer_offset_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                texture_buffer_range_query_case(case, glw::GL_TEXTURE_BUFFER_OFFSET, 0, 256, verifier);
            },
        );
    }
    for (suffix, verifier) in [
        ("integer", QueryType::TextureLevelInteger),
        ("float", QueryType::TextureLevelFloat),
    ] {
        add_api_case(
            &mut group,
            format!("texture_buffer_size_{suffix}"),
            move |case: &mut ApiCase<'_>| {
                texture_buffer_range_query_case(case, glw::GL_TEXTURE_BUFFER_SIZE, 1024, 512, verifier);
            },
        );
    }

    group
}

/// `createTextureBufferTests`'s `renderTypeCombinations` - all 15 non-empty subsets of
/// the four `RenderBits`, in upstream's own declaration order.
const RENDER_TYPE_COMBINATIONS: [RenderBits; 15] = [
    RenderBits::new(true, false, false, false),
    RenderBits::new(false, true, false, false),
    RenderBits::new(true, true, false, false),
    RenderBits::new(false, false, true, false),
    RenderBits::new(true, false, true, false),
    RenderBits::new(false, true, true, false),
    RenderBits::new(true, true, true, false),
    RenderBits::new(false, false, false, true),
    RenderBits::new(true, false, false, true),
    RenderBits::new(false, true, false, true),
    RenderBits::new(true, true, false, true),
    RenderBits::new(false, false, true, true),
    RenderBits::new(true, false, true, true),
    RenderBits::new(false, true, true, true),
    RenderBits::new(true, true, true, true),
];

/// `createTextureBufferTests`'s `bufferSizes`/`rangeSizes`/`offsets` tables, folded into
/// the case-name -> `(buffer_size, offset_units, size)` triples the `render` group
/// registers per render type.
fn render_group_cases() -> Vec<(String, usize, usize, usize)> {
    let mut cases = Vec::new();
    for size in [512usize, 513, 65536, 65537, 131071] {
        cases.push((format!("buffer_size_{size}"), size, 0, 0));
    }
    for size in [512usize, 513, 65537, 98304] {
        cases.push((format!("range_size_{size}"), 131072, 0, size));
    }
    for offset in [1usize, 7] {
        cases.push((format!("offset_{offset}_alignments"), 131072, offset, 65537));
    }
    cases
}

/// `createTextureBufferTests`'s `render` sub-group: "Setup texture buffer with
/// glBufferData and render data in different ways".
fn render_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("render");
    for render in RENDER_TYPE_COMBINATIONS {
        let mut render_type_group = TestCaseGroup::new(render.test_name());
        for (name, buffer_size, offset_units, size) in render_group_cases() {
            add_api_case(&mut render_type_group, name.clone(), move |case: &mut ApiCase<'_>| {
                render_case(case, &name, buffer_size, offset_units, size, render);
            });
        }
        group.add_child(render_type_group);
    }
    group
}

/// `createTextureBufferTests`'s `modifyTypes` table, in upstream's own order.
const MODIFY_TYPES: [ModifyBits; 4] = [
    ModifyBits::new(true, false, false, false),
    ModifyBits::new(false, true, false, false),
    ModifyBits::new(false, false, true, false),
    ModifyBits::new(false, false, false, true),
];

/// `RENDERBITS_AS_FRAGMENT_TEXTURE` alone - the fixed `postRender`/`preRender` every
/// `modify`/`modify_render` (respectively `render_modify`) case renders through.
const AS_FRAGMENT_TEXTURE: RenderBits = RenderBits::new(false, false, false, true);

/// `createTextureBufferTests`'s `modify` sub-group: "Modify texture buffer content in
/// multiple ways". Same `bufferSizes`/`rangeSizes`/`offsets` cases as `render`
/// (`render_group_cases`), `preRender` none, `postRender` always
/// `RENDERBITS_AS_FRAGMENT_TEXTURE`.
fn modify_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("modify");
    for modify in MODIFY_TYPES {
        let mut modify_type_group = TestCaseGroup::new(modify.test_name());
        for (name, buffer_size, offset_units, size) in render_group_cases() {
            add_api_case(&mut modify_type_group, name.clone(), move |case: &mut ApiCase<'_>| {
                run_case(
                    case,
                    &name,
                    buffer_size,
                    offset_units,
                    size,
                    None,
                    Some(modify),
                    Some(AS_FRAGMENT_TEXTURE),
                );
            });
        }
        group.add_child(modify_type_group);
    }
    group
}

/// `createTextureBufferTests`'s `modify_render` sub-group: "Modify texture buffer
/// content in multiple ways and render in different ways". `preRender` none, `size` a
/// fixed 16 KiB (no range/offset), `postRender` every `RENDER_TYPE_COMBINATIONS` entry.
fn modify_render_group() -> TestCaseGroup {
    const SIZE: usize = 16 * 1024;
    let mut group = TestCaseGroup::new("modify_render");
    for modify in MODIFY_TYPES {
        let mut modify_type_group = TestCaseGroup::new(modify.test_name());
        for render in RENDER_TYPE_COMBINATIONS {
            let name = render.test_name();
            add_api_case(&mut modify_type_group, name.clone(), move |case: &mut ApiCase<'_>| {
                run_case(case, &name, SIZE, 0, 0, None, Some(modify), Some(render));
            });
        }
        group.add_child(modify_type_group);
    }
    group
}

/// `createTextureBufferTests`'s `render_modify` sub-group: "Render texture buffer and
/// modify.". `preRender` every `RENDER_TYPE_COMBINATIONS` entry, `size` the same fixed
/// 16 KiB, `postRender` always `RENDERBITS_AS_FRAGMENT_TEXTURE`.
fn render_modify_group() -> TestCaseGroup {
    const SIZE: usize = 16 * 1024;
    let mut group = TestCaseGroup::new("render_modify");
    for render in RENDER_TYPE_COMBINATIONS {
        let mut render_type_group = TestCaseGroup::new(render.test_name());
        for modify in MODIFY_TYPES {
            let name = modify.test_name().to_string();
            add_api_case(&mut render_type_group, name.clone(), move |case: &mut ApiCase<'_>| {
                run_case(
                    case,
                    &name,
                    SIZE,
                    0,
                    0,
                    Some(render),
                    Some(modify),
                    Some(AS_FRAGMENT_TEXTURE),
                );
            });
        }
        group.add_child(render_type_group);
    }
    group
}

/// `createTextureBufferTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_buffer");
    group.add_child(state_query_group());
    group.add_child(render_group());
    group.add_child(modify_group());
    group.add_child(modify_render_group());
    group.add_child(render_modify_group());
    group
}
