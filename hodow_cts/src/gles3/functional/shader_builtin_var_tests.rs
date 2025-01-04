// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `VertexIDCase` is re-entered three times by
// upstream (CONTINUE); here one `iterate` runs the three iterations, each with the same seed
// `0xcf23ab1 ^ deInt32Hash(iterNdx)`, and reports the first failure. The depth range and
// `gl_FragCoord`/`gl_PointCoord`/`gl_FrontFacing` cases are shared with GLES2 in
// `gls::shader_builtin_var_cases`.

use crate::gls::shader_builtin_var_cases::{
    BuiltinVarGlsl, depth_range_case, frag_coord_w_case, frag_coord_xyz_case, front_facing_case, point_coord_case,
};
use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{
    self, Context, DataType, Precision, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, VarType,
};
use crate::glw::{self, GLuint};
use crate::rr::defs::IndexType;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType as RrPrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{
    DrawCommand, DrawIndices, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view,
};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
    VertexVaryingInfo,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::clear;
use crate::tcu::random::de_int32_hash;
use crate::tcu::vector::Vec4;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

/// `Box<dyn TestCase>`, which `add_child` needs (it does not unsize a `Box<Concrete>` itself).
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

/// `getInteger<Pname>`
fn get_integer(gl: &glw::Functions, pname: u32) -> Result<i32, TestError> {
    let mut value = -1;
    // SAFETY: every pname passed here is a single-integer query.
    unsafe { gl.get_integerv(pname, &mut value) };
    glu::expect_no_error(gl, "glGetIntegerv()")?;
    Ok(value)
}

/// `getVectorsFromComps<Pname>` - truncated division, as upstream.
fn get_vectors_from_comps(gl: &glw::Functions, pname: u32) -> Result<i32, TestError> {
    Ok(get_integer(gl, pname)? / 4)
}

/// `ShaderBuiltinConstantCase`
struct ShaderBuiltinConstantCase {
    name: String,
    var_name: &'static str,
    pname: u32,
    /// `getVectorsFromComps` rather than `getInteger`.
    from_comps: bool,
    shader_type: ShaderType,
}

impl TestCase for ShaderBuiltinConstantCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let mut spec = ShaderSpec::new(context.context_type().glsl_version());
        spec.source = format!("result = {};\n", self.var_name);
        spec.outputs.push(Symbol::new(
            "result",
            VarType::basic(DataType::Int, Some(Precision::HighP)),
        ));
        let executor = shader_exec_util::create_executor(&context.render_context, self.shader_type, &spec)?;

        let reference = if self.from_comps {
            get_vectors_from_comps(gl, self.pname)?
        } else {
            get_integer(gl, self.pname)?
        };

        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Compile failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let mut result_bytes = (-1i32).to_ne_bytes();
        {
            let mut out_slice: &mut [u8] = &mut result_bytes;
            executor.execute(1, &[], std::slice::from_mut(&mut out_slice))?;
        }
        let result = i32::from_ne_bytes(result_bytes);

        if result != reference {
            return Ok(TestStatus::fail(format!(
                "Invalid builtin constant value: {} = {result}, expected {reference}",
                self.var_name
            )));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// --- VertexIDCase ---

const MAX_VERTICES: usize = 8 * 3;

/// `VertexIDReferenceShader` - position and colour in, colour out.
struct VertexIdReferenceShader {
    vertex_inputs: Vec<VertexInputInfo>,
    vertex_outputs: Vec<VertexOutputInfo>,
    fragment_inputs: Vec<FragmentInputInfo>,
    fragment_outputs: Vec<FragmentOutputInfo>,
}

impl VertexIdReferenceShader {
    fn new() -> Self {
        Self {
            vertex_inputs: vec![
                VertexInputInfo {
                    type_: Some(GenericVecType::Float)
                };
                2
            ],
            vertex_outputs: vec![VertexVaryingInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
            fragment_inputs: vec![VertexVaryingInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
            fragment_outputs: vec![FragmentOutputInfo {
                type_: Some(GenericVecType::Float),
            }],
        }
    }
}

impl VertexShader for VertexIdReferenceShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.vertex_inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &self.vertex_outputs
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        const VARYINGLOC_COLOR: usize = 0;
        const POSITION_ATTR_LOC: usize = 0;
        const COLOR_ATTR_LOC: usize = 1;

        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: both attributes were bound by `render_reference` before the draw.
            unsafe {
                read_vertex_attrib_float(
                    &mut position,
                    &inputs[POSITION_ATTR_LOC],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
                read_vertex_attrib_float(
                    &mut color,
                    &inputs[COLOR_ATTR_LOC],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
            }

            // Transform to position
            packet.position = position;
            // Pass color to FS
            packet.outputs[VARYINGLOC_COLOR] = GenericVec4::from_float(color);
        }
    }
}

impl FragmentShader for VertexIdReferenceShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &self.fragment_inputs
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.fragment_outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        const VARYINGLOC_COLOR: i32 = 0;

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let value = read_varying(&packets[packet_ndx], context, VARYINGLOC_COLOR, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(value),
                    );
                }
            }
        }
    }
}

/// `VertexIDCase::renderReference`
fn render_reference(dst: &mut Surface, indices: &[u16], positions: &[Vec4], colors: &[Vec4], subpixel_bits: i32) {
    let (width, height) = (dst.get_width(), dst.get_height());
    let state = RenderState::new(ViewportState::from_target_size(width, height), subpixel_bits);
    let mut render_target = RenderTarget::new(as_multisample_view(dst.get_access()), None, None);
    let shader = VertexIdReferenceShader::new();
    let program = Program {
        vertex_shader: &shader,
        fragment_shader: &shader,
        geometry_shader: None,
    };

    let attribs = [
        VertexAttrib::from_pointer(VertexAttribType::Float, 4, 0, 0, positions.as_ptr().cast()),
        VertexAttrib::from_pointer(VertexAttribType::Float, 4, 0, 0, colors.as_ptr().cast()),
    ];

    let primitives = PrimitiveList::from_indices(
        RrPrimitiveType::Triangles,
        indices.len(),
        DrawIndices::U16(indices, 0),
        IndexType::Uint16,
    );
    let command = DrawCommand {
        state: &state,
        program: &program,
        vertex_attribs: &attribs,
        primitives: &primitives,
    };
    Renderer::new().draw(&command, &mut render_target);
}

/// `VertexIDCase::init`'s colour table.
fn vertex_id_colors() -> Vec<Vec4> {
    const C: [[f32; 3]; MAX_VERTICES] = [
        [0.0, 0.0, 0.0],
        [0.5, 1.0, 0.5],
        [0.0, 0.5, 1.0],
        [0.0, 1.0, 0.0],
        [0.0, 1.0, 1.0],
        [0.5, 0.0, 0.0],
        [0.5, 0.0, 1.0],
        [0.5, 0.0, 0.5],
        [1.0, 0.0, 0.0],
        [0.5, 1.0, 0.0],
        [0.0, 0.5, 0.0],
        [0.5, 1.0, 1.0],
        [0.0, 0.0, 1.0],
        [1.0, 0.0, 0.5],
        [0.0, 0.5, 0.5],
        [1.0, 1.0, 0.5],
        [1.0, 0.0, 1.0],
        [1.0, 0.5, 0.0],
        [0.0, 1.0, 0.5],
        [1.0, 0.5, 1.0],
        [1.0, 1.0, 0.0],
        [1.0, 0.5, 0.5],
        [0.0, 0.0, 0.5],
        [1.0, 1.0, 1.0],
    ];
    C.iter().map(|c| Vec4::new(c[0], c[1], c[2], 1.0)).collect()
}

struct VertexIdCase;

impl TestCase for VertexIdCase {
    fn name(&self) -> &str {
        "vertex_id"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;

        let quad_width = 32;
        let quad_height = 32;

        if width < quad_width {
            return Err(TestError::NotSupported("Too small render target".to_string()));
        }

        let max_quads_x = width / quad_width;
        let num_vertices = MAX_VERTICES as i32;

        let num_quads = num_vertices / 6 + i32::from(num_vertices % 6 != 0);
        let viewport_w = num_quads.min(max_quads_x) * quad_width;
        let viewport_h = (num_quads / max_quads_x + i32::from(num_quads % max_quads_x != 0)) * quad_height;

        if viewport_h > height {
            return Err(TestError::NotSupported("Too small render target".to_string()));
        }

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 out mediump vec4 v_color;\n\
                 uniform highp vec4 u_colors[24];\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_color = u_colors[gl_VertexID];\n\
                 }\n",
                "#version 300 es\n\
                 in mediump vec4 v_color;\n\
                 layout(location = 0) out mediump vec4 o_color;\n\
                 void main (void)\n\
                 {\n\
                 \x20   o_color = v_color;\n\
                 }\n",
            ),
        );
        if !program.is_ok() {
            return Err(TestError::InternalError("Compile failed".to_string()));
        }

        let mut position_buffer: GLuint = 0;
        let mut element_buffer: GLuint = 0;
        // SAFETY: one name each is generated into a live `GLuint`.
        unsafe {
            gl.gen_buffers(1, &mut position_buffer);
            gl.gen_buffers(1, &mut element_buffer);
        }

        let result = run_iterations(
            context,
            &program,
            position_buffer,
            element_buffer,
            viewport_w,
            viewport_h,
            quad_width,
            quad_height,
            max_quads_x,
        );

        // SAFETY: both names were generated above and are deleted once.
        unsafe {
            gl.delete_buffers(1, &position_buffer);
            gl.delete_buffers(1, &element_buffer);
        }
        result
    }
}

#[allow(clippy::too_many_arguments)]
fn run_iterations(
    context: &Context,
    program: &ShaderProgram<'_>,
    position_buffer: GLuint,
    element_buffer: GLuint,
    viewport_w: i32,
    viewport_h: i32,
    quad_width: i32,
    quad_height: i32,
    max_quads_x: i32,
) -> TestOutcome {
    let gl = context.gl();
    let render_target = context.render_target();
    let num_vertices = MAX_VERTICES;

    let colors = vertex_id_colors();

    // Compute positions.
    let mut positions = vec![Vec4::splat(0.0); num_vertices];
    for vtx_ndx in (0..num_vertices).step_by(3) {
        let h = 2.0 * quad_height as f32 / viewport_h as f32;
        let w = 2.0 * quad_width as f32 / viewport_w as f32;

        let tri_ndx = (vtx_ndx / 3) as i32;
        let quad_ndx = tri_ndx / 2;
        let quad_y = quad_ndx / max_quads_x;
        let quad_x = quad_ndx % max_quads_x;

        let x0 = -1.0 + quad_x as f32 * w;
        let y0 = -1.0 + quad_y as f32 * h;

        if tri_ndx % 2 == 0 {
            positions[vtx_ndx] = Vec4::new(x0, y0, 0.0, 1.0);
            positions[vtx_ndx + 1] = Vec4::new(x0 + w, y0 + h, 0.0, 1.0);
            positions[vtx_ndx + 2] = Vec4::new(x0, y0 + h, 0.0, 1.0);
        } else {
            positions[vtx_ndx] = Vec4::new(x0 + w, y0 + h, 0.0, 1.0);
            positions[vtx_ndx + 1] = Vec4::new(x0, y0, 0.0, 1.0);
            positions[vtx_ndx + 2] = Vec4::new(x0 + w, y0, 0.0, 1.0);
        }
    }

    let threshold = 0.02f32;
    let mut status = TestStatus::pass("Pass");

    for iter_ndx in 0..3 {
        let mut rnd = Random::new(0xcf23ab1 ^ de_int32_hash(iter_ndx));
        let mut ref_img = Surface::new(viewport_w, viewport_h);
        let mut test_img = Surface::new(viewport_w, viewport_h);

        let viewport_x = rnd.get_int(0, render_target.width - viewport_w);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_h);

        let clear_color = Vec4::new(0.0, 0.0, 0.0, 1.0);
        let mut subpixel_bits = 0;

        // SAFETY: a program this case built, valid names and in-range pointers throughout.
        let (pos_loc, colors_loc) = unsafe {
            let pos_loc = gl.get_attrib_location(program.program(), c"a_position".as_ptr());
            let colors_loc = gl.get_uniform_location(program.program(), c"u_colors[0]".as_ptr());

            // Setup common state.
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
            gl.use_program(program.program());
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buffer);
            gl.enable_vertex_attrib_array(pos_loc as u32);
            gl.vertex_attrib_pointer(pos_loc as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.uniform_4fv(colors_loc, colors.len() as i32, colors.as_ptr().cast());

            // Clear render target to black.
            gl.clear_color(clear_color.x(), clear_color.y(), clear_color.z(), clear_color.w());
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            gl.get_integerv(glw::GL_SUBPIXEL_BITS, &mut subpixel_bits);
            (pos_loc, colors_loc)
        };
        let _ = (pos_loc, colors_loc);

        clear(&mut ref_img.get_access(), clear_color.m_data);

        let pos_bytes = std::mem::size_of_val(positions.as_slice()) as isize;

        match iter_ndx {
            0 => {
                // glDrawArrays()
                let indices: Vec<u16> = (0..positions.len() as u16).collect();

                // SAFETY: the bound array buffer receives `pos_bytes` bytes from `positions`.
                unsafe {
                    gl.buffer_data(
                        glw::GL_ARRAY_BUFFER,
                        pos_bytes,
                        positions.as_ptr().cast(),
                        glw::GL_DYNAMIC_DRAW,
                    );
                    gl.draw_arrays(glw::GL_TRIANGLES, 0, positions.len() as i32);
                }

                glu::read_pixels(
                    &context.render_context,
                    viewport_x,
                    viewport_y,
                    &mut test_img.get_access(),
                )?;
                glu::expect_no_error(gl, "Draw")?;

                render_reference(&mut ref_img, &indices, &positions, &colors, subpixel_bits);
            }
            1 | 2 => {
                // glDrawElements(), indices in a client-side array (1) or a buffer (2)
                let mut indices: Vec<u16> = (0..positions.len() as u16).collect();
                rnd.shuffle(&mut indices);

                // Use indices to re-map positions.
                let mut mapped_pos = vec![Vec4::splat(0.0); positions.len()];
                for ndx in 0..indices.len() {
                    mapped_pos[indices[ndx] as usize] = positions[ndx];
                }

                // SAFETY: buffer uploads from live vectors with matching byte sizes; the element
                // pointer is either a live client array or an offset into the bound buffer.
                unsafe {
                    if iter_ndx == 2 {
                        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buffer);
                        gl.buffer_data(
                            glw::GL_ELEMENT_ARRAY_BUFFER,
                            std::mem::size_of_val(indices.as_slice()) as isize,
                            indices.as_ptr().cast(),
                            glw::GL_DYNAMIC_DRAW,
                        );
                    }

                    gl.buffer_data(
                        glw::GL_ARRAY_BUFFER,
                        pos_bytes,
                        mapped_pos.as_ptr().cast(),
                        glw::GL_DYNAMIC_DRAW,
                    );
                    let element_ptr: *const std::ffi::c_void = if iter_ndx == 2 {
                        std::ptr::null()
                    } else {
                        indices.as_ptr().cast()
                    };
                    gl.draw_elements(
                        glw::GL_TRIANGLES,
                        indices.len() as i32,
                        glw::GL_UNSIGNED_SHORT,
                        element_ptr,
                    );
                }

                glu::read_pixels(
                    &context.render_context,
                    viewport_x,
                    viewport_y,
                    &mut test_img.get_access(),
                )?;
                glu::expect_no_error(gl, "Draw")?;

                render_reference(&mut ref_img, &indices, &mapped_pos, &colors, subpixel_bits);
            }
            _ => unreachable!("three iterations"),
        }

        let ok = fuzzy_compare_ok(&ref_img.get_const_access(), &test_img.get_const_access(), threshold)
            .ok_or_else(|| TestError::InternalError("fuzzy comparison of unsupported formats".to_string()))?;
        if !ok {
            status = TestStatus::fail("Image comparison failed");
        }
    }

    // SAFETY: unbinding is always valid.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }
    Ok(status)
}

/// `ShaderBuiltinVarTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin_variable");

    // Builtin constants. `true` marks `getVectorsFromComps`.
    const BUILTIN_CONSTANTS: [(&str, &str, u32, bool); 11] = [
        // GLES 2.
        (
            "max_vertex_attribs",
            "gl_MaxVertexAttribs",
            glw::GL_MAX_VERTEX_ATTRIBS,
            false,
        ),
        (
            "max_vertex_uniform_vectors",
            "gl_MaxVertexUniformVectors",
            glw::GL_MAX_VERTEX_UNIFORM_VECTORS,
            false,
        ),
        (
            "max_fragment_uniform_vectors",
            "gl_MaxFragmentUniformVectors",
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
            false,
        ),
        (
            "max_texture_image_units",
            "gl_MaxTextureImageUnits",
            glw::GL_MAX_TEXTURE_IMAGE_UNITS,
            false,
        ),
        (
            "max_vertex_texture_image_units",
            "gl_MaxVertexTextureImageUnits",
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
            false,
        ),
        (
            "max_combined_texture_image_units",
            "gl_MaxCombinedTextureImageUnits",
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
            false,
        ),
        ("max_draw_buffers", "gl_MaxDrawBuffers", glw::GL_MAX_DRAW_BUFFERS, false),
        // GLES 3.
        (
            "max_vertex_output_vectors",
            "gl_MaxVertexOutputVectors",
            glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS,
            true,
        ),
        (
            "max_fragment_input_vectors",
            "gl_MaxFragmentInputVectors",
            glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS,
            true,
        ),
        (
            "min_program_texel_offset",
            "gl_MinProgramTexelOffset",
            glw::GL_MIN_PROGRAM_TEXEL_OFFSET,
            false,
        ),
        (
            "max_program_texel_offset",
            "gl_MaxProgramTexelOffset",
            glw::GL_MAX_PROGRAM_TEXEL_OFFSET,
            false,
        ),
    ];

    for (case_name, var_name, pname, from_comps) in BUILTIN_CONSTANTS {
        for (suffix, shader_type) in [("vertex", ShaderType::Vertex), ("fragment", ShaderType::Fragment)] {
            group.add_child(boxed(ShaderBuiltinConstantCase {
                name: format!("{case_name}_{suffix}"),
                var_name,
                pname,
                from_comps,
                shader_type,
            }));
        }
    }

    group.add_child(depth_range_case("depth_range_vertex", true, BuiltinVarGlsl::Es300));
    group.add_child(depth_range_case("depth_range_fragment", false, BuiltinVarGlsl::Es300));

    // Vertex shader builtin variables.
    group.add_child(boxed(VertexIdCase));

    // Fragment shader builtin variables.
    group.add_child(frag_coord_xyz_case(BuiltinVarGlsl::Es300));
    group.add_child(frag_coord_w_case(BuiltinVarGlsl::Es300));
    group.add_child(point_coord_case(BuiltinVarGlsl::Es300));
    group.add_child(front_facing_case(BuiltinVarGlsl::Es300));

    group
}
