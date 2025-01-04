// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fUniformLocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `negative` sub-group comes out of `shaders/es3{1,2}/uniform_location.test`, which
// `scripts/gen_shader_library.py` parsed ahead of time into `src/generated/shader_library/`.
//
// `glu::Texture2D` has no counterpart either - the only texture these cases need is a
// 16x16 image of one constant colour, which is one `glTexImage2D` from a `Vec<u8>`.

use std::sync::Arc;

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::glu::{
    self, Context, DataType, Precision, ProgramSources, ShaderProgram, StructType, TestCase, TestCaseGroup, Texture,
    VarType, VarTypeComponent,
};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::random::{de_int32_hash, de_string_hash};
use crate::tcu::{Random, Surface, TestOutcome, TestStatus};

/// `UniformLocationCase::RENDER_SIZE`
const RENDER_SIZE: i32 = 16;

/// The largest location any case asks for, and the cap upstream's random draws use.
const MAX_LOCATIONS: i32 = 1024;

/// `UniformInfo::ShaderStage` as a bit mask.
const STAGE_VERTEX: u32 = 1 << 0;
const STAGE_FRAGMENT: u32 = 1 << 1;

/// `UniformInfo`
#[derive(Clone)]
struct UniformInfo {
    ty: VarType,
    /// Declarations with and without layout qualifiers, which is what linkage is tested
    /// with.
    declare_location: u32,
    layout_location: u32,
    check_location: u32,
    /// `-1` for unset.
    location: i32,
}

/// `createVarType` - bools take no precision qualifier, everything else is highp.
fn create_var_type(ty: DataType) -> VarType {
    VarType::basic(
        ty,
        if ty.is_bool_or_bvec() {
            None
        } else {
            Some(Precision::HighP)
        },
    )
}

/// `getDataTypeSamplerSampleType`, restricted to the sampler types these cases use.
fn sampler_sample_type(ty: DataType) -> DataType {
    match ty {
        DataType::IntSampler2D => DataType::IntVec4,
        DataType::UintSampler2D => DataType::UintVec4,
        _ => DataType::FloatVec4,
    }
}

/// `UniformLocationCase::getExpectedValue` - a (hopefully) unique value for a uniform.
/// Multi-component types get one value for the whole thing. The range is `[0,1]` for
/// floats, `[0,127]` for ints, `[0,254]` for uints and `0`/`1` for booleans; samplers
/// are treated as the type they return.
fn expected_value(ty: DataType, id: i32, name: &str) -> f32 {
    let hash = de_string_hash(name).wrapping_add(de_int32_hash(id));
    let adjusted = if ty.is_sampler() { sampler_sample_type(ty) } else { ty };

    if adjusted.is_int_or_ivec() {
        (hash % 128) as f32
    } else if adjusted.is_uint_or_uvec() {
        (hash % 255) as f32
    } else if adjusted.is_float_or_vec() {
        (hash % 255) as f32 / 255.0
    } else {
        debug_assert!(adjusted.is_bool_or_bvec());
        (hash % 2) as f32
    }
}

/// `getUniformName`
fn uniform_name(ndx: usize, ty: &VarType, path: &[VarTypeComponent]) -> String {
    glu::var_type::type_access_name(&format!("uni{ndx}"), ty, path)
}

/// `getFirstComponentName` - the trailing subscripts that reduce a vector or matrix to
/// one scalar, so `verify(float(...))` has something it can take.
fn first_component_name(ty: &VarType) -> &'static str {
    let basic = ty.basic_type();
    if basic.is_vector() {
        "[0]"
    } else if basic.is_matrix() {
        "[0][0]"
    } else {
        ""
    }
}

/// `shuffledRange` - `[from, to)` in a shuffled order.
fn shuffled_range(from: i32, to: i32, seed: u32) -> Vec<i32> {
    let mut retval: Vec<i32> = (from..to).collect();
    let mut rng = Random::new(seed);
    rng.shuffle(&mut retval);
    retval
}

/// `getTextureFormat` - a four-channel, eight-bits-each format the sampler can read.
fn texture_format(sampler_type: DataType) -> GLenum {
    match sampler_type {
        DataType::IntSampler2D => glw::GL_RGBA8I,
        DataType::UintSampler2D => glw::GL_RGBA8UI,
        _ => glw::GL_RGBA8,
    }
}

struct UniformLocationCase {
    name: String,
    uniform_info: Vec<UniformInfo>,
    /// `MaxUniformLocationCase` puts the first uniform at `GL_MAX_UNIFORM_LOCATIONS - 1`
    /// instead of where the spec says.
    use_max_location: bool,
}

/// `UniformLocationCase::genShaderSources`
fn gen_shader_sources(uniform_list: &[UniformInfo]) -> ProgramSources {
    let mut vert_decl = String::from(
        "#version 310 es\n\
         precision highp float;\n\
         precision highp int;\n\
         float verify(float val, float ref) { return float(abs(val-ref) < 0.05); }\n\n\
         in highp vec4 a_position;\n\
         out highp vec4 v_color;\n",
    );
    let mut frag_decl = String::from(
        "#version 310 es\n\n\
         precision highp float;\n\
         precision highp int;\n\
         float verify(float val, float ref) { return float(abs(val-ref) < 0.05); }\n\n\
         in highp vec4 v_color;\n\
         layout(location = 0) out mediump vec4 o_color;\n\n",
    );
    let mut vert_main = String::from("void main()\n{\n    gl_Position = a_position;\n    v_color = vec4(1.0);\n");
    let mut frag_main = String::from("void main()\n{\n    o_color = v_color;\n");

    // Struct prototypes are shared between uniforms, and each must be declared once.
    let mut declared_structs: Vec<*const StructType> = Vec::new();

    for (uniform_ndx, uniform_info) in uniform_list.iter().enumerate() {
        let declare_in_vert = uniform_info.declare_location & STAGE_VERTEX != 0;
        let declare_in_frag = uniform_info.declare_location & STAGE_FRAGMENT != 0;
        let layout_in_vert = uniform_info.layout_location & STAGE_VERTEX != 0;
        let layout_in_frag = uniform_info.layout_location & STAGE_FRAGMENT != 0;
        let check_in_vert = uniform_info.check_location & STAGE_VERTEX != 0;
        let check_in_frag = uniform_info.check_location & STAGE_FRAGMENT != 0;

        let layout = if uniform_info.location >= 0 {
            format!("layout(location = {}) ", uniform_info.location)
        } else {
            String::new()
        };
        let uni_name = format!("uni{uniform_ndx}");

        // Struct definitions.
        if uniform_info.ty.is_struct_type() {
            let struct_type = uniform_info.ty.struct_ptr();
            let key = Arc::as_ptr(struct_type);
            if !declared_structs.contains(&key) {
                if declare_in_vert {
                    vert_decl.push_str(&glu::declare_struct(struct_type, 0));
                    vert_decl.push_str(";\n");
                }
                if declare_in_frag {
                    frag_decl.push_str(&glu::declare_struct(struct_type, 0));
                    frag_decl.push_str(";\n");
                }
                declared_structs.push(key);
            }
        }

        if declare_in_vert {
            vert_decl.push_str(&format!(
                "uniform {}{};\n",
                if layout_in_vert { layout.as_str() } else { "" },
                glu::declare_var(&uniform_info.ty, &uni_name, 0)
            ));
        }
        if declare_in_frag {
            frag_decl.push_str(&format!(
                "uniform {}{};\n",
                if layout_in_frag { layout.as_str() } else { "" },
                glu::declare_var(&uniform_info.ty, &uni_name, 0)
            ));
        }

        // Anything that needs to be done for each enclosed primitive type.
        for (sub_type_index, path) in glu::var_type::basic_type_paths(&uniform_info.ty).iter().enumerate() {
            let sub_type = glu::var_type::get_var_type(&uniform_info.ty, path);
            let scalar_type = sub_type.basic_type().scalar_type();
            let type_name = scalar_type.name();
            let id = if uniform_info.location >= 0 {
                uniform_info.location + sub_type_index as i32
            } else {
                -1
            };
            let expect_value = format!("{:.3}", expected_value(scalar_type, id, type_name));
            let access = glu::var_type::type_access_name(&uni_name, &uniform_info.ty, path);

            let expr = if scalar_type.is_sampler() {
                format!("float( texture({access}, vec2(0.5)).r)")
            } else {
                format!("float({access}{})", first_component_name(&sub_type))
            };

            if check_in_vert {
                vert_main.push_str(&format!("    v_color.rgb *= verify({expr}, {expect_value});\n"));
            }
            if check_in_frag {
                frag_main.push_str(&format!("    o_color.rgb *= verify({expr}, {expect_value});\n"));
            }
        }
    }

    vert_main.push_str("}\n");
    frag_main.push_str("}\n");

    ProgramSources::vtx_frag(vert_decl + &vert_main, frag_decl + &frag_main)
}

impl UniformLocationCase {
    /// `UniformLocationCase::verifyLocations`
    fn verify_locations(
        &self,
        context: &Context,
        program: &ShaderProgram,
        uniform_list: &[UniformInfo],
    ) -> Result<(), TestStatus> {
        let gl = context.gl();
        let program_id = program.program();
        let mut used_locations: Vec<i32> = Vec::new();

        if !program.is_ok() {
            log::warn!("ERROR: shader failed to compile/link");
            return Err(TestStatus::fail("Shader failed to compile/link"));
        }

        for (uniform_ndx, uniform_info) in uniform_list.iter().enumerate() {
            for (sub_type_index, path) in glu::var_type::basic_type_paths(&uniform_info.ty).iter().enumerate() {
                let name = uniform_name(uniform_ndx, &uniform_info.ty, path);
                let c_name = std::ffi::CString::new(name.clone()).expect("generated name has no interior nul");
                // SAFETY: the program linked; an absent name answers -1.
                let got_loc = unsafe { gl.get_uniform_location(program_id, c_name.as_ptr()) };
                let expect_loc = if uniform_info.location >= 0 {
                    uniform_info.location + sub_type_index as i32
                } else {
                    -1
                };

                if expect_loc >= 0 {
                    if uniform_info.check_location == 0 && got_loc == -1 {
                        continue;
                    }

                    if got_loc != expect_loc {
                        log::warn!(
                            "ERROR: found uniform {name} in location {got_loc} when it should have been in {expect_loc}"
                        );
                        return Err(TestStatus::fail("Incorrect uniform location"));
                    }

                    if used_locations.contains(&expect_loc) {
                        log::warn!("ERROR: expected uniform {name} in location {got_loc} but it has already been used");
                        return Err(TestStatus::fail("Overlapping uniform location"));
                    }

                    used_locations.push(expect_loc);
                } else if got_loc >= 0 {
                    if used_locations.contains(&got_loc) {
                        log::warn!("ERROR: found uniform {name} in location {got_loc} which has already been used");
                        return Err(TestStatus::fail("Overlapping uniform location"));
                    }

                    used_locations.push(got_loc);
                }
            }
        }

        Ok(())
    }

    /// `UniformLocationCase::createTexture` - a 16x16 image whose red channel is the
    /// value the shader is going to compare against, bound to `binding`.
    fn create_texture<'gl>(
        &self,
        gl: &'gl glw::Functions,
        sampler_type: DataType,
        red_channel_value: f32,
        binding: i32,
    ) -> Texture<'gl> {
        const SIZE: i32 = 16;
        let internal_format = texture_format(sampler_type);
        let (format, data_type, texel) = match internal_format {
            glw::GL_RGBA8I => (
                glw::GL_RGBA_INTEGER,
                glw::GL_BYTE,
                [red_channel_value as i32 as u8, 0, 0, 0],
            ),
            glw::GL_RGBA8UI => (
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_BYTE,
                [red_channel_value as i32 as u8, 0, 0, 0],
            ),
            _ => (
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                [(red_channel_value * 255.0 + 0.5) as u8, 0, 0, 255],
            ),
        };

        let data: Vec<u8> = texel.iter().copied().cycle().take((SIZE * SIZE * 4) as usize).collect();
        let tex = Texture::new(gl);

        // SAFETY: the upload covers exactly `SIZE * SIZE` four-byte texels.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0 + binding as GLenum);
            gl.bind_texture(glw::GL_TEXTURE_2D, tex.get());
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal_format as GLint,
                SIZE,
                SIZE,
                0,
                format,
                data_type,
                data.as_ptr().cast(),
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
        }

        tex
    }

    /// `UniformLocationCase::render`
    fn render(&self, context: &Context, program: &ShaderProgram, uniform_list: &[UniformInfo]) {
        let gl = context.gl();
        let program_id = program.program();

        // Vertex data.
        const POSITION: [f32; 16] = [
            -1.0, -1.0, 0.1, 1.0, -1.0, 1.0, 0.1, 1.0, 1.0, -1.0, 0.1, 1.0, 1.0, 1.0, 0.1, 1.0,
        ];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        // Buffers to feed to the GPU; only the first element is relevant, since the
        // others are never verified.
        let mut float_buf = [0.0f32; 16];
        let mut int_buf = [0i32; 4];
        let mut uint_buf = [0u32; 4];

        // The textures have to outlive the draw.
        let mut tex_list = Vec::new();

        // SAFETY: every uniform upload below matches the entry point's element count,
        // and the draw reads from client arrays that outlive it.
        unsafe {
            let pos_loc = gl.get_attrib_location(program_id, c"a_position".as_ptr());
            gl.use_program(program_id);

            // Set uniforms.
            for (uniform_ndx, uniform_info) in uniform_list.iter().enumerate() {
                let mut expected_location = uniform_info.location;

                for path in glu::var_type::basic_type_paths(&uniform_info.ty) {
                    let ty = glu::var_type::get_var_type(&uniform_info.ty, &path);
                    let name = uniform_name(uniform_ndx, &uniform_info.ty, &path);
                    let c_name = std::ffi::CString::new(name.clone()).expect("generated name has no interior nul");
                    let got_loc = gl.get_uniform_location(program_id, c_name.as_ptr());
                    let scalar_type = ty.basic_type().scalar_type();
                    let value = expected_value(scalar_type, expected_location, scalar_type.name());

                    if scalar_type.is_sampler() {
                        let binding = tex_list.len() as i32;
                        tex_list.push(self.create_texture(gl, scalar_type, value, binding));
                        gl.uniform_1i(got_loc, binding);
                    } else if got_loc >= 0 {
                        float_buf[0] = value;
                        int_buf[0] = value as i32;
                        uint_buf[0] = value as u32;

                        log::info!("Set uniform {name} in location {got_loc} to {value}");
                        set_uniform(gl, got_loc, ty.basic_type(), &float_buf, &int_buf, &uint_buf);
                    }

                    expected_location += i32::from(expected_location >= 0);
                }
            }

            gl.enable_vertex_attrib_array(pos_loc as u32);
            gl.vertex_attrib_pointer(
                pos_loc as u32,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                POSITION.as_ptr().cast(),
            );
            gl.draw_elements(
                glw::GL_TRIANGLES,
                INDICES.len() as i32,
                glw::GL_UNSIGNED_SHORT,
                INDICES.as_ptr().cast(),
            );
            gl.disable_vertex_attrib_array(pos_loc as u32);
        }
    }
}

/// The `switch (type.getBasicType())` in `UniformLocationCase::render`.
///
/// # Safety
/// `location` must name a uniform of `basic_type` in the program in use.
unsafe fn set_uniform(
    gl: &glw::Functions,
    location: GLint,
    basic_type: DataType,
    float_buf: &[f32; 16],
    int_buf: &[i32; 4],
    uint_buf: &[u32; 4],
) {
    use DataType::*;
    let (f, i, u) = (float_buf.as_ptr(), int_buf.as_ptr(), uint_buf.as_ptr());

    // SAFETY: the caller's contract, and each entry point is the one named by the type.
    unsafe {
        match basic_type {
            Float => gl.uniform_1fv(location, 1, f),
            FloatVec2 => gl.uniform_2fv(location, 1, f),
            FloatVec3 => gl.uniform_3fv(location, 1, f),
            FloatVec4 => gl.uniform_4fv(location, 1, f),

            Int => gl.uniform_1iv(location, 1, i),
            IntVec2 => gl.uniform_2iv(location, 1, i),
            IntVec3 => gl.uniform_3iv(location, 1, i),
            IntVec4 => gl.uniform_4iv(location, 1, i),

            Uint => gl.uniform_1uiv(location, 1, u),
            UintVec2 => gl.uniform_2uiv(location, 1, u),
            UintVec3 => gl.uniform_3uiv(location, 1, u),
            UintVec4 => gl.uniform_4uiv(location, 1, u),

            Bool => gl.uniform_1iv(location, 1, i),
            BoolVec2 => gl.uniform_2iv(location, 1, i),
            BoolVec3 => gl.uniform_3iv(location, 1, i),
            BoolVec4 => gl.uniform_4iv(location, 1, i),

            FloatMat2 => gl.uniform_matrix_2fv(location, 1, glw::FALSE, f),
            FloatMat2x3 => gl.uniform_matrix_2x_3fv(location, 1, glw::FALSE, f),
            FloatMat2x4 => gl.uniform_matrix_2x_4fv(location, 1, glw::FALSE, f),
            FloatMat3x2 => gl.uniform_matrix_3x_2fv(location, 1, glw::FALSE, f),
            FloatMat3 => gl.uniform_matrix_3fv(location, 1, glw::FALSE, f),
            FloatMat3x4 => gl.uniform_matrix_3x_4fv(location, 1, glw::FALSE, f),
            FloatMat4x2 => gl.uniform_matrix_4x_2fv(location, 1, glw::FALSE, f),
            FloatMat4x3 => gl.uniform_matrix_4x_3fv(location, 1, glw::FALSE, f),
            FloatMat4 => gl.uniform_matrix_4fv(location, 1, glw::FALSE, f),

            _ => unreachable!("uniform type outside the set these cases generate"),
        }
    }
}

/// `UniformLocationCase::verifyResult` - the shader multiplies white by one `verify()`
/// per uniform, so anything but white means at least one comparison failed.
fn verify_result(rendered: &Surface) -> bool {
    const THRESHOLD: f32 = 0.1;

    for y in 0..rendered.get_height() {
        for x in 0..rendered.get_width() {
            let pixel = rendered.get_pixel(x, y).to_vec().m_data;
            if pixel.iter().any(|c| (c - 1.0).abs() > THRESHOLD) {
                return false;
            }
        }
    }

    true
}

impl TestCase for UniformLocationCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `UniformLocationCase::run`, plus `MaxUniformLocationCase::iterate`'s override.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut uniform_list = self.uniform_info.clone();

        if self.use_max_location {
            let mut max_location = MAX_LOCATIONS;
            // SAFETY: one GLint out.
            unsafe { gl.get_integerv(glw::GL_MAX_UNIFORM_LOCATIONS, &mut max_location) };
            uniform_list[0].location = max_location - 1;
        }

        let program = ShaderProgram::new(gl, &gen_shader_sources(&uniform_list));

        if let Err(status) = self.verify_locations(context, &program, &uniform_list) {
            return Ok(status);
        }

        // `gls::TextureTestUtil::RandomViewport` - a `RENDER_SIZE` square placed at
        // random inside the render target, so a case cannot depend on where it lands.
        let render_target = context.render_target();
        let width = RENDER_SIZE.min(render_target.width);
        let height = RENDER_SIZE.min(render_target.height);
        let mut rnd = Random::new(de_string_hash(&self.name));
        let x = rnd.get_int(0, render_target.width - width);
        let y = rnd.get_int(0, render_target.height - height);

        // SAFETY: setting clear colour, clearing and setting the viewport need only a
        // current context.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.viewport(x, y, width, height);
        }

        self.render(context, &program, &uniform_list);

        let mut rendered = Surface::new(width, height);
        glu::read_pixels(&context.render_context, x, y, &mut rendered.get_access())?;
        glu::expect_no_error(gl, "error in readPixels")?;

        Ok(if verify_result(&rendered) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Shader produced incorrect result")
        })
    }
}

fn case(name: String, uniform_info: Vec<UniformInfo>, use_max_location: bool) -> Box<dyn TestCase> {
    Box::new(UniformLocationCase {
        name,
        uniform_info,
        use_max_location,
    })
}

/// `UniformLocationTests::init`'s `primitiveTypes`
const PRIMITIVE_TYPES: [DataType; 28] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
    DataType::Sampler2D,
    DataType::IntSampler2D,
    DataType::UintSampler2D,
];

/// The last index `struct`/`link` draw a member type from - everything up to `mat4`,
/// which leaves the three sampler types out.
const MAX_PRIMITIVE_TYPE_NDX: i32 = PRIMITIVE_TYPES.len() as i32 - 4;

const CHECK_STAGES: [(u32, &str); 2] = [(STAGE_VERTEX, "vertex"), (STAGE_FRAGMENT, "fragment")];

/// `UniformLocationTests::init`. The base seed is upstream's `--deqp-base-seed`, which
/// defaults to 0 and which this port has no switch for.
pub fn create_tests() -> TestCaseGroup {
    const BASE_SEED: u32 = 0;
    let mut group = TestCaseGroup::new("uniform_location");

    // .basic - primitive type cases with trivial linkage.
    {
        let mut sub = TestCaseGroup::new("basic");
        let mut rng = Random::new(BASE_SEED + 0x1001);

        for ty in PRIMITIVE_TYPES {
            for (stage, stage_name) in CHECK_STAGES {
                let name = format!("{}_{stage_name}", ty.name());
                let uniform = UniformInfo {
                    ty: create_var_type(ty),
                    declare_location: stage,
                    layout_location: stage,
                    check_location: stage,
                    location: rng.get_int(0, MAX_LOCATIONS - 1),
                };
                sub.add_child(case(name, vec![uniform], false));
            }
        }

        group.add_child(sub);
    }

    // .array
    {
        let mut sub = TestCaseGroup::new("array");
        let mut rng = Random::new(BASE_SEED + 0x2001);

        for ty in PRIMITIVE_TYPES {
            for (stage, stage_name) in CHECK_STAGES {
                let name = format!("{}_{stage_name}", ty.name());
                let uniform = UniformInfo {
                    ty: VarType::array(create_var_type(ty), 8),
                    declare_location: stage,
                    layout_location: stage,
                    check_location: stage,
                    location: rng.get_int(0, MAX_LOCATIONS - 1 - 8),
                };
                sub.add_child(case(name, vec![uniform], false));
            }
        }

        group.add_child(sub);
    }

    // .nested_array
    {
        let mut sub = TestCaseGroup::new("nested_array");
        let mut rng = Random::new(BASE_SEED + 0x3001);

        for ty in PRIMITIVE_TYPES {
            for (stage, stage_name) in CHECK_STAGES {
                let name = format!("{}_{stage_name}", ty.name());
                // Stay comfortably within the minimum maximum uniform component count
                // (896 in the fragment stage) and sampler count with all types.
                let array_size = if ty.scalar_size() > 4 || ty.is_sampler() { 3 } else { 7 };
                let uniform = UniformInfo {
                    ty: VarType::array(VarType::array(create_var_type(ty), array_size), array_size),
                    declare_location: stage,
                    layout_location: stage,
                    check_location: stage,
                    location: rng.get_int(0, MAX_LOCATIONS - 1 - array_size * array_size),
                };
                sub.add_child(case(name, vec![uniform], false));
            }
        }

        group.add_child(sub);
    }

    // .struct - random contents and declaration location.
    {
        let mut sub = TestCaseGroup::new("struct");
        let mut rng = Random::new(BASE_SEED + 0x4001);

        for case_ndx in 0..16 {
            let layout_loc = rng.get_uint32() & 0x3;
            let declare_loc = (rng.get_uint32() & 0x3) | layout_loc;
            let verify_loc = (rng.get_uint32() & 0x3) & declare_loc;
            let location = if layout_loc != 0 {
                rng.get_int(0, MAX_LOCATIONS - 1 - 5)
            } else {
                -1
            };

            let mut struct_proto = StructType::new("S");
            for member_name in ["a", "b", "c", "d", "e"] {
                let ty = PRIMITIVE_TYPES[rng.get_int(0, MAX_PRIMITIVE_TYPE_NDX) as usize];
                struct_proto.add_member(member_name, create_var_type(ty));
            }

            let uniform = UniformInfo {
                ty: VarType::structure(&Arc::new(struct_proto)),
                declare_location: declare_loc,
                layout_location: layout_loc,
                check_location: verify_loc,
                location,
            };
            sub.add_child(case(format!("case_{case_ndx}"), vec![uniform], false));
        }

        group.add_child(sub);
    }

    // .nested_struct
    {
        let mut sub = TestCaseGroup::new("nested_struct");
        let mut rng = Random::new(BASE_SEED + 0x5001);

        for case_ndx in 0..16 {
            let base_loc = rng.get_int(0, MAX_LOCATIONS - 1 - 60);

            // Structs have to be added in the order of their declaration.
            let layout_locs: [u32; 4] = std::array::from_fn(|_| rng.get_uint32() & 0x3);
            let temp_decl: [u32; 4] = std::array::from_fn(|i| (rng.get_uint32() & 0x3) | layout_locs[i]);

            // A component struct has to be declared if anything using it is declared.
            let declare_locs = [
                temp_decl[0] | temp_decl[1] | temp_decl[2] | temp_decl[3],
                temp_decl[1] | temp_decl[2] | temp_decl[3],
                temp_decl[2] | temp_decl[3],
                temp_decl[3],
            ];
            let verify_locs: [u32; 4] = std::array::from_fn(|i| rng.get_uint32() & 0x3 & declare_locs[i]);

            let mut type0 = StructType::new("Type0");
            let mut type1 = StructType::new("Type1");
            let mut type2 = StructType::new("Type2");
            let mut type3 = StructType::new("Type3");

            for member_name in ["a", "b", "c", "d", "e"] {
                let ty = PRIMITIVE_TYPES[rng.get_int(0, MAX_PRIMITIVE_TYPE_NDX) as usize];
                type0.add_member(member_name, create_var_type(ty));
            }
            for member_name in ["a", "b", "c", "d", "e"] {
                let ty = PRIMITIVE_TYPES[rng.get_int(0, MAX_PRIMITIVE_TYPE_NDX) as usize];
                type1.add_member(member_name, create_var_type(ty));
            }

            let type0 = Arc::new(type0);
            let type1 = Arc::new(type1);

            type2.add_member("a", VarType::structure(&type0));
            type2.add_member("b", VarType::structure(&type1));
            type2.add_member(
                "c",
                create_var_type(PRIMITIVE_TYPES[rng.get_int(0, MAX_PRIMITIVE_TYPE_NDX) as usize]),
            );
            let type2 = Arc::new(type2);

            type3.add_member("a", VarType::structure(&type2));
            let type3 = Arc::new(type3);

            let types = [&type0, &type1, &type2, &type3];
            let base_locs = [base_loc, base_loc + 5, base_loc + 16, base_loc + 27];

            let config: Vec<UniformInfo> = (0..4)
                .map(|i| UniformInfo {
                    ty: VarType::structure(types[i]),
                    declare_location: declare_locs[i],
                    layout_location: layout_locs[i],
                    check_location: verify_locs[i],
                    location: if layout_locs[i] != 0 { base_locs[i] } else { -1 },
                })
                .collect();

            sub.add_child(case(format!("case_{case_ndx}"), config, false));
        }

        group.add_child(sub);
    }

    // .min_max
    {
        let mut sub = TestCaseGroup::new("min_max");

        for ty in PRIMITIVE_TYPES {
            for (stage, stage_name) in CHECK_STAGES {
                let name = format!("{}_{stage_name}", ty.name());
                let uniform = UniformInfo {
                    ty: create_var_type(ty),
                    declare_location: stage,
                    layout_location: stage,
                    check_location: stage,
                    location: 0,
                };
                sub.add_child(case(format!("{name}_min"), vec![uniform.clone()], false));
                sub.add_child(case(format!("{name}_max"), vec![uniform], true));
            }
        }

        group.add_child(sub);
    }

    // .link - location specified independently from use.
    {
        let mut sub = TestCaseGroup::new("link");
        let mut rng = Random::new(BASE_SEED + 0x82e1);

        for case_ndx in 0..10 {
            let mut locations = shuffled_range(0, MAX_LOCATIONS, (0x1234 + case_ndx * 100) as u32);
            let mut config = Vec::new();

            for _ in 0..32 {
                let layout_loc = rng.get_uint32() & 0x3;
                let declare_loc = (rng.get_uint32() & 0x3) | layout_loc;
                let verify_loc = (rng.get_uint32() & 0x3) & declare_loc;
                let ty = PRIMITIVE_TYPES[rng.get_int(0, MAX_PRIMITIVE_TYPE_NDX) as usize];

                config.push(UniformInfo {
                    ty: create_var_type(ty),
                    declare_location: declare_loc,
                    layout_location: layout_loc,
                    check_location: verify_loc,
                    location: if layout_loc != 0 {
                        *locations.last().expect("32 draws out of 1024")
                    } else {
                        -1
                    },
                });
                locations.pop();
            }

            sub.add_child(case(format!("case_{case_ndx}"), config, false));
        }

        group.add_child(sub);
    }

    // .negative
    {
        let mut sub = TestCaseGroup::new("negative");
        sub.add_child(create_group("es31", &lib::es31_uniform_location::ROOT));
        sub.add_child(create_group("es32", &lib::es32_uniform_location::ROOT));
        group.add_child(sub);
    }

    group
}
