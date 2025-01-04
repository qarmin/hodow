// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramInterfaceDefinition.cpp
//   modules/gles31/functional/es31fProgramInterfaceDefinition.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `Program` owns its shaders and
// their struct types through raw pointers and frees them in its destructor; here they are
// owned values, so `addShader` hands back a `&mut Shader` and the struct types live in the
// `Arc<StructType>` the `VarType` already holds.
//
// The stage-order table drops upstream's ray-tracing and mesh stages - this is the ES
// module, and `glu::ShaderType` here has only the six stages ES has.

use crate::glu::shader_util::DataType;
use crate::glu::var_type::{InterfaceBlock, Interpolation, Storage, VarType, VariableDeclaration};
use crate::glu::{GlslVersion, ShaderType};

/// `ProgramInterface`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ProgramInterface {
    Uniform,
    UniformBlock,
    AtomicCounterBuffer,
    ProgramInput,
    ProgramOutput,
    TransformFeedbackVarying,
    BufferVariable,
    ShaderStorageBlock,
}

/// `s_shaderStageOrder` - the pipeline order, which is what "first"/"last stage" mean.
const SHADER_STAGE_ORDER: [ShaderType; 6] = [
    ShaderType::Compute,
    ShaderType::Vertex,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Geometry,
    ShaderType::Fragment,
];

/// `getShaderStageIndex`
fn shader_stage_index(stage: ShaderType) -> Option<usize> {
    SHADER_STAGE_ORDER.iter().position(|&s| s == stage)
}

/// `ProgramInterfaceDefinition::DefaultBlock`
#[derive(Clone, Default, Debug)]
pub struct DefaultBlock {
    pub variables: Vec<VariableDeclaration>,
    pub interface_blocks: Vec<InterfaceBlock>,
}

/// `ProgramInterfaceDefinition::Shader`
#[derive(Clone, Debug)]
pub struct Shader {
    shader_type: ShaderType,
    version: GlslVersion,
    pub default_block: DefaultBlock,
}

/// `containsMatchingSubtype(const glu::VarType&, ...)`
fn contains_matching_subtype(var_type: &VarType, predicate: fn(DataType) -> bool) -> bool {
    match var_type {
        VarType::Basic(basic_type, _) => predicate(*basic_type),
        VarType::Array(element, _) => contains_matching_subtype(element, predicate),
        VarType::Struct(struct_ptr) => struct_ptr
            .members
            .iter()
            .any(|m| contains_matching_subtype(&m.ty, predicate)),
    }
}

/// `containsMatchingSubtype(const std::vector<glu::VariableDeclaration>&, ...)`
fn decls_contain_matching_subtype(decls: &[VariableDeclaration], predicate: fn(DataType) -> bool) -> bool {
    decls.iter().any(|d| contains_matching_subtype(&d.var_type, predicate))
}

/// `isOpaqueType`
fn is_opaque_type(data_type: DataType) -> bool {
    data_type.is_atomic_counter() || data_type.is_image() || data_type.is_sampler()
}

/// `isIllegalVertexInput` - booleans, opaque types, arrays and structs are not allowed.
fn is_illegal_vertex_input(var_type: &VarType) -> bool {
    match var_type {
        VarType::Basic(basic_type, _) => basic_type.is_bool_or_bvec(),
        _ => true,
    }
}

/// `isIllegalVertexOutput` - booleans, opaque types, arrays of arrays, arrays of structs,
/// an array in a struct and a struct in a struct are all out.
fn is_illegal_vertex_output(var_type: &VarType, inside_a_struct: bool, inside_an_array: bool) -> bool {
    match var_type {
        VarType::Basic(basic_type, _) => {
            let opaque = !basic_type.is_scalar() && !basic_type.is_vector() && !basic_type.is_matrix();
            basic_type.is_bool_or_bvec() || opaque
        }
        VarType::Array(element, _) => {
            if inside_an_array || inside_a_struct {
                return true;
            }
            is_illegal_vertex_output(element, inside_a_struct, true)
        }
        VarType::Struct(struct_ptr) => {
            if inside_an_array || inside_a_struct {
                return true;
            }
            struct_ptr
                .members
                .iter()
                .any(|m| is_illegal_vertex_output(&m.ty, true, inside_an_array))
        }
    }
}

/// `isIllegalFragmentInput`
fn is_illegal_fragment_input(var_type: &VarType) -> bool {
    is_illegal_vertex_output(var_type, false, false)
}

/// `isIllegalFragmentOutput` - as above, plus matrices, and structs are out entirely.
fn is_illegal_fragment_output(var_type: &VarType, inside_an_array: bool) -> bool {
    match var_type {
        VarType::Basic(basic_type, _) => {
            let opaque = !basic_type.is_scalar() && !basic_type.is_vector() && !basic_type.is_matrix();
            basic_type.is_bool_or_bvec() || opaque || basic_type.is_matrix()
        }
        VarType::Array(element, _) => {
            if inside_an_array {
                return true;
            }
            is_illegal_fragment_output(element, true)
        }
        VarType::Struct(_) => true,
    }
}

/// `isTypeIntegerOrContainsIntegers`
fn is_type_integer_or_contains_integers(var_type: &VarType) -> bool {
    match var_type {
        VarType::Basic(basic_type, _) => basic_type.is_int_or_ivec() || basic_type.is_uint_or_uvec(),
        VarType::Array(element, _) => is_type_integer_or_contains_integers(element),
        VarType::Struct(struct_ptr) => struct_ptr
            .members
            .iter()
            .any(|m| is_type_integer_or_contains_integers(&m.ty)),
    }
}

impl Shader {
    fn new(shader_type: ShaderType, version: GlslVersion) -> Self {
        Self {
            shader_type,
            version,
            default_block: DefaultBlock::default(),
        }
    }

    pub fn shader_type(&self) -> ShaderType {
        self.shader_type
    }

    pub fn version(&self) -> GlslVersion {
        self.version
    }

    /// `Shader::isValid`
    pub fn is_valid(&self) -> bool {
        for variable in &self.default_block.variables {
            // atomic declaration in the default block without binding
            if variable.layout.binding.is_none()
                && contains_matching_subtype(&variable.var_type, DataType::is_atomic_counter)
            {
                return false;
            }

            // atomic declaration in a struct
            if variable.var_type.is_struct_type()
                && contains_matching_subtype(&variable.var_type, DataType::is_atomic_counter)
            {
                return false;
            }

            // Unsupported layout qualifiers
            if variable.layout.matrix_order.is_some() {
                return false;
            }

            if contains_matching_subtype(&variable.var_type, DataType::is_sampler) {
                // A sampler may carry a location and a binding and nothing else.
                let allowed = crate::glu::Layout {
                    location: variable.layout.location,
                    binding: variable.layout.binding,
                    ..crate::glu::Layout::default()
                };
                if variable.layout != allowed {
                    return false;
                }
            }
        }

        for block in &self.default_block.interface_blocks {
            // ES31 disallows interface block array arrays
            if block.dimensions.len() > 1 {
                return false;
            }

            // Interface block arrays must have instance name
            if !block.dimensions.is_empty() && block.instance_name.is_empty() {
                return false;
            }

            // Opaque types in interface block
            if decls_contain_matching_subtype(&block.variables, is_opaque_type) {
                return false;
            }
        }

        match self.shader_type {
            ShaderType::Vertex => {
                for variable in &self.default_block.variables {
                    if variable.storage == Some(Storage::In) && is_illegal_vertex_input(&variable.var_type) {
                        return false;
                    }
                    if variable.storage == Some(Storage::Out)
                        && is_illegal_vertex_output(&variable.var_type, false, false)
                    {
                        return false;
                    }
                    if variable.storage == Some(Storage::Out)
                        && variable.interpolation != Some(Interpolation::Flat)
                        && is_type_integer_or_contains_integers(&variable.var_type)
                    {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if matches!(block.storage, Some(Storage::In | Storage::PatchIn | Storage::PatchOut)) {
                        return false;
                    }
                }
            }

            ShaderType::Fragment => {
                for variable in &self.default_block.variables {
                    if variable.storage == Some(Storage::In) && is_illegal_fragment_input(&variable.var_type) {
                        return false;
                    }
                    if variable.storage == Some(Storage::In)
                        && variable.interpolation != Some(Interpolation::Flat)
                        && is_type_integer_or_contains_integers(&variable.var_type)
                    {
                        return false;
                    }
                    if variable.storage == Some(Storage::Out) && is_illegal_fragment_output(&variable.var_type, false) {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if matches!(block.storage, Some(Storage::PatchIn | Storage::Out | Storage::PatchOut)) {
                        return false;
                    }
                }
            }

            ShaderType::Compute => {
                for variable in &self.default_block.variables {
                    if matches!(
                        variable.storage,
                        Some(Storage::In | Storage::PatchIn | Storage::Out | Storage::PatchOut)
                    ) {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if matches!(
                        block.storage,
                        Some(Storage::In | Storage::PatchIn | Storage::Out | Storage::PatchOut)
                    ) {
                        return false;
                    }
                }
            }

            ShaderType::Geometry => {
                for variable in &self.default_block.variables {
                    if matches!(variable.storage, Some(Storage::PatchIn | Storage::PatchOut)) {
                        return false;
                    }
                    // arrayed input
                    if variable.storage == Some(Storage::In) && !variable.var_type.is_array_type() {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if matches!(block.storage, Some(Storage::PatchIn | Storage::PatchOut)) {
                        return false;
                    }
                    // arrayed input
                    if block.storage == Some(Storage::In) && block.dimensions.is_empty() {
                        return false;
                    }
                }
            }

            ShaderType::TessControl => {
                for variable in &self.default_block.variables {
                    if variable.storage == Some(Storage::PatchIn) {
                        return false;
                    }
                    // arrayed input
                    if variable.storage == Some(Storage::In) && !variable.var_type.is_array_type() {
                        return false;
                    }
                    // arrayed output
                    if variable.storage == Some(Storage::Out) && !variable.var_type.is_array_type() {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if block.storage == Some(Storage::PatchIn) {
                        return false;
                    }
                    // arrayed input
                    if block.storage == Some(Storage::In) && block.dimensions.is_empty() {
                        return false;
                    }
                    // arrayed output
                    if block.storage == Some(Storage::Out) && block.dimensions.is_empty() {
                        return false;
                    }
                }
            }

            ShaderType::TessEvaluation => {
                for variable in &self.default_block.variables {
                    if variable.storage == Some(Storage::PatchOut) {
                        return false;
                    }
                    // arrayed input
                    if variable.storage == Some(Storage::In) && !variable.var_type.is_array_type() {
                        return false;
                    }
                }
                for block in &self.default_block.interface_blocks {
                    if block.storage == Some(Storage::PatchOut) {
                        return false;
                    }
                    // arrayed input
                    if block.storage == Some(Storage::In) && block.dimensions.is_empty() {
                        return false;
                    }
                }
            }
        }

        true
    }
}

/// `ProgramInterfaceDefinition::Program`
#[derive(Clone, Default, Debug)]
pub struct Program {
    separable: bool,
    shaders: Vec<Shader>,
    xfb_varyings: Vec<String>,
    xfb_mode: u32,
    geo_num_output_vertices: u32,
    tess_num_output_vertices: u32,
}

impl Program {
    pub fn new() -> Self {
        Self::default()
    }

    /// `Program::addShader`
    pub fn add_shader(&mut self, shader_type: ShaderType, version: GlslVersion) -> &mut Shader {
        self.shaders.push(Shader::new(shader_type, version));
        self.shaders.last_mut().expect("just pushed")
    }

    pub fn set_separable(&mut self, separable: bool) {
        self.separable = separable;
    }

    pub fn is_separable(&self) -> bool {
        self.separable
    }

    pub fn shaders(&self) -> &[Shader] {
        &self.shaders
    }

    pub fn shaders_mut(&mut self) -> &mut [Shader] {
        &mut self.shaders
    }

    /// `Program::getFirstStage` - `None` where upstream answers `SHADERTYPE_LAST`.
    pub fn first_stage(&self) -> Option<ShaderType> {
        self.shaders
            .iter()
            .filter_map(|s| shader_stage_index(s.shader_type))
            .min()
            .map(|ndx| SHADER_STAGE_ORDER[ndx])
    }

    /// `Program::getLastStage`
    pub fn last_stage(&self) -> Option<ShaderType> {
        self.shaders
            .iter()
            .filter_map(|s| shader_stage_index(s.shader_type))
            .max()
            .map(|ndx| SHADER_STAGE_ORDER[ndx])
    }

    /// `Program::hasStage`
    pub fn has_stage(&self, stage: ShaderType) -> bool {
        self.shaders.iter().any(|s| s.shader_type == stage)
    }

    pub fn add_transform_feedback_varying(&mut self, var_name: &str) {
        self.xfb_varyings.push(var_name.to_string());
    }

    pub fn transform_feedback_varyings(&self) -> &[String] {
        &self.xfb_varyings
    }

    pub fn set_transform_feedback_mode(&mut self, mode: u32) {
        self.xfb_mode = mode;
    }

    pub fn transform_feedback_mode(&self) -> u32 {
        self.xfb_mode
    }

    pub fn geometry_num_output_vertices(&self) -> u32 {
        self.geo_num_output_vertices
    }

    pub fn set_geometry_num_output_vertices(&mut self, vertices: u32) {
        self.geo_num_output_vertices = vertices;
    }

    pub fn tessellation_num_output_patch_vertices(&self) -> u32 {
        self.tess_num_output_vertices
    }

    pub fn set_tessellation_num_output_patch_vertices(&mut self, vertices: u32) {
        self.tess_num_output_vertices = vertices;
    }

    /// `Program::isValid`
    pub fn is_valid(&self) -> bool {
        use crate::gles31::functional::program_interface_definition_util::{
            VariableSearchFilter, find_program_variable_path_by_path_name, program_transform_feedback_stage,
        };

        // Every shader in this port is an ES one, so upstream's `isOpenGLES` is always true.
        if self.shaders.is_empty() {
            return false;
        }

        if self.shaders.iter().any(|s| !s.is_valid()) {
            return false;
        }

        // same version
        if self.shaders.iter().any(|s| s.version != self.shaders[0].version) {
            return false;
        }

        let compute_present = self.has_stage(ShaderType::Compute);
        let vertex_present = self.has_stage(ShaderType::Vertex);
        let fragment_present = self.has_stage(ShaderType::Fragment);
        let tess_control_present = self.has_stage(ShaderType::TessControl);
        let tess_eval_present = self.has_stage(ShaderType::TessEvaluation);
        let geometry_present = self.has_stage(ShaderType::Geometry);

        // compute present -> no other stages present
        let non_compute_present =
            vertex_present || fragment_present || tess_control_present || tess_eval_present || geometry_present;
        if compute_present && non_compute_present {
            return false;
        }

        // must contain both vertex and fragment shaders
        if !compute_present && !self.separable && (!vertex_present || !fragment_present) {
            return false;
        }

        // tess.Eval present <=> tess.Control present
        if !self.separable && tess_eval_present != tess_control_present {
            return false;
        }

        if (self.tess_num_output_vertices != 0) != (tess_control_present || tess_eval_present) {
            return false;
        }

        if (self.geo_num_output_vertices != 0) != geometry_present {
            return false;
        }

        for varying in &self.xfb_varyings {
            // user-defined
            if varying.starts_with("gl_") {
                continue;
            }

            let Some(stage) = program_transform_feedback_stage(self) else {
                return false;
            };
            let filter = VariableSearchFilter::shader_type_storage(stage, Storage::Out);
            let Some(path) = find_program_variable_path_by_path_name(self, varying, &filter) else {
                return false;
            };
            let Some(var_type) = path.last().and_then(|c| c.variable_type()) else {
                return false;
            };

            // Khronos bug #12787 disallowed capturing whole structs in OpenGL ES.
            if var_type.is_struct_type() {
                return false;
            }
        }

        true
    }
}
