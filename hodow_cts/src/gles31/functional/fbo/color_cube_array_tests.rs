// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFboColorbufferTests.cpp (FboColorTexCubeArrayCase)
//   modules/gles31/functional/es31fFboTestUtil.cpp (TextureCubeArrayShader)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// The `color.texcubearray` group (36 cases). Same narrowing as `gles3`'s `TextureNdShader`: the program is
// moved into the context on `create_program`, so `setLayer`/`setFace`/`setTexScaleBias`/`setUniforms` are the
// free function `set_cube_array_uniforms` taking the program id. Fragments sample at lod 0. The GLSL version
// of the shader source (310 es + extension, or 320 es) is chosen in `pre_check` and remembered in an atomic.

use std::sync::atomic::{AtomicBool, Ordering};

use crate::gles3::functional::fbo::fbo_test_case::{
    FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status,
};
use crate::gles3::functional::fbo::fbo_test_util::{
    ChannelClass, Texture2DShader, channel_class, get_format_name, get_format_threshold_gl, get_fragment_output_type,
    read_pixels,
};
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::reference_context::ResolvedSampler;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, UniformValue, pdec};
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::{CubeFace, TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{Random, Surface, TestError, de_string_hash};

const MIN_THRESHOLD: [u8; 4] = [12, 12, 12, 12];

/// `generateRandomColor`
fn generate_random_color(random: &mut Random) -> [f32; 4] {
    let r = random.get_float();
    let g = random.get_float();
    let b = random.get_float();
    [r, g, b, 1.0]
}

/// `getCubeFaceFromNdx`
fn get_cube_face_from_ndx(ndx: i32) -> CubeFace {
    match ndx {
        0 => CubeFace::PositiveX,
        1 => CubeFace::NegativeX,
        2 => CubeFace::PositiveY,
        3 => CubeFace::NegativeY,
        4 => CubeFace::PositiveZ,
        5 => CubeFace::NegativeZ,
        _ => panic!("invalid cube face index {ndx}"),
    }
}

/// `glu::isGLInternalColorFormatFilterable`, for the formats this group's table uses.
fn is_gl_internal_color_format_filterable(format: GLenum) -> bool {
    matches!(
        format,
        glw::GL_R8
            | glw::GL_RG8
            | glw::GL_RGB8
            | glw::GL_RGB565
            | glw::GL_RGBA4
            | glw::GL_RGB5_A1
            | glw::GL_RGBA8
            | glw::GL_RGB10_A2
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_R16F
            | glw::GL_RG16F
            | glw::GL_RGB16F
            | glw::GL_RGBA16F
            | glw::GL_R11F_G11F_B10F
    )
}

/// `glu::getSamplerCubeArrayType`
fn get_sampler_cube_array_type(format: crate::tcu::texture::TextureFormat) -> DataType {
    match channel_class(format.type_) {
        ChannelClass::Float | ChannelClass::Fixed => DataType::SamplerCubeArray,
        ChannelClass::Uint => DataType::UintSamplerCubeArray,
        ChannelClass::Int => DataType::IntSamplerCubeArray,
    }
}

fn read_attrib(inputs: &[VertexAttrib], index: usize, packet: &VertexPacket) -> Vec4 {
    let mut v = Vec4::splat(0.0);
    // SAFETY: the attribute was bound by the case before the draw call.
    unsafe { read_vertex_attrib_float(&mut v, &inputs[index], packet.instance_ndx, packet.vertex_ndx, 0) };
    v
}

/// `FboTestUtil::TextureCubeArrayShader` - output is always `vec4` in this group.
pub struct TextureCubeArrayShader {
    base: ShaderProgramBase,
    sampler: Option<ResolvedSampler>,
    sampler_type: DataType,
}

impl TextureCubeArrayShader {
    pub fn new(sampler_type: DataType, output_type: DataType, es32: bool) -> Self {
        let version = if es32 {
            "#version 320 es\n"
        } else {
            "#version 310 es\n#extension GL_EXT_texture_cube_map_array : require\n"
        };
        let vertex_source = format!(
            "{version}\
             in highp vec4 a_position;\n\
             in mediump vec2 a_coord;\n\
             uniform mat3 u_coordMat;\n\
             out highp vec3 v_coord;\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_coord = u_coordMat * vec3(a_coord, 1.0);\n\
             }}\n"
        );
        let fragment_source = format!(
            "{version}\
             uniform highp {sampler} u_sampler0;\n\
             uniform highp vec4 u_scale;\n\
             uniform highp vec4 u_bias;\n\
             uniform highp int u_layer;\n\
             in highp vec3 v_coord;\n\
             layout(location = 0) out highp {output} o_color;\n\
             void main (void)\n\
             {{\n\
             \x20   o_color = {output}(vec4(texture(u_sampler0, vec4(v_coord, u_layer))) * u_scale + u_bias);\n\
             }}\n",
            sampler = sampler_type.name(),
            output = output_type.name(),
        );

        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_coordMat", DataType::FloatMat3))
            .uniform(pdec::Uniform::new("u_sampler0", sampler_type))
            .uniform(pdec::Uniform::new("u_scale", DataType::FloatVec4))
            .uniform(pdec::Uniform::new("u_bias", DataType::FloatVec4))
            .uniform(pdec::Uniform::new("u_layer", DataType::Int))
            .vertex_source(vertex_source)
            .fragment_source(fragment_source);

        Self {
            base: ShaderProgramBase::new(&decl),
            sampler: None,
            sampler_type,
        }
    }

    fn sample(&self, s: f32, t: f32, r: f32, layer: f32) -> [f32; 4] {
        let Some(sampler) = self.sampler.as_ref().and_then(|s| s.as_cube_array()) else {
            return [0.0; 4];
        };
        match self.sampler_type {
            DataType::IntSamplerCubeArray => {
                let v = sampler.sample_int(s, t, r, layer, 0.0);
                [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32]
            }
            DataType::UintSamplerCubeArray => {
                let v = sampler.sample_uint(s, t, r, layer, 0.0);
                [v[0] as f32, v[1] as f32, v[2] as f32, v[3] as f32]
            }
            _ => sampler.sample(s, t, r, layer, 0.0),
        }
    }
}

impl VertexShader for TextureCubeArrayShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        let m = match self.base.uniform_by_name("u_coordMat").value {
            UniformValue::Mat3(m) => m,
            ref other => panic!("u_coordMat is not a mat3: {other:?}"),
        };
        for packet in packets.iter_mut() {
            let a_coord = read_attrib(inputs, 1, packet);
            let (cx, cy) = (a_coord.x(), a_coord.y());
            let v_coord = [
                m[0] * cx + m[1] * cy + m[2],
                m[3] * cx + m[4] * cy + m[5],
                m[6] * cx + m[7] * cy + m[8],
            ];

            packet.position = read_attrib(inputs, 0, packet);
            packet.outputs[0] = GenericVec4::from_float(Vec4::new(v_coord[0], v_coord[1], v_coord[2], 0.0));
        }
    }
}

impl FragmentShader for TextureCubeArrayShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let tex_scale = self.base.uniform_by_name("u_scale").value.as_f32_vec4();
        let tex_bias = self.base.uniform_by_name("u_bias").value.as_f32_vec4();
        let layer = self.base.uniform_by_name("u_layer").value.as_i32();

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                let sampled = self.sample(coord.x(), coord.y(), coord.z(), layer as f32);
                let color = Vec4::new(
                    sampled[0] * tex_scale[0] + tex_bias[0],
                    sampled[1] * tex_scale[1] + tex_bias[1],
                    sampled[2] * tex_scale[2] + tex_bias[2],
                    sampled[3] * tex_scale[3] + tex_bias[3],
                );
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for TextureCubeArrayShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            if name == "u_sampler0" {
                self.sampler = sampler.clone();
            }
        }
    }
}

/// `TextureCubeArrayShader::setLayer` + `setFace` + `setTexScaleBias` + `setUniforms`.
pub fn set_cube_array_uniforms(
    ctx: &mut dyn SglrContext,
    program: u32,
    layer: i32,
    face: CubeFace,
    scale: [f32; 4],
    bias: [f32; 4],
) {
    // Row-major, indexed by `CubeFace` (-X, +X, -Y, +Y, -Z, +Z).
    const CUBE_TRANSFORMS: [[f32; 9]; 6] = [
        [0.0, 0.0, -1.0, 0.0, -2.0, 1.0, 2.0, 0.0, -1.0],
        [0.0, 0.0, 1.0, 0.0, -2.0, 1.0, -2.0, 0.0, 1.0],
        [2.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, -2.0, 1.0],
        [2.0, 0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 2.0, -1.0],
        [-2.0, 0.0, 1.0, 0.0, -2.0, 1.0, 0.0, 0.0, -1.0],
        [2.0, 0.0, -1.0, 0.0, -2.0, 1.0, 0.0, 0.0, 1.0],
    ];

    let row_major = CUBE_TRANSFORMS[face as usize];
    let mut column_major = [0.0f32; 9];
    for row in 0..3 {
        for col in 0..3 {
            column_major[col * 3 + row] = row_major[row * 3 + col];
        }
    }

    ctx.use_program(program);
    let sampler_loc = ctx.get_uniform_location(program, "u_sampler0");
    ctx.uniform1i(sampler_loc, 0);
    let mat_loc = ctx.get_uniform_location(program, "u_coordMat");
    ctx.uniform_matrix3fv(mat_loc, 1, false, &column_major);
    let layer_loc = ctx.get_uniform_location(program, "u_layer");
    ctx.uniform1i(layer_loc, layer);
    let scale_loc = ctx.get_uniform_location(program, "u_scale");
    ctx.uniform4fv(scale_loc, 1, &scale);
    let bias_loc = ctx.get_uniform_location(program, "u_bias");
    ctx.uniform4fv(bias_loc, 1, &bias);
}

/// `FboColorTexCubeArrayCase`
struct FboColorTexCubeArrayCase {
    name: String,
    format: GLenum,
    tex_size: [i32; 3],
    es32: AtomicBool,
}

impl FboRender for FboColorTexCubeArrayCase {
    fn pre_check(&self, context: &Context) -> Result<(), TestError> {
        let es32 = context.context_type().supports(3, 2);
        if !es32
            && !context
                .context_info
                .is_extension_supported("GL_EXT_texture_cube_map_array")
        {
            return Err(TestError::NotSupported(
                "Test requires extension GL_EXT_texture_cube_map_array or a context version equal or higher than 3.2"
                    .to_string(),
            ));
        }
        self.es32.store(es32, Ordering::Relaxed);

        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0xed607a89);
        let tex_fmt = map_gl_internal_format(self.format)
            .ok_or_else(|| TestError::Fail(format!("unknown internal format {:#x}", self.format)))?;
        let fmt_info = get_texture_format_info(tex_fmt);

        let out_scale: [f32; 4] = std::array::from_fn(|i| fmt_info.value_max[i] - fmt_info.value_min[i]);
        let tex_to_fbo_shader =
            Texture2DShader::new(1, get_fragment_output_type(tex_fmt), out_scale, fmt_info.value_min);
        let tex_to_fbo_uniforms = tex_to_fbo_shader.uniforms();
        let array_tex_shader = TextureCubeArrayShader::new(
            get_sampler_cube_array_type(tex_fmt),
            DataType::FloatVec4,
            self.es32.load(Ordering::Relaxed),
        );

        let tex_to_fbo_shader_id = ctx.create_program(Box::new(tex_to_fbo_shader));
        let array_tex_shader_id = ctx.create_program(Box::new(array_tex_shader));

        // Setup textures
        tex_to_fbo_uniforms.set_uniforms(ctx, tex_to_fbo_shader_id);

        // Framebuffers.
        let mut fbos: Vec<u32> = Vec::new();
        let mut tex = [0u32];

        {
            let transfer_fmt = get_transfer_format(tex_fmt)?;
            let is_filterable = is_gl_internal_color_format_filterable(self.format);
            let size = self.tex_size;
            let filter = (if is_filterable { glw::GL_LINEAR } else { glw::GL_NEAREST }) as i32;

            log::info!(
                "Creating a cube map array texture ({}x{}, depth: {})",
                size[0],
                size[1],
                size[2]
            );

            ctx.gen_textures(&mut tex);

            ctx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex[0]);
            ctx.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_CLAMP_TO_EDGE as i32,
            );
            ctx.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_CLAMP_TO_EDGE as i32,
            );
            ctx.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_WRAP_R,
                glw::GL_CLAMP_TO_EDGE as i32,
            );
            ctx.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_MIN_FILTER, filter);
            ctx.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_MAG_FILTER, filter);
            ctx.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                self.format,
                size[0],
                size[1],
                size[2],
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                None,
            );

            log::info!("Creating a framebuffer object for each layer-face");

            for ndx in 0..self.tex_size[2] {
                let mut layer_fbo = [0u32];
                ctx.gen_framebuffers(&mut layer_fbo);
                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, layer_fbo[0]);
                ctx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, ndx);
                check_error(ctx)?;
                check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

                fbos.push(layer_fbo[0]);
            }
        }

        log::info!("Rendering test images to layer-faces in randomized order");

        {
            let mut order: Vec<i32> = (0..fbos.len() as i32).collect();
            rnd.shuffle(&mut order);

            for (ndx, &layer_face) in order.iter().enumerate() {
                let ndx = ndx as i32;
                let format = glw::GL_RGBA;
                let data_type = glw::GL_UNSIGNED_BYTE;
                let tex_w = 128;
                let tex_h = 128;
                let fbo = fbos[layer_face as usize];
                let viewport = self.tex_size;
                let mut data = TextureLevel::new(
                    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
                    tex_w as u32,
                    tex_h as u32,
                    1,
                )?;

                let grid_color = generate_random_color(&mut rnd);
                fill_with_grid(&mut data.get_access(), 8, grid_color, [0.0; 4]);

                let mut tmp_tex = [0u32];
                ctx.gen_textures(&mut tmp_tex);
                ctx.bind_texture(glw::GL_TEXTURE_2D, tmp_tex[0]);
                ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
                ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
                ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
                ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
                ctx.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    format,
                    tex_w,
                    tex_h,
                    0,
                    format,
                    data_type,
                    Some(data.data()),
                );

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
                ctx.viewport(0, 0, viewport[0], viewport[1]);
                draw_quad(
                    ctx,
                    tex_to_fbo_shader_id,
                    Vec3::new(-1.0, -1.0, 0.0),
                    Vec3::new(1.0, 1.0, 0.0),
                );
                check_error(ctx)?;

                // Render to framebuffer
                {
                    let p0 = Vec3::new((ndx % 2) as f32 - 1.0, (ndx / 2) as f32 - 1.0, 0.0);
                    let p1 = Vec3::new(p0.x() + 1.0, p0.y() + 1.0, p0.z());
                    let layer = layer_face / 6;
                    let face = get_cube_face_from_ndx(layer_face % 6);

                    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                    let (width, height) = (ctx.get_width(), ctx.get_height());
                    ctx.viewport(0, 0, width, height);

                    ctx.active_texture(glw::GL_TEXTURE0);
                    ctx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex[0]);

                    set_cube_array_uniforms(
                        ctx,
                        array_tex_shader_id,
                        layer,
                        face,
                        fmt_info.look_up_scale,
                        fmt_info.look_up_bias,
                    );

                    draw_quad(ctx, array_tex_shader_id, p0, p1);
                    check_error(ctx)?;
                }
            }
        }

        let (width, height) = (ctx.get_width(), ctx.get_height());
        read_pixels(
            ctx,
            dst,
            0,
            0,
            width,
            height,
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            [1.0; 4],
            [0.0; 4],
        )?;
        check_error(ctx)
    }

    /// `FboColorbufferCase::compare`
    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        let Ok(format_threshold) = get_format_threshold_gl(self.format) else {
            return false;
        };
        let threshold: [u8; 4] = std::array::from_fn(|i| format_threshold[i].max(MIN_THRESHOLD[i]));

        log::info!("Comparing images, threshold: {threshold:?}");

        bilinear_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            None,
            threshold,
        )
    }
}

/// `FboColorTests::init`'s `texcubearray` group
pub fn create_tests() -> TestCaseGroup {
    const COLOR_FORMATS: [GLenum; 36] = [
        // RGBA formats
        glw::GL_RGBA32I,
        glw::GL_RGBA32UI,
        glw::GL_RGBA16I,
        glw::GL_RGBA16UI,
        glw::GL_RGBA8,
        glw::GL_RGBA8I,
        glw::GL_RGBA8UI,
        glw::GL_SRGB8_ALPHA8,
        glw::GL_RGB10_A2,
        glw::GL_RGB10_A2UI,
        glw::GL_RGBA4,
        glw::GL_RGB5_A1,
        // RGB formats
        glw::GL_RGB8,
        glw::GL_RGB565,
        // RG formats
        glw::GL_RG32I,
        glw::GL_RG32UI,
        glw::GL_RG16I,
        glw::GL_RG16UI,
        glw::GL_RG8,
        glw::GL_RG8I,
        glw::GL_RG8UI,
        // R formats
        glw::GL_R32I,
        glw::GL_R32UI,
        glw::GL_R16I,
        glw::GL_R16UI,
        glw::GL_R8,
        glw::GL_R8I,
        glw::GL_R8UI,
        // GL_EXT_color_buffer_float
        glw::GL_RGBA32F,
        glw::GL_RGBA16F,
        glw::GL_R11F_G11F_B10F,
        glw::GL_RG32F,
        glw::GL_RG16F,
        glw::GL_R32F,
        glw::GL_R16F,
        // GL_EXT_color_buffer_half_float
        glw::GL_RGB16F,
    ];

    let mut group = TestCaseGroup::new("texcubearray");
    for &format in &COLOR_FORMATS {
        let name = get_format_name(format);
        group.add_child(FboTestCase::new(
            name,
            FboColorTexCubeArrayCase {
                name: name.to_string(),
                format,
                tex_size: [128, 128, 12],
                es32: AtomicBool::new(false),
            },
        ));
    }
    group
}
