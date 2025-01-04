// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fLayoutBindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both halves of the file are ported. The `negative` cases compile and link a program and
// check that it fails; they draw nothing. The `render` cases draw one full-viewport quad
// whose fragment colour comes from the resource bound at a `layout(binding = N)` point, so
// their reference is a solid colour the host already knows - no rasteriser is involved.
//
// Upstream's four `*BindingNegativeCase` subclasses differ only in the set of
// `GL_MAX_*` limits they query, the uniform's base name, and the declaration/body strings
// they build, so here they are a `UniformKind` and one `generate_shaders_*` function each
// rather than four subclasses of one base - the shader builders keep their upstream shape
// one for one.
//
// Note when re-syncing: `LayoutBindingNegativeCase`'s *declaration* and *definition* list
// the five `max*UnitsEnum` parameters in different orders, and the definition is the one
// that binds. Positionally they are vertex, tess-control, tess-evaluation, fragment,
// combined; reading the declaration instead swaps fragment with the two tessellation
// stages. The struct below names its fields to make that impossible to get wrong.

use crate::glu::{
    self, Context, ProgramSources, ShaderProgram, ShaderType as GluShaderType, TestCase, TestCaseGroup,
    get_data_type_from_gl_type,
};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::{TextureLevel, clear};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, de_string_hash};

/// `TestType`. The negative cases only ever use `Single` and `Array`; the other three
/// reach the render cases alone.
///
/// clippy's `enum_variant_names` refuses upstream's shared `TESTTYPE_BINDING_` prefix, so
/// the variants drop it; `name()` below still spells each one the way upstream does.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Single,
    Max,
    Multiple,
    Array,
    MaxArray,
}

impl TestType {
    /// The upstream enumerator's own spelling, for a panic message.
    fn name(self) -> &'static str {
        match self {
            Self::Single => "TESTTYPE_BINDING_SINGLE",
            Self::Max => "TESTTYPE_BINDING_MAX",
            Self::Multiple => "TESTTYPE_BINDING_MULTIPLE",
            Self::Array => "TESTTYPE_BINDING_ARRAY",
            Self::MaxArray => "TESTTYPE_BINDING_MAX_ARRAY",
        }
    }

    /// Whether the uniform is declared as an array rather than as several instances.
    fn is_array_instance(self) -> bool {
        matches!(self, Self::Array | Self::MaxArray)
    }
}

/// `ShaderType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Vertex,
    Fragment,
    TessControl,
    TessEvaluation,
    All,
}

/// `LayoutBindingNegativeCase::ErrorType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ErrorType {
    OverMaxUnits,
    LessThanZero,
    Contradictory,
}

const MAX_UNIFORM_MULTIPLE_INSTANCES: i32 = 7;
const MAX_UNIFORM_ARRAY_SIZE: i32 = 7;

const SIMPLE_VERTEX_SHADER_SOURCE: &str = concat!(
    "#version 310 es\n",
    "in highp vec4 a_position;\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = a_position;\n",
    "}\n",
);

const SIMPLE_FRAGMENT_SHADER_SOURCE: &str = concat!(
    "#version 310 es\n",
    "in highp vec4 v_color;\n",
    "layout(location = 0) out highp vec4 fragColor;\n",
    "void main (void)\n",
    "{\n",
    "    fragColor = v_color;\n",
    "}\n",
);

const SIMPLE_TESS_CONTROL_SHADER_SOURCE: &str = concat!(
    "#version 310 es\n",
    "#extension GL_EXT_tessellation_shader : require\n",
    "layout (vertices=3) out;\n",
    "\n",
    "void main (void)\n",
    "{\n",
    "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n",
    "}\n",
);

const SIMPLE_TESS_EVALUATION_SHADER_SOURCE: &str = concat!(
    "#version 310 es\n",
    "#extension GL_EXT_tessellation_shader : require\n",
    "layout (triangles) in;\n",
    "\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = gl_TessCoord[0] * gl_in[0].gl_Position + gl_TessCoord[1] * gl_in[1].gl_Position + gl_TessCoord[2] * gl_in[2].gl_Position;\n",
    "}\n",
);

/// `generateVertexShader`
fn generate_vertex_shader(shader_type: ShaderType, shader_uniform_declarations: &str, shader_body: &str) -> String {
    match shader_type {
        ShaderType::Vertex | ShaderType::All => format!(
            concat!(
                "#version 310 es\n",
                "in highp vec4 a_position;\n",
                "out highp vec4 v_color;\n",
                "uniform highp int u_arrayNdx;\n\n",
                "{}\n",
                "void main (void)\n",
                "{{\n",
                "    highp vec4 color;\n\n",
                "{}\n",
                "    v_color = color;\n",
                "    gl_Position = a_position;\n",
                "}}\n",
            ),
            shader_uniform_declarations, shader_body
        ),
        ShaderType::Fragment | ShaderType::TessControl | ShaderType::TessEvaluation => {
            SIMPLE_VERTEX_SHADER_SOURCE.to_string()
        }
    }
}

/// `generateFragmentShader`
fn generate_fragment_shader(shader_type: ShaderType, shader_uniform_declarations: &str, shader_body: &str) -> String {
    match shader_type {
        ShaderType::Vertex | ShaderType::TessControl | ShaderType::TessEvaluation => {
            SIMPLE_FRAGMENT_SHADER_SOURCE.to_string()
        }
        ShaderType::Fragment => format!(
            concat!(
                "#version 310 es\n",
                "layout(location = 0) out highp vec4 fragColor;\n",
                "uniform highp int u_arrayNdx;\n\n",
                "{}\n",
                "void main (void)\n",
                "{{\n",
                "    highp vec4 color;\n\n",
                "{}\n",
                "    fragColor = color;\n",
                "}}\n",
            ),
            shader_uniform_declarations, shader_body
        ),
        ShaderType::All => format!(
            concat!(
                "#version 310 es\n",
                "in highp vec4 v_color;\n",
                "layout(location = 0) out highp vec4 fragColor;\n",
                "uniform highp int u_arrayNdx;\n\n",
                "{}\n",
                "void main (void)\n",
                "{{\n",
                "    if (v_color.x > 2.0) discard;\n",
                "    highp vec4 color;\n\n",
                "{}\n",
                "    fragColor = color;\n",
                "}}\n",
            ),
            shader_uniform_declarations, shader_body
        ),
    }
}

/// `generateTessControlShader`
fn generate_tess_control_shader(
    shader_type: ShaderType,
    shader_uniform_declarations: &str,
    shader_body: &str,
) -> String {
    match shader_type {
        ShaderType::Vertex | ShaderType::Fragment | ShaderType::TessEvaluation => {
            SIMPLE_TESS_CONTROL_SHADER_SOURCE.to_string()
        }
        ShaderType::TessControl | ShaderType::All => format!(
            concat!(
                "#version 310 es\n",
                "#extension GL_EXT_tessellation_shader : require\n",
                "layout (vertices=3) out;\n",
                "\n",
                "uniform highp int u_arrayNdx;\n\n",
                "{}\n",
                "void main (void)\n",
                "{{\n",
                "    highp vec4 color;\n\n",
                "{}\n",
                "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n",
                "}}\n",
            ),
            shader_uniform_declarations, shader_body
        ),
    }
}

/// `generateTessEvaluationShader`
fn generate_tess_evaluation_shader(
    shader_type: ShaderType,
    shader_uniform_declarations: &str,
    shader_body: &str,
) -> String {
    match shader_type {
        ShaderType::Vertex | ShaderType::Fragment | ShaderType::TessControl => {
            SIMPLE_TESS_EVALUATION_SHADER_SOURCE.to_string()
        }
        ShaderType::TessEvaluation | ShaderType::All => format!(
            concat!(
                "#version 310 es\n",
                "#extension GL_EXT_tessellation_shader : require\n",
                "layout (triangles) in;\n",
                "\n",
                "uniform highp int u_arrayNdx;\n\n",
                "{}\n",
                "out mediump vec4 v_color;\n",
                "void main (void)\n",
                "{{\n",
                "    highp vec4 color;\n\n",
                "{}\n",
                "    v_color = color;\n",
                "    gl_Position = gl_TessCoord[0] * gl_in[0].gl_Position + gl_TessCoord[1] * gl_in[1].gl_Position + gl_TessCoord[2] * gl_in[2].gl_Position;\n",
                "}}\n",
            ),
            shader_uniform_declarations, shader_body
        ),
    }
}

/// `getUniformName(name, declNdx)`
fn uniform_name(name: &str, decl_ndx: i32) -> String {
    format!("{name}{decl_ndx}")
}

/// `getUniformName(name, declNdx, arrNdx)`
fn uniform_name_indexed(name: &str, decl_ndx: i32, arr_ndx: i32) -> String {
    format!("{name}{decl_ndx}[{arr_ndx}]")
}

/// Which upstream `*BindingNegativeCase` subclass a case is.
#[derive(Clone, Copy, PartialEq, Eq)]
enum UniformKind {
    Sampler2D,
    Sampler3D,
    Image2D,
    Image3D,
    Ubo,
    Ssbo,
}

/// The limits and base name each subclass hands `LayoutBindingNegativeCase`'s constructor.
struct Limits {
    max_binding_point: GLenum,
    max_vertex_units: GLenum,
    max_tess_ctrl_units: GLenum,
    max_tess_eval_units: GLenum,
    max_fragment_units: GLenum,
    max_combined_units: GLenum,
    uniform_name: &'static str,
}

impl UniformKind {
    fn limits(self) -> Limits {
        match self {
            Self::Sampler2D | Self::Sampler3D => Limits {
                max_binding_point: glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
                max_vertex_units: glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
                max_tess_ctrl_units: glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS,
                max_tess_eval_units: glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS,
                max_fragment_units: glw::GL_MAX_TEXTURE_IMAGE_UNITS,
                max_combined_units: glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
                uniform_name: "u_sampler",
            },
            Self::Image2D | Self::Image3D => Limits {
                max_binding_point: glw::GL_MAX_IMAGE_UNITS,
                max_vertex_units: glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
                max_tess_ctrl_units: glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
                max_tess_eval_units: glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
                max_fragment_units: glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
                max_combined_units: glw::GL_MAX_COMBINED_IMAGE_UNIFORMS,
                uniform_name: "u_image",
            },
            Self::Ubo => Limits {
                max_binding_point: glw::GL_MAX_UNIFORM_BUFFER_BINDINGS,
                max_vertex_units: glw::GL_MAX_VERTEX_UNIFORM_BLOCKS,
                max_tess_ctrl_units: glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS,
                max_tess_eval_units: glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS,
                max_fragment_units: glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
                max_combined_units: glw::GL_MAX_COMBINED_UNIFORM_BLOCKS,
                uniform_name: "ColorBlock",
            },
            Self::Ssbo => Limits {
                max_binding_point: glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
                max_vertex_units: glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS,
                max_tess_ctrl_units: glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
                max_tess_eval_units: glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
                max_fragment_units: glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
                max_combined_units: glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS,
                uniform_name: "ColorBuffer",
            },
        }
    }
}

/// The per-stage binding points `initBindingPoints` produces.
struct Bindings {
    vertex: Vec<GLint>,
    fragment: Vec<GLint>,
    tess_ctrl: Vec<GLint>,
    tess_eval: Vec<GLint>,
}

/// `LayoutBindingNegativeCase`
struct LayoutBindingNegativeCase {
    name: String,
    kind: UniformKind,
    shader_type: ShaderType,
    test_type: TestType,
    error_type: ErrorType,
}

fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut v = 0;
    // SAFETY: every pname used here is single-valued.
    unsafe { gl.get_integerv(pname, &mut v) };
    v
}

impl LayoutBindingNegativeCase {
    /// `LayoutBindingNegativeCase::initBindingPoints`
    fn init_binding_points(
        &self,
        min_binding_point: GLint,
        num_binding_points: GLint,
        num_bindings: GLint,
    ) -> Bindings {
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x00ff_23a4);
        let mut b = Bindings {
            vertex: Vec::new(),
            fragment: Vec::new(),
            tess_ctrl: Vec::new(),
            tess_eval: Vec::new(),
        };

        match self.error_type {
            // Select a binding point that is 1 over the maximum
            ErrorType::OverMaxUnits => {
                let binding = num_binding_points + 1 - num_bindings;
                b.vertex.push(binding);
                b.fragment.push(binding);
                b.tess_ctrl.push(binding);
                b.tess_eval.push(binding);
            }
            // Select a random negative binding point
            ErrorType::LessThanZero => {
                let binding = -rnd.get_int(1, num_bindings);
                b.vertex.push(binding);
                b.fragment.push(binding);
                b.tess_ctrl.push(binding);
                b.tess_eval.push(binding);
            }
            // Select two valid, but contradictory binding points
            ErrorType::Contradictory => {
                b.vertex.push(min_binding_point);
                b.fragment.push((min_binding_point + 1) % num_binding_points);
                b.tess_ctrl.push((min_binding_point + 2) % num_binding_points);
                b.tess_eval.push((min_binding_point + 3) % num_binding_points);
            }
        }

        // In case we are testing with multiple uniforms populate the rest of the binding
        // points. Upstream derives the tess-evaluation entries from the tess-*control*
        // front element, not from its own; reproduced verbatim, since it decides which
        // pairs of stages contradict each other in the array cases.
        for ndx in 1..num_bindings {
            b.vertex.push(b.vertex[0] + ndx);
            b.fragment.push(b.fragment[0] + ndx);
            b.tess_ctrl.push(b.tess_ctrl[0] + ndx);
            b.tess_eval.push(b.tess_ctrl[0] + ndx);
        }

        b
    }

    /// `SamplerBindingNegativeCase::generateShaders`
    fn generate_shaders_sampler(
        &self,
        b: &Bindings,
        num_bindings: GLint,
        tess_support: bool,
        gl_type: GLenum,
    ) -> ProgramSources {
        let tex_coord_type = if gl_type == glw::GL_SAMPLER_2D { "vec2" } else { "vec3" };
        let sampler_type = get_data_type_from_gl_type(gl_type).name();
        let array_instance = self.test_type == TestType::Array;
        let num_declarations = if array_instance { 1 } else { num_bindings };
        let name = self.kind.limits().uniform_name;

        let mut decls = [String::new(), String::new(), String::new(), String::new()];
        let mut shader_body = String::new();

        // Generate the uniform declarations for the vertex and fragment shaders
        for decl_ndx in 0..num_declarations {
            let decl_name = if array_instance {
                uniform_name_indexed(name, decl_ndx, num_bindings)
            } else {
                uniform_name(name, decl_ndx)
            };

            for (dst, binding) in decls
                .iter_mut()
                .zip([&b.vertex, &b.fragment, &b.tess_ctrl, &b.tess_eval])
            {
                dst.push_str(&format!(
                    "layout(binding = {}) uniform highp {sampler_type} {decl_name};\n",
                    binding[decl_ndx as usize]
                ));
            }
        }

        // Generate the shader body for the vertex and fragment shaders
        for bind_ndx in 0..num_bindings {
            let use_name = if array_instance {
                uniform_name_indexed(name, 0, bind_ndx)
            } else {
                uniform_name(name, bind_ndx)
            };
            shader_body.push_str(&format!(
                "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = texture({use_name}, {tex_coord_type}(0.5));\n    }}\n",
                if bind_ndx == 0 { "if" } else { "else if" }
            ));
        }

        shader_body.push_str("    else\n    {\n        color = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n");

        assemble_sources(self.shader_type, &decls, &shader_body, tess_support)
    }

    /// `ImageBindingNegativeCase::generateShaders`
    fn generate_shaders_image(
        &self,
        b: &Bindings,
        num_bindings: GLint,
        tess_support: bool,
        gl_type: GLenum,
    ) -> ProgramSources {
        let tex_coord_type = if gl_type == glw::GL_IMAGE_2D { "ivec2" } else { "ivec3" };
        let image_type = get_data_type_from_gl_type(gl_type).name();
        let array_instance = self.test_type == TestType::Array;
        let num_declarations = if array_instance { 1 } else { num_bindings };
        let name = self.kind.limits().uniform_name;

        let mut decls = [String::new(), String::new(), String::new(), String::new()];
        let mut shader_body = String::new();

        // Generate the uniform declarations for the vertex and fragment shaders
        for decl_ndx in 0..num_declarations {
            let decl_name = if array_instance {
                uniform_name_indexed(name, decl_ndx, num_bindings)
            } else {
                uniform_name(name, decl_ndx)
            };

            for (dst, binding) in decls
                .iter_mut()
                .zip([&b.vertex, &b.fragment, &b.tess_ctrl, &b.tess_eval])
            {
                dst.push_str(&format!(
                    "layout(rgba8, binding = {}) uniform readonly highp {image_type} {decl_name};\n",
                    binding[decl_ndx as usize]
                ));
            }
        }

        // Generate the shader body for the vertex and fragment shaders
        for bind_ndx in 0..num_bindings {
            let use_name = if array_instance {
                uniform_name_indexed(name, 0, bind_ndx)
            } else {
                uniform_name(name, bind_ndx)
            };
            shader_body.push_str(&format!(
                "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = imageLoad({use_name}, {tex_coord_type}(0));\n    }}\n",
                if bind_ndx == 0 { "if" } else { "else if" }
            ));
        }

        shader_body.push_str("    else\n    {\n        color = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n");

        assemble_sources(self.shader_type, &decls, &shader_body, tess_support)
    }

    /// `UBOBindingNegativeCase::generateShaders` and `SSBOBindingNegativeCase::generateShaders`
    ///
    /// The two differ in one keyword (`uniform` / `buffer`) and in which stage's binding
    /// the tessellation-evaluation declaration reads: UBO's uses the tess-*control* one,
    /// SSBO's its own. Both are reproduced verbatim.
    fn generate_shaders_block(&self, b: &Bindings, num_bindings: GLint, tess_support: bool) -> ProgramSources {
        let is_ssbo = self.kind == UniformKind::Ssbo;
        let keyword = if is_ssbo { "buffer" } else { "uniform" };
        let array_instance = self.test_type == TestType::Array;
        let num_declarations = if array_instance { 1 } else { num_bindings };
        let name = self.kind.limits().uniform_name;

        let mut decls = [String::new(), String::new(), String::new(), String::new()];
        let mut shader_body = String::new();

        let tess_eval_binding = if is_ssbo { &b.tess_eval } else { &b.tess_ctrl };

        // Generate the uniform declarations for the vertex and fragment shaders
        for decl_ndx in 0..num_declarations {
            let block_name = uniform_name(name, decl_ndx);
            let instance_name = if array_instance {
                uniform_name_indexed("colors", decl_ndx, num_bindings)
            } else {
                uniform_name("colors", decl_ndx)
            };

            for (dst, binding) in decls
                .iter_mut()
                .zip([&b.vertex, &b.fragment, &b.tess_ctrl, tess_eval_binding])
            {
                dst.push_str(&format!(
                    "layout(std140, binding = {}) {keyword} {block_name}\n{{\n    highp vec4 color1;\n    highp vec4 color2;\n}} {instance_name};\n",
                    binding[decl_ndx as usize]
                ));
            }
        }

        // Generate the shader body for the vertex and fragment shaders. Multiply by two
        // to cover cases for both colors for each UBO.
        for bind_ndx in 0..num_bindings * 2 {
            let uname = if array_instance {
                uniform_name_indexed("colors", 0, bind_ndx / 2)
            } else {
                uniform_name("colors", bind_ndx / 2)
            };
            shader_body.push_str(&format!(
                "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = {uname}{};\n    }}\n",
                if bind_ndx == 0 { "if" } else { "else if" },
                if bind_ndx % 2 == 0 { ".color1" } else { ".color2" }
            ));
        }

        shader_body.push_str("    else\n    {\n        color = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n");

        assemble_sources(self.shader_type, &decls, &shader_body, tess_support)
    }
}

/// The tail every `generateShaders` shares: run the four per-stage generators over the
/// stage's own declarations and the one shared body.
fn assemble_sources(
    shader_type: ShaderType,
    decls: &[String; 4],
    shader_body: &str,
    tess_support: bool,
) -> ProgramSources {
    let mut sources = ProgramSources::vtx_frag(
        generate_vertex_shader(shader_type, &decls[0], shader_body),
        generate_fragment_shader(shader_type, &decls[1], shader_body),
    );

    if tess_support {
        sources = sources
            .with(
                GluShaderType::TessControl,
                generate_tess_control_shader(shader_type, &decls[2], shader_body),
            )
            .with(
                GluShaderType::TessEvaluation,
                generate_tess_evaluation_shader(shader_type, &decls[3], shader_body),
            );
    }

    sources
}

impl TestCase for LayoutBindingNegativeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let limits = self.kind.limits();

        // `LayoutBindingNegativeCase::init` - decide appropriate binding points for the
        // vertex and fragment shaders.
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x00ff_23a4);
        let tess_support = context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
            || context.context_type().supports(3, 2);

        if !tess_support && matches!(self.shader_type, ShaderType::TessEvaluation | ShaderType::TessControl) {
            return Err(TestError::NotSupported("Tesselation shaders not supported".to_string()));
        }

        let num_shader_stages = if tess_support { 4 } else { 2 };

        let max_vertex_units = get_integer(gl, limits.max_vertex_units);
        let max_fragment_units = get_integer(gl, limits.max_fragment_units);
        let (max_tess_ctrl_units, max_tess_eval_units) = if tess_support {
            (
                get_integer(gl, limits.max_tess_ctrl_units),
                get_integer(gl, limits.max_tess_eval_units),
            )
        } else {
            (0, 0)
        };
        let max_combined_units = get_integer(gl, limits.max_combined_units);
        let num_binding_points = get_integer(gl, limits.max_binding_point);
        glu::expect_no_error(gl, "Querying available uniform numbers failed")?;

        log::debug!("Maximum units for uniform type in the vertex shader: {max_vertex_units}");
        log::debug!("Maximum units for uniform type in the fragment shader: {max_fragment_units}");
        if tess_support {
            log::debug!("Maximum units for uniform type in the tessellation control shader: {max_tess_ctrl_units}");
            log::debug!("Maximum units for uniform type in the tessellation evaluation shader: {max_tess_ctrl_units}");
        }
        log::debug!("Maximum combined units for uniform type: {max_combined_units}");
        log::debug!("Maximum binding point for uniform type: {}", num_binding_points - 1);

        // Select maximum number of uniforms used for the test
        let max_units = match self.shader_type {
            ShaderType::Vertex => max_vertex_units,
            ShaderType::Fragment => max_fragment_units,
            ShaderType::All => max_vertex_units
                .min(max_fragment_units)
                .min(max_tess_ctrl_units.min(max_tess_eval_units))
                .min(max_combined_units / num_shader_stages),
            ShaderType::TessControl => max_tess_ctrl_units,
            ShaderType::TessEvaluation => max_tess_eval_units,
        };

        // Select the number of uniforms (= bindings) used for this test
        let num_bindings = match self.test_type {
            TestType::Single => 1,
            TestType::Array => {
                if self.error_type == ErrorType::Contradictory {
                    // leave room for contradictory case
                    if max_units < 3 {
                        return Err(TestError::NotSupported(
                            "Not enough uniforms available for test".to_string(),
                        ));
                    }
                    rnd.get_int(2, MAX_UNIFORM_ARRAY_SIZE.min(max_units - 1))
                } else {
                    if max_units < 2 {
                        return Err(TestError::NotSupported(
                            "Not enough uniforms available for test".to_string(),
                        ));
                    }
                    rnd.get_int(2, MAX_UNIFORM_ARRAY_SIZE.min(max_units))
                }
            }
            // The negative half never uses the other three test types.
            other => unreachable!("{} never reaches a negative case", other.name()),
        };

        // Check that we have enough uniforms in different shaders to perform the tests
        if matches!(self.shader_type, ShaderType::Vertex | ShaderType::All) && max_vertex_units < num_bindings {
            return Err(TestError::NotSupported(
                "Vertex shader: not enough uniforms available for test".to_string(),
            ));
        }

        if matches!(self.shader_type, ShaderType::Fragment | ShaderType::All) && max_fragment_units < num_bindings {
            return Err(TestError::NotSupported(
                "Fragment shader: not enough uniforms available for test".to_string(),
            ));
        }

        if tess_support
            && matches!(self.shader_type, ShaderType::TessControl | ShaderType::All)
            && max_tess_ctrl_units < num_bindings
        {
            return Err(TestError::NotSupported(
                "Tessellation control shader: not enough uniforms available for test".to_string(),
            ));
        }

        if tess_support
            && matches!(self.shader_type, ShaderType::TessEvaluation | ShaderType::All)
            && max_tess_eval_units < num_bindings
        {
            return Err(TestError::NotSupported(
                "Tessellation evaluation shader: not enough uniforms available for test".to_string(),
            ));
        }

        if self.shader_type == ShaderType::All && max_combined_units < num_bindings * num_shader_stages {
            return Err(TestError::NotSupported(
                "Not enough uniforms available for test".to_string(),
            ));
        }

        // Check that we have enough binding points to perform the tests
        if num_binding_points < num_bindings {
            return Err(TestError::NotSupported(
                "Not enough binding points available for test".to_string(),
            ));
        }

        if self.error_type == ErrorType::Contradictory && num_binding_points == num_bindings {
            return Err(TestError::NotSupported(
                "Not enough binding points available for test".to_string(),
            ));
        }

        // Initialize the binding points i.e. populate the two binding point vectors
        let bindings = self.init_binding_points(0, num_binding_points, num_bindings);

        // Generate the shader program - note: this must be done after deciding the binding points
        log::debug!("Creating test shaders");
        let sources = match self.kind {
            UniformKind::Sampler2D => {
                self.generate_shaders_sampler(&bindings, num_bindings, tess_support, glw::GL_SAMPLER_2D)
            }
            UniformKind::Sampler3D => {
                self.generate_shaders_sampler(&bindings, num_bindings, tess_support, glw::GL_SAMPLER_3D)
            }
            UniformKind::Image2D => {
                self.generate_shaders_image(&bindings, num_bindings, tess_support, glw::GL_IMAGE_2D)
            }
            UniformKind::Image3D => {
                self.generate_shaders_image(&bindings, num_bindings, tess_support, glw::GL_IMAGE_3D)
            }
            UniformKind::Ubo | UniformKind::Ssbo => self.generate_shaders_block(&bindings, num_bindings, tess_support),
        };
        let program = ShaderProgram::new_expecting_build_failure(gl, &sources);

        // `LayoutBindingNegativeCase::iterate`
        let compiled =
            |shader_type: GluShaderType| program.shader_info.iter().any(|(t, info)| *t == shader_type && info.ok);

        let (pass, fail_message) = match self.error_type {
            // Contradictory binding points should cause a link-time error
            ErrorType::Contradictory => (!program.program_info.ok, "Test failed - expected a link-time error"),
            // Out of bounds binding points should cause a compile-time error
            ErrorType::LessThanZero | ErrorType::OverMaxUnits => {
                let pass = if tess_support {
                    !compiled(GluShaderType::Vertex)
                        || !compiled(GluShaderType::Fragment)
                        || !compiled(GluShaderType::TessControl)
                        || !compiled(GluShaderType::TessEvaluation)
                } else {
                    !compiled(GluShaderType::Vertex) || !compiled(GluShaderType::Fragment)
                };
                (pass, "Test failed - expected a compile-time error")
            }
        };

        Ok(if pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail(fail_message)
        })
    }
}

/// `s_negativeTestTypes`
const NEGATIVE_TEST_TYPES: [(ShaderType, TestType, ErrorType, &str); 18] = [
    (
        ShaderType::Vertex,
        TestType::Single,
        ErrorType::OverMaxUnits,
        "vertex_binding_over_max",
    ),
    (
        ShaderType::Fragment,
        TestType::Single,
        ErrorType::OverMaxUnits,
        "fragment_binding_over_max",
    ),
    (
        ShaderType::TessControl,
        TestType::Single,
        ErrorType::OverMaxUnits,
        "tess_control_binding_over_max",
    ),
    (
        ShaderType::TessEvaluation,
        TestType::Single,
        ErrorType::OverMaxUnits,
        "tess_evaluation_binding_over_max",
    ),
    (
        ShaderType::Vertex,
        TestType::Single,
        ErrorType::LessThanZero,
        "vertex_binding_neg",
    ),
    (
        ShaderType::Fragment,
        TestType::Single,
        ErrorType::LessThanZero,
        "fragment_binding_neg",
    ),
    (
        ShaderType::TessControl,
        TestType::Single,
        ErrorType::LessThanZero,
        "tess_control_binding_neg",
    ),
    (
        ShaderType::TessEvaluation,
        TestType::Single,
        ErrorType::LessThanZero,
        "tess_evaluation_binding_neg",
    ),
    (
        ShaderType::Vertex,
        TestType::Array,
        ErrorType::OverMaxUnits,
        "vertex_binding_over_max_array",
    ),
    (
        ShaderType::Fragment,
        TestType::Array,
        ErrorType::OverMaxUnits,
        "fragment_binding_over_max_array",
    ),
    (
        ShaderType::TessControl,
        TestType::Array,
        ErrorType::OverMaxUnits,
        "tess_control_binding_over_max_array",
    ),
    (
        ShaderType::TessEvaluation,
        TestType::Array,
        ErrorType::OverMaxUnits,
        "tess_evaluation_binding_over_max_array",
    ),
    (
        ShaderType::Vertex,
        TestType::Array,
        ErrorType::LessThanZero,
        "vertex_binding_neg_array",
    ),
    (
        ShaderType::Fragment,
        TestType::Array,
        ErrorType::LessThanZero,
        "fragment_binding_neg_array",
    ),
    (
        ShaderType::TessControl,
        TestType::Array,
        ErrorType::LessThanZero,
        "tess_control_binding_neg_array",
    ),
    (
        ShaderType::TessEvaluation,
        TestType::Array,
        ErrorType::LessThanZero,
        "tess_evaluation_binding_neg_array",
    ),
    (
        ShaderType::All,
        TestType::Single,
        ErrorType::Contradictory,
        "binding_contradictory",
    ),
    (
        ShaderType::All,
        TestType::Array,
        ErrorType::Contradictory,
        "binding_contradictory_array",
    ),
];

fn negative_group(name: &str, kind: UniformKind) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    for (shader_type, test_type, error_type, case_name) in NEGATIVE_TEST_TYPES {
        group.add_child(Box::new(LayoutBindingNegativeCase {
            name: case_name.to_string(),
            kind,
            shader_type,
            test_type,
            error_type,
        }) as Box<dyn TestCase>);
    }

    group
}

// ---------------------------------------------------------------------------------------
// The `render` half: `LayoutBindingRenderCase` and its four subclasses.
// ---------------------------------------------------------------------------------------

/// `LayoutBindingRenderCase::MAX_TEST_RENDER_WIDTH` / `_HEIGHT` / `TEST_TEXTURE_SIZE`
const MAX_TEST_RENDER_WIDTH: i32 = 256;
const MAX_TEST_RENDER_HEIGHT: i32 = 256;
const TEST_TEXTURE_SIZE: i32 = 1;

/// `getRandomColor`
fn get_random_color(rnd: &mut Random) -> [f32; 4] {
    let r = rnd.get_float_range(0.2, 0.9);
    let g = rnd.get_float_range(0.2, 0.9);
    let b = rnd.get_float_range(0.2, 0.9);
    [r, g, b, 1.0]
}

/// `LayoutBindingRenderCase`
struct LayoutBindingRenderCase {
    name: String,
    kind: UniformKind,
    shader_type: ShaderType,
    test_type: TestType,
}

impl LayoutBindingRenderCase {
    /// `LayoutBindingRenderCase::initBindingPoints`
    fn init_binding_points(
        &self,
        min_binding_point: GLint,
        num_binding_points: GLint,
        num_bindings: GLint,
    ) -> Vec<GLint> {
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x00ff_23a4);
        let mut bindings = Vec::new();

        match self.test_type {
            TestType::Single => bindings.push(rnd.get_int(min_binding_point, num_binding_points - 1)),
            TestType::Max => bindings.push(num_binding_points - 1),
            TestType::Multiple => {
                // Choose multiple unique binding points from the low and high end of the
                // available binding points.
                let mut low: Vec<GLint> = (0..num_binding_points / 2).collect();
                let mut high: Vec<GLint> = (num_binding_points / 2..num_binding_points).collect();

                rnd.shuffle(&mut low);
                rnd.shuffle(&mut high);

                for ndx in 0..num_bindings {
                    let from = if ndx % 2 == 0 { &mut low } else { &mut high };
                    bindings.push(from.pop().expect("enough binding points, checked by the caller"));
                }
            }
            TestType::Array => {
                let binding = rnd.get_int(min_binding_point, num_binding_points - num_bindings);
                bindings.extend(binding..binding + num_bindings);
            }
            TestType::MaxArray => {
                let binding = num_binding_points - num_bindings;
                bindings.extend(binding..binding + num_bindings);
            }
        }

        bindings
    }

    /// The uniform declarations and body `generateShaders` builds, per subclass.
    fn generate_shader_strings(&self, bindings: &[GLint], num_bindings: i32) -> (String, String) {
        let uniform_name_base = self.kind.limits().uniform_name;
        let array_instance = self.test_type.is_array_instance();
        let num_declarations = if array_instance { 1 } else { num_bindings };
        let mut decl = String::new();
        let mut body = String::new();

        match self.kind {
            UniformKind::Sampler2D | UniformKind::Sampler3D => {
                let (sampler_gl_type, tex_coord_type) = if self.kind == UniformKind::Sampler2D {
                    (glw::GL_SAMPLER_2D, "vec2")
                } else {
                    (glw::GL_SAMPLER_3D, "vec3")
                };
                let sampler_type = get_data_type_from_gl_type(sampler_gl_type).name();

                for decl_ndx in 0..num_declarations {
                    let name = if array_instance {
                        uniform_name_indexed(uniform_name_base, decl_ndx, num_bindings)
                    } else {
                        uniform_name(uniform_name_base, decl_ndx)
                    };
                    decl.push_str(&format!(
                        "layout(binding = {}) uniform highp {sampler_type} {name};\n",
                        bindings[decl_ndx as usize]
                    ));
                }

                for bind_ndx in 0..num_bindings {
                    let name = if array_instance {
                        uniform_name_indexed(uniform_name_base, 0, bind_ndx)
                    } else {
                        uniform_name(uniform_name_base, bind_ndx)
                    };
                    body.push_str(&format!(
                        "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = texture({name}, {tex_coord_type}(0.5));\n    }}\n",
                        if bind_ndx == 0 { "if" } else { "else if" }
                    ));
                }
            }
            UniformKind::Image2D | UniformKind::Image3D => {
                let (image_gl_type, tex_coord_type) = if self.kind == UniformKind::Image2D {
                    (glw::GL_IMAGE_2D, "ivec2")
                } else {
                    (glw::GL_IMAGE_3D, "ivec3")
                };
                let image_type = get_data_type_from_gl_type(image_gl_type).name();

                for decl_ndx in 0..num_declarations {
                    let name = if array_instance {
                        uniform_name_indexed(uniform_name_base, decl_ndx, num_bindings)
                    } else {
                        uniform_name(uniform_name_base, decl_ndx)
                    };
                    decl.push_str(&format!(
                        "layout(rgba8, binding = {}) uniform readonly highp {image_type} {name};\n",
                        bindings[decl_ndx as usize]
                    ));
                }

                for bind_ndx in 0..num_bindings {
                    let name = if array_instance {
                        uniform_name_indexed(uniform_name_base, 0, bind_ndx)
                    } else {
                        uniform_name(uniform_name_base, bind_ndx)
                    };
                    body.push_str(&format!(
                        "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = imageLoad({name}, {tex_coord_type}(0));\n    }}\n",
                        if bind_ndx == 0 { "if" } else { "else if" }
                    ));
                }
            }
            UniformKind::Ubo | UniformKind::Ssbo => {
                let block_keyword = if self.kind == UniformKind::Ubo {
                    "uniform"
                } else {
                    "buffer"
                };

                for decl_ndx in 0..num_declarations {
                    let instance = if array_instance {
                        uniform_name_indexed("colors", decl_ndx, num_bindings)
                    } else {
                        uniform_name("colors", decl_ndx)
                    };
                    decl.push_str(&format!(
                        "layout(std140, binding = {}) {block_keyword} {}\n{{\n    highp vec4 color1;\n    highp vec4 color2;\n}} {instance};\n",
                        bindings[decl_ndx as usize],
                        uniform_name(uniform_name_base, decl_ndx)
                    ));
                }

                // Twice, to cover both colours of each block.
                for bind_ndx in 0..num_bindings * 2 {
                    let uname = if array_instance {
                        uniform_name_indexed("colors", 0, bind_ndx / 2)
                    } else {
                        uniform_name("colors", bind_ndx / 2)
                    };
                    let member = if bind_ndx % 2 == 0 { ".color1" } else { ".color2" };
                    body.push_str(&format!(
                        "    {} (u_arrayNdx == {bind_ndx})\n    {{\n        color = {uname}{member};\n    }}\n",
                        if bind_ndx == 0 { "if" } else { "else if" }
                    ));
                }
            }
        }

        body.push_str("    else\n    {\n        color = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n");
        (decl, body)
    }
}

/// `LayoutBindingRenderCase::drawAndVerifyResult`
///
/// # Safety
/// A current context with the case's program in use and its buffers bound.
unsafe fn draw_and_verify_result(
    context: &Context,
    expected_color: [f32; 4],
    width: i32,
    height: i32,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut reference = Surface::new(width, height);

    // The point of these tests is to check layout_binding, so the thresholds can be
    // generous.
    let surface_threshold = context.render_target().pixel_format().get_color_threshold();
    let compare_threshold = RGBA::new(
        (2 * surface_threshold.get_red()).clamp(0, 255),
        (2 * surface_threshold.get_green()).clamp(0, 255),
        (2 * surface_threshold.get_blue()).clamp(0, 255),
        (2 * surface_threshold.get_alpha()).clamp(0, 255),
    );

    // SAFETY: the caller set the program and the element buffer up.
    unsafe {
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());
    }
    glu::expect_no_error(gl, "Drawing failed")?;

    let mut result = Surface::new(width, height);
    glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

    clear(&mut reference.get_access(), expected_color);
    log::debug!("Verifying output image, fragment output color is {expected_color:?}");

    Ok(pixel_threshold_compare(&reference, &result, compare_threshold).ok)
}

impl TestCase for LayoutBindingRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let limits = self.kind.limits();
        let uniform_name_base = limits.uniform_name;
        let array_instance = self.test_type.is_array_instance();

        // `LayoutBindingRenderCase::init`
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x00ff_23a4);
        let max_vertex_units = get_integer(gl, limits.max_vertex_units);
        let max_fragment_units = get_integer(gl, limits.max_fragment_units);
        let max_combined_units = get_integer(gl, limits.max_combined_units);
        let num_binding_points = get_integer(gl, limits.max_binding_point);
        glu::expect_no_error(gl, "Querying available uniform numbers failed")?;

        log::debug!("Maximum units for uniform type in the vertex shader: {max_vertex_units}");
        log::debug!("Maximum units for uniform type in the fragment shader: {max_fragment_units}");
        log::debug!("Maximum combined units for uniform type: {max_combined_units}");
        log::debug!("Maximum binding point for uniform type: {}", num_binding_points - 1);

        let max_units = match self.shader_type {
            ShaderType::Vertex => max_vertex_units,
            ShaderType::Fragment => max_fragment_units,
            ShaderType::All => max_combined_units / 2,
            other => unreachable!("{:?} never reaches a render case", other as i32),
        };

        let num_bindings = match self.test_type {
            TestType::Single | TestType::Max => 1,
            TestType::Multiple => {
                if max_units < 2 {
                    return Err(TestError::NotSupported(
                        "Not enough uniforms available for test".to_string(),
                    ));
                }
                rnd.get_int(2, MAX_UNIFORM_MULTIPLE_INSTANCES.min(max_units))
            }
            TestType::Array | TestType::MaxArray => {
                if max_units < 2 {
                    return Err(TestError::NotSupported(
                        "Not enough uniforms available for test".to_string(),
                    ));
                }
                rnd.get_int(2, MAX_UNIFORM_ARRAY_SIZE.min(max_units))
            }
        };

        // Check that there are enough uniforms in the different shaders, and enough
        // binding points, to perform the test.
        if matches!(self.shader_type, ShaderType::Vertex | ShaderType::All) && max_vertex_units < num_bindings {
            return Err(TestError::NotSupported(
                "Vertex shader: not enough uniforms available for test".to_string(),
            ));
        }
        if matches!(self.shader_type, ShaderType::Fragment | ShaderType::All) && max_fragment_units < num_bindings {
            return Err(TestError::NotSupported(
                "Fragment shader: not enough uniforms available for test".to_string(),
            ));
        }
        if self.shader_type == ShaderType::All && max_combined_units < num_bindings * 2 {
            return Err(TestError::NotSupported(
                "Not enough uniforms available for test".to_string(),
            ));
        }
        if num_binding_points < num_bindings {
            return Err(TestError::NotSupported(
                "Not enough binding points available for test".to_string(),
            ));
        }

        let bindings = self.init_binding_points(0, num_binding_points, num_bindings);

        // Generate the shader program - note: this must be done after deciding the
        // binding points.
        log::debug!("Creating test shaders");
        let (decl, body) = self.generate_shader_strings(&bindings, num_bindings);
        let sources = ProgramSources::vtx_frag(
            generate_vertex_shader(self.shader_type, &decl, &body),
            generate_fragment_shader(self.shader_type, &decl, &body),
        );
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail(
                program
                    .build_failure_summary()
                    .unwrap_or_else(|| "Shader compile failed".to_string()),
            ));
        }

        let render_width = MAX_TEST_RENDER_WIDTH.min(context.render_target().width);
        let render_height = MAX_TEST_RENDER_HEIGHT.min(context.render_target().height);

        // Setup vertex and index buffers so that we render one quad covering the whole
        // viewport.
        const VERTICES: [f32; 12] = [-1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
        const INDICES: [u16; 6] = [0, 1, 2, 0, 2, 3];

        let index_buffer = glu::Buffer::new(gl);
        let vertex_buffer = glu::Buffer::new(gl);
        let pos_loc;
        let array_ndx_loc;

        // SAFETY: a linked program and this case's own buffers.
        unsafe {
            pos_loc = gl.get_attrib_location(program.program(), c"a_position".as_ptr());
            array_ndx_loc = gl.get_uniform_location(program.program(), c"u_arrayNdx".as_ptr());
            if pos_loc < 0 || array_ndx_loc < 0 {
                return Err(TestError::Fail(
                    "a_position or u_arrayNdx is not an active variable".to_string(),
                ));
            }

            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get());
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&INDICES) as isize,
                INDICES.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "Index buffer setup failed")?;

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTICES) as isize,
                VERTICES.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            gl.enable_vertex_attrib_array(pos_loc as u32);
            gl.vertex_attrib_pointer(pos_loc as u32, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            glu::expect_no_error(gl, "Vertex buffer setup failed")?;
        }

        // Per-subclass resource setup, and the colour each iteration expects.
        let mut textures: Vec<glu::Texture<'_>> = Vec::new();
        let mut buffers: Vec<glu::Buffer<'_>> = Vec::new();
        let mut colors: Vec<[f32; 4]> = Vec::new();
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x00ff_23a4);

        match self.kind {
            UniformKind::Sampler2D | UniformKind::Sampler3D => {
                let texture_type = if self.kind == UniformKind::Sampler2D {
                    glw::GL_TEXTURE_2D
                } else {
                    glw::GL_TEXTURE_3D
                };

                for _ in 0..num_bindings {
                    colors.push(get_random_color(&mut rnd));
                    textures.push(glu::Texture::new(gl));
                }

                for tex_ndx in 0..num_bindings as usize {
                    // SAFETY: names this function just created.
                    unsafe {
                        initialize_texture(
                            gl,
                            texture_type,
                            bindings[tex_ndx],
                            textures[tex_ndx].get(),
                            colors[tex_ndx],
                        )?;
                    }
                }

                // SAFETY: a plain state change.
                unsafe { gl.active_texture(glw::GL_TEXTURE0) };
            }
            UniformKind::Image2D | UniformKind::Image3D => {
                let texture_type = if self.kind == UniformKind::Image2D {
                    glw::GL_TEXTURE_2D
                } else {
                    glw::GL_TEXTURE_3D
                };

                for _ in 0..num_bindings {
                    colors.push(get_random_color(&mut rnd));
                    textures.push(glu::Texture::new(gl));
                }

                for tex_ndx in 0..num_bindings as usize {
                    // SAFETY: names this function just created.
                    unsafe {
                        initialize_image(
                            gl,
                            texture_type,
                            bindings[tex_ndx],
                            tex_ndx as GLint,
                            textures[tex_ndx].get(),
                            colors[tex_ndx],
                        )?;
                    }
                }
            }
            UniformKind::Ubo | UniformKind::Ssbo => {
                let target = if self.kind == UniformKind::Ubo {
                    glw::GL_UNIFORM_BUFFER
                } else {
                    glw::GL_SHADER_STORAGE_BUFFER
                };

                for _ in 0..num_bindings {
                    buffers.push(glu::Buffer::new(gl));
                    colors.push(get_random_color(&mut rnd));
                    colors.push(get_random_color(&mut rnd));
                }

                for buf_ndx in 0..num_bindings as usize {
                    let pair = [colors[2 * buf_ndx], colors[2 * buf_ndx + 1]];
                    // SAFETY: the buffer is this case's own and the upload is two vec4s.
                    unsafe {
                        gl.bind_buffer(target, buffers[buf_ndx].get());
                        gl.buffer_data(
                            target,
                            std::mem::size_of_val(&pair) as isize,
                            pair.as_ptr().cast(),
                            glw::GL_STATIC_DRAW,
                        );
                        gl.bind_buffer_base(target, bindings[buf_ndx] as u32, buffers[buf_ndx].get());
                    }
                }
                glu::expect_no_error(gl, "Buffer setup failed")?;
            }
        }

        // `initRenderState`
        // SAFETY: a linked program on a current context.
        unsafe {
            gl.use_program(program.program());
            gl.viewport(0, 0, render_width, render_height);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
        }
        glu::expect_no_error(gl, "Failed to set render state")?;

        let mut query_test_passed = true;
        let mut image_test_passed = true;

        for iter_ndx in 0..num_bindings {
            let name = if array_instance {
                uniform_name_indexed(uniform_name_base, 0, iter_ndx)
            } else {
                uniform_name(uniform_name_base, iter_ndx)
            };
            let binding = bindings[iter_ndx as usize];
            let c_name = std::ffi::CString::new(name.clone()).expect("a uniform name with no interior nul");
            let mut val: GLint = -1;

            match self.kind {
                UniformKind::Ubo | UniformKind::Ssbo => {
                    let interface = if self.kind == UniformKind::Ubo {
                        glw::GL_UNIFORM_BLOCK
                    } else {
                        glw::GL_SHADER_STORAGE_BLOCK
                    };
                    let prop = glw::GL_BUFFER_BINDING;
                    // SAFETY: one property is asked for and one GLint of output is given.
                    unsafe {
                        let index = gl.get_program_resource_index(program.program(), interface, c_name.as_ptr());
                        gl.get_program_resourceiv(
                            program.program(),
                            interface,
                            index,
                            1,
                            &prop,
                            1,
                            std::ptr::null_mut(),
                            &mut val,
                        );
                    }
                }
                _ => {
                    // SAFETY: a sampler or image uniform holds one GLint.
                    unsafe {
                        let loc = gl.get_uniform_location(program.program(), c_name.as_ptr());
                        gl.get_uniformiv(program.program(), loc, &mut val);
                    }
                }
            }
            log::debug!("Querying binding point for {name}: {val} == {binding}");
            glu::expect_no_error(gl, "Binding point query failed")?;

            if val != binding {
                query_test_passed = false;
            }

            match self.kind {
                UniformKind::Ubo | UniformKind::Ssbo => {
                    // Draw twice to render both colours within the block.
                    for draw_cycle in 0..2 {
                        let array_ndx = iter_ndx * 2 + draw_cycle;
                        // SAFETY: a linked program in use.
                        unsafe { gl.uniform_1i(array_ndx_loc, array_ndx) };
                        // SAFETY: the program and buffers set up above.
                        if !unsafe {
                            draw_and_verify_result(context, colors[array_ndx as usize], render_width, render_height)?
                        } {
                            image_test_passed = false;
                        }
                    }
                }
                _ => {
                    // SAFETY: a linked program in use.
                    unsafe { gl.uniform_1i(array_ndx_loc, iter_ndx) };
                    // SAFETY: the program and buffers set up above.
                    if !unsafe {
                        draw_and_verify_result(context, colors[iter_ndx as usize], render_width, render_height)?
                    } {
                        image_test_passed = false;
                    }
                }
            }
        }

        // SAFETY: the location came from this case's own program.
        unsafe { gl.disable_vertex_attrib_array(pos_loc as u32) };

        // `setTestResult`
        Ok(match (query_test_passed, image_test_passed) {
            (true, true) => TestStatus::pass("Pass"),
            (false, false) => TestStatus::fail("One or more binding point queries and image comparisons failed"),
            (false, true) => TestStatus::fail("One or more binding point queries failed"),
            (true, false) => TestStatus::fail("One or more image comparisons failed"),
        })
    }
}

/// `SamplerBindingRenderCase::initializeTexture`
///
/// # Safety
/// A current context and a texture name this case owns.
unsafe fn initialize_texture(
    gl: &glw::Functions,
    texture_type: GLenum,
    binding_point: GLint,
    texture_name: glw::GLuint,
    color: [f32; 4],
) -> Result<(), TestError> {
    let level_data = solid_rgba8_level(texture_type, color);

    // SAFETY: the pixel buffer is exactly the size the upload describes.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0 + binding_point as u32);
        gl.bind_texture(texture_type, texture_name);
        gl.tex_parameteri(texture_type, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);

        if texture_type == glw::GL_TEXTURE_2D {
            gl.tex_image_2d(
                texture_type,
                0,
                glw::GL_RGBA8 as i32,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                level_data.as_ptr().cast(),
            );
        } else {
            gl.tex_image_3d(
                texture_type,
                0,
                glw::GL_RGBA8 as i32,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                level_data.as_ptr().cast(),
            );
        }
    }

    glu::expect_no_error(gl, "Texture initialization failed")
}

/// `ImageBindingRenderCase::initializeImage`
///
/// # Safety
/// A current context and a texture name this case owns.
unsafe fn initialize_image(
    gl: &glw::Functions,
    texture_type: GLenum,
    image_binding_point: GLint,
    texture_binding_point: GLint,
    texture_name: glw::GLuint,
    color: [f32; 4],
) -> Result<(), TestError> {
    let level_data = solid_rgba8_level(texture_type, color);

    // SAFETY: the pixel buffer is exactly the size the upload describes.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0 + texture_binding_point as u32);
        gl.bind_texture(texture_type, texture_name);
        gl.tex_parameteri(texture_type, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);

        if texture_type == glw::GL_TEXTURE_2D {
            gl.tex_storage_2d(texture_type, 1, glw::GL_RGBA8, TEST_TEXTURE_SIZE, TEST_TEXTURE_SIZE);
            gl.tex_sub_image_2d(
                texture_type,
                0,
                0,
                0,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                level_data.as_ptr().cast(),
            );
        } else {
            gl.tex_storage_3d(
                texture_type,
                1,
                glw::GL_RGBA8,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
            );
            gl.tex_sub_image_3d(
                texture_type,
                0,
                0,
                0,
                0,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                TEST_TEXTURE_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                level_data.as_ptr().cast(),
            );
        }

        gl.bind_texture(texture_type, 0);
        gl.bind_image_texture(
            image_binding_point as u32,
            texture_name,
            0,
            glw::GL_TRUE as u8,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA8,
        );
    }

    glu::expect_no_error(gl, "Image initialization failed")
}

/// `tcu::TextureLevel(RGBA8, TEST_TEXTURE_SIZE, ...)` cleared to one colour.
fn solid_rgba8_level(texture_type: GLenum, color: [f32; 4]) -> Vec<u8> {
    let depth = if texture_type == glw::GL_TEXTURE_2D {
        1
    } else {
        TEST_TEXTURE_SIZE
    };
    let mut level = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        TEST_TEXTURE_SIZE as u32,
        TEST_TEXTURE_SIZE as u32,
        depth as u32,
    )
    .expect("RGBA8 is a storable format");
    clear(&mut level.get_access(), color);
    level.data().to_vec()
}

/// `s_renderTestTypes`
const RENDER_TEST_TYPES: [(ShaderType, TestType, &str); 10] = [
    (ShaderType::Vertex, TestType::Single, "vertex_binding_single"),
    (ShaderType::Vertex, TestType::Max, "vertex_binding_max"),
    (ShaderType::Vertex, TestType::Multiple, "vertex_binding_multiple"),
    (ShaderType::Vertex, TestType::Array, "vertex_binding_array"),
    (ShaderType::Vertex, TestType::MaxArray, "vertex_binding_max_array"),
    (ShaderType::Fragment, TestType::Single, "fragment_binding_single"),
    (ShaderType::Fragment, TestType::Max, "fragment_binding_max"),
    (ShaderType::Fragment, TestType::Multiple, "fragment_binding_multiple"),
    (ShaderType::Fragment, TestType::Array, "fragment_binding_array"),
    (ShaderType::Fragment, TestType::MaxArray, "fragment_binding_max_array"),
];

fn render_group(name: &str, kind: UniformKind) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    for (shader_type, test_type, case_name) in RENDER_TEST_TYPES {
        group.add_child(Box::new(LayoutBindingRenderCase {
            name: case_name.to_string(),
            kind,
            shader_type,
            test_type,
        }) as Box<dyn TestCase>);
    }

    group
}

/// `LayoutBindingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("layout_binding");

    let mut sampler_render = TestCaseGroup::new("sampler");
    sampler_render.add_child(render_group("sampler2d", UniformKind::Sampler2D));
    sampler_render.add_child(render_group("sampler3d", UniformKind::Sampler3D));
    group.add_child(sampler_render);

    group.add_child(render_group("ubo", UniformKind::Ubo));
    group.add_child(render_group("ssbo", UniformKind::Ssbo));

    let mut image_render = TestCaseGroup::new("image");
    image_render.add_child(render_group("image2d", UniformKind::Image2D));
    image_render.add_child(render_group("image3d", UniformKind::Image3D));
    group.add_child(image_render);

    let mut negative = TestCaseGroup::new("negative");

    let mut sampler = TestCaseGroup::new("sampler");
    sampler.add_child(negative_group("sampler2d", UniformKind::Sampler2D));
    sampler.add_child(negative_group("sampler3d", UniformKind::Sampler3D));
    negative.add_child(sampler);

    negative.add_child(negative_group("ubo", UniformKind::Ubo));
    negative.add_child(negative_group("ssbo", UniformKind::Ssbo));

    let mut image = TestCaseGroup::new("image");
    image.add_child(negative_group("image2d", UniformKind::Image2D));
    image.add_child(negative_group("image3d", UniformKind::Image3D));
    negative.add_child(image);

    group.add_child(negative);

    group
}
