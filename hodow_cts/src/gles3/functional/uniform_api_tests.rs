// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fUniformApiTests.cpp  (UniformApiTests::init)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the registration lives here - the
// case itself is `gls::uniform_api_case`, shared with the ES 2.0 copy of this same file.

use std::sync::Arc;

use crate::gls::uniform_api_case::{
    AssignMethod, CASE_SHADER_TYPES, CaseKind, CaseShaderType, CheckMethod, EsVersion,
    FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX, FEATURE_ARRAYASSIGN_BLOCKS_OF_TWO, FEATURE_ARRAYASSIGN_FULL,
    FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX, FEATURE_MATRIXMODE_ROWMAJOR, FEATURE_UNIFORMFUNC_VALUE,
    FEATURE_UNIFORMUSAGE_EVERY_OTHER, FEATURE_UNIFORMVALUE_ZERO, InfoQueryType, TEST_DATA_TYPES, UniformCase,
    UniformCollection, ValueToCheck, bool_api_variation, is_bool_or_bvec, is_matrix, random_case_shader_type,
    random_features,
};
use crate::glu::shader_util::{DataType, get_data_type_vector};
use crate::glu::{TestCase, TestCaseGroup};

/// `UniformCollectionCase`
struct UniformCollectionCase {
    name_prefix: String,
    collection: Arc<UniformCollection>,
}

/// `UniformCollectionGroup`
struct UniformCollectionGroup {
    name: &'static str,
    cases: Vec<UniformCollectionCase>,
}

/// The `UNIFORMCOLLECTIONS_*` indices, kept as constants so the registration below
/// reads like upstream's.
const COLLECTIONS_BASIC: usize = 0;
const COLLECTIONS_BASIC_ARRAY: usize = 1;
const COLLECTIONS_ARRAY_IN_STRUCT: usize = 4;
const COLLECTIONS_MULTIPLE_BASIC_ARRAY: usize = 7;
const COLLECTIONS_LAST: usize = 9;

/// `UniformApiTests::init`'s `defaultUniformCollections`
fn default_uniform_collections() -> Vec<UniformCollectionGroup> {
    let mut groups: Vec<UniformCollectionGroup> = [
        "basic",
        "basic_array",
        "basic_struct",
        "struct_in_array",
        "array_in_struct",
        "nested_structs_arrays",
        "multiple_basic",
        "multiple_basic_array",
        "multiple_nested_structs_arrays",
    ]
    .into_iter()
    .map(|name| UniformCollectionGroup {
        name,
        cases: Vec::new(),
    })
    .collect();

    // The indices upstream's enum gives these, in its own order.
    const BASIC_STRUCT: usize = 2;
    const STRUCT_IN_ARRAY: usize = 3;
    const NESTED_STRUCTS_ARRAYS: usize = 5;
    const MULTIPLE_BASIC: usize = 6;
    const MULTIPLE_NESTED_STRUCTS_ARRAYS: usize = 8;

    let push = |groups: &mut Vec<UniformCollectionGroup>, group: usize, name: &str, collection: UniformCollection| {
        groups[group].cases.push(UniformCollectionCase {
            name_prefix: if name.is_empty() {
                String::new()
            } else {
                format!("{name}_")
            },
            collection: Arc::new(collection),
        });
    };

    for data_type in TEST_DATA_TYPES {
        let type_name = data_type.name();

        push(
            &mut groups,
            COLLECTIONS_BASIC,
            type_name,
            UniformCollection::basic(data_type, ""),
        );

        if data_type.is_scalar()
            || (data_type.is_vector() && data_type.scalar_size() == 4)
            || data_type == DataType::FloatMat4
            || data_type == DataType::Sampler2D
        {
            push(
                &mut groups,
                COLLECTIONS_BASIC_ARRAY,
                type_name,
                UniformCollection::basic_array(data_type, ""),
            );
        }

        if data_type.is_scalar() || data_type == DataType::FloatMat4 || data_type == DataType::Sampler2D {
            let second_data_type = if data_type.is_scalar() {
                get_data_type_vector(data_type, 4)
            } else if data_type == DataType::FloatMat4 {
                DataType::FloatMat2
            } else {
                DataType::SamplerCube
            };
            let name = format!("{type_name}_{}", second_data_type.name());

            push(
                &mut groups,
                BASIC_STRUCT,
                &name,
                UniformCollection::basic_struct(data_type, second_data_type, false, ""),
            );
            push(
                &mut groups,
                COLLECTIONS_ARRAY_IN_STRUCT,
                &name,
                UniformCollection::basic_struct(data_type, second_data_type, true, ""),
            );
            push(
                &mut groups,
                STRUCT_IN_ARRAY,
                &name,
                UniformCollection::struct_in_array(data_type, second_data_type, false, ""),
            );
            push(
                &mut groups,
                NESTED_STRUCTS_ARRAYS,
                &name,
                UniformCollection::nested_arrays_structs(data_type, second_data_type, ""),
            );
        }
    }

    push(&mut groups, MULTIPLE_BASIC, "", UniformCollection::multiple_basic());
    push(
        &mut groups,
        COLLECTIONS_MULTIPLE_BASIC_ARRAY,
        "",
        UniformCollection::multiple_basic_array(),
    );
    push(
        &mut groups,
        MULTIPLE_NESTED_STRUCTS_ARRAYS,
        "",
        UniformCollection::multiple_nested_arrays_structs(),
    );

    groups
}

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    case_shader_type: CaseShaderType,
    collection: &Arc<UniformCollection>,
    features: u32,
    kind: CaseKind,
) {
    group.add_child(Box::new(UniformCase {
        name,
        es_version: EsVersion::Es3,
        case_shader_type,
        uniform_collection: Arc::clone(collection),
        features,
        kind,
    }) as Box<dyn TestCase>);
}

/// `UniformApiTests::init`
#[allow(clippy::too_many_lines)]
pub fn create_tests() -> TestCaseGroup {
    let collections = default_uniform_collections();
    let mut group = TestCaseGroup::new("uniform_api");

    // Info-query cases (check info returned by e.g. glGetActiveUniforms()).
    {
        let mut info_query_group = TestCaseGroup::new("info_query");

        for case_type in [
            InfoQueryType::Uniform,
            InfoQueryType::IndicesUniformsiv,
            InfoQueryType::Consistency,
        ] {
            let mut case_type_group = TestCaseGroup::new(case_type.name());

            for (collection_group_ndx, collection_group) in collections.iter().enumerate() {
                let num_array_first_elem_name_cases = usize::from(
                    case_type == InfoQueryType::IndicesUniformsiv && collection_group_ndx == COLLECTIONS_BASIC_ARRAY,
                ) + 1;

                for refer_to_first_array_elem_without_index in 0..num_array_first_elem_name_cases {
                    let collection_group_name = if refer_to_first_array_elem_without_index == 0 {
                        collection_group.name.to_string()
                    } else {
                        format!("{}_first_elem_without_brackets", collection_group.name)
                    };
                    let mut collection_test_group = TestCaseGroup::new(collection_group_name);

                    for collection_case in &collection_group.cases {
                        for shader_type in CASE_SHADER_TYPES {
                            add_case(
                                &mut collection_test_group,
                                format!("{}{}", collection_case.name_prefix, shader_type.name()),
                                shader_type,
                                &collection_case.collection,
                                if refer_to_first_array_elem_without_index == 0 {
                                    0
                                } else {
                                    FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX
                                },
                                CaseKind::InfoQuery(case_type),
                            );
                        }
                    }

                    case_type_group.add_child(collection_test_group);
                }
            }

            // Info-querying cases when unused uniforms are present.
            {
                let mut unused_uniforms_group = TestCaseGroup::new("unused_uniforms");

                for collection_case in &collections[COLLECTIONS_ARRAY_IN_STRUCT].cases {
                    for shader_type in CASE_SHADER_TYPES {
                        add_case(
                            &mut unused_uniforms_group,
                            format!("{}{}", collection_case.name_prefix, shader_type.name()),
                            shader_type,
                            &collection_case.collection,
                            FEATURE_UNIFORMUSAGE_EVERY_OTHER | FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX,
                            CaseKind::InfoQuery(case_type),
                        );
                    }
                }

                case_type_group.add_child(unused_uniforms_group);
            }

            info_query_group.add_child(case_type_group);
        }

        group.add_child(info_query_group);
    }

    // Cases testing uniform values.
    {
        let mut value_group = TestCaseGroup::new("value");

        // Cases checking uniforms' initial values (all must be zeros).
        {
            let mut initial_values_group = TestCaseGroup::new("initial");

            for check_method in [CheckMethod::GetUniform, CheckMethod::Render] {
                let mut check_method_group = TestCaseGroup::new(check_method.name());

                for (collection_group_ndx, collection_group) in collections.iter().enumerate() {
                    let mut collection_test_group = TestCaseGroup::new(collection_group.name);

                    for collection_case in &collection_group.cases {
                        let collection = &collection_case.collection;
                        let contains_booleans = collection.contains_matching_basic_type(is_bool_or_bvec);
                        let vary_bool_api_type = check_method == CheckMethod::GetUniform
                            && contains_booleans
                            && (collection_group_ndx == COLLECTIONS_BASIC
                                || collection_group_ndx == COLLECTIONS_BASIC_ARRAY);
                        let num_bool_variations = if vary_bool_api_type { 3 } else { 1 };

                        // \note Samplers' initial API values (i.e. their texture units) are 0,
                        // and no two samplers of different types shall have same unit when rendering.
                        if check_method == CheckMethod::Render && collection.contains_several_sampler_types() {
                            continue;
                        }

                        for boolean_type_i in 0..num_bool_variations {
                            let (boolean_type_feat, boolean_type_name) = bool_api_variation(boolean_type_i);
                            let name_with_api_type = if vary_bool_api_type {
                                format!("{}api_{boolean_type_name}_", collection_case.name_prefix)
                            } else {
                                collection_case.name_prefix.clone()
                            };

                            for shader_type in CASE_SHADER_TYPES {
                                add_case(
                                    &mut collection_test_group,
                                    format!("{name_with_api_type}{}", shader_type.name()),
                                    shader_type,
                                    collection,
                                    FEATURE_UNIFORMVALUE_ZERO | boolean_type_feat,
                                    CaseKind::Value(ValueToCheck::Initial, check_method),
                                );
                            }
                        }
                    }

                    check_method_group.add_child(collection_test_group);
                }

                initial_values_group.add_child(check_method_group);
            }

            value_group.add_child(initial_values_group);
        }

        // Cases that first assign values to each uniform, then check them.
        {
            let mut assigned_values_group = TestCaseGroup::new("assigned");

            for assign_method in [AssignMethod::Pointer, AssignMethod::Value] {
                let mut assign_method_group = TestCaseGroup::new(assign_method.name());

                for check_method in [CheckMethod::GetUniform, CheckMethod::Render] {
                    let mut check_method_group = TestCaseGroup::new(check_method.name());

                    for (collection_group_ndx, collection_group) in collections.iter().enumerate() {
                        let num_array_first_elem_name_cases = usize::from(
                            check_method == CheckMethod::GetUniform && collection_group_ndx == COLLECTIONS_BASIC_ARRAY,
                        ) + 1;

                        for refer_to_first_array_elem_without_index in 0..num_array_first_elem_name_cases {
                            let collection_group_name = if refer_to_first_array_elem_without_index == 0 {
                                collection_group.name.to_string()
                            } else {
                                format!("{}_first_elem_without_brackets", collection_group.name)
                            };
                            // Skip empty groups by creating groups on demand.
                            let mut collection_test_group: Option<TestCaseGroup> = None;

                            for collection_case in &collection_group.cases {
                                let collection = &collection_case.collection;
                                let contains_booleans = collection.contains_matching_basic_type(is_bool_or_bvec);
                                let vary_bool_api_type = check_method == CheckMethod::GetUniform
                                    && contains_booleans
                                    && (collection_group_ndx == COLLECTIONS_BASIC
                                        || collection_group_ndx == COLLECTIONS_BASIC_ARRAY);
                                let num_bool_variations = if vary_bool_api_type { 3 } else { 1 };
                                let contains_matrices = collection.contains_matching_basic_type(is_matrix);
                                let vary_matrix_mode = contains_matrices
                                    && (collection_group_ndx == COLLECTIONS_BASIC
                                        || collection_group_ndx == COLLECTIONS_BASIC_ARRAY);
                                let num_mat_variations = if vary_matrix_mode { 2 } else { 1 };

                                if contains_matrices && assign_method != AssignMethod::Pointer {
                                    continue;
                                }

                                for boolean_type_i in 0..num_bool_variations {
                                    let (boolean_type_feat, boolean_type_name) = bool_api_variation(boolean_type_i);
                                    let name_with_bool_type = if vary_bool_api_type {
                                        format!("{}api_{boolean_type_name}_", collection_case.name_prefix)
                                    } else {
                                        collection_case.name_prefix.clone()
                                    };

                                    for matrix_type_i in 0..num_mat_variations {
                                        let name_with_matrix_type = format!(
                                            "{name_with_bool_type}{}",
                                            if matrix_type_i == 1 { "row_major_" } else { "" }
                                        );

                                        for shader_type in CASE_SHADER_TYPES {
                                            let features = boolean_type_feat
                                                | if refer_to_first_array_elem_without_index == 0 {
                                                    0
                                                } else {
                                                    FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX
                                                }
                                                | if matrix_type_i == 1 {
                                                    FEATURE_MATRIXMODE_ROWMAJOR
                                                } else {
                                                    0
                                                }
                                                | if assign_method == AssignMethod::Value {
                                                    FEATURE_UNIFORMFUNC_VALUE
                                                } else {
                                                    0
                                                };

                                            add_case(
                                                collection_test_group.get_or_insert_with(|| {
                                                    TestCaseGroup::new(collection_group_name.clone())
                                                }),
                                                format!("{name_with_matrix_type}{}", shader_type.name()),
                                                shader_type,
                                                collection,
                                                features,
                                                CaseKind::Value(ValueToCheck::Assigned, check_method),
                                            );
                                        }
                                    }
                                }
                            }

                            if let Some(collection_test_group) = collection_test_group {
                                check_method_group.add_child(collection_test_group);
                            }
                        }
                    }

                    assign_method_group.add_child(check_method_group);
                }

                assigned_values_group.add_child(assign_method_group);
            }

            // Cases assigning multiple basic-array elements with one glUniform*v().
            {
                const ARRAY_ASSIGN_GROUPS: [(u32, &str); 2] = [
                    (FEATURE_ARRAYASSIGN_FULL, "basic_array_assign_full"),
                    (FEATURE_ARRAYASSIGN_BLOCKS_OF_TWO, "basic_array_assign_partial"),
                ];
                const BASIC_ARRAY_COLLECTION_GROUPS: [usize; 3] = [
                    COLLECTIONS_BASIC_ARRAY,
                    COLLECTIONS_ARRAY_IN_STRUCT,
                    COLLECTIONS_MULTIPLE_BASIC_ARRAY,
                ];

                for (array_assign_mode, group_name) in ARRAY_ASSIGN_GROUPS {
                    let mut cur_array_assign_group = TestCaseGroup::new(group_name);

                    for collection_group_ndx in BASIC_ARRAY_COLLECTION_GROUPS {
                        let collection_group = &collections[collection_group_ndx];
                        let mut collection_test_group = TestCaseGroup::new(collection_group.name);

                        for collection_case in &collection_group.cases {
                            for shader_type in CASE_SHADER_TYPES {
                                add_case(
                                    &mut collection_test_group,
                                    format!("{}{}", collection_case.name_prefix, shader_type.name()),
                                    shader_type,
                                    &collection_case.collection,
                                    array_assign_mode,
                                    CaseKind::Value(ValueToCheck::Assigned, CheckMethod::GetUniform),
                                );
                            }
                        }

                        cur_array_assign_group.add_child(collection_test_group);
                    }

                    assigned_values_group.add_child(cur_array_assign_group);
                }
            }

            // Value checking cases when unused uniforms are present.
            {
                let mut unused_uniforms_group = TestCaseGroup::new("unused_uniforms");

                for collection_case in &collections[COLLECTIONS_ARRAY_IN_STRUCT].cases {
                    for shader_type in CASE_SHADER_TYPES {
                        add_case(
                            &mut unused_uniforms_group,
                            format!("{}{}", collection_case.name_prefix, shader_type.name()),
                            shader_type,
                            &collection_case.collection,
                            FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX | FEATURE_UNIFORMUSAGE_EVERY_OTHER,
                            CaseKind::Value(ValueToCheck::Assigned, CheckMethod::GetUniform),
                        );
                    }
                }

                assigned_values_group.add_child(unused_uniforms_group);
            }

            value_group.add_child(assigned_values_group);
        }

        group.add_child(value_group);
    }

    // Random cases.
    {
        const NUM_RANDOM_CASES: u32 = 100;
        let mut random_group = TestCaseGroup::new("random");

        for ndx in 0..NUM_RANDOM_CASES {
            random_group.add_child(Box::new(UniformCase {
                name: ndx.to_string(),
                es_version: EsVersion::Es3,
                case_shader_type: random_case_shader_type(ndx),
                uniform_collection: Arc::new(UniformCollection::random(ndx, &TEST_DATA_TYPES)),
                features: random_features(ndx, EsVersion::Es3),
                kind: CaseKind::Random,
            }) as Box<dyn TestCase>);
        }

        group.add_child(random_group);
    }

    let _ = COLLECTIONS_LAST;
    group
}
