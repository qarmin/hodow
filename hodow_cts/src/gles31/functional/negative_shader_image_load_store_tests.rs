// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream derives three strings from a
// `tcu::TextureFormat` through three switches; here the format table carries those strings
// directly, since nothing else about the format is used.
//
// Upstream instantiates each of the four test bodies for six texture types through a
// function template; `TestFunc` is a plain `fn` pointer here, so a macro emits the same 24
// wrappers.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::ShaderType;
use crate::tcu::TestError;

/// `MemoryQualifier`
#[derive(Clone, Copy)]
enum Memory {
    Readonly,
    Writeonly,
    Both,
}

impl Memory {
    /// `getMemoryQualifier`
    fn qualifier(self) -> &'static str {
        match self {
            Self::Writeonly => "writeonly",
            Self::Readonly => "readonly",
            Self::Both => "writeonly readonly",
        }
    }
}

/// `ImageOperation`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ImageOperation {
    Store,
    Load,
    AtomicAdd,
    AtomicMin,
    AtomicMax,
    AtomicAnd,
    AtomicOr,
    AtomicXor,
    AtomicExchange,
    AtomicCompSwap,
}

impl ImageOperation {
    /// `getFunctionName`
    fn name(self) -> &'static str {
        match self {
            Self::Store => "imageStore",
            Self::Load => "imageLoad",
            Self::AtomicAdd => "imageAtomicAdd",
            Self::AtomicMin => "imageAtomicMin",
            Self::AtomicMax => "imageAtomicMax",
            Self::AtomicAnd => "imageAtomicAnd",
            Self::AtomicOr => "imageAtomicOr",
            Self::AtomicXor => "imageAtomicXor",
            Self::AtomicExchange => "imageAtomicExchange",
            Self::AtomicCompSwap => "imageAtomicCompSwap",
        }
    }

    /// `getShaderImageFunctionExtensionString`
    fn extension(self) -> &'static str {
        match self {
            Self::Store | Self::Load => "",
            _ => "#extension GL_OES_shader_image_atomic : enable",
        }
    }

    /// `getOtherFunctionArguments`
    fn arguments(self, format: &Format) -> String {
        match self {
            Self::Load => String::new(),
            Self::Store => format!(", {}vec4(1, 1, 1, 1)", format.type_prefix),
            Self::AtomicAdd
            | Self::AtomicMin
            | Self::AtomicMax
            | Self::AtomicAnd
            | Self::AtomicOr
            | Self::AtomicXor => ", 1".to_string(),
            Self::AtomicExchange => if format.is_float { ", 1.0" } else { ", 1" }.to_string(),
            Self::AtomicCompSwap => ", 1, 1".to_string(),
        }
    }
}

/// `glu::TextureTestUtil::TextureType`, restricted to the six upstream instantiates.
#[derive(Clone, Copy)]
enum ImageType {
    Texture2D,
    Texture3D,
    Cube,
    Texture2DArray,
    Buffer,
    CubeArray,
}

impl ImageType {
    /// The suffix of `getShaderImageTypeDeclaration`.
    fn suffix(self) -> &'static str {
        match self {
            Self::Texture2D => "2D",
            Self::Texture3D => "3D",
            Self::Cube => "Cube",
            Self::Texture2DArray => "2DArray",
            Self::Buffer => "Buffer",
            Self::CubeArray => "CubeArray",
        }
    }

    /// `getShaderImageTypeExtensionString`
    fn extension(self) -> &'static str {
        match self {
            Self::Buffer => "#extension GL_EXT_texture_buffer : enable",
            Self::CubeArray => "#extension GL_EXT_texture_cube_map_array : enable",
            _ => "",
        }
    }

    /// `getShaderImageParamP`
    fn param_p(self) -> &'static str {
        match self {
            Self::Texture2D => "ivec2(1, 1)",
            Self::Buffer => "1",
            _ => "ivec3(1, 1, 1)",
        }
    }
}

/// One `tcu::TextureFormat` reduced to what the shader source needs: its layout
/// qualifier, the `i`/`u`/`` prefix its image type and vector literals take, and whether
/// `imageAtomicExchange` gets a float argument.
struct Format {
    layout: &'static str,
    type_prefix: &'static str,
    is_float: bool,
}

const fn fmt(layout: &'static str, type_prefix: &'static str, is_float: bool) -> Format {
    Format {
        layout,
        type_prefix,
        is_float,
    }
}

/// The float-and-integer format list `image_store` / `image_load` / `image_atomic_exchange`
/// share.
const ALL_FORMATS: &[Format] = &[
    fmt("rgba32f", "", true),
    fmt("rgba16f", "", true),
    fmt("r32f", "", true),
    fmt("rgba8", "", true),
    fmt("rgba8_snorm", "", true),
    fmt("rgba32i", "i", false),
    fmt("rgba16i", "i", false),
    fmt("rgba8i", "i", false),
    fmt("r32i", "i", false),
    fmt("rgba32ui", "u", false),
    fmt("rgba16ui", "u", false),
    fmt("rgba8ui", "u", false),
    fmt("r32ui", "u", false),
];

/// The integer-only tail of the list above, which is what `image_atomic` uses.
const FIRST_INTEGER_FORMAT: usize = 5;

/// `s_shaders`
const SHADERS: &[ShaderType] = &[
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

/// `generateShaderSource` - pinned to `#version 310 es` upstream, on every context.
fn generate_shader_source(
    function: ImageOperation,
    memory: Memory,
    image_type: ImageType,
    format: &Format,
    shader_type: ShaderType,
) -> String {
    let geometry_layout = if matches!(shader_type, ShaderType::Geometry) {
        "layout(max_vertices = 3) out;"
    } else {
        ""
    };

    format!(
        "#version 310 es\n{type_ext}\n{fn_ext}\n{geometry_layout}\nlayout({layout}, binding = 0) highp uniform {memory} {prefix}image{image} u_img0;\nvoid main(void)\n{{\n {name}(u_img0, {param}{args});\n}}\n",
        type_ext = image_type.extension(),
        fn_ext = function.extension(),
        layout = format.layout,
        memory = memory.qualifier(),
        prefix = format.type_prefix,
        image = image_type.suffix(),
        name = function.name(),
        param = image_type.param_p(),
        args = function.arguments(format),
    )
}

/// `testShader`
fn test_shader(
    ctx: &mut NegativeTestContext<'_>,
    function: ImageOperation,
    memory: Memory,
    image_type: ImageType,
    format: &Format,
) {
    ctx.begin_section(&format!("{} {} {}", function.name(), memory.qualifier(), format.layout));
    for &shader_type in SHADERS {
        if ctx.is_shader_supported(shader_type) {
            ctx.begin_section(&format!("Verify shader: {}", shader_type.as_str()));
            let source = generate_shader_source(function, memory, image_type, format, shader_type);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            ctx.end_section();
        }
    }
    ctx.end_section();
}

/// `image_store`
fn image_store(ctx: &mut NegativeTestContext<'_>, image_type: ImageType) -> Result<(), TestError> {
    ctx.begin_section("It is an error to pass a readonly image to imageStore.");
    for memory in [Memory::Readonly, Memory::Both] {
        for format in ALL_FORMATS {
            test_shader(ctx, ImageOperation::Store, memory, image_type, format);
        }
    }
    ctx.end_section();
    Ok(())
}

/// `image_load`
fn image_load(ctx: &mut NegativeTestContext<'_>, image_type: ImageType) -> Result<(), TestError> {
    ctx.begin_section("It is an error to pass a writeonly image to imageLoad.");
    for memory in [Memory::Writeonly, Memory::Both] {
        for format in ALL_FORMATS {
            test_shader(ctx, ImageOperation::Load, memory, image_type, format);
        }
    }
    ctx.end_section();
    Ok(())
}

/// `image_atomic`
fn image_atomic(ctx: &mut NegativeTestContext<'_>, image_type: ImageType) -> Result<(), TestError> {
    let operations = [
        ImageOperation::AtomicAdd,
        ImageOperation::AtomicMin,
        ImageOperation::AtomicMax,
        ImageOperation::AtomicAnd,
        ImageOperation::AtomicOr,
        ImageOperation::AtomicXor,
        ImageOperation::AtomicCompSwap,
    ];

    ctx.begin_section("It is an error to pass a writeonly and/or readonly image to imageAtomic*.");
    for memory in [Memory::Readonly, Memory::Writeonly, Memory::Both] {
        for format in &ALL_FORMATS[FIRST_INTEGER_FORMAT..] {
            for function in operations {
                test_shader(ctx, function, memory, image_type, format);
            }
        }
    }
    ctx.end_section();
    Ok(())
}

/// `image_atomic_exchange`
fn image_atomic_exchange(ctx: &mut NegativeTestContext<'_>, image_type: ImageType) -> Result<(), TestError> {
    ctx.begin_section("It is an error to pass a writeonly and/or readonly image to imageAtomic*.");
    for memory in [Memory::Readonly, Memory::Writeonly, Memory::Both] {
        for format in ALL_FORMATS {
            test_shader(ctx, ImageOperation::AtomicExchange, memory, image_type, format);
        }
    }
    ctx.end_section();
    Ok(())
}

/// `CREATE_TEST_FUNC_PER_TEXTURE_TYPE` - one `TestFunc` per (body, texture type) pair, in
/// upstream's order.
macro_rules! per_texture_type {
    ($table:ident, $body:ident, $module:ident) => {
        mod $module {
            use super::{ImageType, NegativeTestContext, TestError, $body};

            pub fn texture_2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::Texture2D)
            }
            pub fn texture_3d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::Texture3D)
            }
            pub fn cube(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::Cube)
            }
            pub fn array_2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::Texture2DArray)
            }
            pub fn buffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::Buffer)
            }
            pub fn cube_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
                $body(ctx, ImageType::CubeArray)
            }
        }

        pub static $table: &[FunctionContainer] = &[
            FunctionContainer {
                function: $module::texture_2d,
                name: "texture_2d",
            },
            FunctionContainer {
                function: $module::texture_3d,
                name: "texture_3d",
            },
            FunctionContainer {
                function: $module::cube,
                name: "cube",
            },
            FunctionContainer {
                function: $module::array_2d,
                name: "2d_array",
            },
            FunctionContainer {
                function: $module::buffer,
                name: "buffer",
            },
            FunctionContainer {
                function: $module::cube_array,
                name: "cube_array",
            },
        ];
    };
}

per_texture_type!(LOAD_FUNCTIONS, image_load, load_wrappers);
per_texture_type!(STORE_FUNCTIONS, image_store, store_wrappers);
per_texture_type!(ATOMIC_FUNCTIONS, image_atomic, atomic_wrappers);
per_texture_type!(
    ATOMIC_EXCHANGE_FUNCTIONS,
    image_atomic_exchange,
    atomic_exchange_wrappers
);
