// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fComputeShaderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One `TestCase` per compute-shader built-in (`gl_NumWorkGroups`/`gl_WorkGroupSize`/
// `gl_WorkGroupID`/`gl_LocalInvocationID`/`gl_GlobalInvocationID`/`gl_LocalInvocationIndex`),
// each writing the built-in straight into an unsized SSBO array (one element per invocation,
// indexed by `gl_GlobalInvocationID` through a uniform stride) and comparing every element
// against a host-computed reference. Genuinely new shape for this campaign - not
// `gls::ShaderRenderCase`/`gls::shader_exec_util` at all, just a raw compute dispatch plus a
// buffer readback, the same shape `ssbo_array_length_tests.rs` already uses. Upstream splits
// each case's own list of (local size, work group count) sub-cases across `init`/several
// `iterate()` calls purely to keep any one iteration's log short; a single call over the
// whole list does the same work with no functional difference, matching how
// `ssbo_array_length_tests.rs` already collapsed a similar multi-iterate case. Local
// `(u32, u32, u32)` triples stand in for `UVec3` here rather than `tcu::vector::UVec3` -
// `tcu::Vector` has no component-wise arithmetic for an integer element type yet (only
// `f32`, added for the shader-render evaluators), and this file is the only place that
// needs it.

use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Triple = (u32, u32, u32);

fn mul3(a: Triple, b: Triple) -> Triple {
    (a.0 * b.0, a.1 * b.1, a.2 * b.2)
}

fn add3(a: Triple, b: Triple) -> Triple {
    (a.0 + b.0, a.1 + b.1, a.2 + b.2)
}

/// One `ComputeBuiltinVarCase` subclass each - `glsl_name`/`num_comps`/`compute_reference`
/// are that subclass's own overrides, `sub_cases` its own constructor's `m_subCases` list.
#[derive(Clone, Copy)]
enum Builtin {
    NumWorkGroups,
    WorkGroupSize,
    WorkGroupId,
    LocalInvocationId,
    GlobalInvocationId,
    LocalInvocationIndex,
}

impl Builtin {
    fn case_name(self) -> &'static str {
        match self {
            Self::NumWorkGroups => "num_work_groups",
            Self::WorkGroupSize => "work_group_size",
            Self::WorkGroupId => "work_group_id",
            Self::LocalInvocationId => "local_invocation_id",
            Self::GlobalInvocationId => "global_invocation_id",
            Self::LocalInvocationIndex => "local_invocation_index",
        }
    }

    fn glsl_name(self) -> &'static str {
        match self {
            Self::NumWorkGroups => "gl_NumWorkGroups",
            Self::WorkGroupSize => "gl_WorkGroupSize",
            Self::WorkGroupId => "gl_WorkGroupID",
            Self::LocalInvocationId => "gl_LocalInvocationID",
            Self::GlobalInvocationId => "gl_GlobalInvocationID",
            Self::LocalInvocationIndex => "gl_LocalInvocationIndex",
        }
    }

    /// `TYPE_UINT_VEC3` everywhere except `gl_LocalInvocationIndex`'s plain `TYPE_UINT`.
    fn num_comps(self) -> usize {
        match self {
            Self::LocalInvocationIndex => 1,
            _ => 3,
        }
    }

    fn glsl_type(self) -> &'static str {
        match self {
            Self::LocalInvocationIndex => "uint",
            _ => "uvec3",
        }
    }

    /// `ComputeBuiltinVarCase::computeReference`, one arm per subclass.
    fn compute_reference(
        self,
        num_work_groups: Triple,
        work_group_size: Triple,
        work_group_id: Triple,
        local_invocation_id: Triple,
    ) -> Triple {
        match self {
            Self::NumWorkGroups => num_work_groups,
            Self::WorkGroupSize => work_group_size,
            Self::WorkGroupId => work_group_id,
            Self::LocalInvocationId => local_invocation_id,
            Self::GlobalInvocationId => add3(mul3(work_group_id, work_group_size), local_invocation_id),
            Self::LocalInvocationIndex => (
                local_invocation_id.2 * work_group_size.0 * work_group_size.1
                    + local_invocation_id.1 * work_group_size.0
                    + local_invocation_id.0,
                0,
                0,
            ),
        }
    }

    /// `m_subCases`, `(localSize, numWorkGroups)` per entry - each subclass's own constructor
    /// upstream, verbatim.
    fn sub_cases(self) -> &'static [(Triple, Triple)] {
        const A: &[(Triple, Triple)] = &[
            ((1, 1, 1), (1, 1, 1)),
            ((1, 1, 1), (52, 1, 1)),
            ((1, 1, 1), (1, 39, 1)),
            ((1, 1, 1), (1, 1, 78)),
            ((1, 1, 1), (4, 7, 11)),
            ((2, 3, 4), (4, 7, 11)),
        ];
        const B: &[(Triple, Triple)] = &[
            ((1, 1, 1), (1, 1, 1)),
            ((1, 1, 1), (2, 7, 3)),
            ((2, 1, 1), (1, 1, 1)),
            ((2, 1, 1), (1, 3, 5)),
            ((1, 3, 1), (1, 1, 1)),
            ((1, 1, 7), (1, 1, 1)),
            ((1, 1, 7), (3, 3, 1)),
            ((10, 3, 4), (1, 1, 1)),
            ((10, 3, 4), (3, 1, 2)),
        ];
        const C: &[(Triple, Triple)] = &[
            ((1, 1, 1), (1, 1, 1)),
            ((1, 1, 1), (52, 1, 1)),
            ((1, 1, 1), (1, 39, 1)),
            ((1, 1, 1), (1, 1, 78)),
            ((1, 1, 1), (4, 7, 11)),
            ((2, 3, 4), (4, 7, 11)),
            ((10, 3, 4), (1, 1, 1)),
            ((10, 3, 4), (3, 1, 2)),
        ];
        const D: &[(Triple, Triple)] = &[
            ((1, 1, 1), (1, 1, 1)),
            ((1, 1, 1), (1, 39, 1)),
            ((1, 1, 1), (4, 7, 11)),
            ((2, 3, 4), (4, 7, 11)),
            ((10, 3, 4), (1, 1, 1)),
            ((10, 3, 4), (3, 1, 2)),
        ];
        match self {
            Self::NumWorkGroups | Self::WorkGroupId => A,
            Self::WorkGroupSize | Self::LocalInvocationId => B,
            Self::GlobalInvocationId => C,
            Self::LocalInvocationIndex => D,
        }
    }
}

/// `ComputeBuiltinVarCase::genBuiltinVarSource`
fn gen_builtin_var_source(builtin: Builtin, local_size: Triple) -> String {
    format!(
        "#version 310 es\n\
         layout (local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n\
         uniform highp uvec2 u_stride;\n\
         layout(binding = 0) buffer Output\n\
         {{\n    \
         {} result[];\n\
         }} sb_out;\n\
         \n\
         void main (void)\n\
         {{\n    \
         highp uint offset = u_stride.x*gl_GlobalInvocationID.z + u_stride.y*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n    \
         sb_out.result[offset] = {};\n\
         }}\n",
        local_size.0,
        local_size.1,
        local_size.2,
        builtin.glsl_type(),
        builtin.glsl_name(),
    )
}

struct ComputeBuiltinVarCase {
    name: String,
    builtin: Builtin,
}

impl TestCase for ComputeBuiltinVarCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ComputeBuiltinVarCase::iterate`, over every one of `Builtin::sub_cases` in one call.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        for &(local_size, num_work_groups) in self.builtin.sub_cases() {
            let source = gen_builtin_var_source(self.builtin, local_size);
            let program = ShaderProgram::new(gl, &ProgramSources::compute(source));
            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }
            let program_id = program.program();

            let global_size = mul3(local_size, num_work_groups);
            let stride = (global_size.0 * global_size.1, global_size.0);
            let num_invocations =
                local_size.0 * local_size.1 * local_size.2 * num_work_groups.0 * num_work_groups.1 * num_work_groups.2;

            // SAFETY: `program_id` just linked successfully, and `"Output.result"` is a
            // buffer variable it declares.
            let out_var_index = unsafe {
                gl.get_program_resource_index(program_id, glw::GL_BUFFER_VARIABLE, c"Output.result".as_ptr())
            };
            let out_var_info =
                glu::get_program_interface_variable_info(gl, program_id, glw::GL_BUFFER_VARIABLE, out_var_index)?;

            if out_var_info.array_size != 0 {
                return Err(TestError::Fail("Output.result is not an unsized array".to_string()));
            }

            let buffer_size = num_invocations as isize * out_var_info.array_stride as isize;
            let output_buffer = Buffer::new(gl);

            // SAFETY: a null data pointer only allocates `buffer_size` bytes.
            unsafe {
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    buffer_size,
                    std::ptr::null(),
                    glw::GL_STREAM_READ,
                );
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "buffer setup")?;

                gl.use_program(program_id);
                let loc = gl.get_uniform_location(program_id, c"u_stride".as_ptr());
                gl.uniform_2uiv(loc, 1, [stride.0, stride.1].as_ptr());
                glu::expect_no_error(gl, "program setup")?;

                gl.dispatch_compute(num_work_groups.0, num_work_groups.1, num_work_groups.2);
                glu::expect_no_error(gl, "dispatch")?;
            }

            // SAFETY: the mapping covers the whole buffer just allocated above, and every
            // read stays within it (`element_stride` apart, `num_invocations` elements); the
            // pointer is read through before being unmapped.
            let mismatch = unsafe {
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                let ptr = gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer_size, glw::GL_MAP_READ_BIT);
                glu::expect_no_error(gl, "map")?;
                if ptr.is_null() {
                    return Err(TestError::Fail("mapBufferRange returned NULL".to_string()));
                }

                let num_comps = self.builtin.num_comps();
                let mut mismatch = None;
                'search: for group_z in 0..num_work_groups.2 {
                    for group_y in 0..num_work_groups.1 {
                        for group_x in 0..num_work_groups.0 {
                            for local_z in 0..local_size.2 {
                                for local_y in 0..local_size.1 {
                                    for local_x in 0..local_size.0 {
                                        let group_id = (group_x, group_y, group_z);
                                        let local_id = (local_x, local_y, local_z);
                                        let global_id = add3(mul3(group_id, local_size), local_id);
                                        let offset = stride.0 * global_id.2 + stride.1 * global_id.1 + global_id.0;
                                        let reference = self.builtin.compute_reference(
                                            num_work_groups,
                                            local_size,
                                            group_id,
                                            local_id,
                                        );

                                        let elem_ptr = ptr
                                            .cast::<u8>()
                                            .add(offset as usize * out_var_info.array_stride as usize)
                                            .cast::<u32>();
                                        let actual: Triple = (
                                            elem_ptr.read_unaligned(),
                                            if num_comps > 1 {
                                                elem_ptr.add(1).read_unaligned()
                                            } else {
                                                0
                                            },
                                            if num_comps > 2 {
                                                elem_ptr.add(2).read_unaligned()
                                            } else {
                                                0
                                            },
                                        );

                                        let matches = if num_comps == 3 {
                                            actual == reference
                                        } else {
                                            actual.0 == reference.0
                                        };
                                        if !matches {
                                            mismatch = Some((offset, reference, actual));
                                            break 'search;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) == glw::FALSE {
                    return Err(TestError::Fail("unmapBuffer returned false".to_string()));
                }
                glu::expect_no_error(gl, "unmap")?;

                mismatch
            };

            if let Some((offset, reference, actual)) = mismatch {
                log::warn!("ERROR: comparison failed at offset {offset}: expected {reference:?}, got {actual:?}");
                return Ok(TestStatus::fail("Comparison failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ComputeShaderBuiltinVarTests::init`
pub fn create_tests() -> TestCaseGroup {
    const BUILTINS: [Builtin; 6] = [
        Builtin::NumWorkGroups,
        Builtin::WorkGroupSize,
        Builtin::WorkGroupId,
        Builtin::LocalInvocationId,
        Builtin::GlobalInvocationId,
        Builtin::LocalInvocationIndex,
    ];

    let mut group = TestCaseGroup::new("compute");
    for builtin in BUILTINS {
        group.add_child(Box::new(ComputeBuiltinVarCase {
            name: builtin.case_name().to_string(),
            builtin,
        }) as Box<dyn TestCase>);
    }

    group
}
