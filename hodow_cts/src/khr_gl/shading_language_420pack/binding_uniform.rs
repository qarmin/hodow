// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (QualifierOverrideLayoutTest, BindingUniformBlocksTest, BindingUniformSingleBlockTest, BindingUniformBlockArrayTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The member `Utils::buffer`s of the upstream classes are a `BufferStash` released by `release_resource`.

use std::ffi::{CString, c_void};

use super::objects::{Buffer, BufferStash, Program, ShaderSource, VertexArray};
use super::qualifiers::{VariableStorage, variable_name};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, replace_all_tokens, replace_token, version_string};
use crate::glu::Context;
use crate::glw::{self, GLfloat, GLint, GLuint};
use crate::tcu::TestError;

/// `QualifierOverrideLayoutTest`
pub(super) struct QualifierOverrideLayout;

impl Case420 for QualifierOverrideLayout {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "qualifier_override_layout"
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
            compute: "",
            fragment: QUALIFIER_OVERRIDE_LAYOUT_FRAGMENT_SHADER_TEMPLATE,
            geometry: QUALIFIER_OVERRIDE_LAYOUT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: QUALIFIER_OVERRIDE_LAYOUT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: QUALIFIER_OVERRIDE_LAYOUT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: QUALIFIER_OVERRIDE_LAYOUT_VERTEX_SHADER_TEMPLATE,
        };

        if stage == ShaderStage::Compute {
            return;
        }

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
    }

    fn prepare_vertex_buffer(
        &self,
        program: &Program,
        buffer: &mut Buffer,
        vao: &mut VertexArray,
        _case_index: usize,
    ) -> Result<(), TestError> {
        const EXPECTED_LOCATION: GLint = 2;

        let gl = program.context().gl();
        let test_name = variable_name(ShaderStage::Vertex, VariableStorage::Input, "test");
        let test_loc = program.get_attrib_location(&test_name)?;

        if test_loc != EXPECTED_LOCATION {
            return super::fail("Vertex attribute location is invalid");
        }

        vao.generate()?;
        vao.bind()?;

        buffer.generate(glw::GL_ARRAY_BUFFER)?;
        let data: [GLfloat; 4] = [0.0, 1.0, 0.0, 1.0];
        buffer.update(
            std::mem::size_of_val(&data) as glw::GLsizeiptr,
            data.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        )?;

        gl_call!(
            gl,
            "VertexAttribPointer",
            gl.vertex_attrib_pointer(
                test_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "EnableVertexAttribArray",
            gl.enable_vertex_attrib_array(test_loc as GLuint)
        );
        Ok(())
    }
}

/// `BindingUniformBlocksTest`
#[derive(Default)]
pub(super) struct BindingUniformBlocks {
    buffers: BufferStash,
}

impl Case420 for BindingUniformBlocks {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_uniform_blocks"
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
            compute: BINDING_UNIFORM_BLOCKS_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_BLOCKS_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_BLOCKS_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_BLOCKS_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_BLOCKS_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_BLOCKS_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_BLOCKS_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_UNIFORM_BLOCKS_UNI_GOKU.as_bytes(), code);
        replace_all_tokens("UNI_VEGETA", BINDING_UNIFORM_BLOCKS_UNI_VEGETA.as_bytes(), code);
        replace_all_tokens("UNI_CHILDREN", BINDING_UNIFORM_BLOCKS_UNI_CHILDREN.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [GLfloat; 4] = [1.0, 0.0, 0.0, 0.0];
        const VEGETA_DATA: [GLfloat; 3] = [0.0, 1.0, 0.0];
        const CHILDREN_DATA: [GLfloat; 8] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];

        let context = program.context();
        self.buffers
            .add_bound_range(context, glw::GL_UNIFORM_BUFFER, 0, &GOKU_DATA)?;
        self.buffers
            .add_bound_range(context, glw::GL_UNIFORM_BUFFER, 1, &VEGETA_DATA)?;
        self.buffers
            .add_bound_range(context, glw::GL_UNIFORM_BUFFER, 3, &CHILDREN_DATA)
    }

    fn release_resource(&self, context: &Context) {
        self.buffers.release(context);
    }
}

/// `BindingUniformSingleBlockTest`
pub(super) struct BindingUniformSingleBlock {
    name: String,
    test_stage: ShaderStage,
    buffers: BufferStash,
}

impl BindingUniformSingleBlock {
    pub(super) fn new(test_stage: ShaderStage) -> Self {
        Self {
            name: format!("binding_uniform_single_block_stage_{}", test_stage.name()),
            test_stage,
            buffers: BufferStash::default(),
        }
    }
}

/// `addBindingUniformSingleBlockTest`
pub(super) const SINGLE_BLOCK_STAGES: [ShaderStage; 5] = [
    ShaderStage::Vertex,
    ShaderStage::TessControl,
    ShaderStage::TessEval,
    ShaderStage::Geometry,
    ShaderStage::Fragment,
];

impl Case420 for BindingUniformSingleBlock {
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
            compute: BINDING_UNIFORM_SINGLE_BLOCK_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_SINGLE_BLOCK_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_SINGLE_BLOCK_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_SINGLE_BLOCK_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_SINGLE_BLOCK_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_SINGLE_BLOCK_VERTEX_SHADER_TEMPLATE,
        };

        let uniform_definition = if stage == ShaderStage::Compute || stage == self.test_stage {
            BINDING_UNIFORM_SINGLE_BLOCK_UNI_GOKU_WITH_BINDING
        } else {
            BINDING_UNIFORM_SINGLE_BLOCK_UNI_GOKU_NO_BINDING
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_SINGLE_BLOCK_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", uniform_definition.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [GLfloat; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];

        self.buffers
            .add_bound_range(program.context(), glw::GL_UNIFORM_BUFFER, 0, &GOKU_DATA)
    }

    fn release_resource(&self, context: &Context) {
        self.buffers.release(context);
    }
}

/// `BindingUniformBlockArrayTest`
#[derive(Default)]
pub(super) struct BindingUniformBlockArray {
    buffers: BufferStash,
}

impl BindingUniformBlockArray {
    /// `BindingUniformBlockArrayTest::checkBinding`
    fn check_binding(program: &Program, index: GLuint, expected_binding: GLint) -> Result<(), TestError> {
        let gl = program.context().gl();
        let name = CString::new(format!("GOKU[{index}]")).expect("names have no NUL");

        // SAFETY: the name is a live NUL-terminated string.
        let uniform_index = unsafe { gl.get_uniform_block_index(program.program_object_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformBlockIndex")?;

        if uniform_index == glw::GL_INVALID_INDEX {
            return super::fail("Uniform block is inactive");
        }

        let mut binding: GLint = -1;
        gl_call!(
            gl,
            "GetActiveUniformBlockiv",
            gl.get_active_uniform_blockiv(
                program.program_object_id,
                uniform_index,
                glw::GL_UNIFORM_BLOCK_BINDING,
                &mut binding
            )
        );

        if expected_binding != binding {
            return super::fail("Wrong binding reported by API");
        }
        Ok(())
    }
}

impl Case420 for BindingUniformBlockArray {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_uniform_block_array"
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
            compute: BINDING_UNIFORM_BLOCK_ARRAY_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_BLOCK_ARRAY_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_BLOCK_ARRAY_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_BLOCK_ARRAY_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_BLOCK_ARRAY_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_BLOCK_ARRAY_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_BLOCK_ARRAY_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_UNIFORM_BLOCK_ARRAY_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [[GLfloat; 8]; 14] = [
            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0],
            [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0],
            [1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0],
            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0],
            [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0],
        ];

        for (i, data) in GOKU_DATA.iter().enumerate() {
            let index = i as GLuint;
            Self::check_binding(program, index, index as GLint + 2)?;
            self.buffers
                .add_bound_range(program.context(), glw::GL_UNIFORM_BUFFER, index + 2, data)?;
        }
        Ok(())
    }

    fn release_resource(&self, context: &Context) {
        self.buffers.release(context);
    }
}

/// `BindingUniformDefaultTest`
pub(super) struct BindingUniformDefault;

impl Case420 for BindingUniformDefault {
    const KIND: Kind = Kind::Api;

    fn name(&self) -> &str {
        "binding_uniform_default"
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
            compute: BINDING_UNIFORM_DEFAULT_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_DEFAULT_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_DEFAULT_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_DEFAULT_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_DEFAULT_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_DEFAULT_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_DEFAULT_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_UNIFORM_DEFAULT_UNI_GOKU.as_bytes(), code);
    }

    fn check_program_results(&self, program: &Program, _case_index: usize) -> Result<bool, TestError> {
        let gl = program.context().gl();
        let name = c"GOKU";

        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_uniform_block_index(program.program_object_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformBlockIndex")?;

        if index == glw::GL_INVALID_INDEX {
            return super::fail("Uniform block is inactive");
        }

        let mut binding: GLint = -1;
        gl_call!(
            gl,
            "GetActiveUniformBlockiv",
            gl.get_active_uniform_blockiv(
                program.program_object_id,
                index,
                glw::GL_UNIFORM_BLOCK_BINDING,
                &mut binding
            )
        );

        Ok(binding == 0)
    }
}

/// `BindingUniformAPIOverirdeTest`
#[derive(Default)]
pub(super) struct BindingUniformApiOverride {
    buffers: BufferStash,
}

impl Case420 for BindingUniformApiOverride {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        "binding_uniform_api_overirde"
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
            compute: BINDING_UNIFORM_API_OVERRIDE_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_API_OVERRIDE_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_API_OVERRIDE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_API_OVERRIDE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_API_OVERRIDE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_API_OVERRIDE_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_API_OVERRIDE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("UNI_GOKU", BINDING_UNIFORM_API_OVERRIDE_UNI_GOKU.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const GOKU_DATA: [GLfloat; 8] = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
        const NEW_BINDING: GLuint = 11;

        let context = program.context();
        let gl = context.gl();

        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_uniform_block_index(program.program_object_id, c"GOKU".as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformBlockIndex")?;

        if index == glw::GL_INVALID_INDEX {
            return super::fail("Uniform block is inactive");
        }

        gl_call!(
            gl,
            "UniformBlockBinding",
            gl.uniform_block_binding(program.program_object_id, index, NEW_BINDING)
        );

        let mut binding: GLint = -1;
        gl_call!(
            gl,
            "GetActiveUniformBlockiv",
            gl.get_active_uniform_blockiv(
                program.program_object_id,
                index,
                glw::GL_UNIFORM_BLOCK_BINDING,
                &mut binding
            )
        );

        if NEW_BINDING as GLint != binding {
            return super::fail("GetActiveUniformBlockiv returned wrong binding");
        }

        self.buffers
            .add_bound_range(context, glw::GL_UNIFORM_BUFFER, NEW_BINDING, &GOKU_DATA)
    }

    fn release_resource(&self, context: &Context) {
        self.buffers.release(context);
    }
}

/// `BindingUniformGlobalBlockTest`
pub(super) struct BindingUniformGlobalBlock;

impl Case420 for BindingUniformGlobalBlock {
    const KIND: Kind = Kind::Negative;

    fn name(&self) -> &str {
        "binding_uniform_global_block"
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
            compute: BINDING_UNIFORM_GLOBAL_BLOCK_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_GLOBAL_BLOCK_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_GLOBAL_BLOCK_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_GLOBAL_BLOCK_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_GLOBAL_BLOCK_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_GLOBAL_BLOCK_VERTEX_SHADER_TEMPLATE,
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "UNIFORM_DEFINITION",
            &mut position,
            BINDING_UNIFORM_GLOBAL_BLOCK_UNIFORM_DEFINITION.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_GLOBAL_BLOCK_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
    }
}

/// `BindingUniformInvalidTest::TESTCASES` without `TEST_CASES_MAX`
#[derive(Clone, Copy)]
pub(super) enum InvalidBinding {
    NegativeValue,
    VariableName,
    Std140,
    Missing,
}

/// `addBindingUniformInvalidTest`
pub(super) const INVALID_BINDINGS: [InvalidBinding; 4] = [
    InvalidBinding::NegativeValue,
    InvalidBinding::VariableName,
    InvalidBinding::Std140,
    InvalidBinding::Missing,
];

/// `BindingUniformInvalidTest`
pub(super) struct BindingUniformInvalid {
    name: String,
    binding: InvalidBinding,
}

impl BindingUniformInvalid {
    pub(super) fn new(binding: InvalidBinding) -> Self {
        let case_name = match binding {
            InvalidBinding::NegativeValue => "-1",
            InvalidBinding::VariableName => "goku",
            InvalidBinding::Std140 => "std140",
            InvalidBinding::Missing => "",
        };
        Self {
            name: format!("binding_uniform_invalid_case_{case_name}"),
            binding,
        }
    }
}

impl Case420 for BindingUniformInvalid {
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
            compute: BINDING_UNIFORM_INVALID_COMPUTE_SHADER_TEMPLATE,
            fragment: BINDING_UNIFORM_INVALID_FRAGMENT_SHADER_TEMPLATE,
            geometry: BINDING_UNIFORM_INVALID_GEOMETRY_SHADER_TEMPLATE,
            tess_control: BINDING_UNIFORM_INVALID_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: BINDING_UNIFORM_INVALID_TESS_EVAL_SHADER_TEMPLATE,
            vertex: BINDING_UNIFORM_INVALID_VERTEX_SHADER_TEMPLATE,
        };

        let binding = match self.binding {
            InvalidBinding::NegativeValue => "-1",
            InvalidBinding::VariableName => "goku",
            InvalidBinding::Std140 => "std140",
            InvalidBinding::Missing => "missing",
        };

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token(
            "UNIFORM_DEFINITION",
            &mut position,
            BINDING_UNIFORM_INVALID_UNIFORM_DEFINITION.as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            BINDING_UNIFORM_INVALID_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        replace_all_tokens("BINDING", binding.as_bytes(), code);
    }
}
