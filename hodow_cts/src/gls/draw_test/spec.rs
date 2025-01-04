// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.hpp / .cpp  (deqp::gls::DrawTestSpec, and the file's
//   own anonymous-namespace enum<->GLenum/string tables and `MethodInfo` helper)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See `super`'s own module doc comment
// for what this file covers and what is still deferred.
//
// **No `PROFILE_CORE` branch.** `glu::ApiType` in this port is narrowed to the ES
// profiles only (see `glu::render_context::ApiType`'s own doc comment) - there is no
// desktop-GL root in this port and none is planned (`CLAUDE.md`'s "ES only,
// deliberately"). Upstream's `AttributeSpec::valid`/`DrawTestSpec::valid` each have one
// branch gated on `ctxType.getProfile() == glu::PROFILE_CORE` ("no user pointers in GL
// core") - dropped here rather than translated, since that profile can never be
// selected through this port's `ApiType`.
//
// **No `_LAST` sentinel on `Target`/`CompatibilityTestType`.** Upstream's `_LAST` on
// every enum here exists mostly to size a `static const` lookup array
// (`de::getSizedArrayElement<ENUM_LAST>`); a Rust `match` needs no such bound, so it is
// dropped wherever nothing ever stores it as a real value. It survives (as `Last`) on
// the enums where upstream's own default constructors assign it to a struct field to
// mean "not set yet" - `InputType`/`OutputType`/`Usage`/`Storage`/`Primitive`/
// `IndexType`/`DrawMethod` - since those are genuine sentinel states this port's structs
// still need, matching `valid()`'s own `DE_ASSERT(... != ..._LAST)` guards (ported as
// `debug_assert_ne!`).

use crate::glw::{self, GLenum};

/// `DrawTestSpec::Target`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Target {
    ElementArray = 0,
    Array,
}

impl Target {
    /// `targetToGL`
    pub fn to_gl(self) -> GLenum {
        match self {
            Target::ElementArray => glw::GL_ELEMENT_ARRAY_BUFFER,
            Target::Array => glw::GL_ARRAY_BUFFER,
        }
    }

    /// `DrawTestSpec::targetToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Target::ElementArray => "element_array",
            Target::Array => "array",
        }
    }
}

/// `DrawTestSpec::InputType`
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

    /// Sentinel "not set yet" value - see this module's top doc comment. Also doubles
    /// as `GLValue`'s own "no value" tag (`GLValue::GLValue(void)`).
    Last,
}

impl InputType {
    /// `inputTypeToGL`. Panics on `Last` - a `GLenum` for "no type" does not exist,
    /// matching upstream's own out-of-bounds `getSizedArrayElement` assert.
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
            InputType::Last => unreachable!("InputType::Last has no GL encoding"),
        }
    }

    /// `DrawTestSpec::inputTypeToString`
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
            InputType::UnsignedInt2_10_10_10 => "unsigned_int2_10_10_10",
            InputType::Int2_10_10_10 => "int2_10_10_10",
            InputType::Last => unreachable!("InputType::Last has no name"),
        }
    }

    /// `DrawTestSpec::inputTypeSize`
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
            // `sizeof(uint32_t) / 4` in the original - the packed 2_10_10_10 formats are
            // a single 32-bit word; this "size" is read only as an alignment divisor
            // (`isBufferAligned`/`isBufferStrideAligned`), never to size a buffer.
            InputType::UnsignedInt2_10_10_10 => (size_of::<u32>() / 4) as i32,
            InputType::Int2_10_10_10 => (size_of::<u32>() / 4) as i32,
            InputType::Last => unreachable!("InputType::Last has no size"),
        }
    }

    /// `inputTypeIsFloatType`
    pub fn is_float_type(self) -> bool {
        matches!(
            self,
            InputType::Float | InputType::Fixed | InputType::Half | InputType::Double
        )
    }
}

/// `DrawTestSpec::OutputType`
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

    /// Sentinel "not set yet" value - see this module's top doc comment.
    Last,
}

impl OutputType {
    /// `outputTypeToGLType` - the GLSL type name, not a `GLenum` (there is no `GLenum`
    /// for a shader-side vector type).
    pub fn to_glsl_type_name(self) -> &'static str {
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
            OutputType::Last => unreachable!("OutputType::Last has no GLSL name"),
        }
    }

    /// `DrawTestSpec::outputTypeToString`
    pub fn to_str(self) -> &'static str {
        // Identical table to `to_glsl_type_name` upstream too - one `static const
        // char*[]` read by both `outputTypeToGLType` and `DrawTestSpec::outputTypeToString`.
        self.to_glsl_type_name()
    }

    /// `outputTypeIsFloatType`
    pub fn is_float_type(self) -> bool {
        matches!(
            self,
            OutputType::Float | OutputType::Vec2 | OutputType::Vec3 | OutputType::Vec4
        )
    }

    /// `outputTypeIsIntType`
    pub fn is_int_type(self) -> bool {
        matches!(
            self,
            OutputType::Int | OutputType::IVec2 | OutputType::IVec3 | OutputType::IVec4
        )
    }

    /// `outputTypeIsUintType`
    pub fn is_uint_type(self) -> bool {
        matches!(
            self,
            OutputType::Uint | OutputType::UVec2 | OutputType::UVec3 | OutputType::UVec4
        )
    }

    /// `DrawTestShaderProgram::getComponentCount`
    pub fn component_count(self) -> i32 {
        match self {
            OutputType::Float | OutputType::Int | OutputType::Uint => 1,
            OutputType::Vec2 | OutputType::IVec2 | OutputType::UVec2 => 2,
            OutputType::Vec3 | OutputType::IVec3 | OutputType::UVec3 => 3,
            OutputType::Vec4 | OutputType::IVec4 | OutputType::UVec4 => 4,
            OutputType::Last => unreachable!("OutputType::Last has no component count"),
        }
    }
}

/// `DrawTestSpec::Usage`
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

    /// Sentinel "not applicable" value - see this module's top doc comment
    /// (`AttributeSpec::createDefaultAttribute` sets this, since a default attribute has
    /// no backing buffer to apply a usage hint to).
    Last,
}

impl Usage {
    /// `usageToGL`. Panics on `Last`, matching upstream's out-of-bounds assert.
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
            Usage::Last => unreachable!("Usage::Last has no GL encoding"),
        }
    }

    /// `DrawTestSpec::usageTypeToString`
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
            Usage::Last => unreachable!("Usage::Last has no name"),
        }
    }
}

/// `DrawTestSpec::Storage`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Storage {
    User = 0,
    Buffer,

    /// Sentinel "not applicable" value - see this module's top doc comment.
    Last,
}

impl Storage {
    /// `DrawTestSpec::storageToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Storage::User => "user_ptr",
            Storage::Buffer => "buffer",
            Storage::Last => unreachable!("Storage::Last has no name"),
        }
    }
}

/// `DrawTestSpec::Primitive`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Primitive {
    Points = 0,
    Triangles,
    TriangleFan,
    TriangleStrip,
    Lines,
    LineStrip,
    LineLoop,

    LinesAdjacency,
    LineStripAdjacency,
    TrianglesAdjacency,
    TriangleStripAdjacency,

    /// Sentinel "not set yet" value - see this module's top doc comment.
    Last,
}

impl Primitive {
    /// `primitiveToGL`. Panics on `Last`, matching upstream's out-of-bounds assert.
    pub fn to_gl(self) -> GLenum {
        match self {
            Primitive::Points => glw::GL_POINTS,
            Primitive::Triangles => glw::GL_TRIANGLES,
            Primitive::TriangleFan => glw::GL_TRIANGLE_FAN,
            Primitive::TriangleStrip => glw::GL_TRIANGLE_STRIP,
            Primitive::Lines => glw::GL_LINES,
            Primitive::LineStrip => glw::GL_LINE_STRIP,
            Primitive::LineLoop => glw::GL_LINE_LOOP,
            Primitive::LinesAdjacency => glw::GL_LINES_ADJACENCY,
            Primitive::LineStripAdjacency => glw::GL_LINE_STRIP_ADJACENCY,
            Primitive::TrianglesAdjacency => glw::GL_TRIANGLES_ADJACENCY,
            Primitive::TriangleStripAdjacency => glw::GL_TRIANGLE_STRIP_ADJACENCY,
            Primitive::Last => unreachable!("Primitive::Last has no GL encoding"),
        }
    }

    /// `DrawTestSpec::primitiveToString`
    pub fn to_str(self) -> &'static str {
        match self {
            Primitive::Points => "points",
            Primitive::Triangles => "triangles",
            Primitive::TriangleFan => "triangle_fan",
            Primitive::TriangleStrip => "triangle_strip",
            Primitive::Lines => "lines",
            Primitive::LineStrip => "line_strip",
            Primitive::LineLoop => "line_loop",
            Primitive::LinesAdjacency => "lines_adjacency",
            Primitive::LineStripAdjacency => "line_strip_adjacency",
            Primitive::TrianglesAdjacency => "triangles_adjacency",
            Primitive::TriangleStripAdjacency => "triangle_strip_adjacency",
            Primitive::Last => unreachable!("Primitive::Last has no name"),
        }
    }

    /// `getElementCount` - the number of vertices `primitiveCount` primitives of this
    /// type consume (per instance).
    pub fn element_count(self, primitive_count: usize) -> usize {
        match self {
            Primitive::Points => primitive_count,
            Primitive::Triangles => primitive_count * 3,
            Primitive::TriangleFan => primitive_count + 2,
            Primitive::TriangleStrip => primitive_count + 2,
            Primitive::Lines => primitive_count * 2,
            Primitive::LineStrip => primitive_count + 1,
            // "If primitiveCount == 1, a line loop still needs two distinct vertices" -
            // upstream's own special case, ported verbatim.
            Primitive::LineLoop => {
                if primitive_count == 1 {
                    2
                } else {
                    primitive_count
                }
            }
            Primitive::LinesAdjacency => primitive_count * 4,
            Primitive::LineStripAdjacency => primitive_count + 3,
            Primitive::TrianglesAdjacency => primitive_count * 6,
            Primitive::TriangleStripAdjacency => primitive_count * 2 + 4,
            Primitive::Last => unreachable!("Primitive::Last has no element count"),
        }
    }
}

/// `DrawTestSpec::IndexType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum IndexType {
    Byte = 0,
    Short,
    Int,

    /// Sentinel "not set yet" value - see this module's top doc comment.
    Last,
}

impl IndexType {
    /// `indexTypeToGL`. Panics on `Last`, matching upstream's out-of-bounds assert.
    pub fn to_gl(self) -> GLenum {
        match self {
            IndexType::Byte => glw::GL_UNSIGNED_BYTE,
            IndexType::Short => glw::GL_UNSIGNED_SHORT,
            IndexType::Int => glw::GL_UNSIGNED_INT,
            IndexType::Last => unreachable!("IndexType::Last has no GL encoding"),
        }
    }

    /// `DrawTestSpec::indexTypeToString`
    pub fn to_str(self) -> &'static str {
        match self {
            IndexType::Byte => "byte",
            IndexType::Short => "short",
            IndexType::Int => "int",
            IndexType::Last => unreachable!("IndexType::Last has no name"),
        }
    }

    /// `DrawTestSpec::indexTypeSize`
    pub fn size(self) -> i32 {
        match self {
            IndexType::Byte => size_of::<u8>() as i32,
            IndexType::Short => size_of::<u16>() as i32,
            IndexType::Int => size_of::<u32>() as i32,
            IndexType::Last => unreachable!("IndexType::Last has no size"),
        }
    }
}

/// `DrawTestSpec::DrawMethod`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DrawMethod {
    DrawArrays = 0,
    DrawArraysInstanced,
    DrawArraysIndirect,
    DrawElements,
    DrawElementsRanged,
    DrawElementsInstanced,
    DrawElementsIndirect,
    DrawElementsBaseVertex,
    DrawElementsInstancedBaseVertex,
    DrawElementsRangedBaseVertex,

    /// Sentinel "not set yet" value - see this module's top doc comment.
    Last,
}

impl DrawMethod {
    /// `DrawTestSpec::drawMethodToString`
    pub fn to_str(self) -> &'static str {
        match self {
            DrawMethod::DrawArrays => "draw_arrays",
            DrawMethod::DrawArraysInstanced => "draw_arrays_instanced",
            DrawMethod::DrawArraysIndirect => "draw_arrays_indirect",
            DrawMethod::DrawElements => "draw_elements",
            DrawMethod::DrawElementsRanged => "draw_range_elements",
            DrawMethod::DrawElementsInstanced => "draw_elements_instanced",
            DrawMethod::DrawElementsIndirect => "draw_elements_indirect",
            DrawMethod::DrawElementsBaseVertex => "draw_elements_base_vertex",
            DrawMethod::DrawElementsInstancedBaseVertex => "draw_elements_instanced_base_vertex",
            DrawMethod::DrawElementsRangedBaseVertex => "draw_range_elements_base_vertex",
            DrawMethod::Last => unreachable!("DrawMethod::Last has no name"),
        }
    }

    /// `getMethodInfo`
    pub fn info(self) -> MethodInfo {
        // indexed, instanced, ranged, first, base_vertex, indirect - same column order
        // as upstream's own `static const MethodInfo infos[]` table.
        const fn mi(
            indexed: bool,
            instanced: bool,
            ranged: bool,
            first: bool,
            base_vertex: bool,
            indirect: bool,
        ) -> MethodInfo {
            MethodInfo {
                indexed,
                instanced,
                ranged,
                first,
                base_vertex,
                indirect,
            }
        }
        match self {
            DrawMethod::DrawArrays => mi(false, false, false, true, false, false),
            DrawMethod::DrawArraysInstanced => mi(false, true, false, true, false, false),
            DrawMethod::DrawArraysIndirect => mi(false, true, false, true, false, true),
            DrawMethod::DrawElements => mi(true, false, false, false, false, false),
            DrawMethod::DrawElementsRanged => mi(true, false, true, false, false, false),
            DrawMethod::DrawElementsInstanced => mi(true, true, false, false, false, false),
            DrawMethod::DrawElementsIndirect => mi(true, true, false, false, true, true),
            DrawMethod::DrawElementsBaseVertex => mi(true, false, false, false, true, false),
            DrawMethod::DrawElementsInstancedBaseVertex => mi(true, true, false, false, true, false),
            DrawMethod::DrawElementsRangedBaseVertex => mi(true, false, true, false, true, false),
            DrawMethod::Last => unreachable!("DrawMethod::Last has no method info"),
        }
    }
}

/// `DrawTestSpec::CompatibilityTestType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CompatibilityTestType {
    None = 0,
    UnalignedOffset,
    UnalignedStride,
}

/// `MethodInfo` (anonymous-namespace struct, `getMethodInfo`'s return shape)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct MethodInfo {
    pub indexed: bool,
    pub instanced: bool,
    pub ranged: bool,
    pub first: bool,
    pub base_vertex: bool,
    pub indirect: bool,
}

/// `DrawTestSpec::AttributeSpec`
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct AttributeSpec {
    pub input_type: InputType,
    pub output_type: OutputType,
    pub storage: Storage,
    pub usage: Usage,
    pub component_count: i32,
    pub offset: i32,
    pub stride: i32,
    pub normalize: bool,
    /// Used only if `drawMethod` is `Draw*Instanced`.
    pub instance_divisor: i32,
    pub use_default_attribute: bool,
    /// Treat this attribute as a position attribute. Attribute at index 0 is always
    /// treated as such. `false` by default.
    pub additional_position_attribute: bool,
    /// Component order of this attribute is BGRA, valid only for 4-component targets.
    /// `false` by default.
    pub bgra_component_order: bool,
}

impl Default for AttributeSpec {
    /// `DrawTestSpec::AttributeSpec::AttributeSpec(void)`
    fn default() -> Self {
        Self {
            input_type: InputType::Last,
            output_type: OutputType::Last,
            storage: Storage::Last,
            usage: Usage::Last,
            component_count: 0,
            offset: 0,
            stride: 0,
            normalize: false,
            instance_divisor: 0,
            use_default_attribute: false,
            additional_position_attribute: false,
            bgra_component_order: false,
        }
    }
}

impl AttributeSpec {
    /// `DrawTestSpec::AttributeSpec::createAttributeArray`
    #[allow(clippy::too_many_arguments)]
    pub fn create_attribute_array(
        input_type: InputType,
        output_type: OutputType,
        storage: Storage,
        usage: Usage,
        component_count: i32,
        offset: i32,
        stride: i32,
        normalize: bool,
        instance_divisor: i32,
    ) -> Self {
        Self {
            input_type,
            output_type,
            storage,
            usage,
            component_count,
            offset,
            stride,
            normalize,
            instance_divisor,
            use_default_attribute: false,
            ..Default::default()
        }
    }

    /// `DrawTestSpec::AttributeSpec::createDefaultAttribute` - `inputType` must be
    /// `Int`, `UnsignedInt` or `Float`.
    pub fn create_default_attribute(input_type: InputType, output_type: OutputType, component_count: i32) -> Self {
        debug_assert!(matches!(
            input_type,
            InputType::Int | InputType::UnsignedInt | InputType::Float
        ));
        debug_assert!(input_type == InputType::Float || component_count == 4);

        Self {
            input_type,
            output_type,
            storage: Storage::Last,
            usage: Usage::Last,
            component_count,
            offset: 0,
            stride: 0,
            normalize: false,
            instance_divisor: 0,
            use_default_attribute: true,
            ..Default::default()
        }
    }

    /// `DrawTestSpec::AttributeSpec::hash`
    pub fn hash(&self) -> i32 {
        if self.use_default_attribute {
            self.input_type as i32 + 7 * self.output_type as i32 + 13 * self.component_count
        } else {
            self.input_type as i32
                + 2 * self.output_type as i32
                + 3 * self.storage as i32
                + 5 * self.usage as i32
                + 7 * self.component_count
                + 11 * self.offset
                + 13 * self.stride
                + 17 * i32::from(!self.normalize)
                + 19 * self.instance_divisor
        }
    }

    /// `DrawTestSpec::AttributeSpec::valid` - see this module's top doc comment for the
    /// dropped `PROFILE_CORE` branch.
    #[allow(clippy::needless_bool)]
    pub fn valid(&self, api_type: crate::glu::ApiType) -> bool {
        let input_type_float = matches!(self.input_type, InputType::Float | InputType::Fixed | InputType::Half);
        let input_type_unsigned_integer = matches!(
            self.input_type,
            InputType::UnsignedByte
                | InputType::UnsignedShort
                | InputType::UnsignedInt
                | InputType::UnsignedInt2_10_10_10
        );
        let input_type_signed_integer = matches!(
            self.input_type,
            InputType::Byte | InputType::Short | InputType::Int | InputType::Int2_10_10_10
        );
        let input_type_packed = matches!(
            self.input_type,
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10
        );

        let output_type_float = self.output_type.is_float_type();
        let output_type_signed_integer = self.output_type.is_int_type();
        let output_type_unsigned_integer = self.output_type.is_uint_type();

        if self.use_default_attribute {
            if !matches!(
                self.input_type,
                InputType::Int | InputType::UnsignedInt | InputType::Float
            ) {
                return false;
            }
            if self.input_type != InputType::Float && self.component_count != 4 {
                return false;
            }
            // No casting allowed (undefined results).
            if self.input_type == InputType::Int && !output_type_signed_integer {
                return false;
            }
            if self.input_type == InputType::UnsignedInt && !output_type_unsigned_integer {
                return false;
            }
        }

        if input_type_packed && self.component_count != 4 {
            return false;
        }

        // Invalid conversions:

        // float -> [u]int
        if input_type_float && !output_type_float {
            return false;
        }
        // uint -> int (undefined results)
        if input_type_unsigned_integer && output_type_signed_integer {
            return false;
        }
        // int -> uint (undefined results)
        if input_type_signed_integer && output_type_unsigned_integer {
            return false;
        }
        // packed -> non-float (packed formats are converted to floats)
        if input_type_packed && !output_type_float {
            return false;
        }
        // Invalid normalize. Normalize is only valid if output type is float.
        if self.normalize && !output_type_float {
            return false;
        }

        // Allow reverse order (GL_BGRA) only for packed and 4-component ubyte.
        if self.bgra_component_order && self.component_count != 4 {
            return false;
        }
        if self.bgra_component_order
            && !matches!(
                self.input_type,
                InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 | InputType::UnsignedByte
            )
        {
            return false;
        }
        if self.bgra_component_order && !self.normalize {
            return false;
        }

        // GLES2 limits.
        if api_type == crate::glu::ApiType::es(2, 0) {
            if !matches!(
                self.input_type,
                InputType::Float
                    | InputType::Fixed
                    | InputType::Byte
                    | InputType::UnsignedByte
                    | InputType::Short
                    | InputType::UnsignedShort
            ) {
                return false;
            }
            if !output_type_float {
                return false;
            }
            if self.bgra_component_order {
                return false;
            }
        }

        // GLES3 limits.
        if api_type.major == 3 && self.bgra_component_order {
            return false;
        }

        true
    }

    /// `DrawTestSpec::AttributeSpec::isBufferAligned`
    pub fn is_buffer_aligned(&self) -> bool {
        let input_type_packed = matches!(
            self.input_type,
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10
        );

        if self.storage == Storage::Buffer {
            let data_type_size = if input_type_packed { 4 } else { self.input_type.size() };
            if self.offset % data_type_size != 0 {
                return false;
            }
        }
        true
    }

    /// `DrawTestSpec::AttributeSpec::isBufferStrideAligned`
    pub fn is_buffer_stride_aligned(&self) -> bool {
        let input_type_packed = matches!(
            self.input_type,
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10
        );

        if self.storage == Storage::Buffer {
            let data_type_size = if input_type_packed { 4 } else { self.input_type.size() };
            if self.stride % data_type_size != 0 {
                return false;
            }
        }
        true
    }
}

/// `DrawTestSpec`
#[derive(Debug, Clone, PartialEq)]
pub struct DrawTestSpec {
    /// Needed in spec validation.
    pub api_type: crate::glu::ApiType,
    pub primitive: Primitive,
    /// Number of primitives to draw (per instance).
    pub primitive_count: i32,

    pub draw_method: DrawMethod,
    /// Used only if `drawMethod` is `DrawElements*`.
    pub index_type: IndexType,
    /// Used only if `drawMethod` is `DrawElements*`.
    pub index_pointer_offset: i32,
    /// Used only if `drawMethod` is `DrawElements*`.
    pub index_storage: Storage,
    /// Used only if `drawMethod` is `DrawArrays*`.
    pub first: i32,
    /// Used only if `drawMethod` is `Draw*Ranged`.
    pub index_min: i32,
    /// Used only if `drawMethod` is `Draw*Ranged`.
    pub index_max: i32,
    /// Used only if `drawMethod` is `Draw*Instanced` or `Draw*Indirect`.
    pub instance_count: i32,
    /// Used only if `drawMethod` is `Draw*Indirect`.
    pub indirect_offset: i32,
    /// Used only if `drawMethod` is `DrawElementsIndirect` or `*BaseVertex`.
    pub base_vertex: i32,

    pub attribs: Vec<AttributeSpec>,
}

impl DrawTestSpec {
    /// `DrawTestSpec::DrawTestSpec(void)` - upstream's default constructor never sets
    /// `apiType`, relying on every real caller to assign it immediately after
    /// constructing (`valid()` then `DE_ASSERT`s it is not `PROFILE_LAST`). This port's
    /// `ApiType` has no such "unset" representation (see its own doc comment), so the
    /// caller supplies it up front instead - the same requirement, made unconditional
    /// rather than merely asserted.
    pub fn new(api_type: crate::glu::ApiType) -> Self {
        Self {
            api_type,
            primitive: Primitive::Last,
            primitive_count: 0,
            draw_method: DrawMethod::Last,
            index_type: IndexType::Last,
            index_pointer_offset: 0,
            index_storage: Storage::Last,
            first: 0,
            index_min: 0,
            index_max: 0,
            instance_count: 0,
            indirect_offset: 0,
            base_vertex: 0,
            attribs: Vec::new(),
        }
    }

    /// `DrawTestSpec::hash`
    pub fn hash(&self) -> i32 {
        // Use only drawmode-relevant values in "hashing", as the irrelevant ones might
        // not be set (causing non-deterministic behaviour).
        let info = self.draw_method.info();

        let index_hash = if info.indexed {
            self.index_type as i32 + 10 * self.index_pointer_offset + 100 * self.index_storage as i32
        } else {
            0
        };
        let array_hash = if info.first { self.first } else { 0 };
        let index_range_hash = if info.ranged {
            self.index_min + 10 * self.index_max
        } else {
            0
        };
        let instance_hash = if info.instanced { self.instance_count } else { 0 };
        let indirect_hash = if info.indirect { self.indirect_offset } else { 0 };
        let base_vtx_hash = if info.base_vertex { self.base_vertex } else { 0 };
        let basic_hash = self.primitive as i32 + 10 * self.primitive_count + 100 * self.draw_method as i32;

        index_hash
            + 3 * array_hash
            + 5 * index_range_hash
            + 7 * instance_hash
            + 13 * basic_hash
            + 17 * self.attribs.len() as i32
            + 19 * self.primitive_count
            + 23 * indirect_hash
            + 27 * base_vtx_hash
    }

    /// `DrawTestSpec::valid` - see this module's top doc comment for the dropped
    /// `PROFILE_CORE` branch.
    pub fn valid(&self) -> bool {
        debug_assert_ne!(self.primitive, Primitive::Last);
        debug_assert_ne!(self.draw_method, DrawMethod::Last);

        let info = self.draw_method.info();

        for attrib in &self.attribs {
            if !attrib.valid(self.api_type) {
                return false;
            }
        }

        if info.ranged {
            // These three mirror `GLValue::getMaxValue` for the matching `InputType`
            // exactly (including the short case genuinely being `65530`, not
            // `u16::MAX` - `gl_value.rs`'s own table, not a typo here).
            let max_index_value: u32 = match self.index_type {
                IndexType::Byte => u8::MAX as u32,
                IndexType::Short => 65530,
                IndexType::Int => u32::MAX,
                IndexType::Last => unreachable!("index_type must be set when ranged"),
            };

            if self.index_min > self.index_max {
                return false;
            }
            if self.index_min < 0 || self.index_max < 0 {
                return false;
            }
            if self.index_min as u32 > max_index_value || self.index_max as u32 > max_index_value {
                return false;
            }
        }

        if info.first && self.first < 0 {
            return false;
        }

        // GLES2 limits.
        if self.api_type == crate::glu::ApiType::es(2, 0) {
            if self.draw_method != DrawMethod::DrawArrays && self.draw_method != DrawMethod::DrawElements {
                return false;
            }
            if self.draw_method == DrawMethod::DrawElements
                && self.index_type != IndexType::Byte
                && self.index_type != IndexType::Short
            {
                return false;
            }
        }

        // Indirect limitations.
        if info.indirect {
            // Indirect offset alignment.
            if self.indirect_offset % 4 != 0 {
                return false;
            }
            // All attribute arrays must be stored in a buffer.
            for attrib in &self.attribs {
                if !attrib.use_default_attribute && attrib.storage == Storage::User {
                    return false;
                }
            }
        }
        if self.draw_method == DrawMethod::DrawElementsIndirect {
            // Index offset must be convertible to `firstIndex`.
            if self.index_pointer_offset % self.index_type.size() != 0 {
                return false;
            }
            // Indices must be in a buffer.
            if self.index_storage != Storage::Buffer {
                return false;
            }
        }

        true
    }

    /// `DrawTestSpec::isCompatibilityTest`
    pub fn is_compatibility_test(&self) -> CompatibilityTestType {
        let info = self.draw_method.info();

        let mut buffer_alignment_bad = false;
        let mut stride_alignment_bad = false;

        for attrib in &self.attribs {
            if !attrib.is_buffer_aligned() {
                buffer_alignment_bad = true;
            }
        }
        for attrib in &self.attribs {
            if !attrib.is_buffer_stride_aligned() {
                stride_alignment_bad = true;
            }
        }

        if info.indexed && self.index_storage == Storage::Buffer {
            let index_size = self.index_type.size();
            if self.index_pointer_offset % index_size != 0 {
                buffer_alignment_bad = true;
            }
        }

        // Combination of bad alignment and bad stride is treated as bad offset.
        if buffer_alignment_bad {
            CompatibilityTestType::UnalignedOffset
        } else if stride_alignment_bad {
            CompatibilityTestType::UnalignedStride
        } else {
            CompatibilityTestType::None
        }
    }

    /// `DrawTestSpec::getName`
    pub fn get_name(&self) -> String {
        use std::fmt::Write as _;

        let info = self.draw_method.info();
        let mut name = String::new();

        for (ndx, attrib) in self.attribs.iter().enumerate() {
            if self.attribs.len() > 1 {
                let _ = write!(name, "attrib{ndx}_");
            }

            if ndx == 0 || attrib.additional_position_attribute {
                name.push_str("pos_");
            } else {
                name.push_str("col_");
            }

            if attrib.use_default_attribute {
                let _ = write!(
                    name,
                    "non_array_{}_{}_{}_",
                    attrib.input_type.to_str(),
                    attrib.component_count,
                    attrib.output_type.to_str()
                );
            } else {
                let _ = write!(
                    name,
                    "{}_{}_{}_{}",
                    attrib.storage.to_str(),
                    attrib.offset,
                    attrib.stride,
                    attrib.input_type.to_str()
                );
                if attrib.input_type != InputType::UnsignedInt2_10_10_10
                    && attrib.input_type != InputType::Int2_10_10_10
                {
                    let _ = write!(name, "{}", attrib.component_count);
                }
                let _ = write!(
                    name,
                    "_{}{}_{}_{}_",
                    if attrib.normalize { "normalized_" } else { "" },
                    attrib.output_type.to_str(),
                    attrib.usage.to_str(),
                    attrib.instance_divisor
                );
            }
        }

        if info.indexed {
            let _ = write!(
                name,
                "index_{}_{}_offset{}_",
                self.index_type.to_str(),
                self.index_storage.to_str(),
                self.index_pointer_offset
            );
        }
        if info.first {
            let _ = write!(name, "first{}_", self.first);
        }
        if info.ranged {
            let _ = write!(name, "ranged_{}_{}_", self.index_min, self.index_max);
        }
        if info.instanced {
            let _ = write!(name, "instances{}_", self.instance_count);
        }

        name.push_str(match self.primitive {
            Primitive::Points => "points_",
            Primitive::Triangles => "triangles_",
            Primitive::TriangleFan => "triangle_fan_",
            Primitive::TriangleStrip => "triangle_strip_",
            Primitive::Lines => "lines_",
            Primitive::LineStrip => "line_strip_",
            Primitive::LineLoop => "line_loop_",
            Primitive::LinesAdjacency => "line_adjancency",
            Primitive::LineStripAdjacency => "line_strip_adjancency",
            Primitive::TrianglesAdjacency => "triangles_adjancency",
            Primitive::TriangleStripAdjacency => "triangle_strip_adjancency",
            Primitive::Last => unreachable!("primitive must be set"),
        });

        let _ = write!(name, "{}", self.primitive_count);

        name
    }
}

/// `checkSpecsShaderCompatible` - only the attributes matter: whether two specs can
/// reuse the same `DrawTestShaderProgram` (not yet ported - see `super`'s module doc
/// comment).
pub fn specs_shader_compatible(a: &DrawTestSpec, b: &DrawTestSpec) -> bool {
    if a.attribs.len() != b.attribs.len() {
        return false;
    }

    for (attrib_a, attrib_b) in a.attribs.iter().zip(b.attribs.iter()) {
        // Only the output type (== shader input type) matters, and the usage in the shader.
        if attrib_a.additional_position_attribute != attrib_b.additional_position_attribute {
            return false;
        }

        // Component counts need not match.
        if attrib_a.output_type.is_float_type() && attrib_b.output_type.is_float_type() {
            continue;
        }
        if attrib_a.output_type.is_int_type() && attrib_b.output_type.is_int_type() {
            continue;
        }
        if attrib_a.output_type.is_uint_type() && attrib_b.output_type.is_uint_type() {
            continue;
        }

        return false;
    }

    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::glu::ApiType;

    #[test]
    fn input_type_to_gl_matches_upstream_table() {
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
    fn primitive_element_count_matches_upstream() {
        assert_eq!(Primitive::Points.element_count(5), 5);
        assert_eq!(Primitive::Triangles.element_count(3), 9);
        assert_eq!(Primitive::TriangleFan.element_count(4), 6);
        assert_eq!(Primitive::TriangleStrip.element_count(4), 6);
        assert_eq!(Primitive::Lines.element_count(3), 6);
        assert_eq!(Primitive::LineStrip.element_count(4), 5);
        // The primitiveCount == 1 special case for line loops.
        assert_eq!(Primitive::LineLoop.element_count(1), 2);
        assert_eq!(Primitive::LineLoop.element_count(3), 3);
        assert_eq!(Primitive::LinesAdjacency.element_count(2), 8);
        assert_eq!(Primitive::LineStripAdjacency.element_count(4), 7);
        assert_eq!(Primitive::TrianglesAdjacency.element_count(2), 12);
        assert_eq!(Primitive::TriangleStripAdjacency.element_count(3), 10);
    }

    #[test]
    fn draw_method_info_matches_upstream_table() {
        // DRAWMETHOD_DRAWELEMENTS_INDIRECT: {true, true, false, false, true, true}
        let info = DrawMethod::DrawElementsIndirect.info();
        assert!(info.indexed);
        assert!(info.instanced);
        assert!(!info.ranged);
        assert!(!info.first);
        assert!(info.base_vertex);
        assert!(info.indirect);

        // DRAWMETHOD_DRAWARRAYS: {false, false, false, true, false, false}
        let info = DrawMethod::DrawArrays.info();
        assert!(!info.indexed && !info.instanced && !info.ranged && info.first && !info.base_vertex && !info.indirect);
    }

    #[test]
    fn attribute_spec_hash_default_attribute_branch() {
        let spec = AttributeSpec::create_default_attribute(InputType::Float, OutputType::Vec4, 4);
        // 1*FLOAT(0) + 7*VEC4(3) + 13*4 = 0 + 21 + 52 = 73
        assert_eq!(spec.hash(), 73);
    }

    #[test]
    fn attribute_spec_hash_array_branch() {
        let spec = AttributeSpec::create_attribute_array(
            InputType::Int,    // = 7
            OutputType::Int,   // = 4
            Storage::Buffer,   // = 1
            Usage::StaticDraw, // = 1
            2,
            4,
            16,
            false,
            0,
        );
        // 1*7 + 2*4 + 3*1 + 5*1 + 7*2 + 11*4 + 13*16 + 17*1 + 19*0
        // = 7 + 8 + 3 + 5 + 14 + 44 + 208 + 17 + 0 = 306
        assert_eq!(spec.hash(), 306);
    }

    #[test]
    fn attribute_spec_valid_rejects_float_to_int_cast() {
        let spec = AttributeSpec::create_attribute_array(
            InputType::Float,
            OutputType::Int,
            Storage::Buffer,
            Usage::StaticDraw,
            1,
            0,
            0,
            false,
            0,
        );
        assert!(!spec.valid(ApiType::es(3, 0)));
    }

    #[test]
    fn attribute_spec_valid_rejects_gles2_unsupported_input_type() {
        // INPUTTYPE_INT is not in GLES2's accepted-input-type list (only
        // float/fixed/byte/ubyte/short/ushort are), but is otherwise a perfectly valid
        // int -> int attribute on ES3+.
        let spec = AttributeSpec::create_attribute_array(
            InputType::Int,
            OutputType::Int,
            Storage::Buffer,
            Usage::StaticDraw,
            1,
            0,
            0,
            false,
            0,
        );
        assert!(!spec.valid(ApiType::es(2, 0)));
        assert!(spec.valid(ApiType::es(3, 0)));
    }

    #[test]
    fn attribute_spec_valid_accepts_plain_float_array() {
        let spec = AttributeSpec::create_attribute_array(
            InputType::Float,
            OutputType::Vec4,
            Storage::Buffer,
            Usage::StaticDraw,
            4,
            0,
            16,
            false,
            0,
        );
        assert!(spec.valid(ApiType::es(2, 0)));
        assert!(spec.valid(ApiType::es(3, 0)));
    }

    #[test]
    fn attribute_spec_buffer_alignment() {
        let mut spec = AttributeSpec::create_attribute_array(
            InputType::Short, // size 2
            OutputType::Vec2,
            Storage::Buffer,
            Usage::StaticDraw,
            2,
            3, // not a multiple of 2
            4,
            false,
            0,
        );
        assert!(!spec.is_buffer_aligned());
        spec.offset = 4;
        assert!(spec.is_buffer_aligned());

        spec.stride = 3;
        assert!(!spec.is_buffer_stride_aligned());
        spec.stride = 6;
        assert!(spec.is_buffer_stride_aligned());
    }

    #[test]
    fn draw_test_spec_valid_gles2_rejects_instanced() {
        let mut spec = DrawTestSpec::new(ApiType::es(2, 0));
        spec.primitive = Primitive::Triangles;
        spec.primitive_count = 1;
        spec.draw_method = DrawMethod::DrawArraysInstanced;
        spec.first = 0;
        spec.instance_count = 1;
        assert!(!spec.valid());
    }

    #[test]
    fn draw_test_spec_valid_plain_draw_arrays() {
        let mut spec = DrawTestSpec::new(ApiType::es(3, 0));
        spec.primitive = Primitive::Triangles;
        spec.primitive_count = 1;
        spec.draw_method = DrawMethod::DrawArrays;
        spec.first = 0;
        assert!(spec.valid());
    }

    #[test]
    fn draw_test_spec_hash_only_uses_relevant_fields() {
        let mut a = DrawTestSpec::new(ApiType::es(3, 0));
        a.primitive = Primitive::Triangles;
        a.primitive_count = 2;
        a.draw_method = DrawMethod::DrawArrays;
        a.first = 5;
        // Fields irrelevant to DRAWARRAYS (indexed/ranged/instanced/indirect/base vertex)
        // must not perturb the hash.
        let mut b = a.clone();
        b.index_min = 999;
        b.index_max = 999;
        b.instance_count = 999;
        b.indirect_offset = 999;
        b.base_vertex = 999;
        assert_eq!(a.hash(), b.hash());

        // But `first`, which *is* relevant to DRAWARRAYS, must perturb it.
        let mut c = a.clone();
        c.first = 6;
        assert_ne!(a.hash(), c.hash());
    }

    #[test]
    fn is_compatibility_test_detects_unaligned_offset() {
        let mut spec = DrawTestSpec::new(ApiType::es(3, 0));
        spec.draw_method = DrawMethod::DrawArrays;
        spec.attribs.push(AttributeSpec::create_attribute_array(
            InputType::Short,
            OutputType::Vec2,
            Storage::Buffer,
            Usage::StaticDraw,
            2,
            1, // unaligned for a 2-byte type
            4,
            false,
            0,
        ));
        assert_eq!(spec.is_compatibility_test(), CompatibilityTestType::UnalignedOffset);
    }

    #[test]
    fn is_compatibility_test_none_for_user_storage() {
        // STORAGE_USER is never buffer-(mis)aligned - isBufferAligned only checks
        // STORAGE_BUFFER.
        let mut spec = DrawTestSpec::new(ApiType::es(3, 0));
        spec.draw_method = DrawMethod::DrawArrays;
        spec.attribs.push(AttributeSpec::create_attribute_array(
            InputType::Short,
            OutputType::Vec2,
            Storage::User,
            Usage::StaticDraw,
            2,
            1,
            3,
            false,
            0,
        ));
        assert_eq!(spec.is_compatibility_test(), CompatibilityTestType::None);
    }

    #[test]
    fn specs_shader_compatible_ignores_component_count() {
        let mut a = DrawTestSpec::new(ApiType::es(3, 0));
        a.attribs.push(AttributeSpec::create_attribute_array(
            InputType::Float,
            OutputType::Vec2,
            Storage::Buffer,
            Usage::StaticDraw,
            2,
            0,
            0,
            false,
            0,
        ));
        let mut b = a.clone();
        b.attribs[0].output_type = OutputType::Vec4;
        assert!(specs_shader_compatible(&a, &b));

        b.attribs[0].output_type = OutputType::IVec4;
        assert!(!specs_shader_compatible(&a, &b));
    }

    #[test]
    fn get_name_matches_a_hand_traced_case() {
        let mut spec = DrawTestSpec::new(ApiType::es(3, 0));
        spec.primitive = Primitive::Triangles;
        spec.primitive_count = 1;
        spec.draw_method = DrawMethod::DrawArrays;
        spec.first = 0;
        spec.attribs.push(AttributeSpec::create_default_attribute(
            InputType::Float,
            OutputType::Vec4,
            4,
        ));

        // attribs.size() == 1, so no "attrib0_" prefix; ndx == 0 -> "pos_"; default
        // attribute branch: "non_array_float_4_vec4_"; no index (not indexed); first ->
        // "first0_"; primitive -> "triangles_"; then primitiveCount.
        assert_eq!(spec.get_name(), "pos_non_array_float_4_vec4_first0_triangles_1");
    }
}
