// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureBarrierTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The class hierarchy (`TextureBarrierBasicOutline`, `TextureBarrierTexelBlocksBase`, `TextureBarrierSameTexelRWBase` and the four cases) is `Kind`, whose methods answer what the virtual functions answer. The extension check that upstream throws from `init` is `check_support`. `init` and `deinit` are `Rig::new` and its `Drop`. The triangle data is uploaded with one `glBufferData` instead of upstream's allocate, map and write, which leaves the same bytes in the buffer. The waiver `WAIVER_WITH_BUG_13788` is off upstream and absent here.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const NUM_TEXTURES: usize = 8;
const GRID_SIZE: usize = 64;
const TRIANGLE_COUNT: usize = GRID_SIZE * GRID_SIZE * 2;
const VERTEX_COUNT: usize = TRIANGLE_COUNT * 3;

/// `TextureBarrierTests::API`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Api {
    Gl45Core,
    GlArbTextureBarrier,
}

/// `apiToTestName`
fn api_to_test_name(api: Api) -> &'static str {
    match api {
        Api::Gl45Core => "texture_barrier",
        Api::GlArbTextureBarrier => "texture_barrier_ARB",
    }
}

/// Actual test cases may override it to provide an alternative vertex shader.
const VSH: &str = "#version 400 core\nin vec2 Position;\nvoid main() {\n    gl_Position = vec4(Position, 0.0, 1.0);\n}";

const TEXEL_BLOCKS_FSH: &str = "#version 400 core\n#define NUM_TEXTURES 8\nuniform int blockSize;\nuniform int modulo;\nuniform usampler2D texInput[NUM_TEXTURES];\nout uvec4 fragOutput[NUM_TEXTURES];\nuvec4 func(uvec4 t0, uvec4 t1, uvec4 t2, uvec4 t3) {\n   return t0 + t1 + t2 + t3;\n}\nvoid main() {\n    ivec2 texelCoord = ivec2(gl_FragCoord.xy);\n    ivec2 blockCoord = texelCoord / blockSize;\n    ivec2 xOffset = ivec2(blockSize, 0);\n    ivec2 yOffset = ivec2(0, blockSize);\n    if (((blockCoord.x + blockCoord.y) % 2) == modulo) {\n        for (int i = 0; i < NUM_TEXTURES; ++i) {\n            fragOutput[i] = func(texelFetch(texInput[i], texelCoord + xOffset, 0),\n                                 texelFetch(texInput[i], texelCoord - xOffset, 0),\n                                 texelFetch(texInput[i], texelCoord + yOffset, 0),\n                                 texelFetch(texInput[i], texelCoord - yOffset, 0));\n        }\n    } else {\n        discard;\n    }\n}";

const SAME_TEXEL_RW_FSH: &str = "#version 400 core\n#define NUM_TEXTURES 8\nuniform usampler2D texInput[NUM_TEXTURES];\nout uvec4 fragOutput[NUM_TEXTURES];\nuvec4 func(uvec4 t) {\n    return t + 1;\n}\nvoid main() {\n    ivec2 texelCoord = ivec2(gl_FragCoord.xy);\n    for (int i = 0; i < NUM_TEXTURES; ++i) {\n        fragOutput[i] = func(texelFetch(texInput[i], texelCoord, 0));\n    }\n}";

/// The four cases.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    DisjointTexels,
    OverlappingTexels,
    SameTexelRw,
    SameTexelRwMultipass,
}

impl Kind {
    fn name(self) -> &'static str {
        match self {
            Self::DisjointTexels => "disjoint-texels",
            Self::OverlappingTexels => "overlapping-texels",
            Self::SameTexelRw => "same-texel-rw",
            Self::SameTexelRwMultipass => "same-texel-rw-multipass",
        }
    }

    fn is_texel_blocks(self) -> bool {
        matches!(self, Self::DisjointTexels | Self::OverlappingTexels)
    }

    fn fsh(self) -> &'static str {
        if self.is_texel_blocks() {
            TEXEL_BLOCKS_FSH
        } else {
            SAME_TEXEL_RW_FSH
        }
    }

    /// Should return the number of separate test passes.
    fn num_test_passes(self) -> i32 {
        match self {
            Self::DisjointTexels => 16, // one for each blockSize value
            _ => 1,
        }
    }

    /// Should return the number of rendering passes to perform.
    fn num_render_passes(self) -> i32 {
        match self {
            Self::DisjointTexels => 5, // as the same blockSize and modulo value is used between render passes the rendering results should still stay well defined
            Self::OverlappingTexels => 42,
            Self::SameTexelRw => 1,
            Self::SameTexelRwMultipass => 42,
        }
    }

    /// Whether there is need for a TextureBarrier between subsequent render passes.
    fn needs_barrier(self) -> bool {
        matches!(self, Self::OverlappingTexels | Self::SameTexelRwMultipass)
    }

    /// Returns the block size to be used in the specified pass.
    fn block_size(self, test_pass: i32, render_pass: i32) -> i32 {
        match self {
            Self::DisjointTexels => test_pass + 1,
            _ => (5 + render_pass * 3) % 7 + 1,
        }
    }

    /// Returns the modulo value to be used in the specified pass.
    fn modulo(self, _test_pass: i32, render_pass: i32) -> i32 {
        match self {
            Self::DisjointTexels => 0,
            _ => (render_pass * 3) % 2,
        }
    }
}

#[derive(Clone, Copy)]
struct Vertex {
    x: f32,
    y: f32,
}

#[derive(Clone, Copy)]
struct Triangle {
    v0: Vertex,
    v1: Vertex,
    v2: Vertex,
}

/// Generate vertex data using the following steps: (1) Generate an irregular grid covering the whole screen (i.e. (-1,-1) to (1,1)); (2) Generate a list of triangles covering the grid; (3) Shuffle the generated triangle list; (4) Write the vertices of the shuffled triangle list.
fn generate_vertex_data() -> Vec<f32> {
    let grid_size = GRID_SIZE as f32;
    let mut grid = [[Vertex { x: 0.0, y: 0.0 }; GRID_SIZE + 1]; GRID_SIZE + 1];

    // Generate grid vertices
    for (x, column) in grid.iter_mut().enumerate() {
        for (y, vertex) in column.iter_mut().enumerate() {
            // Calculate normalized coordinates
            let normx = x as f32 / grid_size;
            let normy = y as f32 / grid_size;

            // Pseudo-random grid vertex coordinate with scale & bias
            vertex.x = normx * 2.0 - 1.0 + (normx * std::f32::consts::PI * 13.0).sin() * 0.3 / grid_size;
            vertex.y = normy * 2.0 - 1.0 + (normy * std::f32::consts::PI * 13.0).sin() * 0.3 / grid_size;
        }
    }

    let mut list = vec![
        Triangle {
            v0: grid[0][0],
            v1: grid[0][0],
            v2: grid[0][0]
        };
        TRIANGLE_COUNT
    ];

    // Generate triangle list
    for x in 0..GRID_SIZE {
        for y in 0..GRID_SIZE {
            // Generate first triangle of grid block
            list[(x + y * GRID_SIZE) * 2] = Triangle {
                v0: grid[x][y],
                v1: grid[x + 1][y],
                v2: grid[x + 1][y + 1],
            };

            // Generate second triangle of grid block
            list[(x + y * GRID_SIZE) * 2 + 1] = Triangle {
                v0: grid[x + 1][y + 1],
                v1: grid[x][y + 1],
                v2: grid[x][y],
            };
        }
    }

    // Shuffle triangle list
    for i in (1..=TRIANGLE_COUNT - 2).rev() {
        // Pseudo-random triangle index as one operand of the exchange
        let j = (((list[i].v1.y + list[i].v2.x + 13.0) * 1345.13) as i32 % i as i32) as usize;
        list.swap(i, j);
    }

    // Write triange list vertices to destination
    let mut data = Vec::with_capacity(TRIANGLE_COUNT * 6);
    for triangle in &list {
        for vertex in [triangle.v0, triangle.v1, triangle.v2] {
            data.push(vertex.x);
            data.push(vertex.y);
        }
    }
    data
}

/// `TextureBarrierBasicOutline::init` and `deinit`: the textures, framebuffer and geometry every case renders with.
struct Rig<'a> {
    gl: &'a glw::Functions,
    vao: GLuint,
    vbo: GLuint,
    fbo: GLuint,
    tex: [GLuint; NUM_TEXTURES],
    width: u32,
    height: u32,
    reference: Vec<Vec<u32>>,
    actual: Vec<u32>,
}

impl<'a> Rig<'a> {
    fn new(context: &'a Context) -> Res<Self> {
        let gl = context.gl();
        let render_target = context.render_target();
        let (width, height) = (render_target.width as u32, render_target.height as u32);
        let mut rig = Self {
            gl,
            vao: 0,
            vbo: 0,
            fbo: 0,
            tex: [0; NUM_TEXTURES],
            width,
            height,
            reference: vec![vec![0u32; (width * height) as usize]; NUM_TEXTURES],
            actual: vec![0u32; (width * height) as usize],
        };

        // Create textures
        gl!(gl.gen_textures(NUM_TEXTURES as i32, rig.tex.as_mut_ptr()));
        for (i, &tex) in rig.tex.iter().enumerate() {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, tex));
            gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32UI, width as i32, height as i32));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        }

        // Create framebuffer
        gl!(gl.gen_framebuffers(1, &mut rig.fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, rig.fbo));
        let mut draw_buffers = [0 as glw::GLenum; NUM_TEXTURES];
        for (i, draw_buffer) in draw_buffers.iter_mut().enumerate() {
            gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0 + i as u32, rig.tex[i], 0));
            *draw_buffer = glw::GL_COLOR_ATTACHMENT0 + i as u32;
        }
        gl!(gl.draw_buffers(NUM_TEXTURES as i32, draw_buffers.as_ptr()));

        // Create vertex array and buffer
        let vertex_data = generate_vertex_data();
        gl!(gl.gen_vertex_arrays(1, &mut rig.vao));
        gl!(gl.bind_vertex_array(rig.vao));
        gl!(gl.gen_buffers(1, &mut rig.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, rig.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(vertex_data.as_slice()) as isize,
            vertex_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));

        // Setup state
        gl!(gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1));
        gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1));

        Ok(rig)
    }

    /// Renders a set of primitives that cover each pixel of the framebuffer exactly once.
    fn render(&self) {
        // Issue the whole grid using multiple separate draw commands
        let min_tri_count_per_draw = TRIANGLE_COUNT / 7;
        let mut first = 0;
        while first < VERTEX_COUNT {
            // Pseudo-random number of vertices per draw
            let count = (VERTEX_COUNT - first).min((first % 23 + min_tri_count_per_draw) * 3);
            gl!(self.gl.draw_arrays(glw::GL_TRIANGLES, first as i32, count as i32));
            first += count;
        }
    }

    /// The texel value of the specified image at the specified location; out-of-bounds reads return zero.
    fn texel(&self, image: &[u32], x: i64, y: i64) -> u32 {
        if x < 0 || x >= i64::from(self.width) || y < 0 || y >= i64::from(self.height) {
            return 0;
        }
        image[(x + y * i64::from(self.width)) as usize]
    }

    /// Initializes the reference images and uploads them to their corresponding textures.
    fn init_texture_data(&mut self) {
        let gl = self.gl;
        for i in 0..NUM_TEXTURES {
            for x in 0..self.width {
                for y in 0..self.height {
                    self.reference[i][(x + y * self.width) as usize] =
                        ((i as u32) << 24).wrapping_add(y << 12).wrapping_add(x);
                }
            }

            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                self.width as i32,
                self.height as i32,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                self.reference[i].as_ptr().cast()
            ));
        }
    }

    /// Verifies whether the reference images matches those of the textures we rendered to.
    fn verify_texture_data(&mut self) -> bool {
        let gl = self.gl;
        for i in 0..NUM_TEXTURES {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                self.actual.as_mut_ptr().cast()
            ));

            if self.reference[i] != self.actual {
                return false;
            }
        }
        true
    }
}

impl Drop for Rig<'_> {
    fn drop(&mut self) {
        let gl = self.gl;

        // Cleanup textures
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.delete_textures(NUM_TEXTURES as i32, self.tex.as_ptr()));

        // Cleanup framebuffer
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.delete_framebuffers(1, &self.fbo));

        // Cleanup vertex array and buffer
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_vertex_arrays(1, &self.vao));

        // Cleanup state
        gl!(gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4));
        gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4));
    }
}

/// `TextureBarrierTexelBlocksBase`'s render pass state: what was last uploaded to the uniforms, which the reference update also reads.
struct BlockState {
    block_size: i32,
    modulo: i32,
    block_size_loc: GLint,
    modulo_loc: GLint,
}

/// `TextureBarrierTexelBlocksBase::setupRenderPass`
fn setup_render_pass(
    gl: &glw::Functions,
    kind: Kind,
    program: GLuint,
    state: &mut BlockState,
    test_pass: i32,
    render_pass: i32,
) {
    if !kind.is_texel_blocks() {
        // The fragment shader used by these tests doesn't have any parameters, thus no need for render pass setup code.
        return;
    }

    if test_pass == 0 && render_pass == 0 {
        // Get the uniform locations in the first pass, reuse it afterwards
        state.block_size_loc = gl!(gl.get_uniform_location(program, c"blockSize".as_ptr()));
        state.modulo_loc = gl!(gl.get_uniform_location(program, c"modulo".as_ptr()));
    }

    // Update block size if changed
    let new_block_size = kind.block_size(test_pass, render_pass);
    if new_block_size != state.block_size {
        state.block_size = new_block_size;
        gl!(gl.uniform_1i(state.block_size_loc, state.block_size));
    }

    // Update modulo if changed
    let new_modulo = kind.modulo(test_pass, render_pass);
    if new_modulo != state.modulo {
        state.modulo = new_modulo;
        gl!(gl.uniform_1i(state.modulo_loc, state.modulo));
    }
}

/// `updateTextureData` - CPU code equivalent to the fragment shader to update reference data.
fn update_texture_data(rig: &mut Rig<'_>, kind: Kind, state: &BlockState) {
    if kind.is_texel_blocks() {
        let block_size = i64::from(state.block_size);
        for x in 0..rig.width {
            for y in 0..rig.height {
                let block_x = x / state.block_size as u32;
                let block_y = y / state.block_size as u32;
                if ((block_x + block_y) % 2) as i32 == state.modulo {
                    for i in 0..NUM_TEXTURES {
                        let (xi, yi) = (i64::from(x), i64::from(y));
                        let value = rig
                            .texel(&rig.reference[i], xi + block_size, yi)
                            .wrapping_add(rig.texel(&rig.reference[i], xi - block_size, yi))
                            .wrapping_add(rig.texel(&rig.reference[i], xi, yi + block_size))
                            .wrapping_add(rig.texel(&rig.reference[i], xi, yi - block_size));
                        rig.reference[i][(x + y * rig.width) as usize] = value;
                    }
                }
            }
        }
    } else {
        for texture in rig.reference.iter_mut() {
            for texel in texture.iter_mut() {
                *texel = texel.wrapping_add(1);
            }
        }
    }
}

struct TextureBarrierCase {
    api: Api,
    kind: Kind,
}

impl TestCase for TextureBarrierCase {
    fn name(&self) -> &str {
        self.kind.name()
    }

    /// `TextureBarrierBaseTest::featureSupported`; upstream throws it from `init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supported = (self.api == Api::GlArbTextureBarrier
            && context.context_info.is_extension_supported("GL_ARB_texture_barrier"))
            || self.api == Api::Gl45Core;
        if !supported {
            return Err(TestError::NotSupported(
                "Required texture_barrier extension is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let kind = self.kind;
        let mut rig = Rig::new(context)?;

        // Compile & link the program to use
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VSH, kind.fsh()));
        if !program.is_ok() {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }
        let program_id = program.program();
        gl!(gl.use_program(program_id));

        for i in 0..NUM_TEXTURES {
            let sampler_name =
                std::ffi::CString::new(format!("texInput[{i}]")).expect("sampler name holds no nul byte");
            let loc = gl!(gl.get_uniform_location(program_id, sampler_name.as_ptr()));
            gl!(gl.uniform_1i(loc, i as GLint));
        }

        let mut state = BlockState {
            block_size: -1,
            modulo: -1,
            block_size_loc: 0,
            modulo_loc: 0,
        };

        for test_pass in 0..kind.num_test_passes() {
            // Initialize texture data at the beginning of each test pass
            rig.init_texture_data();

            // Perform rendering passes
            for render_pass in 0..kind.num_render_passes() {
                // Setup render pass
                setup_render_pass(gl, kind, program_id, &mut state, test_pass, render_pass);

                // Render a set of primitives that cover each pixel of the framebuffer exactly once
                rig.render();

                // If a TextureBarrier is needed insert it here
                if kind.needs_barrier() {
                    gl!(gl.texture_barrier());
                }
            }

            // Update reference data after actual rendering to avoid bubbles
            for render_pass in 0..kind.num_render_passes() {
                // Setup render pass
                setup_render_pass(gl, kind, program_id, &mut state, test_pass, render_pass);

                // Update reference data
                update_texture_data(&mut rig, kind, &state);
            }

            // Verify results at the end of each test pass
            if !rig.verify_texture_data() {
                return Err(TestError::Fail("Failed to validate rendering results".to_string()));
            }
        }

        gl!(gl.use_program(0));

        // Test case passed
        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureBarrierTests::init`
pub fn create_tests(api: Api) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(api_to_test_name(api));
    for kind in [
        Kind::DisjointTexels,
        Kind::OverlappingTexels,
        Kind::SameTexelRw,
        Kind::SameTexelRwMultipass,
    ] {
        group.add_child(Box::new(TextureBarrierCase { api, kind }) as Box<dyn TestCase>);
    }
    group
}
