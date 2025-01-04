// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.hpp / .cpp  (deqp::gls::Array - the enums and
//   the file's own anonymous-namespace enum<->GLenum/string tables and predicates)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See `super`'s own module doc comment
// for what this file covers and what is still deferred.
//
// **No `_LAST` sentinel kept on any enum here.** Unlike `draw_test::spec`, nothing in
// this port's `Array`-related code yet needs a "not set yet" state for one of these
// enums (upstream's own default constructors for the one struct that will need this,
// `MultiVertexArrayTest::Spec::ArraySpec`, are not reached until that piece is ported -
// re-add a `Last` variant there if it turns out to be a genuine sentinel, not a
// leftover `de::getSizedArrayElement` array-sizing artifact, the same distinction
// `draw_test::spec`'s own top doc comment draws).

use crate::glw::{self, GLenum};

/// `Array::Target`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Target {
    ElementArray = 0,
    Array,
}

impl Target {
    /// `ContextArray::targetToGL`
    pub fn to_gl(self) -> GLenum {
        match self {
            Target::ElementArray => glw::GL_ELEMENT_ARRAY_BUFFER,
            Target::Array => glw::GL_ARRAY_BUFFER,
        }
    }

    /// `Array::targetToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Target::ElementArray => "element_array",
            Target::Array => "array",
        }
    }
}

/// `Array::InputType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum InputType {
    Float = 0,
    Fixed,
    Double,

    Byte,
    Short,

    UnsignedByte,
    UnsignedShort,

    Int,
    UnsignedInt,
    Half,
    UnsignedInt2_10_10_10,
    Int2_10_10_10,
}

impl InputType {
    /// `ContextArray::inputTypeToGL`
    pub fn to_gl(self) -> GLenum {
        match self {
            InputType::Float => glw::GL_FLOAT,
            InputType::Fixed => glw::GL_FIXED,
            InputType::Double => glw::GL_DOUBLE,
            InputType::Byte => glw::GL_BYTE,
            InputType::Short => glw::GL_SHORT,
            InputType::UnsignedByte => glw::GL_UNSIGNED_BYTE,
            InputType::UnsignedShort => glw::GL_UNSIGNED_SHORT,
            InputType::Int => glw::GL_INT,
            InputType::UnsignedInt => glw::GL_UNSIGNED_INT,
            InputType::Half => glw::GL_HALF_FLOAT,
            InputType::UnsignedInt2_10_10_10 => glw::GL_UNSIGNED_INT_2_10_10_10_REV,
            InputType::Int2_10_10_10 => glw::GL_INT_2_10_10_10_REV,
        }
    }

    /// `Array::inputTypeToString`
    pub fn to_str(self) -> &'static str {
        match self {
            InputType::Float => "float",
            InputType::Fixed => "fixed",
            InputType::Double => "double",
            InputType::Byte => "byte",
            InputType::Short => "short",
            InputType::UnsignedByte => "unsigned_byte",
            InputType::UnsignedShort => "unsigned_short",
            InputType::Int => "int",
            InputType::UnsignedInt => "unsigned_int",
            InputType::Half => "half",
            InputType::UnsignedInt2_10_10_10 => "usigned_int2_10_10_10",
            InputType::Int2_10_10_10 => "int2_10_10_10",
        }
    }

    /// `Array::inputTypeSize`
    pub fn size(self) -> i32 {
        match self {
            InputType::Float => size_of::<f32>() as i32,
            InputType::Fixed => size_of::<i32>() as i32,
            InputType::Double => size_of::<f64>() as i32,
            InputType::Byte => size_of::<i8>() as i32,
            InputType::Short => size_of::<i16>() as i32,
            InputType::UnsignedByte => size_of::<u8>() as i32,
            InputType::UnsignedShort => size_of::<u16>() as i32,
            InputType::Int => size_of::<i32>() as i32,
            InputType::UnsignedInt => size_of::<u32>() as i32,
            InputType::Half => size_of::<u16>() as i32,
            // `(int)sizeof(uint32_t) / 4` in the original, for both packed formats -
            // the packed 2_10_10_10 formats are a single 32-bit word; upstream's own
            // comment nowhere explains why this divides by 4 rather than stating `1`
            // directly, but the literal value is what this ports.
            InputType::UnsignedInt2_10_10_10 => (size_of::<u32>() / 4) as i32,
            InputType::Int2_10_10_10 => (size_of::<u32>() / 4) as i32,
        }
    }

    /// `inputTypeIsFloatType` (free function in the anonymous namespace upstream)
    pub fn is_float_type(self) -> bool {
        matches!(
            self,
            InputType::Float | InputType::Fixed | InputType::Double | InputType::Half
        )
    }
}

/// `Array::OutputType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum OutputType {
    Float = 0,
    Vec2,
    Vec3,
    Vec4,

    Int,
    Uint,

    IVec2,
    IVec3,
    IVec4,

    UVec2,
    UVec3,
    UVec4,
}

impl OutputType {
    /// `Array::outputTypeToString` / `ContextArray::outputTypeToGLType` - one shared
    /// table upstream too (`ContextArray::outputTypeToGLType` is `Array::outputTypeToString`
    /// verbatim, re-declared on the other class for call-site convenience).
    pub fn to_str(self) -> &'static str {
        match self {
            OutputType::Float => "float",
            OutputType::Vec2 => "vec2",
            OutputType::Vec3 => "vec3",
            OutputType::Vec4 => "vec4",
            OutputType::Int => "int",
            OutputType::Uint => "uint",
            OutputType::IVec2 => "ivec2",
            OutputType::IVec3 => "ivec3",
            OutputType::IVec4 => "ivec4",
            OutputType::UVec2 => "uvec2",
            OutputType::UVec3 => "uvec3",
            OutputType::UVec4 => "uvec4",
        }
    }

    /// `outputTypeIsFloatType` (free function in the anonymous namespace upstream)
    pub fn is_float_type(self) -> bool {
        matches!(
            self,
            OutputType::Float | OutputType::Vec2 | OutputType::Vec3 | OutputType::Vec4
        )
    }

    /// `ContextShaderProgram::getComponentCount`. Note `ContextShaderProgram::mapOutputType`
    /// (`OutputType` -> `rr::GenericVecType`) is not ported yet, unlike this method -
    /// its only caller is `ContextShaderProgram` itself (not yet ported, see `super`'s
    /// module doc comment), and that is also the piece that would need `rr` wired in
    /// here, the same way `draw_test::spec::OutputType` has no equivalent method at all
    /// (its own caller, `shader_program.rs`, matches on the enum directly instead).
    pub fn component_count(self) -> i32 {
        match self {
            OutputType::Float | OutputType::Int | OutputType::Uint => 1,
            OutputType::Vec2 | OutputType::IVec2 | OutputType::UVec2 => 2,
            OutputType::Vec3 | OutputType::IVec3 | OutputType::UVec3 => 3,
            OutputType::Vec4 | OutputType::IVec4 | OutputType::UVec4 => 4,
        }
    }
}

/// `Array::Usage`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Usage {
    DynamicDraw = 0,
    StaticDraw,
    StreamDraw,

    StreamRead,
    StreamCopy,

    StaticRead,
    StaticCopy,

    DynamicRead,
    DynamicCopy,
}

impl Usage {
    /// `ContextArray::usageToGL`
    pub fn to_gl(self) -> GLenum {
        match self {
            Usage::DynamicDraw => glw::GL_DYNAMIC_DRAW,
            Usage::StaticDraw => glw::GL_STATIC_DRAW,
            Usage::StreamDraw => glw::GL_STREAM_DRAW,
            Usage::StreamRead => glw::GL_STREAM_READ,
            Usage::StreamCopy => glw::GL_STREAM_COPY,
            Usage::StaticRead => glw::GL_STATIC_READ,
            Usage::StaticCopy => glw::GL_STATIC_COPY,
            Usage::DynamicRead => glw::GL_DYNAMIC_READ,
            Usage::DynamicCopy => glw::GL_DYNAMIC_COPY,
        }
    }

    /// `Array::usageTypeToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Usage::DynamicDraw => "dynamic_draw",
            Usage::StaticDraw => "static_draw",
            Usage::StreamDraw => "stream_draw",
            Usage::StreamRead => "stream_read",
            Usage::StreamCopy => "stream_copy",
            Usage::StaticRead => "static_read",
            Usage::StaticCopy => "static_copy",
            Usage::DynamicRead => "dynamic_read",
            Usage::DynamicCopy => "dynamic_copy",
        }
    }
}

/// `Array::Storage`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Storage {
    User = 0,
    Buffer,
}

impl Storage {
    /// `Array::storageToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Storage::User => "user_ptr",
            Storage::Buffer => "buffer",
        }
    }
}

/// `Array::Primitive`. Note this enum has only four variants here - no lines or
/// adjacency primitives, unlike `draw_test::spec::Primitive`'s eleven. This older
/// framework's draws are always `GL_TRIANGLES`/`GL_TRIANGLE_FAN`/`GL_TRIANGLE_STRIP`/
/// `GL_POINTS`, confirmed by this being the complete enum upstream declares.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Primitive {
    Points = 0,
    Triangles,
    TriangleFan,
    TriangleStrip,
}

impl Primitive {
    /// `ContextArray::primitiveToGL`
    pub fn to_gl(self) -> GLenum {
        match self {
            Primitive::Points => glw::GL_POINTS,
            Primitive::Triangles => glw::GL_TRIANGLES,
            Primitive::TriangleFan => glw::GL_TRIANGLE_FAN,
            Primitive::TriangleStrip => glw::GL_TRIANGLE_STRIP,
        }
    }

    /// `Array::primitiveToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Primitive::Points => "points",
            Primitive::Triangles => "triangles",
            Primitive::TriangleFan => "triangle_fan",
            Primitive::TriangleStrip => "triangle_strip",
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn target_to_gl() {
        assert_eq!(Target::ElementArray.to_gl(), glw::GL_ELEMENT_ARRAY_BUFFER);
        assert_eq!(Target::Array.to_gl(), glw::GL_ARRAY_BUFFER);
    }

    #[test]
    fn target_to_str() {
        assert_eq!(Target::ElementArray.to_str(), "element_array");
        assert_eq!(Target::Array.to_str(), "array");
    }

    #[test]
    fn input_type_to_gl_covers_every_variant() {
        assert_eq!(InputType::Float.to_gl(), glw::GL_FLOAT);
        assert_eq!(InputType::Fixed.to_gl(), glw::GL_FIXED);
        assert_eq!(InputType::Double.to_gl(), glw::GL_DOUBLE);
        assert_eq!(InputType::Byte.to_gl(), glw::GL_BYTE);
        assert_eq!(InputType::Short.to_gl(), glw::GL_SHORT);
        assert_eq!(InputType::UnsignedByte.to_gl(), glw::GL_UNSIGNED_BYTE);
        assert_eq!(InputType::UnsignedShort.to_gl(), glw::GL_UNSIGNED_SHORT);
        assert_eq!(InputType::Int.to_gl(), glw::GL_INT);
        assert_eq!(InputType::UnsignedInt.to_gl(), glw::GL_UNSIGNED_INT);
        assert_eq!(InputType::Half.to_gl(), glw::GL_HALF_FLOAT);
        assert_eq!(
            InputType::UnsignedInt2_10_10_10.to_gl(),
            glw::GL_UNSIGNED_INT_2_10_10_10_REV
        );
        assert_eq!(InputType::Int2_10_10_10.to_gl(), glw::GL_INT_2_10_10_10_REV);
    }

    #[test]
    fn input_type_to_str_matches_upstream_table() {
        // Note the upstream typo "usigned_int2_10_10_10" (missing the 'n') - ported
        // verbatim, matching `draw_test::spec::InputType`'s own note on the same string
        // table not existing (this file's variant of it has the typo; `draw_test`'s
        // sibling table spells it correctly - the two tables genuinely differ, which is
        // itself evidence the two `GLValue`/`InputType` pairs are independent copies,
        // not a shared source re-declared twice).
        assert_eq!(InputType::UnsignedInt2_10_10_10.to_str(), "usigned_int2_10_10_10");
        assert_eq!(InputType::Int2_10_10_10.to_str(), "int2_10_10_10");
        assert_eq!(InputType::Float.to_str(), "float");
        assert_eq!(InputType::Half.to_str(), "half");
    }

    #[test]
    fn input_type_size() {
        assert_eq!(InputType::Float.size(), 4);
        assert_eq!(InputType::Double.size(), 8);
        assert_eq!(InputType::Byte.size(), 1);
        assert_eq!(InputType::UnsignedByte.size(), 1);
        assert_eq!(InputType::Short.size(), 2);
        assert_eq!(InputType::UnsignedShort.size(), 2);
        assert_eq!(InputType::Int.size(), 4);
        assert_eq!(InputType::UnsignedInt.size(), 4);
        assert_eq!(InputType::Half.size(), 2);
        assert_eq!(InputType::Fixed.size(), 4);
        // sizeof(uint32_t) / 4 == 1, integer division, for both packed formats.
        assert_eq!(InputType::UnsignedInt2_10_10_10.size(), 1);
        assert_eq!(InputType::Int2_10_10_10.size(), 1);
    }

    #[test]
    fn input_type_is_float_type() {
        assert!(InputType::Float.is_float_type());
        assert!(InputType::Fixed.is_float_type());
        assert!(InputType::Double.is_float_type());
        assert!(InputType::Half.is_float_type());
        assert!(!InputType::Byte.is_float_type());
        assert!(!InputType::UnsignedByte.is_float_type());
        assert!(!InputType::Short.is_float_type());
        assert!(!InputType::UnsignedShort.is_float_type());
        assert!(!InputType::Int.is_float_type());
        assert!(!InputType::UnsignedInt.is_float_type());
        assert!(!InputType::UnsignedInt2_10_10_10.is_float_type());
        assert!(!InputType::Int2_10_10_10.is_float_type());
    }

    #[test]
    fn output_type_is_float_type() {
        assert!(OutputType::Float.is_float_type());
        assert!(OutputType::Vec2.is_float_type());
        assert!(OutputType::Vec3.is_float_type());
        assert!(OutputType::Vec4.is_float_type());
        assert!(!OutputType::Int.is_float_type());
        assert!(!OutputType::Uint.is_float_type());
        assert!(!OutputType::IVec2.is_float_type());
        assert!(!OutputType::UVec4.is_float_type());
    }

    #[test]
    fn output_type_component_count() {
        assert_eq!(OutputType::Float.component_count(), 1);
        assert_eq!(OutputType::Int.component_count(), 1);
        assert_eq!(OutputType::Uint.component_count(), 1);
        assert_eq!(OutputType::Vec2.component_count(), 2);
        assert_eq!(OutputType::IVec2.component_count(), 2);
        assert_eq!(OutputType::UVec2.component_count(), 2);
        assert_eq!(OutputType::Vec3.component_count(), 3);
        assert_eq!(OutputType::IVec3.component_count(), 3);
        assert_eq!(OutputType::UVec3.component_count(), 3);
        assert_eq!(OutputType::Vec4.component_count(), 4);
        assert_eq!(OutputType::IVec4.component_count(), 4);
        assert_eq!(OutputType::UVec4.component_count(), 4);
    }

    #[test]
    fn output_type_to_str() {
        assert_eq!(OutputType::Float.to_str(), "float");
        assert_eq!(OutputType::IVec3.to_str(), "ivec3");
        assert_eq!(OutputType::UVec4.to_str(), "uvec4");
    }

    #[test]
    fn usage_to_gl_and_str() {
        assert_eq!(Usage::DynamicDraw.to_gl(), glw::GL_DYNAMIC_DRAW);
        assert_eq!(Usage::StaticDraw.to_gl(), glw::GL_STATIC_DRAW);
        assert_eq!(Usage::StreamDraw.to_gl(), glw::GL_STREAM_DRAW);
        assert_eq!(Usage::StreamRead.to_gl(), glw::GL_STREAM_READ);
        assert_eq!(Usage::StreamCopy.to_gl(), glw::GL_STREAM_COPY);
        assert_eq!(Usage::StaticRead.to_gl(), glw::GL_STATIC_READ);
        assert_eq!(Usage::StaticCopy.to_gl(), glw::GL_STATIC_COPY);
        assert_eq!(Usage::DynamicRead.to_gl(), glw::GL_DYNAMIC_READ);
        assert_eq!(Usage::DynamicCopy.to_gl(), glw::GL_DYNAMIC_COPY);
        assert_eq!(Usage::DynamicDraw.to_str(), "dynamic_draw");
        assert_eq!(Usage::DynamicCopy.to_str(), "dynamic_copy");
    }

    #[test]
    fn storage_to_str() {
        assert_eq!(Storage::User.to_str(), "user_ptr");
        assert_eq!(Storage::Buffer.to_str(), "buffer");
    }

    #[test]
    fn primitive_to_gl_and_str_has_only_four_variants() {
        assert_eq!(Primitive::Points.to_gl(), glw::GL_POINTS);
        assert_eq!(Primitive::Triangles.to_gl(), glw::GL_TRIANGLES);
        assert_eq!(Primitive::TriangleFan.to_gl(), glw::GL_TRIANGLE_FAN);
        assert_eq!(Primitive::TriangleStrip.to_gl(), glw::GL_TRIANGLE_STRIP);
        assert_eq!(Primitive::Points.to_str(), "points");
        assert_eq!(Primitive::TriangleStrip.to_str(), "triangle_strip");
    }
}
