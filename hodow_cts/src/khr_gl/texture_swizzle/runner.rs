// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTextureSwizzleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts; see `mod.rs`. Upstream's `isInRange` quirks are kept: the half-float output is compared as a signed byte and the unsigned-int output as an unsigned short.

use super::{OutChDesc, TEXTURE_ACCESS, TEXTURE_TARGETS, TextureFormat, VALID_VALUES};
use crate::generated::khr_texture_swizzle_tables::TEXTURE_FORMATS;
use crate::glu::{self, Context, ProgramSources, ShaderProgram};
use crate::glw::{self, GLenum};
use crate::tcu::float::Float16;
use crate::tcu::{TestError, TestOutcome, TestStatus};

const WIDTH: i32 = 1;
const HEIGHT: i32 = 1;
const DEPTH: i32 = 1;
const OUTPUT_WIDTH: i32 = 8;
const OUTPUT_HEIGHT: i32 = 8;

const CHANNELS: [&str; 4] = ["r", "g", "b", "a"];

/// Enumerations of cube map faces
const CUBE_MAP_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

const CHANNEL_INDEX_ONE: usize = 4;
const CHANNEL_INDEX_ZERO: usize = 5;

/// `testCase`
#[derive(Clone, Copy)]
struct TestCaseDesc {
    channel_index: usize,
    source_texture_format_index: usize,
    source_texture_target_index: usize,
    texture_access_index: usize,
    texture_swizzle: [i32; 4],
    texture_sizes: [i32; 4],
}

fn fail<T>(message: &str) -> Result<T> {
    Err(TestError::Fail(message.to_string()))
}

/// `get_swizzled_channel_idx` - the index of the channel that will be accessed after "swizzle" is applied.
fn get_swizzled_channel_idx(channel_idx: usize, swizzle_set: &[i32; 4]) -> Result<usize> {
    match swizzle_set[channel_idx] as GLenum {
        glw::GL_RED => Ok(0),
        glw::GL_GREEN => Ok(1),
        glw::GL_BLUE => Ok(2),
        glw::GL_ALPHA => Ok(3),
        glw::GL_ONE => Ok(CHANNEL_INDEX_ONE),
        glw::GL_ZERO => Ok(CHANNEL_INDEX_ZERO),
        _ => fail("Invalid value"),
    }
}

/// `get_descriptor_for_channel` - the descriptor of an output channel from the texture format descriptor.
fn get_descriptor_for_channel(format: &TextureFormat, channel: usize) -> Result<OutChDesc> {
    let desc = match channel {
        CHANNEL_INDEX_ONE => format.one_ch,
        CHANNEL_INDEX_ZERO => format.zero_ch,
        0 => format.red_ch,
        1 => format.green_ch,
        2 => format.blue_ch,
        3 => format.alpha_ch,
        _ => return fail("Invalid value"),
    };

    Ok(match desc.internal_format {
        glw::GL_ONE => format.one_ch,
        glw::GL_ZERO => format.zero_ch,
        _ => desc,
    })
}

/// `get_internal_format_for_channel`
fn get_internal_format_for_channel(format: &TextureFormat, channel: usize) -> Result<GLenum> {
    Ok(get_descriptor_for_channel(format, channel)?.internal_format)
}

/// `get_index_of_format`
fn get_index_of_format(internal_format: GLenum) -> Result<usize> {
    if glw::GL_ZERO == internal_format {
        return Ok(0);
    }
    TEXTURE_FORMATS
        .iter()
        .position(|format| format.internal_format == internal_format)
        .map_or_else(|| fail("Unknown internal format"), Ok)
}

fn read_u16(bytes: &[u8]) -> u16 {
    u16::from_ne_bytes([bytes[0], bytes[1]])
}

fn read_u32(bytes: &[u8]) -> u32 {
    u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]])
}

/// `calculate_values_from_source`
fn calculate_values_from_source(format_idx: usize) -> Result<[f64; 4]> {
    let format = &TEXTURE_FORMATS[format_idx];
    let mut ch_rgba = [0.0f64; 4];
    let data = format.source_data;

    let (n_channels, is_norm) = match format.format {
        glw::GL_RED_INTEGER => (1, false),
        glw::GL_RED => (1, true),
        glw::GL_RG_INTEGER => (2, false),
        glw::GL_RG => (2, true),
        glw::GL_RGB_INTEGER => (3, false),
        glw::GL_RGB => (3, true),
        glw::GL_RGBA_INTEGER => (4, false),
        glw::GL_RGBA => (4, true),
        _ => return fail("Unsupported format"),
    };

    if glw::GL_SRGB8 == format.internal_format || glw::GL_SRGB8_ALPHA8 == format.internal_format {
        let src_data_srgb8_alpha8 = [64u8, 8, 255, 32];
        for (channel, value) in src_data_srgb8_alpha8.iter().enumerate() {
            ch_rgba[channel] = f64::from(*value) / 255.0;
        }
    } else if glw::GL_UNSIGNED_BYTE_3_3_2 == format.type_ {
        let v = data[0];
        ch_rgba[0] = f64::from(v >> 5) / 7.0;
        ch_rgba[1] = f64::from((v >> 2) & 7) / 7.0;
        ch_rgba[2] = f64::from(v & 3) / 3.0;
    } else if glw::GL_UNSIGNED_SHORT_5_6_5 == format.type_ {
        let v = read_u16(data);
        ch_rgba[0] = f64::from((v >> 11) as u8) / 31.0;
        ch_rgba[1] = f64::from(((v >> 5) as u8) & 63) / 63.0;
        ch_rgba[2] = f64::from(v & 31) / 31.0;
    } else if glw::GL_UNSIGNED_SHORT_4_4_4_4 == format.type_ {
        let v = read_u16(data);
        ch_rgba[0] = f64::from((v >> 12) as u8) / 15.0;
        ch_rgba[1] = f64::from(((v >> 8) & 15) as u8) / 15.0;
        ch_rgba[2] = f64::from(((v >> 4) & 15) as u8) / 15.0;
        ch_rgba[3] = f64::from((v & 15) as u8) / 15.0;
    } else if glw::GL_UNSIGNED_SHORT_5_5_5_1 == format.type_ {
        let v = read_u16(data);
        ch_rgba[0] = f64::from((v >> 11) as u8) / 31.0;
        ch_rgba[1] = f64::from(((v >> 6) & 31) as u8) / 31.0;
        ch_rgba[2] = f64::from(((v >> 1) & 31) as u8) / 31.0;
        ch_rgba[3] = f64::from((v & 1) as u8) / 1.0;
    } else if glw::GL_UNSIGNED_INT_10_10_10_2 == format.type_ {
        let v = read_u32(data);
        ch_rgba[0] = f64::from((v >> 22) as u16);
        ch_rgba[1] = f64::from(((v >> 12) & 1023) as u16);
        ch_rgba[2] = f64::from(((v >> 2) & 1023) as u16);
        ch_rgba[3] = f64::from((v & 3) as u16);
        if is_norm {
            ch_rgba[0] /= 1023.0;
            ch_rgba[1] /= 1023.0;
            ch_rgba[2] /= 1023.0;
            ch_rgba[3] /= 3.0;
        }
    } else if glw::GL_UNSIGNED_INT_10F_11F_11F_REV == format.type_ {
        // r11f, g11f and b10f of the C++: 0.5, 0.75 and 0.25, all exact
        ch_rgba[0] = 0.5;
        ch_rgba[1] = 0.75;
        ch_rgba[2] = 0.25;
    } else if glw::GL_UNSIGNED_INT_5_9_9_9_REV == format.type_ {
        return fail("Not supported: GL_UNSIGNED_INT_5_9_9_9_REV");
    } else if glw::GL_UNSIGNED_INT_24_8 == format.type_ {
        return fail("Not supported: GL_UNSIGNED_INT_24_8");
    } else if glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV == format.type_ {
        return fail("Not supported: GL_FLOAT_32_UNSIGNED_INT_24_8_REV");
    } else if glw::GL_BYTE == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(data[i] as i8);
            if is_norm {
                ch_rgba[i] /= 127.0;
            }
        }
    } else if glw::GL_UNSIGNED_BYTE == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(data[i]);
            if is_norm {
                ch_rgba[i] /= 255.0;
            }
        }
    } else if glw::GL_SHORT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(read_u16(&data[i * 2..]) as i16);
            if is_norm {
                ch_rgba[i] /= 32767.0;
            }
        }
    } else if glw::GL_UNSIGNED_SHORT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(read_u16(&data[i * 2..]));
            if is_norm {
                ch_rgba[i] /= 65535.0;
            }
        }
    } else if glw::GL_INT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(read_u32(&data[i * 4..]) as i32);
            if is_norm {
                ch_rgba[i] /= 2_147_483_647.0;
            }
        }
    } else if glw::GL_UNSIGNED_INT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(read_u32(&data[i * 4..]));
            if is_norm {
                ch_rgba[i] /= 4_294_967_295.0;
            }
        }
    } else if glw::GL_FLOAT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(f32::from_bits(read_u32(&data[i * 4..])));
        }
    } else if glw::GL_HALF_FLOAT == format.type_ {
        for i in 0..n_channels {
            ch_rgba[i] = f64::from(Float16::from_bits(read_u16(&data[i * 2..])).as_float());
        }
    } else {
        return fail("Invalid enum");
    }

    Ok(ch_rgba)
}

type Result<T> = std::result::Result<T, TestError>;

/// `calculate_max_for_size`
fn calculate_max_for_size(size: i32) -> f64 {
    2.0f64.powi(size) - 1.0
}

/// `convert<T>` - writes `value` as a `T` at the start of `out`.
fn convert(output_type: GLenum, out: &mut [u8; 8], value: f64) -> Result<()> {
    match output_type {
        glw::GL_BYTE => out[..1].copy_from_slice(&(value as i8).to_ne_bytes()),
        glw::GL_UNSIGNED_BYTE => out[..1].copy_from_slice(&(value as u8).to_ne_bytes()),
        glw::GL_SHORT => out[..2].copy_from_slice(&(value as i16).to_ne_bytes()),
        glw::GL_UNSIGNED_SHORT => out[..2].copy_from_slice(&(value as u16).to_ne_bytes()),
        glw::GL_INT => out[..4].copy_from_slice(&(value as i32).to_ne_bytes()),
        glw::GL_UNSIGNED_INT => out[..4].copy_from_slice(&(value as u32).to_ne_bytes()),
        _ => return fail("Invalid enum"),
    }
    Ok(())
}

/// `calculate_expected_value` - the low and top bound of the expected output value, and the size of one texel of the output format.
fn calculate_expected_value(
    source_format_idx: usize,
    output_format_idx: usize,
    index_of_swizzled_channel: usize,
    mut source_size: i32,
    mut output_size: i32,
) -> Result<([u8; 8], [u8; 8], usize)> {
    let output_format = &TEXTURE_FORMATS[output_format_idx];
    let source_format = &TEXTURE_FORMATS[source_format_idx];
    let desc = get_descriptor_for_channel(source_format, index_of_swizzled_channel)?;

    let mut is_signed = false;
    let mut range_low = 0.0f64;
    let mut range_top = 0.0f64;
    let texel_size;

    match output_format.type_ {
        glw::GL_BYTE => {
            is_signed = true;
            range_low = -127.0;
            range_top = 127.0;
            texel_size = 1;
        }
        glw::GL_UNSIGNED_BYTE => {
            range_low = 0.0;
            range_top = 255.0;
            texel_size = 1;
        }
        glw::GL_SHORT => {
            is_signed = true;
            range_low = -32767.0;
            range_top = 32767.0;
            texel_size = 2;
        }
        glw::GL_UNSIGNED_SHORT => {
            range_low = 0.0;
            range_top = 65535.0;
            texel_size = 2;
        }
        glw::GL_HALF_FLOAT => texel_size = 2,
        glw::GL_INT => {
            is_signed = true;
            range_low = -2_147_483_647.0;
            range_top = 2_147_483_647.0;
            texel_size = 4;
        }
        glw::GL_UNSIGNED_INT => {
            range_low = 0.0;
            range_top = 4_294_967_295.0;
            texel_size = 4;
        }
        glw::GL_FLOAT => texel_size = 4,
        _ => return fail("Invalid enum"),
    }

    if is_signed {
        source_size -= 1;
        output_size -= 1;
    }

    let mut out_low = [0u8; 8];
    let mut out_top = [0u8; 8];

    if let Some(expected_data) = desc.expected_data {
        out_top[..texel_size].copy_from_slice(&expected_data[..texel_size]);
        out_low[..texel_size].copy_from_slice(&expected_data[..texel_size]);
    } else {
        let ch_rgba = calculate_values_from_source(source_format_idx)?;

        let max_internal = calculate_max_for_size(source_size) as f32;
        let max_output = calculate_max_for_size(output_size) as f32;

        let temp_internal = ch_rgba[index_of_swizzled_channel] as f32 * max_internal;
        // Offset by 1 to avoid rounding done by FPU
        let stor_internal_low = (temp_internal - 1.0).floor();
        let stor_internal_top = (temp_internal + 1.0).ceil();

        let read_internal_low = stor_internal_low / max_internal;
        let read_internal_top = stor_internal_top / max_internal;

        let temp_output_low = read_internal_low * max_output;
        let temp_output_top = read_internal_top * max_output;

        let stor_output_low = f64::from(temp_output_low).floor().clamp(range_low, range_top);
        let stor_output_top = f64::from(temp_output_top).ceil().clamp(range_low, range_top);

        convert(output_format.type_, &mut out_low, stor_output_low)?;
        convert(output_format.type_, &mut out_top, stor_output_top)?;
    }

    Ok((out_low, out_top, texel_size))
}

/// `isInRange<T>`
fn is_in_range<T: PartialOrd + Copy>(value: T, low: T, top: T) -> bool {
    !(value > top || value < low)
}

/// `std::stringstream << double`, which is `%g` with six significant digits.
fn format_g6(value: f64) -> String {
    if value == 0.0 {
        return "0".to_string();
    }
    let exponent = value.abs().log10().floor() as i32;
    // %e rounds, which can carry into the next decade
    let scientific = format!("{:.5e}", value);
    let (mantissa, exp_text) = scientific.split_once('e').expect("a scientific literal");
    let exponent = exp_text.parse::<i32>().unwrap_or(exponent);
    if !(-4..6).contains(&exponent) {
        let mantissa = if mantissa.contains('.') {
            mantissa.trim_end_matches('0').trim_end_matches('.')
        } else {
            mantissa
        };
        return format!(
            "{mantissa}e{}{:02}",
            if exponent < 0 { '-' } else { '+' },
            exponent.abs()
        );
    }
    let decimals = (5 - exponent).max(0) as usize;
    let fixed = format!("{value:.decimals$}");
    if fixed.contains('.') {
        fixed.trim_end_matches('0').trim_end_matches('.').to_string()
    } else {
        fixed
    }
}

/// `SmokeTest::prepareCoordinates`
fn prepare_coordinates(test_case: &TestCaseDesc) -> Result<String> {
    let access = &TEXTURE_ACCESS[test_case.texture_access_index];
    let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

    let type_ = match (
        access.use_integral_coordinates,
        access.n_coordinates + target.n_array_coordinates + target.n_coordinates,
    ) {
        (false, 1) => "float",
        (false, 2) => "vec2",
        (false, 3) => "vec3",
        (false, 4) => "vec4",
        (true, 1) => "int",
        (true, 2) => "ivec2",
        (true, 3) => "ivec3",
        (true, 4) => "ivec4",
        _ => return fail("Invalid value"),
    };

    let mut values = Vec::new();
    values.extend(std::iter::repeat_n("0", target.n_coordinates));
    values.extend(std::iter::repeat_n("0", target.n_array_coordinates));
    values.extend(std::iter::repeat_n("1", access.n_coordinates));
    Ok(format!("{type_}({})", values.join(", ")))
}

/// `SmokeTest::prepareDerivatives`
fn prepare_derivatives(test_case: &TestCaseDesc, index: usize) -> Result<String> {
    let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

    let type_ = match target.n_derivatives {
        1 => "float",
        2 => "vec2",
        3 => "vec3",
        4 => "vec4",
        _ => return fail("Invalid value"),
    };

    let values: Vec<&str> = (0..target.n_derivatives)
        .map(|i| if index == i { "1.0" } else { "0.0" })
        .collect();
    Ok(format!("{type_}({})", values.join(", ")))
}

/// `SmokeTest::prepareOffsets`
fn prepare_offsets(test_case: &TestCaseDesc) -> Result<String> {
    let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

    let type_ = match target.n_derivatives {
        1 => "int",
        2 => "ivec2",
        3 => "ivec3",
        4 => "ivec4",
        _ => return fail("Invalid value"),
    };

    let values: Vec<&str> = (0..target.n_coordinates).map(|_| "0").collect();
    Ok(format!("{type_}({})", values.join(", ")))
}

/// The `Runner`'s common state: the members `SmokeTest` keeps.
struct Runner<'a> {
    context: &'a Context,
    gl: &'a glw::Functions,
    is_ms_supported: bool,
    prepare_fbo: Option<glu::Framebuffer<'a>>,
    out_tex: Option<glu::Texture<'a>>,
    source_tex: Option<glu::Texture<'a>>,
    test_fbo: Option<glu::Framebuffer<'a>>,
    vao: Option<glu::VertexArray<'a>>,
    functional: bool,
}

/// `SmokeTest::iterate` for one access routine and channel
pub fn iterate_smoke(context: &Context, access_idx: usize, channel_idx: usize) -> TestOutcome {
    let mut runner = Runner::new(context, false);

    let tested_format = glw::GL_RGBA32UI;
    let tested_target = glw::GL_TEXTURE_2D_ARRAY;
    let format_idx = get_index_of_format(tested_format)?;
    let tgt_idx = TEXTURE_TARGETS
        .iter()
        .position(|target| target.target == tested_target)
        .ok_or_else(|| TestError::Fail("Unknown texture target".to_string()))?;

    runner.test_init()?;

    if !runner.is_target_supported(tgt_idx) {
        return Err(TestError::NotSupported(
            "Texture target is not support by implementation".to_string(),
        ));
    }

    let source_channel_sizes = runner.prepare_source_texture(format_idx, tgt_idx)?;

    if !runner.fill_source_texture(format_idx, tgt_idx)? {
        return fail("Failed to prepare source texture");
    }

    if !is_target_supp_by_access(access_idx, tgt_idx) {
        return Err(TestError::NotSupported("Target not supported".to_string()));
    }

    for r in 0..VALID_VALUES.len() {
        for g in 0..VALID_VALUES.len() {
            for b in 0..VALID_VALUES.len() {
                for a in 0..VALID_VALUES.len() {
                    let test_case = TestCaseDesc {
                        channel_index: channel_idx,
                        source_texture_format_index: format_idx,
                        source_texture_target_index: tgt_idx,
                        texture_access_index: access_idx,
                        texture_swizzle: [VALID_VALUES[r], VALID_VALUES[g], VALID_VALUES[b], VALID_VALUES[a]],
                        texture_sizes: source_channel_sizes,
                    };

                    runner.execute_test_case(&test_case)?;
                    runner.out_tex = None;
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `FunctionalTest::iterate`
pub fn iterate_functional(context: &Context, format_idx: usize, tgt_idx: usize) -> TestOutcome {
    // FUNCTIONAL_TEST_ALL_ACCESS_ROUTINES == 0: 4 - index of "texelFetch" entry in texture_access_routines
    const ACCESS_IDX: usize = 4;
    // FUNCTIONAL_TEST_ALL_SWIZZLE_COMBINATIONS == 0: values are indices of entries in valid_values
    const TESTED_SWIZZLE_COMBINATIONS: [[usize; 4]; 5] =
        [[3, 2, 1, 0], [5, 4, 0, 3], [5, 5, 5, 5], [4, 4, 4, 4], [2, 2, 2, 2]];

    let mut runner = Runner::new(context, true);
    let mut test_result = true;

    runner.test_init()?;

    // FUNCTIONAL_TEST_ALL_FORMATS
    let (major, minor) = TEXTURE_FORMATS[format_idx].minimum_gl_context;
    if !context.context_type().supports_core(major, minor) {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }

    if !runner.is_target_supported(tgt_idx) {
        return Err(TestError::NotSupported("Target not supported".to_string()));
    }

    if !is_target_supp_by_format(format_idx, tgt_idx) {
        return Err(TestError::NotSupported("Target not supported".to_string()));
    }

    let source_channel_sizes = runner.prepare_source_texture(format_idx, tgt_idx)?;

    if !runner.fill_source_texture(format_idx, tgt_idx)? {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }

    if !is_target_supp_by_access(ACCESS_IDX, tgt_idx) {
        return Err(TestError::NotSupported("Target not supported".to_string()));
    }

    'combinations: for combination in TESTED_SWIZZLE_COMBINATIONS {
        for channel_idx in 0..4 {
            let test_case = TestCaseDesc {
                channel_index: channel_idx,
                source_texture_format_index: format_idx,
                source_texture_target_index: tgt_idx,
                texture_access_index: ACCESS_IDX,
                texture_swizzle: [
                    VALID_VALUES[combination[0]],
                    VALID_VALUES[combination[1]],
                    VALID_VALUES[combination[2]],
                    VALID_VALUES[combination[3]],
                ],
                texture_sizes: source_channel_sizes,
            };

            if !runner.execute_test_case(&test_case)? {
                runner.log_test_case_details(&test_case)?;
                log::info!("Found pixel with wrong value");
                test_result = false;
                break 'combinations;
            }
            runner.out_tex = None;
        }
    }

    Ok(if test_result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `SmokeTest::isTargetSuppByAccess`
fn is_target_supp_by_access(access_idx: usize, target_idx: usize) -> bool {
    let access = &TEXTURE_ACCESS[access_idx];
    let source_target = &TEXTURE_TARGETS[target_idx];

    if !source_target.support_integral_coordinates && access.use_integral_coordinates {
        return false;
    }

    if !source_target.support_offset && access.use_offsets {
        return false;
    }

    if !source_target.support_lod && access.use_lod {
        if source_target.require_multisampling && access.support_multisampling {
            return true;
        }
        return false;
    }

    if !source_target.supports_proj && access.n_coordinates == 1 {
        return false;
    }

    if source_target.require_multisampling && !access.support_multisampling {
        return false;
    }

    true
}

/// `SmokeTest::isTargetSuppByFormat`
fn is_target_supp_by_format(format_idx: usize, target_idx: usize) -> bool {
    let format = &TEXTURE_FORMATS[format_idx];
    let source_target = &TEXTURE_TARGETS[target_idx];
    let is_multisample = source_target.target == glw::GL_TEXTURE_2D_MULTISAMPLE
        || source_target.target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY;

    match format.internal_format {
        glw::GL_DEPTH_COMPONENT16
        | glw::GL_DEPTH_COMPONENT24
        | glw::GL_DEPTH_COMPONENT32
        | glw::GL_DEPTH_COMPONENT32F
        | glw::GL_DEPTH24_STENCIL8
        | glw::GL_DEPTH32F_STENCIL8 => !(source_target.target == glw::GL_TEXTURE_3D || is_multisample),
        glw::GL_RGB9_E5 => !is_multisample,
        _ => true,
    }
}

/// `SmokeTest::prepareArguments`
fn prepare_arguments(gl: &glw::Functions, test_case: &TestCaseDesc) -> Result<String> {
    let access = &TEXTURE_ACCESS[test_case.texture_access_index];
    let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

    let mut arguments = prepare_coordinates(test_case)?;

    if access.use_lod && target.support_lod {
        arguments.push_str(", int(0)");
    } else if access.use_derivatives {
        let derivatives_0 = prepare_derivatives(test_case, 0)?;
        let derivatives_1 = prepare_derivatives(test_case, 1)?;
        arguments.push_str(&format!(", {derivatives_0}, {derivatives_1}"));
    }

    if access.use_offsets {
        arguments.push_str(&format!(", {}", prepare_offsets(test_case)?));
    }

    if target.require_multisampling && access.support_multisampling {
        // prepareSample
        let mut samples: glw::GLsizei = 1;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, &mut samples) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        arguments.push_str(&format!(", {}", samples - 1));
    }

    Ok(arguments)
}

/// `SmokeTest::getFragmentShader`
fn get_fragment_shader(
    gl: &glw::Functions,
    test_case: &TestCaseDesc,
    output_format_index: usize,
    is_tested_stage: bool,
) -> Result<String> {
    let output_format = &TEXTURE_FORMATS[output_format_index];
    let source_format = &TEXTURE_FORMATS[test_case.source_texture_format_index];

    if is_tested_stage {
        let arguments = prepare_arguments(gl, test_case)?;
        let access = &TEXTURE_ACCESS[test_case.texture_access_index];
        let channel = CHANNELS[test_case.channel_index];
        let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

        Ok(format!(
            "#version 330 core\n\nuniform {}sampler{} sampler;\n\nout {} out_color;\n\nvoid main()\n{{\n    {} result = {}(sampler, {}).{};\n\n    out_color = result;\n}}\n\n",
            source_format.sampler.sampler_prefix,
            target.sampler_type,
            output_format.sampler.basic_type,
            source_format.sampler.basic_type,
            access.name,
            arguments,
            channel
        ))
    } else {
        Ok(format!(
            "#version 330 core\n\nflat in {} result;\n\nout {} out_color;\n\nvoid main()\n{{\n    out_color = result;\n}}\n\n",
            source_format.sampler.basic_type, output_format.sampler.basic_type
        ))
    }
}

const BLANK_VERTEX_BODY: &str = "    switch (gl_VertexID)\n    {\n      case 0: gl_Position = vec4(-1.0, 1.0, 0.0, 1.0); break; \n      case 1: gl_Position = vec4( 1.0, 1.0, 0.0, 1.0); break; \n      case 2: gl_Position = vec4(-1.0,-1.0, 0.0, 1.0); break; \n      case 3: gl_Position = vec4( 1.0,-1.0, 0.0, 1.0); break; \n    }\n}\n\n";

/// `SmokeTest::getVertexShader`
fn get_vertex_shader(gl: &glw::Functions, test_case: Option<&TestCaseDesc>, is_tested_stage: bool) -> Result<String> {
    match test_case {
        Some(test_case) if is_tested_stage => {
            let arguments = prepare_arguments(gl, test_case)?;
            let access = &TEXTURE_ACCESS[test_case.texture_access_index];
            let channel = CHANNELS[test_case.channel_index];
            let source_format = &TEXTURE_FORMATS[test_case.source_texture_format_index];
            let target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

            Ok(format!(
                "#version 330 core\n\nuniform {}sampler{} sampler;\n\nflat out {} result;\n\nvoid main()\n{{\n    result = {}(sampler, {}).{};\n\n{}",
                source_format.sampler.sampler_prefix,
                target.sampler_type,
                source_format.sampler.basic_type,
                access.name,
                arguments,
                channel,
                BLANK_VERTEX_BODY
            ))
        }
        _ => Ok(format!("#version 330 core\n\nvoid main()\n{{\n{BLANK_VERTEX_BODY}")),
    }
}

/// `Utils::programInfo::build`
fn build_program<'gl>(
    gl: &'gl glw::Functions,
    fragment_shader_code: &str,
    vertex_shader_code: &str,
) -> Result<ShaderProgram<'gl>> {
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_shader_code, fragment_shader_code));
    if !program.is_ok() {
        return fail("Failed to compile shader");
    }
    Ok(program)
}

impl<'a> Runner<'a> {
    fn new(context: &'a Context, functional: bool) -> Self {
        Self {
            context,
            gl: context.gl(),
            is_ms_supported: false,
            prepare_fbo: None,
            out_tex: None,
            source_tex: None,
            test_fbo: None,
            vao: None,
            functional,
        }
    }

    /// `SmokeTest::testInit`
    fn test_init(&mut self) -> Result<()> {
        let gl = self.gl;
        let mut major = 0;
        let mut minor = 0;
        // SAFETY: one GLint out per call.
        unsafe {
            gl.get_integerv(glw::GL_MAJOR_VERSION, &mut major);
            gl.get_integerv(glw::GL_MINOR_VERSION, &mut minor);
        }
        glu::expect_no_error(gl, "GetIntegerv")?;

        if 4 < major || (4 == major && 3 <= minor) {
            self.is_ms_supported = true;
        }

        if !self.is_ms_supported {
            self.is_ms_supported = self
                .context
                .context_info
                .is_extension_supported("GL_ARB_texture_storage_multisample");
        }

        self.prepare_fbo = Some(glu::Framebuffer::new(gl));
        glu::expect_no_error(gl, "GenFramebuffers")?;

        self.test_fbo = Some(glu::Framebuffer::new(gl));
        glu::expect_no_error(gl, "GenFramebuffers")?;

        let vao = glu::VertexArray::new(gl);
        glu::expect_no_error(gl, "genVertexArrays")?;
        // SAFETY: the vertex array is the guard's own.
        unsafe { gl.bind_vertex_array(vao.get()) };
        glu::expect_no_error(gl, "bindVertexArray")?;
        self.vao = Some(vao);
        Ok(())
    }

    /// `SmokeTest::isTargetSupported`
    fn is_target_supported(&self, target_idx: usize) -> bool {
        match TEXTURE_TARGETS[target_idx].target {
            glw::GL_TEXTURE_2D_MULTISAMPLE | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => self.is_ms_supported,
            _ => true,
        }
    }

    fn source_tex_id(&self) -> glw::GLuint {
        self.source_tex.as_ref().map_or(0, glu::Texture::get)
    }

    fn out_tex_id(&self) -> glw::GLuint {
        self.out_tex.as_ref().map_or(0, glu::Texture::get)
    }

    /// `SmokeTest::prepareSourceTexture` - returns the channel sizes of the source texture.
    fn prepare_source_texture(&mut self, format_idx: usize, target_idx: usize) -> Result<[i32; 4]> {
        let gl = self.gl;
        let level = 0;
        let border = 0;
        let target = TEXTURE_TARGETS[target_idx].target;
        let texture_format = &TEXTURE_FORMATS[format_idx];
        let format = texture_format.format;
        let internal_format = texture_format.internal_format;
        let type_ = texture_format.type_;
        let mut samples: glw::GLsizei = 1;
        let mut target_get_prm = target;
        let mut out_sizes = [0i32; 4];

        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, &mut samples) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let source_tex = glu::Texture::new(gl);
        glu::expect_no_error(gl, "GenTextures")?;
        // SAFETY: the texture is the guard's own.
        unsafe { gl.bind_texture(target, source_tex.get()) };
        glu::expect_no_error(gl, "BindTexture")?;
        self.source_tex = Some(source_tex);

        let function_name;
        // SAFETY: allocations without data.
        let error = unsafe {
            match target {
                glw::GL_TEXTURE_1D => {
                    gl.tex_image_1d(
                        target,
                        level,
                        internal_format as i32,
                        WIDTH,
                        border,
                        format,
                        type_,
                        std::ptr::null(),
                    );
                    function_name = "TexImage1D";
                }
                glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                    gl.tex_image_2d(
                        target,
                        level,
                        internal_format as i32,
                        WIDTH,
                        HEIGHT,
                        border,
                        format,
                        type_,
                        std::ptr::null(),
                    );
                    function_name = "TexImage2D";
                }
                glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                    gl.tex_image_3d(
                        target,
                        level,
                        internal_format as i32,
                        WIDTH,
                        HEIGHT,
                        DEPTH,
                        border,
                        format,
                        type_,
                        std::ptr::null(),
                    );
                    function_name = "TexImage3D";
                }
                glw::GL_TEXTURE_CUBE_MAP => {
                    for face in CUBE_MAP_FACES {
                        gl.tex_image_2d(
                            face,
                            level,
                            internal_format as i32,
                            WIDTH,
                            HEIGHT,
                            border,
                            format,
                            type_,
                            std::ptr::null(),
                        );
                    }
                    function_name = "TexImage2D";
                    target_get_prm = CUBE_MAP_FACES[0];
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE => {
                    gl.tex_image_2d_multisample(target, samples, internal_format, WIDTH, HEIGHT, glw::FALSE);
                    function_name = "TexImage2DMultisample";
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                    gl.tex_image_3d_multisample(target, samples, internal_format, WIDTH, HEIGHT, DEPTH, glw::FALSE);
                    function_name = "TexImage3DMultisample";
                }
                _ => return fail("Invalid enum"),
            }
            gl.get_error()
        };
        if error != glw::GL_NO_ERROR {
            return fail(&format!("{function_name} returned {}", glw::error_name(error)));
        }

        if target != glw::GL_TEXTURE_2D_MULTISAMPLE
            && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            && target != glw::GL_TEXTURE_RECTANGLE
        {
            // SAFETY: state setters on the bound texture.
            unsafe {
                gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
                glu::expect_no_error(gl, "TexParameteri")?;
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 0);
                glu::expect_no_error(gl, "TexParameteri")?;
                gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                glu::expect_no_error(gl, "TexParameteri")?;
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                glu::expect_no_error(gl, "TexParameteri")?;
            }
        }

        if texture_format.ds_mode == glw::GL_STENCIL_INDEX {
            // SAFETY: a state setter on the bound texture.
            unsafe {
                gl.tex_parameteri(
                    target,
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    texture_format.ds_mode as i32,
                )
            };
            glu::expect_no_error(gl, "TexParameteri")?;
        }

        let mut query = |pname: GLenum, slot: usize| -> Result<()> {
            // SAFETY: one GLint out.
            unsafe { gl.get_tex_level_parameteriv(target_get_prm, 0, pname, &mut out_sizes[slot]) };
            glu::expect_no_error(gl, "GetTexLevelParameteriv")
        };
        match internal_format {
            glw::GL_DEPTH24_STENCIL8 | glw::GL_DEPTH32F_STENCIL8 => {
                query(glw::GL_TEXTURE_STENCIL_SIZE, 1)?;
                query(glw::GL_TEXTURE_DEPTH_SIZE, 0)?;
            }
            glw::GL_DEPTH_COMPONENT16
            | glw::GL_DEPTH_COMPONENT24
            | glw::GL_DEPTH_COMPONENT32
            | glw::GL_DEPTH_COMPONENT32F => query(glw::GL_TEXTURE_DEPTH_SIZE, 0)?,
            _ => {
                query(glw::GL_TEXTURE_RED_SIZE, 0)?;
                query(glw::GL_TEXTURE_GREEN_SIZE, 1)?;
                query(glw::GL_TEXTURE_BLUE_SIZE, 2)?;
                query(glw::GL_TEXTURE_ALPHA_SIZE, 3)?;
            }
        }

        // SAFETY: unbinding.
        unsafe { gl.bind_texture(target, 0) };
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(out_sizes)
    }

    /// `SmokeTest::fillSourceTexture` / `FunctionalTest::fillSourceTexture`
    fn fill_source_texture(&mut self, format_idx: usize, target_idx: usize) -> Result<bool> {
        if !self.functional {
            return self.fill_source_texture_smoke(format_idx, target_idx);
        }

        let gl = self.gl;
        let target = TEXTURE_TARGETS[target_idx].target;
        let format = &TEXTURE_FORMATS[format_idx];
        let mut result = true;

        // SAFETY: the source texture is this runner's own.
        unsafe { gl.bind_texture(target, self.source_tex_id()) };
        glu::expect_no_error(gl, "BindTexture")?;

        let data = format.source_data.as_ptr().cast::<std::ffi::c_void>();
        // SAFETY: `source_data` holds one texel of the format, which is all a 1x1x1 upload reads.
        unsafe {
            match target {
                glw::GL_TEXTURE_1D => {
                    gl.tex_sub_image_1d(target, 0, 0, WIDTH, format.format, format.type_, data);
                    glu::expect_no_error(gl, "TexSubImage1D")?;
                }
                glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                    gl.tex_sub_image_2d(target, 0, 0, 0, WIDTH, HEIGHT, format.format, format.type_, data);
                    glu::expect_no_error(gl, "TexSubImage2D")?;
                }
                glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                    gl.tex_sub_image_3d(
                        target,
                        0,
                        0,
                        0,
                        0,
                        WIDTH,
                        HEIGHT,
                        DEPTH,
                        format.format,
                        format.type_,
                        data,
                    );
                    glu::expect_no_error(gl, "TexSubImage3D")?;
                }
                glw::GL_TEXTURE_CUBE_MAP => {
                    for face in CUBE_MAP_FACES {
                        gl.tex_sub_image_2d(face, 0, 0, 0, WIDTH, HEIGHT, format.format, format.type_, data);
                        glu::expect_no_error(gl, "TexSubImage2D")?;
                    }
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                    result = self.fill_ms_texture(format_idx, target_idx)?;
                }
                _ => return fail("Invalid enum"),
            }

            gl.bind_texture(target, 0);
        }
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(result)
    }

    /// `SmokeTest::fillSourceTexture`
    fn fill_source_texture_smoke(&mut self, format_idx: usize, target_idx: usize) -> Result<bool> {
        let gl = self.gl;
        let rgba32ui: [u32; 4] = [0x3fff_ffff, 0x7fff_ffff, 0xbfff_ffff, 0xffff_ffff];
        let target = TEXTURE_TARGETS[target_idx].target;
        let texture_format = &TEXTURE_FORMATS[format_idx];

        // SAFETY: the source texture is this runner's own.
        unsafe { gl.bind_texture(target, self.source_tex_id()) };
        glu::expect_no_error(gl, "BindTexture")?;

        if texture_format.internal_format != glw::GL_RGBA32UI {
            return fail("Invalid enum");
        }

        match target {
            // SAFETY: `rgba32ui` is one RGBA32UI texel.
            glw::GL_TEXTURE_2D_ARRAY => unsafe {
                gl.tex_sub_image_3d(
                    target,
                    0,
                    0,
                    0,
                    0,
                    WIDTH,
                    HEIGHT,
                    DEPTH,
                    texture_format.format,
                    texture_format.type_,
                    rgba32ui.as_ptr().cast(),
                );
            },
            _ => return fail("Invalid enum"),
        }

        // SAFETY: unbinding.
        unsafe { gl.bind_texture(target, 0) };
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(true)
    }

    /// `FunctionalTest::fillMSTexture` - renders the source values into the multisample texture.
    fn fill_ms_texture(&mut self, format_idx: usize, target_idx: usize) -> Result<bool> {
        let gl = self.gl;
        let target = TEXTURE_TARGETS[target_idx].target;
        let prepare_fbo = self.prepare_fbo.as_ref().map_or(0, glu::Framebuffer::get);

        // SAFETY: the framebuffer is this runner's own.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, prepare_fbo) };
        glu::expect_no_error(gl, "BindFramebuffer")?;

        match target {
            glw::GL_TEXTURE_2D_MULTISAMPLE => {
                // SAFETY: attaches the source texture.
                unsafe {
                    gl.framebuffer_texture_2d(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        target,
                        self.source_tex_id(),
                        0,
                    )
                };
                glu::expect_no_error(gl, "FramebufferTexture2D")?;
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                // SAFETY: attaches layer 0 of the source texture.
                unsafe {
                    gl.framebuffer_texture_layer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        self.source_tex_id(),
                        0,
                        0,
                    )
                };
                glu::expect_no_error(gl, "FramebufferTexture2D")?;
            }
            _ => return fail("Invalid enum"),
        }

        // SAFETY: a status query.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
        glu::expect_no_error(gl, "CheckFramebufferStatus")?;

        if glw::GL_FRAMEBUFFER_UNSUPPORTED == status {
            // SAFETY: unbinding.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
            glu::expect_no_error(gl, "BindFramebuffer")?;
            return Ok(false);
        } else if glw::GL_FRAMEBUFFER_COMPLETE != status {
            return fail("Framebuffer is incomplete. Format is supported");
        }

        // SAFETY: a state setter.
        unsafe { gl.viewport(0, 0, OUTPUT_WIDTH, OUTPUT_HEIGHT) };
        glu::expect_no_error(gl, "Viewport")?;

        // prepareProgram
        let format = &TEXTURE_FORMATS[format_idx];
        let ch_rgba = calculate_values_from_source(format_idx)?;
        let values = format!(
            "{}, {}, {}, {}",
            format_g6(ch_rgba[0]),
            format_g6(ch_rgba[1]),
            format_g6(ch_rgba[2]),
            format_g6(ch_rgba[3])
        );
        let prefix = format.sampler.sampler_prefix;
        let fs = format!(
            "#version 330 core\n\nout {prefix}vec4 out_color;\n\nvoid main()\n{{\n    out_color = {prefix}vec4({values});\n}}\n\n"
        );
        let vs = get_vertex_shader(gl, None, false)?;
        let program = build_program(gl, &fs, &vs)?;

        // SAFETY: a program that built; a clear and a draw into the attached texture.
        unsafe {
            gl.use_program(program.program());
            glu::expect_no_error(gl, "UseProgram")?;

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "Clear")?;

            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            glu::expect_no_error(gl, "DrawArrays")?;

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        }
        glu::expect_no_error(gl, "BindFramebuffer")?;
        Ok(true)
    }

    /// `SmokeTest::prepareOutputTexture`
    fn prepare_output_texture(&mut self, format_idx: usize) -> Result<()> {
        let gl = self.gl;
        let format = &TEXTURE_FORMATS[format_idx];

        let out_tex = glu::Texture::new(gl);
        glu::expect_no_error(gl, "GenTextures")?;

        // SAFETY: the texture is the guard's own.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, out_tex.get());
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format.internal_format as i32,
                OUTPUT_WIDTH,
                OUTPUT_HEIGHT,
                0,
                format.format,
                format.type_,
                std::ptr::null(),
            );
            glu::expect_no_error(gl, "TexImage2D")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        }
        glu::expect_no_error(gl, "BindTexture")?;
        self.out_tex = Some(out_tex);
        Ok(())
    }

    /// `SmokeTest::executeTestCase` - false is upstream's `wrongResults` exception.
    fn execute_test_case(&mut self, test_case: &TestCaseDesc) -> Result<bool> {
        let gl = self.gl;
        let source_format = &TEXTURE_FORMATS[test_case.source_texture_format_index];
        let channel = get_swizzled_channel_idx(test_case.channel_index, &test_case.texture_swizzle)?;
        let out_internal_format = get_internal_format_for_channel(source_format, channel)?;
        let out_format_idx = get_index_of_format(out_internal_format)?;
        let mut out_channel_size = 0;

        self.prepare_output_texture(out_format_idx)?;

        let test_fbo = self.test_fbo.as_ref().map_or(0, glu::Framebuffer::get);
        // SAFETY: the textures and the framebuffer are this runner's own.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, self.out_tex_id());
            glu::expect_no_error(gl, "BindTexture")?;

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, test_fbo);
            glu::expect_no_error(gl, "BindFramebuffer")?;

            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.out_tex_id(),
                0,
            );
            glu::expect_no_error(gl, "FramebufferTexture2D")?;

            gl.viewport(0, 0, OUTPUT_WIDTH, OUTPUT_HEIGHT);
            glu::expect_no_error(gl, "Viewport")?;

            gl.get_tex_level_parameteriv(glw::GL_TEXTURE_2D, 0, glw::GL_TEXTURE_RED_SIZE, &mut out_channel_size);
            glu::expect_no_error(gl, "GetTexLevelParameteriv")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        }
        glu::expect_no_error(gl, "BindTexture")?;

        if !self.prepare_and_test_program(test_case, out_format_idx, out_channel_size, channel, true)? {
            return Ok(false);
        }
        if !self.prepare_and_test_program(test_case, out_format_idx, out_channel_size, channel, false)? {
            return Ok(false);
        }

        // SAFETY: unbinding.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        glu::expect_no_error(gl, "BindFramebuffer")?;
        Ok(true)
    }

    /// `SmokeTest::prepareAndTestProgram`
    fn prepare_and_test_program(
        &mut self,
        test_case: &TestCaseDesc,
        output_format_index: usize,
        output_channel_size: i32,
        index_of_swizzled_channel: usize,
        test_vertex_stage: bool,
    ) -> Result<bool> {
        let gl = self.gl;
        let source_target = &TEXTURE_TARGETS[test_case.source_texture_target_index];

        let fs = get_fragment_shader(gl, test_case, output_format_index, !test_vertex_stage)?;
        let vs = get_vertex_shader(gl, Some(test_case), test_vertex_stage)?;

        let program = build_program(gl, &fs, &vs)?;

        // SAFETY: a program that built; a NUL-terminated name.
        let location = unsafe {
            gl.use_program(program.program());
            glu::expect_no_error(gl, "UseProgram")?;

            let location = gl.get_uniform_location(program.program(), c"sampler".as_ptr());
            glu::expect_no_error(gl, "GetUniformLocation")?;
            location
        };
        if -1 == location {
            return fail("Uniform is not available");
        }

        // SAFETY: the sampler uniform of the program in use.
        unsafe { gl.uniform_1i(location, 0) };
        glu::expect_no_error(gl, "Uniform1i")?;

        self.draw(source_target.target, &test_case.texture_swizzle, false)?;
        if !self.capture_and_verify(
            test_case,
            output_format_index,
            output_channel_size,
            index_of_swizzled_channel,
        )? {
            return Ok(false);
        }

        self.draw(source_target.target, &test_case.texture_swizzle, true)?;
        self.capture_and_verify(
            test_case,
            output_format_index,
            output_channel_size,
            index_of_swizzled_channel,
        )
    }

    /// `SmokeTest::draw`
    fn draw(&self, target: GLenum, texture_swizzle: &[i32; 4], use_rgba_enum: bool) -> Result<()> {
        let gl = self.gl;

        // SAFETY: state setters on the source texture and a draw into the attached output texture.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            glu::expect_no_error(gl, "ActiveTexture")?;

            gl.bind_texture(target, self.source_tex_id());
            glu::expect_no_error(gl, "BindTexture")?;

            if use_rgba_enum {
                gl.tex_parameteriv(target, glw::GL_TEXTURE_SWIZZLE_RGBA, texture_swizzle.as_ptr());
                glu::expect_no_error(gl, "TexParameteriv")?;
            } else {
                gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_R, texture_swizzle[0]);
                gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_G, texture_swizzle[1]);
                gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_B, texture_swizzle[2]);
                gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_A, texture_swizzle[3]);
                glu::expect_no_error(gl, "TexParameteri")?;
            }

            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            glu::expect_no_error(gl, "Clear")?;

            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            glu::expect_no_error(gl, "DrawArrays")?;

            gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_R, glw::GL_RED as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_G, glw::GL_GREEN as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_B, glw::GL_BLUE as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_A, glw::GL_ALPHA as i32);
            glu::expect_no_error(gl, "TexParameteri")?;

            gl.bind_texture(target, 0);
        }
        glu::expect_no_error(gl, "BindTexture")
    }

    /// `SmokeTest::captureAndVerify`
    fn capture_and_verify(
        &self,
        test_case: &TestCaseDesc,
        output_format_index: usize,
        output_channel_size: i32,
        index_of_swizzled_channel: usize,
    ) -> Result<bool> {
        let gl = self.gl;
        let output_format = &TEXTURE_FORMATS[output_format_index];
        let mut result_image = vec![0u8; (OUTPUT_WIDTH * OUTPUT_HEIGHT * 4) as usize * std::mem::size_of::<u32>()];

        // SAFETY: the output texture is this runner's own; the buffer holds four 32-bit channels per pixel.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, self.out_tex_id());
            glu::expect_no_error(gl, "BindTexture")?;

            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                output_format.format,
                output_format.type_,
                result_image.as_mut_ptr().cast(),
            );
            glu::expect_no_error(gl, "getTexImage")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        }
        glu::expect_no_error(gl, "BindTexture")?;

        self.verify_output_image(
            test_case,
            output_format_index,
            output_channel_size,
            index_of_swizzled_channel,
            &result_image,
        )
    }

    /// `SmokeTest::verifyOutputImage` and `FunctionalTest::verifyOutputImage`
    fn verify_output_image(
        &self,
        test_case: &TestCaseDesc,
        output_format_index: usize,
        output_channel_size: i32,
        index_of_swizzled_channel: usize,
        data: &[u8],
    ) -> Result<bool> {
        if !self.functional {
            let rgba32ui: [u32; 6] = [0x3fff_ffff, 0x7fff_ffff, 0xbfff_ffff, 0xffff_ffff, 1, 0];
            let source_format = &TEXTURE_FORMATS[test_case.source_texture_format_index];

            return match source_format.internal_format {
                glw::GL_RGBA32UI => {
                    let expected_value = rgba32ui[index_of_swizzled_channel];
                    for i in 0..(OUTPUT_WIDTH * OUTPUT_HEIGHT) as usize {
                        if read_u32(&data[i * 4..]) != expected_value {
                            return fail("Found pixel with wrong value");
                        }
                    }
                    Ok(true)
                }
                _ => fail("Invalid enum"),
            };
        }

        let output_format = &TEXTURE_FORMATS[output_format_index];
        let source_size = test_case
            .texture_sizes
            .get(index_of_swizzled_channel)
            .copied()
            .unwrap_or(0);

        let (expected_data_low, expected_data_top, texel_size) = calculate_expected_value(
            test_case.source_texture_format_index,
            output_format_index,
            index_of_swizzled_channel,
            source_size,
            output_channel_size,
        )?;

        for i in 0..(OUTPUT_HEIGHT * OUTPUT_WIDTH) as usize {
            let pointer = &data[i * texel_size..];

            let res = match output_format.type_ {
                glw::GL_BYTE => is_in_range(pointer[0] as i8, expected_data_low[0] as i8, expected_data_top[0] as i8),
                glw::GL_UNSIGNED_BYTE => is_in_range(pointer[0], expected_data_low[0], expected_data_top[0]),
                glw::GL_SHORT => is_in_range(
                    read_u16(pointer) as i16,
                    read_u16(&expected_data_low) as i16,
                    read_u16(&expected_data_top) as i16,
                ),
                glw::GL_UNSIGNED_SHORT => is_in_range(
                    read_u16(pointer),
                    read_u16(&expected_data_low),
                    read_u16(&expected_data_top),
                ),
                glw::GL_HALF_FLOAT => {
                    is_in_range(pointer[0] as i8, expected_data_low[0] as i8, expected_data_top[0] as i8)
                }
                glw::GL_INT => is_in_range(
                    read_u32(pointer) as i32,
                    read_u32(&expected_data_low) as i32,
                    read_u32(&expected_data_top) as i32,
                ),
                glw::GL_UNSIGNED_INT => is_in_range(
                    read_u16(pointer),
                    read_u16(&expected_data_low),
                    read_u16(&expected_data_top),
                ),
                glw::GL_FLOAT => is_in_range(
                    f32::from_bits(read_u32(pointer)),
                    f32::from_bits(read_u32(&expected_data_low)),
                    f32::from_bits(read_u32(&expected_data_top)),
                ),
                _ => return fail("Invalid enum"),
            };

            if !res {
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// `SmokeTest::logTestCaseDetials` (sic)
    fn log_test_case_details(&self, test_case: &TestCaseDesc) -> Result<()> {
        let target = TEXTURE_TARGETS[test_case.source_texture_target_index].target;
        let source_format = &TEXTURE_FORMATS[test_case.source_texture_format_index];
        let channel = get_swizzled_channel_idx(test_case.channel_index, &test_case.texture_swizzle)?;
        let out_internal_format = get_internal_format_for_channel(source_format, channel)?;
        let out_format_idx = get_index_of_format(out_internal_format)?;
        let output_format = &TEXTURE_FORMATS[out_format_idx];

        log::info!(
            "Test case details. Source texture: Target: {target:#x}. Format: {:#x}, {:#x}, {:#x}, DS: {:#x}. Swizzle: {:?}. Channel: {}. Access: {}. Output texture: Format: {:#x}, {:#x}, {:#x}.",
            source_format.internal_format,
            source_format.format,
            source_format.type_,
            source_format.ds_mode,
            test_case.texture_swizzle,
            CHANNELS[test_case.channel_index],
            TEXTURE_ACCESS[test_case.texture_access_index].name,
            output_format.internal_format,
            output_format.format,
            output_format.type_
        );
        Ok(())
    }
}
