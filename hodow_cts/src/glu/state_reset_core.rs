// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluStateReset.cpp (`resetStateGLCore`, `resetState`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The per-target texture blocks, which upstream
// spells out call by call, are a table (`TEXTURE_TARGETS`) with the same calls in the same order;
// everything else follows upstream's section order. Like `reset_state_es`, an error raised while
// resetting is logged rather than failing a case that has already been judged.
//
// This is what the Khronos GL CTS runs after every case (`TestCaseWrapper::deinit`).

use crate::glu::{Context, ContextType};
use crate::glw;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Swizzle {
    /// Core 3.3, where `ARB_texture_swizzle` became core.
    Since33,
    Always,
}

#[derive(Clone, Copy)]
enum Image {
    None,
    /// `glTexImage1D`
    Image1D,
    /// `glTexImage2D` on the target itself
    Image2D,
    /// `glTexImage3D` on the target itself
    Image3D,
}

/// One texture target's reset, from the matching block in `resetStateGLCore`.
struct TextureTarget {
    target: glw::GLenum,
    image: Image,
    min_filter: glw::GLenum,
    wrap_clamp_to_edge: bool,
    wrap_t: bool,
    wrap_r: bool,
    /// `GL_TEXTURE_MIN_LOD`/`MAX_LOD` and `GL_TEXTURE_LOD_BIAS`. Rectangle textures take neither (upstream's
    /// "Drivers don't accept GL_MIN_LOD, GL_MAX_LOD for rectangle textures"), cube arrays no bias.
    min_max_lod: bool,
    lod_bias: bool,
    swizzle: Swizzle,
    /// Multisample targets have no sampler state, only swizzle and levels.
    sampler_state: bool,
}

const fn target(target: glw::GLenum, image: Image) -> TextureTarget {
    TextureTarget {
        target,
        image,
        min_filter: glw::GL_NEAREST_MIPMAP_LINEAR,
        wrap_clamp_to_edge: false,
        wrap_t: true,
        wrap_r: false,
        min_max_lod: true,
        lod_bias: true,
        swizzle: Swizzle::Since33,
        sampler_state: true,
    }
}

const TEXTURE_1D: TextureTarget = TextureTarget {
    wrap_t: false,
    ..target(glw::GL_TEXTURE_1D, Image::Image1D)
};
const TEXTURE_2D: TextureTarget = target(glw::GL_TEXTURE_2D, Image::Image2D);
const TEXTURE_CUBE_MAP: TextureTarget = target(glw::GL_TEXTURE_CUBE_MAP, Image::None);
const TEXTURE_CUBE_MAP_ARRAY: TextureTarget = TextureTarget {
    lod_bias: false,
    swizzle: Swizzle::Always,
    ..target(glw::GL_TEXTURE_CUBE_MAP_ARRAY, Image::None)
};
const TEXTURE_1D_ARRAY: TextureTarget = TextureTarget {
    wrap_t: false,
    ..target(glw::GL_TEXTURE_1D_ARRAY, Image::Image2D)
};
const TEXTURE_2D_ARRAY: TextureTarget = target(glw::GL_TEXTURE_2D_ARRAY, Image::Image3D);
const TEXTURE_3D: TextureTarget = TextureTarget {
    wrap_r: true,
    ..target(glw::GL_TEXTURE_3D, Image::Image3D)
};
const TEXTURE_RECTANGLE: TextureTarget = TextureTarget {
    min_filter: glw::GL_LINEAR,
    wrap_clamp_to_edge: true,
    min_max_lod: false,
    lod_bias: false,
    ..target(glw::GL_TEXTURE_RECTANGLE, Image::Image2D)
};
const TEXTURE_2D_MULTISAMPLE: TextureTarget = TextureTarget {
    swizzle: Swizzle::Always,
    sampler_state: false,
    ..target(glw::GL_TEXTURE_2D_MULTISAMPLE, Image::None)
};
const TEXTURE_2D_MULTISAMPLE_ARRAY: TextureTarget = TextureTarget {
    swizzle: Swizzle::Always,
    sampler_state: false,
    ..target(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, Image::None)
};

const CUBE_FACES: [glw::GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `glu::resetState` for a desktop core context (`resetStateGLCore`).
pub fn reset_state_gl_core(context: &Context) {
    let gl = context.gl();
    let context_type = context.context_type();
    let target = context.render_target();

    super::drain_errors(gl);

    // SAFETY: every call below is a state setter with in-range arguments on a current context. The only
    // pointers involved are into local arrays sized for what the call reads or writes.
    unsafe {
        // Primitives and vertices state.
        if context_type.supports_core(4, 0) {
            const DEFAULT_TESS_LEVELS: [f32; 4] = [1.0, 1.0, 1.0, 1.0];
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, DEFAULT_TESS_LEVELS.as_ptr());
            gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, DEFAULT_TESS_LEVELS.as_ptr());
        }

        // Vertex attrib array state.
        gl.bind_vertex_array(0);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        if context_type.supports_core(3, 1) {
            gl.disable(glw::GL_PRIMITIVE_RESTART);
            gl.primitive_restart_index(0);
        }

        // Transformation state.
        let mut num_user_clip_planes = 0;
        gl.get_integerv(glw::GL_MAX_CLIP_DISTANCES, &mut num_user_clip_planes);
        gl.viewport(0, 0, target.width, target.height);
        gl.depth_range(0.0, 1.0);
        for ndx in 0..num_user_clip_planes as u32 {
            gl.disable(glw::GL_CLIP_DISTANCE0 + ndx);
        }
        if context_type.supports_core(3, 2) {
            gl.disable(glw::GL_DEPTH_CLAMP);
        }

        // Coloring.
        gl.clamp_color(glw::GL_CLAMP_READ_COLOR, glw::GL_FIXED_ONLY);
        if context_type.supports_core(3, 2) {
            gl.provoking_vertex(glw::GL_LAST_VERTEX_CONVENTION);
        }

        rasterization_state(gl);
        multisampling_state(gl, context_type);
        texture_state(gl, context_type, context);
        pixel_operations(gl, target.width, target.height);

        // Framebuffer control.
        gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
        gl.depth_mask(glw::TRUE);
        gl.stencil_mask(!0u32);
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear_depth(1.0);
        gl.clear_stencil(0);

        framebuffer_state(gl);

        // Renderbuffer state.
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);

        pixel_transfer_state(gl);
        program_object_state(gl, context_type);

        // Vertex shader state.
        let mut num_vertex_attrib_arrays = 0;
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut num_vertex_attrib_arrays);
        for ndx in 0..num_vertex_attrib_arrays as u32 {
            gl.vertex_attrib_4f(ndx, 0.0, 0.0, 0.0, 1.0);
        }
        gl.disable(glw::GL_VERTEX_PROGRAM_POINT_SIZE);

        transform_feedback_state(gl, context_type);
        asynchronous_query_state(gl);

        // Hints.
        gl.hint(glw::GL_LINE_SMOOTH_HINT, glw::GL_DONT_CARE);
        gl.hint(glw::GL_POLYGON_SMOOTH_HINT, glw::GL_DONT_CARE);
        gl.hint(glw::GL_TEXTURE_COMPRESSION_HINT, glw::GL_DONT_CARE);
        gl.hint(glw::GL_FRAGMENT_SHADER_DERIVATIVE_HINT, glw::GL_DONT_CARE);

        // Buffer copy state.
        if context_type.supports_core(3, 1) {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, 0);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, 0);
        }

        // Images.
        if context_type.supports_core(4, 4) {
            let mut num_image_units = 0;
            gl.get_integerv(glw::GL_MAX_IMAGE_UNITS, &mut num_image_units);
            for ndx in 0..num_image_units as u32 {
                gl.bind_image_texture(ndx, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_R8);
            }
        }

        // Sample shading state.
        if context_type.supports_core(4, 0) {
            gl.min_sample_shading(0.0);
            gl.disable(glw::GL_SAMPLE_SHADING);
        }

        // Debug state. Some drivers advertise GL_KHR_debug and hand out null pointers; upstream ignores that silently, so does this.
        if context.context_info.is_extension_supported("GL_KHR_debug")
            && gl.debug_message_control.is_some()
            && gl.debug_message_callback.is_some()
        {
            gl.debug_message_control(
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                0,
                std::ptr::null(),
                glw::TRUE,
            );
            gl.debug_message_control(
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                glw::GL_DEBUG_SEVERITY_LOW,
                0,
                std::ptr::null(),
                glw::FALSE,
            );
            gl.debug_message_callback(None, std::ptr::null());
            // The contexts this suite creates carry no CONTEXT_DEBUG flag.
            gl.disable(glw::GL_DEBUG_OUTPUT);
        }
    }

    let left_over = super::drain_errors(gl);
    if left_over > 0 {
        log::warn!("{left_over} GL error(s) raised while resetting state between cases");
    }
}

unsafe fn rasterization_state(gl: &glw::Functions) {
    unsafe {
        gl.disable(glw::GL_RASTERIZER_DISCARD);
        gl.point_size(1.0);
        gl.point_parameterf(glw::GL_POINT_FADE_THRESHOLD_SIZE, 1.0);
        gl.point_parameteri(glw::GL_POINT_SPRITE_COORD_ORIGIN, glw::GL_UPPER_LEFT as i32);
        gl.line_width(1.0);
        gl.disable(glw::GL_LINE_SMOOTH);
        gl.disable(glw::GL_CULL_FACE);
        gl.cull_face(glw::GL_BACK);
        gl.front_face(glw::GL_CCW);
        gl.disable(glw::GL_POLYGON_SMOOTH);
        gl.polygon_offset(0.0, 0.0);
        gl.disable(glw::GL_POLYGON_OFFSET_POINT);
        gl.disable(glw::GL_POLYGON_OFFSET_LINE);
        gl.disable(glw::GL_POLYGON_OFFSET_FILL);
    }
}

unsafe fn multisampling_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.enable(glw::GL_MULTISAMPLE);
        gl.disable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
        gl.disable(glw::GL_SAMPLE_ALPHA_TO_ONE);
        gl.disable(glw::GL_SAMPLE_COVERAGE);
        gl.sample_coverage(1.0, glw::FALSE);

        if context_type.supports_core(3, 2) {
            let mut num_sample_mask_words = 0;
            gl.get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut num_sample_mask_words);
            gl.disable(glw::GL_SAMPLE_MASK);
            for ndx in 0..num_sample_mask_words as u32 {
                gl.sample_maski(ndx, !0u32);
            }
        }
    }
}

/// The texture state, per texture unit. Upstream's `\todo [2013-04-08 pyry] Reset all levels?` still stands: only level 0 is reset.
unsafe fn texture_state(gl: &glw::Functions, context_type: ContextType, context: &Context) {
    const BORDER_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 0.0];
    let supports_cubemap_array = context
        .context_info
        .is_extension_supported("GL_ARB_texture_cube_map_array")
        || context_type.supports_core(4, 0);

    unsafe {
        let mut num_tex_units = 0;
        gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut num_tex_units);

        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0);

        for ndx in 0..num_tex_units as u32 {
            gl.active_texture(glw::GL_TEXTURE0 + ndx);

            reset_target(gl, context_type, &TEXTURE_1D, &BORDER_COLOR);
            reset_target(gl, context_type, &TEXTURE_2D, &BORDER_COLOR);
            reset_target(gl, context_type, &TEXTURE_CUBE_MAP, &BORDER_COLOR);
            if supports_cubemap_array {
                reset_target(gl, context_type, &TEXTURE_CUBE_MAP_ARRAY, &BORDER_COLOR);
            }
            reset_target(gl, context_type, &TEXTURE_1D_ARRAY, &BORDER_COLOR);
            reset_target(gl, context_type, &TEXTURE_2D_ARRAY, &BORDER_COLOR);
            reset_target(gl, context_type, &TEXTURE_3D, &BORDER_COLOR);

            if context_type.supports_core(3, 1) {
                reset_target(gl, context_type, &TEXTURE_RECTANGLE, &BORDER_COLOR);

                // Buffer texture. Upstream: "\todo [2013-05-04 pyry] Which parameters apply to buffer textures?"
                gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0);
                gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R8, 0);
            }

            if context_type.supports_core(3, 2) {
                reset_target(gl, context_type, &TEXTURE_2D_MULTISAMPLE, &BORDER_COLOR);
                gl.tex_image_2d_multisample(glw::GL_TEXTURE_2D_MULTISAMPLE, 1, glw::GL_RGBA8, 0, 0, glw::TRUE);

                reset_target(gl, context_type, &TEXTURE_2D_MULTISAMPLE_ARRAY, &BORDER_COLOR);
                gl.tex_image_3d_multisample(
                    glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                    1,
                    glw::GL_RGBA8,
                    0,
                    0,
                    0,
                    glw::TRUE,
                );
            }
        }

        gl.active_texture(glw::GL_TEXTURE0);

        if context_type.supports_core(3, 3) {
            for ndx in 0..num_tex_units as u32 {
                gl.bind_sampler(ndx, 0);
            }
            gl.disable(glw::GL_TEXTURE_CUBE_MAP_SEAMLESS);
        }
    }
}

/// One target's block of `resetStateGLCore`'s texture section, in upstream's call order.
unsafe fn reset_target(gl: &glw::Functions, context_type: ContextType, spec: &TextureTarget, border_color: &[f32; 4]) {
    let target = spec.target;
    unsafe {
        gl.bind_texture(target, 0);

        match spec.image {
            Image::None => {}
            Image::Image1D => gl.tex_image_1d(
                target,
                0,
                glw::GL_RGBA as i32,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            ),
            Image::Image2D => gl.tex_image_2d(
                target,
                0,
                glw::GL_RGBA as i32,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            ),
            Image::Image3D => gl.tex_image_3d(
                target,
                0,
                glw::GL_RGBA as i32,
                0,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            ),
        }
        if target == glw::GL_TEXTURE_CUBE_MAP {
            for face in CUBE_FACES {
                gl.tex_image_2d(
                    face,
                    0,
                    glw::GL_RGBA as i32,
                    0,
                    0,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
            }
        }

        if spec.sampler_state {
            let wrap = if spec.wrap_clamp_to_edge {
                glw::GL_CLAMP_TO_EDGE
            } else {
                glw::GL_REPEAT
            } as i32;
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, spec.min_filter as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            gl.tex_parameterfv(target, glw::GL_TEXTURE_BORDER_COLOR, border_color.as_ptr());
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, wrap);
            if spec.wrap_t {
                gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, wrap);
            }
            if spec.wrap_r {
                gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, wrap);
            }
            if spec.min_max_lod {
                gl.tex_parameterf(target, glw::GL_TEXTURE_MIN_LOD, -1000.0);
                gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LOD, 1000.0);
            }
            gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 1000);
            if spec.lod_bias {
                gl.tex_parameterf(target, glw::GL_TEXTURE_LOD_BIAS, 0.0);
            }
            gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NONE as i32);
            gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LEQUAL as i32);
        } else {
            // Multisample targets: swizzle first, then the levels, as upstream.
            reset_swizzle(gl, target);
            gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 1000);
            return;
        }

        if spec.swizzle == Swizzle::Always || (spec.swizzle == Swizzle::Since33 && context_type.supports_core(3, 3)) {
            reset_swizzle(gl, target);
        }
    }
}

unsafe fn reset_swizzle(gl: &glw::Functions, target: glw::GLenum) {
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_R, glw::GL_RED as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_G, glw::GL_GREEN as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_B, glw::GL_BLUE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_SWIZZLE_A, glw::GL_ALPHA as i32);
    }
}

unsafe fn pixel_operations(gl: &glw::Functions, width: i32, height: i32) {
    unsafe {
        gl.disable(glw::GL_SCISSOR_TEST);
        gl.scissor(0, 0, width, height);

        gl.disable(glw::GL_STENCIL_TEST);
        gl.stencil_func(glw::GL_ALWAYS, 0, !0u32);
        gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);

        gl.disable(glw::GL_DEPTH_TEST);
        gl.depth_func(glw::GL_LESS);

        gl.disable(glw::GL_BLEND);
        gl.blend_func(glw::GL_ONE, glw::GL_ZERO);
        gl.blend_equation(glw::GL_FUNC_ADD);
        gl.blend_color(0.0, 0.0, 0.0, 0.0);

        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
        gl.enable(glw::GL_DITHER);

        gl.disable(glw::GL_COLOR_LOGIC_OP);
        gl.logic_op(glw::GL_COPY);
    }
}

unsafe fn framebuffer_state(gl: &glw::Functions) {
    // Upstream asks the render context for its default framebuffer; a pbuffer or surfaceless context here always answers 0.
    let framebuffer = 0;
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);

        if framebuffer == 0 {
            gl.draw_buffer(glw::GL_BACK);
            gl.read_buffer(glw::GL_BACK);

            // A workaround for single-buffered configurations, as upstream: nowhere else needs to know whether the config is.
            if gl.get_error() != glw::GL_NO_ERROR {
                gl.draw_buffer(glw::GL_FRONT);
                gl.read_buffer(glw::GL_FRONT);
            }
        } else {
            gl.draw_buffer(glw::GL_COLOR_ATTACHMENT0);
            gl.read_buffer(glw::GL_COLOR_ATTACHMENT0);
        }
    }
}

unsafe fn pixel_transfer_state(gl: &glw::Functions) {
    unsafe {
        for (name, value) in [
            (glw::GL_UNPACK_SWAP_BYTES, 0),
            (glw::GL_UNPACK_LSB_FIRST, 0),
            (glw::GL_UNPACK_IMAGE_HEIGHT, 0),
            (glw::GL_UNPACK_SKIP_IMAGES, 0),
            (glw::GL_UNPACK_ROW_LENGTH, 0),
            (glw::GL_UNPACK_SKIP_ROWS, 0),
            (glw::GL_UNPACK_SKIP_PIXELS, 0),
            (glw::GL_UNPACK_ALIGNMENT, 4),
            (glw::GL_PACK_SWAP_BYTES, 0),
            (glw::GL_PACK_LSB_FIRST, 0),
            (glw::GL_PACK_IMAGE_HEIGHT, 0),
            (glw::GL_PACK_SKIP_IMAGES, 0),
            (glw::GL_PACK_ROW_LENGTH, 0),
            (glw::GL_PACK_SKIP_ROWS, 0),
            (glw::GL_PACK_SKIP_PIXELS, 0),
            (glw::GL_PACK_ALIGNMENT, 4),
        ] {
            gl.pixel_storei(name, value);
        }

        gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
    }
}

unsafe fn program_object_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.use_program(0);

        if context_type.supports_core(3, 1) {
            let mut max_uniform_buffer_bindings = 0;
            gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);

            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0);
            for ndx in 0..max_uniform_buffer_bindings as u32 {
                gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, ndx, 0);
            }
        }
    }
}

unsafe fn transform_feedback_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        let mut num_separate_attribs = 0;
        gl.get_integerv(
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
            &mut num_separate_attribs,
        );

        if context_type.supports_core(4, 0) {
            let mut transform_feedback_active: glw::GLboolean = 0;
            gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_ACTIVE, &mut transform_feedback_active);
            if transform_feedback_active != 0 {
                gl.end_transform_feedback();
            }
        }

        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
        for ndx in 0..num_separate_attribs as u32 {
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, ndx, 0);
        }
    }
}

unsafe fn asynchronous_query_state(gl: &glw::Functions) {
    unsafe {
        for query_target in [
            glw::GL_PRIMITIVES_GENERATED,
            glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
            glw::GL_SAMPLES_PASSED,
        ] {
            let mut query_active = 0;
            gl.get_queryiv(query_target, glw::GL_CURRENT_QUERY, &mut query_active);
            if query_active != 0 {
                gl.end_query(query_target);
            }
        }
    }
}
