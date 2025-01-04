// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fNegativeFragmentApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `ES3F_ADD_API_CASE` body is a
// function and the registration is a table of them, exactly as in the ES 2.0 port; see
// the note in `gles2/functional/negative_api/buffer.rs`.
//
// Upstream's `TestLog::Section`/`EndSection` pair becomes a single `case.section(..)`,
// and its `throw tcu::NotSupportedError` becomes `case.not_supported(..)` plus a
// `return`, which a plain function cannot do implicitly.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, Context, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLuint};

/// `checkDrawBuffersIndexedSupport`
fn check_draw_buffers_indexed_support(ctx: &Context) -> bool {
    ctx.context_type().supports(3, 2) || ctx.context_info.is_extension_supported("GL_EXT_draw_buffers_indexed")
}

fn scissor(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: a current context; the arguments are invalid on purpose and no pointer
    // is involved.
    unsafe {
        gl.scissor(0, 0, -1, 0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.scissor(0, 0, 0, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.scissor(0, 0, -1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn depth_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if func is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.depth_func(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn viewport(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if either width or height is negative.");
    // SAFETY: as above.
    unsafe {
        gl.viewport(0, 0, -1, 1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.viewport(0, 0, 1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.viewport(0, 0, -1, -1);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

// Stencil functions

fn stencil_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
    // SAFETY: as above.
    unsafe { gl.stencil_func(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn stencil_func_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe { gl.stencil_func_separate(BAD_ENUM, glw::GL_NEVER, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if func is not one of the eight accepted values.");
    // SAFETY: as above.
    unsafe { gl.stencil_func_separate(glw::GL_FRONT, BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn stencil_op(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the defined symbolic constant values.");
    // SAFETY: as above.
    unsafe {
        gl.stencil_op(BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.stencil_op(glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.stencil_op(glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn stencil_op_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section(
        "GL_INVALID_ENUM is generated if face is any value other than GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.",
    );
    // SAFETY: as above.
    unsafe { gl.stencil_op_separate(BAD_ENUM, glw::GL_KEEP, glw::GL_ZERO, glw::GL_REPLACE) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if sfail, dpfail, or dppass is any value other than the eight defined symbolic constant values.");
    // SAFETY: as above.
    unsafe {
        gl.stencil_op_separate(glw::GL_FRONT, BAD_ENUM, glw::GL_ZERO, glw::GL_REPLACE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.stencil_op_separate(glw::GL_FRONT, glw::GL_KEEP, BAD_ENUM, glw::GL_REPLACE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.stencil_op_separate(glw::GL_FRONT, glw::GL_KEEP, glw::GL_ZERO, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn stencil_mask_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if face is not GL_FRONT, GL_BACK, or GL_FRONT_AND_BACK.");
    // SAFETY: as above.
    unsafe { gl.stencil_mask_separate(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

// Blend functions

fn blend_equation(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equation(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn blend_equation_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if modeRGB is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equation_separate(BAD_ENUM, glw::GL_FUNC_ADD) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if modeAlpha is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equation_separate(glw::GL_FUNC_ADD, BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn blend_func(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if either sfactor or dfactor is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        gl.blend_func(BAD_ENUM, glw::GL_ONE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func(glw::GL_ONE, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

fn blend_func_separate(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if srcRGB, dstRGB, srcAlpha, or dstAlpha is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        gl.blend_func_separate(BAD_ENUM, glw::GL_ONE, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separate(glw::GL_ZERO, BAD_ENUM, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separate(glw::GL_ZERO, glw::GL_ONE, BAD_ENUM, glw::GL_ONE_MINUS_SRC_COLOR);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separate(glw::GL_ZERO, glw::GL_ONE, glw::GL_SRC_COLOR, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }
}

/// The `buf` argument upstream writes as a literal `-1` on the indexed blend entry
/// points, whose parameter is a `GLuint`.
const BAD_BUF: GLuint = u32::MAX;

fn blend_equationi(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut max_draw_buffers = -1;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
    if !check_draw_buffers_indexed_support(case.context()) {
        case.not_supported("GL_EXT_draw_buffers_indexed is not supported");
        return;
    }
    case.section("GL_INVALID_ENUM is generated if mode is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equationi(0, BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section(
        "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
    );
    // SAFETY: as above.
    unsafe {
        gl.blend_equationi(BAD_BUF, glw::GL_FUNC_ADD);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.blend_equationi(max_draw_buffers as GLuint, glw::GL_FUNC_ADD);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn blend_equation_separatei(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut max_draw_buffers = -1;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
    if !check_draw_buffers_indexed_support(case.context()) {
        case.not_supported("GL_EXT_draw_buffers_indexed is not supported");
        return;
    }
    case.section("GL_INVALID_ENUM is generated if modeRGB is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equation_separatei(0, BAD_ENUM, glw::GL_FUNC_ADD) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if modeAlpha is not GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MAX or GL_MIN.");
    // SAFETY: as above.
    unsafe { gl.blend_equation_separatei(0, glw::GL_FUNC_ADD, BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section(
        "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
    );
    // SAFETY: as above.
    unsafe {
        gl.blend_equation_separatei(BAD_BUF, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.blend_equation_separatei(max_draw_buffers as GLuint, glw::GL_FUNC_ADD, glw::GL_FUNC_ADD);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn blend_funci(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut max_draw_buffers = -1;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
    if !check_draw_buffers_indexed_support(case.context()) {
        case.not_supported("GL_EXT_draw_buffers_indexed is not supported");
        return;
    }
    case.section("GL_INVALID_ENUM is generated if either sfactor or dfactor is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        gl.blend_funci(0, BAD_ENUM, glw::GL_ONE);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_funci(0, glw::GL_ONE, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
    );
    // SAFETY: as above.
    unsafe {
        gl.blend_funci(BAD_BUF, glw::GL_ONE, glw::GL_ONE);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.blend_funci(max_draw_buffers as GLuint, glw::GL_ONE, glw::GL_ONE);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

fn blend_func_separatei(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut max_draw_buffers = -1;
    // SAFETY: one integer of output.
    unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
    if !check_draw_buffers_indexed_support(case.context()) {
        case.not_supported("GL_EXT_draw_buffers_indexed is not supported");
        return;
    }
    case.section("GL_INVALID_ENUM is generated if srcRGB, dstRGB, srcAlpha, or dstAlpha is not an accepted value.");
    // SAFETY: as above.
    unsafe {
        gl.blend_func_separatei(0, BAD_ENUM, glw::GL_ONE, glw::GL_SRC_COLOR, glw::GL_ONE_MINUS_SRC_COLOR);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separatei(
            0,
            glw::GL_ZERO,
            BAD_ENUM,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separatei(0, glw::GL_ZERO, glw::GL_ONE, BAD_ENUM, glw::GL_ONE_MINUS_SRC_COLOR);
        case.expect_error(glw::GL_INVALID_ENUM);
        gl.blend_func_separatei(0, glw::GL_ZERO, glw::GL_ONE, glw::GL_SRC_COLOR, BAD_ENUM);
        case.expect_error(glw::GL_INVALID_ENUM);
    }

    case.section(
        "GL_INVALID_VALUE is generated if buf is not in the range zero to the value of MAX_DRAW_BUFFERS minus one.",
    );
    // SAFETY: as above.
    unsafe {
        gl.blend_func_separatei(
            BAD_BUF,
            glw::GL_ONE,
            glw::GL_ONE,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.blend_func_separatei(
            max_draw_buffers as GLuint,
            glw::GL_ONE,
            glw::GL_ONE,
            glw::GL_SRC_COLOR,
            glw::GL_ONE_MINUS_SRC_COLOR,
        );
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

// Rasterization API functions

fn cull_face(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.cull_face(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn front_face(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.front_face(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);
}

fn line_width(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if width is less than or equal to 0.");
    // SAFETY: as above.
    unsafe {
        gl.line_width(0.0);
        case.expect_error(glw::GL_INVALID_VALUE);
        gl.line_width(-1.0);
        case.expect_error(glw::GL_INVALID_VALUE);
    }
}

// Asynchronous queries

fn gen_queries(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if n is negative.");
    let mut ids: GLuint = 0;
    // SAFETY: the negative count is the error being provoked; the destination is a
    // single GLuint and GL writes nothing when it rejects the call.
    unsafe { gl.gen_queries(-1, &mut ids) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn begin_query(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut ids: [GLuint; 3] = [0; 3];
    // SAFETY: three names asked for, three GLuints of room.
    unsafe { gl.gen_queries(3, ids.as_mut_ptr()) };

    case.section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
    // SAFETY: a current context; every argument below is a name this case generated.
    unsafe { gl.begin_query(BAD_ENUM, ids[0]) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if glBeginQuery is executed while a query object of the same target is already active.");
    // SAFETY: as above.
    unsafe {
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[0]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[1]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        // \note GL_ANY_SAMPLES_PASSED and GL_ANY_SAMPLES_PASSED_CONSERVATIVE alias to the same target for the purposes of this error.
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, ids[1]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[1]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[2]);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
        gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        case.expect_error(glw::GL_NO_ERROR);
    }

    case.section("GL_INVALID_OPERATION is generated if id is 0.");
    // SAFETY: as above.
    unsafe { gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, 0) };
    case.expect_error(glw::GL_INVALID_OPERATION);

    case.section(
        "GL_INVALID_OPERATION is generated if id not a name returned from a previous call to glGenQueries, or if such a name has since been deleted with glDeleteQueries.",
    );
    // SAFETY: as above; the deleted name is this case's own.
    unsafe {
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, BAD_BUF);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.delete_queries(1, &ids[2]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[2]);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if id is the name of an already active query object.");
    // SAFETY: as above.
    unsafe {
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, ids[0]);
        case.expect_error(glw::GL_NO_ERROR);
        gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[0]);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    case.section("GL_INVALID_OPERATION is generated if id refers to an existing query object whose type does not does not match target.");
    // SAFETY: as above.
    unsafe {
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
        case.expect_error(glw::GL_NO_ERROR);
        gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, ids[0]);
        case.expect_error(glw::GL_INVALID_OPERATION);
    }

    // SAFETY: two names this case generated and has not deleted.
    unsafe { gl.delete_queries(2, ids.as_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
}

fn end_query(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut id: GLuint = 0;
    // SAFETY: one name asked for, one GLuint of room.
    unsafe { gl.gen_queries(1, &mut id) };

    case.section("GL_INVALID_ENUM is generated if target is not one of the accepted tokens.");
    // SAFETY: a current context; the id is this case's own.
    unsafe { gl.end_query(BAD_ENUM) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_OPERATION is generated if glEndQuery is executed when a query object of the same target is not active.");
    // SAFETY: as above.
    unsafe {
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, id);
        case.expect_error(glw::GL_NO_ERROR);
        gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        case.expect_error(glw::GL_INVALID_OPERATION);
        gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
        case.expect_error(glw::GL_NO_ERROR);
    }

    // SAFETY: as above.
    unsafe { gl.delete_queries(1, &id) };
    case.expect_error(glw::GL_NO_ERROR);
}

fn delete_queries(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut id: GLuint = 0;
    // SAFETY: one name asked for, one GLuint of room.
    unsafe { gl.gen_queries(1, &mut id) };

    case.section("GL_INVALID_VALUE is generated if n is negative.");
    // SAFETY: the negative count is the error being provoked.
    unsafe { gl.delete_queries(-1, &id) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: the name is this case's own.
    unsafe { gl.delete_queries(1, &id) };
}

// Sync objects

fn fence_sync(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if condition is not GL_SYNC_GPU_COMMANDS_COMPLETE.");
    // SAFETY: a current context; both calls are rejected, so no sync object leaks.
    unsafe { gl.fence_sync(BAD_ENUM, 0) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if flags is not zero.");
    // SAFETY: as above.
    unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0x0010) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn wait_sync(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: a current context; the returned handle is deleted at the end.
    let sync = unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };

    case.section("GL_INVALID_VALUE is generated if sync is not the name of a sync object.");
    // SAFETY: a null handle is exactly the error being provoked; GL validates it.
    unsafe { gl.wait_sync(std::ptr::null_mut(), 0, glw::GL_TIMEOUT_IGNORED) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if flags is not zero.");
    // SAFETY: the handle is the one created above.
    unsafe { gl.wait_sync(sync, 0x0010, glw::GL_TIMEOUT_IGNORED) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if timeout is not GL_TIMEOUT_IGNORED.");
    // SAFETY: as above.
    unsafe { gl.wait_sync(sync, 0, 0) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: as above.
    unsafe { gl.delete_sync(sync) };
}

fn client_wait_sync(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: a current context; the returned handle is deleted at the end.
    let sync = unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };

    case.section("GL_INVALID_VALUE is generated if sync is not the name of an existing sync object.");
    // SAFETY: a null handle is exactly the error being provoked; GL validates it.
    unsafe { gl.client_wait_sync(std::ptr::null_mut(), 0, 10000) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if flags contains any unsupported flag.");
    // SAFETY: the handle is the one created above.
    unsafe { gl.client_wait_sync(sync, 0x00000004, 10000) };
    case.expect_error(glw::GL_INVALID_VALUE);

    // SAFETY: as above.
    unsafe { gl.delete_sync(sync) };
}

fn delete_sync(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if sync is neither zero or the name of a sync object.");
    // SAFETY: the bogus handle is the error being provoked - GL rejects any value that
    // is not one it handed out, and upstream passes the same literal 1.
    unsafe { gl.delete_sync(std::ptr::without_provenance_mut(1)) };
    case.expect_error(glw::GL_INVALID_VALUE);
    // SAFETY: zero is explicitly a no-op.
    unsafe { gl.delete_sync(std::ptr::null_mut()) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `NegativeFragmentApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("scissor", scissor),
        ("depth_func", depth_func),
        ("viewport", viewport),
        ("stencil_func", stencil_func),
        ("stencil_func_separate", stencil_func_separate),
        ("stencil_op", stencil_op),
        ("stencil_op_separate", stencil_op_separate),
        ("stencil_mask_separate", stencil_mask_separate),
        ("blend_equation", blend_equation),
        ("blend_equation_separate", blend_equation_separate),
        ("blend_func", blend_func),
        ("blend_func_separate", blend_func_separate),
        ("blend_equationi", blend_equationi),
        ("blend_equation_separatei", blend_equation_separatei),
        ("blend_funci", blend_funci),
        ("blend_func_separatei", blend_func_separatei),
        ("cull_face", cull_face),
        ("front_face", front_face),
        ("line_width", line_width),
        ("gen_queries", gen_queries),
        ("begin_query", begin_query),
        ("end_query", end_query),
        ("delete_queries", delete_queries),
        ("fence_sync", fence_sync),
        ("wait_sync", wait_sync),
        ("client_wait_sync", client_wait_sync),
        ("delete_sync", delete_sync),
    ];
    add_api_cases(&mut group, cases);
    group
}
