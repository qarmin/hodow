// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fVertexAttributeBindingStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four `Mixed*` cases always
// create and bind their own VAO: upstream only does so on ES, and the port is ES-only.

use crate::gls::state_query_util::{QueryType, verify_state_attribute_integer, verify_state_indexed_integer};
use crate::glu::{ApiCase, Buffer, TestCaseGroup, VertexArray, add_api_case};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::Random;

/// The `verifiers[]` of `.vertex_attrib` - the first has no postfix at all, to avoid
/// renaming the cases that predate the other three.
const ATTRIBUTE_VERIFIERS: [(&str, QueryType); 4] = [
    ("", QueryType::AttributeInteger),
    ("_getvertexattribfv", QueryType::AttributeFloat),
    ("_getvertexattribiiv", QueryType::AttributePureInteger),
    ("_getvertexattribiuiv", QueryType::AttributePureUnsignedInteger),
];

/// The `verifiers[]` of `.indexed`
const INDEXED_VERIFIERS: [(&str, QueryType); 3] = [
    ("getintegeri", QueryType::IndexedInteger),
    ("getintegeri64", QueryType::IndexedInteger64),
    ("getboolean", QueryType::IndexedBoolean),
];

/// `de::max(16, reported)` - the queries must answer for at least 16 attributes or
/// bindings even if the implementation reports fewer.
fn queried_count(case: &mut ApiCase<'_>, limit: glw::GLenum) -> i32 {
    let mut reported: GLint = -1;
    // SAFETY: one integer out.
    unsafe { case.gl().get_integerv(limit, &raw mut reported) };
    case.expect_no_error("glGetIntegerv");
    reported.max(16)
}

/// `AttributeBindingCase::test`
fn attribute_binding_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    // SAFETY: a VAO this case owns for its whole body.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_attrs = queried_count(case, glw::GL_MAX_VERTEX_ATTRIBS);

    case.section("Initial values");
    for attr in 0..max_attrs {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = attr as GLuint;
        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_BINDING, index, attr, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        // SAFETY: both VAOs are this case's own.
        unsafe {
            case.gl().vertex_attrib_binding(1, 4);
        }
        case.expect_no_error("glVertexAttribBinding");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(other_vao.get()) };
        case.expect_no_error("glBindVertexArray");
        // SAFETY: as above.
        unsafe { case.gl().vertex_attrib_binding(1, 7) };
        case.expect_no_error("glVertexAttribBinding");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_BINDING, 1, 4, verifier);
    }

    case.section("Random values");
    let mut rnd = Random::new(0xabc);
    for _ in 0..10 {
        let va = rnd.get_int(0, max_attrs - 1);
        let binding = rnd.get_int(0, 16);

        #[expect(clippy::cast_sign_loss, reason = "both come from a non-negative range")]
        let (va_index, binding_index) = (va as GLuint, binding as GLuint);
        // SAFETY: both indices are within the limits queried above.
        unsafe { case.gl().vertex_attrib_binding(va_index, binding_index) };
        case.expect_no_error("glVertexAttribBinding");

        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_BINDING, va_index, binding, verifier);
    }
}

/// `AttributeRelativeOffsetCase::test`
fn attribute_relative_offset_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    // SAFETY: a VAO this case owns for its whole body.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_attrs = queried_count(case, glw::GL_MAX_VERTEX_ATTRIBS);

    case.section("Initial values");
    for attr in 0..max_attrs {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = attr as GLuint;
        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, index, 0, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        // SAFETY: a legal format for attribute 1 on the bound VAO.
        unsafe { case.gl().vertex_attrib_format(1, 4, glw::GL_FLOAT, glw::FALSE, 9) };
        case.expect_no_error("glVertexAttribFormat");
        // SAFETY: this case's own VAO.
        unsafe { case.gl().bind_vertex_array(other_vao.get()) };
        case.expect_no_error("glBindVertexArray");
        // SAFETY: as above.
        unsafe { case.gl().vertex_attrib_format(1, 4, glw::GL_FLOAT, glw::FALSE, 21) };
        case.expect_no_error("glVertexAttribFormat");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, 1, 9, verifier);
    }

    case.section("Random values");
    let mut rnd = Random::new(0xabc);
    for _ in 0..10 {
        let va = rnd.get_int(0, max_attrs - 1);
        let offset = rnd.get_int(0, 2047);

        #[expect(clippy::cast_sign_loss, reason = "both come from a non-negative range")]
        let (va_index, offset_u) = (va as GLuint, offset as GLuint);
        // SAFETY: the offset is within GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET's minimum.
        unsafe {
            case.gl()
                .vertex_attrib_format(va_index, 4, glw::GL_FLOAT, glw::FALSE, offset_u)
        };
        case.expect_no_error("glVertexAttribFormat");

        verify_state_attribute_integer(case, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, va_index, offset, verifier);
    }
}

/// `VertexBindingDivisorCase::test`
fn vertex_binding_divisor_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    // SAFETY: a VAO this case owns for its whole body.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_bindings = queried_count(case, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);

    case.section("Initial values");
    for binding in 0..max_bindings {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = binding as GLuint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_DIVISOR, index, 0, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        // SAFETY: a divisor on the bound VAO's binding 1.
        unsafe { case.gl().vertex_binding_divisor(1, 4) };
        case.expect_no_error("glVertexBindingDivisor");
        // SAFETY: this case's own VAO.
        unsafe { case.gl().bind_vertex_array(other_vao.get()) };
        case.expect_no_error("glBindVertexArray");
        // SAFETY: as above.
        unsafe { case.gl().vertex_binding_divisor(1, 9) };
        case.expect_no_error("glVertexBindingDivisor");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_DIVISOR, 1, 4, verifier);
    }

    case.section("Random values");
    let mut rnd = Random::new(0xabc);
    for _ in 0..10 {
        let binding = rnd.get_int(0, max_bindings - 1);
        let divisor = rnd.get_int(0, 2047);

        #[expect(clippy::cast_sign_loss, reason = "both come from a non-negative range")]
        let (binding_index, divisor_u) = (binding as GLuint, divisor as GLuint);
        // SAFETY: the binding index is within the limit queried above.
        unsafe { case.gl().vertex_binding_divisor(binding_index, divisor_u) };
        case.expect_no_error("glVertexBindingDivisor");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_DIVISOR, binding_index, divisor, verifier);
    }
}

/// `VertexBindingOffsetCase::test`
fn vertex_binding_offset_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: both objects are this case's own.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_bindings = queried_count(case, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);

    case.section("Initial values");
    for binding in 0..max_bindings {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = binding as GLuint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_OFFSET, index, 0, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        // SAFETY: this case's own buffer and VAOs.
        unsafe { case.gl().bind_vertex_buffer(1, buffer.get(), 4, 32) };
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(other_vao.get()) };
        case.expect_no_error("glBindVertexArray");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_buffer(1, buffer.get(), 13, 32) };
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_OFFSET, 1, 4, verifier);
    }

    case.section("Random values");
    let mut rnd = Random::new(0xabc);
    for _ in 0..10 {
        let binding = rnd.get_int(0, max_bindings - 1);
        let offset = rnd.get_int(0, 4000);

        #[expect(clippy::cast_sign_loss, reason = "the binding index comes from a non-negative range")]
        let binding_index = binding as GLuint;
        // SAFETY: as above.
        unsafe {
            let offset_ptr = offset as glw::GLintptr;
            case.gl()
                .bind_vertex_buffer(binding_index, buffer.get(), offset_ptr, 32);
        }
        case.expect_no_error("glBindVertexBuffer");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_OFFSET, binding_index, offset, verifier);
    }
}

/// `VertexBindingStrideCase::test`
fn vertex_binding_stride_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: both objects are this case's own.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_bindings = queried_count(case, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);

    case.section("Initial values");
    for binding in 0..max_bindings {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = binding as GLuint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_STRIDE, index, 16, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        // SAFETY: this case's own buffer and VAOs.
        unsafe { case.gl().bind_vertex_buffer(1, buffer.get(), 0, 32) };
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(other_vao.get()) };
        case.expect_no_error("glBindVertexArray");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_buffer(1, buffer.get(), 0, 64) };
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_STRIDE, 1, 32, verifier);
    }

    case.section("Random values");
    let mut rnd = Random::new(0xabc);
    for _ in 0..10 {
        let binding = rnd.get_int(0, max_bindings - 1);
        let stride = rnd.get_int(0, 2048);

        #[expect(clippy::cast_sign_loss, reason = "the binding index comes from a non-negative range")]
        let binding_index = binding as GLuint;
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_buffer(binding_index, buffer.get(), 0, stride) };
        case.expect_no_error("glBindVertexBuffer");

        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_STRIDE, binding_index, stride, verifier);
    }
}

/// `VertexBindingBufferCase::test`
fn vertex_binding_buffer_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: both objects are this case's own.
    unsafe { case.gl().bind_vertex_array(vao.get()) };
    let max_bindings = queried_count(case, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);

    case.section("Initial values");
    for binding in 0..max_bindings {
        #[expect(clippy::cast_sign_loss, reason = "the loop starts at zero")]
        let index = binding as GLuint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_BUFFER, index, 0, verifier);
    }

    case.section("VAO state");
    {
        let other_vao = VertexArray::new(case.gl());
        let other_buffer = Buffer::new(case.gl());
        // SAFETY: this case's own objects.
        unsafe { case.gl().bind_vertex_buffer(1, buffer.get(), 0, 32) };
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe {
            case.gl().bind_vertex_array(other_vao.get());
            case.gl().bind_vertex_buffer(1, other_buffer.get(), 0, 32);
        }
        case.expect_no_error("glBindVertexBuffer");
        // SAFETY: as above.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        case.expect_no_error("glBindVertexArray");

        #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
        let buffer_as_int = buffer.get() as GLint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_BUFFER, 1, buffer_as_int, verifier);
    }

    case.section("Deleting a bound buffer");
    {
        let other_vao = VertexArray::new(case.gl());
        let mut other_buffer: GLuint = 0;
        // SAFETY: a name this block generates and deletes itself.
        unsafe {
            case.gl().gen_buffers(1, &raw mut other_buffer);
            case.gl().bind_vertex_buffer(1, other_buffer, 0, 32);
            case.gl().bind_vertex_array(other_vao.get());
            case.gl().bind_vertex_buffer(1, other_buffer, 0, 32);
            case.gl().delete_buffers(1, &raw const other_buffer);
        }
        case.expect_no_error("setup");

        // Deleting the buffer clears the binding in the *currently bound* VAO only.
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_BUFFER, 1, 0, verifier);

        // SAFETY: this case's own VAO.
        unsafe { case.gl().bind_vertex_array(vao.get()) };
        #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
        let other_as_int = other_buffer as GLint;
        verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_BUFFER, 1, other_as_int, verifier);
    }
}

/// `MixedVertexBindingDivisorCase::test`
fn mixed_vertex_binding_divisor_case(case: &mut ApiCase<'_>) {
    let vao = VertexArray::new(case.gl());
    // SAFETY: a VAO this case owns; `glVertexAttribDivisor` writes the binding state.
    unsafe {
        case.gl().bind_vertex_array(vao.get());
        case.gl().vertex_attrib_divisor(1, 4);
    }
    case.expect_no_error("glVertexAttribDivisor");
    verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_DIVISOR, 1, 4, QueryType::IndexedInteger);
}

/// `MixedVertexBindingOffsetCase::test`
fn mixed_vertex_binding_offset_case(case: &mut ApiCase<'_>) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: this case's own objects; the pointer argument is a buffer offset.
    unsafe {
        case.gl().bind_vertex_array(vao.get());
        case.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        case.gl()
            .vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::without_provenance(12));
    }
    case.expect_no_error("glVertexAttribPointer");
    verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_OFFSET, 1, 12, QueryType::IndexedInteger);
}

/// `MixedVertexBindingStrideCase::test`
fn mixed_vertex_binding_stride_case(case: &mut ApiCase<'_>) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: as above.
    unsafe {
        case.gl().bind_vertex_array(vao.get());
        case.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        case.gl()
            .vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 12, std::ptr::null());
    }
    case.expect_no_error("glVertexAttribPointer");
    verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_STRIDE, 1, 12, QueryType::IndexedInteger);

    // A stride of zero means "tightly packed", which for four floats is 16.
    // SAFETY: as above.
    unsafe {
        case.gl()
            .vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
    };
    case.expect_no_error("glVertexAttribPointer");
    verify_state_indexed_integer(case, glw::GL_VERTEX_BINDING_STRIDE, 1, 16, QueryType::IndexedInteger);
}

/// `MixedVertexBindingBufferCase::test`
fn mixed_vertex_binding_buffer_case(case: &mut ApiCase<'_>) {
    let vao = VertexArray::new(case.gl());
    let buffer = Buffer::new(case.gl());
    // SAFETY: as above.
    unsafe {
        case.gl().bind_vertex_array(vao.get());
        case.gl().bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        case.gl()
            .vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
    }
    case.expect_no_error("glVertexAttribPointer");

    #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
    let buffer_as_int = buffer.get() as GLint;
    verify_state_indexed_integer(
        case,
        glw::GL_VERTEX_BINDING_BUFFER,
        1,
        buffer_as_int,
        QueryType::IndexedInteger,
    );
}

/// `VertexAttributeBindingStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_attribute_binding");

    let mut attribute_group = TestCaseGroup::new("vertex_attrib");
    for (suffix, verifier) in ATTRIBUTE_VERIFIERS {
        add_api_case(
            &mut attribute_group,
            format!("vertex_attrib_binding{suffix}"),
            move |case: &mut ApiCase<'_>| {
                attribute_binding_case(case, verifier);
            },
        );
        add_api_case(
            &mut attribute_group,
            format!("vertex_attrib_relative_offset{suffix}"),
            move |case: &mut ApiCase<'_>| {
                attribute_relative_offset_case(case, verifier);
            },
        );
    }
    group.add_child(attribute_group);

    let mut indexed_group = TestCaseGroup::new("indexed");
    for (name, verifier) in INDEXED_VERIFIERS {
        add_api_case(
            &mut indexed_group,
            format!("vertex_binding_divisor_{name}"),
            move |case: &mut ApiCase<'_>| {
                vertex_binding_divisor_case(case, verifier);
            },
        );
        add_api_case(
            &mut indexed_group,
            format!("vertex_binding_offset_{name}"),
            move |case: &mut ApiCase<'_>| {
                vertex_binding_offset_case(case, verifier);
            },
        );
        add_api_case(
            &mut indexed_group,
            format!("vertex_binding_stride_{name}"),
            move |case: &mut ApiCase<'_>| {
                vertex_binding_stride_case(case, verifier);
            },
        );
        add_api_case(
            &mut indexed_group,
            format!("vertex_binding_buffer_{name}"),
            move |case: &mut ApiCase<'_>| {
                vertex_binding_buffer_case(case, verifier);
            },
        );
    }
    add_api_case(
        &mut indexed_group,
        "vertex_binding_divisor_mixed",
        mixed_vertex_binding_divisor_case,
    );
    add_api_case(
        &mut indexed_group,
        "vertex_binding_offset_mixed",
        mixed_vertex_binding_offset_case,
    );
    add_api_case(
        &mut indexed_group,
        "vertex_binding_stride_mixed",
        mixed_vertex_binding_stride_case,
    );
    add_api_case(
        &mut indexed_group,
        "vertex_binding_buffer_mixed",
        mixed_vertex_binding_buffer_case,
    );
    group.add_child(indexed_group);

    group
}
