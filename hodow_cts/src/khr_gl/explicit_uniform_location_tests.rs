// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cExplicitUniformLocationTest.cpp
//   external/openglcts/modules/gles31/es31cExplicitUniformLocationTest.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop `ExplicitUniformLocationGLTests` group is ported (all 48 cases, subroutines included): the `#version 430 core` shader header is the only one generated, the ES31 group is not registered anywhere in this tree. The test classes become functions over a `Base` that holds the value generator and struct counter each class instance owns upstream; `Loc` and `Index` share one `LayoutSpecifier` type that streams its own keyword. `std::set`/`std::map` become `HashSet`/`BTreeMap`; the kernel-source and image logging of upstream's `Logger` is reduced to log lines.

use std::collections::{BTreeMap, HashSet};
use std::ffi::{CString, c_void};

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals or buffers of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

macro_rules! put {
    ($out:expr, $($arg:tt)*) => {
        $out.push_str(&format!($($arg)*))
    };
}

fn cstr(text: &str) -> CString {
    CString::new(text).expect("names and shader sources have no NUL")
}

/// `std::ostream << float` (`%g`, six significant digits)
fn format_g(value: f32) -> String {
    if value == 0.0 {
        return "0".to_string();
    }
    let value = f64::from(value);
    let scientific = format!("{value:.5e}");
    let (mantissa, exponent) = scientific.split_once('e').expect("scientific notation has an exponent");
    let exponent: i32 = exponent.parse().expect("exponent is an integer");
    if !(-4..6).contains(&exponent) {
        let mantissa = if mantissa.contains('.') {
            mantissa.trim_end_matches('0').trim_end_matches('.')
        } else {
            mantissa
        };
        return format!(
            "{mantissa}e{}{:02}",
            if exponent < 0 { '-' } else { '+' },
            exponent.abs()
        );
    }
    let fixed = format!("{:.*}", (5 - exponent) as usize, value);
    if fixed.contains('.') {
        fixed.trim_end_matches('0').trim_end_matches('.').to_string()
    } else {
        fixed
    }
}

#[derive(Clone, Copy)]
enum DefOccurence {
    AllSh,
    Vsh,
    FshOrCsh,
    AllButFsh,
    AllButVsh,
    NoneSh,
}

impl DefOccurence {
    fn occurs(self, shader: GLenum) -> bool {
        match self {
            Self::NoneSh => false,
            Self::AllSh => true,
            Self::FshOrCsh => shader == glw::GL_FRAGMENT_SHADER || shader == glw::GL_COMPUTE_SHADER,
            Self::Vsh => shader == glw::GL_VERTEX_SHADER,
            Self::AllButFsh => shader != glw::GL_FRAGMENT_SHADER,
            Self::AllButVsh => shader != glw::GL_VERTEX_SHADER,
        }
    }
}

#[derive(Clone, Copy, PartialEq)]
enum NumSys {
    Dec,
    Oct,
    Hex,
}

/// `LayoutSpecifier<LocationSpecifier>` and `LayoutSpecifier<IndexSpecifier>`
#[derive(Clone, Copy)]
struct LayoutSpecifier {
    val: i32,
    num_sys: NumSys,
    occurence: DefOccurence,
}

type Loc = LayoutSpecifier;
type Index = LayoutSpecifier;

impl LayoutSpecifier {
    fn c(val: i32) -> Self {
        Self {
            val,
            num_sys: NumSys::Dec,
            occurence: DefOccurence::AllSh,
        }
    }

    fn c_sys(val: i32, num_sys: NumSys) -> Self {
        Self {
            val,
            num_sys,
            occurence: DefOccurence::AllSh,
        }
    }

    fn c_occ(val: i32, occurence: DefOccurence) -> Self {
        Self {
            val,
            num_sys: NumSys::Dec,
            occurence,
        }
    }

    fn implicit() -> Self {
        Self {
            val: 1999999,
            num_sys: NumSys::Dec,
            occurence: DefOccurence::NoneSh,
        }
    }

    fn is_implicit(&self, stages: &[GLenum]) -> bool {
        stages.iter().all(|&stage| !self.occurence.occurs(stage))
    }

    fn stream_definition(&self, keyword: &str, out: &mut String, shader: GLenum) {
        if self.val < 0 || !self.occurence.occurs(shader) {
            return;
        }
        let number = match self.num_sys {
            NumSys::Dec => self.val.to_string(),
            NumSys::Oct => format!("0{:o}", self.val),
            NumSys::Hex => format!("0x{:x}", self.val),
        };
        put!(out, "layout({keyword} = {number}) ");
    }

    fn stream_location(&self, out: &mut String, shader: GLenum) {
        self.stream_definition("location", out, shader);
    }

    fn stream_index(&self, out: &mut String, shader: GLenum) {
        self.stream_definition("index", out, shader);
    }
}

#[derive(Default)]
struct UniformStructCounter {
    counter: i32,
}

impl UniformStructCounter {
    fn get_next_count(&mut self) -> i32 {
        self.counter += 1;
        self.counter - 1
    }
}

#[derive(Clone, Copy, PartialEq)]
enum BaseType {
    Struct,
    Float,
    Int,
    UnsignedInt,
    Sampler,
}

/// `UniformType::streamArrayStr` / `SubroutineUniform::streamArrayStr`
fn stream_array_str(out: &mut String, is_array: bool, sizes: &[i32], array_size: i32, array_elem: Option<i32>) {
    if !is_array {
        return;
    }
    match array_elem {
        None => {
            for size in sizes {
                put!(out, "[{size}]");
            }
        }
        Some(mut array_elem) => {
            let mut tail_size = array_size;
            for size in sizes {
                tail_size /= size;
                put!(out, "[{}]", array_elem / tail_size);
                array_elem %= tail_size;
            }
        }
    }
}

#[derive(Clone)]
struct UniformType {
    enum_type: GLenum,
    array_sizes_segmented: Vec<i32>,
    array_size: i32,
    child_types: Vec<UniformType>,
    is_array: bool,
    signed_type: bool,
    str_type: String,
    ref_str_type: String,
    size: (i32, i32),
    base_type: BaseType,
}

impl UniformType {
    fn of(enum_type: GLenum) -> Self {
        Self::new(enum_type, 0)
    }

    fn new(enum_type: GLenum, array_size: i32) -> Self {
        let mut ty = Self {
            enum_type,
            array_sizes_segmented: vec![array_size.max(1)],
            array_size: array_size.max(1),
            child_types: Vec::new(),
            is_array: array_size > 0,
            signed_type: true,
            str_type: String::new(),
            ref_str_type: String::new(),
            size: (1, 1),
            base_type: BaseType::Struct,
        };
        ty.fill();
        ty
    }

    fn segmented(enum_type: GLenum, array_sizes_segmented: &[i32]) -> Self {
        let array_size = array_sizes_segmented.iter().product();
        let mut ty = Self {
            enum_type,
            array_sizes_segmented: array_sizes_segmented.to_vec(),
            array_size,
            child_types: Vec::new(),
            is_array: true,
            signed_type: true,
            str_type: String::new(),
            ref_str_type: String::new(),
            size: (1, 1),
            base_type: BaseType::Struct,
        };
        ty.fill();
        ty
    }

    fn structure(struct_counter: &mut UniformStructCounter, child_types: Vec<UniformType>, array_size: i32) -> Self {
        Self {
            enum_type: 0,
            array_sizes_segmented: vec![array_size.max(1)],
            array_size: array_size.max(1),
            child_types,
            is_array: array_size > 0,
            signed_type: true,
            str_type: format!("S{}", struct_counter.get_next_count()),
            ref_str_type: String::new(),
            size: (0, 0),
            base_type: BaseType::Struct,
        }
    }

    fn is_struct(&self) -> bool {
        self.base_type == BaseType::Struct
    }

    fn abs(&self) -> &'static str {
        match self.base_type {
            BaseType::Float | BaseType::Sampler => "0.1",
            BaseType::UnsignedInt => "0u",
            BaseType::Int => "0",
            BaseType::Struct => unreachable!("a struct has no abs() tolerance"),
        }
    }

    fn stream_array_str(&self, out: &mut String, array_elem: Option<i32>) {
        stream_array_str(
            out,
            self.is_array,
            &self.array_sizes_segmented,
            self.array_size,
            array_elem,
        );
    }

    fn fill(&mut self) {
        let (str_type, ref_str_type, base_type, size) = match self.enum_type {
            glw::GL_SAMPLER_2D => ("sampler2D", "vec4", BaseType::Sampler, (1, 1)),
            glw::GL_FLOAT => ("float", "float", BaseType::Float, (1, 1)),
            glw::GL_INT => ("int", "int", BaseType::Int, (1, 1)),
            glw::GL_UNSIGNED_INT => ("uint", "uint", BaseType::UnsignedInt, (1, 1)),
            glw::GL_FLOAT_VEC2 => ("vec2", "vec2", BaseType::Float, (2, 1)),
            glw::GL_FLOAT_VEC3 => ("vec3", "vec3", BaseType::Float, (3, 1)),
            glw::GL_FLOAT_VEC4 => ("vec4", "vec4", BaseType::Float, (4, 1)),
            glw::GL_FLOAT_MAT2 => ("mat2", "vec2", BaseType::Float, (2, 2)),
            glw::GL_FLOAT_MAT3 => ("mat3", "vec3", BaseType::Float, (3, 3)),
            glw::GL_FLOAT_MAT4 => ("mat4", "vec4", BaseType::Float, (4, 4)),
            glw::GL_FLOAT_MAT2x3 => ("mat2x3", "vec3", BaseType::Float, (3, 2)),
            glw::GL_FLOAT_MAT4x3 => ("mat4x3", "vec3", BaseType::Float, (3, 4)),
            glw::GL_FLOAT_MAT2x4 => ("mat2x4", "vec4", BaseType::Float, (4, 2)),
            glw::GL_FLOAT_MAT3x4 => ("mat3x4", "vec4", BaseType::Float, (4, 3)),
            glw::GL_FLOAT_MAT3x2 => ("mat3x2", "vec2", BaseType::Float, (2, 3)),
            glw::GL_FLOAT_MAT4x2 => ("mat4x2", "vec2", BaseType::Float, (2, 4)),
            glw::GL_INT_VEC2 => ("ivec2", "ivec2", BaseType::Int, (2, 1)),
            glw::GL_INT_VEC3 => ("ivec3", "ivec3", BaseType::Int, (3, 1)),
            glw::GL_INT_VEC4 => ("ivec4", "ivec4", BaseType::Int, (4, 1)),
            other => panic!("unsupported uniform type {other:#x}"),
        };
        self.str_type = str_type.to_string();
        self.ref_str_type = ref_str_type.to_string();
        self.base_type = base_type;
        self.size = size;
        self.signed_type = base_type != BaseType::UnsignedInt;
    }
}

#[derive(Default)]
struct UniformValueGenerator {
    f_value: f32,
    i_value: i32,
}

impl UniformValueGenerator {
    fn gen_f(&mut self) -> f32 {
        if self.f_value > 99999.0 {
            self.f_value = 0.0;
        }
        self.f_value += 1.0;
        self.f_value
    }

    fn gen_i(&mut self) -> i32 {
        self.i_value += 1;
        self.i_value
    }
}

#[derive(Clone)]
struct UniformValue {
    ty: UniformType,
    f_values: Vec<f32>,
    i_values: Vec<i32>,
    u_values: Vec<u32>,
}

impl UniformValue {
    fn new(ty: &UniformType, generator: &mut UniformValueGenerator) -> Self {
        let mut value = Self {
            ty: ty.clone(),
            f_values: Vec::new(),
            i_values: Vec::new(),
            u_values: Vec::new(),
        };
        let (size_row, size_column) = ty.size;
        let array_size = ty.array_size as usize;
        match ty.base_type {
            BaseType::Struct => {}
            BaseType::Int => {
                value.i_values = (0..size_row as usize * array_size).map(|_| generator.gen_i()).collect();
            }
            BaseType::UnsignedInt => {
                value.u_values = (0..size_row as usize * array_size)
                    .map(|_| generator.gen_i() as u32)
                    .collect();
            }
            BaseType::Float => {
                value.f_values = (0..(size_column * size_row) as usize * array_size)
                    .map(|_| generator.gen_f())
                    .collect();
            }
            BaseType::Sampler => {
                let count = 4 * array_size;
                value.f_values = (0..count).map(|elem| elem as f32 / count as f32).collect();
                value.i_values = (0..array_size).map(|_| generator.gen_i() % 16).collect();
            }
        }
        value
    }

    fn stream_value(&self, out: &mut String, array_element: i32, column: i32) {
        let array_element_size = self.ty.size.0 * self.ty.size.1;
        put!(out, "{}(", self.ty.ref_str_type);

        if self.ty.base_type == BaseType::Sampler {
            for elem in 0..4 {
                if elem > 0 {
                    out.push_str(", ");
                }
                out.push_str(&format_g(self.f_values[(array_element * 4 + elem) as usize]));
            }
            out.push(')');
            return;
        }

        for elem in 0..self.ty.size.0 {
            if self.f_values.is_empty() {
                break;
            }
            if elem > 0 {
                out.push_str(", ");
            }
            put!(
                out,
                "{}.0",
                self.f_values[(array_element * array_element_size + column * self.ty.size.0 + elem) as usize]
            );
        }
        for elem in 0..self.ty.size.0 {
            if self.i_values.is_empty() {
                break;
            }
            if elem > 0 {
                out.push_str(", ");
            }
            put!(
                out,
                "{}",
                self.i_values[(array_element * array_element_size + elem) as usize]
            );
        }
        for elem in 0..self.ty.size.0 {
            if self.u_values.is_empty() {
                break;
            }
            if elem > 0 {
                out.push_str(", ");
            }
            put!(
                out,
                "{}u",
                self.u_values[(array_element * array_element_size + elem) as usize]
            );
        }
        out.push(')');
    }

    fn get_ptr(&self, array_element: i32) -> *const c_void {
        let offset = (array_element * self.ty.size.0 * self.ty.size.1) as usize;
        match self.ty.base_type {
            BaseType::Int | BaseType::Sampler => self.i_values[offset..].as_ptr().cast(),
            BaseType::UnsignedInt => self.u_values[offset..].as_ptr().cast(),
            BaseType::Float => self.f_values[offset..].as_ptr().cast(),
            BaseType::Struct => unreachable!("a struct has no value pointer"),
        }
    }
}

#[derive(Clone)]
struct Uniform {
    ty: UniformType,
    location: Loc,
    decl_occurence: DefOccurence,
    usage_occurence: DefOccurence,
    value: UniformValue,
    child_uniforms: Vec<Uniform>,
    name: String,
    short_name: String,
}

impl Uniform {
    fn new(
        generator: &mut UniformValueGenerator,
        ty: UniformType,
        location: Loc,
        decl_occurence: DefOccurence,
        usage_occurence: DefOccurence,
    ) -> Self {
        let value = UniformValue::new(&ty, generator);
        let mut child_uniforms = Vec::new();
        if ty.is_struct() {
            let mut current_location = location.val;
            for _ in 0..ty.array_size {
                for child_type in &ty.child_types {
                    let child_location = if current_location > 0 {
                        Loc::c(current_location)
                    } else {
                        Loc::implicit()
                    };
                    child_uniforms.push(Uniform::new(
                        generator,
                        child_type.clone(),
                        child_location,
                        decl_occurence,
                        usage_occurence,
                    ));
                    current_location += child_type.array_size;
                }
            }
        }
        Self {
            ty,
            location,
            decl_occurence,
            usage_occurence,
            value,
            child_uniforms,
            name: String::new(),
            short_name: String::new(),
        }
    }

    fn all(generator: &mut UniformValueGenerator, ty: UniformType, location: Loc) -> Self {
        Self::new(generator, ty, location, DefOccurence::AllSh, DefOccurence::AllSh)
    }

    fn declared(
        generator: &mut UniformValueGenerator,
        ty: UniformType,
        location: Loc,
        decl_occurence: DefOccurence,
    ) -> Self {
        Self::new(generator, ty, location, decl_occurence, DefOccurence::AllSh)
    }

    fn set_name(&mut self, parent_name: &str, name: &str) {
        self.short_name = name.to_string();
        self.name = format!("{parent_name}{name}");
        if self.ty.is_struct() {
            let per_element = self.child_uniforms.len() / self.ty.array_size as usize;
            for i in 0..self.child_uniforms.len() {
                let child_name = format!("m{}", i % per_element);
                let mut child_parent_name = self.name.clone();
                self.ty
                    .stream_array_str(&mut child_parent_name, Some((i / self.ty.array_size as usize) as i32));
                child_parent_name.push('.');
                self.child_uniforms[i].set_name(&child_parent_name, &child_name);
            }
        }
    }

    fn stream_definition(&self, out: &mut String) {
        put!(out, "{} {}", self.ty.str_type, self.short_name);
        self.ty.stream_array_str(out, None);
    }

    fn is_used_in(&self, stages: &[GLenum]) -> bool {
        stages
            .iter()
            .any(|&stage| self.decl_occurence.occurs(stage) && self.usage_occurence.occurs(stage))
    }
}

#[derive(Clone)]
struct SubroutineFunction {
    index: Index,
    embedded_ret_val: UniformValue,
    name: String,
}

impl SubroutineFunction {
    fn new(generator: &mut UniformValueGenerator, index: Index) -> Self {
        Self {
            index,
            embedded_ret_val: UniformValue::new(&UniformType::of(glw::GL_FLOAT_VEC4), generator),
            name: String::new(),
        }
    }
}

#[derive(Clone)]
struct SubroutineFunctionSet {
    fns: Vec<SubroutineFunction>,
    type_name: String,
}

impl SubroutineFunctionSet {
    /// `count` copies of one function: upstream's `std::vector(count, SubroutineFunction(generator))`, so the generator runs once even for zero.
    fn new(generator: &mut UniformValueGenerator, count: usize) -> Self {
        let function = SubroutineFunction::new(generator, Index::implicit());
        Self {
            fns: vec![function; count],
            type_name: String::new(),
        }
    }

    fn push(&mut self, function: SubroutineFunction) {
        self.fns.push(function);
    }
}

#[derive(Clone)]
struct SubroutineUniform {
    functions: SubroutineFunctionSet,
    location: Loc,
    array_size: i32,
    def_occurence: DefOccurence,
    used: bool,
    array_sizes_segmented: Vec<i32>,
    is_array: bool,
    embedded_uint_uniform: UniformValue,
    name: String,
}

impl SubroutineUniform {
    fn new(
        generator: &mut UniformValueGenerator,
        functions: &SubroutineFunctionSet,
        location: Loc,
        array_size: i32,
        def_occurence: DefOccurence,
        used: bool,
    ) -> Self {
        let _ = UniformValue::new(&UniformType::of(glw::GL_UNSIGNED_INT), generator);
        let is_array = array_size != 0;
        let array_size = array_size.max(1);
        Self::finish(
            generator,
            functions,
            location,
            array_size,
            vec![array_size],
            is_array,
            def_occurence,
            used,
        )
    }

    fn segmented(
        generator: &mut UniformValueGenerator,
        functions: &SubroutineFunctionSet,
        location: Loc,
        array_sizes_segmented: &[i32],
        def_occurence: DefOccurence,
        used: bool,
    ) -> Self {
        let _ = UniformValue::new(&UniformType::of(glw::GL_UNSIGNED_INT), generator);
        let array_size = array_sizes_segmented.iter().product();
        Self::finish(
            generator,
            functions,
            location,
            array_size,
            array_sizes_segmented.to_vec(),
            true,
            def_occurence,
            used,
        )
    }

    #[allow(clippy::too_many_arguments)]
    fn finish(
        generator: &mut UniformValueGenerator,
        functions: &SubroutineFunctionSet,
        location: Loc,
        array_size: i32,
        array_sizes_segmented: Vec<i32>,
        is_array: bool,
        def_occurence: DefOccurence,
        used: bool,
    ) -> Self {
        let mut embedded_uint_uniform =
            UniformValue::new(&UniformType::new(glw::GL_UNSIGNED_INT, array_size), generator);
        let function_count = functions.fns.len() as u32;
        for value in &mut embedded_uint_uniform.u_values {
            *value %= function_count;
        }
        Self {
            functions: functions.clone(),
            location,
            array_size,
            def_occurence,
            used,
            array_sizes_segmented,
            is_array,
            embedded_uint_uniform,
            name: String::new(),
        }
    }

    fn stream_array_str(&self, out: &mut String, array_elem: Option<i32>) {
        stream_array_str(
            out,
            self.is_array,
            &self.array_sizes_segmented,
            self.array_size,
            array_elem,
        );
    }

    fn get_selected_function(&self, array_elem: i32) -> &SubroutineFunction {
        &self.functions.fns[self.embedded_uint_uniform.u_values[array_elem as usize] as usize]
    }
}

#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
struct ShaderKey {
    stage: GLenum,
    input: String,
    output: String,
}

impl ShaderKey {
    fn new(stage: GLenum, input: &str, output: &str) -> Self {
        Self {
            stage,
            input: input.to_string(),
            output: output.to_string(),
        }
    }
}

struct CompiledProgram {
    name: GLuint,
    stages: Vec<GLenum>,
}

fn stream_uniform_definitions(uniforms: &[Uniform], shader: GLenum, out: &mut String) {
    for uniform in uniforms {
        if !uniform.decl_occurence.occurs(shader) {
            continue;
        }
        if uniform.ty.is_struct() {
            put!(out, "struct {} {{\n", uniform.ty.str_type);
            for child in 0..uniform.child_uniforms.len() / uniform.ty.array_size as usize {
                out.push_str("    ");
                uniform.child_uniforms[child].stream_definition(out);
                out.push_str(";\n");
            }
            out.push_str("};\n");
        }
        uniform.location.stream_location(out, shader);
        out.push_str("uniform ");
        uniform.stream_definition(out);
        out.push_str(";\n");
    }
}

fn stream_subroutine_definitions(subroutine_uniforms: &[SubroutineUniform], shader: GLenum, out: &mut String) {
    if !subroutine_uniforms.is_empty() {
        out.push_str("uniform float zero;\n");
    }

    for subroutine_uniform in subroutine_uniforms {
        if !subroutine_uniform.def_occurence.occurs(shader) {
            continue;
        }
        let type_name = &subroutine_uniform.functions.type_name;
        put!(out, "subroutine vec4 {type_name}(float param);\n");

        for function in &subroutine_uniform.functions.fns {
            function.index.stream_index(out, shader);
            put!(
                out,
                "subroutine({type_name}) vec4 {}(float param) {{ return zero + ",
                function.name
            );
            function.embedded_ret_val.stream_value(out, 0, 0);
            out.push_str("; }\n");
        }

        subroutine_uniform.location.stream_location(out, shader);
        put!(out, "subroutine uniform {type_name} {}", subroutine_uniform.name);
        subroutine_uniform.stream_array_str(out, None);
        out.push_str(";\n");
    }
}

fn stream_uniform_validator(out: &mut String, uniform: &Uniform, shader: GLenum, out_temporary: &str) {
    if !(uniform.decl_occurence.occurs(shader) && uniform.usage_occurence.occurs(shader)) {
        return;
    }
    if uniform.ty.is_struct() {
        for child in &uniform.child_uniforms {
            stream_uniform_validator(out, child, shader, out_temporary);
        }
        return;
    }

    let ty = &uniform.ty;
    for array_element in 0..ty.array_size {
        for column in 0..ty.size.1 {
            let column_index = if ty.size.1 > 1 {
                format!("[{column}]")
            } else {
                String::new()
            };
            let absolute_f = if ty.signed_type { "abs" } else { "" };

            if ty.base_type == BaseType::Sampler {
                put!(out, "\n    if (any(greaterThan({absolute_f}(texture({}", uniform.name);
                ty.stream_array_str(out, Some(array_element));
                put!(out, "{column_index}, vec2(0.5)) - ");
                uniform.value.stream_value(out, array_element, column);
                put!(out, " ), {}({})))) {{", ty.ref_str_type, ty.abs());
            } else if ty.size.0 > 1 {
                put!(out, "\n    if (any(greaterThan({absolute_f}({}", uniform.name);
                ty.stream_array_str(out, Some(array_element));
                put!(out, "{column_index} - ");
                uniform.value.stream_value(out, array_element, column);
                put!(out, "), {}({})))) {{", ty.ref_str_type, ty.abs());
            } else {
                put!(out, "\n    if ({absolute_f}({}", uniform.name);
                ty.stream_array_str(out, Some(array_element));
                out.push_str(" - ");
                uniform.value.stream_value(out, array_element, 0);
                put!(out, ") >{}({})) {{", ty.ref_str_type, ty.abs());
            }
            put!(out, "\n       {out_temporary} = vec4 (1.0, 0.0, 0.0, 1.0);");
            out.push_str("\n    }");
        }
    }
}

fn stream_uniform_validators(out: &mut String, uniforms: &[Uniform], shader: GLenum, out_temporary: &str) {
    for uniform in uniforms {
        stream_uniform_validator(out, uniform, shader, out_temporary);
    }
}

fn stream_subroutine_validators(
    out: &mut String,
    subroutine_uniforms: &[SubroutineUniform],
    shader: GLenum,
    out_temporary: &str,
) {
    for subroutine_uniform in subroutine_uniforms {
        if !(subroutine_uniform.def_occurence.occurs(shader) && subroutine_uniform.used) {
            continue;
        }
        for array_elem in 0..subroutine_uniform.array_size {
            put!(out, "\n    if (any(greaterThan(abs({}", subroutine_uniform.name);
            subroutine_uniform.stream_array_str(out, Some(array_elem));
            out.push_str("(zero) - ");
            subroutine_uniform
                .get_selected_function(array_elem)
                .embedded_ret_val
                .stream_value(out, 0, 0);
            out.push_str("), vec4(0.1)))) {");
            put!(out, "\n       {out_temporary} = vec4 (1.0, 0.0, 0.0, 1.0);");
            out.push_str("\n    }");
        }
    }
}

const SHADER_HEADER: &str = "#version 430 core\n";

fn generate_fragment_shader(
    key: &ShaderKey,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
) -> String {
    let mut ret = String::new();
    ret.push_str(SHADER_HEADER);
    ret.push('\n');
    stream_uniform_definitions(uniforms, glw::GL_FRAGMENT_SHADER, &mut ret);
    ret.push('\n');
    stream_subroutine_definitions(subroutine_uniforms, glw::GL_FRAGMENT_SHADER, &mut ret);
    put!(
        ret,
        "\n{additional_def}\nin vec4 {};\nout vec4 out_FragColor;\nvoid main() {{\n    vec4 validationResult = {};\n",
        key.input,
        key.input
    );
    stream_uniform_validators(&mut ret, uniforms, glw::GL_FRAGMENT_SHADER, "validationResult");
    ret.push('\n');
    stream_subroutine_validators(
        &mut ret,
        subroutine_uniforms,
        glw::GL_FRAGMENT_SHADER,
        "validationResult",
    );
    ret.push_str("\n    out_FragColor =  validationResult;\n}");
    ret
}

fn generate_vertex_shader(
    key: &ShaderKey,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
) -> String {
    let mut ret = String::new();
    ret.push_str(SHADER_HEADER);
    ret.push('\n');
    stream_uniform_definitions(uniforms, glw::GL_VERTEX_SHADER, &mut ret);
    ret.push('\n');
    stream_subroutine_definitions(subroutine_uniforms, glw::GL_VERTEX_SHADER, &mut ret);
    put!(
        ret,
        "\n{additional_def}\nin vec4 in_Position;\nout vec4 {};\nvoid main() {{\n    vec4 validationResult = vec4(0.0, 1.0, 0.0, 1.0);\n",
        key.output
    );
    stream_uniform_validators(&mut ret, uniforms, glw::GL_VERTEX_SHADER, "validationResult");
    ret.push('\n');
    stream_subroutine_validators(&mut ret, subroutine_uniforms, glw::GL_VERTEX_SHADER, "validationResult");
    put!(
        ret,
        "\n    {} = validationResult;\n    gl_Position = in_Position;\n}}",
        key.output
    );
    ret
}

fn generate_compute_shader(
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
) -> String {
    let mut ret = String::new();
    ret.push_str(SHADER_HEADER);
    ret.push_str("\nlayout (local_size_x = 1, local_size_y = 1) in;\nlayout (std430, binding = 1) buffer ResultBuffer {\n    vec4 cs_ValidationResult;\n};\n");
    stream_uniform_definitions(uniforms, glw::GL_COMPUTE_SHADER, &mut ret);
    ret.push('\n');
    stream_subroutine_definitions(subroutine_uniforms, glw::GL_COMPUTE_SHADER, &mut ret);
    put!(
        ret,
        "\n{additional_def}\nvoid main() {{\n    vec4 validationResult = vec4(0.0, 1.0, 0.0, 1.0);\n"
    );
    stream_uniform_validators(&mut ret, uniforms, glw::GL_COMPUTE_SHADER, "validationResult");
    ret.push('\n');
    stream_subroutine_validators(
        &mut ret,
        subroutine_uniforms,
        glw::GL_COMPUTE_SHADER,
        "validationResult",
    );
    ret.push_str("\n    cs_ValidationResult =  validationResult;\n}");
    ret
}

fn generate_shader(
    key: &ShaderKey,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
) -> String {
    match key.stage {
        glw::GL_VERTEX_SHADER => generate_vertex_shader(key, uniforms, subroutine_uniforms, additional_def),
        glw::GL_FRAGMENT_SHADER => generate_fragment_shader(key, uniforms, subroutine_uniforms, additional_def),
        glw::GL_COMPUTE_SHADER => generate_compute_shader(uniforms, subroutine_uniforms, additional_def),
        other => panic!("unsupported shader stage {other:#x}"),
    }
}

fn create_shaders(
    gl: &glw::Functions,
    program_configs: &[Vec<ShaderKey>],
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
) -> BTreeMap<ShaderKey, GLuint> {
    let mut ret = BTreeMap::new();

    for config in program_configs {
        for key in config {
            if ret.contains_key(key) {
                continue;
            }
            let shader = gl!(gl.create_shader(key.stage));
            let source = cstr(&generate_shader(key, uniforms, subroutine_uniforms, additional_def));
            let source_ptr = source.as_ptr();
            gl!(gl.shader_source(shader, 1, &source_ptr, std::ptr::null()));
            ret.insert(key.clone(), shader);
        }
    }

    for &shader in ret.values() {
        gl!(gl.compile_shader(shader));
    }

    ret
}

fn shader_info_log(gl: &glw::Functions, shader: GLuint) -> String {
    let mut info_log = [0u8; 1000];
    gl!(gl.get_shader_info_log(shader, 1000, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
    String::from_utf8_lossy(&info_log).trim_end_matches('\0').to_string()
}

fn program_info_log(gl: &glw::Functions, program: GLuint) -> String {
    let mut info_log = [0u8; 1000];
    gl!(gl.get_program_info_log(program, 1000, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
    String::from_utf8_lossy(&info_log).trim_end_matches('\0').to_string()
}

fn create_programs(
    gl: &glw::Functions,
    programs: &mut Vec<CompiledProgram>,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
    additional_def: &str,
    negative_compile: bool,
    negative_link: bool,
) -> i64 {
    let mut ret = NO_ERROR;

    let program_configs = vec![
        vec![
            ShaderKey::new(glw::GL_VERTEX_SHADER, "", "vs_ValidationResult"),
            ShaderKey::new(glw::GL_FRAGMENT_SHADER, "vs_ValidationResult", ""),
        ],
        vec![ShaderKey::new(glw::GL_COMPUTE_SHADER, "", "")],
    ];

    let shaders = create_shaders(gl, &program_configs, uniforms, subroutine_uniforms, additional_def);

    for &shader in shaders.values() {
        let mut status: GLint = 0;
        gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
        if status != glw::GL_TRUE as GLint {
            log::info!("Shader compile info log: {}", shader_info_log(gl, shader));
        }

        if !negative_link {
            if !negative_compile {
                if status != glw::GL_TRUE as GLint {
                    log::info!("Shader compilation failed");
                    ret |= ERROR;
                }
            } else if status != 0 {
                log::info!("Negative compilation case failed: shader shoult not compile, but GL_COMPILE_STATUS != 0");
                ret |= ERROR;
            }
        }
    }

    if negative_compile {
        for &shader in shaders.values() {
            gl!(gl.delete_shader(shader));
        }
        return ret;
    }

    for config in &program_configs {
        let name = gl!(gl.create_program());
        let mut stages = Vec::new();
        for key in config {
            let shader = shaders[key];
            gl!(gl.attach_shader(name, shader));
            stages.push(key.stage);
        }
        gl!(gl.link_program(name));
        programs.push(CompiledProgram { name, stages });
    }
    for program in programs.iter() {
        gl!(gl.link_program(program.name));
    }

    for &shader in shaders.values() {
        gl!(gl.delete_shader(shader));
    }

    for program in programs.iter() {
        let mut status: GLint = 0;
        gl!(gl.get_programiv(program.name, glw::GL_LINK_STATUS, &mut status));
        let info_log = program_info_log(gl, program.name);
        if status != glw::GL_TRUE as GLint {
            log::info!("Program link info log: {info_log}");
        }

        if !negative_link {
            if status != glw::GL_TRUE as GLint {
                log::info!("Shader link failed");
                ret |= ERROR;
            }
        } else if status != 0 {
            log::info!("Negative link case failed: program should not link, but GL_LINK_STATUS != 0");
            ret |= ERROR;
        }
    }
    ret
}

fn delete_programs(gl: &glw::Functions, programs: &mut Vec<CompiledProgram>) {
    for program in programs.iter() {
        gl!(gl.delete_program(program.name));
    }
    programs.clear();
}

#[allow(clippy::explicit_counter_loop)]
fn set_uniform(gl: &glw::Functions, uniform: &Uniform, program: &CompiledProgram) {
    if !uniform.is_used_in(&program.stages) {
        return;
    }

    if uniform.ty.is_struct() {
        for child in &uniform.child_uniforms {
            set_uniform(gl, child, program);
        }
        return;
    }

    let mut loc: GLint = if uniform.location.is_implicit(&program.stages) {
        let mut name = uniform.name.clone();
        uniform.ty.stream_array_str(&mut name, Some(0));
        let name = cstr(&name);
        gl!(gl.get_uniform_location(program.name, name.as_ptr()))
    } else {
        uniform.location.val
    };

    for array_elem in 0..uniform.ty.array_size {
        let ptr = uniform.value.get_ptr(array_elem);
        match uniform.ty.enum_type {
            glw::GL_FLOAT => gl!(gl.uniform_1f(loc, *ptr.cast::<f32>())),
            glw::GL_FLOAT_VEC2 => gl!(gl.uniform_2fv(loc, 1, ptr.cast())),
            glw::GL_FLOAT_VEC3 => gl!(gl.uniform_3fv(loc, 1, ptr.cast())),
            glw::GL_FLOAT_VEC4 => gl!(gl.uniform_4fv(loc, 1, ptr.cast())),
            glw::GL_FLOAT_MAT2 => gl!(gl.uniform_matrix_2fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT3 => gl!(gl.uniform_matrix_3fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT4 => gl!(gl.uniform_matrix_4fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT2x3 => gl!(gl.uniform_matrix_2x_3fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT4x3 => gl!(gl.uniform_matrix_4x_3fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT2x4 => gl!(gl.uniform_matrix_2x_4fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT3x4 => gl!(gl.uniform_matrix_3x_4fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT3x2 => gl!(gl.uniform_matrix_3x_2fv(loc, 1, 0, ptr.cast())),
            glw::GL_FLOAT_MAT4x2 => gl!(gl.uniform_matrix_4x_2fv(loc, 1, 0, ptr.cast())),
            glw::GL_INT | glw::GL_SAMPLER_2D => gl!(gl.uniform_1i(loc, *ptr.cast::<GLint>())),
            glw::GL_INT_VEC2 => gl!(gl.uniform_2iv(loc, 1, ptr.cast())),
            glw::GL_INT_VEC3 => gl!(gl.uniform_3iv(loc, 1, ptr.cast())),
            glw::GL_INT_VEC4 => gl!(gl.uniform_4iv(loc, 1, ptr.cast())),
            glw::GL_UNSIGNED_INT => gl!(gl.uniform_1ui(loc, *ptr.cast::<GLuint>())),
            other => panic!("unsupported uniform type {other:#x}"),
        }
        loc += 1;
    }
}

fn set_subroutine_uniform(
    gl: &glw::Functions,
    subroutine_uniform: &SubroutineUniform,
    program: &CompiledProgram,
    stage: GLenum,
    indices_out: &mut [GLuint],
) {
    if !(subroutine_uniform.def_occurence.occurs(stage) && subroutine_uniform.used) {
        return;
    }

    for array_elem in 0..subroutine_uniform.array_size {
        let loc: GLint = if subroutine_uniform.location.is_implicit(&program.stages) {
            let mut name = subroutine_uniform.name.clone();
            subroutine_uniform.stream_array_str(&mut name, Some(array_elem));
            let name = cstr(&name);
            gl!(gl.get_subroutine_uniform_location(program.name, stage, name.as_ptr()))
        } else {
            subroutine_uniform.location.val + array_elem
        };
        if loc < 0 {
            continue;
        }

        let selected_function = subroutine_uniform.get_selected_function(array_elem);
        let index = if selected_function.index.is_implicit(&[stage]) {
            let name = cstr(&selected_function.name);
            gl!(gl.get_subroutine_index(program.name, stage, name.as_ptr()))
        } else {
            selected_function.index.val as GLuint
        };

        if let Some(slot) = indices_out.get_mut(loc as usize) {
            *slot = index;
        }
    }
}

fn run_execute_program(
    context: &Context,
    program: &CompiledProgram,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
) -> i64 {
    let gl = context.gl();
    let mut ret = NO_ERROR;

    gl!(gl.use_program(program.name));

    for uniform in uniforms {
        set_uniform(gl, uniform, program);
    }

    if !subroutine_uniforms.is_empty() {
        for &stage in &program.stages {
            let mut numactive: GLint = 0;
            gl!(gl.get_program_stageiv(
                program.name,
                stage,
                glw::GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS,
                &mut numactive
            ));
            if numactive != 0 {
                let mut indices = vec![0 as GLuint; numactive as usize];
                for subroutine_uniform in subroutine_uniforms {
                    set_subroutine_uniform(gl, subroutine_uniform, program, stage, &mut indices);
                }
                gl!(gl.uniform_subroutinesuiv(stage, numactive, indices.as_ptr()));
            }
        }
    }

    if program.stages[0] != glw::GL_COMPUTE_SHADER {
        let target = context.render_target();
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let mut pixels = vec![0u8; (target.width * target.height * 4) as usize];
        gl!(gl.read_pixels(
            0,
            0,
            target.width,
            target.height,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            pixels.as_mut_ptr().cast()
        ));
        for pixel in pixels.chunks_exact(4) {
            if pixel[0] != 0 || pixel[1] != 255 || pixel[2] != 0 {
                ret |= ERROR;
                log::info!(
                    "Program {}: Wrong color. Expected green, got ({}, {}, {}, {}).",
                    program.name,
                    pixel[0],
                    pixel[1],
                    pixel[2],
                    pixel[3]
                );
                break;
            }
        }
    } else {
        let mut buffer: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut buffer));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4 * std::mem::size_of::<f32>() as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_READ
        ));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer));

        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));

        let mapped = gl!(gl.map_buffer_range(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4 * std::mem::size_of::<f32>() as isize,
            glw::GL_MAP_READ_BIT
        )) as *const f32;
        if mapped.is_null() {
            ret |= ERROR;
            log::info!("Program {}: mapping the result buffer failed", program.name);
        } else {
            // SAFETY: the mapping covers four floats and stays valid until the unmap below.
            let color = unsafe { std::slice::from_raw_parts(mapped, 4) };
            if color[0] != 0.0 || color[1] != 1.0 || color[2] != 0.0 {
                ret |= ERROR;
                log::info!(
                    "Program {}: Wrong color. Expected green, got ({}, {}, {}, {}).",
                    program.name,
                    color[0] as i32,
                    color[1] as i32,
                    color[2] as i32,
                    color[3] as i32
                );
            }
            gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        }

        gl!(gl.delete_buffers(1, &buffer));
    }

    ret
}

/// Locations in upstream's `std::set<GLuint>`, here the `GLint` that is inserted.
fn run_query_uniform(
    gl: &glw::Functions,
    program: &CompiledProgram,
    uniform: &Uniform,
    used_locations: &mut HashSet<GLint>,
    max: GLint,
) -> i64 {
    let mut ret = NO_ERROR;

    if uniform.ty.is_struct() {
        for child in &uniform.child_uniforms {
            ret |= run_query_uniform(gl, program, child, used_locations, max);
        }
        return ret;
    }

    let implicit = uniform.location.is_implicit(&program.stages);
    for array_elem in 0..uniform.ty.array_size {
        let mut reserved_location: GLint = if implicit {
            -1
        } else {
            uniform.location.val + array_elem
        };

        let run_queries = implicit || (array_elem < 1000 || array_elem > uniform.ty.array_size - 1000);

        if run_queries {
            let mut name = uniform.name.clone();
            uniform.ty.stream_array_str(&mut name, Some(array_elem));
            let c_name = cstr(&name);
            let returned = gl!(gl.get_uniform_location(program.name, c_name.as_ptr()));
            let returned_piq = gl!(gl.get_program_resource_location(program.name, glw::GL_UNIFORM, c_name.as_ptr()));

            if returned != returned_piq {
                ret |= ERROR;
                log::info!(
                    "Locations of  uniform \"{name}\" returned by glGetUniformLocation and differ glGetProgramResourceLocation differ: {returned} != {returned_piq}."
                );
            }

            let used = uniform.is_used_in(&program.stages);

            if !implicit {
                let expected = reserved_location;
                if !(expected == returned || (!used && returned == -1)) {
                    ret |= ERROR;
                    log::info!("Unexpected uniform \"{name}\" location: expected {expected}, got {returned}.");
                }
            } else if used {
                if returned < 0 {
                    ret |= ERROR;
                    log::info!("Unexpected uniform \"{name}\" location: expected positive value, got {returned}.");
                } else {
                    reserved_location = returned;
                }
            }

            if returned >= 0 && returned >= max {
                ret |= ERROR;
                log::info!(
                    "Uniform \"{name}\" returned location ({returned}) is greater than implementation dependent limit ({max})."
                );
            }
        }

        if reserved_location >= 0 && !used_locations.insert(reserved_location) {
            ret |= ERROR;
            log::info!("Uniform location ({reserved_location}) is not unique.");
        }
    }
    ret
}

fn run_query_uniform_subroutine(
    gl: &glw::Functions,
    program: &CompiledProgram,
    stage: GLenum,
    subroutine_uniform: &SubroutineUniform,
    used_locations: &mut HashSet<GLint>,
    max: GLint,
) -> i64 {
    let mut ret = NO_ERROR;

    for array_elem in 0..subroutine_uniform.array_size {
        let mut name = subroutine_uniform.name.clone();
        subroutine_uniform.stream_array_str(&mut name, Some(array_elem));
        let c_name = cstr(&name);

        let returned = gl!(gl.get_subroutine_uniform_location(program.name, stage, c_name.as_ptr()));

        let piq_stage = match stage {
            glw::GL_VERTEX_SHADER => glw::GL_VERTEX_SUBROUTINE_UNIFORM,
            glw::GL_FRAGMENT_SHADER => glw::GL_FRAGMENT_SUBROUTINE_UNIFORM,
            glw::GL_COMPUTE_SHADER => glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            other => panic!("unsupported shader stage {other:#x}"),
        };

        let returned_piq = gl!(gl.get_program_resource_location(program.name, piq_stage, c_name.as_ptr()));

        if returned != returned_piq {
            ret |= ERROR;
            log::info!(
                "Locations of subrutine uniform \"{name}\" returned by glGetUniformLocation and differ glGetProgramResourceLocation differ: {returned} != {returned_piq}."
            );
        }

        let used = subroutine_uniform.def_occurence.occurs(stage) && subroutine_uniform.used;

        let mut reserved_location: GLint = -1;

        if !subroutine_uniform.location.is_implicit(&[stage]) {
            let expected = subroutine_uniform.location.val + array_elem;
            if !(expected == returned || (!used && returned == -1)) {
                ret |= ERROR;
                log::info!("Unexpected subroutine uniform \"{name}\" location: expected {expected}, got {returned}.");
            }
            reserved_location = expected;
        } else if used {
            if returned < 0 {
                ret |= ERROR;
                log::info!(
                    "Unexpected subroutine uniform \"{name}\" location: expected positive value, got {returned}."
                );
            } else {
                reserved_location = returned;
            }
        }

        if reserved_location >= 0 && !used_locations.insert(reserved_location) {
            ret |= ERROR;
            log::info!("Subroutine uniform \"{name}\" location ({reserved_location}) is not unique.");
        }

        if returned >= 0 && returned >= max {
            ret |= ERROR;
            log::info!(
                "Subroutine uniform \"{name}\" returned location ({returned}) is greater than implementation dependent limit ({max})."
            );
        }
    }
    ret
}

fn run_query_uniform_subroutine_function(
    gl: &glw::Functions,
    program: &CompiledProgram,
    stage: GLenum,
    subroutine_function: &SubroutineFunction,
    used_indices: &mut HashSet<GLint>,
    max: GLint,
    used: bool,
) -> i64 {
    let mut ret = NO_ERROR;

    let name = &subroutine_function.name;
    let c_name = cstr(name);

    let returned = gl!(gl.get_subroutine_index(program.name, stage, c_name.as_ptr())) as GLint;

    let piq_stage = match stage {
        glw::GL_VERTEX_SHADER => glw::GL_VERTEX_SUBROUTINE,
        glw::GL_FRAGMENT_SHADER => glw::GL_FRAGMENT_SUBROUTINE,
        glw::GL_COMPUTE_SHADER => glw::GL_COMPUTE_SUBROUTINE,
        other => panic!("unsupported shader stage {other:#x}"),
    };

    let returned_piq = gl!(gl.get_program_resource_index(program.name, piq_stage, c_name.as_ptr())) as GLint;

    if returned != returned_piq {
        ret |= ERROR;
        log::info!(
            "Indices of subroutine function \"{name}\" returned by glGetSubroutineIndex and differ glGetProgramResourceIndex differ: {returned} != {returned_piq}."
        );
    }

    let mut reserved_index: GLint = -1;

    if !subroutine_function.index.is_implicit(&[stage]) {
        let expected = subroutine_function.index.val;
        if !(expected == returned || (!used && returned == -1)) {
            ret |= ERROR;
            log::info!("Unexpected subroutine function \"{name}\" index: expected {expected}, got {returned}.");
        }
        reserved_index = expected;
    } else if used {
        if returned < 0 {
            ret |= ERROR;
            log::info!("Unexpected subroutine function \"{name}\" index: expected positive value, got {returned}.");
        } else {
            reserved_index = returned;
        }
    }

    if reserved_index >= 0 && !used_indices.insert(reserved_index) {
        ret |= ERROR;
        log::info!("Subroutine function \"{name}\" index ({reserved_index}) is not unique.");
    }

    if returned >= 0 && returned >= max {
        ret |= ERROR;
        log::info!(
            "Subroutine function \"{name}\" returned index ({returned}) is greater than implementation dependent limit ({max})."
        );
    }

    ret
}

fn run_query_program(
    gl: &glw::Functions,
    program: &CompiledProgram,
    uniforms: &[Uniform],
    subroutine_uniforms: &[SubroutineUniform],
) -> i64 {
    let mut ret = NO_ERROR;

    {
        let mut used_locations = HashSet::new();
        let mut max: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_UNIFORM_LOCATIONS, &mut max));

        for uniform in uniforms {
            ret |= run_query_uniform(gl, program, uniform, &mut used_locations, max);
        }
    }

    if !subroutine_uniforms.is_empty() {
        let mut max_location: GLint = 0;
        let mut max_index: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS, &mut max_location));
        gl!(gl.get_integerv(glw::GL_MAX_SUBROUTINES, &mut max_index));

        for &stage in &program.stages {
            let mut used_locations = HashSet::new();
            let mut used_indices = HashSet::new();
            for subroutine_uniform in subroutine_uniforms {
                ret |= run_query_uniform_subroutine(
                    gl,
                    program,
                    stage,
                    subroutine_uniform,
                    &mut used_locations,
                    max_location,
                );
                for function in &subroutine_uniform.functions.fns {
                    ret |= run_query_uniform_subroutine_function(
                        gl,
                        program,
                        stage,
                        function,
                        &mut used_indices,
                        max_index,
                        subroutine_uniform.def_occurence.occurs(stage) && subroutine_uniform.used,
                    );
                }
            }
        }
    }

    ret
}

/// The members `ExplicitUniformLocationCaseBase` gives every case instance.
#[derive(Default)]
struct Base {
    uniform_value_generator: UniformValueGenerator,
    uniform_struct_counter: UniformStructCounter,
}

fn do_run_subroutines(context: &Context, subroutine_uniforms: &mut [SubroutineUniform]) -> i64 {
    do_run(context, &mut [], subroutine_uniforms, "", false, false)
}

fn do_run_uniforms(context: &Context, uniforms: &mut [Uniform]) -> i64 {
    do_run(context, uniforms, &mut [], "", false, false)
}

fn do_run_negative_compile(context: &Context, additional_def: &str) -> i64 {
    do_run(context, &mut [], &mut [], additional_def, true, false)
}

fn do_run_negative_link_uniforms(context: &Context, uniforms: &mut [Uniform]) -> i64 {
    do_run(context, uniforms, &mut [], "", false, true)
}

fn do_run_negative_link_subroutines(context: &Context, subroutine_uniforms: &mut [SubroutineUniform]) -> i64 {
    do_run(context, &mut [], subroutine_uniforms, "", false, true)
}

fn do_run(
    context: &Context,
    uniforms: &mut [Uniform],
    subroutine_uniforms: &mut [SubroutineUniform],
    additional_def: &str,
    negative_compile: bool,
    negative_link: bool,
) -> i64 {
    let gl = context.gl();
    let mut ret = NO_ERROR;
    for (i, uniform) in uniforms.iter_mut().enumerate() {
        uniform.set_name("", &format!("u{i}"));
    }
    let mut subroutine_type_counter = 0;
    let mut subroutine_function_counter = 0;
    for (i, subroutine_uniform) in subroutine_uniforms.iter_mut().enumerate() {
        subroutine_uniform.name = format!("u{}", i + uniforms.len());
        if subroutine_uniform.functions.type_name.is_empty() {
            subroutine_uniform.functions.type_name = format!("st{subroutine_type_counter}");
            subroutine_type_counter += 1;
            for function in &mut subroutine_uniform.functions.fns {
                function.name = format!("sf{subroutine_function_counter}");
                subroutine_function_counter += 1;
            }
        }
    }

    let coords: [f32; 16] = [
        1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0,
    ];

    let mut vbo: GLuint = 0;
    let mut vao: GLuint = 0;
    gl!(gl.gen_buffers(1, &mut vbo));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&coords) as isize,
        coords.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));

    gl!(gl.gen_vertex_arrays(1, &mut vao));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, 0, std::ptr::null()));
    gl!(gl.enable_vertex_attrib_array(0));

    let mut programs = Vec::new();
    ret |= create_programs(
        gl,
        &mut programs,
        uniforms,
        subroutine_uniforms,
        additional_def,
        negative_compile,
        negative_link,
    );

    for program in &programs {
        if ret != NO_ERROR || negative_compile || negative_link {
            break;
        }
        ret |= run_execute_program(context, program, uniforms, subroutine_uniforms);
        ret |= run_query_program(gl, program, uniforms, subroutine_uniforms);
    }

    gl!(gl.use_program(0));

    delete_programs(gl, &mut programs);

    gl!(gl.delete_buffers(1, &vbo));
    gl!(gl.delete_vertex_arrays(1, &vao));

    ret
}

fn max_of(context: &Context, pname: GLenum) -> GLint {
    let mut max: GLint = 0;
    gl!(context.gl().get_integerv(pname, &mut max));
    max
}

type CaseFn = fn(&mut Base, &Context) -> SubcaseResult;

struct Case(CaseFn);

impl Subcase for Case {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        (self.0)(&mut Base::default(), context)
    }
}

fn uniform_loc(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![Uniform::declared(
        g,
        UniformType::of(glw::GL_FLOAT_VEC4),
        Loc::c(2),
        DefOccurence::FshOrCsh,
    )];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_non_dec(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c_sys(0x0a, NumSys::Hex),
            DefOccurence::FshOrCsh,
        ),
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c_sys(0o10, NumSys::Oct),
            DefOccurence::FshOrCsh,
        ),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_multiple_stages(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC4), Loc::c(2))];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_multiple_uniforms(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC4), Loc::c(2)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC4), Loc::c(3)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC4), Loc::c(5)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_types_mix(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::of(glw::GL_FLOAT), Loc::c(2)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC3), Loc::c(3)),
        Uniform::all(g, UniformType::of(glw::GL_UNSIGNED_INT), Loc::c(0)),
        Uniform::all(g, UniformType::of(glw::GL_INT_VEC3), Loc::c(1)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT2), Loc::c(4)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT2), Loc::c(7)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT2), Loc::c(5)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT3), Loc::c(6)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_types_mat(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT2x3), Loc::c(1)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT3x2), Loc::c(2)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT2), Loc::c(0)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_MAT4x3), Loc::c(3)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_types_samplers(base: &mut Base, context: &Context) -> SubcaseResult {
    let gl = context.gl();
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::new(glw::GL_SAMPLER_2D, 3), Loc::c(1)),
        Uniform::all(g, UniformType::of(glw::GL_SAMPLER_2D), Loc::c(13)),
    ];

    let mut tex_units: Vec<GLuint> = Vec::new();
    let mut colors: Vec<[u8; 4]> = Vec::new();

    for uniform in &uniforms {
        for elem in 0..uniform.ty.array_size as usize {
            tex_units.push(uniform.value.i_values[elem] as GLuint);
            let channel =
                |component: usize| (255.0 * f64::from(uniform.value.f_values[4 * elem + component]) + 0.5) as u8;
            colors.push([channel(0), channel(1), channel(2), channel(3)]);
        }
    }

    let mut textures = vec![0 as GLuint; tex_units.len()];
    gl!(gl.gen_textures(textures.len() as i32, textures.as_mut_ptr()));

    for i in 0..textures.len() {
        gl!(gl.active_texture(glw::GL_TEXTURE0 + tex_units[i]));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[i]));
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 1));
        gl!(gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            colors[i].as_ptr().cast()
        ));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    }
    gl!(gl.active_texture(glw::GL_TEXTURE0));
    let ret = do_run_uniforms(context, &mut uniforms);
    gl!(gl.delete_textures(textures.len() as i32, textures.as_ptr()));
    Ok(ret)
}

fn uniform_loc_types_structs(base: &mut Base, context: &Context) -> SubcaseResult {
    let members = vec![
        UniformType::of(glw::GL_FLOAT_VEC4),
        UniformType::new(glw::GL_FLOAT, 2),
        UniformType::of(glw::GL_FLOAT_MAT2),
    ];
    let g = &mut base.uniform_value_generator;
    let c = &mut base.uniform_struct_counter;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::structure(c, members.clone(), 3), Loc::c(1)),
        Uniform::all(g, UniformType::structure(c, members, 0), Loc::c(13)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_arrays_non_spaced(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::new(glw::GL_FLOAT, 3), Loc::c(2)),
        Uniform::all(g, UniformType::new(glw::GL_FLOAT_VEC3, 2), Loc::c(5)),
        Uniform::all(g, UniformType::new(glw::GL_INT, 3), Loc::c(7)),
        Uniform::all(g, UniformType::of(glw::GL_INT_VEC4), Loc::c(10)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_array_spaced(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::of(glw::GL_FLOAT), Loc::c(2)),
        Uniform::all(g, UniformType::new(glw::GL_FLOAT_VEC3, 2), Loc::c(5)),
        Uniform::all(g, UniformType::new(glw::GL_INT, 3), Loc::c(8)),
        Uniform::all(g, UniformType::new(glw::GL_INT_VEC4, 1), Loc::c(12)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_arrayof_arrays(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::segmented(glw::GL_FLOAT, &[2, 3]), Loc::c(2)),
        Uniform::all(g, UniformType::segmented(glw::GL_FLOAT_VEC3, &[2, 2]), Loc::c(8)),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT), Loc::c(12)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_mix_with_implicit(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::of(glw::GL_FLOAT), Loc::c_occ(0, DefOccurence::FshOrCsh)),
        Uniform::all(
            g,
            UniformType::of(glw::GL_FLOAT_VEC3),
            Loc::c_occ(2, DefOccurence::FshOrCsh),
        ),
        Uniform::all(g, UniformType::of(glw::GL_INT), Loc::c_occ(3, DefOccurence::FshOrCsh)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_mix_with_implicit2(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::all(g, UniformType::new(glw::GL_FLOAT, 3), Loc::implicit()),
        Uniform::all(g, UniformType::new(glw::GL_FLOAT_VEC3, 2), Loc::c(3)),
        Uniform::all(g, UniformType::new(glw::GL_INT, 3), Loc::implicit()),
        Uniform::all(g, UniformType::new(glw::GL_INT_VEC4, 2), Loc::c(8)),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_mix_with_implicit3(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let unused = |g: &mut UniformValueGenerator, ty: GLenum, location: i32| {
        Uniform::new(
            g,
            UniformType::of(ty),
            Loc::c(location),
            DefOccurence::AllSh,
            DefOccurence::NoneSh,
        )
    };
    let mut uniforms = vec![
        unused(g, glw::GL_FLOAT, 0),
        unused(g, glw::GL_FLOAT_VEC3, 2),
        unused(g, glw::GL_INT, 3),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT), Loc::implicit()),
        Uniform::all(g, UniformType::of(glw::GL_FLOAT_VEC3), Loc::implicit()),
        Uniform::all(g, UniformType::of(glw::GL_INT), Loc::implicit()),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

/// The body shared by UniformLocMixWithImplicitMax (one implicit float) and ...MaxArray (an implicit float[3]).
fn mix_with_implicit_max(base: &mut Base, context: &Context, implicit_count: i32, third_test_offset: i32) -> i64 {
    let mut ret = NO_ERROR;
    let max = max_of(context, glw::GL_MAX_UNIFORM_LOCATIONS);
    let tests = [0, 3, max - third_test_offset];
    let g = &mut base.uniform_value_generator;
    for test in tests {
        let mut uniforms = Vec::new();
        if test > 0 {
            uniforms.push(Uniform::new(
                g,
                UniformType::new(glw::GL_FLOAT, test),
                Loc::c(0),
                DefOccurence::AllSh,
                DefOccurence::NoneSh,
            ));
        }
        if test < max - implicit_count {
            uniforms.push(Uniform::new(
                g,
                UniformType::new(glw::GL_FLOAT, max - implicit_count - test),
                Loc::c(test + implicit_count),
                DefOccurence::AllSh,
                DefOccurence::NoneSh,
            ));
        }
        let implicit_type = if implicit_count == 1 {
            UniformType::of(glw::GL_FLOAT)
        } else {
            UniformType::new(glw::GL_FLOAT, implicit_count)
        };
        uniforms.push(Uniform::all(g, implicit_type, Loc::implicit()));
        ret |= do_run_uniforms(context, &mut uniforms);
    }
    ret
}

fn uniform_loc_mix_with_implicit_max(base: &mut Base, context: &Context) -> SubcaseResult {
    Ok(mix_with_implicit_max(base, context, 1, 1))
}

fn uniform_loc_mix_with_implicit_max_array(base: &mut Base, context: &Context) -> SubcaseResult {
    Ok(mix_with_implicit_max(base, context, 3, 4))
}

fn uniform_loc_implicit_in_some_stages(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![Uniform::all(
        g,
        UniformType::of(glw::GL_FLOAT),
        Loc::c_occ(3, DefOccurence::FshOrCsh),
    )];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_implicit_in_some_stages2(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![Uniform::new(
        g,
        UniformType::of(glw::GL_FLOAT),
        Loc::c_occ(3, DefOccurence::FshOrCsh),
        DefOccurence::AllSh,
        DefOccurence::AllButFsh,
    )];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_implicit_in_some_stages3(base: &mut Base, context: &Context) -> SubcaseResult {
    use DefOccurence::{AllButFsh, AllButVsh, AllSh, FshOrCsh, Vsh};
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::new(
            g,
            UniformType::of(glw::GL_FLOAT),
            Loc::c_occ(3, FshOrCsh),
            AllSh,
            AllButFsh,
        ),
        Uniform::new(
            g,
            UniformType::of(glw::GL_FLOAT),
            Loc::c_occ(2, AllButFsh),
            AllSh,
            FshOrCsh,
        ),
        Uniform::new(
            g,
            UniformType::new(glw::GL_FLOAT, 3),
            Loc::c_occ(7, FshOrCsh),
            AllSh,
            AllButFsh,
        ),
        Uniform::new(
            g,
            UniformType::new(glw::GL_FLOAT, 3),
            Loc::c_occ(4, AllButFsh),
            AllSh,
            FshOrCsh,
        ),
        Uniform::new(g, UniformType::of(glw::GL_FLOAT), Loc::c_occ(0, Vsh), AllSh, AllButVsh),
        Uniform::new(
            g,
            UniformType::of(glw::GL_FLOAT),
            Loc::c_occ(1, AllButFsh),
            AllSh,
            AllButVsh,
        ),
    ];
    Ok(do_run_uniforms(context, &mut uniforms))
}

fn uniform_loc_negative_compile_non_number_literal(_base: &mut Base, context: &Context) -> SubcaseResult {
    Ok(do_run_negative_compile(
        context,
        "layout (location = x) uniform float u0;",
    ))
}

fn uniform_loc_negative_compile_non_const_loc(_base: &mut Base, context: &Context) -> SubcaseResult {
    Ok(do_run_negative_compile(
        context,
        "\nconst int i = 1;\nlayout (location = i) uniform float u0;",
    ))
}

fn uniform_loc_negative_link_location_reused1(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c(2),
            DefOccurence::FshOrCsh,
        ),
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c(2),
            DefOccurence::FshOrCsh,
        ),
    ];
    Ok(do_run_negative_link_uniforms(context, &mut uniforms))
}

fn uniform_loc_negative_link_location_reused2(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c(2),
            DefOccurence::FshOrCsh,
        ),
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT_VEC4),
            Loc::c(2),
            DefOccurence::AllButFsh,
        ),
    ];
    Ok(do_run_negative_link_uniforms(context, &mut uniforms))
}

fn uniform_loc_negative_link_max_location(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_UNIFORM_LOCATIONS);
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![Uniform::declared(
        g,
        UniformType::of(glw::GL_FLOAT_VEC4),
        Loc::c(max),
        DefOccurence::FshOrCsh,
    )];
    Ok(do_run_negative_link_uniforms(context, &mut uniforms))
}

fn uniform_loc_negative_link_max_max_num_of_location(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_UNIFORM_LOCATIONS);
    let g = &mut base.uniform_value_generator;
    let mut uniforms = vec![
        Uniform::new(
            g,
            UniformType::new(glw::GL_FLOAT, max),
            Loc::c(0),
            DefOccurence::FshOrCsh,
            DefOccurence::NoneSh,
        ),
        Uniform::declared(
            g,
            UniformType::of(glw::GL_FLOAT),
            Loc::implicit(),
            DefOccurence::AllButFsh,
        ),
    ];
    Ok(do_run_negative_link_uniforms(context, &mut uniforms))
}

fn sub_routine_loc(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(2),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_non_decimal(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(
            g,
            &functions_st0,
            Loc::c_sys(0x0a, NumSys::Hex),
            0,
            DefOccurence::FshOrCsh,
            true,
        ),
        SubroutineUniform::new(
            g,
            &functions_st0,
            Loc::c_sys(0o10, NumSys::Oct),
            0,
            DefOccurence::FshOrCsh,
            true,
        ),
    ];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_all_stages(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(2),
        0,
        DefOccurence::AllSh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_arrays(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(1),
        2,
        DefOccurence::AllSh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_arrays_mix(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let functions_st1 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(g, &functions_st0, Loc::c(1), 2, DefOccurence::AllSh, true),
        SubroutineUniform::segmented(g, &functions_st0, Loc::c(3), &[2, 3], DefOccurence::AllSh, true),
        SubroutineUniform::new(g, &functions_st1, Loc::c(9), 0, DefOccurence::AllSh, true),
    ];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_mix_with_implicit(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(g, &functions_st0, Loc::implicit(), 0, DefOccurence::AllSh, true),
        SubroutineUniform::new(g, &functions_st0, Loc::c(0), 0, DefOccurence::AllSh, true),
        SubroutineUniform::new(g, &functions_st0, Loc::c(1), 0, DefOccurence::AllSh, true),
    ];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_compilation_non_number_literal(_base: &mut Base, context: &Context) -> SubcaseResult {
    let def = "\nsubroutine vec4 st0(float param);\nsubroutine(st0) vec4 sf0(float param) { return param; }\nlayout(location = x ) subroutine uniform st0 u0;";
    Ok(do_run_negative_compile(context, def))
}

fn sub_routine_loc_compilation_non_const_loc(_base: &mut Base, context: &Context) -> SubcaseResult {
    let def = "\nconst int i = 1;\nsubroutine vec4 st0(float param);\nsubroutine(st0) vec4 sf0(float param) { return param; }\nlayout(location = i ) subroutine uniform st0 u0;";
    Ok(do_run_negative_compile(context, def))
}

fn sub_routine_loc_link_location_reused1(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(g, &functions_st0, Loc::c(2), 0, DefOccurence::FshOrCsh, true),
        SubroutineUniform::new(g, &functions_st0, Loc::c(2), 0, DefOccurence::FshOrCsh, true),
    ];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_link_location_max_location(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS);
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(max),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

fn sub_routine_loc_link_max_num_of_locations(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS);
    let g = &mut base.uniform_value_generator;
    let functions_st0 = SubroutineFunctionSet::new(g, 2);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(g, &functions_st0, Loc::c(0), max, DefOccurence::FshOrCsh, false),
        SubroutineUniform::new(g, &functions_st0, Loc::implicit(), 0, DefOccurence::FshOrCsh, true),
    ];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

/// A set holding one function per entry of `indices`, as the `push_back(SubroutineFunction(generator, Index::...))` runs of the index cases build it.
fn function_set_with_indices(g: &mut UniformValueGenerator, indices: &[Index]) -> SubroutineFunctionSet {
    let mut functions = SubroutineFunctionSet::new(g, 0);
    for &index in indices {
        functions.push(SubroutineFunction::new(g, index));
    }
    functions
}

fn subroutine_index(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(1), Index::c(2)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_non_decimal(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 =
        function_set_with_indices(g, &[Index::c_sys(0x0a, NumSys::Hex), Index::c_sys(0o10, NumSys::Oct)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_loc(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(1), Index::c(2)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(3),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_non_cont(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(0), Index::c(2)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(2),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_mult_uniforms(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(1), Index::c(3)]);
    let functions_st1 = function_set_with_indices(g, &[Index::c(2), Index::c(0)]);
    let mut subroutine_uniforms = vec![
        SubroutineUniform::new(g, &functions_st0, Loc::c(1), 0, DefOccurence::FshOrCsh, true),
        SubroutineUniform::new(g, &functions_st1, Loc::c(9), 0, DefOccurence::FshOrCsh, true),
    ];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_allstages(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(1), Index::c(2)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::AllSh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_mix_implicit(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::implicit(), Index::c(1), Index::c(0)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::c(2),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_negative_compilation_non_number_literal(_base: &mut Base, context: &Context) -> SubcaseResult {
    let def = "\nsubroutine vec4 st0(float param);\nlayout(index = x) subroutine(st0) vec4 sf1(float param) { return param; };";
    Ok(do_run_negative_compile(context, def))
}

fn subroutine_index_negative_compilation_non_const_index(_base: &mut Base, context: &Context) -> SubcaseResult {
    let def = "\nconst int i = 1;\nlayout(index = i) subroutine(st0) vec4 sf1(float param) { return param; };";
    Ok(do_run_negative_compile(context, def))
}

fn subroutine_index_negative_link_index_reused(base: &mut Base, context: &Context) -> SubcaseResult {
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(2), Index::c(2)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_negative_link_max_index(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_SUBROUTINES);
    let g = &mut base.uniform_value_generator;
    let functions_st0 = function_set_with_indices(g, &[Index::c(max)]);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

fn subroutine_index_negative_link_max_num_of_indices(base: &mut Base, context: &Context) -> SubcaseResult {
    let max = max_of(context, glw::GL_MAX_SUBROUTINES);
    let g = &mut base.uniform_value_generator;
    let mut indices: Vec<Index> = (0..max).map(Index::c).collect();
    indices.push(Index::implicit());
    let functions_st0 = function_set_with_indices(g, &indices);
    let mut subroutine_uniforms = vec![SubroutineUniform::new(
        g,
        &functions_st0,
        Loc::implicit(),
        0,
        DefOccurence::FshOrCsh,
        true,
    )];
    Ok(do_run_negative_link_subroutines(context, &mut subroutine_uniforms))
}

const CASES: [(&str, CaseFn); 48] = [
    ("uniform-loc", uniform_loc),
    ("uniform-loc-nondecimal", uniform_loc_non_dec),
    ("uniform-loc-all-stages", uniform_loc_multiple_stages),
    ("uniform-loc-multiple-uniforms", uniform_loc_multiple_uniforms),
    ("uniform-loc-types-mix", uniform_loc_types_mix),
    ("uniform-loc-types-mat", uniform_loc_types_mat),
    ("uniform-loc-types-structs", uniform_loc_types_structs),
    ("uniform-loc-types-samplers", uniform_loc_types_samplers),
    ("uniform-loc-arrays-nonspaced", uniform_loc_arrays_non_spaced),
    ("uniform-loc-arrays-spaced", uniform_loc_array_spaced),
    ("uniform-loc-arrays-of-arrays", uniform_loc_arrayof_arrays),
    ("uniform-loc-mix-with-implicit", uniform_loc_mix_with_implicit),
    ("uniform-loc-mix-with-implicit2", uniform_loc_mix_with_implicit2),
    ("uniform-loc-mix-with-implicit3", uniform_loc_mix_with_implicit3),
    ("uniform-loc-mix-with-implicit-max", uniform_loc_mix_with_implicit_max),
    (
        "uniform-loc-mix-with-implicit-max-array",
        uniform_loc_mix_with_implicit_max_array,
    ),
    (
        "uniform-loc-implicit-in-some-stages",
        uniform_loc_implicit_in_some_stages,
    ),
    (
        "uniform-loc-implicit-in-some-stages2",
        uniform_loc_implicit_in_some_stages2,
    ),
    (
        "uniform-loc-implicit-in-some-stages3",
        uniform_loc_implicit_in_some_stages3,
    ),
    (
        "uniform-loc-negative-compile-non-number-literal",
        uniform_loc_negative_compile_non_number_literal,
    ),
    (
        "uniform-loc-negative-compile-nonconst-loc",
        uniform_loc_negative_compile_non_const_loc,
    ),
    (
        "uniform-loc-negative-link-location-reused1",
        uniform_loc_negative_link_location_reused1,
    ),
    (
        "uniform-loc-negative-link-location-reused2",
        uniform_loc_negative_link_location_reused2,
    ),
    (
        "uniform-loc-negative-link-max-location",
        uniform_loc_negative_link_max_location,
    ),
    (
        "uniform-loc-negative-link-max-num-of-locations",
        uniform_loc_negative_link_max_max_num_of_location,
    ),
    ("subroutine-loc", sub_routine_loc),
    ("subroutine-loc-nondecimal", sub_routine_loc_non_decimal),
    ("subroutine-loc-all-stages", sub_routine_loc_all_stages),
    ("subroutine-loc-arrays", sub_routine_loc_arrays),
    ("subroutine-loc-arrays-mix", sub_routine_loc_arrays_mix),
    ("subroutine-loc-mix-with-implicit", sub_routine_loc_mix_with_implicit),
    (
        "subroutine-loc-negative-compilation-non-number-literal",
        sub_routine_loc_compilation_non_number_literal,
    ),
    (
        "subroutine-loc-negative-compilation-nonconst-loc",
        sub_routine_loc_compilation_non_const_loc,
    ),
    (
        "subroutine-loc-negative-link-location-reused1",
        sub_routine_loc_link_location_reused1,
    ),
    (
        "subroutine-loc-negative-link-location-max-location",
        sub_routine_loc_link_location_max_location,
    ),
    (
        "subroutine-loc-negative-link-max-num-of-locations",
        sub_routine_loc_link_max_num_of_locations,
    ),
    ("subroutine-index", subroutine_index),
    ("subroutine-index-nondecimal", subroutine_index_non_decimal),
    ("subroutine-index-loc", subroutine_index_loc),
    ("subroutine-index-non-continuous", subroutine_index_non_cont),
    ("subroutine-index-multiple-uniforms", subroutine_index_mult_uniforms),
    ("subroutine-index-all-stages", subroutine_index_allstages),
    ("subroutine-index-mix-implicit", subroutine_index_mix_implicit),
    (
        "subroutine-index-negative-compilation-non-number-literal",
        subroutine_index_negative_compilation_non_number_literal,
    ),
    (
        "subroutine-index-negative-compilation-nonconst-index",
        subroutine_index_negative_compilation_non_const_index,
    ),
    (
        "subroutine-index-negative-link-index-reused",
        subroutine_index_negative_link_index_reused,
    ),
    (
        "subroutine-index-negative-link-location-maxindex",
        subroutine_index_negative_link_max_index,
    ),
    (
        "subroutine-index-negative-link-max-num-of-indices",
        subroutine_index_negative_link_max_num_of_indices,
    ),
];

/// `ExplicitUniformLocationGLTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("explicit_uniform_location");
    for (name, run) in CASES {
        group.add_child(
            Box::new(TestSubcase::new(name, move || Box::new(Case(run)) as Box<dyn Subcase>)) as Box<dyn TestCase>,
        );
    }
    group
}
