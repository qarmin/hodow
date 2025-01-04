// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgProgramExecutor.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ProgramExecutor` is the reference interpreter upstream's `shaders.random` case
// compares a driver's real GLSL compile/link/draw against: it runs a vertex shader once
// per grid vertex (packed `EXEC_VEC_WIDTH` lanes at a time, via the already-ported
// `rsg::execution_context`), bilinearly interpolates its outputs across each screen-space
// grid cell into per-fragment varyings, runs the fragment shader the same way, and writes
// the resulting colour into a real `tcu::PixelBufferAccess`. Confirmed a genuine leaf
// once `rsg::shader`/`rsg::execution_context` both existed: its own real `#include`s
// (`rsgShader`/`rsgVariableValue`/`tcuTexture`/`rsgSamplers`) are all already ported, and
// `rsgExecutionContext.hpp` (also already ported) turns out to need no *new* method here
// either - `getValue` is non-`const` and lazily-allocating on both sides, and every
// upstream read of an already-populated variable goes through the same method's own
// implicit `ExecValueAccess -> ExecConstValueAccess` conversion (this port's
// `StridedValueAccess::into_const`), not a separate `const` overload (confirmed by
// reading `rsgExecutionContext.hpp` directly - there is only one `getValue`).
//
// **`Shader::execute` needing `&mut Shader` (this port's own deviation, forced by
// `Function`/`Shader` storing their `StatementArena` inline - see `rsg::shader`'s own top
// doc comment) does not fit upstream's call shape verbatim.** Upstream's
// `ProgramExecutor::execute` takes `const Shader&` for both shaders - a `Shader` is
// logically read-only once built, upstream's own `Statement::execute` reaching its
// mutation through one level of pointer indirection its `const` method hides, exactly the
// `Expression::evaluate`/`Statement::execute` deviation already noted in `rsg::statement`'s
// own top doc comment. Taking `&[ShaderInput]`/`getOutputs()` *and* `vertexShader.execute(...)`
// concurrently the way upstream's single `const` reference allows is therefore not possible
// here: a live `&[ShaderInput]` borrow of `vertex_shader` would conflict with the `&mut
// vertex_shader` call `execute` needs a few lines later in the very same block. Fixed by
// snapshotting each shader's own input/output *metadata* (`VariableId` + a cloned
// `ValueRange`, or just `VariableId` where no range is needed) into a plain owned `Vec`
// *before* entering the per-packet loop - the metadata itself never changes across the
// loop (upstream's own `const vector<ShaderInput*>&`/`vector<const Variable*>` are read
// once, outside the loop, for the same reason), so cloning it once costs nothing
// observable and removes the aliasing conflict entirely. Every per-vertex/per-fragment
// *value* lookup afterward (`var_manager.get_variable(id).get_type()`) borrows the
// separate `&VariableManager` parameter instead, which is never in conflict with
// `vertex_shader`'s own mutable borrow since the two are unrelated places.
//
// **`VaryingStore` is keyed by variable *name* (`HashMap<String, VaryingStorage>`), not
// pointer identity** - upstream's own `std::map<std::string, VaryingStorage*>` already
// uses the name as its key (confirmed by reading `VaryingStore::getStorage`'s signature:
// `const char *name`, not a `const Variable*`), so this is a direct translation, not a
// deviation - the vertex and fragment shader's matching-named output/input `Variable`s are
// two distinct objects (one per shader's own global scope) that must still resolve to the
// same varying storage, which only the shared name can do.
//
// **A confirmed, genuine upstream performance bug, ported faithfully (not fixed)**: the
// vertex-shader block's own `numPackets` is computed as `numVertices + ((numVertices %
// EXEC_VEC_WIDTH) ? 1 : 0)` - note `numVertices +`, not `numVertices / EXEC_VEC_WIDTH +`,
// confirmed by reading the line directly and contrasted against the fragment-shader
// block's own `numPackets` a few dozen lines later in the very same function, which
// *does* divide (`(width * height) / EXEC_VEC_WIDTH + (...)`). This does not produce a
// wrong *result* - every packet beyond the first real one has `packetStart >=
// numVertices`, so `packetEnd = min((packetNdx+1)*EXEC_VEC_WIDTH, numVertices) <=
// packetStart` and every per-vertex loop inside that packet (both the input-interpolation
// and output-storage ones) iterates zero times - but it does call `vertexShader.execute`
// roughly `numVertices` times instead of `numVertices / EXEC_VEC_WIDTH` (64x too many for
// any grid with `numVertices >> 64`, e.g. a realistic 32x32-cell grid: 1089 vertices means
// 1090 redundant shader-interpreter runs instead of ~18). Reproduced exactly as
// `num_vertices + usize::from(num_vertices % EXEC_VEC_WIDTH != 0)` below; fixing it would
// be a behaviour-observable (timing, not output) deviation from upstream this effort's own
// "port genuine upstream bugs/oddities faithfully" rule asks to keep.
//
// **`toColor` (`rsgProgramExecutor.cpp`'s own free function, `tcu::Vec4 -> tcu::RGBA`) is
// dead code in this translation unit, confirmed by grep**: it is defined but never called
// anywhere in `rsgProgramExecutor.cpp` - `ProgramExecutor::execute`'s own final pixel
// write calls `m_dst.setPixel(c, ...)` directly with the float `Vec4`, never through
// `toColor`. Not ported, the same "declared/defined but never reached" shape this effort's
// `Variable::isWritable`/`Shader::allocateFunction` findings already documented, just the
// opposite direction (defined, simply unused, rather than declared-but-undefined).
//
// **`computeVertexIndices`'s own `gridVtxHeight` parameter is `DE_UNREF`'d** (confirmed
// by reading the body: only `gridVtxWidth` is ever used) - dropped from this port's
// `compute_vertex_indices` signature entirely rather than carried over as an unused
// parameter, since Rust has no direct `DE_UNREF` idiom and an unused parameter would be a
// clippy warning for no behavioural reason.

use std::collections::HashMap;

use super::execution_context::{EXEC_VEC_WIDTH, ExecConstValueAccess, ExecValueAccess, ExecutionContext};
use super::samplers::{Sampler2D, Sampler2DMap, SamplerCube, SamplerCubeMap};
use super::shader::Shader;
use super::variable_manager::{VariableId, VariableManager};
use super::variable_type::{Type, VariableType};
use super::variable_value::{ConstValueAccess, ConstValueRangeAccess, Scalar, ValueAccess, ValueRange, ValueStorage};
use crate::tcu::pixel::{PixelBufferAccess, Sampler};
use crate::tcu::texture_2d::Texture2D;
use crate::tcu::texture_cube::TextureCube;
use crate::tcu::vector::{IVec4, Vec2, Vec4};

/// `rsg::VaryingStorage` - stride-1 storage for one shader-output variable's value at
/// every one of `num_vertices` grid vertices, contiguous in `type_`'s own scalar order
/// (`type.getScalarSize() * vtxNdx` is each vertex's own base offset into one flat
/// `Vec<Scalar>`, matching upstream's single flat `std::vector<Scalar> m_value` exactly).
struct VaryingStorage {
    value: Vec<Scalar>,
}

impl VaryingStorage {
    /// `VaryingStorage::VaryingStorage(const VariableType&, int numVertices)`.
    fn new(type_: &VariableType, num_vertices: usize) -> Self {
        Self {
            value: vec![Scalar::zero(); type_.scalar_size() as usize * num_vertices],
        }
    }

    /// `VaryingStorage::getValue` (mutable overload).
    fn get_value(&mut self, type_: &VariableType, vtx_ndx: usize) -> ValueAccess<'_> {
        let offset = type_.scalar_size() as usize * vtx_ndx;
        ValueAccess::new(type_.clone(), &mut self.value[offset..], 1)
    }

    /// `VaryingStorage::getValue` (`const` overload).
    fn get_value_const(&self, type_: &VariableType, vtx_ndx: usize) -> ConstValueAccess<'_> {
        let offset = type_.scalar_size() as usize * vtx_ndx;
        ConstValueAccess::new(type_.clone(), &self.value[offset..], 1)
    }
}

/// `rsg::VaryingStore` - see this module's own top doc comment for why the key is the
/// variable's own name, matching upstream's `std::map<std::string, VaryingStorage*>`
/// exactly (not a deviation).
struct VaryingStore {
    num_vertices: usize,
    values: HashMap<String, VaryingStorage>,
}

impl VaryingStore {
    /// `VaryingStore::VaryingStore(int numVertices)`.
    fn new(num_vertices: usize) -> Self {
        Self {
            num_vertices,
            values: HashMap::new(),
        }
    }

    /// `VaryingStore::getStorage` - lazily allocates storage for `name` on first access,
    /// matching upstream's `std::map::operator[]` default-insert-then-check-null idiom.
    fn get_storage(&mut self, type_: &VariableType, name: &str) -> &mut VaryingStorage {
        let num_vertices = self.num_vertices;
        self.values
            .entry(name.to_string())
            .or_insert_with(|| VaryingStorage::new(type_, num_vertices))
    }
}

/// `rsg::interpolateVertexQuad` - bilinear interpolation of the four corners of `quad`
/// (`x0y0`/`x1y0`/`x0y1`/`x1y1`, in that component order) at `(x, y)`.
fn interpolate_vertex_quad(quad: Vec4, x: f32, y: f32) -> f32 {
    let w00 = (1.0 - x) * (1.0 - y);
    let w01 = (1.0 - x) * y;
    let w10 = x * (1.0 - y);
    let w11 = x * y;
    quad.x() * w00 + quad.y() * w10 + quad.z() * w01 + quad.w() * w11
}

/// `rsg::interpolateVertex` - see this module's own top doc comment on
/// `getVertexInterpolationCoords` for why this is not a plain 1-D lerp in `x` despite its
/// two scalar endpoints: it is `interpolateVertexQuad` over a quad whose two "shared-value"
/// corners (`x1y0`/`x0y1`, both `(x0y0 + x1y1) / 2`) make the result also depend on `y`.
fn interpolate_vertex(x0y0: f32, x1y1: f32, x: f32, y: f32) -> f32 {
    let mid = (x0y0 + x1y1) * 0.5;
    interpolate_vertex_quad(Vec4::new(x0y0, mid, mid, x1y1), x, y)
}

/// `rsg::interpolateTri` - barycentric interpolation of a triangle `(v0, v1, v2)` with
/// `v0` at `(0, 0)`, `v1` at `(1, 0)`, `v2` at `(0, 1)`.
fn interpolate_tri(v0: f32, v1: f32, v2: f32, x: f32, y: f32) -> f32 {
    v0 + (v1 - v0) * x + (v2 - v0) * y
}

/// `rsg::interpolateFragment` - a screen-space quad is split into two triangles along its
/// `x + y == 1` diagonal; `quad` is `(x0y0, x1y0, x0y1, x1y1)` as elsewhere in this file.
fn interpolate_fragment(quad: Vec4, x: f32, y: f32) -> f32 {
    if x + y < 1.0 {
        interpolate_tri(quad.x(), quad.y(), quad.z(), x, y)
    } else {
        interpolate_tri(quad.w(), quad.z(), quad.y(), 1.0 - x, 1.0 - y)
    }
}

/// `rsg::getVertexInterpolationCoords` (the inline free function declared directly in
/// `rsgProgramExecutor.hpp`, alongside the class, not in the `.cpp`) - picks, per
/// vector/scalar *component* of a vertex-shader input (`input_element_ndx`), which of the
/// four grid-cell corners that component's own value varies across: `elementNdx % 4 < 2`
/// picks `x` vs `1-x`, `elementNdx % 2 == 0` picks `y` vs `1-y` - so a `vec4` input's four
/// components each get one of the four `(x or 1-x, y or 1-y)` combinations.
pub(crate) fn get_vertex_interpolation_coords(x: f32, y: f32, input_element_ndx: i32) -> (f32, f32) {
    let xd = if input_element_ndx % 4 < 2 { x } else { 1.0 - x };
    let yd = if input_element_ndx % 2 == 0 { y } else { 1.0 - y };
    (xd, yd)
}

/// `rsg::interpolateVertexInput` (templated on `Stride` upstream; this port's own
/// `StridedValueAccess` carries its stride as a runtime field instead, so no generic
/// parameter is needed - see `rsg::variable_value`'s own top doc comment). `dst` is taken
/// by `&mut` rather than by value (upstream's own by-value `StridedValueAccess<Stride>
/// dst` parameter, cheap to copy there since it is only a pointer/type/stride triple) so
/// the caller can keep reusing the same access across every `dst_comp` in a packet's lane
/// range without re-fetching it from `ExecutionContext` each time.
fn interpolate_vertex_input(
    dst: &mut ExecValueAccess<'_>,
    dst_comp: usize,
    value_range: &ConstValueRangeAccess<'_>,
    x: f32,
    y: f32,
) {
    assert_eq!(
        value_range.get_type().base_type(),
        Type::Float,
        "TCU_CHECK(valueRange.getType().getBaseType() == TYPE_FLOAT)"
    );
    let num_elements = value_range.get_type().num_elements();
    for element_ndx in 0..num_elements {
        let (xd, yd) = get_vertex_interpolation_coords(x, y, element_ndx);
        let min_val = value_range.get_min().component(element_ndx).as_float();
        let max_val = value_range.get_max().component(element_ndx).as_float();
        dst.component(element_ndx)
            .set_float_at(dst_comp, interpolate_vertex(min_val, max_val, xd, yd));
    }
}

/// `rsg::interpolateFragmentInput` - same by-`&mut` reasoning as
/// `interpolate_vertex_input` above.
#[allow(clippy::too_many_arguments)]
fn interpolate_fragment_input(
    dst: &mut ExecValueAccess<'_>,
    dst_comp: usize,
    vtx0: &ConstValueAccess<'_>,
    vtx1: &ConstValueAccess<'_>,
    vtx2: &ConstValueAccess<'_>,
    vtx3: &ConstValueAccess<'_>,
    x: f32,
    y: f32,
) {
    assert_eq!(
        dst.get_type().base_type(),
        Type::Float,
        "TCU_CHECK(dst.getType().getBaseType() == TYPE_FLOAT)"
    );
    let num_elements = dst.get_type().num_elements();
    for ndx in 0..num_elements {
        let quad = Vec4::new(
            vtx0.component(ndx).as_float(),
            vtx1.component(ndx).as_float(),
            vtx2.component(ndx).as_float(),
            vtx3.component(ndx).as_float(),
        );
        dst.component(ndx)
            .set_float_at(dst_comp, interpolate_fragment(quad, x, y));
    }
}

/// `rsg::copyVarying` - copies one lane (`comp_ndx`) of a strided `src` (a vertex
/// shader's output, stride `EXEC_VEC_WIDTH`) into a fresh stride-1 `dst` (one vertex's own
/// slot in a `VaryingStorage`). Takes `dst` by value, matching upstream exactly: each call
/// site builds a brand-new access right before calling this, never reuses one afterward.
fn copy_varying(mut dst: ValueAccess<'_>, src: &ExecConstValueAccess<'_>, comp_ndx: usize) {
    assert_eq!(
        dst.get_type().base_type(),
        Type::Float,
        "TCU_CHECK(dst.getType().getBaseType() == TYPE_FLOAT)"
    );
    for elem_ndx in 0..dst.get_type().num_elements() {
        dst.component(elem_ndx)
            .set_float(src.component(elem_ndx).as_float_at(comp_ndx));
    }
}

/// `rsg::computeVertexIndices` - the four grid-vertex indices surrounding screen pixel
/// `(x, y)`'s own cell, in `(top-left, top-right, bottom-left, bottom-right)` order. See
/// this module's own top doc comment for why `grid_vtx_height` is not a parameter here.
fn compute_vertex_indices(cell_width: f32, cell_height: f32, grid_vtx_width: i32, x: i32, y: i32) -> IVec4 {
    let x0 = (x as f32 / cell_width).floor() as i32;
    let y0 = (y as f32 / cell_height).floor() as i32;
    IVec4::new(
        y0 * grid_vtx_width + x0,
        y0 * grid_vtx_width + x0 + 1,
        (y0 + 1) * grid_vtx_width + x0,
        (y0 + 1) * grid_vtx_width + x0 + 1,
    )
}

/// `rsg::computeGridCellWeights` - `(x, y)`'s own fractional position inside its grid
/// cell, sampling the pixel's centre (`+ 0.5`). `deFloatFrac(v)` is `v - floor(v)`,
/// reproduced directly rather than via `f32::fract` (which disagrees with `deFloatFrac`
/// for a negative input - not reachable here since `gx`/`gy` are always non-negative, but
/// spelling it out keeps the translation exact rather than relying on that fact silently).
fn compute_grid_cell_weights(cell_width: f32, cell_height: f32, x: i32, y: i32) -> Vec2 {
    let gx = (x as f32 + 0.5) / cell_width;
    let gy = (y as f32 + 0.5) / cell_height;
    Vec2::new(gx - gx.floor(), gy - gy.floor())
}

/// Writes every uniform `shader` declares, found by name in `uniforms`, into `exec_ctx`.
fn assign_uniforms(
    exec_ctx: &mut ExecutionContext<'_>,
    shader: &Shader,
    uniforms: &[(&str, &VariableType, &ValueStorage)],
) {
    for input in shader.get_uniforms() {
        let Some((_, type_, storage)) = uniforms.iter().find(|(name, _, _)| *name == input.get_name()) else {
            continue;
        };
        let src = storage.get_value_const(type_).value();
        exec_ctx.get_value(input.get_variable(), type_).assign_from(&src);
    }
}

/// `rsg::ProgramExecutor`.
pub struct ProgramExecutor<'d, 't> {
    dst: PixelBufferAccess<'d>,
    grid_width: i32,
    grid_height: i32,
    samplers_2d: Sampler2DMap<'t>,
    samplers_cube: SamplerCubeMap<'t>,
}

impl<'d, 't> ProgramExecutor<'d, 't> {
    /// `ProgramExecutor::ProgramExecutor`.
    pub fn new(dst: PixelBufferAccess<'d>, grid_width: i32, grid_height: i32) -> Self {
        Self {
            dst,
            grid_width,
            grid_height,
            samplers_2d: HashMap::new(),
            samplers_cube: HashMap::new(),
        }
    }

    /// `ProgramExecutor::setTexture` (the `Texture2D` overload).
    pub fn set_texture_2d(&mut self, sampler_ndx: i32, texture: &'t Texture2D, sampler: Sampler) {
        self.samplers_2d.insert(sampler_ndx, Sampler2D::new(texture, sampler));
    }

    /// `ProgramExecutor::setTexture` (the `TextureCube` overload).
    pub fn set_texture_cube(&mut self, sampler_ndx: i32, texture: &'t TextureCube, sampler: Sampler) {
        self.samplers_cube
            .insert(sampler_ndx, SamplerCube::new(texture, sampler));
    }

    /// `ProgramExecutor::execute`. Each stage resolves its `VariableId`s against its own
    /// `VariableManager` (`rsg::program_generator::generate` builds one per shader, see
    /// `Shader::take_variables`), and `uniforms` is by name - `(name, type, value)` - because the
    /// two managers number their variables independently. A uniform a stage does not declare is
    /// ignored for that stage, as upstream's unified list is.
    pub fn execute(
        &mut self,
        vertex_vars: &VariableManager<'_>,
        fragment_vars: &VariableManager<'_>,
        vertex_shader: &mut Shader,
        fragment_shader: &mut Shader,
        uniforms: &[(&str, &VariableType, &ValueStorage)],
    ) {
        let grid_vtx_width = self.grid_width + 1;
        let grid_vtx_height = self.grid_height + 1;
        let num_vertices = (grid_vtx_width * grid_vtx_height) as usize;

        let mut varying_store = VaryingStore::new(num_vertices);

        // Execute vertex shader.
        {
            let var_manager = vertex_vars;
            let mut exec_ctx = ExecutionContext::new(&self.samplers_2d, &self.samplers_cube);
            // See this module's own top doc comment: a confirmed, faithfully-reproduced
            // upstream performance bug (`numVertices +`, not `numVertices /
            // EXEC_VEC_WIDTH +`).
            #[allow(clippy::manual_is_multiple_of)]
            let num_packets = num_vertices + usize::from(num_vertices % EXEC_VEC_WIDTH != 0);

            // Snapshot input/output metadata before the loop - see this module's own top
            // doc comment for why this cannot stay a live `&[ShaderInput]`/`Vec<VariableId>`
            // borrow of `vertex_shader` the way upstream's `const` reference allows.
            let inputs: Vec<(VariableId, ValueRange)> = vertex_shader
                .get_inputs()
                .iter()
                .map(|input| (input.get_variable(), ValueRange::from_access(&input.get_value_range())))
                .collect();
            let output_ids = vertex_shader.get_outputs(var_manager);

            assign_uniforms(&mut exec_ctx, vertex_shader, uniforms);

            for packet_ndx in 0..num_packets {
                let packet_start = packet_ndx * EXEC_VEC_WIDTH;
                let packet_end = ((packet_ndx + 1) * EXEC_VEC_WIDTH).min(num_vertices);

                // Compute values for vertex shader inputs.
                for (input_id, value_range) in &inputs {
                    let var_type = var_manager.get_variable(*input_id).get_type().clone();
                    let mut access = exec_ctx.get_value(*input_id, &var_type);

                    for vtx_ndx in packet_start..packet_end {
                        let y = vtx_ndx / grid_vtx_width as usize;
                        let x = vtx_ndx - y * grid_vtx_width as usize;
                        let xf = x as f32 / (grid_vtx_width - 1) as f32;
                        let yf = y as f32 / (grid_vtx_height - 1) as f32;

                        interpolate_vertex_input(
                            &mut access,
                            vtx_ndx - packet_start,
                            &value_range.as_const_access(),
                            xf,
                            yf,
                        );
                    }
                }

                // Execute vertex shader for packet.
                vertex_shader.execute(var_manager, &mut exec_ctx);

                // Store output values.
                for &output_id in &output_ids {
                    let output = var_manager.get_variable(output_id);
                    if output.get_name() == "gl_Position" {
                        continue; // Do not store position.
                    }
                    let output_type = output.get_type().clone();
                    let output_name = output.get_name().to_string();

                    let access = exec_ctx.get_value(output_id, &output_type).into_const();
                    let dst_storage = varying_store.get_storage(&output_type, &output_name);

                    for vtx_ndx in packet_start..packet_end {
                        let varying_access = dst_storage.get_value(&output_type, vtx_ndx);
                        copy_varying(varying_access, &access, vtx_ndx - packet_start);
                    }
                }
            }
        }

        // Execute fragment shader.
        {
            let var_manager = fragment_vars;
            let mut exec_ctx = ExecutionContext::new(&self.samplers_2d, &self.samplers_cube);

            assign_uniforms(&mut exec_ctx, fragment_shader, uniforms);

            let inputs: Vec<VariableId> = fragment_shader
                .get_inputs()
                .iter()
                .map(|input| input.get_variable())
                .collect();

            // Find fragment shader output assigned to location 0. This is fragment color.
            let output_ids = fragment_shader.get_outputs(var_manager);
            let frag_color_var = output_ids
                .into_iter()
                .find(|&id| var_manager.get_variable(id).get_layout_location() == 0);
            let frag_color_var = frag_color_var.expect("TCU_CHECK(fragColorVar)");

            let [width, height, _] = self.dst.size();
            let (width, height) = (width as usize, height as usize);
            let num_packets = (width * height) / EXEC_VEC_WIDTH + usize::from((width * height) % EXEC_VEC_WIDTH != 0);

            let cell_width = width as f32 / self.grid_width as f32;
            let cell_height = height as f32 / self.grid_height as f32;

            for packet_ndx in 0..num_packets {
                let packet_start = packet_ndx * EXEC_VEC_WIDTH;
                let packet_end = ((packet_ndx + 1) * EXEC_VEC_WIDTH).min(width * height);

                // Interpolate varyings.
                for &input_id in &inputs {
                    let input = var_manager.get_variable(input_id);
                    let input_type = input.get_type().clone();
                    let input_name = input.get_name().to_string();
                    let mut access = exec_ctx.get_value(input_id, &input_type);
                    let src = varying_store.get_storage(&input_type, &input_name);

                    // \todo [2011-03-08 pyry] Part of this could be pre-computed... -
                    // upstream's own `\todo`, carried over unfixed.
                    for frag_ndx in packet_start..packet_end {
                        let y = (frag_ndx / width) as i32;
                        let x = (frag_ndx - y as usize * width) as i32;
                        let vtx_indices = compute_vertex_indices(cell_width, cell_height, grid_vtx_width, x, y);
                        let weights = compute_grid_cell_weights(cell_width, cell_height, x, y);

                        let vtx0 = src.get_value_const(&input_type, vtx_indices.x() as usize);
                        let vtx1 = src.get_value_const(&input_type, vtx_indices.y() as usize);
                        let vtx2 = src.get_value_const(&input_type, vtx_indices.z() as usize);
                        let vtx3 = src.get_value_const(&input_type, vtx_indices.w() as usize);

                        interpolate_fragment_input(
                            &mut access,
                            frag_ndx - packet_start,
                            &vtx0,
                            &vtx1,
                            &vtx2,
                            &vtx3,
                            weights.x(),
                            weights.y(),
                        );
                    }
                }

                // Execute fragment shader.
                fragment_shader.execute(var_manager, &mut exec_ctx);

                // Write resulting color.
                let color_type = var_manager.get_variable(frag_color_var).get_type().clone();
                let color_value = exec_ctx.get_value(frag_color_var, &color_type).into_const();
                for frag_ndx in packet_start..packet_end {
                    let y = frag_ndx / width;
                    let x = frag_ndx - y * width;
                    let c_ndx = frag_ndx - packet_start;
                    let c = [
                        color_value.component(0).as_float_at(c_ndx),
                        color_value.component(1).as_float_at(c_ndx),
                        color_value.component(2).as_float_at(c_ndx),
                        color_value.component(3).as_float_at(c_ndx),
                    ];

                    // \todo [2012-11-13 pyry] Reverse order. - upstream's own `\todo`,
                    // carried over unfixed.
                    self.dst.set_pixel(c, x as u32, (height - y - 1) as u32, 0);
                }
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn interpolate_tri_is_a_barycentric_blend_with_v0_at_the_origin() {
        assert_eq!(interpolate_tri(10.0, 20.0, 30.0, 0.0, 0.0), 10.0);
        assert_eq!(interpolate_tri(10.0, 20.0, 30.0, 1.0, 0.0), 20.0);
        assert_eq!(interpolate_tri(10.0, 20.0, 30.0, 0.0, 1.0), 30.0);
        // Midpoint of the v0-v1 edge.
        assert_eq!(interpolate_tri(10.0, 20.0, 30.0, 0.5, 0.0), 15.0);
    }

    #[test]
    fn interpolate_fragment_picks_the_lower_left_triangle_when_x_plus_y_is_below_one() {
        // quad = (x0y0, x1y0, x0y1, x1y1) = (1, 2, 3, 4).
        let quad = Vec4::new(1.0, 2.0, 3.0, 4.0);
        // x + y = 0.3 < 1: interpolateTri(quad.x(), quad.y(), quad.z(), x, y)
        //   = 1 + (2-1)*0.2 + (3-1)*0.1 = 1 + 0.2 + 0.2 = 1.4.
        // f32 arithmetic, not exact decimal math - `0.2_f32`/`0.1_f32` aren't exactly
        // representable, so the summed result lands one ULP off the `1.4` literal.
        assert!((interpolate_fragment(quad, 0.2, 0.1) - 1.4).abs() < 1e-6);

        // x + y = 1.3 >= 1: interpolateTri(quad.w(), quad.z(), quad.y(), 1-x, 1-y)
        //   = 4 + (3-4)*0.3 + (2-4)*0.4 = 4 - 0.3 - 0.8 = 2.9.
        assert!((interpolate_fragment(quad, 0.7, 0.6) - 2.9).abs() < 1e-6);
    }

    #[test]
    fn interpolate_vertex_quad_reproduces_each_corner_at_its_own_coordinate() {
        // quad = (x0y0, x1y0, x0y1, x1y1).
        let quad = Vec4::new(1.0, 2.0, 3.0, 4.0);
        assert_eq!(interpolate_vertex_quad(quad, 0.0, 0.0), 1.0);
        assert_eq!(interpolate_vertex_quad(quad, 1.0, 0.0), 2.0);
        assert_eq!(interpolate_vertex_quad(quad, 0.0, 1.0), 3.0);
        assert_eq!(interpolate_vertex_quad(quad, 1.0, 1.0), 4.0);
    }

    #[test]
    fn interpolate_vertex_at_x_half_y_half_is_the_pure_midpoint_of_its_two_endpoints() {
        // mid = (0+10)/2 = 5. quad = (0, 5, 5, 10). At (0.5, 0.5) every weight is 0.25,
        // so the result is the average of all four corners: (0+5+5+10)/4 = 5.0.
        assert_eq!(interpolate_vertex(0.0, 10.0, 0.5, 0.5), 5.0);
    }

    #[test]
    fn interpolate_vertex_at_a_non_symmetric_point_depends_on_both_x_and_y() {
        // v0=0, v1=10, mid=5, quad=(0,5,5,10). At x=0.25, y=0.0:
        // w00=(0.75)(1)=0.75, w01=(0.75)(0)=0, w10=(0.25)(1)=0.25, w11=(0.25)(0)=0.
        // result = 0*0.75 + 5*0.25 + 5*0 + 10*0 = 1.25 - demonstrably not the pure
        // 1-D lerp `2.5` a reader might otherwise expect from two scalar endpoints.
        assert_eq!(interpolate_vertex(0.0, 10.0, 0.25, 0.0), 1.25);
    }

    #[test]
    fn get_vertex_interpolation_coords_cycles_through_the_four_corner_combinations() {
        // elementNdx % 4 < 2 picks x vs 1-x; elementNdx % 2 == 0 picks y vs 1-y.
        assert_eq!(get_vertex_interpolation_coords(0.3, 0.7, 0), (0.3, 0.7)); // (x, y)
        assert_eq!(get_vertex_interpolation_coords(0.3, 0.7, 1), (0.3, 0.3)); // (x, 1-y)
        assert_eq!(get_vertex_interpolation_coords(0.3, 0.7, 2), (0.7, 0.7)); // (1-x, y)
        assert_eq!(get_vertex_interpolation_coords(0.3, 0.7, 3), (0.7, 0.3)); // (1-x, 1-y)
        // The cycle repeats every 4.
        assert_eq!(get_vertex_interpolation_coords(0.3, 0.7, 4), (0.3, 0.7));
    }

    #[test]
    fn compute_vertex_indices_picks_the_four_corners_of_the_containing_cell() {
        // A 3x3-vertex grid (2x2 cells), each cell 10x10 pixels. Pixel (12, 7) falls in
        // cell (1, 0) (x in [10,20), y in [0,10)).
        let indices = compute_vertex_indices(10.0, 10.0, 3, 12, 7);
        // y0 = floor(7/10) = 0, x0 = floor(12/10) = 1.
        // top-left = y0*3+x0 = 1, top-right = 2, bottom-left = (y0+1)*3+x0 = 4, bottom-right = 5.
        assert_eq!((indices.x(), indices.y(), indices.z(), indices.w()), (1, 2, 4, 5));
    }

    #[test]
    fn compute_grid_cell_weights_is_the_pixel_centers_fraction_within_its_cell() {
        // Cell width/height 10, pixel (12, 7): centre at (12.5, 7.5).
        // gx = 12.5/10 = 1.25 -> frac 0.25. gy = 7.5/10 = 0.75 -> frac 0.75.
        let w = compute_grid_cell_weights(10.0, 10.0, 12, 7);
        assert!((w.x() - 0.25).abs() < 1e-6);
        assert!((w.y() - 0.75).abs() < 1e-6);
    }

    #[test]
    fn varying_storage_round_trips_a_value_at_a_given_vertex_index() {
        use crate::rsg::variable_type::Type;
        let type_ = VariableType::new_basic(Type::Float, 2);
        let mut storage = VaryingStorage::new(&type_, 4);

        storage.get_value(&type_, 2).component(0).set_float(1.5);
        storage.get_value(&type_, 2).component(1).set_float(2.5);

        let v = storage.get_value_const(&type_, 2);
        assert_eq!(v.component(0).as_float(), 1.5);
        assert_eq!(v.component(1).as_float(), 2.5);

        // A different vertex index must not alias the same storage.
        let other = storage.get_value_const(&type_, 0);
        assert_eq!(other.component(0).as_float(), 0.0);
    }

    #[test]
    fn varying_store_lazily_allocates_per_name_and_keeps_distinct_names_separate() {
        use crate::rsg::variable_type::Type;
        let type_ = VariableType::new_basic(Type::Float, 1);
        let mut store = VaryingStore::new(2);

        store.get_storage(&type_, "v_color").get_value(&type_, 0).set_float(9.0);
        store
            .get_storage(&type_, "v_normal")
            .get_value(&type_, 0)
            .set_float(3.0);

        assert_eq!(
            store
                .get_storage(&type_, "v_color")
                .get_value_const(&type_, 0)
                .as_float(),
            9.0
        );
        assert_eq!(
            store
                .get_storage(&type_, "v_normal")
                .get_value_const(&type_, 0)
                .as_float(),
            3.0
        );
    }

    #[test]
    fn copy_varying_reads_one_lane_of_a_strided_source_into_a_fresh_stride_one_destination() {
        use crate::rsg::execution_context::EXEC_VEC_WIDTH;
        use crate::rsg::variable_type::Type;
        use crate::rsg::variable_value::ValueStorage;

        let type_ = VariableType::new_basic(Type::Float, 2);
        let mut src_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let mut src = src_storage.get_value(&type_);
            src.component(0).set_float_at(5, 11.0);
            src.component(1).set_float_at(5, 22.0);
        }

        let mut dst_storage = VaryingStorage::new(&type_, 1);
        copy_varying(
            dst_storage.get_value(&type_, 0),
            &src_storage.get_value_const(&type_),
            5,
        );

        let dst = dst_storage.get_value_const(&type_, 0);
        assert_eq!(dst.component(0).as_float(), 11.0);
        assert_eq!(dst.component(1).as_float(), 22.0);
    }
}
