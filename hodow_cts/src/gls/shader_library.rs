// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluShaderLibrary.{hpp,cpp}   (the case specification and its helpers)
//   modules/glshared/glsShaderLibraryCase.{hpp,cpp}
//   modules/glshared/glsShaderLibrary.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream parses the `.test` shader-library files at *run time* out of a data archive.
// Doing that here would make the binary depend on data files it has to find on disk, which
// the project deliberately does not do (see the SPIR-V note in CLAUDE.md). Instead
// `scripts/gen_shader_library.py` parses the same files ahead of time and emits the case
// tree as Rust statics under `src/generated/shader_library/`; this file is only the spec
// types those statics are built out of, and the case that executes one.
//
// So the `.test` parser is a developer tool, exactly like `compile_shaders.py`, and the
// shipped binary still links nothing but libc.

use crate::glu::shader_util::DataType;
use crate::glu::{
    self, Context, GlslVersion, ProgramPipeline, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup,
    TestNode,
};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{Random, StringTemplate, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

/// `glu::sl::CaseType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum CaseType {
    /// Has all shaders specified separately.
    Complete,
    /// "Both" case, vertex shader sub case.
    VertexOnly,
    /// "Both" case, fragment shader sub case.
    FragmentOnly,
}

/// `glu::sl::ExpectResult`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExpectResult {
    Pass,
    CompileFail,
    LinkFail,
    CompileLinkFail,
    ValidationFail,
    BuildSuccessful,
}

/// `glu::sl::Value::Element`, split by how the value's own scalar type reads it.
#[derive(Clone, Copy, Debug)]
pub enum Elements {
    Float(&'static [f32]),
    Int(&'static [i32]),
}

impl Elements {
    pub fn len(&self) -> usize {
        match self {
            Self::Float(v) => v.len(),
            Self::Int(v) => v.len(),
        }
    }

    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }

    /// The scalar at `ndx` as a float, which is how every input reaches the shader: the
    /// generated vertex shader takes even an integer input as a float attribute.
    pub fn as_float(&self, ndx: usize) -> f32 {
        match self {
            Self::Float(v) => v[ndx],
            Self::Int(v) => v[ndx] as f32,
        }
    }
}

/// `glu::sl::Value`
#[derive(Clone, Copy, Debug)]
pub struct Value {
    pub data_type: DataType,
    pub name: &'static str,
    pub elements: Elements,
}

/// `glu::sl::ValueBlock`
#[derive(Clone, Copy, Debug)]
pub struct ValueBlock {
    pub inputs: &'static [Value],
    pub outputs: &'static [Value],
    pub uniforms: &'static [Value],
}

/// `glu::sl::RequiredCapability`
#[derive(Clone, Copy, Debug)]
pub enum RequiredCapability {
    /// `CAPABILITY_LIMIT`
    Limit {
        pname: GLenum,
        /// The queried limit must be strictly greater than this.
        reference_value: i32,
        /// The enum's spelling, for the NotSupported message.
        pname_str: &'static str,
    },
    /// `CAPABILITY_FULL_GLSL_ES_100_SUPPORT` - a build failure here is the implementation
    /// not covering all of GLSL ES 1.00, which is not required of it.
    FullGlslEs100Support,
    /// `CAPABILITY_ONLY_GLSL_ES_100_SUPPORT` - the case is meaningless on an ES 3 context.
    OnlyGlslEs100Support,
    /// `CAPABILITY_EXACTLY_ONE_DRAW_BUFFER` - unextended ES 2 has exactly one.
    ExactlyOneDrawBuffer,
}

/// `glu::sl::RequiredExtension` - one or more extensions, at least one of which must be
/// supported, and the stages that need it.
#[derive(Clone, Copy, Debug)]
pub struct RequiredExtension {
    pub alternatives: &'static [&'static str],
    pub effective_stages: u32,
}

/// `glu::sl::ProgramSpecification`
#[derive(Clone, Copy, Debug)]
pub struct ProgramSpec {
    pub sources: &'static [(ShaderType, &'static str)],
    pub required_extensions: &'static [RequiredExtension],
    /// Has an effect only when `separable` is set.
    pub active_stages: u32,
    pub separable: bool,
}

impl ProgramSpec {
    fn source_for(&self, shader_type: ShaderType) -> Option<&'static str> {
        self.sources
            .iter()
            .find(|&&(ty, _)| ty == shader_type)
            .map(|&(_, src)| src)
    }
}

/// `glu::sl::ShaderCaseSpecification`
#[derive(Clone, Copy, Debug)]
pub struct CaseSpec {
    pub case_type: CaseType,
    pub expect_result: ExpectResult,
    pub target_version: GlslVersion,
    pub required_caps: &'static [RequiredCapability],
    pub values: ValueBlock,
    pub programs: &'static [ProgramSpec],
}

/// One node of a generated case tree.
pub enum Node {
    Group(&'static Group),
    Case(&'static Case),
}

/// A generated group of shader-library cases.
pub struct Group {
    pub name: &'static str,
    pub children: &'static [Node],
}

/// A generated shader-library case.
pub struct Case {
    pub name: &'static str,
    pub spec: CaseSpec,
}

/// Builds the `glu::TestCaseGroup` a generated tree describes.
pub fn create_group(name: &str, root: &'static Group) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    add_group_children(&mut group, root);
    group
}

/// Appends a generated tree's top-level nodes to an existing group, which is what a case
/// file loaded into a group that also has hand-written children needs.
pub fn add_group_children(group: &mut TestCaseGroup, root: &'static Group) {
    for child in root.children {
        group.add_child(create_node(child));
    }
}

fn create_node(node: &'static Node) -> TestNode {
    match node {
        Node::Group(g) => TestNode::Group(create_group(g.name, g)),
        Node::Case(c) => TestNode::Case(Box::new(ShaderLibraryCase::new(c.name, c.spec))),
    }
}

/// `glslVersionUsesInOutQualifiers`
fn uses_in_out_qualifiers(version: GlslVersion) -> bool {
    version >= GlslVersion::Es300
}

/// `supportsFragmentHighp`
fn supports_fragment_highp(version: GlslVersion) -> bool {
    version != GlslVersion::Es100
}

/// `glu::getDataTypeFloatScalars` - the float type of the same shape, which is what an
/// integer input travels through the vertex stage as.
fn float_scalars(data_type: DataType) -> DataType {
    match data_type.scalar_size() {
        1 => DataType::Float,
        2 => DataType::FloatVec2,
        3 => DataType::FloatVec3,
        4 => DataType::FloatVec4,
        _ => data_type,
    }
}

/// The float type matching a value's shape, keeping matrices as they are.
fn float_type_name(data_type: DataType) -> &'static str {
    if data_type.is_matrix() {
        data_type.name()
    } else {
        float_scalars(data_type).name()
    }
}

/// `glu::sl::genCompareFunctions`
fn gen_compare_functions(out: &mut String, values: &ValueBlock, use_float_types: bool) {
    use DataType::*;

    let found = |ty: DataType| values.outputs.iter().any(|v| v.data_type == ty);

    if use_float_types {
        for (ty, line) in [
            (Bool, "bool isOk (float a, bool b) { return ((a > 0.5) == b); }\n"),
            (
                BoolVec2,
                "bool isOk (vec2 a, bvec2 b) { return (greaterThan(a, vec2(0.5)) == b); }\n",
            ),
            (
                BoolVec3,
                "bool isOk (vec3 a, bvec3 b) { return (greaterThan(a, vec3(0.5)) == b); }\n",
            ),
            (
                BoolVec4,
                "bool isOk (vec4 a, bvec4 b) { return (greaterThan(a, vec4(0.5)) == b); }\n",
            ),
            (
                Int,
                "bool isOk (float a, int b)  { float atemp = a+0.5; return (float(b) <= atemp && atemp <= float(b+1)); }\n",
            ),
            (
                IntVec2,
                "bool isOk (vec2 a, ivec2 b) { return (ivec2(floor(a + 0.5)) == b); }\n",
            ),
            (
                IntVec3,
                "bool isOk (vec3 a, ivec3 b) { return (ivec3(floor(a + 0.5)) == b); }\n",
            ),
            (
                IntVec4,
                "bool isOk (vec4 a, ivec4 b) { return (ivec4(floor(a + 0.5)) == b); }\n",
            ),
            (
                Uint,
                "bool isOk (float a, uint b) { float atemp = a+0.5; return (float(b) <= atemp && atemp <= float(b+1u)); }\n",
            ),
            (
                UintVec2,
                "bool isOk (vec2 a, uvec2 b) { return (uvec2(floor(a + 0.5)) == b); }\n",
            ),
            (
                UintVec3,
                "bool isOk (vec3 a, uvec3 b) { return (uvec3(floor(a + 0.5)) == b); }\n",
            ),
            (
                UintVec4,
                "bool isOk (vec4 a, uvec4 b) { return (uvec4(floor(a + 0.5)) == b); }\n",
            ),
        ] {
            if found(ty) {
                out.push_str(line);
            }
        }
    } else {
        for (ty, line) in [
            (Bool, "bool isOk (bool a, bool b)   { return (a == b); }\n"),
            (BoolVec2, "bool isOk (bvec2 a, bvec2 b) { return (a == b); }\n"),
            (BoolVec3, "bool isOk (bvec3 a, bvec3 b) { return (a == b); }\n"),
            (BoolVec4, "bool isOk (bvec4 a, bvec4 b) { return (a == b); }\n"),
            (Int, "bool isOk (int a, int b)     { return (a == b); }\n"),
            (IntVec2, "bool isOk (ivec2 a, ivec2 b) { return (a == b); }\n"),
            (IntVec3, "bool isOk (ivec3 a, ivec3 b) { return (a == b); }\n"),
            (IntVec4, "bool isOk (ivec4 a, ivec4 b) { return (a == b); }\n"),
            (Uint, "bool isOk (uint a, uint b)   { return (a == b); }\n"),
            (UintVec2, "bool isOk (uvec2 a, uvec2 b) { return (a == b); }\n"),
            (UintVec3, "bool isOk (uvec3 a, uvec3 b) { return (a == b); }\n"),
            (UintVec4, "bool isOk (uvec4 a, uvec4 b) { return (a == b); }\n"),
        ] {
            if found(ty) {
                out.push_str(line);
            }
        }
    }

    for (ty, line) in [
        (
            Float,
            "bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }\n",
        ),
        (
            FloatVec2,
            "bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatVec3,
            "bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatVec4,
            "bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatMat2,
            "bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat2x3,
            "bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat2x4,
            "bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
        (
            FloatMat3x2,
            "bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return \
             all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat3,
            "bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return \
             all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat3x4,
            "bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return \
             all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
        (
            FloatMat4x2,
            "bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), \
             abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat4x3,
            "bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), \
             abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat4,
            "bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); \
             return all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
    ] {
        if found(ty) {
            out.push_str(line);
        }
    }
}

/// `genCompareOp`
fn gen_compare_op(out: &mut String, dst_vec4_var: &str, values: &ValueBlock, non_float_name_prefix: &str) {
    let mut is_first_output = true;

    for val in values.outputs {
        if is_first_output {
            out.push_str("bool RES = ");
            is_first_output = false;
        } else {
            out.push_str("RES = RES && ");
        }

        if val.data_type.scalar_type() == DataType::Float {
            out.push_str(&format!("isOk({}, ref_{}, 0.05);\n", val.name, val.name));
        } else {
            out.push_str(&format!(
                "isOk({non_float_name_prefix}{}, ref_{});\n",
                val.name, val.name
            ));
        }
    }

    if is_first_output {
        out.push_str(&format!("{dst_vec4_var} = vec4(1.0);\n"));
    } else {
        out.push_str(&format!("{dst_vec4_var} = vec4(RES, RES, RES, 1.0);\n"));
    }
}

/// `generateUniformDeclarations` - a dotted name is a block member, which the block's own
/// declaration in the case source already covers.
fn generate_uniform_declarations(out: &mut String, values: &ValueBlock) {
    for val in values.uniforms {
        if !val.name.contains('.') {
            out.push_str(&format!("uniform {} {};\n", val.data_type.name(), val.name));
        }
    }
}

/// `generateExtensionStatements` + `injectExtensionRequirements` - the directives go after
/// the last preprocessor line, since `#extension` must follow `#version`.
fn inject_extension_requirements(base_code: &str, extensions: &[RequiredExtension], shader_type: ShaderType) -> String {
    let mut ext_str = String::new();
    for ext in extensions {
        debug_assert_eq!(
            ext.alternatives.len(),
            1,
            "extensions must be resolved to one alternative first"
        );
        if ext.effective_stages & (1 << (shader_type as u32)) != 0 {
            ext_str.push_str(&format!("#extension {} : require\n", ext.alternatives[0]));
        }
    }

    if ext_str.is_empty() {
        return base_code.to_string();
    }

    let mut result = String::new();
    let mut first_non_preprocessor_line = true;

    for line in base_code.lines() {
        let is_preprocessor_directive = line.trim_start_matches(['\t', ' ']).starts_with('#');

        if !is_preprocessor_directive && first_non_preprocessor_line {
            first_non_preprocessor_line = false;
            result.push_str(&ext_str);
        }

        result.push_str(line);
        result.push('\n');
    }

    result
}

/// `checkAndSpecializeExtensions` - each requirement collapses to the first alternative the
/// context actually has, or the case is NotSupported.
fn check_and_specialize_extensions(
    src: &[RequiredExtension],
    context: &Context,
) -> Result<Vec<RequiredExtension>, TestError> {
    let mut specialized = Vec::with_capacity(src.len());

    for extension in src {
        let supported = extension
            .alternatives
            .iter()
            .position(|&alt| context.context_info.is_extension_supported(alt));

        match supported {
            Some(ndx) => specialized.push(RequiredExtension {
                alternatives: &extension.alternatives[ndx..=ndx],
                effective_stages: extension.effective_stages,
            }),
            None => {
                let list = extension.alternatives.join(", ");
                return Err(TestError::NotSupported(if extension.alternatives.len() == 1 {
                    format!("Test requires extension {list}")
                } else {
                    format!("Test requires any extension of {list}")
                }));
            }
        }
    }

    Ok(specialized)
}

/// `checkImplementationLimits`
fn check_implementation_limits(required_caps: &[RequiredCapability], context: &Context) -> Result<(), TestError> {
    for capability in required_caps {
        let RequiredCapability::Limit {
            pname,
            reference_value,
            pname_str,
        } = *capability
        else {
            continue;
        };

        let mut supported_value: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { context.gl().get_integerv(pname, &mut supported_value) };

        if supported_value <= reference_value {
            return Err(TestError::NotSupported(format!(
                "Test requires {pname_str} ({supported_value}) >= {reference_value}"
            )));
        }
    }

    Ok(())
}

/// `glu::sl::isCapabilityRequired`
fn is_capability_required(spec: &CaseSpec, flag: RequiredCapability) -> bool {
    spec.required_caps
        .iter()
        .any(|cap| std::mem::discriminant(cap) == std::mem::discriminant(&flag))
}

/// `genVertexShader` - the vertex half of a "both" case whose fragment shader is under
/// test: it only forwards every input to a varying.
fn gen_vertex_shader(spec: &CaseSpec) -> String {
    let uses_inout = uses_in_out_qualifiers(spec.target_version);
    let vtx_in = if uses_inout { "in" } else { "attribute" };
    let vtx_out = if uses_inout { "out" } else { "varying" };

    let mut res = String::new();
    res.push_str(spec.target_version.declaration());
    res.push_str("\nprecision highp float;\nprecision highp int;\n\n");
    res.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));

    for val in spec.values.inputs {
        let type_str = float_type_name(val.data_type);
        res.push_str(&format!("{vtx_in} {type_str} a_{};\n", val.name));

        if val.data_type.scalar_type() == DataType::Float {
            res.push_str(&format!("{vtx_out} {type_str} {};\n", val.name));
        } else {
            res.push_str(&format!("{vtx_out} {type_str} v_{};\n", val.name));
        }
    }

    res.push_str("\nvoid main()\n{\n    gl_Position = dEQP_Position;\n");
    for val in spec.values.inputs {
        if val.data_type.scalar_type() == DataType::Float {
            res.push_str(&format!("    {} = a_{};\n", val.name, val.name));
        } else {
            res.push_str(&format!("    v_{} = a_{};\n", val.name, val.name));
        }
    }
    res.push_str("}\n");

    res
}

/// `genFragmentShader` - the fragment half of a "both" case whose vertex shader is under
/// test: it only compares every output against its reference uniform.
fn gen_fragment_shader(spec: &CaseSpec) -> String {
    let uses_inout = uses_in_out_qualifiers(spec.target_version);
    let custom_color_out = uses_inout;
    let frag_in = if uses_inout { "in" } else { "varying" };
    let prec = if supports_fragment_highp(spec.target_version) {
        "highp"
    } else {
        "mediump"
    };

    let mut shader = String::new();
    shader.push_str(spec.target_version.declaration());
    shader.push_str(&format!("\nprecision {prec} float;\nprecision {prec} int;\n\n"));

    if custom_color_out {
        shader.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n\n");
    }

    gen_compare_functions(&mut shader, &spec.values, true);
    shader.push('\n');

    for val in spec.values.outputs {
        let float_type_str = float_type_name(val.data_type);
        let ref_type_str = val.data_type.name();

        if val.data_type.scalar_type() == DataType::Float {
            shader.push_str(&format!("{frag_in} {float_type_str} {};\n", val.name));
        } else {
            shader.push_str(&format!("{frag_in} {float_type_str} v_{};\n", val.name));
        }

        shader.push_str(&format!("uniform {ref_type_str} ref_{};\n", val.name));
    }

    shader.push_str("\nvoid main()\n{\n    ");
    gen_compare_op(
        &mut shader,
        if custom_color_out {
            "dEQP_FragColor"
        } else {
            "gl_FragColor"
        },
        &spec.values,
        "v_",
    );
    shader.push_str("}\n");

    shader
}

/// `specializeVertexShader`
fn specialize_vertex_shader(spec: &CaseSpec, src: &str, extensions: &[RequiredExtension]) -> Result<String, TestError> {
    let uses_inout = uses_in_out_qualifiers(spec.target_version);
    let vtx_in = if uses_inout { "in" } else { "attribute" };
    let vtx_out = if uses_inout { "out" } else { "varying" };

    let mut decl = String::new();
    let mut setup = String::new();
    let mut output = String::from("gl_Position = dEQP_Position;\n");

    decl.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));

    for val in spec.values.inputs {
        let float_type_str = float_type_name(val.data_type);
        let ref_type_str = val.data_type.name();

        if val.data_type.scalar_type() == DataType::Float {
            decl.push_str(&format!("{vtx_in} {float_type_str} {};\n", val.name));
        } else {
            decl.push_str(&format!("{vtx_in} {float_type_str} a_{};\n", val.name));
            setup.push_str(&format!(
                "{ref_type_str} {} = {ref_type_str}(a_{});\n",
                val.name, val.name
            ));
        }
    }

    for val in spec.values.outputs {
        let float_type_str = float_type_name(val.data_type);
        let ref_type_str = val.data_type.name();

        if val.data_type.scalar_type() == DataType::Float {
            decl.push_str(&format!("{vtx_out} {float_type_str} {};\n", val.name));
        } else {
            decl.push_str(&format!("{vtx_out} {float_type_str} v_{};\n", val.name));
            decl.push_str(&format!("{ref_type_str} {};\n", val.name));
            output.push_str(&format!("v_{} = {float_type_str}({});\n", val.name, val.name));
        }
    }

    let base_src = StringTemplate::new(src).specialize(&[
        ("DECLARATIONS", decl),
        ("SETUP", setup),
        ("OUTPUT", output),
        ("POSITION_FRAG_COLOR", "gl_Position".to_string()),
    ])?;

    Ok(inject_extension_requirements(&base_src, extensions, ShaderType::Vertex))
}

/// `specializeFragmentShader`
fn specialize_fragment_shader(
    spec: &CaseSpec,
    src: &str,
    extensions: &[RequiredExtension],
) -> Result<String, TestError> {
    let uses_inout = uses_in_out_qualifiers(spec.target_version);
    let custom_color_out = uses_inout;
    let frag_in = if uses_inout { "in" } else { "varying" };
    let frag_color = if custom_color_out {
        "dEQP_FragColor"
    } else {
        "gl_FragColor"
    };

    let mut decl = String::new();
    let mut setup = String::new();
    let mut output = String::new();

    gen_compare_functions(&mut decl, &spec.values, false);
    gen_compare_op(&mut output, frag_color, &spec.values, "");

    if custom_color_out {
        decl.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
    }

    for val in spec.values.inputs {
        let float_type_str = float_type_name(val.data_type);
        let ref_type_str = val.data_type.name();

        if val.data_type.scalar_type() == DataType::Float {
            decl.push_str(&format!("{frag_in} {float_type_str} {};\n", val.name));
        } else {
            decl.push_str(&format!("{frag_in} {float_type_str} v_{};\n", val.name));
            // \note the scale on an integer input is upstream's own hack: without it the
            // varying interpolation can land just below the integer and chop() rounds down.
            let offset = if val.data_type.is_int_or_ivec() {
                " * 1.0025"
            } else {
                ""
            };
            setup.push_str(&format!(
                "{ref_type_str} {} = {ref_type_str}(v_{}{offset});\n",
                val.name, val.name
            ));
        }
    }

    for val in spec.values.outputs {
        let ref_type_str = val.data_type.name();
        decl.push_str(&format!("uniform {ref_type_str} ref_{};\n", val.name));
        decl.push_str(&format!("{ref_type_str} {};\n", val.name));
    }

    let base_src = StringTemplate::new(src).specialize(&[
        ("DECLARATIONS", decl),
        ("SETUP", setup),
        ("OUTPUT", output),
        ("POSITION_FRAG_COLOR", frag_color.to_string()),
    ])?;

    Ok(inject_extension_requirements(
        &base_src,
        extensions,
        ShaderType::Fragment,
    ))
}

/// The `${...}` substitutions one stage of a complete case takes.
fn stage_specialization(
    spec: &CaseSpec,
    shader_type: ShaderType,
    max_patch_vertices: i32,
) -> Vec<(&'static str, String)> {
    let uses_inout = uses_in_out_qualifiers(spec.target_version);
    let mut decl = String::new();

    match shader_type {
        // `generateVertexSpecialization`
        ShaderType::Vertex => {
            let vtx_in = if uses_inout { "in" } else { "attribute" };
            let mut setup = String::new();

            decl.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));

            for val in spec.values.inputs {
                let type_str = val.data_type.name();

                if val.data_type.scalar_type() == DataType::Float {
                    decl.push_str(&format!("{vtx_in} {type_str} {};\n", val.name));
                } else {
                    let float_type_str = float_type_name(val.data_type);
                    decl.push_str(&format!("{vtx_in} {float_type_str} a_{};\n", val.name));
                    setup.push_str(&format!("{type_str} {} = {type_str}(a_{});\n", val.name, val.name));
                }
            }

            generate_uniform_declarations(&mut decl, &spec.values);

            vec![
                ("VERTEX_DECLARATIONS", decl),
                ("VERTEX_SETUP", setup),
                ("VERTEX_OUTPUT", "gl_Position = dEQP_Position;\n".to_string()),
            ]
        }

        // `generateFragmentSpecialization`
        ShaderType::Fragment => {
            let custom_color_out = uses_inout;
            let frag_color = if custom_color_out {
                "dEQP_FragColor"
            } else {
                "gl_FragColor"
            };
            let mut output = String::new();

            gen_compare_functions(&mut decl, &spec.values, false);
            gen_compare_op(&mut output, frag_color, &spec.values, "");

            if custom_color_out {
                decl.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
            }

            for val in spec.values.outputs {
                let ref_type_str = val.data_type.name();
                decl.push_str(&format!("uniform {ref_type_str} ref_{};\n", val.name));
                decl.push_str(&format!("{ref_type_str} {};\n", val.name));
            }

            generate_uniform_declarations(&mut decl, &spec.values);

            vec![
                ("FRAGMENT_DECLARATIONS", decl),
                ("FRAGMENT_OUTPUT", output),
                ("FRAG_COLOR", frag_color.to_string()),
            ]
        }

        // `generateGeometrySpecialization`
        ShaderType::Geometry => {
            decl.push_str("layout (triangles) in;\nlayout (triangle_strip, max_vertices=3) out;\n\n");
            generate_uniform_declarations(&mut decl, &spec.values);
            vec![("GEOMETRY_DECLARATIONS", decl)]
        }

        // `generateTessControlSpecialization`
        ShaderType::TessControl => {
            decl.push_str("layout (vertices=3) out;\n\n");
            generate_uniform_declarations(&mut decl, &spec.values);

            let output = "gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\ngl_TessLevelInner[0] = 2.0;\ngl_TessLevelInner[1] \
                          = 2.0;\ngl_TessLevelOuter[0] = 2.0;\ngl_TessLevelOuter[1] = 2.0;\ngl_TessLevelOuter[2] = 2.0;\ngl_TessLevelOuter[3] = 2.0;"
                .to_string();

            vec![
                ("TESSELLATION_CONTROL_DECLARATIONS", decl),
                ("TESSELLATION_CONTROL_OUTPUT", output),
                ("GL_MAX_PATCH_VERTICES", max_patch_vertices.to_string()),
            ]
        }

        // `generateTessEvalSpecialization`
        ShaderType::TessEvaluation => {
            decl.push_str("layout (triangles) in;\n\n");
            generate_uniform_declarations(&mut decl, &spec.values);

            let output = "gl_Position = gl_TessCoord[0] * gl_in[0].gl_Position + gl_TessCoord[1] * gl_in[1].gl_Position + gl_TessCoord[2] * \
                          gl_in[2].gl_Position;\n"
                .to_string();

            vec![
                ("TESSELLATION_EVALUATION_DECLARATIONS", decl),
                ("TESSELLATION_EVALUATION_OUTPUT", output),
                ("GL_MAX_PATCH_VERTICES", max_patch_vertices.to_string()),
            ]
        }

        ShaderType::Compute => Vec::new(),
    }
}

/// `specializeProgramSources`
fn specialize_program_sources(
    program: &ProgramSpec,
    spec: &CaseSpec,
    extensions: &[RequiredExtension],
    max_patch_vertices: i32,
) -> Result<ProgramSources, TestError> {
    let mut dst = ProgramSources::default();

    for shader_type in [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessControl,
        ShaderType::TessEvaluation,
    ] {
        let Some(src) = program.source_for(shader_type) else {
            continue;
        };

        let params = stage_specialization(spec, shader_type, max_patch_vertices);
        let base = StringTemplate::new(src).specialize(&params)?;
        dst = dst.with(
            shader_type,
            inject_extension_requirements(&base, extensions, shader_type),
        );
    }

    if program.separable {
        dst = dst.separable();
    }

    Ok(dst)
}

/// `isTessellationPresent`
fn is_tessellation_present(spec: &CaseSpec) -> bool {
    let tessellation_bits = (1 << (ShaderType::TessControl as u32)) | (1 << (ShaderType::TessEvaluation as u32));

    if spec.programs[0].separable {
        spec.programs.iter().any(|p| p.active_stages & tessellation_bits != 0)
    } else {
        spec.programs[0].source_for(ShaderType::TessControl).is_some()
            || spec.programs[0].source_for(ShaderType::TessEvaluation).is_some()
    }
}

/// `isTessellationSupported`
fn is_tessellation_supported(context: &Context) -> bool {
    context.context_type().supports(3, 2)
        || context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
}

/// `checkPixels` - the whole quad must come out white; all-black is the shader reporting a
/// mismatch, anything else is a driver that did not render what it was asked to.
fn check_pixels(surface: &Surface, x0: i32, y0: i32, width: i32, height: i32) -> bool {
    let mut all_white = true;
    let mut all_black = true;
    let mut any_unexpected = false;

    for y in y0..y0 + height {
        for x in x0..x0 + width {
            let pixel = surface.get_pixel(x, y);
            // \note alpha is deliberately not part of the comparison.
            let is_white = pixel.get_red() == 255 && pixel.get_green() == 255 && pixel.get_blue() == 255;
            let is_black = pixel.get_red() == 0 && pixel.get_green() == 0 && pixel.get_blue() == 0;

            all_white = all_white && is_white;
            all_black = all_black && is_black;
            any_unexpected = any_unexpected || (!is_white && !is_black);
        }
    }

    if !all_white {
        if any_unexpected {
            log::debug!("WARNING: expecting all rendered pixels to be white or black, but got other colors as well!");
        } else if !all_black {
            log::debug!("WARNING: got inconsistent results over the image, when all pixels should be the same color!");
        }
        return false;
    }

    true
}

/// `setUniformValue`
fn set_uniform_value(context: &Context, pipeline_programs: &[GLuint], name: &str, val: &Value, array_ndx: usize) {
    use DataType::*;

    let gl = context.gl();
    let scalar_size = val.data_type.scalar_size() as usize;
    let elem_ndx = array_ndx * scalar_size;
    let c_name = std::ffi::CString::new(name).expect("a uniform name has no interior NUL");
    let mut found_any_match = false;

    // The values are handed to GL as the union upstream stores them in: a float type reads
    // the float half, everything else (including bool) the int half.
    let floats: Vec<f32> = (0..scalar_size).map(|n| val.elements.as_float(elem_ndx + n)).collect();
    let ints: Vec<GLint> = match val.elements {
        Elements::Int(v) => v[elem_ndx..elem_ndx + scalar_size].to_vec(),
        Elements::Float(v) => v[elem_ndx..elem_ndx + scalar_size]
            .iter()
            .map(|&f| f as GLint)
            .collect(),
    };

    for &program in pipeline_programs {
        // SAFETY: a NUL-terminated name and a program this case built.
        let loc = unsafe { gl.get_uniform_location(program, c_name.as_ptr()) };
        if loc == -1 {
            continue;
        }
        found_any_match = true;

        // SAFETY: each call is given exactly `scalar_size` scalars, which is what the
        // uniform's own type holds.
        unsafe {
            gl.use_program(program);

            let f = floats.as_ptr();
            let i = ints.as_ptr();
            match val.data_type {
                Float => gl.uniform_1fv(loc, 1, f),
                FloatVec2 => gl.uniform_2fv(loc, 1, f),
                FloatVec3 => gl.uniform_3fv(loc, 1, f),
                FloatVec4 => gl.uniform_4fv(loc, 1, f),
                FloatMat2 => gl.uniform_matrix_2fv(loc, 1, glw::FALSE, f),
                FloatMat3 => gl.uniform_matrix_3fv(loc, 1, glw::FALSE, f),
                FloatMat4 => gl.uniform_matrix_4fv(loc, 1, glw::FALSE, f),
                FloatMat2x3 => gl.uniform_matrix_2x_3fv(loc, 1, glw::FALSE, f),
                FloatMat2x4 => gl.uniform_matrix_2x_4fv(loc, 1, glw::FALSE, f),
                FloatMat3x2 => gl.uniform_matrix_3x_2fv(loc, 1, glw::FALSE, f),
                FloatMat3x4 => gl.uniform_matrix_3x_4fv(loc, 1, glw::FALSE, f),
                FloatMat4x2 => gl.uniform_matrix_4x_2fv(loc, 1, glw::FALSE, f),
                FloatMat4x3 => gl.uniform_matrix_4x_3fv(loc, 1, glw::FALSE, f),
                Int | Bool => gl.uniform_1iv(loc, 1, i),
                IntVec2 | BoolVec2 => gl.uniform_2iv(loc, 1, i),
                IntVec3 | BoolVec3 => gl.uniform_3iv(loc, 1, i),
                IntVec4 | BoolVec4 => gl.uniform_4iv(loc, 1, i),
                Uint => gl.uniform_1uiv(loc, 1, i.cast()),
                UintVec2 => gl.uniform_2uiv(loc, 1, i.cast()),
                UintVec3 => gl.uniform_3uiv(loc, 1, i.cast()),
                UintVec4 => gl.uniform_4uiv(loc, 1, i.cast()),
                other => unreachable!("no uniform setter for {other:?}"),
            }
        }
    }

    if !found_any_match {
        log::debug!(
            "WARNING // Uniform \"{name}\" location is not valid, location = -1. Cannot set value to the uniform."
        );
    }
}

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;

/// `gls::ShaderLibraryCase`
pub struct ShaderLibraryCase {
    name: String,
    spec: CaseSpec,
}

impl ShaderLibraryCase {
    pub fn new(name: impl Into<String>, spec: CaseSpec) -> Self {
        Self {
            name: name.into(),
            spec,
        }
    }

    /// `ShaderLibraryCase::init` - the version and limit checks, plus the log line saying
    /// what the case expects to happen.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supported = context.context_type().supports_api(self.spec.target_version.min_api());

        if !supported {
            return Err(TestError::NotSupported(format!(
                "{} is not supported",
                self.spec.target_version.declaration()
            )));
        }

        check_implementation_limits(self.spec.required_caps, context)?;

        match self.spec.expect_result {
            ExpectResult::Pass => {}
            ExpectResult::CompileFail => log::debug!("Expecting shader compilation to fail."),
            ExpectResult::LinkFail => log::debug!("Expecting program linking to fail."),
            ExpectResult::CompileLinkFail => {
                log::debug!("Expecting either shader compilation or program linking to fail.")
            }
            ExpectResult::ValidationFail => log::debug!("Expecting program validation to fail."),
            ExpectResult::BuildSuccessful => {
                log::debug!(
                    "Expecting shader compilation and program linking to succeed. Resulting program will not be executed."
                );
            }
        }

        Ok(())
    }
}

impl TestCase for ShaderLibraryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        self.check_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        execute(&self.name, &self.spec, context)
    }
}

/// `ShaderLibraryCase::execute`
fn execute(case_name: &str, spec: &CaseSpec, context: &Context) -> TestOutcome {
    const QUAD_SIZE: f32 = 1.0;
    #[rustfmt::skip]
    const POSITIONS: [f32; 16] = [
        -QUAD_SIZE, -QUAD_SIZE, 0.0, 1.0,
        -QUAD_SIZE,  QUAD_SIZE, 0.0, 1.0,
         QUAD_SIZE, -QUAD_SIZE, 0.0, 1.0,
         QUAD_SIZE,  QUAD_SIZE, 0.0, 1.0,
    ];
    const INDICES: [u16; 6] = [0, 1, 2, 1, 3, 2];
    const NUM_VERTICES_PER_DRAW: i32 = 4;

    let gl = context.gl();

    if is_capability_required(spec, RequiredCapability::OnlyGlslEs100Support) && glu::is_es3_compatible(gl) {
        return Ok(TestStatus::pass("Pass"));
    }

    if is_capability_required(spec, RequiredCapability::ExactlyOneDrawBuffer) {
        // On unextended ES 2 there is one draw buffer and no `GL_MAX_DRAW_BUFFERS` query,
        // so the query failing is itself the answer.
        let mut max_draw_buffers: GLint = 0;
        // SAFETY: one GLint out.
        let ok = unsafe {
            gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers);
            gl.get_error() == glw::GL_NO_ERROR
        };
        if ok && max_draw_buffers > 1 {
            return Err(TestError::NotSupported(
                "Test requires exactly one draw buffer".to_string(),
            ));
        }
    }

    let render_target = context.render_target();
    let mut rnd = Random::new(de_string_hash(case_name));
    let width = render_target.width.min(VIEWPORT_WIDTH);
    let height = render_target.height.min(VIEWPORT_HEIGHT);
    let viewport_x = rnd.get_int(0, render_target.width - width);
    let viewport_y = rnd.get_int(0, render_target.height - height);

    let tessellation_present = is_tessellation_present(spec);
    let separable_programs = spec.programs[0].separable;

    // Specialize the shaders.
    let max_patch_vertices = if tessellation_present && is_tessellation_supported(context) {
        let mut value: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_MAX_PATCH_VERTICES, &mut value) };
        value
    } else {
        0
    };

    let mut specialized_sources: Vec<ProgramSources> = Vec::with_capacity(spec.programs.len());

    match spec.case_type {
        CaseType::VertexOnly => {
            let ext = check_and_specialize_extensions(spec.programs[0].required_extensions, context)?;
            let src = spec.programs[0]
                .source_for(ShaderType::Vertex)
                .expect("a vertex-only case has a vertex shader");
            specialized_sources.push(
                ProgramSources::default()
                    .with(ShaderType::Vertex, specialize_vertex_shader(spec, src, &ext)?)
                    .with(ShaderType::Fragment, gen_fragment_shader(spec)),
            );
        }

        CaseType::FragmentOnly => {
            let ext = check_and_specialize_extensions(spec.programs[0].required_extensions, context)?;
            let src = spec.programs[0]
                .source_for(ShaderType::Fragment)
                .expect("a fragment-only case has a fragment shader");
            specialized_sources.push(
                ProgramSources::default()
                    .with(ShaderType::Vertex, gen_vertex_shader(spec))
                    .with(ShaderType::Fragment, specialize_fragment_shader(spec, src, &ext)?),
            );
        }

        CaseType::Complete => {
            for program in spec.programs {
                let ext = check_and_specialize_extensions(program.required_extensions, context)?;
                specialized_sources.push(specialize_program_sources(program, spec, &ext, max_patch_vertices)?);
            }
        }
    }

    // Build.
    let mut all_compiles_ok = true;
    let mut all_links_ok = true;
    let mut vertex_program_id = 0;
    let mut pipeline_program_ids = Vec::with_capacity(specialized_sources.len());
    let mut programs = Vec::with_capacity(specialized_sources.len());

    // The driver's own error is never a warning of its own here: for a negative case - a
    // `vector_illegal` conversion, a `negative` shader-library case - failing to build *is*
    // the expected result, and for every other case it goes into the failure message below.
    let mut build_failure = None;

    for (ndx, sources) in specialized_sources.iter().enumerate() {
        let program = ShaderProgram::new_reporting_build_failure(gl, sources);
        if build_failure.is_none() {
            build_failure = program.build_failure_summary();
        }

        if !separable_programs || spec.programs[ndx].active_stages & (1 << (ShaderType::Vertex as u32)) != 0 {
            vertex_program_id = program.program();
        }
        pipeline_program_ids.push(program.program());

        if program.shader_info.iter().any(|(_, info)| !info.ok) {
            all_compiles_ok = false;
        }
        if !program.program_info.ok {
            all_links_ok = false;
        }

        programs.push(program);
    }

    let fail_reason = match spec.expect_result {
        ExpectResult::Pass | ExpectResult::ValidationFail | ExpectResult::BuildSuccessful => {
            if !all_compiles_ok {
                Some("expected shaders to compile and link properly, but failed to compile.")
            } else if !all_links_ok {
                Some("expected shaders to compile and link properly, but failed to link.")
            } else {
                None
            }
        }

        ExpectResult::CompileFail => {
            if all_compiles_ok && !all_links_ok {
                Some("expected compilation to fail, but shaders compiled and link failed.")
            } else if all_compiles_ok {
                Some("expected compilation to fail, but shaders compiled correctly.")
            } else {
                None
            }
        }

        ExpectResult::LinkFail => {
            if !all_compiles_ok {
                Some("expected linking to fail, but unable to compile.")
            } else if all_links_ok {
                Some("expected linking to fail, but passed.")
            } else {
                None
            }
        }

        ExpectResult::CompileLinkFail => {
            if all_compiles_ok && all_links_ok {
                Some("expected compile or link to fail, but passed.")
            } else {
                None
            }
        }
    };

    if let Some(reason) = fail_reason {
        // Upstream's wording says which expectation was missed; the driver's own message
        // says why, and is the half that has to survive into `--output`.
        let reason = match &build_failure {
            Some(detail) => format!("{reason} {detail}"),
            None => reason.to_string(),
        };
        log::debug!("ERROR: {reason}");

        if is_capability_required(spec, RequiredCapability::FullGlslEs100Support) {
            log::debug!(
                "Assuming build failure is caused by implementation not supporting full GLSL ES 100 specification, which is not required."
            );

            // The feature is detectable at compile time, so a driver that only notices at
            // link time is a quality warning rather than a missing feature.
            if all_compiles_ok && !all_links_ok {
                return Ok(TestStatus::new(crate::tcu::TestResult::QualityWarning, reason));
            }
            return Err(TestError::NotSupported("Full GLSL ES 100 is not supported".to_string()));
        }

        // A driver that only parses the shader at link time reports the failure one stage
        // later than the case asked for; that is a quality warning, not a defect.
        if spec.expect_result == ExpectResult::CompileFail && all_compiles_ok && !all_links_ok {
            return Ok(TestStatus::new(crate::tcu::TestResult::QualityWarning, reason));
        }
        return Ok(TestStatus::fail(reason));
    }

    // Return if the shader is not intended to be run.
    if matches!(
        spec.expect_result,
        ExpectResult::CompileFail
            | ExpectResult::CompileLinkFail
            | ExpectResult::LinkFail
            | ExpectResult::BuildSuccessful
    ) {
        return Ok(TestStatus::pass("Pass"));
    }

    // SAFETY: a viewport inside the render target, and a program this case built.
    unsafe { gl.viewport(viewport_x, viewport_y, width, height) };

    let pipeline = if separable_programs {
        let pipeline = ProgramPipeline::new(gl);
        // SAFETY: every program below is one this case built, and the stage bits come from
        // the case's own spec.
        unsafe {
            gl.bind_program_pipeline(pipeline.get());
            for (ndx, program_id) in pipeline_program_ids.iter().enumerate() {
                let mut shader_flags = 0;
                for stage in [
                    ShaderType::Vertex,
                    ShaderType::Fragment,
                    ShaderType::Geometry,
                    ShaderType::TessControl,
                    ShaderType::TessEvaluation,
                    ShaderType::Compute,
                ] {
                    if spec.programs[ndx].active_stages & (1 << (stage as u32)) != 0 {
                        shader_flags |= gl_shader_type_bit(stage);
                    }
                }
                gl.use_program_stages(pipeline.get(), shader_flags, *program_id);
            }
            gl.active_shader_program(pipeline.get(), vertex_program_id);
        }
        glu::expect_no_error(gl, "setup pipeline")?;
        Some(pipeline)
    } else {
        // SAFETY: a program this case built.
        unsafe { gl.use_program(vertex_program_id) };
        glu::expect_no_error(gl, "glUseProgram()")?;
        None
    };

    // Fetch the position attribute's location.
    let position_name = std::ffi::CString::new("dEQP_Position").expect("no interior NUL");
    // SAFETY: a NUL-terminated name and a program this case built.
    let position_loc = unsafe { gl.get_attrib_location(vertex_program_id, position_name.as_ptr()) };
    if position_loc == -1 {
        return Err(TestError::Fail(
            "no location found for attribute 'dEQP_Position'".to_string(),
        ));
    }

    let values = &spec.values;
    // Render at least one pass even when there is no input/output data at all.
    let num_render_passes = if values.outputs.is_empty() {
        1
    } else {
        values.outputs[0].elements.len() / values.outputs[0].data_type.scalar_size() as usize
    };

    for array_ndx in 0..num_render_passes {
        // Every attribute value is replicated once per vertex, so the whole quad reads the
        // same value and the comparison is a solid colour.
        let mut attrib_values: Vec<Vec<f32>> = Vec::with_capacity(values.inputs.len());
        for val in values.inputs {
            let scalar_size = val.data_type.scalar_size() as usize;
            let mut scalars = vec![0.0; NUM_VERTICES_PER_DRAW as usize * scalar_size];
            for rep_ndx in 0..NUM_VERTICES_PER_DRAW as usize {
                for ndx in 0..scalar_size {
                    scalars[rep_ndx * scalar_size + ndx] = val.elements.as_float(array_ndx * scalar_size + ndx);
                }
            }
            attrib_values.push(scalars);
        }

        let mut vertex_arrays = vec![glu::va::float_at(
            position_loc as u32,
            4,
            NUM_VERTICES_PER_DRAW,
            0,
            &POSITIONS,
        )];

        for (val_ndx, val) in values.inputs.iter().enumerate() {
            let scalar_size = val.data_type.scalar_size();

            // A fragment-only case takes even a float input through an `a_`-prefixed
            // attribute, because the generated vertex shader is the one declaring it.
            let attrib_prefix =
                if spec.case_type == CaseType::FragmentOnly || val.data_type.scalar_type() != DataType::Float {
                    "a_"
                } else {
                    ""
                };
            let attrib_name = format!("{attrib_prefix}{}", val.name);
            let c_attrib_name = std::ffi::CString::new(attrib_name.as_str()).expect("no interior NUL");
            // SAFETY: a NUL-terminated name and a program this case built.
            let attrib_loc = unsafe { gl.get_attrib_location(vertex_program_id, c_attrib_name.as_ptr()) };

            if attrib_loc == -1 {
                log::debug!("Warning: no location found for attribute '{attrib_name}'");
                continue;
            }

            if val.data_type.is_matrix() {
                let num_cols = val.data_type.matrix_num_columns();
                let num_rows = val.data_type.matrix_num_rows();
                debug_assert_eq!(scalar_size, num_cols * num_rows);

                for col in 0..num_cols {
                    vertex_arrays.push(glu::va::float_at(
                        (attrib_loc + col) as u32,
                        num_rows,
                        NUM_VERTICES_PER_DRAW,
                        scalar_size * size_of::<f32>() as i32,
                        &attrib_values[val_ndx][(col * num_rows) as usize..],
                    ));
                }
            } else {
                vertex_arrays.push(glu::va::float_at(
                    attrib_loc as u32,
                    scalar_size,
                    NUM_VERTICES_PER_DRAW,
                    0,
                    &attrib_values[val_ndx],
                ));
            }
        }

        // Reference values for the outputs, then the uniforms.
        for val in values.outputs {
            set_uniform_value(
                context,
                &pipeline_program_ids,
                &format!("ref_{}", val.name),
                val,
                array_ndx,
            );
        }
        for val in values.uniforms {
            set_uniform_value(context, &pipeline_program_ids, val.name, val, array_ndx);
        }

        // SAFETY: plain state setting.
        unsafe {
            gl.clear_color(0.125, 0.25, 0.5, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            if separable_programs {
                gl.use_program(0);
            } else {
                gl.use_program(vertex_program_id);
            }

            if tessellation_present {
                gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            }
        }

        let primitives = if tessellation_present {
            glu::pr::patches(&INDICES)
        } else {
            glu::pr::triangles(&INDICES)
        };
        glu::draw(&context.render_context, vertex_program_id, &vertex_arrays, &primitives)?;

        // SAFETY: no out parameters.
        let post_draw_error = unsafe { gl.get_error() };

        if spec.expect_result == ExpectResult::Pass {
            if post_draw_error != glw::GL_NO_ERROR {
                return Err(TestError::Fail(format!("draw: got GL error {post_draw_error:#x}")));
            }

            let mut surface = Surface::new(width, height);
            glu::read_pixels(
                &context.render_context,
                viewport_x,
                viewport_y,
                &mut surface.get_access(),
            )?;

            // The quad covers the whole viewport; the sub-region skips the edge pixels,
            // where rasterisation may or may not have covered the sample.
            let w = POSITIONS[3];
            let min_y = (((-QUAD_SIZE / w) * 0.5 + 0.5) * height as f32 + 1.0).ceil() as i32;
            let max_y = (((QUAD_SIZE / w) * 0.5 + 0.5) * height as f32 - 0.5).floor() as i32;
            let min_x = (((-QUAD_SIZE / w) * 0.5 + 0.5) * width as f32 + 1.0).ceil() as i32;
            let max_x = (((QUAD_SIZE / w) * 0.5 + 0.5) * width as f32 - 0.5).floor() as i32;

            if !check_pixels(&surface, min_x, min_y, max_x - min_x + 1, max_y - min_y + 1) {
                log::debug!(
                    "INCORRECT RESULT for sub-case {} of {num_render_passes}):",
                    array_ndx + 1
                );
                // SAFETY: plain state setting.
                unsafe { gl.use_program(0) };
                return Ok(TestStatus::fail("Image comparison failed"));
            }
        } else if spec.expect_result == ExpectResult::ValidationFail {
            // \note upstream validates the pipeline in a draw callback; here the draw has
            // already happened, so the validation status is queried around it instead.
            let mut validate_status: GLint = 0;
            // SAFETY: one GLint out, on an object this case owns.
            unsafe {
                match &pipeline {
                    Some(p) => {
                        gl.validate_program_pipeline(p.get());
                        gl.get_program_pipelineiv(p.get(), glw::GL_VALIDATE_STATUS, &mut validate_status);
                    }
                    None => {
                        gl.validate_program(vertex_program_id);
                        gl.get_programiv(vertex_program_id, glw::GL_VALIDATE_STATUS, &mut validate_status);
                    }
                }
            }

            log::debug!(
                "Draw call generated error: {post_draw_error:#x} {}\nValidate status: {validate_status}",
                if post_draw_error == glw::GL_INVALID_OPERATION {
                    "(expected)"
                } else {
                    "(unexpected)"
                }
            );

            if post_draw_error != glw::GL_NO_ERROR && post_draw_error != glw::GL_INVALID_OPERATION {
                return Ok(TestStatus::fail(format!(
                    "Draw: got unexpected error: {post_draw_error:#x}"
                )));
            }

            if validate_status != 0 {
                return Ok(TestStatus::fail(if post_draw_error == glw::GL_NO_ERROR {
                    "expected validation and rendering to fail but validation and rendering succeeded"
                } else {
                    "expected validation and rendering to fail but validation succeeded (rendering failed as expected)"
                }));
            }

            if post_draw_error == glw::GL_NO_ERROR {
                return Ok(TestStatus::fail(
                    "expected validation and rendering to fail but rendering succeeded (validation failed as expected)",
                ));
            }

            // Validation does not depend on the input values, so one pass is enough.
            break;
        }
    }

    // SAFETY: plain state setting.
    unsafe {
        gl.use_program(0);
        if separable_programs {
            gl.bind_program_pipeline(0);
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `glu::getGLShaderTypeBit`
fn gl_shader_type_bit(shader_type: ShaderType) -> glw::GLbitfield {
    match shader_type {
        ShaderType::Vertex => glw::GL_VERTEX_SHADER_BIT,
        ShaderType::Fragment => glw::GL_FRAGMENT_SHADER_BIT,
        ShaderType::Geometry => glw::GL_GEOMETRY_SHADER_BIT,
        ShaderType::TessControl => glw::GL_TESS_CONTROL_SHADER_BIT,
        ShaderType::TessEvaluation => glw::GL_TESS_EVALUATION_SHADER_BIT,
        ShaderType::Compute => glw::GL_COMPUTE_SHADER_BIT,
    }
}
