// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgPrettyPrinter.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `PrettyPrinter` turns a built `rsg::token::TokenStream` into actual GLSL source
// text - the last leaf between a generated AST and a compilable shader string, now
// that `rsg::token`/`rsg::expression`/`rsg::statement` all exist. Upstream's own
// shape: a `std::string m_line` accumulator plus an `int m_indentDepth` counter, fed
// one token at a time (`processToken`) and flushed to the real output only on
// `Token::NEWLINE` - ported 1:1 as `process_token`/`append` below.
//
// **One deliberate, non-semantic shape change**: upstream's constructor takes an
// external `std::ostringstream&` to write into (`PrettyPrinter(std::ostringstream&)`);
// this port owns its output `String` directly (`output`/`finish`/`source`)
// rather than threading a borrowed sink through, since nothing here needs the
// caller's own buffer to be the same object - the exact same idiomatic-Rust-for-
// plumbing-only latitude this project already takes for `Drop`/`Result` elsewhere.
// Every actual formatting decision below is unchanged from upstream.
//
// `simple_token_str` is `s_tokenStr` (the fixed per-`Token` punctuation/keyword
// table) reproduced as a `match`, keyed by variant rather than by array index -
// `Token`'s own ordering was never guaranteed to track the C++ enum's, so indexing
// into a parallel Rust array the way upstream indexes `s_tokenStr[token]` would be
// one silent reordering away from printing the wrong punctuation for a real token.
// Deliberately left unreachable for the seven value-carrying/formatting-only
// variants (`Identifier`/`FloatLiteral`/`IntLiteral`/`BoolLiteral`/`IndentInc`/
// `IndentDec`/`Newline`) - `process_token`'s own `match` handles every one of those
// in its own arm before ever reaching the `_ =>` branch that calls this function, the
// same shape upstream's own `switch` has (those seven are `nullptr` entries in
// `s_tokenStr`, never passed through `getSimpleTokenStr`).

use super::token::{Token, TokenStream};

/// `rsg::isIdentifierChar` - ASCII letter, digit or underscore. Used on both sides of
/// a token boundary to decide whether gluing two pieces of text together without a
/// space would accidentally merge two separate identifiers/keywords into one token
/// when the GLSL source is later lexed back (`float x` must not become `floatx`).
fn is_identifier_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// `s_tokenStr` - see this module's own top doc comment for why this is a `match` on
/// the token itself rather than an index into a parallel array.
fn simple_token_str(token: &Token) -> &'static str {
    match token {
        Token::Struct => "struct",
        Token::Invariant => "invariant",
        Token::Precision => "precision",
        Token::Void => "void",
        Token::Break => "break",
        Token::Continue => "continue",
        Token::Do => "do ",
        Token::While => "while ",
        Token::Else => "else ",
        Token::For => "for ",
        Token::If => "if ",
        Token::Discard => "discard",
        Token::Return => "return ",
        Token::IncOp => "++",
        Token::DecOp => "--",
        Token::LeftParen => "(",
        Token::RightParen => ")",
        Token::LeftBracket => "[",
        Token::RightBracket => "]",
        Token::LeftBrace => "{",
        Token::RightBrace => "}",
        Token::Dot => ".",
        Token::Comma => ", ",
        Token::Colon => " : ",
        Token::Semicolon => ";",
        Token::Minus => " - ",
        Token::Plus => " + ",
        Token::Mul => " * ",
        Token::Div => " / ",
        Token::Mod => " % ",
        Token::Question => " ? ",
        Token::Bool => "bool",
        Token::BVec2 => "bvec2",
        Token::BVec3 => "bvec3",
        Token::BVec4 => "bvec4",
        Token::Int => "int",
        Token::IVec2 => "ivec2",
        Token::IVec3 => "ivec3",
        Token::IVec4 => "ivec4",
        Token::Float => "float",
        Token::Vec2 => "vec2",
        Token::Vec3 => "vec3",
        Token::Vec4 => "vec4",
        Token::Mat2 => "mat2",
        Token::Mat3 => "mat3",
        Token::Mat4 => "mat4",
        Token::Sampler2D => "sampler2D",
        Token::SamplerCube => "samplerCube",
        Token::Equal => " = ",
        Token::MulAssign => " *= ",
        Token::DivAssign => " /= ",
        Token::AddAssign => " += ",
        Token::SubAssign => " -= ",
        Token::CmpLt => " < ",
        Token::CmpGt => " > ",
        Token::CmpLe => " <= ",
        Token::CmpGe => " >= ",
        Token::CmpEq => " == ",
        Token::CmpNe => " != ",
        Token::LogicalAnd => " && ",
        Token::LogicalOr => " || ",
        Token::LogicalNot => "!",
        Token::LogicalXor => " ^^ ",
        Token::Attribute => "attribute",
        Token::Uniform => "uniform",
        Token::Varying => "varying",
        Token::Const => "const",
        Token::Flat => "flat",
        Token::HighPrecision => "highp",
        Token::MediumPrecision => "mediump",
        Token::LowPrecision => "lowp",
        Token::In => "in",
        Token::Out => "out",
        Token::Inout => "inout",
        Token::Layout => "layout",
        Token::Location => "location",
        Token::Identifier(_)
        | Token::FloatLiteral(_)
        | Token::IntLiteral(_)
        | Token::BoolLiteral(_)
        | Token::IndentInc
        | Token::IndentDec
        | Token::Newline => {
            unreachable!(
                "rsg::simple_token_str: value-carrying/formatting-only token - handled by its own `process_token` match arm before this function is ever called"
            )
        }
    }
}

/// `de::toString(float)` plus `PrettyPrinter::processToken`'s own `FLOAT_LITERAL`
/// fallback (`if (f.find('.') == npos) f += ".0"`), combined - nothing else in this
/// file ever needs the un-suffixed form. Reproduces C++'s default `ostream`
/// formatting of a floating-point value: `%g`-style, 6 significant digits, switching
/// to scientific notation outside `[1e-4, 1e6)` the same way `printf("%g", ...)`
/// does, with a minimum 2-digit zero-padded exponent (the same convention `%e`
/// uses). The rounded 6-digit mantissa is obtained once, via Rust's own
/// (correctly-rounded) `{:.5e}` formatting, and both branches below rebuild their
/// output directly from those digits rather than re-formatting the original value at
/// a different precision - so the fixed and scientific branches can never disagree
/// with each other about where the rounding landed on a boundary value.
///
/// **Faithfully reproduces a genuine upstream oddity, not fixed here**: the ".0"
/// fallback is a bare `find('.') == npos` check with no awareness of scientific
/// notation, so a magnitude extreme enough to hit the scientific branch (whose
/// trimmed-to-nothing fraction leaves no '.' either, e.g. `"1e+06"`) gets ".0"
/// appended to the *exponent* instead - `"1e+06.0"`, not valid GLSL. Ported code
/// keeps upstream's own behaviour, bug and all (see this crate's `QUIRKS.md`
/// discipline); `rsg`'s own generated value ranges are never extreme enough in
/// practice to reach this branch, which is presumably why it was never caught
/// upstream either.
fn format_glsl_float(value: f32) -> String {
    let v = value as f64;

    if v == 0.0 {
        return if v.is_sign_negative() {
            "-0.0".to_string()
        } else {
            "0.0".to_string()
        };
    }

    // 6 significant digits (`P = 6`, `ostream`'s default precision): 1 digit before
    // the point plus `P - 1 = 5` after, already correctly rounded.
    let sci = format!("{v:.5e}");
    let (mantissa_part, exp_part) = sci
        .split_once('e')
        .expect("Rust's `{:e}` formatting always contains one 'e'");
    let exponent: i32 = exp_part
        .parse()
        .expect("Rust's `{:e}` exponent is always a plain base-10 integer");
    let negative = mantissa_part.starts_with('-');
    let digits: Vec<char> = mantissa_part.chars().filter(|c| c.is_ascii_digit()).collect();
    debug_assert_eq!(
        digits.len(),
        6,
        "format_glsl_float: `{{:.5e}}` always yields exactly 1 + 5 significant digits"
    );

    let body = if !(-4..6).contains(&exponent) {
        // %g's scientific branch.
        let frac: String = digits[1..].iter().collect();
        let frac_trimmed = frac.trim_end_matches('0');
        let mantissa_str = if frac_trimmed.is_empty() {
            digits[0].to_string()
        } else {
            format!("{}.{}", digits[0], frac_trimmed)
        };
        let exp_sign = if exponent < 0 { '-' } else { '+' };
        format!("{mantissa_str}e{exp_sign}{:02}", exponent.abs())
    } else {
        // %g's fixed branch - rebuild the fixed-point digit string directly from
        // the already-rounded `digits` (see this function's own doc comment for
        // why), rather than re-formatting `v` at a different precision.
        let fixed_digits: String = if exponent >= 0 {
            let int_len = (exponent + 1) as usize;
            let int_part: String = digits[..int_len].iter().collect();
            let frac_part: String = digits[int_len..].iter().collect();
            format!("{int_part}.{frac_part}")
        } else {
            let leading_zeros = "0".repeat((-exponent - 1) as usize);
            let all_digits: String = digits.iter().collect();
            format!("0.{leading_zeros}{all_digits}")
        };
        let trimmed = fixed_digits.trim_end_matches('0');
        trimmed.trim_end_matches('.').to_string()
    };

    let mut result = if negative { format!("-{body}") } else { body };

    if !result.contains('.') {
        result.push_str(".0");
    }

    result
}

/// `rsg::PrettyPrinter` - see this module's own top doc comment for the one
/// non-semantic shape change (owns its output `String` instead of borrowing an
/// `ostringstream&`).
#[derive(Default)]
pub struct PrettyPrinter {
    line: String,
    output: String,
    indent_depth: i32,
}

impl PrettyPrinter {
    /// `PrettyPrinter::PrettyPrinter`
    pub fn new() -> Self {
        Self::default()
    }

    /// `PrettyPrinter::append`
    pub fn append(&mut self, tokens: &TokenStream) {
        for token in tokens.tokens() {
            self.process_token(token);
        }
    }

    /// The finished source text so far (everything flushed by a `Token::Newline`;
    /// an unterminated trailing line, same as upstream, is never flushed).
    pub fn source(&self) -> &str {
        &self.output
    }

    /// Consumes `self` and returns the finished source text - see this module's own
    /// top doc comment for why a caller wanting a literal prefix before it (upstream's
    /// own `"#version 300 es\n"`) prepends that to this method's own return value
    /// instead of threading a mutable buffer reference through the whole struct.
    pub fn finish(self) -> String {
        self.output
    }

    /// `PrettyPrinter::processToken`
    fn process_token(&mut self, token: &Token) {
        let prev_is_identifier_char = self.line.chars().next_back().is_some_and(is_identifier_char);

        match token {
            Token::Identifier(name) => {
                if prev_is_identifier_char {
                    self.line.push(' ');
                }
                self.line.push_str(name);
            }

            Token::FloatLiteral(value) => {
                self.line.push_str(&format_glsl_float(*value));
            }

            Token::IntLiteral(value) => {
                self.line.push_str(&value.to_string());
            }

            Token::BoolLiteral(value) => {
                self.line.push_str(if *value { "true" } else { "false" });
            }

            Token::IndentInc => {
                self.indent_depth += 1;
            }

            Token::IndentDec => {
                self.indent_depth -= 1;
            }

            Token::Newline => {
                // Indent.
                for _ in 0..self.indent_depth {
                    self.output.push('\t');
                }
                // Flush the line to the source.
                self.output.push_str(&self.line);
                self.output.push('\n');
                self.line.clear();
            }

            _ => {
                let token_str = simple_token_str(token);
                if prev_is_identifier_char && token_str.chars().next().is_some_and(is_identifier_char) {
                    self.line.push(' ');
                }
                self.line.push_str(token_str);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn format_glsl_float_matches_ostream_percent_g_for_ordinary_values() {
        assert_eq!(format_glsl_float(1.5), "1.5");
        assert_eq!(format_glsl_float(2.0), "2.0"); // Bare integer gets the ".0" fallback.
        assert_eq!(format_glsl_float(0.0), "0.0");
        assert_eq!(format_glsl_float(0.001), "0.001"); // The CMP_EQ epsilon literal.
        assert_eq!(format_glsl_float(-3.25), "-3.25");
        assert_eq!(format_glsl_float(123456.0), "123456.0");
    }

    #[test]
    fn format_glsl_float_switches_to_scientific_outside_the_percent_g_range() {
        // exponent = 6 (>= P = 6): scientific, trailing mantissa zeros trimmed.
        assert_eq!(format_glsl_float(1_500_000.0), "1.5e+06");
        // exponent = -5 (< -4): scientific, 2-digit zero-padded exponent.
        assert_eq!(format_glsl_float(0.0000125), "1.25e-05");
        // A whole-number scientific result still hits the ".0"-on-the-exponent
        // upstream oddity this function's own doc comment documents - faithfully
        // reproduced, not "fixed" into `"1.0e+06"`.
        assert_eq!(format_glsl_float(1_000_000.0), "1e+06.0");
    }

    #[test]
    fn append_joins_tokens_with_upstream_adjacency_spacing() {
        let mut tokens = TokenStream::new();
        tokens
            .push(Token::Float)
            .push(Token::identifier("x"))
            .push(Token::Equal)
            .push(Token::FloatLiteral(1.5))
            .push(Token::Semicolon)
            .push(Token::Newline);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.source(), "float x = 1.5;\n");
    }

    #[test]
    fn return_keyword_carries_its_own_trailing_space_without_doubling_it() {
        // `Token::Return`'s own table entry is `"return "` (with the trailing
        // space baked in, same as upstream's `s_tokenStr`) specifically so a
        // following identifier is never glued onto it - confirm the adjacency
        // check does *not* add a second space on top of that baked-in one.
        let mut tokens = TokenStream::new();
        tokens
            .push(Token::Return)
            .push(Token::identifier("result"))
            .push(Token::Semicolon)
            .push(Token::Newline);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.source(), "return result;\n");
    }

    #[test]
    fn indent_inc_and_dec_add_and_remove_a_leading_tab_per_newline() {
        let mut tokens = TokenStream::new();
        tokens
            .push(Token::IndentInc)
            .push(Token::identifier("foo"))
            .push(Token::Semicolon)
            .push(Token::Newline)
            .push(Token::IndentDec)
            .push(Token::identifier("bar"))
            .push(Token::Semicolon)
            .push(Token::Newline);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.finish(), "\tfoo;\nbar;\n");
    }

    #[test]
    fn adjacent_identifier_like_tokens_get_a_separating_space() {
        // Two back-to-back `Identifier`s (e.g. two generated names that happen to
        // be emitted without an operator between them in a test harness driving
        // this directly) must not merge into one token when re-lexed.
        let mut tokens = TokenStream::new();
        tokens
            .push(Token::identifier("foo"))
            .push(Token::identifier("bar"))
            .push(Token::Newline);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.source(), "foo bar\n");
    }

    #[test]
    fn literal_tokens_never_check_adjacency_matching_upstream() {
        // `FLOAT_LITERAL`/`INT_LITERAL`/`BOOL_LITERAL` are glued on unconditionally
        // in upstream's own `switch` - only `IDENTIFIER` and the default branch
        // consult `prevIsIdentifierChar`. Not a realistic shader (no operator
        // between the literals), but exercises the real code path: a `Dot` (plain
        // ".") immediately before an `IntLiteral` must not gain a space either.
        let mut tokens = TokenStream::new();
        tokens.push(Token::Dot).push(Token::IntLiteral(5)).push(Token::Newline);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.source(), ".5\n");
    }

    #[test]
    fn unterminated_trailing_line_is_never_flushed() {
        // Matches upstream: `processToken` only ever writes to `m_str` on
        // `Token::NEWLINE`, so a `TokenStream` with no trailing newline leaves its
        // last line sitting in `m_line`, never reaching the real output.
        let mut tokens = TokenStream::new();
        tokens
            .push(Token::Float)
            .push(Token::identifier("x"))
            .push(Token::Semicolon);

        let mut printer = PrettyPrinter::new();
        printer.append(&tokens);

        assert_eq!(printer.source(), "");
    }
}
