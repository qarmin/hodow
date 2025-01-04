// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (BindingSamplersTest, BindingSamplerSingleTest, BindingSamplerArrayTest, BindingSamplerDefaultTest, BindingSamplerAPIOverrideTest, BindingSamplerInvalidTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The member `Utils::texture`s and the member buffer of the upstream classes are a `TextureStash`.

use super::objects::{Buffer, Program, ShaderSource, Texture, TextureStash};
use super::templates::*;
use super::{
    Case420, Kind, ShaderStage, StageTemplates, TextureType, Types, replace_all_tokens, replace_token, version_string,
};
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;

/// `addBindingSamplersTest`
pub(super) const SAMPLERS_TEXTURE_TYPES: [TextureType; 8] = [
    TextureType::Tex2D,
    TextureType::TexBuffer,
    TextureType::Tex2DRect,
    TextureType::Tex2DArray,
    TextureType::Tex3D,
    TextureType::TexCube,
    TextureType::Tex1D,
    TextureType::Tex1DArray,
];

/// `addBindingSamplerSingleTest`
pub(super) const SINGLE_STAGES: [ShaderStage; 5] = [
    ShaderStage::Vertex,
    ShaderStage::TessControl,
    ShaderStage::TessEval,
    ShaderStage::Geometry,
    ShaderStage::Fragment,
];

fn fill_source(
    out_source: &mut ShaderSource,
    templates: &StageTemplates,
    stage: ShaderStage,
    use_version_400: bool,
) -> usize {
    let code = &mut out_source.parts[0].code;
    *code = templates.get(stage).as_bytes().to_vec();

    let mut position = 0;
    replace_token(
        "VERSION",
        &mut position,
        version_string(stage, use_version_400).as_bytes(),
        code,
    );
    position
}

/// The solid-colour 16x16 RGBA8 contents the sampler cases upload.
fn solid_texels(color: GLuint) -> Vec<GLuint> {
    vec![color; 16 * 16]
}

/// Creates a 16x16 2D texture filled with `color` and leaves it bound on the active unit.
fn create_solid_texture(context: &Context, stash: &TextureStash, color: GLuint) -> Result<(), TestError> {
    let mut texture = Texture::new(context);
    texture.create(16, 16, glw::GL_RGBA8)?;
    texture.update(
        16,
        16,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        solid_texels(color).as_ptr().cast(),
    )?;
    stash.add(texture);
    Ok(())
}

fn active_texture(context: &Context, unit: GLuint) -> Result<(), TestError> {
    let gl = context.gl();
    gl_call!(gl, "ActiveTexture", gl.active_texture(glw::GL_TEXTURE0 + unit));
    Ok(())
}

/// `BindingSamplersTest`
pub(super) struct BindingSamplers {
    name: String,
    test_case: TextureType,
    textures: TextureStash,
}

impl BindingSamplers {
    pub(super) fn new(test_case: TextureType) -> Self {
        Self {
            name: format!("binding_samplers_texture_type_{}", test_case.name()),
            test_case,
            textures: TextureStash::default(),
        }
    }

    /// `BindingSamplersTest::prepareTexture`; the texture is returned still bound to the active unit's target.
    fn prepare_texture<'c>(&self, context: &'c Context, color: GLuint) -> Result<Texture<'c>, TestError> {
        let texture_data = solid_texels(color);
        let mut texture = Texture::new(context);

        if self.test_case != TextureType::TexBuffer {
            texture.create_typed(16, 16, 1, glw::GL_RGBA8, self.test_case)?;
            texture.update(
                16,
                16,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                texture_data.as_ptr().cast(),
            )?;
        } else {
            let mut buffer = Buffer::new(context);
            buffer.generate(glw::GL_TEXTURE_BUFFER)?;
            buffer.update(
                texture_data.len() as glw::GLsizeiptr,
                texture_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            )?;
            texture.create_buffer(glw::GL_RGBA8, buffer.leak())?;
        }

        Ok(texture)
    }
}

impl Case420 for BindingSamplers {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLERS_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLERS_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLERS_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLERS_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLERS_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLERS_VERTEX_SHADER_TEMPLATE,
        };

        let base_tex_coord_type = if self.test_case == TextureType::TexBuffer {
            Types::Int
        } else {
            Types::Float
        };
        let n_coordinates = self.test_case.number_of_coordinates();
        let sampler_type = self.test_case.sampler_type();
        let sampling_function = if self.test_case == TextureType::TexBuffer {
            "texelFetch"
        } else {
            "texture"
        };
        let tex_coord_type = base_tex_coord_type
            .type_name(1, n_coordinates as usize)
            .expect("the type exists");
        let coordinates = match n_coordinates {
            1 => "0",
            2 => "0, 0",
            3 => "0, 0, 0",
            _ => "0, 0, 0, 0",
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLERS_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position -= BINDING_SAMPLERS_VERIFICATION_SNIPPET.len();
        replace_token("COORDINATES", &mut position, coordinates.as_bytes(), code);
        replace_all_tokens("SAMPLING_FUNCTION", sampling_function.as_bytes(), code);
        replace_all_tokens("UNI_GOKU", BINDING_SAMPLERS_UNI_GOKU.as_bytes(), code);
        replace_all_tokens("UNI_VEGETA", BINDING_SAMPLERS_UNI_VEGETA.as_bytes(), code);
        replace_all_tokens("UNI_TRUNKS", BINDING_SAMPLERS_UNI_TRUNKS.as_bytes(), code);
        replace_all_tokens("TEX_COORD_TYPE", tex_coord_type.as_bytes(), code);
        replace_all_tokens("TYPE", sampler_type.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: GLuint = 0x000000ff;
        const VEGETA_DATA: GLuint = 0x0000ff00;
        const TRUNKS_DATA: GLuint = 0x00ff0000;

        let context = program.context();

        for (unit, color) in [(0, GOKU_DATA), (1, VEGETA_DATA), (3, TRUNKS_DATA)] {
            let texture = self.prepare_texture(context, color)?;
            active_texture(context, unit)?;
            texture.bind()?;
            self.textures.add(texture);
        }

        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingSamplerSingleTest`
pub(super) struct BindingSamplerSingle {
    name: String,
    test_stage: ShaderStage,
    textures: TextureStash,
}

impl BindingSamplerSingle {
    pub(super) fn new(test_stage: ShaderStage) -> Self {
        Self {
            name: format!("binding_sampler_single_stage_{}", test_stage.name()),
            test_stage,
            textures: TextureStash::default(),
        }
    }
}

impl Case420 for BindingSamplerSingle {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLER_SINGLE_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLER_SINGLE_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLER_SINGLE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLER_SINGLE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLER_SINGLE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLER_SINGLE_VERTEX_SHADER_TEMPLATE,
        };

        let uniform_definition = if stage == ShaderStage::Compute || stage == self.test_stage {
            BINDING_SAMPLER_SINGLE_UNI_GOKU_WITH_BINDING
        } else {
            BINDING_SAMPLER_SINGLE_UNI_GOKU_NO_BINDING
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLER_SINGLE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", uniform_definition.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: GLuint = 0x000000ff;

        let context = program.context();
        let mut texture = Texture::new(context);
        texture.create(16, 16, glw::GL_RGBA8)?;
        texture.update(
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            solid_texels(GOKU_DATA).as_ptr().cast(),
        )?;

        active_texture(context, 2)?;
        texture.bind()?;
        self.textures.add(texture);
        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingSamplerArrayTest`
#[derive(Default)]
pub(super) struct BindingSamplerArray {
    textures: TextureStash,
}

impl Case420 for BindingSamplerArray {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_sampler_array"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLER_ARRAY_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLER_ARRAY_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLER_ARRAY_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLER_ARRAY_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLER_ARRAY_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLER_ARRAY_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLER_ARRAY_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_SAMPLER_ARRAY_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [GLuint; 7] = [
            0x00000000, 0xff000000, 0x00ff0000, 0xffff0000, 0x0000ff00, 0xff00ff00, 0x00ffff00,
        ];
        const BINDING_OFFSET: GLuint = 1;

        let context = program.context();

        for (i, color) in GOKU_DATA.iter().enumerate() {
            let expected_binding = i as GLuint + BINDING_OFFSET;

            if !program.check_uniform_array_binding("goku", i as GLuint, expected_binding as GLint)? {
                return super::fail("Wrong binding reported by API");
            }

            active_texture(context, expected_binding)?;
            create_solid_texture(context, &self.textures, *color)?;
        }
        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingSamplerDefaultTest`
pub(super) struct BindingSamplerDefault;

impl Case420 for BindingSamplerDefault {
    const KIND: Kind = Kind::Api;

    fn name(&self) -> &str {
        "binding_sampler_default"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLER_DEFAULT_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLER_DEFAULT_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLER_DEFAULT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLER_DEFAULT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLER_DEFAULT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLER_DEFAULT_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLER_DEFAULT_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_SAMPLER_DEFAULT_UNI_GOKU.as_bytes(), code);
    }

    fn check_program_results(&self, program: &Program, _case_index: usize) -> Result<bool, TestError> {
        program.check_uniform_binding("goku", 0)
    }
}

/// `BindingSamplerAPIOverrideTest`
#[derive(Default)]
pub(super) struct BindingSamplerApiOverride {
    textures: TextureStash,
}

impl Case420 for BindingSamplerApiOverride {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_sampler_api_override"
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLER_API_OVERRIDE_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLER_API_OVERRIDE_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLER_API_OVERRIDE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLER_API_OVERRIDE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLER_API_OVERRIDE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLER_API_OVERRIDE_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLER_API_OVERRIDE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_SAMPLER_API_OVERRIDE_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: GLuint = 0x000000ff;
        const NEW_BINDING: GLint = 11;

        let context = program.context();
        let gl = context.gl();
        let uniform_location = program.get_uniform_location("goku")?;

        // SAFETY: the location was just queried from the program in use.
        unsafe { gl.uniform_1i(uniform_location, NEW_BINDING) };

        let binding = program.get_uniform_1i(uniform_location)?;
        if NEW_BINDING != binding {
            return super::fail("Wrong binding value");
        }

        let mut texture = Texture::new(context);
        texture.create(16, 16, glw::GL_RGBA8)?;
        texture.update(
            16,
            16,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            solid_texels(GOKU_DATA).as_ptr().cast(),
        )?;

        active_texture(context, NEW_BINDING as GLuint)?;
        texture.bind()?;
        self.textures.add(texture);
        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingSamplerInvalidTest::TESTCASES` without `TEST_CASES_MAX`
#[derive(Clone, Copy)]
pub(super) enum InvalidBinding {
    NegativeValue,
    VariableName,
    Std140,
    Missing,
}

/// `addBindingSamplerInvalidTest`
pub(super) const INVALID_BINDINGS: [InvalidBinding; 4] = [
    InvalidBinding::NegativeValue,
    InvalidBinding::VariableName,
    InvalidBinding::Std140,
    InvalidBinding::Missing,
];

/// `BindingSamplerInvalidTest`
pub(super) struct BindingSamplerInvalid {
    name: String,
    binding: InvalidBinding,
}

impl BindingSamplerInvalid {
    pub(super) fn new(binding: InvalidBinding) -> Self {
        let case_name = match binding {
            InvalidBinding::NegativeValue => "-1",
            InvalidBinding::VariableName => "goku",
            InvalidBinding::Std140 => "std140",
            InvalidBinding::Missing => "",
        };
        Self {
            name: format!("binding_sampler_invalid_case_{case_name}"),
            binding,
        }
    }
}

impl Case420 for BindingSamplerInvalid {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        _context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_SAMPLER_INVALID_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_SAMPLER_INVALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_SAMPLER_INVALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_SAMPLER_INVALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_SAMPLER_INVALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_SAMPLER_INVALID_VERTEX_SHADER_TEMPLATE,
        };

        let binding = match self.binding {
            InvalidBinding::NegativeValue => "= -1",
            InvalidBinding::VariableName => "= goku",
            InvalidBinding::Std140 => "= std140",
            InvalidBinding::Missing => "",
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_SAMPLER_INVALID_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_SAMPLER_INVALID_UNI_GOKU.as_bytes(), code);
        replace_all_tokens("BINDING", binding.as_bytes(), code);
    }
}
