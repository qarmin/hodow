// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (InitializerListTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The size-4 branch of `getVectorValues` starts with `uni_matrix[COLUMN].z` (sic) as upstream does.

use super::objects::{Program, ShaderSource};
use super::templates::*;
use super::{Case420, Kind, ShaderStage, StageTemplates, Types, replace_token, version_string};
use crate::glu::Context;
use crate::glw::GLfloat;
use crate::tcu::TestError;

const VALUE: GLfloat = 0.0625;

/// `InitializerListTest::TESTED_INITIALIZERS`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Initializer {
    Vector,
    Matrix,
    MatrixRows,
    Struct,
    ArrayScalar,
    ArrayVectorCtr,
    ArrayVectorList,
    ArrayMatrixCtr,
    ArrayMatrixList,
    ArrayStruct,
    NestedStructCtr,
    NestedStructList,
    NestedSturctArraysStructList,
    NestedSturctArraysStructMix,
    NestedArrayStructStructList,
    NestedArrayStructStructMix,
    NestedStructStructArrayList,
    NestedStructStructArrayMix,
    UnsizedArrayScalar,
    UnsizedArrayVector,
    UnsizedArrayMatrix,
    UnsizedArrayStruct,
}

use Initializer::*;

const ALL_INITIALIZERS: [Initializer; 22] = [
    Vector,
    Matrix,
    MatrixRows,
    Struct,
    ArrayScalar,
    ArrayVectorCtr,
    ArrayVectorList,
    ArrayMatrixCtr,
    ArrayMatrixList,
    ArrayStruct,
    NestedStructCtr,
    NestedStructList,
    NestedSturctArraysStructList,
    NestedSturctArraysStructMix,
    NestedArrayStructStructList,
    NestedArrayStructStructMix,
    NestedStructStructArrayList,
    NestedStructStructArrayMix,
    UnsizedArrayScalar,
    UnsizedArrayVector,
    UnsizedArrayMatrix,
    UnsizedArrayStruct,
];

impl Initializer {
    /// `getInitializerName`
    fn name(self) -> &'static str {
        match self {
            Vector => "vector",
            Matrix => "matrix",
            MatrixRows => "matrix_rows",
            Struct => "struct",
            ArrayScalar => "array_scalar",
            ArrayVectorCtr => "array_vector_ctr",
            ArrayVectorList => "array_vector_list",
            ArrayMatrixCtr => "array_matrix_ctr",
            ArrayMatrixList => "array_matrix_list",
            ArrayStruct => "array_struct",
            NestedStructCtr => "nested_struct_ctr",
            NestedStructList => "nested_struct_list",
            NestedSturctArraysStructList => "nested_struct_arrays_struct_list",
            NestedSturctArraysStructMix => "nested_struct_arrays_struct_mix",
            NestedArrayStructStructList => "nested_array_struct_struct_list",
            NestedArrayStructStructMix => "nested_array_struct_struct_mix",
            NestedStructStructArrayList => "nested_struct_struct_array_list",
            NestedStructStructArrayMix => "nested_struct_struct_array_mix",
            UnsizedArrayScalar => "unsized_array_scalar",
            UnsizedArrayVector => "unsized_array_vector",
            UnsizedArrayMatrix => "unsized_array_matrix",
            UnsizedArrayStruct => "unsized_array_struct",
        }
    }
}

/// `addInitializerListTest`
pub(super) fn cases() -> Vec<InitializerList> {
    let mut cases = Vec::new();

    for initializer in ALL_INITIALIZERS {
        match initializer {
            Vector | ArrayVectorCtr | ArrayVectorList | UnsizedArrayVector => {
                for n_rows in 2..=4 {
                    cases.push(InitializerList::new(initializer, 1, n_rows));
                }
            }
            Matrix | MatrixRows | ArrayMatrixCtr | ArrayMatrixList | UnsizedArrayMatrix => {
                for n_cols in 2..=4 {
                    for n_rows in 2..=4 {
                        cases.push(InitializerList::new(initializer, n_cols, n_rows));
                    }
                }
            }
            ArrayScalar | UnsizedArrayScalar => cases.push(InitializerList::new(initializer, 1, 1)),
            _ => cases.push(InitializerList::new(initializer, 1, 4)),
        }
    }

    cases
}

/// `InitializerListTest`
pub(super) struct InitializerList {
    name: String,
    initializer: Initializer,
    n_cols: usize,
    n_rows: usize,
}

impl InitializerList {
    fn new(initializer: Initializer, n_cols: usize, n_rows: usize) -> Self {
        Self {
            name: format!(
                "initializer_list_initializer_{}_cols_{n_cols}_rows_{n_rows}",
                initializer.name()
            ),
            initializer,
            n_cols,
            n_rows,
        }
    }

    /// `getArrayDefinition`
    fn array_definition(&self) -> &'static str {
        match self.initializer {
            Vector
            | Matrix
            | MatrixRows
            | Struct
            | NestedStructCtr
            | NestedStructList
            | NestedSturctArraysStructList
            | NestedSturctArraysStructMix
            | NestedStructStructArrayList
            | NestedStructStructArrayMix => "",
            ArrayScalar
            | ArrayVectorCtr
            | ArrayVectorList
            | ArrayMatrixCtr
            | ArrayMatrixList
            | ArrayStruct
            | NestedArrayStructStructList
            | NestedArrayStructStructMix => "[4]",
            UnsizedArrayScalar | UnsizedArrayVector | UnsizedArrayMatrix | UnsizedArrayStruct => "[]",
        }
    }

    /// `getExpectedValue`
    fn expected_value(&self) -> String {
        let n_values = (self.n_cols * self.n_rows) as GLfloat;
        let mut value: GLfloat = match self.initializer {
            Vector | Matrix | MatrixRows => n_values,
            ArrayVectorCtr | ArrayVectorList | ArrayMatrixCtr | ArrayMatrixList | UnsizedArrayVector
            | UnsizedArrayMatrix => n_values * 4.0,
            ArrayScalar | UnsizedArrayScalar => 4.0,
            Struct => 8.0,
            NestedStructCtr | NestedStructList => 12.0,
            NestedStructStructArrayList | NestedStructStructArrayMix => 16.0,
            NestedSturctArraysStructList | NestedSturctArraysStructMix => 28.0,
            ArrayStruct | UnsizedArrayStruct => 32.0,
            NestedArrayStructStructList | NestedArrayStructStructMix => 48.0,
        };

        value *= VALUE;
        format!("{value:.6}")
    }

    /// `getInitialization`
    fn initialization(&self) -> String {
        let (n_cols, n_rows) = (self.n_cols, self.n_rows);
        let braces = |inner: String| format!("{{ {inner} }}");

        match self.initializer {
            Vector => vector_initializer(0, n_rows),
            Matrix => braces(vector_array_list(n_cols, n_rows)),
            MatrixRows => braces(vector_array_ctr(n_cols, n_rows)),
            Struct => braces(format!(
                "{}, {}",
                vector_initializer(0, n_rows),
                vector_initializer(2, n_rows)
            )),
            ArrayScalar | UnsizedArrayScalar => braces(vector_values(0, 4)),
            ArrayVectorList | UnsizedArrayVector => braces(vector_array_list(4, n_rows)),
            ArrayVectorCtr => braces(vector_array_ctr(4, n_rows)),
            ArrayMatrixList | UnsizedArrayMatrix => braces(
                (0..4)
                    .map(|_| braces(vector_array_list(n_cols, n_rows)))
                    .collect::<Vec<_>>()
                    .join(", "),
            ),
            ArrayMatrixCtr => {
                let type_name = Types::Float.type_name(n_cols, n_rows).expect("the type exists");
                let matrix = format!(
                    "{type_name}({})",
                    (0..n_cols)
                        .map(|col| vector_values(col, n_rows))
                        .collect::<Vec<_>>()
                        .join(", ")
                );
                braces(vec![matrix; 4].join(", "))
            }
            ArrayStruct | UnsizedArrayStruct => {
                let element = braces(format!(
                    "{}, {}",
                    vector_initializer(0, n_rows),
                    vector_initializer(2, n_rows)
                ));
                braces(vec![element; 4].join(", "))
            }
            NestedStructCtr => format!(
                "StructureWithStructure(BasicStructure({}, {}), {})",
                vector_constructor(0, 4),
                vector_constructor(2, 4),
                vector_constructor(3, 4)
            ),
            NestedStructList => format!(
                "{{ {{ {}, {} }}, {} }}",
                vector_initializer(0, 4),
                vector_initializer(2, 4),
                vector_initializer(3, 4)
            ),
            NestedSturctArraysStructList => {
                let element = format!("{{ {}, {} }}", vector_initializer(2, 4), vector_initializer(3, 4));
                format!(
                    "{{ {}, {{ {} }} }}",
                    vector_initializer(0, 4),
                    vec![element; 3].join(", ")
                )
            }
            NestedSturctArraysStructMix => {
                let element = format!("{{ {}, {} }}", vector_initializer(2, 4), vector_constructor(3, 4));
                format!(
                    "{{ {}, {{ {} }} }}",
                    vector_constructor(0, 4),
                    vec![element; 3].join(", ")
                )
            }
            NestedArrayStructStructList => {
                let element = format!(
                    "{{ {{ {}, {} }}, {} }}",
                    vector_initializer(0, 4),
                    vector_initializer(1, 4),
                    vector_initializer(2, 4)
                );
                braces(vec![element; 4].join(", "))
            }
            NestedArrayStructStructMix => {
                let element = format!(
                    "StructureWithStructure(\nBasicStructure({} , {}), {}) , {{ {{ {}, {} }}, {} }}",
                    vector_constructor(0, 4),
                    vector_constructor(1, 4),
                    vector_constructor(2, 4),
                    vector_initializer(0, 4),
                    vector_initializer(1, 4),
                    vector_initializer(2, 4)
                );
                format!("{{\n{} }}", vec![element; 2].join(" , "))
            }
            NestedStructStructArrayList => format!(
                "{{ {{ {}, {{ {}, {} }} }}, {} }}",
                vector_initializer(0, 4),
                vector_initializer(1, 4),
                vector_initializer(2, 4),
                vector_initializer(3, 4)
            ),
            NestedStructStructArrayMix => format!(
                "StructureWithStructureWithArray(StructureWithArray({} , vec4[2]( {} , {} )) , {})",
                vector_constructor(0, 4),
                vector_constructor(1, 4),
                vector_constructor(2, 4),
                vector_constructor(3, 4)
            ),
        }
    }

    /// `getSum`
    fn sum(&self) -> String {
        let (n_cols, n_rows) = (self.n_cols, self.n_rows);

        match self.initializer {
            Vector => vector_sum("variable", n_rows),
            Matrix | MatrixRows => vector_array_sum("variable[INDEX]", n_cols, n_rows),
            Struct => format!(
                "{} + {}",
                vector_sum("variable.member_a", n_rows),
                vector_sum("variable.member_b", n_rows)
            ),
            ArrayScalar | UnsizedArrayScalar => "variable[0] + variable[1] + variable[2] + variable[3]".to_string(),
            ArrayVectorList | ArrayVectorCtr | UnsizedArrayVector => vector_array_sum("variable[INDEX]", 4, n_rows),
            ArrayMatrixList | ArrayMatrixCtr | UnsizedArrayMatrix => format!(
                "{} + {} + {} + {}",
                vector_array_sum("variable[0][INDEX]", n_cols, n_rows),
                vector_array_sum("variable[1][INDEX]", n_cols, n_rows),
                vector_array_sum("variable[2][INDEX]", n_cols, n_rows),
                vector_array_sum("variable[3][INDEX]", n_cols, n_rows)
            ),
            ArrayStruct | UnsizedArrayStruct => format!(
                "{} + {}",
                vector_array_sum("variable[INDEX].member_a", 4, n_rows),
                vector_array_sum("variable[INDEX].member_b", 4, n_rows)
            ),
            NestedStructCtr | NestedStructList => format!(
                "{} + {} + {}",
                vector_sum("variable.member_a.member_a", 4),
                vector_sum("variable.member_a.member_b", 4),
                vector_sum("variable.member_b", 4)
            ),
            NestedSturctArraysStructList | NestedSturctArraysStructMix => format!(
                "{} + {} + {}",
                vector_sum("variable.member_a", 4),
                vector_array_sum("variable.member_b[INDEX].member_a", 3, 4),
                vector_array_sum("variable.member_b[INDEX].member_b", 3, 4)
            ),
            NestedArrayStructStructList | NestedArrayStructStructMix => format!(
                "{} + {} + {}",
                vector_array_sum("variable[INDEX].member_a.member_a", 4, 4),
                vector_array_sum("variable[INDEX].member_a.member_b", 4, 4),
                vector_array_sum("variable[INDEX].member_b", 4, 4)
            ),
            NestedStructStructArrayList | NestedStructStructArrayMix => format!(
                "{} + {} + {}",
                vector_sum("variable.member_a.member_a", 4),
                vector_array_sum("variable.member_a.member_b[INDEX]", 2, 4),
                vector_sum("variable.member_b", 4)
            ),
        }
    }

    /// `getTypeDefinition`
    fn type_definition(&self) -> String {
        const BASIC_STRUCT: &str = "struct BasicStructure {\n    vec4 member_a;\n    vec4 member_b;\n};\n";
        const STRUCT_WITH_ARRAY: &str = "struct StructureWithArray {\n    vec4 member_a;\n    vec4 member_b[2];\n};\n";
        const STRUCT_WITH_STRUCT: &str =
            "struct StructureWithStructure {\n    BasicStructure member_a;\n    vec4           member_b;\n};\n";
        const STRUCT_WITH_STRUCT_ARRAY: &str =
            "struct StructureWithStructArray {\n    vec4           member_a;\n    BasicStructure member_b[3];\n};\n";
        const STRUCT_WITH_STRUCT_WITH_ARRAY: &str = "struct StructureWithStructureWithArray {\n    StructureWithArray member_a;\n    vec4               member_b;\n};\n";

        match self.initializer {
            Vector | Matrix | MatrixRows | ArrayScalar | ArrayVectorCtr | ArrayVectorList | ArrayMatrixCtr
            | ArrayMatrixList | UnsizedArrayScalar | UnsizedArrayVector | UnsizedArrayMatrix => String::new(),
            Struct | ArrayStruct | UnsizedArrayStruct => BASIC_STRUCT.to_string(),
            NestedStructCtr | NestedStructList | NestedArrayStructStructList | NestedArrayStructStructMix => {
                format!("{BASIC_STRUCT}{STRUCT_WITH_STRUCT}")
            }
            NestedSturctArraysStructList | NestedSturctArraysStructMix => {
                format!("{BASIC_STRUCT}{STRUCT_WITH_STRUCT_ARRAY}")
            }
            NestedStructStructArrayList | NestedStructStructArrayMix => {
                format!("{STRUCT_WITH_ARRAY}{STRUCT_WITH_STRUCT_WITH_ARRAY}")
            }
        }
    }

    /// `getTypeName`
    fn type_name(&self) -> String {
        match self.initializer {
            Vector | Matrix | MatrixRows | ArrayVectorCtr | ArrayVectorList | ArrayMatrixCtr | ArrayMatrixList
            | UnsizedArrayVector | UnsizedArrayMatrix => Types::Float
                .type_name(self.n_cols, self.n_rows)
                .expect("the type exists")
                .to_string(),
            Struct | ArrayStruct | UnsizedArrayStruct => "BasicStructure".to_string(),
            NestedStructCtr | NestedStructList | NestedArrayStructStructList | NestedArrayStructStructMix => {
                "StructureWithStructure".to_string()
            }
            NestedSturctArraysStructList | NestedSturctArraysStructMix => "StructureWithStructArray".to_string(),
            NestedStructStructArrayList | NestedStructStructArrayMix => "StructureWithStructureWithArray".to_string(),
            ArrayScalar | UnsizedArrayScalar => "float".to_string(),
        }
    }
}

/// `getVectorArrayCtr`
fn vector_array_ctr(columns: usize, size: usize) -> String {
    (0..columns)
        .map(|col| vector_constructor(col, size))
        .collect::<Vec<_>>()
        .join(", ")
}

/// `getVectorArrayList`
fn vector_array_list(columns: usize, size: usize) -> String {
    (0..columns)
        .map(|col| vector_initializer(col, size))
        .collect::<Vec<_>>()
        .join(", ")
}

/// `getVectorConstructor`
fn vector_constructor(column: usize, size: usize) -> String {
    format!(
        "{}({})",
        Types::Float.type_name(1, size).expect("the type exists"),
        vector_values(column, size)
    )
}

/// `getVectorInitializer`
fn vector_initializer(column: usize, size: usize) -> String {
    format!("{{{}}}", vector_values(column, size))
}

/// `getVectorArraySum`
fn vector_array_sum(array_name: &str, columns: usize, size: usize) -> String {
    (0..columns)
        .map(|i| vector_sum(&array_name.replacen("INDEX", &i.to_string(), 1), size))
        .collect::<Vec<_>>()
        .join(" + ")
}

/// `getVectorSum`
fn vector_sum(vector_name: &str, size: usize) -> String {
    const LUT: [&str; 4] = [".x", ".y", ".z", ".w"];

    (0..size)
        .map(|i| format!("{vector_name}{}", LUT[i]))
        .collect::<Vec<_>>()
        .join(" + ")
}

/// `getVectorValues`
fn vector_values(column: usize, size: usize) -> String {
    let init_template = match size {
        2 => "uni_matrix[COLUMN].x, uni_matrix[COLUMN].y",
        3 => "uni_matrix[COLUMN].x, uni_matrix[COLUMN].y, uni_matrix[COLUMN].z",
        _ => "uni_matrix[COLUMN].z, uni_matrix[COLUMN].y, uni_matrix[COLUMN].z, uni_matrix[COLUMN].w",
    };

    init_template.replace("COLUMN", &column.to_string())
}

impl Case420 for InitializerList {
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
            compute: INITIALIZER_LIST_COMPUTE_SHADER_TEMPLATE,
            fragment: INITIALIZER_LIST_FRAGMENT_SHADER_TEMPLATE,
            geometry: INITIALIZER_LIST_GEOMETRY_SHADER_TEMPLATE,
            tess_control: INITIALIZER_LIST_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: INITIALIZER_LIST_TESS_EVAL_SHADER_TEMPLATE,
            vertex: INITIALIZER_LIST_VERTEX_SHADER_TEMPLATE,
        };

        let array_definition = self.array_definition();
        let expected_value = self.expected_value();
        let initialization = self.initialization();
        let sum = self.sum();
        let type_definition = self.type_definition();
        let type_name = self.type_name();

        let code = &mut out_source.parts[0].code;
        *code = templates.get(stage).as_bytes().to_vec();

        let mut position = 0;
        replace_token(
            "VERSION",
            &mut position,
            version_string(stage, use_version_400).as_bytes(),
            code,
        );
        replace_token("TYPE_DEFINITION", &mut position, type_definition.as_bytes(), code);
        replace_token(
            "VERIFICATION",
            &mut position,
            INITIALIZER_LIST_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position -= INITIALIZER_LIST_VERIFICATION_SNIPPET.len();
        replace_token("TYPE_NAME", &mut position, type_name.as_bytes(), code);
        replace_token("ARRAY_DEFINITION", &mut position, array_definition.as_bytes(), code);
        replace_token("INITIALIZATION", &mut position, initialization.as_bytes(), code);
        replace_token("SUM", &mut position, sum.as_bytes(), code);
        replace_token("EXPECTED_VALUE", &mut position, expected_value.as_bytes(), code);
    }

    fn prepare_uniforms(&self, program: &Program, _case_index: usize) -> Result<(), TestError> {
        program.uniform_float("uni_matrix", 4, 4, &[VALUE; 16])
    }
}

/// `InitializerListNegativeTest::TESTED_ERRORS`
#[derive(Clone, Copy)]
pub(super) enum TestedError {
    TypeUivecBool,
    TypeIvecBool,
    TypeVecBool,
    TypeMatBool,
    ComponentsVecLess,
    ComponentsVecMore,
    ComponentsMatLessRows,
    ComponentsMatLessColumns,
    ComponentsMatMoreRows,
    ComponentsMatMoreColumns,
    ListInConstructor,
    StructLayoutMemberType,
    StructLayoutMemberCountMore,
    StructLayoutMemberCountLess,
    StructLayoutMemberOrder,
}

/// `addInitializerListNegativeTest`
pub(super) const TESTED_ERRORS: [TestedError; 15] = [
    TestedError::TypeUivecBool,
    TestedError::TypeIvecBool,
    TestedError::TypeVecBool,
    TestedError::TypeMatBool,
    TestedError::ComponentsVecLess,
    TestedError::ComponentsVecMore,
    TestedError::ComponentsMatLessRows,
    TestedError::ComponentsMatLessColumns,
    TestedError::ComponentsMatMoreRows,
    TestedError::ComponentsMatMoreColumns,
    TestedError::ListInConstructor,
    TestedError::StructLayoutMemberType,
    TestedError::StructLayoutMemberCountMore,
    TestedError::StructLayoutMemberCountLess,
    TestedError::StructLayoutMemberOrder,
];

/// `InitializerListNegativeTest`
pub(super) struct InitializerListNegative {
    name: String,
    error: TestedError,
}

impl InitializerListNegative {
    pub(super) fn new(error: TestedError) -> Self {
        use TestedError::*;

        let error_name = match error {
            TypeUivecBool => "type_uivec_bool",
            TypeIvecBool => "type_ivec_bool",
            TypeVecBool => "type_vec_bool",
            TypeMatBool => "type_mat_bool",
            ComponentsVecLess => "components_vec_less",
            ComponentsVecMore => "components_vec_more",
            ComponentsMatLessRows => "components_mat_less_rows",
            ComponentsMatLessColumns => "components_mat_less_columns",
            ComponentsMatMoreRows => "components_mat_more_rows",
            ComponentsMatMoreColumns => "components_mat_more_columns",
            ListInConstructor => "list_in_constructor",
            StructLayoutMemberType => "struct_layout_member_type",
            StructLayoutMemberCountMore => "struct_layout_member_count_more",
            StructLayoutMemberCountLess => "struct_layout_member_count_less",
            StructLayoutMemberOrder => "struct_layout_member_order",
        };

        Self {
            name: format!("initializer_list_negative_error_{error_name}"),
            error,
        }
    }

    /// `getInitialization`
    fn initialization(&self) -> &'static str {
        use TestedError::*;

        match self.error {
            TypeUivecBool => "{ true, 0, 1, 2 }",
            TypeIvecBool => "{ true, 0, -1, 2 }",
            TypeVecBool => "{ true, 0.125, 0.25, 0.375 }",
            TypeMatBool => "{ {false, 0, 1, 1}, {0, 1, 0, 1}, {1, 0, 1, 0}, {0, 1, 0, 1} }",
            ComponentsVecLess | ComponentsVecMore => "{ 0, 0.25, 0.375 }",
            ComponentsMatLessRows => "{ {0, 0, 1, 1}, {0, 0, 1}, {1, 0, 1, 0}, {0, 1, 0, 1} }",
            ComponentsMatMoreRows => "{ {0, 0, 1}, {0, 0, 1}, {1, 0, 1, 0}, {1, 0, 1} }",
            ComponentsMatLessColumns => "{ {0, 0, 1, 1}, {1, 0, 1, 0}, {0, 1, 0, 1} }",
            ComponentsMatMoreColumns => "{ {0, 0, 1}, {0, 0, 1}, {1, 0, 1}, {1, 0, 1} }",
            ListInConstructor => "Struct( { vec4(0, 1, 0, 1), vec3(0, 1, 0) }, vec4(1, 0, 1, 0) )",
            StructLayoutMemberType => "{ { {0, 1, 0, 1}, vec4(0, 1, 0, 1) }, vec4(1, 0, 1, 0) }",
            StructLayoutMemberCountMore => "{ { {0, 1, 0, 1}, vec3(0, 1, 0) } , vec4(1, 0, 1, 0), vec4(1, 0, 1, 0) }",
            StructLayoutMemberCountLess => "{ { {0, 1, 0, 1}, vec3(0, 1, 0) } }",
            StructLayoutMemberOrder => "{ vec4(1, 0, 1, 0), { vec3(0, 1, 0) , {0, 1, 0, 1} } }",
        }
    }

    /// `getSum`
    fn sum(&self) -> &'static str {
        use TestedError::*;

        match self.error {
            TypeUivecBool | TypeIvecBool | TypeVecBool | ComponentsVecLess => {
                "variable.x + variable.y + variable.z + variable.w"
            }
            TypeMatBool | ComponentsMatLessRows | ComponentsMatLessColumns => concat!(
                "variable[0].x + variable[0].y + variable[0].z + variable[0].w + ",
                "variable[1].x + variable[1].y + variable[1].z + variable[1].w + ",
                "variable[2].x + variable[2].y + variable[2].z + variable[2].w + ",
                "variable[3].x + variable[3].y + variable[3].z + variable[3].w"
            ),
            ComponentsVecMore => "variable.x + variable.y + variable.z",
            ComponentsMatMoreRows | ComponentsMatMoreColumns => concat!(
                "variable[0].x + variable[0].y + variable[0].z",
                "variable[1].x + variable[1].y + variable[1].z",
                "variable[2].x + variable[2].y + variable[2].z"
            ),
            ListInConstructor
            | StructLayoutMemberType
            | StructLayoutMemberCountMore
            | StructLayoutMemberCountLess
            | StructLayoutMemberOrder => concat!(
                "variable.member_a.member_a.x + variable.member_a.member_a.y + variable.member_a.member_a.z + ",
                "variable.member_a.member_a.w + ",
                "variable.member_a.member_b.x + variable.member_a.member_b.y + variable.member_a.member_b.z + ",
                "variable.member_b.x + variable.member_b.y + variable.member_b.z + variable.member_b.w"
            ),
        }
    }

    /// `getTypeDefinition`
    fn type_definition(&self) -> &'static str {
        use TestedError::*;

        match self.error {
            TypeUivecBool
            | TypeIvecBool
            | TypeVecBool
            | TypeMatBool
            | ComponentsVecLess
            | ComponentsVecMore
            | ComponentsMatLessRows
            | ComponentsMatLessColumns
            | ComponentsMatMoreRows
            | ComponentsMatMoreColumns => "",
            ListInConstructor
            | StructLayoutMemberType
            | StructLayoutMemberCountMore
            | StructLayoutMemberCountLess
            | StructLayoutMemberOrder => concat!(
                "struct BasicStructure {\n",
                "    vec4 member_a;\n",
                "    vec3 member_b;\n",
                "};\n",
                "\n",
                "struct StructureWithStructure {\n",
                "    BasicStructure member_a;\n",
                "    vec4           member_b;\n",
                "};\n"
            ),
        }
    }

    /// `getTypeName`
    fn type_name(&self) -> &'static str {
        use TestedError::*;

        match self.error {
            TypeUivecBool => "uvec4",
            TypeIvecBool => "ivec4",
            TypeVecBool | ComponentsVecLess => "vec4",
            ComponentsVecMore => "vec2",
            TypeMatBool | ComponentsMatLessRows | ComponentsMatLessColumns => "mat4",
            ComponentsMatMoreRows | ComponentsMatMoreColumns => "mat3",
            ListInConstructor
            | StructLayoutMemberType
            | StructLayoutMemberCountMore
            | StructLayoutMemberCountLess
            | StructLayoutMemberOrder => "StructureWithStructure",
        }
    }
}

impl Case420 for InitializerListNegative {
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
            compute: INITIALIZER_LIST_NEGATIVE_COMPUTE_SHADER_TEMPLATE,
            fragment: INITIALIZER_LIST_NEGATIVE_FRAGMENT_SHADER_TEMPLATE,
            geometry: INITIALIZER_LIST_NEGATIVE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: INITIALIZER_LIST_NEGATIVE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: INITIALIZER_LIST_NEGATIVE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: INITIALIZER_LIST_NEGATIVE_VERTEX_SHADER_TEMPLATE,
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
            "TYPE_DEFINITION",
            &mut position,
            self.type_definition().as_bytes(),
            code,
        );
        replace_token(
            "VERIFICATION",
            &mut position,
            INITIALIZER_LIST_NEGATIVE_VERIFICATION_SNIPPET.as_bytes(),
            code,
        );
        position -= INITIALIZER_LIST_NEGATIVE_VERIFICATION_SNIPPET.len();
        replace_token("TYPE_NAME", &mut position, self.type_name().as_bytes(), code);
        replace_token("INITIALIZATION", &mut position, self.initialization().as_bytes(), code);
        replace_token("SUM", &mut position, self.sum().as_bytes(), code);
    }
}
