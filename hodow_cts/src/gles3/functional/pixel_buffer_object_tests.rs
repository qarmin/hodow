// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fPixelBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// There is no reference image anywhere in this group: it reads the same framebuffer twice,
// once into a pixel pack buffer and once into memory, and compares the two. What is drawn
// only has to be non-uniform, which is why it is a seeded pile of scissored clears or of
// random triangles.

use crate::glu::objects::BufferMemMap;
use crate::glu::texture_util::{map_gl_internal_format, map_gl_transfer_format};
use crate::glu::{self, ApiCase, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, get_texture_format_bit_depth};
use crate::tcu::texture::{TextureChannelClass, TextureFormat};
use crate::tcu::vector::UVec4;
use crate::tcu::{Random, de_string_hash};

/// `ReadPixelsTest::TestSpec::FramebufferType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum FramebufferType {
    Native,
    Renderbuffer,
}

/// `ReadPixelsTest::TestSpec`
#[derive(Clone, Copy)]
struct TestSpec {
    use_color_clear: bool,
    render_triangles: bool,
    framebuffer_type: FramebufferType,
    renderbuffer_format: GLenum,
}

/// The `m_colorScale` and `m_texChannelClass` the constructor derives from the spec.
fn color_scale_and_channel_class(spec: TestSpec) -> (f32, TextureChannelClass) {
    if spec.framebuffer_type == FramebufferType::Native {
        return (1.0, TextureChannelClass::Last);
    }

    let channel_class = map_gl_internal_format(spec.renderbuffer_format)
        .expect("a renderbuffer format this group declares")
        .channel_class();
    let color_scale = match channel_class {
        TextureChannelClass::UnsignedFixedPoint => 1.0,
        TextureChannelClass::SignedInteger
        | TextureChannelClass::UnsignedInteger
        | TextureChannelClass::FloatingPoint => 100.0,
        other => panic!("{other:?} is not a channel class this group declares"),
    };

    (color_scale, channel_class)
}

/// `ReadPixelsTest::init`'s extension check.
fn check_renderbuffer_format_supported(case: &mut ApiCase<'_>, spec: TestSpec) -> bool {
    if spec.framebuffer_type != FramebufferType::Renderbuffer {
        return true;
    }

    let info = &case.context().context_info;
    let supported = match spec.renderbuffer_format {
        glw::GL_RGBA16F | glw::GL_RG16F => {
            info.is_extension_supported("GL_EXT_color_buffer_half_float")
                || info.is_extension_supported("GL_EXT_color_buffer_float")
        }
        glw::GL_RGBA32F | glw::GL_RG32F | glw::GL_R11F_G11F_B10F => {
            info.is_extension_supported("GL_EXT_color_buffer_float")
        }
        _ => true,
    };

    if !supported {
        case.not_supported("Renderbuffer format not supported");
    }
    supported
}

/// `ReadPixelsTest::init`'s program - the fragment output type follows the channel class.
fn build_program<'gl>(
    case: &mut ApiCase<'gl>,
    channel_class: TextureChannelClass,
    framebuffer_type: FramebufferType,
) -> Option<ShaderProgram<'gl>> {
    let outtype = if framebuffer_type == FramebufferType::Native {
        "vec4"
    } else {
        match channel_class {
            TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::FloatingPoint => "vec4",
            TextureChannelClass::SignedInteger => "ivec4",
            TextureChannelClass::UnsignedInteger => "uvec4",
            other => panic!("{other:?} is not a channel class this group declares"),
        }
    };

    let vertex_source = "#version 300 es\n\
                         in mediump vec3 a_position;\n\
                         in mediump vec4 a_color;\n\
                         uniform mediump float u_colorScale;\n\
                         out mediump vec4 v_color;\n\
                         void main(void)\n\
                         {\n\
                         \tgl_Position = vec4(a_position, 1.0);\n\
                         \tv_color = u_colorScale * a_color;\n\
                         }";
    let fragment_source = format!(
        "#version 300 es\n\
         in mediump vec4 v_color;\n\
         layout (location = 0) out mediump {outtype} o_color;\n\
         void main(void)\n\
         {{\n\
         \to_color = {outtype}(v_color);\n\
         }}"
    );

    let program = ShaderProgram::new(case.gl(), &ProgramSources::vtx_frag(vertex_source, &fragment_source));
    if !program.is_ok() {
        case.fail("Failed to compile shader".to_string(), "Failed to compile shader");
        return None;
    }
    Some(program)
}

/// `ReadPixelsTest::renderTriangle`
///
/// # Safety
/// A current context and a linked program whose attributes are the ones named here.
unsafe fn render_triangle(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    color_scale: f32,
    a: [f32; 3],
    b: [f32; 3],
    c: [f32; 3],
) {
    let positions = [a[0], a[1], a[2], b[0], b[1], b[2], c[0], c[1], c[2]];
    const COLORS: [f32; 12] = [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0];

    // SAFETY: the two client-side arrays hold exactly the three vertices drawn.
    unsafe {
        gl.use_program(program.program());

        let color_scale_loc = gl.get_uniform_location(program.program(), c"u_colorScale".as_ptr());
        gl.uniform_1f(color_scale_loc, color_scale);

        let coord_loc = gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as u32;
        let color_loc = gl.get_attrib_location(program.program(), c"a_color".as_ptr()) as u32;

        gl.enable_vertex_attrib_array(color_loc);
        gl.enable_vertex_attrib_array(coord_loc);
        gl.vertex_attrib_pointer(coord_loc, 3, glw::GL_FLOAT, glw::FALSE, 0, positions.as_ptr().cast());
        gl.vertex_attrib_pointer(color_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, COLORS.as_ptr().cast());
        gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        gl.disable_vertex_attrib_array(color_loc);
        gl.disable_vertex_attrib_array(coord_loc);
    }
}

/// `ReadPixelsTest::clearColor`
///
/// # Safety
/// A current context with the target framebuffer bound.
unsafe fn clear_color(
    gl: &glw::Functions,
    framebuffer_type: FramebufferType,
    channel_class: TextureChannelClass,
    r: f32,
    g: f32,
    b: f32,
    a: f32,
) {
    // SAFETY: each clear gives four components for a four-component draw buffer.
    unsafe {
        if framebuffer_type == FramebufferType::Native || channel_class == TextureChannelClass::UnsignedFixedPoint {
            gl.clear_color(r, g, b, a);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            return;
        }

        match channel_class {
            TextureChannelClass::SignedInteger => {
                let color = [r as i32, g as i32, b as i32, a as i32];
                gl.clear_bufferiv(glw::GL_COLOR, 0, color.as_ptr());
            }
            TextureChannelClass::UnsignedInteger => {
                let color = [r as u32, g as u32, b as u32, a as u32];
                gl.clear_bufferuiv(glw::GL_COLOR, 0, color.as_ptr());
            }
            TextureChannelClass::FloatingPoint => {
                let color = [r, g, b, a];
                gl.clear_bufferfv(glw::GL_COLOR, 0, color.as_ptr());
            }
            other => panic!("{other:?} is not a channel class this group declares"),
        }
    }
}

/// The read-back format the framebuffer's channel class calls for, and whether the
/// comparison is a float one.
fn read_format_for(
    framebuffer_type: FramebufferType,
    channel_class: TextureChannelClass,
) -> (TextureFormat, GLenum, GLenum, bool) {
    let (gl_format, gl_type, float_compare) = if framebuffer_type == FramebufferType::Native {
        (glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, false)
    } else {
        match channel_class {
            TextureChannelClass::UnsignedFixedPoint => (glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, true),
            TextureChannelClass::SignedInteger => (glw::GL_RGBA_INTEGER, glw::GL_INT, false),
            TextureChannelClass::UnsignedInteger => (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT, false),
            TextureChannelClass::FloatingPoint => (glw::GL_RGBA, glw::GL_FLOAT, true),
            other => panic!("{other:?} is not a channel class this group declares"),
        }
    };

    let format = map_gl_transfer_format(gl_format, gl_type).expect("a transfer format this group declares");
    (format, gl_format, gl_type, float_compare)
}

/// `ReadPixelsTest::iterate`
fn read_pixels_test(case: &mut ApiCase<'_>, spec: TestSpec, seed: u32) {
    if !check_renderbuffer_format_supported(case, spec) {
        return;
    }

    let (color_scale, channel_class) = color_scale_and_channel_class(spec);
    let Some(program) = build_program(case, channel_class, spec.framebuffer_type) else {
        return;
    };

    let mut random = Random::new(seed);
    let gl = case.gl();
    let target = case.context().render_target();
    let width = target.width;
    let height = target.height;
    let framebuffer = glu::Framebuffer::new(gl);
    let renderbuffer = glu::Renderbuffer::new(gl);

    // SAFETY: names this function just created, on a current context.
    unsafe {
        match spec.framebuffer_type {
            FramebufferType::Native => gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0),
            FramebufferType::Renderbuffer => {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer.get());
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, spec.renderbuffer_format, width, height);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    renderbuffer.get(),
                );
            }
        }

        clear_color(
            gl,
            spec.framebuffer_type,
            channel_class,
            color_scale * 0.4,
            color_scale,
            color_scale * 0.5,
            color_scale,
        );

        if spec.use_color_clear {
            const MAX_CLEAR_COUNT: i32 = 10;
            const MIN_CLEAR_COUNT: i32 = 6;
            const MIN_CLEAR_SIZE: i32 = 15;

            let clear_count = random.get_int(MIN_CLEAR_COUNT, MAX_CLEAR_COUNT);

            for _ in 0..clear_count {
                let clear_x = random.get_int(0, width - MIN_CLEAR_SIZE);
                let clear_y = random.get_int(0, height - MIN_CLEAR_SIZE);
                let clear_width = random.get_int(MIN_CLEAR_SIZE, width - clear_x);
                let clear_height = random.get_int(MIN_CLEAR_SIZE, height - clear_y);

                let clear_red = color_scale * random.get_float();
                let clear_green = color_scale * random.get_float();
                let clear_blue = color_scale * random.get_float();
                let clear_alpha = color_scale * (0.5 + 0.5 * random.get_float());

                gl.enable(glw::GL_SCISSOR_TEST);
                gl.scissor(clear_x, clear_y, clear_width, clear_height);

                clear_color(
                    gl,
                    spec.framebuffer_type,
                    channel_class,
                    clear_red,
                    clear_green,
                    clear_blue,
                    clear_alpha,
                );
            }

            gl.disable(glw::GL_SCISSOR_TEST);
        }

        if spec.render_triangles {
            const MIN_TRIANGLE_COUNT: i32 = 4;
            const MAX_TRIANGLE_COUNT: i32 = 10;

            let triangle_count = random.get_int(MIN_TRIANGLE_COUNT, MAX_TRIANGLE_COUNT);

            for _ in 0..triangle_count {
                let mut vertex = || {
                    [
                        2.0 * random.get_float() - 1.0,
                        2.0 * random.get_float() - 1.0,
                        2.0 * random.get_float() - 1.0,
                    ]
                };
                let (a, b, c) = (vertex(), vertex(), vertex());
                render_triangle(gl, &program, color_scale, a, b, c);
            }
        }
    }

    let (read_format, read_pixels_format, read_pixels_type, float_compare) =
        read_format_for(spec.framebuffer_type, channel_class);
    let pixel_size = read_format.pixel_size().expect("a sized format") as i32;
    let read_data_size = width * height * pixel_size;

    let mut read_reference = match TextureLevel::new(read_format, width as u32, height as u32, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let pixel_buffer = glu::Buffer::new(gl);
    let mut read_result_data = vec![0u8; read_data_size as usize];

    // SAFETY: the pack buffer is sized for exactly the region read into it, and the map
    // is copied out before the buffer is unbound.
    unsafe {
        gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, pixel_buffer.get());
        gl.buffer_data(
            glw::GL_PIXEL_PACK_BUFFER,
            read_data_size as isize,
            std::ptr::null(),
            glw::GL_STREAM_READ,
        );
        gl.read_pixels(
            0,
            0,
            width,
            height,
            read_pixels_format,
            read_pixels_type,
            std::ptr::null_mut(),
        );

        let Some(buf_map) = BufferMemMap::new(
            gl,
            glw::GL_PIXEL_PACK_BUFFER,
            0,
            read_data_size as isize,
            glw::GL_MAP_READ_BIT,
        ) else {
            case.fail("glMapBufferRange() failed".to_string(), "Fail");
            return;
        };
        read_result_data.copy_from_slice(std::slice::from_raw_parts(
            buf_map.get().cast::<u8>(),
            read_data_size as usize,
        ));
        drop(buf_map);

        gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
        gl.read_pixels(
            0,
            0,
            width,
            height,
            read_pixels_format,
            read_pixels_type,
            read_reference.data_mut().as_mut_ptr().cast(),
        );
    }
    if let Err(e) = glu::expect_no_error(gl, "glReadPixels") {
        case.fail(e.to_string(), "Fail");
        return;
    }

    let read_result = ConstPixelBufferAccess::new(read_format, [width as u32, height as u32, 1], &read_result_data);

    let is_ok = if float_compare {
        let pixel_format = target.pixel_format();
        let format_bit_depths = get_texture_format_bit_depth(read_format);
        let threshold = |target_bits: i32, format_bits: i32| 2.0 / (1i64 << target_bits.min(format_bits)) as f32;
        let thresholds = [
            threshold(pixel_format.red_bits, format_bit_depths[0]),
            threshold(pixel_format.green_bits, format_bit_depths[1]),
            threshold(pixel_format.blue_bits, format_bit_depths[2]),
            threshold(pixel_format.alpha_bits, format_bit_depths[3]),
        ];
        float_threshold_compare(&read_reference.get_const_access(), &read_result, thresholds).ok
    } else {
        int_threshold_compare(
            &read_reference.get_const_access(),
            &read_result,
            UVec4::from_array([0; 4]),
        )
        .ok
    };

    if !is_ok {
        case.fail(
            "Result of read pixels to memory differs from result of read pixels to buffer".to_string(),
            "Result comparision failed",
        );
    }
}

/// `renderbufferFormats` / `renderbufferFormatsStr`
const RENDERBUFFER_FORMATS: [(GLenum, &str); 26] = [
    (glw::GL_RGBA8, "rgba8"),
    (glw::GL_RGBA8I, "rgba8i"),
    (glw::GL_RGBA8UI, "rgba8ui"),
    (glw::GL_RGBA16F, "rgba16f"),
    (glw::GL_RGBA16I, "rgba16i"),
    (glw::GL_RGBA16UI, "rgba16ui"),
    (glw::GL_RGBA32F, "rgba32f"),
    (glw::GL_RGBA32I, "rgba32i"),
    (glw::GL_RGBA32UI, "rgba32ui"),
    (glw::GL_SRGB8_ALPHA8, "srgb8_alpha8"),
    (glw::GL_RGB10_A2, "rgb10_a2"),
    (glw::GL_RGB10_A2UI, "rgb10_a2ui"),
    (glw::GL_RGBA4, "rgba4"),
    (glw::GL_RGB5_A1, "rgb5_a1"),
    (glw::GL_RGB8, "rgb8"),
    (glw::GL_RGB565, "rgb565"),
    (glw::GL_R11F_G11F_B10F, "r11f_g11f_b10f"),
    (glw::GL_RG8, "rg8"),
    (glw::GL_RG8I, "rg8i"),
    (glw::GL_RG8UI, "rg8ui"),
    (glw::GL_RG16F, "rg16f"),
    (glw::GL_RG16I, "rg16i"),
    (glw::GL_RG16UI, "rg16ui"),
    (glw::GL_RG32F, "rg32f"),
    (glw::GL_RG32I, "rg32i"),
    (glw::GL_RG32UI, "rg32ui"),
];

fn add_case(group: &mut TestCaseGroup, name: String, spec: TestSpec) {
    // `m_random(deStringHash(spec.name))` - the case's own name is its rng seed.
    let seed = de_string_hash(&name);
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        read_pixels_test(case, spec, seed)
    });
}

/// `PixelBufferObjectTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pbo");

    {
        let mut native = TestCaseGroup::new("native");

        for (name, use_color_clear, render_triangles) in [("clears", true, false), ("triangles", false, true)] {
            add_case(
                &mut native,
                name.to_string(),
                TestSpec {
                    use_color_clear,
                    render_triangles,
                    framebuffer_type: FramebufferType::Native,
                    renderbuffer_format: glw::GL_NONE,
                },
            );
        }

        group.add_child(native);
    }

    {
        let mut renderbuffer = TestCaseGroup::new("renderbuffer");

        for (format, format_name) in RENDERBUFFER_FORMATS {
            for triangles_clears in 0..2 {
                let name = format!(
                    "{format_name}_{}",
                    if triangles_clears == 0 { "triangles" } else { "clears" }
                );
                add_case(
                    &mut renderbuffer,
                    name,
                    TestSpec {
                        use_color_clear: triangles_clears == 1,
                        render_triangles: triangles_clears == 0,
                        framebuffer_type: FramebufferType::Renderbuffer,
                        renderbuffer_format: format,
                    },
                );
            }
        }

        group.add_child(renderbuffer);
    }

    group
}
