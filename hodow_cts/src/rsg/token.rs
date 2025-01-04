// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgToken.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `Token` is the lexical-token shape the random shader generator's pretty-printer
// (`rsg::pretty_printer`, ported since this file was first written - see that module's
// own doc comment) assembles GLSL source out of - every keyword/punctuation mark is its
// own unit variant, and the four value-carrying upstream `Token` constructors
// (`IDENTIFIER`/`FLOAT_LITERAL`/`INT_LITERAL`/`BOOL_LITERAL`) become variants holding
// their value directly, which is what upstream's tagged union (`Token::m_arg`, a raw
// `union` discriminated by `m_type`) already was in spirit. `TokenStream` is the
// `vector<Token>` upstream grows in fixed `ALLOC_SIZE` chunks and indexes by position;
// this port is just a thin `Vec<Token>` wrapper, since there is no manual-allocation
// hazard here worth reproducing.
//
// **Not ported: `Token::operator==`/`operator!=`.** Upstream's own `operator!=`
// (`rsgToken.cpp`) returns `false` whenever the two tokens' types differ and only
// reaches `true` at the end when every per-type value check it walks through did
// *not* fire - i.e. every early-return branch and the final return are inverted from
// what an equality comparison needs (the body reads like `operator==`'s logic with
// every branch's sense flipped, a copy/paste slip). Grepped the whole
// `framework/randomshaders/` directory for any other use of `Token::operator`/a bare
// `tok ==`/`== tok` comparison beyond the two definitions themselves - none - so this
// is dead, already-buggy upstream code with no observable behaviour anywhere to match.
// Porting it faithfully would only plant an inverted-equality landmine for a future
// caller; a derived `PartialEq` (the semantics the name actually implies) stands in
// instead, for whenever a future consumer needs to compare two tokens.

#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    Identifier(String),
    Struct,
    Invariant,
    Precision,
    Void,
    Break,
    Continue,
    Do,
    While,
    Else,
    For,
    If,
    Discard,
    Return,
    IncOp,
    DecOp,
    LeftParen,
    RightParen,
    LeftBracket,
    RightBracket,
    LeftBrace,
    RightBrace,
    Dot,
    Comma,
    Colon,
    Semicolon,
    Minus,
    Plus,
    Mul,
    Div,
    Mod,
    Question,
    Bool,
    BVec2,
    BVec3,
    BVec4,
    Int,
    IVec2,
    IVec3,
    IVec4,
    Float,
    Vec2,
    Vec3,
    Vec4,
    Mat2,
    Mat3,
    Mat4,
    Sampler2D,
    SamplerCube,
    FloatLiteral(f32),
    IntLiteral(i32),
    BoolLiteral(bool),
    Equal,
    MulAssign,
    DivAssign,
    AddAssign,
    SubAssign,
    CmpLt,
    CmpGt,
    CmpLe,
    CmpGe,
    CmpEq,
    CmpNe,
    LogicalAnd,
    LogicalOr,
    LogicalNot,
    LogicalXor,
    Attribute,
    Uniform,
    Varying,
    Const,
    Flat,
    HighPrecision,
    MediumPrecision,
    LowPrecision,
    In,
    Out,
    Inout,
    Layout,
    Location,

    // Formatting only
    IndentInc,
    IndentDec,
    Newline,
}

impl Token {
    pub fn identifier(name: impl Into<String>) -> Token {
        Token::Identifier(name.into())
    }
}

/// Port of `rsg::TokenStream` - a flat, ordered sequence of `Token`s built up with
/// `push` (upstream's `operator<<`; Rust has no equivalent operator worth overloading
/// here, so this is a plain method a caller chains with `;`-separated statements).
#[derive(Debug, Clone, Default)]
pub struct TokenStream {
    tokens: Vec<Token>,
}

impl TokenStream {
    pub fn new() -> TokenStream {
        TokenStream::default()
    }

    pub fn len(&self) -> usize {
        self.tokens.len()
    }

    pub fn is_empty(&self) -> bool {
        self.tokens.is_empty()
    }

    pub fn push(&mut self, token: Token) -> &mut TokenStream {
        self.tokens.push(token);
        self
    }

    pub fn tokens(&self) -> &[Token] {
        &self.tokens
    }
}

impl std::ops::Index<usize> for TokenStream {
    type Output = Token;

    fn index(&self, index: usize) -> &Token {
        &self.tokens[index]
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn push_appends_in_order_and_chains() {
        let mut stream = TokenStream::new();
        stream
            .push(Token::Float)
            .push(Token::identifier("x"))
            .push(Token::Semicolon);

        assert_eq!(stream.len(), 3);
        assert_eq!(stream[0], Token::Float);
        assert_eq!(stream[1], Token::Identifier("x".to_string()));
        assert_eq!(stream[2], Token::Semicolon);
    }

    #[test]
    fn empty_stream_reports_empty() {
        let stream = TokenStream::new();
        assert!(stream.is_empty());
        assert_eq!(stream.len(), 0);
        assert_eq!(stream.tokens(), &[] as &[Token]);
    }

    #[test]
    fn value_variants_carry_their_value() {
        assert_eq!(Token::FloatLiteral(1.5), Token::FloatLiteral(1.5));
        assert_ne!(Token::FloatLiteral(1.5), Token::FloatLiteral(2.0));
        assert_eq!(Token::IntLiteral(-3), Token::IntLiteral(-3));
        assert_eq!(Token::BoolLiteral(true), Token::BoolLiteral(true));
        assert_ne!(Token::BoolLiteral(true), Token::BoolLiteral(false));
        assert_ne!(Token::Identifier("a".into()), Token::Identifier("b".into()));
    }
}
