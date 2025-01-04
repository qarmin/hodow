// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (GLSL420Pack::Utils qualifier and variable helpers)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The helpers keep upstream's token-replacement algorithms (including the `position -= length` steps) so the strings they build are identical.

use super::ShaderStage;

/// `Utils::QUALIFIERS`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Qualifier {
    #[expect(dead_code, reason = "upstream's enumerator, never constructed by this port")]
    None,
    Const,
    In,
    Out,
    Inout,
    Uniform,
    Patch,
    #[expect(dead_code, reason = "upstream's enumerator, never constructed by this port")]
    Centroid,
    Sample,
    Flat,
    Noperspective,
    Smooth,
    Location,
    Lowp,
    Mediump,
    Highp,
    Precise,
    Invariant,
}

/// `Utils::VARIABLE_STORAGE`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum VariableStorage {
    Input,
    Output,
    Uniform,
}

/// `Utils::VARIABLE_FLAVOUR`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum VariableFlavour {
    Basic,
    Array,
    IndexedByInvocationId,
}

pub(super) type QualifierSet = Vec<Qualifier>;

/// `Utils::replaceToken` on text: the first `token` at or after `search_position`.
fn replace_token(token: &str, search_position: &mut usize, text: &str, string: &mut String) {
    let token_position = *search_position
        + string[*search_position..]
            .find(token)
            .expect("the token is present in the template");
    string.replace_range(token_position..token_position + token.len(), text);
    *search_position = token_position + text.len();
}

/// `Utils::doesContainQualifier`
pub(super) fn does_contain_qualifier(qualifier: Qualifier, qualifiers: &[Qualifier]) -> bool {
    qualifiers.contains(&qualifier)
}

/// `Utils::doesStageSupportQualifier`
pub(super) fn does_stage_support_qualifier(stage: ShaderStage, storage: VariableStorage, qualifier: Qualifier) -> bool {
    use Qualifier::*;
    use VariableStorage::{Input, Output};

    match stage {
        ShaderStage::Compute => matches!(
            qualifier,
            Qualifier::None | Uniform | Lowp | Mediump | Highp | Invariant
        ),
        ShaderStage::Fragment => {
            if qualifier == Patch {
                false
            } else {
                !(storage == Output && matches!(qualifier, Smooth | Noperspective | Flat))
            }
        }
        ShaderStage::Vertex => {
            if qualifier == Patch {
                false
            } else {
                !(storage == Input
                    && matches!(qualifier, Smooth | Noperspective | Flat | Invariant | Centroid | Sample))
            }
        }
        ShaderStage::Geometry => qualifier != Patch,
        ShaderStage::TessControl => !(storage == Input && qualifier == Patch),
        ShaderStage::TessEval => !(storage == Output && qualifier == Patch),
    }
}

/// `Utils::getQualifierString`
pub(super) fn qualifier_string(qualifier: Qualifier) -> &'static str {
    match qualifier {
        Qualifier::None => "",
        Qualifier::Const => "const",
        Qualifier::In => "in",
        Qualifier::Out => "out",
        Qualifier::Inout => "inout",
        Qualifier::Uniform => "uniform",
        Qualifier::Patch => "patch",
        Qualifier::Centroid => "centroid",
        Qualifier::Sample => "sample",
        Qualifier::Flat => "flat",
        Qualifier::Noperspective => "noperspective",
        Qualifier::Smooth => "smooth",
        Qualifier::Location => "layout (location = LOC_VALUE)",
        Qualifier::Lowp => "lowp",
        Qualifier::Mediump => "mediump",
        Qualifier::Highp => "highp",
        Qualifier::Precise => "precise",
        Qualifier::Invariant => "invariant",
    }
}

/// `Utils::getQualifiersListString`
pub(super) fn qualifiers_list_string(qualifiers: &[Qualifier]) -> String {
    const QUALIFIER_LIST: &str = "QUALIFIER QUALIFIER_LIST";
    const TOKEN_QUALIFIER: &str = "QUALIFIER";
    const TOKEN_QUAL_LIST: &str = "QUALIFIER_LIST";

    let mut list = TOKEN_QUAL_LIST.to_string();
    let mut position = 0;

    for &qualifier in qualifiers {
        replace_token(TOKEN_QUAL_LIST, &mut position, QUALIFIER_LIST, &mut list);
        position -= QUALIFIER_LIST.len();
        replace_token(TOKEN_QUALIFIER, &mut position, qualifier_string(qualifier), &mut list);
    }

    replace_token(TOKEN_QUAL_LIST, &mut position, "", &mut list);
    list
}

/// `Utils::prepareQualifiersSet`
pub(super) fn prepare_qualifiers_set(
    in_qualifiers: &[Qualifier],
    stage: ShaderStage,
    storage: VariableStorage,
) -> QualifierSet {
    let mut result = QualifierSet::new();

    for &in_qualifier in in_qualifiers {
        let mut qualifier = in_qualifier;

        if !does_stage_support_qualifier(stage, storage, qualifier) {
            continue;
        }

        if storage == VariableStorage::Input && matches!(qualifier, Qualifier::Uniform | Qualifier::Out) {
            qualifier = Qualifier::In;
        } else if storage == VariableStorage::Output && matches!(qualifier, Qualifier::In | Qualifier::Uniform) {
            qualifier = Qualifier::Out;
        } else if storage == VariableStorage::Uniform && matches!(qualifier, Qualifier::In | Qualifier::Out) {
            qualifier = Qualifier::Uniform;
        }

        result.push(qualifier);
    }

    result
}

/// `Utils::getBlockVariableDefinition`
pub(super) fn block_variable_definition(qualifiers: &[Qualifier], type_name: &str, variable_name: &str) -> String {
    let mut variable_definition = "QUALIFIER_LISTTYPE VARIABLE_NAME".to_string();
    let mut position = 0;
    let list = qualifiers_list_string(qualifiers);

    replace_token("QUALIFIER_LIST", &mut position, &list, &mut variable_definition);
    replace_token("TYPE", &mut position, type_name, &mut variable_definition);
    replace_token("VARIABLE_NAME", &mut position, variable_name, &mut variable_definition);
    variable_definition
}

/// `Utils::getBlockVariableReference`
pub(super) fn block_variable_reference(flavour: VariableFlavour, variable_name: &str, block_name: &str) -> String {
    let mut variable_definition = match flavour {
        VariableFlavour::Basic => "BLOCK_NAME.VARIABLE_NAME",
        VariableFlavour::Array => "BLOCK_NAME[0].VARIABLE_NAME",
        VariableFlavour::IndexedByInvocationId => "BLOCK_NAME[gl_InvocationID].VARIABLE_NAME",
    }
    .to_string();
    let mut position = 0;

    variable_definition = variable_definition.replace("BLOCK_NAME", block_name);
    replace_token("VARIABLE_NAME", &mut position, variable_name, &mut variable_definition);
    variable_definition
}

/// `Utils::getVariableDefinition`
pub(super) fn variable_definition(
    flavour: VariableFlavour,
    qualifiers: &[Qualifier],
    type_name: &str,
    variable_name: &str,
) -> String {
    let mut definition = match flavour {
        VariableFlavour::Basic => "QUALIFIER_LISTTYPE VARIABLE_NAME",
        VariableFlavour::Array | VariableFlavour::IndexedByInvocationId => "QUALIFIER_LISTTYPE VARIABLE_NAME[]",
    }
    .to_string();
    let mut position = 0;
    let list = qualifiers_list_string(qualifiers);

    replace_token("QUALIFIER_LIST", &mut position, &list, &mut definition);
    replace_token("TYPE", &mut position, type_name, &mut definition);
    replace_token("VARIABLE_NAME", &mut position, variable_name, &mut definition);
    definition
}

/// `Utils::getVariableFlavour`
pub(super) fn variable_flavour(
    stage: ShaderStage,
    storage: VariableStorage,
    qualifiers: &[Qualifier],
) -> VariableFlavour {
    if storage == VariableStorage::Uniform {
        return VariableFlavour::Basic;
    }

    match stage {
        ShaderStage::Geometry => {
            if storage == VariableStorage::Input {
                VariableFlavour::Array
            } else {
                VariableFlavour::Basic
            }
        }
        ShaderStage::TessEval => {
            if !does_contain_qualifier(Qualifier::Patch, qualifiers) && storage == VariableStorage::Input {
                VariableFlavour::Array
            } else {
                VariableFlavour::Basic
            }
        }
        ShaderStage::TessControl => {
            if does_contain_qualifier(Qualifier::Patch, qualifiers) && storage == VariableStorage::Output {
                VariableFlavour::Basic
            } else {
                VariableFlavour::IndexedByInvocationId
            }
        }
        ShaderStage::Vertex | ShaderStage::Fragment => VariableFlavour::Basic,
        ShaderStage::Compute => unreachable!("upstream fails with Invliad enum"),
    }
}

/// `Utils::getVariableName`
pub(super) fn variable_name(stage: ShaderStage, storage: VariableStorage, variable_name: &str) -> String {
    const PREFIXES: [[(&str, &str); 6]; 3] = [
        [
            ("", ""),
            ("in", "vs"),
            ("vs", "tcs"),
            ("tcs", "tes"),
            ("tes", "gs"),
            ("gs", "fs"),
        ],
        [
            ("", ""),
            ("vs", "tcs"),
            ("tcs", "tes"),
            ("tes", "gs"),
            ("gs", "fs"),
            ("fs", "out"),
        ],
        [
            ("uni", "comp"),
            ("uni", "vs"),
            ("uni", "tcs"),
            ("uni", "tes"),
            ("uni", "gs"),
            ("uni", "fs"),
        ],
    ];

    let (preceeding, prefix) = PREFIXES[storage as usize][stage as usize];
    let mut name = "PRECEEDING_PREFIX_VARIABLE_NAME".to_string();
    let mut position = 0;

    replace_token("PRECEEDING", &mut position, preceeding, &mut name);
    replace_token("PREFIX", &mut position, prefix, &mut name);
    replace_token("VARIABLE_NAME", &mut position, variable_name, &mut name);
    name
}

/// `Utils::getVariableReference`
pub(super) fn variable_reference(flavour: VariableFlavour, variable_name: &str) -> String {
    let mut reference = match flavour {
        VariableFlavour::Basic => "VARIABLE_NAME",
        VariableFlavour::Array => "VARIABLE_NAME[0]",
        VariableFlavour::IndexedByInvocationId => "VARIABLE_NAME[gl_InvocationID]",
    }
    .to_string();
    let mut position = 0;

    replace_token("VARIABLE_NAME", &mut position, variable_name, &mut reference);
    reference
}

/// `Utils::prepareBlockVariableStrings`: the definition and the reference.
pub(super) fn prepare_block_variable_strings(
    stage: ShaderStage,
    storage: VariableStorage,
    in_qualifiers: &[Qualifier],
    type_name: &str,
    in_variable_name: &str,
    block_name: &str,
) -> (String, String) {
    let flavour = variable_flavour(stage, storage, in_qualifiers);
    let qualifiers = prepare_qualifiers_set(in_qualifiers, stage, storage);
    let name = variable_name(stage, storage, in_variable_name);

    (
        block_variable_definition(&qualifiers, type_name, &name),
        block_variable_reference(flavour, &name, block_name),
    )
}

/// `Utils::prepareVariableStrings`: the definition and the reference.
pub(super) fn prepare_variable_strings(
    stage: ShaderStage,
    storage: VariableStorage,
    in_qualifiers: &[Qualifier],
    type_name: &str,
    in_variable_name: &str,
) -> (String, String) {
    let flavour = variable_flavour(stage, storage, in_qualifiers);
    let qualifiers = prepare_qualifiers_set(in_qualifiers, stage, storage);
    let name = variable_name(stage, storage, in_variable_name);

    (
        variable_definition(flavour, &qualifiers, type_name, &name),
        variable_reference(flavour, &name),
    )
}
