// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramInterfaceQueryTests.cpp
//     (the `ResourceDefinition` namespace and `generateProgramDefinitionFromResource`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, and split out of the case tree into its
// own file - the tree is ~8000 lines of C++ and this part is what every one of its cases is
// built from. Upstream's node class hierarchy is one enum here, since the only thing the
// subclasses add is data and the only thing anything does with a node is match on its type.
//
// A node chain is built leaf-to-root (each node holds its enclosing one), exactly as
// upstream does, so `generate_program_definition` can walk outwards from the variable.
//
// A `Shader` node carries no GLSL version: upstream stores the context's version in every
// one of them, and the case tree here is built before any context exists, so the version is
// a parameter of the generator instead.

use std::sync::Arc;

use crate::gles31::functional::program_interface_definition::{DefaultBlock, Program};
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::var_type::{
    FormatLayout, InterfaceBlock, Interpolation, Layout, Storage, StructType, UNSIZED_ARRAY, VarType,
    VariableDeclaration, memory_access,
};
use crate::glu::{GlslVersion, ShaderType};
use crate::glw;

/// Every shader stage, in the order `glu::ShaderType` declares them - what upstream's
/// `for (int shaderType = 0; shaderType < glu::SHADERTYPE_LAST; ++shaderType)` walks.
pub const ALL_SHADER_TYPES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

/// `ResourceDefinition::ArrayElement::DEFAULT_SIZE` - the size varies per nesting level.
pub const ARRAY_DEFAULT_SIZE: i32 = -1;

/// `ResourceDefinition::ArrayElement::UNSIZED_ARRAY`
pub const ARRAY_UNSIZED: i32 = -2;

/// `ResourceDefinition::Node` and its subclasses.
#[derive(Clone, Debug)]
pub enum NodeKind {
    Program { separable: bool },
    Shader { shader_type: ShaderType },
    DefaultBlock,
    Variable { data_type: DataType },
    InterfaceBlock { named: bool },
    ArrayElement { array_size: i32 },
    StructMember,
    StorageQualifier { storage: Storage },
    LayoutQualifier { layout: Layout },
    ShaderSet { present: [bool; 6], referencing: [bool; 6] },
    InterpolationQualifier { interpolation: Interpolation },
    TransformFeedbackTarget { builtin_var_name: Option<&'static str> },
}

/// One link of a resource definition chain.
#[derive(Clone, Debug)]
pub struct Node {
    pub kind: NodeKind,
    pub enclosing: Option<NodePtr>,
}

pub type NodePtr = Arc<Node>;

/// The index a shader type has in a `ShaderSet`'s two bool arrays.
fn stage_index(shader_type: ShaderType) -> usize {
    shader_type as usize
}

impl Node {
    fn new(kind: NodeKind, enclosing: Option<NodePtr>) -> NodePtr {
        Arc::new(Self { kind, enclosing })
    }

    /// `ResourceDefinition::Program`
    pub fn program(separable: bool) -> NodePtr {
        Self::new(NodeKind::Program { separable }, None)
    }

    /// `ResourceDefinition::Shader`
    pub fn shader(enclosing: &NodePtr, shader_type: ShaderType) -> NodePtr {
        Self::new(NodeKind::Shader { shader_type }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::DefaultBlock`
    pub fn default_block(enclosing: &NodePtr) -> NodePtr {
        Self::new(NodeKind::DefaultBlock, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::StorageQualifier`
    pub fn storage_qualifier(enclosing: &NodePtr, storage: Storage) -> NodePtr {
        Self::new(NodeKind::StorageQualifier { storage }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::Variable`
    pub fn variable(enclosing: &NodePtr, data_type: DataType) -> NodePtr {
        Self::new(NodeKind::Variable { data_type }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::InterfaceBlock`
    pub fn interface_block(enclosing: &NodePtr, named: bool) -> NodePtr {
        Self::new(NodeKind::InterfaceBlock { named }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::ArrayElement`
    pub fn array_element(enclosing: &NodePtr, array_size: i32) -> NodePtr {
        Self::new(NodeKind::ArrayElement { array_size }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::ArrayElement` with the default (per-level varying) size.
    pub fn array_element_default(enclosing: &NodePtr) -> NodePtr {
        Self::array_element(enclosing, ARRAY_DEFAULT_SIZE)
    }

    /// `ResourceDefinition::StructMember`
    pub fn struct_member(enclosing: &NodePtr) -> NodePtr {
        Self::new(NodeKind::StructMember, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::LayoutQualifier`
    pub fn layout_qualifier(enclosing: &NodePtr, layout: Layout) -> NodePtr {
        Self::new(NodeKind::LayoutQualifier { layout }, Some(Arc::clone(enclosing)))
    }

    /// `ResourceDefinition::InterpolationQualifier`
    pub fn interpolation_qualifier(enclosing: &NodePtr, interpolation: Interpolation) -> NodePtr {
        Self::new(
            NodeKind::InterpolationQualifier { interpolation },
            Some(Arc::clone(enclosing)),
        )
    }

    /// `ResourceDefinition::ShaderSet` with every stage absent.
    pub fn shader_set(enclosing: &NodePtr) -> NodePtr {
        Self::new(
            NodeKind::ShaderSet {
                present: [false; 6],
                referencing: [false; 6],
            },
            Some(Arc::clone(enclosing)),
        )
    }

    /// `ResourceDefinition::ShaderSet(enclosing, version, stagesPresentBits, stagesReferencingBits)`
    pub fn shader_set_masked(enclosing: &NodePtr, present_bits: u32, referencing_bits: u32) -> NodePtr {
        let mut present = [false; 6];
        let mut referencing = [false; 6];

        for shader_type in ALL_SHADER_TYPES {
            let mask = 1 << (shader_type as u32);
            let stage_present = present_bits & mask != 0;
            let stage_referencing = referencing_bits & mask != 0;
            debug_assert!(stage_present || !stage_referencing);

            present[stage_index(shader_type)] = stage_present;
            referencing[stage_index(shader_type)] = stage_referencing;
        }

        Self::new(
            NodeKind::ShaderSet { present, referencing },
            Some(Arc::clone(enclosing)),
        )
    }

    /// `ResourceDefinition::TransformFeedbackTarget`
    pub fn transform_feedback_target(enclosing: &NodePtr, builtin_var_name: Option<&'static str>) -> NodePtr {
        Self::new(
            NodeKind::TransformFeedbackTarget { builtin_var_name },
            Some(Arc::clone(enclosing)),
        )
    }
}

/// `ShaderSet::setStage` - a node is shared once built, so this answers a new one.
pub fn shader_set_with_stage(node: &NodePtr, shader_type: ShaderType, referencing: bool) -> NodePtr {
    let NodeKind::ShaderSet {
        present,
        referencing: referencing_mask,
    } = &node.kind
    else {
        panic!("not a shader set");
    };

    let mut present = *present;
    let mut referencing_mask = *referencing_mask;
    present[stage_index(shader_type)] = true;
    referencing_mask[stage_index(shader_type)] = referencing;

    Arc::new(Node {
        kind: NodeKind::ShaderSet {
            present,
            referencing: referencing_mask,
        },
        enclosing: node.enclosing.clone(),
    })
}

/// `ShaderSet::getReferencingMask`
pub fn shader_set_referencing_mask(node: &Node) -> u32 {
    let NodeKind::ShaderSet { referencing, .. } = &node.kind else {
        panic!("not a shader set");
    };

    ALL_SHADER_TYPES
        .iter()
        .filter(|&&stage| referencing[stage_index(stage)])
        .fold(0, |mask, &stage| mask | (1 << (stage as u32)))
}

/// `getDataTypeDefaultPrecision` - `None` where upstream answers `PRECISION_LAST`, i.e. a
/// type that takes no precision qualifier.
pub fn data_type_default_precision(data_type: DataType) -> Option<Precision> {
    if data_type.is_bool_or_bvec() {
        None
    } else if data_type.is_scalar_or_vector()
        || data_type.is_matrix()
        || data_type.is_sampler()
        || data_type.is_image()
        || data_type.is_atomic_counter()
    {
        Some(Precision::HighP)
    } else {
        unreachable!("no default precision for {data_type:?}")
    }
}

/// The `layout(format)` qualifier an image variable of this type needs.
fn image_format_layout(data_type: DataType) -> FormatLayout {
    use DataType::*;

    match data_type {
        Image2D | ImageCube | Image2DArray | Image3D => FormatLayout::Rgba8,
        IntImage2D | IntImageCube | IntImage2DArray | IntImage3D => FormatLayout::Rgba8i,
        UintImage2D | UintImageCube | UintImage2DArray | UintImage3D => FormatLayout::Rgba8ui,
        other => unreachable!("not an image type: {other:?}"),
    }
}

/// Which of the three objects the walk is currently attaching qualifiers to.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum BindingType {
    Variable,
    InterfaceBlock,
    DefaultBlock,
}

/// `generateProgramDefinitionFromResource`
pub fn generate_program_definition(resource: &Node, glsl_version: GlslVersion) -> Program {
    let mut program = Program::new();

    match &resource.kind {
        NodeKind::Variable { data_type } => {
            let basic_type = *data_type;
            let mut struct_ndx = 0;
            let mut auto_assign_array_size = 0;
            let mut bound_object = BindingType::Variable;
            let mut variable = VariableDeclaration::new(
                VarType::basic(basic_type, data_type_default_precision(basic_type)),
                "target",
                None,
            );
            let mut interface_block = InterfaceBlock::default();
            let mut default_block = DefaultBlock::default();
            let mut feedback_target_varying_path: Vec<String> = Vec::new();
            let mut feedback_target_set = false;

            // image specific
            if basic_type.is_image() {
                variable.memory_access_qualifier_bits |= memory_access::READONLY_BIT;
                variable.layout.binding = Some(1);
                variable.layout.format = Some(image_format_layout(basic_type));
            }

            // atomic counter specific
            if basic_type.is_atomic_counter() {
                variable.layout.binding = Some(1);
            }

            let mut head = resource.enclosing.clone();
            while let Some(node) = head {
                match &node.kind {
                    NodeKind::StorageQualifier { storage } => match bound_object {
                        BindingType::Variable => {
                            debug_assert!(variable.storage.is_none());
                            variable.storage = Some(*storage);
                        }
                        BindingType::InterfaceBlock => {
                            debug_assert!(interface_block.storage.is_none());
                            interface_block.storage = Some(*storage);
                        }
                        BindingType::DefaultBlock => unreachable!("a storage qualifier outside any object"),
                    },

                    NodeKind::LayoutQualifier { layout } => {
                        let target_layout = match bound_object {
                            BindingType::Variable => &mut variable.layout,
                            BindingType::InterfaceBlock => &mut interface_block.layout,
                            BindingType::DefaultBlock => unreachable!("a layout qualifier outside any object"),
                        };

                        // Every field the qualifier does set overrides; the ones it leaves
                        // defaulted leave whatever an inner qualifier already put there.
                        if layout.location.is_some() {
                            target_layout.location = layout.location;
                        }
                        if layout.binding.is_some() {
                            target_layout.binding = layout.binding;
                        }
                        if layout.offset.is_some() {
                            target_layout.offset = layout.offset;
                        }
                        if layout.format.is_some() {
                            target_layout.format = layout.format;
                        }
                        if layout.matrix_order.is_some() {
                            target_layout.matrix_order = layout.matrix_order;
                        }
                    }

                    NodeKind::InterpolationQualifier { interpolation } => {
                        debug_assert_eq!(bound_object, BindingType::Variable);
                        variable.interpolation = Some(*interpolation);
                    }

                    NodeKind::ArrayElement { array_size } => {
                        // Vary the array size per level
                        let array_size = if *array_size == ARRAY_DEFAULT_SIZE {
                            auto_assign_array_size -= 1;
                            if auto_assign_array_size <= 1 {
                                auto_assign_array_size = 3;
                            }
                            auto_assign_array_size
                        } else if *array_size == ARRAY_UNSIZED {
                            UNSIZED_ARRAY
                        } else {
                            *array_size
                        };

                        match bound_object {
                            BindingType::Variable => {
                                variable.var_type = VarType::array(variable.var_type.clone(), array_size)
                            }
                            BindingType::InterfaceBlock => interface_block.dimensions.push(array_size),
                            BindingType::DefaultBlock => unreachable!("an array element outside any object"),
                        }

                        if feedback_target_set {
                            feedback_target_varying_path
                                .last_mut()
                                .expect("a path root")
                                .push_str("[0]");
                        }
                    }

                    NodeKind::StructMember => {
                        debug_assert_eq!(bound_object, BindingType::Variable);
                        // Struct members cannot carry any qualifier except precision.
                        debug_assert!(variable.interpolation.is_none());
                        debug_assert!(variable.layout.is_default());
                        debug_assert_eq!(variable.memory_access_qualifier_bits, 0);
                        debug_assert!(variable.storage.is_none());

                        let mut struct_type = StructType::new(&format!("StructType{struct_ndx}"));
                        struct_ndx += 1;
                        struct_type.add_member(&variable.name, variable.var_type.clone());

                        variable = VariableDeclaration::new(VarType::structure(&Arc::new(struct_type)), "target", None);

                        if feedback_target_set {
                            feedback_target_varying_path.push("target".to_string());
                        }
                    }

                    NodeKind::InterfaceBlock { named } => {
                        debug_assert_eq!(bound_object, BindingType::Variable);
                        bound_object = BindingType::InterfaceBlock;

                        interface_block.interface_name = "TargetInterface".to_string();
                        interface_block.instance_name = if *named {
                            "targetInstance".to_string()
                        } else {
                            String::new()
                        };
                        interface_block.variables.push(variable.clone());

                        if feedback_target_set && !interface_block.instance_name.is_empty() {
                            feedback_target_varying_path.push(interface_block.interface_name.clone());
                        }
                    }

                    NodeKind::DefaultBlock => {
                        match bound_object {
                            BindingType::Variable => default_block.variables.push(variable.clone()),
                            BindingType::InterfaceBlock => default_block.interface_blocks.push(interface_block.clone()),
                            BindingType::DefaultBlock => unreachable!("two default blocks in one chain"),
                        }
                        bound_object = BindingType::DefaultBlock;
                    }

                    NodeKind::Shader { shader_type } => {
                        let shader = program.add_shader(*shader_type, glsl_version);
                        shader.default_block = default_block.clone();
                    }

                    NodeKind::ShaderSet { present, referencing } => {
                        for shader_type in ALL_SHADER_TYPES {
                            if present[stage_index(shader_type)] {
                                let referencing = referencing[stage_index(shader_type)];
                                let shader = program.add_shader(shader_type, glsl_version);
                                if referencing {
                                    shader.default_block = default_block.clone();
                                }
                            }
                        }
                    }

                    NodeKind::TransformFeedbackTarget { builtin_var_name } => {
                        debug_assert!(builtin_var_name.is_none());
                        feedback_target_set = true;
                        feedback_target_varying_path.push(variable.name.clone());
                    }

                    // A chain has one variable, at the leaf the walk started from.
                    NodeKind::Variable { .. } => unreachable!("two variables in one chain"),

                    NodeKind::Program { separable } => {
                        program.set_separable(*separable);

                        debug_assert_eq!(feedback_target_set, !feedback_target_varying_path.is_empty());
                        if !feedback_target_varying_path.is_empty() {
                            // The path was collected leaf-first, and the varying name runs
                            // outermost-first.
                            let name = feedback_target_varying_path
                                .iter()
                                .rev()
                                .cloned()
                                .collect::<Vec<_>>()
                                .join(".");
                            program.add_transform_feedback_varying(&name);
                            program.set_transform_feedback_mode(glw::GL_INTERLEAVED_ATTRIBS);
                        }
                        break;
                    }
                }

                head = node.enclosing.clone();
            }
        }

        // empty default block
        NodeKind::DefaultBlock | NodeKind::TransformFeedbackTarget { .. } => {
            let mut feedback_target_varying_name: Option<&'static str> = None;
            let mut head = Some(Arc::new(resource.clone()));

            while let Some(node) = head {
                match &node.kind {
                    NodeKind::Shader { shader_type } => {
                        program.add_shader(*shader_type, glsl_version);
                    }

                    NodeKind::ShaderSet { present, .. } => {
                        for shader_type in ALL_SHADER_TYPES {
                            if present[stage_index(shader_type)] {
                                program.add_shader(shader_type, glsl_version);
                            }
                        }
                    }

                    NodeKind::TransformFeedbackTarget { builtin_var_name } => {
                        feedback_target_varying_name =
                            Some(builtin_var_name.expect("an empty-block feedback target names a builtin"));
                    }

                    NodeKind::DefaultBlock => {}

                    NodeKind::Program { separable } => {
                        program.set_separable(*separable);
                        if let Some(name) = feedback_target_varying_name {
                            program.add_transform_feedback_varying(name);
                            program.set_transform_feedback_mode(glw::GL_INTERLEAVED_ATTRIBS);
                        }
                        break;
                    }

                    other => unreachable!("unexpected node in an empty-block chain: {other:?}"),
                }

                head = node.enclosing.clone();
            }
        }

        other => unreachable!("a resource chain starts at a variable or a default block, not {other:?}"),
    }

    if program.has_stage(ShaderType::Geometry) {
        program.set_geometry_num_output_vertices(1);
    }
    if program.has_stage(ShaderType::TessControl) || program.has_stage(ShaderType::TessEvaluation) {
        program.set_tessellation_num_output_patch_vertices(1);
    }

    program
}
