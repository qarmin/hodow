// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsShaderExecUtil.hpp / .cpp  (deqp::gls::ShaderExecUtil::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds six executors (vertex/fragment/geometry/tess-control/tess-eval/compute)
// behind one polymorphic base. All six are ported now: `FragmentOutExecutor` backs
// Vertex/Fragment/Geometry (they only differ in which shaders build the program),
// `ComputeExecutor` and the new `PatchExecutor` (TessControl/TessEvaluation) share their
// buffer bookkeeping through `BufferIo`, held by composition rather than the inheritance
// upstream's `BufferIoExecutor` base class uses (`ShaderExecutor` is an enum, not a trait
// object). Geometry/TessControl/TessEvaluation were added for `opaque_type_indexing`
// (`hodow_cts/src/gles31/functional/opaque_type_indexing_tests.rs`), which - unlike
// `ShaderBuiltinConstantCase` - registers one *separate* case per shader stage rather than
// one case that iterates all six: on this project's own llvmpipe (which reports ES 3.2 and
// genuinely implements both `GL_EXT_geometry_shader`/`GL_EXT_tessellation_shader`),
// upstream's real `deqp-gles31` executes the geometry cases for real (Pass) and the two
// tessellation ones for real too, hitting a driver bug there
// (`GL_INVALID_FRAMEBUFFER_OPERATION` out of `glMapBufferRange`) that makes upstream itself
// report `Fail` - so reporting `NotSupported` unconditionally, as `builtin_constants` could
// safely do, would have disagreed with upstream on every one of those cases instead of
// agreeing with the driver's own bug. `useIntOutputs` is not threaded through as a runtime
// check the way upstream's `hasFloatRenderTargets` is: every context this suite can create
// is ES, and `glu::isContextTypeGLCore` is false for all of them, so it is always `true`
// here.
//
// Matrix-typed inputs/outputs (`compute_fragment_output_layout`/`compute_var_layout`, plus
// `frag_output_decl_and_assign`/`FragmentOutExecutor::execute`'s per-column readback and
// `BufferIo`'s std430 `matrix_stride`) are ported now, needed by
// `builtin_precision_tests`'s matrix family (`matrixCompMult`/`outerProduct`/`transpose`/
// `determinant`/`inverse`) - read directly off upstream's own matrix branches in
// `generateFragShaderOutputDecl`/`generateFragShaderOutAssign`/`FragmentOutExecutor::execute`/
// `BufferIoExecutor::computeVarLayout`/`copyToBuffer`/`copyFromBuffer`
// (`glsShaderExecUtil.cpp` ~310-380, ~600-670, ~1000-1120), not guessed from the scalar
// shape. A matrix output occupies one fragment-output location per *column*
// (`num_locations()` already returned `matrix_num_columns()` for a matrix - only the early
// bail-out was removed), each holding a `uvec{rows}` `floatBitsToUint` of that column,
// exactly like a float vector output; a matrix vertex/uniform *input* needs no shader-source
// change at all (`in mat2 name;`/`flat out mat2 name;` are both ordinary GLSL declarations,
// and `declare_var` already emits them generically off `DataType::name()`) - the only input
// side change is `FragmentOutExecutor::execute`'s attribute binding, which needs one
// `va::float_named_offset` call per column (a matrix vertex attribute consumes one GL
// attribute location per column, reached via `BindingPoint::Name`'s new offset field in
// `glu::draw_util`). A std430 buffer's matrix stride is the column's own vector alignment
// (`vec2`/`vec3`/`vec4` alignment, i.e. always a `vec4`-rounded 16 bytes for 3- and
// 4-row columns), repeated once per column - `compute_var_layout`'s matrix branch and
// `copy_to_buffer`/`copy_from_buffer`'s per-column loop mirror this exactly.

use std::collections::HashMap;
use std::fmt::Write as _;

use crate::glu::objects::{BufferMemMap, VertexArray};
use crate::glu::shader_util::{
    DataType, Precision, get_data_type_float_vec, get_data_type_int_vec, get_data_type_uint_vec,
};
use crate::glu::var_type::{StructType, VarType, declare_struct, declare_var};
use crate::glu::{self, Buffer, Framebuffer, ProgramSources, RenderContext, Renderbuffer, ShaderProgram, ShaderType};
use crate::glw::{self, GLuint};
use crate::tcu::TestError;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

/// `ShaderExecUtil::Symbol`
#[derive(Clone)]
pub struct Symbol {
    pub name: String,
    pub var_type: VarType,
}

impl Symbol {
    pub fn new(name: impl Into<String>, var_type: VarType) -> Self {
        Self {
            name: name.into(),
            var_type,
        }
    }
}

/// `ShaderExecUtil::ShaderSpec`
#[derive(Clone)]
pub struct ShaderSpec {
    pub version: glu::GlslVersion,
    pub inputs: Vec<Symbol>,
    pub outputs: Vec<Symbol>,
    pub global_declarations: String,
    pub source: String,
}

impl ShaderSpec {
    pub fn new(version: glu::GlslVersion) -> Self {
        Self {
            version,
            inputs: Vec::new(),
            outputs: Vec::new(),
            global_declarations: String::new(),
            source: String::new(),
        }
    }
}

/// `checkExtension`
fn check_extension(gl: &glw::Functions, extension: &str) -> Result<(), TestError> {
    if !glu::context_info::query_extensions(gl).contains(extension) {
        return Err(TestError::NotSupported(format!("{extension} is not supported")));
    }
    Ok(())
}

/// `checkLimit`
fn check_limit(gl: &glw::Functions, pname: u32, pname_str: &str, required: i32) -> Result<(), TestError> {
    let mut implementation_limit = -1;
    // SAFETY: every pname passed here is a single-integer query.
    unsafe { gl.get_integerv(pname, &mut implementation_limit) };
    // SAFETY: glGetError needs nothing but the current context.
    let error = unsafe { gl.get_error() };
    if error != glw::GL_NO_ERROR {
        return Err(TestError::Fail(format!(
            "Failed to query {pname_str} - got {}",
            glw::error_name(error)
        )));
    }
    if implementation_limit < required {
        return Err(TestError::NotSupported(format!(
            "Test requires {pname_str} >= {required}, got {implementation_limit}"
        )));
    }
    Ok(())
}

/// `checkTessSupport`
fn check_tess_support(gl: &glw::Functions, spec: &ShaderSpec, stage: PatchStage) -> Result<(), TestError> {
    let num_block_required = 2;

    if spec.version <= glu::GlslVersion::Es310 {
        check_extension(gl, "GL_EXT_tessellation_shader")?;
    }

    match stage {
        PatchStage::TessControl => check_limit(
            gl,
            glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
            "GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS",
            num_block_required,
        ),
        PatchStage::TessEvaluation => check_limit(
            gl,
            glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
            "GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS",
            num_block_required,
        ),
    }
}

fn query_int(gl: &glw::Functions, pname: u32) -> i32 {
    let mut value = 0;
    // SAFETY: every pname passed here is a single-integer query.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

/// The GLSL type a `bool`/`bvec` output becomes once it has to survive as a `flat`
/// varying - GLSL has no boolean interpolant, so it is carried as its same-width `int`.
fn varying_var_type(var_type: &VarType) -> VarType {
    let basic = var_type.basic_type();
    if basic.is_bool_or_bvec() {
        let vec_size = basic.scalar_size();
        let int_type = if vec_size > 1 {
            get_data_type_int_vec(vec_size)
        } else {
            DataType::Int
        };
        VarType::basic(int_type, Some(Precision::HighP))
    } else {
        var_type.clone()
    }
}

// Shader source generation - `generateVertexShader`/`generateFragmentShader`/... .

fn generate_vertex_shader(spec: &ShaderSpec, input_prefix: &str, output_prefix: &str) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    let _ = writeln!(src, "in highp vec4 a_position;");
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "in {};",
            declare_var(&input.var_type, &format!("{input_prefix}{}", input.name), 0)
        );
    }
    for output in &spec.outputs {
        let _ = writeln!(
            src,
            "flat out {};",
            declare_var(
                &varying_var_type(&output.var_type),
                &format!("{output_prefix}{}", output.name),
                0
            )
        );
    }
    let _ = writeln!(src, "\nvoid main (void)\n{{");
    let _ = writeln!(src, "    gl_Position = a_position;");
    let _ = writeln!(src, "    gl_PointSize = 1.0;\n");
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "\t{} = {input_prefix}{};",
            declare_var(&input.var_type, &input.name, 0),
            input.name
        );
    }
    for output in &spec.outputs {
        let _ = writeln!(src, "\t{};", declare_var(&output.var_type, &output.name, 0));
    }
    for line in spec.source.lines() {
        let _ = writeln!(src, "\t{line}");
    }
    for output in &spec.outputs {
        if output.var_type.basic_type().is_bool_or_bvec() {
            let vec_size = output.var_type.basic_type().scalar_size();
            let int_name = if vec_size > 1 {
                get_data_type_int_vec(vec_size).name()
            } else {
                "int"
            };
            let _ = writeln!(src, "\t{output_prefix}{} = {int_name}({});", output.name, output.name);
        } else {
            let _ = writeln!(src, "\t{output_prefix}{} = {};", output.name, output.name);
        }
    }
    let _ = writeln!(src, "}}");
    src
}

fn generate_passthrough_vertex_shader(spec: &ShaderSpec, input_prefix: &str, output_prefix: &str) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}\nin highp vec4 a_position;", spec.version.declaration());
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "in {};",
            declare_var(&input.var_type, &format!("{input_prefix}{}", input.name), 0)
        );
        let _ = writeln!(
            src,
            "flat out {};",
            declare_var(&input.var_type, &format!("{output_prefix}{}", input.name), 0)
        );
    }
    let _ = writeln!(src, "\nvoid main (void)\n{{");
    let _ = writeln!(src, "    gl_Position = a_position;");
    let _ = writeln!(src, "    gl_PointSize = 1.0;");
    for input in &spec.inputs {
        let _ = writeln!(src, "\t{output_prefix}{} = {input_prefix}{};", input.name, input.name);
    }
    let _ = writeln!(src, "}}");
    src
}

fn generate_geometry_shader(spec: &ShaderSpec, input_prefix: &str, output_prefix: &str) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    if spec.version <= glu::GlslVersion::Es310 {
        let _ = writeln!(src, "#extension GL_EXT_geometry_shader : require");
    }
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    let _ = writeln!(src, "layout(points) in;");
    let _ = writeln!(src, "layout(points, max_vertices = 1) out;");
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "flat in {}[];",
            declare_var(&input.var_type, &format!("{input_prefix}{}", input.name), 0)
        );
    }
    for output in &spec.outputs {
        let _ = writeln!(
            src,
            "flat out {};",
            declare_var(
                &varying_var_type(&output.var_type),
                &format!("{output_prefix}{}", output.name),
                0
            )
        );
    }
    let _ = writeln!(src, "\nvoid main (void)\n{{");
    let _ = writeln!(src, "    gl_Position = gl_in[0].gl_Position;\n");
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "\t{} = {input_prefix}{}[0];",
            declare_var(&input.var_type, &input.name, 0),
            input.name
        );
    }
    for output in &spec.outputs {
        let _ = writeln!(src, "\t{};", declare_var(&output.var_type, &output.name, 0));
    }
    let _ = writeln!(src);
    for line in spec.source.lines() {
        let _ = writeln!(src, "\t{line}");
    }
    for output in &spec.outputs {
        if output.var_type.basic_type().is_bool_or_bvec() {
            let vec_size = output.var_type.basic_type().scalar_size();
            let int_name = if vec_size > 1 {
                get_data_type_int_vec(vec_size).name()
            } else {
                "int"
            };
            let _ = writeln!(src, "\t{output_prefix}{} = {int_name}({});", output.name, output.name);
        } else {
            let _ = writeln!(src, "\t{output_prefix}{} = {};", output.name, output.name);
        }
    }
    let _ = writeln!(src, "    EmitVertex();");
    let _ = writeln!(src, "    EndPrimitive();");
    let _ = writeln!(src, "}}");
    src
}

/// `generateFragShaderOutputDecl` + `generateFragShaderOutAssign` combined, since both
/// always walk the same output list. `useIntOutputs` is always true here - see the module
/// header - so a float output always goes through `floatBitsToUint` and a bool through an
/// int cast; matrix outputs are rejected earlier, in `compute_fragment_output_layout`.
fn frag_output_decl_and_assign(
    spec: &ShaderSpec,
    out_location_map: &HashMap<String, i32>,
    output_prefix: &str,
    value_prefix: &str,
) -> (String, String) {
    let mut decl = String::new();
    let mut assign = String::new();
    for output in &spec.outputs {
        let location = out_location_map[&output.name];
        let out_var_name = format!("{output_prefix}{}", output.name);
        let basic = output.var_type.basic_type();

        if basic.is_float_or_vec() {
            let vec_size = basic.scalar_size();
            let uint_type = if vec_size > 1 {
                get_data_type_uint_vec(vec_size)
            } else {
                DataType::Uint
            };
            let _ = writeln!(
                decl,
                "layout(location = {location}) out highp {} {out_var_name};",
                uint_type.name()
            );
            let _ = writeln!(
                assign,
                "\t{out_var_name} = floatBitsToUint({value_prefix}{});",
                output.name
            );
        } else if basic.is_matrix() {
            // `generateFragShaderOutputDecl`/`generateFragShaderOutAssign`'s matrix branch:
            // one `uvec{rows}` output location per column, each a `floatBitsToUint` of that
            // column - `useIntOutputs` is always true here (see the module header).
            let num_rows = basic.matrix_num_rows();
            let num_cols = basic.matrix_num_columns();
            let uint_type = get_data_type_uint_vec(num_rows);
            for col in 0..num_cols {
                let _ = writeln!(
                    decl,
                    "layout(location = {}) out highp {} {out_var_name}_{col};",
                    location + col,
                    uint_type.name()
                );
                let _ = writeln!(
                    assign,
                    "\t{out_var_name}_{col} = floatBitsToUint({value_prefix}{}[{col}]);",
                    output.name
                );
            }
        } else if basic.is_bool_or_bvec() {
            let vec_size = basic.scalar_size();
            let int_type = if vec_size > 1 {
                get_data_type_int_vec(vec_size)
            } else {
                DataType::Int
            };
            let _ = writeln!(
                decl,
                "layout(location = {location}) out highp {} {out_var_name};",
                int_type.name()
            );
            let _ = writeln!(
                assign,
                "\t{out_var_name} = {}({value_prefix}{});",
                int_type.name(),
                output.name
            );
        } else {
            let _ = writeln!(
                decl,
                "layout(location = {location}) out {};",
                declare_var(&output.var_type, &out_var_name, 0)
            );
            let _ = writeln!(assign, "\t{out_var_name} = {value_prefix}{};", output.name);
        }
    }
    (decl, assign)
}

fn generate_fragment_shader(
    spec: &ShaderSpec,
    out_location_map: &HashMap<String, i32>,
    input_prefix: &str,
    output_prefix: &str,
) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "flat in {};",
            declare_var(&input.var_type, &format!("{input_prefix}{}", input.name), 0)
        );
    }
    let (decl, assign) = frag_output_decl_and_assign(spec, out_location_map, output_prefix, "");
    src.push_str(&decl);
    let _ = writeln!(src, "\nvoid main (void)\n{{");
    for input in &spec.inputs {
        let _ = writeln!(
            src,
            "\t{} = {input_prefix}{};",
            declare_var(&input.var_type, &input.name, 0),
            input.name
        );
    }
    for output in &spec.outputs {
        let _ = writeln!(src, "\t{};", declare_var(&output.var_type, &output.name, 0));
    }
    for line in spec.source.lines() {
        let _ = writeln!(src, "\t{line}");
    }
    src.push_str(&assign);
    let _ = writeln!(src, "}}");
    src
}

fn generate_passthrough_fragment_shader(
    spec: &ShaderSpec,
    out_location_map: &HashMap<String, i32>,
    input_prefix: &str,
    output_prefix: &str,
) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    for output in &spec.outputs {
        let _ = writeln!(
            src,
            "flat in {};",
            declare_var(
                &varying_var_type(&output.var_type),
                &format!("{input_prefix}{}", output.name),
                0
            )
        );
    }
    let (decl, assign) = frag_output_decl_and_assign(spec, out_location_map, output_prefix, input_prefix);
    src.push_str(&decl);
    let _ = writeln!(src, "\nvoid main (void)\n{{");
    src.push_str(&assign);
    let _ = writeln!(src, "}}");
    src
}

// FragmentOutExecutor - backs the Vertex and Fragment executors.

struct FragmentOutputLayout {
    /// `locationSymbols` - which output symbol (by index into `outputs`) owns each
    /// consecutive fragment output location.
    location_symbols: Vec<usize>,
    location_map: HashMap<String, i32>,
}

fn compute_fragment_output_layout(symbols: &[Symbol]) -> FragmentOutputLayout {
    let mut location_symbols = Vec::new();
    let mut location_map = HashMap::new();
    let mut location = 0i32;

    for (idx, symbol) in symbols.iter().enumerate() {
        // `num_locations()` already returns `matrix_num_columns()` for a matrix - one
        // fragment output location per column, matching `location_symbols` pointing back
        // at this same symbol index once per column below.
        let num_locations = symbol.var_type.basic_type().num_locations();
        location_map.insert(symbol.name.clone(), location);
        location += num_locations;
        for _ in 0..num_locations {
            location_symbols.push(idx);
        }
    }

    FragmentOutputLayout {
        location_symbols,
        location_map,
    }
}

fn renderbuffer_format_for_output(output_type: &VarType) -> Result<TextureFormat, TestError> {
    let basic = output_type.basic_type();
    let num_comps = basic.num_components();
    let order = match num_comps {
        1 => ChannelOrder::R,
        2 => ChannelOrder::RG,
        // No RGB variant is renderable, so 3- and 4-component outputs both land in RGBA.
        3 | 4 => ChannelOrder::RGBA,
        other => {
            return Err(TestError::InternalError(format!(
                "{other}-component ShaderExecUtil output"
            )));
        }
    };
    let channel_type = match basic.scalar_type() {
        DataType::Uint => ChannelType::UNSIGNED_INT32,
        DataType::Int | DataType::Bool => ChannelType::SIGNED_INT32,
        // useIntOutputs is always true on ES - see the module header.
        DataType::Float => ChannelType::UNSIGNED_INT32,
        other => {
            return Err(TestError::InternalError(format!(
                "{} is not a valid ShaderExecUtil output type",
                other.name()
            )));
        }
    };
    Ok(TextureFormat::new(order, channel_type))
}

fn internal_format_for(format: TextureFormat) -> Result<u32, TestError> {
    use ChannelOrder::{R, RG, RGBA};
    use ChannelType::{FLOAT, SIGNED_INT32, UNSIGNED_INT32};
    Ok(match (format.order, format.type_) {
        (R, SIGNED_INT32) => glw::GL_R32I,
        (R, UNSIGNED_INT32) => glw::GL_R32UI,
        (R, FLOAT) => glw::GL_R32F,
        (RG, SIGNED_INT32) => glw::GL_RG32I,
        (RG, UNSIGNED_INT32) => glw::GL_RG32UI,
        (RG, FLOAT) => glw::GL_RG32F,
        (RGBA, SIGNED_INT32) => glw::GL_RGBA32I,
        (RGBA, UNSIGNED_INT32) => glw::GL_RGBA32UI,
        (RGBA, FLOAT) => glw::GL_RGBA32F,
        _ => {
            return Err(TestError::NotPorted(format!(
                "renderbuffer internal format for {:?}/{:?}",
                format.order, format.type_
            )));
        }
    })
}

pub struct FragmentOutExecutor<'gl> {
    render_context: &'gl RenderContext,
    program: ShaderProgram<'gl>,
    inputs: Vec<Symbol>,
    outputs: Vec<Symbol>,
    output_layout: FragmentOutputLayout,
}

impl<'gl> FragmentOutExecutor<'gl> {
    fn new_vertex(render_context: &'gl RenderContext, spec: &ShaderSpec) -> Result<Self, TestError> {
        let output_layout = compute_fragment_output_layout(&spec.outputs);
        let vertex_src = generate_vertex_shader(spec, "a_", "vtx_out_");
        let fragment_src = generate_passthrough_fragment_shader(spec, &output_layout.location_map, "vtx_out_", "o_");
        let program = ShaderProgram::new(
            render_context.functions(),
            &ProgramSources::vtx_frag(vertex_src, fragment_src),
        );
        Ok(Self {
            render_context,
            program,
            inputs: spec.inputs.clone(),
            outputs: spec.outputs.clone(),
            output_layout,
        })
    }

    fn new_fragment(render_context: &'gl RenderContext, spec: &ShaderSpec) -> Result<Self, TestError> {
        let output_layout = compute_fragment_output_layout(&spec.outputs);
        let vertex_src = generate_passthrough_vertex_shader(spec, "a_", "vtx_out_");
        let fragment_src = generate_fragment_shader(spec, &output_layout.location_map, "vtx_out_", "o_");
        let program = ShaderProgram::new(
            render_context.functions(),
            &ProgramSources::vtx_frag(vertex_src, fragment_src),
        );
        Ok(Self {
            render_context,
            program,
            inputs: spec.inputs.clone(),
            outputs: spec.outputs.clone(),
            output_layout,
        })
    }

    /// `GeometryShaderExecutor::create`
    fn new_geometry(render_context: &'gl RenderContext, spec: &ShaderSpec) -> Result<Self, TestError> {
        if spec.version <= glu::GlslVersion::Es310 {
            check_extension(render_context.functions(), "GL_EXT_geometry_shader")?;
        }

        let output_layout = compute_fragment_output_layout(&spec.outputs);
        let vertex_src = generate_passthrough_vertex_shader(spec, "a_", "vtx_out_");
        let geometry_src = generate_geometry_shader(spec, "vtx_out_", "geom_out_");
        let fragment_src = generate_passthrough_fragment_shader(spec, &output_layout.location_map, "geom_out_", "o_");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vertex_src)
            .with(ShaderType::Geometry, geometry_src)
            .with(ShaderType::Fragment, fragment_src);
        let program = ShaderProgram::new(render_context.functions(), &sources);
        Ok(Self {
            render_context,
            program,
            inputs: spec.inputs.clone(),
            outputs: spec.outputs.clone(),
            output_layout,
        })
    }

    fn execute(&self, num_values: i32, inputs: &[&[u8]], outputs: &mut [&mut [u8]]) -> Result<(), TestError> {
        let gl = self.render_context.functions();
        let max_renderbuffer_size = query_int(gl, glw::GL_MAX_RENDERBUFFER_SIZE);
        let framebuffer_w = max_renderbuffer_size.min(num_values).max(1);
        let framebuffer_h = num_values / framebuffer_w + i32::from(num_values % framebuffer_w != 0);

        if framebuffer_h > max_renderbuffer_size {
            return Err(TestError::NotSupported(
                "Value count is too high for maximum supported renderbuffer size".to_string(),
            ));
        }

        let framebuffer = Framebuffer::new(gl);
        let renderbuffers: Vec<Renderbuffer<'_>> = (0..self.output_layout.location_symbols.len())
            .map(|_| Renderbuffer::new(gl))
            .collect();

        let mut positions = Vec::with_capacity(num_values as usize * 2);
        for val_ndx in 0..num_values {
            let ix = val_ndx % framebuffer_w;
            let iy = val_ndx / framebuffer_w;
            let fx = -1.0 + 2.0 * ((ix as f32 + 0.5) / framebuffer_w as f32);
            let fy = -1.0 + 2.0 * ((iy as f32 + 0.5) / framebuffer_h as f32);
            positions.push(fx);
            positions.push(fy);
        }
        // Attribute names have to outlive `vertex_arrays` below, which borrows them.
        let input_names: Vec<String> = self.inputs.iter().map(|s| format!("a_{}", s.name)).collect();
        let mut vertex_arrays = vec![glu::va::float("a_position", 2, num_values, 0, &positions)];
        for ((symbol, name), data) in self.inputs.iter().zip(&input_names).zip(inputs) {
            let basic = symbol.var_type.basic_type();
            let vec_size = basic.scalar_size();
            let num_scalars = (num_values as usize) * vec_size as usize;
            if basic.is_float_or_vec() {
                // SAFETY: the caller supplies `num_values * vec_size` native-endian `f32`
                // values, byte-cast from a `Vec<f32>` whose own pointer is already
                // `f32`-aligned - see the module header on this convention.
                let floats = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<f32>(), num_scalars) };
                vertex_arrays.push(glu::va::float(name, vec_size, num_values, 0, floats));
            } else if basic.is_int_or_ivec() {
                // SAFETY: as above, for `i32`.
                let ints = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<i32>(), num_scalars) };
                vertex_arrays.push(glu::va::int32(name, vec_size, num_values, 0, ints));
            } else if basic.is_uint_or_uvec() {
                // SAFETY: as above, for `u32`.
                let uints = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<u32>(), num_scalars) };
                vertex_arrays.push(glu::va::uint32(name, vec_size, num_values, 0, uints));
            } else if basic.is_matrix() {
                // A matrix vertex attribute occupies one GL attribute location per
                // column, reached via one binding per column at an increasing offset off
                // the attribute's own resolved location (`glu::draw_util`'s
                // `BindingPoint::Name` offset) - `FragmentOutExecutor::execute`'s own
                // matrix branch in upstream, `((const float*)ptr) + colNdx*numRows` per
                // column with `stride = numRows*numCols*sizeof(float)` (every value is
                // one flat, column-major matrix block, so consecutive values of the same
                // column are `vec_size` floats apart).
                let num_rows = basic.matrix_num_rows();
                let num_cols = basic.matrix_num_columns();
                let stride_bytes = vec_size * 4;
                // SAFETY: as above, for `f32`.
                let floats = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<f32>(), num_scalars) };
                for col in 0..num_cols {
                    let start = (col * num_rows) as usize;
                    vertex_arrays.push(glu::va::float_named_offset(
                        name,
                        col,
                        num_rows,
                        num_values,
                        stride_bytes,
                        &floats[start..],
                    ));
                }
            } else {
                return Err(TestError::NotPorted(format!(
                    "{}-typed FragmentOutExecutor input",
                    basic.name()
                )));
            }
        }

        // SAFETY: every object bound below is one this call just created, and the
        // renderbuffer storage calls follow directly with an internal format this
        // module derives from the output's own type.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        }

        for (out_ndx, &sym_idx) in self.output_layout.location_symbols.iter().enumerate() {
            let format = renderbuffer_format_for_output(&self.outputs[sym_idx].var_type)?;
            let internal_format = internal_format_for(format)?;
            // SAFETY: as above.
            unsafe {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffers[out_ndx].get());
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format, framebuffer_w, framebuffer_h);
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0 + out_ndx as u32,
                    glw::GL_RENDERBUFFER,
                    renderbuffers[out_ndx].get(),
                );
            }
        }
        // SAFETY: unbinding is always valid.
        unsafe { gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0) };
        glu::expect_no_error(gl, "Failed to set up framebuffer object")?;
        // SAFETY: the framebuffer above was just bound.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(format!("framebuffer incomplete: 0x{status:x}")));
        }

        {
            let draw_buffers: Vec<u32> = (0..self.output_layout.location_symbols.len())
                .map(|i| glw::GL_COLOR_ATTACHMENT0 + i as u32)
                .collect();
            // SAFETY: the slice outlives the call.
            unsafe { gl.draw_buffers(draw_buffers.len() as i32, draw_buffers.as_ptr()) };
            glu::expect_no_error(gl, "glDrawBuffers()")?;
        }

        // SAFETY: a valid viewport matching the framebuffer just built.
        unsafe { gl.viewport(0, 0, framebuffer_w, framebuffer_h) };
        glu::draw(
            self.render_context,
            self.program.program(),
            &vertex_arrays,
            &glu::pr::list(glu::PrimitiveType::Points, num_values),
        )?;
        glu::expect_no_error(gl, "Error in draw")?;

        for (out_ndx, output) in self.outputs.iter().enumerate() {
            let basic = output.var_type.basic_type();
            let is_matrix = basic.is_matrix();
            // One render target (hence one `read_buffer`/readback pass) per matrix
            // column, each holding `num_column_comps` components - `num_component`s for
            // a plain vector output, matching upstream's own `numVecs`/`numComps` split
            // in `copyToBuffer`/`copyFromBuffer` (see the module header).
            let num_vecs = if is_matrix {
                basic.matrix_num_columns() as usize
            } else {
                1
            };
            let num_column_comps = if is_matrix {
                basic.matrix_num_rows() as usize
            } else {
                basic.num_components() as usize
            };
            let format = renderbuffer_format_for_output(&output.var_type)?;
            let read_format = TextureFormat::new(ChannelOrder::RGBA, format.type_);
            let location = self.output_layout.location_map[&output.name];
            let dst = &mut outputs[out_ndx];

            for vec_ndx in 0..num_vecs {
                let mut tmp = TextureLevel::new(read_format, framebuffer_w as u32, framebuffer_h as u32, 1)?;
                // SAFETY: the location just bound is one of the color attachments set up
                // above (one per column, for a matrix).
                unsafe { gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + (location as usize + vec_ndx) as u32) };
                {
                    let mut access = tmp.get_access();
                    glu::read_pixels(self.render_context, 0, 0, &mut access)?;
                }
                glu::expect_no_error(gl, "Reading pixels")?;

                let raw = tmp.data();
                for val_ndx in 0..num_values as usize {
                    // The readback buffer is always RGBA (4 x 4-byte lanes) regardless of
                    // how many components the output actually declares.
                    let src_off = val_ndx * 4 * 4;
                    let dst_off = (val_ndx * num_vecs + vec_ndx) * num_column_comps * 4;
                    dst[dst_off..dst_off + num_column_comps * 4]
                        .copy_from_slice(&raw[src_off..src_off + num_column_comps * 4]);
                }
            }
        }

        // SAFETY: unbinding is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        Ok(())
    }
}

// BufferIoExecutor / ComputeExecutor - the SSBO-based executors.

#[derive(Clone, Copy)]
struct VarLayout {
    offset: u32,
    stride: u32,
    /// `BufferIoExecutor::VarLayout::matrixStride` - the byte distance between two
    /// consecutive columns of a matrix-typed symbol; `0` for a scalar/vector one.
    matrix_stride: u32,
}

fn vec_std430_byte_alignment(scalar_size: i32) -> u32 {
    match scalar_size {
        1 => 4,
        2 => 8,
        3 | 4 => 16,
        other => unreachable!("{other}-component vector has no std430 alignment"),
    }
}

fn align_up(value: u32, alignment: u32) -> u32 {
    if alignment == 0 {
        value
    } else {
        value.div_ceil(alignment) * alignment
    }
}

fn compute_var_layout(symbols: &[Symbol]) -> Vec<VarLayout> {
    let mut max_alignment = 0u32;
    let mut cur_offset = 0u32;
    let mut layout = Vec::with_capacity(symbols.len());

    for symbol in symbols {
        let basic = symbol.var_type.basic_type();

        if basic.is_matrix() {
            // `computeVarLayout`'s matrix branch: one std430 column-vector alignment
            // (`vec2`/`vec3`/`vec4`, i.e. always 16-byte-rounded for 3/4 rows) repeated
            // once per column - a matrix's own alignment/stride is its column vector's,
            // never the whole matrix's flat scalar count.
            let num_vecs = basic.matrix_num_columns() as u32;
            let vec_type = get_data_type_float_vec(basic.matrix_num_rows());
            let alignment = vec_std430_byte_alignment(vec_type.scalar_size());

            cur_offset = align_up(cur_offset, alignment);
            max_alignment = max_alignment.max(alignment);
            layout.push(VarLayout {
                offset: cur_offset,
                stride: 0,
                matrix_stride: alignment,
            });
            cur_offset += alignment * num_vecs;
        } else {
            let alignment = vec_std430_byte_alignment(basic.scalar_size());
            let size = basic.scalar_size() as u32 * 4;

            cur_offset = align_up(cur_offset, alignment);
            max_alignment = max_alignment.max(alignment);
            layout.push(VarLayout {
                offset: cur_offset,
                stride: 0,
                matrix_stride: 0,
            });
            cur_offset += size;
        }
    }

    let total_size = align_up(cur_offset, max_alignment.max(1));
    for entry in &mut layout {
        entry.stride = total_size;
    }
    layout
}

fn layout_stride(layout: &[VarLayout]) -> u32 {
    layout.first().map_or(0, |l| l.stride)
}

/// `BufferIoExecutor::copyToBuffer` - `num_vecs` is the matrix's own column count
/// (`1` for a scalar/vector `basic`), `num_comps` its column height (the whole scalar
/// count for a non-matrix); `copy_from_buffer` below is the same loop with the two
/// offsets swapped.
fn copy_to_buffer(basic: DataType, layout: &VarLayout, num_values: i32, src: &[u8], dst: &mut [u8]) {
    let is_matrix = basic.is_matrix();
    let scalar_size = basic.scalar_size() as usize;
    let num_vecs = if is_matrix {
        basic.matrix_num_columns() as usize
    } else {
        1
    };
    let num_comps = scalar_size / num_vecs;
    let comp_bytes = num_comps * 4;

    for elem in 0..num_values as usize {
        for vec_ndx in 0..num_vecs {
            let src_off = 4 * (elem * scalar_size + vec_ndx * num_comps);
            let dst_off = layout.offset as usize
                + layout.stride as usize * elem
                + if is_matrix {
                    layout.matrix_stride as usize * vec_ndx
                } else {
                    0
                };
            dst[dst_off..dst_off + comp_bytes].copy_from_slice(&src[src_off..src_off + comp_bytes]);
        }
    }
}

/// `BufferIoExecutor::copyFromBuffer` - see `copy_to_buffer`'s own doc comment.
fn copy_from_buffer(basic: DataType, layout: &VarLayout, num_values: i32, src: &[u8], dst: &mut [u8]) {
    let is_matrix = basic.is_matrix();
    let scalar_size = basic.scalar_size() as usize;
    let num_vecs = if is_matrix {
        basic.matrix_num_columns() as usize
    } else {
        1
    };
    let num_comps = scalar_size / num_vecs;
    let comp_bytes = num_comps * 4;

    for elem in 0..num_values as usize {
        for vec_ndx in 0..num_vecs {
            let src_off = layout.offset as usize
                + layout.stride as usize * elem
                + if is_matrix {
                    layout.matrix_stride as usize * vec_ndx
                } else {
                    0
                };
            let dst_off = 4 * (elem * scalar_size + vec_ndx * num_comps);
            dst[dst_off..dst_off + comp_bytes].copy_from_slice(&src[src_off..src_off + comp_bytes]);
        }
    }
}

fn declare_buffer_blocks(spec: &ShaderSpec) -> String {
    let mut src = String::new();

    if !spec.inputs.is_empty() {
        let mut input_struct = StructType::new("Inputs");
        for symbol in &spec.inputs {
            input_struct.add_member(&symbol.name, symbol.var_type.clone());
        }
        let _ = writeln!(src, "{};", declare_struct(&input_struct, 0));
    }
    {
        let mut output_struct = StructType::new("Outputs");
        for symbol in &spec.outputs {
            output_struct.add_member(&symbol.name, symbol.var_type.clone());
        }
        let _ = writeln!(src, "{};", declare_struct(&output_struct, 0));
    }
    let _ = writeln!(src);

    if !spec.inputs.is_empty() {
        let _ = writeln!(
            src,
            "layout(binding = 0, std430) buffer InBuffer\n{{\n    Inputs inputs[];\n}};"
        );
    }
    let _ = writeln!(
        src,
        "layout(binding = 1, std430) buffer OutBuffer\n{{\n    Outputs outputs[];\n}};\n"
    );
    src
}

fn generate_exec_buffer_io(spec: &ShaderSpec, invocation_ndx_name: &str) -> String {
    let mut src = String::new();
    for symbol in &spec.inputs {
        let _ = writeln!(
            src,
            "\t{} = inputs[{invocation_ndx_name}].{};",
            declare_var(&symbol.var_type, &symbol.name, 0),
            symbol.name
        );
    }
    for symbol in &spec.outputs {
        let _ = writeln!(src, "\t{};", declare_var(&symbol.var_type, &symbol.name, 0));
    }
    let _ = writeln!(src);
    for line in spec.source.lines() {
        let _ = writeln!(src, "\t{line}");
    }
    let _ = writeln!(src);
    for symbol in &spec.outputs {
        let _ = writeln!(
            src,
            "\toutputs[{invocation_ndx_name}].{} = {};",
            symbol.name, symbol.name
        );
    }
    src
}

fn generate_compute_shader(spec: &ShaderSpec) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    let _ = writeln!(src, "layout(local_size_x = 1) in;\n");
    src.push_str(&declare_buffer_blocks(spec));
    let _ = writeln!(src, "void main (void)\n{{");
    let _ = writeln!(
        src,
        "    uint invocationNdx = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z"
    );
    let _ = writeln!(
        src,
        "                       + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;"
    );
    src.push_str(&generate_exec_buffer_io(spec, "invocationNdx"));
    let _ = writeln!(src, "}}");
    src
}

/// Shared buffer bookkeeping behind `ComputeExecutor` and `PatchExecutor` -
/// upstream's `BufferIoExecutor` base class, held here by composition instead of
/// inheritance since `ShaderExecutor` is an enum rather than a trait object.
struct BufferIo<'gl> {
    gl: &'gl glw::Functions,
    inputs: Vec<Symbol>,
    outputs: Vec<Symbol>,
    input_layout: Vec<VarLayout>,
    output_layout: Vec<VarLayout>,
    input_buffer: Buffer<'gl>,
    output_buffer: Buffer<'gl>,
}

impl<'gl> BufferIo<'gl> {
    fn new(gl: &'gl glw::Functions, spec: &ShaderSpec) -> Result<Self, TestError> {
        let input_layout = compute_var_layout(&spec.inputs);
        let output_layout = compute_var_layout(&spec.outputs);
        Ok(Self {
            gl,
            inputs: spec.inputs.clone(),
            outputs: spec.outputs.clone(),
            input_layout,
            output_layout,
            input_buffer: Buffer::new(gl),
            output_buffer: Buffer::new(gl),
        })
    }

    fn has_inputs(&self) -> bool {
        !self.inputs.is_empty()
    }

    fn init_buffers(&self, num_values: i32) {
        let in_size = num_values as i64 * layout_stride(&self.input_layout) as i64;
        let out_size = num_values as i64 * layout_stride(&self.output_layout) as i64;
        // SAFETY: these are plain allocation requests; a zero size is a valid, empty one.
        unsafe {
            self.gl
                .bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.input_buffer.get());
            self.gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                in_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            );
            self.gl
                .bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.output_buffer.get());
            self.gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                out_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            );
        }
    }

    fn upload_input_buffer(&self, inputs: &[&[u8]], num_values: i32) -> Result<(), TestError> {
        let size = num_values as i64 * layout_stride(&self.input_layout) as i64;
        if size == 0 {
            return Ok(()); // No inputs.
        }
        // SAFETY: the buffer is this executor's own.
        unsafe {
            self.gl
                .bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.input_buffer.get())
        };
        let map = BufferMemMap::new(
            self.gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_WRITE_BIT,
        )
        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
        // SAFETY: the mapping covers exactly `size` writable bytes, just computed above.
        let dst = unsafe { std::slice::from_raw_parts_mut(map.get().cast::<u8>(), size as usize) };
        for ((symbol, layout), src) in self.inputs.iter().zip(&self.input_layout).zip(inputs) {
            copy_to_buffer(symbol.var_type.basic_type(), layout, num_values, src, dst);
        }
        Ok(())
    }

    fn read_output_buffer(&self, outputs: &mut [&mut [u8]], num_values: i32) -> Result<(), TestError> {
        let size = num_values as i64 * layout_stride(&self.output_layout) as i64;
        // SAFETY: a plain state-setting call and a bind of this executor's own buffer.
        unsafe {
            self.gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT);
            self.gl
                .bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.output_buffer.get());
        }
        let map = BufferMemMap::new(
            self.gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT,
        )
        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
        // SAFETY: the mapping covers exactly `size` readable bytes, just computed above.
        let src = unsafe { std::slice::from_raw_parts(map.get().cast::<u8>(), size as usize) };
        for ((symbol, layout), dst) in self.outputs.iter().zip(&self.output_layout).zip(outputs.iter_mut()) {
            copy_from_buffer(symbol.var_type.basic_type(), layout, num_values, src, dst);
        }
        Ok(())
    }
}

pub struct ComputeExecutor<'gl> {
    gl: &'gl glw::Functions,
    program: ShaderProgram<'gl>,
    io: BufferIo<'gl>,
}

/// The minimum `GL_MAX_COMPUTE_WORK_GROUP_COUNT`/`_SIZE` guaranteed by ES 3.1 - upstream's
/// own comment on `m_maxWorkSize`.
const MAX_VALUES_PER_INVOCATION: i32 = 128;

impl<'gl> ComputeExecutor<'gl> {
    fn new(gl: &'gl glw::Functions, spec: &ShaderSpec) -> Result<Self, TestError> {
        let io = BufferIo::new(gl, spec)?;
        let source = generate_compute_shader(spec);
        let program = ShaderProgram::new(gl, &ProgramSources::compute(source));
        Ok(Self { gl, program, io })
    }

    fn execute(&self, num_values: i32, inputs: &[&[u8]], outputs: &mut [&mut [u8]]) -> Result<(), TestError> {
        let input_stride = layout_stride(&self.io.input_layout);
        let output_stride = layout_stride(&self.io.output_layout);

        self.io.init_buffers(num_values);
        self.io.upload_input_buffer(inputs, num_values)?;

        let mut cur_offset = 0;
        while cur_offset < num_values {
            let num_to_exec = MAX_VALUES_PER_INVOCATION.min(num_values - cur_offset);

            // SAFETY: every range bound below stays inside the buffer `init_buffers` just
            // sized for `num_values` elements.
            unsafe {
                if input_stride > 0 {
                    self.gl.bind_buffer_range(
                        glw::GL_SHADER_STORAGE_BUFFER,
                        0,
                        self.io.input_buffer.get(),
                        (cur_offset as i64 * input_stride as i64) as isize,
                        (num_to_exec as i64 * input_stride as i64) as isize,
                    );
                }
                self.gl.bind_buffer_range(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    1,
                    self.io.output_buffer.get(),
                    (cur_offset as i64 * output_stride as i64) as isize,
                    (num_to_exec as i64 * output_stride as i64) as isize,
                );
            }
            glu::expect_no_error(self.gl, "glBindBufferRange(GL_SHADER_STORAGE_BUFFER)")?;

            // SAFETY: the program is linked (checked by the caller via `is_ok`) and every
            // buffer range above was just bound.
            unsafe { self.gl.dispatch_compute(num_to_exec as GLuint, 1, 1) };
            glu::expect_no_error(self.gl, "glDispatchCompute()")?;

            cur_offset += num_to_exec;
        }

        self.io.read_output_buffer(outputs, num_values)
    }
}

// PatchExecutor - TessControlExecutor/TessEvaluationExecutor, upstream's other two
// `BufferIoExecutor` derivatives. Both render an SSBO-per-invocation program over
// `GL_PATCHES`, differing only in which stage carries the buffer I/O and how many
// vertices form one patch.

fn generate_vertex_shader_for_tess(version: glu::GlslVersion) -> String {
    format!(
        "{}\n\nvoid main (void)\n{{\n    gl_Position = vec4(gl_VertexID/2, gl_VertexID%2, 0.0, 1.0);\n}}\n",
        version.declaration()
    )
}

fn generate_empty_fragment_source(version: glu::GlslVersion) -> String {
    format!("{}\nvoid main (void)\n{{\n}}\n", version.declaration())
}

fn tess_ext_pragma(version: glu::GlslVersion) -> &'static str {
    if version <= glu::GlslVersion::Es310 {
        "#extension GL_EXT_tessellation_shader : require\n"
    } else {
        ""
    }
}

fn generate_tess_control_shader(spec: &ShaderSpec) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    src.push_str(tess_ext_pragma(spec.version));
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    let _ = writeln!(src, "\nlayout(vertices = 1) out;\n");
    src.push_str(&declare_buffer_blocks(spec));
    let _ = writeln!(src, "void main (void)\n{{");
    for ndx in 0..2 {
        let _ = writeln!(src, "\tgl_TessLevelInner[{ndx}] = 1.0;");
    }
    for ndx in 0..4 {
        let _ = writeln!(src, "\tgl_TessLevelOuter[{ndx}] = 1.0;");
    }
    let _ = writeln!(src, "\n\thighp uint invocationId = uint(gl_PrimitiveID);");
    src.push_str(&generate_exec_buffer_io(spec, "invocationId"));
    let _ = writeln!(src, "}}");
    src
}

fn generate_empty_tess_eval_shader(version: glu::GlslVersion) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", version.declaration());
    src.push_str(tess_ext_pragma(version));
    let _ = writeln!(src, "layout(triangles, ccw) in;");
    let _ = writeln!(
        src,
        "\nvoid main (void)\n{{\n\tgl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);\n}}"
    );
    src
}

fn generate_passthrough_tess_control_shader(version: glu::GlslVersion) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", version.declaration());
    src.push_str(tess_ext_pragma(version));
    let _ = writeln!(src, "layout(vertices = 1) out;\n");
    let _ = writeln!(src, "void main (void)\n{{");
    for ndx in 0..2 {
        let _ = writeln!(src, "\tgl_TessLevelInner[{ndx}] = 1.0;");
    }
    for ndx in 0..4 {
        let _ = writeln!(src, "\tgl_TessLevelOuter[{ndx}] = 1.0;");
    }
    let _ = writeln!(src, "}}");
    src
}

fn generate_tess_eval_shader(spec: &ShaderSpec) -> String {
    let mut src = String::new();
    let _ = writeln!(src, "{}", spec.version.declaration());
    src.push_str(tess_ext_pragma(spec.version));
    if !spec.global_declarations.is_empty() {
        let _ = writeln!(src, "{}", spec.global_declarations);
    }
    let _ = writeln!(src, "\nlayout(isolines, equal_spacing) in;\n");
    src.push_str(&declare_buffer_blocks(spec));
    let _ = writeln!(src, "void main (void)\n{{");
    let _ = writeln!(src, "\tgl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);");
    let _ = writeln!(
        src,
        "\thighp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);"
    );
    src.push_str(&generate_exec_buffer_io(spec, "invocationId"));
    let _ = writeln!(src, "}}");
    src
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PatchStage {
    TessControl,
    TessEvaluation,
}

pub struct PatchExecutor<'gl> {
    gl: &'gl glw::Functions,
    program: ShaderProgram<'gl>,
    io: BufferIo<'gl>,
    stage: PatchStage,
}

impl<'gl> PatchExecutor<'gl> {
    fn new(render_context: &'gl RenderContext, spec: &ShaderSpec, stage: PatchStage) -> Result<Self, TestError> {
        let gl = render_context.functions();
        check_tess_support(gl, spec, stage)?;
        let io = BufferIo::new(gl, spec)?;
        let sources = match stage {
            PatchStage::TessControl => ProgramSources::default()
                .with(ShaderType::Vertex, generate_vertex_shader_for_tess(spec.version))
                .with(ShaderType::TessControl, generate_tess_control_shader(spec))
                .with(
                    ShaderType::TessEvaluation,
                    generate_empty_tess_eval_shader(spec.version),
                )
                .with(ShaderType::Fragment, generate_empty_fragment_source(spec.version)),
            PatchStage::TessEvaluation => ProgramSources::default()
                .with(ShaderType::Vertex, generate_vertex_shader_for_tess(spec.version))
                .with(
                    ShaderType::TessControl,
                    generate_passthrough_tess_control_shader(spec.version),
                )
                .with(ShaderType::TessEvaluation, generate_tess_eval_shader(spec))
                .with(ShaderType::Fragment, generate_empty_fragment_source(spec.version)),
        };
        let program = ShaderProgram::new(gl, &sources);
        Ok(Self { gl, program, io, stage })
    }

    fn execute(&self, num_values: i32, inputs: &[&[u8]], outputs: &mut [&mut [u8]]) -> Result<(), TestError> {
        // `TessEvaluationExecutor` pairs values two at a time (isolines, 2 vertices per
        // patch) and pads the buffer to an even count; `TessControlExecutor` needs no
        // padding (one triangle patch, 3 vertices, per value).
        let (patch_vertices, num_patches, aligned_values) = match self.stage {
            PatchStage::TessControl => (3, num_values, num_values),
            PatchStage::TessEvaluation => {
                let aligned = num_values + (num_values & 1);
                (2, aligned / 2, aligned)
            }
        };

        self.io.init_buffers(aligned_values);
        self.io.upload_input_buffer(inputs, num_values)?;

        // SAFETY: both buffers were just sized by `init_buffers` above.
        unsafe {
            if self.io.has_inputs() {
                self.gl
                    .bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.io.input_buffer.get());
            }
            self.gl
                .bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.io.output_buffer.get());
        }

        let vao = VertexArray::new(self.gl);
        // SAFETY: a vertex array object this call owns; the draw that follows needs no
        // vertex attributes at all (every input/output goes through the SSBOs above).
        unsafe {
            self.gl.bind_vertex_array(vao.get());
            self.gl.patch_parameteri(glw::GL_PATCH_VERTICES, patch_vertices);
            self.gl.draw_arrays(glw::GL_PATCHES, 0, patch_vertices * num_patches);
            self.gl.bind_vertex_array(0);
        }
        glu::expect_no_error(self.gl, "Error in tessellation draw")?;

        self.io.read_output_buffer(outputs, num_values)
    }
}

// Utilities - `createExecutor`/`executorSupported`.

pub enum ShaderExecutor<'gl> {
    /// Backs Vertex, Fragment and Geometry - all three only differ in which shaders
    /// upstream builds the program from.
    FragmentOut(FragmentOutExecutor<'gl>),
    Compute(ComputeExecutor<'gl>),
    Patch(PatchExecutor<'gl>),
}

impl<'gl> ShaderExecutor<'gl> {
    pub fn is_ok(&self) -> bool {
        match self {
            Self::FragmentOut(e) => e.program.is_ok(),
            Self::Compute(e) => e.program.is_ok(),
            Self::Patch(e) => e.program.is_ok(),
        }
    }

    pub fn build_failure_summary(&self) -> Option<String> {
        match self {
            Self::FragmentOut(e) => e.program.build_failure_summary(),
            Self::Compute(e) => e.program.build_failure_summary(),
            Self::Patch(e) => e.program.build_failure_summary(),
        }
    }

    pub fn program(&self) -> GLuint {
        match self {
            Self::FragmentOut(e) => e.program.program(),
            Self::Compute(e) => e.program.program(),
            Self::Patch(e) => e.program.program(),
        }
    }

    pub fn use_program(&self, gl: &glw::Functions) {
        // SAFETY: `program()` is a program this executor owns, and linked when `is_ok`.
        unsafe { gl.use_program(self.program()) };
    }

    pub fn execute(&self, num_values: i32, inputs: &[&[u8]], outputs: &mut [&mut [u8]]) -> Result<(), TestError> {
        match self {
            Self::FragmentOut(e) => e.execute(num_values, inputs, outputs),
            Self::Compute(e) => e.execute(num_values, inputs, outputs),
            Self::Patch(e) => e.execute(num_values, inputs, outputs),
        }
    }
}

/// `ShaderExecUtil::createExecutor`
pub fn create_executor<'gl>(
    render_context: &'gl RenderContext,
    shader_type: ShaderType,
    spec: &ShaderSpec,
) -> Result<ShaderExecutor<'gl>, TestError> {
    match shader_type {
        ShaderType::Vertex => Ok(ShaderExecutor::FragmentOut(FragmentOutExecutor::new_vertex(
            render_context,
            spec,
        )?)),
        ShaderType::Fragment => Ok(ShaderExecutor::FragmentOut(FragmentOutExecutor::new_fragment(
            render_context,
            spec,
        )?)),
        ShaderType::Geometry => Ok(ShaderExecutor::FragmentOut(FragmentOutExecutor::new_geometry(
            render_context,
            spec,
        )?)),
        ShaderType::Compute => Ok(ShaderExecutor::Compute(ComputeExecutor::new(
            render_context.functions(),
            spec,
        )?)),
        ShaderType::TessControl => Ok(ShaderExecutor::Patch(PatchExecutor::new(
            render_context,
            spec,
            PatchStage::TessControl,
        )?)),
        ShaderType::TessEvaluation => Ok(ShaderExecutor::Patch(PatchExecutor::new(
            render_context,
            spec,
            PatchStage::TessEvaluation,
        )?)),
    }
}
