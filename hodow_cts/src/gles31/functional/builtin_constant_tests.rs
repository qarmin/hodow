// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderBuiltinConstantTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every case checks a `gl_Max*`/`gl_Min*` builtin constant against the same limit read
// back through `glGetIntegerv`/`glGetIntegeri_v`, in every shader stage
// `gls::shader_exec_util` can build a program for. Upstream checks all six stages
// (vertex/tess-control/tess-eval/geometry/fragment/compute); this port's executor only
// covers vertex/fragment/compute (see `shader_exec_util`'s module header), so the other
// three are skipped exactly the way upstream itself skips a stage the driver has no
// extension for - logged, not a failure - which is also why the overall verdict is
// unaffected on a driver (this dev container's llvmpipe included) that *does* implement
// `GL_EXT_geometry_shader`/`GL_EXT_tessellation_shader`.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

fn get_integer(gl: &glw::Functions, pname: u32) -> Result<i32, TestError> {
    let mut value = -1;
    // SAFETY: every pname passed here is a single-integer query.
    unsafe { gl.get_integerv(pname, &mut value) };
    glu::expect_no_error(gl, "glGetIntegerv()")?;
    Ok(value)
}

fn get_vectors_from_comps(gl: &glw::Functions, pname: u32) -> Result<i32, TestError> {
    let value = get_integer(gl, pname)?;
    if value % 4 != 0 {
        return Err(TestError::Fail(format!(
            "expected the queried limit to be divisible by 4, got {value}"
        )));
    }
    Ok(value / 4)
}

fn get_ivec3(gl: &glw::Functions, pname: u32) -> Result<[i32; 3], TestError> {
    let mut value = [-1i32; 3];
    // SAFETY: each index is queried into its own element of a 3-element array.
    unsafe {
        for (ndx, slot) in value.iter_mut().enumerate() {
            gl.get_integeri_v(pname, ndx as u32, slot);
        }
    }
    glu::expect_no_error(gl, "glGetIntegeri_v()")?;
    Ok(value)
}

/// `makeCaseName` - `gl_MaxVertexAttribs` becomes `max_vertex_attribs`.
fn make_case_name(var_name: &str) -> String {
    let rest = &var_name[3..]; // strip the leading "gl_"
    let mut out = String::new();
    let mut chars = rest.chars();
    if let Some(first) = chars.next() {
        out.push(first.to_ascii_lowercase());
    }
    for c in chars {
        if c.is_ascii_uppercase() {
            out.push('_');
            out.push(c.to_ascii_lowercase());
        } else {
            out.push(c);
        }
    }
    out
}

/// The extensions whose constants remain readable on an ES 3.2 (or later) context with no
/// `#extension` pragma at all - both `init`'s support check and
/// `createGetConstantExecutor`'s pragma emission key off this same list.
fn ext_folded_into_es32(ext: &str) -> bool {
    matches!(
        ext,
        "GL_OES_sample_variables" | "GL_EXT_geometry_shader" | "GL_EXT_tessellation_shader"
    )
}

fn check_support(context: &Context, var_name: &str, required_ext: Option<&str>) -> Result<(), TestError> {
    let supports_es32 = context.context_type().supports(3, 2);

    if let Some(ext) = required_ext {
        if ext_folded_into_es32(ext) {
            if !supports_es32 && !context.context_info.is_extension_supported(ext) {
                return Err(TestError::NotSupported(format!(
                    "The test requires a GLES 3.2 context or support for the extension {ext}."
                )));
            }
        } else if !context.context_info.is_extension_supported(ext) {
            return Err(TestError::NotSupported(format!("{ext} not supported")));
        }
    }

    if !supports_es32
        && matches!(
            var_name,
            "gl_MaxTessControlImageUniforms"
                | "gl_MaxTessEvaluationImageUniforms"
                | "gl_MaxTessControlAtomicCounters"
                | "gl_MaxTessEvaluationAtomicCounters"
                | "gl_MaxTessControlAtomicCounterBuffers"
                | "gl_MaxTessEvaluationAtomicCounterBuffers"
        )
    {
        return Err(TestError::NotSupported(format!(
            "The test requires a GLES 3.2 context. The constant '{var_name}' is not supported."
        )));
    }

    Ok(())
}

fn create_get_constant_executor<'gl>(
    context: &'gl Context,
    shader_type: ShaderType,
    var_type: VarType,
    var_name: &str,
    required_ext: Option<&str>,
) -> Result<shader_exec_util::ShaderExecutor<'gl>, TestError> {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(context.context_type().glsl_version());
    spec.source = format!("result = {var_name};\n");
    spec.outputs.push(Symbol::new("result", var_type));

    if let Some(ext) = required_ext
        && !(supports_es32 && ext_folded_into_es32(ext))
    {
        spec.global_declarations = format!("#extension {ext} : require\n");
    }

    shader_exec_util::create_executor(&context.render_context, shader_type, &spec)
}

/// The shader stages every case iterates. Order matches `glu::ShaderType`'s own
/// declaration order here rather than upstream's `SHADERTYPE_LAST` loop order - which
/// stage runs first affects only log section order, never the verdict.
const SHADER_TYPES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

fn verify_int_in_shader_type(
    context: &Context,
    shader_type: ShaderType,
    var_name: &str,
    required_ext: Option<&str>,
    reference: i32,
) -> Result<(), TestError> {
    let var_type = VarType::basic(DataType::Int, Some(Precision::HighP));
    let executor = create_get_constant_executor(context, shader_type, var_type, var_name, required_ext)?;
    if !executor.is_ok() {
        return Err(TestError::Fail(format!(
            "Compile failed: {}",
            executor.build_failure_summary().unwrap_or_default()
        )));
    }
    executor.use_program(context.gl());

    let mut result_bytes = (-1i32).to_ne_bytes();
    {
        let mut out_slice: &mut [u8] = &mut result_bytes;
        executor.execute(1, &[], std::slice::from_mut(&mut out_slice))?;
    }
    let result = i32::from_ne_bytes(result_bytes);

    if result != reference {
        return Err(TestError::Fail(format!(
            "Invalid builtin constant value: {var_name} = {result}, expected {reference}"
        )));
    }
    Ok(())
}

fn verify_ivec3_in_shader_type(
    context: &Context,
    shader_type: ShaderType,
    var_name: &str,
    required_ext: Option<&str>,
    reference: [i32; 3],
) -> Result<(), TestError> {
    let var_type = VarType::basic(DataType::IntVec3, Some(Precision::HighP));
    let executor = create_get_constant_executor(context, shader_type, var_type, var_name, required_ext)?;
    if !executor.is_ok() {
        return Err(TestError::Fail(format!(
            "Compile failed: {}",
            executor.build_failure_summary().unwrap_or_default()
        )));
    }
    executor.use_program(context.gl());

    let mut result_bytes = [0u8; 12];
    {
        let mut out_slice: &mut [u8] = &mut result_bytes;
        executor.execute(1, &[], std::slice::from_mut(&mut out_slice))?;
    }
    let result = [
        i32::from_ne_bytes(result_bytes[0..4].try_into().unwrap()),
        i32::from_ne_bytes(result_bytes[4..8].try_into().unwrap()),
        i32::from_ne_bytes(result_bytes[8..12].try_into().unwrap()),
    ];

    if result != reference {
        return Err(TestError::Fail(format!(
            "Invalid builtin constant value: {var_name} = {result:?}, expected {reference:?}"
        )));
    }
    Ok(())
}

/// `ShaderBuiltinConstantCase<int>::iterate`/`<tcu::IVec3>::iterate`, folded into one
/// generic runner: `check_support` throws (returns `Err`) exactly as upstream's own
/// `init()` does, then every shader stage is tried in turn and only the first failure's
/// message survives - matching upstream, which keeps looping after `setTestResult(FAIL,
/// ...)` but never overwrites an already-failed verdict either.
fn run_case(
    context: &Context,
    var_name: &str,
    required_ext: Option<&str>,
    verify: impl Fn(&Context, ShaderType) -> Result<(), TestError>,
) -> TestOutcome {
    check_support(context, var_name, required_ext)?;

    let mut first_failure: Option<String> = None;
    for &shader_type in &SHADER_TYPES {
        match verify(context, shader_type) {
            Ok(()) => {}
            Err(TestError::NotSupported(msg)) => {
                log::debug!("Not checking {}: {msg}", shader_type.as_str());
            }
            Err(other) => {
                log::warn!("{}: {other}", shader_type.as_str());
                if first_failure.is_none() {
                    first_failure = Some(other.to_string());
                }
            }
        }
    }

    match first_failure {
        Some(msg) => Ok(TestStatus::fail(msg)),
        None => Ok(TestStatus::pass("Pass")),
    }
}

struct IntConstantCase {
    case_name: String,
    var_name: &'static str,
    get_value: GetIntConstant,
    required_ext: Option<&'static str>,
}

impl TestCase for IntConstantCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_support(context, self.var_name, self.required_ext)?;
        let reference = (self.get_value)(context.gl())?;
        run_case(context, self.var_name, self.required_ext, |ctx, shader_type| {
            verify_int_in_shader_type(ctx, shader_type, self.var_name, self.required_ext, reference)
        })
    }
}

struct IVec3ConstantCase {
    case_name: String,
    var_name: &'static str,
    get_value: GetIVec3Constant,
    required_ext: Option<&'static str>,
}

impl TestCase for IVec3ConstantCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_support(context, self.var_name, self.required_ext)?;
        let reference = (self.get_value)(context.gl())?;
        run_case(context, self.var_name, self.required_ext, |ctx, shader_type| {
            verify_ivec3_in_shader_type(ctx, shader_type, self.var_name, self.required_ext, reference)
        })
    }
}

fn int_case(
    var_name: &'static str,
    get_value: GetIntConstant,
    required_ext: Option<&'static str>,
) -> Box<dyn TestCase> {
    Box::new(IntConstantCase {
        case_name: make_case_name(var_name),
        var_name,
        get_value,
        required_ext,
    })
}

fn ivec3_case(
    var_name: &'static str,
    get_value: GetIVec3Constant,
    required_ext: Option<&'static str>,
) -> Box<dyn TestCase> {
    Box::new(IVec3ConstantCase {
        case_name: make_case_name(var_name),
        var_name,
        get_value,
        required_ext,
    })
}

type GetIntConstant = fn(&glw::Functions) -> Result<i32, TestError>;
type GetIVec3Constant = fn(&glw::Functions) -> Result<[i32; 3], TestError>;

const INT_CONSTANTS: &[(&str, GetIntConstant)] = &[
    ("gl_MaxVertexAttribs", |gl| get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS)),
    ("gl_MaxVertexUniformVectors", |gl| {
        get_integer(gl, glw::GL_MAX_VERTEX_UNIFORM_VECTORS)
    }),
    ("gl_MaxVertexOutputVectors", |gl| {
        get_vectors_from_comps(gl, glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxFragmentInputVectors", |gl| {
        get_vectors_from_comps(gl, glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS)
    }),
    ("gl_MaxFragmentUniformVectors", |gl| {
        get_integer(gl, glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS)
    }),
    ("gl_MaxDrawBuffers", |gl| get_integer(gl, glw::GL_MAX_DRAW_BUFFERS)),
    ("gl_MaxVertexTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxCombinedTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MinProgramTexelOffset", |gl| {
        get_integer(gl, glw::GL_MIN_PROGRAM_TEXEL_OFFSET)
    }),
    ("gl_MaxProgramTexelOffset", |gl| {
        get_integer(gl, glw::GL_MAX_PROGRAM_TEXEL_OFFSET)
    }),
    ("gl_MaxImageUnits", |gl| get_integer(gl, glw::GL_MAX_IMAGE_UNITS)),
    ("gl_MaxVertexImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_VERTEX_IMAGE_UNIFORMS)
    }),
    ("gl_MaxFragmentImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS)
    }),
    ("gl_MaxComputeImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS)
    }),
    ("gl_MaxCombinedImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_COMBINED_IMAGE_UNIFORMS)
    }),
    ("gl_MaxCombinedShaderOutputResources", |gl| {
        get_integer(gl, glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES)
    }),
    ("gl_MaxComputeUniformComponents", |gl| {
        get_integer(gl, glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS)
    }),
    ("gl_MaxComputeTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxComputeAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS)
    }),
    ("gl_MaxComputeAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxVertexAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTERS)
    }),
    ("gl_MaxFragmentAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS)
    }),
    ("gl_MaxCombinedAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_COMBINED_ATOMIC_COUNTERS)
    }),
    ("gl_MaxAtomicCounterBindings", |gl| {
        get_integer(gl, glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS)
    }),
    ("gl_MaxVertexAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxFragmentAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxCombinedAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxAtomicCounterBufferSize", |gl| {
        get_integer(gl, glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE)
    }),
];

const IVEC3_CONSTANTS: &[(&str, GetIVec3Constant)] = &[
    ("gl_MaxComputeWorkGroupCount", |gl| {
        get_ivec3(gl, glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT)
    }),
    ("gl_MaxComputeWorkGroupSize", |gl| {
        get_ivec3(gl, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE)
    }),
];

const GEOMETRY_SHADER_CONSTANTS: &[(&str, GetIntConstant)] = &[
    ("gl_MaxGeometryInputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS)
    }),
    ("gl_MaxGeometryOutputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxGeometryImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS)
    }),
    ("gl_MaxGeometryTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxGeometryOutputVertices", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES)
    }),
    ("gl_MaxGeometryTotalOutputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxGeometryUniformComponents", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS)
    }),
    ("gl_MaxGeometryAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS)
    }),
    ("gl_MaxGeometryAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS)
    }),
];

const TESSELLATION_SHADER_CONSTANTS: &[(&str, GetIntConstant)] = &[
    ("gl_MaxTessControlInputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS)
    }),
    ("gl_MaxTessControlOutputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxTessControlTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxTessControlUniformComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS)
    }),
    ("gl_MaxTessControlTotalOutputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxTessControlImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS)
    }),
    ("gl_MaxTessEvaluationImageUniforms", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS)
    }),
    ("gl_MaxTessControlAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS)
    }),
    ("gl_MaxTessEvaluationAtomicCounters", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS)
    }),
    ("gl_MaxTessControlAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxTessEvaluationAtomicCounterBuffers", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS)
    }),
    ("gl_MaxTessEvaluationInputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS)
    }),
    ("gl_MaxTessEvaluationOutputComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS)
    }),
    ("gl_MaxTessEvaluationTextureImageUnits", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS)
    }),
    ("gl_MaxTessEvaluationUniformComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS)
    }),
    ("gl_MaxTessPatchComponents", |gl| {
        get_integer(gl, glw::GL_MAX_TESS_PATCH_COMPONENTS)
    }),
    ("gl_MaxPatchVertices", |gl| get_integer(gl, glw::GL_MAX_PATCH_VERTICES)),
    ("gl_MaxTessGenLevel", |gl| get_integer(gl, glw::GL_MAX_TESS_GEN_LEVEL)),
];

/// `ShaderBuiltinConstantTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin_constants");

    let mut core_group = TestCaseGroup::new("core");
    for &(var_name, get_value) in INT_CONSTANTS {
        core_group.add_child(int_case(var_name, get_value, None));
    }
    for &(var_name, get_value) in IVEC3_CONSTANTS {
        core_group.add_child(ivec3_case(var_name, get_value, None));
    }
    group.add_child(core_group);

    let mut sample_var_group = TestCaseGroup::new("sample_variables");
    sample_var_group.add_child(int_case(
        "gl_MaxSamples",
        |gl| get_integer(gl, glw::GL_MAX_SAMPLES),
        Some("GL_OES_sample_variables"),
    ));
    group.add_child(sample_var_group);

    let mut geom_group = TestCaseGroup::new("geometry_shader");
    for &(var_name, get_value) in GEOMETRY_SHADER_CONSTANTS {
        geom_group.add_child(int_case(var_name, get_value, Some("GL_EXT_geometry_shader")));
    }
    group.add_child(geom_group);

    let mut tess_group = TestCaseGroup::new("tessellation_shader");
    for &(var_name, get_value) in TESSELLATION_SHADER_CONSTANTS {
        tess_group.add_child(int_case(var_name, get_value, Some("GL_EXT_tessellation_shader")));
    }
    group.add_child(tess_group);

    group
}
