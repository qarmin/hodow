// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluDrawUtil.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, ported on demand. Only the 32-bit
// component types (`VTX_COMP_FLOAT`, `VTX_COMP_SIGNED_INT32`, `VTX_COMP_UNSIGNED_INT32`)
// and `INDEXTYPE_UINT16` indices are ported. There is no `VertexAttributeDescriptor`:
// every field it carries beyond the ones `VertexArrayPointer` already has is a constant
// here, and `VertexArrayPointer::convert` has only one value each component type accepts.

use std::ffi::CString;

use crate::glu::RenderContext;
use crate::glu::objects::{Buffer, VertexArray};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::TestError;

/// `getMinimumAlignment` - the todo upstream never resolved; a float is what it answers.
const MIN_ALIGNMENT: i32 = std::mem::size_of::<f32>() as i32;

/// `deAlign32`
fn deqp_align(value: i32, align: i32) -> i32 {
    (value + align - 1) / align * align
}

/// `glu::VertexComponentType`, restricted to the 32-bit variants ported.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VertexComponentType {
    Float,
    /// `VTX_COMP_SIGNED_INT32`
    SignedInt32,
    /// `VTX_COMP_UNSIGNED_INT32`
    UnsignedInt32,
}

impl VertexComponentType {
    /// `getVtxCompGLType`
    fn gl_type(self) -> GLenum {
        match self {
            Self::Float => glw::GL_FLOAT,
            Self::SignedInt32 => glw::GL_INT,
            Self::UnsignedInt32 => glw::GL_UNSIGNED_INT,
        }
    }

    /// `getVtxCompSize`
    fn size(self) -> i32 {
        match self {
            Self::Float | Self::SignedInt32 | Self::UnsignedInt32 => 4,
        }
    }

    /// `de::inRange(componentType, VTX_COMP_UNSIGNED_INT8, VTX_COMP_SIGNED_INT32)` - an
    /// integer attribute takes `glVertexAttribIPointer`, since the only `convert` mode
    /// upstream allows it is `VTX_COMP_CONVERT_NONE`.
    fn is_int(self) -> bool {
        match self {
            Self::SignedInt32 | Self::UnsignedInt32 => true,
            Self::Float => false,
        }
    }
}

/// `glu::PrimitiveType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveType {
    /// `PRIMITIVETYPE_PATCHES`
    Patches,
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
        PrimitiveType::Patches => glw::GL_PATCHES,
    }
}

/// `glu::VertexArrayPointer`
///
/// `data` is upstream's `const void*`: the component type says how to read it, so it is
/// held as raw bytes rather than as a slice of one scalar type.
pub struct VertexArrayPointer<'a> {
    pub component_type: VertexComponentType,
    pub num_components: i32,
    pub num_elements: i32,
    pub stride: i32,
    pub data: &'a [u8],
}

/// `glu::VertexArrayBinding::BindingPoint` - a binding is by name or by location.
///
/// The shader-library cases are what need the location form: a matrix attribute occupies
/// one location per column and there is no name for the individual columns. `Name`'s own
/// `i32` is upstream's `BindingPoint::location` field doubling as an offset added to the
/// name's resolved location (`namedBindingsToProgramLocations`'s own comment: "Add
/// binding.location as an offset to accommodate matrices") - a matrix vertex attribute
/// occupies one consecutive GL attribute location per column, so binding column `c` of an
/// attribute named once needs `getAttribLocation(name) + c`.
pub enum BindingPoint<'a> {
    Name(&'a str, i32),
    Location(GLuint),
}

/// `glu::VertexArrayBinding`
pub struct VertexArrayBinding<'a> {
    pub binding: BindingPoint<'a>,
    pub pointer: VertexArrayPointer<'a>,
}

/// `glu::va` - the shorthand constructors upstream's tests write at the call site.
pub mod va {
    use super::{BindingPoint, VertexArrayBinding, VertexArrayPointer, VertexComponentType};

    /// The scalar types a binding may be built from - a plain 4-byte POD each, which is
    /// what makes reinterpreting the caller's slice as upstream's `const void*` sound.
    trait VertexComponent: Copy {
        const TYPE: VertexComponentType;
    }

    impl VertexComponent for f32 {
        const TYPE: VertexComponentType = VertexComponentType::Float;
    }

    impl VertexComponent for i32 {
        const TYPE: VertexComponentType = VertexComponentType::SignedInt32;
    }

    impl VertexComponent for u32 {
        const TYPE: VertexComponentType = VertexComponentType::UnsignedInt32;
    }

    fn binding<'a, T: VertexComponent>(
        binding: BindingPoint<'a>,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [T],
    ) -> VertexArrayBinding<'a> {
        VertexArrayBinding {
            binding,
            pointer: VertexArrayPointer {
                component_type: T::TYPE,
                num_components,
                num_elements,
                stride,
                // SAFETY: `T` is a 4-byte scalar with no padding and no invalid bit
                // pattern, and `u8` has the weaker alignment.
                data: unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<u8>(), std::mem::size_of_val(data)) },
            },
        }
    }

    /// `glu::va::Float(name, numComponents, numElements, stride, data)`
    pub fn float<'a>(
        name: &'a str,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [f32],
    ) -> VertexArrayBinding<'a> {
        binding(BindingPoint::Name(name, 0), num_components, num_elements, stride, data)
    }

    /// `glu::va::Float(name, offset, numComponents, numElements, stride, data)` - the
    /// offset-taking overload, needed only for one column of a matrix vertex attribute
    /// (see `BindingPoint::Name`'s own doc comment).
    pub fn float_named_offset<'a>(
        name: &'a str,
        offset: i32,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [f32],
    ) -> VertexArrayBinding<'a> {
        binding(
            BindingPoint::Name(name, offset),
            num_components,
            num_elements,
            stride,
            data,
        )
    }

    /// `glu::va::Float(location, numComponents, numElements, stride, data)`
    pub fn float_at<'a>(
        location: u32,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [f32],
    ) -> VertexArrayBinding<'a> {
        binding(
            BindingPoint::Location(location),
            num_components,
            num_elements,
            stride,
            data,
        )
    }

    /// `glu::va::Int32(name, numComponents, numElements, stride, data)`
    pub fn int32<'a>(
        name: &'a str,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [i32],
    ) -> VertexArrayBinding<'a> {
        binding(BindingPoint::Name(name, 0), num_components, num_elements, stride, data)
    }

    /// `glu::va::Uint32(name, numComponents, numElements, stride, data)`
    pub fn uint32<'a>(
        name: &'a str,
        num_components: i32,
        num_elements: i32,
        stride: i32,
        data: &'a [u32],
    ) -> VertexArrayBinding<'a> {
        binding(BindingPoint::Name(name, 0), num_components, num_elements, stride, data)
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

    /// `glu::pr::TriangleStrip(numElements, indices)`
    pub fn triangle_strip(indices: &[u16]) -> PrimitiveList<'_> {
        PrimitiveList {
            type_: PrimitiveType::TriangleStrip,
            num_elements: indices.len() as i32,
            indices: Some(indices),
        }
    }

    /// `glu::PrimitiveList(type, numElements)` - the non-indexed form, which `pr` has no
    /// shorthand for because upstream's own call sites spell the constructor out.
    pub fn list(type_: PrimitiveType, num_elements: i32) -> PrimitiveList<'static> {
        PrimitiveList {
            type_,
            num_elements,
            indices: None,
        }
    }

    /// `glu::pr::Patches(numElements, indices)`
    pub fn patches(indices: &[u16]) -> PrimitiveList<'_> {
        PrimitiveList {
            type_: PrimitiveType::Patches,
            num_elements: indices.len() as i32,
            indices: Some(indices),
        }
    }
}

/// `glu::drawFromUserPointers`
pub fn draw_from_user_pointers(
    context: &RenderContext,
    program: GLuint,
    vertex_arrays: &[VertexArrayBinding<'_>],
    primitives: &PrimitiveList<'_>,
) -> Result<(), TestError> {
    let gl = context.functions();
    let locations = named_bindings_to_program_locations(gl, program, vertex_arrays)?;

    // Set VA state.
    for &(location, va) in &locations {
        // SAFETY: the client-side array outlives the draw below, and the attribute is
        // told exactly how many components and elements it holds.
        unsafe {
            gl.enable_vertex_attrib_array(location);
            if va.pointer.component_type.is_int() {
                gl.vertex_attrib_i_pointer(
                    location,
                    va.pointer.num_components,
                    va.pointer.component_type.gl_type(),
                    va.pointer.stride,
                    va.pointer.data.as_ptr().cast(),
                );
            } else {
                gl.vertex_attrib_pointer(
                    location,
                    va.pointer.num_components,
                    va.pointer.component_type.gl_type(),
                    glw::FALSE,
                    va.pointer.stride,
                    va.pointer.data.as_ptr().cast(),
                );
            }
        }
    }

    let mode = get_primitive_gl_type(primitives.type_);
    // SAFETY: as above; an index array, when there is one, outlives the call too.
    unsafe {
        match primitives.indices {
            Some(indices) => gl.draw_elements(
                mode,
                primitives.num_elements,
                glw::GL_UNSIGNED_SHORT,
                indices.as_ptr().cast(),
            ),
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

/// Lowers every binding to a location, dropping the named ones the program does not use.
///
/// `namedBindingsToProgramLocations` adds the binding's own location as an offset, which is
/// how a matrix attribute reaches the location of each of its columns from one name.
fn named_bindings_to_program_locations<'a>(
    gl: &glw::Functions,
    program: GLuint,
    vertex_arrays: &'a [VertexArrayBinding<'a>],
) -> Result<Vec<(GLuint, &'a VertexArrayBinding<'a>)>, TestError> {
    let mut locations = Vec::with_capacity(vertex_arrays.len());

    for va in vertex_arrays {
        match va.binding {
            BindingPoint::Location(location) => locations.push((location, va)),
            BindingPoint::Name(name, offset) => {
                let name = CString::new(name)
                    .map_err(|_| TestError::InternalError("attribute name with an interior NUL".to_string()))?;
                // SAFETY: a NUL-terminated name and a program name the caller owns.
                let location = unsafe { gl.get_attrib_location(program, name.as_ptr()) };
                if location >= 0 {
                    locations.push(((location + offset) as GLuint, va));
                }
            }
        }
    }

    Ok(locations)
}

/// `computeNonStridedBufferLayout` + `uploadBufferData` - one planar buffer holding every
/// attribute back to back, each starting at a float-aligned offset.
fn upload_vertex_buffer(
    gl: &glw::Functions,
    buffer: GLuint,
    arrays: &[(GLuint, &VertexArrayBinding<'_>)],
) -> Result<Vec<i32>, TestError> {
    let mut offsets = Vec::with_capacity(arrays.len());
    let mut data: Vec<u8> = Vec::new();

    for &(_, va) in arrays {
        let element_size = va.pointer.component_type.size() * va.pointer.num_components;
        let offset = deqp_align(data.len() as i32, MIN_ALIGNMENT);
        data.resize(offset as usize, 0);
        offsets.push(offset);

        // `copyToLayout`: the destination is always tightly packed, so a source stride that
        // is neither 0 nor the element size is the only case that copies element by element.
        let src_stride = if va.pointer.stride != 0 {
            va.pointer.stride
        } else {
            element_size
        };
        for ndx in 0..va.pointer.num_elements {
            let start = (ndx * src_stride) as usize;
            let end = start + element_size as usize;
            data.extend_from_slice(&va.pointer.data[start..end]);
        }
    }

    // SAFETY: the upload covers exactly the bytes `data` holds.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            data.len() as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }
    crate::glu::expect_no_error(gl, "Uploading buffer data failed")?;

    Ok(offsets)
}

/// `glu::drawFromBuffers`
fn draw_from_buffers(
    context: &RenderContext,
    program: GLuint,
    vertex_arrays: &[VertexArrayBinding<'_>],
    primitives: &PrimitiveList<'_>,
) -> Result<(), TestError> {
    let gl = context.functions();
    let locations = named_bindings_to_program_locations(gl, program, vertex_arrays)?;

    let vertex_buffer = Buffer::new(gl);
    let offsets = upload_vertex_buffer(gl, vertex_buffer.get(), &locations)?;

    // `setVertexBufferAttributes`
    // SAFETY: every offset points inside the buffer just uploaded, and the attribute is
    // told exactly how many components it holds.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
        for (&(location, va), &offset) in locations.iter().zip(&offsets) {
            let comp_type = va.pointer.component_type;
            gl.enable_vertex_attrib_array(location);
            if comp_type.is_int() {
                gl.vertex_attrib_i_pointer(
                    location,
                    va.pointer.num_components,
                    comp_type.gl_type(),
                    0,
                    offset as *const std::ffi::c_void,
                );
            } else {
                gl.vertex_attrib_pointer(
                    location,
                    va.pointer.num_components,
                    comp_type.gl_type(),
                    glw::FALSE,
                    0,
                    offset as *const std::ffi::c_void,
                );
            }
        }
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }

    let mode = get_primitive_gl_type(primitives.type_);
    match primitives.indices {
        Some(indices) => {
            let index_buffer = Buffer::new(gl);
            // SAFETY: the upload covers exactly the indices it points at, and the draw
            // reads them out of the bound element array buffer.
            unsafe {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get());
                gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    std::mem::size_of_val(indices) as isize,
                    indices.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }
            crate::glu::expect_no_error(gl, "Uploading index data failed")?;

            // SAFETY: the element array buffer holds `num_elements` indices.
            unsafe {
                gl.draw_elements(mode, primitives.num_elements, glw::GL_UNSIGNED_SHORT, std::ptr::null());
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
            }
        }
        // SAFETY: every enabled attribute holds at least `num_elements` elements.
        None => unsafe { gl.draw_arrays(mode, 0, primitives.num_elements) },
    }

    // Disable attribute arrays or otherwise someone later on might get crash thanks to invalid pointers.
    for &(location, _) in &locations {
        // SAFETY: a location this call enabled.
        unsafe { gl.disable_vertex_attrib_array(location) };
    }

    Ok(())
}

/// `glu::drawFromVAOBuffers`
pub fn draw_from_vao_buffers(
    context: &RenderContext,
    program: GLuint,
    vertex_arrays: &[VertexArrayBinding<'_>],
    primitives: &PrimitiveList<'_>,
) -> Result<(), TestError> {
    let gl = context.functions();
    let vao = VertexArray::new(gl);

    // SAFETY: a vertex array object this call owns.
    unsafe { gl.bind_vertex_array(vao.get()) };
    let result = draw_from_buffers(context, program, vertex_arrays, primitives);
    // SAFETY: unbinding is always valid.
    unsafe { gl.bind_vertex_array(0) };

    result
}

/// `glu::draw`
pub fn draw(
    context: &RenderContext,
    program: GLuint,
    vertex_arrays: &[VertexArrayBinding<'_>],
    primitives: &PrimitiveList<'_>,
) -> Result<(), TestError> {
    let ctx_type = context.context_type();

    // Upstream: `isContextTypeGLCore(ctxType) || contextSupports(ctxType, ApiType::es(3, 1))`. A core profile has no default vertex array, so client-side arrays cannot work there.
    if ctx_type.api.desktop || ctx_type.supports(3, 1) {
        draw_from_vao_buffers(context, program, vertex_arrays, primitives)
    } else {
        draw_from_user_pointers(context, program, vertex_arrays, primitives)
    }
}
