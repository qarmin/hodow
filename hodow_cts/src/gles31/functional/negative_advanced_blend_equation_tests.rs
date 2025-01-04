// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeAdvancedBlendEquationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `!isES` VAO handling has no
// counterpart here - this port only ever runs an ES context, where the default VAO is legal.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::TestError;

/// `s_equations` - the GL enum and its `blend_support_*` layout qualifier, in one table
/// rather than upstream's two parallel switches.
const EQUATIONS: &[(GLenum, &str)] = &[
    (glw::GL_MULTIPLY, "blend_support_multiply"),
    (glw::GL_SCREEN, "blend_support_screen"),
    (glw::GL_OVERLAY, "blend_support_overlay"),
    (glw::GL_DARKEN, "blend_support_darken"),
    (glw::GL_LIGHTEN, "blend_support_lighten"),
    (glw::GL_COLORDODGE, "blend_support_colordodge"),
    (glw::GL_COLORBURN, "blend_support_colorburn"),
    (glw::GL_HARDLIGHT, "blend_support_hardlight"),
    (glw::GL_SOFTLIGHT, "blend_support_softlight"),
    (glw::GL_DIFFERENCE, "blend_support_difference"),
    (glw::GL_EXCLUSION, "blend_support_exclusion"),
    (glw::GL_HSL_HUE, "blend_support_hsl_hue"),
    (glw::GL_HSL_SATURATION, "blend_support_hsl_saturation"),
    (glw::GL_HSL_COLOR, "blend_support_hsl_color"),
    (glw::GL_HSL_LUMINOSITY, "blend_support_hsl_luminosity"),
];

/// `generateProgramSources`
fn program_sources(ctx: &NegativeTestContext<'_>, layout_equation: &str) -> ProgramSources {
    let version = ctx.glsl_version_decl();
    let vertex = format!("{version}\nvoid main ()\n{{\n    gl_Position = vec4(0.0);\n}}\n");
    let fragment = format!(
        "{version}\n{}layout({layout_equation}) out;\nlayout(location=0) out mediump vec4 o_color;\nvoid main ()\n{{\n    o_color = vec4(0);\n}}\n",
        ctx.extension_directive("GL_KHR_blend_equation_advanced")
    );

    ProgramSources::vtx_frag(vertex, fragment)
}

/// The support check both cases open with.
fn check_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_extension_supported("GL_KHR_blend_equation_advanced") || ctx.context_supports(3, 2) {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "This test requires support for the extension GL_KHR_blend_equation_advanced or context version 3.2 or higher.".to_string(),
        ))
    }
}

/// `glDrawElements(GL_TRIANGLES, 0, GL_UNSIGNED_INT, 0)` - a zero-count draw, so no index
/// is ever read; what is under test is the state validation that precedes the fetch.
fn draw_nothing(ctx: &NegativeTestContext<'_>) {
    // SAFETY: count is 0 and the index pointer is null, which is only legal because
    // nothing is fetched.
    unsafe {
        ctx.gl()
            .draw_elements(glw::GL_TRIANGLES, 0, glw::GL_UNSIGNED_INT, std::ptr::null());
    }
}

fn blend_qualifier_mismatch(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;

    ctx.begin_section(
        "GL_INVALID_OPERATION is generated if blending is enabled, and the blend qualifier is different from blend_support_all_equations and does not match the blend equation.",
    );
    for (equation, layout) in EQUATIONS {
        let program = ShaderProgram::new(ctx.gl(), &program_sources(ctx, layout));
        if !program.is_ok() {
            return Err(TestError::Fail(format!("failed to build the {layout} program")));
        }

        // SAFETY: the program is this function's own.
        unsafe { ctx.gl().use_program(program.program()) };
        ctx.expect_error(glw::GL_NO_ERROR);

        for (other, _) in EQUATIONS {
            if other == equation {
                continue;
            }

            // SAFETY: as above; `draw_nothing` fetches no index.
            unsafe {
                ctx.gl().enable(glw::GL_BLEND);
                ctx.gl().blend_equation(*other);
            }
            ctx.expect_error(glw::GL_NO_ERROR);
            draw_nothing(ctx);
            ctx.expect_error(glw::GL_INVALID_OPERATION);

            // SAFETY: as above.
            unsafe { ctx.gl().disable(glw::GL_BLEND) };
            draw_nothing(ctx);
            ctx.expect_error(glw::GL_NO_ERROR);
        }
    }
    ctx.end_section();
    Ok(())
}

fn attachment_advanced_equation(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;

    let mut fbo: GLuint = 0;
    let mut texture: GLuint = 0;
    let attachments: [GLenum; 2] = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
    let multi_draw_buffers = ctx.is_extension_supported("GL_NVX_blend_equation_advanced_multi_draw_buffers");

    // SAFETY: the texture and framebuffer are this function's own and are deleted at the
    // end; the two-element attachment list matches the count passed with it.
    unsafe {
        ctx.gl().gen_textures(1, &mut texture);
        ctx.gl().bind_texture(glw::GL_TEXTURE_2D, texture);
        ctx.gl().tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        ctx.gl().gen_framebuffers(1, &mut fbo);
        ctx.gl().bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.gl().framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        ctx.expect_error(glw::GL_NO_ERROR);
        let _ = ctx.gl().check_framebuffer_status(glw::GL_FRAMEBUFFER);
    }

    ctx.begin_section("GL_INVALID_OPERATION is generated if blending is enabled, advanced equations are used, and the draw buffer for other color outputs is not NONE unless NVX_blend_equation_advanced_multi_draw_buffers is supported.");
    for (equation, layout) in EQUATIONS {
        let program = ShaderProgram::new(ctx.gl(), &program_sources(ctx, layout));
        if !program.is_ok() {
            return Err(TestError::Fail(format!("failed to build the {layout} program")));
        }

        // SAFETY: as above.
        unsafe {
            ctx.gl().use_program(program.program());
            ctx.gl().enable(glw::GL_BLEND);
            ctx.gl().draw_buffers(2, attachments.as_ptr());
        }
        ctx.expect_error(glw::GL_NO_ERROR);
        // SAFETY: as above.
        unsafe { ctx.gl().blend_equation(*equation) };
        draw_nothing(ctx);
        ctx.expect_error(if multi_draw_buffers {
            glw::GL_NO_ERROR
        } else {
            glw::GL_INVALID_OPERATION
        });
    }
    ctx.end_section();

    ctx.begin_section("GL_NO_ERROR is generated if no advanced blend equations are used.");
    // SAFETY: as above.
    unsafe { ctx.gl().blend_equation(glw::GL_FUNC_ADD) };
    draw_nothing(ctx);
    ctx.expect_error(glw::GL_NO_ERROR);
    ctx.end_section();

    ctx.begin_section("GL_NO_ERROR is generated if blending is disabled.");
    // SAFETY: as above.
    unsafe { ctx.gl().disable(glw::GL_BLEND) };
    for (equation, _) in EQUATIONS {
        // SAFETY: as above.
        unsafe { ctx.gl().blend_equation(*equation) };
        draw_nothing(ctx);
        ctx.expect_error(glw::GL_NO_ERROR);
    }
    ctx.end_section();

    // SAFETY: as above.
    unsafe {
        ctx.gl().delete_framebuffers(1, &fbo);
        ctx.gl().delete_textures(1, &texture);
    }
    Ok(())
}

/// `getNegativeAdvancedBlendEquationTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: blend_qualifier_mismatch,
        name: "blend_qualifier_mismatch",
    },
    FunctionContainer {
        function: attachment_advanced_equation,
        name: "attachment_advanced_equation",
    },
];
