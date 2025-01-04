// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsRandomShaderCase.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Deviations, all forced by the port's shape:
//  - Cases are stateless (`iterate(&self, &Context)`), so upstream's `init`/`iterate`/`deinit` are one
//    `iterate`: shaders are generated, limits checked, textures made and everything dropped inside it.
//    The case holds only its `ProgramParameters`.
//  - Upstream's `VertexArray`/`TextureManager` classes are plain local vectors/sets here.
//  - `rsg::ProgramGenerator` leaves each shader with its own variable arena (`Shader::take_variables`);
//    each stage gets its own `VariableManager`, and uniforms cross stages by name (see
//    `gls::random_shader_program`, which does the same for the sglr-based consumer).
//  - The per-attribute/uniform log lines and the fuzzy-compare images are not logged.
//  - GLES2 fills the 4-argument `mapGLSampler` the same way as upstream (wrap R = wrap T); the sampler
//    carries one filter, which is LINEAR for both min and mag here.

use std::collections::BTreeSet;
use std::ffi::CString;

use crate::gls::random_shader_program::{UniformAssignment, compute_unified_uniforms, compute_uniform_values};
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util_surface::{LodRange, fill_with_component_gradients_old, map_gl_sampler};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase};
use crate::glw;
use crate::rsg::name_allocator::NameAllocator;
use crate::rsg::parameters::ProgramParameters;
use crate::rsg::program_executor::{ProgramExecutor, get_vertex_interpolation_coords};
use crate::rsg::program_generator;
use crate::rsg::shader::Shader;
use crate::rsg::variable::ShaderType;
use crate::rsg::variable_manager::VariableManager;
use crate::rsg::variable_type::{Type, VariableType};
use crate::rsg::variable_value::ValueStorage;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{CubeFace, TextureLevel};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;

const TEXTURE_2D_WIDTH: u32 = 64;
const TEXTURE_2D_HEIGHT: u32 = 64;
const TEXTURE_CUBE_SIZE: u32 = 16;

const TEXTURE_WRAP_S: glw::GLenum = glw::GL_CLAMP_TO_EDGE;
const TEXTURE_WRAP_T: glw::GLenum = glw::GL_CLAMP_TO_EDGE;
const TEXTURE_MIN_FILTER: glw::GLenum = glw::GL_LINEAR;
const TEXTURE_MAG_FILTER: glw::GLenum = glw::GL_LINEAR;

/// `m_gridWidth`/`m_gridHeight`
const GRID_WIDTH: i32 = 1;
const GRID_HEIGHT: i32 = 1;

/// `gls::VertexArray`
struct VertexArray {
    name: String,
    num_components: i32,
    vertices: Vec<f32>,
}

/// `gls::RandomShaderCase`
pub struct RandomShaderCase {
    name: String,
    parameters: ProgramParameters,
}

impl RandomShaderCase {
    pub fn new(name: impl Into<String>, parameters: ProgramParameters) -> Self {
        Self {
            name: name.into(),
            parameters,
        }
    }
}

fn num_sampler_uniforms(shader: &Shader) -> i32 {
    shader
        .get_uniforms()
        .iter()
        .filter(|u| u.get_value_range().get_type().is_sampler())
        .count() as i32
}

/// `RandomShaderCase::checkShaderLimits`
fn check_shader_limits(gl: &glw::Functions, shader: &Shader) -> Result<(), TestError> {
    let num_required_samplers = num_sampler_uniforms(shader);

    if num_required_samplers > 0 {
        let pname = if shader.get_type() == ShaderType::Vertex {
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS
        } else {
            glw::GL_MAX_TEXTURE_IMAGE_UNITS
        };
        let mut num_supported: glw::GLint = -1;

        // SAFETY: a current context and a valid out pointer.
        let error = unsafe {
            gl.get_integerv(pname, &mut num_supported);
            gl.get_error()
        };
        if error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!("Limit query failed: error {error:#x}")));
        }

        if num_supported < num_required_samplers {
            return Err(TestError::NotSupported(format!(
                "Shader requires {num_required_samplers} sampler(s). Implementation supports {num_supported}"
            )));
        }
    }
    Ok(())
}

/// `RandomShaderCase::checkProgramLimits`
fn check_program_limits(
    gl: &glw::Functions,
    vertex_shader: &Shader,
    fragment_shader: &Shader,
) -> Result<(), TestError> {
    let num_required_combined_samplers = num_sampler_uniforms(vertex_shader) + num_sampler_uniforms(fragment_shader);

    if num_required_combined_samplers > 0 {
        let mut num_supported: glw::GLint = -1;

        // SAFETY: a current context and a valid out pointer.
        let error = unsafe {
            gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut num_supported);
            gl.get_error()
        };
        if error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!("Limit query failed: error {error:#x}")));
        }

        if num_supported < num_required_combined_samplers {
            return Err(TestError::NotSupported(format!(
                "Program requires {num_required_combined_samplers} sampler(s). Implementation supports {num_supported}"
            )));
        }
    }
    Ok(())
}

/// `RandomShaderCase::getTex2D`
fn make_tex_2d(context: &Context) -> Result<Texture2D<'_>, TestError> {
    let gl = context.gl();
    let mut tex = Texture2D::new(
        &context.render_context,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        TEXTURE_2D_WIDTH,
        TEXTURE_2D_HEIGHT,
    )?;

    tex.ref_texture_mut().alloc_level(0);
    fill_with_component_gradients_old(
        &mut tex.ref_texture_mut().level_mut(0),
        [-1.0, -1.0, -1.0, 2.0],
        [1.0, 1.0, 1.0, 0.0],
    );

    // SAFETY: a current context; the texture outlives the calls.
    unsafe {
        tex.upload()?;

        gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, TEXTURE_WRAP_S as glw::GLint);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, TEXTURE_WRAP_T as glw::GLint);
        gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MIN_FILTER,
            TEXTURE_MIN_FILTER as glw::GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MAG_FILTER,
            TEXTURE_MAG_FILTER as glw::GLint,
        );
    }
    glu::expect_no_error(gl, "texture 2D setup")?;

    Ok(tex)
}

/// `RandomShaderCase::getTexCube`
fn make_tex_cube(context: &Context) -> Result<TextureCube<'_>, TestError> {
    let gl = context.gl();
    let mut tex = TextureCube::new(
        &context.render_context,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        TEXTURE_CUBE_SIZE,
    )?;

    const FACES: [CubeFace; 6] = [
        CubeFace::NegativeX,
        CubeFace::PositiveX,
        CubeFace::NegativeY,
        CubeFace::PositiveY,
        CubeFace::NegativeZ,
        CubeFace::PositiveZ,
    ];
    const GRADIENTS: [([f32; 4], [f32; 4]); 6] = [
        ([-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]), // negative x
        ([0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive x
        ([-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // negative y
        ([-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive y
        ([-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]), // negative z
        ([0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),    // positive z
    ];

    // Fill level 0.
    tex.ref_texture_mut().alloc_level(0);
    for (face_ndx, &face) in FACES.iter().enumerate() {
        let mut level = tex.ref_texture_mut().face_level_mut(face, 0);
        fill_with_component_gradients_old(&mut level, GRADIENTS[face_ndx].0, GRADIENTS[face_ndx].1);
    }

    // SAFETY: a current context; the texture outlives the calls.
    unsafe {
        tex.upload()?;

        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex.gl_texture());
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_WRAP_S,
            TEXTURE_WRAP_S as glw::GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_WRAP_T,
            TEXTURE_WRAP_T as glw::GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MIN_FILTER,
            TEXTURE_MIN_FILTER as glw::GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MAG_FILTER,
            TEXTURE_MAG_FILTER as glw::GLint,
        );
    }
    glu::expect_no_error(gl, "texture cube setup")?;

    Ok(tex)
}

/// `setUniformValue`
fn set_uniform_value(
    gl: &glw::Functions,
    location: glw::GLint,
    type_: &VariableType,
    storage: &ValueStorage,
) -> Result<(), TestError> {
    let value = storage.get_value_const(type_);
    let num_elements = type_.num_elements();

    match type_.base_type() {
        Type::Float => {
            let mut data = [0.0f32; 4];
            if !(1..=4).contains(&num_elements) {
                return Err(TestError::Fail("Unsupported type".to_string()));
            }
            for (ndx, dst) in data.iter_mut().enumerate().take(num_elements as usize) {
                *dst = value.component(ndx as i32).as_float();
            }

            // SAFETY: `data` holds at least `num_elements` floats.
            unsafe {
                match num_elements {
                    1 => gl.uniform_1fv(location, 1, data.as_ptr()),
                    2 => gl.uniform_2fv(location, 1, data.as_ptr()),
                    3 => gl.uniform_3fv(location, 1, data.as_ptr()),
                    _ => gl.uniform_4fv(location, 1, data.as_ptr()),
                }
            }
        }

        Type::Int | Type::Bool | Type::Sampler2D | Type::SamplerCube => {
            let mut data = [0i32; 4];
            if !(1..=4).contains(&num_elements) {
                return Err(TestError::Fail("Unsupported type".to_string()));
            }
            for (ndx, dst) in data.iter_mut().enumerate().take(num_elements as usize) {
                // A bool is stored as its raw 0/1 scalar, which is what `glUniform*iv` reads upstream.
                *dst = value.component(ndx as i32).as_int();
            }

            // SAFETY: `data` holds at least `num_elements` ints.
            unsafe {
                match num_elements {
                    1 => gl.uniform_1iv(location, 1, data.as_ptr()),
                    2 => gl.uniform_2iv(location, 1, data.as_ptr()),
                    3 => gl.uniform_3iv(location, 1, data.as_ptr()),
                    _ => gl.uniform_4iv(location, 1, data.as_ptr()),
                }
            }
        }

        _ => return Err(TestError::Fail("Unsupported type".to_string())),
    }
    Ok(())
}

impl RandomShaderCase {
    /// `RandomShaderCase::init`'s vertex generation, one `VertexArray` per vertex shader input.
    fn generate_vertex_arrays(vertex_shader: &Shader) -> Result<Vec<VertexArray>, TestError> {
        let num_vertices = (GRID_WIDTH + 1) * (GRID_HEIGHT + 1);
        let mut arrays = Vec::new();

        for input in vertex_shader.get_inputs() {
            let value_range = input.get_value_range();
            let num_components = value_range.get_type().num_elements();
            let is_position = input.get_name() == "dEQP_Position";

            if value_range.get_type().base_type() != Type::Float {
                return Err(TestError::InternalError(
                    "TCU_CHECK: vertex attribute is not a float type".to_string(),
                ));
            }

            let mut vertices = vec![0.0f32; (num_components * num_vertices) as usize];

            for vtx_ndx in 0..num_vertices {
                let y = vtx_ndx / (GRID_WIDTH + 1);
                let x = vtx_ndx - y * (GRID_WIDTH + 1);
                let xf = x as f32 / GRID_WIDTH as f32;
                let yf = y as f32 / GRID_HEIGHT as f32;
                let dst = &mut vertices[(vtx_ndx * num_components) as usize..((vtx_ndx + 1) * num_components) as usize];

                if is_position {
                    // Position attribute gets special interpolation handling.
                    debug_assert!(num_components == 4);
                    dst[0] = -1.0 + xf * 2.0;
                    dst[1] = 1.0 + yf * -2.0;
                    dst[2] = 0.0;
                    dst[3] = 1.0;
                } else {
                    for (comp_ndx, d) in dst.iter_mut().enumerate() {
                        let min_val = value_range.get_min().component(comp_ndx as i32).as_float();
                        let max_val = value_range.get_max().component(comp_ndx as i32).as_float();
                        let (xd, yd) = get_vertex_interpolation_coords(xf, yf, comp_ndx as i32);
                        let f = (xd + yd) / 2.0;

                        *d = min_val + f * (max_val - min_val);
                    }
                }
            }

            arrays.push(VertexArray {
                name: input.get_name().to_string(),
                num_components,
                vertices,
            });
        }

        Ok(arrays)
    }

    /// `RandomShaderCase::init`'s index generation.
    fn generate_indices() -> Vec<u16> {
        let num_quads = GRID_WIDTH * GRID_HEIGHT;
        let mut indices = vec![0u16; (num_quads * 6) as usize];

        for quad_ndx in 0..num_quads {
            let quad_y = quad_ndx / GRID_WIDTH;
            let quad_x = quad_ndx - quad_y * GRID_WIDTH;
            let base = (quad_ndx * 6) as usize;

            indices[base] = (quad_x + quad_y * (GRID_WIDTH + 1)) as u16;
            indices[base + 1] = (quad_x + (quad_y + 1) * (GRID_WIDTH + 1)) as u16;
            indices[base + 2] = (quad_x + quad_y * (GRID_WIDTH + 1) + 1) as u16;
            indices[base + 3] = indices[base + 2];
            indices[base + 4] = indices[base + 1];
            indices[base + 5] = (quad_x + (quad_y + 1) * (GRID_WIDTH + 1) + 1) as u16;
        }

        indices
    }
}

impl TestCase for RandomShaderCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `RandomShaderCase::init` + `iterate` + `deinit`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // Generate shaders.
        let mut vertex_shader = Shader::new(ShaderType::Vertex);
        let mut fragment_shader = Shader::new(ShaderType::Fragment);
        program_generator::generate(&self.parameters, &mut vertex_shader, &mut fragment_shader);

        check_shader_limits(gl, &vertex_shader)?;
        check_shader_limits(gl, &fragment_shader)?;
        check_program_limits(gl, &vertex_shader, &fragment_shader)?;

        // Compute uniform values.
        let mut rnd = Random::new(self.parameters.seed);
        let unified_uniforms = compute_unified_uniforms(&vertex_shader, &fragment_shader);
        let uniforms: Vec<UniformAssignment> = compute_uniform_values(&mut rnd, &unified_uniforms);

        let vertex_arrays = Self::generate_vertex_arrays(&vertex_shader)?;
        let indices = Self::generate_indices();

        // Create textures.
        let mut tex_2d_units = BTreeSet::new();
        let mut tex_cube_units = BTreeSet::new();
        for uniform in &uniforms {
            if !uniform.type_.is_sampler() {
                continue;
            }

            let unit_ndx = uniform.storage.get_value_const(&uniform.type_).component(0).as_int();

            match uniform.type_.base_type() {
                Type::Sampler2D => {
                    tex_2d_units.insert(unit_ndx);
                }
                Type::SamplerCube => {
                    tex_cube_units.insert(unit_ndx);
                }
                _ => {
                    return Err(TestError::InternalError(
                        "DE_ASSERT: unexpected sampler type".to_string(),
                    ));
                }
            }
        }
        let tex_2d = if tex_2d_units.is_empty() {
            None
        } else {
            Some(make_tex_2d(context)?)
        };
        let tex_cube = if tex_cube_units.is_empty() {
            None
        } else {
            Some(make_tex_cube(context)?)
        };

        // Compile program.
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(vertex_shader.get_source(), fragment_shader.get_source()),
        );
        if !program.is_ok() {
            return Ok(TestStatus::fail("Failed to compile shader"));
        }

        // Compute random viewport.
        let mut rnd = Random::new(self.parameters.seed);
        let render_target = context.render_target();
        let viewport_width = VIEWPORT_WIDTH.min(render_target.width);
        let viewport_height = VIEWPORT_HEIGHT.min(render_target.height);
        let viewport_x = rnd.get_int(0, render_target.width - viewport_width);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_height);
        let has_alpha = render_target.alpha_bits > 0;
        let format = TextureFormat::new(
            if has_alpha {
                ChannelOrder::RGBA
            } else {
                ChannelOrder::RGB
            },
            ChannelType::UNORM_INT8,
        );
        let mut rendered = TextureLevel::new(format, viewport_width as u32, viewport_height as u32, 1)?;
        let mut reference = TextureLevel::new(format, viewport_width as u32, viewport_height as u32, 1)?;

        // SAFETY: a current context; every pointer handed to GL below (client-side vertex arrays, the
        // index array, uniform data) stays alive until after `glFlush`, and nothing is read back from them.
        unsafe {
            gl.use_program(program.program());
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);

            // Set up attributes.
            for array in &vertex_arrays {
                let c_name = CString::new(array.name.as_str()).map_err(|e| TestError::InternalError(e.to_string()))?;
                let location = gl.get_attrib_location(program.program(), c_name.as_ptr());

                if location >= 0 {
                    gl.vertex_attrib_pointer(
                        location as u32,
                        array.num_components,
                        glw::GL_FLOAT,
                        glw::FALSE,
                        0,
                        array.vertices.as_ptr().cast(),
                    );
                    gl.enable_vertex_attrib_array(location as u32);
                }
            }
        }
        glu::expect_no_error(gl, "After attribute setup")?;

        // Uniforms.
        for uniform in &uniforms {
            let c_name = CString::new(uniform.name.as_str()).map_err(|e| TestError::InternalError(e.to_string()))?;
            // SAFETY: a current context and a NUL-terminated name.
            let location = unsafe { gl.get_uniform_location(program.program(), c_name.as_ptr()) };

            if location >= 0 {
                set_uniform_value(gl, location, &uniform.type_, &uniform.storage)?;
            }
        }
        glu::expect_no_error(gl, "After uniform setup")?;

        // Textures.
        if let Some(tex) = &tex_2d {
            for &unit_ndx in &tex_2d_units {
                // SAFETY: a current context.
                unsafe {
                    gl.active_texture(glw::GL_TEXTURE0 + unit_ndx as u32);
                    gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
                }
            }
        }
        glu::expect_no_error(gl, "After 2D texture setup")?;

        if let Some(tex) = &tex_cube {
            for &unit_ndx in &tex_cube_units {
                // SAFETY: a current context.
                unsafe {
                    gl.active_texture(glw::GL_TEXTURE0 + unit_ndx as u32);
                    gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex.gl_texture());
                }
            }
        }
        glu::expect_no_error(gl, "After cubemap setup")?;

        // Draw and read.
        // SAFETY: see above; `indices` outlives the call.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_width, viewport_height);
            gl.draw_elements(
                glw::GL_TRIANGLES,
                indices.len() as i32,
                glw::GL_UNSIGNED_SHORT,
                indices.as_ptr().cast(),
            );
            gl.flush();
        }
        glu::expect_no_error(gl, "Draw")?;

        // Render reference while GPU is doing work.
        {
            let mut vertex_names = NameAllocator::new();
            let mut fragment_names = NameAllocator::new();
            let vertex_vars = VariableManager::from_variables(&mut vertex_names, vertex_shader.take_variables());
            let fragment_vars = VariableManager::from_variables(&mut fragment_names, fragment_shader.take_variables());
            let sampler = map_gl_sampler(
                TEXTURE_WRAP_S,
                TEXTURE_WRAP_T,
                TEXTURE_WRAP_T,
                TEXTURE_MIN_FILTER,
                TEXTURE_MAG_FILTER,
                LodRange::Minified,
            )?;
            let uniform_refs: Vec<(&str, &VariableType, &ValueStorage)> = uniforms
                .iter()
                .map(|u| (u.name.as_str(), &u.type_, &u.storage))
                .collect();

            let mut executor = ProgramExecutor::new(reference.get_access(), GRID_WIDTH, GRID_HEIGHT);

            if let Some(tex) = &tex_2d {
                for &unit_ndx in &tex_2d_units {
                    executor.set_texture_2d(unit_ndx, tex.ref_texture(), sampler);
                }
            }
            if let Some(tex) = &tex_cube {
                for &unit_ndx in &tex_cube_units {
                    executor.set_texture_cube(unit_ndx, tex.ref_texture(), sampler);
                }
            }

            executor.execute(
                &vertex_vars,
                &fragment_vars,
                &mut vertex_shader,
                &mut fragment_shader,
                &uniform_refs,
            );
        }

        if has_alpha {
            glu::read_pixels(
                &context.render_context,
                viewport_x,
                viewport_y,
                &mut rendered.get_access(),
            )?;
        } else {
            // Read as GL_RGBA8, then drop alpha.
            let rgba = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
            let mut read_buf = TextureLevel::new(rgba, viewport_width as u32, viewport_height as u32, 1)?;
            glu::read_pixels(
                &context.render_context,
                viewport_x,
                viewport_y,
                &mut read_buf.get_access(),
            )?;
            glu::expect_no_error(gl, "Read pixels")?;

            let src = read_buf.data();
            let mut dst_access = rendered.get_access();
            #[allow(clippy::chunks_exact_to_as_chunks)] // `as_chunks` is nightly-unstable
            for (dst, src) in dst_access.raw_mut().chunks_exact_mut(3).zip(src.chunks_exact(4)) {
                dst.copy_from_slice(&src[..3]);
            }
        }

        // Compare.
        const THRESHOLD: f32 = 0.02;
        let images_ok =
            fuzzy_compare_ok(&reference.get_const_access(), &rendered.get_const_access(), THRESHOLD).unwrap_or(false);

        if images_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}
