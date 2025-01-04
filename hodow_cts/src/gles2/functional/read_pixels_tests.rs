// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fReadPixelsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ES 2.0 half of the same idea as `gles3::functional::read_pixels_tests`, and a
// separate port rather than a shared one because upstream keeps them separate and they
// differ in more than the shader version: there is no renderbuffer path, no
// GL_PACK_ROW_LENGTH / SKIP_ROWS / SKIP_PIXELS (ES 2.0 has none of them) and no integer
// colour buffer, so only GL_PACK_ALIGNMENT is varied.

use crate::glu::texture_util::map_gl_transfer_format;
use crate::glu::{self, ApiCase, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear, get_texture_format_bit_depth};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{Random, de_string_hash};

/// `ReadPixelsTest::m_width` / `m_height`, which upstream writes as locals here.
const WIDTH: i32 = 13;
const HEIGHT: i32 = 13;

/// `ReadPixelsTest::render` - draws the quad and fills the same rectangle in `reference`.
fn render(case: &mut ApiCase<'_>, reference: &mut TextureLevel) -> bool {
    let gl = case.gl();

    // Create program.
    let vertex_source = "attribute mediump vec2 a_coord;\n\
                         void main (void)\n\
                         {\n\
                         \tgl_Position = vec4(a_coord, 0.0, 1.0);\n\
                         }\n";
    let fragment_source = "void main (void)\n\
                           {\n\
                           \tgl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);\n\
                           }\n";

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_source, fragment_source));
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

        let coord_loc = gl.get_attrib_location(program.program(), c"a_coord".as_ptr());
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
                access.set_pixel([0.0, 0.0, 0.0, 1.0], x as u32, y as u32, 0);
            }
        }
    }

    true
}

/// `ReadPixelsTest::getFormatInfo` - `None` means upstream's `NotSupportedError`.
fn get_format_info(case: &mut ApiCase<'_>, choose_format: bool) -> Option<(TextureFormat, i32, GLenum, GLenum)> {
    if choose_format {
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

        let format = map_gl_transfer_format(gl_format, gl_type)?;
        let pixel_size = format.pixel_size()? as i32;
        Some((format, pixel_size, gl_format, gl_type))
    } else {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        // Upstream writes the pixel size as `1 * 4` - one byte per channel, four channels.
        Some((format, 4, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE))
    }
}

/// `ReadPixelsTest::iterate`
fn read_pixels_test(case: &mut ApiCase<'_>, choose_format: bool, alignment: i32, seed: u32) {
    let mut rnd = Random::new(seed);

    let Some((format, pixel_size, gl_format, gl_type)) = get_format_info(case, choose_format) else {
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
    // SAFETY: plain viewport state on a current context.
    unsafe { gl.viewport(0, 0, WIDTH, HEIGHT) };

    // Clear color.
    {
        let (red, green, blue) = (rnd.get_float(), rnd.get_float(), rnd.get_float());
        let alpha = 1.0f32;

        log::debug!("Clear color: ({red}, {green}, {blue}, {alpha})");

        // SAFETY: plain clear state on a current context.
        unsafe {
            gl.clear_color(red, green, blue, alpha);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        clear(&mut reference.get_access(), [red, green, blue, alpha]);
    }

    if !render(case, &mut reference) {
        return;
    }

    let row_pitch = alignment * ((pixel_size * WIDTH) as f32 / alignment as f32).ceil() as i32;
    let mut pixel_data = vec![0u8; (row_pitch * HEIGHT) as usize];

    // SAFETY: the buffer is exactly the size GL_PACK_ALIGNMENT makes GL write.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, alignment);
        gl.read_pixels(0, 0, WIDTH, HEIGHT, gl_format, gl_type, pixel_data.as_mut_ptr().cast());
    }
    if let Err(e) = glu::expect_no_error(gl, "glReadPixels") {
        case.fail(e.to_string(), "Fail");
        return;
    }

    let result_access = ConstPixelBufferAccess::new_with_pitch(
        format,
        [WIDTH as u32, HEIGHT as u32, 1],
        [
            pixel_size as usize,
            row_pitch as usize,
            row_pitch as usize * HEIGHT as usize,
        ],
        &pixel_data,
    );

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

    if target.num_samples > 1 {
        // `bilinearCompare` only accepts RGBA8, and its threshold is the same fraction
        // scaled into 8-bit units.
        let reference_rgba8 = to_rgba8(&reference.get_const_access());
        let result_rgba8 = to_rgba8(&result_access);
        let byte_threshold = |t: f32| (256.0 * t).ceil() as u8;

        if !bilinear_compare(
            &reference_rgba8.get_const_access(),
            &result_rgba8.get_const_access(),
            None,
            thresholds.map(byte_threshold),
        ) {
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

/// `ReadPixelsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("read_pixels");

    for (choose_format, prefix) in [(false, "rgba_ubyte_align"), (true, "choose_align")] {
        for alignment in [1, 2, 4, 8] {
            let name = format!("{prefix}_{alignment}");
            // `m_seed(deStringHash(name))` - the case's own name is its rng seed.
            let seed = de_string_hash(&name);
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                read_pixels_test(case, choose_format, alignment, seed)
            });
        }
    }

    group
}
