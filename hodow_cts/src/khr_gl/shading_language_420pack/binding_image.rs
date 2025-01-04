// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (BindingImageTest, BindingImagesTest, BindingImageSingleTest, BindingImageArrayTest, BindingImageDefaultTest, BindingImageAPIOverrideTest, BindingImageInvalidTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The member textures and buffers of the upstream classes are a `TextureStash` and a `BufferStash`; the `BindingImageTest` base is the free functions `prepare_buffer`, `prepare_texture`, `verify_buffer` and `verify_texture`.

use super::objects::{BufferStash, Program, ShaderSource, Texture, TextureStash};
use super::templates::*;
use super::{
    Case420, Kind, ShaderStage, StageTemplates, TextureType, Types, max_image_uniforms, replace_all_tokens,
    replace_token, version_string,
};
use crate::glu::Context;
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;

const WIDTH: GLuint = 16;
const HEIGHT: GLuint = 16;
const DEPTH: GLuint = 6;
const GREEN_COLOR: GLuint = 0xff00ff00;

const GOKU_DATA: GLuint = 0x000000ff;
const VEGETA_DATA: GLuint = 0x0000ff00;
const TRUNKS_DATA: GLuint = 0x00ff0000;

/// `addBindingImageSingleTest`
pub(super) const SINGLE_STAGES: [ShaderStage; 5] = [
    ShaderStage::Vertex,
    ShaderStage::TessControl,
    ShaderStage::TessEval,
    ShaderStage::Geometry,
    ShaderStage::Fragment,
];

/// `BindingImageTest::prepareBuffer`: a member buffer of `WIDTH` texels of `color`.
fn prepare_buffer(context: &Context, buffers: &BufferStash, color: GLuint) -> Result<(), TestError> {
    let texture_data = vec![color; WIDTH as usize];
    let buffer = buffers.generate_filled(context, glw::GL_TEXTURE_BUFFER, &texture_data)?;
    buffers.add(buffer, glw::GL_TEXTURE_BUFFER);
    Ok(())
}

/// `BindingImageTest::prepareTexture`; `buffer` is the member buffer (stash and index) a buffer texture is made of.
fn prepare_texture(
    context: &Context,
    textures: &TextureStash,
    buffer: Option<(&BufferStash, usize)>,
    texture_type: TextureType,
    color: GLuint,
    unit: GLuint,
) -> Result<(), TestError> {
    let gl = context.gl();
    let mut texture = Texture::new(context);

    if texture_type != TextureType::TexBuffer {
        let texture_data = vec![color; (WIDTH * HEIGHT * DEPTH) as usize];
        texture.create_typed(WIDTH, HEIGHT, DEPTH, glw::GL_RGBA8, texture_type)?;
        texture.update(
            WIDTH,
            HEIGHT,
            DEPTH,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_ptr().cast(),
        )?;
    } else {
        let (stash, index) = buffer.expect("a buffer texture needs its buffer");
        stash.with(context, index, |buffer| {
            buffer.bind()?;
            texture.create_buffer(glw::GL_RGBA8, buffer.id)
        })?;
    }

    let is_layered = matches!(
        texture_type,
        TextureType::Tex1DArray | TextureType::Tex2DArray | TextureType::Tex3D | TextureType::TexCube
    );

    gl_call!(
        gl,
        "BindImageTexture",
        gl.bind_image_texture(
            unit,
            texture.id,
            0,
            (if is_layered { glw::GL_TRUE } else { glw::GL_FALSE }) as glw::GLboolean,
            0,
            glw::GL_READ_WRITE,
            glw::GL_RGBA8
        )
    );

    textures.add(texture);
    Ok(())
}

/// `BindingImageTest::verifyBuffer`
fn verify_buffer(context: &Context, buffers: &BufferStash, index: usize) -> Result<bool, TestError> {
    buffers.with(context, index, |buffer| {
        let data = buffer.map(glw::GL_READ_ONLY)?.cast::<GLuint>();
        // SAFETY: the buffer was filled with `WIDTH` texels and stays mapped until the unmap below.
        let color = unsafe { *data };
        buffer.unmap()?;
        Ok(GREEN_COLOR == color)
    })
}

/// `BindingImageTest::verifyTexture`
fn verify_texture(context: &Context, textures: &TextureStash, index: usize) -> Result<bool, TestError> {
    textures.with(context, index, |texture| {
        let mut texture_data = vec![0 as GLuint; (WIDTH * HEIGHT * DEPTH) as usize];
        texture.get(glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, texture_data.as_mut_ptr().cast())?;
        Ok(GREEN_COLOR == texture_data[0])
    })
}

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

fn images_flag(context: &Context, stage: ShaderStage) -> &'static [u8] {
    if max_image_uniforms(context, stage) > 0 {
        b"1"
    } else {
        b"0"
    }
}

/// `BindingImagesTest`
pub(super) struct BindingImages {
    name: String,
    test_case: TextureType,
    textures: TextureStash,
    buffers: BufferStash,
}

impl BindingImages {
    pub(super) fn new(test_case: TextureType) -> Self {
        Self {
            name: format!("binding_images_texture_type_{}", test_case.name()),
            test_case,
            textures: TextureStash::default(),
            buffers: BufferStash::default(),
        }
    }
}

impl Case420 for BindingImages {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_IMAGES_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGES_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGES_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGES_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGES_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGES_VERTEX_SHADER_TEMPLATE,
        };

        let n_coordinates = self.test_case.number_of_coordinates();
        let image_type = self.test_case.image_type();
        let tex_coord_type = Types::Int
            .type_name(1, n_coordinates as usize)
            .expect("the type exists");
        let (coordinates_read, coordinates_write) = match n_coordinates {
            1 => ("1", "0"),
            2 => ("1, 0", "0, 0"),
            3 => ("1, 0, 0", "0, 0, 0"),
            _ => ("1, 0, 0, 0", "0, 0, 0, 0"),
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_IMAGES_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position -= BINDING_IMAGES_VERIFICATION_SNIPPET.len();
        replace_token("COORDINATES", &mut position, coordinates_read.as_bytes(), code);
        replace_token("COORDINATES", &mut position, coordinates_write.as_bytes(), code);
        replace_all_tokens("IMAGES", images_flag(context, stage), code);
        replace_all_tokens("UNI_GOKU", BINDING_IMAGES_UNI_GOKU.as_bytes(), code);
        replace_all_tokens("UNI_VEGETA", BINDING_IMAGES_UNI_VEGETA.as_bytes(), code);
        replace_all_tokens("UNI_TRUNKS", BINDING_IMAGES_UNI_TRUNKS.as_bytes(), code);
        replace_all_tokens("TEX_COORD_TYPE", tex_coord_type.as_bytes(), code);
        replace_all_tokens("TYPE", image_type.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        let context = program.context();

        prepare_buffer(context, &self.buffers, GOKU_DATA)?;
        prepare_buffer(context, &self.buffers, VEGETA_DATA)?;
        prepare_buffer(context, &self.buffers, TRUNKS_DATA)?;
        prepare_texture(
            context,
            &self.textures,
            Some((&self.buffers, 0)),
            self.test_case,
            GOKU_DATA,
            1,
        )?;
        prepare_texture(
            context,
            &self.textures,
            Some((&self.buffers, 1)),
            self.test_case,
            VEGETA_DATA,
            2,
        )?;
        prepare_texture(
            context,
            &self.textures,
            Some((&self.buffers, 2)),
            self.test_case,
            TRUNKS_DATA,
            4,
        )
    }

    fn verify_additional_results(&self, context: &Context, _case_index: usize) -> Result<bool, TestError> {
        if self.test_case != TextureType::TexBuffer {
            Ok(verify_texture(context, &self.textures, 0)?
                && verify_texture(context, &self.textures, 1)?
                && verify_texture(context, &self.textures, 2)?)
        } else {
            Ok(verify_buffer(context, &self.buffers, 0)?
                && verify_buffer(context, &self.buffers, 1)?
                && verify_buffer(context, &self.buffers, 2)?)
        }
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);

        if self.test_case != TextureType::TexBuffer {
            self.buffers.release(context);
        } else {
            self.buffers.forget();
        }
    }
}

/// `BindingImageSingleTest`
pub(super) struct BindingImageSingle {
    name: String,
    test_stage: ShaderStage,
    textures: TextureStash,
}

impl BindingImageSingle {
    pub(super) fn new(test_stage: ShaderStage) -> Self {
        Self {
            name: format!("binding_image_single_stage_{}", test_stage.name()),
            test_stage,
            textures: TextureStash::default(),
        }
    }
}

impl Case420 for BindingImageSingle {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_IMAGE_SINGLE_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGE_SINGLE_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGE_SINGLE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGE_SINGLE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGE_SINGLE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGE_SINGLE_VERTEX_SHADER_TEMPLATE,
        };

        let mut uniform_definition = BINDING_IMAGE_SINGLE_UNI_GOKU_NO_BINDING;

        match stage {
            ShaderStage::Compute => uniform_definition = BINDING_IMAGE_SINGLE_UNI_GOKU_WITH_BINDING,
            ShaderStage::Fragment if max_image_uniforms(context, self.test_stage) == 0 => {
                uniform_definition = BINDING_IMAGE_SINGLE_UNI_GOKU_WITH_BINDING;
            }
            _ => {}
        }

        if stage == self.test_stage {
            uniform_definition = BINDING_IMAGE_SINGLE_UNI_GOKU_WITH_BINDING;
        }

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_IMAGE_SINGLE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("IMAGES", images_flag(context, stage), code);
        replace_all_tokens("UNI_GOKU", uniform_definition.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        prepare_texture(
            program.context(),
            &self.textures,
            None,
            TextureType::Tex2D,
            GOKU_DATA,
            2,
        )
    }

    fn verify_additional_results(&self, context: &Context, _case_index: usize) -> Result<bool, TestError> {
        verify_texture(context, &self.textures, 0)
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingImageArrayTest`
#[derive(Default)]
pub(super) struct BindingImageArray {
    textures: TextureStash,
}

impl Case420 for BindingImageArray {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_image_array"
    }

    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_IMAGE_ARRAY_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGE_ARRAY_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGE_ARRAY_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGE_ARRAY_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGE_ARRAY_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGE_ARRAY_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_IMAGE_ARRAY_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("IMAGES", images_flag(context, stage), code);
        replace_all_tokens("UNI_GOKU", BINDING_IMAGE_ARRAY_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [GLuint; 7] = [
            0x00000000, 0xff000000, 0x00ff0000, 0xffff0000, 0x0000ff00, 0xff00ff00, 0x00ffff00,
        ];

        for (i, color) in GOKU_DATA.iter().enumerate() {
            let expected_binding = i as GLuint + 1;

            if !program.check_uniform_array_binding("goku", i as GLuint, expected_binding as GLint)? {
                return super::fail("Wrong binding reported by API");
            }

            prepare_texture(
                program.context(),
                &self.textures,
                None,
                TextureType::Tex2D,
                *color,
                expected_binding,
            )?;
        }
        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingImageDefaultTest`
pub(super) struct BindingImageDefault;

impl Case420 for BindingImageDefault {
    const KIND: Kind = Kind::Api;

    fn name(&self) -> &str {
        "binding_image_default"
    }

    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_IMAGE_DEFAULT_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGE_DEFAULT_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGE_DEFAULT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGE_DEFAULT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGE_DEFAULT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGE_DEFAULT_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_IMAGE_DEFAULT_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("IMAGES", images_flag(context, stage), code);
        replace_all_tokens("UNI_GOKU", BINDING_IMAGE_DEFAULT_UNI_GOKU.as_bytes(), code);
    }

    fn check_program_results(&self, program: &Program, _case_index: usize) -> Result<bool, TestError> {
        program.check_uniform_binding("goku", 0)
    }
}

/// `BindingImageAPIOverrideTest`
#[derive(Default)]
pub(super) struct BindingImageApiOverride {
    textures: TextureStash,
}

impl Case420 for BindingImageApiOverride {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_image_api_override"
    }

    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        _case_index: usize,
        out_source: &mut ShaderSource,
    ) {
        let templates = StageTemplates {
            compute: BINDING_IMAGE_API_OVERRIDE_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGE_API_OVERRIDE_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGE_API_OVERRIDE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGE_API_OVERRIDE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGE_API_OVERRIDE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGE_API_OVERRIDE_VERTEX_SHADER_TEMPLATE,
        };

        let mut position = fill_source(out_source, &templates, stage, use_version_400);
        let code = &mut out_source.parts[0].code;
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_IMAGE_API_OVERRIDE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("IMAGES", images_flag(context, stage), code);
        replace_all_tokens("UNI_GOKU", BINDING_IMAGE_API_OVERRIDE_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const NEW_BINDING: GLint = 7;

        let context = program.context();
        let gl = context.gl();
        let uniform_location = program.get_uniform_location("goku")?;

        // SAFETY: the location was just queried from the program in use.
        unsafe { gl.uniform_1i(uniform_location, NEW_BINDING) };

        let binding = program.get_uniform_1i(uniform_location)?;
        if NEW_BINDING != binding {
            return super::fail("Wrong binding value");
        }

        prepare_texture(
            context,
            &self.textures,
            None,
            TextureType::Tex2D,
            GOKU_DATA,
            NEW_BINDING as GLuint,
        )
    }

    fn release_resource(&self, context: &Context) {
        self.textures.release(context);
    }
}

/// `BindingImageInvalidTest::TESTCASES` without `TEST_CASES_MAX`
#[derive(Clone, Copy)]
pub(super) enum InvalidBinding {
    NegativeValue,
    VariableName,
    Std140,
    Missing,
}

/// `addBindingImageInvalidTest`
pub(super) const INVALID_BINDINGS: [InvalidBinding; 4] = [
    InvalidBinding::NegativeValue,
    InvalidBinding::VariableName,
    InvalidBinding::Std140,
    InvalidBinding::Missing,
];

/// `BindingImageInvalidTest`
pub(super) struct BindingImageInvalid {
    name: String,
    binding: InvalidBinding,
}

impl BindingImageInvalid {
    pub(super) fn new(binding: InvalidBinding) -> Self {
        let case_name = match binding {
            InvalidBinding::NegativeValue => "-1",
            InvalidBinding::VariableName => "goku",
            InvalidBinding::Std140 => "std140",
            InvalidBinding::Missing => "",
        };
        Self {
            name: format!("binding_image_invalid_case_{case_name}"),
            binding,
        }
    }
}

impl Case420 for BindingImageInvalid {
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
            compute: BINDING_IMAGE_INVALID_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_IMAGE_INVALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_IMAGE_INVALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_IMAGE_INVALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_IMAGE_INVALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_IMAGE_INVALID_VERTEX_SHADER_TEMPLATE,
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
            BINDING_IMAGE_INVALID_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_IMAGE_INVALID_UNI_GOKU.as_bytes(), code);
        replace_all_tokens("BINDING", binding.as_bytes(), code);
    }
}
