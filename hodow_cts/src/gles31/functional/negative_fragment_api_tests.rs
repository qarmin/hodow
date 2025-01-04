// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeFragmentApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each function keeps its upstream name
// and the order of its calls; the `beginSection` strings are the spec sentences the
// following calls check, so they are kept verbatim rather than paraphrased.

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;

/// `checkSupport` - the indexed blend entry points need ES 3.2 or the extension.
fn check_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.context_supports(3, 2) || ctx.is_extension_supported("GL_EXT_draw_buffers_indexed") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_draw_buffers_indexed is not supported".to_string(),
        ))
    }
}

fn scissor(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: every call in this file is deliberately invalid; a conformant driver
    // raises an error and changes nothing, which is exactly what is being checked.
    unsafe {
        ctx.gl().scissor(0, 0, -1, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().scissor(0, 0, 0, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().scissor(0, 0, -1, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn depth_func(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if func is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().depth_func(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn viewport(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().viewport(0, 0, -1, 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().viewport(0, 0, 1, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().viewport(0, 0, -1, -1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

// Stencil functions

fn stencil_func(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().stencil_func(BAD_ENUM, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn stencil_func_separate(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
        ctx.gl().stencil_func_separate(BAD_ENUM, glw::GL_NEVER, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
        ctx.gl().stencil_func_separate(glw::GL_FRONT, BAD_ENUM, 0, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
    }
    Ok(())
}

fn stencil_op(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the defined symbolic constant values.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().stencil_op(BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().stencil_op(glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().stencil_op(glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn stencil_op_separate(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section(
            "GL_INVALID_ENUM is generated if face is any value other than GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.",
        );
        ctx.gl()
            .stencil_op_separate(BAD_ENUM, glw::GL_KEEP, glw::GL_ZERO, glw::GL_REPLACE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the eight defined symbolic constant values.");
        ctx.gl()
            .stencil_op_separate(glw::GL_FRONT, BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .stencil_op_separate(glw::GL_FRONT, glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .stencil_op_separate(glw::GL_FRONT, glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
    }
    Ok(())
}

fn stencil_mask_separate(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().stencil_mask_separate(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

// Blend functions

fn blend_equation(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if mode is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().blend_equation(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn blend_equation_separate(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if modeRGB is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
        ctx.gl().blend_equation_separate(BAD_ENUM, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section("GL_INVALID_ENUM is generated if modeAlpha is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
        ctx.gl().blend_equation_separate(glw::GL_FUNC_ADD, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
    }
    Ok(())
}

fn blend_equationi(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let max_draw_buffers = ctx.get_integer(glw::GL_MAX_DRAW_BUFFERS);

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if mode is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
        ctx.gl().blend_equationi(0, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
        );
        ctx.gl().blend_equationi(BAD_ENUM, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().blend_equationi(max_draw_buffers as GLuint, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn blend_equation_separatei(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let max_draw_buffers = ctx.get_integer(glw::GL_MAX_DRAW_BUFFERS);

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if modeRGB is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
        ctx.gl().blend_equation_separatei(0, BAD_ENUM, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section("GL_INVALID_ENUM is generated if modeAlpha is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
        ctx.gl().blend_equation_separatei(0, glw::GL_FUNC_ADD, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
        );
        ctx.gl()
            .blend_equation_separatei(BAD_ENUM, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl()
            .blend_equation_separatei(max_draw_buffers as GLuint, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn blend_func(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if either sfactor or dfactor is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().blend_func(BAD_ENUM, glw::GL_ONE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().blend_func(glw::GL_ONE, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn blend_func_separate(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section(
        "GL_INVALID_ENUM is generated if srcRGB, dstRGB, srcAlpha, or dstAlpha is not an accepted value.",
    );
    // SAFETY: as above.
    unsafe {
        ctx.gl()
            .blend_func_separate(BAD_ENUM, glw::GL_ONE, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .blend_func_separate(glw::GL_ZERO, BAD_ENUM, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .blend_func_separate(glw::GL_ZERO, glw::GL_ONE, BAD_ENUM, glw::GL_ONE_MINUS_SRC_COLOR);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .blend_func_separate(glw::GL_ZERO, glw::GL_ONE, glw::GL_SRC_COLOR, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn blend_funci(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let max_draw_buffers = ctx.get_integer(glw::GL_MAX_DRAW_BUFFERS);

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if either sfactor or dfactor is not an accepted value.");
        ctx.gl().blend_funci(0, BAD_ENUM, glw::GL_ONE);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().blend_funci(0, glw::GL_ONE, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
        );
        ctx.gl().blend_funci(BAD_ENUM, glw::GL_ONE, glw::GL_ONE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl()
            .blend_funci(max_draw_buffers as GLuint, glw::GL_ONE, glw::GL_ONE);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn blend_func_separatei(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_support(ctx)?;
    let max_draw_buffers = ctx.get_integer(glw::GL_MAX_DRAW_BUFFERS);

    // SAFETY: as above.
    unsafe {
        ctx.begin_section(
            "GL_INVALID_ENUM is generated if srcRGB, dstRGB, srcAlpha, or dstAlpha is not an accepted value.",
        );
        ctx.gl()
            .blend_func_separatei(0, BAD_ENUM, glw::GL_ONE, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl().blend_func_separatei(
            0,
            glw::GL_ZERO,
            BAD_ENUM,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .blend_func_separatei(0, glw::GL_ZERO, glw::GL_ONE, BAD_ENUM, glw::GL_ONE_MINUS_SRC_COLOR);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.gl()
            .blend_func_separatei(0, glw::GL_ZERO, glw::GL_ONE, glw::GL_SRC_COLOR, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();
        ctx.begin_section(
            "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
        );
        ctx.gl().blend_func_separatei(
            BAD_ENUM,
            glw::GL_ONE,
            glw::GL_ONE,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().blend_func_separatei(
            max_draw_buffers as GLuint,
            glw::GL_ONE,
            glw::GL_ONE,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

// Rasterization API functions

fn cull_face(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().cull_face(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn front_face(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().front_face(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
    }
    ctx.end_section();
    Ok(())
}

fn line_width(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if width is less than or equal to 0.");
    // SAFETY: as above.
    unsafe {
        ctx.gl().line_width(0.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().line_width(-1.0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

// Asynchronous queries

fn gen_queries(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
    let mut ids: GLuint = 0;
    // SAFETY: a negative count is the error under test; the driver writes nothing.
    unsafe {
        ctx.gl().gen_queries(-1, &mut ids);
        ctx.expect_error(glw::GL_INVALID_VALUE);
    }
    ctx.end_section();
    Ok(())
}

fn begin_query(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut ids = [0 as GLuint; 3];
    // SAFETY: three names are asked for and three GLuints of output are given; every
    // later call names one of them.
    unsafe {
        ctx.gl().gen_queries(3, ids.as_mut_ptr());

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl().begin_query(BAD_ENUM, ids[0]);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if glBeginQuery is executed while a query object of the same target is already active.");
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[0]);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[1]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        // \note GL_ANY_SAMPLES_PASSED and GL_ANY_SAMPLES_PASSED_CONSERVATIVE alias to
        // the same target for the purposes of this error.
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, ids[1]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl()
            .begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[1]);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[2]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);
        ctx.gl().end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if id is 0.");
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, 0);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section(
            "GL_INVALID_OPERATION is generated if id not a name returned from a previous call to glGenQueries, or if such a name has since been deleted with glDeleteQueries.",
        );
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().delete_queries(1, &ids[2]);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[2]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if id is the name of an already active query object.");
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[0]);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[0]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if id refers to an existing query object whose type does not does not match target.");
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl()
            .begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[0]);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.gl().delete_queries(2, ids.as_ptr());
        ctx.expect_error(glw::GL_NO_ERROR);
    }
    Ok(())
}

fn end_query(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut id: GLuint = 0;
    // SAFETY: one name is asked for and one GLuint of output is given.
    unsafe {
        ctx.gl().gen_queries(1, &mut id);

        ctx.begin_section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
        ctx.gl().end_query(BAD_ENUM);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated if glEndQuery is executed when a query object of the same target is not active.");
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().begin_query(glw::GL_ANY_SAMPLES_PASSED, id);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.gl().end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.gl().end_query(glw::GL_ANY_SAMPLES_PASSED);
        ctx.expect_error(glw::GL_NO_ERROR);
        ctx.end_section();

        ctx.gl().delete_queries(1, &id);
        ctx.expect_error(glw::GL_NO_ERROR);
    }
    Ok(())
}

fn delete_queries(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut id: GLuint = 0;
    // SAFETY: as above.
    unsafe {
        ctx.gl().gen_queries(1, &mut id);

        ctx.begin_section("GL_INVALID_VALUE is generated if n is negative.");
        ctx.gl().delete_queries(-1, &id);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_queries(1, &id);
    }
    Ok(())
}

// Sync objects

fn fence_sync(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if condition is not GL_SYNC_GPU_COMMANDS_COMPLETE.");
        ctx.gl().fence_sync(BAD_ENUM, 0);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if flags is not zero.");
        ctx.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0x0010);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn wait_sync(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: the sync object below is this function's own and is deleted at the end;
    // every other handle passed is deliberately invalid, which is the error under test.
    unsafe {
        let sync = ctx.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

        ctx.begin_section("GL_INVALID_VALUE is generated if sync is not the name of a sync object.");
        ctx.gl().wait_sync(std::ptr::null_mut(), 0, glw::GL_TIMEOUT_IGNORED);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if flags is not zero.");
        ctx.gl().wait_sync(sync, 0x0010, glw::GL_TIMEOUT_IGNORED);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if timeout is not GL_TIMEOUT_IGNORED.");
        ctx.gl().wait_sync(sync, 0, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_sync(sync);
    }
    Ok(())
}

fn client_wait_sync(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe {
        let sync = ctx.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

        ctx.begin_section("GL_INVALID_VALUE is generated if sync is not the name of an existing sync object.");
        ctx.gl().client_wait_sync(std::ptr::null_mut(), 0, 10000);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if flags contains any unsupported flag.");
        ctx.gl().client_wait_sync(sync, 0x00000004, 10000);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        ctx.gl().delete_sync(sync);
    }
    Ok(())
}

fn delete_sync(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_INVALID_VALUE is generated if sync is neither zero or the name of a sync object.");
    // SAFETY: passing a bogus handle is the error under test; a conformant driver
    // rejects it without dereferencing it.
    unsafe {
        ctx.gl().delete_sync(std::ptr::dangling_mut());
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.gl().delete_sync(std::ptr::null_mut());
        ctx.expect_error(glw::GL_NO_ERROR);
    }
    ctx.end_section();
    Ok(())
}

/// Silences the unused-import warning where `GLint` is only named in a signature.
const _: Option<GLint> = None;

/// `getNegativeFragmentApiTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: scissor,
        name: "scissor",
    },
    FunctionContainer {
        function: depth_func,
        name: "depth_func",
    },
    FunctionContainer {
        function: viewport,
        name: "viewport",
    },
    FunctionContainer {
        function: stencil_func,
        name: "stencil_func",
    },
    FunctionContainer {
        function: stencil_func_separate,
        name: "stencil_func_separate",
    },
    FunctionContainer {
        function: stencil_op,
        name: "stencil_op",
    },
    FunctionContainer {
        function: stencil_op_separate,
        name: "stencil_op_separate",
    },
    FunctionContainer {
        function: stencil_mask_separate,
        name: "stencil_mask_separate",
    },
    FunctionContainer {
        function: blend_equation,
        name: "blend_equation",
    },
    FunctionContainer {
        function: blend_equationi,
        name: "blend_equationi",
    },
    FunctionContainer {
        function: blend_equation_separate,
        name: "blend_equation_separate",
    },
    FunctionContainer {
        function: blend_equation_separatei,
        name: "blend_equation_separatei",
    },
    FunctionContainer {
        function: blend_func,
        name: "blend_func",
    },
    FunctionContainer {
        function: blend_funci,
        name: "blend_funci",
    },
    FunctionContainer {
        function: blend_func_separate,
        name: "blend_func_separate",
    },
    FunctionContainer {
        function: blend_func_separatei,
        name: "blend_func_separatei",
    },
    FunctionContainer {
        function: cull_face,
        name: "cull_face",
    },
    FunctionContainer {
        function: front_face,
        name: "front_face",
    },
    FunctionContainer {
        function: line_width,
        name: "line_width",
    },
    FunctionContainer {
        function: gen_queries,
        name: "gen_queries",
    },
    FunctionContainer {
        function: begin_query,
        name: "begin_query",
    },
    FunctionContainer {
        function: end_query,
        name: "end_query",
    },
    FunctionContainer {
        function: delete_queries,
        name: "delete_queries",
    },
    FunctionContainer {
        function: fence_sync,
        name: "fence_sync",
    },
    FunctionContainer {
        function: wait_sync,
        name: "wait_sync",
    },
    FunctionContainer {
        function: client_wait_sync,
        name: "client_wait_sync",
    },
    FunctionContainer {
        function: delete_sync,
        name: "delete_sync",
    },
];
