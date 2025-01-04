// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fReadPixelsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The reference needs no rasteriser: the case clears the target to a random colour and
// draws one axis-aligned quad over the middle half of a 13x13 viewport, so the host fills
// the same rectangle by hand. What is under test is `glReadPixels` honouring
// GL_PACK_ALIGNMENT / ROW_LENGTH / SKIP_ROWS / SKIP_PIXELS, which is a question about the
// layout of the bytes it writes, not about what was rendered.

use crate::glu::texture_util::map_gl_transfer_format;
use crate::glu::{self, ApiCase, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear, clear_int, get_texture_format_bit_depth};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{Random, de_string_hash};

/// `ReadPixelsTest`'s constructor arguments, which upstream keeps as members.
#[derive(Clone, Copy)]
struct ReadPixelsParams {
    /// `FLAG_CHOOSE_FORMAT` - ask the driver for GL_IMPLEMENTATION_COLOR_READ_*.
    choose_format: bool,
    /// `FLAG_USE_RBO` - render into an integer renderbuffer instead of the default target.
    use_render_buffer: bool,
    alignment: i32,
    row_length: i32,
    skip_rows: i32,
    skip_pixels: i32,
    format: GLenum,
    type_: GLenum,
}

/// `ReadPixelsTest::m_width` / `m_height`
const WIDTH: i32 = 13;
const HEIGHT: i32 = 13;

/// `ReadPixelsTest::render` - draws the quad and fills the same rectangle in `reference`.
fn render(case: &mut ApiCase<'_>, reference: &mut TextureLevel) -> bool {
    let gl = case.gl();

    // Create program.
    let vertex_source = "#version 300 es\n\
                         in mediump vec2 i_coord;\n\
                         void main (void)\n\
                         {\n\
                         \tgl_Position = vec4(i_coord, 0.0, 1.0);\n\
                         }\n";

    let type_ = reference.format().type_;
    let mut fragment_source = String::from("#version 300 es\n");
    if type_ == ChannelType::SIGNED_INT32 {
        fragment_source.push_str("layout(location = 0) out mediump ivec4 o_color;\n");
    } else if type_ == ChannelType::UNSIGNED_INT32 {
        fragment_source.push_str("layout(location = 0) out mediump uvec4 o_color;\n");
    } else {
        fragment_source.push_str("layout(location = 0) out mediump vec4 o_color;\n");
    }
    fragment_source.push_str("void main (void)\n{\n");
    if type_ == ChannelType::UNSIGNED_INT32 {
        fragment_source.push_str("\to_color = uvec4(0, 0, 0, 1000);\n");
    } else if type_ == ChannelType::SIGNED_INT32 {
        fragment_source.push_str("\to_color = ivec4(0, 0, 0, 1000);\n");
    } else {
        fragment_source.push_str("\to_color = vec4(0.0, 0.0, 0.0, 1.0);\n");
    }
    fragment_source.push_str("}\n");

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_source, &fragment_source));
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Fail");
        return false;
    }

    // Render.
    // SAFETY: a linked program of this case's own, and a client-side array of exactly the
    // six vertices the draw asks for.
    unsafe {
        gl.use_program(program.program());

        const COORDS: [f32; 12] = [-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5];

        let coord_loc = gl.get_attrib_location(program.program(), c"i_coord".as_ptr());
        gl.enable_vertex_attrib_array(coord_loc as u32);
        gl.vertex_attrib_pointer(
            coord_loc as u32,
            2,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            COORDS.as_ptr().cast(),
        );
        gl.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        gl.disable_vertex_attrib_array(coord_loc as u32);
    }

    // Render reference.
    let [width, height, _] = reference.size();
    let coord_x1 = (-0.5 * width as f32 / 2.0 + width as f32 / 2.0) as i32;
    let coord_y1 = (-0.5 * height as f32 / 2.0 + height as f32 / 2.0) as i32;
    let coord_x2 = (0.5 * width as f32 / 2.0 + width as f32 / 2.0) as i32;
    let coord_y2 = (0.5 * height as f32 / 2.0 + height as f32 / 2.0) as i32;

    let mut access = reference.get_access();
    for x in 0..width as i32 {
        if x < coord_x1 || x > coord_x2 {
            continue;
        }

        for y in 0..height as i32 {
            if y >= coord_y1 && y <= coord_y2 {
                if type_ == ChannelType::SIGNED_INT32 || type_ == ChannelType::UNSIGNED_INT32 {
                    let stored = access.set_pixel_int([0, 0, 0, 1000], x as u32, y as u32, 0);
                    debug_assert!(stored, "a 32-bit integer format is storable");
                } else {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x as u32, y as u32, 0);
                }
            }
        }
    }

    true
}

/// `ReadPixelsTest::getFormatInfo` - `None` means upstream's `NotSupportedError`.
fn get_format_info(case: &mut ApiCase<'_>, params: ReadPixelsParams) -> Option<(TextureFormat, i32, GLenum, GLenum)> {
    let (gl_format, gl_type) = if params.choose_format {
        let gl_format = case.get_int(glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT) as GLenum;
        let gl_type = case.get_int(glw::GL_IMPLEMENTATION_COLOR_READ_TYPE) as GLenum;

        if gl_format != glw::GL_RGBA && gl_format != glw::GL_BGRA && gl_format != glw::GL_RGB {
            case.not_supported(format!(
                "Unsupported IMPLEMENTATION_COLOR_READ_FORMAT: {}",
                glu::texture_format_name(gl_format).unwrap_or("<unknown>")
            ));
            return None;
        }
        if glu::type_name(gl_type).is_none() {
            case.not_supported(format!("Unsupported GL_IMPLEMENTATION_COLOR_READ_TYPE: {gl_type:#06x}"));
            return None;
        }

        (gl_format, gl_type)
    } else {
        (params.format, params.type_)
    };

    let format = map_gl_transfer_format(gl_format, gl_type)?;
    let pixel_size = format.pixel_size()? as i32;
    Some((format, pixel_size, gl_format, gl_type))
}

/// `deCeilFloatToInt32(float(a) / float(b)) * b`, the row stride GL packs with.
fn row_pitch(alignment: i32, pixel_size: i32, row_width: i32) -> i32 {
    alignment * ((pixel_size * row_width) as f32 / alignment as f32).ceil() as i32
}

/// `ReadPixelsTest::clearColor` - clears, renders, and reads the result back.
fn clear_color(
    case: &mut ApiCase<'_>,
    params: ReadPixelsParams,
    gl_format: GLenum,
    gl_type: GLenum,
    reference: &mut TextureLevel,
    pixel_size: i32,
    seed: u32,
) -> Option<Vec<u8>> {
    let gl = case.gl();
    let mut rnd = Random::new(seed);
    let framebuffer = glu::Framebuffer::new(gl);
    let renderbuffer = glu::Renderbuffer::new(gl);

    // SAFETY: names this function just created, on a current context.
    unsafe {
        if params.use_render_buffer {
            let internal_format = if gl_type == glw::GL_UNSIGNED_INT {
                glw::GL_RGBA32UI
            } else {
                glw::GL_RGBA32I
            };
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format, WIDTH, HEIGHT);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                renderbuffer.get(),
            );
        }

        let [width, height, _] = reference.size();
        gl.viewport(0, 0, width as i32, height as i32);
    }

    // Clear color.
    if gl_format == glw::GL_RGBA || gl_format == glw::GL_BGRA || gl_format == glw::GL_RGB {
        let (red, green, blue, alpha) = (rnd.get_float(), rnd.get_float(), rnd.get_float(), rnd.get_float());
        let color = [red, green, blue, alpha];

        log::debug!("ClearColor: ({red}, {green}, {blue})");
        // SAFETY: a four-float colour for a four-component draw buffer.
        unsafe {
            gl.clear_color(red, green, blue, alpha);
            gl.clear_bufferfv(glw::GL_COLOR, 0, color.as_ptr());
        }
        clear(&mut reference.get_access(), color);
    } else if gl_format == glw::GL_RGBA_INTEGER {
        let color = [
            rnd.get_uint32() as i32,
            rnd.get_uint32() as i32,
            rnd.get_uint32() as i32,
            rnd.get_uint32() as i32,
        ];
        log::debug!("ClearColor: ({}, {}, {})", color[0], color[1], color[2]);

        // SAFETY: a four-integer colour for a four-component integer draw buffer.
        unsafe {
            if gl_type == glw::GL_INT {
                gl.clear_bufferiv(glw::GL_COLOR, 0, color.as_ptr());
            } else {
                gl.clear_bufferuiv(glw::GL_COLOR, 0, color.as_ptr().cast());
            }
        }
        clear_int(&mut reference.get_access(), color);
    } else {
        case.fail(format!("unexpected read format {gl_format:#06x}"), "Fail");
        return None;
    }

    if !render(case, reference) {
        return None;
    }

    let row_width = if params.row_length == 0 {
        WIDTH
    } else {
        params.row_length
    } + params.skip_pixels;
    let pitch = row_pitch(params.alignment, pixel_size, row_width);
    let mut pixel_data = vec![0u8; (pitch * (HEIGHT + params.skip_rows)) as usize];

    // SAFETY: the buffer is at least as large as the pack parameters make GL write.
    unsafe {
        gl.read_pixels(0, 0, WIDTH, HEIGHT, gl_format, gl_type, pixel_data.as_mut_ptr().cast());
    }
    if let Err(e) = glu::expect_no_error(gl, "glReadPixels") {
        case.fail(e.to_string(), "Fail");
        return None;
    }

    Some(pixel_data)
}

/// `ReadPixelsTest::iterate`
fn read_pixels_test(case: &mut ApiCase<'_>, params: ReadPixelsParams, seed: u32) {
    let Some((format, pixel_size, gl_format, gl_type)) = get_format_info(case, params) else {
        return;
    };

    log::debug!(
        "Format: {}, Type: {}",
        glu::texture_format_name(gl_format).unwrap_or("<unknown>"),
        glu::type_name(gl_type).unwrap_or("<unknown>")
    );

    let mut reference = match TextureLevel::new(format, WIDTH as u32, HEIGHT as u32, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let gl = case.gl();
    // SAFETY: plain pack-parameter state on a current context.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, params.alignment);
        gl.pixel_storei(glw::GL_PACK_ROW_LENGTH, params.row_length);
        gl.pixel_storei(glw::GL_PACK_SKIP_ROWS, params.skip_rows);
        gl.pixel_storei(glw::GL_PACK_SKIP_PIXELS, params.skip_pixels);
        gl.viewport(0, 0, WIDTH, HEIGHT);
    }
    log::debug!("GL_PACK_ALIGNMENT: {}", params.alignment);
    log::debug!("GL_PACK_ROW_LENGTH: {}", params.row_length);
    log::debug!("GL_PACK_SKIP_ROWS: {}", params.skip_rows);
    log::debug!("GL_PACK_SKIP_PIXELS: {}", params.skip_pixels);

    let Some(pixel_data) = clear_color(case, params, gl_format, gl_type, &mut reference, pixel_size, seed) else {
        return;
    };

    let row_width = if params.row_length == 0 {
        WIDTH
    } else {
        params.row_length
    };
    let pitch = row_pitch(params.alignment, pixel_size, row_width);
    let offset = (pixel_size * params.skip_pixels + params.skip_rows * pitch) as usize;
    let result_access = ConstPixelBufferAccess::new_with_pitch(
        format,
        [WIDTH as u32, HEIGHT as u32, 1],
        [pixel_size as usize, pitch as usize, pitch as usize * HEIGHT as usize],
        &pixel_data[offset..],
    );

    // \note Renderbuffers are never multisampled.
    let target = case.context().render_target();
    let pixel_format = target.pixel_format();
    let format_bit_depths = get_texture_format_bit_depth(format);
    let threshold = |target_bits: i32, format_bits: i32| 2.0 / (1i64 << target_bits.min(format_bits)) as f32;
    let thresholds = [
        threshold(pixel_format.red_bits, format_bit_depths[0]),
        threshold(pixel_format.green_bits, format_bit_depths[1]),
        threshold(pixel_format.blue_bits, format_bit_depths[2]),
        threshold(pixel_format.alpha_bits, format_bit_depths[3]),
    ];

    if !params.use_render_buffer && target.num_samples > 1 {
        // Upstream converts both sides to RGBA8 and goes through `bilinearCompare`, whose
        // threshold is the same fraction scaled into 8-bit units.
        let reference_rgba8 = to_rgba8(&reference.get_const_access());
        let result_rgba8 = to_rgba8(&result_access);
        let byte_threshold = |t: f32| (256.0 * t).ceil() as u8;
        let ok = bilinear_compare(
            &reference_rgba8.get_const_access(),
            &result_rgba8.get_const_access(),
            None,
            thresholds.map(byte_threshold),
        );

        if !ok {
            case.fail("Result image comparison failed".to_string(), "Fail");
        }
    } else {
        let result = float_threshold_compare(&reference.get_const_access(), &result_access, thresholds);
        if !result.ok {
            case.fail(
                format!("Result image comparison failed, max difference {:?}", result.max_diff),
                "Fail",
            );
        }
    }
}

/// `tcu::copy` into an RGBA8 level - `bilinearCompare` only accepts that format.
fn to_rgba8(src: &ConstPixelBufferAccess<'_>) -> TextureLevel {
    let [width, height, _] = src.size();
    let mut dst = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        width,
        height,
        1,
    )
    .expect("RGBA8 is a storable format");
    {
        let mut access = dst.get_access();
        for y in 0..height {
            for x in 0..width {
                access.set_pixel(src.get_pixel(x, y, 0), x, y, 0);
            }
        }
    }
    dst
}

fn add_case(group: &mut TestCaseGroup, name: &str, params: ReadPixelsParams) {
    // `m_seed(deStringHash(name))` - the case's own name is its rng seed.
    let seed = de_string_hash(name);
    add_api_case(group, name.to_string(), move |case: &mut ApiCase<'_>| {
        read_pixels_test(case, params, seed)
    });
}

/// `ReadPixelsTests::init`
pub fn create_tests() -> TestCaseGroup {
    const NO_FLAGS: ReadPixelsParams = ReadPixelsParams {
        choose_format: false,
        use_render_buffer: false,
        alignment: 4,
        row_length: 0,
        skip_rows: 0,
        skip_pixels: 0,
        format: glw::GL_RGBA,
        type_: glw::GL_UNSIGNED_BYTE,
    };
    const USE_RBO: ReadPixelsParams = ReadPixelsParams {
        use_render_buffer: true,
        format: glw::GL_RGBA_INTEGER,
        type_: glw::GL_INT,
        ..NO_FLAGS
    };
    const CHOOSE_FORMAT: ReadPixelsParams = ReadPixelsParams {
        choose_format: true,
        ..NO_FLAGS
    };

    let mut group = TestCaseGroup::new("read_pixels");

    {
        let mut sub = TestCaseGroup::new("alignment");

        for alignment in [1, 2, 4, 8] {
            add_case(
                &mut sub,
                &format!("rgba_ubyte_{alignment}"),
                ReadPixelsParams { alignment, ..NO_FLAGS },
            );
        }
        for alignment in [1, 2, 4, 8] {
            add_case(
                &mut sub,
                &format!("rgba_int_{alignment}"),
                ReadPixelsParams { alignment, ..USE_RBO },
            );
        }
        for alignment in [1, 2, 4, 8] {
            add_case(
                &mut sub,
                &format!("rgba_uint_{alignment}"),
                ReadPixelsParams {
                    alignment,
                    type_: glw::GL_UNSIGNED_INT,
                    ..USE_RBO
                },
            );
        }
        for alignment in [1, 2, 4, 8] {
            add_case(
                &mut sub,
                &format!("choose_{alignment}"),
                ReadPixelsParams {
                    alignment,
                    ..CHOOSE_FORMAT
                },
            );
        }

        group.add_child(sub);
    }

    {
        let mut sub = TestCaseGroup::new("rowlength");

        for row_length in [17, 19, 23, 29] {
            add_case(
                &mut sub,
                &format!("rgba_ubyte_{row_length}"),
                ReadPixelsParams { row_length, ..NO_FLAGS },
            );
        }
        for row_length in [17, 19, 23, 29] {
            add_case(
                &mut sub,
                &format!("rgba_int_{row_length}"),
                ReadPixelsParams { row_length, ..USE_RBO },
            );
        }
        for row_length in [17, 19, 23, 29] {
            add_case(
                &mut sub,
                &format!("rgba_uint_{row_length}"),
                ReadPixelsParams {
                    row_length,
                    type_: glw::GL_UNSIGNED_INT,
                    ..USE_RBO
                },
            );
        }
        for row_length in [17, 19, 23, 29] {
            add_case(
                &mut sub,
                &format!("choose_{row_length}"),
                ReadPixelsParams {
                    row_length,
                    ..CHOOSE_FORMAT
                },
            );
        }

        group.add_child(sub);
    }

    {
        let mut sub = TestCaseGroup::new("skip");
        /// `(skipRows, skipPixels)` - upstream names the case `<skipRows>_<skipPixels>`.
        const SKIPS: [(i32, i32); 4] = [(0, 3), (3, 0), (3, 3), (3, 5)];

        for (skip_rows, skip_pixels) in SKIPS {
            add_case(
                &mut sub,
                &format!("rgba_ubyte_{skip_rows}_{skip_pixels}"),
                ReadPixelsParams {
                    row_length: 17,
                    skip_rows,
                    skip_pixels,
                    ..NO_FLAGS
                },
            );
        }
        for (skip_rows, skip_pixels) in SKIPS {
            add_case(
                &mut sub,
                &format!("rgba_int_{skip_rows}_{skip_pixels}"),
                ReadPixelsParams {
                    row_length: 17,
                    skip_rows,
                    skip_pixels,
                    ..USE_RBO
                },
            );
        }
        for (skip_rows, skip_pixels) in SKIPS {
            add_case(
                &mut sub,
                &format!("rgba_uint_{skip_rows}_{skip_pixels}"),
                ReadPixelsParams {
                    row_length: 17,
                    skip_rows,
                    skip_pixels,
                    type_: glw::GL_UNSIGNED_INT,
                    ..USE_RBO
                },
            );
        }
        for (skip_rows, skip_pixels) in SKIPS {
            add_case(
                &mut sub,
                &format!("choose_{skip_rows}_{skip_pixels}"),
                ReadPixelsParams {
                    row_length: 17,
                    skip_rows,
                    skip_pixels,
                    ..CHOOSE_FORMAT
                },
            );
        }

        group.add_child(sub);
    }

    group
}
