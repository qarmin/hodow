// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramInterfaceDefinitionUtil.cpp
//   modules/gles31/functional/es31fProgramInterfaceDefinitionUtil.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `VariablePathComponent` is an owned enum
// rather than a tagged union of borrowed pointers - these definitions are small, and a
// borrowed path would have to be threaded through every caller for nothing. Upstream's
// `traverseVariablePath` runs `glu::VarTokenizer` over the tail of the name; the same walk
// here is a small string parser, which is what `glu::parse_type_path` already does, except
// that a malformed path has to answer "no such variable" rather than panic.
//
// The accumulator templates (`accumulateShader`, `accumulateComplexType` and the filter
// functor classes) become closures, since that is all upstream uses them as.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt::Write as _;

use crate::gles31::functional::program_interface_definition::{DefaultBlock, Program, ProgramInterface, Shader};
use crate::glu::shader_util::DataType;
use crate::glu::var_type::{
    InterfaceBlock, MatrixOrder, Storage, StructType, UNSIZED_ARRAY, VarType, VariableDeclaration, memory_access,
    parse_variable_name,
};
use crate::glu::{ProgramSources, ShaderType, declare_var, indent};
use crate::glw;

/// `ResourceNameGenerationFlag`
pub mod resource_name_flag {
    pub const DEFAULT: u32 = 0x0;
    pub const TOP_LEVEL_BUFFER_VARIABLE: u32 = 0x1;
    pub const TRANSFORM_FEEDBACK_VARIABLE: u32 = 0x2;
}

/// The bit a `ShaderType` takes in a `VariableSearchFilter` mask.
fn shader_type_bit(shader_type: ShaderType) -> u32 {
    1 << (shader_type as u32)
}

/// The bit a `Storage` takes in a `VariableSearchFilter` mask.
fn storage_bit(storage: Storage) -> u32 {
    1 << (storage as u32)
}

/// `ProgramInterfaceDefinition::VariableSearchFilter`
#[derive(Clone, Copy, Debug)]
pub struct VariableSearchFilter {
    shader_type_bits: u32,
    storage_bits: u32,
}

impl Default for VariableSearchFilter {
    fn default() -> Self {
        Self {
            shader_type_bits: u32::MAX,
            storage_bits: u32::MAX,
        }
    }
}

impl VariableSearchFilter {
    /// `createShaderTypeFilter`
    pub fn shader_type(shader_type: ShaderType) -> Self {
        Self {
            shader_type_bits: shader_type_bit(shader_type),
            ..Self::default()
        }
    }

    /// `createStorageFilter`
    pub fn storage(storage: Storage) -> Self {
        Self {
            storage_bits: storage_bit(storage),
            ..Self::default()
        }
    }

    /// `createShaderTypeStorageFilter`
    pub fn shader_type_storage(shader_type: ShaderType, storage: Storage) -> Self {
        Self::shader_type(shader_type).and(Self::storage(storage))
    }

    /// `logicalOr`
    pub fn or(self, other: Self) -> Self {
        Self {
            shader_type_bits: self.shader_type_bits | other.shader_type_bits,
            storage_bits: self.storage_bits | other.storage_bits,
        }
    }

    /// `logicalAnd`
    pub fn and(self, other: Self) -> Self {
        Self {
            shader_type_bits: self.shader_type_bits & other.shader_type_bits,
            storage_bits: self.storage_bits & other.storage_bits,
        }
    }

    pub fn matches_shader(&self, shader: &Shader) -> bool {
        self.shader_type_bits & shader_type_bit(shader.shader_type()) != 0
    }

    pub fn matches_variable(&self, variable: &VariableDeclaration) -> bool {
        variable
            .storage
            .is_some_and(|s| self.storage_bits & storage_bit(s) != 0)
    }

    pub fn matches_block(&self, block: &InterfaceBlock) -> bool {
        block.storage.is_some_and(|s| self.storage_bits & storage_bit(s) != 0)
    }

    pub fn shader_type_bits(&self) -> u32 {
        self.shader_type_bits
    }

    pub fn storage_bits(&self) -> u32 {
        self.storage_bits
    }
}

/// `ProgramInterfaceDefinition::VariablePathComponent`
#[derive(Clone, Debug)]
pub enum VariablePathComponent {
    /// `struct_member` is the index this type has in the struct one step up the path, and
    /// `None` for an array element or for the declaration's own type. Upstream has no such
    /// field: it compares `&member.getType()` against the path component by *pointer*, and
    /// an owned path cannot do that - two members of the same type would compare equal and
    /// the location walk would stop at the wrong one.
    Type {
        ty: VarType,
        struct_member: Option<usize>,
    },
    InterfaceBlock(InterfaceBlock),
    Declaration(VariableDeclaration),
}

impl VariablePathComponent {
    pub fn is_variable_type(&self) -> bool {
        matches!(self, Self::Type { .. })
    }

    pub fn is_interface_block(&self) -> bool {
        matches!(self, Self::InterfaceBlock(_))
    }

    pub fn is_declaration(&self) -> bool {
        matches!(self, Self::Declaration(_))
    }

    pub fn variable_type(&self) -> Option<&VarType> {
        match self {
            Self::Type { ty, .. } => Some(ty),
            _ => None,
        }
    }

    /// The index this component has in the struct one step up the path, if that is how it
    /// was reached.
    pub fn struct_member_index(&self) -> Option<usize> {
        match self {
            Self::Type { struct_member, .. } => *struct_member,
            _ => None,
        }
    }

    pub fn interface_block(&self) -> Option<&InterfaceBlock> {
        match self {
            Self::InterfaceBlock(block) => Some(block),
            _ => None,
        }
    }

    pub fn declaration(&self) -> Option<&VariableDeclaration> {
        match self {
            Self::Declaration(decl) => Some(decl),
            _ => None,
        }
    }
}

/// `ProgramInterfaceDefinition::ShaderResourceUsage`
#[derive(Clone, Copy, Default, Debug)]
pub struct ShaderResourceUsage {
    pub num_inputs: i32,
    pub num_input_vectors: i32,
    pub num_input_components: i32,
    pub num_outputs: i32,
    pub num_output_vectors: i32,
    pub num_output_components: i32,
    pub num_patch_input_components: i32,
    pub num_patch_output_components: i32,
    pub num_default_block_uniform_components: i32,
    pub num_combined_uniform_components: i32,
    pub num_uniform_vectors: i32,
    pub num_samplers: i32,
    pub num_images: i32,
    pub num_atomic_counter_buffers: i32,
    pub num_atomic_counters: i32,
    pub num_uniform_blocks: i32,
    pub num_shader_storage_blocks: i32,
}

/// `ProgramInterfaceDefinition::ProgramResourceUsage`
#[derive(Clone, Copy, Debug)]
pub struct ProgramResourceUsage {
    pub uniform_buffer_max_binding: i32,
    pub uniform_buffer_max_size: i32,
    pub num_uniform_blocks: i32,
    pub num_combined_vertex_uniform_components: i32,
    pub num_combined_fragment_uniform_components: i32,
    pub num_combined_geometry_uniform_components: i32,
    pub num_combined_tess_control_uniform_components: i32,
    pub num_combined_tess_eval_uniform_components: i32,
    pub shader_storage_buffer_max_binding: i32,
    pub shader_storage_buffer_max_size: i32,
    pub num_shader_storage_blocks: i32,
    pub num_varying_components: i32,
    pub num_varying_vectors: i32,
    pub num_combined_samplers: i32,
    pub atomic_counter_buffer_max_binding: i32,
    pub atomic_counter_buffer_max_size: i32,
    pub num_atomic_counter_buffers: i32,
    pub num_atomic_counters: i32,
    pub max_image_binding: i32,
    pub num_combined_images: i32,
    pub num_combined_output_resources: i32,
    pub num_xfb_interleaved_components: i32,
    pub num_xfb_separate_attribs: i32,
    pub num_xfb_separate_components: i32,
    pub fragment_output_max_binding: i32,
}

impl Default for ProgramResourceUsage {
    fn default() -> Self {
        // \note the four `max binding` fields start at -1 rather than 0: a max binding is an
        // inclusive upper bound, so -1 is how "no bindings at all" is expressed.
        Self {
            uniform_buffer_max_binding: -1,
            uniform_buffer_max_size: 0,
            num_uniform_blocks: 0,
            num_combined_vertex_uniform_components: 0,
            num_combined_fragment_uniform_components: 0,
            num_combined_geometry_uniform_components: 0,
            num_combined_tess_control_uniform_components: 0,
            num_combined_tess_eval_uniform_components: 0,
            shader_storage_buffer_max_binding: -1,
            shader_storage_buffer_max_size: 0,
            num_shader_storage_blocks: 0,
            num_varying_components: 0,
            num_varying_vectors: 0,
            num_combined_samplers: 0,
            atomic_counter_buffer_max_binding: -1,
            atomic_counter_buffer_max_size: 0,
            num_atomic_counter_buffers: 0,
            num_atomic_counters: 0,
            max_image_binding: -1,
            num_combined_images: 0,
            num_combined_output_resources: 0,
            num_xfb_interleaved_components: 0,
            num_xfb_separate_attribs: 0,
            num_xfb_separate_components: 0,
            fragment_output_max_binding: -1,
        }
    }
}

/// `incrementMultiDimensionIndex` - answers false once the index wraps back to all zeros.
fn increment_multi_dimension_index(index: &mut [i32], dimensions: &[i32]) -> bool {
    let mut ndx = index.len() as isize - 1;

    while ndx >= 0 {
        index[ndx as usize] += 1;
        if index[ndx as usize] == dimensions[ndx as usize] {
            index[ndx as usize] = 0;
            ndx -= 1;
        } else {
            break;
        }
    }

    ndx != -1
}

/// Every index of a multi-dimensional interface block array, in upstream's order.
fn multi_dimension_indices(dimensions: &[i32]) -> Vec<Vec<i32>> {
    let mut index = vec![0; dimensions.len()];
    let mut all = vec![index.clone()];

    while increment_multi_dimension_index(&mut index, dimensions) {
        all.push(index.clone());
    }

    all
}

/// `programContainsIOBlocks`
pub fn program_contains_io_blocks(program: &Program) -> bool {
    program.shaders().iter().any(shader_contains_io_blocks)
}

/// `shaderContainsIOBlocks`
pub fn shader_contains_io_blocks(shader: &Shader) -> bool {
    shader.default_block.interface_blocks.iter().any(|b| {
        matches!(
            b.storage,
            Some(Storage::In | Storage::Out | Storage::PatchIn | Storage::PatchOut)
        )
    })
}

/// `getProgramTransformFeedbackStage` - the last stage that can produce varyings.
pub fn program_transform_feedback_stage(program: &Program) -> Option<ShaderType> {
    [ShaderType::Geometry, ShaderType::TessEvaluation, ShaderType::Vertex]
        .into_iter()
        .find(|&stage| program.has_stage(stage))
}

/// `generateVariableTypeResourceNames`
pub fn generate_variable_type_resource_names(resources: &mut Vec<String>, name: &str, ty: &VarType, flags: u32) {
    // remove top-level flag from children
    let child_flags = flags & !resource_name_flag::TOP_LEVEL_BUFFER_VARIABLE;

    match ty {
        VarType::Basic(..) => resources.push(name.to_string()),

        VarType::Struct(struct_ptr) => {
            for member in &struct_ptr.members {
                generate_variable_type_resource_names(
                    resources,
                    &format!("{name}.{}", member.name),
                    &member.ty,
                    child_flags,
                );
            }
        }

        VarType::Array(element, size) => {
            // Bottom-level arrays of basic types of a transform feedback variable produce
            // only the first element, and without the trailing "[0]".
            if element.is_basic_type() && flags & resource_name_flag::TRANSFORM_FEEDBACK_VARIABLE != 0 {
                resources.push(name.to_string());
            }
            // Bottom-level arrays of basic types and SSBO top-level arrays of any type
            // produce only the first element.
            else if element.is_basic_type() || flags & resource_name_flag::TOP_LEVEL_BUFFER_VARIABLE != 0 {
                generate_variable_type_resource_names(resources, &format!("{name}[0]"), element, child_flags);
            }
            // Other arrays of aggregate types are expanded.
            else {
                for ndx in 0..*size {
                    generate_variable_type_resource_names(resources, &format!("{name}[{ndx}]"), element, child_flags);
                }
            }
        }
    }
}

// Program source generation

/// `getShaderExtensionDeclarations`
fn shader_extension_declarations(shader: &Shader) -> String {
    let mut extensions: Vec<&str> = Vec::new();

    match shader.shader_type() {
        ShaderType::Geometry => extensions.push("GL_EXT_geometry_shader"),
        ShaderType::TessControl | ShaderType::TessEvaluation => extensions.push("GL_EXT_tessellation_shader"),
        _ => {}
    }

    if shader_contains_io_blocks(shader) {
        extensions.push("GL_EXT_shader_io_blocks");
    }

    extensions
        .iter()
        .map(|e| format!("#extension {e} : require\n"))
        .collect()
}

/// `getShaderTypeDeclarations` - the `isCoreGL` half never applies here, this port only
/// ever builds ES shaders.
fn shader_type_declarations(program: &Program, shader: &Shader) -> String {
    match shader.shader_type() {
        ShaderType::Vertex | ShaderType::Fragment => String::new(),
        ShaderType::Geometry => format!(
            "layout(points) in;\nlayout(points, max_vertices={}) out;\n",
            program.geometry_num_output_vertices()
        ),
        ShaderType::TessControl => format!(
            "layout(vertices={}) out;\n",
            program.tessellation_num_output_patch_vertices()
        ),
        ShaderType::TessEvaluation => "layout(triangles, point_mode) in;\n".to_string(),
        ShaderType::Compute => "layout(local_size_x=1) in;\n".to_string(),
    }
}

/// `collectNamedStructureDefinitions` - post order, and a struct type that is shared by
/// several variables is only emitted once.
fn collect_named_structure_definitions(dst: &mut Vec<std::sync::Arc<StructType>>, ty: &VarType) {
    match ty {
        VarType::Basic(..) => {}
        VarType::Array(element, _) => collect_named_structure_definitions(dst, element),
        VarType::Struct(struct_ptr) => {
            if struct_ptr.has_type_name()
                && dst
                    .iter()
                    .any(|s| s.has_type_name() && s.type_name == struct_ptr.type_name)
            {
                // identical type has been added already, and so have its members
                return;
            }

            // Add types of members first
            for member in &struct_ptr.members {
                collect_named_structure_definitions(dst, &member.ty);
            }

            dst.push(std::sync::Arc::clone(struct_ptr));
        }
    }
}

/// `writeStructureDefinitions`
fn write_structure_definitions(buf: &mut String, default_block: &DefaultBlock) {
    let mut named_structs = Vec::new();

    for variable in &default_block.variables {
        collect_named_structure_definitions(&mut named_structs, &variable.var_type);
    }
    for block in &default_block.interface_blocks {
        for variable in &block.variables {
            collect_named_structure_definitions(&mut named_structs, &variable.var_type);
        }
    }

    for struct_type in &named_structs {
        let _ = write!(buf, "struct {}\n{{\n", struct_type.type_name);
        for member in &struct_type.members {
            let _ = writeln!(buf, "{}{};", indent(1), declare_var(&member.ty, &member.name, 1));
        }
        buf.push_str("};\n");
    }

    if !named_structs.is_empty() {
        buf.push('\n');
    }
}

/// `writeInterfaceBlock`
fn write_interface_block(buf: &mut String, block: &InterfaceBlock) {
    let _ = write!(buf, "{}", block.layout);
    if !block.layout.is_default() {
        buf.push(' ');
    }

    let _ = write!(
        buf,
        "{} {}\n{{\n",
        block
            .storage
            .expect("an interface block always has a storage qualifier")
            .name(),
        block.interface_name
    );

    for variable in &block.variables {
        let _ = writeln!(buf, "{}{};", indent(1), variable);
    }

    buf.push('}');

    if !block.instance_name.is_empty() {
        let _ = write!(buf, " {}", block.instance_name);
    }

    for dimension in &block.dimensions {
        let _ = write!(buf, "[{dimension}]");
    }

    buf.push_str(";\n\n");
}

/// `isReadableInterface`
fn is_readable_interface(block: &InterfaceBlock) -> bool {
    matches!(block.storage, Some(Storage::Uniform | Storage::In | Storage::PatchIn))
        || (block.storage == Some(Storage::Buffer)
            && block.memory_access_qualifier_flags & memory_access::WRITEONLY_BIT == 0)
}

/// `isWritableInterface`
fn is_writable_interface(block: &InterfaceBlock) -> bool {
    matches!(block.storage, Some(Storage::Out | Storage::PatchOut))
        || (block.storage == Some(Storage::Buffer)
            && block.memory_access_qualifier_flags & memory_access::READONLY_BIT == 0)
}

/// `writeVariableReadAccumulateExpression`
fn write_variable_read_accumulate_expression(
    buf: &mut String,
    accumulator_name: &str,
    name: &str,
    shader_type: ShaderType,
    storage: Option<Storage>,
    program: &Program,
    var_type: &VarType,
) {
    match var_type {
        VarType::Basic(basic_type, _) => {
            let expression = if basic_type.is_scalar() {
                format!("vec4(float({name}))")
            } else if basic_type.is_vector() {
                format!("vec4({name}.xyxy)")
            } else if basic_type.is_matrix() {
                format!("vec4(float({name}[0][0]))")
            } else if basic_type.is_sampler_multisample() {
                format!("vec4(float(textureSize({name}).x))")
            } else if basic_type.is_sampler() {
                format!("vec4(float(textureSize({name}, 0).x))")
            } else if basic_type.is_image() {
                format!("vec4(float(imageSize({name}).x))")
            } else if basic_type.is_atomic_counter() {
                format!("vec4(float(atomicCounterIncrement({name})))")
            } else {
                unreachable!("no read expression for {basic_type:?}")
            };
            let _ = writeln!(buf, "\t{accumulator_name} += {expression};");
        }

        VarType::Struct(struct_ptr) => {
            for member in &struct_ptr.members {
                write_variable_read_accumulate_expression(
                    buf,
                    accumulator_name,
                    &format!("{name}.{}", member.name),
                    shader_type,
                    storage,
                    program,
                    &member.ty,
                );
            }
        }

        VarType::Array(element, size) => {
            if *size != UNSIZED_ARRAY {
                for ndx in 0..*size {
                    write_variable_read_accumulate_expression(
                        buf,
                        accumulator_name,
                        &format!("{name}[{ndx}]"),
                        shader_type,
                        storage,
                        program,
                        element,
                    );
                }
            } else if storage == Some(Storage::Buffer) {
                // run-time sized array, read arbitrary
                write_variable_read_accumulate_expression(
                    buf,
                    accumulator_name,
                    &format!("{name}[8]"),
                    shader_type,
                    storage,
                    program,
                    element,
                );
            } else {
                match shader_type {
                    // implicit sized geometry input array, size = primitive size. Just reading first is enough
                    ShaderType::Geometry => {
                        write_variable_read_accumulate_expression(
                            buf,
                            accumulator_name,
                            &format!("{name}[0]"),
                            shader_type,
                            storage,
                            program,
                            element,
                        );
                    }
                    // implicit sized tessellation input array, size = input patch max size. Just reading current is enough
                    ShaderType::TessControl => {
                        write_variable_read_accumulate_expression(
                            buf,
                            accumulator_name,
                            &format!("{name}[gl_InvocationID]"),
                            shader_type,
                            storage,
                            program,
                            element,
                        );
                    }
                    // implicit sized tessellation input array, size = output patch max size. Read all to prevent optimizations
                    ShaderType::TessEvaluation => {
                        for ndx in 0..program.tessellation_num_output_patch_vertices() {
                            write_variable_read_accumulate_expression(
                                buf,
                                accumulator_name,
                                &format!("{name}[{ndx}]"),
                                shader_type,
                                storage,
                                program,
                                element,
                            );
                        }
                    }
                    other => unreachable!("unsized input array in a {other:?} shader"),
                }
            }
        }
    }
}

/// `writeInterfaceReadAccumulateExpression`
fn write_interface_read_accumulate_expression(
    buf: &mut String,
    accumulator_name: &str,
    block: &InterfaceBlock,
    shader_type: ShaderType,
    program: &Program,
) {
    if block.dimensions.is_empty() {
        let prefix = if block.instance_name.is_empty() {
            String::new()
        } else {
            format!("{}.", block.instance_name)
        };

        for variable in &block.variables {
            write_variable_read_accumulate_expression(
                buf,
                accumulator_name,
                &format!("{prefix}{}", variable.name),
                shader_type,
                block.storage,
                program,
                &variable.var_type,
            );
        }
    } else {
        for index in multi_dimension_indices(&block.dimensions) {
            let mut name = block.instance_name.clone();
            for ndx in &index {
                let _ = write!(name, "[{ndx}]");
            }

            for variable in &block.variables {
                write_variable_read_accumulate_expression(
                    buf,
                    accumulator_name,
                    &format!("{name}.{}", variable.name),
                    shader_type,
                    block.storage,
                    program,
                    &variable.var_type,
                );
            }
        }
    }
}

/// `writeVariableWriteExpression` - \note `program` is carried only because upstream's
/// signature has it; nothing on the write path reads it.
#[expect(clippy::only_used_in_recursion, reason = "mirrors the upstream signature")]
fn write_variable_write_expression(
    buf: &mut String,
    source_vec4_name: &str,
    name: &str,
    shader_type: ShaderType,
    storage: Option<Storage>,
    program: &Program,
    var_type: &VarType,
) {
    match var_type {
        VarType::Basic(basic_type, _) => {
            let expression = if basic_type.is_scalar() {
                format!("{}({source_vec4_name}.y)", basic_type.name())
            } else if basic_type.is_vector() || basic_type.is_matrix() {
                format!(
                    "{}({}({source_vec4_name}.y))",
                    basic_type.name(),
                    basic_type.scalar_type().name()
                )
            } else {
                unreachable!("no write expression for {basic_type:?}")
            };
            let _ = writeln!(buf, "\t{name} = {expression};");
        }

        VarType::Struct(struct_ptr) => {
            for member in &struct_ptr.members {
                write_variable_write_expression(
                    buf,
                    source_vec4_name,
                    &format!("{name}.{}", member.name),
                    shader_type,
                    storage,
                    program,
                    &member.ty,
                );
            }
        }

        VarType::Array(element, size) => {
            if *size != UNSIZED_ARRAY {
                for ndx in 0..*size {
                    write_variable_write_expression(
                        buf,
                        source_vec4_name,
                        &format!("{name}[{ndx}]"),
                        shader_type,
                        storage,
                        program,
                        element,
                    );
                }
            } else if storage == Some(Storage::Buffer) {
                // run-time sized array, write arbitrary
                write_variable_write_expression(
                    buf,
                    source_vec4_name,
                    &format!("{name}[9]"),
                    shader_type,
                    storage,
                    program,
                    element,
                );
            } else {
                // implicit sized tessellation output array: only gl_InvocationID is writable
                assert_eq!(
                    shader_type,
                    ShaderType::TessControl,
                    "unsized output array outside tess. control"
                );
                write_variable_write_expression(
                    buf,
                    source_vec4_name,
                    &format!("{name}[gl_InvocationID]"),
                    shader_type,
                    storage,
                    program,
                    element,
                );
            }
        }
    }
}

/// `writeInterfaceWriteExpression`
fn write_interface_write_expression(
    buf: &mut String,
    source_vec4_name: &str,
    block: &InterfaceBlock,
    shader_type: ShaderType,
    program: &Program,
) {
    if block.dimensions.is_empty() {
        let prefix = if block.instance_name.is_empty() {
            String::new()
        } else {
            format!("{}.", block.instance_name)
        };

        for variable in &block.variables {
            write_variable_write_expression(
                buf,
                source_vec4_name,
                &format!("{prefix}{}", variable.name),
                shader_type,
                block.storage,
                program,
                &variable.var_type,
            );
        }
    } else {
        for index in multi_dimension_indices(&block.dimensions) {
            let mut name = block.instance_name.clone();
            for ndx in &index {
                let _ = write!(name, "[{ndx}]");
            }

            for variable in &block.variables {
                write_variable_write_expression(
                    buf,
                    source_vec4_name,
                    &format!("{name}.{}", variable.name),
                    shader_type,
                    block.storage,
                    program,
                    &variable.var_type,
                );
            }
        }
    }
}

/// `traverseVariablePath(typePath, subPath, type)` - walks `sub_path` down `ty`, pushing
/// every type it passes through. `None` means the path does not name anything in `ty`.
fn traverse_type_path(
    type_path: &mut Vec<VariablePathComponent>,
    sub_path: &str,
    ty: &VarType,
    struct_member: Option<usize>,
) -> bool {
    type_path.push(VariablePathComponent::Type {
        ty: ty.clone(),
        struct_member,
    });

    if sub_path.is_empty() {
        return true;
    }

    if let (VarType::Struct(struct_ptr), Some(tail)) = (ty, sub_path.strip_prefix('.')) {
        let end = tail.find(['[', '.']).unwrap_or(tail.len());
        let member_name = &tail[..end];
        if member_name.is_empty() {
            return false;
        }

        for (member_ndx, member) in struct_ptr.members.iter().enumerate() {
            if member.name == member_name {
                return traverse_type_path(type_path, &tail[end..], &member.ty, Some(member_ndx));
            }
        }

        // malformed path, no such member
        return false;
    }

    if let (VarType::Array(element, _), Some(tail)) = (ty, sub_path.strip_prefix('[')) {
        let Some((index, tail)) = tail.split_once(']') else {
            return false;
        };
        if index.is_empty() || !index.bytes().all(|b| b.is_ascii_digit()) {
            return false;
        }
        return traverse_type_path(type_path, tail, element, None);
    }

    false
}

/// `traverseVariablePath(typePath, path, var)`
fn traverse_variable_path(type_path: &mut Vec<VariablePathComponent>, path: &str, var: &VariableDeclaration) -> bool {
    if parse_variable_name(path) != var.name {
        return false;
    }

    type_path.push(VariablePathComponent::Declaration(var.clone()));
    traverse_type_path(type_path, &path[var.name.len()..], &var.var_type, None)
}

/// `traverseShaderVariablePath`
fn traverse_shader_variable_path(
    type_path: &mut Vec<VariablePathComponent>,
    shader: &Shader,
    path: &str,
    filter: &VariableSearchFilter,
) -> bool {
    // Default block variable?
    for variable in &shader.default_block.variables {
        if filter.matches_variable(variable) && traverse_variable_path(type_path, path, variable) {
            return true;
        }
    }

    // is variable an interface block variable?
    let block_name = parse_variable_name(path);

    for block in &shader.default_block.interface_blocks {
        if !filter.matches_block(block) {
            continue;
        }

        if block.interface_name == block_name {
            // A member of a named interface block. \note there is no array index specifier
            // even when the interface is declared as an array of instances.
            let block_member_path = &path[block_name.len() + 1..];
            let block_member_name = parse_variable_name(block_member_path);

            for variable in &block.variables {
                if variable.name == block_member_name {
                    type_path.push(VariablePathComponent::InterfaceBlock(block.clone()));
                    return traverse_variable_path(type_path, block_member_path, variable);
                }
            }

            // terminate search
            return false;
        } else if block.instance_name.is_empty() {
            let block_member_name = parse_variable_name(path);

            // unnamed block contains such variable?
            for variable in &block.variables {
                if variable.name == block_member_name {
                    type_path.push(VariablePathComponent::InterfaceBlock(block.clone()));
                    return traverse_variable_path(type_path, path, variable);
                }
            }

            // continue search
        }
    }

    false
}

/// `traverseProgramVariablePath`
fn traverse_program_variable_path(
    program: &Program,
    path: &str,
    filter: &VariableSearchFilter,
) -> Option<Vec<VariablePathComponent>> {
    for shader in program.shaders() {
        if filter.matches_shader(shader) {
            let mut type_path = Vec::new();
            if traverse_shader_variable_path(&mut type_path, shader, path, filter) {
                return Some(type_path);
            }
        }
    }

    None
}

/// `findProgramVariablePathByPathName`
pub fn find_program_variable_path_by_path_name(
    program: &Program,
    path_name: &str,
    filter: &VariableSearchFilter,
) -> Option<Vec<VariablePathComponent>> {
    traverse_program_variable_path(program, path_name, filter)
}

/// `containsSubType`
fn contains_sub_type(complex_type: &VarType, basic_type: DataType) -> bool {
    match complex_type {
        VarType::Basic(ty, _) => *ty == basic_type,
        VarType::Array(element, _) => contains_sub_type(element, basic_type),
        VarType::Struct(struct_ptr) => struct_ptr.members.iter().any(|m| contains_sub_type(&m.ty, basic_type)),
    }
}

/// The number of instances an interface block declaration stands for.
fn block_num_instances(block: &InterfaceBlock) -> i32 {
    block.dimensions.iter().product::<i32>().max(1)
}

/// `getNumShaderBlocks`
fn num_shader_blocks(shader: &Shader, storage: Storage) -> i32 {
    shader
        .default_block
        .interface_blocks
        .iter()
        .filter(|b| b.storage == Some(storage))
        .map(block_num_instances)
        .sum()
}

/// `getNumAtomicCounterBuffers` - one per distinct binding.
fn num_atomic_counter_buffers(shader: &Shader) -> i32 {
    let bindings: BTreeSet<i32> = shader
        .default_block
        .variables
        .iter()
        .filter(|v| contains_sub_type(&v.var_type, DataType::UintAtomicCounter))
        .map(|v| v.layout.binding.expect("an atomic counter always carries a binding"))
        .collect();

    bindings.len() as i32
}

/// `accumulateComplexType`
fn accumulate_complex_type(complex_type: &VarType, d_type_map: &dyn Fn(DataType) -> i32) -> i32 {
    match complex_type {
        VarType::Basic(basic_type, _) => d_type_map(*basic_type),
        VarType::Array(element, size) => {
            let array_size = if *size == UNSIZED_ARRAY { 1 } else { *size };
            array_size * accumulate_complex_type(element, d_type_map)
        }
        VarType::Struct(struct_ptr) => struct_ptr
            .members
            .iter()
            .map(|m| accumulate_complex_type(&m.ty, d_type_map))
            .sum(),
    }
}

/// `accumulateShader`
fn accumulate_shader(
    shader: &Shader,
    ib_filter: &dyn Fn(&InterfaceBlock) -> bool,
    vd_filter: &dyn Fn(&VariableDeclaration) -> bool,
    d_map: &dyn Fn(DataType) -> i32,
) -> i32 {
    let mut total = 0;

    for block in &shader.default_block.interface_blocks {
        if ib_filter(block) {
            let num_instances = block_num_instances(block);
            for variable in &block.variables {
                total += num_instances * accumulate_complex_type(&variable.var_type, d_map);
            }
        }
    }

    for variable in &shader.default_block.variables {
        if vd_filter(variable) {
            total += accumulate_complex_type(&variable.var_type, d_map);
        }
    }

    total
}

/// `getNumTypeInstances(const glu::VarType&, predicate)`
fn num_type_instances_of(complex_type: &VarType, predicate: fn(DataType) -> bool) -> i32 {
    accumulate_complex_type(complex_type, &|t| i32::from(predicate(t)))
}

/// `getNumTypeInstances(shader, storage, predicate)`
fn num_type_instances_filtered(shader: &Shader, storage: Storage, predicate: fn(DataType) -> bool) -> i32 {
    accumulate_shader(
        shader,
        &|b| b.storage == Some(storage),
        &|d| d.storage == Some(storage),
        &|t| i32::from(predicate(t)),
    )
}

/// `getNumTypeInstances(shader, storage)`
fn num_type_instances(shader: &Shader, storage: Storage) -> i32 {
    num_type_instances_filtered(shader, storage, |_| true)
}

/// `accumulateShaderStorage`
fn accumulate_shader_storage(shader: &Shader, storage: Storage, type_map: fn(DataType) -> i32) -> i32 {
    accumulate_shader(
        shader,
        &|b| b.storage == Some(storage),
        &|d| d.storage == Some(storage),
        &type_map,
    )
}

/// `getNumDataTypeComponents`
fn num_data_type_components(data_type: DataType) -> i32 {
    if data_type.is_scalar_or_vector() || data_type.is_matrix() {
        data_type.scalar_size()
    } else {
        0
    }
}

/// `getNumDataTypeVectors`
fn num_data_type_vectors(data_type: DataType) -> i32 {
    if data_type.is_scalar() || data_type.is_vector() {
        1
    } else if data_type.is_matrix() {
        data_type.matrix_num_columns()
    } else {
        0
    }
}

/// `getNumComponents`
fn num_components(shader: &Shader, storage: Storage) -> i32 {
    accumulate_shader_storage(shader, storage, num_data_type_components)
}

/// `getNumVectors`
fn num_vectors(shader: &Shader, storage: Storage) -> i32 {
    accumulate_shader_storage(shader, storage, num_data_type_vectors)
}

/// `getNumDefaultBlockComponents`
fn num_default_block_components(shader: &Shader, storage: Storage) -> i32 {
    shader
        .default_block
        .variables
        .iter()
        .filter(|v| v.storage == Some(storage))
        .map(|v| accumulate_complex_type(&v.var_type, &num_data_type_components))
        .sum()
}

/// `getMaxBufferBinding`
fn max_buffer_binding(shader: &Shader, storage: Storage) -> i32 {
    let mut max_binding = -1;

    for block in &shader.default_block.interface_blocks {
        if block.storage == Some(storage) {
            let binding = block.layout.binding.unwrap_or(0);
            max_binding = max_binding.max(binding + block_num_instances(block) - 1);
        }
    }

    max_binding
}

/// `getBufferTypeSize` - assumes vec4 alignment, so it is an upper bound on what the
/// driver will actually need.
fn buffer_type_size(data_type: DataType, order: Option<MatrixOrder>) -> i32 {
    let num_vectors = if data_type.is_scalar_or_vector() {
        1
    } else if data_type.is_matrix() && order == Some(MatrixOrder::RowMajor) {
        data_type.matrix_num_rows()
    } else if data_type.is_matrix() {
        data_type.matrix_num_columns()
    } else {
        unreachable!("no buffer size for {data_type:?}")
    };

    4 * num_vectors
}

/// `getBufferVariableSize`
fn buffer_variable_size(ty: &VarType, order: Option<MatrixOrder>) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => buffer_type_size(*basic_type, order),
        VarType::Array(element, size) => {
            let array_size = if *size == UNSIZED_ARRAY { 1 } else { *size };
            array_size * buffer_variable_size(element, order)
        }
        VarType::Struct(struct_ptr) => struct_ptr
            .members
            .iter()
            .map(|m| buffer_variable_size(&m.ty, order))
            .sum(),
    }
}

/// `getBufferSize`
fn buffer_size(block: &InterfaceBlock, block_order: Option<MatrixOrder>) -> i32 {
    block
        .variables
        .iter()
        .map(|v| buffer_variable_size(&v.var_type, v.layout.matrix_order.or(block_order)))
        .sum()
}

/// `getBufferMaxSize`
fn buffer_max_size(shader: &Shader, storage: Storage) -> i32 {
    shader
        .default_block
        .interface_blocks
        .iter()
        .filter(|b| b.storage == Some(storage))
        .map(|b| buffer_size(b, b.layout.matrix_order))
        .max()
        .unwrap_or(0)
}

/// `getAtomicCounterMaxBinding`
fn atomic_counter_max_binding(shader: &Shader) -> i32 {
    shader
        .default_block
        .variables
        .iter()
        .filter(|v| contains_sub_type(&v.var_type, DataType::UintAtomicCounter))
        .map(|v| v.layout.binding.expect("an atomic counter always carries a binding"))
        .max()
        .unwrap_or(-1)
}

/// `getUniformMaxBinding`
fn uniform_max_binding(shader: &Shader, predicate: fn(DataType) -> bool) -> i32 {
    let mut max_binding = -1;

    for variable in &shader.default_block.variables {
        let binding = variable.layout.binding.unwrap_or(0);
        let num_instances = num_type_instances_of(&variable.var_type, predicate);
        max_binding = max_binding.max(binding + num_instances - 1);
    }

    max_binding
}

/// `getAtomicCounterMaxBufferSize`
fn atomic_counter_max_buffer_size(shader: &Shader) -> i32 {
    let mut buffer_sizes: BTreeMap<i32, i32> = BTreeMap::new();

    for variable in &shader.default_block.variables {
        if contains_sub_type(&variable.var_type, DataType::UintAtomicCounter) {
            let buffer_binding = variable
                .layout
                .binding
                .expect("an atomic counter always carries a binding");
            let offset = variable.layout.offset.unwrap_or(0);
            let size = offset + 4 * num_type_instances_of(&variable.var_type, DataType::is_atomic_counter);

            let entry = buffer_sizes.entry(buffer_binding).or_insert(size);
            *entry = (*entry).max(size);
        }
    }

    buffer_sizes.values().copied().max().unwrap_or(0)
}

/// `getNumFeedbackVaryingComponents`
fn num_feedback_varying_components(program: &Program, name: &str) -> i32 {
    if name == "gl_Position" {
        return 4;
    }

    let stage = program_transform_feedback_stage(program).expect("a program with varyings has an output stage");
    let path = traverse_program_variable_path(
        program,
        name,
        &VariableSearchFilter::shader_type_storage(stage, Storage::Out),
    )
    .expect("program failed validate, invalid operation");

    accumulate_complex_type(
        path.last()
            .and_then(VariablePathComponent::variable_type)
            .expect("a variable path ends in a type"),
        &num_data_type_components,
    )
}

/// `getNumXFBComponents`
fn num_xfb_components(program: &Program) -> i32 {
    program
        .transform_feedback_varyings()
        .iter()
        .map(|v| num_feedback_varying_components(program, v))
        .sum()
}

/// `getNumMaxXFBOutputComponents`
fn num_max_xfb_output_components(program: &Program) -> i32 {
    program
        .transform_feedback_varyings()
        .iter()
        .map(|v| num_feedback_varying_components(program, v))
        .max()
        .unwrap_or(0)
}

/// `getFragmentOutputMaxLocation` - a missing location qualifier means location 0.
fn fragment_output_max_location(shader: &Shader) -> i32 {
    let mut max_output_location = -1;

    for variable in &shader.default_block.variables {
        if variable.storage == Some(Storage::Out) {
            let output_location = variable.layout.location.unwrap_or(0);
            // only basic types or arrays of basic types are possible here
            let location_slots_taken = if variable.var_type.is_array_type() {
                variable.var_type.array_size()
            } else {
                1
            };
            max_output_location = max_output_location.max(output_location + location_slots_taken - 1);
        }
    }

    max_output_location
}

/// `getProgramInterfaceBlockMemberResourceList`
pub fn program_interface_block_member_resource_list(block: &InterfaceBlock) -> Vec<String> {
    let name_prefix = if block.instance_name.is_empty() {
        String::new()
    } else {
        format!("{}.", block.interface_name)
    };
    let is_top_level_buffer_variable = block.storage == Some(Storage::Buffer);
    let mut resources = Vec::new();

    // \note this is defined in the GLSL spec, not in the GL spec
    for variable in &block.variables {
        generate_variable_type_resource_names(
            &mut resources,
            &format!("{name_prefix}{}", variable.name),
            &variable.var_type,
            if is_top_level_buffer_variable {
                resource_name_flag::TOP_LEVEL_BUFFER_VARIABLE
            } else {
                resource_name_flag::DEFAULT
            },
        );
    }

    resources
}

/// `getProgramInterfaceResourceList`
pub fn program_interface_resource_list(program: &Program, interface: ProgramInterface) -> Vec<String> {
    // The same {uniform (block), buffer (variable)} can exist in several shaders; remove
    // the duplicates but keep the order.
    let remove_duplicated = matches!(
        interface,
        ProgramInterface::Uniform
            | ProgramInterface::UniformBlock
            | ProgramInterface::BufferVariable
            | ProgramInterface::ShaderStorageBlock
    );
    let mut resources: Vec<String> = Vec::new();

    match interface {
        ProgramInterface::Uniform | ProgramInterface::BufferVariable => {
            let storage = if interface == ProgramInterface::Uniform {
                Storage::Uniform
            } else {
                Storage::Buffer
            };

            for shader in program.shaders() {
                for variable in &shader.default_block.variables {
                    if variable.storage == Some(storage) {
                        generate_variable_type_resource_names(
                            &mut resources,
                            &variable.name,
                            &variable.var_type,
                            resource_name_flag::DEFAULT,
                        );
                    }
                }

                for block in &shader.default_block.interface_blocks {
                    if block.storage == Some(storage) {
                        resources.extend(program_interface_block_member_resource_list(block));
                    }
                }
            }
        }

        ProgramInterface::UniformBlock | ProgramInterface::ShaderStorageBlock => {
            let storage = if interface == ProgramInterface::UniformBlock {
                Storage::Uniform
            } else {
                Storage::Buffer
            };

            for shader in program.shaders() {
                for block in &shader.default_block.interface_blocks {
                    if block.storage == Some(storage) {
                        for index in multi_dimension_indices(&block.dimensions) {
                            let mut name = block.interface_name.clone();
                            for ndx in &index {
                                let _ = write!(name, "[{ndx}]");
                            }
                            resources.push(name);
                        }
                    }
                }
            }
        }

        ProgramInterface::ProgramInput | ProgramInterface::ProgramOutput => {
            let is_input = interface == ProgramInterface::ProgramInput;
            let query_storage = if is_input { Storage::In } else { Storage::Out };
            let query_patch_storage = if is_input { Storage::PatchIn } else { Storage::PatchOut };
            let shader_type = if is_input {
                program.first_stage()
            } else {
                program.last_stage()
            };

            for shader in program.shaders() {
                if Some(shader.shader_type()) != shader_type {
                    continue;
                }

                for variable in &shader.default_block.variables {
                    if variable.storage == Some(query_storage) || variable.storage == Some(query_patch_storage) {
                        generate_variable_type_resource_names(
                            &mut resources,
                            &variable.name,
                            &variable.var_type,
                            resource_name_flag::DEFAULT,
                        );
                    }
                }

                for block in &shader.default_block.interface_blocks {
                    if block.storage == Some(query_storage) || block.storage == Some(query_patch_storage) {
                        resources.extend(program_interface_block_member_resource_list(block));
                    }
                }
            }

            // built-ins
            if is_input {
                match shader_type {
                    // only read from when there are no other inputs
                    Some(ShaderType::Vertex) if resources.is_empty() => resources.push("gl_VertexID".to_string()),
                    Some(ShaderType::Fragment) if resources.is_empty() => resources.push("gl_FragCoord".to_string()),
                    Some(ShaderType::Geometry) => resources.push("gl_PerVertex.gl_Position".to_string()),
                    Some(ShaderType::TessControl) => {
                        resources.push("gl_InvocationID".to_string());
                        resources.push("gl_PerVertex.gl_Position".to_string());
                    }
                    Some(ShaderType::TessEvaluation) => resources.push("gl_PerVertex.gl_Position".to_string()),
                    Some(ShaderType::Compute) if resources.is_empty() => resources.push("gl_NumWorkGroups".to_string()),
                    _ => {}
                }
            } else {
                match shader_type {
                    Some(ShaderType::Vertex) => resources.push("gl_Position".to_string()),
                    // only written to when there are no other outputs
                    Some(ShaderType::Fragment) if resources.is_empty() => resources.push("gl_FragDepth".to_string()),
                    Some(ShaderType::Geometry) => resources.push("gl_Position".to_string()),
                    Some(ShaderType::TessControl) => {
                        resources.push("gl_PerVertex.gl_Position".to_string());
                        resources.push("gl_TessLevelOuter[0]".to_string());
                        resources.push("gl_TessLevelInner[0]".to_string());
                    }
                    Some(ShaderType::TessEvaluation) => resources.push("gl_Position".to_string()),
                    _ => {}
                }
            }
        }

        ProgramInterface::TransformFeedbackVarying => {
            let xfb_stage =
                program_transform_feedback_stage(program).expect("a program with varyings has an output stage");

            for varying_name in program.transform_feedback_varyings() {
                if varying_name.starts_with("gl_") {
                    resources.push(varying_name.clone()); // builtin
                } else {
                    let path = traverse_program_variable_path(
                        program,
                        varying_name,
                        &VariableSearchFilter::shader_type_storage(xfb_stage, Storage::Out),
                    )
                    .expect("program failed validate, invalid operation");

                    generate_variable_type_resource_names(
                        &mut resources,
                        varying_name,
                        path.last()
                            .and_then(VariablePathComponent::variable_type)
                            .expect("a variable path ends in a type"),
                        resource_name_flag::TRANSFORM_FEEDBACK_VARIABLE,
                    );
                }
            }
        }

        ProgramInterface::AtomicCounterBuffer => {
            unreachable!("the atomic counter buffer interface has no resource names")
        }
    }

    if remove_duplicated {
        let mut added = BTreeSet::new();
        resources.retain(|r| added.insert(r.clone()));
    }

    resources
}

/// The uniform `generateProgramInterfaceProgramSources` adds to keep the optimizer from
/// eliminating the resources under test.
pub fn unused_zero_uniform_name() -> &'static str {
    "unusedZero"
}

/// The vertex attribute it adds for the same reason.
pub fn no_opt_vertex_attrib_name() -> &'static str {
    "noOpt"
}

/// `generateProgramInterfaceProgramSources`
pub fn generate_program_interface_program_sources(program: &Program) -> ProgramSources {
    debug_assert!(program.is_valid());

    let mut sources = ProgramSources::default();

    for shader in program.shaders() {
        let mut contains_user_defined_outputs = false;
        let mut contains_user_defined_inputs = false;
        let mut source_buf = String::new();
        let mut usage_buf = String::new();

        let _ = write!(
            source_buf,
            "{}\n{}{}\n",
            shader.version().declaration(),
            shader_extension_declarations(shader),
            shader_type_declarations(program, shader),
        );

        // Struct definitions
        write_structure_definitions(&mut source_buf, &shader.default_block);

        // variables in the default scope
        for variable in &shader.default_block.variables {
            let _ = writeln!(source_buf, "{variable};");
        }
        if !shader.default_block.variables.is_empty() {
            source_buf.push('\n');
        }

        // Interface blocks
        for block in &shader.default_block.interface_blocks {
            write_interface_block(&mut source_buf, block);
        }

        // Use inputs and outputs so that they won't be removed by the optimizer
        if shader.shader_type() == ShaderType::Vertex {
            let _ = writeln!(usage_buf, "highp in int {};", no_opt_vertex_attrib_name());
        }
        let _ = write!(
            usage_buf,
            "highp uniform vec4 {}; // Default value is vec4(0.0).\nhighp vec4 readInputs()\n{{\n    highp vec4 retValue = {};\n",
            unused_zero_uniform_name(),
            unused_zero_uniform_name(),
        );

        // User-defined inputs
        for variable in &shader.default_block.variables {
            if matches!(
                variable.storage,
                Some(Storage::In | Storage::PatchIn | Storage::Uniform)
            ) {
                write_variable_read_accumulate_expression(
                    &mut usage_buf,
                    "retValue",
                    &variable.name,
                    shader.shader_type(),
                    variable.storage,
                    program,
                    &variable.var_type,
                );
                contains_user_defined_inputs = true;
            }
        }

        for block in &shader.default_block.interface_blocks {
            if is_readable_interface(block) {
                write_interface_read_accumulate_expression(
                    &mut usage_buf,
                    "retValue",
                    block,
                    shader.shader_type(),
                    program,
                );
                contains_user_defined_inputs = true;
            }
        }

        // Built-in inputs
        match shader.shader_type() {
            // make readInputs never be a compile time constant
            ShaderType::Vertex if !contains_user_defined_inputs => {
                usage_buf.push_str("    retValue += vec4(float(gl_VertexID));\n")
            }
            ShaderType::Fragment if !contains_user_defined_inputs => {
                usage_buf.push_str("    retValue += gl_FragCoord;\n")
            }
            ShaderType::Compute if !contains_user_defined_inputs => {
                usage_buf.push_str("    retValue += vec4(float(gl_NumWorkGroups.x));\n")
            }
            // always use the previous stage's output values so that stage won't be optimized out
            ShaderType::Geometry | ShaderType::TessControl | ShaderType::TessEvaluation => {
                usage_buf.push_str("    retValue += gl_in[0].gl_Position;\n")
            }
            _ => {}
        }

        usage_buf.push_str("    return retValue;\n}\n\n");
        usage_buf.push_str("void writeOutputs(in highp vec4 unusedValue)\n{\n");

        // User-defined outputs
        for variable in &shader.default_block.variables {
            if matches!(variable.storage, Some(Storage::Out | Storage::PatchOut)) {
                write_variable_write_expression(
                    &mut usage_buf,
                    "unusedValue",
                    &variable.name,
                    shader.shader_type(),
                    variable.storage,
                    program,
                    &variable.var_type,
                );
                contains_user_defined_outputs = true;
            }
        }

        for block in &shader.default_block.interface_blocks {
            if is_writable_interface(block) {
                write_interface_write_expression(&mut usage_buf, "unusedValue", block, shader.shader_type(), program);
                contains_user_defined_outputs = true;
            }
        }

        // Builtin outputs that must be written to
        match shader.shader_type() {
            ShaderType::Vertex => {
                // Prevent drivers from moving the store to a subsequent shader stage
                let _ = writeln!(usage_buf, "    gl_Position = {} == 0 ? unusedValue : vec4(1.0);", no_opt_vertex_attrib_name());
            }
            ShaderType::Geometry => usage_buf.push_str("    gl_Position = unusedValue;\n    EmitVertex();\n"),
            ShaderType::TessControl => usage_buf.push_str(
                "    gl_out[gl_InvocationID].gl_Position = unusedValue;\n    gl_TessLevelOuter[0] = 2.8;\n    gl_TessLevelOuter[1] = 2.8;\n    \
                 gl_TessLevelOuter[2] = 2.8;\n    gl_TessLevelOuter[3] = 2.8;\n    gl_TessLevelInner[0] = 2.8;\n    gl_TessLevelInner[1] = 2.8;\n",
            ),
            ShaderType::TessEvaluation => usage_buf.push_str("    gl_Position = unusedValue;\n"),
            _ => {}
        }

        // Output to sink input data to
        if !contains_user_defined_outputs {
            if shader.shader_type() == ShaderType::Fragment {
                usage_buf.push_str("    gl_FragDepth = dot(unusedValue.xy, unusedValue.xw);\n");
            } else if shader.shader_type() == ShaderType::Compute {
                usage_buf.push_str("    unusedOutputBlock.unusedValue = unusedValue;\n");
            }
        }

        usage_buf.push_str("}\n\nvoid main()\n{\n    writeOutputs(readInputs());\n}\n");

        // Interface for the unused output
        if shader.shader_type() == ShaderType::Compute && !contains_user_defined_outputs {
            source_buf.push_str(
                "writeonly buffer UnusedOutputInterface\n{\n    highp vec4 unusedValue;\n} unusedOutputBlock;\n\n",
            );
        }

        sources = sources.with(shader.shader_type(), source_buf + &usage_buf);
    }

    if program.is_separable() {
        sources = sources.separable();
    }

    if !program.transform_feedback_varyings().is_empty() || program.transform_feedback_mode() != 0 {
        sources =
            sources.with_transform_feedback(program.transform_feedback_varyings(), program.transform_feedback_mode());
    }

    sources
}

/// `getShaderResourceUsage`
pub fn shader_resource_usage(program: &Program, shader: &Shader) -> ShaderResourceUsage {
    let mut usage = ShaderResourceUsage {
        num_inputs: num_type_instances(shader, Storage::In),
        num_input_vectors: num_vectors(shader, Storage::In),
        num_input_components: num_components(shader, Storage::In),

        num_outputs: num_type_instances(shader, Storage::Out),
        num_output_vectors: num_vectors(shader, Storage::Out),
        num_output_components: num_components(shader, Storage::Out),

        num_patch_input_components: num_components(shader, Storage::PatchIn),
        num_patch_output_components: num_components(shader, Storage::PatchOut),

        num_default_block_uniform_components: num_default_block_components(shader, Storage::Uniform),
        num_combined_uniform_components: num_components(shader, Storage::Uniform),
        num_uniform_vectors: num_vectors(shader, Storage::Uniform),

        num_samplers: num_type_instances_filtered(shader, Storage::Uniform, DataType::is_sampler),
        num_images: num_type_instances_filtered(shader, Storage::Uniform, DataType::is_image),

        num_atomic_counter_buffers: num_atomic_counter_buffers(shader),
        num_atomic_counters: num_type_instances_filtered(shader, Storage::Uniform, DataType::is_atomic_counter),

        num_uniform_blocks: num_shader_blocks(shader, Storage::Uniform),
        num_shader_storage_blocks: num_shader_blocks(shader, Storage::Buffer),
    };

    // add builtins
    let patch_vertices = program.tessellation_num_output_patch_vertices() as i32;
    match shader.shader_type() {
        // gl_Position is not counted for vertex, and fragment/compute add nothing
        ShaderType::Vertex | ShaderType::Fragment | ShaderType::Compute => {}

        ShaderType::Geometry => {
            // gl_Position in (point mode => size 1)
            usage.num_inputs += 1;
            usage.num_input_vectors += 1;
            usage.num_input_components += 4;

            // gl_Position out
            usage.num_outputs += 1;
            usage.num_output_vectors += 1;
            usage.num_output_components += 4;
        }

        ShaderType::TessControl => {
            // gl_Position in is read up to gl_InstanceID
            usage.num_inputs += patch_vertices;
            usage.num_input_vectors += patch_vertices;
            usage.num_input_components += 4 * patch_vertices;

            // gl_Position out, size = num patch out vertices
            usage.num_outputs += patch_vertices;
            usage.num_output_vectors += patch_vertices;
            usage.num_output_components += 4 * patch_vertices;
        }

        ShaderType::TessEvaluation => {
            // gl_Position in is read up to gl_InstanceID
            usage.num_inputs += patch_vertices;
            usage.num_input_vectors += patch_vertices;
            usage.num_input_components += 4 * patch_vertices;

            // gl_Position out
            usage.num_outputs += 1;
            usage.num_output_vectors += 1;
            usage.num_output_components += 4;
        }
    }

    usage
}

/// `getCombinedProgramResourceUsage`
pub fn combined_program_resource_usage(program: &Program) -> ProgramResourceUsage {
    let mut usage = ProgramResourceUsage::default();
    let mut num_vertex_output_components = 0;
    let mut num_fragment_input_components = 0;
    let mut num_vertex_output_vectors = 0;
    let mut num_fragment_input_vectors = 0;

    for shader in program.shaders() {
        usage.uniform_buffer_max_binding = usage
            .uniform_buffer_max_binding
            .max(max_buffer_binding(shader, Storage::Uniform));
        usage.uniform_buffer_max_size = usage
            .uniform_buffer_max_size
            .max(buffer_max_size(shader, Storage::Uniform));
        usage.num_uniform_blocks += num_shader_blocks(shader, Storage::Uniform);

        let uniform_components = num_components(shader, Storage::Uniform);
        match shader.shader_type() {
            ShaderType::Vertex => usage.num_combined_vertex_uniform_components += uniform_components,
            ShaderType::Fragment => usage.num_combined_fragment_uniform_components += uniform_components,
            ShaderType::Geometry => usage.num_combined_geometry_uniform_components += uniform_components,
            ShaderType::TessControl => usage.num_combined_tess_control_uniform_components += uniform_components,
            ShaderType::TessEvaluation => usage.num_combined_tess_eval_uniform_components += uniform_components,
            ShaderType::Compute => {}
        }

        usage.shader_storage_buffer_max_binding = usage
            .shader_storage_buffer_max_binding
            .max(max_buffer_binding(shader, Storage::Buffer));
        usage.shader_storage_buffer_max_size = usage
            .shader_storage_buffer_max_size
            .max(buffer_max_size(shader, Storage::Buffer));
        usage.num_shader_storage_blocks += num_shader_blocks(shader, Storage::Buffer);

        if shader.shader_type() == ShaderType::Vertex {
            num_vertex_output_components += num_components(shader, Storage::Out);
            num_vertex_output_vectors += num_vectors(shader, Storage::Out);
        } else if shader.shader_type() == ShaderType::Fragment {
            num_fragment_input_components += num_components(shader, Storage::In);
            num_fragment_input_vectors += num_vectors(shader, Storage::In);
        }

        usage.num_combined_samplers += num_type_instances_filtered(shader, Storage::Uniform, DataType::is_sampler);

        usage.atomic_counter_buffer_max_binding = usage
            .atomic_counter_buffer_max_binding
            .max(atomic_counter_max_binding(shader));
        usage.atomic_counter_buffer_max_size = usage
            .atomic_counter_buffer_max_size
            .max(atomic_counter_max_buffer_size(shader));
        usage.num_atomic_counter_buffers += num_atomic_counter_buffers(shader);
        usage.num_atomic_counters += num_type_instances_filtered(shader, Storage::Uniform, DataType::is_atomic_counter);
        usage.max_image_binding = usage
            .max_image_binding
            .max(uniform_max_binding(shader, DataType::is_image));
        usage.num_combined_images += num_type_instances_filtered(shader, Storage::Uniform, DataType::is_image);

        usage.num_combined_output_resources +=
            num_type_instances_filtered(shader, Storage::Uniform, DataType::is_image);
        usage.num_combined_output_resources += num_shader_blocks(shader, Storage::Buffer);

        if shader.shader_type() == ShaderType::Fragment {
            usage.num_combined_output_resources += num_vectors(shader, Storage::Out);
            usage.fragment_output_max_binding = usage
                .fragment_output_max_binding
                .max(fragment_output_max_location(shader));
        }
    }

    if program.transform_feedback_mode() == glw::GL_INTERLEAVED_ATTRIBS {
        usage.num_xfb_interleaved_components = num_xfb_components(program);
    } else if program.transform_feedback_mode() == glw::GL_SEPARATE_ATTRIBS {
        usage.num_xfb_separate_attribs = program.transform_feedback_varyings().len() as i32;
        usage.num_xfb_separate_components = num_max_xfb_output_components(program);
    }

    // legacy limits
    usage.num_varying_components = num_vertex_output_components.max(num_fragment_input_components);
    usage.num_varying_vectors = num_vertex_output_vectors.max(num_fragment_input_vectors);

    usage
}
