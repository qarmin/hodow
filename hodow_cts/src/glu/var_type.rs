// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluVarType.hpp / .cpp          (glu::VarType, glu::StructType, glu::declare)
//   framework/opengl/gluVarTypeUtil.hpp / .cpp      (glu::VarTypeComponent, glu::SubTypeAccess)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's three-way tagged union
// becomes an `enum`, and the `const StructType*` a struct type is referred to by becomes
// an `Arc<StructType>` - a raw pointer there is upstream's way of keeping one declaration
// shared between the uniforms that use it, and reference counting says the same thing
// without the manual `delete` loop every owner of one has. `Layout`, the image
// format/memory qualifiers and the desktop-only storage classes are not ported; no ES
// case here declares one yet.

use std::fmt;
use std::fmt::Write as _;
use std::sync::Arc;

use crate::glu::shader_util::{DataType, Precision};

/// `VarType::UNSIZED_ARRAY`
pub const UNSIZED_ARRAY: i32 = -1;

/// `glu::VarType`
#[derive(Clone, PartialEq, Debug)]
pub enum VarType {
    /// Upstream's `PRECISION_LAST` for a type that takes no precision qualifier.
    Basic(DataType, Option<Precision>),
    Array(Box<VarType>, i32),
    Struct(Arc<StructType>),
}

impl VarType {
    pub fn basic(basic_type: DataType, precision: Option<Precision>) -> Self {
        Self::Basic(basic_type, precision)
    }

    pub fn array(element_type: VarType, size: i32) -> Self {
        Self::Array(Box::new(element_type), size)
    }

    pub fn structure(struct_ptr: &Arc<StructType>) -> Self {
        Self::Struct(Arc::clone(struct_ptr))
    }

    pub fn is_basic_type(&self) -> bool {
        matches!(self, Self::Basic(..))
    }

    pub fn is_array_type(&self) -> bool {
        matches!(self, Self::Array(..))
    }

    pub fn is_struct_type(&self) -> bool {
        matches!(self, Self::Struct(_))
    }

    /// `VarType::getBasicType`
    pub fn basic_type(&self) -> DataType {
        match self {
            Self::Basic(t, _) => *t,
            _ => panic!("not a basic type"),
        }
    }

    /// `VarType::getPrecision`
    pub fn precision(&self) -> Option<Precision> {
        match self {
            Self::Basic(_, p) => *p,
            _ => panic!("not a basic type"),
        }
    }

    /// `VarType::getElementType`
    pub fn element_type(&self) -> &VarType {
        match self {
            Self::Array(elem, _) => elem,
            _ => panic!("not an array type"),
        }
    }

    /// `VarType::getArraySize`
    pub fn array_size(&self) -> i32 {
        match self {
            Self::Array(_, size) => *size,
            _ => panic!("not an array type"),
        }
    }

    /// `VarType::getStructPtr`
    pub fn struct_ptr(&self) -> &Arc<StructType> {
        match self {
            Self::Struct(s) => s,
            _ => panic!("not a struct type"),
        }
    }

    /// `VarType::getScalarSize`
    pub fn scalar_size(&self) -> i32 {
        match self {
            Self::Basic(t, _) => t.scalar_size(),
            Self::Array(elem, size) => elem.scalar_size() * size,
            Self::Struct(s) => s.members.iter().map(|m| m.ty.scalar_size()).sum(),
        }
    }
}

/// `glu::StructMember`
#[derive(Clone, PartialEq, Debug)]
pub struct StructMember {
    pub name: String,
    pub ty: VarType,
}

/// `glu::StructType`
#[derive(Clone, PartialEq, Debug)]
pub struct StructType {
    pub type_name: String,
    pub members: Vec<StructMember>,
}

impl StructType {
    pub fn new(type_name: &str) -> Self {
        Self {
            type_name: type_name.to_string(),
            members: Vec::new(),
        }
    }

    pub fn has_type_name(&self) -> bool {
        !self.type_name.is_empty()
    }

    /// `StructType::addMember`
    pub fn add_member(&mut self, name: &str, ty: VarType) {
        self.members.push(StructMember {
            name: name.to_string(),
            ty,
        });
    }

    pub fn num_members(&self) -> usize {
        self.members.len()
    }

    pub fn member(&self, ndx: usize) -> &StructMember {
        &self.members[ndx]
    }
}

/// `glu::decl::Indent`
pub fn indent(level: i32) -> String {
    "\t".repeat(level.max(0) as usize)
}

/// `glu::declare(const VarType&, const std::string&, int)`
pub fn declare_var(ty: &VarType, name: &str, indent_level: i32) -> String {
    let mut cur_type = ty;
    let mut array_sizes = Vec::new();

    // Handle arrays.
    while cur_type.is_array_type() {
        array_sizes.push(cur_type.array_size());
        cur_type = cur_type.element_type();
    }

    let mut out = String::new();
    match cur_type {
        VarType::Basic(basic_type, precision) => {
            if let Some(precision) = precision {
                let _ = write!(out, "{} ", precision.name());
            }
            out.push_str(basic_type.name());
        }
        VarType::Struct(struct_ptr) => {
            if struct_ptr.has_type_name() {
                out.push_str(&struct_ptr.type_name);
            } else {
                // Generate inline declaration.
                out.push_str(&declare_struct(struct_ptr, indent_level));
            }
        }
        VarType::Array(..) => unreachable!("every array level was peeled above"),
    }

    let _ = write!(out, " {name}");

    for size in array_sizes {
        if size == UNSIZED_ARRAY {
            out.push_str("[]");
        } else {
            let _ = write!(out, "[{size}]");
        }
    }

    out
}

/// `glu::declare(const StructType*, int)`
pub fn declare_struct(struct_ptr: &StructType, indent_level: i32) -> String {
    let mut out = String::from("struct");

    // Type name is optional.
    if struct_ptr.has_type_name() {
        let _ = write!(out, " {}", struct_ptr.type_name);
    }

    let _ = write!(out, "\n{}{{\n", indent(indent_level));

    for member in &struct_ptr.members {
        let _ = writeln!(
            out,
            "{}{};",
            indent(indent_level + 1),
            declare_var(&member.ty, &member.name, indent_level + 1)
        );
    }

    let _ = write!(out, "{}}}", indent(indent_level));

    out
}

/// `glu::VarTypeComponent` - one step down a path into a composite type.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum VarTypeComponent {
    StructMember(usize),
    ArrayElement(usize),
    MatrixColumn(usize),
    VectorComponent(usize),
}

/// `glu::getVarType(const VarType&, const TypeComponentVector&)` - the subtype a path
/// names, e.g. `m0[2]` inside a struct.
pub fn get_var_type(ty: &VarType, path: &[VarTypeComponent]) -> VarType {
    let mut cur = ty.clone();
    for component in path {
        cur = match (component, &cur) {
            (VarTypeComponent::StructMember(ndx), VarType::Struct(s)) => s.members[*ndx].ty.clone(),
            (VarTypeComponent::ArrayElement(_), VarType::Array(elem, _)) => (**elem).clone(),
            (VarTypeComponent::MatrixColumn(_), VarType::Basic(t, prec)) => VarType::Basic(
                crate::glu::shader_util::get_data_type_float_vec(t.matrix_num_rows()),
                *prec,
            ),
            (VarTypeComponent::VectorComponent(_), VarType::Basic(t, prec)) => VarType::Basic(t.scalar_type(), *prec),
            _ => panic!("path component does not apply to this type"),
        };
    }
    cur
}

/// `glu::BasicTypeIterator` - every basic-type leaf of a composite type, as the path
/// that reaches it. Unlike `vector_type_paths`, a matrix is one leaf rather than one per
/// column, which is what makes this the right walk for "one uniform location each".
pub fn basic_type_paths(ty: &VarType) -> Vec<Vec<VarTypeComponent>> {
    fn walk(ty: &VarType, path: &mut Vec<VarTypeComponent>, dst: &mut Vec<Vec<VarTypeComponent>>) {
        match ty {
            VarType::Basic(..) => dst.push(path.clone()),
            VarType::Array(elem, size) => {
                for ndx in 0..(*size).max(0) as usize {
                    path.push(VarTypeComponent::ArrayElement(ndx));
                    walk(elem, path, dst);
                    path.pop();
                }
            }
            VarType::Struct(struct_ptr) => {
                for (ndx, member) in struct_ptr.members.iter().enumerate() {
                    path.push(VarTypeComponent::StructMember(ndx));
                    walk(&member.ty, path, dst);
                    path.pop();
                }
            }
        }
    }

    let mut dst = Vec::new();
    walk(ty, &mut Vec::new(), &mut dst);
    dst
}

/// `glu::VectorTypeIterator` - every scalar-or-vector leaf of a composite type, as the
/// path that reaches it.
///
/// Upstream is an input iterator over `SubTypeIterator<IsVectorOrScalarType>`; the whole
/// traversal is eager here, because every caller in this port collects it immediately.
pub fn vector_type_paths(ty: &VarType) -> Vec<Vec<VarTypeComponent>> {
    fn walk(ty: &VarType, path: &mut Vec<VarTypeComponent>, dst: &mut Vec<Vec<VarTypeComponent>>) {
        match ty {
            VarType::Basic(basic_type, _) => {
                if basic_type.is_scalar_or_vector() {
                    dst.push(path.clone());
                } else if basic_type.is_matrix() {
                    for col in 0..basic_type.matrix_num_columns() as usize {
                        path.push(VarTypeComponent::MatrixColumn(col));
                        dst.push(path.clone());
                        path.pop();
                    }
                }
            }
            VarType::Array(elem, size) => {
                for ndx in 0..(*size).max(0) as usize {
                    path.push(VarTypeComponent::ArrayElement(ndx));
                    walk(elem, path, dst);
                    path.pop();
                }
            }
            VarType::Struct(struct_ptr) => {
                for (ndx, member) in struct_ptr.members.iter().enumerate() {
                    path.push(VarTypeComponent::StructMember(ndx));
                    walk(&member.ty, path, dst);
                    path.pop();
                }
            }
        }
    }

    let mut dst = Vec::new();
    walk(ty, &mut Vec::new(), &mut dst);
    dst
}

/// `glu::parseVariableName` - the leading identifier of `v_varA[1].m0`.
pub fn parse_variable_name(name_with_path: &str) -> String {
    name_with_path
        .split_once(['[', '.'])
        .map_or(name_with_path, |(head, _)| head)
        .to_string()
}

/// `glu::parseTypePath` - the `[1].m0` half of the same string, against the type it
/// indexes into.
pub fn parse_type_path(name_with_path: &str, ty: &VarType) -> Vec<VarTypeComponent> {
    let mut path = Vec::new();
    let mut cur = ty.clone();
    let mut rest = &name_with_path[parse_variable_name(name_with_path).len()..];

    while !rest.is_empty() {
        if let Some(tail) = rest.strip_prefix('[') {
            let (index, tail) = tail.split_once(']').expect("unterminated array subscript");
            let index: usize = index.parse().expect("array subscript is not a number");

            let component = match &cur {
                VarType::Array(..) => VarTypeComponent::ArrayElement(index),
                VarType::Basic(basic_type, _) if basic_type.is_matrix() => VarTypeComponent::MatrixColumn(index),
                VarType::Basic(basic_type, _) if basic_type.is_vector() => VarTypeComponent::VectorComponent(index),
                _ => panic!("cannot subscript this type"),
            };
            cur = get_var_type(&cur, std::slice::from_ref(&component));
            path.push(component);
            rest = tail;
        } else if let Some(tail) = rest.strip_prefix('.') {
            let end = tail.find(['[', '.']).unwrap_or(tail.len());
            let member_name = &tail[..end];
            let struct_ptr = cur.struct_ptr().clone();
            let ndx = struct_ptr
                .members
                .iter()
                .position(|member| member.name == member_name)
                .expect("no such struct member");

            let component = VarTypeComponent::StructMember(ndx);
            cur = get_var_type(&cur, std::slice::from_ref(&component));
            path.push(component);
            rest = &tail[end..];
        } else {
            panic!("unexpected character in type path: {rest}");
        }
    }

    path
}

/// `glu::TypeAccessFormat`'s `operator<<` - the GLSL expression that names a subtype,
/// which is also the name `glGetUniformLocation` answers to.
pub fn type_access_name(base_name: &str, ty: &VarType, path: &[VarTypeComponent]) -> String {
    let mut out = base_name.to_string();
    let mut cur = ty.clone();

    for component in path {
        match (component, &cur) {
            (VarTypeComponent::StructMember(ndx), VarType::Struct(s)) => {
                let _ = write!(out, ".{}", s.members[*ndx].name);
                cur = s.members[*ndx].ty.clone();
            }
            (VarTypeComponent::ArrayElement(ndx), VarType::Array(elem, _)) => {
                let _ = write!(out, "[{ndx}]");
                cur = (**elem).clone();
            }
            (VarTypeComponent::MatrixColumn(ndx) | VarTypeComponent::VectorComponent(ndx), _) => {
                let _ = write!(out, "[{ndx}]");
                cur = get_var_type(&cur, std::slice::from_ref(component));
            }
            _ => panic!("path component does not apply to this type"),
        }
    }

    out
}

/// `glu::Storage`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Storage {
    In,
    Out,
    Const,
    Uniform,
    Buffer,
    PatchIn,
    PatchOut,
}

impl Storage {
    /// `glu::getStorageName`
    pub fn name(self) -> &'static str {
        match self {
            Self::In => "in",
            Self::Out => "out",
            Self::Const => "const",
            Self::Uniform => "uniform",
            Self::Buffer => "buffer",
            Self::PatchIn => "patch in",
            Self::PatchOut => "patch out",
        }
    }
}

/// `glu::Interpolation`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Interpolation {
    Smooth,
    Flat,
    Centroid,
}

impl Interpolation {
    /// `glu::getInterpolationName`
    pub fn name(self) -> &'static str {
        match self {
            Self::Smooth => "smooth",
            Self::Flat => "flat",
            Self::Centroid => "centroid",
        }
    }
}

/// `glu::FormatLayout`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum FormatLayout {
    Rgba32f,
    Rgba16f,
    R32f,
    Rgba8,
    Rgba8Snorm,
    Rgba32i,
    Rgba16i,
    Rgba8i,
    R32i,
    Rgba32ui,
    Rgba16ui,
    Rgba8ui,
    R32ui,
}

impl FormatLayout {
    /// `glu::getFormatLayoutName`
    pub fn name(self) -> &'static str {
        match self {
            Self::Rgba32f => "rgba32f",
            Self::Rgba16f => "rgba16f",
            Self::R32f => "r32f",
            Self::Rgba8 => "rgba8",
            Self::Rgba8Snorm => "rgba8_snorm",
            Self::Rgba32i => "rgba32i",
            Self::Rgba16i => "rgba16i",
            Self::Rgba8i => "rgba8i",
            Self::R32i => "r32i",
            Self::Rgba32ui => "rgba32ui",
            Self::Rgba16ui => "rgba16ui",
            Self::Rgba8ui => "rgba8ui",
            Self::R32ui => "r32ui",
        }
    }
}

/// `glu::MatrixOrder`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum MatrixOrder {
    ColumnMajor,
    RowMajor,
}

impl MatrixOrder {
    /// `glu::getMatrixOrderName`
    pub fn name(self) -> &'static str {
        match self {
            Self::ColumnMajor => "column_major",
            Self::RowMajor => "row_major",
        }
    }
}

/// `glu::MemoryAccessQualifier` - a bit set, so it stays a plain mask rather than an enum.
pub mod memory_access {
    pub const COHERENT_BIT: u32 = 0x01;
    pub const VOLATILE_BIT: u32 = 0x02;
    pub const RESTRICT_BIT: u32 = 0x04;
    pub const READONLY_BIT: u32 = 0x08;
    pub const WRITEONLY_BIT: u32 = 0x10;
    pub const MASK: u32 = (WRITEONLY_BIT << 1) - 1;

    /// `glu::getMemoryAccessQualifierName`
    pub fn name(bit: u32) -> &'static str {
        match bit {
            COHERENT_BIT => "coherent",
            VOLATILE_BIT => "volatile",
            RESTRICT_BIT => "restrict",
            READONLY_BIT => "readonly",
            WRITEONLY_BIT => "writeonly",
            other => panic!("not a single memory access qualifier bit: {other:#x}"),
        }
    }
}

/// `glu::Layout` - upstream's `-1` / `*_LAST` defaults are `None` here.
#[derive(Clone, Copy, PartialEq, Eq, Debug, Default)]
pub struct Layout {
    pub location: Option<i32>,
    pub binding: Option<i32>,
    pub offset: Option<i32>,
    pub format: Option<FormatLayout>,
    pub matrix_order: Option<MatrixOrder>,
}

impl Layout {
    pub fn location(location: i32) -> Self {
        Self {
            location: Some(location),
            ..Self::default()
        }
    }

    pub fn binding(binding: i32) -> Self {
        Self {
            binding: Some(binding),
            ..Self::default()
        }
    }

    pub fn is_default(&self) -> bool {
        *self == Self::default()
    }
}

impl fmt::Display for Layout {
    /// `operator<<(std::ostream&, const Layout&)` - nothing at all when every field is
    /// defaulted, which is what makes `layout()` never appear empty in generated GLSL.
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut parts: Vec<String> = Vec::new();

        if let Some(location) = self.location {
            parts.push(format!("location={location}"));
        }
        if let Some(binding) = self.binding {
            parts.push(format!("binding={binding}"));
        }
        if let Some(offset) = self.offset {
            parts.push(format!("offset={offset}"));
        }
        if let Some(format) = self.format {
            parts.push(format.name().to_string());
        }
        if let Some(matrix_order) = self.matrix_order {
            parts.push(matrix_order.name().to_string());
        }

        if !parts.is_empty() {
            write!(f, "layout({})", parts.join(", "))?;
        }
        Ok(())
    }
}

/// `glu::VariableDeclaration`
#[derive(Clone, PartialEq, Debug)]
pub struct VariableDeclaration {
    pub layout: Layout,
    pub interpolation: Option<Interpolation>,
    pub storage: Option<Storage>,
    pub var_type: VarType,
    pub memory_access_qualifier_bits: u32,
    pub name: String,
}

impl VariableDeclaration {
    pub fn new(var_type: VarType, name: &str, storage: Option<Storage>) -> Self {
        Self {
            layout: Layout::default(),
            interpolation: None,
            storage,
            var_type,
            memory_access_qualifier_bits: 0,
            name: name.to_string(),
        }
    }
}

impl fmt::Display for VariableDeclaration {
    /// `operator<<(std::ostream&, const VariableDeclaration&)`
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if !self.layout.is_default() {
            write!(f, "{} ", self.layout)?;
        }

        let mut bit = 1;
        while bit & memory_access::MASK != 0 {
            if self.memory_access_qualifier_bits & bit != 0 {
                write!(f, "{} ", memory_access::name(bit))?;
            }
            bit <<= 1;
        }

        if let Some(interpolation) = self.interpolation {
            write!(f, "{} ", interpolation.name())?;
        }
        if let Some(storage) = self.storage {
            write!(f, "{} ", storage.name())?;
        }

        write!(f, "{}", declare_var(&self.var_type, &self.name, 0))
    }
}

/// `glu::InterfaceBlock`
#[derive(Clone, PartialEq, Debug, Default)]
pub struct InterfaceBlock {
    pub layout: Layout,
    pub storage: Option<Storage>,
    pub memory_access_qualifier_flags: u32,
    pub interface_name: String,
    pub instance_name: String,
    pub variables: Vec<VariableDeclaration>,
    pub dimensions: Vec<i32>,
}
