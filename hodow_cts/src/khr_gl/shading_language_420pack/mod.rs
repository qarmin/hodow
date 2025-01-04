// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The class chain `TestBase` -> `APITestBase` / `GLSLTestBase` / `NegativeTestBase` is the trait `Case420` plus the driver `Test420`: a case states its `Kind` and fills in the hooks, and the driver runs `TestBase::test` for it. Upstream's `prepareNextTestCase` mutated a member; here the index it selected is passed to every hook as `case_index`.
//
// Written without compiling. Ported so far: the framework, `line_numbering`.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        crate::glu::expect_no_error($gl, $name)?;
    }};
}

mod binding_image;
mod binding_sampler;
mod binding_uniform;
mod const_values;
mod implicit_conversions;
mod initializer_list;
mod length_of;
mod line_continuation;
mod line_numbering;
mod objects;
mod qualifier_order;
mod qualifiers;
mod scalar_and_builtin;
mod templates;
mod utf8;

use objects::{Buffer, BuildOutcome, Framebuffer, Program, ProgramSources, ShaderSource, Texture, VertexArray};

/// `TCU_FAIL`
pub(super) fn fail<T>(message: &str) -> Result<T, TestError> {
    Err(TestError::Fail(message.to_string()))
}

/// `Utils::TEXTURE_TYPES`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum TextureType {
    TexBuffer,
    Tex2D,
    Tex2DRect,
    Tex2DArray,
    Tex3D,
    TexCube,
    Tex1D,
    Tex1DArray,
}

impl TextureType {
    /// `Utils::getTextureTartet`
    pub(super) fn target(self) -> GLenum {
        match self {
            Self::TexBuffer => glw::GL_TEXTURE_BUFFER,
            Self::Tex2D => glw::GL_TEXTURE_2D,
            Self::Tex2DRect => glw::GL_TEXTURE_RECTANGLE,
            Self::Tex2DArray => glw::GL_TEXTURE_2D_ARRAY,
            Self::Tex3D => glw::GL_TEXTURE_3D,
            Self::TexCube => glw::GL_TEXTURE_CUBE_MAP,
            Self::Tex1D => glw::GL_TEXTURE_1D,
            Self::Tex1DArray => glw::GL_TEXTURE_1D_ARRAY,
        }
    }

    /// `Utils::getImageType`
    pub(super) fn image_type(self) -> &'static str {
        match self {
            Self::TexBuffer => "imageBuffer",
            Self::Tex2D => "image2D",
            Self::Tex2DRect => "image2DRect",
            Self::Tex2DArray => "image2DArray",
            Self::Tex3D => "image3D",
            Self::TexCube => "imageCube",
            Self::Tex1D => "image1D",
            Self::Tex1DArray => "image1DArray",
        }
    }

    /// `Utils::getNumberOfCoordinates`
    pub(super) fn number_of_coordinates(self) -> GLuint {
        match self {
            Self::TexBuffer | Self::Tex1D => 1,
            Self::Tex2D | Self::Tex2DRect | Self::Tex1DArray => 2,
            Self::Tex2DArray | Self::Tex3D | Self::TexCube => 3,
        }
    }

    /// `Utils::getSamplerType`
    pub(super) fn sampler_type(self) -> &'static str {
        match self {
            Self::TexBuffer => "samplerBuffer",
            Self::Tex2D => "sampler2D",
            Self::Tex2DRect => "sampler2DRect",
            Self::Tex2DArray => "sampler2DArray",
            Self::Tex3D => "sampler3D",
            Self::TexCube => "samplerCube",
            Self::Tex1D => "sampler1D",
            Self::Tex1DArray => "sampler1DArray",
        }
    }

    /// `Utils::getTextureTypeName`
    pub(super) fn name(self) -> &'static str {
        match self {
            Self::TexBuffer => "buffer",
            Self::Tex2D => "2D",
            Self::Tex2DRect => "2D_rectangle",
            Self::Tex2DArray => "2D_array",
            Self::Tex3D => "3D",
            Self::TexCube => "cube",
            Self::Tex1D => "1D",
            Self::Tex1DArray => "1D_array",
        }
    }
}

/// `Utils::TYPES`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Types {
    Float,
    Double,
    Int,
    Uint,
}

impl Types {
    /// `Utils::getTypeName`; `None` where upstream returns a null pointer.
    pub(super) fn type_name(self, n_columns: usize, n_rows: usize) -> Option<&'static str> {
        const FLOAT_LUT: [[Option<&str>; 4]; 4] = [
            [Some("float"), Some("vec2"), Some("vec3"), Some("vec4")],
            [None, Some("mat2"), Some("mat2x3"), Some("mat2x4")],
            [None, Some("mat3x2"), Some("mat3"), Some("mat3x4")],
            [None, Some("mat4x2"), Some("mat4x3"), Some("mat4")],
        ];
        const DOUBLE_LUT: [[Option<&str>; 4]; 4] = [
            [Some("double"), Some("dvec2"), Some("dvec3"), Some("dvec4")],
            [None, Some("dmat2"), Some("dmat2x3"), Some("dmat2x4")],
            [None, Some("dmat3x2"), Some("dmat3"), Some("dmat3x4")],
            [None, Some("dmat4x2"), Some("dmat4x3"), Some("dmat4")],
        ];
        const INT_LUT: [&str; 4] = ["int", "ivec2", "ivec3", "ivec4"];
        const UINT_LUT: [&str; 4] = ["uint", "uvec2", "uvec3", "uvec4"];

        if !(1..=4).contains(&n_columns) || !(1..=4).contains(&n_rows) {
            return None;
        }

        match self {
            Self::Float => FLOAT_LUT[n_columns - 1][n_rows - 1],
            Self::Double => DOUBLE_LUT[n_columns - 1][n_rows - 1],
            Self::Int => Some(INT_LUT[n_rows - 1]),
            Self::Uint => Some(UINT_LUT[n_rows - 1]),
        }
    }

    /// `Utils::doesTypeSupportMatrix`
    pub(super) fn supports_matrix(self) -> bool {
        matches!(self, Self::Float | Self::Double)
    }
}

/// `Utils::SHADER_STAGES`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ShaderStage {
    Compute,
    Vertex,
    TessControl,
    TessEval,
    Geometry,
    Fragment,
}

impl ShaderStage {
    /// `Utils::getShaderStageName`
    pub(super) fn name(self) -> &'static str {
        match self {
            Self::Compute => "compute",
            Self::Vertex => "vertex",
            Self::TessControl => "tesselation_control",
            Self::TessEval => "tesselation_evaluation",
            Self::Geometry => "geometry",
            Self::Fragment => "fragment",
        }
    }
}

/// The six per-stage templates every `prepareShaderSource` switches over.
pub(super) struct StageTemplates {
    pub(super) compute: &'static str,
    pub(super) fragment: &'static str,
    pub(super) geometry: &'static str,
    pub(super) tess_control: &'static str,
    pub(super) tess_evaluation: &'static str,
    pub(super) vertex: &'static str,
}

impl StageTemplates {
    pub(super) fn get(&self, stage: ShaderStage) -> &'static str {
        match stage {
            ShaderStage::Compute => self.compute,
            ShaderStage::Fragment => self.fragment,
            ShaderStage::Geometry => self.geometry,
            ShaderStage::TessControl => self.tess_control,
            ShaderStage::TessEval => self.tess_evaluation,
            ShaderStage::Vertex => self.vertex,
        }
    }
}

/// `TestBase::maxImageUniforms`
pub(super) fn max_image_uniforms(context: &Context, stage: ShaderStage) -> GLint {
    let pname = match stage {
        ShaderStage::Compute => glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS,
        ShaderStage::Fragment => glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
        ShaderStage::Geometry => glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS,
        ShaderStage::TessControl => glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
        ShaderStage::TessEval => glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
        ShaderStage::Vertex => glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
    };
    let mut max_image_uniforms: GLint = 0;

    // SAFETY: one integer of output is given.
    unsafe { context.gl().get_integerv(pname, &mut max_image_uniforms) };
    max_image_uniforms
}

/// `Utils::isGLVersionAtLeast`
pub(super) fn is_gl_version_at_least(
    gl: &glw::Functions,
    required_major: GLint,
    required_minor: GLint,
) -> Result<bool, TestError> {
    let mut major: GLint = 0;
    let mut minor: GLint = 0;
    gl_call!(gl, "GetIntegerv", gl.get_integerv(glw::GL_MAJOR_VERSION, &mut major));
    gl_call!(gl, "GetIntegerv", gl.get_integerv(glw::GL_MINOR_VERSION, &mut minor));
    Ok(major > required_major || (major == required_major && minor >= required_minor))
}

/// `Utils::replaceToken`: replaces the first `token` at or after `search_position` and moves the position behind the text.
pub(super) fn replace_token(token: &str, search_position: &mut usize, text: &[u8], string: &mut Vec<u8>) {
    let token_position = *search_position
        + find(&string[*search_position..], token.as_bytes()).expect("the token is present in the template");
    string.splice(token_position..token_position + token.len(), text.iter().copied());
    *search_position = token_position + text.len();
}

/// `Utils::replaceAllTokens`
pub(super) fn replace_all_tokens(token: &str, text: &[u8], string: &mut Vec<u8>) {
    let mut search_position = 0;
    while let Some(offset) = find(&string[search_position..], token.as_bytes()) {
        let token_position = search_position + offset;
        search_position = token_position + text.len();
        string.splice(token_position..token_position + token.len(), text.iter().copied());
    }
}

fn find(haystack: &[u8], needle: &[u8]) -> Option<usize> {
    haystack.windows(needle.len()).position(|window| window == needle)
}

/// Which of `APITestBase`, `GLSLTestBase` and `NegativeTestBase` a case derives from.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    Api,
    Glsl,
    Negative,
}

const COLOR_TEXTURE_INTERNAL_FORMAT: GLenum = glw::GL_RGBA8;
const COLOR_TEXTURE_FORMAT: GLenum = glw::GL_RGBA;
const COLOR_TEXTURE_TYPE: GLenum = glw::GL_UNSIGNED_BYTE;
const COLOR_TEXTURE_WIDTH: GLuint = 16;
const COLOR_TEXTURE_HEIGHT: GLuint = 16;

/// The virtual methods of `TestBase` and its three bases. Every hook has upstream's default.
pub(super) trait Case420: Send + Sync {
    const KIND: Kind;

    fn name(&self) -> &str;

    /// `getShaderSourceConfig`: number of source parts and whether lengths are given.
    fn shader_source_config(&self, case_index: usize) -> (usize, bool) {
        let _ = case_index;
        (1, false)
    }

    /// `prepareNextTestCase`
    fn has_test_case(&self, case_index: usize) -> bool {
        case_index == 0
    }

    /// `prepareShaderSource`
    fn prepare_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        case_index: usize,
        out_source: &mut ShaderSource,
    );

    /// `prepareUniforms`
    fn prepare_uniforms(&self, program: &Program, case_index: usize) -> Result<(), TestError> {
        let _ = (program, case_index);
        Ok(())
    }

    /// `testInit`
    fn test_init(&self, context: &Context) -> Result<bool, TestError> {
        let _ = context;
        Ok(true)
    }

    /// `GLSLTestBase::prepareSourceTexture`: the sampler name to bind the source texture to.
    fn prepare_source_texture(
        &self,
        context: &Context,
        texture: &mut Texture,
        case_index: usize,
    ) -> Result<Option<&'static str>, TestError> {
        let _ = (context, texture, case_index);
        Ok(None)
    }

    /// `GLSLTestBase::prepareVertexBuffer`
    fn prepare_vertex_buffer(
        &self,
        program: &Program,
        buffer: &mut Buffer,
        vao: &mut VertexArray,
        case_index: usize,
    ) -> Result<(), TestError> {
        let _ = (program, buffer, case_index);
        vao.generate()?;
        vao.bind()
    }

    /// `GLSLTestBase::verifyAdditionalResults`
    fn verify_additional_results(&self, context: &Context, case_index: usize) -> Result<bool, TestError> {
        let _ = (context, case_index);
        Ok(true)
    }

    /// `GLSLTestBase::releaseResource`
    fn release_resource(&self, context: &Context) {
        let _ = context;
    }

    /// `APITestBase::checkResults`
    fn check_program_results(&self, program: &Program, case_index: usize) -> Result<bool, TestError> {
        let _ = (program, case_index);
        fail("APITestBase::checkResults is not implemented")
    }
}

/// The `prepareSourceTexture` shared by the sampling cases: a 64x64 grey texture with a blue 32x32 square in the middle; returns the sampler name.
pub(super) fn prepare_blue_square_texture(texture: &mut Texture) -> Result<&'static str, TestError> {
    const WIDTH: GLuint = 64;
    const HEIGHT: GLuint = 64;
    const BLUE_COLOR: GLuint = 0xffff0000;
    const GREY_COLOR: GLuint = 0xaaaaaaaa;

    let mut data = vec![GREY_COLOR; (WIDTH * HEIGHT) as usize];

    for y in 16..48 {
        for x in 16..48 {
            data[(x + y * 64) as usize] = BLUE_COLOR;
        }
    }

    texture.create(WIDTH, HEIGHT, glw::GL_RGBA8)?;
    texture.update(
        WIDTH,
        HEIGHT,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        data.as_ptr().cast(),
    )?;

    Ok("uni_sampler")
}

/// `TestBase` as a `glu::TestCase` for one `Case420`.
pub(super) struct Test420<C: Case420>(pub(super) C);

impl<C: Case420> Test420<C> {
    /// `TestBase::initShaderSource`
    fn init_shader_source(
        &self,
        context: &Context,
        stage: ShaderStage,
        use_version_400: bool,
        case_index: usize,
    ) -> ShaderSource {
        let (n_parts, use_lengths) = self.0.shader_source_config(case_index);
        let mut source = ShaderSource {
            parts: vec![objects::ShaderPart::default(); n_parts],
            use_lengths,
        };

        self.0
            .prepare_shader_source(context, stage, use_version_400, case_index, &mut source);

        for part in &mut source.parts {
            if use_lengths {
                part.length = part.code.len() as GLint;
                part.code
                    .extend_from_slice(b"This should be ignored by compiler, as source length is provided");
            } else {
                part.length = 0;
            }
        }
        source
    }

    fn draw_sources(&self, context: &Context, use_version_400: bool, case_index: usize) -> [ShaderSource; 5] {
        [
            self.init_shader_source(context, ShaderStage::Fragment, use_version_400, case_index),
            self.init_shader_source(context, ShaderStage::Geometry, use_version_400, case_index),
            self.init_shader_source(context, ShaderStage::TessControl, use_version_400, case_index),
            self.init_shader_source(context, ShaderStage::TessEval, use_version_400, case_index),
            self.init_shader_source(context, ShaderStage::Vertex, use_version_400, case_index),
        ]
    }

    fn build_draw_program<'a>(
        &self,
        context: &'a Context,
        sources: &[ShaderSource; 5],
    ) -> Result<(Program<'a>, BuildOutcome), TestError> {
        let mut program = Program::new(context);
        let outcome = program.build(
            &ProgramSources {
                compute: None,
                fragment: Some(&sources[0]),
                geometry: Some(&sources[1]),
                tess_control: Some(&sources[2]),
                tess_evaluation: Some(&sources[3]),
                vertex: Some(&sources[4]),
            },
            false,
        )?;
        Ok((program, outcome))
    }

    /// The `testCompute` build of the three bases, `None` when `GLSLTestBase` / `APITestBase` skip an empty compute source.
    fn build_compute_program<'a>(
        &self,
        context: &'a Context,
        source: &ShaderSource,
    ) -> Result<(Program<'a>, BuildOutcome), TestError> {
        let mut program = Program::new(context);
        let outcome = program.build(
            &ProgramSources {
                compute: Some(source),
                ..Default::default()
            },
            false,
        )?;
        Ok((program, outcome))
    }

    /// `NegativeTestBase::testCompute` and `testDrawArray`: the build must fail.
    fn negative_outcome(outcome: &BuildOutcome) -> bool {
        match outcome {
            BuildOutcome::Built => false,
            BuildOutcome::CompileFailed { message, .. } => {
                log::info!("Shader compilation error message: {message}");
                true
            }
            BuildOutcome::LinkFailed { message } => {
                log::info!("Program linking failed. Error message: {message}");
                true
            }
        }
    }

    /// `testCompute` of the case's base
    fn test_compute(&self, context: &Context, case_index: usize) -> Result<bool, TestError> {
        let compute_shader = self.init_shader_source(context, ShaderStage::Compute, false, case_index);

        if C::KIND != Kind::Negative && compute_shader.first_part_empty() {
            return Ok(true);
        }

        let (program, outcome) = self.build_compute_program(context, &compute_shader)?;

        match C::KIND {
            Kind::Negative => Ok(Self::negative_outcome(&outcome)),
            Kind::Api => {
                if !outcome.report_failure() {
                    return Ok(false);
                }
                program.use_program()?;
                self.0.check_program_results(&program, case_index)
            }
            Kind::Glsl => {
                if !outcome.report_failure() {
                    return Ok(false);
                }
                let gl = context.gl();
                let mut color_tex = Texture::new(context);
                let mut source_tex = Texture::new(context);

                program.use_program()?;

                color_tex.create(COLOR_TEXTURE_WIDTH, COLOR_TEXTURE_HEIGHT, COLOR_TEXTURE_INTERNAL_FORMAT)?;
                gl_call!(
                    gl,
                    "BindImageTexture",
                    gl.bind_image_texture(
                        0,
                        color_tex.id,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        glw::GL_WRITE_ONLY,
                        glw::GL_RGBA8
                    )
                );
                let location = program.get_uniform_location("uni_image")?;
                gl_call!(gl, "Uniform1i", gl.uniform_1i(location, 0));

                if let Some(sampler_name) = self.0.prepare_source_texture(context, &mut source_tex, case_index)? {
                    Self::bind_texture_to_sampler(context, &program, &source_tex, sampler_name)?;
                }

                self.0.prepare_uniforms(&program, case_index)?;

                gl_call!(
                    gl,
                    "DispatchCompute",
                    gl.dispatch_compute(COLOR_TEXTURE_WIDTH, COLOR_TEXTURE_HEIGHT, 1)
                );

                let result = self.check_color_results(context, &color_tex, case_index)?;
                self.0.release_resource(context);
                Ok(result)
            }
        }
    }

    /// `GLSLTestBase::bindTextureToSampler`
    fn bind_texture_to_sampler(
        context: &Context,
        program: &Program,
        texture: &Texture,
        uniform_name: &str,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        gl_call!(gl, "ActiveTexture", gl.active_texture(glw::GL_TEXTURE0));
        texture.bind()?;
        let location = program.get_uniform_location(uniform_name)?;
        gl_call!(gl, "Uniform1i", gl.uniform_1i(location, 0));
        Ok(())
    }

    /// `GLSLTestBase::checkResults(Utils::texture &)`
    fn check_color_results(
        &self,
        context: &Context,
        color_texture: &Texture,
        case_index: usize,
    ) -> Result<bool, TestError> {
        const GREEN_COLOR: GLuint = 0xff00ff00;
        let mut texture_data = vec![0 as GLuint; (COLOR_TEXTURE_WIDTH * COLOR_TEXTURE_HEIGHT) as usize];

        color_texture.get(
            COLOR_TEXTURE_FORMAT,
            COLOR_TEXTURE_TYPE,
            texture_data.as_mut_ptr().cast(),
        )?;

        for (i, &texel) in texture_data.iter().enumerate() {
            if texel != GREEN_COLOR {
                log::info!("Invalid texel: {texel:08x} at index: {i}");
                return Ok(false);
            }
        }

        self.0.verify_additional_results(context, case_index)
    }

    /// `testDrawArray` of the case's base
    fn test_draw_array(&self, context: &Context, use_version_400: bool, case_index: usize) -> Result<bool, TestError> {
        let sources = self.draw_sources(context, use_version_400, case_index);
        let (program, outcome) = self.build_draw_program(context, &sources)?;

        match C::KIND {
            Kind::Negative => Ok(Self::negative_outcome(&outcome)),
            Kind::Api => {
                if !outcome.report_failure() {
                    return Ok(false);
                }
                program.use_program()?;
                self.0.check_program_results(&program, case_index)
            }
            Kind::Glsl => {
                if !outcome.report_failure() {
                    return Ok(false);
                }
                let gl = context.gl();
                let mut color_tex = Texture::new(context);
                let mut framebuffer = Framebuffer::new(context);
                let mut source_tex = Texture::new(context);
                let mut vao = VertexArray::new(context);
                let mut vertex_buffer = Buffer::new(context);

                self.0
                    .prepare_vertex_buffer(&program, &mut vertex_buffer, &mut vao, case_index)?;
                program.use_program()?;

                framebuffer.generate()?;
                color_tex.create(COLOR_TEXTURE_WIDTH, COLOR_TEXTURE_HEIGHT, COLOR_TEXTURE_INTERNAL_FORMAT)?;
                framebuffer.attach_texture(
                    glw::GL_COLOR_ATTACHMENT0,
                    color_tex.id,
                    COLOR_TEXTURE_WIDTH,
                    COLOR_TEXTURE_HEIGHT,
                )?;
                framebuffer.clear_color(0.0, 0.0, 0.0, 0.0)?;
                framebuffer.clear(glw::GL_COLOR_BUFFER_BIT)?;

                if let Some(sampler_name) = self.0.prepare_source_texture(context, &mut source_tex, case_index)? {
                    Self::bind_texture_to_sampler(context, &program, &source_tex, sampler_name)?;
                }

                self.0.prepare_uniforms(&program, case_index)?;

                gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_PATCHES, 0, 1));

                let result = self.check_color_results(context, &color_tex, case_index)?;
                self.0.release_resource(context);
                Ok(result)
            }
        }
    }

    /// `TestBase::test`
    fn test(
        &self,
        context: &Context,
        is_shader_language_420pack: bool,
        is_compute_shader_supported: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut case_index = 0;

        self.0.test_init(context)?;

        gl_call!(gl, "PatchParameteri", gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));

        while self.0.has_test_case(case_index) {
            let mut case_result = true;

            if !self.test_draw_array(context, false, case_index)? {
                case_result = false;
            }

            if is_shader_language_420pack && !self.test_draw_array(context, true, case_index)? {
                case_result = false;
            }

            if is_compute_shader_supported && !self.test_compute(context, case_index)? {
                case_result = false;
            }

            if !case_result {
                log::info!("Test case failed.");
                result = false;
            }

            case_index += 1;
        }

        Ok(result)
    }
}

impl<C: Case420> TestCase for Test420<C> {
    fn name(&self) -> &str {
        self.0.name()
    }

    /// `TestBase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let is_shader_language_420pack = context
            .context_info
            .is_extension_supported("GL_ARB_shading_language_420pack");
        let is_compute_shader_supported = is_gl_version_at_least(gl, 4, 3)?;

        if self.test(context, is_shader_language_420pack, is_compute_shader_supported)? {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

fn boxed<C: Case420 + 'static>(case: C) -> Box<dyn TestCase> {
    Box::new(Test420(case))
}

/// `ShadingLanguage420PackTests::init`, in upstream's order for the cases ported so far.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shading_language_420pack");
    for stage in binding_sampler::SINGLE_STAGES {
        group.add_child(boxed(binding_sampler::BindingSamplerSingle::new(stage)));
    }
    for stage in binding_image::SINGLE_STAGES {
        group.add_child(boxed(binding_image::BindingImageSingle::new(stage)));
    }
    let qualifier_order_cases = qualifier_order::cases();
    let qualifier_order_family = |group: &mut TestCaseGroup, families: &[qualifier_order::Family]| {
        for (family, sets) in &qualifier_order_cases {
            if families.contains(family) {
                for (test_id, set) in sets.iter().enumerate() {
                    group.add_child(boxed(qualifier_order::QualifierOrder::new(
                        *family,
                        test_id,
                        set.clone(),
                    )));
                }
            }
        }
    };

    for case in utf8::CHARACTERS_CASES {
        group.add_child(boxed(utf8::Utf8Characters::new(case.0, case.1)));
    }
    for character in utf8::IN_SOURCE_CHARACTERS {
        group.add_child(boxed(utf8::Utf8InSource::new(character)));
    }
    qualifier_order_family(
        &mut group,
        &[qualifier_order::Family::Plain, qualifier_order::Family::Block],
    );
    for case in line_continuation::cases() {
        group.add_child(boxed(case));
    }
    group.add_child(boxed(line_numbering::LineNumbering));
    for case in implicit_conversions::valid_cases() {
        group.add_child(boxed(case));
    }
    group.add_child(boxed(implicit_conversions::ImplicitConversionsInvalid));
    group.add_child(boxed(const_values::ConstDynamicValue));
    group.add_child(boxed(const_values::ConstAssignment));
    group.add_child(boxed(const_values::ConstDynamicValueAsConstExpr));
    qualifier_order_family(
        &mut group,
        &[
            qualifier_order::Family::Uniform,
            qualifier_order::Family::FunctionInout,
            qualifier_order::Family::FunctionInput,
            qualifier_order::Family::FunctionOutput,
        ],
    );
    group.add_child(boxed(binding_uniform::QualifierOverrideLayout));
    group.add_child(boxed(binding_uniform::BindingUniformBlocks::default()));
    for stage in binding_uniform::SINGLE_BLOCK_STAGES {
        group.add_child(boxed(binding_uniform::BindingUniformSingleBlock::new(stage)));
    }
    group.add_child(boxed(binding_uniform::BindingUniformBlockArray::default()));
    group.add_child(boxed(binding_uniform::BindingUniformDefault));
    group.add_child(boxed(binding_uniform::BindingUniformApiOverride::default()));
    group.add_child(boxed(binding_uniform::BindingUniformGlobalBlock));
    for binding in binding_uniform::INVALID_BINDINGS {
        group.add_child(boxed(binding_uniform::BindingUniformInvalid::new(binding)));
    }
    for texture_type in binding_sampler::SAMPLERS_TEXTURE_TYPES {
        group.add_child(boxed(binding_sampler::BindingSamplers::new(texture_type)));
    }
    group.add_child(boxed(binding_sampler::BindingSamplerArray::default()));
    group.add_child(boxed(binding_sampler::BindingSamplerDefault));
    group.add_child(boxed(binding_sampler::BindingSamplerApiOverride::default()));
    for binding in binding_sampler::INVALID_BINDINGS {
        group.add_child(boxed(binding_sampler::BindingSamplerInvalid::new(binding)));
    }
    for texture_type in binding_sampler::SAMPLERS_TEXTURE_TYPES {
        group.add_child(boxed(binding_image::BindingImages::new(texture_type)));
    }
    group.add_child(boxed(binding_image::BindingImageArray::default()));
    group.add_child(boxed(binding_image::BindingImageDefault));
    group.add_child(boxed(binding_image::BindingImageApiOverride::default()));
    for binding in binding_image::INVALID_BINDINGS {
        group.add_child(boxed(binding_image::BindingImageInvalid::new(binding)));
    }
    for case in initializer_list::cases() {
        group.add_child(boxed(case));
    }
    for error in initializer_list::TESTED_ERRORS {
        group.add_child(boxed(initializer_list::InitializerListNegative::new(error)));
    }
    for case in length_of::cases() {
        group.add_child(boxed(case));
    }
    group.add_child(boxed(scalar_and_builtin::LengthOfComputeResult));
    group.add_child(boxed(scalar_and_builtin::ScalarSwizzlers));
    for case in scalar_and_builtin::SWIZZLER_INVALID_CASES {
        group.add_child(boxed(scalar_and_builtin::ScalarSwizzlersInvalid::new(case)));
    }
    group.add_child(boxed(scalar_and_builtin::BuiltInValues::default()));
    for test_case in 0..2 {
        group.add_child(boxed(scalar_and_builtin::BuiltInAssignment::new(test_case)));
    }
    group
}

/// `TestBase::getStageSpecificLayout`
pub(super) fn stage_specific_layout(stage: ShaderStage) -> &'static str {
    match stage {
        ShaderStage::Geometry => {
            "layout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n"
        }
        ShaderStage::TessControl => "layout(vertices = 1)                     out;\n",
        ShaderStage::TessEval => "layout(isolines, point_mode)             in;\n",
        _ => "",
    }
}

/// `TestBase::getVersionString`
pub(super) fn version_string(stage: ShaderStage, use_version_400: bool) -> &'static str {
    if stage == ShaderStage::Compute {
        "#version 430"
    } else if use_version_400 {
        "#version 400\n#extension GL_ARB_shading_language_420pack : require\n#extension GL_ARB_separate_shader_objects : enable"
    } else {
        "#version 420"
    }
}
