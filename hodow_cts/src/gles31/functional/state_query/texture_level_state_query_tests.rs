// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureLevelStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One deliberate shape change: upstream's twelve `TextureLevel*Case` subclasses differ
// only in which iteration generator they call and which pname they verify, so the
// hierarchy is one `LevelCase` enum with the same twelve variants and the same two
// methods (`generate_test_iterations` / `check_texture_state`). Everything else - the
// generators, the format tables, the operation order inside an iteration - is upstream's.

use crate::gls::state_query_util::{
    QueriedState, QueryType, query_texture_level_state, verify_integer, verify_integer_min,
};
use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{ApiCase, ContextType, TestCaseGroup, add_api_case, get_transfer_format, texture_format_name};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::pixel::get_texture_format_bit_depth;
use crate::tcu::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};

/// `textureTypeHasDepth`
fn texture_type_has_depth(texture_bind_target: GLenum) -> bool {
    match texture_bind_target {
        glw::GL_TEXTURE_2D => false,
        glw::GL_TEXTURE_3D => true,
        glw::GL_TEXTURE_2D_ARRAY => true,
        glw::GL_TEXTURE_CUBE_MAP => false,
        glw::GL_TEXTURE_2D_MULTISAMPLE => false,
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => true,
        glw::GL_TEXTURE_BUFFER => false,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => true,
        other => panic!("{other:#x} is not a texture bind target"),
    }
}

/// `textureTypeHasHeight`
fn texture_type_has_height(texture_bind_target: GLenum) -> bool {
    match texture_bind_target {
        glw::GL_TEXTURE_BUFFER => false,
        glw::GL_TEXTURE_2D
        | glw::GL_TEXTURE_3D
        | glw::GL_TEXTURE_2D_ARRAY
        | glw::GL_TEXTURE_CUBE_MAP
        | glw::GL_TEXTURE_2D_MULTISAMPLE
        | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        | glw::GL_TEXTURE_CUBE_MAP_ARRAY => true,
        other => panic!("{other:#x} is not a texture bind target"),
    }
}

/// `getTextureTargetExtension`
fn texture_target_extension(target: GLenum) -> &'static str {
    match target {
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => "GL_OES_texture_storage_multisample_2d_array",
        glw::GL_TEXTURE_BUFFER => "GL_EXT_texture_buffer",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "GL_EXT_texture_cube_map_array",
        other => panic!("{other:#x} is a core texture target"),
    }
}

/// `isCoreTextureTarget`
fn is_core_texture_target(target: GLenum, context_type: ContextType) -> bool {
    match target {
        glw::GL_TEXTURE_2D
        | glw::GL_TEXTURE_3D
        | glw::GL_TEXTURE_2D_ARRAY
        | glw::GL_TEXTURE_CUBE_MAP
        | glw::GL_TEXTURE_2D_MULTISAMPLE => true,
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY | glw::GL_TEXTURE_BUFFER | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
            context_type.supports(3, 2)
        }
        _ => false,
    }
}

/// `TextureGenerationSpec::TextureLevelSpec`
#[derive(Clone, Copy)]
struct TextureLevelSpec {
    width: i32,
    height: i32,
    depth: i32,
    level: i32,
    internal_format: GLenum,
    compressed: bool,
}

impl Default for TextureLevelSpec {
    fn default() -> Self {
        Self {
            width: 0,
            height: 0,
            depth: 0,
            level: 0,
            internal_format: glw::GL_RGBA,
            compressed: false,
        }
    }
}

/// `TextureGenerationSpec`
struct TextureGenerationSpec {
    bind_target: GLenum,
    query_target: GLenum,
    immutable: bool,
    /// fixed sample pos argument for multisample textures
    fixed_sample_pos: bool,
    sample_count: i32,
    tex_buffer_data_offset: i32,
    tex_buffer_data_size: i32,
    bind_whole_array: bool,
    levels: Vec<TextureLevelSpec>,
    description: String,
}

impl Default for TextureGenerationSpec {
    fn default() -> Self {
        Self {
            bind_target: 0,
            query_target: 0,
            immutable: true,
            fixed_sample_pos: true,
            sample_count: 0,
            tex_buffer_data_offset: 0,
            tex_buffer_data_size: 256,
            bind_whole_array: false,
            levels: Vec::new(),
            description: String::new(),
        }
    }
}

/// `glu::getTextureTargetStr`, for the iteration descriptions only.
fn texture_target_str(target: GLenum) -> &'static str {
    match target {
        glw::GL_TEXTURE_2D => "GL_TEXTURE_2D",
        glw::GL_TEXTURE_3D => "GL_TEXTURE_3D",
        glw::GL_TEXTURE_2D_ARRAY => "GL_TEXTURE_2D_ARRAY",
        glw::GL_TEXTURE_CUBE_MAP => "GL_TEXTURE_CUBE_MAP",
        glw::GL_TEXTURE_2D_MULTISAMPLE => "GL_TEXTURE_2D_MULTISAMPLE",
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => "GL_TEXTURE_2D_MULTISAMPLE_ARRAY",
        glw::GL_TEXTURE_BUFFER => "GL_TEXTURE_BUFFER",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "GL_TEXTURE_CUBE_MAP_ARRAY",
        _ => "<unknown>",
    }
}

/// `glu::getTextureFormatStr` / `getTextureFormatName`, for the log only.
fn texture_format_str(value: i32) -> String {
    #[expect(clippy::cast_sign_loss, reason = "upstream prints the queried integer as a GLenum")]
    let as_enum = value as GLenum;
    texture_format_name(as_enum).map_or_else(|| format!("{value}"), ToString::to_string)
}

/// `verifyTextureLevelParameterEqualWithPrinter<IntegerPrinter>`
fn verify_texture_level_parameter_equal(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: i32,
    pname: GLenum,
    ref_value: i32,
    query_type: QueryType,
) -> bool {
    verify_texture_level_parameter_equal_with_printer(case, target, level, pname, ref_value, query_type, false)
}

/// `verifyTextureLevelParameterEqualWithPrinter<PixelFormatPrinter>`
fn verify_texture_level_parameter_internal_format_equal(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: i32,
    pname: GLenum,
    ref_value: i32,
    query_type: QueryType,
) -> bool {
    verify_texture_level_parameter_equal_with_printer(case, target, level, pname, ref_value, query_type, true)
}

/// `verifyTextureLevelParameterEqualWithPrinter` - the `Printer` template parameter only
/// chooses how the reference is spelled in the log, so it is a flag here.
fn verify_texture_level_parameter_equal_with_printer(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: i32,
    pname: GLenum,
    ref_value: i32,
    query_type: QueryType,
    format_printer: bool,
) -> bool {
    let printed = if format_printer {
        texture_format_str(ref_value)
    } else {
        ref_value.to_string()
    };
    log::debug!("Verifying {}, expecting {printed}", texture_level_parameter_str(pname));

    let before = case.failure_count();
    let Some(state) = query_texture_level_state(case, query_type, target, level, pname) else {
        return false;
    };

    verify_integer(case, state, ref_value);

    case.failure_count() == before
}

/// `verifyTextureLevelParameterGreaterOrEqual`
fn verify_texture_level_parameter_greater_or_equal(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: i32,
    pname: GLenum,
    ref_value: i32,
    query_type: QueryType,
) -> bool {
    log::debug!(
        "Verifying {}, expecting {ref_value} or greater",
        texture_level_parameter_str(pname)
    );

    let before = case.failure_count();
    let Some(state) = query_texture_level_state(case, query_type, target, level, pname) else {
        return false;
    };

    verify_integer_min(case, state, ref_value);

    case.failure_count() == before
}

/// `verifyTextureLevelParameterInternalFormatAnyOf`
fn verify_texture_level_parameter_internal_format_any_of(
    case: &mut ApiCase<'_>,
    target: GLenum,
    level: i32,
    pname: GLenum,
    ref_values: &[i32],
    query_type: QueryType,
) -> bool {
    let printed: Vec<String> = ref_values.iter().map(|value| texture_format_str(*value)).collect();
    log::debug!(
        "Verifying {}, expecting any of {{{}}}",
        texture_level_parameter_str(pname),
        printed.join(", ")
    );

    let Some(state) = query_texture_level_state(case, query_type, target, level, pname) else {
        return false;
    };

    match state {
        QueriedState::Integer(value) => {
            if ref_values.contains(&value) {
                return true;
            }
            log::warn!("Error: got {value}, ({})", texture_format_str(value));
            false
        }
        QueriedState::Float(value) => {
            #[expect(
                clippy::cast_precision_loss,
                reason = "upstream compares the queried float against (float)refValue"
            )]
            let matched = ref_values.iter().any(|reference| value == *reference as f32);
            if matched {
                return true;
            }
            #[expect(
                clippy::cast_possible_truncation,
                reason = "upstream prints (int)state.getFloatAccess()"
            )]
            let as_int = value as i32;
            log::warn!("Error: got {value}, ({})", texture_format_str(as_int));
            false
        }
        other => panic!("{other:?} is not a texture-level state"),
    }
}

/// `glu::getTextureLevelParameterStr`, for the log only.
fn texture_level_parameter_str(pname: GLenum) -> &'static str {
    match pname {
        glw::GL_TEXTURE_WIDTH => "GL_TEXTURE_WIDTH",
        glw::GL_TEXTURE_HEIGHT => "GL_TEXTURE_HEIGHT",
        glw::GL_TEXTURE_DEPTH => "GL_TEXTURE_DEPTH",
        glw::GL_TEXTURE_INTERNAL_FORMAT => "GL_TEXTURE_INTERNAL_FORMAT",
        glw::GL_TEXTURE_SAMPLES => "GL_TEXTURE_SAMPLES",
        glw::GL_TEXTURE_FIXED_SAMPLE_LOCATIONS => "GL_TEXTURE_FIXED_SAMPLE_LOCATIONS",
        glw::GL_TEXTURE_RED_SIZE => "GL_TEXTURE_RED_SIZE",
        glw::GL_TEXTURE_GREEN_SIZE => "GL_TEXTURE_GREEN_SIZE",
        glw::GL_TEXTURE_BLUE_SIZE => "GL_TEXTURE_BLUE_SIZE",
        glw::GL_TEXTURE_ALPHA_SIZE => "GL_TEXTURE_ALPHA_SIZE",
        glw::GL_TEXTURE_DEPTH_SIZE => "GL_TEXTURE_DEPTH_SIZE",
        glw::GL_TEXTURE_STENCIL_SIZE => "GL_TEXTURE_STENCIL_SIZE",
        glw::GL_TEXTURE_SHARED_SIZE => "GL_TEXTURE_SHARED_SIZE",
        glw::GL_TEXTURE_RED_TYPE => "GL_TEXTURE_RED_TYPE",
        glw::GL_TEXTURE_GREEN_TYPE => "GL_TEXTURE_GREEN_TYPE",
        glw::GL_TEXTURE_BLUE_TYPE => "GL_TEXTURE_BLUE_TYPE",
        glw::GL_TEXTURE_ALPHA_TYPE => "GL_TEXTURE_ALPHA_TYPE",
        glw::GL_TEXTURE_DEPTH_TYPE => "GL_TEXTURE_DEPTH_TYPE",
        glw::GL_TEXTURE_COMPRESSED => "GL_TEXTURE_COMPRESSED",
        glw::GL_TEXTURE_BUFFER_DATA_STORE_BINDING => "GL_TEXTURE_BUFFER_DATA_STORE_BINDING",
        glw::GL_TEXTURE_BUFFER_OFFSET => "GL_TEXTURE_BUFFER_OFFSET",
        glw::GL_TEXTURE_BUFFER_SIZE => "GL_TEXTURE_BUFFER_SIZE",
        _ => "<unknown>",
    }
}

/// `isDepthFormat`
fn is_depth_format(fmt: TextureFormat) -> bool {
    fmt.order == ChannelOrder::D || fmt.order == ChannelOrder::DS
}

/// `isColorRenderableFormat`
fn is_color_renderable_format(internal_format: GLenum) -> bool {
    matches!(
        internal_format,
        glw::GL_RGB565
            | glw::GL_RGBA4
            | glw::GL_RGB5_A1
            | glw::GL_RGB10_A2
            | glw::GL_RGB10_A2UI
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_R8
            | glw::GL_RG8
            | glw::GL_RGB8
            | glw::GL_RGBA8
            | glw::GL_R8I
            | glw::GL_RG8I
            | glw::GL_RGBA8I
            | glw::GL_R8UI
            | glw::GL_RG8UI
            | glw::GL_RGBA8UI
            | glw::GL_R16I
            | glw::GL_RG16I
            | glw::GL_RGBA16I
            | glw::GL_R16UI
            | glw::GL_RG16UI
            | glw::GL_RGBA16UI
            | glw::GL_R32I
            | glw::GL_RG32I
            | glw::GL_RGBA32I
            | glw::GL_R32UI
            | glw::GL_RG32UI
            | glw::GL_RGBA32UI
    )
}

/// `isRenderableFormat`
fn is_renderable_format(internal_format: GLenum) -> bool {
    is_color_renderable_format(internal_format)
        || matches!(
            internal_format,
            glw::GL_DEPTH_COMPONENT16
                | glw::GL_DEPTH_COMPONENT24
                | glw::GL_DEPTH_COMPONENT32F
                | glw::GL_DEPTH24_STENCIL8
                | glw::GL_DEPTH32F_STENCIL8
        )
}

/// `isTextureBufferFormat`
fn is_texture_buffer_format(internal_format: GLenum) -> bool {
    matches!(
        internal_format,
        glw::GL_R8
            | glw::GL_R16F
            | glw::GL_R32F
            | glw::GL_R8I
            | glw::GL_R16I
            | glw::GL_R32I
            | glw::GL_R8UI
            | glw::GL_R16UI
            | glw::GL_R32UI
            | glw::GL_RG8
            | glw::GL_RG16F
            | glw::GL_RG32F
            | glw::GL_RG8I
            | glw::GL_RG16I
            | glw::GL_RG32I
            | glw::GL_RG8UI
            | glw::GL_RG16UI
            | glw::GL_RG32UI
            | glw::GL_RGB32F
            | glw::GL_RGB32I
            | glw::GL_RGB32UI
            | glw::GL_RGBA8
            | glw::GL_RGBA16F
            | glw::GL_RGBA32F
            | glw::GL_RGBA8I
            | glw::GL_RGBA16I
            | glw::GL_RGBA32I
            | glw::GL_RGBA8UI
            | glw::GL_RGBA16UI
            | glw::GL_RGBA32UI
    )
}

/// `isLegalFormatForTarget`
///
/// The last condition is upstream's, verbatim, `||` and all: it rejects
/// `GL_TEXTURE_BUFFER` outright *and* rejects every non-texture-buffer format on every
/// other target, so `generateInternalFormatTextureGenerationGroup` only ever exercises
/// the 30 texture-buffer formats. Changing it to the `&&` it was plainly meant to be
/// would test 24 more formats than `deqp-vk`'s own build does, and this port is only
/// useful while it agrees with upstream case for case.
fn is_legal_format_for_target(target: GLenum, format: GLenum) -> bool {
    let fmt = map_gl_internal_format(format).expect("every format in the table maps");

    if target == glw::GL_TEXTURE_3D && is_depth_format(fmt) {
        return false;
    }
    if (target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY)
        && !is_renderable_format(format)
    {
        return false;
    }
    if target == glw::GL_TEXTURE_BUFFER || !is_texture_buffer_format(format) {
        return false;
    }
    true
}

/// `isCompressionSupportedForTarget`
fn is_compression_supported_for_target(target: GLenum) -> bool {
    target == glw::GL_TEXTURE_2D || target == glw::GL_TEXTURE_2D_ARRAY
}

/// `isMultisampleTarget`
fn is_multisample_target(target: GLenum) -> bool {
    target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
}

/// `targetSupportsMipLevels`
fn target_supports_mip_levels(target: GLenum) -> bool {
    target != glw::GL_TEXTURE_2D_MULTISAMPLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        && target != glw::GL_TEXTURE_BUFFER
}

/// `getPixelSize`
fn get_pixel_size(internal_format: GLenum) -> i32 {
    let fmt = map_gl_internal_format(internal_format).expect("every format in the table maps");
    #[expect(clippy::cast_possible_wrap, reason = "a pixel size is at most 32 bytes")]
    let size = fmt.pixel_size().expect("every mapped format has a pixel size") as i32;
    size
}

/// `generateColorTextureGenerationGroup`
fn generate_color_texture_generation_group(
    group: &mut Vec<TextureGenerationSpec>,
    target: GLenum,
    max_samples: i32,
    internal_format: GLenum,
) {
    let query_target = if target == glw::GL_TEXTURE_CUBE_MAP {
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
    } else {
        target
    };

    // initial
    group.push(TextureGenerationSpec {
        bind_target: target,
        query_target,
        immutable: true,
        sample_count: 0,
        description: format!("{}, initial values", texture_target_str(target)),
        ..Default::default()
    });

    // ms targets
    if is_multisample_target(target) {
        for (sample_count, fixed_sample_pos, size, description) in [
            (1, false, 16, "low sample count"),
            (max_samples, false, 32, "high sample count"),
            (max_samples, true, 32, "fixed sample positions"),
        ] {
            let level = TextureLevelSpec {
                width: size,
                height: size,
                depth: if texture_type_has_depth(target) { 6 } else { 1 },
                level: 0,
                internal_format,
                compressed: false,
            };

            group.push(TextureGenerationSpec {
                bind_target: target,
                query_target,
                immutable: true,
                sample_count,
                fixed_sample_pos,
                description: format!("{}, {description}", texture_target_str(target)),
                levels: vec![level],
                ..Default::default()
            });
        }
    } else if target == glw::GL_TEXTURE_BUFFER {
        let base_size = get_pixel_size(internal_format);

        // whole buffer
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: true,
            description: format!("{}, whole buffer", texture_target_str(target)),
            tex_buffer_data_offset: 0,
            tex_buffer_data_size: 32 * base_size + (base_size - 1),
            bind_whole_array: true,
            levels: vec![TextureLevelSpec {
                width: 32,
                height: 1,
                depth: 1,
                level: 0,
                internal_format,
                compressed: false,
            }],
            ..Default::default()
        });

        // partial buffer
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: true,
            description: format!("{}, partial buffer", texture_target_str(target)),
            tex_buffer_data_offset: 256,
            tex_buffer_data_size: 16 * base_size + (base_size - 1),
            bind_whole_array: false,
            levels: vec![TextureLevelSpec {
                width: 16,
                height: 1,
                depth: 1,
                level: 0,
                internal_format,
                compressed: false,
            }],
            ..Default::default()
        });
    } else {
        let cube = target == glw::GL_TEXTURE_CUBE_MAP || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;

        // immutable
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: true,
            description: format!("{}, immutable", texture_target_str(target)),
            levels: vec![TextureLevelSpec {
                width: 32,
                height: 32,
                depth: if texture_type_has_depth(target) { 6 } else { 1 },
                level: 0,
                internal_format,
                compressed: false,
            }],
            ..Default::default()
        });

        // mutable
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: false,
            description: format!("{}, mutable", texture_target_str(target)),
            levels: vec![TextureLevelSpec {
                width: 16,
                height: if cube { 16 } else { 64 },
                depth: if texture_type_has_depth(target) { 6 } else { 1 },
                level: 0,
                internal_format,
                compressed: false,
            }],
            ..Default::default()
        });

        // mip3
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: false,
            description: format!("{}, mip level 3", texture_target_str(target)),
            levels: vec![TextureLevelSpec {
                width: 4,
                height: if cube { 4 } else { 8 },
                depth: if texture_type_has_depth(target) { 6 } else { 1 },
                level: 3,
                internal_format,
                compressed: false,
            }],
            ..Default::default()
        });
    }
}

/// `internalFormats`
const INTERNAL_FORMATS: [GLenum; 54] = [
    glw::GL_R8,
    glw::GL_R8_SNORM,
    glw::GL_RG8,
    glw::GL_RG8_SNORM,
    glw::GL_RGB8,
    glw::GL_RGB8_SNORM,
    glw::GL_RGB565,
    glw::GL_RGBA4,
    glw::GL_RGB5_A1,
    glw::GL_RGBA8,
    glw::GL_RGBA8_SNORM,
    glw::GL_RGB10_A2,
    glw::GL_RGB10_A2UI,
    glw::GL_SRGB8,
    glw::GL_SRGB8_ALPHA8,
    glw::GL_R16F,
    glw::GL_RG16F,
    glw::GL_RGB16F,
    glw::GL_RGBA16F,
    glw::GL_R32F,
    glw::GL_RG32F,
    glw::GL_RGB32F,
    glw::GL_RGBA32F,
    glw::GL_R11F_G11F_B10F,
    glw::GL_RGB9_E5,
    glw::GL_R8I,
    glw::GL_R8UI,
    glw::GL_R16I,
    glw::GL_R16UI,
    glw::GL_R32I,
    glw::GL_R32UI,
    glw::GL_RG8I,
    glw::GL_RG8UI,
    glw::GL_RG16I,
    glw::GL_RG16UI,
    glw::GL_RG32I,
    glw::GL_RG32UI,
    glw::GL_RGB8I,
    glw::GL_RGB8UI,
    glw::GL_RGB16I,
    glw::GL_RGB16UI,
    glw::GL_RGB32I,
    glw::GL_RGB32UI,
    glw::GL_RGBA8I,
    glw::GL_RGBA8UI,
    glw::GL_RGBA16I,
    glw::GL_RGBA16UI,
    glw::GL_RGBA32I,
    glw::GL_RGBA32UI,
    glw::GL_DEPTH_COMPONENT32F,
    glw::GL_DEPTH_COMPONENT24,
    glw::GL_DEPTH_COMPONENT16,
    glw::GL_DEPTH32F_STENCIL8,
    glw::GL_DEPTH24_STENCIL8,
];

/// `generateInternalFormatTextureGenerationGroup`
fn generate_internal_format_texture_generation_group(group: &mut Vec<TextureGenerationSpec>, target: GLenum) {
    let query_target = if target == glw::GL_TEXTURE_CUBE_MAP {
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
    } else {
        target
    };

    // initial
    group.push(TextureGenerationSpec {
        bind_target: target,
        query_target,
        immutable: true,
        sample_count: 0,
        fixed_sample_pos: true,
        description: format!("{}, initial values", texture_target_str(target)),
        ..Default::default()
    });

    // test all formats
    for internal_format in INTERNAL_FORMATS {
        if !is_legal_format_for_target(target, internal_format) {
            continue;
        }

        let base_size = get_pixel_size(internal_format);
        let mut tex_gen = TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: true,
            sample_count: if is_multisample_target(target) { 1 } else { 0 },
            description: format!(
                "{}, internal format {}",
                texture_target_str(target),
                texture_format_name(internal_format).unwrap_or("<unknown>")
            ),
            ..Default::default()
        };

        if target == glw::GL_TEXTURE_BUFFER {
            tex_gen.tex_buffer_data_offset = 0;
            tex_gen.tex_buffer_data_size = 32 * base_size + (base_size - 1);
            tex_gen.bind_whole_array = true;
        }

        tex_gen.levels.push(TextureLevelSpec {
            width: 32,
            height: if texture_type_has_height(target) { 32 } else { 1 },
            depth: if texture_type_has_depth(target) { 6 } else { 1 },
            level: 0,
            internal_format,
            compressed: false,
        });
        group.push(tex_gen);
    }

    // test mutable rgba8 with mip level 3
    if target_supports_mip_levels(target) {
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: false,
            description: format!("{}, internal format GL_RGBA8, mip level 3", texture_target_str(target)),
            levels: vec![TextureLevelSpec {
                width: 32,
                height: 32,
                depth: if texture_type_has_depth(target) { 6 } else { 1 },
                level: 3,
                internal_format: glw::GL_RGBA8,
                compressed: false,
            }],
            ..Default::default()
        });
    }
}

/// `generateCompressedTextureGenerationGroup`
fn generate_compressed_texture_generation_group(group: &mut Vec<TextureGenerationSpec>, target: GLenum) {
    let query_target = if target == glw::GL_TEXTURE_CUBE_MAP {
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
    } else {
        target
    };

    // initial
    group.push(TextureGenerationSpec {
        bind_target: target,
        query_target,
        immutable: true,
        description: format!("{}, initial values", texture_target_str(target)),
        ..Default::default()
    });

    // compressed
    if is_compression_supported_for_target(target) {
        group.push(TextureGenerationSpec {
            bind_target: target,
            query_target,
            immutable: false,
            description: format!("{}, compressed", texture_target_str(target)),
            levels: vec![TextureLevelSpec {
                width: 32,
                height: 32,
                depth: if target == glw::GL_TEXTURE_2D_ARRAY { 2 } else { 1 },
                level: 0,
                internal_format: glw::GL_COMPRESSED_RGB8_ETC2,
                compressed: true,
            }],
            ..Default::default()
        });
    }
}

/// `generateTextureBufferGenerationGroup`
fn generate_texture_buffer_generation_group(group: &mut Vec<TextureGenerationSpec>, target: GLenum) {
    let query_target = if target == glw::GL_TEXTURE_CUBE_MAP {
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
    } else {
        target
    };

    // initial
    group.push(TextureGenerationSpec {
        bind_target: target,
        query_target,
        immutable: true,
        sample_count: 0,
        description: format!("{}, initial values", texture_target_str(target)),
        ..Default::default()
    });

    // actual specification tests are in texture_buffer tests, no need to do them here too
}

/// `applyTextureGenerationSpec`
fn apply_texture_generation_spec(case: &mut ApiCase<'_>, spec: &TextureGenerationSpec, tex_buffer: &mut GLuint) {
    debug_assert!(
        !(spec.immutable && spec.levels.len() > 1),
        "immutable textures have only one level"
    );

    for level in &spec.levels {
        let transfer_format = if level.compressed {
            None
        } else {
            let fmt = map_gl_internal_format(level.internal_format).expect("every format in the table maps");
            Some(get_transfer_format(fmt).expect("every mapped format has a transfer format"))
        };

        // SAFETY: a texture of `spec.bind_target` is bound; every call below passes the
        // dimensions of the level being specified and a null pixel pointer.
        unsafe {
            let gl = case.gl();
            match (spec.immutable, level.compressed, spec.bind_target) {
                (true, false, glw::GL_TEXTURE_2D | glw::GL_TEXTURE_CUBE_MAP) => {
                    gl.tex_storage_2d(spec.bind_target, 1, level.internal_format, level.width, level.height);
                }
                (true, false, glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY) => {
                    gl.tex_storage_3d(
                        spec.bind_target,
                        1,
                        level.internal_format,
                        level.width,
                        level.height,
                        level.depth,
                    );
                }
                (true, false, glw::GL_TEXTURE_2D_MULTISAMPLE) => {
                    gl.tex_storage_2d_multisample(
                        spec.bind_target,
                        spec.sample_count,
                        level.internal_format,
                        level.width,
                        level.height,
                        if spec.fixed_sample_pos { glw::TRUE } else { glw::FALSE },
                    );
                }
                (true, false, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY) => {
                    gl.tex_storage_3d_multisample(
                        spec.bind_target,
                        spec.sample_count,
                        level.internal_format,
                        level.width,
                        level.height,
                        level.depth,
                        if spec.fixed_sample_pos { glw::TRUE } else { glw::FALSE },
                    );
                }
                (false, false, glw::GL_TEXTURE_2D | glw::GL_TEXTURE_CUBE_MAP) => {
                    let transfer = transfer_format.expect("an uncompressed level has a transfer format");
                    // a cube map's mutable levels are specified through the face, not the target
                    let target = if spec.bind_target == glw::GL_TEXTURE_CUBE_MAP {
                        spec.query_target
                    } else {
                        spec.bind_target
                    };
                    #[expect(clippy::cast_possible_wrap, reason = "an internal format enum fits in a GLint")]
                    let internal_format = level.internal_format as GLint;
                    gl.tex_image_2d(
                        target,
                        level.level,
                        internal_format,
                        level.width,
                        level.height,
                        0,
                        transfer.format,
                        transfer.data_type,
                        std::ptr::null(),
                    );
                }
                (false, false, glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY) => {
                    let transfer = transfer_format.expect("an uncompressed level has a transfer format");
                    #[expect(clippy::cast_possible_wrap, reason = "an internal format enum fits in a GLint")]
                    let internal_format = level.internal_format as GLint;
                    gl.tex_image_3d(
                        spec.bind_target,
                        level.level,
                        internal_format,
                        level.width,
                        level.height,
                        level.depth,
                        0,
                        transfer.format,
                        transfer.data_type,
                        std::ptr::null(),
                    );
                }
                (false, true, glw::GL_TEXTURE_2D) => {
                    debug_assert!(
                        level.width == 32
                            && level.height == 32
                            && level.internal_format == glw::GL_COMPRESSED_RGB8_ETC2
                    );

                    let buffer = [0u8; 64 * 8];
                    #[expect(clippy::cast_possible_wrap, reason = "a fixed 512-byte buffer")]
                    let size = buffer.len() as i32;
                    gl.compressed_tex_image_2d(
                        spec.bind_target,
                        level.level,
                        level.internal_format,
                        level.width,
                        level.height,
                        0,
                        size,
                        buffer.as_ptr().cast(),
                    );
                }
                (false, true, glw::GL_TEXTURE_2D_ARRAY) => {
                    debug_assert!(
                        level.width == 32
                            && level.height == 32
                            && level.depth == 2
                            && level.internal_format == glw::GL_COMPRESSED_RGB8_ETC2
                    );

                    let buffer = [0u8; 64 * 8 * 2];
                    #[expect(clippy::cast_possible_wrap, reason = "a fixed 1024-byte buffer")]
                    let size = buffer.len() as i32;
                    gl.compressed_tex_image_3d(
                        spec.bind_target,
                        level.level,
                        level.internal_format,
                        level.width,
                        level.height,
                        level.depth,
                        0,
                        size,
                        buffer.as_ptr().cast(),
                    );
                }
                (true, false, glw::GL_TEXTURE_BUFFER) => {
                    gl.gen_buffers(1, tex_buffer);
                    gl.bind_buffer(glw::GL_TEXTURE_BUFFER, *tex_buffer);

                    if spec.bind_whole_array {
                        gl.buffer_data(
                            glw::GL_TEXTURE_BUFFER,
                            isize::try_from(spec.tex_buffer_data_size).unwrap(),
                            std::ptr::null(),
                            glw::GL_STATIC_DRAW,
                        );
                        gl.tex_buffer(glw::GL_TEXTURE_BUFFER, level.internal_format, *tex_buffer);
                    } else {
                        gl.buffer_data(
                            glw::GL_TEXTURE_BUFFER,
                            isize::try_from(spec.tex_buffer_data_offset + spec.tex_buffer_data_size).unwrap(),
                            std::ptr::null(),
                            glw::GL_STATIC_DRAW,
                        );
                        gl.tex_buffer_range(
                            glw::GL_TEXTURE_BUFFER,
                            level.internal_format,
                            *tex_buffer,
                            isize::try_from(spec.tex_buffer_data_offset).unwrap(),
                            isize::try_from(spec.tex_buffer_data_size).unwrap(),
                        );
                    }
                }
                (immutable, compressed, bind_target) => panic!(
                    "no specification path for immutable={immutable}, compressed={compressed}, target={bind_target:#x}"
                ),
            }
        }

        // SAFETY: glGetError needs only a current context.
        let err = unsafe { case.gl().get_error() };
        if err != glw::GL_NO_ERROR {
            log::debug!("Texture specification failed, got {}", glw::error_name(err));
        }
    }
}

/// The twelve `TextureLevel*Case` subclasses. `Size`/`Type` carry the pname their
/// upstream class takes as a constructor argument.
#[derive(Clone, Copy, PartialEq, Eq)]
enum LevelCase {
    /// `TextureLevelSampleCase`
    Samples,
    /// `TextureLevelFixedSamplesCase`
    FixedSamples,
    /// `TextureLevelWidthCase`
    Width,
    /// `TextureLevelHeightCase`
    Height,
    /// `TextureLevelDepthCase`
    Depth,
    /// `TextureLevelInternalFormatCase`
    InternalFormat,
    /// `TextureLevelSizeCase`
    Size(GLenum),
    /// `TextureLevelTypeCase`
    Type(GLenum),
    /// `TextureLevelCompressedCase`
    Compressed,
    /// `TextureLevelBufferDataStoreCase`
    BufferDataStore,
    /// `TextureLevelBufferDataOffsetCase`
    BufferDataOffset,
    /// `TextureLevelBufferDataSizeCase`
    BufferDataSize,
}

impl LevelCase {
    /// The three buffer cases override `init` with an extra `checkSupport`.
    fn needs_texture_buffer_support(self) -> bool {
        matches!(
            self,
            Self::BufferDataStore | Self::BufferDataOffset | Self::BufferDataSize
        )
    }

    /// `generateTestIterations`
    fn generate_test_iterations(self, case: &mut ApiCase<'_>, target: GLenum) -> Vec<TextureGenerationSpec> {
        let mut iterations = Vec::new();
        match self {
            // TextureLevelCommonCase::generateTestIterations
            Self::Samples | Self::FixedSamples | Self::Width | Self::Height | Self::Depth => {
                let internal_format = glw::GL_RGBA8;
                let samples = get_format_samples(case, target, internal_format);
                let max_samples = if samples.is_empty() { -1 } else { samples[0] };

                generate_color_texture_generation_group(&mut iterations, target, max_samples, internal_format);
            }
            Self::InternalFormat | Self::Size(_) | Self::Type(_) => {
                generate_internal_format_texture_generation_group(&mut iterations, target)
            }
            Self::Compressed => generate_compressed_texture_generation_group(&mut iterations, target),
            Self::BufferDataStore | Self::BufferDataOffset | Self::BufferDataSize => {
                generate_texture_buffer_generation_group(&mut iterations, target)
            }
        }
        iterations
    }

    /// `checkTextureState`
    fn check_texture_state(
        self,
        case: &mut ApiCase<'_>,
        spec: &TextureGenerationSpec,
        tex_buffer: GLuint,
        query_type: QueryType,
    ) -> bool {
        match self {
            Self::Samples => {
                let query_level = spec.levels.first().map_or(0, |level| level.level);
                let ref_value = if spec.levels.is_empty() { 0 } else { spec.sample_count };

                verify_texture_level_parameter_greater_or_equal(
                    case,
                    spec.query_target,
                    query_level,
                    glw::GL_TEXTURE_SAMPLES,
                    ref_value,
                    query_type,
                )
            }
            Self::FixedSamples => {
                let query_level = spec.levels.first().map_or(0, |level| level.level);
                // upstream: `(spec.levels.empty()) ? (1) : ((spec.fixedSamplePos) ? (1) : (0))`
                let ref_value = i32::from(spec.levels.is_empty() || spec.fixed_sample_pos);

                verify_texture_level_parameter_equal(
                    case,
                    spec.query_target,
                    query_level,
                    glw::GL_TEXTURE_FIXED_SAMPLE_LOCATIONS,
                    ref_value,
                    query_type,
                )
            }
            Self::Width => check_per_level(case, spec, query_type, glw::GL_TEXTURE_WIDTH, |level| level.width),
            Self::Height => check_per_level(case, spec, query_type, glw::GL_TEXTURE_HEIGHT, |level| level.height),
            Self::Depth => check_per_level(case, spec, query_type, glw::GL_TEXTURE_DEPTH, |level| level.depth),
            Self::InternalFormat => {
                if spec.levels.is_empty() {
                    #[expect(clippy::cast_possible_wrap, reason = "upstream's initialValues array is int")]
                    let initial_values = [glw::GL_RGBA as i32, glw::GL_R8 as i32];

                    verify_texture_level_parameter_internal_format_any_of(
                        case,
                        spec.query_target,
                        0,
                        glw::GL_TEXTURE_INTERNAL_FORMAT,
                        &initial_values,
                        query_type,
                    )
                } else {
                    let mut all_ok = true;
                    for level in &spec.levels {
                        #[expect(clippy::cast_possible_wrap, reason = "an internal format enum fits in a GLint")]
                        let ref_value = level.internal_format as i32;

                        all_ok &= verify_texture_level_parameter_internal_format_equal(
                            case,
                            spec.query_target,
                            level.level,
                            glw::GL_TEXTURE_INTERNAL_FORMAT,
                            ref_value,
                            query_type,
                        );
                    }
                    all_ok
                }
            }
            Self::Size(pname) => {
                if spec.levels.is_empty() {
                    verify_texture_level_parameter_equal(case, spec.query_target, 0, pname, 0, query_type)
                } else {
                    let mut all_ok = true;
                    for level in &spec.levels {
                        let ref_value = minimum_component_resolution(pname, level.internal_format);
                        all_ok &= verify_texture_level_parameter_greater_or_equal(
                            case,
                            spec.query_target,
                            level.level,
                            pname,
                            ref_value,
                            query_type,
                        );
                    }
                    all_ok
                }
            }
            Self::Type(pname) => {
                if spec.levels.is_empty() {
                    #[expect(clippy::cast_possible_wrap, reason = "GL_NONE is 0")]
                    let none = glw::GL_NONE as i32;
                    verify_texture_level_parameter_equal(case, spec.query_target, 0, pname, none, query_type)
                } else {
                    let mut all_ok = true;
                    for level in &spec.levels {
                        let ref_value = component_type(pname, level.internal_format);
                        all_ok &= verify_texture_level_parameter_equal(
                            case,
                            spec.query_target,
                            level.level,
                            pname,
                            ref_value,
                            query_type,
                        );
                    }
                    all_ok
                }
            }
            Self::Compressed => check_per_level(case, spec, query_type, glw::GL_TEXTURE_COMPRESSED, |level| {
                i32::from(level.compressed)
            }),
            Self::BufferDataStore => {
                #[expect(
                    clippy::cast_possible_wrap,
                    reason = "upstream passes m_texBuffer straight into an int reference"
                )]
                let ref_value = if spec.levels.is_empty() { 0 } else { tex_buffer as i32 };

                verify_texture_level_parameter_equal(
                    case,
                    spec.query_target,
                    0,
                    glw::GL_TEXTURE_BUFFER_DATA_STORE_BINDING,
                    ref_value,
                    query_type,
                )
            }
            Self::BufferDataOffset => {
                let ref_value = if spec.levels.is_empty() {
                    0
                } else {
                    spec.tex_buffer_data_offset
                };

                verify_texture_level_parameter_equal(
                    case,
                    spec.query_target,
                    0,
                    glw::GL_TEXTURE_BUFFER_OFFSET,
                    ref_value,
                    query_type,
                )
            }
            Self::BufferDataSize => {
                let ref_value = if spec.levels.is_empty() {
                    0
                } else {
                    spec.tex_buffer_data_size
                };

                verify_texture_level_parameter_equal(
                    case,
                    spec.query_target,
                    0,
                    glw::GL_TEXTURE_BUFFER_SIZE,
                    ref_value,
                    query_type,
                )
            }
        }
    }
}

/// The `if (spec.levels.empty()) <initial value> else <one check per level>` shape
/// `TextureLevelWidthCase`, `...HeightCase`, `...DepthCase` and `...CompressedCase`
/// all repeat verbatim, with 0 as the initial value.
fn check_per_level(
    case: &mut ApiCase<'_>,
    spec: &TextureGenerationSpec,
    query_type: QueryType,
    pname: GLenum,
    of_level: fn(&TextureLevelSpec) -> i32,
) -> bool {
    const INITIAL_VALUE: i32 = 0;
    let mut all_ok = true;

    if spec.levels.is_empty() {
        all_ok &= verify_texture_level_parameter_equal(case, spec.query_target, 0, pname, INITIAL_VALUE, query_type);
    } else {
        for level in &spec.levels {
            all_ok &= verify_texture_level_parameter_equal(
                case,
                spec.query_target,
                level.level,
                pname,
                of_level(level),
                query_type,
            );
        }
    }

    all_ok
}

/// `TextureLevelSizeCase::getMinimumComponentResolution`
fn minimum_component_resolution(pname: GLenum, internal_format: GLenum) -> i32 {
    let format = map_gl_internal_format(internal_format).expect("every format in the table maps");
    let channel_bit_depth = get_texture_format_bit_depth(format);

    match pname {
        glw::GL_TEXTURE_RED_SIZE => {
            if matches!(
                format.order,
                ChannelOrder::R
                    | ChannelOrder::RG
                    | ChannelOrder::RGB
                    | ChannelOrder::RGBA
                    | ChannelOrder::BGRA
                    | ChannelOrder::ARGB
                    | ChannelOrder::sRGB
                    | ChannelOrder::sRGBA
            ) {
                channel_bit_depth[0]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_GREEN_SIZE => {
            if matches!(
                format.order,
                ChannelOrder::RG
                    | ChannelOrder::RGB
                    | ChannelOrder::RGBA
                    | ChannelOrder::BGRA
                    | ChannelOrder::ARGB
                    | ChannelOrder::sRGB
                    | ChannelOrder::sRGBA
            ) {
                channel_bit_depth[1]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_BLUE_SIZE => {
            if matches!(
                format.order,
                ChannelOrder::RGB
                    | ChannelOrder::RGBA
                    | ChannelOrder::BGRA
                    | ChannelOrder::ARGB
                    | ChannelOrder::sRGB
                    | ChannelOrder::sRGBA
            ) {
                channel_bit_depth[2]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_ALPHA_SIZE => {
            if matches!(
                format.order,
                ChannelOrder::RGBA | ChannelOrder::BGRA | ChannelOrder::ARGB | ChannelOrder::sRGBA
            ) {
                channel_bit_depth[3]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_DEPTH_SIZE => {
            if matches!(format.order, ChannelOrder::D | ChannelOrder::DS) {
                channel_bit_depth[0]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_STENCIL_SIZE => {
            if format.order == ChannelOrder::DS {
                channel_bit_depth[3]
            } else {
                0
            }
        }
        glw::GL_TEXTURE_SHARED_SIZE => {
            if internal_format == glw::GL_RGB9_E5 {
                5
            } else {
                0
            }
        }
        other => panic!("{other:#x} is not a size pname"),
    }
}

/// `TextureLevelTypeCase::getComponentType`
fn component_type(pname: GLenum, internal_format: GLenum) -> i32 {
    #[expect(clippy::cast_possible_wrap, reason = "these enums all fit in a GLint")]
    fn as_int(value: GLenum) -> i32 {
        value as i32
    }

    let format = map_gl_internal_format(internal_format).expect("every format in the table maps");
    let channel_class = format.type_.channel_class();

    // depth-stencil special cases
    if format.type_ == ChannelType::UNSIGNED_INT_24_8 {
        return if pname == glw::GL_TEXTURE_DEPTH_TYPE {
            as_int(glw::GL_UNSIGNED_NORMALIZED)
        } else {
            as_int(glw::GL_NONE)
        };
    } else if format.type_ == ChannelType::FLOAT_UNSIGNED_INT_24_8_REV {
        return if pname == glw::GL_TEXTURE_DEPTH_TYPE {
            as_int(glw::GL_FLOAT)
        } else {
            as_int(glw::GL_NONE)
        };
    }

    let channel_type = match channel_class {
        TextureChannelClass::SignedFixedPoint => glw::GL_SIGNED_NORMALIZED,
        TextureChannelClass::UnsignedFixedPoint => glw::GL_UNSIGNED_NORMALIZED,
        TextureChannelClass::SignedInteger => glw::GL_INT,
        TextureChannelClass::UnsignedInteger => glw::GL_UNSIGNED_INT,
        TextureChannelClass::FloatingPoint => glw::GL_FLOAT,
        TextureChannelClass::Last => panic!("{internal_format:#x} has no channel class"),
    };

    let has_channel = match pname {
        glw::GL_TEXTURE_RED_TYPE => matches!(
            format.order,
            ChannelOrder::R
                | ChannelOrder::RG
                | ChannelOrder::RGB
                | ChannelOrder::RGBA
                | ChannelOrder::BGRA
                | ChannelOrder::ARGB
                | ChannelOrder::sRGB
                | ChannelOrder::sRGBA
        ),
        glw::GL_TEXTURE_GREEN_TYPE => matches!(
            format.order,
            ChannelOrder::RG
                | ChannelOrder::RGB
                | ChannelOrder::RGBA
                | ChannelOrder::BGRA
                | ChannelOrder::ARGB
                | ChannelOrder::sRGB
                | ChannelOrder::sRGBA
        ),
        glw::GL_TEXTURE_BLUE_TYPE => matches!(
            format.order,
            ChannelOrder::RGB
                | ChannelOrder::RGBA
                | ChannelOrder::BGRA
                | ChannelOrder::ARGB
                | ChannelOrder::sRGB
                | ChannelOrder::sRGBA
        ),
        glw::GL_TEXTURE_ALPHA_TYPE => matches!(
            format.order,
            ChannelOrder::RGBA | ChannelOrder::BGRA | ChannelOrder::ARGB | ChannelOrder::sRGBA
        ),
        glw::GL_TEXTURE_DEPTH_TYPE => matches!(format.order, ChannelOrder::D | ChannelOrder::DS),
        other => panic!("{other:#x} is not a type pname"),
    };

    if has_channel {
        as_int(channel_type)
    } else {
        as_int(glw::GL_NONE)
    }
}

/// `TextureLevelCase::getFormatSamples`
fn get_format_samples(case: &mut ApiCase<'_>, target: GLenum, internal_format: GLenum) -> Vec<i32> {
    if !is_multisample_target(target) {
        return Vec::new();
    }

    let mut sample_count: i32 = -1;
    // SAFETY: one output, and `GL_NUM_SAMPLE_COUNTS` writes exactly one integer.
    unsafe {
        case.gl().get_internalformativ(
            target,
            internal_format,
            glw::GL_NUM_SAMPLE_COUNTS,
            1,
            &raw mut sample_count,
        )
    };

    if sample_count < 0 {
        case.fail(
            "internal format query failed".to_string(),
            "internal format query failed",
        );
        return Vec::new();
    }

    let mut samples = vec![0i32; usize::try_from(sample_count).unwrap()];
    if sample_count > 0 {
        // SAFETY: the array is sized from what the count query answered.
        unsafe {
            case.gl().get_internalformativ(
                target,
                internal_format,
                glw::GL_SAMPLES,
                sample_count,
                samples.as_mut_ptr(),
            )
        };
        case.expect_no_error("get max samples");
    }
    samples
}

/// `TextureLevelCase::testConfig`
fn test_config(
    case: &mut ApiCase<'_>,
    level_case: LevelCase,
    spec: &TextureGenerationSpec,
    tex_buffer: &mut GLuint,
    query_type: QueryType,
) -> bool {
    case.section(&format!("Iteration - {}", spec.description));

    let mut texture: GLuint = 0;
    // SAFETY: one name in, one name out, deleted below.
    unsafe {
        case.gl().gen_textures(1, &raw mut texture);
        case.gl().bind_texture(spec.bind_target, texture);
    }
    case.expect_no_error("gen tex");

    // Set the state
    apply_texture_generation_spec(case, spec, tex_buffer);

    // Verify the state
    let result = level_case.check_texture_state(case, spec, *tex_buffer, query_type);

    // SAFETY: names this function and `apply_texture_generation_spec` created.
    unsafe {
        case.gl().delete_textures(1, &raw const texture);
        if *tex_buffer != 0 {
            case.gl().delete_buffers(1, &raw const *tex_buffer);
            // upstream clears `m_texture` here rather than `m_texBuffer`, so the name
            // stays set; the only case that reads it back has no levels, so it never
            // compares against a stale one.
        }
    }

    result
}

/// `TextureLevelCase::init` + `iterate`
fn run_texture_level_case(case: &mut ApiCase<'_>, level_case: LevelCase, target: GLenum, query_type: QueryType) {
    if level_case.needs_texture_buffer_support() && !check_texture_buffer_support(case) {
        case.not_supported("Test requires GL_EXT_texture_buffer extension");
        return;
    }

    if !is_core_texture_target(target, case.context().context_type()) {
        let target_extension = texture_target_extension(target);

        if !case.context().context_info.is_extension_supported(target_extension) {
            case.not_supported(format!("Test requires {target_extension} extension"));
            return;
        }
    }

    let iterations = level_case.generate_test_iterations(case, target);
    let mut tex_buffer: GLuint = 0;
    let mut failed_iterations = Vec::new();

    for (index, spec) in iterations.iter().enumerate() {
        debug_assert_eq!(spec.bind_target, target);

        if !test_config(case, level_case, spec, &mut tex_buffer, query_type) {
            failed_iterations.push(index + 1);
        }
    }

    if !failed_iterations.is_empty() {
        let list: Vec<String> = failed_iterations.iter().map(ToString::to_string).collect();
        case.fail(
            format!("Following iteration(s) failed: {}", list.join(", ")),
            "One or more iterations failed",
        );
    }
}

/// `checkSupport` - the three buffer cases' own gate, on top of the target's.
fn check_texture_buffer_support(case: &ApiCase<'_>) -> bool {
    case.context().context_type().supports(3, 2)
        || case
            .context()
            .context_info
            .is_extension_supported("GL_EXT_texture_buffer")
}

/// `getVerifierSuffix`
fn verifier_suffix(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::TextureLevelFloat => "_float",
        QueryType::TextureLevelInteger => "_integer",
        other => panic!("{other:?} is not a texture-level verifier"),
    }
}

/// `verifiers`
const VERIFIERS: [QueryType; 2] = [QueryType::TextureLevelInteger, QueryType::TextureLevelFloat];

/// `textureTargets`
const TEXTURE_TARGETS: [(&str, GLenum); 8] = [
    ("texture_2d", glw::GL_TEXTURE_2D),
    ("texture_3d", glw::GL_TEXTURE_3D),
    ("texture_2d_array", glw::GL_TEXTURE_2D_ARRAY),
    ("texture_cube_map", glw::GL_TEXTURE_CUBE_MAP),
    ("texture_2d_multisample", glw::GL_TEXTURE_2D_MULTISAMPLE),
    // GL_OES_texture_storage_multisample_2d_array
    ("texture_2d_multisample_array", glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY),
    // GL_EXT_texture_buffer
    ("texture_buffer", glw::GL_TEXTURE_BUFFER),
    // GL_EXT_texture_cube_map_array
    ("texture_cube_array", glw::GL_TEXTURE_CUBE_MAP_ARRAY),
];

/// The `FOR_EACH_VERIFIER` block, in upstream's registration order.
const STATES: [(&str, LevelCase); 22] = [
    ("samples", LevelCase::Samples),
    ("fixed_sample_locations", LevelCase::FixedSamples),
    ("width", LevelCase::Width),
    ("height", LevelCase::Height),
    ("depth", LevelCase::Depth),
    ("internal_format", LevelCase::InternalFormat),
    ("red_size", LevelCase::Size(glw::GL_TEXTURE_RED_SIZE)),
    ("green_size", LevelCase::Size(glw::GL_TEXTURE_GREEN_SIZE)),
    ("blue_size", LevelCase::Size(glw::GL_TEXTURE_BLUE_SIZE)),
    ("alpha_size", LevelCase::Size(glw::GL_TEXTURE_ALPHA_SIZE)),
    ("depth_size", LevelCase::Size(glw::GL_TEXTURE_DEPTH_SIZE)),
    ("stencil_size", LevelCase::Size(glw::GL_TEXTURE_STENCIL_SIZE)),
    ("shared_size", LevelCase::Size(glw::GL_TEXTURE_SHARED_SIZE)),
    ("red_type", LevelCase::Type(glw::GL_TEXTURE_RED_TYPE)),
    ("green_type", LevelCase::Type(glw::GL_TEXTURE_GREEN_TYPE)),
    ("blue_type", LevelCase::Type(glw::GL_TEXTURE_BLUE_TYPE)),
    ("alpha_type", LevelCase::Type(glw::GL_TEXTURE_ALPHA_TYPE)),
    ("depth_type", LevelCase::Type(glw::GL_TEXTURE_DEPTH_TYPE)),
    ("compressed", LevelCase::Compressed),
    ("buffer_data_store_binding", LevelCase::BufferDataStore),
    ("buffer_offset", LevelCase::BufferDataOffset),
    ("buffer_size", LevelCase::BufferDataSize),
];

/// `TextureLevelStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_level");

    for (target_name, target) in TEXTURE_TARGETS {
        let mut target_group = TestCaseGroup::new(target_name);

        for (state_name, level_case) in STATES {
            for verifier in VERIFIERS {
                add_api_case(
                    &mut target_group,
                    format!("{state_name}{}", verifier_suffix(verifier)),
                    move |case: &mut ApiCase<'_>| {
                        run_texture_level_case(case, level_case, target, verifier);
                    },
                );
            }
        }

        group.add_child(target_group);
    }

    group
}
