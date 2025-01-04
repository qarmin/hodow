// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cLayoutBindingTests.cpp
//   external/openglcts/modules/gles31/es31cLayoutBindingTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only. `LayoutBindingBaseCase` and its sampler and image subclasses are one `Runner` over a `Surface` (the virtual `getDefaultUniformName`, `buildLayout`, `maxBindings`, `maxArraySize` are `match`es on it); the `tcu::StringTemplate` of the upstream shader templates is a `${KEY}` replacement over a per-stage argument map. `LayoutBindingProgram` is `Program` over `glu::ShaderProgram`, its error log a plain dump of the failing build and the sources.
//
// All 21 cases: the sampler, image, atomic counter, uniform block and shader storage buffer variants of each stage. The atomic counter, block and buffer variants (AtomicCounterLayoutBindingCase, UniformBlocksLayoutBindingCase, ShaderStorageBufferLayoutBindingCase) differ from the base only in the `Surface`-dependent helpers, the program-resource-query based binding point lookups and the subtest overrides.

use std::collections::{BTreeMap, HashMap};

use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

/// `eStageType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    Fragment,
    Compute,
}

impl Stage {
    fn index(self) -> usize {
        match self {
            Stage::Vertex => 0,
            Stage::Fragment => 1,
            Stage::Compute => 2,
        }
    }
}

/// `eSurfaceType` restricted to the ported ones
#[derive(Clone, Copy, PartialEq, Eq)]
enum Surface {
    Texture,
    Image,
    AtomicCounter,
    UniformBlock,
    ShaderStorageBuffer,
}

/// `eTextureType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TextureType {
    None,
    TwoD,
    TwoDArray,
    ThreeD,
}

/// `LayoutBindingParameters`
#[derive(Clone, Copy)]
struct Parameters {
    keyword: &'static str,
    surface_type: Surface,
    texture_type: TextureType,
    vector_type: &'static str,
    uniform_type: &'static str,
    coord_vector_type: &'static str,
    access_function: &'static str,
}

const SAMPLER_2D: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::Texture,
    texture_type: TextureType::TwoD,
    vector_type: "vec4",
    uniform_type: "sampler2D",
    coord_vector_type: "vec2",
    access_function: "texture",
};
const SAMPLER_3D: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::Texture,
    texture_type: TextureType::ThreeD,
    vector_type: "vec4",
    uniform_type: "sampler3D",
    coord_vector_type: "vec3",
    access_function: "texture",
};
const SAMPLER_2D_ARRAY: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::Texture,
    texture_type: TextureType::TwoDArray,
    vector_type: "vec4",
    uniform_type: "sampler2DArray",
    coord_vector_type: "vec3",
    access_function: "texture",
};
const ATOMIC_UINT: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::AtomicCounter,
    texture_type: TextureType::TwoD,
    vector_type: "vec4",
    uniform_type: "atomic_uint",
    coord_vector_type: "vec3",
    access_function: "atomic",
};
const BLOCK: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::UniformBlock,
    texture_type: TextureType::None,
    vector_type: "vec4",
    uniform_type: "block",
    coord_vector_type: "vec3",
    access_function: "block",
};
const BUFFER: Parameters = Parameters {
    keyword: "buffer",
    surface_type: Surface::ShaderStorageBuffer,
    texture_type: TextureType::None,
    vector_type: "vec4",
    uniform_type: "buffer",
    coord_vector_type: "vec3",
    access_function: "atomicAdd",
};
const IMAGE_2D: Parameters = Parameters {
    keyword: "uniform",
    surface_type: Surface::Image,
    texture_type: TextureType::TwoD,
    vector_type: "vec4",
    uniform_type: "image2D",
    coord_vector_type: "ivec2",
    access_function: "imageLoad",
};

/// `LayoutBindingTestResult`
struct SubResult {
    passed: bool,
    reason: String,
}

impl SubResult {
    fn pass() -> Self {
        Self {
            passed: true,
            reason: String::new(),
        }
    }

    fn new(passed: bool, reason: String) -> Self {
        Self { passed, reason }
    }
}

type SubTest<'a> = fn(&mut Runner<'a>) -> Result<SubResult, TestError>;

/// `IntegerConstant`: the literal spellings of one integer
fn integer_constants(value: i32) -> Vec<String> {
    vec![
        format!("{value}"),
        format!("{value}u"),
        format!("{value}U"),
        format!("0{value:o}"),
        format!("0{value:o}u"),
        format!("0{value:o}U"),
        format!("0x{value:x}"),
        format!("0X{value:x}"),
        format!("0x{value:x}u"),
        format!("0X{value:x}u"),
        format!("0x{value:x}U"),
        format!("0X{value:x}U"),
    ]
}

/// `${KEY}` replacement, as `tcu::StringTemplate::specialize` over the argument map
fn specialize(template: &str, args: &HashMap<&'static str, String>) -> String {
    let mut result = template.to_string();
    for (key, value) in args {
        result = result.replace(&format!("${{{key}}}"), value);
    }
    result
}

const VERTEX_TEMPLATE: &str = "${VERSION}layout(location=0) in vec2 inPosition;\n${UNIFORM_DECL}\nflat out ${OUT_VAR_TYPE} fragColor;\n${OPTIONAL_FUNCTION_BLOCK}\nvoid main(void)\n{\n  ${OUT_ASSIGNMENT} ${UNIFORM_ACCESS}\n  gl_Position = vec4(inPosition, 0.0, 1.0);\n}\n";
const FRAGMENT_TEMPLATE: &str = "${VERSION}layout(location=0) out ${OUT_VAR_TYPE} ${OUT_VAR};\nflat in ${OUT_VAR_TYPE} fragColor;\n${UNIFORM_DECL}\n${OPTIONAL_FUNCTION_BLOCK}\nvoid main(void)\n{\n  ${OUT_ASSIGNMENT} ${UNIFORM_ACCESS}\n}\n";
const COMPUTE_TEMPLATE: &str = "${VERSION}${UNIFORM_DECL}\n${OPTIONAL_FUNCTION_BLOCK}\nvoid main(void)\n{\n  ${OUT_VAR_TYPE} tmp = ${UNIFORM_ACCESS}\n  ${OUT_ASSIGNMENT} tmp ${OUT_END}\n}\n";
const UNIFORM_DECL_TEMPLATE: &str = "${LAYOUT}${KEYWORD}${UNIFORM_TYPE}${UNIFORM_BLOCK_NAME}${UNIFORM_BLOCK}${UNIFORM_INSTANCE_NAME}${UNIFORM_ARRAY};\n";

/// `LayoutBindingProgram`
struct Program<'gl> {
    gl: &'gl glw::Functions,
    stage: Stage,
    surface: Surface,
    program: ShaderProgram<'gl>,
}

impl<'gl> Program<'gl> {
    fn new(gl: &'gl glw::Functions, stage: Stage, surface: Surface, sources: &[String; 3]) -> Self {
        let program_sources = if stage != Stage::Compute {
            ProgramSources::vtx_frag(
                sources[Stage::Vertex.index()].clone(),
                sources[Stage::Fragment.index()].clone(),
            )
        } else {
            ProgramSources::compute(sources[Stage::Compute.index()].clone())
        };
        Self {
            gl,
            stage,
            surface,
            program: ShaderProgram::new_reporting_build_failure(gl, &program_sources),
        }
    }

    fn program(&self) -> GLuint {
        self.program.program()
    }

    /// `compiledAndLinked`
    fn compiled_and_linked(&self) -> bool {
        self.program.is_ok()
    }

    /// `getErrorLog`
    fn error_log(&self, dump_shaders: bool, sources: &[String; 3]) -> String {
        let mut log = String::new();
        if let Some(summary) = self.program.build_failure_summary() {
            log.push_str(&format!(
                "Build failed while testing stage {}: {summary}\n",
                self.stage.index()
            ));
        }
        if dump_shaders {
            log.push_str("Shader should not have compiled\n");
        }
        let stages: &[Stage] = if self.stage != Stage::Compute {
            &[Stage::Vertex, Stage::Fragment]
        } else {
            &[Stage::Compute]
        };
        for stage in stages {
            log.push_str(&format!(
                "### dump of stage {} ###\n{}",
                stage.index(),
                sources[stage.index()]
            ));
        }
        log
    }

    /// The program-resource lookup of the block cases and the atomic counter cases: `getProgramResourceIndex` of `name` in `interface`, `None` when it has no index
    fn resource_index(&self, interface: GLenum, name: &str) -> Option<GLuint> {
        let c_name = std::ffi::CString::new(name).expect("no NUL in a resource name");
        // SAFETY: a linked program and a NUL-terminated name.
        let index = unsafe {
            self.gl
                .get_program_resource_index(self.program(), interface, c_name.as_ptr())
        };
        if index == glw::GL_INVALID_INDEX {
            None
        } else {
            Some(index)
        }
    }

    /// One `getProgramResourceiv` of one property; `None` when the call raised an error
    fn resource_value(&self, interface: GLenum, index: GLuint, property: GLenum) -> Option<GLint> {
        let mut value: GLint = -1;
        // SAFETY: a linked program, an index it reported, one property and one int out.
        unsafe {
            self.gl.get_program_resourceiv(
                self.program(),
                interface,
                index,
                1,
                &property,
                1,
                std::ptr::null_mut(),
                &mut value,
            )
        };
        // SAFETY: plain error query.
        if unsafe { self.gl.get_error() } == glw::GL_NO_ERROR {
            Some(value)
        } else {
            None
        }
    }

    /// `getBindingPoints`: the names that have a location and report a binding point
    fn binding_points(&self, args: &[String]) -> BTreeMap<String, GLint> {
        let gl = self.gl;
        let mut binding_points = BTreeMap::new();

        match self.surface {
            Surface::AtomicCounter => {
                for name in args {
                    let Some(index) = self.resource_index(glw::GL_UNIFORM, name) else {
                        continue;
                    };
                    let Some(atomic_counter_buffer_index) = self
                        .resource_value(glw::GL_UNIFORM, index, glw::GL_ATOMIC_COUNTER_BUFFER_INDEX)
                        .filter(|&value| value != -1)
                    else {
                        continue;
                    };
                    let Some(value) = self
                        .resource_value(
                            glw::GL_ATOMIC_COUNTER_BUFFER,
                            atomic_counter_buffer_index as GLuint,
                            glw::GL_BUFFER_BINDING,
                        )
                        .filter(|&value| value != -1)
                    else {
                        continue;
                    };
                    binding_points.insert(name.clone(), value);
                }
            }
            Surface::UniformBlock | Surface::ShaderStorageBuffer => {
                let interface = if self.surface == Surface::UniformBlock {
                    glw::GL_UNIFORM_BLOCK
                } else {
                    glw::GL_SHADER_STORAGE_BLOCK
                };
                for name in args {
                    let Some(index) = self.resource_index(interface, name) else {
                        continue;
                    };
                    if let Some(value) = self.resource_value(interface, index, glw::GL_BUFFER_BINDING) {
                        binding_points.insert(name.clone(), value);
                    }
                }
            }
            Surface::Texture | Surface::Image => {
                let mut locations: Vec<(&String, GLint)> = Vec::new();
                let mut passed = true;
                for name in args {
                    let c_name = std::ffi::CString::new(name.as_str()).expect("no NUL in a uniform name");
                    // SAFETY: a linked program and a NUL-terminated name.
                    let location = unsafe { gl.get_uniform_location(self.program(), c_name.as_ptr()) };
                    passed &= location >= 0;
                    if passed {
                        locations.push((name, location));
                    }
                }

                for (name, location) in locations {
                    let mut binding_point: GLint = 0;
                    // SAFETY: a linked program and a location it reported; one int out.
                    unsafe { gl.get_uniformiv(self.program(), location, &mut binding_point) };
                    // SAFETY: plain error query.
                    if unsafe { gl.get_error() } == glw::GL_NO_ERROR {
                        binding_points.insert(name.clone(), binding_point);
                    }
                }
            }
        }
        binding_points
    }

    /// `getOffsets` of the atomic counter case
    fn offsets(&self, args: &[String]) -> BTreeMap<String, GLint> {
        let mut offsets = BTreeMap::new();
        for name in args {
            let Some(index) = self.resource_index(glw::GL_UNIFORM, name) else {
                continue;
            };
            let mut value: GLint = -1;
            let property = glw::GL_OFFSET;
            // SAFETY: a linked program, an index it reported, one property and one int out.
            unsafe {
                self.gl.get_program_resourceiv(
                    self.program(),
                    glw::GL_UNIFORM,
                    index,
                    1,
                    &property,
                    1,
                    std::ptr::null_mut(),
                    &mut value,
                )
            };
            // SAFETY: plain error query.
            if unsafe { self.gl.get_error() } == glw::GL_NO_ERROR {
                offsets.insert(name.clone(), value);
            }
        }
        offsets
    }

    /// `setBindingPoints`
    fn set_binding_points(&self, list: &[String], binding_point: GLint) {
        let gl = self.gl;
        for name in list {
            match self.surface {
                Surface::UniformBlock => {
                    let c_name = std::ffi::CString::new(name.as_str()).expect("no NUL in a block name");
                    // SAFETY: a linked program and a NUL-terminated name.
                    let block_index = unsafe { gl.get_uniform_block_index(self.program(), c_name.as_ptr()) };
                    if block_index == glw::GL_INVALID_INDEX {
                        return;
                    }
                    // SAFETY: a block index the program reported.
                    unsafe { gl.uniform_block_binding(self.program(), block_index, binding_point as GLuint) };
                }
                Surface::ShaderStorageBuffer => {
                    let Some(block_index) = self.resource_index(glw::GL_SHADER_STORAGE_BLOCK, name) else {
                        return;
                    };
                    // SAFETY: a block index the program reported.
                    unsafe { gl.shader_storage_block_binding(self.program(), block_index, binding_point as GLuint) };
                }
                Surface::Texture | Surface::Image | Surface::AtomicCounter => {
                    let c_name = std::ffi::CString::new(name.as_str()).expect("no NUL in a uniform name");
                    // SAFETY: a linked program and a NUL-terminated name.
                    let location = unsafe { gl.get_uniform_location(self.program(), c_name.as_ptr()) };
                    if location < 0 {
                        continue;
                    }
                    // SAFETY: a location the program reported; the program is in use.
                    unsafe { gl.uniform_1i(location, binding_point) };
                }
            }
        }
    }
}

/// The map's `operator[]` of upstream: a missing key reads as zero.
fn at(map: &BTreeMap<String, GLint>, key: &str) -> GLint {
    map.get(key).copied().unwrap_or(0)
}

/// `LayoutBindingBaseCase` state for one `iterate`
struct Runner<'a> {
    context: &'a Context,
    stage: Stage,
    parameters: Parameters,
    glsl_version: GlslVersion,
    sources: [String; 3],
    args: [HashMap<&'static str, String>; 3],
    texture_id: GLuint,
    buffer_id: GLuint,
}

impl<'a> Runner<'a> {
    fn gl(&self) -> &'a glw::Functions {
        self.context.gl()
    }

    fn get_integer(&self, pname: GLenum) -> GLint {
        let mut units: GLint = 0;
        // SAFETY: one int out.
        unsafe { self.gl().get_integerv(pname, &mut units) };
        units
    }

    /// `needsPrecision` for a desktop context
    fn needs_precision(&self) -> bool {
        let surface = self.parameters.surface_type;
        let buffer_like = matches!(surface, Surface::UniformBlock | Surface::ShaderStorageBuffer);
        if self.glsl_version == GlslVersion::Glsl450 {
            !buffer_like
        } else {
            !(buffer_like || matches!(surface, Surface::AtomicCounter | Surface::Image))
        }
    }

    fn default_uniform_name(&self, idx: usize) -> String {
        match self.parameters.surface_type {
            Surface::Texture => format!("sampler{idx}"),
            Surface::Image => format!("image{idx}"),
            Surface::AtomicCounter => format!("atomic{idx}"),
            Surface::UniformBlock => format!("uniform{idx}"),
            Surface::ShaderStorageBuffer => format!("buffer{idx}"),
        }
    }

    fn build_layout(&self, binding: &str) -> String {
        match self.parameters.surface_type {
            Surface::Texture | Surface::AtomicCounter => {
                if binding.is_empty() {
                    String::new()
                } else {
                    format!("layout(binding={binding}) ")
                }
            }
            Surface::Image => {
                if binding.is_empty() {
                    "layout(rgba8) readonly ".to_string()
                } else {
                    format!("layout(binding={binding}, rgba8) readonly ")
                }
            }
            Surface::UniformBlock => {
                if binding.is_empty() {
                    "layout(std140) ".to_string()
                } else {
                    format!("layout(binding={binding}, std140) ")
                }
            }
            Surface::ShaderStorageBuffer => {
                if binding.is_empty() {
                    "layout(std430) ".to_string()
                } else {
                    format!("layout(binding={binding}, std430) ")
                }
            }
        }
    }

    fn build_layout_int(&self, binding: i32) -> String {
        self.build_layout(&binding.to_string())
    }

    fn build_access(&self, var: &str) -> String {
        match self.parameters.surface_type {
            Surface::AtomicCounter => format!("vec4(float(atomicCounter({var})), 1.0, 0.0, 1.0)"),
            Surface::UniformBlock => format!("vec4(0.0, {var}_a, 0.0, 1.0) + vec4(0.0, {var}_b, 0.0, 1.0)"),
            Surface::ShaderStorageBuffer => format!("vec4(0.0, {var}_a[0] + {var}_a[1], 0.0, 1.0)"),
            Surface::Texture | Surface::Image => format!(
                "{}({var},{}(0))",
                self.parameters.access_function, self.parameters.coord_vector_type
            ),
        }
    }

    /// `buildBlockName`
    fn build_block_name(&self, name: &str) -> String {
        match self.parameters.surface_type {
            Surface::UniformBlock | Surface::ShaderStorageBuffer => name.to_string(),
            _ => String::new(),
        }
    }

    /// `buildBlock` with its default `float` type
    fn build_block(&self, name: &str) -> String {
        match self.parameters.surface_type {
            Surface::UniformBlock => format!("{{float {name}_a; float {name}_b; }}"),
            Surface::ShaderStorageBuffer => format!("{{float {name}_a[2];\n}}"),
            _ => String::new(),
        }
    }

    /// The name a uniform of index `idx` is queried by: the block name plus `_block` for a block, else the uniform name
    fn query_name(&self, idx: usize) -> String {
        let name = self.default_uniform_name(idx);
        if self.build_block_name(&self.default_uniform_name(0)).is_empty() {
            name
        } else {
            format!("{name}_block")
        }
    }

    fn build_array(idx: i32) -> String {
        format!("[{idx}]")
    }

    fn build_array_access(&self, uniform: usize, idx: i32) -> String {
        let mut s = format!("{}{}", self.default_uniform_name(uniform), Self::build_array(idx));
        if !self.build_block_name(&self.default_uniform_name(0)).is_empty() {
            s.push('.');
            s.push_str(&self.default_uniform_name(uniform));
        }
        s
    }

    fn max_bindings(&self) -> i32 {
        match self.parameters.surface_type {
            Surface::Texture => self.get_integer(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS),
            Surface::Image => self.get_integer(glw::GL_MAX_IMAGE_UNITS),
            Surface::AtomicCounter => self.get_integer(glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS),
            Surface::UniformBlock => self.get_integer(glw::GL_MAX_UNIFORM_BUFFER_BINDINGS),
            Surface::ShaderStorageBuffer => self.get_integer(glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS),
        }
    }

    fn max_array_size(&self) -> i32 {
        let pname = match (self.parameters.surface_type, self.stage) {
            (Surface::Texture, Stage::Vertex) => glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
            (Surface::Texture, Stage::Fragment) => glw::GL_MAX_TEXTURE_IMAGE_UNITS,
            (Surface::Texture, Stage::Compute) => glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS,
            (Surface::Image, Stage::Vertex) => glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
            (Surface::Image, Stage::Fragment) => glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
            (Surface::Image, Stage::Compute) => glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS,
            (Surface::AtomicCounter, Stage::Vertex) => glw::GL_MAX_VERTEX_ATOMIC_COUNTERS,
            (Surface::AtomicCounter, Stage::Fragment) => glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS,
            (Surface::AtomicCounter, Stage::Compute) => glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS,
            (Surface::UniformBlock, Stage::Vertex) => glw::GL_MAX_VERTEX_UNIFORM_BLOCKS,
            (Surface::UniformBlock, Stage::Fragment) => glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
            (Surface::UniformBlock, Stage::Compute) => glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS,
            (Surface::ShaderStorageBuffer, Stage::Vertex) => glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS,
            (Surface::ShaderStorageBuffer, Stage::Fragment) => glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
            (Surface::ShaderStorageBuffer, Stage::Compute) => glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS,
        };
        self.get_integer(pname)
    }

    /// `makeSparseRange`
    fn make_sparse_range(max_element: i32, min_element: i32) -> Vec<i32> {
        const RANGE_TEMPLATE: [f32; 6] = [0.0, 0.1, 0.5, 0.6, 0.9, 1.0];
        let max = RANGE_TEMPLATE[RANGE_TEMPLATE.len() - 1];
        let range = ((max_element - 1) - min_element) as f32;
        RANGE_TEMPLATE
            .iter()
            .map(|&e| min_element + ((e * range) / max) as i32)
            .collect()
    }

    fn texture_target(&self) -> GLenum {
        match self.parameters.texture_type {
            TextureType::TwoD => glw::GL_TEXTURE_2D,
            TextureType::TwoDArray => glw::GL_TEXTURE_2D_ARRAY,
            TextureType::ThreeD => glw::GL_TEXTURE_3D,
            TextureType::None => 0,
        }
    }

    fn set_template_param_for(&mut self, stage: Stage, param: &'static str, value: String) {
        self.args[stage.index()].insert(param, value);
    }

    fn set_template_param(&mut self, param: &'static str, value: String) {
        self.set_template_param_for(self.stage, param, value);
    }

    fn update_template_for(&mut self, stage: Stage) {
        let template = match stage {
            Stage::Vertex => VERTEX_TEMPLATE,
            Stage::Fragment => FRAGMENT_TEMPLATE,
            Stage::Compute => COMPUTE_TEMPLATE,
        };
        self.sources[stage.index()] = specialize(template, &self.args[stage.index()]);
    }

    fn update_template(&mut self) {
        self.update_template_for(self.stage);
    }

    /// `initDefaultVSContext`, `initDefaultFSContext` and `initDefaultCSContext`: every subtest starts from these.
    fn reset_contexts(&mut self) {
        let mut version = format!("{}\nprecision highp float;\n", self.glsl_version.declaration());
        if self.needs_precision() {
            version.push_str(&format!("precision highp {};\n", self.parameters.uniform_type));
        }

        let vector_type = self.parameters.vector_type.to_string();

        let mut vertex = HashMap::new();
        vertex.insert("VERSION", version.clone());
        vertex.insert("UNIFORM_DECL", String::new());
        vertex.insert("OPTIONAL_FUNCTION_BLOCK", String::new());
        vertex.insert("UNIFORM_ACCESS", String::new());
        vertex.insert(
            "OUT_ASSIGNMENT",
            if self.stage != Stage::Vertex {
                String::new()
            } else {
                "fragColor =".to_string()
            },
        );
        vertex.insert("OUT_VAR_TYPE", vector_type.clone());
        vertex.insert("OUT_VAR", "fragColor".to_string());
        self.args[Stage::Vertex.index()] = vertex;
        self.update_template_for(Stage::Vertex);

        let mut fragment = HashMap::new();
        fragment.insert("VERSION", version);
        fragment.insert("OUT_VAR_TYPE", vector_type.clone());
        fragment.insert(
            "UNIFORM_ACCESS",
            if self.stage != Stage::Fragment {
                "fragColor;".to_string()
            } else {
                "vec4(0.0,0.0,0.0,0.0);".to_string()
            },
        );
        fragment.insert("UNIFORM_DECL", String::new());
        fragment.insert("OPTIONAL_FUNCTION_BLOCK", String::new());
        fragment.insert("OUT_ASSIGNMENT", "outColor =".to_string());
        fragment.insert("OUT_VAR", "outColor".to_string());
        self.args[Stage::Fragment.index()] = fragment;
        self.update_template_for(Stage::Fragment);

        let mut compute_version = format!(
            "{}\nlayout (local_size_x = 1) in;\nprecision highp float;\n",
            self.glsl_version.declaration()
        );
        if self.needs_precision() {
            compute_version.push_str(&format!("precision highp {};\n", self.parameters.uniform_type));
        }
        let mut compute = HashMap::new();
        if self.parameters.surface_type == Surface::Image {
            compute_version.push_str(&format!(
                "layout(binding=0, std430) buffer outData {{\n    {vector_type} outColor;\n}};\n"
            ));
            compute.insert("OUT_ASSIGNMENT", "outColor =".to_string());
            compute.insert("OUT_END", ";".to_string());
        } else {
            compute_version.push_str("layout(binding=0, rgba8) uniform highp writeonly image2D outImage;\n");
            compute.insert("OUT_ASSIGNMENT", "imageStore(outImage, ivec2(0), ".to_string());
            compute.insert("OUT_END", ");".to_string());
        }
        compute.insert("VERSION", compute_version);
        compute.insert("OUT_VAR_TYPE", vector_type);
        compute.insert("UNIFORM_ACCESS", "vec4(0.0,0.0,0.0,0.0);".to_string());
        compute.insert("UNIFORM_DECL", String::new());
        compute.insert("OPTIONAL_FUNCTION_BLOCK", String::new());
        self.args[Stage::Compute.index()] = compute;
        self.update_template_for(Stage::Compute);
    }

    /// `buildUniformDecl` of the uniform of index `idx`, with its block name and block
    fn uniform_decl(&self, layout: &str, idx: usize, array: &str) -> String {
        let instance = self.default_uniform_name(idx);
        let uniform_block_name = self.build_block_name(&instance);
        let uniform_block = self.build_block(&instance);
        let with_space = |value: &str| {
            if value.is_empty() {
                String::new()
            } else {
                format!("{value} ")
            }
        };

        let mut args: HashMap<&'static str, String> = HashMap::new();
        args.insert("LAYOUT", with_space(layout));
        args.insert("KEYWORD", with_space(self.parameters.keyword));
        args.insert(
            "UNIFORM_TYPE",
            if uniform_block_name.is_empty() {
                with_space(self.parameters.uniform_type)
            } else {
                String::new()
            },
        );
        args.insert(
            "UNIFORM_BLOCK_NAME",
            if !instance.is_empty() && !uniform_block_name.is_empty() {
                with_space(&format!("{uniform_block_name}_block"))
            } else {
                with_space(&uniform_block_name)
            },
        );
        args.insert("UNIFORM_BLOCK", with_space(&uniform_block));
        args.insert(
            "UNIFORM_INSTANCE_NAME",
            if (uniform_block_name.is_empty() && uniform_block.is_empty()) || !array.is_empty() {
                instance
            } else {
                String::new()
            },
        );
        args.insert("UNIFORM_ARRAY", array.to_string());
        specialize(UNIFORM_DECL_TEMPLATE, &args)
    }

    fn program(&self) -> Program<'a> {
        Program::new(self.gl(), self.stage, self.parameters.surface_type, &self.sources)
    }

    /// `bind`
    fn bind(&self, binding: i32) {
        let gl = self.gl();
        let target = self.texture_target();
        // SAFETY: state calls on the current context with the texture this case created.
        unsafe {
            match self.parameters.surface_type {
                Surface::Texture => {
                    gl.active_texture(glw::GL_TEXTURE0 + binding as GLenum);
                    gl.bind_texture(target, self.texture_id);
                    gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint);
                    gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as GLint);
                    gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                    gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                }
                Surface::Image => gl.bind_image_texture(
                    binding as GLuint,
                    self.texture_id,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_READ_ONLY,
                    glw::GL_RGBA8,
                ),
                Surface::UniformBlock => gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, binding as GLuint, self.buffer_id),
                Surface::ShaderStorageBuffer => {
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, binding as GLuint, self.buffer_id)
                }
                Surface::AtomicCounter => {}
            }
        }
    }

    /// `unbind`
    fn unbind(&self, binding: i32) {
        let gl = self.gl();
        // SAFETY: state calls on the current context.
        unsafe {
            match self.parameters.surface_type {
                Surface::Texture => {
                    gl.active_texture(glw::GL_TEXTURE0 + binding as GLenum);
                    gl.bind_texture(self.texture_target(), 0);
                }
                Surface::Image => {
                    gl.bind_image_texture(binding as GLuint, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_R32F)
                }
                Surface::UniformBlock => gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, binding as GLuint, 0),
                Surface::ShaderStorageBuffer => {
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, binding as GLuint, 0)
                }
                Surface::AtomicCounter => {}
            }
        }
    }

    /// `init`: the 2x2 (x1) texture filled with the expected colour (0, 1, 0, 1)
    fn init_texture(&mut self) -> Result<(), TestError> {
        let gl = self.gl();
        let target = self.texture_target();
        let texels = [[0u8, 255, 0, 255]; 4];

        // a test case where no texture allocation is needed
        if self.parameters.texture_type == TextureType::None {
            return Ok(());
        }

        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut self.texture_id));
        gl_call!(gl, "BindTexture", gl.bind_texture(target, self.texture_id));
        match self.parameters.texture_type {
            TextureType::TwoD => {
                gl_call!(gl, "TexStorage2D", gl.tex_storage_2d(target, 1, glw::GL_RGBA8, 2, 2));
                gl_call!(
                    gl,
                    "TexSubImage2D",
                    gl.tex_sub_image_2d(
                        target,
                        0,
                        0,
                        0,
                        2,
                        2,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        texels.as_ptr().cast()
                    )
                );
            }
            TextureType::None => {}
            TextureType::TwoDArray | TextureType::ThreeD => {
                gl_call!(gl, "TexStorage3D", gl.tex_storage_3d(target, 1, glw::GL_RGBA8, 2, 2, 1));
                gl_call!(
                    gl,
                    "TexSubImage3D",
                    gl.tex_sub_image_3d(
                        target,
                        0,
                        0,
                        0,
                        0,
                        2,
                        2,
                        1,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        texels.as_ptr().cast()
                    )
                );
            }
        }
        Ok(())
    }

    /// `setupTest` of the block cases: the buffer holding two floats the shaders read
    fn setup_test(&mut self) -> Result<(), TestError> {
        let gl = self.gl();
        let target = match self.parameters.surface_type {
            Surface::UniformBlock => glw::GL_UNIFORM_BUFFER,
            Surface::ShaderStorageBuffer => glw::GL_SHADER_STORAGE_BUFFER,
            _ => return Ok(()),
        };
        let f: [f32; 2] = [0.25, 0.75];
        gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut self.buffer_id));
        gl_call!(gl, "BindBuffer", gl.bind_buffer(target, self.buffer_id));
        gl_call!(
            gl,
            "BufferData",
            gl.buffer_data(
                target,
                std::mem::size_of_val(&f) as glw::GLsizeiptr,
                f.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        Ok(())
    }

    /// `teardownTest`
    fn teardown(&mut self) {
        if self.buffer_id != 0 {
            let target = if self.parameters.surface_type == Surface::UniformBlock {
                glw::GL_UNIFORM_BUFFER
            } else {
                glw::GL_SHADER_STORAGE_BUFFER
            };
            // SAFETY: unbinds and deletes the name this case created, on the current context.
            unsafe {
                self.gl().bind_buffer(target, 0);
                self.gl().delete_buffers(1, &self.buffer_id);
            }
            self.buffer_id = 0;
        }
        if self.texture_id != 0 {
            // SAFETY: deletes the name this case created, on the current context.
            unsafe { self.gl().delete_textures(1, &self.texture_id) };
            self.texture_id = 0;
        }
    }

    /// `drawTest`
    fn draw_test(&self, program: GLuint, binding: i32) -> Result<SubResult, TestError> {
        let gl = self.gl();
        let render_target = self.context.render_target();

        gl_call!(gl, "Viewport", {
            gl.viewport(0, 0, render_target.width, render_target.height);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.use_program(program);
        });

        self.bind(binding);

        let vertex_arrays = [va::float("inPosition", 2, 4, 0, &POSITION)];
        glu::draw(
            &self.context.render_context,
            program,
            &vertex_arrays,
            &pr::triangle_strip(&QUAD_INDICES),
        )?;

        let mut pixel = [0u8; 4];
        gl_call!(gl, "ReadPixels", {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                pixel.as_mut_ptr().cast(),
            );
        });

        self.unbind(binding);

        if pixel != [0, 255, 0, 255] {
            return Ok(SubResult::new(
                false,
                format!(
                    "drawTest failed expected: [0, 255, 0, 255] actual: {pixel:?}\n{}\n{}\n",
                    self.sources[0], self.sources[1]
                ),
            ));
        }
        Ok(SubResult::pass())
    }

    /// `drawTestCompute`
    fn draw_test_compute(&self, program: GLuint, binding: i32) -> Result<SubResult, TestError> {
        let gl = self.gl();

        gl_call!(gl, "UseProgram", gl.use_program(program));

        if self.parameters.surface_type == Surface::Image {
            self.bind(binding);

            let buffer: [f32; 4] = [0.1, 0.2, 0.3, 0.4];
            let mut ssb: GLuint = 0;
            gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut ssb));
            gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, ssb));
            gl_call!(
                gl,
                "BufferData",
                gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    16,
                    buffer.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY
                )
            );
            gl_call!(
                gl,
                "BindBufferBase",
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssb)
            );

            gl_call!(gl, "DispatchCompute", {
                gl.dispatch_compute(1, 1, 1);
                gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT);
            });

            // SAFETY: maps the 16 bytes of the buffer just written by the dispatch.
            let mapped = unsafe { gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 16, glw::GL_MAP_READ_BIT) };
            let pixel = if mapped.is_null() {
                [0.0f32; 4]
            } else {
                // SAFETY: the mapping covers four floats.
                unsafe { *mapped.cast::<[f32; 4]>() }
            };
            // SAFETY: unmaps and deletes the buffer this call created.
            unsafe {
                gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
                gl.delete_buffers(1, &ssb);
            }

            self.unbind(binding);

            let expected = [0.0f32, 1.0, 0.0, 1.0];
            if pixel != expected {
                return Ok(SubResult::new(
                    false,
                    format!("drawTestCompute failed expected: {expected:?} actual: {pixel:?}\n"),
                ));
            }
        } else {
            let mut something: u32 = 0x01020304;
            let mut tex: GLuint = 0;

            gl_call!(gl, "GenTextures", {
                gl.gen_textures(1, &mut tex);
                gl.bind_texture(glw::GL_TEXTURE_2D, tex);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint);
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 1);
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_ref(&something).cast(),
                );
            });

            self.bind(binding);

            gl_call!(gl, "BindImageTexture", {
                gl.bind_image_texture(0, tex, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA8);
                gl.dispatch_compute(1, 1, 1);
                gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT);
                gl.bind_image_texture(0, 0, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA8);
            });

            let mut fbo: GLuint = 0;
            gl_call!(gl, "GenFramebuffers", {
                gl.gen_framebuffers(1, &mut fbo);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    tex,
                    0,
                );
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::from_mut(&mut something).cast(),
                );
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                gl.delete_framebuffers(1, &fbo);
                gl.delete_textures(1, &tex);
            });

            self.unbind(binding);

            const EXPECTED: u32 = 0xff00ff00;
            if EXPECTED != something {
                return Ok(SubResult::new(
                    false,
                    format!("drawTestCompute failed expected: {EXPECTED:#x} actual: {something:#x}\n"),
                ));
            }
        }
        Ok(SubResult::pass())
    }

    fn draw(&self, program: GLuint, binding: i32) -> Result<SubResult, TestError> {
        if self.stage == Stage::Compute {
            self.draw_test_compute(program, binding)
        } else {
            self.draw_test(program, binding)
        }
    }

    fn generate_log(&self, msg: &str, result: GLint, expected: GLint) -> String {
        format!(
            "{msg} expected: {expected} actual: {result}\n{}\n{}\n",
            self.sources[0], self.sources[1]
        )
    }

    fn access_statement(&self) -> String {
        format!("{};\n", self.build_access(&self.default_uniform_name(0)))
    }

    /// The array element uniform names of `uniform` (`texUnitStr` in upstream)
    fn array_names(&self, uniform: usize, array_size: i32) -> Vec<String> {
        (0..array_size)
            .map(|idx| format!("{}{}", self.query_name(uniform), Self::build_array(idx)))
            .collect()
    }

    fn compile_failure(&self, program: &Program<'_>) -> SubResult {
        SubResult::new(false, program.error_log(false, &self.sources))
    }

    /// `binding_basic_default`
    fn binding_basic_default(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }

        let access = self.access_statement();
        self.set_template_param("UNIFORM_ACCESS", access);

        let decl = self.uniform_decl(&self.build_layout(""), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();

        let program = self.program();
        if !program.compiled_and_linked() {
            return Ok(self.compile_failure(&program));
        }

        let list = [self.query_name(0)];
        let binding_points = program.binding_points(&list);

        // upstream indexes the map with the block name (empty, or not a key of the map), which reads as zero
        let block_name = self.build_block_name(&self.default_uniform_name(0));
        if !(binding_points.len() == list.len() && at(&binding_points, &block_name) == 0) {
            return Ok(SubResult::new(
                false,
                self.generate_log(
                    "binding point did not match default",
                    at(&binding_points, &block_name),
                    0,
                ),
            ));
        }
        Ok(SubResult::pass())
    }

    /// `binding_basic_explicit`
    fn binding_basic_explicit(&mut self) -> Result<SubResult, TestError> {
        let access = self.access_statement();
        self.set_template_param("UNIFORM_ACCESS", access);

        for binding in Self::make_sparse_range(self.max_bindings(), 0) {
            let decl = self.uniform_decl(&self.build_layout_int(binding), 0, "");
            self.set_template_param("UNIFORM_DECL", decl);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            let list = [self.query_name(0)];
            let binding_points = program.binding_points(&list);
            if !(binding_points.len() == list.len() && binding == at(&binding_points, &list[0])) {
                return Ok(SubResult::new(
                    false,
                    self.generate_log(
                        "binding point did not match default",
                        at(&binding_points, &list[0]),
                        binding,
                    ),
                ));
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_basic_multiple`
    fn binding_basic_multiple(&mut self) -> Result<SubResult, TestError> {
        let base_binding_point = self.max_bindings() - 1;

        let decl0 = self.uniform_decl(&self.build_layout_int(base_binding_point), 0, "");
        let decl1 = self.uniform_decl(&self.build_layout_int(base_binding_point), 1, "");
        self.set_template_param("UNIFORM_DECL", format!("{decl0}{decl1}"));

        let access = format!(
            "{} + {};\n",
            self.build_access(&self.default_uniform_name(0)),
            self.build_access(&self.default_uniform_name(1))
        );
        self.set_template_param("UNIFORM_ACCESS", access);
        self.update_template();

        let program = self.program();
        if !program.compiled_and_linked() {
            return Ok(self.compile_failure(&program));
        }

        let list = [self.query_name(0), self.query_name(1)];
        let binding_points = program.binding_points(&list);
        if !(base_binding_point == at(&binding_points, &list[0]) && base_binding_point == at(&binding_points, &list[1]))
        {
            let mut err = self.generate_log(
                "binding point did not match default",
                at(&binding_points, &list[0]),
                base_binding_point,
            );
            err.push_str(&self.generate_log(
                "binding point did not match default",
                at(&binding_points, &list[1]),
                base_binding_point,
            ));
            return Ok(SubResult::new(false, err));
        }
        Ok(SubResult::pass())
    }

    /// `binding_basic_render`
    fn binding_basic_render(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }

        let access = self.access_statement();
        self.set_template_param("UNIFORM_ACCESS", access);

        for binding in Self::make_sparse_range(self.max_bindings(), 0) {
            let decl = self.uniform_decl(&self.build_layout_int(binding), 0, "");
            self.set_template_param("UNIFORM_DECL", decl);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            let draw_test_result = self.draw(program.program(), binding)?;
            if !draw_test_result.passed {
                return Ok(SubResult::new(draw_test_result.passed, draw_test_result.reason));
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_integer_constant`
    fn binding_integer_constant(&mut self) -> Result<SubResult, TestError> {
        let integers = Self::make_sparse_range(self.max_bindings(), 0);

        // the literal spellings in the order of upstream's `Literals` enum, each over all the integers
        let mut constants: Vec<(String, i32)> = Vec::new();
        for literal in 0..12 {
            for &value in &integers {
                constants.push((integer_constants(value)[literal].clone(), value));
            }
        }

        // the binding point set with an integer constant, then with one from a preprocessor substitution
        for through_define in [false, true] {
            for (int_const, as_int) in &constants {
                let (layout, prefix) = if through_define {
                    (
                        self.build_layout("INT_CONST"),
                        format!("#define INT_CONST {int_const}\n"),
                    )
                } else {
                    (self.build_layout(int_const), String::new())
                };
                let decl = self.uniform_decl(&layout, 0, "");
                self.set_template_param("UNIFORM_DECL", format!("{prefix}{decl}"));

                let access = self.access_statement();
                self.set_template_param("UNIFORM_ACCESS", access);
                self.update_template();

                let program = self.program();
                if !program.compiled_and_linked() {
                    return Ok(self.compile_failure(&program));
                }

                let list = [self.query_name(0)];
                let binding_points = program.binding_points(&list);
                if *as_int != at(&binding_points, &list[0]) {
                    return Ok(SubResult::new(
                        false,
                        self.generate_log(
                            "binding point did not match default",
                            at(&binding_points, &list[0]),
                            *as_int,
                        ),
                    ));
                }
            }
        }
        Ok(SubResult::pass())
    }

    /// The access expression summing the elements of the arrays `0..uniforms`, as the array subtests build it
    fn array_access_statement(&self, uniforms: usize, array_size: i32) -> String {
        let mut s = String::new();
        for uniform in 0..uniforms {
            for idx in 0..array_size {
                s.push_str(if (idx as usize | uniform) != 0 { " + " } else { "" });
                s.push_str(&self.build_access(&self.build_array_access(uniform, idx)));
            }
        }
        s.push_str(";\n");
        s
    }

    /// `binding_array_size`
    fn binding_array_size(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return self.binding_array_size_atomic();
        }

        for array_size in Self::make_sparse_range(self.max_array_size(), 1) {
            let decl = self.uniform_decl(
                &self.build_layout_int(self.max_bindings() - array_size - 1),
                0,
                &Self::build_array(array_size),
            );
            self.set_template_param("UNIFORM_DECL", decl);

            let access = self.array_access_statement(1, array_size);
            self.set_template_param("UNIFORM_ACCESS", access);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            let list = self.array_names(0, array_size);
            let binding_points = program.binding_points(&list);
            for idx in 0..array_size {
                let expected = (self.max_bindings() - array_size - 1) + idx;
                if expected != at(&binding_points, &list[idx as usize]) {
                    return Ok(SubResult::new(
                        false,
                        self.generate_log(
                            "binding point did not match default",
                            at(&binding_points, &list[idx as usize]),
                            expected,
                        ),
                    ));
                }
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_array_implicit`
    fn binding_array_implicit(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }

        for base_binding_point in Self::make_sparse_range(self.max_bindings(), 0) {
            let array_size = (self.max_bindings() - base_binding_point).min(4);

            let decl = self.uniform_decl(
                &self.build_layout_int(base_binding_point),
                0,
                &Self::build_array(array_size),
            );
            self.set_template_param("UNIFORM_DECL", decl);

            let access = self.array_access_statement(1, array_size);
            self.set_template_param("UNIFORM_ACCESS", access);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            let list = self.array_names(0, array_size);
            let binding_points = program.binding_points(&list);
            for idx in 0..array_size {
                if base_binding_point + idx != at(&binding_points, &list[idx as usize]) {
                    return Ok(SubResult::new(
                        false,
                        self.generate_log(
                            "binding point did not match default",
                            at(&binding_points, &list[idx as usize]),
                            base_binding_point + idx,
                        ),
                    ));
                }
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_array_multiple`
    fn binding_array_multiple(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }

        // two arrays, limit max. binding to one
        for base_binding_point in Self::make_sparse_range(self.max_bindings() - 2, 0) {
            // total distance from the binding point to the end of the range, split over two arrays that stay within the per-stage array size
            let array_size = ((self.max_bindings() - base_binding_point - 1) / 2).min(self.max_array_size() / 2);

            let decl = self.uniform_decl(
                &self.build_layout_int(base_binding_point),
                0,
                &Self::build_array(array_size),
            );
            let another_decl = self.uniform_decl(
                &self.build_layout_int(base_binding_point),
                1,
                &Self::build_array(array_size),
            );
            self.set_template_param("UNIFORM_DECL", format!("{decl}{another_decl}"));

            let access = self.array_access_statement(2, array_size);
            self.set_template_param("UNIFORM_ACCESS", access);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            for uniform in 0..2 {
                let list = self.array_names(uniform, array_size);
                let binding_points = program.binding_points(&list);
                for idx in 0..array_size {
                    if base_binding_point + idx != at(&binding_points, &list[idx as usize]) {
                        return Ok(SubResult::new(
                            false,
                            self.generate_log(
                                "binding point did not match default",
                                at(&binding_points, &list[idx as usize]),
                                base_binding_point + idx,
                            ),
                        ));
                    }
                }
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_api_update`
    fn binding_api_update(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type == Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }

        let decl = self.uniform_decl(&self.build_layout_int(1), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);

        let access = self.access_statement();
        self.set_template_param("UNIFORM_ACCESS", access);
        self.update_template();

        let program = self.program();
        if !program.compiled_and_linked() {
            return Ok(self.compile_failure(&program));
        }

        let list = [self.query_name(0)];

        let gl = self.gl();
        // SAFETY: a linked program of this case.
        unsafe { gl.use_program(program.program()) };
        program.set_binding_points(&list, self.max_bindings() - 1);
        // SAFETY: as above.
        unsafe { gl.use_program(0) };

        let binding_points = program.binding_points(&list);
        if at(&binding_points, &list[0]) != self.max_bindings() - 1 {
            return Ok(SubResult::new(
                false,
                self.generate_log(
                    "binding point did not match default",
                    at(&binding_points, &list[0]),
                    self.max_bindings() - 1,
                ),
            ));
        }
        Ok(SubResult::pass())
    }

    /// A build that has to fail; `Some` is the subtest result when it did not.
    fn expect_build_failure(&self) -> Option<SubResult> {
        let program = self.program();
        if program.compiled_and_linked() {
            Some(SubResult::new(false, program.error_log(true, &self.sources)))
        } else {
            None
        }
    }

    /// `binding_compilation_errors`
    fn binding_compilation_errors(&mut self) -> Result<SubResult, TestError> {
        // "uniform float var;" with a binding does not compile
        self.set_template_param("UNIFORM_ACCESS", format!("{}(0.0);", self.parameters.vector_type));
        self.set_template_param("UNIFORM_DECL", "layout(binding=0) uniform float tex0;".to_string());
        self.update_template();
        if let Some(result) = self.expect_build_failure() {
            return Ok(result);
        }

        // a non-constant integer expression in the binding
        let decl = self.uniform_decl(&self.build_layout("0.0"), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();
        if let Some(result) = self.expect_build_failure() {
            return Ok(result);
        }

        let decl = self.uniform_decl(&self.build_layout("-1"), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();
        if let Some(result) = self.expect_build_failure() {
            return Ok(result);
        }

        let decl = self.uniform_decl(&self.build_layout_int(self.max_bindings()), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();
        if let Some(result) = self.expect_build_failure() {
            return Ok(result);
        }

        let decl = self.uniform_decl(&self.build_layout_int(self.max_bindings()), 0, "");
        self.set_template_param("UNIFORM_DECL", decl);
        self.set_template_param("UNIFORM_ACCESS", "vec4(0.0);\n".to_string());
        self.update_template();
        if let Some(result) = self.expect_build_failure() {
            return Ok(result);
        }

        Ok(SubResult::pass())
    }

    /// `binding_link_errors`: the same uniform with different bindings in two compilation units
    fn binding_link_errors(&mut self) -> Result<SubResult, TestError> {
        if self.stage == Stage::Vertex {
            let decl = self.uniform_decl(&self.build_layout_int(1), 0, "");
            self.set_template_param_for(Stage::Vertex, "UNIFORM_DECL", decl);
            self.set_template_param_for(Stage::Vertex, "OUT_ASSIGNMENT", "fragColor =".to_string());
            let access = self.access_statement();
            self.set_template_param_for(Stage::Vertex, "UNIFORM_ACCESS", access);
            self.update_template_for(Stage::Vertex);

            let decl = self.uniform_decl(&self.build_layout_int(3), 0, "");
            self.set_template_param_for(Stage::Fragment, "UNIFORM_DECL", decl);
            let access = format!("fragColor + {};\n", self.build_access(&self.default_uniform_name(0)));
            self.set_template_param_for(Stage::Fragment, "UNIFORM_ACCESS", access);
            self.update_template_for(Stage::Fragment);

            if let Some(result) = self.expect_build_failure() {
                return Ok(result);
            }
        }
        Ok(SubResult::pass())
    }

    /// `binding_examples`: generically empty, the atomic counter spec examples for the atomic counter case
    fn binding_examples(&mut self) -> Result<SubResult, TestError> {
        if self.parameters.surface_type != Surface::AtomicCounter {
            return Ok(SubResult::pass());
        }
        if self.max_bindings() >= 4 {
            self.binding_examples_many_bindings()
        } else {
            self.binding_examples_one_binding()
        }
    }

    /// `binding_mixed_order`: empty for the samplers, the qualifier order check for the images and the atomic counters
    fn binding_mixed_order(&mut self) -> Result<SubResult, TestError> {
        let layouts: [&str; 2] = match self.parameters.surface_type {
            Surface::Image => ["layout(binding=0, rgba8) readonly", "layout(r32f, binding=0) readonly"],
            Surface::AtomicCounter => ["layout(binding=0, offset=0)", "layout(offset=0, binding=0)"],
            _ => return Ok(SubResult::pass()),
        };

        let access = self.access_statement();
        self.set_template_param("UNIFORM_ACCESS", access);

        for layout in layouts {
            let decl = self.uniform_decl(layout, 0, "");
            self.set_template_param("UNIFORM_DECL", decl);
            self.update_template();

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }
        }
        Ok(SubResult::pass())
    }

    /// `AtomicCounterLayoutBindingCase::binding_array_size`
    fn binding_array_size_atomic(&mut self) -> Result<SubResult, TestError> {
        for array_size in Self::make_sparse_range(self.max_array_size(), 1) {
            let decl = self.uniform_decl(&self.build_layout_int(0), 0, &Self::build_array(array_size));
            self.set_template_param("UNIFORM_DECL", decl);

            // a function that accesses the whole array
            let name = self.default_uniform_name(0);
            let function_block = format!(
                "float accumulate(void)\n{{\n  float acc = 0.0;\n  for(int i=0; i < {array_size} ; i++)\n    acc = float(atomicCounter({name}[i]));\n  return acc;\n}}\n"
            );
            self.set_template_param("OPTIONAL_FUNCTION_BLOCK", function_block);
            self.set_template_param("UNIFORM_ACCESS", "vec4(accumulate(), 1.0, 0.0, 1.0);\n".to_string());
            self.update_template();
            self.set_template_param("OPTIONAL_FUNCTION_BLOCK", String::new());

            let program = self.program();
            if !program.compiled_and_linked() {
                return Ok(self.compile_failure(&program));
            }

            let list = [format!("{name}[0]")];
            let binding_points = program.binding_points(&list);
            if at(&binding_points, &list[0]) != 0 {
                return Ok(SubResult::new(
                    false,
                    self.generate_log("binding point did not match default", at(&binding_points, &list[0]), 1),
                ));
            }
        }
        Ok(SubResult::pass())
    }

    /// An atomic counter example whose program has to build; `Some` is the failing subtest result.
    fn atomic_must_build(&mut self, access: String, decl: String) -> Option<SubResult> {
        self.set_template_param("UNIFORM_ACCESS", access);
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();

        let program = self.program();
        if !program.compiled_and_linked() {
            Some(self.compile_failure(&program))
        } else {
            None
        }
    }

    /// An atomic counter example whose program must not build; `Some` is the failing subtest result.
    fn atomic_must_not_build(&mut self, access: String, decl: String) -> Option<SubResult> {
        self.set_template_param("UNIFORM_ACCESS", access);
        self.set_template_param("UNIFORM_DECL", decl);
        self.update_template();

        if self.program().compiled_and_linked() {
            Some(SubResult::new(false, "should not compile".to_string()))
        } else {
            None
        }
    }

    /// The offsets of the atomic counters `atomic0..atomic{count-1}` against `expected`; `Some` is the failing subtest result.
    fn atomic_check_offsets(
        &self,
        program: &Program<'_>,
        expected: &[i32],
        logged_expected: &[i32],
    ) -> Option<SubResult> {
        let list: Vec<String> = (0..expected.len()).map(|idx| self.default_uniform_name(idx)).collect();
        let offsets = program.offsets(&list);
        for idx in 0..list.len() {
            if expected[idx] != at(&offsets, &list[idx]) {
                return Some(SubResult::new(
                    false,
                    self.generate_log(
                        &format!("offset of{}did not match requested", list[idx]),
                        at(&offsets, &list[idx]),
                        logged_expected[idx],
                    ),
                ));
            }
        }
        None
    }

    /// The two-pass examples 5 and 6 of the many-bindings variant: two counters, then three with the third one's declaration `third_decl`.
    fn atomic_pass_fail_example(&mut self, decls: String, third_decl: &str) -> Option<SubResult> {
        for pass in 0..2 {
            let access = |idx: usize| self.build_access(&self.default_uniform_name(idx));
            let access = if pass != 0 {
                format!("{}\n+{}\n+{};\n", access(0), access(1), access(2))
            } else {
                format!("{}\n+{};\n", access(0), access(1))
            };
            let mut decl = decls.clone();
            if pass != 0 {
                decl.push_str(third_decl);
            }
            self.set_template_param("UNIFORM_ACCESS", access);
            self.set_template_param("UNIFORM_DECL", decl);
            self.update_template();

            let program = self.program();
            let passed = program.compiled_and_linked();
            if pass != 0 {
                if passed {
                    return Some(SubResult::new(passed, program.error_log(false, &self.sources)));
                }
            } else if !passed {
                return Some(SubResult::new(passed, "should not compile".to_string()));
            }
        }
        None
    }

    /// `binding_examples_many_bindings`
    fn binding_examples_many_bindings(&mut self) -> Result<SubResult, TestError> {
        let max_bindings = self.get_integer(match self.stage {
            Stage::Vertex => glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS,
            Stage::Fragment => glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS,
            Stage::Compute => glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS,
        });
        let names: Vec<String> = (0..4).map(|idx| self.default_uniform_name(idx)).collect();
        let access0 = self.access_statement();

        // example 1
        {
            let decl = format!(
                "layout(binding=2, offset=4) uniform atomic_uint;\nlayout(binding=2) uniform atomic_uint {};\n",
                names[0]
            );
            if let Some(result) = self.atomic_must_build(access0.clone(), decl) {
                return Ok(result);
            }
            let program = self.program();
            let list = [names[0].clone()];
            let offsets = program.offsets(&list);
            if at(&offsets, &list[0]) != 4 {
                return Ok(SubResult::new(
                    false,
                    self.generate_log("offset did not match requested", at(&offsets, &list[0]), 1),
                ));
            }
        }

        // example 2
        if max_bindings >= 2 {
            let access = format!(
                "{}\n+{}\n+{}\n+{};\n",
                self.build_access(&names[0]),
                self.build_access(&names[1]),
                self.build_access(&names[2]),
                self.build_access(&names[3])
            );
            let decl = format!(
                "layout(binding=3, offset=4) uniform atomic_uint {};\nlayout(binding=2) uniform atomic_uint {};\nlayout(binding=3) uniform atomic_uint {};\nlayout(binding=2) uniform atomic_uint {};\n",
                names[0], names[1], names[2], names[3]
            );
            if let Some(result) = self.atomic_must_build(access, decl) {
                return Ok(result);
            }
            let program = self.program();
            if let Some(result) = self.atomic_check_offsets(&program, &[4, 0, 8, 4], &[4, 4, 4, 4]) {
                return Ok(result);
            }
        }

        // example 3
        let decl = format!(
            "layout(binding=2, offset=4) uniform atomic_uint;\nlayout(offset=8) uniform atomic_uint {};\n",
            names[0]
        );
        if let Some(result) = self.atomic_must_not_build(access0.clone(), decl) {
            return Ok(result);
        }

        // example 4
        let decl = format!("layout(offset=4) uniform atomic_uint {};\n", names[0]);
        if let Some(result) = self.atomic_must_not_build(access0, decl) {
            return Ok(result);
        }

        // examples 5 and 6: first the working example, then the one amended with an error
        if max_bindings >= 2 {
            for third_offset in [0, 2] {
                let decls = format!(
                    "layout(binding=1, offset=0) uniform atomic_uint {};\nlayout(binding=2, offset=0) uniform atomic_uint {};\n",
                    names[0], names[1]
                );
                let third_decl = format!(
                    "layout(binding=1, offset={third_offset}) uniform atomic_uint {};\n",
                    names[2]
                );
                if let Some(result) = self.atomic_pass_fail_example(decls, &third_decl) {
                    return Ok(result);
                }
            }
        }

        Ok(SubResult::pass())
    }

    /// `binding_examples_one_binding`
    fn binding_examples_one_binding(&mut self) -> Result<SubResult, TestError> {
        let names: Vec<String> = (0..4).map(|idx| self.default_uniform_name(idx)).collect();
        let access0 = self.access_statement();

        // example 1
        {
            let decl = format!(
                "layout(binding=0, offset=4) uniform atomic_uint;\nlayout(binding=0) uniform atomic_uint {};\n",
                names[0]
            );
            if let Some(result) = self.atomic_must_build(access0.clone(), decl) {
                return Ok(result);
            }
            let program = self.program();
            let list = [names[0].clone()];
            let offsets = program.offsets(&list);
            if at(&offsets, &list[0]) != 4 {
                return Ok(SubResult::new(
                    false,
                    self.generate_log("offset did not match requested", at(&offsets, &list[0]), 1),
                ));
            }
        }

        // example 2
        {
            let access = format!(
                "{}\n+{}\n+{}\n+{};\n",
                self.build_access(&names[0]),
                self.build_access(&names[1]),
                self.build_access(&names[2]),
                self.build_access(&names[3])
            );
            let decl = format!(
                "layout(binding=0, offset=4) uniform atomic_uint {};\nlayout(binding=0) uniform atomic_uint {};\nlayout(binding=0) uniform atomic_uint {};\nlayout(binding=0) uniform atomic_uint {};\n",
                names[0], names[1], names[2], names[3]
            );
            if let Some(result) = self.atomic_must_build(access, decl) {
                return Ok(result);
            }
            let program = self.program();
            if let Some(result) = self.atomic_check_offsets(&program, &[4, 8, 12, 16], &[4, 8, 12, 16]) {
                return Ok(result);
            }
        }

        // example 3
        let decl = format!(
            "layout(binding=0, offset=4) uniform atomic_uint;\nlayout(offset=8) uniform atomic_uint {};\n",
            names[0]
        );
        if let Some(result) = self.atomic_must_not_build(access0.clone(), decl) {
            return Ok(result);
        }

        // example 4
        let decl = format!("layout(offset=4) uniform atomic_uint {};\n", names[0]);
        if let Some(result) = self.atomic_must_not_build(access0, decl) {
            return Ok(result);
        }

        // examples 5 and 6: first the working example, then the one amended with an error
        for second_offset in [0, 2] {
            let decls = format!("layout(binding=0, offset=0) uniform atomic_uint {};\n", names[0]);
            let second_decl = format!(
                "layout(binding=0, offset={second_offset}) uniform atomic_uint {};\n",
                names[1]
            );
            if let Some(result) = self.atomic_pass_fail_example_one(decls, &second_decl) {
                return Ok(result);
            }
        }

        Ok(SubResult::pass())
    }

    /// The two-pass examples 5 and 6 of the one-binding variant: a single counter, then two with the second one's declaration `second_decl`.
    fn atomic_pass_fail_example_one(&mut self, decls: String, second_decl: &str) -> Option<SubResult> {
        for pass in 0..2 {
            let access = if pass != 0 {
                format!(
                    "{}\n+{};\n",
                    self.build_access(&self.default_uniform_name(0)),
                    self.build_access(&self.default_uniform_name(1))
                )
            } else {
                format!("{};\n", self.build_access(&self.default_uniform_name(0)))
            };
            let mut decl = decls.clone();
            if pass != 0 {
                decl.push_str(second_decl);
            }
            self.set_template_param("UNIFORM_ACCESS", access);
            self.set_template_param("UNIFORM_DECL", decl);
            self.update_template();

            let program = self.program();
            let passed = program.compiled_and_linked();
            if pass != 0 {
                if passed {
                    return Some(SubResult::new(passed, program.error_log(false, &self.sources)));
                }
            } else if !passed {
                return Some(SubResult::new(passed, "should not compile".to_string()));
            }
        }
        None
    }
}

struct LayoutBindingCase {
    name: String,
    stage: Stage,
    parameters: Parameters,
    glsl_version: GlslVersion,
}

impl TestCase for LayoutBindingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut runner = Runner {
            context,
            stage: self.stage,
            parameters: self.parameters,
            glsl_version: self.glsl_version,
            sources: [String::new(), String::new(), String::new()],
            args: [HashMap::new(), HashMap::new(), HashMap::new()],
            texture_id: 0,
            buffer_id: 0,
        };

        if runner.max_array_size() <= 0 {
            log::info!("This test was not run as minimum requirements were not met.");
            return Err(TestError::NotSupported("NotSupported".to_string()));
        }

        let outcome = (|| -> Result<bool, TestError> {
            runner.init_texture()?;
            runner.setup_test()?;

            let tests: [(&str, SubTest<'_>); 13] = [
                ("binding_basic_default", Runner::binding_basic_default),
                ("binding_basic_explicit", Runner::binding_basic_explicit),
                ("binding_basic_multiple", Runner::binding_basic_multiple),
                ("binding_basic_render", Runner::binding_basic_render),
                ("binding_integer_constant", Runner::binding_integer_constant),
                ("binding_array_size", Runner::binding_array_size),
                ("binding_array_implicit", Runner::binding_array_implicit),
                ("binding_array_multiple", Runner::binding_array_multiple),
                ("binding_api_update", Runner::binding_api_update),
                ("binding_compilation_errors", Runner::binding_compilation_errors),
                ("binding_link_errors", Runner::binding_link_errors),
                ("binding_examples", Runner::binding_examples),
                ("binding_mixed_order", Runner::binding_mixed_order),
            ];

            let mut passed = true;
            for (name, test) in tests {
                // every subtest starts from clean templates to avoid bleeding
                runner.reset_contexts();

                let result = test(&mut runner)?;
                if !result.passed {
                    log::info!("{name}\n{}", result.reason);
                }
                passed &= result.passed;
            }
            Ok(passed)
        })();
        runner.teardown();

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `LayoutBindingTests::init`; the name is `createTestName`.
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("layout_binding");
    for (stage_name, stage) in [
        ("ComputeShader", Stage::Compute),
        ("FragmentShader", Stage::Fragment),
        ("VertexShader", Stage::Vertex),
    ] {
        for parameters in [
            SAMPLER_2D,
            SAMPLER_3D,
            SAMPLER_2D_ARRAY,
            IMAGE_2D,
            ATOMIC_UINT,
            BLOCK,
            BUFFER,
        ] {
            let name = format!(
                "{}_layout_binding_{}_{stage_name}",
                parameters.uniform_type, parameters.access_function
            );
            group.add_child(Box::new(LayoutBindingCase {
                name,
                stage,
                parameters,
                glsl_version,
            }) as Box<dyn TestCase>);
        }
    }
    group
}
