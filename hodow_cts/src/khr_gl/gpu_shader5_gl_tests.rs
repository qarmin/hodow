// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cGPUShader5Tests.cpp
//   external/openglcts/modules/gl/gl3cGPUShader5Tests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. This is `gpu_shader5_gl`, the three desktop GL cases of `gl3cts::GPUShader5Tests` (not the `gpu_shader5` group of `khr_gl/gpu_shader5`). `Utils::programInfo` is `ShaderProgram`. The `testCase` tables are the two const tables below, extracted from the C++ by script; their data pointers are `[u32; 4]` bit patterns since upstream hands the same memory to uniforms of different types (`floats` to an `int` uniform is the point of the valid float-encoding rows). `Utils::replaceToken`'s first-occurrence replacement is `str::replace` here; every token appears exactly as many times as it is replaced. The extension check upstream throws from `iterate` is `check_support`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const WIDTH: i32 = 8;
const HEIGHT: i32 = 8;

/// `Utils::_variable_type`
#[derive(Clone, Copy)]
enum VarType {
    Float,
    Int,
    IVec2,
    IVec3,
    IVec4,
    UInt,
    UVec2,
    UVec3,
    UVec4,
    Vec2,
    Vec3,
    Vec4,
}

const FRAGMENT_SHADER: &str =
    "#version 150\n\nin  vec4 result;\nout vec4 color;\n\nvoid main()\n{\n    color = result;\n}\n\n";

/// The `switch (gl_VertexID)` that every vertex shader here ends with.
const VERTEX_POSITIONS: &str = "    switch (gl_VertexID)\n    {\n      case 0: gl_Position = vec4(-1.0, 1.0, 0.0, 1.0); break; \n      case 1: gl_Position = vec4( 1.0, 1.0, 0.0, 1.0); break; \n      case 2: gl_Position = vec4(-1.0,-1.0, 0.0, 1.0); break; \n      case 3: gl_Position = vec4( 1.0,-1.0, 0.0, 1.0); break; \n    }\n}\n\n";

const UNI_DATA_INT_1: [u32; 4] = [112i32 as u32, -1122i32 as u32, 111222i32 as u32, -1222111222i32 as u32];
const UNI_DATA_INT_2: [u32; 4] = [-112i32 as u32, 1122i32 as u32, -111222i32 as u32, 1222111222i32 as u32];
const UNI_DATA_UINT_1: [u32; 4] = [0xffff0000, 0x0000ffff, 0x00ffffff, 0xffffffff];
const UNI_DATA_UINT_2: [u32; 4] = [0xfff70000, 0x00007fff, 0x007fffff, 0xfffffff7];

/// `floats`, `ints` and `uints` of the float encoding cases, as bit patterns
const FLOATS: [u32; 4] = [
    (-1.0f32).to_bits(),
    (-1234.0f32).to_bits(),
    (1.0f32).to_bits(),
    (1234.0f32).to_bits(),
];
const INTS: [u32; 4] = [-1i32 as u32, -1234i32 as u32, 1, 1234];
const UINTS: [u32; 4] = [0xffffffff, 0xfffffb2e, 1, 0x4d2];

struct ImplicitCase {
    destination_type: &'static str,
    is_white_expected: bool,
    source_type: &'static str,
    source_variable_type: VarType,
    u1: &'static [u32; 4],
    u2: &'static [u32; 4],
}

struct ValueInfo {
    var_type: VarType,
    type_name: &'static str,
    data: &'static [u32; 4],
}

struct EncodingCase {
    expected: ValueInfo,
    value: ValueInfo,
    function_name: &'static str,
    is_white_expected: bool,
}

const IMPLICIT_CONVERSION_CASES: [ImplicitCase; 24] = [
    ImplicitCase {
        destination_type: "uint",
        is_white_expected: false,
        source_type: "int",
        source_variable_type: VarType::Int,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uint",
        is_white_expected: true,
        source_type: "int",
        source_variable_type: VarType::Int,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_1,
    },
    ImplicitCase {
        destination_type: "float",
        is_white_expected: false,
        source_type: "int",
        source_variable_type: VarType::Int,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "float",
        is_white_expected: true,
        source_type: "int",
        source_variable_type: VarType::Int,
        u1: &UNI_DATA_INT_2,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uvec2",
        is_white_expected: false,
        source_type: "ivec2",
        source_variable_type: VarType::IVec2,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uvec2",
        is_white_expected: true,
        source_type: "ivec2",
        source_variable_type: VarType::IVec2,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_1,
    },
    ImplicitCase {
        destination_type: "vec2",
        is_white_expected: false,
        source_type: "ivec2",
        source_variable_type: VarType::IVec2,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "vec2",
        is_white_expected: true,
        source_type: "ivec2",
        source_variable_type: VarType::IVec2,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_1,
    },
    ImplicitCase {
        destination_type: "uvec3",
        is_white_expected: false,
        source_type: "ivec3",
        source_variable_type: VarType::IVec3,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uvec3",
        is_white_expected: true,
        source_type: "ivec3",
        source_variable_type: VarType::IVec3,
        u1: &UNI_DATA_INT_2,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "vec3",
        is_white_expected: false,
        source_type: "ivec3",
        source_variable_type: VarType::IVec3,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "vec3",
        is_white_expected: true,
        source_type: "ivec3",
        source_variable_type: VarType::IVec3,
        u1: &UNI_DATA_INT_2,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uvec4",
        is_white_expected: false,
        source_type: "ivec4",
        source_variable_type: VarType::IVec4,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "uvec4",
        is_white_expected: true,
        source_type: "ivec4",
        source_variable_type: VarType::IVec4,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_1,
    },
    ImplicitCase {
        destination_type: "vec4",
        is_white_expected: false,
        source_type: "ivec4",
        source_variable_type: VarType::IVec4,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_2,
    },
    ImplicitCase {
        destination_type: "vec4",
        is_white_expected: true,
        source_type: "ivec4",
        source_variable_type: VarType::IVec4,
        u1: &UNI_DATA_INT_1,
        u2: &UNI_DATA_INT_1,
    },
    ImplicitCase {
        destination_type: "float",
        is_white_expected: false,
        source_type: "uint",
        source_variable_type: VarType::UInt,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "float",
        is_white_expected: true,
        source_type: "uint",
        source_variable_type: VarType::UInt,
        u1: &UNI_DATA_UINT_2,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "vec2",
        is_white_expected: false,
        source_type: "uvec2",
        source_variable_type: VarType::UVec2,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "vec2",
        is_white_expected: true,
        source_type: "uvec2",
        source_variable_type: VarType::UVec2,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_1,
    },
    ImplicitCase {
        destination_type: "vec3",
        is_white_expected: false,
        source_type: "uvec3",
        source_variable_type: VarType::UVec3,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "vec3",
        is_white_expected: true,
        source_type: "uvec3",
        source_variable_type: VarType::UVec3,
        u1: &UNI_DATA_UINT_2,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "vec4",
        is_white_expected: false,
        source_type: "uvec4",
        source_variable_type: VarType::UVec4,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_2,
    },
    ImplicitCase {
        destination_type: "vec4",
        is_white_expected: true,
        source_type: "uvec4",
        source_variable_type: VarType::UVec4,
        u1: &UNI_DATA_UINT_1,
        u2: &UNI_DATA_UINT_1,
    },
];

const FLOAT_ENCODING_CASES: [EncodingCase; 32] = [
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Int,
            type_name: "int",
            data: &INTS,
        },
        value: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Int,
            type_name: "int",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec2,
            type_name: "ivec2",
            data: &INTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec2,
            type_name: "ivec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec3,
            type_name: "ivec3",
            data: &INTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec3,
            type_name: "ivec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec4,
            type_name: "ivec4",
            data: &INTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::IVec4,
            type_name: "ivec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        function_name: "floatBitsToInt",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UInt,
            type_name: "uint",
            data: &UINTS,
        },
        value: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UInt,
            type_name: "uint",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec2,
            type_name: "uvec2",
            data: &UINTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec2,
            type_name: "uvec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec3,
            type_name: "uvec3",
            data: &UINTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec3,
            type_name: "uvec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec4,
            type_name: "uvec4",
            data: &UINTS,
        },
        value: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::UVec4,
            type_name: "uvec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        function_name: "floatBitsToUint",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Int,
            type_name: "int",
            data: &INTS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::Int,
            type_name: "int",
            data: &FLOATS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec2,
            type_name: "ivec2",
            data: &INTS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec2,
            type_name: "ivec2",
            data: &FLOATS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec3,
            type_name: "ivec3",
            data: &INTS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec3,
            type_name: "ivec3",
            data: &FLOATS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec4,
            type_name: "ivec4",
            data: &INTS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::IVec4,
            type_name: "ivec4",
            data: &FLOATS,
        },
        function_name: "intBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UInt,
            type_name: "uint",
            data: &UINTS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Float,
            type_name: "float",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UInt,
            type_name: "uint",
            data: &FLOATS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec2,
            type_name: "uvec2",
            data: &UINTS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec2,
            type_name: "vec2",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec2,
            type_name: "uvec2",
            data: &FLOATS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec3,
            type_name: "uvec3",
            data: &UINTS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec3,
            type_name: "vec3",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec3,
            type_name: "uvec3",
            data: &FLOATS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: true,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec4,
            type_name: "uvec4",
            data: &UINTS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: false,
    },
    EncodingCase {
        expected: ValueInfo {
            var_type: VarType::Vec4,
            type_name: "vec4",
            data: &FLOATS,
        },
        value: ValueInfo {
            var_type: VarType::UVec4,
            type_name: "uvec4",
            data: &FLOATS,
        },
        function_name: "uintBitsToFloat",
        is_white_expected: true,
    },
];

/// `programInfo::setUniform`
fn set_uniform(
    gl: &glw::Functions,
    program: glw::GLuint,
    var_type: VarType,
    name: &std::ffi::CStr,
    data: &[u32; 4],
) -> Res<()> {
    // SAFETY: a linked program and a NUL-terminated name.
    let location = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
    glu::expect_no_error(gl, "glGetUniformLocation() call failed.")?;
    if location == -1 {
        return Err(TestError::Fail("Uniform variable is unavailable".to_string()));
    }

    let f_data = data.as_ptr().cast::<f32>();
    let i_data = data.as_ptr().cast::<GLint>();
    let u_data = data.as_ptr();
    // SAFETY: the array holds the four 32-bit components of the largest type, and one element is read.
    unsafe {
        match var_type {
            VarType::Float => gl.uniform_1fv(location, 1, f_data),
            VarType::Int => gl.uniform_1iv(location, 1, i_data),
            VarType::IVec2 => gl.uniform_2iv(location, 1, i_data),
            VarType::IVec3 => gl.uniform_3iv(location, 1, i_data),
            VarType::IVec4 => gl.uniform_4iv(location, 1, i_data),
            VarType::UInt => gl.uniform_1uiv(location, 1, u_data),
            VarType::UVec2 => gl.uniform_2uiv(location, 1, u_data),
            VarType::UVec3 => gl.uniform_3uiv(location, 1, u_data),
            VarType::UVec4 => gl.uniform_4uiv(location, 1, u_data),
            VarType::Vec2 => gl.uniform_2fv(location, 1, f_data),
            VarType::Vec3 => gl.uniform_3fv(location, 1, f_data),
            VarType::Vec4 => gl.uniform_4fv(location, 1, f_data),
        }
    }
    glu::expect_no_error(gl, "Uniform")
}

/// `GPUShader5ImplicitConversionsTest`'s `testInit`, `verifyImage`, and `deinit` (as drop): the framebuffer and vertex array every case draws with
struct Fixture<'a> {
    gl: &'a glw::Functions,
    _fbo: glu::Framebuffer<'a>,
    _tex: glu::Texture<'a>,
    _vao: glu::VertexArray<'a>,
}

impl<'a> Fixture<'a> {
    fn new(gl: &'a glw::Functions) -> Res<Self> {
        let tex = glu::Texture::new(gl);
        glu::expect_no_error(gl, "GenTextures")?;
        gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, tex.get()));
        gl_call!(
            gl,
            "TexStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, WIDTH, HEIGHT)
        );

        let fbo = glu::Framebuffer::new(gl);
        glu::expect_no_error(gl, "GenFramebuffers")?;
        gl_call!(
            gl,
            "BindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get())
        );
        gl_call!(
            gl,
            "FramebufferTexture2D",
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex.get(),
                0
            )
        );
        gl_call!(gl, "Viewport", gl.viewport(0, 0, WIDTH, HEIGHT));

        let vao = glu::VertexArray::new(gl);
        glu::expect_no_error(gl, "genVertexArrays")?;
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao.get()));

        Ok(Self {
            gl,
            _fbo: fbo,
            _tex: tex,
            _vao: vao,
        })
    }

    /// Verifies if image is filled with <color>; `is_expected` selects if image is expected to be filled with given color or not
    fn verify_image(&self, color: u32, is_expected: bool) -> Res<()> {
        let gl = self.gl;
        let mut result_image = [0u32; (WIDTH * HEIGHT) as usize];
        gl_call!(
            gl,
            "getTexImage",
            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result_image.as_mut_ptr().cast()
            )
        );

        for pixel_data in result_image {
            if is_expected != (color == pixel_data) {
                return Err(TestError::Fail(
                    "Found invalid pixel during verification of drawn image".to_string(),
                ));
            }
        }
        Ok(())
    }

    /// Builds the program, sets the two uniforms, and draws the quad: the part the three `execute` functions share.
    fn draw(&self, vs: &str, uniforms: [(VarType, &std::ffi::CStr, &[u32; 4]); 2]) -> Res<()> {
        let gl = self.gl;
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, FRAGMENT_SHADER));
        if !program.is_ok() {
            return Err(TestError::Fail(format!(
                "Failed to build the program. {}",
                program.build_failure_summary().unwrap_or_default()
            )));
        }
        gl_call!(gl, "UseProgram", gl.use_program(program.program()));
        for (var_type, name, data) in uniforms {
            set_uniform(gl, program.program(), var_type, name, data)?;
        }

        gl_call!(gl, "clearColor", gl.clear_color(0.5, 0.5, 0.5, 0.5));
        gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        // SAFETY: a current context; `Utils::programInfo`'s destructor does the same.
        unsafe { gl.use_program(0) };
        Ok(())
    }
}

/// `GPUShader5ImplicitConversionsTest::getVertexShader`
fn implicit_conversions_vertex_shader(destination_type: &str, source_type: &str) -> String {
    let zero = match destination_type {
        "int" | "uint" => "0",
        "float" => "0.0",
        "ivec2" => "ivec2(0,0)",
        "ivec3" => "ivec3(0,0,0)",
        "ivec4" => "ivec4(0,0,0,0)",
        "uvec2" => "uvec2(0,0)",
        "uvec3" => "uvec3(0,0,0)",
        "uvec4" => "uvec4(0,0,0,0)",
        "vec2" => "vec2(0,0)",
        "vec3" => "vec3(0,0,0)",
        "vec4" => "vec4(0,0,0,0)",
        _ => "ZERO",
    };
    let template = format!(
        "#version 150\n#extension GL_ARB_gpu_shader5 : require\n\nuniform SOURCE_TYPE u1;\nuniform SOURCE_TYPE u2;\n\nout     vec4 result;\n\nvoid main()\n{{\n    DESTINATION_TYPE v = ZERO;\n\n    v = DESTINATION_TYPE(u2) - u1;\n\n    result = vec4(0.0, 0.0, 0.0, 0.0);\n    if (ZERO == v)\n    {{\n      result = vec4(1.0, 1.0, 1.0, 1.0);\n    }}\n\n{VERTEX_POSITIONS}"
    );
    template
        .replace("SOURCE_TYPE", source_type)
        .replace("DESTINATION_TYPE", destination_type)
        .replace("ZERO", zero)
}

/// `GPUShader5ImplicitConversionsTest::iterate`
fn implicit_conversions(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let fixture = Fixture::new(gl)?;
    const WHITE_COLOR: u32 = 0xffffffff;

    for test_case in &IMPLICIT_CONVERSION_CASES {
        let vs = implicit_conversions_vertex_shader(test_case.destination_type, test_case.source_type);
        fixture.draw(
            &vs,
            [
                (test_case.source_variable_type, c"u1", test_case.u1),
                (test_case.source_variable_type, c"u2", test_case.u2),
            ],
        )?;
        fixture.verify_image(WHITE_COLOR, test_case.is_white_expected)?;
    }

    Ok(TestStatus::pass("Pass"))
}

/// `GPUShader5FunctionOverloadingTest::iterate` and `execute`
fn function_overloading(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let u1_data_1: [u32; 4] = [0xffff0000, 0x0000ffff, 0x00ffffff, 0xffffffff];
    let u1_data_2: [u32; 4] = [-112i32 as u32, 1122, -111222i32 as u32, 1222111222];
    let u2_data_1: [u32; 4] = [0xffff0000, 0x0000ffff, 0x00ffffff, 0xffffffff];
    let u2_data_2: [u32; 4] = [0xfff70000, 0x00007fff, 0x007fffff, 0xfffffff7];
    let fixture = Fixture::new(gl)?;
    const BLACK_COLOR: u32 = 0x00000000;

    let vs = format!(
        "#version 150\n#extension GL_ARB_gpu_shader5 : require\n\nuniform ivec4 u1;\nuniform uvec4 u2;\n\nout     vec4  result;\n\nvec4 f(in vec4 a, in vec4 b)\n{{\n    return a * b;\n}}\n\nvec4 f(in uvec4 a, in uvec4 b)\n{{\n    return vec4(a - b);\n}}\n\nvoid main()\n{{\n    result = f(u1, u2);\n\n{VERTEX_POSITIONS}"
    );
    for (u1_data, u2_data, is_black_expected) in [(&u1_data_1, &u2_data_1, true), (&u1_data_2, &u2_data_2, false)] {
        fixture.draw(
            &vs,
            [(VarType::IVec4, c"u1", u1_data), (VarType::UVec4, c"u2", u2_data)],
        )?;
        fixture.verify_image(BLACK_COLOR, is_black_expected)?;
    }

    Ok(TestStatus::pass("Pass"))
}

/// `GPUShader5FloatEncodingTest::getVertexShader`
fn float_encoding_vertex_shader(test_case: &EncodingCase) -> String {
    let template = format!(
        "#version 150\n#extension GL_ARB_gpu_shader5 : require\n\nuniform EXPECTED_VALUE_TYPE expected_value;\nuniform VALUE_TYPE value;\n\nout     vec4 result;\n\nvoid main()\n{{\n    result = vec4(1.0, 1.0, 1.0, 1.0);\n\n    EXPECTED_VALUE_TYPE ret_val = TESTED_FUNCTION(value);\n\n    if (expected_value != ret_val)\n    {{\n        result = vec4(0.0, 0.0, 0.0, 0.0);\n    }}\n\n{VERTEX_POSITIONS}"
    );
    template
        .replace("EXPECTED_VALUE_TYPE", test_case.expected.type_name)
        .replace("VALUE_TYPE", test_case.value.type_name)
        .replace("TESTED_FUNCTION", test_case.function_name)
}

/// `GPUShader5FloatEncodingTest::iterate` and `execute`
fn float_encoding(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let fixture = Fixture::new(gl)?;
    const WHITE_COLOR: u32 = 0xffffffff;

    for test_case in &FLOAT_ENCODING_CASES {
        let vs = float_encoding_vertex_shader(test_case);
        fixture.draw(
            &vs,
            [
                (test_case.expected.var_type, c"expected_value", test_case.expected.data),
                (test_case.value.var_type, c"value", test_case.value.data),
            ],
        )?;
        fixture.verify_image(WHITE_COLOR, test_case.is_white_expected)?;
    }

    Ok(TestStatus::pass("Pass"))
}

struct GpuShader5Case {
    name: &'static str,
    test: fn(&Context) -> TestOutcome,
}

impl TestCase for GpuShader5Case {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader5") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader5 is not supported.".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        (self.test)(context)
    }
}

/// `GPUShader5Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("gpu_shader5_gl");
    for (name, test) in [
        (
            "implicit_conversions",
            implicit_conversions as fn(&Context) -> TestOutcome,
        ),
        ("function_overloading", function_overloading),
        ("float_encoding", float_encoding),
    ] {
        group.add_child(Box::new(GpuShader5Case { name, test }) as Box<dyn TestCase>);
    }
    group
}
