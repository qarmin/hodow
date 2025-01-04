// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fUniformApiTests.cpp  (UniformCase and its subclasses)
//   modules/gles2/functional/es2fUniformApiTests.cpp  (the ES 2.0 spellings of the same)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`'s texture-unit check becomes
// `check_support`, and `deinit`'s texture cleanup is `Drop`. The three `UniformCase`
// subclasses are one `CaseKind` enum rather than virtual `test()` overrides - they share
// every helper and differ only in which of them they call, which is what the vtable was
// expressing. `glu::Texture2D`/`TextureCube` are not ported: the only use here uploads a
// single solid-colour RGBA8 level, which is `gl.tex_image_2d` directly.

use std::ffi::CString;
use std::sync::Arc;

use crate::glu::shader_util::{
    DataType, Precision, get_data_type_from_gl_type, get_data_type_matrix, get_data_type_vector,
};
use crate::glu::var_type::{StructType, VarType};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::random::de_string_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

const MAX_RENDER_WIDTH: i32 = 32;
const MAX_RENDER_HEIGHT: i32 = 32;
const MAX_NUM_SAMPLER_UNIFORMS: i32 = 16;

/// `tcu::RGBA::white()`
const WHITE: RGBA = RGBA::white();
/// `tcu::RGBA::green()`
const GREEN: RGBA = RGBA::green();

/// `s_testDataTypes` in the ES 2.0 copy - no uint, no non-square matrices.
pub(crate) const TEST_DATA_TYPES_ES2: [DataType; 17] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::FloatMat2,
    DataType::FloatMat3,
    DataType::FloatMat4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    DataType::Sampler2D,
    DataType::SamplerCube,
];

/// `s_testDataTypes`
pub(crate) const TEST_DATA_TYPES: [DataType; 27] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    // \note We don't test all sampler types here.
    DataType::Sampler2D,
    DataType::SamplerCube,
];

// `UniformCase::Feature`
//
// ARRAYUSAGE_ONLY_MIDDLE_INDEX: only middle index of each array is used in shader. If not given, use all indices.
pub(crate) const FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX: u32 = 1 << 0;
// UNIFORMFUNC_VALUE: use pass-by-value versions of uniform assignment funcs, e.g. glUniform1f(), where possible.
pub(crate) const FEATURE_UNIFORMFUNC_VALUE: u32 = 1 << 1;
// MATRIXMODE_ROWMAJOR: pass matrices to GL in row major form. If not given, use column major.
pub(crate) const FEATURE_MATRIXMODE_ROWMAJOR: u32 = 1 << 2;
// ARRAYASSIGN: how basic-type arrays are assigned with glUniform*().
pub(crate) const FEATURE_ARRAYASSIGN_FULL: u32 = 1 << 3;
pub(crate) const FEATURE_ARRAYASSIGN_BLOCKS_OF_TWO: u32 = 1 << 4;
// UNIFORMUSAGE_EVERY_OTHER: use about half of the uniforms.
pub(crate) const FEATURE_UNIFORMUSAGE_EVERY_OTHER: u32 = 1 << 5;
// BOOLEANAPITYPE: type used to pass booleans to and from GL api. If none given, use float.
pub(crate) const FEATURE_BOOLEANAPITYPE_INT: u32 = 1 << 6;
pub(crate) const FEATURE_BOOLEANAPITYPE_UINT: u32 = 1 << 7;
// UNIFORMVALUE_ZERO: use zero-valued uniforms. If not given, use random uniform values.
pub(crate) const FEATURE_UNIFORMVALUE_ZERO: u32 = 1 << 8;
// ARRAY_FIRST_ELEM_NAME_NO_INDEX: refer to the first element of an array without the [0].
pub(crate) const FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX: u32 = 1 << 9;

/// `beforeLast`
fn before_last(s: &str, c: char) -> String {
    s.rfind(c).map_or_else(|| s.to_string(), |at| s[..at].to_string())
}

/// `de::floatToString(v, 2)`
fn float_to_string(value: f32) -> String {
    format!("{value:.2}")
}

/// `getSamplerNumLookupDimensions`
fn get_sampler_num_lookup_dimensions(ty: DataType) -> i32 {
    match ty {
        DataType::Sampler2D | DataType::IntSampler2D | DataType::UintSampler2D => 2,
        DataType::SamplerCubeShadow | DataType::Sampler2DArrayShadow => 4,
        _ => 3,
    }
}

/// `getSamplerLookupReturnType`
fn get_sampler_lookup_return_type(ty: DataType) -> DataType {
    match ty {
        DataType::Sampler2D | DataType::SamplerCube | DataType::Sampler2DArray | DataType::Sampler3D => {
            DataType::FloatVec4
        }
        DataType::UintSampler2D
        | DataType::UintSamplerCube
        | DataType::UintSampler2DArray
        | DataType::UintSampler3D => DataType::UintVec4,
        DataType::IntSampler2D | DataType::IntSamplerCube | DataType::IntSampler2DArray | DataType::IntSampler3D => {
            DataType::IntVec4
        }
        DataType::Sampler2DShadow | DataType::SamplerCubeShadow | DataType::Sampler2DArrayShadow => DataType::Float,
        _ => DataType::Invalid,
    }
}

/// `dataTypePredicate`
type DataTypePredicate = fn(DataType) -> bool;

fn is_float_or_vec(t: DataType) -> bool {
    t.is_float_or_vec()
}
pub(crate) fn is_matrix(t: DataType) -> bool {
    t.is_matrix()
}
pub(crate) fn is_bool_or_bvec(t: DataType) -> bool {
    t.is_bool_or_bvec()
}
fn never(_: DataType) -> bool {
    false
}

/// `typeContainsMatchingBasicType`
fn type_contains_matching_basic_type(ty: &VarType, predicate: DataTypePredicate) -> bool {
    match ty {
        VarType::Basic(basic_type, _) => predicate(*basic_type),
        VarType::Array(elem, _) => type_contains_matching_basic_type(elem, predicate),
        VarType::Struct(s) => s
            .members
            .iter()
            .any(|member| type_contains_matching_basic_type(&member.ty, predicate)),
    }
}

/// `getDistinctSamplerTypes`
fn get_distinct_sampler_types(dst: &mut Vec<DataType>, ty: &VarType) {
    match ty {
        VarType::Basic(basic_type, _) => {
            if basic_type.is_sampler() && !dst.contains(basic_type) {
                dst.push(*basic_type);
            }
        }
        VarType::Array(elem, _) => get_distinct_sampler_types(dst, elem),
        VarType::Struct(s) => {
            for member in &s.members {
                get_distinct_sampler_types(dst, &member.ty);
            }
        }
    }
}

/// `getNumSamplersInType`
fn get_num_samplers_in_type(ty: &VarType) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => i32::from(basic_type.is_sampler()),
        VarType::Array(elem, size) => get_num_samplers_in_type(elem) * size,
        VarType::Struct(s) => s
            .members
            .iter()
            .map(|member| get_num_samplers_in_type(&member.ty))
            .sum(),
    }
}

/// `generateRandomType`
fn generate_random_type(
    max_depth: i32,
    cur_struct_idx: &mut i32,
    struct_types_dst: &mut Vec<Arc<StructType>>,
    rnd: &mut Random,
    test_data_types: &[DataType],
) -> VarType {
    let is_struct = max_depth > 0 && rnd.get_float() < 0.2;
    let is_array = rnd.get_float() < 0.3;

    if is_struct {
        let num_members = rnd.get_int(1, 5);
        let mut struct_type = StructType::new(&format!("structType{cur_struct_idx}"));
        *cur_struct_idx += 1;

        for i in 0..num_members {
            let member_type =
                generate_random_type(max_depth - 1, cur_struct_idx, struct_types_dst, rnd, test_data_types);
            struct_type.add_member(&format!("m{i}"), member_type);
        }

        let struct_type = Arc::new(struct_type);
        struct_types_dst.push(Arc::clone(&struct_type));

        if is_array {
            VarType::array(VarType::Struct(struct_type), rnd.get_int(1, 5))
        } else {
            VarType::Struct(struct_type)
        }
    } else {
        let basic_type = *rnd.choose(test_data_types);
        let precision = if basic_type.is_bool_or_bvec() {
            None
        } else {
            Some(Precision::MediumP)
        };
        if is_array {
            VarType::array(VarType::basic(basic_type, precision), rnd.get_int(1, 5))
        } else {
            VarType::basic(basic_type, precision)
        }
    }
}

/// `VarValue` - upstream's union, flattened. Only the member the `ty` selects is read.
#[derive(Clone, Copy, Debug)]
struct VarValue {
    ty: DataType,
    /// At most mat4. \note Matrices here are column-major.
    float_v: [f32; 16],
    int_v: [i32; 4],
    uint_v: [u32; 4],
    bool_v: [bool; 4],
    sampler_unit: i32,
    sampler_fill_float: [f32; 4],
    sampler_fill_int: [i32; 4],
    sampler_fill_uint: [u32; 4],
}

impl VarValue {
    fn new(ty: DataType) -> Self {
        Self {
            ty,
            float_v: [0.0; 16],
            int_v: [0; 4],
            uint_v: [0; 4],
            bool_v: [false; 4],
            sampler_unit: 0,
            sampler_fill_float: [0.0; 4],
            sampler_fill_int: [0; 4],
            sampler_fill_uint: [0; 4],
        }
    }
}

/// Which of the two upstream copies of this case a given instance is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum EsVersion {
    /// `es2fUniformApiTests.cpp` - GLSL ES 1.0, `texture2D`, no `glGetActiveUniformsiv`.
    Es2,
    /// `es3fUniformApiTests.cpp`
    Es3,
    /// `es31fProgramUniformTests.cpp` - the same case driven through
    /// `glProgramUniform*` on a program that is deliberately *not* current.
    Es31,
}

/// `CaseShaderType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum CaseShaderType {
    Vertex,
    Fragment,
    Both,
}

impl CaseShaderType {
    /// `getCaseShaderTypeName`
    pub(crate) fn name(self) -> &'static str {
        match self {
            Self::Vertex => "vertex",
            Self::Fragment => "fragment",
            Self::Both => "both",
        }
    }
}

pub(crate) const CASE_SHADER_TYPES: [CaseShaderType; 3] =
    [CaseShaderType::Vertex, CaseShaderType::Fragment, CaseShaderType::Both];

/// `randomCaseShaderType`
pub(crate) fn random_case_shader_type(seed: u32) -> CaseShaderType {
    CASE_SHADER_TYPES[Random::new(seed).get_int(0, 2) as usize]
}

/// `Uniform`
struct Uniform {
    name: String,
    ty: VarType,
}

/// `UniformCollection`
#[derive(Default)]
pub(crate) struct UniformCollection {
    uniforms: Vec<Uniform>,
    struct_types: Vec<Arc<StructType>>,
}

impl UniformCollection {
    fn add_uniform(&mut self, name: &str, ty: VarType) {
        self.uniforms.push(Uniform {
            name: name.to_string(),
            ty,
        });
    }

    /// `UniformCollection::moveContents`
    fn move_contents(mut self, receiver: &mut UniformCollection) {
        receiver.uniforms.append(&mut self.uniforms);
        receiver.struct_types.append(&mut self.struct_types);
    }

    pub(crate) fn contains_matching_basic_type(&self, predicate: DataTypePredicate) -> bool {
        self.uniforms
            .iter()
            .any(|uniform| type_contains_matching_basic_type(&uniform.ty, predicate))
    }

    fn sampler_types(&self) -> Vec<DataType> {
        let mut sampler_types = Vec::new();
        for uniform in &self.uniforms {
            get_distinct_sampler_types(&mut sampler_types, &uniform.ty);
        }
        sampler_types
    }

    pub(crate) fn contains_several_sampler_types(&self) -> bool {
        self.sampler_types().len() > 1
    }

    fn num_samplers(&self) -> i32 {
        self.uniforms
            .iter()
            .map(|uniform| get_num_samplers_in_type(&uniform.ty))
            .sum()
    }

    fn precision_of(ty: DataType) -> Option<Precision> {
        if ty.is_bool_or_bvec() {
            None
        } else {
            Some(Precision::MediumP)
        }
    }

    /// `UniformCollection::basic`
    pub(crate) fn basic(ty: DataType, name_suffix: &str) -> Self {
        let mut res = Self::default();
        res.add_uniform(
            &format!("u_var{name_suffix}"),
            VarType::basic(ty, Self::precision_of(ty)),
        );
        res
    }

    /// `UniformCollection::basicArray`
    pub(crate) fn basic_array(ty: DataType, name_suffix: &str) -> Self {
        let mut res = Self::default();
        res.add_uniform(
            &format!("u_var{name_suffix}"),
            VarType::array(VarType::basic(ty, Self::precision_of(ty)), 3),
        );
        res
    }

    /// `UniformCollection::basicStruct`
    pub(crate) fn basic_struct(type0: DataType, type1: DataType, contains_arrays: bool, name_suffix: &str) -> Self {
        let mut res = Self::default();
        let prec0 = Self::precision_of(type0);
        let prec1 = Self::precision_of(type1);

        let mut struct_type = StructType::new(&format!("structType{name_suffix}"));
        struct_type.add_member("m0", VarType::basic(type0, prec0));
        struct_type.add_member("m1", VarType::basic(type1, prec1));
        if contains_arrays {
            struct_type.add_member("m2", VarType::array(VarType::basic(type0, prec0), 3));
            struct_type.add_member("m3", VarType::array(VarType::basic(type1, prec1), 3));
        }

        let struct_type = Arc::new(struct_type);
        res.struct_types.push(Arc::clone(&struct_type));
        res.add_uniform(&format!("u_var{name_suffix}"), VarType::Struct(struct_type));
        res
    }

    /// `UniformCollection::structInArray`
    pub(crate) fn struct_in_array(type0: DataType, type1: DataType, contains_arrays: bool, name_suffix: &str) -> Self {
        let mut res = Self::basic_struct(type0, type1, contains_arrays, name_suffix);
        let ty = res.uniforms[0].ty.clone();
        res.uniforms[0].ty = VarType::array(ty, 3);
        res
    }

    /// `UniformCollection::nestedArraysStructs`
    pub(crate) fn nested_arrays_structs(type0: DataType, type1: DataType, name_suffix: &str) -> Self {
        let mut res = Self::default();
        let prec0 = Self::precision_of(type0);
        let prec1 = Self::precision_of(type1);

        let mut sub_sub_struct_type = StructType::new(&format!("subSubStructType{name_suffix}"));
        sub_sub_struct_type.add_member("mss0", VarType::basic(type0, prec0));
        sub_sub_struct_type.add_member("mss1", VarType::basic(type1, prec1));
        let sub_sub_struct_type = Arc::new(sub_sub_struct_type);

        let mut sub_struct_type = StructType::new(&format!("subStructType{name_suffix}"));
        sub_struct_type.add_member("ms0", VarType::basic(type1, prec1));
        sub_struct_type.add_member("ms1", VarType::array(VarType::basic(type0, prec0), 2));
        sub_struct_type.add_member(
            "ms2",
            VarType::array(VarType::Struct(Arc::clone(&sub_sub_struct_type)), 2),
        );
        let sub_struct_type = Arc::new(sub_struct_type);

        let mut struct_type = StructType::new(&format!("structType{name_suffix}"));
        struct_type.add_member("m0", VarType::basic(type0, prec0));
        struct_type.add_member("m1", VarType::Struct(Arc::clone(&sub_struct_type)));
        struct_type.add_member("m2", VarType::basic(type1, prec1));
        let struct_type = Arc::new(struct_type);

        res.struct_types.push(sub_sub_struct_type);
        res.struct_types.push(sub_struct_type);
        res.struct_types.push(Arc::clone(&struct_type));

        res.add_uniform(&format!("u_var{name_suffix}"), VarType::Struct(struct_type));
        res
    }

    /// `UniformCollection::multipleBasic` in the ES 2.0 copy - no uvec4 there.
    pub(crate) fn multiple_basic_es2() -> Self {
        const TYPES: [DataType; 4] = [
            DataType::Float,
            DataType::IntVec3,
            DataType::FloatMat3,
            DataType::BoolVec2,
        ];
        let mut res = Self::default();
        for (i, ty) in TYPES.into_iter().enumerate() {
            Self::basic(ty, &format!("_{i}")).move_contents(&mut res);
        }
        res
    }

    /// `UniformCollection::multipleBasic`
    pub(crate) fn multiple_basic() -> Self {
        const TYPES: [DataType; 5] = [
            DataType::Float,
            DataType::IntVec3,
            DataType::UintVec4,
            DataType::FloatMat3,
            DataType::BoolVec2,
        ];
        let mut res = Self::default();
        for (i, ty) in TYPES.into_iter().enumerate() {
            Self::basic(ty, &format!("_{i}")).move_contents(&mut res);
        }
        res
    }

    /// `UniformCollection::multipleBasicArray`
    pub(crate) fn multiple_basic_array() -> Self {
        const TYPES: [DataType; 3] = [DataType::Float, DataType::IntVec3, DataType::BoolVec2];
        let mut res = Self::default();
        for (i, ty) in TYPES.into_iter().enumerate() {
            Self::basic_array(ty, &format!("_{i}")).move_contents(&mut res);
        }
        res
    }

    /// `UniformCollection::multipleNestedArraysStructs`
    pub(crate) fn multiple_nested_arrays_structs() -> Self {
        const TYPES0: [DataType; 3] = [DataType::Float, DataType::Int, DataType::BoolVec4];
        const TYPES1: [DataType; 3] = [DataType::FloatVec4, DataType::IntVec4, DataType::Bool];
        let mut res = Self::default();
        for i in 0..TYPES0.len() {
            Self::nested_arrays_structs(TYPES0[i], TYPES1[i], &format!("_{i}")).move_contents(&mut res);
        }
        res
    }

    /// `UniformCollection::random`
    pub(crate) fn random(seed: u32, test_data_types: &[DataType]) -> Self {
        let mut rnd = Random::new(seed);
        let num_uniforms = rnd.get_int(1, 5);
        let mut struct_idx = 0;
        let mut res = Self::default();

        for i in 0..num_uniforms {
            let mut struct_types = Vec::new();
            let mut ty;

            // \note Discard uniforms that would cause number of samplers to exceed MAX_NUM_SAMPLER_UNIFORMS.
            loop {
                struct_types.clear();
                ty = generate_random_type(3, &mut struct_idx, &mut struct_types, &mut rnd, test_data_types);
                if res.num_samplers() + get_num_samplers_in_type(&ty) <= MAX_NUM_SAMPLER_UNIFORMS {
                    break;
                }
            }

            res.add_uniform(&format!("u_var{i}"), ty);
            res.struct_types.append(&mut struct_types);
        }

        res
    }
}

/// `getSamplerFillValue`
fn get_sampler_fill_value(sampler: &VarValue) -> VarValue {
    let mut result = VarValue::new(get_sampler_lookup_return_type(sampler.ty));

    match result.ty {
        DataType::FloatVec4 => result.float_v[..4].copy_from_slice(&sampler.sampler_fill_float),
        DataType::UintVec4 => result.uint_v.copy_from_slice(&sampler.sampler_fill_uint),
        DataType::IntVec4 => result.int_v.copy_from_slice(&sampler.sampler_fill_int),
        _ => result.float_v[0] = sampler.sampler_fill_float[0],
    }

    result
}

/// `getSamplerUnitValue`
fn get_sampler_unit_value(sampler: &VarValue) -> VarValue {
    let mut result = VarValue::new(DataType::Int);
    result.int_v[0] = sampler.sampler_unit;
    result
}

/// `getTransposeMatrix`
fn get_transpose_matrix(original: &VarValue) -> VarValue {
    let rows = original.ty.matrix_num_rows();
    let cols = original.ty.matrix_num_columns();
    let mut result = VarValue::new(get_data_type_matrix(rows, cols));

    for i in 0..rows {
        for j in 0..cols {
            result.float_v[(i * cols + j) as usize] = original.float_v[(j * rows + i) as usize];
        }
    }

    result
}

/// `shaderVarValueStr`
fn shader_var_value_str(value: &VarValue) -> String {
    let num_elems = value.ty.scalar_size();
    let mut result = String::new();

    if num_elems > 1 {
        result.push_str(value.ty.name());
        result.push('(');
    }

    for i in 0..num_elems as usize {
        if i > 0 {
            result.push_str(", ");
        }

        if value.ty.is_float_or_vec() || value.ty.is_matrix() {
            result.push_str(&float_to_string(value.float_v[i]));
        } else if value.ty.is_int_or_ivec() {
            result.push_str(&value.int_v[i].to_string());
        } else if value.ty.is_uint_or_uvec() {
            result.push_str(&format!("{}u", value.uint_v[i]));
        } else if value.ty.is_bool_or_bvec() {
            result.push_str(if value.bool_v[i] { "true" } else { "false" });
        } else if value.ty.is_sampler() {
            result.push_str(&shader_var_value_str(&get_sampler_fill_value(value)));
        }
    }

    if num_elems > 1 {
        result.push(')');
    }

    result
}

/// `apiVarValueStr` - upstream logs every assigned value with it. Kept because the log
/// line is what says *which* value a failing case set, and the failure messages here
/// will grow into it.
#[allow(dead_code)]
fn api_var_value_str(value: &VarValue) -> String {
    let num_elems = value.ty.scalar_size();
    let mut result = String::new();

    if num_elems > 1 {
        result.push('(');
    }

    for i in 0..num_elems as usize {
        if i > 0 {
            result.push_str(", ");
        }

        if value.ty.is_float_or_vec() || value.ty.is_matrix() {
            result.push_str(&float_to_string(value.float_v[i]));
        } else if value.ty.is_int_or_ivec() {
            result.push_str(&value.int_v[i].to_string());
        } else if value.ty.is_uint_or_uvec() {
            result.push_str(&value.uint_v[i].to_string());
        } else if value.ty.is_bool_or_bvec() {
            result.push_str(if value.bool_v[i] { "true" } else { "false" });
        } else if value.ty.is_sampler() {
            result.push_str(&value.sampler_unit.to_string());
        }
    }

    if num_elems > 1 {
        result.push(')');
    }

    result
}

/// `generateRandomVarValue`. `sampler_unit` is used if the type is a sampler type;
/// samplers' unit numbers are not randomized.
fn generate_random_var_value(ty: DataType, rnd: &mut Random, sampler_unit: i32) -> VarValue {
    let num_elems = ty.scalar_size() as usize;
    let mut result = VarValue::new(ty);

    if ty.is_float_or_vec() || ty.is_matrix() {
        for i in 0..num_elems {
            result.float_v[i] = rnd.get_float_range(-10.0, 10.0);
        }
    } else if ty.is_int_or_ivec() {
        for i in 0..num_elems {
            result.int_v[i] = rnd.get_int(-10, 10);
        }
    } else if ty.is_uint_or_uvec() {
        for i in 0..num_elems {
            result.uint_v[i] = rnd.get_int(0, 10) as u32;
        }
    } else if ty.is_bool_or_bvec() {
        for i in 0..num_elems {
            result.bool_v[i] = rnd.get_bool();
        }
    } else if ty.is_sampler() {
        let tex_result_type = get_sampler_lookup_return_type(ty);
        let tex_result_scalar_type = tex_result_type.scalar_type();
        let tex_result_num_dims = tex_result_type.scalar_size() as usize;

        result.sampler_unit = sampler_unit;

        for i in 0..tex_result_num_dims {
            match tex_result_scalar_type {
                DataType::Float => result.sampler_fill_float[i] = rnd.get_float_range(0.0, 1.0),
                DataType::Int => result.sampler_fill_int[i] = rnd.get_int(-10, 10),
                _ => result.sampler_fill_uint[i] = rnd.get_int(0, 10) as u32,
            }
        }
    }

    result
}

/// `generateZeroVarValue`
fn generate_zero_var_value(ty: DataType) -> VarValue {
    let mut result = VarValue::new(ty);

    if ty.is_sampler() {
        let tex_result_type = get_sampler_lookup_return_type(ty);
        let tex_result_scalar_type = tex_result_type.scalar_type();
        let tex_result_num_dims = tex_result_type.scalar_size() as usize;

        result.sampler_unit = 0;

        for i in 0..tex_result_num_dims {
            match tex_result_scalar_type {
                DataType::Float => result.sampler_fill_float[i] = 0.12 * i as f32,
                DataType::Int => result.sampler_fill_int[i] = -2 + i as i32,
                _ => result.sampler_fill_uint[i] = 4 + i as u32,
            }
        }
    }

    // Everything else is already zero-initialised, which is what upstream writes here.
    result
}

/// `apiVarValueEquals`
fn api_var_value_equals(a: &VarValue, b: &VarValue) -> bool {
    let size = a.ty.scalar_size() as usize;
    const FLOAT_THRESHOLD: f32 = 0.05;

    if a.ty.is_float_or_vec() || a.ty.is_matrix() {
        (0..size).all(|i| (a.float_v[i] - b.float_v[i]).abs() < FLOAT_THRESHOLD)
    } else if a.ty.is_int_or_ivec() {
        a.int_v[..size] == b.int_v[..size]
    } else if a.ty.is_uint_or_uvec() {
        a.uint_v[..size] == b.uint_v[..size]
    } else if a.ty.is_bool_or_bvec() {
        a.bool_v[..size] == b.bool_v[..size]
    } else {
        debug_assert!(a.ty.is_sampler());
        a.sampler_unit == b.sampler_unit
    }
}

/// `getRandomBoolRepresentation`
fn get_random_bool_representation(bool_value: &VarValue, target_scalar_type: DataType, rnd: &mut Random) -> VarValue {
    let size = bool_value.ty.scalar_size();
    let target_type = if size == 1 {
        target_scalar_type
    } else {
        get_data_type_vector(target_scalar_type, size)
    };
    let mut result = VarValue::new(target_type);

    for i in 0..size as usize {
        match target_scalar_type {
            DataType::Int => {
                if bool_value.bool_v[i] {
                    result.int_v[i] = rnd.get_int(-10, 10);
                    if result.int_v[i] == 0 {
                        result.int_v[i] = 1;
                    }
                } else {
                    result.int_v[i] = 0;
                }
            }
            DataType::Uint => {
                result.uint_v[i] = if bool_value.bool_v[i] {
                    rnd.get_int(1, 10) as u32
                } else {
                    0
                };
            }
            _ => {
                if bool_value.bool_v[i] {
                    result.float_v[i] = rnd.get_float_range(-10.0, 10.0);
                    if result.float_v[i] == 0.0 {
                        result.float_v[i] = 1.0;
                    }
                } else {
                    result.float_v[i] = 0.0;
                }
            }
        }
    }

    result
}

/// `UniformCase::BasicUniform`
struct BasicUniform {
    name: String,
    ty: DataType,
    is_used_in_shader: bool,
    /// The value we ultimately want to set for this uniform.
    final_value: VarValue,
    /// If this is a member of a basic-typed array, the name of that array with "[0]"
    /// appended. Otherwise it equals `name`.
    root_name: String,
    /// The index in that array, otherwise -1.
    elem_ndx: i32,
    /// The size of that array, otherwise 1.
    root_size: i32,
}

/// `UniformCase::BasicUniformReportRef`
struct BasicUniformReportRef {
    name: String,
    /// \note min_size and max_size are for arrays and can be distinct since
    /// implementations are allowed, but not required, to trim the inactive end indices.
    min_size: i32,
    max_size: i32,
    ty: DataType,
    is_used_in_shader: bool,
}

/// `UniformCase::BasicUniformReportGL`
#[derive(Clone)]
struct BasicUniformReportGL {
    name: String,
    /// \note Whether this includes the null byte depends on whether it was queried with
    /// `glGetActiveUniform()` or `glGetActiveUniformsiv()`.
    name_length: i32,
    size: i32,
    ty: DataType,
    index: i32,
}

fn find_with_name<'a>(reports: &'a [BasicUniformReportGL], name: &str) -> Option<&'a BasicUniformReportGL> {
    reports.iter().find(|report| report.name == name)
}

/// `randomFeatures`
pub(crate) fn random_features(seed: u32, es_version: EsVersion) -> u32 {
    const ARRAY_USAGE_CHOICES: [u32; 2] = [0, FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX];
    const UNIFORM_FUNC_CHOICES: [u32; 2] = [0, FEATURE_UNIFORMFUNC_VALUE];
    const MATRIX_MODE_CHOICES: [u32; 2] = [0, FEATURE_MATRIXMODE_ROWMAJOR];
    const ARRAY_ASSIGN_CHOICES: [u32; 3] = [0, FEATURE_ARRAYASSIGN_FULL, FEATURE_ARRAYASSIGN_BLOCKS_OF_TWO];
    const UNIFORM_USAGE_CHOICES: [u32; 2] = [0, FEATURE_UNIFORMUSAGE_EVERY_OTHER];
    const BOOLEAN_API_TYPE_CHOICES: [u32; 3] = [0, FEATURE_BOOLEANAPITYPE_INT, FEATURE_BOOLEANAPITYPE_UINT];
    const UNIFORM_VALUE_CHOICES: [u32; 2] = [0, FEATURE_UNIFORMVALUE_ZERO];

    let mut rnd = Random::new(seed);

    // Upstream's ARRAY_CHOICE is a plain indexed pick, not `de::Random::choose`.
    let mut pick = |choices: &[u32]| choices[rnd.get_int(0, choices.len() as i32 - 1) as usize];

    match es_version {
        // Upstream's ES 2.0 copy has no matrix-mode choice and no uint boolean API type,
        // and the draw order is what decides every other choice, so the two lists cannot
        // be merged.
        EsVersion::Es2 => {
            pick(&ARRAY_USAGE_CHOICES)
                | pick(&UNIFORM_FUNC_CHOICES)
                | pick(&ARRAY_ASSIGN_CHOICES)
                | pick(&UNIFORM_USAGE_CHOICES)
                | pick(&BOOLEAN_API_TYPE_CHOICES[..2])
                | pick(&UNIFORM_VALUE_CHOICES)
        }
        EsVersion::Es3 | EsVersion::Es31 => {
            pick(&ARRAY_USAGE_CHOICES)
                | pick(&UNIFORM_FUNC_CHOICES)
                | pick(&MATRIX_MODE_CHOICES)
                | pick(&ARRAY_ASSIGN_CHOICES)
                | pick(&UNIFORM_USAGE_CHOICES)
                | pick(&BOOLEAN_API_TYPE_CHOICES)
                | pick(&UNIFORM_VALUE_CHOICES)
        }
    }
}

/// `UniformInfoQueryCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum InfoQueryType {
    /// Check info returned by `glGetActiveUniform()`.
    Uniform,
    /// Check info returned by `glGetUniformIndices()` + `glGetActiveUniformsiv()`.
    IndicesUniformsiv,
    /// Query info with both above methods, and check consistency.
    Consistency,
}

impl InfoQueryType {
    pub(crate) fn name(self) -> &'static str {
        match self {
            Self::Uniform => "active_uniform",
            Self::IndicesUniformsiv => "indices_active_uniformsiv",
            Self::Consistency => "consistency",
        }
    }
}

/// `UniformValueCase::ValueToCheck`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum ValueToCheck {
    /// Verify the initial values of the uniforms (i.e. check that they're zero).
    Initial,
    /// Assign values to uniforms with `glUniform*()`, and check those.
    Assigned,
}

/// `UniformValueCase::CheckMethod`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum CheckMethod {
    /// Check values with `glGetUniform*()`.
    GetUniform,
    /// Check values by rendering with the value-checking shader.
    Render,
}

impl CheckMethod {
    pub(crate) fn name(self) -> &'static str {
        match self {
            Self::GetUniform => "get_uniform",
            Self::Render => "render",
        }
    }
}

/// `UniformValueCase::AssignMethod`
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) enum AssignMethod {
    Pointer,
    Value,
}

impl AssignMethod {
    pub(crate) fn name(self) -> &'static str {
        match self {
            Self::Pointer => "by_pointer",
            Self::Value => "by_value",
        }
    }
}

/// Which upstream `UniformCase` subclass this case is.
#[derive(Clone, Copy)]
pub(crate) enum CaseKind {
    InfoQuery(InfoQueryType),
    Value(ValueToCheck, CheckMethod),
    Random,
}

/// `UniformCase` and its three subclasses.
pub(crate) struct UniformCase {
    pub name: String,
    pub es_version: EsVersion,
    pub case_shader_type: CaseShaderType,
    pub uniform_collection: Arc<UniformCollection>,
    pub features: u32,
    pub kind: CaseKind,
}

/// The textures `setupTexture` creates, deleted together like upstream's `deinit`.
struct TextureSet<'gl> {
    gl: &'gl glw::Functions,
    names: Vec<GLuint>,
    filled_texture_units: Vec<i32>,
}

impl<'gl> TextureSet<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            names: Vec::new(),
            filled_texture_units: Vec::new(),
        }
    }

    /// `UniformCase::setupTexture`, for the only two sampler types this suite declares.
    fn setup(&mut self, value: &VarValue) -> Result<(), TestError> {
        // \note No handling for samplers other than 2D or cube.
        const WIDTH: i32 = 32;
        const HEIGHT: i32 = 32;

        let to_u8 = |v: f32| (v.clamp(0.0, 1.0) * 255.0).round() as u8;
        let texel = [
            to_u8(value.sampler_fill_float[0]),
            to_u8(value.sampler_fill_float[1]),
            to_u8(value.sampler_fill_float[2]),
            to_u8(value.sampler_fill_float[3]),
        ];
        let pixels: Vec<u8> = texel
            .iter()
            .copied()
            .cycle()
            .take((WIDTH * HEIGHT * 4) as usize)
            .collect();

        let (target, faces): (GLenum, &[GLenum]) = match value.ty {
            DataType::Sampler2D => (glw::GL_TEXTURE_2D, &[glw::GL_TEXTURE_2D]),
            _ => (
                glw::GL_TEXTURE_CUBE_MAP,
                &[
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                ],
            ),
        };

        // SAFETY: the texture name is this set's own, and the upload reads exactly
        // WIDTH*HEIGHT*4 bytes out of `pixels`.
        unsafe {
            let mut texture = 0;
            self.gl.gen_textures(1, &mut texture);
            self.names.push(texture);

            self.gl.active_texture(glw::GL_TEXTURE0 + value.sampler_unit as GLenum);
            self.filled_texture_units.push(value.sampler_unit);

            self.gl.bind_texture(target, texture);
            for face in faces {
                self.gl.tex_image_2d(
                    *face,
                    0,
                    glw::GL_RGBA as GLint,
                    WIDTH,
                    HEIGHT,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixels.as_ptr().cast(),
                );
            }
            self.gl
                .tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint);
            self.gl
                .tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as GLint);
            self.gl
                .tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            self.gl
                .tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        }

        glu::expect_no_error(self.gl, "setupTexture")
    }
}

impl Drop for TextureSet<'_> {
    fn drop(&mut self) {
        if !self.names.is_empty() {
            // SAFETY: every name is this set's own and is deleted exactly once.
            unsafe { self.gl.delete_textures(self.names.len() as i32, self.names.as_ptr()) };
        }
        // Upstream leaves unit 0 current after `deinit`; the next case's state reset
        // does not cover glActiveTexture, so put it back here.
        // SAFETY: as above.
        unsafe { self.gl.active_texture(glw::GL_TEXTURE0) };
    }
}

impl UniformCase {
    fn has(&self, feature: u32) -> bool {
        self.features & feature != 0
    }

    /// `UniformCase::generateBasicUniforms`
    #[allow(clippy::too_many_arguments)]
    fn generate_basic_uniforms(
        &self,
        basic_uniforms_dst: &mut Vec<BasicUniform>,
        basic_uniform_reports_dst: &mut Vec<BasicUniformReportRef>,
        var_type: &VarType,
        var_name: &str,
        is_parent_active: bool,
        sampler_unit_counter: &mut i32,
        rnd: &mut Random,
    ) {
        let make_value = |ty: DataType, sampler_unit_counter: &mut i32, rnd: &mut Random| {
            if self.has(FEATURE_UNIFORMVALUE_ZERO) {
                generate_zero_var_value(ty)
            } else if ty.is_sampler() {
                let unit = *sampler_unit_counter;
                *sampler_unit_counter += 1;
                generate_random_var_value(ty, rnd, unit)
            } else {
                generate_random_var_value(ty, rnd, -1)
            }
        };

        match var_type {
            VarType::Basic(ty, _) => {
                let is_active = is_parent_active
                    && (!self.has(FEATURE_UNIFORMUSAGE_EVERY_OTHER) || basic_uniforms_dst.len().is_multiple_of(2));
                let value = make_value(*ty, sampler_unit_counter, rnd);

                basic_uniforms_dst.push(BasicUniform {
                    name: var_name.to_string(),
                    ty: *ty,
                    is_used_in_shader: is_active,
                    final_value: value,
                    root_name: var_name.to_string(),
                    elem_ndx: -1,
                    root_size: 1,
                });
                basic_uniform_reports_dst.push(BasicUniformReportRef {
                    name: var_name.to_string(),
                    min_size: 1,
                    max_size: 1,
                    ty: *ty,
                    is_used_in_shader: is_active,
                });
            }
            VarType::Array(element_type, size) => {
                let array_root_name = format!("{var_name}[0]");
                let mut is_elem_active = Vec::new();

                for elem_ndx in 0..*size {
                    let indexed_name = format!("{var_name}[{elem_ndx}]");
                    let is_cur_elem_active = is_parent_active
                        && (!self.has(FEATURE_UNIFORMUSAGE_EVERY_OTHER) || basic_uniforms_dst.len().is_multiple_of(2))
                        && (!self.has(FEATURE_ARRAYUSAGE_ONLY_MIDDLE_INDEX) || elem_ndx == size / 2);

                    is_elem_active.push(is_cur_elem_active);

                    if let VarType::Basic(elem_basic_type, _) = &**element_type {
                        // \note We don't want separate entries in basicUniformReportsDst for elements of basic-type arrays.
                        let value = make_value(*elem_basic_type, sampler_unit_counter, rnd);

                        basic_uniforms_dst.push(BasicUniform {
                            name: indexed_name,
                            ty: *elem_basic_type,
                            is_used_in_shader: is_cur_elem_active,
                            final_value: value,
                            root_name: array_root_name.clone(),
                            elem_ndx,
                            root_size: *size,
                        });
                    } else {
                        self.generate_basic_uniforms(
                            basic_uniforms_dst,
                            basic_uniform_reports_dst,
                            element_type,
                            &indexed_name,
                            is_cur_elem_active,
                            sampler_unit_counter,
                            rnd,
                        );
                    }
                }

                if let VarType::Basic(elem_basic_type, _) = &**element_type {
                    let mut min_size = *size;
                    while min_size > 0 && !is_elem_active[(min_size - 1) as usize] {
                        min_size -= 1;
                    }

                    basic_uniform_reports_dst.push(BasicUniformReportRef {
                        name: array_root_name,
                        min_size,
                        max_size: *size,
                        ty: *elem_basic_type,
                        is_used_in_shader: is_parent_active && min_size > 0,
                    });
                }
            }
            VarType::Struct(struct_type) => {
                for member in &struct_type.members {
                    let member_full_name = format!("{var_name}.{}", member.name);
                    self.generate_basic_uniforms(
                        basic_uniforms_dst,
                        basic_uniform_reports_dst,
                        &member.ty,
                        &member_full_name,
                        is_parent_active,
                        sampler_unit_counter,
                        rnd,
                    );
                }
            }
        }
    }

    /// `UniformCase::writeUniformDefinitions`
    fn write_uniform_definitions(&self, dst: &mut String) {
        for struct_type in &self.uniform_collection.struct_types {
            dst.push_str(&format!("{};\n", glu::declare_struct(struct_type, 0)));
        }

        for uniform in &self.uniform_collection.uniforms {
            dst.push_str(&format!(
                "uniform {};\n",
                glu::declare_var(&uniform.ty, &uniform.name, 0)
            ));
        }

        dst.push('\n');

        for (requiring_types, definition) in COMPARE_FUNCS {
            let sampler_types = self.uniform_collection.sampler_types();
            // ES 2.0 has one sampler return type, so upstream's ES 2.0 copy tests the
            // predicate against `vec4` directly rather than per sampler type.
            let contains_type_sampler = match self.es_version {
                EsVersion::Es2 => {
                    !sampler_types.is_empty()
                        && (requiring_types[0](DataType::FloatVec4) || requiring_types[1](DataType::FloatVec4))
                }
                EsVersion::Es3 | EsVersion::Es31 => sampler_types.iter().any(|sampler_type| {
                    let ret_type = get_sampler_lookup_return_type(*sampler_type);
                    sampler_type.is_sampler() && (requiring_types[0](ret_type) || requiring_types[1](ret_type))
                }),
            };

            if contains_type_sampler
                || self.uniform_collection.contains_matching_basic_type(requiring_types[0])
                || self.uniform_collection.contains_matching_basic_type(requiring_types[1])
            {
                dst.push_str(definition);
                dst.push('\n');
            }
        }
    }

    /// `UniformCase::writeUniformCompareExpr`
    fn write_uniform_compare_expr(&self, dst: &mut String, uniform: &BasicUniform) {
        if uniform.ty.is_sampler() {
            match self.es_version {
                EsVersion::Es2 => dst.push_str(&format!(
                    "compare_vec4({}({}, vec{}(0.0))",
                    if uniform.ty == DataType::Sampler2D {
                        "texture2D"
                    } else {
                        "textureCube"
                    },
                    uniform.name,
                    get_sampler_num_lookup_dimensions(uniform.ty)
                )),
                EsVersion::Es3 | EsVersion::Es31 => dst.push_str(&format!(
                    "compare_{}(texture({}, vec{}(0.0))",
                    get_sampler_lookup_return_type(uniform.ty).name(),
                    uniform.name,
                    get_sampler_num_lookup_dimensions(uniform.ty)
                )),
            }
        } else {
            dst.push_str(&format!("compare_{}({}", uniform.ty.name(), uniform.name));
        }

        dst.push_str(&format!(", {})", shader_var_value_str(&uniform.final_value)));
    }

    /// `UniformCase::writeUniformComparisons`
    fn write_uniform_comparisons(&self, dst: &mut String, basic_uniforms: &[BasicUniform], variable_name: &str) {
        for uniform in basic_uniforms {
            if uniform.is_used_in_shader {
                dst.push_str(&format!("\t{variable_name} *= "));
                self.write_uniform_compare_expr(dst, uniform);
                dst.push_str(";\n");
            } else {
                dst.push_str(&format!("\t// UNUSED: {}\n", uniform.name));
            }
        }
    }

    /// `UniformCase::generateVertexSource`
    fn generate_vertex_source(&self, basic_uniforms: &[BasicUniform]) -> String {
        let is_vertex_case = matches!(self.case_shader_type, CaseShaderType::Vertex | CaseShaderType::Both);
        let mut result = String::from(match self.es_version {
            EsVersion::Es2 => "attribute highp vec4 a_position;\nvarying mediump float v_vtxOut;\n\n",
            EsVersion::Es3 => "#version 300 es\nin highp vec4 a_position;\nout mediump float v_vtxOut;\n\n",
            EsVersion::Es31 => "#version 310 es\nin highp vec4 a_position;\nout mediump float v_vtxOut;\n\n",
        });

        if is_vertex_case {
            self.write_uniform_definitions(&mut result);
        }

        result.push_str("\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_vtxOut = 1.0;\n");

        if is_vertex_case {
            self.write_uniform_comparisons(&mut result, basic_uniforms, "v_vtxOut");
        }

        result.push_str("}\n");
        result
    }

    /// `UniformCase::generateFragmentSource`
    fn generate_fragment_source(&self, basic_uniforms: &[BasicUniform]) -> String {
        let is_fragment_case = matches!(self.case_shader_type, CaseShaderType::Fragment | CaseShaderType::Both);
        let mut result = String::from(match self.es_version {
            EsVersion::Es2 => "varying mediump float v_vtxOut;\n\n",
            EsVersion::Es3 => "#version 300 es\nin mediump float v_vtxOut;\n\n",
            EsVersion::Es31 => "#version 310 es\nin mediump float v_vtxOut;\n\n",
        });

        if is_fragment_case {
            self.write_uniform_definitions(&mut result);
        }

        result.push_str(match self.es_version {
            EsVersion::Es2 => "\nvoid main (void)\n{\n    mediump float result = v_vtxOut;\n",
            EsVersion::Es3 | EsVersion::Es31 => "\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n\nvoid main (void)\n{\n    mediump float result = v_vtxOut;\n",
        });

        if is_fragment_case {
            self.write_uniform_comparisons(&mut result, basic_uniforms, "result");
        }

        result.push_str(match self.es_version {
            EsVersion::Es2 => "    gl_FragColor = vec4(result, result, result, 1.0);\n}\n",
            EsVersion::Es3 => "    dEQP_FragColor = vec4(result, result, result, 1.0);\n}\n",
            // \note Green, not white: this one clears to black first, so a case that
            // never drew at all could pass a white-pixel check.
            EsVersion::Es31 => "    dEQP_FragColor = vec4(1.0-result, result, 0.0, 1.0);\n}\n",
        });
        result
    }

    /// `UniformCase::getActiveUniforms`
    fn get_active_uniforms(
        gl: &glw::Functions,
        dst: &mut Vec<BasicUniformReportGL>,
        reference: &[BasicUniformReportRef],
        program: GLuint,
    ) -> Result<bool, TestError> {
        let mut success = true;
        let mut num_active_uniforms = 0;
        let mut uniform_max_name_length = 0;

        // SAFETY: each query writes one integer, and the name buffer is sized from the
        // driver's own answer to GL_ACTIVE_UNIFORM_MAX_LENGTH.
        unsafe {
            gl.get_programiv(program, glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
            gl.get_programiv(program, glw::GL_ACTIVE_UNIFORM_MAX_LENGTH, &mut uniform_max_name_length);
        }
        glu::expect_no_error(gl, "glGetProgramiv()")?;

        let mut name_buffer = vec![0u8; uniform_max_name_length.max(1) as usize];

        for unif_ndx in 0..num_active_uniforms {
            let mut reported_name_length = 0;
            let mut reported_size = -1;
            let mut reported_type_gl = glw::GL_NONE;

            // SAFETY: as above.
            unsafe {
                gl.get_active_uniform(
                    program,
                    unif_ndx as GLuint,
                    uniform_max_name_length,
                    &mut reported_name_length,
                    &mut reported_size,
                    &mut reported_type_gl,
                    name_buffer.as_mut_ptr().cast(),
                );
            }
            glu::expect_no_error(gl, "glGetActiveUniform()")?;

            let reported_type = get_data_type_from_gl_type(reported_type_gl);
            let nul = name_buffer.iter().position(|b| *b == 0).unwrap_or(name_buffer.len());
            let reported_name = String::from_utf8_lossy(&name_buffer[..nul]).into_owned();

            if reported_type == DataType::Invalid {
                return Err(TestError::Fail("Invalid uniform type".to_string()));
            }

            if reported_name.len() as i32 != reported_name_length {
                log::warn!(
                    "// FAILURE: wrong name length reported, should be {}",
                    reported_name.len()
                );
                success = false;
            }

            if reported_name.starts_with("gl_") {
                continue; // Ignore built-in uniforms.
            }

            let Some(reference) = reference.iter().find(|entry| entry.name == reported_name) else {
                log::warn!("// FAILURE: invalid non-built-in uniform name reported: {reported_name}");
                success = false;
                continue;
            };

            if find_with_name(dst, &reported_name).is_some() {
                log::warn!("// FAILURE: same uniform name reported twice");
                success = false;
            }

            dst.push(BasicUniformReportGL {
                name: reported_name.clone(),
                name_length: reported_name_length,
                size: reported_size,
                ty: reported_type,
                index: unif_ndx,
            });

            if reported_type != reference.ty {
                log::warn!("// FAILURE: wrong type reported, should be {}", reference.ty.name());
                success = false;
            }
            if reported_size < reference.min_size || reported_size > reference.max_size {
                log::warn!(
                    "// FAILURE: wrong size reported for {reported_name}, should be in [{}, {}]",
                    reference.min_size,
                    reference.max_size
                );
                success = false;
            }
        }

        for expected in reference {
            if expected.is_used_in_shader && find_with_name(dst, &expected.name).is_none() {
                log::warn!("// FAILURE: uniform with name {} was not reported by GL", expected.name);
                success = false;
            }
        }

        Ok(success)
    }

    /// `UniformCase::getActiveUniformsiv`
    fn get_active_uniformsiv(
        &self,
        gl: &glw::Functions,
        dst: &mut Vec<BasicUniformReportGL>,
        reference: &[BasicUniformReportRef],
        program: GLuint,
    ) -> Result<bool, TestError> {
        let mut success = true;

        let query_names: Vec<CString> = reference
            .iter()
            .map(|entry| {
                let name = if self.has(FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX) && entry.name.ends_with(']') {
                    before_last(&entry.name, '[')
                } else {
                    entry.name.clone()
                };
                CString::new(name).expect("uniform name holds a nul byte")
            })
            .collect();
        let query_names_c: Vec<*const glw::GLchar> = query_names.iter().map(|name| name.as_ptr()).collect();
        let mut uniform_indices = vec![0u32; reference.len()];

        // SAFETY: the index output is sized to the name list handed in.
        unsafe {
            gl.get_uniform_indices(
                program,
                reference.len() as i32,
                query_names_c.as_ptr(),
                uniform_indices.as_mut_ptr(),
            );
        }
        glu::expect_no_error(gl, "glGetUniformIndices()")?;

        // This shall have the same contents, and in same order, as uniform_indices, but
        // with GL_INVALID_INDEX entries removed.
        let mut valid_uniform_indices = Vec::new();
        for (i, index) in uniform_indices.iter().enumerate() {
            if *index != glw::GL_INVALID_INDEX {
                valid_uniform_indices.push(*index);
            } else if reference[i].is_used_in_shader {
                log::warn!(
                    "// FAILURE: uniform with name {} received GL_INVALID_INDEX",
                    reference[i].name
                );
                success = false;
            }
        }

        if valid_uniform_indices.is_empty() {
            return Ok(success);
        }

        let count = valid_uniform_indices.len();
        let mut name_length_buf = vec![0i32; count];
        let mut size_buf = vec![0i32; count];
        let mut type_buf = vec![0i32; count];

        // SAFETY: each output buffer holds one integer per index handed in.
        unsafe {
            gl.get_active_uniformsiv(
                program,
                count as i32,
                valid_uniform_indices.as_ptr(),
                glw::GL_UNIFORM_NAME_LENGTH,
                name_length_buf.as_mut_ptr(),
            );
            gl.get_active_uniformsiv(
                program,
                count as i32,
                valid_uniform_indices.as_ptr(),
                glw::GL_UNIFORM_SIZE,
                size_buf.as_mut_ptr(),
            );
            gl.get_active_uniformsiv(
                program,
                count as i32,
                valid_uniform_indices.as_ptr(),
                glw::GL_UNIFORM_TYPE,
                type_buf.as_mut_ptr(),
            );
        }
        glu::expect_no_error(gl, "glGetActiveUniformsiv()")?;

        // Keeps the corresponding index to valid_uniform_indices while unif_ndx is the
        // index to uniform_indices.
        let mut valid_ndx = 0;
        for (unif_ndx, index) in uniform_indices.iter().enumerate() {
            if *index == glw::GL_INVALID_INDEX {
                continue;
            }

            let reference = &reference[unif_ndx];
            let reported_index = valid_uniform_indices[valid_ndx] as i32;
            let reported_name_length = name_length_buf[valid_ndx];
            let reported_size = size_buf[valid_ndx];
            let reported_type = get_data_type_from_gl_type(type_buf[valid_ndx] as GLenum);
            valid_ndx += 1;

            if reported_type == DataType::Invalid {
                return Err(TestError::Fail("Invalid uniform type".to_string()));
            }

            dst.push(BasicUniformReportGL {
                name: reference.name.clone(),
                name_length: reported_name_length,
                size: reported_size,
                ty: reported_type,
                index: reported_index,
            });

            if reported_name_length != reference.name.len() as i32 + 1 {
                log::warn!(
                    "// FAILURE: wrong name length reported, should be {}",
                    reference.name.len() + 1
                );
                success = false;
            }
            if reported_type != reference.ty {
                log::warn!("// FAILURE: wrong type reported, should be {}", reference.ty.name());
                success = false;
            }
            if reported_size < reference.min_size || reported_size > reference.max_size {
                log::warn!(
                    "// FAILURE: wrong size reported for {}, should be in [{}, {}]",
                    reference.name,
                    reference.min_size,
                    reference.max_size
                );
                success = false;
            }
        }

        Ok(success)
    }

    /// `UniformCase::uniformVsUniformsivComparison`
    fn uniform_vs_uniformsiv_comparison(
        uniform_results: &[BasicUniformReportGL],
        uniformsiv_results: &[BasicUniformReportGL],
    ) -> bool {
        let mut success = true;

        for uniform_result in uniform_results {
            let Some(uniformsiv_result) = find_with_name(uniformsiv_results, &uniform_result.name) else {
                log::warn!(
                    "// FAILURE: uniform {} was reported active by glGetActiveUniform() but not by glGetUniformIndices()",
                    uniform_result.name
                );
                success = false;
                continue;
            };

            if uniform_result.index != uniformsiv_result.index {
                log::warn!(
                    "// FAILURE: glGetActiveUniform() and glGetUniformIndices() gave different indices for uniform {}",
                    uniform_result.name
                );
                success = false;
            }
            if uniform_result.name_length + 1 != uniformsiv_result.name_length {
                log::warn!(
                    "// FAILURE: glGetActiveUniform() and glGetActiveUniformsiv() gave incompatible name lengths for uniform {}",
                    uniform_result.name
                );
                success = false;
            }
            if uniform_result.size != uniformsiv_result.size {
                log::warn!(
                    "// FAILURE: glGetActiveUniform() and glGetActiveUniformsiv() gave different sizes for uniform {}",
                    uniform_result.name
                );
                success = false;
            }
            if uniform_result.ty != uniformsiv_result.ty {
                log::warn!(
                    "// FAILURE: glGetActiveUniform() and glGetActiveUniformsiv() gave different types for uniform {}",
                    uniform_result.name
                );
                success = false;
            }
        }

        // \note Upstream searches `uniformsivResults` on both sides of this second loop,
        // so it can never fire. Kept as it is, because changing it would change a verdict.
        success
    }

    /// `UniformCase::getUniforms`
    fn get_uniforms(
        &self,
        gl: &glw::Functions,
        basic_uniforms: &[BasicUniform],
        program: GLuint,
    ) -> Result<(Vec<VarValue>, bool), TestError> {
        let mut values = Vec::with_capacity(basic_uniforms.len());
        let mut success = true;

        for uniform in basic_uniforms {
            let query_name = if self.has(FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX) && uniform.elem_ndx == 0 {
                before_last(&uniform.name, '[')
            } else {
                uniform.name.clone()
            };
            let query_name_c = CString::new(query_name).expect("uniform name holds a nul byte");
            // SAFETY: the name is nul-terminated and the program is this case's own.
            let location = unsafe { gl.get_uniform_location(program, query_name_c.as_ptr()) };
            let size = uniform.ty.scalar_size() as usize;

            if location == -1 {
                values.push(VarValue::new(DataType::Invalid));
                if uniform.is_used_in_shader {
                    log::warn!("// FAILURE: {} was used in shader, but has location -1", uniform.name);
                    success = false;
                }
                continue;
            }

            let mut value = VarValue::new(uniform.ty);

            // SAFETY: every destination below holds at least `size` components, which is
            // what the uniform's own type says the driver writes.
            unsafe {
                if uniform.ty.is_float_or_vec() || uniform.ty.is_matrix() {
                    gl.get_uniformfv(program, location, value.float_v.as_mut_ptr());
                } else if uniform.ty.is_int_or_ivec() {
                    gl.get_uniformiv(program, location, value.int_v.as_mut_ptr());
                } else if uniform.ty.is_uint_or_uvec() {
                    gl.get_uniformuiv(program, location, value.uint_v.as_mut_ptr());
                } else if uniform.ty.is_bool_or_bvec() {
                    if self.has(FEATURE_BOOLEANAPITYPE_INT) {
                        gl.get_uniformiv(program, location, value.int_v.as_mut_ptr());
                        for i in 0..size {
                            value.bool_v[i] = value.int_v[i] != 0;
                        }
                    } else if self.has(FEATURE_BOOLEANAPITYPE_UINT) {
                        gl.get_uniformuiv(program, location, value.uint_v.as_mut_ptr());
                        for i in 0..size {
                            value.bool_v[i] = value.uint_v[i] != 0;
                        }
                    } else {
                        // Default: use float.
                        gl.get_uniformfv(program, location, value.float_v.as_mut_ptr());
                        for i in 0..size {
                            value.bool_v[i] = value.float_v[i] != 0.0;
                        }
                    }
                } else {
                    debug_assert!(uniform.ty.is_sampler());
                    let mut unit = -1;
                    gl.get_uniformiv(program, location, &mut unit);
                    value.sampler_unit = unit;
                }
            }
            glu::expect_no_error(gl, "glGetUniform*()")?;

            values.push(value);
        }

        Ok((values, success))
    }

    /// `UniformCase::checkUniformDefaultValues`
    fn check_uniform_default_values(values: &[VarValue], basic_uniforms: &[BasicUniform]) -> bool {
        let mut success = true;

        for (uniform, value) in basic_uniforms.iter().zip(values) {
            if value.ty == DataType::Invalid {
                continue; // This happens when glGetUniformLocation() returned -1.
            }

            let size = uniform.ty.scalar_size() as usize;
            let is_zero = if uniform.ty.is_float_or_vec() || uniform.ty.is_matrix() {
                value.float_v[..size].iter().all(|v| *v == 0.0)
            } else if uniform.ty.is_int_or_ivec() {
                value.int_v[..size].iter().all(|v| *v == 0)
            } else if uniform.ty.is_uint_or_uvec() {
                value.uint_v[..size].iter().all(|v| *v == 0)
            } else if uniform.ty.is_bool_or_bvec() {
                value.bool_v[..size].iter().all(|v| !*v)
            } else {
                value.sampler_unit == 0
            };

            if !is_zero {
                log::warn!("// FAILURE: uniform {} has non-zero initial value", uniform.name);
                success = false;
            }
        }

        success
    }

    /// `UniformCase::assignUniforms`
    #[allow(clippy::too_many_lines)]
    fn assign_uniforms(
        &self,
        gl: &glw::Functions,
        basic_uniforms: &[BasicUniform],
        program: GLuint,
        rnd: &mut Random,
    ) -> Result<(), TestError> {
        // `glProgramUniform*` names the program; `glUniform*` uses the current one.
        // Upstream's ES 3.1 copy exists precisely to check that a driver does not
        // confuse the two, so this cannot collapse into one path.
        let program_uniform_target = (self.es_version == EsVersion::Es31).then_some(program);
        let transpose = self.has(FEATURE_MATRIXMODE_ROWMAJOR);
        let transpose_gl = if transpose { glw::TRUE } else { glw::FALSE };
        let bool_api_type = if self.has(FEATURE_BOOLEANAPITYPE_INT) {
            DataType::Int
        } else if self.has(FEATURE_BOOLEANAPITYPE_UINT) {
            DataType::Uint
        } else {
            DataType::Float
        };

        for uniform in basic_uniforms {
            let is_array_member = uniform.elem_ndx >= 0;
            let query_name = if self.has(FEATURE_ARRAY_FIRST_ELEM_NAME_NO_INDEX) && uniform.elem_ndx == 0 {
                before_last(&uniform.name, '[')
            } else {
                uniform.name.clone()
            };
            let num_values_to_assign = if !is_array_member {
                1
            } else if self.has(FEATURE_ARRAYASSIGN_FULL) {
                if uniform.elem_ndx == 0 { uniform.root_size } else { 0 }
            } else if self.has(FEATURE_ARRAYASSIGN_BLOCKS_OF_TWO) {
                if uniform.elem_ndx % 2 == 0 { 2 } else { 0 }
            } else {
                // Default: assign array elements separately.
                1
            };

            if num_values_to_assign == 0 {
                continue; // Covered by another glUniform*v() call to the same array.
            }

            let query_name_c = CString::new(query_name).expect("uniform name holds a nul byte");
            // SAFETY: the name is nul-terminated and the program is this case's own.
            let location = unsafe { gl.get_uniform_location(program, query_name_c.as_ptr()) };
            let type_size = uniform.ty.scalar_size() as usize;
            let assign_by_value =
                self.has(FEATURE_UNIFORMFUNC_VALUE) && !uniform.ty.is_matrix() && num_values_to_assign == 1;
            let mut values_to_assign: Vec<VarValue> = Vec::new();

            for i in 0..num_values_to_assign {
                let unif_value = if is_array_member {
                    let cur_name = format!("{}[{}]", before_last(&uniform.root_name, '['), uniform.elem_ndx + i);
                    match basic_uniforms.iter().find(|entry| entry.name == cur_name) {
                        Some(elem_unif) => elem_unif.final_value,
                        None => continue,
                    }
                } else {
                    uniform.final_value
                };

                let api_value = if unif_value.ty.is_bool_or_bvec() {
                    get_random_bool_representation(&unif_value, bool_api_type, rnd)
                } else if unif_value.ty.is_sampler() {
                    get_sampler_unit_value(&unif_value)
                } else {
                    unif_value
                };

                values_to_assign.push(if api_value.ty.is_matrix() && transpose {
                    get_transpose_matrix(&api_value)
                } else {
                    api_value
                });
            }

            debug_assert!(!values_to_assign.is_empty());
            let count = values_to_assign.len() as i32;
            let first = &values_to_assign[0];

            /// `glUniform*` or `glProgramUniform*`, as `program_uniform_target` says.
            macro_rules! set {
                ($plain:ident, $prog:ident, $($arg:expr),*) => {
                    match program_uniform_target {
                        Some(target) => gl.$prog(target, location, $($arg),*),
                        None => gl.$plain(location, $($arg),*),
                    }
                };
            }

            // SAFETY: every buffer below holds `count * type_size` components, which is
            // exactly what the matching glUniform* entry point reads.
            unsafe {
                if first.ty.is_float_or_vec() {
                    if assign_by_value {
                        let p = &first.float_v;
                        match type_size {
                            1 => set!(uniform_1f, program_uniform_1f, p[0]),
                            2 => set!(uniform_2f, program_uniform_2f, p[0], p[1]),
                            3 => set!(uniform_3f, program_uniform_3f, p[0], p[1], p[2]),
                            _ => set!(uniform_4f, program_uniform_4f, p[0], p[1], p[2], p[3]),
                        }
                    } else {
                        let buffer: Vec<f32> = (0..values_to_assign.len() * type_size)
                            .map(|i| values_to_assign[i / type_size].float_v[i % type_size])
                            .collect();
                        match type_size {
                            1 => set!(uniform_1fv, program_uniform_1fv, count, buffer.as_ptr()),
                            2 => set!(uniform_2fv, program_uniform_2fv, count, buffer.as_ptr()),
                            3 => set!(uniform_3fv, program_uniform_3fv, count, buffer.as_ptr()),
                            _ => set!(uniform_4fv, program_uniform_4fv, count, buffer.as_ptr()),
                        }
                    }
                } else if first.ty.is_matrix() {
                    debug_assert!(!assign_by_value);
                    let buffer: Vec<f32> = (0..values_to_assign.len() * type_size)
                        .map(|i| values_to_assign[i / type_size].float_v[i % type_size])
                        .collect();
                    let p = buffer.as_ptr();
                    match uniform.ty {
                        DataType::FloatMat2 => {
                            set!(uniform_matrix_2fv, program_uniform_matrix_2fv, count, transpose_gl, p)
                        }
                        DataType::FloatMat3 => {
                            set!(uniform_matrix_3fv, program_uniform_matrix_3fv, count, transpose_gl, p)
                        }
                        DataType::FloatMat4 => {
                            set!(uniform_matrix_4fv, program_uniform_matrix_4fv, count, transpose_gl, p)
                        }
                        DataType::FloatMat2x3 => set!(
                            uniform_matrix_2x_3fv,
                            program_uniform_matrix_2x_3fv,
                            count,
                            transpose_gl,
                            p
                        ),
                        DataType::FloatMat2x4 => set!(
                            uniform_matrix_2x_4fv,
                            program_uniform_matrix_2x_4fv,
                            count,
                            transpose_gl,
                            p
                        ),
                        DataType::FloatMat3x2 => set!(
                            uniform_matrix_3x_2fv,
                            program_uniform_matrix_3x_2fv,
                            count,
                            transpose_gl,
                            p
                        ),
                        DataType::FloatMat3x4 => set!(
                            uniform_matrix_3x_4fv,
                            program_uniform_matrix_3x_4fv,
                            count,
                            transpose_gl,
                            p
                        ),
                        DataType::FloatMat4x2 => set!(
                            uniform_matrix_4x_2fv,
                            program_uniform_matrix_4x_2fv,
                            count,
                            transpose_gl,
                            p
                        ),
                        _ => set!(
                            uniform_matrix_4x_3fv,
                            program_uniform_matrix_4x_3fv,
                            count,
                            transpose_gl,
                            p
                        ),
                    }
                } else if first.ty.is_int_or_ivec() {
                    if assign_by_value {
                        let p = &first.int_v;
                        match type_size {
                            1 => set!(uniform_1i, program_uniform_1i, p[0]),
                            2 => set!(uniform_2i, program_uniform_2i, p[0], p[1]),
                            3 => set!(uniform_3i, program_uniform_3i, p[0], p[1], p[2]),
                            _ => set!(uniform_4i, program_uniform_4i, p[0], p[1], p[2], p[3]),
                        }
                    } else {
                        let buffer: Vec<i32> = (0..values_to_assign.len() * type_size)
                            .map(|i| values_to_assign[i / type_size].int_v[i % type_size])
                            .collect();
                        match type_size {
                            1 => set!(uniform_1iv, program_uniform_1iv, count, buffer.as_ptr()),
                            2 => set!(uniform_2iv, program_uniform_2iv, count, buffer.as_ptr()),
                            3 => set!(uniform_3iv, program_uniform_3iv, count, buffer.as_ptr()),
                            _ => set!(uniform_4iv, program_uniform_4iv, count, buffer.as_ptr()),
                        }
                    }
                } else if first.ty.is_uint_or_uvec() {
                    if assign_by_value {
                        let p = &first.uint_v;
                        match type_size {
                            1 => set!(uniform_1ui, program_uniform_1ui, p[0]),
                            2 => set!(uniform_2ui, program_uniform_2ui, p[0], p[1]),
                            3 => set!(uniform_3ui, program_uniform_3ui, p[0], p[1], p[2]),
                            _ => set!(uniform_4ui, program_uniform_4ui, p[0], p[1], p[2], p[3]),
                        }
                    } else {
                        // \note Upstream spells this `intV`, but its `VarValue` is a
                        // union - `intV` and `uintV` are the same bits there. This
                        // struct keeps them apart, so it has to name the one the value
                        // was actually written to.
                        let buffer: Vec<u32> = (0..values_to_assign.len() * type_size)
                            .map(|i| values_to_assign[i / type_size].uint_v[i % type_size])
                            .collect();
                        match type_size {
                            1 => set!(uniform_1uiv, program_uniform_1uiv, count, buffer.as_ptr()),
                            2 => set!(uniform_2uiv, program_uniform_2uiv, count, buffer.as_ptr()),
                            3 => set!(uniform_3uiv, program_uniform_3uiv, count, buffer.as_ptr()),
                            _ => set!(uniform_4uiv, program_uniform_4uiv, count, buffer.as_ptr()),
                        }
                    }
                } else {
                    debug_assert!(first.ty.is_sampler());
                    let unit = uniform.final_value.sampler_unit;
                    if assign_by_value {
                        set!(uniform_1i, program_uniform_1i, unit);
                    } else {
                        set!(uniform_1iv, program_uniform_1iv, count, &unit);
                    }
                }
            }
            glu::expect_no_error(gl, "glUniform*()")?;
        }

        Ok(())
    }

    /// `UniformCase::compareUniformValues`
    fn compare_uniform_values(values: &[VarValue], basic_uniforms: &[BasicUniform]) -> bool {
        let mut success = true;

        for (uniform, value) in basic_uniforms.iter().zip(values) {
            if value.ty == DataType::Invalid {
                continue; // This happens when glGetUniformLocation() returned -1.
            }

            if !api_var_value_equals(value, &uniform.final_value) {
                log::warn!(
                    "// FAILURE: value obtained with glGetUniform*() for uniform {} differs from value set with glUniform*()",
                    uniform.name
                );
                success = false;
            }
        }

        success
    }

    /// `UniformCase::renderTest`
    fn render_test(
        context: &Context,
        es_version: EsVersion,
        basic_uniforms: &[BasicUniform],
        program: &ShaderProgram<'_>,
        textures: &mut TextureSet<'_>,
        rnd: &mut Random,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_w = render_target.width.min(MAX_RENDER_WIDTH);
        let viewport_h = render_target.height.min(MAX_RENDER_HEIGHT);
        let viewport_x = rnd.get_int(0, render_target.width - viewport_w);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_h);
        let mut rendered_img = Surface::new(viewport_w, viewport_h);

        for uniform in basic_uniforms {
            if uniform.ty.is_sampler()
                && !textures
                    .filled_texture_units
                    .contains(&uniform.final_value.sampler_unit)
            {
                textures.setup(&uniform.final_value)?;
            }
        }

        #[rustfmt::skip]
        const POSITION: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0,
            -1.0,  1.0, 0.0, 1.0,
             1.0, -1.0, 0.0, 1.0,
             1.0,  1.0, 0.0, 1.0,
        ];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: both client arrays outlive the draw, and `a_position` is declared by
        // every generated vertex shader.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);

            if es_version == EsVersion::Es31 {
                // The real program has not been current until now - that is the whole
                // point of the ES 3.1 copy of this case.
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.use_program(program.program());
            }

            let pos_loc = gl.get_attrib_location(program.program(), c"a_position".as_ptr());
            gl.enable_vertex_attrib_array(pos_loc as GLuint);
            gl.vertex_attrib_pointer(
                pos_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                POSITION.as_ptr().cast(),
            );
            gl.draw_elements(
                glw::GL_TRIANGLES,
                INDICES.len() as i32,
                glw::GL_UNSIGNED_SHORT,
                INDICES.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "glDrawElements()")?;
            gl.disable_vertex_attrib_array(pos_loc as GLuint);
        }

        glu::read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        )?;

        let mut num_failed_pixels = 0;
        for y in 0..viewport_h {
            for x in 0..viewport_w {
                let expected = if es_version == EsVersion::Es31 { GREEN } else { WHITE };
                if rendered_img.get_pixel(x, y) != expected {
                    num_failed_pixels += 1;
                }
            }
        }

        if num_failed_pixels > 0 {
            log::warn!("FAILURE: image comparison failed, got {num_failed_pixels} mismatching pixels");
            return Ok(false);
        }

        Ok(true)
    }
}

impl TestCase for UniformCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The texture-unit part of `UniformCase::init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let gl = context.gl();
        let get = |name: GLenum| {
            let mut value = -1;
            // SAFETY: each name below returns a single integer.
            unsafe { gl.get_integerv(name, &mut value) };
            value
        };

        let num_sampler_uniforms = self.uniform_collection.num_samplers();
        let vertex_required = if self.case_shader_type == CaseShaderType::Fragment {
            0
        } else {
            num_sampler_uniforms
        };
        let fragment_required = if self.case_shader_type == CaseShaderType::Vertex {
            0
        } else {
            num_sampler_uniforms
        };
        let combined_required = vertex_required + fragment_required;

        let vertex_supported = get(glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS);
        let fragment_supported = get(glw::GL_MAX_TEXTURE_IMAGE_UNITS);
        let combined_supported = get(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS);

        if vertex_required > vertex_supported {
            return Err(TestError::NotSupported(format!(
                "{vertex_required} vertex texture units required, {vertex_supported} supported"
            )));
        }
        if fragment_required > fragment_supported {
            return Err(TestError::NotSupported(format!(
                "{fragment_required} fragment texture units required, {fragment_supported} supported"
            )));
        }
        if combined_required > combined_supported {
            return Err(TestError::NotSupported(format!(
                "{combined_required} combined texture units required, {combined_supported} supported"
            )));
        }

        Ok(())
    }

    /// `UniformCase::iterate`, with each subclass's `test()` inlined into the match.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));
        let mut basic_uniforms = Vec::new();
        let mut basic_uniform_reports_ref = Vec::new();

        {
            let mut sampler_unit_counter = 0;
            for uniform in &self.uniform_collection.uniforms {
                self.generate_basic_uniforms(
                    &mut basic_uniforms,
                    &mut basic_uniform_reports_ref,
                    &uniform.ty,
                    &uniform.name,
                    true,
                    &mut sampler_unit_counter,
                    &mut rnd,
                );
            }
        }

        let vertex_source = self.generate_vertex_source(&basic_uniforms);
        let fragment_source = self.generate_fragment_source(&basic_uniforms);
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_source, fragment_source));

        if !program.is_ok() {
            return Ok(TestStatus::fail("Compile failed"));
        }

        // An unused program that we'll give to glUseProgram before we actually need the
        // real program above, to see if an implementation tries to use the currently
        // active program for something inappropriate (instead of the program given as
        // argument to, say, glProgramUniform*).
        let unused_program = (self.es_version == EsVersion::Es31).then(|| {
            ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    "#version 310 es\nvoid main (void) { gl_Position = vec4(1.0); }\n",
                    "#version 310 es\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\nvoid main (void) { dEQP_FragColor = vec4(0.0, 0.0, 1.0, 1.0); }\n",
                ),
            )
        });

        if let Some(unused_program) = &unused_program
            && !unused_program.is_ok()
        {
            return Ok(TestStatus::fail("Compilation of unused program failed"));
        }

        // SAFETY: both programs are this case's own and linked.
        unsafe {
            gl.use_program(match &unused_program {
                Some(unused_program) => unused_program.program(),
                None => program.program(),
            });
        }
        glu::expect_no_error(gl, "glUseProgram()")?;

        let mut textures = TextureSet::new(gl);
        let program_gl = program.program();

        let success = match self.kind {
            CaseKind::InfoQuery(case_type) => {
                let mut reports_uniform = Vec::new();
                let mut reports_uniformsiv = Vec::new();
                let mut success = true;

                if matches!(case_type, InfoQueryType::Uniform | InfoQueryType::Consistency) {
                    let ok =
                        Self::get_active_uniforms(gl, &mut reports_uniform, &basic_uniform_reports_ref, program_gl)?;
                    if !ok && case_type == InfoQueryType::Uniform {
                        success = false;
                    }
                }

                if success && matches!(case_type, InfoQueryType::IndicesUniformsiv | InfoQueryType::Consistency) {
                    let ok = self.get_active_uniformsiv(
                        gl,
                        &mut reports_uniformsiv,
                        &basic_uniform_reports_ref,
                        program_gl,
                    )?;
                    if !ok && case_type == InfoQueryType::IndicesUniformsiv {
                        success = false;
                    }
                }

                if success && case_type == InfoQueryType::Consistency {
                    success = Self::uniform_vs_uniformsiv_comparison(&reports_uniform, &reports_uniformsiv);
                }

                success
            }
            CaseKind::Value(value_to_check, check_method) => {
                if value_to_check == ValueToCheck::Assigned {
                    self.assign_uniforms(gl, &basic_uniforms, program_gl, &mut rnd)?;
                }

                if check_method == CheckMethod::GetUniform {
                    let (values, success) = self.get_uniforms(gl, &basic_uniforms, program_gl)?;
                    if !success {
                        false
                    } else if value_to_check == ValueToCheck::Assigned {
                        Self::compare_uniform_values(&values, &basic_uniforms)
                    } else {
                        Self::check_uniform_default_values(&values, &basic_uniforms)
                    }
                } else {
                    Self::render_test(
                        context,
                        self.es_version,
                        &basic_uniforms,
                        &program,
                        &mut textures,
                        &mut rnd,
                    )?
                }
            }
            CaseKind::Random => self.run_random(
                context,
                &basic_uniforms,
                &basic_uniform_reports_ref,
                &program,
                &mut textures,
                &mut rnd,
            )?,
        };

        Ok(if success {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        })
    }
}

impl UniformCase {
    /// `RandomUniformCase::test`
    #[allow(clippy::too_many_arguments, clippy::needless_bool)]
    fn run_random(
        &self,
        context: &Context,
        basic_uniforms: &[BasicUniform],
        basic_uniform_reports_ref: &[BasicUniformReportRef],
        program: &ShaderProgram<'_>,
        textures: &mut TextureSet<'_>,
        rnd: &mut Random,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let program_gl = program.program();

        // \note Different sampler types may not be bound to same unit when rendering.
        let rendering_possible =
            !self.has(FEATURE_UNIFORMVALUE_ZERO) || !self.uniform_collection.contains_several_sampler_types();

        // \note The ES 2.0 copy has no `glGetUniformIndices`/`glGetActiveUniformsiv`,
        // so it draws neither of those two bools - and the draw order decides every
        // later one, so this cannot be a post-hoc filter.
        let es3 = self.es_version != EsVersion::Es2;
        let mut perform_get_active_uniforms = rnd.get_bool();
        let perform_get_active_uniformsiv = es3 && rnd.get_bool();
        let perform_uniform_vs_uniformsiv_comparison =
            es3 && perform_get_active_uniforms && perform_get_active_uniformsiv && rnd.get_bool();
        let perform_get_uniforms = rnd.get_bool();
        let perform_check_uniform_default_values = perform_get_uniforms && rnd.get_bool();
        let perform_assign_uniforms = rnd.get_bool();
        let perform_compare_uniform_values = perform_get_uniforms && perform_assign_uniforms && rnd.get_bool();
        let perform_render_test = rendering_possible && perform_assign_uniforms && rnd.get_bool();

        if !(perform_get_active_uniforms
            || perform_get_active_uniformsiv
            || perform_uniform_vs_uniformsiv_comparison
            || perform_get_uniforms
            || perform_check_uniform_default_values
            || perform_assign_uniforms
            || perform_compare_uniform_values
            || perform_render_test)
        {
            perform_get_active_uniforms = true; // Do something at least.
        }

        {
            let mut reports_uniform = Vec::new();
            let mut reports_uniformsiv = Vec::new();

            if perform_get_active_uniforms
                && !Self::get_active_uniforms(gl, &mut reports_uniform, basic_uniform_reports_ref, program_gl)?
            {
                return Ok(false);
            }
            if perform_get_active_uniformsiv
                && !self.get_active_uniformsiv(gl, &mut reports_uniformsiv, basic_uniform_reports_ref, program_gl)?
            {
                return Ok(false);
            }
            if perform_uniform_vs_uniformsiv_comparison
                && !Self::uniform_vs_uniformsiv_comparison(&reports_uniform, &reports_uniformsiv)
            {
                return Ok(false);
            }
        }

        {
            let mut uniform_default_values = Vec::new();

            if perform_get_uniforms {
                let (values, success) = self.get_uniforms(gl, basic_uniforms, program_gl)?;
                if !success {
                    return Ok(false);
                }
                uniform_default_values = values;
            }
            if perform_check_uniform_default_values
                && !Self::check_uniform_default_values(&uniform_default_values, basic_uniforms)
            {
                return Ok(false);
            }
        }

        if perform_assign_uniforms {
            self.assign_uniforms(gl, basic_uniforms, program_gl, rnd)?;
        }
        if perform_compare_uniform_values {
            let (values, success) = self.get_uniforms(gl, basic_uniforms, program_gl)?;
            if !success || !Self::compare_uniform_values(&values, basic_uniforms) {
                return Ok(false);
            }
        }

        if perform_render_test && !Self::render_test(context, self.es_version, basic_uniforms, program, textures, rnd)?
        {
            return Ok(false);
        }

        Ok(true)
    }
}

/// `writeUniformDefinitions`'s `compareFuncs` table.
const COMPARE_FUNCS: [([DataTypePredicate; 2], &str); 26] = [
    (
        [is_float_or_vec, is_matrix],
        "mediump float compare_float    (mediump float a, mediump float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }",
    ),
    (
        [is_float_vec2, is_matrix_with_2_rows],
        "mediump float compare_vec2     (mediump vec2 a, mediump vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }",
    ),
    (
        [is_float_vec3, is_matrix_with_3_rows],
        "mediump float compare_vec3     (mediump vec3 a, mediump vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }",
    ),
    (
        [is_float_vec4, is_matrix_with_4_rows],
        "mediump float compare_vec4     (mediump vec4 a, mediump vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }",
    ),
    (
        [is_float_mat2, never],
        "mediump float compare_mat2     (mediump mat2 a, mediump mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }",
    ),
    (
        [is_float_mat2x3, never],
        "mediump float compare_mat2x3   (mediump mat2x3 a, mediump mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }",
    ),
    (
        [is_float_mat2x4, never],
        "mediump float compare_mat2x4   (mediump mat2x4 a, mediump mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }",
    ),
    (
        [is_float_mat3x2, never],
        "mediump float compare_mat3x2   (mediump mat3x2 a, mediump mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }",
    ),
    (
        [is_float_mat3, never],
        "mediump float compare_mat3     (mediump mat3 a, mediump mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }",
    ),
    (
        [is_float_mat3x4, never],
        "mediump float compare_mat3x4   (mediump mat3x4 a, mediump mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }",
    ),
    (
        [is_float_mat4x2, never],
        "mediump float compare_mat4x2   (mediump mat4x2 a, mediump mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }",
    ),
    (
        [is_float_mat4x3, never],
        "mediump float compare_mat4x3   (mediump mat4x3 a, mediump mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }",
    ),
    (
        [is_float_mat4, never],
        "mediump float compare_mat4     (mediump mat4 a, mediump mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }",
    ),
    (
        [is_int, never],
        "mediump float compare_int      (mediump int a, mediump int b)      { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_int_vec2, never],
        "mediump float compare_ivec2    (mediump ivec2 a, mediump ivec2 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_int_vec3, never],
        "mediump float compare_ivec3    (mediump ivec3 a, mediump ivec3 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_int_vec4, never],
        "mediump float compare_ivec4    (mediump ivec4 a, mediump ivec4 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_uint, never],
        "mediump float compare_uint     (mediump uint a, mediump uint b)    { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_uint_vec2, never],
        "mediump float compare_uvec2    (mediump uvec2 a, mediump uvec2 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_uint_vec3, never],
        "mediump float compare_uvec3    (mediump uvec3 a, mediump uvec3 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_uint_vec4, never],
        "mediump float compare_uvec4    (mediump uvec4 a, mediump uvec4 b)  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_bool, never],
        "mediump float compare_bool     (bool a, bool b)                    { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_bool_vec2, never],
        "mediump float compare_bvec2    (bvec2 a, bvec2 b)                  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_bool_vec3, never],
        "mediump float compare_bvec3    (bvec3 a, bvec3 b)                  { return a == b ? 1.0 : 0.0; }",
    ),
    (
        [is_bool_vec4, never],
        "mediump float compare_bvec4    (bvec4 a, bvec4 b)                  { return a == b ? 1.0 : 0.0; }",
    ),
    // \note Upstream's table ends at bvec4; this entry keeps the array length honest
    // without adding a definition, since `never` matches nothing.
    ([never, never], ""),
];

macro_rules! type_predicate {
    ($name:ident, $variant:ident) => {
        fn $name(t: DataType) -> bool {
            t == DataType::$variant
        }
    };
}

type_predicate!(is_float_vec2, FloatVec2);
type_predicate!(is_float_vec3, FloatVec3);
type_predicate!(is_float_vec4, FloatVec4);
type_predicate!(is_float_mat2, FloatMat2);
type_predicate!(is_float_mat2x3, FloatMat2x3);
type_predicate!(is_float_mat2x4, FloatMat2x4);
type_predicate!(is_float_mat3x2, FloatMat3x2);
type_predicate!(is_float_mat3, FloatMat3);
type_predicate!(is_float_mat3x4, FloatMat3x4);
type_predicate!(is_float_mat4x2, FloatMat4x2);
type_predicate!(is_float_mat4x3, FloatMat4x3);
type_predicate!(is_float_mat4, FloatMat4);
type_predicate!(is_int, Int);
type_predicate!(is_int_vec2, IntVec2);
type_predicate!(is_int_vec3, IntVec3);
type_predicate!(is_int_vec4, IntVec4);
type_predicate!(is_uint, Uint);
type_predicate!(is_uint_vec2, UintVec2);
type_predicate!(is_uint_vec3, UintVec3);
type_predicate!(is_uint_vec4, UintVec4);
type_predicate!(is_bool, Bool);
type_predicate!(is_bool_vec2, BoolVec2);
type_predicate!(is_bool_vec3, BoolVec3);
type_predicate!(is_bool_vec4, BoolVec4);

/// `dataTypeIsMatrixWithNRows<N>`
fn is_matrix_with_2_rows(t: DataType) -> bool {
    t.is_matrix() && t.matrix_num_rows() == 2
}
fn is_matrix_with_3_rows(t: DataType) -> bool {
    t.is_matrix() && t.matrix_num_rows() == 3
}
fn is_matrix_with_4_rows(t: DataType) -> bool {
    t.is_matrix() && t.matrix_num_rows() == 4
}

/// The `booleanTypeI` triple both value groups spell out.
pub(crate) fn bool_api_variation(boolean_type_i: i32) -> (u32, &'static str) {
    match boolean_type_i {
        1 => (FEATURE_BOOLEANAPITYPE_INT, "int"),
        2 => (FEATURE_BOOLEANAPITYPE_UINT, "uint"),
        _ => (0, "float"),
    }
}
