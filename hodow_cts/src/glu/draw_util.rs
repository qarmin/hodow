// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluDrawUtil.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, ported on demand. Only the
// user-pointer path is here, which is the one `glu::draw` takes on a pre-ES-3.1
// context; the buffer/VAO path it takes on ES 3.1 and GL core raises `NotPorted`
// rather than quietly drawing from a different source than upstream would.
// Only `VTX_COMP_FLOAT` components and `INDEXTYPE_UINT16` indices are ported.

use std::ffi::CString;

use crate::glu::RenderContext;
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::TestError;

/// `glu::VertexComponentType`, restricted to the one variant ported.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VertexComponentType {
    Float,
}

/// `glu::PrimitiveType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveType {
    Triangles,
    TriangleStrip,
    TriangleFan,
    Lines,
    LineStrip,
    LineLoop,
    Points,
}

/// `getPrimitiveGLType`
fn get_primitive_gl_type(type_: PrimitiveType) -> GLenum {
    match type_ {
        PrimitiveType::Triangles => glw::GL_TRIANGLES,
        PrimitiveType::TriangleStrip => glw::GL_TRIANGLE_STRIP,
        PrimitiveType::TriangleFan => glw::GL_TRIANGLE_FAN,
        PrimitiveType::Lines => glw::GL_LINES,
        PrimitiveType::LineStrip => glw::GL_LINE_STRIP,
        PrimitiveType::LineLoop => glw::GL_LINE_LOOP,
        PrimitiveType::Points => glw::GL_POINTS,
    }
}

/// `glu::VertexArrayPointer`
pub struct VertexArrayPointer<'a> {
    pub component_type: VertexComponentType,
    pub num_components: i32,
    pub num_elements: i32,
    pub stride: i32,
    pub data: &'a [f32],
}

/// `glu::VertexArrayBinding`, always bound by name (`BPTYPE_NAME`).
pub struct VertexArrayBinding<'a> {
    pub name: &'a str,
    pub pointer: VertexArrayPointer<'a>,
}

/// `glu::va` - the shorthand constructors upstream's tests write at the call site.
pub mod va {
    use super::{VertexArrayBinding, VertexArrayPointer, VertexComponentType};

    /// `glu::va::Float(name, numComponents, numElements, stride, data)`
    pub fn float<'a>(name: &'a str, num_components: i32, num_elements: i32, stride: i32, data: &'a [f32]) -> VertexArrayBinding<'a> {
        VertexArrayBinding {
            name,
            pointer: VertexArrayPointer {
                component_type: VertexComponentType::Float,
                num_components,
                num_elements,
                stride,
                data,
            },
        }
    }
}

/// `glu::PrimitiveList`
pub struct PrimitiveList<'a> {
    pub type_: PrimitiveType,
    pub num_elements: i32,
    pub indices: Option<&'a [u16]>,
}

/// `glu::pr` - the shorthand constructors upstream's tests write at the call site.
pub mod pr {
    use super::{PrimitiveList, PrimitiveType};

    /// `glu::pr::Triangles(numElements, indices)`
    pub fn triangles(indices: &[u16]) -> PrimitiveList<'_> {
        PrimitiveList {
            type_: PrimitiveType::Triangles,
            num_elements: indices.len() as i32,
            indices: Some(indices),
        }
    }
}

/// `glu::drawFromUserPointers`
pub fn draw_from_user_pointers(context: &RenderContext, program: GLuint, vertex_arrays: &[VertexArrayBinding<'_>], primitives: &PrimitiveList<'_>) -> Result<(), TestError> {
    let gl = context.functions();

    // Lower bindings to locations.
    let mut locations = Vec::with_capacity(vertex_arrays.len());
    for va in vertex_arrays {
        let name = CString::new(va.name).map_err(|_| TestError::InternalError("attribute name with an interior NUL".to_string()))?;
        // SAFETY: a NUL-terminated name and a program name the caller owns.
        let location = unsafe { gl.get_attrib_location(program, name.as_ptr()) };
        if location >= 0 {
            locations.push((location as GLuint, va));
        }
    }

    // Set VA state.
    for &(location, va) in &locations {
        debug_assert!(va.pointer.component_type == VertexComponentType::Float);
        // SAFETY: the client-side array outlives the draw below, and the attribute is
        // told exactly how many components and elements it holds.
        unsafe {
            gl.enable_vertex_attrib_array(location);
            gl.vertex_attrib_pointer(
                location,
                va.pointer.num_components,
                glw::GL_FLOAT,
                glw::FALSE,
                va.pointer.stride,
                va.pointer.data.as_ptr().cast(),
            );
        }
    }

    let mode = get_primitive_gl_type(primitives.type_);
    // SAFETY: as above; an index array, when there is one, outlives the call too.
    unsafe {
        match primitives.indices {
            Some(indices) => gl.draw_elements(mode, primitives.num_elements, glw::GL_UNSIGNED_SHORT, indices.as_ptr().cast()),
            None => gl.draw_arrays(mode, 0, primitives.num_elements),
        }
    }

    // Disable attribute arrays or otherwise someone later on might get crash thanks to invalid pointers.
    for &(location, _) in &locations {
        // SAFETY: a location this call enabled.
        unsafe { gl.disable_vertex_attrib_array(location) };
    }

    Ok(())
}

/// `glu::draw`
pub fn draw(context: &RenderContext, program: GLuint, vertex_arrays: &[VertexArrayBinding<'_>], primitives: &PrimitiveList<'_>) -> Result<(), TestError> {
    let ctx_type = context.context_type();

    if ctx_type.supports(3, 1) {
        Err(TestError::NotPorted("glu::drawFromVAOBuffers (the ES 3.1 / GL core path of glu::draw)".to_string()))
    } else {
        draw_from_user_pointers(context, program, vertex_arrays, primitives)
    }
}
