// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluStateReset.cpp  (glu::resetStateES)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Why this exists, and why it is not optional. GL state is global and one context runs
// a whole batch of cases, so whatever a case leaves behind is what the next one starts
// with. Upstream calls this from `TestCaseWrapper::deinit` after every single case, and
// its tests are written on that assumption: `negative_api.buffer.read_pixels` binds an
// incomplete framebuffer and never unbinds it, so without this the *next* case fails
// with GL_INVALID_FRAMEBUFFER_OPERATION - which is what happened here before it was
// ported, and it is indistinguishable from a driver bug in the log.
//
// Not ported: the `GL_KHR_debug` section (message callback, group stack, labels). It
// only matters once a group that touches debug state is ported, and this note is here
// so that is not discovered the hard way.

use crate::glu::{Context, ContextInfo, ContextType};
use crate::glw;

/// `glu::resetStateES` - puts every piece of state a ported case can touch back to its
/// initial value.
pub fn reset_state_es(context: &Context) {
    let gl = context.gl();
    let context_type = context.context_type();
    let info = &context.context_info;

    // Whatever a failing case left behind is not the next case's business.
    super::drain_errors(gl);

    // SAFETY: every call below is a state setter with in-range arguments, made with a
    // current context. The only pointers involved are into local arrays sized for what
    // the call reads or writes.
    unsafe {
        vertex_attrib_array_state(gl, context_type);
        transformation_state(context, gl, context_type);
        rasterization_state(gl, context_type);
        multisampling_state(gl, context_type);
        texture_state(gl, context_type, info);
        pixel_operations(context, gl, info);
        framebuffer_control(gl);
        framebuffer_state(gl, context_type);

        // Renderbuffer state.
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);

        pixel_transfer_state(gl, context_type);
        program_object_state(gl, context_type);
        vertex_shader_state(gl);
        transform_feedback_state(gl, context_type);
        asynchronous_query_state(gl, context_type);

        // Hints.
        gl.hint(glw::GL_GENERATE_MIPMAP_HINT, glw::GL_DONT_CARE);
        if context_type.supports(3, 0) {
            gl.hint(glw::GL_FRAGMENT_SHADER_DERIVATIVE_HINT, glw::GL_DONT_CARE);
        }

        // Compute.
        if context_type.supports(3, 1) {
            gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, 0);
        }

        // Buffer copy state.
        if context_type.supports(3, 0) {
            gl.bind_buffer(glw::GL_COPY_READ_BUFFER, 0);
            gl.bind_buffer(glw::GL_COPY_WRITE_BUFFER, 0);
        }

        // Images.
        if context_type.supports(3, 1) {
            let mut num_image_units = 0;
            gl.get_integerv(glw::GL_MAX_IMAGE_UNITS, &mut num_image_units);
            for ndx in 0..num_image_units as u32 {
                gl.bind_image_texture(ndx, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_R32UI);
            }
        }

        // Sample shading state.
        if context_type.supports(3, 1) && info.is_extension_supported("GL_OES_sample_shading") {
            gl.min_sample_shading(0.0);
            gl.disable(glw::GL_SAMPLE_SHADING);
        }
    }

    // A driver that raises an error while being reset is worth knowing about, but it is
    // nobody's verdict: the case that ran has already been judged and the next one has
    // not started. So this is logged, not returned.
    let left_over = super::drain_errors(gl);
    if left_over > 0 {
        log::warn!("{left_over} GL error(s) raised while resetting state between cases");
    }
}

unsafe fn vertex_attrib_array_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        let mut num_vertex_attrib_arrays = 0;
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut num_vertex_attrib_arrays);

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);

        if context_type.supports(3, 0) {
            gl.bind_vertex_array(0);
            gl.disable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
        }
        if context_type.supports(3, 1) {
            gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, 0);
        }

        for ndx in 0..num_vertex_attrib_arrays as u32 {
            gl.disable_vertex_attrib_array(ndx);
            gl.vertex_attrib_pointer(ndx, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            if context_type.supports(3, 0) {
                gl.vertex_attrib_divisor(ndx, 0);
            }
        }
    }
}

unsafe fn transformation_state(context: &Context, gl: &glw::Functions, context_type: ContextType) {
    let target = context.render_context.render_target();
    unsafe {
        gl.viewport(0, 0, target.width, target.height);
        gl.depth_rangef(0.0, 1.0);
        if context_type.supports(3, 0) {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        }
    }
}

unsafe fn rasterization_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.line_width(1.0);
        gl.disable(glw::GL_CULL_FACE);
        gl.cull_face(glw::GL_BACK);
        gl.front_face(glw::GL_CCW);
        gl.polygon_offset(0.0, 0.0);
        gl.disable(glw::GL_POLYGON_OFFSET_FILL);
        if context_type.supports(3, 0) {
            gl.disable(glw::GL_RASTERIZER_DISCARD);
        }
    }
}

unsafe fn multisampling_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.disable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
        gl.disable(glw::GL_SAMPLE_COVERAGE);
        gl.sample_coverage(1.0, glw::FALSE);

        if context_type.supports(3, 1) {
            let mut num_sample_mask_words = 0;
            gl.get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut num_sample_mask_words);
            gl.disable(glw::GL_SAMPLE_MASK);
            for ndx in 0..num_sample_mask_words as u32 {
                gl.sample_maski(ndx, !0u32);
            }
        }
    }
}

/// The texture state, per texture unit. Upstream's `\todo [2013-04-08 pyry] Reset all
/// levels?` still stands: only level 0 is reset.
unsafe fn texture_state(gl: &glw::Functions, context_type: ContextType, info: &ContextInfo) {
    const BORDER_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 0.0];
    let supports_border_clamp =
        info.is_extension_supported("GL_EXT_texture_border_clamp") || context_type.supports(3, 2);

    unsafe {
        let mut num_tex_units = 0;
        gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut num_tex_units);

        for ndx in 0..num_tex_units as u32 {
            gl.active_texture(glw::GL_TEXTURE0 + ndx);

            // 2D texture.
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA as i32,
                0,
                0,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );
            reset_sampling(gl, glw::GL_TEXTURE_2D);
            if context_type.supports(3, 0) {
                reset_es3_texture_params(gl, glw::GL_TEXTURE_2D);
            }
            if context_type.supports(3, 1) {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    glw::GL_DEPTH_COMPONENT as i32,
                );
            }
            if supports_border_clamp {
                gl.tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BORDER_COLOR, BORDER_COLOR.as_ptr());
            }

            // Cube map texture.
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0);
            for face in [
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            ] {
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
            reset_sampling(gl, glw::GL_TEXTURE_CUBE_MAP);
            if context_type.supports(3, 0) {
                reset_es3_texture_params(gl, glw::GL_TEXTURE_CUBE_MAP);
            }
            if context_type.supports(3, 1) {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    glw::GL_DEPTH_COMPONENT as i32,
                );
            }
            if supports_border_clamp {
                gl.tex_parameterfv(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_BORDER_COLOR,
                    BORDER_COLOR.as_ptr(),
                );
            }

            if context_type.supports(3, 0) {
                // 2D array texture.
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
                gl.tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    glw::GL_RGBA as i32,
                    0,
                    0,
                    0,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                reset_sampling(gl, glw::GL_TEXTURE_2D_ARRAY);
                reset_es3_texture_params(gl, glw::GL_TEXTURE_2D_ARRAY);
                if supports_border_clamp {
                    gl.tex_parameterfv(
                        glw::GL_TEXTURE_2D_ARRAY,
                        glw::GL_TEXTURE_BORDER_COLOR,
                        BORDER_COLOR.as_ptr(),
                    );
                }
                if context_type.supports(3, 1) {
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_2D_ARRAY,
                        glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                        glw::GL_DEPTH_COMPONENT as i32,
                    );
                }

                // 3D texture.
                gl.bind_texture(glw::GL_TEXTURE_3D, 0);
                gl.tex_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    glw::GL_RGBA as i32,
                    0,
                    0,
                    0,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                );
                reset_sampling(gl, glw::GL_TEXTURE_3D);
                gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, glw::GL_REPEAT as i32);
                reset_es3_texture_params(gl, glw::GL_TEXTURE_3D);
                if supports_border_clamp {
                    gl.tex_parameterfv(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_BORDER_COLOR, BORDER_COLOR.as_ptr());
                }
                if context_type.supports(3, 1) {
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_3D,
                        glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                        glw::GL_DEPTH_COMPONENT as i32,
                    );
                }
            }

            if context_type.supports(3, 1) {
                // Multisample texture. It has no sampler state to reset.
                gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, 0);
                reset_swizzle(gl, glw::GL_TEXTURE_2D_MULTISAMPLE);
                gl.tex_parameteri(glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_BASE_LEVEL, 0);
                gl.tex_parameteri(glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_MAX_LEVEL, 1000);
            }

            if info.is_extension_supported("GL_OES_texture_storage_multisample_2d_array") {
                gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, 0);
                reset_swizzle(gl, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY);
                gl.tex_parameteri(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_TEXTURE_BASE_LEVEL, 0);
                gl.tex_parameteri(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, glw::GL_TEXTURE_MAX_LEVEL, 1000);
            }

            if info.is_extension_supported("GL_EXT_texture_cube_map_array") {
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
                reset_sampling(gl, glw::GL_TEXTURE_CUBE_MAP_ARRAY);
                reset_es3_texture_params(gl, glw::GL_TEXTURE_CUBE_MAP_ARRAY);
                if supports_border_clamp {
                    gl.tex_parameterfv(
                        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                        glw::GL_TEXTURE_BORDER_COLOR,
                        BORDER_COLOR.as_ptr(),
                    );
                }
            }
        }

        gl.active_texture(glw::GL_TEXTURE0);

        if context_type.supports(3, 0) {
            for ndx in 0..num_tex_units as u32 {
                gl.bind_sampler(ndx, 0);
            }
        }
    }
}

/// The filter and wrap defaults, which every texture target above resets identically.
unsafe fn reset_sampling(gl: &glw::Functions, target: glw::GLenum) {
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST_MIPMAP_LINEAR as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as i32);
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

/// The parameters ES 3.0 added, which every ES 3.0 texture target resets identically.
unsafe fn reset_es3_texture_params(gl: &glw::Functions, target: glw::GLenum) {
    unsafe {
        reset_swizzle(gl, target);
        gl.tex_parameterf(target, glw::GL_TEXTURE_MIN_LOD, -1000.0);
        gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LOD, 1000.0);
        gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 1000);
        gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NONE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LEQUAL as i32);
    }
}

unsafe fn pixel_operations(context: &Context, gl: &glw::Functions, info: &ContextInfo) {
    let target = context.render_context.render_target();
    unsafe {
        // Resetting the non-indexed state should be enough, but some implementations
        // have bugs, so upstream sets the indexed state back explicitly as well.
        if info.is_extension_supported("GL_EXT_draw_buffers_indexed") {
            let mut num_draw_buffers = 0;
            gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut num_draw_buffers);
            for ndx in 0..num_draw_buffers as u32 {
                gl.disablei(glw::GL_BLEND, ndx);
                gl.blend_funci(ndx, glw::GL_ONE, glw::GL_ZERO);
                gl.blend_equationi(ndx, glw::GL_FUNC_ADD);
                gl.color_maski(ndx, glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
            }
        }

        gl.disable(glw::GL_SCISSOR_TEST);
        gl.scissor(0, 0, target.width, target.height);

        gl.disable(glw::GL_STENCIL_TEST);
        gl.stencil_func(glw::GL_ALWAYS, 0, !0u32);
        gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);

        gl.disable(glw::GL_DEPTH_TEST);
        gl.depth_func(glw::GL_LESS);

        gl.disable(glw::GL_BLEND);
        gl.blend_func(glw::GL_ONE, glw::GL_ZERO);
        gl.blend_equation(glw::GL_FUNC_ADD);
        gl.blend_color(0.0, 0.0, 0.0, 0.0);

        gl.enable(glw::GL_DITHER);

        if info.is_extension_supported("GL_EXT_sRGB_write_control") {
            gl.enable(glw::GL_FRAMEBUFFER_SRGB);
        }
    }
}

unsafe fn framebuffer_control(gl: &glw::Functions) {
    unsafe {
        gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
        gl.depth_mask(glw::TRUE);
        gl.stencil_mask(!0u32);

        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear_depthf(1.0);
        gl.clear_stencil(0);
    }
}

unsafe fn framebuffer_state(gl: &glw::Functions, context_type: ContextType) {
    // Upstream allows a platform whose default framebuffer is not 0 (iOS); here the
    // render target is a pbuffer or a surfaceless context, so 0 it is - which also
    // means GL_BACK is the draw and read buffer, and the ES 3.1 default-framebuffer
    // parameters do not apply.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);

        if context_type.supports(3, 0) {
            let draw_buffer = glw::GL_BACK;
            gl.draw_buffers(1, &draw_buffer);
            gl.read_buffer(glw::GL_BACK);
        }
    }
}

unsafe fn pixel_transfer_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);

        if context_type.supports(3, 0) {
            for pname in [
                glw::GL_UNPACK_IMAGE_HEIGHT,
                glw::GL_UNPACK_SKIP_IMAGES,
                glw::GL_UNPACK_ROW_LENGTH,
                glw::GL_UNPACK_SKIP_ROWS,
                glw::GL_UNPACK_SKIP_PIXELS,
                glw::GL_PACK_ROW_LENGTH,
                glw::GL_PACK_SKIP_ROWS,
                glw::GL_PACK_SKIP_PIXELS,
            ] {
                gl.pixel_storei(pname, 0);
            }

            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0);
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
        }
    }
}

unsafe fn program_object_state(gl: &glw::Functions, context_type: ContextType) {
    unsafe {
        gl.use_program(0);

        if context_type.supports(3, 0) {
            let mut max_uniform_buffer_bindings = 0;
            gl.get_integerv(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, &mut max_uniform_buffer_bindings);
            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0);
            for ndx in 0..max_uniform_buffer_bindings as u32 {
                gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, ndx, 0);
            }
        }

        if context_type.supports(3, 1) {
            gl.bind_program_pipeline(0);

            let mut max_atomic_counter_buffer_bindings = 0;
            gl.get_integerv(
                glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
                &mut max_atomic_counter_buffer_bindings,
            );
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0);
            for ndx in 0..max_atomic_counter_buffer_bindings as u32 {
                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, ndx, 0);
            }

            let mut max_shader_storage_buffer_bindings = 0;
            gl.get_integerv(
                glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
                &mut max_shader_storage_buffer_bindings,
            );
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            for ndx in 0..max_shader_storage_buffer_bindings as u32 {
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, ndx, 0);
            }
        }
    }
}

unsafe fn vertex_shader_state(gl: &glw::Functions) {
    unsafe {
        let mut num_vertex_attrib_arrays = 0;
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut num_vertex_attrib_arrays);
        for ndx in 0..num_vertex_attrib_arrays as u32 {
            gl.vertex_attrib_4f(ndx, 0.0, 0.0, 0.0, 1.0);
        }
    }
}

unsafe fn transform_feedback_state(gl: &glw::Functions, context_type: ContextType) {
    if !context_type.supports(3, 0) {
        return;
    }
    unsafe {
        let mut num_separate_attribs = 0;
        let mut active = glw::FALSE;
        gl.get_integerv(
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
            &mut num_separate_attribs,
        );
        gl.get_booleanv(glw::GL_TRANSFORM_FEEDBACK_ACTIVE, &mut active);

        if active != glw::FALSE {
            gl.end_transform_feedback();
        }

        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
        for ndx in 0..num_separate_attribs as u32 {
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, ndx, 0);
        }
    }
}

unsafe fn asynchronous_query_state(gl: &glw::Functions, context_type: ContextType) {
    if !context_type.supports(3, 0) {
        return;
    }
    unsafe {
        for target in [
            glw::GL_ANY_SAMPLES_PASSED,
            glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE,
            glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
        ] {
            let mut query_active = 0;
            gl.get_queryiv(target, glw::GL_CURRENT_QUERY, &mut query_active);
            if query_active != 0 {
                gl.end_query(target);
            }
        }
    }
}
