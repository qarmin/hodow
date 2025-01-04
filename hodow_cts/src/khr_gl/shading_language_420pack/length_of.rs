// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (LengthOfVectorAndMatrixTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `m_is_compute_program`, set by `prepareShaderSource` and read by `prepareUniforms`, is an atomic.

use std::ffi::c_void;
use std::sync::atomic::{AtomicBool, Ordering};

use super::objects::{Buffer, Program, ShaderSource, VertexArray};
use super::qualifiers::{
    Qualifier, QualifierSet, VariableStorage, prepare_block_variable_strings, prepare_variable_strings, variable_name,
};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, Types, replace_all_tokens, replace_token, version_string};
use crate::glu::Context;
use crate::glw::{self, GLfloat, GLint, GLuint};
use crate::tcu::TestError;

/// `LengthOfVectorAndMatrixTest::testCase`
#[derive(Clone, Copy)]
pub(super) struct LengthCase {
    type_: Types,
    n_cols: usize,
    n_rows: usize,
}

/// `addLengthOfVectorAndMatrixTest`: uint, int and float vectors, then float matrices.
pub(super) fn cases() -> Vec<LengthOfVectorAndMatrix> {
    let mut cases = Vec::new();

    for type_ in [Types::Uint, Types::Int, Types::Float] {
        for n_rows in 2..=4 {
            cases.push(LengthOfVectorAndMatrix::new(LengthCase {
                type_,
                n_cols: 1,
                n_rows,
            }));
        }
    }

    for n_cols in 2..=4 {
        for n_rows in 2..=4 {
            cases.push(LengthOfVectorAndMatrix::new(LengthCase {
                type_: Types::Float,
                n_cols,
                n_rows,
            }));
        }
    }

    cases
}

/// `LengthOfVectorAndMatrixTest`
pub(super) struct LengthOfVectorAndMatrix {
    name: String,
    test_case: LengthCase,
    is_compute_program: AtomicBool,
}

impl LengthOfVectorAndMatrix {
    fn new(test_case: LengthCase) -> Self {
        let type_name = match test_case.type_ {
            Types::Float => "float",
            Types::Double => "double",
            Types::Int => "int",
            Types::Uint => "uint",
        };
        let name = format!(
            "length_of_vector_and_matrix_type_{type_name}_cols_{}_rows_{}",
            test_case.n_cols, test_case.n_rows
        );

        Self {
            name,
            test_case,
            is_compute_program: AtomicBool::new(false),
        }
    }

    fn type_name(&self) -> &'static str {
        self.test_case
            .type_
            .type_name(self.test_case.n_cols, self.test_case.n_rows)
            .expect("the type exists")
    }

    fn base_type_name(&self) -> &'static str {
        self.test_case.type_.type_name(1, 1).expect("the type exists")
    }

    /// `getExpectedValue`
    fn expected_value(&self, stage: ShaderStage) -> String {
        let mut count: i32 = match stage {
            ShaderStage::Fragment => 3,
            ShaderStage::Compute => 2,
            _ => 4,
        };

        let factor = if self.test_case.n_cols == 1 {
            self.test_case.n_rows
        } else {
            self.test_case.n_cols
        };
        count *= factor as i32;

        match self.test_case.type_ {
            Types::Float => format!("{:.6}", 0.125 * count as GLfloat),
            Types::Int => format!("{}", -count),
            Types::Uint => format!("{count}"),
            Types::Double => unreachable!("upstream asserts here"),
        }
    }

    /// `getVectorInitializer`
    fn vector_initializer(type_: Types, n_rows: usize) -> String {
        let value = match type_ {
            Types::Float => "0.125",
            Types::Uint => "1",
            Types::Int => "-1",
            Types::Double => unreachable!("upstream fails with Invalid enum"),
        };

        format!("{{{}}}", vec![value; n_rows].join(", "))
    }

    /// `getMatrixInitializer`
    fn matrix_initializer(n_cols: usize, n_rows: usize) -> String {
        format!(
            "{{ {} }}",
            vec![Self::vector_initializer(Types::Float, n_rows); n_cols].join(", ")
        )
    }

    /// `getInitialization`
    fn initialization(&self) -> String {
        if self.test_case.n_cols == 1 {
            Self::vector_initializer(self.test_case.type_, self.test_case.n_rows)
        } else {
            Self::matrix_initializer(self.test_case.n_cols, self.test_case.n_rows)
        }
    }

    fn array_index(&self) -> &'static str {
        if self.test_case.n_cols != 1 { "[i]" } else { "" }
    }

    /// `prepareDrawShaderSource`
    fn prepare_draw_shader_source(&self, stage: ShaderStage, use_version_400: bool, out_source: &mut ShaderSource) {
        let shader_template = match stage {
            ShaderStage::Compute => unreachable!("the compute stage has its own path"),
            ShaderStage::Fragment => LENGTH_OF_VECTOR_AND_MATRIX_DRAW_FRAGMENT_SHADER_TEMPLATE,
            ShaderStage::Geometry => LENGTH_OF_VECTOR_AND_MATRIX_DRAW_GEOMETRY_SHADER_TEMPLATE,
            ShaderStage::TessControl => LENGTH_OF_VECTOR_AND_MATRIX_DRAW_TESS_CTRL_SHADER_TEMPLATE,
            ShaderStage::TessEval => LENGTH_OF_VECTOR_AND_MATRIX_DRAW_TESS_EVAL_SHADER_TEMPLATE,
            ShaderStage::Vertex => LENGTH_OF_VECTOR_AND_MATRIX_DRAW_VERTEX_SHADER_TEMPLATE,
        };

        let base_type_name = self.base_type_name();
        let expected_value = self.expected_value(stage);
        let initialization = self.initialization();
        let type_name = self.type_name();

        let mut in_qualifiers = QualifierSet::new();
        let mut out_qualifiers = QualifierSet::new();

        if matches!(self.test_case.type_, Types::Uint | Types::Int) {
            if stage != ShaderStage::Vertex {
                in_qualifiers.push(Qualifier::Flat);
            }
            out_qualifiers.push(Qualifier::Flat);
        }

        let (input_decl, input_ref) = if stage != ShaderStage::Vertex {
            prepare_block_variable_strings(
                stage,
                VariableStorage::Input,
                &in_qualifiers,
                type_name,
                "variable",
                "input_block",
            )
        } else {
            prepare_variable_strings(stage, VariableStorage::Input, &in_qualifiers, type_name, "variable")
        };
        let (output_decl, output_ref) = if stage != ShaderStage::Fragment {
            prepare_block_variable_strings(
                stage,
                VariableStorage::Output,
                &out_qualifiers,
                type_name,
                "variable",
                "output_block",
            )
        } else {
            prepare_variable_strings(stage, VariableStorage::Output, &out_qualifiers, type_name, "variable")
        };

        let code = &mut out_source.parts[0].code;
        *code = shader_template.as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token("VARIABLE_DECLARATION", &mut position, input_decl.as_bytes(), code);
        if stage != ShaderStage::Fragment {
            replace_token("VARIABLE_DECLARATION", &mut position, output_decl.as_bytes(), code);
        }
        replace_token("TYPE_NAME", &mut position, type_name.as_bytes(), code);
        let temp = position;
        replace_token(
            "VERIFICATION",
            &mut position,
            LENGTH_OF_VECTOR_AND_MATRIX_DRAW_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position = temp;
        replace_token("VARIABLE_TYPE", &mut position, type_name.as_bytes(), code);
        replace_token("INITIALIZATION", &mut position, initialization.as_bytes(), code);
        replace_token("INITIALIZATION", &mut position, initialization.as_bytes(), code);
        for _ in 0..5 {
            replace_token("BASE_TYPE", &mut position, base_type_name.as_bytes(), code);
        }
        replace_token("EXPECTED_VALUE", &mut position, expected_value.as_bytes(), code);
        replace_all_tokens("INPUT_VARIABLE_NAME", input_ref.as_bytes(), code);
        replace_all_tokens("OUTPUT_VARIABLE_NAME", output_ref.as_bytes(), code);
        replace_all_tokens("ARRAY_INDEX", self.array_index().as_bytes(), code);
    }

    /// `prepareComputeShaderSource`
    fn prepare_compute_shader_source(&self, out_source: &mut ShaderSource) {
        let base_type_name = self.base_type_name();
        let expected_value = self.expected_value(ShaderStage::Compute);
        let type_name = self.type_name();
        let array_index = self.array_index();

        let code = &mut out_source.parts[0].code;
        *code = LENGTH_OF_VECTOR_AND_MATRIX_COMPUTE_COMPUTE_SHADER_TEMPLATE
            .as_bytes()
            .to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(ShaderStage::Compute, false).as_bytes(),
            code,
        );
        replace_token("TYPE_NAME", &mut position, type_name.as_bytes(), code);
        replace_token("TYPE_NAME", &mut position, type_name.as_bytes(), code);
        let temp = position;
        replace_token(
            "VERIFICATION",
            &mut position,
            LENGTH_OF_VECTOR_AND_MATRIX_COMPUTE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position = temp;
        replace_token("VARIABLE_TYPE", &mut position, type_name.as_bytes(), code);
        for _ in 0..3 {
            replace_token("BASE_TYPE", &mut position, base_type_name.as_bytes(), code);
        }
        replace_token("ARRAY_INDEX", &mut position, array_index.as_bytes(), code);
        replace_token("ARRAY_INDEX", &mut position, array_index.as_bytes(), code);
        replace_token("EXPECTED_VALUE", &mut position, expected_value.as_bytes(), code);
    }
}

impl Case420 for LengthOfVectorAndMatrix {
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
            self.is_compute_program.store(true, Ordering::Relaxed);
            self.prepare_compute_shader_source(out_source);
        } else {
            self.is_compute_program.store(false, Ordering::Relaxed);
            self.prepare_draw_shader_source(stage, use_version_400, out_source);
        }
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        const FLOAT_DATA: [GLfloat; 16] = [0.125; 16];
        const INT_DATA: [GLint; 4] = [-1; 4];
        const UINT_DATA: [GLuint; 4] = [1; 4];

        if !self.is_compute_program.load(Ordering::Relaxed) {
            return Ok(());
        }

        let (n_cols, n_rows) = (self.test_case.n_cols as GLuint, self.test_case.n_rows as GLuint);

        match self.test_case.type_ {
            Types::Float => program.uniform_float("uni_variable", n_cols, n_rows, &FLOAT_DATA),
            Types::Int => program.uniform_int("uni_variable", n_rows, &INT_DATA),
            Types::Uint => program.uniform_uint("uni_variable", n_rows, &UINT_DATA),
            Types::Double => super::fail("Invalid enum"),
        }
    }

    fn prepare_vertex_buffer(
        &self,
        program: &Program,
        buffer: &mut Buffer,
        vao: &mut VertexArray,
        _case_index: usize,
    ) -> Result<(), TestError> {
        const FLOAT_DATA: [GLfloat; 16] = [0.125; 16];
        const INT_DATA: [GLint; 4] = [-1; 4];
        const UINT_DATA: [GLuint; 4] = [1; 4];

        let gl = program.context().gl();
        let variable_name = variable_name(ShaderStage::Vertex, VariableStorage::Input, "variable");
        let variable_loc = program.get_attrib_location(&variable_name)?;

        if variable_loc == -1 {
            return super::fail("Vertex attribute location is invalid");
        }

        vao.generate()?;
        vao.bind()?;

        buffer.generate(glw::GL_ARRAY_BUFFER)?;

        let (data_ptr, data_size) = match self.test_case.type_ {
            Types::Float => (FLOAT_DATA.as_ptr().cast::<c_void>(), std::mem::size_of_val(&FLOAT_DATA)),
            Types::Int => (INT_DATA.as_ptr().cast::<c_void>(), std::mem::size_of_val(&INT_DATA)),
            Types::Uint => (UINT_DATA.as_ptr().cast::<c_void>(), std::mem::size_of_val(&UINT_DATA)),
            Types::Double => return super::fail("Invalid enum"),
        };
        buffer.update(data_size as glw::GLsizeiptr, data_ptr, glw::GL_STATIC_DRAW)?;

        let n_rows = self.test_case.n_rows as GLint;

        match self.test_case.type_ {
            Types::Float => {
                for col in 0..self.test_case.n_cols {
                    let index = variable_loc as GLuint + col as GLuint;
                    let offset = (self.test_case.n_rows * std::mem::size_of::<GLfloat>() * col) as *const c_void;
                    gl_call!(
                        gl,
                        "VertexAttribPointer",
                        gl.vertex_attrib_pointer(
                            index,
                            n_rows,
                            glw::GL_FLOAT,
                            glw::GL_FALSE as glw::GLboolean,
                            0,
                            offset
                        )
                    );
                }
            }
            Types::Int => {
                gl_call!(
                    gl,
                    "VertexAttribIPointer",
                    gl.vertex_attrib_i_pointer(variable_loc as GLuint, n_rows, glw::GL_INT, 0, std::ptr::null())
                );
            }
            Types::Uint => {
                gl_call!(
                    gl,
                    "VertexAttribIPointer",
                    gl.vertex_attrib_i_pointer(
                        variable_loc as GLuint,
                        n_rows,
                        glw::GL_UNSIGNED_INT,
                        0,
                        std::ptr::null()
                    )
                );
            }
            Types::Double => unreachable!("upstream asserts here"),
        }

        for col in 0..self.test_case.n_cols {
            gl_call!(
                gl,
                "EnableVertexAttribArray",
                gl.enable_vertex_attrib_array(variable_loc as GLuint + col as GLuint)
            );
        }
        Ok(())
    }
}
