// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest12)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::utils::{Buffer, Framebuffer, Program, ProgramSources, Texture, VertexArray};
use super::{check_subroutine_support, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const TEXTURE_HEIGHT: GLuint = 16;
const TEXTURE_WIDTH: GLuint = 16;

const POINT_QUAD_GS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nvoid main()\n{\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4(-1,  1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4( 1, -1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4( 1,  1, 0, 1);\n    EmitVertex();\n    \n    EndPrimitive();\n}\n\n";

const EMPTY_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nvoid main()\n{\n}\n\n";

const ATOMIC_FS: &str = "#version 410 core\n#extension GL_ARB_shader_atomic_counters : require\n#extension GL_ARB_shader_subroutine      : require\n\nprecision highp float;\n\nlayout(location = 0) out uint out_color;\n\nlayout(binding = 0, offset = 8) uniform atomic_uint one;\nlayout(binding = 0, offset = 4) uniform atomic_uint two;\nlayout(binding = 0, offset = 0) uniform atomic_uint three;\n\nsubroutine void atomic_routine(void)\n;\nsubroutine(atomic_routine) void increment_two(void)\n{\n    out_color = atomicCounterIncrement(two);\n}\n\nsubroutine(atomic_routine) void decrement_three(void)\n{\n    out_color = atomicCounterDecrement(three);\n}\n\nsubroutine(atomic_routine) void read_one(void)\n{\n    out_color = atomicCounter(one);\n}\n\nsubroutine uniform atomic_routine routine;\n\nvoid main()\n{\n    routine();\n}\n\n";

const IMAGE_FS: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n#extension GL_ARB_shader_subroutine       : require\n\nprecision highp float;\n\nlayout(location = 0) out uvec4 out_color;\n\nlayout(rgba32ui) uniform uimage2D left_image;\nlayout(rgba32ui) uniform uimage2D right_image;\n\nsubroutine void image_routine(void);\n\nsubroutine(image_routine) void left_to_right(void)\n{\n    out_color = imageLoad (left_image,  ivec2(gl_FragCoord.xy));\n                imageStore(right_image, ivec2(gl_FragCoord.xy), out_color);\n}\n\nsubroutine(image_routine) void right_to_left(void)\n{\n    out_color = imageLoad (right_image, ivec2(gl_FragCoord.xy));\n                imageStore(left_image,  ivec2(gl_FragCoord.xy), out_color);\n}\n\nsubroutine uniform image_routine routine;\n\nvoid main()\n{\n    routine();\n}\n\n";

const SSBO_FS: &str = "#version 400 core\n#extension GL_ARB_shader_storage_buffer_object : require\n#extension GL_ARB_shader_subroutine            : require\n\nprecision highp float;\n\nlayout(location = 0) out uvec4 out_color;\n\nlayout(std140, binding = 0) buffer Buffer\n{\n    uvec4 entry;\n};\n\nsubroutine void ssbo_routine(void)\n;\nsubroutine(ssbo_routine) void increment(void)\n{\n    out_color.x = atomicAdd(entry.x, 1);\n    out_color.y = atomicAdd(entry.y, 1);\n    out_color.z = atomicAdd(entry.z, 1);\n    out_color.w = atomicAdd(entry.w, 1);\n}\n\nsubroutine(ssbo_routine) void decrement(void)\n{\n    out_color.x = atomicAdd(entry.x, -1);\n    out_color.y = atomicAdd(entry.y, -1);\n    out_color.z = atomicAdd(entry.z, -1);\n    out_color.w = atomicAdd(entry.w, -1);\n}\n\nsubroutine uniform ssbo_routine routine;\n\nvoid main()\n{\n    routine();\n}\n\n";

/// `FunctionalTest12::fillTexture`
fn fill_texture(texture: &Texture, color: &[GLuint; 4]) -> Result<(), TestError> {
    let texture_data: Vec<GLuint> = (0..TEXTURE_WIDTH * TEXTURE_HEIGHT).flat_map(|_| *color).collect();
    texture.update(
        TEXTURE_WIDTH,
        TEXTURE_HEIGHT,
        glw::GL_RGBA_INTEGER,
        glw::GL_UNSIGNED_INT,
        texture_data.as_ptr().cast(),
    )
}

/// `FunctionalTest12::verifyTexture`
fn verify_texture(texture: &Texture, expected_color: &[GLuint; 4]) -> Result<bool, TestError> {
    let mut results = vec![0 as GLuint; (TEXTURE_WIDTH * TEXTURE_HEIGHT * 4) as usize];
    texture.get(glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT, results.as_mut_ptr().cast())?;
    Ok(results.chunks_exact(4).all(|pixel| pixel == expected_color))
}

/// `glMapBuffer(target, GL_READ_ONLY)` read as `n_words` words and unmapped again.
fn read_buffer_words(context: &Context, target: GLenum, n_words: usize) -> Result<Vec<GLuint>, TestError> {
    let gl = context.gl();

    // SAFETY: the buffer holds at least `n_words` words.
    let mapped = unsafe { gl.map_buffer(target, glw::GL_READ_ONLY) };
    crate::glu::expect_no_error(gl, "MapBuffer")?;

    if mapped.is_null() {
        return super::fail("MapBuffer returned no pointer");
    }

    // SAFETY: the mapping is at least `n_words` words long and stays valid until the unmap below.
    let words = unsafe { std::slice::from_raw_parts(mapped.cast::<GLuint>(), n_words) }.to_vec();

    gl_call!(gl, "UnmapBuffer", gl.unmap_buffer(target));
    Ok(words)
}

/// `Utils::framebuffer` setup every `FunctionalTest12` part ends with: bound, attached to `color_texture`, cleared to zero.
fn prepare_framebuffer(framebuffer: &mut Framebuffer, color_texture: &Texture) -> Result<(), TestError> {
    framebuffer.generate()?;
    framebuffer.bind()?;
    framebuffer.attach_texture(
        glw::GL_COLOR_ATTACHMENT0,
        color_texture.id,
        TEXTURE_WIDTH,
        TEXTURE_HEIGHT,
    )?;
    framebuffer.clear_color(0.0, 0.0, 0.0, 0.0)?;
    framebuffer.clear(glw::GL_COLOR_BUFFER_BIT)
}

/// `FunctionalTest12`
pub(super) struct SsboAtomicImageLoadStore;

impl SsboAtomicImageLoadStore {
    /// `FunctionalTest12::testAtomicDraw`
    fn test_atomic_draw(
        context: &Context,
        subroutine_index: GLuint,
        expected_results: &[GLuint; 3],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_FRAGMENT_SHADER, 1, &subroutine_index)
        );
        gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let atomic_results = read_buffer_words(context, glw::GL_ATOMIC_COUNTER_BUFFER, 3)?;
        let result = atomic_results == expected_results;

        if !result {
            log::info!(
                "Error. Invalid result. Result: [ {}, {}, {} ] Expected: [ {}, {}, {} ]",
                atomic_results[0],
                atomic_results[1],
                atomic_results[2],
                expected_results[0],
                expected_results[1],
                expected_results[2]
            );
        }

        Ok(result)
    }

    /// `FunctionalTest12::testAtomic`
    fn test_atomic(context: &Context) -> Result<bool, TestError> {
        let atomic_buffer_data: [GLuint; 3] = [TEXTURE_WIDTH * TEXTURE_HEIGHT; 3];
        let expected_incremented_two = [atomic_buffer_data[0], 2 * atomic_buffer_data[1], atomic_buffer_data[2]];
        let expected_decremented_three = [0, expected_incremented_two[1], expected_incremented_two[2]];
        let expected_read_one = expected_decremented_three;

        let mut atomic_buffer = Buffer::new(context);
        let mut color_texture = Texture::new(context);
        let mut framebuffer = Framebuffer::new(context);
        let mut program = Program::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                fragment: Some(ATOMIC_FS),
                geometry: Some(POINT_QUAD_GS),
                vertex: Some(EMPTY_VS),
                ..Default::default()
            },
            &[],
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        color_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_R32UI)?;

        let data_size = std::mem::size_of_val(&atomic_buffer_data) as GLsizeiptr;
        atomic_buffer.generate()?;
        atomic_buffer.update(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            data_size,
            atomic_buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )?;
        atomic_buffer.bind_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 0, data_size)?;

        prepare_framebuffer(&mut framebuffer, &color_texture)?;

        let increment_two = program.get_subroutine_index("increment_two", glw::GL_FRAGMENT_SHADER)?;
        let decrement_three = program.get_subroutine_index("decrement_three", glw::GL_FRAGMENT_SHADER)?;
        let read_one = program.get_subroutine_index("read_one", glw::GL_FRAGMENT_SHADER)?;

        let mut result = true;

        if !Self::test_atomic_draw(context, increment_two, &expected_incremented_two)? {
            result = false;
        }
        if !Self::test_atomic_draw(context, decrement_three, &expected_decremented_three)? {
            result = false;
        }
        if !Self::test_atomic_draw(context, read_one, &expected_read_one)? {
            result = false;
        }

        Ok(result)
    }

    /// `FunctionalTest12::testImageDraw`
    fn test_image_draw(
        context: &Context,
        subroutine_index: GLuint,
        left: &Texture,
        right: &Texture,
        left_image: GLint,
        right_image: GLint,
        expected_left_color: &[GLuint; 4],
        expected_right_color: &[GLuint; 4],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_FRAGMENT_SHADER, 1, &subroutine_index)
        );
        gl_call!(gl, "Uniform1i", gl.uniform_1i(left_image, 0));
        gl_call!(gl, "Uniform1i", gl.uniform_1i(right_image, 1));
        gl_call!(
            gl,
            "BindImageTexture",
            gl.bind_image_texture(
                0,
                left.id,
                0,
                glw::GL_FALSE as glw::GLboolean,
                0,
                glw::GL_READ_WRITE,
                glw::GL_RGBA32UI
            )
        );
        gl_call!(
            gl,
            "BindImageTexture",
            gl.bind_image_texture(
                1,
                right.id,
                0,
                glw::GL_FALSE as glw::GLboolean,
                0,
                glw::GL_READ_WRITE,
                glw::GL_RGBA32UI
            )
        );
        gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut result = true;

        if !verify_texture(left, expected_left_color)? {
            log::info!("Error. Invalid result. Left texture is filled with wrong color.");
            result = false;
        }
        if !verify_texture(right, expected_right_color)? {
            log::info!("Error. Invalid result. Right texture is filled with wrong color.");
            result = false;
        }

        Ok(result)
    }

    /// `FunctionalTest12::testImage`
    fn test_image(context: &Context) -> Result<bool, TestError> {
        let blue_color: [GLuint; 4] = [0, 0, 255, 255];
        let clean_color: [GLuint; 4] = [16, 32, 64, 128];
        let red_color: [GLuint; 4] = [255, 0, 0, 255];

        let mut blue_texture = Texture::new(context);
        let mut destination_texture = Texture::new(context);
        let mut color_texture = Texture::new(context);
        let mut framebuffer = Framebuffer::new(context);
        let mut program = Program::new(context);
        let mut red_texture = Texture::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                fragment: Some(IMAGE_FS),
                geometry: Some(POINT_QUAD_GS),
                vertex: Some(EMPTY_VS),
                ..Default::default()
            },
            &[],
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        blue_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA32UI)?;
        destination_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA32UI)?;
        color_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA32UI)?;
        red_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA32UI)?;

        fill_texture(&blue_texture, &blue_color)?;
        fill_texture(&destination_texture, &clean_color)?;
        fill_texture(&red_texture, &red_color)?;

        prepare_framebuffer(&mut framebuffer, &color_texture)?;

        let left_to_right = program.get_subroutine_index("left_to_right", glw::GL_FRAGMENT_SHADER)?;
        let right_to_left = program.get_subroutine_index("right_to_left", glw::GL_FRAGMENT_SHADER)?;
        let left_image = program.get_uniform_location("left_image")?;
        let right_image = program.get_uniform_location("right_image")?;

        let mut result = true;

        let draws = [
            (
                left_to_right,
                &blue_texture,
                &destination_texture,
                &blue_color,
                &blue_color,
            ),
            (
                left_to_right,
                &red_texture,
                &destination_texture,
                &red_color,
                &red_color,
            ),
            (
                right_to_left,
                &destination_texture,
                &blue_texture,
                &blue_color,
                &blue_color,
            ),
            (
                right_to_left,
                &destination_texture,
                &red_texture,
                &red_color,
                &red_color,
            ),
            (left_to_right, &blue_texture, &red_texture, &blue_color, &blue_color),
        ];

        for (subroutine_index, left, right, expected_left_color, expected_right_color) in draws {
            if !Self::test_image_draw(
                context,
                subroutine_index,
                left,
                right,
                left_image,
                right_image,
                expected_left_color,
                expected_right_color,
            )? {
                result = false;
            }
        }

        Ok(result)
    }

    /// `FunctionalTest12::testSSBODraw`
    fn test_ssbo_draw(
        context: &Context,
        subroutine_index: GLuint,
        expected_results: &[GLuint; 4],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_FRAGMENT_SHADER, 1, &subroutine_index)
        );
        gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let ssbo_results = read_buffer_words(context, glw::GL_SHADER_STORAGE_BUFFER, 4)?;
        let result = ssbo_results == expected_results;

        if !result {
            log::info!(
                "Error. Invalid result. Result: [ {}, {}, {}, {} ] Expected: [ {}, {}, {}, {} ]",
                ssbo_results[0],
                ssbo_results[1],
                ssbo_results[2],
                ssbo_results[3],
                expected_results[0],
                expected_results[1],
                expected_results[2],
                expected_results[3]
            );
        }

        Ok(result)
    }

    /// `FunctionalTest12::testSSBO`
    fn test_ssbo(context: &Context) -> Result<bool, TestError> {
        let buffer_data: [GLuint; 4] = [
            TEXTURE_WIDTH * TEXTURE_HEIGHT + 1,
            TEXTURE_WIDTH * TEXTURE_HEIGHT + 2,
            TEXTURE_WIDTH * TEXTURE_HEIGHT + 3,
            TEXTURE_WIDTH * TEXTURE_HEIGHT + 4,
        ];
        let expected_incremented: [GLuint; 4] =
            std::array::from_fn(|i| TEXTURE_WIDTH * TEXTURE_HEIGHT + buffer_data[i]);
        let expected_decremented = buffer_data;

        let mut buffer = Buffer::new(context);
        let mut color_texture = Texture::new(context);
        let mut framebuffer = Framebuffer::new(context);
        let mut program = Program::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                fragment: Some(SSBO_FS),
                geometry: Some(POINT_QUAD_GS),
                vertex: Some(EMPTY_VS),
                ..Default::default()
            },
            &[],
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        color_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA32UI)?;

        let data_size = std::mem::size_of_val(&buffer_data) as GLsizeiptr;
        buffer.generate()?;
        buffer.update(
            glw::GL_SHADER_STORAGE_BUFFER,
            data_size,
            buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )?;
        buffer.bind_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 0, data_size)?;

        prepare_framebuffer(&mut framebuffer, &color_texture)?;

        let increment = program.get_subroutine_index("increment", glw::GL_FRAGMENT_SHADER)?;
        let decrement = program.get_subroutine_index("decrement", glw::GL_FRAGMENT_SHADER)?;

        let mut result = true;

        if !Self::test_ssbo_draw(context, increment, &expected_incremented)? {
            result = false;
        }
        if !Self::test_ssbo_draw(context, decrement, &expected_decremented)? {
            result = false;
        }

        Ok(result)
    }
}

impl TestCase for SsboAtomicImageLoadStore {
    fn name(&self) -> &str {
        "ssbo_atomic_image_load_store"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_subroutine_support(context)?;

        let mut result = true;

        if context
            .context_info
            .is_extension_supported("GL_ARB_shader_atomic_counters")
            && !Self::test_atomic(context)?
        {
            result = false;
        }

        if context
            .context_info
            .is_extension_supported("GL_ARB_shader_storage_buffer_object")
            && !Self::test_ssbo(context)?
        {
            result = false;
        }

        if context
            .context_info
            .is_extension_supported("GL_ARB_shader_image_load_store")
            && !Self::test_image(context)?
        {
            result = false;
        }

        verdict(result)
    }
}
