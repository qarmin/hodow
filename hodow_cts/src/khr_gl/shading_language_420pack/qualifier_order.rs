// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (QualifierOrderTest, QualifierOrderBlockTest, QualifierOrderUniformTest, QualifierOrderFunction{Inout,Input,Output}Test)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six upstream classes differ only in templates, replacement steps and uniforms, so they are one `QualifierOrder` driven by a `Family`. `QualifierOrderUniformTest::testInit` (its result is ignored by `TestBase::test`) is left out; none of these shaders is built for the compute stage (upstream returns before filling the source, so the case is skipped there).

use std::ffi::c_void;

use super::objects::{Buffer, Program, ShaderSource, VertexArray};
use super::qualifiers::Qualifier::*;
use super::qualifiers::{
    QualifierSet, VariableStorage, prepare_block_variable_strings, prepare_variable_strings, qualifiers_list_string,
    variable_name,
};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, replace_all_tokens, replace_token, version_string};
use crate::glu::Context;
use crate::glw::{self, GLfloat, GLuint};
use crate::tcu::TestError;

/// Which upstream class a `QualifierOrder` stands for.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Family {
    Plain,
    Block,
    Uniform,
    FunctionInout,
    FunctionInput,
    FunctionOutput,
}

impl Family {
    fn name_prefix(self) -> &'static str {
        match self {
            Self::Plain => "qualifier_order_test_id_",
            Self::Block => "qualifier_order_block_test_id_",
            Self::Uniform => "qualifier_order_uniform_test_id_",
            Self::FunctionInout => "qualifier_order_function_inout_test_id_",
            Self::FunctionInput => "qualifier_order_function_input_test_id_",
            Self::FunctionOutput => "qualifier_order_function_output_test_id_",
        }
    }

    fn templates(self) -> StageTemplates {
        match self {
            Self::Plain => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_VERTEX_SHADER_TEMPLATE,
            },
            Self::Block => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_BLOCK_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_BLOCK_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_BLOCK_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_BLOCK_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_BLOCK_VERTEX_SHADER_TEMPLATE,
            },
            Self::Uniform => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_UNIFORM_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_UNIFORM_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_UNIFORM_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_UNIFORM_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_UNIFORM_VERTEX_SHADER_TEMPLATE,
            },
            Self::FunctionInout => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_FUNCTION_INOUT_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_FUNCTION_INOUT_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_FUNCTION_INOUT_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_FUNCTION_INOUT_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_FUNCTION_INOUT_VERTEX_SHADER_TEMPLATE,
            },
            Self::FunctionInput => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_FUNCTION_INPUT_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_FUNCTION_INPUT_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_FUNCTION_INPUT_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_FUNCTION_INPUT_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_FUNCTION_INPUT_VERTEX_SHADER_TEMPLATE,
            },
            Self::FunctionOutput => StageTemplates {
                compute: "",
                fragment: QUALIFIER_ORDER_FUNCTION_OUTPUT_FRAGMENT_SHADER_TEMPLATE,
                geometry: QUALIFIER_ORDER_FUNCTION_OUTPUT_GEOMETRY_SHADER_TEMPLATE,
                tess_control: QUALIFIER_ORDER_FUNCTION_OUTPUT_TESS_CTRL_SHADER_TEMPLATE,
                tess_evaluation: QUALIFIER_ORDER_FUNCTION_OUTPUT_TESS_EVAL_SHADER_TEMPLATE,
                vertex: QUALIFIER_ORDER_FUNCTION_OUTPUT_VERTEX_SHADER_TEMPLATE,
            },
        }
    }

    fn verification_snippet(self) -> &'static str {
        match self {
            Self::Plain => QUALIFIER_ORDER_VERIFICATION_SNIPPET,
            Self::Block => QUALIFIER_ORDER_BLOCK_VERIFICATION_SNIPPET,
            Self::Uniform => QUALIFIER_ORDER_UNIFORM_VERIFICATION_SNIPPET,
            Self::FunctionInout => QUALIFIER_ORDER_FUNCTION_INOUT_VERIFICATION_SNIPPET,
            Self::FunctionInput => QUALIFIER_ORDER_FUNCTION_INPUT_VERIFICATION_SNIPPET,
            Self::FunctionOutput => QUALIFIER_ORDER_FUNCTION_OUTPUT_VERIFICATION_SNIPPET,
        }
    }

    fn function_declaration(self) -> &'static str {
        match self {
            Self::FunctionInout => QUALIFIER_ORDER_FUNCTION_INOUT_FUNCTION_DECLARATION,
            Self::FunctionInput => QUALIFIER_ORDER_FUNCTION_INPUT_FUNCTION_DECLARATION,
            Self::FunctionOutput => QUALIFIER_ORDER_FUNCTION_OUTPUT_FUNCTION_DECLARATION,
            _ => unreachable!("only the function families have a function declaration"),
        }
    }
}

/// `addQualifierOrder*Test`: the qualifier permutations of every family.
pub(super) fn cases() -> Vec<(Family, Vec<QualifierSet>)> {
    vec![
        (
            Family::Plain,
            vec![
                vec![Highp, In, Location, Smooth, Invariant],
                vec![Lowp, In, Sample, Location, Noperspective, Invariant],
                vec![Highp, In, Location, Smooth, Invariant, Location],
                vec![Lowp, In, Location, Sample, Location, Noperspective, Invariant],
                vec![Highp, In, Patch, Location, Invariant],
            ],
        ),
        (
            Family::Block,
            vec![
                vec![Highp, Flat, Invariant],
                vec![Lowp, Sample, Noperspective, Invariant],
                vec![Highp, Smooth, Invariant],
                vec![Lowp, Sample, Noperspective, Invariant],
            ],
        ),
        (
            Family::Uniform,
            vec![
                vec![Highp, Uniform, Location],
                vec![Lowp, Uniform, Location],
                vec![Highp, Location, Uniform, Location],
                vec![Location, Lowp, Uniform, Location],
            ],
        ),
        (
            Family::FunctionInout,
            vec![
                vec![Highp, Precise, Inout],
                vec![Inout, Precise, Highp],
                vec![Mediump, Precise, Inout],
                vec![Inout, Precise, Mediump],
                vec![Lowp, Precise, Inout],
                vec![Inout, Precise, Lowp],
            ],
        ),
        (
            Family::FunctionInput,
            vec![
                vec![Const, Highp, Precise, In],
                vec![In, Const, Precise, Highp],
                vec![Precise, Mediump, Const, In],
                vec![In, Precise, Mediump, Const],
                vec![Lowp, Const, In, Precise],
                vec![In, Precise, Const, Lowp],
            ],
        ),
        (
            Family::FunctionOutput,
            vec![
                vec![Highp, Precise, Out],
                vec![Out, Precise, Highp],
                vec![Precise, Mediump, Out],
                vec![Out, Precise, Mediump],
                vec![Lowp, Out, Precise],
                vec![Out, Precise, Lowp],
            ],
        ),
    ]
}

/// `QualifierOrderTest` and its five siblings, one test case each
pub(super) struct QualifierOrder {
    name: String,
    family: Family,
    qualifiers: QualifierSet,
}

impl QualifierOrder {
    pub(super) fn new(family: Family, test_id: usize, qualifiers: QualifierSet) -> Self {
        Self {
            name: format!("{}{test_id}", family.name_prefix()),
            family,
            qualifiers,
        }
    }

    /// The "sample storage qualifier is not a valid qualifier for fragment output" erase of the in/out families.
    fn erase_sample_for_fragment_output(stage: ShaderStage, out_test_decl: &mut String) {
        if stage == ShaderStage::Fragment
            && let Some(position) = out_test_decl.find("sample")
        {
            out_test_decl.replace_range(position..position + 7, "");
        }
    }

    fn prepare_in_out_source(&self, stage: ShaderStage, code: &mut Vec<u8>, version: &str) {
        let (in_test_decl, in_test_ref) = if self.family == Family::Block && stage != ShaderStage::Vertex {
            prepare_block_variable_strings(
                stage,
                VariableStorage::Input,
                &self.qualifiers,
                "vec4",
                "test",
                "input_block",
            )
        } else {
            prepare_variable_strings(stage, VariableStorage::Input, &self.qualifiers, "vec4", "test")
        };
        let (mut out_test_decl, out_test_ref) = if self.family == Family::Block && stage != ShaderStage::Fragment {
            prepare_block_variable_strings(
                stage,
                VariableStorage::Output,
                &self.qualifiers,
                "vec4",
                "test",
                "output_block",
            )
        } else {
            prepare_variable_strings(stage, VariableStorage::Output, &self.qualifiers, "vec4", "test")
        };

        Self::erase_sample_for_fragment_output(stage, &mut out_test_decl);

        let verification_snippet = self.family.verification_snippet();
        let mut position = 0;
        replace_token("VERSION", &mut position, version.as_bytes(), code);
        replace_token("VARIABLE_DECLARATION", &mut position, in_test_decl.as_bytes(), code);
        replace_token("VARIABLE_DECLARATION", &mut position, out_test_decl.as_bytes(), code);
        replace_token("VERIFICATION", &mut position, verification_snippet.as_bytes(), code);
        replace_all_tokens("OUTPUT_VARIABLE_NAME", out_test_ref.as_bytes(), code);
        replace_all_tokens("INPUT_VARIABLE_NAME", in_test_ref.as_bytes(), code);
        replace_all_tokens("LOC_VALUE", b"1", code);
    }

    fn prepare_uniform_source(&self, stage: ShaderStage, code: &mut Vec<u8>, version: &str) {
        let location_string = match stage {
            ShaderStage::Fragment => "0",
            ShaderStage::Geometry => "1",
            ShaderStage::TessControl => "4",
            ShaderStage::TessEval => "3",
            ShaderStage::Vertex => "2",
            ShaderStage::Compute => unreachable!("the compute stage returns before this"),
        };
        let (uni_declaration, uni_reference) =
            prepare_variable_strings(stage, VariableStorage::Uniform, &self.qualifiers, "vec4", "test");

        let mut position = 0;
        replace_token("VERSION", &mut position, version.as_bytes(), code);
        replace_token("VARIABLE_DECLARATION", &mut position, uni_declaration.as_bytes(), code);
        position -= QUALIFIER_ORDER_UNIFORM_VARIABLE_DECLARATION.len();
        replace_token(
            "VERIFICATION",
            &mut position,
            self.family.verification_snippet().as_bytes(),
            code,
        );
        replace_all_tokens("VARIABLE_NAME", uni_reference.as_bytes(), code);
        replace_all_tokens("LOC_VALUE", location_string.as_bytes(), code);
    }

    fn prepare_function_source(&self, stage: ShaderStage, code: &mut Vec<u8>, version: &str) {
        let uni_reference = variable_name(stage, VariableStorage::Uniform, "test");
        let qualifier_list = qualifiers_list_string(&self.qualifiers);
        let function_declaration = self.family.function_declaration();

        let mut position = 0;
        replace_token("VERSION", &mut position, version.as_bytes(), code);
        replace_token(
            "FUNCTION_DECLARATION",
            &mut position,
            function_declaration.as_bytes(),
            code,
        );
        position -= function_declaration.len();
        replace_token("QUALIFIERS_LIST", &mut position, qualifier_list.as_bytes(), code);
        replace_token(
            "VERIFICATION",
            &mut position,
            self.family.verification_snippet().as_bytes(),
            code,
        );
        replace_all_tokens("VARIABLE_NAME", uni_reference.as_bytes(), code);
    }
}

impl Case420 for QualifierOrder {
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
        if stage == ShaderStage::Compute {
            return;
        }

        let code = &mut out_source.parts[0].code;
        *code = self.family.templates().get(stage).as_bytes().to_vec();
        let version = version_string(stage, use_version_400);

        match self.family {
            Family::Plain | Family::Block => self.prepare_in_out_source(stage, code, version),
            Family::Uniform => self.prepare_uniform_source(stage, code, version),
            Family::FunctionInout | Family::FunctionInput | Family::FunctionOutput => {
                self.prepare_function_source(stage, code, version)
            }
        }
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        let float_data: [f32; 4] = match self.family {
            Family::Uniform => [0.0, 0.0, 1.0, 1.0],
            Family::FunctionInout | Family::FunctionInput | Family::FunctionOutput => [1.0, 1.0, 0.0, 0.0],
            Family::Plain | Family::Block => return Ok(()),
        };

        for name in [
            "uni_fs_test",
            "uni_gs_test",
            "uni_tcs_test",
            "uni_tes_test",
            "uni_vs_test",
        ] {
            program.uniform_float(name, 1, 4, &float_data)?;
        }
        Ok(())
    }

    fn prepare_vertex_buffer(
        &self,
        program: &Program,
        buffer: &mut Buffer,
        vao: &mut VertexArray,
        _case_index: usize,
    ) -> Result<(), TestError> {
        if !matches!(self.family, Family::Plain | Family::Block) {
            vao.generate()?;
            return vao.bind();
        }

        let gl = program.context().gl();
        let test_name = variable_name(ShaderStage::Vertex, VariableStorage::Input, "test");
        let test_loc = program.get_attrib_location(&test_name)?;

        if test_loc == -1 {
            return super::fail("Vertex attribute location is invalid");
        }

        vao.generate()?;
        vao.bind()?;

        buffer.generate(glw::GL_ARRAY_BUFFER)?;
        let data: [GLfloat; 4] = [0.0, 0.0, 1.0, 1.0];
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
