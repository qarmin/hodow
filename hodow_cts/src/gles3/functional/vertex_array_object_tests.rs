// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fVertexArrayObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Both `VertexArrayObjectTest` (the
// nine `diff_*` cases) and `MultiVertexArrayObjectTest` (the single `all_attributes`
// case) are ported. `MultiVertexArrayObjectTest` shares the same `Attribute`/
// `BufferSpec`/`VertexArrayState`/`Spec` shape and the same `create_random_buffer_data`/
// `create_program`/`set_state`/`make_draw_call`/`render_manual`/`render_via_vao` helpers
// below unchanged - upstream's own version of those functions is byte-for-byte the same
// code (`MultiVertexArrayObjectTest::makeDrawCall` omits the plain
// `VertexArrayObjectTest::makeDrawCall`'s per-attribute default-value
// `glVertexAttrib{I}4{i,f}` calls, but since both are the GL default `(0,0,0,1)` anyway,
// reusing the fuller helper is behaviourally identical and avoids a second copy). What
// upstream's `init()` builds once as a case-lifetime `Spec` (`GL_MAX_VERTEX_ATTRIBS`
// attributes, each with randomised size/stride/type/divisor/offset/normalized/enabled)
// is instead built fresh inside `iterate()`, matching every other case in this file.
//
// One field upstream's shared `BufferSpec` carries that this port's own `BufferSpec`
// does not: `offset`. It is always `0` in every literal both this class and
// `VertexArrayObjectTest` construct, and `createRandomBufferData` never reads it at
// all - a genuinely dead field, dropped here rather than carried forward unused.
//
// Needs no rasterised reference image and no captured expected values: every case
// renders the *same* vertex-attribute configuration two different ways - once through a
// real, bound `GL_VERTEX_ARRAY_BINDING` object, once by replaying the identical
// `glVertexAttribPointer`/`glBindBuffer`/... calls directly against the default array
// state - and checks the two renders are pixel-identical. Whichever GPU/driver runs this
// is its own oracle: the buffer contents are genuinely random (there is nothing for them
// to agree with beyond themselves), so this port's own `Random` need not match
// upstream's `de::Random` bit-for-bit, unlike the CPU test suite's captured-expected-value
// tests.
//
// `VertexArrayObjectTest::render`/`genReferences` call each other's own helpers with
// their two `tcu::Surface` parameters swapped relative to the parameter names
// (`render(stateResult, vaoResult)` where the parameters are named `(vaoResult,
// defaultResult)`) - not a bug, just confusing to read literally. Working out what each
// *variable* ends up holding: the two real comparisons performed are (a) a plain replay
// of the `vao` config, no VAO object involved, against a draw through a real bound VAO
// object holding that same config, and (b) a plain replay of the `state` config against
// a draw through the default array state (VAO 0) holding that same config. `render_manual`
// and `render_via_vao` below are named for what they actually do, each returning
// `(vao_config_image, state_config_image)` in that order - matching (a) and (b) once
// paired up positionally, without carrying the upstream swap forward into this port.
// One further simplification: `render()`'s own second `setState(m_spec.vao)` call (right
// after the VAO-bound draw, before unbinding it) reapplies state the VAO already holds
// unchanged - a fully idempotent no-op with no way to be observed afterwards - and is
// not ported.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArray, read_pixels};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

#[derive(Clone, Copy)]
struct Attribute {
    enabled: bool,
    size: i32,
    stride: i32,
    type_: GLenum,
    integer: bool,
    divisor: i32,
    offset: i32,
    normalized: bool,
    /// Index into the case's own `buffers` vector (see `iterate`) - `0` means "no
    /// buffer bound", matching upstream's own reserved `m_buffers[0] == 0`.
    buffer_ndx: usize,
}

#[derive(Clone)]
struct VertexArrayState {
    attributes: Vec<Attribute>,
    element_array_buffer: usize,
}

#[derive(Clone, Copy)]
struct BufferSpec {
    count: i32,
    size: i32,
    component_count: i32,
    stride: i32,
    type_: GLenum,
    int_range_min: i32,
    int_range_max: i32,
    float_range_min: f32,
    float_range_max: f32,
}

#[derive(Clone)]
struct Spec {
    count: i32,
    /// `0` means "not instanced" (upstream's own convention: a plain, non-instanced
    /// `Spec` leaves `instances` at its default-constructed `-1`... no - every case here
    /// explicitly sets it to `0` for "not instanced", so that is the sentinel ported).
    instances: i32,
    use_draw_elements: bool,
    index_type: GLenum,
    index_offset: i32,
    index_range_min: i32,
    index_range_max: i32,
    index_count: i32,
    state: VertexArrayState,
    vao: VertexArrayState,
    buffers: Vec<BufferSpec>,
}

fn type_size(type_: GLenum) -> i32 {
    match type_ {
        glw::GL_FLOAT | glw::GL_INT | glw::GL_UNSIGNED_INT => 4,
        glw::GL_SHORT | glw::GL_UNSIGNED_SHORT => 2,
        glw::GL_BYTE | glw::GL_UNSIGNED_BYTE => 1,
        _ => 0,
    }
}

/// `VertexArrayObjectTest::createRandomBufferData`
fn create_random_buffer_data(spec: &BufferSpec, rnd: &mut Random) -> Vec<u8> {
    let mut data = vec![0u8; spec.size as usize];
    let stride = if spec.stride != 0 {
        spec.stride
    } else {
        spec.component_count * type_size(spec.type_)
    } as usize;

    let mut pos = 0usize;
    for _ in 0..spec.count {
        let mut off = pos;
        for _ in 0..spec.component_count {
            match spec.type_ {
                glw::GL_FLOAT => {
                    let v = spec.float_range_min + (spec.float_range_max - spec.float_range_min) * rnd.get_float();
                    data[off..off + 4].copy_from_slice(&v.to_ne_bytes());
                    off += 4;
                }
                glw::GL_INT => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max);
                    data[off..off + 4].copy_from_slice(&v.to_ne_bytes());
                    off += 4;
                }
                glw::GL_UNSIGNED_INT => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max) as u32;
                    data[off..off + 4].copy_from_slice(&v.to_ne_bytes());
                    off += 4;
                }
                glw::GL_SHORT => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max) as i16;
                    data[off..off + 2].copy_from_slice(&v.to_ne_bytes());
                    off += 2;
                }
                glw::GL_UNSIGNED_SHORT => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max) as u16;
                    data[off..off + 2].copy_from_slice(&v.to_ne_bytes());
                    off += 2;
                }
                glw::GL_BYTE => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max) as i8;
                    data[off] = v as u8;
                    off += 1;
                }
                glw::GL_UNSIGNED_BYTE => {
                    let v = rnd.get_int(spec.int_range_min, spec.int_range_max) as u8;
                    data[off] = v;
                    off += 1;
                }
                _ => unreachable!("BufferSpec::type_ is one of the eight GL vertex types above"),
            }
        }
        pos += stride;
    }
    data
}

/// `VertexArrayObjectTest::generateIndices`
fn generate_indices(spec: &Spec, rnd: &mut Random) -> Vec<u8> {
    let size = type_size(spec.index_type) as usize;
    let mut data = vec![0u8; spec.index_count as usize * size];

    for i in 0..spec.index_count as usize {
        let v = rnd.get_int(spec.index_range_min, spec.index_range_max);
        let off = i * size;
        match spec.index_type {
            glw::GL_UNSIGNED_INT => data[off..off + 4].copy_from_slice(&(v as u32).to_ne_bytes()),
            glw::GL_UNSIGNED_SHORT => data[off..off + 2].copy_from_slice(&(v as u16).to_ne_bytes()),
            glw::GL_UNSIGNED_BYTE => data[off] = v as u8,
            _ => unreachable!("Spec::index_type is one of the three GL index types above"),
        }
    }
    data
}

/// The `1 / (2^bits - 1)` table `createProgram` builds three times over (each time
/// keyed, per an upstream quirk, on `state.attributes[0].type_` rather than the
/// attribute actually being scaled - harmless for every case here, since none mixes two
/// differently-typed non-float unnormalized attributes).
fn type_scale_base(type_: GLenum) -> f32 {
    match type_ {
        glw::GL_SHORT => 1.0 / ((1u32 << 14) - 1) as f32,
        glw::GL_UNSIGNED_SHORT => 1.0 / ((1u32 << 15) - 1) as f32,
        glw::GL_INT => 1.0 / ((1u32 << 30) - 1) as f32,
        glw::GL_UNSIGNED_INT => 1.0 / ((1u32 << 31) - 1) as f32,
        glw::GL_BYTE => 1.0 / ((1u32 << 6) - 1) as f32,
        glw::GL_UNSIGNED_BYTE => 1.0 / ((1u32 << 7) - 1) as f32,
        _ => 0.0,
    }
}

const FRAGMENT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "in mediump vec4 v_value;\n",
    "layout(location = 0) out mediump vec4 fragColor;\n",
    "void main (void)\n",
    "{\n",
    "\tfragColor = vec4(v_value.xyz, 1.0);\n",
    "}"
);

/// `VertexArrayObjectTest::createProgram`
fn create_program<'gl>(gl: &'gl glw::Functions, state: &VertexArrayState) -> Result<ShaderProgram<'gl>, TestError> {
    let mut vertex = String::from("#version 300 es\n");
    let mut value_terms = Vec::with_capacity(state.attributes.len());

    for (attrib_ndx, attrib) in state.attributes.iter().enumerate() {
        if attrib.integer {
            vertex.push_str(&format!(
                "layout(location = {attrib_ndx}) in mediump ivec4 a_attrib{attrib_ndx};\n"
            ));
        } else {
            vertex.push_str(&format!(
                "layout(location = {attrib_ndx}) in mediump vec4 a_attrib{attrib_ndx};\n"
            ));
        }

        if attrib.integer {
            let scale = type_scale_base(state.attributes[0].type_);
            value_terms.push(format!("{scale} * vec4(a_attrib{attrib_ndx})"));
        } else if attrib.type_ != glw::GL_FLOAT && !attrib.normalized {
            let scale = 0.5 * type_scale_base(state.attributes[0].type_);
            value_terms.push(format!("{scale} * a_attrib{attrib_ndx}"));
        } else {
            value_terms.push(format!("a_attrib{attrib_ndx}"));
        }
    }

    vertex.push_str("out mediump vec4 v_value;\nvoid main (void)\n{\n");
    vertex.push_str(&format!("\tv_value = {};\n", value_terms.join(" + ")));

    let first = state.attributes[0];
    if first.integer {
        let scale = type_scale_base(first.type_);
        vertex.push_str(&format!(
            "\tgl_Position = vec4({scale} * vec3(a_attrib0.xyz), 1.0);\n}}"
        ));
    } else if first.normalized || first.type_ == glw::GL_FLOAT {
        vertex.push_str("\tgl_Position = vec4(a_attrib0.xyz, 1.0);\n}");
    } else {
        let scale = 0.25 * type_scale_base(first.type_);
        vertex.push_str(&format!("\tgl_Position = vec4({scale} * a_attrib0.xyz, 1.0);\n}}"));
    }

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, FRAGMENT_SOURCE));
    if !program.is_ok() {
        return Err(TestError::Fail("Failed to compile shaders".to_string()));
    }
    Ok(program)
}

/// `VertexArrayObjectTest::setState`
fn set_state(gl: &glw::Functions, buffers: &[GLuint], state: &VertexArrayState) {
    // SAFETY: `buffers` has one real GL buffer name (or `0`) per index any
    // `element_array_buffer`/`buffer_ndx` field of `state` can name.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffers[state.element_array_buffer]);

        for (attrib_ndx, attrib) in state.attributes.iter().enumerate() {
            let index = attrib_ndx as GLuint;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers[attrib.buffer_ndx]);
            if attrib.enabled {
                gl.enable_vertex_attrib_array(index);
            } else {
                gl.disable_vertex_attrib_array(index);
            }

            let offset = attrib.offset as usize as *const std::ffi::c_void;
            if attrib.integer {
                gl.vertex_attrib_i_pointer(index, attrib.size, attrib.type_, attrib.stride, offset);
            } else {
                gl.vertex_attrib_pointer(
                    index,
                    attrib.size,
                    attrib.type_,
                    attrib.normalized as glw::GLboolean,
                    attrib.stride,
                    offset,
                );
            }

            gl.vertex_attrib_divisor(index, attrib.divisor as GLuint);
        }
    }
}

/// `VertexArrayObjectTest::makeDrawCall`
fn make_draw_call(gl: &glw::Functions, spec: &Spec, state: &VertexArrayState, indices: Option<&[u8]>) {
    // SAFETY: `state`'s own attribute state was just set via `set_state`; `indices`
    // (when this draw needs client-side ones) outlives this call.
    unsafe {
        gl.clear_color(0.7, 0.7, 0.7, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);

        for (attrib_ndx, attrib) in state.attributes.iter().enumerate() {
            let index = attrib_ndx as GLuint;
            if attrib.integer {
                gl.vertex_attrib_i_4i(index, 0, 0, 0, 1);
            } else {
                gl.vertex_attrib_4f(index, 0.0, 0.0, 0.0, 1.0);
            }
        }

        if spec.use_draw_elements {
            let ptr = if state.element_array_buffer == 0 {
                indices
                    .expect("client-side indices were generated whenever a spec needs them")
                    .as_ptr()
                    .cast()
            } else {
                spec.index_offset as usize as *const std::ffi::c_void
            };
            if spec.instances == 0 {
                gl.draw_elements(glw::GL_TRIANGLES, spec.count, spec.index_type, ptr);
            } else {
                gl.draw_elements_instanced(glw::GL_TRIANGLES, spec.count, spec.index_type, ptr, spec.instances);
            }
        } else if spec.instances == 0 {
            gl.draw_arrays(glw::GL_TRIANGLES, 0, spec.count);
        } else {
            gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, spec.count, spec.instances);
        }
    }
}

/// `VertexArrayObjectTest::genReferences` - both configs replayed directly against the
/// default array state, no VAO object involved at all. Returns `(vao_config_image,
/// state_config_image)`.
fn render_manual(
    context: &Context,
    buffers: &[GLuint],
    spec: &Spec,
    vao_program: &ShaderProgram<'_>,
    state_program: &ShaderProgram<'_>,
    indices: Option<&[u8]>,
) -> Result<(Surface, Surface), TestError> {
    let gl = context.gl();
    let render_target = context.render_target();

    set_state(gl, buffers, &spec.vao);
    // SAFETY: `vao_program` was built successfully by the caller.
    unsafe { gl.use_program(vao_program.program()) };
    make_draw_call(gl, spec, &spec.vao, indices);
    let mut vao_image = Surface::new(render_target.width, render_target.height);
    read_pixels(&context.render_context, 0, 0, &mut vao_image.get_access())?;

    set_state(gl, buffers, &spec.state);
    // SAFETY: `state_program` was built successfully by the caller.
    unsafe { gl.use_program(state_program.program()) };
    make_draw_call(gl, spec, &spec.state, indices);
    let mut state_image = Surface::new(render_target.width, render_target.height);
    read_pixels(&context.render_context, 0, 0, &mut state_image.get_access())?;

    Ok((vao_image, state_image))
}

/// `VertexArrayObjectTest::render` - the `vao` config drawn through a real bound VAO
/// object, the `state` config drawn through the default array state (VAO 0). Returns
/// `(vao_config_image, state_config_image)`, matching `render_manual`'s own pairing.
fn render_via_vao(
    context: &Context,
    buffers: &[GLuint],
    spec: &Spec,
    vao_program: &ShaderProgram<'_>,
    state_program: &ShaderProgram<'_>,
    indices: Option<&[u8]>,
) -> Result<(Surface, Surface), TestError> {
    let gl = context.gl();
    let render_target = context.render_target();

    let vao = VertexArray::new(gl);
    // SAFETY: `vao` is a fresh object this function owns; capturing `spec.vao`'s own
    // state into it, then leaving it unbound so the state below applies to the default
    // array state instead.
    unsafe { gl.bind_vertex_array(vao.get()) };
    set_state(gl, buffers, &spec.vao);
    unsafe { gl.bind_vertex_array(0) };

    set_state(gl, buffers, &spec.state);

    // SAFETY: `vao_program` was built successfully by the caller; `vao` was just
    // configured with `spec.vao`'s own state above.
    unsafe {
        gl.bind_vertex_array(vao.get());
        gl.use_program(vao_program.program());
    }
    make_draw_call(gl, spec, &spec.vao, indices);
    let mut vao_image = Surface::new(render_target.width, render_target.height);
    read_pixels(&context.render_context, 0, 0, &mut vao_image.get_access())?;

    // SAFETY: unbinding back to the default array state, which still holds `spec.state`
    // from the plain `set_state` call above (a VAO's own state is isolated from it).
    unsafe {
        gl.bind_vertex_array(0);
        gl.use_program(state_program.program());
    }
    make_draw_call(gl, spec, &spec.state, indices);
    let mut state_image = Surface::new(render_target.width, render_target.height);
    read_pixels(&context.render_context, 0, 0, &mut state_image.get_access())?;

    Ok((vao_image, state_image))
}

struct VertexArrayObjectCase {
    name: &'static str,
    spec: Spec,
}

impl TestCase for VertexArrayObjectCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.name));

        // `m_buffers[0]` is reserved for "no buffer" (`glDeleteBuffers` silently
        // ignores a `0` name, so it stays in the vector deleted along with the rest).
        let mut buffers: Vec<GLuint> = vec![0];
        for buffer_spec in &self.spec.buffers {
            let data = create_random_buffer_data(buffer_spec, &mut rnd);
            let mut name: GLuint = 0;
            // SAFETY: `name` is freshly generated and deleted at the end of this
            // function; `data` holds exactly `buffer_spec.size` bytes.
            unsafe {
                gl.gen_buffers(1, &mut name);
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, name);
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    buffer_spec.size as glw::GLsizeiptr,
                    data.as_ptr().cast(),
                    glw::GL_DYNAMIC_DRAW,
                );
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            }
            buffers.push(name);
        }

        let vao_program = create_program(gl, &self.spec.vao)?;
        let state_program = create_program(gl, &self.spec.state)?;

        let needs_client_indices = self.spec.use_draw_elements
            && (self.spec.vao.element_array_buffer == 0 || self.spec.state.element_array_buffer == 0);
        let indices = needs_client_indices.then(|| generate_indices(&self.spec, &mut rnd));

        let (vao_reference, state_reference) = render_manual(
            context,
            &buffers,
            &self.spec,
            &vao_program,
            &state_program,
            indices.as_deref(),
        )?;
        let (vao_result, state_result) = render_via_vao(
            context,
            &buffers,
            &self.spec,
            &vao_program,
            &state_program,
            indices.as_deref(),
        )?;

        // SAFETY: deletes exactly the buffers this function generated above.
        unsafe { gl.delete_buffers(buffers.len() as glw::GLsizei, buffers.as_ptr()) };

        let threshold = RGBA::new(0, 0, 0, 0);
        let state_ok = pixel_threshold_compare(&state_reference, &state_result, threshold).ok;
        let vao_ok = pixel_threshold_compare(&vao_reference, &vao_result, threshold).ok;

        if state_ok && vao_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `MultiVertexArrayObjectTest` - one `Spec` covering every attribute the driver
/// exposes (`GL_MAX_VERTEX_ATTRIBS`), each randomised independently, compared the same
/// way `VertexArrayObjectCase` compares its own fixed one- or two-attribute `Spec`s.
struct MultiVertexArrayObjectCase;

impl TestCase for MultiVertexArrayObjectCase {
    fn name(&self) -> &str {
        "all_attributes"
    }

    /// `MultiVertexArrayObjectTest::init` (spec construction, moved into `iterate` like
    /// every other case in this file) + `MultiVertexArrayObjectTest::iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.name()));

        let mut attrib_count: glw::GLint = 0;
        // SAFETY: a single scalar query.
        unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut attrib_count) };
        let attrib_count = attrib_count as usize;

        let short_coord_buffer_48 = BufferSpec {
            count: 48,
            size: 2 * 384,
            component_count: 4,
            stride: 0,
            type_: glw::GL_SHORT,
            int_range_min: -32768,
            int_range_max: 32768,
            float_range_min: 0.0,
            float_range_max: 0.0,
        };

        let mut state_attributes = Vec::with_capacity(attrib_count);
        let mut vao_attributes = Vec::with_capacity(attrib_count);
        let mut buffers_spec = Vec::with_capacity(attrib_count);

        for attrib_ndx in 0..attrib_count {
            buffers_spec.push(short_coord_buffer_48);

            let mut state_attrib = Attribute {
                enabled: rnd.get_int(0, 4) != 0,
                size: rnd.get_int(2, 4),
                stride: 2 * rnd.get_int(1, 3),
                type_: glw::GL_SHORT,
                integer: rnd.get_bool(),
                divisor: rnd.get_int(0, 1),
                offset: 2 * rnd.get_int(0, 2),
                normalized: rnd.get_bool(),
                buffer_ndx: attrib_ndx + 1,
            };
            if attrib_ndx == 0 {
                state_attrib.divisor = 0;
                state_attrib.enabled = true;
                state_attrib.size = 2;
            }
            state_attributes.push(state_attrib);

            let mut vao_attrib = Attribute {
                enabled: rnd.get_int(0, 4) != 0,
                size: rnd.get_int(2, 4),
                stride: 2 * rnd.get_int(1, 3),
                type_: glw::GL_SHORT,
                integer: rnd.get_bool(),
                divisor: rnd.get_int(0, 1),
                offset: 2 * rnd.get_int(0, 2),
                normalized: rnd.get_bool(),
                buffer_ndx: attrib_count - attrib_ndx,
            };
            if attrib_ndx == 0 {
                vao_attrib.divisor = 0;
                vao_attrib.enabled = true;
                vao_attrib.size = 2;
            }
            vao_attributes.push(vao_attrib);
        }

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: state_attributes,
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vao_attributes,
                element_array_buffer: 0,
            },
            buffers: buffers_spec,
        };

        let mut buffers: Vec<GLuint> = vec![0];
        for buffer_spec in &spec.buffers {
            let data = create_random_buffer_data(buffer_spec, &mut rnd);
            let mut name: GLuint = 0;
            // SAFETY: `name` is freshly generated and deleted at the end of this
            // function; `data` holds exactly `buffer_spec.size` bytes.
            unsafe {
                gl.gen_buffers(1, &mut name);
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, name);
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    buffer_spec.size as glw::GLsizeiptr,
                    data.as_ptr().cast(),
                    glw::GL_DYNAMIC_DRAW,
                );
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            }
            buffers.push(name);
        }

        let vao_program = create_program(gl, &spec.vao)?;
        let state_program = create_program(gl, &spec.state)?;

        // `spec.use_draw_elements` is always `false` here, so neither render needs
        // client-side indices.
        let (vao_reference, state_reference) =
            render_manual(context, &buffers, &spec, &vao_program, &state_program, None)?;
        let (vao_result, state_result) = render_via_vao(context, &buffers, &spec, &vao_program, &state_program, None)?;

        // SAFETY: deletes exactly the buffers this function generated above.
        unsafe { gl.delete_buffers(buffers.len() as glw::GLsizei, buffers.as_ptr()) };

        let threshold = RGBA::new(0, 0, 0, 0);
        let state_ok = pixel_threshold_compare(&state_reference, &state_result, threshold).ok;
        let vao_ok = pixel_threshold_compare(&vao_reference, &vao_result, threshold).ok;

        if state_ok && vao_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

fn attribute(size: i32, type_: GLenum, integer: bool, normalized: bool, buffer_ndx: usize) -> Attribute {
    Attribute {
        enabled: true,
        size,
        stride: 0,
        type_,
        integer,
        divisor: 0,
        offset: 0,
        normalized,
        buffer_ndx,
    }
}

fn float_buffer(count: i32, size: i32, component_count: i32, float_min: f32, float_max: f32) -> BufferSpec {
    BufferSpec {
        count,
        size,
        component_count,
        stride: 0,
        type_: glw::GL_FLOAT,
        int_range_min: 0,
        int_range_max: 0,
        float_range_min: float_min,
        float_range_max: float_max,
    }
}

/// `VertexArrayObjectTestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let float_coord_buffer_48_1 = float_buffer(48, 384, 2, -1.0, 1.0);
    let float_coord_buffer_48_2 = float_buffer(48, 384, 2, -1.0, 1.0);
    let short_coord_buffer_48 = BufferSpec {
        count: 48,
        size: 192,
        component_count: 2,
        stride: 0,
        type_: glw::GL_SHORT,
        int_range_min: -32768,
        int_range_max: 32768,
        float_range_min: 0.0,
        float_range_max: 0.0,
    };

    let mut group = TestCaseGroup::new("vertex_array_objects");

    // Different buffer.
    {
        let mut attrib = attribute(2, glw::GL_FLOAT, false, false, 0);
        let mut vao_attrib = attrib;
        attrib.buffer_ndx = 1;
        vao_attrib.buffer_ndx = 2;

        let spec = Spec {
            count: 48,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![float_coord_buffer_48_1, float_coord_buffer_48_2],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_buffer",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different size.
    {
        let vao_attrib = attribute(3, glw::GL_FLOAT, false, false, 1);
        let mut state_attrib = vao_attrib;
        state_attrib.size = 2;

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![float_coord_buffer_48_1],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_size",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different stride.
    {
        let mut vao_attrib = attribute(2, glw::GL_SHORT, false, true, 1);
        vao_attrib.stride = 2;
        let mut state_attrib = vao_attrib;
        state_attrib.stride = 4;

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_stride",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different types.
    {
        let vao_attrib = attribute(2, glw::GL_SHORT, false, true, 1);
        let mut state_attrib = vao_attrib;
        state_attrib.type_ = glw::GL_BYTE;

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_type",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different "integer".
    {
        let vao_attrib = attribute(2, glw::GL_BYTE, true, false, 1);
        let mut state_attrib = vao_attrib;
        state_attrib.integer = false;

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_integer",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different divisor.
    {
        let attrib0 = attribute(2, glw::GL_SHORT, false, true, 1);
        let mut vao_attrib1 = attribute(4, glw::GL_FLOAT, false, false, 2);
        vao_attrib1.divisor = 3;
        let mut state_attrib1 = vao_attrib1;
        state_attrib1.divisor = 2;

        let spec = Spec {
            count: 12,
            instances: 10,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![attrib0, state_attrib1],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![attrib0, vao_attrib1],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48, float_coord_buffer_48_1],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_divisor",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different offset.
    {
        let mut vao_attrib = attribute(2, glw::GL_SHORT, false, true, 1);
        vao_attrib.offset = 2;
        let mut state_attrib = vao_attrib;
        state_attrib.offset = 4;

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_offset",
            spec,
        }) as Box<dyn TestCase>);
    }

    // Different normalize.
    {
        let vao_attrib = attribute(2, glw::GL_SHORT, false, true, 1);
        let mut state_attrib = vao_attrib;
        state_attrib.normalized = false;

        let spec = Spec {
            count: 48,
            instances: 0,
            use_draw_elements: false,
            index_type: glw::GL_NONE,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 0,
            index_count: 0,
            state: VertexArrayState {
                attributes: vec![state_attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![vao_attrib],
                element_array_buffer: 0,
            },
            buffers: vec![short_coord_buffer_48],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_normalize",
            spec,
        }) as Box<dyn TestCase>);
    }

    // DrawElements with buffer / pointer.
    {
        let attrib = attribute(2, glw::GL_FLOAT, false, true, 1);
        let index_buffer = BufferSpec {
            count: 24,
            size: 192,
            component_count: 1,
            stride: 0,
            type_: glw::GL_UNSIGNED_SHORT,
            int_range_min: 0,
            int_range_max: 48,
            float_range_min: 0.0,
            float_range_max: 0.0,
        };

        let spec = Spec {
            count: 24,
            instances: 0,
            use_draw_elements: true,
            index_type: glw::GL_UNSIGNED_SHORT,
            index_offset: 0,
            index_range_min: 0,
            index_range_max: 48,
            index_count: 24,
            state: VertexArrayState {
                attributes: vec![attrib],
                element_array_buffer: 0,
            },
            vao: VertexArrayState {
                attributes: vec![attrib],
                element_array_buffer: 2,
            },
            buffers: vec![float_coord_buffer_48_1, index_buffer],
        };
        group.add_child(Box::new(VertexArrayObjectCase {
            name: "diff_indices",
            spec,
        }) as Box<dyn TestCase>);
    }

    group.add_child(Box::new(MultiVertexArrayObjectCase) as Box<dyn TestCase>);

    group
}
