// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluShaderUtil.hpp / .cpp  (glu::DataType, glu::Precision)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `DataType` is narrowed to the types
// an OpenGL ES 3.1 shader can declare, the same narrowing `glu::ApiType` already gets
// here - upstream's enum additionally carries desktop GL's doubles, 1D/buffer/cube-array
// samplers and the Vulkan-only 8/16/64-bit and f16 scalars, none of which any ES case
// can name. The `>= TYPE_X && <= TYPE_Y` range predicates become `matches!` arms, so
// dropping those entries cannot silently widen one.

use crate::glw::{self, GLenum};

/// `glu::Precision`
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub enum Precision {
    LowP,
    MediumP,
    HighP,
}

impl Precision {
    /// `glu::getPrecisionName`
    pub fn name(self) -> &'static str {
        match self {
            Self::LowP => "lowp",
            Self::MediumP => "mediump",
            Self::HighP => "highp",
        }
    }
}

/// `glu::DataType`, in upstream's declaration order with the non-ES entries removed.
///
/// Upstream's `PRECISION_LAST` doubles as "this type takes no precision qualifier"
/// (a `bool`, a struct); here that is `Option<Precision>` at the one place it is used,
/// `VarType::Basic`.
#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
pub enum DataType {
    Invalid,

    Float,
    FloatVec2,
    FloatVec3,
    FloatVec4,
    FloatMat2,
    FloatMat2x3,
    FloatMat2x4,
    FloatMat3x2,
    FloatMat3,
    FloatMat3x4,
    FloatMat4x2,
    FloatMat4x3,
    FloatMat4,

    Int,
    IntVec2,
    IntVec3,
    IntVec4,

    Uint,
    UintVec2,
    UintVec3,
    UintVec4,

    Bool,
    BoolVec2,
    BoolVec3,
    BoolVec4,

    Sampler2D,
    SamplerCube,
    Sampler2DArray,
    Sampler3D,

    Sampler2DShadow,
    SamplerCubeShadow,
    Sampler2DArrayShadow,

    IntSampler2D,
    IntSamplerCube,
    IntSampler2DArray,
    IntSampler3D,

    UintSampler2D,
    UintSamplerCube,
    UintSampler2DArray,
    UintSampler3D,

    Sampler2DMultisample,
    IntSampler2DMultisample,
    UintSampler2DMultisample,

    Image2D,
    ImageCube,
    Image2DArray,
    Image3D,

    IntImage2D,
    IntImageCube,
    IntImage2DArray,
    IntImage3D,

    UintImage2D,
    UintImageCube,
    UintImage2DArray,
    UintImage3D,

    UintAtomicCounter,

    SamplerCubeArray,
    SamplerCubeArrayShadow,
    IntSamplerCubeArray,
    UintSamplerCubeArray,

    SamplerBuffer,
    IntSamplerBuffer,
    UintSamplerBuffer,

    Sampler2DMultisampleArray,
    IntSampler2DMultisampleArray,
    UintSampler2DMultisampleArray,
}

use DataType::*;

/// The types `s_testDataTypes`-style tables iterate over, in declaration order.
pub const ALL_DATA_TYPES: [DataType; 55] = [
    Float,
    FloatVec2,
    FloatVec3,
    FloatVec4,
    FloatMat2,
    FloatMat2x3,
    FloatMat2x4,
    FloatMat3x2,
    FloatMat3,
    FloatMat3x4,
    FloatMat4x2,
    FloatMat4x3,
    FloatMat4,
    Int,
    IntVec2,
    IntVec3,
    IntVec4,
    Uint,
    UintVec2,
    UintVec3,
    UintVec4,
    Bool,
    BoolVec2,
    BoolVec3,
    BoolVec4,
    Sampler2D,
    SamplerCube,
    Sampler2DArray,
    Sampler3D,
    Sampler2DShadow,
    SamplerCubeShadow,
    Sampler2DArrayShadow,
    IntSampler2D,
    IntSamplerCube,
    IntSampler2DArray,
    IntSampler3D,
    UintSampler2D,
    UintSamplerCube,
    UintSampler2DArray,
    UintSampler3D,
    Sampler2DMultisample,
    IntSampler2DMultisample,
    UintSampler2DMultisample,
    Image2D,
    ImageCube,
    Image2DArray,
    Image3D,
    IntImage2D,
    IntImageCube,
    IntImage2DArray,
    IntImage3D,
    UintImage2D,
    UintImageCube,
    UintImage2DArray,
    UintImage3D,
];

impl DataType {
    /// `glu::getDataTypeName`
    pub fn name(self) -> &'static str {
        match self {
            Invalid => "invalid",
            Float => "float",
            FloatVec2 => "vec2",
            FloatVec3 => "vec3",
            FloatVec4 => "vec4",
            FloatMat2 => "mat2",
            FloatMat2x3 => "mat2x3",
            FloatMat2x4 => "mat2x4",
            FloatMat3x2 => "mat3x2",
            FloatMat3 => "mat3",
            FloatMat3x4 => "mat3x4",
            FloatMat4x2 => "mat4x2",
            FloatMat4x3 => "mat4x3",
            FloatMat4 => "mat4",
            Int => "int",
            IntVec2 => "ivec2",
            IntVec3 => "ivec3",
            IntVec4 => "ivec4",
            Uint => "uint",
            UintVec2 => "uvec2",
            UintVec3 => "uvec3",
            UintVec4 => "uvec4",
            Bool => "bool",
            BoolVec2 => "bvec2",
            BoolVec3 => "bvec3",
            BoolVec4 => "bvec4",
            Sampler2D => "sampler2D",
            SamplerCube => "samplerCube",
            Sampler2DArray => "sampler2DArray",
            Sampler3D => "sampler3D",
            Sampler2DShadow => "sampler2DShadow",
            SamplerCubeShadow => "samplerCubeShadow",
            Sampler2DArrayShadow => "sampler2DArrayShadow",
            IntSampler2D => "isampler2D",
            IntSamplerCube => "isamplerCube",
            IntSampler2DArray => "isampler2DArray",
            IntSampler3D => "isampler3D",
            UintSampler2D => "usampler2D",
            UintSamplerCube => "usamplerCube",
            UintSampler2DArray => "usampler2DArray",
            UintSampler3D => "usampler3D",
            Sampler2DMultisample => "sampler2DMS",
            IntSampler2DMultisample => "isampler2DMS",
            UintSampler2DMultisample => "usampler2DMS",
            Image2D => "image2D",
            ImageCube => "imageCube",
            Image2DArray => "image2DArray",
            Image3D => "image3D",
            IntImage2D => "iimage2D",
            IntImageCube => "iimageCube",
            IntImage2DArray => "iimage2DArray",
            IntImage3D => "iimage3D",
            UintImage2D => "uimage2D",
            UintImageCube => "uimageCube",
            UintImage2DArray => "uimage2DArray",
            UintImage3D => "uimage3D",
            UintAtomicCounter => "atomic_uint",
            SamplerCubeArray => "samplerCubeArray",
            SamplerCubeArrayShadow => "samplerCubeArrayShadow",
            IntSamplerCubeArray => "isamplerCubeArray",
            UintSamplerCubeArray => "usamplerCubeArray",
            SamplerBuffer => "samplerBuffer",
            IntSamplerBuffer => "isamplerBuffer",
            UintSamplerBuffer => "usamplerBuffer",
            Sampler2DMultisampleArray => "sampler2DMSArray",
            IntSampler2DMultisampleArray => "isampler2DMSArray",
            UintSampler2DMultisampleArray => "usampler2DMSArray",
        }
    }

    /// `glu::getDataTypeScalarSize`
    pub fn scalar_size(self) -> i32 {
        match self {
            Float | Int | Uint | Bool => 1,
            FloatVec2 | IntVec2 | UintVec2 | BoolVec2 => 2,
            FloatVec3 | IntVec3 | UintVec3 | BoolVec3 => 3,
            FloatVec4 | IntVec4 | UintVec4 | BoolVec4 => 4,
            FloatMat2 => 4,
            FloatMat2x3 | FloatMat3x2 => 6,
            FloatMat2x4 | FloatMat4x2 => 8,
            FloatMat3 => 9,
            FloatMat3x4 | FloatMat4x3 => 12,
            FloatMat4 => 16,
            Invalid => 0,
            // Every sampler, image and the atomic counter is one opaque handle.
            _ => 1,
        }
    }

    /// `glu::getDataTypeScalarType`
    pub fn scalar_type(self) -> DataType {
        match self {
            Float | FloatVec2 | FloatVec3 | FloatVec4 => Float,
            FloatMat2 | FloatMat2x3 | FloatMat2x4 | FloatMat3x2 | FloatMat3 | FloatMat3x4 | FloatMat4x2
            | FloatMat4x3 | FloatMat4 => Float,
            Int | IntVec2 | IntVec3 | IntVec4 => Int,
            Uint | UintVec2 | UintVec3 | UintVec4 => Uint,
            Bool | BoolVec2 | BoolVec3 | BoolVec4 => Bool,
            other => other,
        }
    }

    /// `glu::isDataTypeFloatOrVec`
    pub fn is_float_or_vec(self) -> bool {
        matches!(self, Float | FloatVec2 | FloatVec3 | FloatVec4)
    }

    /// `glu::isDataTypeMatrix`
    pub fn is_matrix(self) -> bool {
        matches!(
            self,
            FloatMat2
                | FloatMat2x3
                | FloatMat2x4
                | FloatMat3x2
                | FloatMat3
                | FloatMat3x4
                | FloatMat4x2
                | FloatMat4x3
                | FloatMat4
        )
    }

    /// `glu::isDataTypeIntOrIVec`
    pub fn is_int_or_ivec(self) -> bool {
        matches!(self, Int | IntVec2 | IntVec3 | IntVec4)
    }

    /// `glu::isDataTypeUintOrUVec`
    pub fn is_uint_or_uvec(self) -> bool {
        matches!(self, Uint | UintVec2 | UintVec3 | UintVec4)
    }

    /// `glu::isDataTypeBoolOrBVec`
    pub fn is_bool_or_bvec(self) -> bool {
        matches!(self, Bool | BoolVec2 | BoolVec3 | BoolVec4)
    }

    /// `glu::isDataTypeScalar`
    pub fn is_scalar(self) -> bool {
        matches!(self, Float | Int | Uint | Bool)
    }

    /// `glu::isDataTypeVector`
    pub fn is_vector(self) -> bool {
        matches!(
            self,
            FloatVec2
                | FloatVec3
                | FloatVec4
                | IntVec2
                | IntVec3
                | IntVec4
                | UintVec2
                | UintVec3
                | UintVec4
                | BoolVec2
                | BoolVec3
                | BoolVec4
        )
    }

    /// `glu::isDataTypeScalarOrVector`
    pub fn is_scalar_or_vector(self) -> bool {
        self.is_scalar() || self.is_vector()
    }

    /// `glu::isDataTypeSampler`
    pub fn is_sampler(self) -> bool {
        matches!(
            self,
            Sampler2D
                | SamplerCube
                | Sampler2DArray
                | Sampler3D
                | Sampler2DShadow
                | SamplerCubeShadow
                | Sampler2DArrayShadow
                | IntSampler2D
                | IntSamplerCube
                | IntSampler2DArray
                | IntSampler3D
                | UintSampler2D
                | UintSamplerCube
                | UintSampler2DArray
                | UintSampler3D
                | Sampler2DMultisample
                | IntSampler2DMultisample
                | UintSampler2DMultisample
                | SamplerCubeArray
                | SamplerCubeArrayShadow
                | IntSamplerCubeArray
                | UintSamplerCubeArray
                | SamplerBuffer
                | IntSamplerBuffer
                | UintSamplerBuffer
                | Sampler2DMultisampleArray
                | IntSampler2DMultisampleArray
                | UintSampler2DMultisampleArray
        )
    }

    /// `glu::isDataTypeImage`
    pub fn is_image(self) -> bool {
        matches!(
            self,
            Image2D
                | ImageCube
                | Image2DArray
                | Image3D
                | IntImage2D
                | IntImageCube
                | IntImage2DArray
                | IntImage3D
                | UintImage2D
                | UintImageCube
                | UintImage2DArray
                | UintImage3D
        )
    }

    /// `glu::isDataTypeAtomicCounter`
    pub fn is_atomic_counter(self) -> bool {
        self == UintAtomicCounter
    }

    /// `glu::isDataTypeSamplerMultisample`
    pub fn is_sampler_multisample(self) -> bool {
        matches!(
            self,
            Sampler2DMultisample | IntSampler2DMultisample | UintSampler2DMultisample
        )
    }

    /// `glu::getDataTypeMatrixNumRows`
    pub fn matrix_num_rows(self) -> i32 {
        match self {
            FloatMat2 | FloatMat3x2 | FloatMat4x2 => 2,
            FloatMat2x3 | FloatMat3 | FloatMat4x3 => 3,
            FloatMat2x4 | FloatMat3x4 | FloatMat4 => 4,
            _ => panic!("{} is not a matrix", self.name()),
        }
    }

    /// `glu::getDataTypeMatrixNumColumns`
    pub fn matrix_num_columns(self) -> i32 {
        match self {
            FloatMat2 | FloatMat2x3 | FloatMat2x4 => 2,
            FloatMat3x2 | FloatMat3 | FloatMat3x4 => 3,
            FloatMat4x2 | FloatMat4x3 | FloatMat4 => 4,
            _ => panic!("{} is not a matrix", self.name()),
        }
    }

    /// `glu::getDataTypeNumLocations`
    pub fn num_locations(self) -> i32 {
        if self.is_scalar_or_vector() {
            1
        } else if self.is_matrix() {
            self.matrix_num_columns()
        } else {
            panic!("{} occupies no locations", self.name())
        }
    }

    /// `glu::getDataTypeNumComponents`
    pub fn num_components(self) -> i32 {
        if self.is_scalar_or_vector() {
            self.scalar_size()
        } else if self.is_matrix() {
            self.matrix_num_rows()
        } else {
            panic!("{} has no components", self.name())
        }
    }
}

/// `glu::getDataTypeFloatVec`
pub fn get_data_type_float_vec(vec_size: i32) -> DataType {
    get_data_type_vector(Float, vec_size)
}

/// `glu::getDataTypeIntVec`
pub fn get_data_type_int_vec(vec_size: i32) -> DataType {
    get_data_type_vector(Int, vec_size)
}

/// `glu::getDataTypeUintVec`
pub fn get_data_type_uint_vec(vec_size: i32) -> DataType {
    get_data_type_vector(Uint, vec_size)
}

/// `glu::getDataTypeBoolVec`
pub fn get_data_type_bool_vec(vec_size: i32) -> DataType {
    get_data_type_vector(Bool, vec_size)
}

/// `glu::getDataTypeVector`
pub fn get_data_type_vector(scalar_type: DataType, size: i32) -> DataType {
    assert!((1..=4).contains(&size), "vector size {size} out of range");
    let base = match scalar_type {
        Float => Float,
        Int => Int,
        Uint => Uint,
        Bool => Bool,
        other => panic!("{} is not a scalar type", other.name()),
    };
    match (base, size) {
        (Float, 1) => Float,
        (Float, 2) => FloatVec2,
        (Float, 3) => FloatVec3,
        (Float, 4) => FloatVec4,
        (Int, 1) => Int,
        (Int, 2) => IntVec2,
        (Int, 3) => IntVec3,
        (Int, 4) => IntVec4,
        (Uint, 1) => Uint,
        (Uint, 2) => UintVec2,
        (Uint, 3) => UintVec3,
        (Uint, 4) => UintVec4,
        (Bool, 1) => Bool,
        (Bool, 2) => BoolVec2,
        (Bool, 3) => BoolVec3,
        (_, _) => BoolVec4,
    }
}

/// `glu::getDataTypeMatrix`
pub fn get_data_type_matrix(num_cols: i32, num_rows: i32) -> DataType {
    match (num_cols, num_rows) {
        (2, 2) => FloatMat2,
        (2, 3) => FloatMat2x3,
        (2, 4) => FloatMat2x4,
        (3, 2) => FloatMat3x2,
        (3, 3) => FloatMat3,
        (3, 4) => FloatMat3x4,
        (4, 2) => FloatMat4x2,
        (4, 3) => FloatMat4x3,
        (4, 4) => FloatMat4,
        _ => panic!("no {num_cols}x{num_rows} matrix type"),
    }
}

/// `glu::getDataTypeFromGLType` - the inverse of what `glGetActiveUniform` reports.
///
/// A type this ES-narrowed enum has no entry for answers `Invalid`, exactly as
/// upstream's `TYPE_LAST` does for a `GLenum` it does not recognise.
pub fn get_data_type_from_gl_type(gl_type: GLenum) -> DataType {
    match gl_type {
        glw::GL_FLOAT => Float,
        glw::GL_FLOAT_VEC2 => FloatVec2,
        glw::GL_FLOAT_VEC3 => FloatVec3,
        glw::GL_FLOAT_VEC4 => FloatVec4,
        glw::GL_FLOAT_MAT2 => FloatMat2,
        glw::GL_FLOAT_MAT2x3 => FloatMat2x3,
        glw::GL_FLOAT_MAT2x4 => FloatMat2x4,
        glw::GL_FLOAT_MAT3x2 => FloatMat3x2,
        glw::GL_FLOAT_MAT3 => FloatMat3,
        glw::GL_FLOAT_MAT3x4 => FloatMat3x4,
        glw::GL_FLOAT_MAT4x2 => FloatMat4x2,
        glw::GL_FLOAT_MAT4x3 => FloatMat4x3,
        glw::GL_FLOAT_MAT4 => FloatMat4,
        glw::GL_INT => Int,
        glw::GL_INT_VEC2 => IntVec2,
        glw::GL_INT_VEC3 => IntVec3,
        glw::GL_INT_VEC4 => IntVec4,
        glw::GL_UNSIGNED_INT => Uint,
        glw::GL_UNSIGNED_INT_VEC2 => UintVec2,
        glw::GL_UNSIGNED_INT_VEC3 => UintVec3,
        glw::GL_UNSIGNED_INT_VEC4 => UintVec4,
        glw::GL_BOOL => Bool,
        glw::GL_BOOL_VEC2 => BoolVec2,
        glw::GL_BOOL_VEC3 => BoolVec3,
        glw::GL_BOOL_VEC4 => BoolVec4,
        glw::GL_SAMPLER_2D => Sampler2D,
        glw::GL_SAMPLER_CUBE => SamplerCube,
        glw::GL_SAMPLER_2D_ARRAY => Sampler2DArray,
        glw::GL_SAMPLER_3D => Sampler3D,
        glw::GL_SAMPLER_2D_SHADOW => Sampler2DShadow,
        glw::GL_SAMPLER_CUBE_SHADOW => SamplerCubeShadow,
        glw::GL_SAMPLER_2D_ARRAY_SHADOW => Sampler2DArrayShadow,
        glw::GL_INT_SAMPLER_2D => IntSampler2D,
        glw::GL_INT_SAMPLER_CUBE => IntSamplerCube,
        glw::GL_INT_SAMPLER_2D_ARRAY => IntSampler2DArray,
        glw::GL_INT_SAMPLER_3D => IntSampler3D,
        glw::GL_UNSIGNED_INT_SAMPLER_2D => UintSampler2D,
        glw::GL_UNSIGNED_INT_SAMPLER_CUBE => UintSamplerCube,
        glw::GL_UNSIGNED_INT_SAMPLER_2D_ARRAY => UintSampler2DArray,
        glw::GL_UNSIGNED_INT_SAMPLER_3D => UintSampler3D,
        glw::GL_SAMPLER_2D_MULTISAMPLE => Sampler2DMultisample,
        glw::GL_INT_SAMPLER_2D_MULTISAMPLE => IntSampler2DMultisample,
        glw::GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE => UintSampler2DMultisample,
        glw::GL_IMAGE_2D => Image2D,
        glw::GL_IMAGE_CUBE => ImageCube,
        glw::GL_IMAGE_2D_ARRAY => Image2DArray,
        glw::GL_IMAGE_3D => Image3D,
        glw::GL_INT_IMAGE_2D => IntImage2D,
        glw::GL_INT_IMAGE_CUBE => IntImageCube,
        glw::GL_INT_IMAGE_2D_ARRAY => IntImage2DArray,
        glw::GL_INT_IMAGE_3D => IntImage3D,
        glw::GL_UNSIGNED_INT_IMAGE_2D => UintImage2D,
        glw::GL_UNSIGNED_INT_IMAGE_CUBE => UintImageCube,
        glw::GL_UNSIGNED_INT_IMAGE_2D_ARRAY => UintImage2DArray,
        glw::GL_UNSIGNED_INT_IMAGE_3D => UintImage3D,
        glw::GL_UNSIGNED_INT_ATOMIC_COUNTER => UintAtomicCounter,
        _ => Invalid,
    }
}
