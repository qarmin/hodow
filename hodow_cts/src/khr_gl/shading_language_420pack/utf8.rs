// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (UTF8CharactersTest, UTF8InSourceTest, Utils::getUtf8Character)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `DEBUG_CASE` and the `-1` test case index (debug aids upstream never registers) are left out.

use super::objects::{ShaderSource, Texture};
use super::templates::*;
use super::{
    Case420, Kind, ShaderStage, StageTemplates, prepare_blue_square_texture, replace_all_tokens, replace_token,
    version_string,
};
use crate::glu::Context;
use crate::tcu::TestError;

/// `Utils::UTF8_CHARACTERS` without `EMPTY`
#[derive(Clone, Copy)]
pub(super) enum Utf8Character {
    TwoBytes,
    ThreeBytes,
    FourBytes,
    FiveBytes,
    SixBytes,
    RedundantAscii,
}

impl Utf8Character {
    /// `Utils::getUtf8Character`
    fn bytes(self) -> &'static [u8] {
        match self {
            Self::TwoBytes => &[0xd7, 0x84],
            Self::ThreeBytes => &[0xe3, 0x82, 0x81],
            Self::FourBytes => &[0xf0, 0x93, 0x83, 0x93],
            Self::FiveBytes => &[0xfa, 0x82, 0x82, 0x82, 0x82],
            Self::SixBytes => &[0xfd, 0x82, 0x82, 0x82, 0x82, 0x82],
            Self::RedundantAscii => &[0xf2, 0x80, 0x80, 0x5e],
        }
    }

    fn name(self) -> &'static str {
        match self {
            Self::TwoBytes => "two_bytes",
            Self::ThreeBytes => "three_bytes",
            Self::FourBytes => "four_bytes",
            Self::FiveBytes => "five_bytes",
            Self::SixBytes => "six_bytes",
            Self::RedundantAscii => "redundant_bytes",
        }
    }
}

/// `UTF8CharactersTest::CASES`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Utf8Placement {
    InComment,
    InPreprocessor,
    AsLastCharacterNullTerminated,
    AsLastCharacterNonNullTerminated,
}

impl Utf8Placement {
    fn name(self) -> &'static str {
        match self {
            Self::InComment => "in_comment",
            Self::InPreprocessor => "in_preprocessor",
            Self::AsLastCharacterNullTerminated => "just_before_null",
            Self::AsLastCharacterNonNullTerminated => "as_last_character",
        }
    }
}

use Utf8Character::*;
use Utf8Placement::*;

const ALL_CHARACTERS: [Utf8Character; 6] = [TwoBytes, ThreeBytes, FourBytes, FiveBytes, SixBytes, RedundantAscii];

const fn characters_cases() -> [(Utf8Placement, Utf8Character); 24] {
    let placements = [
        InComment,
        InPreprocessor,
        AsLastCharacterNullTerminated,
        AsLastCharacterNonNullTerminated,
    ];
    let mut cases = [(InComment, TwoBytes); 24];
    let mut i = 0;
    while i < 24 {
        cases[i] = (placements[i / 6], ALL_CHARACTERS[i % 6]);
        i += 1;
    }
    cases
}

/// `addUTF8CharactersTest`
pub(super) const CHARACTERS_CASES: [(Utf8Placement, Utf8Character); 24] = characters_cases();

/// `addUTF8InSourceTest`
pub(super) const IN_SOURCE_CHARACTERS: [Utf8Character; 6] = ALL_CHARACTERS;

/// `UTF8CharactersTest`
pub(super) struct Utf8Characters {
    name: String,
    placement: Utf8Placement,
    character: Utf8Character,
}

impl Utf8Characters {
    pub(super) fn new(placement: Utf8Placement, character: Utf8Character) -> Self {
        Self {
            name: format!(
                "utf8_characters_case_{}_character_{}",
                placement.name(),
                character.name()
            ),
            placement,
            character,
        }
    }
}

impl Case420 for Utf8Characters {
    const KIND: Kind = Kind::Glsl;

    fn name(&self) -> &str {
        &self.name
    }

    fn shader_source_config(&self, _case_index: usize) -> (usize, bool) {
        (1, self.placement == AsLastCharacterNonNullTerminated)
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
            compute: UTF8_CHARACTERS_COMPUTE_SHADER_TEMPLATE,
            fragment: UTF8_CHARACTERS_FRAGMENT_SHADER_TEMPLATE,
            geometry: UTF8_CHARACTERS_GEOMETRY_SHADER_TEMPLATE,
            tess_control: UTF8_CHARACTERS_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: UTF8_CHARACTERS_TESS_EVAL_SHADER_TEMPLATE,
            vertex: UTF8_CHARACTERS_VERTEX_SHADER_TEMPLATE,
        };

        let utf8_character = self.character.bytes();
        let nothing: &[u8] = b"";
        let (comment_case, preprocessor_case, last_character_case) = match self.placement {
            InComment => (utf8_character, nothing, nothing),
            InPreprocessor => (nothing, utf8_character, nothing),
            AsLastCharacterNullTerminated | AsLastCharacterNonNullTerminated => (nothing, nothing, utf8_character),
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
        replace_all_tokens("COMMENT_CASE", comment_case, code);
        replace_all_tokens("PREPROCESSOR_CASE", preprocessor_case, code);
        replace_all_tokens("LAST_CHARACTER_CASE", last_character_case, code);
    }

    fn prepare_source_texture(
        &self,
        _context: &Context,
        texture: &mut Texture,
        _case_index: usize,
    ) -> Result<Option<&'static str>, TestError> {
        prepare_blue_square_texture(texture).map(Some)
    }
}

/// `UTF8InSourceTest`
pub(super) struct Utf8InSource {
    name: String,
    character: Utf8Character,
}

impl Utf8InSource {
    pub(super) fn new(character: Utf8Character) -> Self {
        Self {
            name: format!("utf8_in_source_character_{}", character.name()),
            character,
        }
    }
}

impl Case420 for Utf8InSource {
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
            compute: UTF8_IN_SOURCE_COMPUTE_SHADER_TEMPLATE,
            fragment: UTF8_IN_SOURCE_FRAGMENT_SHADER_TEMPLATE,
            geometry: UTF8_IN_SOURCE_GEOMETRY_SHADER_TEMPLATE,
            tess_control: UTF8_IN_SOURCE_TESS_CTRL_SHADER_TEMPLATE,
            tess_evaluation: UTF8_IN_SOURCE_TESS_EVAL_SHADER_TEMPLATE,
            vertex: UTF8_IN_SOURCE_VERTEX_SHADER_TEMPLATE,
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
        replace_all_tokens("HERE", self.character.bytes(), code);
    }
}
