// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgVariableType.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `VariableType` is the GLSL type system every variable, expression and function
// signature in the (not yet ported) random shader generator is typed with: `void`,
// scalar/vector `float`/`int`/`bool` (`numElements` 1/2/3/4, no separate vector
// variant - matching upstream, which overloads the same `TYPE_FLOAT`/`TYPE_INT`/
// `TYPE_BOOL` tags by element count instead of having `TYPE_VEC3` etc.), `sampler2D`/
// `samplerCube`, a named `struct` with an ordered member list, and a fixed-size array
// of some other `VariableType`. There is deliberately no matrix type here even though
// `Token` (ported alongside this) has `MAT2`/`MAT3`/`MAT4` entries - confirmed by
// reading upstream's own `VariableType::Type` enum directly, matrices are simply never
// one of its variants in the real source, so `tokenizeShortType` can never actually
// reach those three `Token` variants from a `VariableType`.
//
// `Member` drops upstream's null-`m_type` default constructor: that constructor exists
// only so a pre-C++11 `std::vector<Member>` can be resized before its elements are
// assigned (confirmed by grep - nothing in `framework/randomshaders/` ever calls
// `Member()` and then reads a member before overwriting it), which Rust's `Vec` has no
// equivalent need for, so every `Member` here always owns a real `VariableType`.
//
// `getScalarType`'s upstream `static const VariableType s_xTypes[]` function-local
// statics (returning a `const VariableType&` with static storage duration) become a
// plain by-value `scalar_type(Type) -> VariableType` - there is nothing to reproduce by
// keeping these as lazily-initialised statics in Rust; a `VariableType` is cheap to
// construct and this is called during shader-generation setup, never per-fragment.
// `element_type()` is by-value for the same reason (upstream hands back either one of
// those same statics or a reference to its own `m_elementType` field - the fallback to
// a non-recursive by-value clone unifies both without reproducing the lifetime).
//
// Precision support is genuinely absent upstream too, not narrowed by this port:
// `m_precision` is set to `PRECISION_NONE` by every one of upstream's four
// constructors and never written anywhere else in the whole directory (grepped) -
// `getElementType`'s own `DE_ASSERT(m_precision == PRECISION_NONE) // \todo [pyry]
// Precision` is upstream's own admission this was never finished. `precision()` is
// kept as a getter (every `VariableType` just always reports `Precision::None`) purely
// so `tokenize_short_type`'s precision-qualifier switch has something to match on,
// exactly mirroring upstream's own always-`PRECISION_NONE` reality.

use super::token::{Token, TokenStream};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Type {
    Void,
    Float,
    Int,
    Bool,
    Struct,
    Array,
    Sampler2D,
    SamplerCube,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Precision {
    None,
    Low,
    Medium,
    High,
}

/// A single named field of a `TYPE_STRUCT` `VariableType`. See this module's own doc
/// comment for why, unlike upstream's `Member`, the type is never absent.
#[derive(Debug, Clone)]
pub struct Member {
    type_: Box<VariableType>,
    name: String,
}

impl Member {
    pub fn new(type_: VariableType, name: impl Into<String>) -> Member {
        Member {
            type_: Box::new(type_),
            name: name.into(),
        }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn get_name(&self) -> &str {
        &self.name
    }
}

impl PartialEq for Member {
    fn eq(&self, other: &Member) -> bool {
        self.name == other.name && *self.type_ == *other.type_
    }
}

#[derive(Debug, Clone)]
pub struct VariableType {
    base_type: Type,
    precision: Precision,
    type_name: String,
    num_elements: i32,
    element_type: Option<Box<VariableType>>,
    members: Vec<Member>,
}

impl Default for VariableType {
    /// Port of the no-argument `VariableType()` constructor - `TYPE_VOID`.
    fn default() -> VariableType {
        VariableType {
            base_type: Type::Void,
            precision: Precision::None,
            type_name: String::new(),
            num_elements: 0,
            element_type: None,
            members: Vec::new(),
        }
    }
}

impl VariableType {
    /// Port of `VariableType(Type baseType, int numElements = 0)` - a scalar or
    /// vector of `baseType` (`float`/`int`/`bool`/the two sampler types), or `void`.
    pub fn new_basic(base_type: Type, num_elements: i32) -> VariableType {
        debug_assert!(base_type != Type::Array && base_type != Type::Struct);
        VariableType {
            base_type,
            num_elements,
            ..VariableType::default()
        }
    }

    /// Port of `VariableType(Type baseType, const VariableType &elementType, int numElements)`.
    pub fn new_array(element_type: VariableType, num_elements: i32) -> VariableType {
        VariableType {
            base_type: Type::Array,
            num_elements,
            element_type: Some(Box::new(element_type)),
            ..VariableType::default()
        }
    }

    /// Port of `VariableType(Type baseType, const char *typeName)` - a named struct
    /// with no members yet; a caller fills `members_mut()` afterwards.
    pub fn new_struct(type_name: impl Into<String>) -> VariableType {
        VariableType {
            base_type: Type::Struct,
            type_name: type_name.into(),
            ..VariableType::default()
        }
    }

    pub fn base_type(&self) -> Type {
        self.base_type
    }

    pub fn precision(&self) -> Precision {
        self.precision
    }

    pub fn type_name(&self) -> &str {
        &self.type_name
    }

    pub fn num_elements(&self) -> i32 {
        self.num_elements
    }

    pub fn members(&self) -> &[Member] {
        &self.members
    }

    pub fn members_mut(&mut self) -> &mut Vec<Member> {
        &mut self.members
    }

    pub fn is_struct(&self) -> bool {
        self.base_type == Type::Struct
    }

    pub fn is_array(&self) -> bool {
        self.base_type == Type::Array
    }

    pub fn is_float_or_vec(&self) -> bool {
        self.base_type == Type::Float
    }

    pub fn is_int_or_vec(&self) -> bool {
        self.base_type == Type::Int
    }

    pub fn is_bool_or_vec(&self) -> bool {
        self.base_type == Type::Bool
    }

    pub fn is_sampler(&self) -> bool {
        self.base_type == Type::Sampler2D || self.base_type == Type::SamplerCube
    }

    pub fn is_void(&self) -> bool {
        self.base_type == Type::Void
    }

    /// Port of `VariableType::getScalarType` - the canonical single-component
    /// `VariableType` for a scalar/sampler base type.
    pub fn scalar_type(base_type: Type) -> VariableType {
        match base_type {
            Type::Float => VariableType::new_basic(Type::Float, 1),
            Type::Int => VariableType::new_basic(Type::Int, 1),
            Type::Bool => VariableType::new_basic(Type::Bool, 1),
            Type::Sampler2D => VariableType::new_basic(Type::Sampler2D, 1),
            Type::SamplerCube => VariableType::new_basic(Type::SamplerCube, 1),
            _ => panic!("VariableType::scalar_type(): unsupported type"),
        }
    }

    /// Port of `VariableType::getElementType` - for a vector/sampler, its scalar
    /// component type; for an array, the type of one element.
    pub fn element_type(&self) -> VariableType {
        debug_assert!(self.precision == Precision::None); // \todo [pyry] Precision
        match self.base_type {
            Type::Float | Type::Int | Type::Bool | Type::Sampler2D | Type::SamplerCube => {
                VariableType::scalar_type(self.base_type)
            }
            Type::Array => (**self
                .element_type
                .as_ref()
                .expect("array VariableType always has an element type"))
            .clone(),
            _ => panic!("VariableType::element_type(): unsupported type"),
        }
    }

    /// Port of `VariableType::getScalarSize`.
    pub fn scalar_size(&self) -> i32 {
        match self.base_type {
            Type::Void | Type::Float | Type::Int | Type::Bool | Type::Sampler2D | Type::SamplerCube => {
                self.num_elements
            }
            Type::Struct => self.members.iter().map(|m| m.get_type().scalar_size()).sum(),
            Type::Array => {
                self.element_type
                    .as_ref()
                    .expect("array VariableType always has an element type")
                    .scalar_size()
                    * self.num_elements
            }
        }
    }

    /// Port of `VariableType::getMemberScalarOffset`.
    pub fn member_scalar_offset(&self, member_ndx: i32) -> i32 {
        debug_assert!(self.is_struct());
        self.members[..member_ndx as usize]
            .iter()
            .map(|m| m.get_type().scalar_size())
            .sum()
    }

    /// Port of `VariableType::getElementScalarOffset`.
    pub fn element_scalar_offset(&self, element_ndx: i32) -> i32 {
        debug_assert!(self.is_array());
        element_ndx * self.element_type().scalar_size()
    }

    /// Port of `VariableType::tokenizeShortType`.
    pub fn tokenize_short_type(&self, stream: &mut TokenStream) {
        match self.precision {
            Precision::Low => {
                stream.push(Token::LowPrecision);
            }
            Precision::Medium => {
                stream.push(Token::MediumPrecision);
            }
            Precision::High => {
                stream.push(Token::HighPrecision);
            }
            Precision::None => {}
        }

        match self.base_type {
            Type::Void => {
                stream.push(Token::Void);
            }
            Type::Float => {
                stream.push(match self.num_elements {
                    1 => Token::Float,
                    2 => Token::Vec2,
                    3 => Token::Vec3,
                    4 => Token::Vec4,
                    other => panic!("VariableType::tokenize_short_type(): bad float vector size {other}"),
                });
            }
            Type::Int => {
                stream.push(match self.num_elements {
                    1 => Token::Int,
                    2 => Token::IVec2,
                    3 => Token::IVec3,
                    4 => Token::IVec4,
                    other => panic!("VariableType::tokenize_short_type(): bad int vector size {other}"),
                });
            }
            Type::Bool => {
                stream.push(match self.num_elements {
                    1 => Token::Bool,
                    2 => Token::BVec2,
                    3 => Token::BVec3,
                    4 => Token::BVec4,
                    other => panic!("VariableType::tokenize_short_type(): bad bool vector size {other}"),
                });
            }
            Type::Sampler2D => {
                stream.push(Token::Sampler2D);
            }
            Type::SamplerCube => {
                stream.push(Token::SamplerCube);
            }
            Type::Struct => {
                debug_assert!(!self.type_name.is_empty());
                stream.push(Token::identifier(self.type_name.clone()));
            }
            Type::Array => {
                let element_type = self
                    .element_type
                    .as_ref()
                    .expect("array VariableType always has an element type");
                element_type.tokenize_short_type(stream);
                stream
                    .push(Token::LeftBracket)
                    .push(Token::IntLiteral(self.num_elements))
                    .push(Token::RightBracket);
            }
        }
    }
}

impl PartialEq for VariableType {
    /// Port of `VariableType::operator!=`/`operator==`. Note `m_typeName` is
    /// deliberately **not** compared, matching upstream's own omission - two structs
    /// with identical member lists compare equal regardless of their declared names.
    fn eq(&self, other: &VariableType) -> bool {
        self.base_type == other.base_type
            && self.precision == other.precision
            && self.num_elements == other.num_elements
            && self.element_type == other.element_type
            && self.members == other.members
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn scalar_size_of_vector_is_its_element_count() {
        assert_eq!(VariableType::new_basic(Type::Float, 3).scalar_size(), 3);
        assert_eq!(VariableType::new_basic(Type::Int, 1).scalar_size(), 1);
    }

    #[test]
    fn scalar_size_of_array_multiplies_element_type() {
        let array_of_vec3 = VariableType::new_array(VariableType::new_basic(Type::Float, 3), 4);
        assert_eq!(array_of_vec3.scalar_size(), 12);
    }

    #[test]
    fn scalar_size_of_struct_sums_members() {
        let mut s = VariableType::new_struct("Foo");
        s.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 3), "a")); // 3
        s.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Int, 1), "b")); // 1
        s.members_mut().push(Member::new(
            VariableType::new_array(VariableType::new_basic(Type::Bool, 2), 2),
            "c",
        )); // 2*2=4
        assert_eq!(s.scalar_size(), 3 + 1 + 4);
    }

    #[test]
    fn member_scalar_offset_is_the_running_sum_of_preceding_members() {
        let mut s = VariableType::new_struct("Foo");
        s.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 3), "a")); // offset 0, size 3
        s.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Int, 1), "b")); // offset 3, size 1
        s.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 4), "c")); // offset 4

        assert_eq!(s.member_scalar_offset(0), 0);
        assert_eq!(s.member_scalar_offset(1), 3);
        assert_eq!(s.member_scalar_offset(2), 4);
    }

    #[test]
    fn element_scalar_offset_is_index_times_element_scalar_size() {
        let array_of_vec4 = VariableType::new_array(VariableType::new_basic(Type::Float, 4), 5);
        assert_eq!(array_of_vec4.element_scalar_offset(0), 0);
        assert_eq!(array_of_vec4.element_scalar_offset(1), 4);
        assert_eq!(array_of_vec4.element_scalar_offset(3), 12);
    }

    #[test]
    fn element_type_of_vector_is_its_scalar_component() {
        let vec3 = VariableType::new_basic(Type::Float, 3);
        assert_eq!(vec3.element_type(), VariableType::new_basic(Type::Float, 1));

        let ivec2 = VariableType::new_basic(Type::Int, 2);
        assert_eq!(ivec2.element_type(), VariableType::new_basic(Type::Int, 1));
    }

    #[test]
    fn element_type_of_array_is_the_stored_element_type() {
        let array_of_vec3 = VariableType::new_array(VariableType::new_basic(Type::Float, 3), 4);
        assert_eq!(array_of_vec3.element_type(), VariableType::new_basic(Type::Float, 3));
    }

    #[test]
    #[should_panic(expected = "unsupported type")]
    fn element_type_of_void_panics() {
        let _ = VariableType::default().element_type();
    }

    #[test]
    #[should_panic(expected = "unsupported type")]
    fn scalar_type_of_struct_panics() {
        let _ = VariableType::scalar_type(Type::Struct);
    }

    #[test]
    fn equality_ignores_struct_type_name_matching_upstream() {
        let mut a = VariableType::new_struct("Foo");
        a.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 1), "x"));

        let mut b = VariableType::new_struct("Bar");
        b.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 1), "x"));

        assert_eq!(a, b, "upstream's own operator== never compares m_typeName");
    }

    #[test]
    fn equality_does_compare_members() {
        let mut a = VariableType::new_struct("Foo");
        a.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 1), "x"));

        let mut b = VariableType::new_struct("Foo");
        b.members_mut()
            .push(Member::new(VariableType::new_basic(Type::Int, 1), "x"));

        assert_ne!(a, b);
    }

    #[test]
    fn tokenize_short_type_of_vectors_and_scalars() {
        let mut stream = TokenStream::new();
        VariableType::new_basic(Type::Float, 1).tokenize_short_type(&mut stream);
        VariableType::new_basic(Type::Float, 3).tokenize_short_type(&mut stream);
        VariableType::new_basic(Type::Int, 4).tokenize_short_type(&mut stream);
        VariableType::new_basic(Type::Bool, 2).tokenize_short_type(&mut stream);
        VariableType::new_basic(Type::Sampler2D, 1).tokenize_short_type(&mut stream);
        VariableType::new_basic(Type::SamplerCube, 1).tokenize_short_type(&mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::Float,
                Token::Vec3,
                Token::IVec4,
                Token::BVec2,
                Token::Sampler2D,
                Token::SamplerCube,
            ]
        );
    }

    #[test]
    fn tokenize_short_type_of_struct_emits_its_name_as_an_identifier() {
        let mut stream = TokenStream::new();
        VariableType::new_struct("Light").tokenize_short_type(&mut stream);
        assert_eq!(stream.tokens(), &[Token::identifier("Light")]);
    }

    #[test]
    fn tokenize_short_type_of_array_emits_element_type_then_bracketed_size() {
        let mut stream = TokenStream::new();
        let array_of_vec4 = VariableType::new_array(VariableType::new_basic(Type::Float, 4), 3);
        array_of_vec4.tokenize_short_type(&mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::Vec4,
                Token::LeftBracket,
                Token::IntLiteral(3),
                Token::RightBracket
            ]
        );
    }

    #[test]
    fn tokenize_short_type_of_array_of_struct() {
        let mut stream = TokenStream::new();
        let array_of_struct = VariableType::new_array(VariableType::new_struct("Light"), 2);
        array_of_struct.tokenize_short_type(&mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::identifier("Light"),
                Token::LeftBracket,
                Token::IntLiteral(2),
                Token::RightBracket,
            ]
        );
    }

    #[test]
    fn precision_is_always_none_matching_upstreams_own_unfinished_state() {
        assert_eq!(VariableType::new_basic(Type::Float, 1).precision(), Precision::None);
        assert_eq!(VariableType::new_struct("Foo").precision(), Precision::None);
    }

    #[test]
    fn predicate_helpers() {
        assert!(VariableType::new_basic(Type::Float, 3).is_float_or_vec());
        assert!(VariableType::new_basic(Type::Int, 1).is_int_or_vec());
        assert!(VariableType::new_basic(Type::Bool, 4).is_bool_or_vec());
        assert!(VariableType::new_basic(Type::Sampler2D, 1).is_sampler());
        assert!(VariableType::new_basic(Type::SamplerCube, 1).is_sampler());
        assert!(VariableType::new_struct("Foo").is_struct());
        assert!(VariableType::new_array(VariableType::new_basic(Type::Float, 1), 2).is_array());
        assert!(VariableType::default().is_void());
    }
}
