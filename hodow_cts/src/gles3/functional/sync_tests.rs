// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fSyncTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`/`deinit` fold into `iterate`,
// and the iteration upstream drives by returning CONTINUE is a loop here.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLbitfield, GLuint64};
use crate::tcu::random::de_string_hash;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

const NUM_CASE_ITERATIONS: i32 = 5;

/// `WaitCommand`
const COMMAND_WAIT_SYNC: u32 = 1 << 0;
const COMMAND_CLIENT_WAIT_SYNC: u32 = 1 << 1;

/// `CaseOptions`
const CASE_FLUSH_BEFORE_WAIT: u32 = 1 << 0;
const CASE_FINISH_BEFORE_WAIT: u32 = 1 << 1;

const VERT_SHADER_SOURCE: &str = "#version 300 es\nlayout(location = 0) in mediump vec4 a_position;\n\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n";
const FRAG_SHADER_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\n\nvoid main (void)\n{\n    o_color = vec4(0.25, 0.5, 0.75, 1.0);\n}\n";

fn generate_vertices(num_primitives: i32, rnd: &mut Random) -> Vec<f32> {
    let num_vertices = 3 * num_primitives;
    let mut dst = vec![0.0f32; (num_vertices * 4) as usize];

    for i in 0..num_vertices as usize {
        dst[i * 4] = rnd.get_float_range(-1.0, 1.0); // x
        dst[i * 4 + 1] = rnd.get_float_range(-1.0, 1.0); // y
        dst[i * 4 + 2] = rnd.get_float_range(0.0, 1.0); // z
        dst[i * 4 + 3] = 1.0; // w
    }

    dst
}

struct FenceSyncCase {
    name: String,
    num_primitives: i32,
    wait_command: u32,
    wait_flags: GLbitfield,
    timeout: GLuint64,
    case_options: u32,
}

impl TestCase for FenceSyncCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERT_SHADER_SOURCE, FRAG_SHADER_SOURCE));
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader program".to_string()));
        }

        for _iter_ndx in 0..NUM_CASE_ITERATIONS {
            let mut test_ok = true;
            let vertices = generate_vertices(self.num_primitives, &mut rnd);

            // SAFETY: the vertex data outlives the draw that reads it, and every sync
            // object below is created and deleted inside this iteration.
            let wait_value = unsafe {
                gl.use_program(program.program());
                gl.enable(glw::GL_DEPTH_TEST);
                gl.clear_color(0.3, 0.3, 0.3, 1.0);
                gl.clear_depthf(1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);

                gl.enable_vertex_attrib_array(0);
                gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, vertices.as_ptr().cast());

                gl.draw_arrays(glw::GL_TRIANGLES, 0, (vertices.len() / 4) as i32);

                let sync_object = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

                if self.case_options & CASE_FLUSH_BEFORE_WAIT != 0 {
                    gl.flush();
                }
                if self.case_options & CASE_FINISH_BEFORE_WAIT != 0 {
                    gl.finish();
                }

                let mut wait_value = 0;

                if self.wait_command & COMMAND_WAIT_SYNC != 0 {
                    debug_assert!(self.timeout == glw::GL_TIMEOUT_IGNORED);
                    debug_assert!(self.wait_flags == 0);
                    gl.wait_sync(sync_object, self.wait_flags, self.timeout);
                }
                if self.wait_command & COMMAND_CLIENT_WAIT_SYNC != 0 {
                    wait_value = gl.client_wait_sync(sync_object, self.wait_flags, self.timeout);
                    match wait_value {
                        glw::GL_ALREADY_SIGNALED | glw::GL_TIMEOUT_EXPIRED | glw::GL_CONDITION_SATISFIED => {}
                        glw::GL_WAIT_FAILED => test_ok = false,
                        _ => return Err(TestError::Fail("Illegal return value!".to_string())),
                    }
                }

                gl.finish();

                if !sync_object.is_null() {
                    gl.delete_sync(sync_object);
                }

                wait_value
            };

            if self.case_options & CASE_FINISH_BEFORE_WAIT != 0 && wait_value != glw::GL_ALREADY_SIGNALED {
                test_ok = false;
            }

            if !test_ok {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SyncTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fence_sync");

    let mut fence_sync_case = |name: &str, num_primitives: i32, wait_command: u32, wait_flags: GLbitfield, timeout: GLuint64, options: u32| {
        group.add_child(Box::new(FenceSyncCase {
            name: name.to_string(),
            num_primitives,
            wait_command,
            wait_flags,
            timeout,
            case_options: options,
        }) as Box<dyn TestCase>);
    };

    fence_sync_case("wait_sync_smalldraw", 10, COMMAND_WAIT_SYNC, 0, glw::GL_TIMEOUT_IGNORED, 0);
    fence_sync_case("wait_sync_largedraw", 10000, COMMAND_WAIT_SYNC, 0, glw::GL_TIMEOUT_IGNORED, 0);

    fence_sync_case("client_wait_sync_smalldraw", 10, COMMAND_CLIENT_WAIT_SYNC, 0, 0, 0);
    fence_sync_case("client_wait_sync_largedraw", 10000, COMMAND_CLIENT_WAIT_SYNC, 0, 0, 0);
    fence_sync_case("client_wait_sync_timeout_smalldraw", 10, COMMAND_CLIENT_WAIT_SYNC, 0, 10, 0);
    fence_sync_case("client_wait_sync_timeout_largedraw", 10000, COMMAND_CLIENT_WAIT_SYNC, 0, 10, 0);

    fence_sync_case("client_wait_sync_flush_auto", 10000, COMMAND_CLIENT_WAIT_SYNC, glw::GL_SYNC_FLUSH_COMMANDS_BIT, 0, 0);
    fence_sync_case("client_wait_sync_flush_manual", 10000, COMMAND_CLIENT_WAIT_SYNC, 0, 0, CASE_FLUSH_BEFORE_WAIT);
    fence_sync_case("client_wait_sync_noflush", 10000, COMMAND_CLIENT_WAIT_SYNC, 0, 0, 0);
    fence_sync_case("client_wait_sync_finish", 10000, COMMAND_CLIENT_WAIT_SYNC, 0, 0, CASE_FINISH_BEFORE_WAIT);

    group
}
