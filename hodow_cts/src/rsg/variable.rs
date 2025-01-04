// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgVariable.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The header is a genuine leaf (`rsgDefs`/`rsgVariableType`/`rsgToken` only, confirmed
// by reading it directly) - only the `.cpp` reaches for `rsgGeneratorState`/`rsgShader`,
// and only for one method. This project's prior session assumed the whole file was
// blocked on those from the `.cpp`'s own `#include`s alone (`tmp/DO_UNTIL_CTS_
// FOUNDATIONS_GLES23.md`'s iteration 11 note); re-checking which *methods* actually use
// them, rather than stopping at the file-level include list, is what unblocked this -
// the same lesson `rsgVariableValue` (ported earlier this session) already demonstrated
// for an `.hpp`-level dependency.
//
// **`Variable::tokenizeDeclaration` is now ported too** - re-read against its real body
// in `rsgVariable.cpp` (not re-guessed from the stale summary this module's own doc
// comment used to carry): it needs only `GeneratorState::getProgramParameters().version`
// (already available wherever this is called from) and `state.getShader().getType()` -
// which, read closely, is used *only* to pick `vertex` vs `fragment` wording
// (`attribute`/`varying` under GLSL ES 1.0, `mediump` placement under ES 3.0) - not the
// whole `Shader` object. `ShaderType` below is that one bit, standing in for upstream's
// `Shader::Type` until `rsg::shader` exists for real; every `Token` variant the real
// body emits (`Const`/`In`/`Out`/`Inout`/`Uniform`/`MediumPrecision`/`Layout`/
// `Location`/`Attribute`/`Varying`) was already ported as part of `rsg::token`, so this
// needed no new tokens either - confirmed by grepping for all ten before writing this,
// not discovered by a failed compile. This closes the one real gap `rsgVariable.hpp`'s
// own header had - see this module's own earlier note on how the "whole file blocked on
// the `.cpp`'s `#include`s" assumption was already wrong once for this same file.
//
// **`Variable::isWritable` is NOT ported, for a different reason**: it is
// *declared* in `rsgVariable.hpp` but never *defined* anywhere in
// `framework/randomshaders/` (grepped the whole directory - zero definitions, zero call
// sites). A C++ translation unit that never instantiates a call to it links fine
// regardless; calling it would be a link error. This is dead, unimplemented upstream
// API - there is no body to port, and guessing one would not be a port at all.
//
// **A later session found and fixed a genuine, if currently unreachable, divergence
// from upstream inside `tokenize_declaration`'s own `STORAGE_SHADER_OUT` arm**: the
// GLSL-ES-1.0 (`version < VERSION_300`) half of that arm had collapsed upstream's real
// `if (vertex) str << VARYING << MEDIUM_PRECISION; else DE_ASSERT(false);` into an
// unconditional push plus a side `debug_assert_eq!` - observably different from
// upstream in a *release* build, where `DE_ASSERT(false)` is a no-op that emits
// **no tokens at all**, not upstream's `varying mediump` for every shader type
// regardless. Confirmed unreachable on both sides of the port by the identical
// invariant: the only `STORAGE_SHADER_OUT` variable a `VERSION_100` fragment shader
// ever gets is named `"gl_FragColor"`, and `ShaderGenerator::generate`'s/
// `shader_generator::generate`'s own "declare live globals" loop filters any
// `gl_`-prefixed name out *before* building the one kind of statement
// (`DeclarationStatement`) that ever calls `tokenizeDeclaration`/
// `tokenize_declaration` at all (`!deStringBeginsWith(name, "gl_")` /
// `!name.starts_with("gl_")`, confirmed identical side by side). Fixed anyway, not
// just documented, per this project's "keep upstream C++ shape" rule and because
// upstream's own open `\todo` ("Multiple outputs from fragment shader!") could someday
// make this reachable for real. See the arm's own doc comment for the full account.

use super::parameters::Version;
use super::token::{Token, TokenStream};
use super::variable_type::VariableType;

/// `rsg::Shader::Type` - the one bit of `rsg::Shader` `Variable::tokenizeDeclaration`
/// actually needs (see this module's own top doc comment). Lives here, not in a
/// `rsg::shader` module, because nothing else in this port needs the rest of `Shader`
/// yet; move it there (as `Shader::Type` or similar) once that module exists for real,
/// rather than duplicating it. Upstream's third enumerator, `TYPE_LAST`, is a C++
/// enum-count sentinel, never a real value anywhere - not carried over.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ShaderType {
    Vertex,
    Fragment,
}

/// `rsg::Variable::Storage`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Storage {
    Local,
    ShaderIn,
    ShaderOut,
    Uniform,
    Const,
    ParameterIn,
    ParameterOut,
    ParameterInout,
}

/// `rsg::Variable`
#[derive(Debug, Clone)]
pub struct Variable {
    type_: VariableType,
    storage: Storage,
    name: String,
    layout_location: i32,
}

impl Variable {
    /// `Variable::Variable` - `m_layoutLocation(-1)`, matching `has_layout_location`'s
    /// own `>= 0` test below.
    pub fn new(type_: VariableType, storage: Storage, name: impl Into<String>) -> Self {
        Self {
            type_,
            storage,
            name: name.into(),
            layout_location: -1,
        }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn get_storage(&self) -> Storage {
        self.storage
    }

    pub fn get_name(&self) -> &str {
        &self.name
    }

    pub fn get_layout_location(&self) -> i32 {
        self.layout_location
    }

    pub fn has_layout_location(&self) -> bool {
        self.layout_location >= 0
    }

    pub fn set_storage(&mut self, storage: Storage) {
        self.storage = storage;
    }

    pub fn set_layout_location(&mut self, location: i32) {
        self.layout_location = location;
    }

    /// `Variable::tokenizeDeclaration(GeneratorState&, TokenStream&)` - see this
    /// module's own top doc comment for why `version`/`shader_type` (two plain values)
    /// stand in for the `GeneratorState&`/implicit `Shader&` upstream reaches for.
    /// `\todo` upstream: "Remove precision hacks once precision handling is
    /// implemented" - carried over unfixed, matching upstream's own still-open state
    /// (`VariableType::get_precision` always returns `None` today, confirmed in
    /// `rsg::variable_type`'s own doc comment).
    pub fn tokenize_declaration(&self, version: Version, shader_type: ShaderType, str: &mut TokenStream) {
        match self.storage {
            Storage::Const => {
                str.push(Token::Const);
            }
            Storage::ParameterIn => {
                str.push(Token::In);
            }
            Storage::ParameterOut => {
                str.push(Token::Out);
            }
            Storage::ParameterInout => {
                str.push(Token::Inout);
            }

            Storage::Uniform => {
                str.push(Token::Uniform);
                if self.type_.is_float_or_vec() || self.type_.is_int_or_vec() {
                    str.push(Token::MediumPrecision);
                }
            }

            Storage::ShaderIn => {
                if version == Version::Version300 {
                    if self.has_layout_location() {
                        str.push(Token::Layout);
                        str.push(Token::LeftParen);
                        str.push(Token::Location);
                        str.push(Token::Equal);
                        str.push(Token::IntLiteral(self.layout_location));
                        str.push(Token::RightParen);
                    }

                    str.push(Token::In);

                    if shader_type == ShaderType::Fragment {
                        str.push(Token::MediumPrecision);
                    }
                } else {
                    debug_assert!(!self.has_layout_location());

                    match shader_type {
                        ShaderType::Vertex => {
                            str.push(Token::Attribute);
                        }
                        ShaderType::Fragment => {
                            str.push(Token::Varying);
                            str.push(Token::MediumPrecision);
                        }
                    }
                }
            }

            Storage::ShaderOut => {
                if version == Version::Version300 {
                    if self.has_layout_location() {
                        str.push(Token::Layout);
                        str.push(Token::LeftParen);
                        str.push(Token::Location);
                        str.push(Token::Equal);
                        str.push(Token::IntLiteral(self.layout_location));
                        str.push(Token::RightParen);
                    }

                    str.push(Token::Out);
                    str.push(Token::MediumPrecision);
                } else {
                    debug_assert!(!self.has_layout_location());

                    // Upstream's real shape here is `if (vertex) str << VARYING <<
                    // MEDIUM_PRECISION; else DE_ASSERT(false);` - a single-statement
                    // `if`/`else` with **no tokens pushed at all** on the `else` arm
                    // (`DE_ASSERT` is a no-op outside a debug build, not a value-
                    // producing expression). An earlier draft of this port collapsed
                    // that into an unconditional push plus a side debug-assert, which
                    // is observably different in a *release* build: upstream emits
                    // nothing for a fragment `STORAGE_SHADER_OUT` declaration under
                    // GLSL ES 1.0, this port used to emit `varying mediump` regardless.
                    // Confirmed dead in practice either way, by the same invariant on
                    // both sides of the port: the only `STORAGE_SHADER_OUT` variable a
                    // `VERSION_100` fragment shader ever has is named "gl_FragColor"
                    // (`getFragColorName`/`get_frag_color_name`), and
                    // `ShaderGenerator::generate`'s/`shader_generator::generate`'s own
                    // "declare live globals" loop filters any `gl_`-prefixed name out
                    // of `createDeclarationStatementVars`/`create_declaration_
                    // statement_vars` *before* a `DeclarationStatement` - the only real
                    // caller of `tokenizeDeclaration`/`tokenize_declaration` - is ever
                    // built for it (confirmed by reading both `generate` functions'
                    // own "declare" filter side by side: `!deStringBeginsWith(name,
                    // "gl_")` / `!name.starts_with("gl_")`). Kept faithful to upstream's
                    // real branch shape anyway, not just documented, in case upstream's
                    // own open `\todo` ("Multiple outputs from fragment shader!") ever
                    // produces a non-`gl_`-prefixed fragment `ShaderOut` variable here -
                    // the `debug_assert!` below is this port's `DE_ASSERT(false)`, same
                    // "fires in a debug build, compiled out in release" semantics.
                    if shader_type == ShaderType::Vertex {
                        str.push(Token::Varying);
                        str.push(Token::MediumPrecision);
                    } else {
                        debug_assert!(
                            false,
                            "a fragment shader has no declarable ShaderOut variable under GLSL ES 1.0 \
                             (matches upstream's own unreachable DE_ASSERT(false) in rsgVariable.cpp)"
                        );
                    }
                }
            }

            Storage::Local => {}
        }

        self.type_.tokenize_short_type(str);

        debug_assert!(!self.name.is_empty());
        str.push(Token::identifier(self.name.clone()));
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::variable_type::Type;

    #[test]
    fn new_variable_has_no_layout_location() {
        let v = Variable::new(VariableType::new_basic(Type::Float, 1), Storage::Local, "x");
        assert_eq!(v.get_layout_location(), -1);
        assert!(!v.has_layout_location());
        assert_eq!(v.get_name(), "x");
        assert_eq!(v.get_storage(), Storage::Local);
    }

    #[test]
    fn set_layout_location_makes_has_layout_location_true() {
        let mut v = Variable::new(VariableType::new_basic(Type::Float, 4), Storage::ShaderOut, "o_color");
        assert!(!v.has_layout_location());
        v.set_layout_location(0);
        assert!(v.has_layout_location());
        assert_eq!(v.get_layout_location(), 0);
    }

    #[test]
    fn set_storage_overrides_the_constructor_value() {
        let mut v = Variable::new(VariableType::new_basic(Type::Int, 1), Storage::Local, "n");
        assert_eq!(v.get_storage(), Storage::Local);
        v.set_storage(Storage::Const);
        assert_eq!(v.get_storage(), Storage::Const);
    }

    #[test]
    fn tokenize_declaration_of_a_local_variable_is_just_the_type_and_name() {
        let v = Variable::new(VariableType::new_basic(Type::Float, 1), Storage::Local, "x");
        let mut stream = TokenStream::new();
        v.tokenize_declaration(Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens(), &[Token::Float, Token::Identifier("x".to_string())]);
    }

    #[test]
    fn tokenize_declaration_of_a_uniform_adds_the_uniform_keyword_and_precision_for_numeric_types() {
        let v = Variable::new(VariableType::new_basic(Type::Float, 1), Storage::Uniform, "u_x");
        let mut stream = TokenStream::new();
        v.tokenize_declaration(Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[
                Token::Uniform,
                Token::MediumPrecision,
                Token::Float,
                Token::Identifier("u_x".to_string())
            ]
        );

        // A bool uniform gets no precision qualifier (`isFloatOrVec() || isIntOrVec()` is
        // false for bool), confirmed by reading upstream's own condition directly.
        let bool_uniform = Variable::new(VariableType::new_basic(Type::Bool, 1), Storage::Uniform, "u_b");
        let mut bool_stream = TokenStream::new();
        bool_uniform.tokenize_declaration(Version::Version100, ShaderType::Vertex, &mut bool_stream);
        assert_eq!(
            bool_stream.tokens(),
            &[Token::Uniform, Token::Bool, Token::Identifier("u_b".to_string())]
        );
    }

    #[test]
    fn tokenize_declaration_of_a_shader_input_picks_attribute_or_varying_under_version_100() {
        let mut v_in = Variable::new(VariableType::new_basic(Type::Float, 1), Storage::ShaderIn, "a_x");
        let mut stream = TokenStream::new();
        v_in.tokenize_declaration(Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::Attribute, Token::Float, Token::Identifier("a_x".to_string())]
        );

        let mut f_stream = TokenStream::new();
        v_in.tokenize_declaration(Version::Version100, ShaderType::Fragment, &mut f_stream);
        assert_eq!(
            f_stream.tokens(),
            &[
                Token::Varying,
                Token::MediumPrecision,
                Token::Float,
                Token::Identifier("a_x".to_string())
            ]
        );

        // Under GLSL ES 3.0 it's always `in`, plus a layout qualifier if one was set,
        // plus mediump only in the fragment shader.
        v_in.set_layout_location(2);
        let mut es3_stream = TokenStream::new();
        v_in.tokenize_declaration(Version::Version300, ShaderType::Vertex, &mut es3_stream);
        assert_eq!(
            es3_stream.tokens(),
            &[
                Token::Layout,
                Token::LeftParen,
                Token::Location,
                Token::Equal,
                Token::IntLiteral(2),
                Token::RightParen,
                Token::In,
                Token::Float,
                Token::Identifier("a_x".to_string()),
            ]
        );
    }

    #[test]
    fn tokenize_declaration_of_a_shader_output_is_out_under_version_300_and_varying_under_version_100() {
        let v_out = Variable::new(VariableType::new_basic(Type::Float, 4), Storage::ShaderOut, "o_color");

        let mut es3_stream = TokenStream::new();
        v_out.tokenize_declaration(Version::Version300, ShaderType::Fragment, &mut es3_stream);
        assert_eq!(
            es3_stream.tokens(),
            &[
                Token::Out,
                Token::MediumPrecision,
                Token::Vec4,
                Token::Identifier("o_color".to_string())
            ]
        );

        let mut v100_stream = TokenStream::new();
        v_out.tokenize_declaration(Version::Version100, ShaderType::Vertex, &mut v100_stream);
        assert_eq!(
            v100_stream.tokens(),
            &[
                Token::Varying,
                Token::MediumPrecision,
                Token::Vec4,
                Token::Identifier("o_color".to_string())
            ]
        );
    }

    /// Regression test for the `STORAGE_SHADER_OUT`/GLSL-ES-1.0 divergence this module's
    /// own top doc comment documents fixing: upstream's real branch here is
    /// `if (vertex) str << VARYING << MEDIUM_PRECISION; else DE_ASSERT(false);`, i.e. a
    /// fragment `ShaderOut` declaration under `VERSION_100` is `DE_ASSERT`'s own "should
    /// never happen" - a hard abort in a debug build, a silent no-op (no tokens at all)
    /// in release. `debug_assert!` is the one Rust primitive with that exact two-build-
    /// profile shape, so this test only runs where it can actually observe it (a plain
    /// `cargo test` build has `debug_assertions` on; `--release` would not panic here at
    /// all, matching upstream's own release behaviour rather than being a gap in this
    /// test). Confirmed unreachable through the real generator (see the doc comment two
    /// paragraphs up) - this exercises the primitive in isolation, not a path any real
    /// shader generation run takes.
    #[test]
    #[cfg(debug_assertions)]
    #[should_panic(expected = "a fragment shader has no declarable ShaderOut variable under GLSL ES 1.0")]
    fn tokenize_declaration_of_a_fragment_shader_output_under_version_100_hits_upstreams_unreachable_assert() {
        let v_out = Variable::new(VariableType::new_basic(Type::Float, 4), Storage::ShaderOut, "o_color");
        let mut stream = TokenStream::new();
        v_out.tokenize_declaration(Version::Version100, ShaderType::Fragment, &mut stream);
    }
}
