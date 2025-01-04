// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSeparateShaderTests.cpp   (`createGLESSeparateShaderTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `validation` is a shader-library file (`scripts/gen_shader_library.py`, see
// `src/generated/shader_library/`). Everything else is ported here on top of it:
// `pipeline`, `program_uniform`, `create_shader_program`, `interface`, `random` and `api`
// - all built on `SeparateShaderTest`, which renders a triangle through a
// `glUseProgramStages`-assembled pipeline and compares it against the same shaders
// linked into one monolithic program (`tcu::fuzzyCompare`/`pixelThresholdCompare`), so no
// host-rasterised reference is needed - the "reference" is the same shaders run a
// different way.
//
// Upstream's `ProgramWrapper` base class (`ShaderProgramWrapper`/`RawProgramWrapper`) is
// a `Program` enum here - Rust has no virtual dispatch to spare, and the two shapes
// (a linked `glu::ShaderProgram`, or a raw `glCreateShaderProgramv()` name with no
// `ShaderProgram` behind it) are exhaustive. `RawProgramWrapper::writeToLog` (the shader
// source kept only so a failure can print it) has no counterpart - nothing here prints a
// test log, matching every other `ApiCase`-based port in this tree.
//
// **RNG fidelity is deliberately not attempted beyond what upstream's own semantics need
// it for.** `paramsValid`/`areCaseParamFlagsValid` decide which case *names* exist, and
// those are ported exactly - a name this doesn't register would show up as "missing"
// against upstream's case list. But once a `TestParams` is fixed, everything the RNG
// drives after that (which varying types, which triangle vertices, which initializer
// values) only has to produce *a* valid pipeline: `testPipelineRendering` compares the
// pipeline's rendering against a monolithic program built from the identical generated
// shader sources, so the two always agree by construction, for any RNG that produces
// compilable GLSL. `Random`/`de_string_hash` (the project's own faithful port of
// `de::Random`) are reused throughout anyway, because they were already there and a
// different generator buys nothing.

use std::ffi::CString;

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::glu::objects::ProgramPipeline;
use crate::glu::render_context::RenderTarget;
use crate::glu::shader_program::{ProgramSources, ShaderProgram, ShaderType};
use crate::glu::shader_util::{DataType, Precision, get_data_type_matrix, get_data_type_vector};
use crate::glu::var_type::{Interpolation, Storage, VarType, VariableDeclaration};
use crate::glu::{self, ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::{Random, de_string_hash};

const VIEWPORT_SIZE: i32 = 128;

// Varying interface generation

/// `BindingKind` - `BINDING_LAST` doubles as "resolve randomly" (`randomBinding`),
/// mirrored here as a third variant rather than an `Option` so `VaryingParams` keeps the
/// same three-state shape upstream's own field has.
#[derive(Clone, Copy, PartialEq, Eq)]
enum BindingKind {
    Name,
    Location,
    Random,
}

fn random_binding(rnd: &mut Random) -> BindingKind {
    if rnd.get_bool() {
        BindingKind::Location
    } else {
        BindingKind::Name
    }
}

/// `VaryingInterpolation` - `Last` is upstream's array-bound sentinel, reused here for
/// "meaningless because there are no varyings" (`TestParams::varyings.count == 0`);
/// `Random` is "resolve per-varying" (`chooseInterpolation`).
#[derive(Clone, Copy, PartialEq, Eq)]
enum VaryingInterpolation {
    Smooth,
    Flat,
    Centroid,
    Default,
    Random,
    Last,
}

fn random_interpolation(rnd: &mut Random) -> VaryingInterpolation {
    const VALID: [VaryingInterpolation; 4] = [
        VaryingInterpolation::Smooth,
        VaryingInterpolation::Flat,
        VaryingInterpolation::Centroid,
        VaryingInterpolation::Default,
    ];
    *rnd.choose(&VALID)
}

/// `getGluInterpolation` - `None` is upstream's `glu::INTERPOLATION_LAST`, "no qualifier".
fn get_glu_interpolation(interpolation: VaryingInterpolation) -> Option<Interpolation> {
    match interpolation {
        VaryingInterpolation::Smooth => Some(Interpolation::Smooth),
        VaryingInterpolation::Flat => Some(Interpolation::Flat),
        VaryingInterpolation::Centroid => Some(Interpolation::Centroid),
        VaryingInterpolation::Default => None,
        VaryingInterpolation::Random | VaryingInterpolation::Last => unreachable!("resolved before this point"),
    }
}

/// A stand-in for `Random::chooseWeighted` - not upstream-bit-exact (see the file
/// header), just a fair weighted pick.
fn choose_weighted<T: Copy>(rnd: &mut Random, items: &[T], weights: &[f32]) -> T {
    let total: f32 = weights.iter().sum();
    let mut r = rnd.get_float_range(0.0, total);
    for (item, w) in items.iter().zip(weights) {
        if r < *w {
            return *item;
        }
        r -= *w;
    }
    *items.last().expect("non-empty")
}

/// `randomType`
fn random_type(rnd: &mut Random) -> DataType {
    if rnd.get_int(0, 7) == 0 {
        let num_cols = rnd.get_int(2, 4);
        let num_rows = rnd.get_int(2, 4);
        get_data_type_matrix(num_cols, num_rows)
    } else {
        const TYPES: [DataType; 3] = [DataType::Float, DataType::Int, DataType::Uint];
        const WEIGHTS: [f32; 3] = [3.0, 1.0, 1.0];
        let size = rnd.get_int(1, 4);
        let scalar_type = choose_weighted(rnd, &TYPES, &WEIGHTS);
        get_data_type_vector(scalar_type, size)
    }
}

/// `isSSOCompatibleInterpolation` - Khronos bug #12630: flat/smooth qualifiers must
/// match in SSO; auxiliary storage (centroid) does not matter.
fn is_sso_compatible_interpolation(vertex: VaryingInterpolation, fragment: VaryingInterpolation) -> bool {
    let is_smooth = |i: VaryingInterpolation| {
        matches!(
            i,
            VaryingInterpolation::Smooth | VaryingInterpolation::Default | VaryingInterpolation::Centroid
        )
    };
    is_smooth(vertex) == is_smooth(fragment)
}

/// `chooseInterpolation`
fn choose_interpolation(param: VaryingInterpolation, ty: DataType, rnd: &mut Random) -> VaryingInterpolation {
    if ty.scalar_type() != DataType::Float {
        return VaryingInterpolation::Flat;
    }
    if param == VaryingInterpolation::Random {
        return random_interpolation(rnd);
    }
    param
}

/// `VaryingParams`
#[derive(Clone, Copy)]
struct VaryingParams {
    count: i32,
    /// `None` is upstream's `glu::TYPE_LAST`, "resolve randomly per varying".
    type_: Option<DataType>,
    binding: BindingKind,
    vtx_interp: VaryingInterpolation,
    frg_interp: VaryingInterpolation,
}

/// `VaryingInterface`
struct VaryingInterface {
    vtx_outputs: Vec<VariableDeclaration>,
    frg_inputs: Vec<VariableDeclaration>,
}

/// `genVaryingInterface`
fn gen_varying_interface(params: &VaryingParams, rnd: &mut Random) -> VaryingInterface {
    let mut vtx_outputs = Vec::new();
    let mut frg_inputs = Vec::new();
    let mut offset = 0;

    for var_ndx in 0..params.count {
        let binding = if params.binding == BindingKind::Random {
            random_binding(rnd)
        } else {
            params.binding
        };
        let ty = params.type_.unwrap_or_else(|| random_type(rnd));
        let vtx_interp = choose_interpolation(params.vtx_interp, ty, rnd);
        let frg_interp = choose_interpolation(params.frg_interp, ty, rnd);
        let vtx_compat_interp = if is_sso_compatible_interpolation(vtx_interp, frg_interp) {
            vtx_interp
        } else {
            frg_interp
        };
        let loc = if binding == BindingKind::Location {
            Some(offset)
        } else {
            None
        };
        let vtx_name = if binding == BindingKind::Name {
            format!("var{var_ndx}")
        } else {
            format!("vtxVar{var_ndx}")
        };
        let frg_name = if binding == BindingKind::Name {
            format!("var{var_ndx}")
        } else {
            format!("frgVar{var_ndx}")
        };
        let var_type = VarType::basic(ty, Some(Precision::HighP));

        offset += ty.num_locations();

        // Over 16 locations aren't necessarily supported, so halt here.
        if offset > 16 {
            break;
        }

        let mut vtx_decl = VariableDeclaration::new(var_type.clone(), &vtx_name, Some(Storage::Out));
        vtx_decl.interpolation = get_glu_interpolation(vtx_compat_interp);
        vtx_decl.layout.location = loc;
        vtx_outputs.push(vtx_decl);

        let mut frg_decl = VariableDeclaration::new(var_type, &frg_name, Some(Storage::In));
        frg_decl.interpolation = get_glu_interpolation(frg_interp);
        frg_decl.layout.location = loc;
        frg_inputs.push(frg_decl);
    }

    VaryingInterface {
        vtx_outputs,
        frg_inputs,
    }
}

/// `varyingCompatVtxOutputs` - vertex output declarations maximally compatible with the
/// fragment input ones (same name/interpolation), for the monolithic reference program.
fn varying_compat_vtx_outputs(varyings: &VaryingInterface) -> Vec<VariableDeclaration> {
    let mut outputs = varyings.vtx_outputs.clone();
    for (out, input) in outputs.iter_mut().zip(&varyings.frg_inputs) {
        out.interpolation = input.interpolation;
        out.name.clone_from(&input.name);
    }
    outputs
}

// Shader source generation

/// `printInputColor` - upstream's `oss <<`; text formatting (`printFloat`'s field width,
/// `de::floatToString`'s digit count) is not reproduced anywhere in this file, since
/// nothing here compares generated GLSL as text - only the image it renders.
fn print_input_color(input: &VariableDeclaration) -> String {
    let basic_type = input.var_type.basic_type();
    let mut exp = input.name.clone();

    match basic_type.scalar_type() {
        DataType::Float => {}
        DataType::Int | DataType::Uint => {
            let float_type = get_data_type_vector(DataType::Float, basic_type.scalar_size());
            exp = format!("({}({exp}) / 255.0)", float_type.name());
        }
        _ => unreachable!("impossible"),
    }

    if basic_type.is_scalar_or_vector() {
        match basic_type.scalar_size() {
            1 => format!("hsv(vec3({exp}, 1.0, 1.0))"),
            2 => format!("hsv(vec3({exp}, 1.0))"),
            3 => format!("vec4({exp}, 1.0)"),
            4 => exp,
            _ => unreachable!("impossible"),
        }
    } else if basic_type.is_matrix() {
        let rows = basic_type.matrix_num_rows();
        let columns = basic_type.matrix_num_columns();

        if rows == columns {
            format!("hsv(vec3(determinant({exp})))")
        } else {
            let (rows, exp) = if rows != 3 && columns >= 3 {
                (columns, format!("transpose({exp})[0]"))
            } else {
                (rows, format!("{exp}[0]"))
            };
            let exp = if rows > 3 { format!("{exp}.xyz") } else { exp };
            format!("hsv({exp})")
        }
    } else {
        unreachable!("impossible")
    }
}

fn print_float_declaration(var_name: &str, uniform: bool, value: f32) -> String {
    let var_type = VarType::basic(DataType::Float, Some(Precision::HighP));
    if uniform {
        format!(
            "{};\n",
            VariableDeclaration::new(var_type, var_name, Some(Storage::Uniform))
        )
    } else {
        format!(
            "{} = {value:.6};\n",
            VariableDeclaration::new(var_type, var_name, Some(Storage::Const))
        )
    }
}

/// `printRandomInitializer`
fn print_random_initializer(ty: DataType, rnd: &mut Random) -> String {
    let size = ty.scalar_size();
    let mut parts = Vec::with_capacity(size as usize);

    for _ in 0..size {
        let part = match ty.scalar_type() {
            DataType::Float => format!("{:.4}", f64::from(rnd.get_int(0, 16)) / 16.0),
            DataType::Int | DataType::Uint => rnd.get_int(0, 255).to_string(),
            DataType::Bool => if rnd.get_bool() { "true" } else { "false" }.to_string(),
            _ => unreachable!("impossible"),
        };
        parts.push(part);
    }

    format!("{}({})", ty.name(), parts.join(", "))
}

/// `genVtxShaderSrc`
fn gen_vtx_shader_src(seed: u32, outputs: &[VariableDeclaration], var_name: &str, uniform: bool, value: f32) -> String {
    let mut rnd = Random::new(seed);
    const QUADRANTS: [[f64; 2]; 3] = [[1.0, 1.0], [-1.0, 1.0], [1.0, -1.0]];

    let mut src = String::from("#version 310 es\n");
    src.push_str(&print_float_declaration(var_name, uniform, value));
    for out in outputs {
        src.push_str(&format!("{out};\n"));
    }

    src.push_str("const vec2 triangle[3] = vec2[3](\n");
    for (vertex_ndx, quadrant) in QUADRANTS.iter().enumerate() {
        let x = quadrant[0] * f64::from(rnd.get_int(4, 16)) / 16.0;
        let y = quadrant[1] * f64::from(rnd.get_int(4, 16)) / 16.0;
        src.push_str(&format!(
            "\tvec2({x:.4}, {y:.4}){}\n",
            if vertex_ndx < 2 { "," } else { "" }
        ));
    }
    src.push_str(");\n");

    for out in outputs {
        let ty = out.var_type.basic_type();
        let type_name = ty.name();
        let inits: Vec<String> = (0..3).map(|_| print_random_initializer(ty, &mut rnd)).collect();
        src.push_str(&format!(
            "const {type_name} {}Inits[3] = {type_name}[3](\n\t{}\n);\n",
            out.name,
            inits.join(",\n\t")
        ));
    }

    src.push_str("void main (void)\n{\n");
    src.push_str(&format!(
        "\tgl_Position = vec4({var_name} * triangle[gl_VertexID], 0.0, 1.0);\n"
    ));
    for out in outputs {
        src.push_str(&format!("\t{0} = {0}Inits[gl_VertexID];\n", out.name));
    }
    src.push_str("}\n");
    src
}

/// `genFrgShaderSrc`
fn gen_frg_shader_src(seed: u32, inputs: &[VariableDeclaration], var_name: &str, uniform: bool, value: f32) -> String {
    let mut rnd = Random::new(seed);

    let mut src = String::from("#version 310 es\nprecision highp float;\nout vec4 fragColor;\n");
    src.push_str(&print_float_declaration(var_name, uniform, value));
    for input in inputs {
        src.push_str(&format!("{input};\n"));
    }

    // glsl % isn't defined for negative numbers.
    src.push_str("int imod (int n, int d)\n{\n\treturn (n < 0 ? d - 1 - (-1 - n) % d : n % d);\n}\n");
    src.push_str(
        "vec4 hsv (vec3 hsv)\n{\n\tfloat h = hsv.x * 3.0;\n\tfloat r = max(0.0, 1.0 - h) + max(0.0, h - 2.0);\n\tfloat g = max(0.0, 1.0 - abs(h - 1.0));\n\tfloat b = max(0.0, 1.0 - abs(h - 2.0));\n\tvec3 hs = mix(vec3(1.0), vec3(r, g, b), hsv.y);\n\treturn vec4(hsv.z * hs, 1.0);\n}\n",
    );

    src.push_str("void main (void)\n{\n");
    src.push_str(&format!("\tfragColor = vec4(vec3({var_name}), 1.0);\n"));

    if !inputs.is_empty() {
        let a = rnd.get_float_range(0.5, 2.0);
        let b = rnd.get_float_range(0.5, 2.0);
        src.push_str(&format!(
            "\tswitch (imod(int(0.5 * ({a:.4} * gl_FragCoord.x - {b:.4} * gl_FragCoord.y)), {}))\n\t{{\n",
            inputs.len()
        ));
        for (i, input) in inputs.iter().enumerate() {
            src.push_str(&format!(
                "\t\tcase {i}:\n\t\t\tfragColor *= {};\n\t\t\tbreak;\n",
                print_input_color(input)
            ));
        }
        src.push_str(&format!(
            "\t\tcase {}:\n\t\t\tfragColor = vec4(1.0, 0.0, 1.0, 1.0);\n\t\t\tbreak;\n",
            inputs.len()
        ));
        src.push_str("\t\tcase -1:\n\t\t\tfragColor = vec4(1.0, 1.0, 0.0, 1.0);\n\t\t\tbreak;\n");
        src.push_str("\t\tdefault:\n\t\t\tfragColor = vec4(1.0, 1.0, 0.0, 1.0);\n");
        src.push_str("\t}\n");
    }

    src.push_str("}\n");
    src
}

// ProgramWrapper

/// `RawProgramWrapper` - a program name from `glCreateShaderProgramv()`, deleted when it
/// goes out of scope. Upstream's `writeToLog` (kept only for a failure's log) is not
/// carried, matching the file header.
struct RawProgram<'gl> {
    gl: &'gl glw::Functions,
    name: GLuint,
}

impl Drop for RawProgram<'_> {
    fn drop(&mut self) {
        // SAFETY: `name` is this wrapper's own and is deleted exactly once.
        unsafe { self.gl.delete_program(self.name) };
    }
}

/// `ProgramWrapper` - see the file header for why this is an enum rather than a trait
/// object.
enum Program<'gl> {
    Shader(ShaderProgram<'gl>),
    Raw(RawProgram<'gl>),
}

impl Program<'_> {
    /// `ProgramWrapper::getProgramName`
    fn program_name(&self) -> GLuint {
        match self {
            Self::Shader(p) => p.program(),
            Self::Raw(p) => p.name,
        }
    }
}

/// `SeparateShaderTest::createShaderProgram`
fn create_shader_program<'gl>(
    case: &mut ApiCase<'gl>,
    vtx_source: Option<&str>,
    frg_source: Option<&str>,
    separable: bool,
) -> Option<Program<'gl>> {
    let gl = case.gl();
    let mut sources = ProgramSources::default();
    if let Some(v) = vtx_source {
        sources = sources.with(ShaderType::Vertex, v.to_string());
    }
    if let Some(f) = frg_source {
        sources = sources.with(ShaderType::Fragment, f.to_string());
    }
    if separable {
        sources = sources.separable();
    }

    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("Couldn't create shader program".to_string(), "Fail");
        return None;
    }
    Some(Program::Shader(program))
}

/// `SeparateShaderTest::createSingleShaderProgram`
fn create_single_shader_program<'gl>(
    case: &mut ApiCase<'gl>,
    use_create_helper: bool,
    shader_type: ShaderType,
    src: &str,
) -> Option<Program<'gl>> {
    if use_create_helper {
        let gl = case.gl();
        let c_src = CString::new(src).expect("generated GLSL has no interior NUL");
        let ptr = c_src.as_ptr();
        // SAFETY: `ptr` is valid for the call's duration and names exactly one string.
        let program_name = unsafe { gl.create_shader_programv(shader_type.gl_enum(), 1, &ptr) };
        // SAFETY: glGetError needs only a current context.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR || program_name == 0 {
            case.fail("glCreateShaderProgramv() failed".to_string(), "Fail");
            return None;
        }

        let mut link_status: GLint = 0;
        // SAFETY: one integer of output, against the program name just returned.
        unsafe { gl.get_programiv(program_name, glw::GL_LINK_STATUS, &mut link_status) };
        if link_status == 0 {
            case.fail("glCreateShaderProgram() failed at linking".to_string(), "Fail");
            // SAFETY: deletes the program this call just created.
            unsafe { gl.delete_program(program_name) };
            return None;
        }

        Some(Program::Raw(RawProgram { gl, name: program_name }))
    } else {
        match shader_type {
            ShaderType::Vertex => create_shader_program(case, Some(src), None, true),
            ShaderType::Fragment => create_shader_program(case, None, Some(src), true),
            _ => unreachable!("impossible case"),
        }
    }
}

/// `SeparateShaderTest::setUniform`
fn set_uniform(
    case: &mut ApiCase<'_>,
    program: &Program<'_>,
    uniform_name: &str,
    value: f32,
    use_program_uniform: bool,
) {
    let gl = case.gl();
    let prog_name = program.program_name();
    let c_name = CString::new(uniform_name).expect("uniform name has no interior NUL");
    // SAFETY: `prog_name` is a linked program this case owns; the location is looked up,
    // never assumed.
    let location = unsafe { gl.get_uniform_location(prog_name, c_name.as_ptr()) };

    if use_program_uniform {
        // SAFETY: as above.
        unsafe { gl.program_uniform_1f(prog_name, location, value) };
    } else {
        // SAFETY: as above.
        unsafe {
            gl.use_program(prog_name);
            gl.uniform_1f(location, value);
            gl.use_program(0);
        }
    }
}

/// `ProgramPipeline::isValid`
fn is_pipeline_valid(gl: &glw::Functions, pipeline: GLuint) -> bool {
    let mut status: GLint = 0;
    // SAFETY: `pipeline` is a name this case owns.
    unsafe {
        gl.validate_program_pipeline(pipeline);
        gl.get_program_pipelineiv(pipeline, glw::GL_VALIDATE_STATUS, &mut status);
    }
    status != 0
}

// TestParams / ProgramParams

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    init_single: bool,
    switch_vtx: bool,
    switch_frg: bool,
    use_uniform: bool,
    use_same_name: bool,
    use_create_helper: bool,
    use_program_uniform: bool,
    varyings: VaryingParams,
}

fn default_test_params() -> TestParams {
    TestParams {
        init_single: false,
        switch_vtx: false,
        switch_frg: false,
        use_uniform: false,
        use_same_name: false,
        use_create_helper: false,
        use_program_uniform: false,
        varyings: VaryingParams {
            count: 0,
            type_: None,
            binding: BindingKind::Name,
            vtx_interp: VaryingInterpolation::Last,
            frg_interp: VaryingInterpolation::Last,
        },
    }
}

/// `paramsSeed` - not upstream-bit-exact (see the file header); just needs to give each
/// distinct `TestParams` its own reproducible-within-a-run RNG stream.
fn params_seed(params: &TestParams) -> u32 {
    let mut code: u32 = 0;
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.init_single));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.switch_vtx));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.switch_frg));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.use_uniform));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.use_same_name));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.use_create_helper));
    code = code.wrapping_mul(2).wrapping_add(u32::from(params.use_program_uniform));
    code = code.wrapping_mul(31).wrapping_add(params.varyings.count as u32);
    code
}

/// `paramsValid`
fn params_valid(params: &TestParams) -> bool {
    if params.init_single {
        if params.use_same_name {
            return false;
        }
        if !params.switch_vtx && !params.switch_frg && params.use_create_helper {
            return false;
        }
        if params.switch_vtx != params.switch_frg {
            return false;
        }
    }

    if params.use_program_uniform && !params.use_uniform {
        return false;
    }

    if params.varyings.count == 0
        && !(params.varyings.vtx_interp == VaryingInterpolation::Last
            && params.varyings.frg_interp == VaryingInterpolation::Last)
    {
        return false;
    }

    // Mismatch by flat/smooth is not allowed. See Khronos bug #12630.
    if params.varyings.vtx_interp != VaryingInterpolation::Random
        && params.varyings.frg_interp != VaryingInterpolation::Random
        && (params.varyings.vtx_interp == VaryingInterpolation::Flat)
            != (params.varyings.frg_interp == VaryingInterpolation::Flat)
    {
        return false;
    }

    true
}

/// `genParams`
fn gen_params(seed: u32) -> TestParams {
    let mut rnd = Random::new(seed);
    let mut params;
    let mut try_ndx = 0;

    loop {
        let init_single = rnd.get_bool();
        let switch_vtx = rnd.get_bool();
        let switch_frg = rnd.get_bool();
        let use_uniform = rnd.get_bool();
        let use_program_uniform = use_uniform && rnd.get_bool();
        let use_create_helper = rnd.get_bool();
        let use_same_name = rnd.get_bool();
        let i = rnd.get_int(-1, 3);
        let count = if i == -1 { 0 } else { 1 << i };

        let varyings = if count > 0 {
            VaryingParams {
                count,
                type_: None,
                binding: BindingKind::Random,
                vtx_interp: VaryingInterpolation::Random,
                frg_interp: VaryingInterpolation::Random,
            }
        } else {
            VaryingParams {
                count: 0,
                type_: None,
                binding: BindingKind::Random,
                vtx_interp: VaryingInterpolation::Last,
                frg_interp: VaryingInterpolation::Last,
            }
        };

        params = TestParams {
            init_single,
            switch_vtx,
            switch_frg,
            use_uniform,
            use_same_name,
            use_create_helper,
            use_program_uniform,
            varyings,
        };

        try_ndx += 1;
        if params_valid(&params) || try_ndx >= 16 {
            break;
        }
    }

    params
}

/// `ProgramParams`
#[derive(Clone, Copy)]
struct ProgramParams {
    vtx_seed: u32,
    vtx_scale: f32,
    frg_seed: u32,
    frg_scale: f32,
}

/// `genProgramParams`
fn gen_program_params(rnd: &mut Random) -> ProgramParams {
    ProgramParams {
        vtx_seed: rnd.get_uint32(),
        vtx_scale: f32::from(rnd.get_int(8, 16) as i16) / 16.0,
        frg_seed: rnd.get_uint32(),
        frg_scale: f32::from(rnd.get_int(0, 16) as i16) / 16.0,
    }
}

// Pipeline

/// `Pipeline`
struct Pipeline<'gl> {
    pipeline: ProgramPipeline<'gl>,
    full_prog: Option<Program<'gl>>,
    vtx_prog: Option<Program<'gl>>,
    frg_prog: Option<Program<'gl>>,
}

impl<'gl> Pipeline<'gl> {
    /// `Pipeline::getVertexProgram`
    fn vertex_program(&self) -> &Program<'gl> {
        self.vtx_prog.as_ref().unwrap_or_else(|| {
            self.full_prog
                .as_ref()
                .expect("createPipeline always sets one of vtx_prog/full_prog")
        })
    }

    /// `Pipeline::getFragmentProgram`
    fn fragment_program(&self) -> &Program<'gl> {
        self.frg_prog.as_ref().unwrap_or_else(|| {
            self.full_prog
                .as_ref()
                .expect("createPipeline always sets one of frg_prog/full_prog")
        })
    }
}

/// `SeparateShaderTest::createPipeline`
fn create_pipeline<'gl>(
    case: &mut ApiCase<'gl>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
    pp: &ProgramParams,
) -> Option<Pipeline<'gl>> {
    let use_uniform = params.use_uniform;
    let vtx_name = if params.use_same_name { "scale" } else { "vtxScale" };
    let init_vtx_seed = if params.switch_vtx {
        rnd.get_uint32()
    } else {
        pp.vtx_seed
    };

    let frg_name = if params.use_same_name { "scale" } else { "frgScale" };
    let init_frg_seed = if params.switch_frg {
        rnd.get_uint32()
    } else {
        pp.frg_seed
    };
    let frg_source = gen_frg_shader_src(init_frg_seed, &varyings.frg_inputs, frg_name, use_uniform, pp.frg_scale);

    let gl = case.gl();
    let pipeline = ProgramPipeline::new(gl);
    let mut full_prog = None;
    let mut vtx_prog = None;
    let mut frg_prog = None;

    // We cannot allow a situation where we have a single program with a single
    // uniform, because then the vertex and fragment shader uniforms would not be
    // distinct in the final pipeline, and we are going to test that altering one
    // uniform will not affect the other.
    debug_assert!(!(params.init_single && params.use_same_name && !params.switch_vtx && !params.switch_frg));

    if params.init_single {
        let vtx_source = gen_vtx_shader_src(
            init_vtx_seed,
            &varying_compat_vtx_outputs(varyings),
            vtx_name,
            use_uniform,
            pp.vtx_scale,
        );
        full_prog = create_shader_program(case, Some(&vtx_source), Some(&frg_source), true);
        let name = full_prog.as_ref()?.program_name();
        // SAFETY: `pipeline`/`name` are this case's own.
        unsafe {
            case.gl().use_program_stages(
                pipeline.get(),
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                name,
            )
        };
    } else {
        let vtx_source = gen_vtx_shader_src(
            init_vtx_seed,
            &varyings.vtx_outputs,
            vtx_name,
            use_uniform,
            pp.vtx_scale,
        );
        vtx_prog = create_single_shader_program(case, params.use_create_helper, ShaderType::Vertex, &vtx_source);
        let name = vtx_prog.as_ref()?.program_name();
        // SAFETY: as above.
        unsafe {
            case.gl()
                .use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, name)
        };

        frg_prog = create_single_shader_program(case, params.use_create_helper, ShaderType::Fragment, &frg_source);
        let name = frg_prog.as_ref()?.program_name();
        // SAFETY: as above.
        unsafe {
            case.gl()
                .use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, name)
        };
    }

    if !is_pipeline_valid(case.gl(), pipeline.get()) {
        case.fail("Pipeline is invalid after initialization".to_string(), "Fail");
    }

    if params.switch_vtx {
        let new_source = gen_vtx_shader_src(pp.vtx_seed, &varyings.vtx_outputs, vtx_name, use_uniform, pp.vtx_scale);
        vtx_prog = create_single_shader_program(case, params.use_create_helper, ShaderType::Vertex, &new_source);
        let name = vtx_prog.as_ref()?.program_name();
        // SAFETY: as above.
        unsafe {
            case.gl()
                .use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, name)
        };
    }
    if params.switch_frg {
        let new_source = gen_frg_shader_src(pp.frg_seed, &varyings.frg_inputs, frg_name, use_uniform, pp.frg_scale);
        frg_prog = create_single_shader_program(case, params.use_create_helper, ShaderType::Fragment, &new_source);
        let name = frg_prog.as_ref()?.program_name();
        // SAFETY: as above.
        unsafe {
            case.gl()
                .use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, name)
        };
    }

    if (params.switch_vtx || params.switch_frg) && !is_pipeline_valid(case.gl(), pipeline.get()) {
        case.fail(
            "Pipeline became invalid after changing a stage's program".to_string(),
            "Fail",
        );
    }

    if params.use_uniform {
        let vtx_stage = vtx_prog
            .as_ref()
            .unwrap_or_else(|| full_prog.as_ref().expect("one of vtx_prog/full_prog is set"));
        let frg_stage = frg_prog
            .as_ref()
            .unwrap_or_else(|| full_prog.as_ref().expect("one of frg_prog/full_prog is set"));
        set_uniform(case, vtx_stage, vtx_name, pp.vtx_scale, params.use_program_uniform);
        set_uniform(case, frg_stage, frg_name, pp.frg_scale, params.use_program_uniform);
    }

    Some(Pipeline {
        pipeline,
        full_prog,
        vtx_prog,
        frg_prog,
    })
}

/// `SeparateShaderTest::createReferenceProgram`
fn create_reference_program<'gl>(
    case: &mut ApiCase<'gl>,
    params: &TestParams,
    varyings: &VaryingInterface,
    pp: &ProgramParams,
) -> Option<Program<'gl>> {
    let use_uniform = params.use_uniform;
    let vtx_src = gen_vtx_shader_src(
        pp.vtx_seed,
        &varying_compat_vtx_outputs(varyings),
        "vtxScale",
        use_uniform,
        pp.vtx_scale,
    );
    let frg_src = gen_frg_shader_src(pp.frg_seed, &varyings.frg_inputs, "frgScale", use_uniform, pp.frg_scale);
    let program = create_shader_program(case, Some(&vtx_src), Some(&frg_src), false)?;

    if use_uniform {
        set_uniform(case, &program, "vtxScale", pp.vtx_scale, false);
        set_uniform(case, &program, "frgScale", pp.frg_scale, false);
    }
    Some(program)
}

// Rendering

/// `Rectangle`
#[derive(Clone, Copy)]
struct Rectangle {
    x: GLint,
    y: GLint,
    width: GLint,
    height: GLint,
}

/// `randomViewport`
fn random_viewport(target: RenderTarget, rnd: &mut Random, max_width: GLint, max_height: GLint) -> Rectangle {
    let width = target.width.min(max_width);
    let x_off = rnd.get_int(0, target.width - width);
    let height = target.height.min(max_height);
    let y_off = rnd.get_int(0, target.height - height);
    Rectangle {
        x: x_off,
        y: y_off,
        width,
        height,
    }
}

/// `SeparateShaderTest::drawSurface` - always called with an explicit seed at every call
/// site in this port (`seed > 0 ? seed : m_rnd.getUint32()`'s default-argument branch is
/// never taken upstream either: every call already resolves its own seed first).
fn draw_surface(case: &mut ApiCase<'_>, dst: &mut Surface, seed: u32) -> Option<()> {
    let mut rnd = Random::new(seed);
    let viewport = random_viewport(case.context().render_target(), &mut rnd, VIEWPORT_SIZE, VIEWPORT_SIZE);
    let gl = case.gl();

    // SAFETY: plain draw state on a current context. This port only ever creates ES
    // contexts, where the default vertex array object is legal, so upstream's
    // `!glu::isContextTypeES` VAO branch has no counterpart here, as elsewhere in this
    // tree.
    unsafe {
        gl.clear_color(0.125, 0.25, 0.5, 1.0);
        gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
    }
    case.expect_no_error("glDrawArrays");

    dst.set_size(viewport.width, viewport.height);
    if let Err(e) = glu::pixel_transfer::read_pixels(
        &case.context().render_context,
        viewport.x,
        viewport.y,
        &mut dst.get_access(),
    ) {
        case.fail(e.to_string(), "Fail");
        return None;
    }
    Some(())
}

// The five `SeparateShaderTest::TestFunc` bodies

/// `SeparateShaderTest::testPipelineRendering`
fn test_pipeline_rendering(
    case: &mut ApiCase<'_>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
) -> Option<()> {
    let pp = gen_program_params(rnd);
    let pipeline = create_pipeline(case, params, varyings, rnd, &pp)?;
    let pipe_name = pipeline.pipeline.get();
    let ref_program = create_reference_program(case, params, varyings, &pp)?;
    let ref_prog_name = ref_program.program_name();
    let mut ref_surface = Surface::new(0, 0);
    let mut pipeline_surface = Surface::new(0, 0);
    let draw_seed = rnd.get_uint32();

    // SAFETY: `ref_prog_name` is this case's own linked program.
    unsafe { case.gl().use_program(ref_prog_name) };
    draw_surface(case, &mut ref_surface, draw_seed)?;
    // SAFETY: unbinding is always legal.
    unsafe { case.gl().use_program(0) };

    // SAFETY: `pipe_name` is this case's own pipeline.
    unsafe { case.gl().bind_program_pipeline(pipe_name) };
    draw_surface(case, &mut pipeline_surface, draw_seed)?;
    // SAFETY: as above.
    unsafe { case.gl().bind_program_pipeline(0) };

    let result = fuzzy_compare_ok(
        &ref_surface.get_const_access(),
        &pipeline_surface.get_const_access(),
        0.05,
    )
    .unwrap_or(false);
    if !result {
        case.fail(
            "Pipeline rendering differs from equivalent monolithic program".to_string(),
            "Fail",
        );
    }
    Some(())
}

/// `SeparateShaderTest::testCurrentProgPriority`
fn test_current_prog_priority(
    case: &mut ApiCase<'_>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
) -> Option<()> {
    let pipe_pp = gen_program_params(rnd);
    let program_pp = gen_program_params(rnd);
    let pipeline = create_pipeline(case, params, varyings, rnd, &pipe_pp)?;
    let pipe_name = pipeline.pipeline.get();
    let program = create_reference_program(case, params, varyings, &program_pp)?;
    let program_name = program.program_name();
    let mut pipeline_surface = Surface::new(0, 0);
    let mut ref_surface = Surface::new(0, 0);
    let mut result_surface = Surface::new(0, 0);
    let draw_seed = rnd.get_uint32();

    // SAFETY: `pipe_name` is this case's own pipeline.
    unsafe { case.gl().bind_program_pipeline(pipe_name) };
    draw_surface(case, &mut pipeline_surface, draw_seed)?;
    // SAFETY: as above.
    unsafe { case.gl().bind_program_pipeline(0) };

    // SAFETY: `program_name` is this case's own linked program.
    unsafe { case.gl().use_program(program_name) };
    draw_surface(case, &mut ref_surface, draw_seed)?;
    // SAFETY: as above.
    unsafe { case.gl().use_program(0) };

    // SAFETY: as above, both together.
    unsafe {
        case.gl().use_program(program_name);
        case.gl().bind_program_pipeline(pipe_name);
    }
    draw_surface(case, &mut result_surface, draw_seed)?;
    // SAFETY: as above.
    unsafe {
        case.gl().bind_program_pipeline(0);
        case.gl().use_program(0);
    }

    let result = pixel_threshold_compare(&ref_surface, &result_surface, RGBA::new(0, 0, 0, 0));
    if !result.ok {
        case.fail("glBindProgramPipeline() affects glUseProgram()".to_string(), "Fail");
    }
    Some(())
}

/// `SeparateShaderTest::testActiveProgramUniform`
fn test_active_program_uniform(
    case: &mut ApiCase<'_>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
) -> Option<()> {
    let ref_pp = gen_program_params(rnd);
    let mut ref_surface = Surface::new(0, 0);
    let mut result_surface = Surface::new(0, 0);
    let draw_seed = rnd.get_uint32();

    {
        let ref_prog = create_reference_program(case, params, varyings, &ref_pp)?;
        let ref_prog_name = ref_prog.program_name();
        // SAFETY: `ref_prog_name` is this case's own linked program.
        unsafe { case.gl().use_program(ref_prog_name) };
        draw_surface(case, &mut ref_surface, draw_seed)?;
        // SAFETY: as above.
        unsafe { case.gl().use_program(0) };
    }

    {
        let mut change_pp = gen_program_params(rnd);
        change_pp.vtx_seed = ref_pp.vtx_seed;
        change_pp.frg_seed = ref_pp.frg_seed;
        let change_prog = create_reference_program(case, params, varyings, &change_pp)?;
        let change_name = change_prog.program_name();
        let gl = case.gl();
        let pipeline = ProgramPipeline::new(gl);
        let vtx_scale = CString::new("vtxScale").expect("no interior NUL");
        let frg_scale = CString::new("frgScale").expect("no interior NUL");
        // SAFETY: `change_name` is this case's own linked program.
        let (vtx_loc, frg_loc) = unsafe {
            (
                gl.get_uniform_location(change_name, vtx_scale.as_ptr()),
                gl.get_uniform_location(change_name, frg_scale.as_ptr()),
            )
        };

        // SAFETY: `pipeline`/`change_name` are this case's own.
        unsafe {
            gl.bind_program_pipeline(pipeline.get());
            gl.active_shader_program(pipeline.get(), change_name);
            gl.uniform_1f(vtx_loc, ref_pp.vtx_scale);
            gl.uniform_1f(frg_loc, ref_pp.frg_scale);
            gl.active_shader_program(pipeline.get(), 0);
            gl.bind_program_pipeline(0);
            gl.use_program(change_name);
        }
        draw_surface(case, &mut result_surface, draw_seed)?;
        // SAFETY: as above.
        unsafe { case.gl().use_program(0) };
    }

    let result = fuzzy_compare_ok(
        &ref_surface.get_const_access(),
        &result_surface.get_const_access(),
        0.05,
    )
    .unwrap_or(false);
    if !result {
        case.fail(
            "glUniform() did not correctly modify the active program of the bound pipeline".to_string(),
            "Fail",
        );
    }
    Some(())
}

/// `SeparateShaderTest::testPipelineQueryPrograms`
fn test_pipeline_query_programs(
    case: &mut ApiCase<'_>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
) -> Option<()> {
    let pipe_pp = gen_program_params(rnd);
    let pipeline = create_pipeline(case, params, varyings, rnd, &pipe_pp)?;
    let pipe_name = pipeline.pipeline.get();
    let mut query_vtx: GLint = 0;
    let mut query_frg: GLint = 0;

    // SAFETY: `pipe_name` is this case's own pipeline; each query writes one integer.
    unsafe {
        case.gl()
            .get_program_pipelineiv(pipe_name, glw::GL_VERTEX_SHADER, &mut query_vtx)
    };
    #[expect(clippy::cast_sign_loss, reason = "a program name is never negative")]
    if query_vtx as GLuint != pipeline.vertex_program().program_name() {
        case.fail(
            "Program pipeline query reported wrong vertex shader program".to_string(),
            "Fail",
        );
    }

    // SAFETY: as above.
    unsafe {
        case.gl()
            .get_program_pipelineiv(pipe_name, glw::GL_FRAGMENT_SHADER, &mut query_frg)
    };
    #[expect(clippy::cast_sign_loss, reason = "a program name is never negative")]
    if query_frg as GLuint != pipeline.fragment_program().program_name() {
        case.fail(
            "Program pipeline query reported wrong fragment shader program".to_string(),
            "Fail",
        );
    }
    Some(())
}

/// `SeparateShaderTest::testPipelineQueryActive`
fn test_pipeline_query_active(
    case: &mut ApiCase<'_>,
    params: &TestParams,
    varyings: &VaryingInterface,
    rnd: &mut Random,
) -> Option<()> {
    let pipe_pp = gen_program_params(rnd);
    let pipeline = create_pipeline(case, params, varyings, rnd, &pipe_pp)?;
    let pipe_name = pipeline.pipeline.get();
    let new_active = pipeline.vertex_program().program_name();
    let mut query_active: GLint = 0;

    // SAFETY: `pipe_name` is this case's own pipeline; the query writes one integer.
    unsafe {
        case.gl()
            .get_program_pipelineiv(pipe_name, glw::GL_ACTIVE_PROGRAM, &mut query_active)
    };
    if query_active != 0 {
        case.fail(
            "Program pipeline query reported non-zero initial active program".to_string(),
            "Fail",
        );
    }

    // SAFETY: `pipe_name`/`new_active` are this case's own.
    unsafe { case.gl().active_shader_program(pipe_name, new_active) };

    // SAFETY: as above.
    unsafe {
        case.gl()
            .get_program_pipelineiv(pipe_name, glw::GL_ACTIVE_PROGRAM, &mut query_active)
    };
    #[expect(clippy::cast_sign_loss, reason = "a program name is never negative")]
    if query_active as GLuint != new_active {
        case.fail(
            "Program pipeline query reported incorrect active program".to_string(),
            "Fail",
        );
    }

    // SAFETY: as above.
    unsafe { case.gl().active_shader_program(pipe_name, 0) };
    Some(())
}

type TestFunc = fn(&mut ApiCase<'_>, &TestParams, &VaryingInterface, &mut Random) -> Option<()>;

/// `SeparateShaderTest::iterate` (plus its constructor, which builds `m_rnd`/`m_varyings`
/// once). Upstream stops iterating - without exhausting `m_iterations` - the moment any
/// iteration leaves a non-`Pass` verdict, since later iterations cannot improve a
/// `ResultCollector` that already holds a failure; `ApiCase::fail`'s own "keep the first
/// failure" bookkeeping is what `failure_count` reads here to reproduce that.
fn separate_shader_case(case: &mut ApiCase<'_>, params: TestParams, iterations: i32, test_func: TestFunc) {
    let mut rnd = Random::new(params_seed(&params));
    let varyings = gen_varying_interface(&params.varyings, &mut rnd);

    for _ in 0..iterations {
        test_func(case, &params, &varyings, &mut rnd);
        if case.failure_count() > 0 {
            break;
        }
    }
}

// Group construction utilities

/// `ParamFlags`, restricted to the three bits `areCaseParamFlagsValid`/`addRenderTest`
/// look at - the two outer bits (`same_name`/`uniform`) are folded into `params`/`name`
/// by each group's own loop before `add_render_test` is called, exactly as upstream's
/// `flags & PARAMFLAGS_MASK` narrows the same 5-bit loop counter down to these three.
#[derive(Clone, Copy)]
struct ParamFlags {
    switch_fragment: bool,
    switch_vertex: bool,
    init_single: bool,
}

/// `areCaseParamFlagsValid`
fn are_case_param_flags_valid(flags: ParamFlags) -> bool {
    if flags.init_single {
        flags.switch_vertex == flags.switch_fragment
    } else {
        true
    }
}

/// `addRenderTest`
fn add_render_test(
    group: &mut TestCaseGroup,
    name_prefix: &str,
    num_iterations: i32,
    flags: ParamFlags,
    mut params: TestParams,
) -> bool {
    let mut name = name_prefix.to_string();

    params.init_single = flags.init_single;
    params.switch_vtx = flags.switch_vertex;
    params.switch_frg = flags.switch_fragment;

    name.push_str(if flags.init_single {
        "single_program"
    } else {
        "separate_programs"
    });

    match (flags.switch_fragment, flags.switch_vertex) {
        (false, false) => {}
        (true, false) => name.push_str("_add_fragment"),
        (false, true) => name.push_str("_add_vertex"),
        (true, true) => name.push_str("_add_both"),
    }

    if !params_valid(&params) {
        return false;
    }

    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        separate_shader_case(case, params, num_iterations, test_pipeline_rendering)
    });
    true
}

/// `createCommonSeparateShaderTests`'s `.pipeline` sub-group.
fn pipeline_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pipeline");
    let default_params = default_test_params();
    const NUM_ITERATIONS: i32 = 4;

    for flags_bits in 0u32..32 {
        let flags = ParamFlags {
            switch_fragment: flags_bits & 1 != 0,
            switch_vertex: flags_bits & 2 != 0,
            init_single: flags_bits & 4 != 0,
        };
        if !are_case_param_flags_valid(flags) {
            continue;
        }

        let mut params = default_params;
        let mut name = String::new();

        if flags_bits & 16 != 0 {
            params.use_same_name = true;
            name.push_str("same_");
        } else {
            name.push_str("different_");
        }

        if flags_bits & 8 != 0 {
            params.use_uniform = true;
            name.push_str("uniform_");
        } else {
            name.push_str("constant_");
        }

        add_render_test(&mut group, &name, NUM_ITERATIONS, flags, params);
    }

    group
}

/// `createCommonSeparateShaderTests`'s `.program_uniform` sub-group.
fn program_uniform_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("program_uniform");
    let default_params = default_test_params();
    const NUM_ITERATIONS: i32 = 4;

    for flags_bits in 0u32..8 {
        let flags = ParamFlags {
            switch_fragment: flags_bits & 1 != 0,
            switch_vertex: flags_bits & 2 != 0,
            init_single: flags_bits & 4 != 0,
        };
        if !are_case_param_flags_valid(flags) {
            continue;
        }

        let mut params = default_params;
        params.use_uniform = true;
        params.use_program_uniform = true;

        add_render_test(&mut group, "", NUM_ITERATIONS, flags, params);
    }

    group
}

/// `createCommonSeparateShaderTests`'s `.create_shader_program` sub-group.
fn create_shader_program_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("create_shader_program");
    let default_params = default_test_params();
    const NUM_ITERATIONS: i32 = 4;

    for flags_bits in 0u32..8 {
        let flags = ParamFlags {
            switch_fragment: flags_bits & 1 != 0,
            switch_vertex: flags_bits & 2 != 0,
            init_single: flags_bits & 4 != 0,
        };
        if !are_case_param_flags_valid(flags) {
            continue;
        }

        let mut params = default_params;
        params.use_create_helper = true;

        add_render_test(&mut group, "", NUM_ITERATIONS, flags, params);
    }

    group
}

/// `VARYINGINTERPOLATION_RANDOM`'s numeric value, i.e. the count of fully-specified
/// interpolations (`Smooth`/`Flat`/`Centroid`/`Default`).
const NUM_INTERPOLATIONS: u32 = 4;

fn interpolation_from_index(i: u32) -> VaryingInterpolation {
    match i {
        0 => VaryingInterpolation::Smooth,
        1 => VaryingInterpolation::Flat,
        2 => VaryingInterpolation::Centroid,
        3 => VaryingInterpolation::Default,
        _ => unreachable!("index out of range"),
    }
}

/// `describeInterpolation`, restricted to the name (the description is log-only).
fn describe_interpolation(stage: &str, qual: VaryingInterpolation, name: &mut String) {
    if qual == VaryingInterpolation::Default {
        return;
    }
    let qual_name = get_glu_interpolation(qual).expect("Default is handled above").name();
    name.push('_');
    name.push_str(stage);
    name.push('_');
    name.push_str(qual_name);
}

/// `createCommonSeparateShaderTests`'s `.interface` sub-group.
fn interface_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("interface");
    let default_params = default_test_params();
    const NUM_ITERATIONS: i32 = 4;
    // `BindingKind::Random` is excluded here on purpose - upstream's own loop only ranges
    // over `BINDING_LAST` (2), i.e. `BINDING_NAME`/`BINDING_LOCATION`.
    const INTERFACE_FLAGS_LAST: u32 = 2 * NUM_INTERPOLATIONS * NUM_INTERPOLATIONS;

    for flags in 0..INTERFACE_FLAGS_LAST {
        let mut tmp = flags;
        let frg_interp = interpolation_from_index(tmp % NUM_INTERPOLATIONS);
        tmp /= NUM_INTERPOLATIONS;
        let vtx_interp = interpolation_from_index(tmp % NUM_INTERPOLATIONS);
        tmp /= NUM_INTERPOLATIONS;
        let binding = if tmp % 2 == 0 {
            BindingKind::Name
        } else {
            BindingKind::Location
        };

        let mut params = default_params;
        params.varyings.count = 1;
        params.varyings.type_ = Some(DataType::Float);
        params.varyings.binding = binding;
        params.varyings.vtx_interp = vtx_interp;
        params.varyings.frg_interp = frg_interp;

        let mut name = match binding {
            BindingKind::Location => "same_location".to_string(),
            BindingKind::Name => "same_name".to_string(),
            BindingKind::Random => unreachable!("excluded by INTERFACE_FLAGS_LAST"),
        };
        describe_interpolation("vertex", vtx_interp, &mut name);
        describe_interpolation("fragment", frg_interp, &mut name);

        if !params_valid(&params) {
            continue;
        }

        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            separate_shader_case(case, params, NUM_ITERATIONS, test_pipeline_rendering)
        });
    }

    group
}

/// `createCommonSeparateShaderTests`'s `.random` sub-group - see the file header for why
/// this does not also replicate upstream's `set<string> seen` deduplication: upstream's
/// own case names here are already just `"0".."127"` (`i`, not `paramsCode(params)`,
/// specifically because upstream's base seed can change between runs), so
/// deduplication only affects configuration diversity, not correctness or naming.
fn random_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("random");
    const NUM_ITERATIONS: i32 = 4;
    let mut rnd = Random::new(de_string_hash("separate_shader.random"));

    for i in 0..128 {
        let params = gen_params(rnd.get_uint32());
        let name = i.to_string();
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            separate_shader_case(case, params, NUM_ITERATIONS, test_pipeline_rendering)
        });
    }

    group
}

/// `createCommonSeparateShaderTests`'s `.api` sub-group.
fn api_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("api");
    let mut params = default_test_params();
    params.use_uniform = true;

    add_api_case(&mut group, "current_program_priority", move |case: &mut ApiCase<'_>| {
        separate_shader_case(case, params, 1, test_current_prog_priority)
    });
    add_api_case(&mut group, "active_program_uniform", move |case: &mut ApiCase<'_>| {
        separate_shader_case(case, params, 1, test_active_program_uniform)
    });
    add_api_case(&mut group, "pipeline_programs", move |case: &mut ApiCase<'_>| {
        separate_shader_case(case, params, 1, test_pipeline_query_programs)
    });
    add_api_case(&mut group, "pipeline_active", move |case: &mut ApiCase<'_>| {
        separate_shader_case(case, params, 1, test_pipeline_query_active)
    });

    group
}

/// `createGLESSeparateShaderTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("separate_shader");

    group.add_child(pipeline_group());
    group.add_child(program_uniform_group());
    group.add_child(create_shader_program_group());
    group.add_child(interface_group());
    group.add_child(random_group());
    group.add_child(api_group());

    let mut validation = TestCaseGroup::new("validation");
    validation.add_child(create_group("es31", &lib::es31_separate_shader_validation::ROOT));
    validation.add_child(create_group("es32", &lib::es32_separate_shader_validation::ROOT));
    group.add_child(validation);

    group
}
