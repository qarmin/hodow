// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSynchronizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The whole file is ported - all 104
// cases: `in_invocation` and `inter_invocation` (40, everything upstream builds from
// `InterInvocationTestCase`), `inter_call.with_memory_barrier` (28, upstream's `op::`
// command list + `InterCallTestCase`) and `inter_call.without_memory_barrier` (36, the
// four `Concurrent*` classes over `validateSortedAtomicRampAdditionValueChain`).
//
// Two deliberate shape changes, both collapsing a class family into a `match`:
//
// - upstream's five `InterInvocationTestCase` subclasses (`InvocationWriteReadCase`,
//   `InvocationReadWriteCase`, `InvocationOverWriteCase` and `InvocationAliasWriteCase`
//   in its two flavours) differ only in the body of `genShaderMainBlock`, so they are one
//   struct with a `CaseKind` here and the shader text is chosen by a `match`. Each arm is
//   one upstream function, named in its comment.
// - upstream's `InterCallOperations` exists only to give `operator<<` somewhere to push a
//   command into a `std::vector<Command>` holding a tagged union. A `Vec<Command>` of a
//   Rust enum is that vector, so the builder class has nothing left to port and the case
//   registrations below pass the vector directly.

use std::collections::BTreeMap;

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, expect_no_error};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

/// `InterInvocationTestCase::StorageType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum StorageType {
    Buffer,
    Image,
}

/// `InterInvocationTestCase::CaseFlags`
const FLAG_ATOMIC: u32 = 0x1;
const FLAG_ALIASING_STORAGES: u32 = 0x2;
const FLAG_IN_GROUP: u32 = 0x4;

/// `InvocationAliasWriteCase::TestType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum AliasType {
    Write,
    Overwrite,
}

/// Which of upstream's five `InterInvocationTestCase` subclasses a case is.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    WriteRead,
    ReadWrite,
    OverWrite,
    AliasWrite(AliasType),
}

const WORK_WIDTH: i32 = 256; // !< total work width
const WORK_HEIGHT: i32 = 256; // !<     ...    height
const LOCAL_WIDTH: i32 = 16; // !< group width
const LOCAL_HEIGHT: i32 = 8; // !< group height
const ELEMENTS_PER_INVOCATION: i32 = 8; // !< elements accessed by a single invocation

/// `checkSupport`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached and is not written out.
fn check_support(context: &Context) -> bool {
    context.context_type().supports(3, 2)
        || context
            .context_info
            .is_extension_supported("GL_OES_shader_image_atomic")
}

/// `specializeShader`
fn specialize_shader(context: &Context, code: &str) -> String {
    let shader_image_atomic_require = if context.context_type().supports(3, 2) {
        ""
    } else {
        "#extension GL_OES_shader_image_atomic : require"
    };

    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
    .replace("${SHADER_IMAGE_ATOMIC_REQUIRE}", shader_image_atomic_require)
}

/// `readBuffer`
///
/// # Safety
/// `target` must have a buffer bound that holds at least `num_elements` values of `T`.
unsafe fn read_buffer<T: Copy>(
    gl: &glw::Functions,
    target: glw::GLenum,
    num_elements: usize,
) -> Result<Vec<T>, TestError> {
    // SAFETY: the caller guarantees the bound buffer is large enough; the mapping is
    // released again below.
    let ptr = unsafe {
        gl.map_buffer_range(
            target,
            0,
            (size_of::<T>() * num_elements) as glw::GLsizeiptr,
            glw::GL_MAP_READ_BIT,
        )
    };
    expect_no_error(gl, "map")?;

    if ptr.is_null() {
        return Err(TestError::Fail("mapBufferRange returned NULL".to_string()));
    }

    // SAFETY: the driver mapped at least the requested range; it is copied out before
    // the mapping is released, and the destination is a properly aligned Vec.
    let result = unsafe { std::slice::from_raw_parts(ptr.cast::<T>(), num_elements) }.to_vec();

    // SAFETY: releasing the mapping made above.
    if unsafe { gl.unmap_buffer(target) } == glw::GL_FALSE as glw::GLboolean {
        return Err(TestError::Fail("unmapBuffer returned false".to_string()));
    }

    Ok(result)
}

/// `InterInvocationTestCase` and its five subclasses.
struct InterInvocationTestCase {
    name: String,
    kind: CaseKind,
    storage: StorageType,
    use_atomic: bool,
    aliasing_storages: bool,
    sync_with_group: bool,
}

impl InterInvocationTestCase {
    /// `InterInvocationTestCase::InterInvocationTestCase`
    fn new(name: String, kind: CaseKind, storage: StorageType, flags: u32) -> Self {
        // `InvocationAliasWriteCase` adds FLAG_ALIASING_STORAGES to whatever it is given.
        let flags = if matches!(kind, CaseKind::AliasWrite(_)) {
            flags | FLAG_ALIASING_STORAGES
        } else {
            flags
        };

        Self {
            name,
            kind,
            storage,
            use_atomic: (flags & FLAG_ATOMIC) != 0,
            aliasing_storages: (flags & FLAG_ALIASING_STORAGES) != 0,
            sync_with_group: (flags & FLAG_IN_GROUP) != 0,
        }
    }

    /// `InterInvocationTestCase::genBarrierSource`
    fn gen_barrier_source(&self) -> &'static str {
        if self.sync_with_group {
            // Wait until all invocations in this work group have their texture/buffer read/write operations complete
            // \note We could also use memoryBarrierBuffer() or memoryBarrierImage() in place of groupMemoryBarrier() but
            //       we only require intra-workgroup synchronization.
            "\n    groupMemoryBarrier();\n    barrier();\n\n"
        } else if self.storage == StorageType::Buffer {
            // Waiting only for data written by this invocation. Since all buffer reads and writes are
            // processed in order (within a single invocation), we don't have to do anything.
            "\n"
        } else {
            // Waiting only for data written by this invocation. But since operations complete in undefined
            // order, we have to wait for them to complete.
            "\n    memoryBarrierImage();\n\n"
        }
    }

    /// The local ID expression a read or a second write uses: another invocation's when
    /// the case synchronises with the whole group, its own otherwise.
    fn local_id(&self, x_offset: i32, y_offset: i32) -> String {
        if self.sync_with_group {
            format!("(gl_LocalInvocationID.xy + uvec2({x_offset}, {y_offset})) % gl_WorkGroupSize.xy")
        } else {
            "gl_LocalInvocationID.xy".to_string()
        }
    }

    /// How upstream spells the group index in a *first* write: the image forms wrap it
    /// in `int(...)` where the buffer forms do not. Semantically identical - `groupNdx`
    /// is already an `int` - but the generated source is what a driver compiles, so it
    /// is reproduced verbatim.
    fn group_ndx_value(&self) -> &'static str {
        match self.storage {
            StorageType::Buffer => "groupNdx",
            StorageType::Image => "int(groupNdx)",
        }
    }

    /// One `sb_store`/`u_image` write of `value` at this invocation's own index.
    fn write_own(&self, storage_name: &str, value: &str, ndx: i32) -> String {
        match (self.storage, self.use_atomic) {
            (StorageType::Buffer, true) => {
                format!("\tatomicAdd({storage_name}.values[getIndex(gl_LocalInvocationID.xy, {ndx})], {value});\n")
            }
            (StorageType::Buffer, false) => {
                format!("\t{storage_name}.values[getIndex(gl_LocalInvocationID.xy, {ndx})] = {value};\n")
            }
            (StorageType::Image, true) => {
                format!("\timageAtomicAdd({storage_name}, getCoord(gl_LocalInvocationID.xy, {ndx}), {value});\n")
            }
            (StorageType::Image, false) => format!(
                "\timageStore({storage_name}, getCoord(gl_LocalInvocationID.xy, {ndx}), ivec4({value}, 0, 0, 0));\n"
            ),
        }
    }

    /// An exchanging write of `groupNdx` at `local_id`, which is what an overwrite does.
    fn overwrite(&self, storage_name: &str, local_id: &str, ndx: i32) -> String {
        match (self.storage, self.use_atomic) {
            (StorageType::Buffer, true) => {
                format!("\tatomicExchange({storage_name}.values[getIndex({local_id}, {ndx})], groupNdx);\n")
            }
            (StorageType::Buffer, false) => {
                format!("\t{storage_name}.values[getIndex({local_id}, {ndx})] = groupNdx;\n")
            }
            (StorageType::Image, true) => {
                format!("\timageAtomicExchange({storage_name}, getCoord({local_id}, {ndx}), groupNdx);\n")
            }
            (StorageType::Image, false) => {
                format!("\timageStore({storage_name}, getCoord({local_id}, {ndx}), ivec4(groupNdx, 0, 0, 0));\n")
            }
        }
    }

    /// A read that compares against `expected`; the atomic form exchanges `written` in
    /// while reading, which is what makes the read itself a write too.
    fn read_check(&self, storage_name: &str, local_id: &str, ndx: i32, written: i32, expected: &str) -> String {
        match (self.storage, self.use_atomic) {
            (StorageType::Buffer, true) => format!(
                "\tallOk = allOk && (atomicExchange({storage_name}.values[getIndex({local_id}, {ndx})], {written}) == {expected});\n"
            ),
            (StorageType::Buffer, false) => {
                format!("\tallOk = allOk && ({storage_name}.values[getIndex({local_id}, {ndx})] == {expected});\n")
            }
            (StorageType::Image, true) => format!(
                "\tallOk = allOk && (imageAtomicExchange({storage_name}, getCoord({local_id}, {ndx}), {written}) == {expected});\n"
            ),
            (StorageType::Image, false) => format!(
                "\tallOk = allOk && (imageLoad({storage_name}, getCoord({local_id}, {ndx})).x == {expected});\n"
            ),
        }
    }

    /// `InvocationWriteReadCase::genShaderMainBlock`
    fn gen_write_read_block(&self) -> String {
        let mut buf = String::new();
        let store = self.storage_name(0);

        // write
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            buf.push_str(&self.write_own(store, self.group_ndx_value(), ndx));
        }

        // barrier
        buf.push_str(self.gen_barrier_source());

        // read
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            let local_id = self.local_id(ndx + 1, 2 * ndx);
            buf.push_str(&self.read_check(store, &local_id, ndx, 0, "groupNdx"));
        }

        buf
    }

    /// `InvocationReadWriteCase::genShaderMainBlock`
    fn gen_read_write_block(&self) -> String {
        let mut buf = String::new();
        let store = self.storage_name(0);

        // read
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            let local_id = self.local_id(ndx + 1, 2 * ndx);
            buf.push_str(&self.read_check(store, &local_id, ndx, 123, "0"));
        }

        // barrier
        buf.push_str(self.gen_barrier_source());

        // write
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            buf.push_str(&self.write_own(store, self.group_ndx_value(), ndx));
        }

        buf
    }

    /// `InvocationOverWriteCase::genShaderMainBlock`
    fn gen_over_write_block(&self) -> String {
        let mut buf = String::new();
        let store = self.storage_name(0);

        // write
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            buf.push_str(&self.write_own(store, "456", ndx));
        }

        // barrier
        buf.push_str(self.gen_barrier_source());

        // write over
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            // write another invocation's value or our own value depending on test type
            let local_id = self.local_id(ndx + 4, 3 * ndx);
            buf.push_str(&self.overwrite(store, &local_id, ndx));
        }

        // barrier
        buf.push_str(self.gen_barrier_source());

        // read
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            // check another invocation's value or our own value depending on test type
            let local_id = self.local_id(ndx + 1, 2 * ndx);
            buf.push_str(&self.read_check(store, &local_id, ndx, 123, "groupNdx"));
        }

        buf
    }

    /// The storage name a generated statement uses: the aliasing cases have two
    /// storages, every other case exactly one.
    fn storage_name(&self, index: u32) -> &'static str {
        match (self.storage, self.aliasing_storages, index) {
            (StorageType::Buffer, false, _) => "sb_store",
            (StorageType::Buffer, true, 0) => "sb_store0",
            (StorageType::Buffer, true, _) => "sb_store1",
            (StorageType::Image, false, _) => "u_image",
            (StorageType::Image, true, 0) => "u_image0",
            (StorageType::Image, true, _) => "u_image1",
        }
    }

    /// `InvocationBasicCase::genShaderSource` / `InvocationAliasWriteCase::genShaderSource`
    fn gen_shader_source(&self, context: &Context) -> String {
        specialize_shader(context, &self.gen_shader_source_template())
    }

    /// The same, before `specializeShader` substitutes the context-dependent tokens -
    /// split out so a test can compare the generated text against upstream's own
    /// without needing a GL context.
    fn gen_shader_source_template(&self) -> String {
        let use_image_atomics = self.use_atomic && self.storage == StorageType::Image;
        let mut buf = String::new();

        buf.push_str("${GLSL_VERSION_DECL}\n");
        if use_image_atomics {
            buf.push_str("${SHADER_IMAGE_ATOMIC_REQUIRE}\n");
        }
        buf.push_str(&format!(
            "layout (local_size_x={LOCAL_WIDTH}, local_size_y={LOCAL_HEIGHT}) in;\n"
        ));
        buf.push_str("layout(binding=0, std430) buffer Output\n{\n    highp int values[];\n} sb_result;\n");

        if self.storage == StorageType::Buffer {
            if self.aliasing_storages {
                buf.push_str(
                    "layout(binding=1, std430) coherent buffer Storage0\n{\n    highp int values[];\n} sb_store0;\n",
                );
                buf.push_str(
                    "layout(binding=2, std430) coherent buffer Storage1\n{\n    highp int values[];\n} sb_store1;\n",
                );
            } else {
                buf.push_str(
                    "layout(binding=1, std430) coherent buffer Storage\n{\n    highp int values[];\n} sb_store;\n",
                );
            }
            buf.push_str(
                "\nhighp int getIndex (in highp uvec2 localID, in highp int element)\n\
                 {\n    highp uint groupNdx = gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;\n",
            );
            buf.push_str(&format!(
                "    return int((localID.y * gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupSize.x) + (groupNdx * gl_WorkGroupSize.x) + localID.x) * {ELEMENTS_PER_INVOCATION} + element;\n}}\n"
            ));
        } else {
            if self.aliasing_storages {
                buf.push_str("layout(r32i, binding=1) coherent uniform highp iimage2D u_image0;\n");
                buf.push_str("layout(r32i, binding=2) coherent uniform highp iimage2D u_image1;\n");
            } else {
                buf.push_str("layout(r32i, binding=1) coherent uniform highp iimage2D u_image;\n");
            }
            buf.push_str("\nhighp ivec2 getCoord (in highp uvec2 localID, in highp int element)\n{\n");
            buf.push_str(&format!(
                "    return ivec2(int(gl_WorkGroupID.x * gl_WorkGroupSize.x + localID.x), int(gl_WorkGroupID.y * gl_WorkGroupSize.y + localID.y) + element * {WORK_HEIGHT});\n}}\n"
            ));
        }

        buf.push_str(
            "\nvoid main (void)\n{\n\
             \x20   int resultNdx   = int(gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x + gl_GlobalInvocationID.x);\n\
             \x20   int groupNdx    = int(gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x);\n\
             \x20   bool allOk      = true;\n\n",
        );

        match self.kind {
            CaseKind::WriteRead => buf.push_str(&self.gen_write_read_block()),
            CaseKind::ReadWrite => buf.push_str(&self.gen_read_write_block()),
            CaseKind::OverWrite => buf.push_str(&self.gen_over_write_block()),
            CaseKind::AliasWrite(alias_type) => buf.push_str(&self.gen_alias_write_block(alias_type)),
        }

        // `InvocationBasicCase` puts a newline between the block and the result store;
        // `InvocationAliasWriteCase` writes that newline itself, so both end up here.
        buf.push_str("\n    sb_result.values[resultNdx] = (allOk) ? (1) : (0);\n}\n");

        buf
    }

    /// The body of `InvocationAliasWriteCase::genShaderSource` between the declarations
    /// and the result store.
    fn gen_alias_write_block(&self, alias_type: AliasType) -> String {
        let mut buf = String::new();
        let store0 = self.storage_name(0);
        let store1 = self.storage_name(1);

        if alias_type == AliasType::Overwrite {
            // write
            for ndx in 0..ELEMENTS_PER_INVOCATION {
                buf.push_str(&self.write_own(store0, "456", ndx));
            }

            // barrier
            buf.push_str(self.gen_barrier_source());
        }

        // write (again)
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            let local_id = self.local_id(ndx + 2, 2 * ndx);
            buf.push_str(&self.overwrite(store1, &local_id, ndx));
        }

        // barrier
        buf.push_str(self.gen_barrier_source());

        // read
        for ndx in 0..ELEMENTS_PER_INVOCATION {
            buf.push_str(&self.read_check(store0, "gl_LocalInvocationID.xy", ndx, 123, "groupNdx"));
        }

        buf
    }

    /// `InterInvocationTestCase::runCompute`
    ///
    /// # Safety
    /// The objects passed in must be the ones `init` created for this case.
    unsafe fn run_compute(
        &self,
        gl: &glw::Functions,
        program: GLuint,
        storage_buf: GLuint,
        storage_tex: GLuint,
        result_buf: GLuint,
    ) -> Result<(), TestError> {
        let groups_x = WORK_WIDTH / LOCAL_WIDTH;
        let groups_y = WORK_HEIGHT / LOCAL_HEIGHT;

        // SAFETY: every handle is this case's own and the program was built above.
        unsafe {
            gl.use_program(program);

            // source
            match (self.storage, self.aliasing_storages) {
                (StorageType::Buffer, false) => {
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, storage_buf);
                    expect_no_error(gl, "bind source buf")?;
                }
                (StorageType::Buffer, true) => {
                    // Binding same buffer object to buffer storages.
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, storage_buf);
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, storage_buf);
                    expect_no_error(gl, "bind source buf")?;
                }
                (StorageType::Image, false) => {
                    gl.bind_image_texture(
                        1,
                        storage_tex,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        glw::GL_READ_WRITE,
                        glw::GL_R32I,
                    );
                    expect_no_error(gl, "bind result buf")?;
                }
                (StorageType::Image, true) => {
                    // Binding same texture level to image storages.
                    gl.bind_image_texture(
                        1,
                        storage_tex,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        glw::GL_READ_WRITE,
                        glw::GL_R32I,
                    );
                    gl.bind_image_texture(
                        2,
                        storage_tex,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        glw::GL_READ_WRITE,
                        glw::GL_R32I,
                    );
                    expect_no_error(gl, "bind result buf")?;
                }
            }

            // destination
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, result_buf);
            expect_no_error(gl, "bind result buf")?;

            // dispatch
            gl.dispatch_compute(groups_x as GLuint, groups_y as GLuint, 1);
            expect_no_error(gl, "dispatchCompute")?;
        }

        Ok(())
    }

    /// `InterInvocationTestCase::verifyResults`
    ///
    /// # Safety
    /// `result_buf` must be this case's own result buffer.
    unsafe fn verify_results(&self, gl: &glw::Functions, result_buf: GLuint) -> Result<bool, TestError> {
        let num_elements = (WORK_WIDTH * WORK_HEIGHT) as usize;

        // SAFETY: the buffer was created with exactly this many elements.
        let results = unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, result_buf);
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT);
            read_buffer::<i32>(gl, glw::GL_SHADER_STORAGE_BUFFER, num_elements)?
        };

        Ok(results.iter().all(|&value| value == 1))
    }
}

impl TestCase for InterInvocationTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The requirement `InterInvocationTestCase::init` throws `NotSupportedError` for.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.use_atomic && self.storage == StorageType::Image && !check_support(context) {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_shader_image_atomic extension".to_string(),
            ));
        }

        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // program
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.gen_shader_source(context)));
        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        let mut storage_buf: GLuint = 0;
        let mut storage_tex: GLuint = 0;
        let mut result_buf: GLuint = 0;
        let storage_elements = (WORK_WIDTH * WORK_HEIGHT * ELEMENTS_PER_INVOCATION) as usize;

        // SAFETY: every object created here is this case's own and is deleted below.
        unsafe {
            // source
            if self.storage == StorageType::Buffer {
                let zero_buffer = vec![0u32; storage_elements];

                gl.gen_buffers(1, &mut storage_buf);
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, storage_buf);
                gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    (storage_elements * size_of::<u32>()) as glw::GLsizeiptr,
                    zero_buffer.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                expect_no_error(gl, "gen storage buf")?;
            } else {
                gl.gen_textures(1, &mut storage_tex);
                gl.bind_texture(glw::GL_TEXTURE_2D, storage_tex);
                gl.tex_storage_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    glw::GL_R32I,
                    WORK_WIDTH,
                    WORK_HEIGHT * ELEMENTS_PER_INVOCATION,
                );
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                expect_no_error(gl, "gen storage image")?;

                // Zero-fill
                let zero_buffer = vec![0i32; storage_elements];
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    WORK_WIDTH,
                    WORK_HEIGHT * ELEMENTS_PER_INVOCATION,
                    glw::GL_RED_INTEGER,
                    glw::GL_INT,
                    zero_buffer.as_ptr().cast(),
                );
                expect_no_error(gl, "specify image contents")?;
            }

            // destination
            let result_elements = (WORK_WIDTH * WORK_HEIGHT) as usize;
            let negative_buffer = vec![-1i32; result_elements];

            gl.gen_buffers(1, &mut result_buf);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, result_buf);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (result_elements * size_of::<i32>()) as glw::GLsizeiptr,
                negative_buffer.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            expect_no_error(gl, "gen storage buf")?;
        }

        // Dispatch, then verify buffer contents.
        // SAFETY: the handles are the ones created immediately above.
        let outcome = unsafe {
            self.run_compute(gl, program.program(), storage_buf, storage_tex, result_buf)
                .and_then(|()| self.verify_results(gl, result_buf))
        };

        // `deinit`
        // SAFETY: deleting this case's own objects, whether or not the run succeeded.
        unsafe {
            if storage_buf != 0 {
                gl.delete_buffers(1, &storage_buf);
            }
            if storage_tex != 0 {
                gl.delete_textures(1, &storage_tex);
            }
            if result_buf != 0 {
                gl.delete_buffers(1, &result_buf);
            }
        }

        if outcome? {
            Ok(TestStatus::pass("Pass"))
        } else if self.storage == StorageType::Buffer {
            Ok(TestStatus::fail("buffer content verification failed"))
        } else {
            Ok(TestStatus::fail("image content verification failed"))
        }
    }
}

/// `InterCallTestCase::m_invocationGridSize` - width and height of the two dimensional work dispatch.
const INVOCATION_GRID_SIZE: i32 = 512;
/// `InterCallTestCase::m_perInvocationSize` - number of elements accessed in single invocation.
const PER_INVOCATION_SIZE: i32 = 2;

/// `InterCallTestCase::Flags`
const FLAG_USE_ATOMIC: u32 = 1;
const FLAG_USE_INT: u32 = 2;

/// One entry of upstream's `InterCallOperations` command list, i.e. its
/// `Command`/`CommandUnion` pair with the `op::` structs folded into the variants.
#[derive(Debug, Clone, Copy)]
enum Command {
    /// `op::WriteData`
    WriteData { target_handle: i32, seed: i32 },
    /// `op::ReadData`
    ReadData { target_handle: i32, seed: i32 },
    /// `op::Barrier`
    Barrier,
    /// `op::ReadMultipleData`
    ReadMultipleData {
        target_handle0: i32,
        seed0: i32,
        target_handle1: i32,
        seed1: i32,
    },
    /// `op::WriteDataInterleaved`
    WriteDataInterleaved {
        target_handle: i32,
        seed: i32,
        even_odd: bool,
    },
    /// `op::ReadDataInterleaved`
    ReadDataInterleaved { target_handle: i32, seed0: i32, seed1: i32 },
    /// `op::ReadZeroData`
    ReadZeroData { target_handle: i32 },
}

/// `InterCallTestCase`
struct InterCallTestCase {
    name: String,
    storage: StorageType,
    use_atomic: bool,
    format_integer: bool,
    cmds: Vec<Command>,
}

impl InterCallTestCase {
    /// `InterCallTestCase::InterCallTestCase`
    fn new(name: String, storage: StorageType, flags: u32, cmds: Vec<Command>) -> Self {
        Self {
            name,
            storage,
            use_atomic: (flags & FLAG_USE_ATOMIC) != 0,
            format_integer: (flags & FLAG_USE_INT) != 0,
            cmds,
        }
    }

    fn value_type(&self) -> &'static str {
        if self.format_integer { "int" } else { "float" }
    }

    fn image_format(&self) -> &'static str {
        if self.format_integer { "r32i" } else { "r32f" }
    }

    fn image_type(&self) -> &'static str {
        if self.format_integer { "iimage2D" } else { "image2D" }
    }

    fn gl_image_format(&self) -> glw::GLenum {
        if self.format_integer {
            glw::GL_R32I
        } else {
            glw::GL_R32F
        }
    }

    /// The `coherent ` qualifier every buffer block carries when the case uses atomics.
    fn buffer_coherent(&self) -> &'static str {
        if self.use_atomic { "coherent " } else { "" }
    }

    /// The version/extension preamble every one of the six generators starts with.
    fn program_preamble(&self) -> String {
        let use_image_atomics = self.use_atomic && self.storage == StorageType::Image;
        let mut buf = String::from("${GLSL_VERSION_DECL}\n");

        if use_image_atomics {
            buf.push_str("${SHADER_IMAGE_ATOMIC_REQUIRE}\n");
        }
        buf.push_str("layout (local_size_x = 1, local_size_y = 1) in;\n");

        buf
    }

    /// The destination declaration the two write generators share (binding 0).
    fn out_storage_decl(&self) -> String {
        match self.storage {
            StorageType::Buffer => format!(
                "layout(binding=0, std430) {}buffer Buffer\n{{\n    highp {} values[];\n}} sb_out;\n",
                self.buffer_coherent(),
                self.value_type()
            ),
            StorageType::Image => format!(
                "layout({}, binding=0) {}uniform highp {} u_imageOut;\n",
                self.image_format(),
                if self.use_atomic { "coherent " } else { "writeonly " },
                self.image_type()
            ),
        }
    }

    /// A source declaration, as the three read generators write it. `suffix` is the empty
    /// string for the single-source generators and `0`/`1` for `genReadMultipleProgram`.
    fn in_storage_decl(&self, binding: i32, suffix: &str) -> String {
        match self.storage {
            StorageType::Buffer => format!(
                "layout(binding={binding}, std430) {}buffer Buffer{suffix}\n{{\n    highp {} values[];\n}} sb_in{suffix};\n",
                self.buffer_coherent(),
                self.value_type()
            ),
            StorageType::Image => format!(
                "layout({}, binding={binding}) {}uniform highp {} u_imageIn{suffix};\n",
                self.image_format(),
                if self.use_atomic { "coherent " } else { "readonly " },
                self.image_type()
            ),
        }
    }

    /// The result buffer declaration every read generator ends its declarations with.
    fn result_storage_decl(&self) -> &'static str {
        "layout(binding=0, std430) buffer ResultBuffer\n{\n    highp int resultOk[];\n} sb_result;\n"
    }

    /// `InterCallTestCase::genWriteProgram`
    fn gen_write_program_template(&self, seed: i32) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.out_storage_decl());

        buf.push_str(
            "\nvoid main (void)\n{\n    uvec3 size    = gl_NumWorkGroups * gl_WorkGroupSize;\n    int groupNdx  = int(size.x * size.y * gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x);\n\n",
        );

        // Write to buffer/image m_perInvocationSize elements
        match self.storage {
            StorageType::Buffer => {
                for write_ndx in 0..PER_INVOCATION_SIZE {
                    buf.push_str(if self.use_atomic { "    atomicExchange(" } else { "    " });
                    buf.push_str(&format!(
                        "sb_out.values[(groupNdx + {}) % {}]",
                        seed + write_ndx * INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE,
                        INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE
                    ));

                    if self.use_atomic {
                        buf.push_str(&format!(", {}(groupNdx));\n", self.value_type()));
                    } else {
                        buf.push_str(&format!(" = {}(groupNdx);\n", self.value_type()));
                    }
                }
            }
            StorageType::Image => {
                for write_ndx in 0..PER_INVOCATION_SIZE {
                    buf.push_str(if self.use_atomic {
                        "    imageAtomicExchange"
                    } else {
                        "    imageStore"
                    });
                    buf.push_str(&format!(
                        "(u_imageOut, ivec2((int(gl_GlobalInvocationID.x) + {}) % {}, int(gl_GlobalInvocationID.y) + {}), ",
                        seed + write_ndx * 100,
                        INVOCATION_GRID_SIZE,
                        write_ndx * INVOCATION_GRID_SIZE
                    ));

                    if self.use_atomic {
                        buf.push_str(&format!("{}(groupNdx));\n", self.value_type()));
                    } else if self.format_integer {
                        buf.push_str("ivec4(int(groupNdx), 0, 0, 0));\n");
                    } else {
                        buf.push_str("vec4(float(groupNdx), 0.0, 0.0, 0.0));\n");
                    }
                }
            }
        }

        buf.push_str("}\n");

        buf
    }

    /// The `main` prologue the four read generators share, up to and including the
    /// scratch variable they hand to `atomicExchange`/`imageAtomicExchange`
    /// (`zero = 0` in three of them, `anything = 5` in `genReadZeroProgram`).
    fn read_main_prologue(&self, extra_decl: &str, scratch_name: &str, scratch_value: &str) -> String {
        format!(
            "\nvoid main (void)\n{{\n    uvec3 size = gl_NumWorkGroups * gl_WorkGroupSize;\n    int groupNdx = int(size.x * size.y * gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x);\n{extra_decl}    {} {scratch_name} = {scratch_value};\n    bool allOk = true;\n\n",
            self.value_type()
        )
    }

    /// `InterCallTestCase::genReadProgram`
    fn gen_read_program_template(&self, seed: i32) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.in_storage_decl(1, ""));
        buf.push_str(self.result_storage_decl());
        buf.push_str(&self.read_main_prologue("", "zero", if self.format_integer { "0" } else { "0.0" }));

        // Verify data
        match self.storage {
            StorageType::Buffer => {
                for read_ndx in 0..PER_INVOCATION_SIZE {
                    let index = seed + read_ndx * INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE;
                    let modulo = INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE;

                    if self.use_atomic {
                        buf.push_str(&format!(
                            "    allOk = allOk && (atomicExchange(sb_in.values[(groupNdx + {index}) % {modulo}], zero) == {}(groupNdx));\n",
                            self.value_type()
                        ));
                    } else {
                        buf.push_str(&format!(
                            "    allOk = allOk && (sb_in.values[(groupNdx + {index}) % {modulo}] == {}(groupNdx));\n",
                            self.value_type()
                        ));
                    }
                }
            }
            StorageType::Image => {
                for read_ndx in 0..PER_INVOCATION_SIZE {
                    let x_offset = seed + read_ndx * 100;
                    let y_offset = read_ndx * INVOCATION_GRID_SIZE;

                    if self.use_atomic {
                        buf.push_str(&format!(
                            "    allOk = allOk && (imageAtomicExchange(u_imageIn, ivec2((gl_GlobalInvocationID.x + {x_offset}u) % {INVOCATION_GRID_SIZE}u, gl_GlobalInvocationID.y + {y_offset}u), zero) == {}(groupNdx));\n",
                            self.value_type()
                        ));
                    } else {
                        buf.push_str(&format!(
                            "    allOk = allOk && (imageLoad(u_imageIn, ivec2((gl_GlobalInvocationID.x + {x_offset}u) % {INVOCATION_GRID_SIZE}u, gl_GlobalInvocationID.y + {y_offset}u)).x == {}(groupNdx));\n",
                            self.value_type()
                        ));
                    }
                }
            }
        }

        buf.push_str("    sb_result.resultOk[groupNdx] = (allOk) ? (1) : (0);\n}\n");

        buf
    }

    /// `InterCallTestCase::genReadMultipleProgram`
    fn gen_read_multiple_program_template(&self, seed0: i32, seed1: i32) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.in_storage_decl(1, "0"));
        buf.push_str(&self.in_storage_decl(2, "1"));
        buf.push_str(self.result_storage_decl());
        buf.push_str(&self.read_main_prologue("", "zero", if self.format_integer { "0" } else { "0.0" }));

        // Verify data
        match self.storage {
            StorageType::Buffer => {
                for read_ndx in 0..PER_INVOCATION_SIZE {
                    let modulo = INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE;

                    for (source_ndx, seed) in [seed0, seed1].into_iter().enumerate() {
                        let index = seed + read_ndx * INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE;

                        buf.push_str(&format!(
                            "    allOk = allOk && ({}sb_in{source_ndx}.values[(groupNdx + {index}) % {modulo}]{} == {}(groupNdx));\n",
                            if self.use_atomic { "atomicExchange(" } else { "" },
                            if self.use_atomic { ", zero)" } else { "" },
                            self.value_type()
                        ));
                    }
                }
            }
            StorageType::Image => {
                for read_ndx in 0..PER_INVOCATION_SIZE {
                    let y_offset = read_ndx * INVOCATION_GRID_SIZE;

                    for (source_ndx, seed) in [seed0, seed1].into_iter().enumerate() {
                        let x_offset = seed + read_ndx * 100;

                        buf.push_str(&format!(
                            "    allOk = allOk && ({}(u_imageIn{source_ndx}, ivec2((gl_GlobalInvocationID.x + {x_offset}u) % {INVOCATION_GRID_SIZE}u, gl_GlobalInvocationID.y + {y_offset}u){} == {}(groupNdx));\n",
                            if self.use_atomic { "imageAtomicExchange" } else { "imageLoad" },
                            if self.use_atomic { ", zero)" } else { ").x" },
                            self.value_type()
                        ));
                    }
                }
            }
        }

        buf.push_str("    sb_result.resultOk[groupNdx] = (allOk) ? (1) : (0);\n}\n");

        buf
    }

    /// `InterCallTestCase::genWriteInterleavedProgram`
    fn gen_write_interleaved_program_template(&self, seed: i32, even_odd: bool) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.out_storage_decl());

        buf.push_str(
            "\nvoid main (void)\n{\n    uvec3 size    = gl_NumWorkGroups * gl_WorkGroupSize;\n    int groupNdx  = int(size.x * size.y * gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x);\n\n",
        );

        // Write to buffer/image m_perInvocationSize elements
        match self.storage {
            StorageType::Buffer => {
                for write_ndx in 0..PER_INVOCATION_SIZE {
                    buf.push_str(if self.use_atomic { "    atomicExchange(" } else { "    " });
                    buf.push_str(&format!(
                        "sb_out.values[((groupNdx + {}) % {}) * 2 + {}]",
                        seed + write_ndx * INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE / 2,
                        INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE / 2 * PER_INVOCATION_SIZE,
                        if even_odd { 0 } else { 1 }
                    ));

                    if self.use_atomic {
                        buf.push_str(&format!(", {}(groupNdx));\n", self.value_type()));
                    } else {
                        // No space before the `=`; upstream writes `"= "` here and `" = "`
                        // in `genWriteProgram`.
                        buf.push_str(&format!("= {}(groupNdx);\n", self.value_type()));
                    }
                }
            }
            StorageType::Image => {
                for write_ndx in 0..PER_INVOCATION_SIZE {
                    buf.push_str(if self.use_atomic {
                        "    imageAtomicExchange"
                    } else {
                        "    imageStore"
                    });
                    buf.push_str(&format!(
                        "(u_imageOut, ivec2(((int(gl_GlobalInvocationID.x) + {}) % {}) * 2 + {}, int(gl_GlobalInvocationID.y) + {}), ",
                        seed + write_ndx * 100,
                        INVOCATION_GRID_SIZE / 2,
                        if even_odd { 0 } else { 1 },
                        write_ndx * INVOCATION_GRID_SIZE
                    ));

                    if self.use_atomic {
                        buf.push_str(&format!("{}(groupNdx));\n", self.value_type()));
                    } else if self.format_integer {
                        buf.push_str("ivec4(int(groupNdx), 0, 0, 0));\n");
                    } else {
                        buf.push_str("vec4(float(groupNdx), 0.0, 0.0, 0.0));\n");
                    }
                }
            }
        }

        buf.push_str("}\n");

        buf
    }

    /// `InterCallTestCase::genReadInterleavedProgram`
    fn gen_read_interleaved_program_template(&self, seed0: i32, seed1: i32) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.in_storage_decl(1, ""));
        buf.push_str(self.result_storage_decl());
        buf.push_str(&self.read_main_prologue(
            "    int interleavedGroupNdx = int((size.x >> 1U) * size.y * gl_GlobalInvocationID.z + (size.x >> 1U) * gl_GlobalInvocationID.y + (gl_GlobalInvocationID.x >> 1U));\n",
            "zero",
            if self.format_integer { "0" } else { "0.0" },
        ));

        // Verify data - the even half of the invocations checks what the `evenOdd` write
        // wrote, the odd half what the other one did.
        buf.push_str("    if (groupNdx % 2 == 0)\n    {\n");
        for (branch_ndx, seed) in [seed0, seed1].into_iter().enumerate() {
            if branch_ndx == 1 {
                buf.push_str("    }\n    else\n    {\n");
            }

            for read_ndx in 0..PER_INVOCATION_SIZE {
                match self.storage {
                    StorageType::Buffer => {
                        let index = seed + read_ndx * INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE / 2;
                        let modulo = INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE / 2;

                        buf.push_str(&format!(
                            "        allOk = allOk && ({}sb_in.values[((interleavedGroupNdx + {index}) % {modulo}) * 2 + {branch_ndx}]{} == {}(interleavedGroupNdx));\n",
                            if self.use_atomic { "atomicExchange(" } else { "" },
                            if self.use_atomic { ", zero)" } else { "" },
                            self.value_type()
                        ));
                    }
                    StorageType::Image => {
                        let x_offset = seed + read_ndx * 100;
                        let y_offset = read_ndx * INVOCATION_GRID_SIZE;

                        buf.push_str(&format!(
                            "        allOk = allOk && ({}(u_imageIn, ivec2(((int(gl_GlobalInvocationID.x >> 1U) + {x_offset}) % {}) * 2 + {branch_ndx}, int(gl_GlobalInvocationID.y) + {y_offset}){} == {}(interleavedGroupNdx));\n",
                            if self.use_atomic { "imageAtomicExchange" } else { "imageLoad" },
                            INVOCATION_GRID_SIZE / 2,
                            if self.use_atomic { ", zero)" } else { ").x" },
                            self.value_type()
                        ));
                    }
                }
            }
        }
        buf.push_str("    }\n");

        buf.push_str("    sb_result.resultOk[groupNdx] = (allOk) ? (1) : (0);\n}\n");

        buf
    }

    /// `InterCallTestCase::genReadZeroProgram`
    fn gen_read_zero_program_template(&self) -> String {
        let mut buf = self.program_preamble();

        buf.push_str(&self.in_storage_decl(1, ""));
        buf.push_str(self.result_storage_decl());
        buf.push_str(&self.read_main_prologue("", "anything", if self.format_integer { "5" } else { "5.0" }));

        // Verify data
        for read_ndx in 0..PER_INVOCATION_SIZE {
            match self.storage {
                StorageType::Buffer => buf.push_str(&format!(
                    "    allOk = allOk && ({}sb_in.values[groupNdx * {PER_INVOCATION_SIZE} + {read_ndx}]{} == {});\n",
                    if self.use_atomic { "atomicExchange(" } else { "" },
                    if self.use_atomic { ", anything)" } else { "" },
                    if self.format_integer { "0" } else { "0.0" }
                )),
                StorageType::Image => buf.push_str(&format!(
                    "    allOk = allOk && ({}(u_imageIn, ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y + {}u){} == {});\n",
                    if self.use_atomic { "imageAtomicExchange" } else { "imageLoad" },
                    read_ndx * INVOCATION_GRID_SIZE,
                    if self.use_atomic { ", anything)" } else { ").x" },
                    if self.format_integer { "0" } else { "0.0" }
                )),
            }
        }

        buf.push_str("    sb_result.resultOk[groupNdx] = (allOk) ? (1) : (0);\n}\n");

        buf
    }

    /// The program each command needs, or `None` for `op::Barrier`.
    fn gen_program_template(&self, cmd: &Command) -> Option<String> {
        match *cmd {
            Command::WriteData { seed, .. } => Some(self.gen_write_program_template(seed)),
            Command::ReadData { seed, .. } => Some(self.gen_read_program_template(seed)),
            Command::Barrier => None,
            Command::ReadMultipleData { seed0, seed1, .. } => {
                Some(self.gen_read_multiple_program_template(seed0, seed1))
            }
            Command::WriteDataInterleaved { seed, even_odd, .. } => {
                Some(self.gen_write_interleaved_program_template(seed, even_odd))
            }
            Command::ReadDataInterleaved { seed0, seed1, .. } => {
                Some(self.gen_read_interleaved_program_template(seed0, seed1))
            }
            Command::ReadZeroData { .. } => Some(self.gen_read_zero_program_template()),
        }
    }

    /// `InterCallTestCase::genStorage`
    ///
    /// # Safety
    /// Leaves the created object bound; the caller owns the returned handle.
    unsafe fn gen_storage(&self, gl: &glw::Functions) -> Result<GLuint, TestError> {
        let mut ret_val: GLuint = 0;

        // SAFETY: a fresh object of this case's own, deleted in `deinit`.
        unsafe {
            match self.storage {
                StorageType::Buffer => {
                    let num_elements = (INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE) as usize;
                    let buffer_size = num_elements * size_of::<u32>();

                    gl.gen_buffers(1, &mut ret_val);
                    gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, ret_val);

                    // The float branch fills with 0.0f, which has the same bit pattern.
                    let zero_buffer = vec![0u32; num_elements];
                    gl.buffer_data(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        buffer_size as glw::GLsizeiptr,
                        zero_buffer.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                    expect_no_error(gl, "gen buffer")?;
                }
                StorageType::Image => {
                    let image_width = INVOCATION_GRID_SIZE;
                    let image_height = INVOCATION_GRID_SIZE * PER_INVOCATION_SIZE;

                    gl.gen_textures(1, &mut ret_val);
                    gl.bind_texture(glw::GL_TEXTURE_2D, ret_val);
                    gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, self.gl_image_format(), image_width, image_height);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                    expect_no_error(gl, "gen image")?;

                    // Filling image with 0 - 0.0f and 0i32 share a bit pattern, so one
                    // zeroed buffer serves both the GL_RED/GL_FLOAT and the
                    // GL_RED_INTEGER/GL_INT upload.
                    let zero_buffer = vec![0u32; (image_width * image_height) as usize];
                    let (format, ty) = if self.format_integer {
                        (glw::GL_RED_INTEGER, glw::GL_INT)
                    } else {
                        (glw::GL_RED, glw::GL_FLOAT)
                    };
                    gl.tex_sub_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        0,
                        0,
                        image_width,
                        image_height,
                        format,
                        ty,
                        zero_buffer.as_ptr().cast(),
                    );
                    expect_no_error(gl, "specify image contents")?;
                }
            }
        }

        Ok(ret_val)
    }

    /// `InterCallTestCase::genResultStorage`
    ///
    /// # Safety
    /// Leaves the created buffer bound; the caller owns the returned handle.
    unsafe fn gen_result_storage(&self, gl: &glw::Functions) -> Result<GLuint, TestError> {
        let mut ret_val: GLuint = 0;

        // SAFETY: a fresh buffer of this case's own, deleted in `deinit`.
        unsafe {
            gl.gen_buffers(1, &mut ret_val);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, ret_val);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (INVOCATION_GRID_SIZE as usize * INVOCATION_GRID_SIZE as usize * size_of::<u32>()) as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            );
            expect_no_error(gl, "gen buffer")?;
        }

        Ok(ret_val)
    }

    /// `InterCallTestCase::runCommand(const op::WriteData &)` and its
    /// `WriteDataInterleaved` sibling, which differ only in the dispatch width.
    ///
    /// # Safety
    /// `program` and `storage` must be this case's own objects.
    unsafe fn run_write(
        &self,
        gl: &glw::Functions,
        program: GLuint,
        storage: GLuint,
        interleaved: bool,
    ) -> Result<(), TestError> {
        // SAFETY: the handles belong to this case.
        unsafe {
            gl.use_program(program);

            // set destination
            match self.storage {
                StorageType::Buffer => {
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, storage);
                    expect_no_error(gl, "bind destination buffer")?;
                }
                StorageType::Image => {
                    let access = if self.use_atomic {
                        glw::GL_READ_WRITE
                    } else {
                        glw::GL_WRITE_ONLY
                    };
                    gl.bind_image_texture(
                        0,
                        storage,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        access,
                        self.gl_image_format(),
                    );
                    expect_no_error(gl, "bind destination image")?;
                }
            }

            // calc
            let width = if interleaved {
                INVOCATION_GRID_SIZE / 2
            } else {
                INVOCATION_GRID_SIZE
            };
            gl.dispatch_compute(width as GLuint, INVOCATION_GRID_SIZE as GLuint, 1);
            expect_no_error(gl, "dispatch write")?;
        }

        Ok(())
    }

    /// `InterCallTestCase::runCommand(const op::Barrier &)`
    ///
    /// # Safety
    /// Requires a current context.
    unsafe fn run_barrier(&self, gl: &glw::Functions) {
        let bits = match self.storage {
            StorageType::Buffer => glw::GL_SHADER_STORAGE_BARRIER_BIT,
            StorageType::Image => glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT,
        };

        // SAFETY: requires only a current context.
        unsafe { gl.memory_barrier(bits) };
    }

    /// `InterCallTestCase::runSingleRead`, and `runCommand(const op::ReadMultipleData &)`
    /// when a second source is given - the two differ only in how many sources they bind.
    ///
    /// # Safety
    /// Every handle must be this case's own object.
    unsafe fn run_read(
        &self,
        gl: &glw::Functions,
        program: GLuint,
        sources: &[GLuint],
        result_storage: GLuint,
    ) -> Result<(), TestError> {
        // SAFETY: the handles belong to this case.
        unsafe {
            gl.use_program(program);

            // set source(s)
            for (ndx, &source) in sources.iter().enumerate() {
                let binding = (ndx + 1) as GLuint;

                match self.storage {
                    StorageType::Buffer => gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, binding, source),
                    StorageType::Image => {
                        let access = if self.use_atomic {
                            glw::GL_READ_WRITE
                        } else {
                            glw::GL_READ_ONLY
                        };
                        gl.bind_image_texture(
                            binding,
                            source,
                            0,
                            glw::GL_FALSE as glw::GLboolean,
                            0,
                            access,
                            self.gl_image_format(),
                        );
                    }
                }
            }
            expect_no_error(gl, "bind source")?;

            // set destination
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, result_storage);
            expect_no_error(gl, "bind result buffer")?;

            // calc
            gl.dispatch_compute(INVOCATION_GRID_SIZE as GLuint, INVOCATION_GRID_SIZE as GLuint, 1);
            expect_no_error(gl, "dispatch read")?;
        }

        Ok(())
    }

    /// `InterCallTestCase::verifyResults`
    ///
    /// # Safety
    /// Every non-zero entry of `result_storages` must be one of this case's own buffers.
    unsafe fn verify_results(&self, gl: &glw::Functions, result_storages: &[GLuint]) -> Result<bool, TestError> {
        let num_elements = (INVOCATION_GRID_SIZE * INVOCATION_GRID_SIZE) as usize;
        let mut all_results_ok = true;

        for &result_storage in result_storages {
            if result_storage == 0 {
                continue;
            }

            // SAFETY: the buffer was created with exactly this many elements.
            let results = unsafe {
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, result_storage);
                read_buffer::<i32>(gl, glw::GL_SHADER_STORAGE_BUFFER, num_elements)?
            };

            if !results.iter().all(|&value| value == 1) {
                all_results_ok = false;
            }
        }

        Ok(all_results_ok)
    }
}

impl TestCase for InterCallTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The requirement `InterCallTestCase::init` throws `NotSupportedError` for.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.use_atomic && self.storage == StorageType::Image && !check_support(context) {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_shader_image_atomic extension".to_string(),
            ));
        }

        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut storage_ids: BTreeMap<i32, GLuint> = BTreeMap::new();
        let mut result_storages: Vec<GLuint> = vec![0; self.cmds.len()];

        let mut run = || -> Result<bool, TestError> {
            let mut programs: Vec<Option<ShaderProgram<'_>>> = Vec::with_capacity(self.cmds.len());

            // `init` - generate resources and validate command list
            for (step, cmd) in self.cmds.iter().enumerate() {
                // new storage handle?
                let new_storage = match *cmd {
                    Command::WriteData { target_handle, .. }
                    | Command::WriteDataInterleaved { target_handle, .. }
                    | Command::ReadZeroData { target_handle } => Some(target_handle),
                    _ => None,
                };
                if let Some(handle) = new_storage
                    && !storage_ids.contains_key(&handle)
                {
                    // SAFETY: the handle is stored and deleted in `deinit` below.
                    let storage = unsafe { self.gen_storage(gl)? };
                    storage_ids.insert(handle, storage);
                }

                // program
                let Some(template) = self.gen_program_template(cmd) else {
                    programs.push(None);
                    continue;
                };
                let program = ShaderProgram::new(gl, &ProgramSources::compute(specialize_shader(context, &template)));
                if !program.is_ok() {
                    return Err(TestError::Fail("could not build program".to_string()));
                }
                programs.push(Some(program));

                // result storage
                let needs_result = matches!(
                    cmd,
                    Command::ReadData { .. }
                        | Command::ReadMultipleData { .. }
                        | Command::ReadDataInterleaved { .. }
                        | Command::ReadZeroData { .. }
                );
                if needs_result {
                    // SAFETY: the handle is stored and deleted in `deinit` below.
                    result_storages[step] = unsafe { self.gen_result_storage(gl)? };
                }
            }

            // `iterate` - run steps
            for (step, cmd) in self.cmds.iter().enumerate() {
                let program = programs[step].as_ref().map_or(0, ShaderProgram::program);

                // SAFETY: every handle below was created for this step above.
                unsafe {
                    match *cmd {
                        Command::WriteData { target_handle, .. } => {
                            self.run_write(gl, program, storage_ids[&target_handle], false)?
                        }
                        Command::ReadData { target_handle, .. } => {
                            self.run_read(gl, program, &[storage_ids[&target_handle]], result_storages[step])?
                        }
                        Command::Barrier => self.run_barrier(gl),
                        Command::ReadMultipleData {
                            target_handle0,
                            target_handle1,
                            ..
                        } => self.run_read(
                            gl,
                            program,
                            &[storage_ids[&target_handle0], storage_ids[&target_handle1]],
                            result_storages[step],
                        )?,
                        Command::WriteDataInterleaved { target_handle, .. } => {
                            self.run_write(gl, program, storage_ids[&target_handle], true)?
                        }
                        Command::ReadDataInterleaved { target_handle, .. } => {
                            self.run_read(gl, program, &[storage_ids[&target_handle]], result_storages[step])?
                        }
                        Command::ReadZeroData { target_handle } => {
                            self.run_read(gl, program, &[storage_ids[&target_handle]], result_storages[step])?
                        }
                    }
                }
            }

            // read results from result buffers
            // SAFETY: the buffers are the ones created above.
            unsafe { self.verify_results(gl, &result_storages) }
        };
        let outcome = run();

        // `deinit`
        // SAFETY: deleting this case's own objects, whether or not the run succeeded.
        unsafe {
            for &result_storage in &result_storages {
                if result_storage != 0 {
                    gl.delete_buffers(1, &result_storage);
                }
            }
            for storage in storage_ids.values() {
                match self.storage {
                    StorageType::Buffer => gl.delete_buffers(1, storage),
                    StorageType::Image => gl.delete_textures(1, storage),
                }
            }
        }

        if outcome? {
            Ok(TestStatus::pass("Pass"))
        } else if self.storage == StorageType::Buffer {
            Ok(TestStatus::fail("buffer content verification failed"))
        } else {
            Ok(TestStatus::fail("image content verification failed"))
        }
    }
}

/// `validateSortedAtomicRampAdditionValueChain`
///
/// `Some((invalidOperationNdx, errorDelta, errorExpected))` is upstream's three out
/// parameters, which only ever feed its log; here they go into the failure message.
fn validate_sorted_atomic_ramp_addition_value_chain(value_chain: &[u32], sum_value: u32) -> Option<(usize, u32, u32)> {
    let mut chain_delta: Vec<u32> = (0..value_chain.len())
        .map(|call_ndx| {
            let next = if call_ndx + 1 == value_chain.len() {
                sum_value
            } else {
                value_chain[call_ndx + 1]
            };
            next.wrapping_sub(value_chain[call_ndx])
        })
        .collect();

    // chainDelta contains now the actual additions applied to the value
    // check there exists an addition ramp form 1 to ...
    chain_delta.sort_unstable();

    for (call_ndx, &delta) in chain_delta.iter().enumerate() {
        if delta != (call_ndx + 1) as u32 {
            return Some((call_ndx, delta, (call_ndx + 1) as u32));
        }
    }

    None
}

/// `generateShuffledRamp` - generate a ramp of values from 1 to `num_elements`, and shuffle it.
fn generate_shuffled_ramp(num_elements: i32) -> Vec<i32> {
    let mut rng = Random::new(0xabcd);

    // some positive (non-zero) unique values
    let mut ramp: Vec<i32> = (1..=num_elements).collect();

    rng.shuffle(&mut ramp);

    ramp
}

/// Which half of `verify_atomic_ramp` rejected the results - upstream reports the two
/// with different result strings.
enum RampError {
    /// The work buffer/image did not end up holding `sum_value` everywhere.
    Work(String),
    /// One element's chain of intermediate results is not an addition ramp.
    Intermediate(String),
}

impl RampError {
    /// What upstream writes into its log before setting the result.
    fn detail(&self) -> String {
        match self {
            Self::Work(detail) => format!("Work buffer error, {detail}"),
            Self::Intermediate(detail) => format!("Intermediate buffer error, {detail}"),
        }
    }
}

/// The "did every buffer/image element end up holding `sum_value`" half of the three
/// `Concurrent*` cases that run an atomic-addition ramp, and then the per-element chain
/// check over their intermediate results.
///
/// Upstream writes this out once per case class; the two halves are identical apart from
/// the failure strings and how many elements the chain check walks, so they are one
/// function here taking those two as parameters.
fn verify_atomic_ramp(
    work_buffer: &[u32],
    intermediate_results: &[Vec<u32>],
    chain_elements: usize,
    sum_value: u32,
) -> Option<RampError> {
    for (ndx, &value) in work_buffer.iter().enumerate() {
        if value != sum_value {
            return Some(RampError::Work(format!(
                "at index {ndx} expected value {sum_value}, got {value}"
            )));
        }
    }

    let num_calls = intermediate_results.len();
    let mut value_chain = vec![0u32; num_calls];

    for value_ndx in 0..chain_elements {
        // collect result chain for each element
        for (call_ndx, results) in intermediate_results.iter().enumerate() {
            value_chain[call_ndx] = results[value_ndx];
        }

        // check there exists a path from 0 to sumValue using each addition once
        // decompose cumulative results to addition operations (all additions positive => this works)
        value_chain.sort_unstable();

        if let Some((invalid_operation_ndx, error_delta, error_expected)) =
            validate_sorted_atomic_ramp_addition_value_chain(&value_chain, sum_value)
        {
            return Some(RampError::Intermediate(format!(
                "at value index {value_ndx}, applied operation index {invalid_operation_ndx}, value was increased by {error_delta}, but expected {error_expected}"
            )));
        }
    }

    None
}

/// `SSBOConcurrentAtomicCase`
struct SsboConcurrentAtomicCase {
    name: String,
    num_calls: i32,
    work_size: i32,
}

impl SsboConcurrentAtomicCase {
    /// `SSBOConcurrentAtomicCase::genComputeSource`
    fn gen_compute_source_template(&self) -> String {
        format!(
            "${{GLSL_VERSION_DECL}}\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 1, std430) writeonly buffer IntermediateResults\n{{\n    highp uint values[{}];\n}} sb_ires;\n\nlayout (binding = 2, std430) volatile buffer WorkBuffer\n{{\n    highp uint values[{}];\n}} sb_work;\nuniform highp uint u_atomicDelta;\n\nvoid main ()\n{{\n    highp uint invocationIndex = gl_GlobalInvocationID.x;\n    sb_ires.values[invocationIndex] = atomicAdd(sb_work.values[invocationIndex], u_atomicDelta);\n}}",
            self.work_size, self.work_size
        )
    }
}

impl TestCase for SsboConcurrentAtomicCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let sum_value = (self.num_calls * (self.num_calls + 1) / 2) as u32;
        let work_elements = self.work_size as usize;
        let mut buffer_id: GLuint = 0;
        let mut intermediate_result_buffers: Vec<GLuint> = Vec::new();

        // `init` - gen buffers
        // SAFETY: fresh objects of this case's own, deleted below.
        unsafe {
            let zero_data = vec![0u32; work_elements];

            gl.gen_buffers(1, &mut buffer_id);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer_id);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (size_of::<u32>() * work_elements) as glw::GLsizeiptr,
                zero_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );

            for _ in 0..self.num_calls {
                let mut buffer: GLuint = 0;

                gl.gen_buffers(1, &mut buffer);
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
                gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    (size_of::<u32>() * work_elements) as glw::GLsizeiptr,
                    zero_data.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY,
                );

                intermediate_result_buffers.push(buffer);
            }
        }

        let outcome = (|| -> Result<Option<RampError>, TestError> {
            expect_no_error(gl, "gen buffers")?;

            // gen program
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, &self.gen_compute_source_template())),
            );
            if !program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }

            // generate unique deltas
            let deltas = generate_shuffled_ramp(self.num_calls);

            // invoke program N times, each with a different delta
            // SAFETY: the program and buffers were created just above.
            let (work_buffer, intermediate_results) = unsafe {
                let delta_location = gl.get_uniform_location(program.program(), c"u_atomicDelta".as_ptr());
                if delta_location == -1 {
                    return Err(TestError::Fail("u_atomicDelta location was -1".to_string()));
                }

                gl.use_program(program.program());
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, buffer_id);

                for call_ndx in 0..self.num_calls as usize {
                    gl.uniform_1ui(delta_location, deltas[call_ndx] as GLuint);
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, intermediate_result_buffers[call_ndx]);
                    gl.dispatch_compute(self.work_size as GLuint, 1, 1);
                }
                expect_no_error(gl, "post dispatch")?;

                // Verify result
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer_id);
                let work_buffer = read_buffer::<u32>(gl, glw::GL_SHADER_STORAGE_BUFFER, work_elements)?;

                // verify steps - collect results
                let mut intermediate_results = Vec::with_capacity(intermediate_result_buffers.len());
                for &intermediate in &intermediate_result_buffers {
                    gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, intermediate);
                    intermediate_results.push(read_buffer::<u32>(gl, glw::GL_SHADER_STORAGE_BUFFER, work_elements)?);
                }

                (work_buffer, intermediate_results)
            };

            Ok(verify_atomic_ramp(
                &work_buffer,
                &intermediate_results,
                work_elements,
                sum_value,
            ))
        })();

        // `deinit`
        // SAFETY: deleting this case's own objects, whether or not the run succeeded.
        unsafe {
            gl.delete_buffers(1, &buffer_id);
            for buffer in &intermediate_result_buffers {
                gl.delete_buffers(1, buffer);
            }
        }

        match outcome? {
            None => Ok(TestStatus::pass("Pass")),
            Some(error) => {
                log::debug!("{}", error.detail());
                Ok(TestStatus::fail("Buffer contents invalid"))
            }
        }
    }
}

/// `ConcurrentAtomicCounterCase`
struct ConcurrentAtomicCounterCase {
    name: String,
    num_calls: i32,
    work_size: i32,
}

impl ConcurrentAtomicCounterCase {
    /// `ConcurrentAtomicCounterCase::genComputeSource`
    fn gen_compute_source_template(&self, even_odd: bool) -> String {
        format!(
            "${{GLSL_VERSION_DECL}}\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 1, std430) writeonly buffer IntermediateResults\n{{\n    highp uint values[{}];\n}} sb_ires;\n\nlayout (binding = 0, offset = 0) uniform atomic_uint u_counter;\nuniform highp uint u_callNdx;\n\nvoid main ()\n{{\n    highp uint dataNdx = u_callNdx * {}u + gl_GlobalInvocationID.x;\n    if ((dataNdx % 2u) == {}u)\n        sb_ires.values[dataNdx] = atomicCounterIncrement(u_counter);\n}}",
            self.work_size * self.num_calls,
            self.work_size,
            if even_odd { 0 } else { 1 }
        )
    }
}

impl TestCase for ConcurrentAtomicCounterCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let intermediate_elements = (self.num_calls * self.work_size) as usize;
        let mut counter_buffer: GLuint = 0;
        let mut intermediate_result_buffer: GLuint = 0;

        // `init` - gen buffer
        // SAFETY: fresh objects of this case's own, deleted below.
        unsafe {
            let zero_data = vec![0u32; intermediate_elements];

            gl.gen_buffers(1, &mut counter_buffer);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, counter_buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                size_of::<u32>() as glw::GLsizeiptr,
                zero_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );

            gl.gen_buffers(1, &mut intermediate_result_buffer);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, intermediate_result_buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (size_of::<u32>() * intermediate_elements) as glw::GLsizeiptr,
                zero_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );
        }

        let outcome = (|| -> Result<Option<RampError>, TestError> {
            expect_no_error(gl, "gen buffers")?;

            // gen programs
            let even_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, &self.gen_compute_source_template(true))),
            );
            if !even_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            let odd_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, &self.gen_compute_source_template(false))),
            );
            if !odd_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }

            // SAFETY: the programs and buffers were created just above.
            let (counter_value, mut intermediate_results) = unsafe {
                // invoke program N times, each with a different delta
                let even_call_ndx_location = gl.get_uniform_location(even_program.program(), c"u_callNdx".as_ptr());
                let odd_call_ndx_location = gl.get_uniform_location(odd_program.program(), c"u_callNdx".as_ptr());

                if even_call_ndx_location == -1 || odd_call_ndx_location == -1 {
                    return Err(TestError::Fail("u_callNdx location was -1".to_string()));
                }

                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, intermediate_result_buffer);
                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, counter_buffer);

                for call_ndx in 0..self.num_calls {
                    gl.use_program(even_program.program());
                    gl.uniform_1ui(even_call_ndx_location, call_ndx as GLuint);
                    gl.dispatch_compute(self.work_size as GLuint, 1, 1);

                    gl.use_program(odd_program.program());
                    gl.uniform_1ui(odd_call_ndx_location, call_ndx as GLuint);
                    gl.dispatch_compute(self.work_size as GLuint, 1, 1);
                }
                expect_no_error(gl, "post dispatch")?;

                // Verify result
                gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, counter_buffer);
                let counter_value = read_buffer::<u32>(gl, glw::GL_ATOMIC_COUNTER_BUFFER, 1)?[0];

                // verify steps - collect results
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, intermediate_result_buffer);
                let intermediate_results =
                    read_buffer::<u32>(gl, glw::GL_SHADER_STORAGE_BUFFER, intermediate_elements)?;

                (counter_value, intermediate_results)
            };

            if counter_value != intermediate_elements as u32 {
                return Ok(Some(RampError::Work(format!(
                    "Counter buffer error, expected value {intermediate_elements}, got {counter_value}"
                ))));
            }

            // verify values - every invocation of every call incremented the counter once,
            // so the intermediate results are a permutation of 0..numCalls*workSize.
            intermediate_results.sort_unstable();
            for (value_ndx, &value) in intermediate_results.iter().enumerate() {
                if value != value_ndx as u32 {
                    return Ok(Some(RampError::Intermediate(format!(
                        "at value index {value_ndx}, expected {value_ndx}, got {value}"
                    ))));
                }
            }

            Ok(None)
        })();

        // `deinit`
        // SAFETY: deleting this case's own objects, whether or not the run succeeded.
        unsafe {
            gl.delete_buffers(1, &counter_buffer);
            gl.delete_buffers(1, &intermediate_result_buffer);
        }

        match outcome? {
            None => Ok(TestStatus::pass("Pass")),
            Some(error) => {
                log::debug!("{}", error.detail());
                Ok(TestStatus::fail("Buffer contents invalid"))
            }
        }
    }
}

/// `ConcurrentImageAtomicCase`
struct ConcurrentImageAtomicCase {
    name: String,
    num_calls: i32,
    work_size: i32,
}

impl ConcurrentImageAtomicCase {
    /// `ConcurrentImageAtomicCase::genComputeSource`
    fn gen_compute_source_template(&self) -> String {
        format!(
            "${{GLSL_VERSION_DECL}}\n${{SHADER_IMAGE_ATOMIC_REQUIRE}}\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 1, std430) writeonly buffer IntermediateResults\n{{\n    highp uint values[{}];\n}} sb_ires;\n\nlayout (binding = 2, r32ui) volatile uniform highp uimage2D u_workImage;\nuniform highp uint u_atomicDelta;\n\nvoid main ()\n{{\n    highp uint invocationIndex = gl_GlobalInvocationID.x + gl_GlobalInvocationID.y * uint({});\n    sb_ires.values[invocationIndex] = imageAtomicAdd(u_workImage, ivec2(gl_GlobalInvocationID.xy), u_atomicDelta);\n}}",
            self.work_size * self.work_size,
            self.work_size
        )
    }

    /// `ConcurrentImageAtomicCase::genImageReadSource`
    fn gen_image_read_source_template(&self) -> String {
        format!(
            "${{GLSL_VERSION_DECL}}\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 1, std430) writeonly buffer ImageValues\n{{\n    highp uint values[{}];\n}} sb_res;\n\nlayout (binding = 2, r32ui) readonly uniform highp uimage2D u_workImage;\n\nvoid main ()\n{{\n    highp uint invocationIndex = gl_GlobalInvocationID.x + gl_GlobalInvocationID.y * uint({});\n    sb_res.values[invocationIndex] = imageLoad(u_workImage, ivec2(gl_GlobalInvocationID.xy)).x;\n}}",
            self.work_size * self.work_size,
            self.work_size
        )
    }

    /// `ConcurrentImageAtomicCase::genImageClearSource`
    fn gen_image_clear_source_template(&self) -> &'static str {
        "${GLSL_VERSION_DECL}\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 2, r32ui) writeonly uniform highp uimage2D u_workImage;\n\nvoid main ()\n{\n    imageStore(u_workImage, ivec2(gl_GlobalInvocationID.xy), uvec4(0, 0, 0, 0));\n}"
    }

    /// `ConcurrentImageAtomicCase::readWorkImage`
    ///
    /// # Safety
    /// `image_id` and `program` must be this case's own objects.
    unsafe fn read_work_image(
        &self,
        gl: &glw::Functions,
        image_read_program: GLuint,
        image_id: GLuint,
    ) -> Result<Vec<u32>, TestError> {
        let elements = (self.work_size * self.work_size) as usize;
        let mut result_buffer: GLuint = 0;

        // SAFETY: `result_buffer` is created and deleted here; the rest belongs to the case.
        unsafe {
            gl.gen_buffers(1, &mut result_buffer);

            // Read image to an ssbo
            let zero_data = vec![0u32; elements];

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, result_buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (size_of::<u32>() * elements) as glw::GLsizeiptr,
                zero_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );

            gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
            gl.use_program(image_read_program);

            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, result_buffer);
            gl.bind_image_texture(
                2,
                image_id,
                0,
                glw::GL_FALSE as glw::GLboolean,
                0,
                glw::GL_READ_ONLY,
                glw::GL_R32UI,
            );
            gl.dispatch_compute(self.work_size as GLuint, self.work_size as GLuint, 1);

            let result = expect_no_error(gl, "read")
                .and_then(|()| read_buffer::<u32>(gl, glw::GL_SHADER_STORAGE_BUFFER, elements));

            gl.delete_buffers(1, &result_buffer);

            result
        }
    }
}

impl TestCase for ConcurrentImageAtomicCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The requirement `ConcurrentImageAtomicCase::init` throws `NotSupportedError` for.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !check_support(context) {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_shader_image_atomic".to_string(),
            ));
        }

        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let sum_value = (self.num_calls * (self.num_calls + 1) / 2) as u32;
        let image_elements = (self.work_size * self.work_size) as usize;
        let mut image_id: GLuint = 0;
        let mut intermediate_result_buffers: Vec<GLuint> = Vec::new();

        let outcome = (|| -> Result<Option<RampError>, TestError> {
            // `init`
            // SAFETY: fresh objects of this case's own, deleted below.
            unsafe {
                // gen image
                gl.gen_textures(1, &mut image_id);
                gl.bind_texture(glw::GL_TEXTURE_2D, image_id);
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32UI, self.work_size, self.work_size);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                expect_no_error(gl, "gen tex")?;

                // gen buffers
                let zero_data = vec![0u32; image_elements];

                for _ in 0..self.num_calls {
                    let mut buffer: GLuint = 0;

                    gl.gen_buffers(1, &mut buffer);
                    gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
                    gl.buffer_data(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        (size_of::<u32>() * image_elements) as glw::GLsizeiptr,
                        zero_data.as_ptr().cast(),
                        glw::GL_DYNAMIC_COPY,
                    );

                    intermediate_result_buffers.push(buffer);
                    expect_no_error(gl, "gen buffers")?;
                }
            }

            // gen programs
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, &self.gen_compute_source_template())),
            );
            if !program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            let image_read_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, &self.gen_image_read_source_template())),
            );
            if !image_read_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            let image_clear_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, self.gen_image_clear_source_template())),
            );
            if !image_clear_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }

            // generate unique deltas
            let deltas = generate_shuffled_ramp(self.num_calls);

            // SAFETY: the programs, image and buffers were created just above.
            let (work_image, intermediate_results) = unsafe {
                // clear image
                gl.use_program(image_clear_program.program());
                gl.bind_image_texture(
                    2,
                    image_id,
                    0,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    glw::GL_WRITE_ONLY,
                    glw::GL_R32UI,
                );
                gl.dispatch_compute(self.work_size as GLuint, self.work_size as GLuint, 1);
                gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT);
                expect_no_error(gl, "clear")?;

                // invoke program N times, each with a different delta
                let delta_location = gl.get_uniform_location(program.program(), c"u_atomicDelta".as_ptr());
                if delta_location == -1 {
                    return Err(TestError::Fail("u_atomicDelta location was -1".to_string()));
                }

                gl.use_program(program.program());
                gl.bind_image_texture(
                    2,
                    image_id,
                    0,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    glw::GL_READ_WRITE,
                    glw::GL_R32UI,
                );

                for call_ndx in 0..self.num_calls as usize {
                    gl.uniform_1ui(delta_location, deltas[call_ndx] as GLuint);
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, intermediate_result_buffers[call_ndx]);
                    gl.dispatch_compute(self.work_size as GLuint, self.work_size as GLuint, 1);
                }
                expect_no_error(gl, "post dispatch")?;

                // Verify result
                let work_image = self.read_work_image(gl, image_read_program.program(), image_id)?;

                // verify steps - collect results
                let mut intermediate_results = Vec::with_capacity(intermediate_result_buffers.len());
                for &intermediate in &intermediate_result_buffers {
                    gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, intermediate);
                    intermediate_results.push(read_buffer::<u32>(gl, glw::GL_SHADER_STORAGE_BUFFER, image_elements)?);
                }

                (work_image, intermediate_results)
            };

            // Upstream's chain check walks `m_workSize` elements here, not
            // `m_workSize * m_workSize` - i.e. only the first row of the image. Kept as
            // upstream has it, so a verdict cannot differ from `deqp-gles31`'s.
            Ok(verify_atomic_ramp(
                &work_image,
                &intermediate_results,
                self.work_size as usize,
                sum_value,
            ))
        })();

        // `deinit`
        // SAFETY: deleting this case's own objects, whether or not the run succeeded.
        unsafe {
            if image_id != 0 {
                gl.delete_textures(1, &image_id);
            }
            for buffer in &intermediate_result_buffers {
                gl.delete_buffers(1, buffer);
            }
        }

        match outcome? {
            None => Ok(TestStatus::pass("Pass")),
            Some(RampError::Work(detail)) => {
                log::debug!("Work image error, {detail}");
                Ok(TestStatus::fail("Image contents invalid"))
            }
            Some(RampError::Intermediate(detail)) => {
                log::debug!("Intermediate buffer error, {detail}");
                Ok(TestStatus::fail("Buffer contents invalid"))
            }
        }
    }
}

/// `ConcurrentSSBOAtomicCounterMixedCase`
struct ConcurrentSsboAtomicCounterMixedCase {
    name: String,
    num_calls: i32,
    work_size: i32,
}

impl ConcurrentSsboAtomicCounterMixedCase {
    /// `ConcurrentSSBOAtomicCounterMixedCase::genSSBOComputeSource`
    fn gen_ssbo_compute_source_template(&self) -> &'static str {
        "${GLSL_VERSION_DECL}\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout (binding = 1, std430) volatile buffer WorkBuffer\n{\n    highp uint targetValue;\n    highp uint unused;\n} sb_work;\n\nvoid main ()\n{\n    // flip high bits\n    highp uint mask = uint(1) << (24u + (gl_GlobalInvocationID.x % 8u));\n    sb_work.unused = atomicXor(sb_work.targetValue, mask);\n}"
    }

    /// `ConcurrentSSBOAtomicCounterMixedCase::genAtomicCounterComputeSource`
    fn gen_atomic_counter_compute_source_template(&self) -> &'static str {
        "${GLSL_VERSION_DECL}\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nlayout (binding = 0, offset = 0) uniform atomic_uint u_counter;\n\nvoid main ()\n{\n    atomicCounterIncrement(u_counter);\n}"
    }
}

impl TestCase for ConcurrentSsboAtomicCounterMixedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let expected = (self.num_calls * self.work_size) as u32;
        let mut buffer_id: GLuint = 0;

        // `init` - gen buffer
        // SAFETY: a fresh buffer of this case's own, deleted below.
        unsafe {
            let zero_buf = [0u32; 2];

            gl.gen_buffers(1, &mut buffer_id);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer_id);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (size_of::<u32>() * 2) as glw::GLsizeiptr,
                zero_buf.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );
        }

        let outcome = (|| -> Result<Option<RampError>, TestError> {
            expect_no_error(gl, "gen buffers")?;

            // gen programs
            let ssbo_atomic_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(context, self.gen_ssbo_compute_source_template())),
            );
            if !ssbo_atomic_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }
            let atomic_counter_program = ShaderProgram::new(
                gl,
                &ProgramSources::compute(specialize_shader(
                    context,
                    self.gen_atomic_counter_compute_source_template(),
                )),
            );
            if !atomic_counter_program.is_ok() {
                return Err(TestError::Fail("could not build program".to_string()));
            }

            // SAFETY: the programs and the buffer were created just above.
            let result = unsafe {
                // invoke programs N times
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer_id);
                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, buffer_id);

                for _ in 0..self.num_calls {
                    gl.use_program(atomic_counter_program.program());
                    gl.dispatch_compute(self.work_size as GLuint, 1, 1);

                    gl.use_program(ssbo_atomic_program.program());
                    gl.dispatch_compute(self.work_size as GLuint, 1, 1);
                }
                expect_no_error(gl, "post dispatch")?;

                // Verify result - XORs cancel out, only addition is left
                gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer_id);
                read_buffer::<u32>(gl, glw::GL_ATOMIC_COUNTER_BUFFER, 1)?[0]
            };

            if result != expected {
                return Ok(Some(RampError::Work(format!(
                    "Buffer value error, expected value {expected}, got {result}"
                ))));
            }

            Ok(None)
        })();

        // `deinit`
        // SAFETY: deleting this case's own buffer, whether or not the run succeeded.
        unsafe { gl.delete_buffers(1, &buffer_id) };

        match outcome? {
            None => Ok(TestStatus::pass("Pass")),
            Some(error) => {
                log::debug!("{}", error.detail());
                Ok(TestStatus::fail("Buffer contents invalid"))
            }
        }
    }
}

/// `SynchronizationTests::init`'s `.with_memory_barrier` block.
///
/// Split out of `create_tests` so a unit test can reach the same cases (and so the
/// command lists, which are what a reader compares against the C++, stand alone).
fn inter_call_with_memory_barrier_cases() -> Vec<InterCallTestCase> {
    /// Upstream declares its own `CaseConfig` in this block, separate from the one the
    /// invocation groups use.
    struct CaseConfig {
        name_prefix: &'static str,
        storage: StorageType,
        flags: u32,
    }

    let mut cases = Vec::new();

    const INTER_CALL_CONFIGS: &[CaseConfig] = &[
        CaseConfig {
            name_prefix: "image",
            storage: StorageType::Image,
            flags: 0,
        },
        CaseConfig {
            name_prefix: "image_atomic",
            storage: StorageType::Image,
            flags: FLAG_USE_ATOMIC | FLAG_USE_INT,
        },
        CaseConfig {
            name_prefix: "ssbo",
            storage: StorageType::Buffer,
            flags: 0,
        },
        CaseConfig {
            name_prefix: "ssbo_atomic",
            storage: StorageType::Buffer,
            flags: FLAG_USE_ATOMIC | FLAG_USE_INT,
        },
    ];

    const SEED0: i32 = 123;
    const SEED1: i32 = 457;

    for config in INTER_CALL_CONFIGS {
        for (suffix, cmds) in [
            (
                "_write_read",
                vec![
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::Barrier,
                    Command::ReadData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                ],
            ),
            (
                "_read_write",
                vec![
                    Command::ReadZeroData { target_handle: 1 },
                    Command::Barrier,
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                ],
            ),
            (
                "_overwrite",
                vec![
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::Barrier,
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED1,
                    },
                    Command::Barrier,
                    Command::ReadData {
                        target_handle: 1,
                        seed: SEED1,
                    },
                ],
            ),
            (
                "_multiple_write_read",
                vec![
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::WriteData {
                        target_handle: 2,
                        seed: SEED1,
                    },
                    Command::Barrier,
                    Command::ReadMultipleData {
                        target_handle0: 1,
                        seed0: SEED0,
                        target_handle1: 2,
                        seed1: SEED1,
                    },
                ],
            ),
            (
                "_multiple_interleaved_write_read",
                vec![
                    Command::WriteDataInterleaved {
                        target_handle: 1,
                        seed: SEED0,
                        even_odd: true,
                    },
                    Command::WriteDataInterleaved {
                        target_handle: 1,
                        seed: SEED1,
                        even_odd: false,
                    },
                    Command::Barrier,
                    Command::ReadDataInterleaved {
                        target_handle: 1,
                        seed0: SEED0,
                        seed1: SEED1,
                    },
                ],
            ),
            (
                "_multiple_unrelated_write_read_ordered",
                vec![
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::WriteData {
                        target_handle: 2,
                        seed: SEED1,
                    },
                    Command::Barrier,
                    Command::ReadData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::ReadData {
                        target_handle: 2,
                        seed: SEED1,
                    },
                ],
            ),
            (
                "_multiple_unrelated_write_read_non_ordered",
                vec![
                    Command::WriteData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                    Command::WriteData {
                        target_handle: 2,
                        seed: SEED1,
                    },
                    Command::Barrier,
                    Command::ReadData {
                        target_handle: 2,
                        seed: SEED1,
                    },
                    Command::ReadData {
                        target_handle: 1,
                        seed: SEED0,
                    },
                ],
            ),
        ] {
            let name = format!("{}{suffix}", config.name_prefix);
            cases.push(InterCallTestCase::new(name, config.storage, config.flags, cmds));
        }
    }

    cases
}

/// `SynchronizationTests::init`
///
/// Upstream registers three sub-groups here: `in_invocation`, `inter_invocation` and
/// `inter_call`. `inter_call.without_memory_barrier` is not ported (see the file header).
pub fn create_tests() -> TestCaseGroup {
    struct CaseConfig {
        name_prefix: &'static str,
        storage: StorageType,
        flags: u32,
    }

    const CONFIGS: &[CaseConfig] = &[
        CaseConfig {
            name_prefix: "image",
            storage: StorageType::Image,
            flags: 0,
        },
        CaseConfig {
            name_prefix: "image_atomic",
            storage: StorageType::Image,
            flags: FLAG_ATOMIC,
        },
        CaseConfig {
            name_prefix: "ssbo",
            storage: StorageType::Buffer,
            flags: 0,
        },
        CaseConfig {
            name_prefix: "ssbo_atomic",
            storage: StorageType::Buffer,
            flags: FLAG_ATOMIC,
        },
    ];

    let mut group = TestCaseGroup::new("synchronization");
    let mut in_invocation_group = TestCaseGroup::new("in_invocation");
    let mut inter_invocation_group = TestCaseGroup::new("inter_invocation");

    for group_ndx in 0..2 {
        let target_group = if group_ndx == 0 {
            &mut in_invocation_group
        } else {
            &mut inter_invocation_group
        };
        let extra_flags = if group_ndx == 0 { 0 } else { FLAG_IN_GROUP };

        for config in CONFIGS {
            for (suffix, kind) in [
                ("_write_read", CaseKind::WriteRead),
                ("_read_write", CaseKind::ReadWrite),
                ("_overwrite", CaseKind::OverWrite),
                ("_alias_write", CaseKind::AliasWrite(AliasType::Write)),
                ("_alias_overwrite", CaseKind::AliasWrite(AliasType::Overwrite)),
            ] {
                let name = format!("{}{suffix}", config.name_prefix);
                target_group.add_child(Box::new(InterInvocationTestCase::new(
                    name,
                    kind,
                    config.storage,
                    config.flags | extra_flags,
                )) as Box<dyn TestCase>);
            }
        }
    }

    // .inter_call
    let mut inter_call_group = TestCaseGroup::new("inter_call");
    let mut with_barrier_group = TestCaseGroup::new("with_memory_barrier");

    for case in inter_call_with_memory_barrier_cases() {
        with_barrier_group.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    // .without_memory_barrier
    let mut without_barrier_group = TestCaseGroup::new("without_memory_barrier");
    {
        struct InvocationConfig {
            name: &'static str,
            count: i32,
        }

        const SSBO_INVOCATIONS: &[InvocationConfig] = &[
            InvocationConfig {
                name: "1k",
                count: 1024,
            },
            InvocationConfig {
                name: "4k",
                count: 4096,
            },
            InvocationConfig {
                name: "32k",
                count: 32768,
            },
        ];
        const IMAGE_INVOCATIONS: &[InvocationConfig] = &[
            InvocationConfig { name: "8x8", count: 8 },
            InvocationConfig {
                name: "32x32",
                count: 32,
            },
            InvocationConfig {
                name: "128x128",
                count: 128,
            },
        ];
        const COUNTER_INVOCATIONS: &[InvocationConfig] = &[
            InvocationConfig { name: "32", count: 32 },
            InvocationConfig {
                name: "128",
                count: 128,
            },
            InvocationConfig {
                name: "1k",
                count: 1024,
            },
        ];
        const CALL_COUNTS: &[i32] = &[2, 5, 100];

        for invocation in SSBO_INVOCATIONS {
            for &call_count in CALL_COUNTS {
                let name = format!(
                    "ssbo_atomic_dispatch_{call_count}_calls_{}_invocations",
                    invocation.name
                );
                without_barrier_group.add_child(Box::new(SsboConcurrentAtomicCase {
                    name,
                    num_calls: call_count,
                    work_size: invocation.count,
                }) as Box<dyn TestCase>);
            }
        }

        for invocation in IMAGE_INVOCATIONS {
            for &call_count in CALL_COUNTS {
                let name = format!(
                    "image_atomic_dispatch_{call_count}_calls_{}_invocations",
                    invocation.name
                );
                without_barrier_group.add_child(Box::new(ConcurrentImageAtomicCase {
                    name,
                    num_calls: call_count,
                    work_size: invocation.count,
                }) as Box<dyn TestCase>);
            }
        }

        for invocation in COUNTER_INVOCATIONS {
            for &call_count in CALL_COUNTS {
                let name = format!(
                    "atomic_counter_dispatch_{call_count}_calls_{}_invocations",
                    invocation.name
                );
                without_barrier_group.add_child(Box::new(ConcurrentAtomicCounterCase {
                    name,
                    num_calls: call_count,
                    work_size: invocation.count,
                }) as Box<dyn TestCase>);
            }
        }

        for invocation in COUNTER_INVOCATIONS {
            for &call_count in CALL_COUNTS {
                let name = format!(
                    "ssbo_atomic_counter_mixed_dispatch_{call_count}_calls_{}_invocations",
                    invocation.name
                );
                without_barrier_group.add_child(Box::new(ConcurrentSsboAtomicCounterMixedCase {
                    name,
                    num_calls: call_count,
                    work_size: invocation.count,
                }) as Box<dyn TestCase>);
            }
        }
    }

    inter_call_group.add_child(with_barrier_group);
    inter_call_group.add_child(without_barrier_group);

    group.add_child(in_invocation_group);
    group.add_child(inter_invocation_group);
    group.add_child(inter_call_group);
    group
}
