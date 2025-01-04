// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramInterfaceQueryTestCase.cpp
//   modules/gles31/functional/es31fProgramInterfaceQueryTestCase.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's validators are a class
// hierarchy three deep (`PropValidator` -> `SingleVariableValidator`/`SingleBlockValidator`
// -> one class per property); here `PropValidator` is a trait and the two middle classes
// are the free functions `validate_single_variable` / `validate_single_block` that each
// concrete validator's `validate` delegates to. That keeps the per-property bodies - which
// is where the actual rules live - in one-to-one correspondence with the C++.
//
// Upstream reports a failure by writing it into the test context, where the first one wins;
// here that is a `Cell` on the validation state, read once when the case finishes.

use std::cell::RefCell;

use crate::gles31::functional::program_interface_definition::{Program, ProgramInterface, Shader};
use crate::gles31::functional::program_interface_definition_util::{
    VariablePathComponent, VariableSearchFilter, combined_program_resource_usage,
    find_program_variable_path_by_path_name, generate_program_interface_program_sources, shader_resource_usage,
};
use crate::glu::shader_util::DataType;
use crate::glu::var_type::{InterfaceBlock, MatrixOrder, Storage, UNSIZED_ARRAY, VarType};
use crate::glu::{Context, ShaderType, get_data_type_from_gl_type};
use crate::glw::{self, GLenum, GLint, GLuint};

/// `ProgramResourcePropFlags`
pub mod prop {
    pub const ARRAY_SIZE: u32 = 1 << 1;
    pub const ARRAY_STRIDE: u32 = 1 << 2;
    pub const ATOMIC_COUNTER_BUFFER_INDEX: u32 = 1 << 3;
    pub const BLOCK_INDEX: u32 = 1 << 4;
    pub const LOCATION: u32 = 1 << 5;
    pub const MATRIX_ROW_MAJOR: u32 = 1 << 6;
    pub const MATRIX_STRIDE: u32 = 1 << 7;
    pub const NAME_LENGTH: u32 = 1 << 8;
    pub const OFFSET: u32 = 1 << 9;
    pub const REFERENCED_BY_SHADER: u32 = 1 << 10;
    pub const TYPE: u32 = 1 << 11;
    pub const BUFFER_BINDING: u32 = 1 << 12;
    pub const BUFFER_DATA_SIZE: u32 = 1 << 13;
    pub const ACTIVE_VARIABLES: u32 = 1 << 14;
    pub const TOP_LEVEL_ARRAY_SIZE: u32 = 1 << 15;
    pub const TOP_LEVEL_ARRAY_STRIDE: u32 = 1 << 16;
    pub const IS_PER_PATCH: u32 = 1 << 17;

    pub const UNIFORM_INTERFACE_MASK: u32 = ARRAY_SIZE
        | ARRAY_STRIDE
        | ATOMIC_COUNTER_BUFFER_INDEX
        | BLOCK_INDEX
        | LOCATION
        | MATRIX_ROW_MAJOR
        | MATRIX_STRIDE
        | NAME_LENGTH
        | OFFSET
        | REFERENCED_BY_SHADER
        | TYPE;

    pub const UNIFORM_BLOCK_INTERFACE_MASK: u32 =
        NAME_LENGTH | REFERENCED_BY_SHADER | BUFFER_BINDING | BUFFER_DATA_SIZE | ACTIVE_VARIABLES;

    pub const SHADER_STORAGE_BLOCK_MASK: u32 =
        NAME_LENGTH | REFERENCED_BY_SHADER | BUFFER_BINDING | BUFFER_DATA_SIZE | ACTIVE_VARIABLES;

    pub const PROGRAM_INPUT_MASK: u32 =
        ARRAY_SIZE | LOCATION | NAME_LENGTH | REFERENCED_BY_SHADER | TYPE | IS_PER_PATCH;

    pub const PROGRAM_OUTPUT_MASK: u32 =
        ARRAY_SIZE | LOCATION | NAME_LENGTH | REFERENCED_BY_SHADER | TYPE | IS_PER_PATCH;

    pub const BUFFER_VARIABLE_MASK: u32 = ARRAY_SIZE
        | ARRAY_STRIDE
        | BLOCK_INDEX
        | MATRIX_ROW_MAJOR
        | MATRIX_STRIDE
        | NAME_LENGTH
        | OFFSET
        | REFERENCED_BY_SHADER
        | TOP_LEVEL_ARRAY_SIZE
        | TOP_LEVEL_ARRAY_STRIDE
        | TYPE;

    pub const TRANSFORM_FEEDBACK_VARYING_MASK: u32 = ARRAY_SIZE | NAME_LENGTH | TYPE;
}

/// `ProgramResourceQueryTestTarget`
#[derive(Clone, Copy, Debug)]
pub struct ProgramResourceQueryTestTarget {
    pub interface: ProgramInterface,
    pub prop_flags: u32,
}

impl ProgramResourceQueryTestTarget {
    /// The constructor asserts that the flags asked for are a subset of what the
    /// interface has; keeping the assert keeps a typo in a case table from silently
    /// querying a property the interface does not define.
    pub fn new(interface: ProgramInterface, prop_flags: u32) -> Self {
        let mask = match interface {
            ProgramInterface::Uniform => prop::UNIFORM_INTERFACE_MASK,
            ProgramInterface::UniformBlock => prop::UNIFORM_BLOCK_INTERFACE_MASK,
            ProgramInterface::ShaderStorageBlock => prop::SHADER_STORAGE_BLOCK_MASK,
            ProgramInterface::ProgramInput => prop::PROGRAM_INPUT_MASK,
            ProgramInterface::ProgramOutput => prop::PROGRAM_OUTPUT_MASK,
            ProgramInterface::BufferVariable => prop::BUFFER_VARIABLE_MASK,
            ProgramInterface::TransformFeedbackVarying => prop::TRANSFORM_FEEDBACK_VARYING_MASK,
            ProgramInterface::AtomicCounterBuffer => 0,
        };
        debug_assert_eq!(prop_flags & !mask, 0, "property is not part of this interface");
        Self { interface, prop_flags }
    }
}

/// `getProgramDefaultBlockInterfaceFromStorage`
fn program_default_block_interface_from_storage(storage: Storage) -> GLenum {
    match storage {
        Storage::In | Storage::PatchIn => glw::GL_PROGRAM_INPUT,
        Storage::Out | Storage::PatchOut => glw::GL_PROGRAM_OUTPUT,
        Storage::Uniform => glw::GL_UNIFORM,
        other => unreachable!("no default-block interface for {other:?}"),
    }
}

/// `isBufferBackedInterfaceBlockStorage`
fn is_buffer_backed_interface_block_storage(storage: Option<Storage>) -> bool {
    matches!(storage, Some(Storage::Buffer | Storage::Uniform))
}

/// `getRequiredExtensionForStage`
pub fn required_extension_for_stage(stage: ShaderType) -> Option<&'static str> {
    match stage {
        ShaderType::Compute | ShaderType::Vertex | ShaderType::Fragment => None,
        ShaderType::Geometry => Some("GL_EXT_geometry_shader"),
        ShaderType::TessControl | ShaderType::TessEvaluation => Some("GL_EXT_tessellation_shader"),
    }
}

/// `getTypeSize` - in basic machine units.
fn type_size(data_type: DataType) -> i32 {
    match data_type {
        // a bool is a uint on the wire
        DataType::Float | DataType::Int | DataType::Uint | DataType::Bool => 4,
        other => unreachable!("no machine size for {other:?}"),
    }
}

/// `getVarTypeSize`
fn var_type_size(ty: &VarType) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => basic_type.scalar_size() * type_size(basic_type.scalar_type()),
        VarType::Struct(struct_ptr) => struct_ptr.members.iter().map(|m| var_type_size(&m.ty)).sum(),
        // unsized arrays are handled as if they had only one element
        VarType::Array(element, size) => {
            if *size == UNSIZED_ARRAY {
                var_type_size(element)
            } else {
                *size * var_type_size(element)
            }
        }
    }
}

/// `getMatrixOrderFromPath` - the innermost qualifier along the path wins.
fn matrix_order_from_path(path: &[VariablePathComponent]) -> Option<MatrixOrder> {
    let mut order = None;

    for component in path {
        let mat_order = match component {
            VariablePathComponent::InterfaceBlock(block) => block.layout.matrix_order,
            VariablePathComponent::Declaration(decl) => decl.layout.matrix_order,
            VariablePathComponent::Type { .. } => None,
        };

        if mat_order.is_some() {
            order = mat_order;
        }
    }

    order
}

/// The state every validator shares: the context it queries, the program it queries, and
/// the first error anything reported.
pub struct Validation<'a> {
    pub context: &'a Context,
    pub program_id: GLuint,
    error: RefCell<Option<String>>,
}

impl<'a> Validation<'a> {
    pub fn new(context: &'a Context, program_id: GLuint) -> Self {
        Self {
            context,
            program_id,
            error: RefCell::new(None),
        }
    }

    pub fn gl(&self) -> &'a glw::Functions {
        self.context.gl()
    }

    /// `PropValidator::setError` - don't overwrite an earlier error.
    pub fn set_error(&self, err: impl Into<String>) {
        let mut slot = self.error.borrow_mut();
        if slot.is_none() {
            *slot = Some(err.into());
        }
    }

    pub fn error(&self) -> Option<String> {
        self.error.borrow().clone()
    }

    fn supports_es32(&self) -> bool {
        self.context.context_type().supports(3, 2)
    }

    fn is_extension_supported(&self, extension: &str) -> bool {
        self.context.context_info.is_extension_supported(extension)
    }

    /// `gl.getProgramInterfaceiv(programID, interface, pname, &value)`
    fn program_interfaceiv(&self, interface: GLenum, pname: GLenum) -> GLint {
        let mut value: GLint = 0;
        // SAFETY: one GLint out, and the program is the one this validation was built for.
        unsafe {
            self.gl()
                .get_program_interfaceiv(self.program_id, interface, pname, &mut value)
        };
        value
    }

    /// `gl.getProgramResourceName(...)` as a `String`.
    fn program_resource_name(&self, interface: GLenum, index: GLuint) -> String {
        let mut buf = vec![0u8; 256];
        let mut written: crate::glw::GLsizei = 0;
        // SAFETY: the driver writes at most `buf.len()` bytes and reports how many.
        unsafe {
            self.gl().get_program_resource_name(
                self.program_id,
                interface,
                index,
                buf.len() as crate::glw::GLsizei,
                &mut written,
                buf.as_mut_ptr().cast(),
            );
        }
        String::from_utf8_lossy(&buf[..written.max(0) as usize]).into_owned()
    }

    /// `gl.getProgramResourceLocation(...)`
    fn program_resource_location(&self, interface: GLenum, name: &str) -> GLint {
        let name = std::ffi::CString::new(name).expect("a resource name has no interior NUL");
        // SAFETY: the name outlives the call.
        unsafe {
            self.gl()
                .get_program_resource_location(self.program_id, interface, name.as_ptr())
        }
    }
}

/// `glu::getBooleanStr`
fn boolean_str(value: GLint) -> String {
    match value {
        0 => "GL_FALSE".to_string(),
        1 => "GL_TRUE".to_string(),
        other => format!("(invalid boolean value {other})"),
    }
}

/// `PropValidator`
pub trait PropValidator {
    /// `m_validationProp`
    fn prop(&self) -> u32;

    /// `m_extension`
    fn extension(&self) -> Option<&'static str> {
        None
    }

    /// `getHumanReadablePropertyString`
    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        prop_val.to_string()
    }

    /// `validate`
    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        implementation_name: &str,
    );

    /// `isSupported`
    fn is_supported(&self, v: &Validation<'_>) -> bool {
        v.supports_es32() || self.extension().is_none_or(|e| v.is_extension_supported(e))
    }

    /// `isSelected`
    fn is_selected(&self, case_flags: u32) -> bool {
        case_flags & self.prop() != 0
    }
}

/// `SingleVariableValidator::validate` - resolve the resource name to a variable, then
/// hand the path to the property's own rule.
fn validate_single_variable(
    v: &Validation<'_>,
    program: &Program,
    resource: &str,
    filter: &VariableSearchFilter,
    on_variable: impl FnOnce(&[VariablePathComponent]),
    on_builtin: impl FnOnce(),
) {
    if let Some(path) = find_program_variable_path_by_path_name(program, resource, filter) {
        let variable = path.last().and_then(VariablePathComponent::variable_type);

        if variable.is_none_or(|ty| !ty.is_basic_type()) {
            log::debug!("Error, resource name \"{resource}\" refers to a non-basic type.");
            v.set_error("resource not basic type");
        } else {
            on_variable(&path);
        }

        // finding a matching variable in any shader is sufficient
        return;
    }

    if resource.starts_with("gl_") {
        // special case for builtins
        on_builtin();
        return;
    }

    // we are only supplied good names, generated by ourselves
    unreachable!("resource name consistency error: {resource}");
}

/// `SingleBlockValidator::validate` - resolve the block name (and any instance index) to
/// the block it names.
fn validate_single_block(
    v: &Validation<'_>,
    program: &Program,
    resource: &str,
    filter: &VariableSearchFilter,
    on_block: impl FnOnce(&InterfaceBlock, &[i32]),
) {
    let _ = v;
    let (block_name, mut rest) = match resource.split_once('[') {
        Some((head, tail)) => (head, Some(tail)),
        None => (resource, None),
    };

    let mut instance_index = Vec::new();
    while let Some(tail) = rest {
        let (index, tail) = tail.split_once(']').expect("malformed block instance index");
        instance_index.push(index.parse::<i32>().expect("block instance index is not a number"));
        rest = tail.strip_prefix('[');
        assert!(
            rest.is_some() || tail.is_empty(),
            "trailing garbage in block resource name"
        );
    }

    for shader in program.shaders() {
        if !filter.matches_shader(shader) {
            continue;
        }

        for block in &shader.default_block.interface_blocks {
            if filter.matches_block(block) && block.interface_name == block_name {
                debug_assert_eq!(instance_index.len(), block.dimensions.len(), "block dimensions match");
                on_block(block, &instance_index);
                return;
            }
        }
    }

    // we are only supplied good names, generated by ourselves
    unreachable!("resource name consistency error: {resource}");
}

/// The `gl_*` variables a property validator has to answer for, since they have no
/// declaration to walk.
struct Builtin<T: 'static> {
    name: &'static str,
    value: T,
}

/// Looks a builtin up by resource name; every table below is exhaustive for the resources
/// this suite generates, so a miss is a bug in the case, not in the driver.
fn builtin_value<T: Copy>(table: &[Builtin<T>], resource: &str) -> T {
    table
        .iter()
        .find(|b| b.name == resource)
        .unwrap_or_else(|| unreachable!("no builtin entry for {resource}"))
        .value
}

// The per-property validators, in upstream's order.

/// `TypeValidator`
struct TypeValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for TypeValidator {
    fn prop(&self) -> u32 {
        prop::TYPE
    }

    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        get_data_type_from_gl_type(prop_val as GLenum).name().to_string()
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        const BUILTINS: &[Builtin<DataType>] = &[
            Builtin {
                name: "gl_Position",
                value: DataType::FloatVec4,
            },
            Builtin {
                name: "gl_FragCoord",
                value: DataType::FloatVec4,
            },
            Builtin {
                name: "gl_PerVertex.gl_Position",
                value: DataType::FloatVec4,
            },
            Builtin {
                name: "gl_VertexID",
                value: DataType::Int,
            },
            Builtin {
                name: "gl_InvocationID",
                value: DataType::Int,
            },
            Builtin {
                name: "gl_NumWorkGroups",
                value: DataType::UintVec3,
            },
            Builtin {
                name: "gl_FragDepth",
                value: DataType::Float,
            },
            Builtin {
                name: "gl_TessLevelOuter[0]",
                value: DataType::Float,
            },
            Builtin {
                name: "gl_TessLevelInner[0]",
                value: DataType::Float,
            },
        ];

        let check = |expected: DataType| {
            log::debug!("Verifying type, expecting {}", expected.name());
            if expected != get_data_type_from_gl_type(prop_value as GLenum) {
                log::debug!(
                    "\tError, got {}",
                    get_data_type_from_gl_type(prop_value as GLenum).name()
                );
                v.set_error("resource type invalid");
            }
        };

        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                check(
                    path.last()
                        .and_then(VariablePathComponent::variable_type)
                        .expect("a basic type")
                        .basic_type(),
                )
            },
            || check(builtin_value(BUILTINS, resource)),
        );
    }
}

/// `ArraySizeValidator`
struct ArraySizeValidator {
    unsized_array_size: i32,
    filter: VariableSearchFilter,
}

impl PropValidator for ArraySizeValidator {
    fn prop(&self) -> u32 {
        prop::ARRAY_SIZE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        const BUILTINS: &[Builtin<i32>] = &[
            Builtin {
                name: "gl_Position",
                value: 1,
            },
            Builtin {
                name: "gl_VertexID",
                value: 1,
            },
            Builtin {
                name: "gl_FragCoord",
                value: 1,
            },
            Builtin {
                name: "gl_PerVertex.gl_Position",
                value: 1,
            },
            Builtin {
                name: "gl_InvocationID",
                value: 1,
            },
            Builtin {
                name: "gl_NumWorkGroups",
                value: 1,
            },
            Builtin {
                name: "gl_FragDepth",
                value: 1,
            },
            Builtin {
                name: "gl_TessLevelOuter[0]",
                value: 4,
            },
            Builtin {
                name: "gl_TessLevelInner[0]",
                value: 2,
            },
        ];

        let check = |array_size: i32| {
            log::debug!("Verifying array size, expecting {array_size}");
            if array_size != prop_value {
                log::debug!("\tError, got {prop_value}");
                v.set_error("resource array size invalid");
            }
        };

        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let enclosing = enclosing_component(path);
                let enclosing_array = enclosing
                    .and_then(VariablePathComponent::variable_type)
                    .filter(|ty| ty.is_array_type());

                let array_size = match enclosing_array {
                    None => 1,
                    Some(ty) if ty.array_size() == UNSIZED_ARRAY => self.unsized_array_size,
                    Some(ty) => ty.array_size(),
                };

                debug_assert!(array_size >= 0);
                check(array_size);
            },
            || check(builtin_value(BUILTINS, resource)),
        );
    }
}

/// The path component one step out from the one the resource names, which is what says
/// whether the variable sits in an array, a struct or neither.
fn enclosing_component(path: &[VariablePathComponent]) -> Option<&VariablePathComponent> {
    if path.len() > 1 { path.get(path.len() - 2) } else { None }
}

/// `ArrayStrideValidator`
struct ArrayStrideValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for ArrayStrideValidator {
    fn prop(&self) -> u32 {
        prop::ARRAY_STRIDE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let basic_type = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type();
                let is_buffer_block = path
                    .first()
                    .and_then(VariablePathComponent::interface_block)
                    .is_some_and(|b| is_buffer_backed_interface_block_storage(b.storage));
                let is_array = enclosing_component(path)
                    .and_then(VariablePathComponent::variable_type)
                    .is_some_and(VarType::is_array_type);
                // atomic counters are buffer backed with a stride of 4 basic machine units
                let is_atomic_counter = basic_type.is_atomic_counter();

                if is_buffer_block && is_array {
                    // The layout tests verify the layouts of buffer backed arrays properly;
                    // here it is enough that the value is at least the element size.
                    let element_size = basic_type.scalar_size() * type_size(basic_type.scalar_type());
                    log::debug!("Verifying array stride, expecting greater or equal to {element_size}");

                    if prop_value < element_size {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource array stride invalid");
                    }
                } else {
                    let array_stride = if is_atomic_counter && is_array {
                        4
                    } else if !is_buffer_block && !is_atomic_counter {
                        -1
                    } else {
                        0
                    };

                    log::debug!("Verifying array stride, expecting {array_stride}");
                    if array_stride != prop_value {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource array stride invalid");
                    }
                }
            },
            || unreachable!("no builtin array stride"),
        );
    }
}

/// `BlockIndexValidator`
struct BlockIndexValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for BlockIndexValidator {
    fn prop(&self) -> u32 {
        prop::BLOCK_INDEX
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let Some(block) = path.first().and_then(VariablePathComponent::interface_block) else {
                    log::debug!("Verifying block index, expecting -1");
                    if prop_value != -1 {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource block index invalid");
                    }
                    return;
                };

                log::debug!("Verifying block index, expecting a valid block index");
                if prop_value == -1 {
                    log::debug!("\tError, got {prop_value}");
                    v.set_error("resource block index invalid");
                    return;
                }

                let interface = match block.storage {
                    Some(Storage::Uniform) => glw::GL_UNIFORM_BLOCK,
                    Some(Storage::Buffer) => glw::GL_SHADER_STORAGE_BLOCK,
                    _ => 0,
                };

                let block_name = v.program_resource_name(interface, prop_value as GLuint);
                let mut expected_name = block.interface_name.clone();
                for _ in &block.dimensions {
                    expected_name.push_str("[0]");
                }

                log::debug!("Block name with index {prop_value} is \"{block_name}\"");
                if block_name != expected_name {
                    log::debug!("\tError, expected {expected_name}");
                    v.set_error("resource block index invalid");
                }
            },
            || unreachable!("no builtin block index"),
        );
    }
}

/// `IsRowMajorValidator`
struct IsRowMajorValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for IsRowMajorValidator {
    fn prop(&self) -> u32 {
        prop::MATRIX_ROW_MAJOR
    }

    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        boolean_str(prop_val)
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let basic_type = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type();
                let is_buffer_block = path
                    .first()
                    .and_then(VariablePathComponent::interface_block)
                    .is_some_and(|b| is_buffer_backed_interface_block_storage(b.storage));
                let expected = i32::from(
                    is_buffer_block
                        && basic_type.is_matrix()
                        && matrix_order_from_path(path) == Some(MatrixOrder::RowMajor),
                );

                log::debug!("Verifying matrix order, expecting IS_ROW_MAJOR = {expected}");
                if prop_value != expected {
                    log::debug!("\tError, got {prop_value}");
                    v.set_error("resource matrix order invalid");
                }
            },
            || unreachable!("no builtin matrix order"),
        );
    }
}

/// `MatrixStrideValidator`
struct MatrixStrideValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for MatrixStrideValidator {
    fn prop(&self) -> u32 {
        prop::MATRIX_STRIDE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let basic_type = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type();
                let is_buffer_block = path
                    .first()
                    .and_then(VariablePathComponent::interface_block)
                    .is_some_and(|b| is_buffer_backed_interface_block_storage(b.storage));

                // The layout tests verify the layouts of buffer backed matrices properly;
                // here it is enough that the stride covers one row or column.
                if is_buffer_block && basic_type.is_matrix() {
                    let column_major = matrix_order_from_path(path) != Some(MatrixOrder::RowMajor);
                    let num_major_elements = if column_major {
                        basic_type.matrix_num_rows()
                    } else {
                        basic_type.matrix_num_columns()
                    };
                    let major_size = num_major_elements * type_size(basic_type.scalar_type());

                    log::debug!("Verifying matrix stride, expecting greater or equal to {major_size}");
                    if prop_value < major_size {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource matrix stride invalid");
                    }
                } else {
                    let matrix_stride = if !is_buffer_block && !basic_type.is_atomic_counter() {
                        -1
                    } else {
                        0
                    };

                    log::debug!("Verifying matrix stride, expecting {matrix_stride}");
                    if matrix_stride != prop_value {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource matrix stride invalid");
                    }
                }
            },
            || unreachable!("no builtin matrix stride"),
        );
    }
}

/// `AtomicCounterBufferIndexVerifier`
struct AtomicCounterBufferIndexVerifier {
    filter: VariableSearchFilter,
}

impl PropValidator for AtomicCounterBufferIndexVerifier {
    fn prop(&self) -> u32 {
        prop::ATOMIC_COUNTER_BUFFER_INDEX
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let basic_type = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type();

                if !basic_type.is_atomic_counter() {
                    log::debug!("Verifying atomic counter buffer index, expecting -1");
                    if prop_value != -1 {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource atomic counter buffer index invalid");
                    }
                    return;
                }

                log::debug!("Verifying atomic counter buffer index, expecting a valid index");
                if prop_value == -1 {
                    log::debug!("\tError, got {prop_value}");
                    v.set_error("resource atomic counter buffer index invalid");
                    return;
                }

                let num_active_resources =
                    v.program_interfaceiv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_ACTIVE_RESOURCES);
                if prop_value >= num_active_resources {
                    log::debug!("\tError, got {prop_value}, GL_ACTIVE_RESOURCES = {num_active_resources}");
                    v.set_error("resource atomic counter buffer index invalid");
                }
            },
            || unreachable!("no builtin atomic counter buffer index"),
        );
    }
}

/// `getVariableLocationLength`
fn variable_location_length(ty: &VarType) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => {
            if basic_type.is_matrix() {
                basic_type.matrix_num_columns()
            } else {
                1
            }
        }
        VarType::Struct(struct_ptr) => struct_ptr.members.iter().map(|m| variable_location_length(&m.ty)).sum(),
        VarType::Array(element, size) => size * variable_location_length(element),
    }
}

/// `getIOSubVariableLocation` - walks down the path adding the locations every member
/// before the one taken consumes.
fn io_sub_variable_location(path: &[VariablePathComponent], start_ndx: usize, mut current_location: i32) -> i32 {
    if current_location == -1 {
        return -1;
    }

    let ty = path[start_ndx].variable_type().expect("a type component");

    match ty {
        VarType::Basic(..) => current_location,
        VarType::Array(..) => io_sub_variable_location(path, start_ndx + 1, current_location),
        VarType::Struct(struct_ptr) => {
            let taken = path[start_ndx + 1]
                .struct_member_index()
                .expect("the next step is a struct member");

            for member in &struct_ptr.members[..taken] {
                if current_location != -1 {
                    current_location += variable_location_length(&member.ty);
                }
            }

            io_sub_variable_location(path, start_ndx + 1, current_location)
        }
    }
}

/// `getIOBlockVariableLocation`
fn io_block_variable_location(path: &[VariablePathComponent]) -> i32 {
    let block = path[0].interface_block().expect("an interface block");
    let declaration = path[1].declaration().expect("a declaration");
    let mut current_location = block.layout.location.unwrap_or(-1);

    // Find the block member
    for member in &block.variables {
        if let Some(location) = member.layout.location {
            current_location = location;
        }

        if member.name == declaration.name {
            break;
        }

        // unspecified + unspecified = unspecified
        if current_location != -1 {
            current_location += variable_location_length(&member.var_type);
        }
    }

    // Find the subtype location in the complex type
    io_sub_variable_location(path, 2, current_location)
}

/// `getExplicitLocationFromPath`
fn explicit_location_from_path(path: &[VariablePathComponent]) -> i32 {
    let var_decl = if path[0].is_interface_block() {
        path[1].declaration().expect("a declaration")
    } else {
        path[0].declaration().expect("a declaration")
    };

    if let Some(block) = path[0].interface_block() {
        return match block.storage {
            // inside a uniform block
            Some(Storage::Uniform) => -1,
            // inside an io block
            Some(Storage::In | Storage::Out | Storage::PatchIn | Storage::PatchOut) => io_block_variable_location(path),
            other => unreachable!("no location rule for a {other:?} block"),
        };
    }

    match var_decl.storage {
        // default block uniform
        Some(Storage::Uniform) => var_decl.layout.location.unwrap_or(-1),
        // default block input/output
        Some(Storage::In | Storage::Out | Storage::PatchIn | Storage::PatchOut) => {
            io_sub_variable_location(path, 1, var_decl.layout.location.unwrap_or(-1))
        }
        other => unreachable!("no location rule for {other:?}"),
    }
}

/// `LocationValidator`
struct LocationValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for LocationValidator {
    fn prop(&self) -> u32 {
        prop::LOCATION
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let is_atomic_counter_uniform = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type()
                    .is_atomic_counter();
                let is_uniform_block_variable = path
                    .first()
                    .and_then(VariablePathComponent::interface_block)
                    .is_some_and(|b| b.storage == Some(Storage::Uniform));
                let is_vertex_shader = self.filter.shader_type_bits() == 1 << (ShaderType::Vertex as u32);
                let is_fragment_shader = self.filter.shader_type_bits() == 1 << (ShaderType::Fragment as u32);
                let storage = match &path[0] {
                    VariablePathComponent::InterfaceBlock(block) => block.storage,
                    _ => path[0].declaration().expect("a declaration").storage,
                };
                let is_input_variable = matches!(storage, Some(Storage::In | Storage::PatchIn));
                let is_output_variable = matches!(storage, Some(Storage::Out | Storage::PatchOut));
                let explicit_layout_location = explicit_location_from_path(path);

                let reason = if is_atomic_counter_uniform {
                    Some("Atomic counter uniforms have effective location of -1")
                } else if is_uniform_block_variable {
                    Some("Uniform block variables have effective location of -1")
                } else if is_input_variable && !is_vertex_shader && explicit_layout_location == -1 {
                    Some(
                        "Inputs (except for vertex shader inputs) not declared with a location layout qualifier have effective location of -1",
                    )
                } else if is_output_variable && !is_fragment_shader && explicit_layout_location == -1 {
                    Some(
                        "Outputs (except for fragment shader outputs) not declared with a location layout qualifier have effective location of -1",
                    )
                } else {
                    None
                };

                if let Some(reason) = reason {
                    log::debug!("Verifying uniform location, expecting -1. ({reason})");
                    if prop_value != -1 {
                        log::debug!("\tError, got {prop_value}");
                        v.set_error("resource location invalid");
                    }
                    return;
                }

                let location_ok = if explicit_layout_location == -1 {
                    log::debug!("Verifying location, expecting a valid location");
                    prop_value != -1
                } else {
                    log::debug!("Verifying location, expecting {explicit_layout_location}");
                    prop_value == explicit_layout_location
                };

                if !location_ok {
                    log::debug!("\tError, got {prop_value}");
                    v.set_error("resource location invalid");
                    return;
                }

                let enclosing_array = enclosing_component(path)
                    .and_then(VariablePathComponent::variable_type)
                    .filter(|ty| ty.is_array_type());
                let interface = program_default_block_interface_from_storage(storage.expect("a storage qualifier"));

                log::debug!("Comparing location to the values returned by GetProgramResourceLocation");

                // Test all bottom-level array elements
                if let Some(array_type) = enclosing_array {
                    // chop "[0]"
                    let array_resource_name = if implementation_name.len() > 3 {
                        &implementation_name[..implementation_name.len() - 3]
                    } else {
                        ""
                    };

                    for array_element_ndx in 0..array_type.array_size() {
                        let element_resource_name = format!("{array_resource_name}[{array_element_ndx}]");
                        let location = v.program_resource_location(interface, &element_resource_name);

                        if location != prop_value + array_element_ndx {
                            log::debug!(
                                "\tError, getProgramResourceLocation (resource=\"{element_resource_name}\") returned location {location}, expected {}",
                                prop_value + array_element_ndx
                            );
                            v.set_error("resource location invalid");
                        } else {
                            log::debug!("\tLocation of \"{element_resource_name}\":\t{location}");
                        }
                    }
                } else {
                    let location = v.program_resource_location(interface, implementation_name);

                    if location != prop_value {
                        log::debug!(
                            "\tError, getProgramResourceLocation returned location {location}, expected {prop_value}"
                        );
                        v.set_error("resource location invalid");
                    }
                }
            },
            || {
                // built-ins have no location
                log::debug!("Verifying location, expecting -1");
                if prop_value != -1 {
                    log::debug!("\tError, got {prop_value}");
                    v.set_error("resource location invalid");
                }
            },
        );
    }
}

/// `validateNameLength` - shared by the variable and the block name-length validators.
fn validate_name_length(v: &Validation<'_>, implementation_name: &str, prop_value: GLint, error: &str) {
    let expected = implementation_name.len() as GLint + 1; // includes null byte
    log::debug!(
        "Verifying name length, expecting {expected} ({} for \"{implementation_name}\" + 1 byte for terminating null character)",
        implementation_name.len()
    );

    if prop_value != expected {
        log::debug!("\tError, invalid name length, got {prop_value}");
        v.set_error(error);
    }
}

/// `VariableNameLengthValidator`
struct VariableNameLengthValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for VariableNameLengthValidator {
    fn prop(&self) -> u32 {
        prop::NAME_LENGTH
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |_path| validate_name_length(v, implementation_name, prop_value, "name length invalid"),
            || validate_name_length(v, implementation_name, prop_value, "name length invalid"),
        );
    }
}

/// `OffsetValidator`
struct OffsetValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for OffsetValidator {
    fn prop(&self) -> u32 {
        prop::OFFSET
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let is_atomic_counter_uniform = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a basic type")
                    .basic_type()
                    .is_atomic_counter();
                let is_buffer_backed_block_storage = path
                    .first()
                    .and_then(VariablePathComponent::interface_block)
                    .is_some_and(|b| is_buffer_backed_interface_block_storage(b.storage));

                if !is_atomic_counter_uniform && !is_buffer_backed_block_storage {
                    // Not buffer backed
                    log::debug!("Verifying offset, expecting -1");
                    if prop_value != -1 {
                        log::debug!("\tError, invalid offset, got {prop_value}");
                        v.set_error("offset invalid");
                    }
                } else {
                    // Expect a valid offset
                    log::debug!("Verifying offset, expecting a valid offset");
                    if prop_value < 0 {
                        log::debug!("\tError, invalid offset, got {prop_value}");
                        v.set_error("offset invalid");
                    }
                }
            },
            || unreachable!("no builtin offset"),
        );
    }
}

/// `VariableReferencedByShaderValidator`
struct VariableReferencedByShaderValidator {
    filter: VariableSearchFilter,
    shader_type: ShaderType,
}

impl VariableReferencedByShaderValidator {
    fn new(shader_type: ShaderType, search_filter: VariableSearchFilter) -> Self {
        Self {
            filter: VariableSearchFilter::shader_type(shader_type).and(search_filter),
            shader_type,
        }
    }
}

impl PropValidator for VariableReferencedByShaderValidator {
    fn prop(&self) -> u32 {
        prop::REFERENCED_BY_SHADER
    }

    fn extension(&self) -> Option<&'static str> {
        required_extension_for_stage(self.shader_type)
    }

    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        boolean_str(prop_val)
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        let referenced_by_shader = find_program_variable_path_by_path_name(program, resource, &self.filter).is_some();
        let stage = self.shader_type.as_str();

        log::debug!(
            "Verifying referenced by {stage} shader, expecting {}",
            if referenced_by_shader { "GL_TRUE" } else { "GL_FALSE" }
        );

        if prop_value != i32::from(referenced_by_shader) {
            log::debug!("\tError, invalid referenced_by_{stage}, got {prop_value}");
            v.set_error(format!("referenced_by_{stage} invalid"));
        }
    }
}

/// `BlockNameLengthValidator`
struct BlockNameLengthValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for BlockNameLengthValidator {
    fn prop(&self) -> u32 {
        prop::NAME_LENGTH
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        implementation_name: &str,
    ) {
        validate_single_block(v, program, resource, &self.filter, |_block, _instance_index| {
            validate_name_length(v, implementation_name, prop_value, "name length invalid");
        });
    }
}

/// `BufferBindingValidator`
struct BufferBindingValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for BufferBindingValidator {
    fn prop(&self) -> u32 {
        prop::BUFFER_BINDING
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_block(v, program, resource, &self.filter, |block, instance_index| {
            let Some(binding) = block.layout.binding else {
                log::debug!("Verifying buffer binding, expecting a valid binding");
                if prop_value < 0 {
                    log::debug!("\tError, invalid buffer binding, got {prop_value}");
                    v.set_error("buffer binding invalid");
                }
                return;
            };

            let mut flat_index = 0;
            let mut dimension_size = 1;
            for dimension_ndx in (0..block.dimensions.len()).rev() {
                flat_index += dimension_size * instance_index[dimension_ndx];
                dimension_size *= block.dimensions[dimension_ndx];
            }

            let expected = if block.dimensions.is_empty() {
                binding
            } else {
                binding + flat_index
            };
            log::debug!("Verifying block binding, expecting {expected}");

            if prop_value != expected {
                log::debug!("\tError, invalid buffer binding, got {prop_value}");
                v.set_error("buffer binding invalid");
            }
        });
    }
}

/// `BlockReferencedByShaderValidator`
struct BlockReferencedByShaderValidator {
    filter: VariableSearchFilter,
    shader_type: ShaderType,
}

impl BlockReferencedByShaderValidator {
    fn new(shader_type: ShaderType, search_filter: VariableSearchFilter) -> Self {
        Self {
            filter: VariableSearchFilter::shader_type(shader_type).and(search_filter),
            shader_type,
        }
    }
}

impl PropValidator for BlockReferencedByShaderValidator {
    fn prop(&self) -> u32 {
        prop::REFERENCED_BY_SHADER
    }

    fn extension(&self) -> Option<&'static str> {
        required_extension_for_stage(self.shader_type)
    }

    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        boolean_str(prop_val)
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        let block_name = crate::glu::var_type::parse_variable_name(resource);
        let mut referenced_by_shader = false;

        for shader in program.shaders() {
            if !self.filter.matches_shader(shader) {
                continue;
            }

            for block in &shader.default_block.interface_blocks {
                if self.filter.matches_block(block) && block.interface_name == block_name {
                    referenced_by_shader = true;
                }
            }
        }

        let stage = self.shader_type.as_str();
        log::debug!(
            "Verifying referenced by {stage} shader, expecting {}",
            if referenced_by_shader { "GL_TRUE" } else { "GL_FALSE" }
        );

        if prop_value != i32::from(referenced_by_shader) {
            log::debug!("\tError, invalid referenced_by_{stage}, got {prop_value}");
            v.set_error(format!("referenced_by_{stage} invalid"));
        }
    }
}

/// `TopLevelArraySizeValidator`
struct TopLevelArraySizeValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for TopLevelArraySizeValidator {
    fn prop(&self) -> u32 {
        prop::TOP_LEVEL_ARRAY_SIZE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let top_level = &path[1].declaration().expect("a declaration").var_type;

                let (expected, reason) = if !top_level.is_array_type() {
                    (1, "Top-level block member is not an array")
                } else if top_level.element_type().is_basic_type() {
                    (1, "Top-level block member is not an array of an aggregate type")
                } else if top_level.array_size() == UNSIZED_ARRAY {
                    (0, "Top-level block member is an unsized top-level array")
                } else {
                    (
                        top_level.array_size(),
                        "Top-level block member is a sized top-level array",
                    )
                };

                log::debug!("Verifying top level array size, expecting {expected}. ({reason}).");
                if prop_value != expected {
                    log::debug!("\tError, invalid top level array size, got {prop_value}");
                    v.set_error("top level array size invalid");
                }
            },
            || unreachable!("no builtin top level array size"),
        );
    }
}

/// `TopLevelArrayStrideValidator`
struct TopLevelArrayStrideValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for TopLevelArrayStrideValidator {
    fn prop(&self) -> u32 {
        prop::TOP_LEVEL_ARRAY_STRIDE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let top_level = &path[1].declaration().expect("a declaration").var_type;

                if !top_level.is_array_type() {
                    log::debug!(
                        "Verifying top level array stride, expecting 0. (Top-level block member is not an array)."
                    );
                    if prop_value != 0 {
                        log::debug!("\tError, top level array stride, got {prop_value}");
                        v.set_error("top level array stride invalid");
                    }
                } else if top_level.element_type().is_basic_type() {
                    log::debug!(
                        "Verifying top level array stride, expecting 0. (Top-level block member is not an array of an aggregate type)."
                    );
                    if prop_value != 0 {
                        log::debug!("\tError, top level array stride, got {prop_value}");
                        v.set_error("top level array stride invalid");
                    }
                } else {
                    let minimum_stride = var_type_size(top_level.element_type());
                    log::debug!("Verifying top level array stride, expecting greater or equal to {minimum_stride}.");
                    if prop_value < minimum_stride {
                        log::debug!("\tError, invalid top level array stride, got {prop_value}");
                        v.set_error("top level array stride invalid");
                    }
                }
            },
            || unreachable!("no builtin top level array stride"),
        );
    }
}

/// `TransformFeedbackResourceValidator::validate` - an xfb resource is either a builtin or
/// a variable reachable from the feedback stage's outputs.
fn validate_transform_feedback_resource(
    v: &Validation<'_>,
    program: &Program,
    resource: &str,
    on_variable: impl FnOnce(&[VariablePathComponent]),
    on_builtin: impl FnOnce(),
) {
    use crate::gles31::functional::program_interface_definition_util::program_transform_feedback_stage;

    if resource.starts_with("gl_") {
        on_builtin();
        return;
    }

    let stage = program_transform_feedback_stage(program).expect("a program with varyings has an output stage");
    let path = find_program_variable_path_by_path_name(
        program,
        resource,
        &VariableSearchFilter::shader_type_storage(stage, Storage::Out),
    )
    .expect("the xfb resource names come from the program definition itself");

    let _ = v;
    on_variable(&path);
}

/// `TransformFeedbackArraySizeValidator`
struct TransformFeedbackArraySizeValidator;

impl PropValidator for TransformFeedbackArraySizeValidator {
    fn prop(&self) -> u32 {
        prop::ARRAY_SIZE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        let check = |array_size: i32| {
            log::debug!("Verifying array size, expecting {array_size}");
            if array_size != prop_value {
                log::debug!("\tError, got {prop_value}");
                v.set_error("resource array size invalid");
            }
        };

        validate_transform_feedback_resource(
            v,
            program,
            resource,
            |path| {
                let ty = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a type");
                check(if ty.is_array_type() { ty.array_size() } else { 1 });
            },
            || {
                assert_eq!(resource, "gl_Position", "the only builtin xfb varying");
                check(1);
            },
        );
    }
}

/// `TransformFeedbackNameLengthValidator`
struct TransformFeedbackNameLengthValidator;

impl PropValidator for TransformFeedbackNameLengthValidator {
    fn prop(&self) -> u32 {
        prop::NAME_LENGTH
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        implementation_name: &str,
    ) {
        validate_transform_feedback_resource(
            v,
            program,
            resource,
            |_path| validate_name_length(v, implementation_name, prop_value, "name length invalid"),
            || validate_name_length(v, implementation_name, prop_value, "name length invalid"),
        );
    }
}

/// `TransformFeedbackTypeValidator`
struct TransformFeedbackTypeValidator;

impl PropValidator for TransformFeedbackTypeValidator {
    fn prop(&self) -> u32 {
        prop::TYPE
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        let check = |expected: DataType| {
            log::debug!("Verifying type, expecting {}", expected.name());
            if expected != get_data_type_from_gl_type(prop_value as GLenum) {
                log::debug!(
                    "\tError, got {}",
                    get_data_type_from_gl_type(prop_value as GLenum).name()
                );
                v.set_error("resource type invalid");
            }
        };

        validate_transform_feedback_resource(
            v,
            program,
            resource,
            |path| {
                // Unlike the other interfaces, the xfb interface refers to an array of a
                // basic type by the bare variable name (the others use "variable[0]"), so
                // the type queried here can be the array - answer for its element.
                let variable = path
                    .last()
                    .and_then(VariablePathComponent::variable_type)
                    .expect("a type");
                let element_type = if variable.is_array_type() {
                    variable.element_type()
                } else {
                    variable
                };
                check(element_type.basic_type());
            },
            || {
                assert_eq!(resource, "gl_Position", "the only builtin xfb varying");
                check(DataType::FloatVec4);
            },
        );
    }
}

/// `PerPatchValidator`
struct PerPatchValidator {
    filter: VariableSearchFilter,
}

impl PropValidator for PerPatchValidator {
    fn prop(&self) -> u32 {
        prop::IS_PER_PATCH
    }

    fn extension(&self) -> Option<&'static str> {
        Some("GL_EXT_tessellation_shader")
    }

    fn human_readable_property_string(&self, prop_val: GLint) -> String {
        boolean_str(prop_val)
    }

    fn validate(
        &self,
        v: &Validation<'_>,
        program: &Program,
        resource: &str,
        prop_value: GLint,
        _implementation_name: &str,
    ) {
        const BUILTINS: &[Builtin<i32>] = &[
            Builtin {
                name: "gl_Position",
                value: 0,
            },
            Builtin {
                name: "gl_PerVertex.gl_Position",
                value: 0,
            },
            Builtin {
                name: "gl_InvocationID",
                value: 0,
            },
            Builtin {
                name: "gl_TessLevelOuter[0]",
                value: 1,
            },
            Builtin {
                name: "gl_TessLevelInner[0]",
                value: 1,
            },
        ];

        let check = |expected: i32| {
            log::debug!("Verifying if is per patch, expecting IS_PER_PATCH = {expected}");
            if prop_value != expected {
                log::debug!("\tError, got {prop_value}");
                v.set_error("resource is per patch invalid");
            }
        };

        validate_single_variable(
            v,
            program,
            resource,
            &self.filter,
            |path| {
                let storage = match &path[0] {
                    VariablePathComponent::InterfaceBlock(block) => block.storage,
                    _ => path[0].declaration().expect("a declaration").storage,
                };
                check(i32::from(matches!(storage, Some(Storage::PatchIn | Storage::PatchOut))));
            },
            || check(builtin_value(BUILTINS, resource)),
        );
    }
}

// The query driver.

/// `getGLInterfaceEnumValue`
fn gl_interface_enum_value(interface: ProgramInterface) -> GLenum {
    match interface {
        ProgramInterface::Uniform => glw::GL_UNIFORM,
        ProgramInterface::UniformBlock => glw::GL_UNIFORM_BLOCK,
        ProgramInterface::AtomicCounterBuffer => glw::GL_ATOMIC_COUNTER_BUFFER,
        ProgramInterface::ProgramInput => glw::GL_PROGRAM_INPUT,
        ProgramInterface::ProgramOutput => glw::GL_PROGRAM_OUTPUT,
        ProgramInterface::TransformFeedbackVarying => glw::GL_TRANSFORM_FEEDBACK_VARYING,
        ProgramInterface::BufferVariable => glw::GL_BUFFER_VARIABLE,
        ProgramInterface::ShaderStorageBlock => glw::GL_SHADER_STORAGE_BLOCK,
    }
}

/// The storage qualifiers and stages an interface's blocks can live in, shared by the two
/// name-recovery helpers below.
fn interface_search_bits(program: &Program, interface: ProgramInterface) -> Option<(Vec<Storage>, Option<ShaderType>)> {
    use crate::gles31::functional::program_interface_definition_util::program_transform_feedback_stage;

    match interface {
        ProgramInterface::UniformBlock
        | ProgramInterface::ShaderStorageBlock
        | ProgramInterface::AtomicCounterBuffer => None,
        ProgramInterface::ProgramInput => Some((vec![Storage::In, Storage::PatchIn], program.first_stage())),
        ProgramInterface::ProgramOutput => Some((vec![Storage::Out, Storage::PatchOut], program.last_stage())),
        ProgramInterface::TransformFeedbackVarying => {
            Some((vec![Storage::Out], program_transform_feedback_stage(program)))
        }
        ProgramInterface::Uniform => Some((vec![Storage::Uniform], None)),
        ProgramInterface::BufferVariable => Some((vec![Storage::Buffer], None)),
    }
}

/// Whether `block_interface_name` names an interface block of this interface. The stage is
/// `None` for the two interfaces that search every stage.
fn matching_blocks(program: &Program, interface: ProgramInterface) -> Vec<&InterfaceBlock> {
    let Some((valid_storages, search_stage)) = interface_search_bits(program, interface) else {
        return Vec::new();
    };

    let mut blocks = Vec::new();
    for shader in program.shaders() {
        if search_stage.is_some_and(|stage| shader.shader_type() != stage) {
            continue;
        }

        for block in &shader.default_block.interface_blocks {
            if block.storage.is_some_and(|s| valid_storages.contains(&s)) {
                blocks.push(block);
            }
        }
    }
    blocks
}

/// `isInterfaceBlockInterfaceName`
fn is_interface_block_interface_name(
    program: &Program,
    interface: ProgramInterface,
    block_interface_name: &str,
) -> bool {
    matching_blocks(program, interface)
        .iter()
        .any(|b| b.interface_name == block_interface_name)
}

/// `getInterfaceBlockInteraceNameByMember`
fn interface_block_interface_name_by_member(
    program: &Program,
    interface: ProgramInterface,
    member_name: &str,
) -> String {
    for block in matching_blocks(program, interface) {
        if block.variables.iter().any(|v| v.name == member_name) {
            return block.interface_name.clone();
        }
    }
    String::new()
}

/// One of upstream's `recoveryStrategies` rows: a driver whose resource-name generation is
/// broken often answers to a name that differs from the spec's by one of these edits.
#[derive(Clone, Copy)]
struct RecoveryStrategy {
    /// "target[0]" -> "target"
    remove_trailing_array: bool,
    /// "target.member" -> "target"
    remove_trailing_member: bool,
    /// "InterfaceName.target" -> "target"
    remove_io_block: bool,
    /// "target" -> "InterfaceName.target"
    add_io_block: bool,
    /// "target" -> "InterfaceName[0].target"
    add_io_block_array: bool,
}

const RECOVERY_STRATEGIES: &[RecoveryStrategy] = &[
    // try one patch
    RecoveryStrategy {
        remove_trailing_array: true,
        remove_trailing_member: false,
        remove_io_block: false,
        add_io_block: false,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: true,
        remove_io_block: false,
        add_io_block: false,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: false,
        remove_io_block: true,
        add_io_block: false,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: false,
        remove_io_block: false,
        add_io_block: true,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: false,
        remove_io_block: false,
        add_io_block: false,
        add_io_block_array: true,
    },
    // patch both ends
    RecoveryStrategy {
        remove_trailing_array: true,
        remove_trailing_member: false,
        remove_io_block: true,
        add_io_block: false,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: true,
        remove_trailing_member: false,
        remove_io_block: false,
        add_io_block: true,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: true,
        remove_trailing_member: false,
        remove_io_block: false,
        add_io_block: false,
        add_io_block_array: true,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: true,
        remove_io_block: true,
        add_io_block: false,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: true,
        remove_io_block: false,
        add_io_block: true,
        add_io_block_array: false,
    },
    RecoveryStrategy {
        remove_trailing_array: false,
        remove_trailing_member: true,
        remove_io_block: false,
        add_io_block: false,
        add_io_block_array: true,
    },
];

/// The name `strategy` would have the driver answer to, if it applies at all.
fn recovered_resource_name(
    strategy: RecoveryStrategy,
    program: &Program,
    interface: ProgramInterface,
    resource_name: &str,
) -> Option<String> {
    let root_name_end = resource_name.find(['.', '[']).unwrap_or(resource_name.len());
    let root_name = &resource_name[..root_name_end];
    let mut simplified = String::new();

    if strategy.remove_trailing_array {
        simplified = resource_name.strip_suffix("[0]")?.to_string();
    }

    if strategy.remove_trailing_member {
        let last_member = resource_name.rfind('.')?;
        simplified = resource_name[..last_member].to_string();
    }

    if strategy.remove_io_block {
        if let Some(tail) = resource_name.strip_prefix("gl_PerVertex.") {
            // builtin interface block, remove block name
            simplified = tail.to_string();
        } else if is_interface_block_interface_name(program, interface, root_name) {
            // user-defined interface block, remove name. \note upstream keeps the
            // separator, which is what makes this differ from the builtin case above.
            let accessor_end = resource_name.find('.')?;
            simplified = resource_name[..accessor_end + 1].to_string();
        } else {
            // recovery not applicable
            return None;
        }
    }

    if strategy.add_io_block || strategy.add_io_block_array {
        let array_accessor = if strategy.add_io_block_array { "[0]" } else { "" };

        if resource_name.starts_with("gl_") && !resource_name.contains('.') {
            // free builtin variable, add block name
            simplified = format!("gl_PerVertex{array_accessor}.{resource_name}");
        } else {
            let interface_name = interface_block_interface_name_by_member(program, interface, root_name);
            if interface_name.is_empty() {
                // recovery not applicable
                return None;
            }
            // free user variable, add block name
            simplified = format!("{interface_name}{array_accessor}.{resource_name}");
        }
    }

    if simplified.is_empty() { None } else { Some(simplified) }
}

/// `glu::getProgramResourcePropertyName` - the handful of properties this suite queries.
fn program_resource_property_name(prop: GLenum) -> &'static str {
    match prop {
        glw::GL_ARRAY_SIZE => "GL_ARRAY_SIZE",
        glw::GL_ARRAY_STRIDE => "GL_ARRAY_STRIDE",
        glw::GL_ATOMIC_COUNTER_BUFFER_INDEX => "GL_ATOMIC_COUNTER_BUFFER_INDEX",
        glw::GL_BLOCK_INDEX => "GL_BLOCK_INDEX",
        glw::GL_BUFFER_BINDING => "GL_BUFFER_BINDING",
        glw::GL_IS_ROW_MAJOR => "GL_IS_ROW_MAJOR",
        glw::GL_IS_PER_PATCH => "GL_IS_PER_PATCH",
        glw::GL_LOCATION => "GL_LOCATION",
        glw::GL_MATRIX_STRIDE => "GL_MATRIX_STRIDE",
        glw::GL_NAME_LENGTH => "GL_NAME_LENGTH",
        glw::GL_OFFSET => "GL_OFFSET",
        glw::GL_REFERENCED_BY_VERTEX_SHADER => "GL_REFERENCED_BY_VERTEX_SHADER",
        glw::GL_REFERENCED_BY_FRAGMENT_SHADER => "GL_REFERENCED_BY_FRAGMENT_SHADER",
        glw::GL_REFERENCED_BY_COMPUTE_SHADER => "GL_REFERENCED_BY_COMPUTE_SHADER",
        glw::GL_REFERENCED_BY_GEOMETRY_SHADER => "GL_REFERENCED_BY_GEOMETRY_SHADER",
        glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER => "GL_REFERENCED_BY_TESS_CONTROL_SHADER",
        glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER => "GL_REFERENCED_BY_TESS_EVALUATION_SHADER",
        glw::GL_TOP_LEVEL_ARRAY_SIZE => "GL_TOP_LEVEL_ARRAY_SIZE",
        glw::GL_TOP_LEVEL_ARRAY_STRIDE => "GL_TOP_LEVEL_ARRAY_STRIDE",
        glw::GL_TYPE => "GL_TYPE",
        _ => "(unknown property)",
    }
}

/// `queryAndValidateProps`
fn query_and_validate_props(
    v: &Validation<'_>,
    interface: ProgramInterface,
    target_resource_name: &str,
    program_definition: &Program,
    props: &[GLenum],
    validators: &[&dyn PropValidator],
) {
    let gl_interface = gl_interface_enum_value(interface);
    let mut implementation_resource_name = target_resource_name.to_string();
    debug_assert_eq!(props.len(), validators.len());

    // query
    let mut resource_ndx = v.program_resource_index(gl_interface, target_resource_name);

    if resource_ndx == glw::GL_INVALID_INDEX {
        // The resource name generation in GL implementations is very commonly broken. Try
        // to keep the test producing useful data even then by recovering from the common
        // naming bugs, but still fail the case: the name really was wrong.
        log::debug!("getProgramResourceIndex returned GL_INVALID_INDEX for \"{target_resource_name}\"");
        v.set_error("could not find target resource");

        for &strategy in RECOVERY_STRATEGIES {
            let Some(simplified) =
                recovered_resource_name(strategy, program_definition, interface, target_resource_name)
            else {
                continue;
            };

            resource_ndx = v.program_resource_index(gl_interface, &simplified);

            // recovery succeeded
            if resource_ndx != glw::GL_INVALID_INDEX {
                log::debug!(
                    "\tResource not found, continuing anyway using index obtained for resource \"{simplified}\""
                );
                implementation_resource_name = simplified;
                break;
            }
        }

        if resource_ndx == glw::GL_INVALID_INDEX {
            return;
        }
    }

    // Prefill the result buffer with a value that is never valid, and make it one larger
    // than asked for so too many return values is detectable.
    let mut prop_values = vec![-2 as GLint; props.len() + 1];
    let mut written: glw::GLsizei = -1;

    // SAFETY: `props.len()` properties in, `prop_values.len()` slots out, and the driver
    // reports how many it wrote.
    unsafe {
        v.gl().get_program_resourceiv(
            v.program_id,
            gl_interface,
            resource_ndx,
            props.len() as glw::GLsizei,
            props.as_ptr(),
            prop_values.len() as glw::GLsizei,
            &mut written,
            prop_values.as_mut_ptr(),
        );
    }

    if written != props.len() as glw::GLsizei {
        log::debug!(
            "getProgramResourceiv returned unexpected number of values, expected {}, got {written}",
            props.len()
        );
        v.set_error("getProgramResourceiv returned unexpected number of values");
        return;
    }

    if prop_values[props.len()] != -2 {
        log::debug!("getProgramResourceiv post write buffer guard value was modified, too many return values");
        v.set_error("getProgramResourceiv returned unexpected number of values");
        return;
    }
    prop_values.pop();

    // log
    log::debug!("For resource index {resource_ndx} (\"{target_resource_name}\") got following properties:");
    for (ndx, &prop_value) in prop_values.iter().enumerate() {
        log::debug!(
            "\t{}:\t{}",
            program_resource_property_name(props[ndx]),
            validators[ndx].human_readable_property_string(prop_value)
        );
    }

    // validate
    for (ndx, &prop_value) in prop_values.iter().enumerate() {
        validators[ndx].validate(
            v,
            program_definition,
            target_resource_name,
            prop_value,
            &implementation_resource_name,
        );
    }
}

impl Validation<'_> {
    /// `gl.getProgramResourceIndex(...)`
    fn program_resource_index(&self, interface: GLenum, name: &str) -> GLuint {
        let name = std::ffi::CString::new(name).expect("a resource name has no interior NUL");
        // SAFETY: the name outlives the call.
        unsafe {
            self.gl()
                .get_program_resource_index(self.program_id, interface, name.as_ptr())
        }
    }
}

/// `getProgramDefinition` - the program a case queries.
type BuildProgramFn = Box<dyn Fn(crate::glu::GlslVersion) -> Program + Send + Sync>;

/// `getQueryTargetResources` - which of that program's resources it asks about.
type TargetResourcesFn = Box<dyn Fn(&Program) -> Vec<String> + Send + Sync>;

/// `ProgramInterfaceQueryTestCase` - upstream's two pure virtuals are closures here, since
/// every subclass in the test tree only differs in what program it builds and which of its
/// resources it asks about.
pub struct ProgramInterfaceQueryTestCase {
    name: String,
    query_target: ProgramResourceQueryTestTarget,
    build_program: BuildProgramFn,
    target_resources: Option<TargetResourcesFn>,
}

impl ProgramInterfaceQueryTestCase {
    pub fn new(
        name: impl Into<String>,
        query_target: ProgramResourceQueryTestTarget,
        build_program: impl Fn(crate::glu::GlslVersion) -> Program + Send + Sync + 'static,
    ) -> Self {
        Self {
            name: name.into(),
            query_target,
            build_program: Box::new(build_program),
            target_resources: None,
        }
    }

    /// `getQueryTargetResources` - the default is every resource the interface has.
    pub fn with_target_resources(
        mut self,
        resources: impl Fn(&Program) -> Vec<String> + Send + Sync + 'static,
    ) -> Self {
        self.target_resources = Some(Box::new(resources));
        self
    }

    pub fn target_interface(&self) -> ProgramInterface {
        self.query_target.interface
    }

    /// `getAndCheckProgramDefinition`
    fn check_program_definition(&self, context: &Context, program: &Program) -> Result<(), crate::tcu::TestError> {
        use crate::gles31::functional::program_interface_definition_util::program_contains_io_blocks;
        use crate::tcu::TestError;

        debug_assert!(program.is_valid());

        if context.context_type().supports(3, 2) {
            return Ok(());
        }

        if (program.has_stage(ShaderType::TessControl) || program.has_stage(ShaderType::TessEvaluation))
            && !context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader extension".to_string(),
            ));
        }

        // Testing IS_PER_PATCH as part of a larger set is fine - the extension is checked
        // before the query - but an IS_PER_PATCH-specific test must not become a no-op pass.
        if self.query_target.prop_flags == prop::IS_PER_PATCH
            && !context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader extension".to_string(),
            ));
        }

        if program.has_stage(ShaderType::Geometry)
            && !context.context_info.is_extension_supported("GL_EXT_geometry_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_geometry_shader extension".to_string(),
            ));
        }

        if program_contains_io_blocks(program)
            && !context.context_info.is_extension_supported("GL_EXT_shader_io_blocks")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_shader_io_blocks extension".to_string(),
            ));
        }

        Ok(())
    }
}

/// `getMaxPatchVertices`
fn max_patch_vertices(context: &Context) -> i32 {
    let mut value: GLint = 0;
    // SAFETY: one GLint out.
    unsafe { context.gl().get_integerv(glw::GL_MAX_PATCH_VERTICES, &mut value) };
    value
}

/// One entry of upstream's `allProperties` table: the GL property and the validator that
/// knows what it should be.
struct TestProperty<'a> {
    prop: GLenum,
    validator: &'a dyn PropValidator,
}

/// The properties this case actually asks for: the ones it selected that the context also
/// supports.
fn selected_properties<'a>(
    all: &'a [TestProperty<'a>],
    v: &Validation<'_>,
    prop_flags: u32,
) -> (Vec<GLenum>, Vec<&'a dyn PropValidator>) {
    let mut props = Vec::new();
    let mut validators: Vec<&dyn PropValidator> = Vec::new();

    for entry in all {
        if entry.validator.is_selected(prop_flags) && entry.validator.is_supported(v) {
            props.push(entry.prop);
            validators.push(entry.validator);
        }
    }

    (props, validators)
}

/// The six `REFERENCED_BY_*_SHADER` properties, which every variable-backed interface asks
/// about in the same order.
const REFERENCED_BY_STAGES: [(GLenum, ShaderType); 6] = [
    (glw::GL_REFERENCED_BY_VERTEX_SHADER, ShaderType::Vertex),
    (glw::GL_REFERENCED_BY_FRAGMENT_SHADER, ShaderType::Fragment),
    (glw::GL_REFERENCED_BY_COMPUTE_SHADER, ShaderType::Compute),
    (glw::GL_REFERENCED_BY_GEOMETRY_SHADER, ShaderType::Geometry),
    (glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER, ShaderType::TessControl),
    (glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER, ShaderType::TessEvaluation),
];

impl crate::glu::TestCase for ProgramInterfaceQueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> crate::tcu::TestOutcome {
        use crate::glu::ShaderProgram;
        use crate::tcu::{TestError, TestStatus};

        let program_definition = (self.build_program)(context.context_type().glsl_version());
        self.check_program_definition(context, &program_definition)?;

        let target_resources = match &self.target_resources {
            Some(f) => f(&program_definition),
            None => crate::gles31::functional::program_interface_definition_util::program_interface_resource_list(
                &program_definition,
                self.query_target.interface,
            ),
        };

        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);

        if !program_definition.transform_feedback_varyings().is_empty() {
            log::debug!(
                "Transform feedback varyings: {{{}}}",
                program_definition
                    .transform_feedback_varyings()
                    .iter()
                    .map(|v| format!("\"{v}\""))
                    .collect::<Vec<_>>()
                    .join(", ")
            );
        }

        if !program.is_ok() {
            log::debug!("Program build failed, checking if program exceeded implementation limits");
            check_program_resource_usage(&program_definition, context)?;

            // within limits
            return Err(TestError::Fail("could not build program".to_string()));
        }

        let v = Validation::new(context, program.program());

        match self.query_target.interface {
            ProgramInterface::Uniform => {
                let filter = VariableSearchFilter::storage(Storage::Uniform);
                let type_validator = TypeValidator { filter };
                let array_size_validator = ArraySizeValidator {
                    unsized_array_size: -1,
                    filter,
                };
                let array_stride_validator = ArrayStrideValidator { filter };
                let block_index_validator = BlockIndexValidator { filter };
                let is_row_major_validator = IsRowMajorValidator { filter };
                let matrix_stride_validator = MatrixStrideValidator { filter };
                let atomic_counter_buffer_index_verifier = AtomicCounterBufferIndexVerifier { filter };
                let location_validator = LocationValidator { filter };
                let name_length_validator = VariableNameLengthValidator { filter };
                let offset_verifier = OffsetValidator { filter };
                let referenced_by: Vec<_> = REFERENCED_BY_STAGES
                    .iter()
                    .map(|&(_, stage)| VariableReferencedByShaderValidator::new(stage, filter))
                    .collect();

                let mut all_properties = vec![
                    TestProperty {
                        prop: glw::GL_ARRAY_SIZE,
                        validator: &array_size_validator,
                    },
                    TestProperty {
                        prop: glw::GL_ARRAY_STRIDE,
                        validator: &array_stride_validator,
                    },
                    TestProperty {
                        prop: glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
                        validator: &atomic_counter_buffer_index_verifier,
                    },
                    TestProperty {
                        prop: glw::GL_BLOCK_INDEX,
                        validator: &block_index_validator,
                    },
                    TestProperty {
                        prop: glw::GL_IS_ROW_MAJOR,
                        validator: &is_row_major_validator,
                    },
                    TestProperty {
                        prop: glw::GL_LOCATION,
                        validator: &location_validator,
                    },
                    TestProperty {
                        prop: glw::GL_MATRIX_STRIDE,
                        validator: &matrix_stride_validator,
                    },
                    TestProperty {
                        prop: glw::GL_NAME_LENGTH,
                        validator: &name_length_validator,
                    },
                    TestProperty {
                        prop: glw::GL_OFFSET,
                        validator: &offset_verifier,
                    },
                ];
                for (ndx, &(prop_enum, _)) in REFERENCED_BY_STAGES.iter().enumerate() {
                    all_properties.push(TestProperty {
                        prop: prop_enum,
                        validator: &referenced_by[ndx],
                    });
                }
                all_properties.push(TestProperty {
                    prop: glw::GL_TYPE,
                    validator: &type_validator,
                });

                for resource in &target_resources {
                    log::debug!("Uniform resource \"{resource}\"");
                    let (props, validators) = selected_properties(&all_properties, &v, self.query_target.prop_flags);
                    debug_assert!(!props.is_empty());
                    query_and_validate_props(
                        &v,
                        self.query_target.interface,
                        resource,
                        &program_definition,
                        &props,
                        &validators,
                    );
                }
            }

            ProgramInterface::UniformBlock | ProgramInterface::ShaderStorageBlock => {
                let storage = if self.query_target.interface == ProgramInterface::UniformBlock {
                    Storage::Uniform
                } else {
                    Storage::Buffer
                };
                let filter = VariableSearchFilter::storage(storage);
                let name_length_validator = BlockNameLengthValidator { filter };
                let buffer_binding_validator = BufferBindingValidator { filter };
                let referenced_by: Vec<_> = REFERENCED_BY_STAGES
                    .iter()
                    .map(|&(_, stage)| BlockReferencedByShaderValidator::new(stage, filter))
                    .collect();

                let mut all_properties = vec![TestProperty {
                    prop: glw::GL_NAME_LENGTH,
                    validator: &name_length_validator,
                }];
                for (ndx, &(prop_enum, _)) in REFERENCED_BY_STAGES.iter().enumerate() {
                    all_properties.push(TestProperty {
                        prop: prop_enum,
                        validator: &referenced_by[ndx],
                    });
                }
                all_properties.push(TestProperty {
                    prop: glw::GL_BUFFER_BINDING,
                    validator: &buffer_binding_validator,
                });

                for resource in &target_resources {
                    log::debug!("Interface block \"{resource}\"");
                    let (props, validators) = selected_properties(&all_properties, &v, self.query_target.prop_flags);
                    debug_assert!(!props.is_empty());
                    query_and_validate_props(
                        &v,
                        self.query_target.interface,
                        resource,
                        &program_definition,
                        &props,
                        &validators,
                    );
                }
            }

            ProgramInterface::ProgramInput | ProgramInterface::ProgramOutput => {
                let is_input_case = self.query_target.interface == ProgramInterface::ProgramInput;
                let varying_storage = if is_input_case { Storage::In } else { Storage::Out };
                let patch_storage = if is_input_case {
                    Storage::PatchIn
                } else {
                    Storage::PatchOut
                };
                let shader_type = if is_input_case {
                    program_definition.first_stage()
                } else {
                    program_definition.last_stage()
                };

                let unsized_array_size = match (is_input_case, shader_type) {
                    // input points
                    (true, Some(ShaderType::Geometry)) => 1,
                    // input batch size
                    (true, Some(ShaderType::TessControl | ShaderType::TessEvaluation)) => max_patch_vertices(context),
                    // output batch size
                    (false, Some(ShaderType::TessControl)) => {
                        program_definition.tessellation_num_output_patch_vertices() as i32
                    }
                    _ => -1,
                };

                let filter = VariableSearchFilter::shader_type(shader_type.expect("a program has stages")).and(
                    VariableSearchFilter::storage(varying_storage).or(VariableSearchFilter::storage(patch_storage)),
                );

                let type_validator = TypeValidator { filter };
                let array_size_validator = ArraySizeValidator {
                    unsized_array_size,
                    filter,
                };
                let location_validator = LocationValidator { filter };
                let name_length_validator = VariableNameLengthValidator { filter };
                let per_patch_validator = PerPatchValidator { filter };
                let referenced_by: Vec<_> = REFERENCED_BY_STAGES
                    .iter()
                    .map(|&(_, stage)| VariableReferencedByShaderValidator::new(stage, filter))
                    .collect();

                let mut all_properties = vec![
                    TestProperty {
                        prop: glw::GL_ARRAY_SIZE,
                        validator: &array_size_validator,
                    },
                    TestProperty {
                        prop: glw::GL_LOCATION,
                        validator: &location_validator,
                    },
                    TestProperty {
                        prop: glw::GL_NAME_LENGTH,
                        validator: &name_length_validator,
                    },
                ];
                for (ndx, &(prop_enum, _)) in REFERENCED_BY_STAGES.iter().enumerate() {
                    all_properties.push(TestProperty {
                        prop: prop_enum,
                        validator: &referenced_by[ndx],
                    });
                }
                all_properties.push(TestProperty {
                    prop: glw::GL_TYPE,
                    validator: &type_validator,
                });
                all_properties.push(TestProperty {
                    prop: glw::GL_IS_PER_PATCH,
                    validator: &per_patch_validator,
                });

                let resource_interface_name = if is_input_case { "Input" } else { "Output" };
                for resource in &target_resources {
                    log::debug!("{resource_interface_name} resource \"{resource}\"");
                    let (props, validators) = selected_properties(&all_properties, &v, self.query_target.prop_flags);
                    debug_assert!(!props.is_empty());
                    query_and_validate_props(
                        &v,
                        self.query_target.interface,
                        resource,
                        &program_definition,
                        &props,
                        &validators,
                    );
                }
            }

            ProgramInterface::BufferVariable => {
                let filter = VariableSearchFilter::storage(Storage::Buffer);
                let type_validator = TypeValidator { filter };
                let array_size_validator = ArraySizeValidator {
                    unsized_array_size: 0,
                    filter,
                };
                let array_stride_validator = ArrayStrideValidator { filter };
                let block_index_validator = BlockIndexValidator { filter };
                let is_row_major_validator = IsRowMajorValidator { filter };
                let matrix_stride_validator = MatrixStrideValidator { filter };
                let offset_validator = OffsetValidator { filter };
                let name_length_validator = VariableNameLengthValidator { filter };
                let top_level_array_size_validator = TopLevelArraySizeValidator { filter };
                let top_level_array_stride_validator = TopLevelArrayStrideValidator { filter };
                let referenced_by: Vec<_> = REFERENCED_BY_STAGES
                    .iter()
                    .map(|&(_, stage)| VariableReferencedByShaderValidator::new(stage, filter))
                    .collect();

                let mut all_properties = vec![
                    TestProperty {
                        prop: glw::GL_ARRAY_SIZE,
                        validator: &array_size_validator,
                    },
                    TestProperty {
                        prop: glw::GL_ARRAY_STRIDE,
                        validator: &array_stride_validator,
                    },
                    TestProperty {
                        prop: glw::GL_BLOCK_INDEX,
                        validator: &block_index_validator,
                    },
                    TestProperty {
                        prop: glw::GL_IS_ROW_MAJOR,
                        validator: &is_row_major_validator,
                    },
                    TestProperty {
                        prop: glw::GL_MATRIX_STRIDE,
                        validator: &matrix_stride_validator,
                    },
                    TestProperty {
                        prop: glw::GL_NAME_LENGTH,
                        validator: &name_length_validator,
                    },
                    TestProperty {
                        prop: glw::GL_OFFSET,
                        validator: &offset_validator,
                    },
                ];
                for (ndx, &(prop_enum, _)) in REFERENCED_BY_STAGES.iter().enumerate() {
                    all_properties.push(TestProperty {
                        prop: prop_enum,
                        validator: &referenced_by[ndx],
                    });
                }
                all_properties.push(TestProperty {
                    prop: glw::GL_TOP_LEVEL_ARRAY_SIZE,
                    validator: &top_level_array_size_validator,
                });
                all_properties.push(TestProperty {
                    prop: glw::GL_TOP_LEVEL_ARRAY_STRIDE,
                    validator: &top_level_array_stride_validator,
                });
                all_properties.push(TestProperty {
                    prop: glw::GL_TYPE,
                    validator: &type_validator,
                });

                for resource in &target_resources {
                    log::debug!("Buffer variable \"{resource}\"");
                    let (props, validators) = selected_properties(&all_properties, &v, self.query_target.prop_flags);
                    debug_assert!(!props.is_empty());
                    query_and_validate_props(
                        &v,
                        self.query_target.interface,
                        resource,
                        &program_definition,
                        &props,
                        &validators,
                    );
                }
            }

            ProgramInterface::TransformFeedbackVarying => {
                let type_validator = TransformFeedbackTypeValidator;
                let array_size_validator = TransformFeedbackArraySizeValidator;
                let name_length_validator = TransformFeedbackNameLengthValidator;

                let all_properties = [
                    TestProperty {
                        prop: glw::GL_ARRAY_SIZE,
                        validator: &array_size_validator,
                    },
                    TestProperty {
                        prop: glw::GL_NAME_LENGTH,
                        validator: &name_length_validator,
                    },
                    TestProperty {
                        prop: glw::GL_TYPE,
                        validator: &type_validator,
                    },
                ];

                for resource in &target_resources {
                    log::debug!("Transform feedback varying \"{resource}\"");
                    let (props, validators) = selected_properties(&all_properties, &v, self.query_target.prop_flags);
                    debug_assert!(!props.is_empty());
                    query_and_validate_props(
                        &v,
                        self.query_target.interface,
                        resource,
                        &program_definition,
                        &props,
                        &validators,
                    );
                }
            }

            ProgramInterface::AtomicCounterBuffer => {
                unreachable!("the atomic counter buffer interface has its own case")
            }
        }

        match v.error() {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `checkLimit`
fn check_limit(context: &Context, pname: GLenum, usage: i32) -> bool {
    if usage <= 0 {
        return true;
    }

    let mut limit: GLint = 0;
    // SAFETY: one GLint out.
    unsafe { context.gl().get_integerv(pname, &mut limit) };

    log::debug!("\t{pname:#x} = {limit}, test requires {usage}");

    if limit < usage {
        log::debug!("\t\tLimit exceeded");
        return false;
    }

    true
}

/// `checkShaderResourceUsage`
fn check_shader_resource_usage(program: &Program, shader: &Shader, context: &Context) -> bool {
    let usage = shader_resource_usage(program, shader);

    let (label, restrictions): (&str, Vec<(GLenum, i32)>) = match shader.shader_type() {
        ShaderType::Vertex => (
            "Vertex shader:",
            vec![
                (glw::GL_MAX_VERTEX_ATTRIBS, usage.num_input_vectors),
                (
                    glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
                    usage.num_default_block_uniform_components,
                ),
                (glw::GL_MAX_VERTEX_UNIFORM_VECTORS, usage.num_uniform_vectors),
                (glw::GL_MAX_VERTEX_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                (glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS, usage.num_output_components),
                (glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                (
                    glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS,
                    usage.num_atomic_counter_buffers,
                ),
                (glw::GL_MAX_VERTEX_ATOMIC_COUNTERS, usage.num_atomic_counters),
                (glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, usage.num_images),
                (
                    glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
                    usage.num_combined_uniform_components,
                ),
                (
                    glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS,
                    usage.num_shader_storage_blocks,
                ),
            ],
        ),

        ShaderType::Fragment => (
            "Fragment shader:",
            vec![
                (
                    glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
                    usage.num_default_block_uniform_components,
                ),
                (glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS, usage.num_uniform_vectors),
                (glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                (glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS, usage.num_input_components),
                (glw::GL_MAX_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                (
                    glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS,
                    usage.num_atomic_counter_buffers,
                ),
                (glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS, usage.num_atomic_counters),
                (glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, usage.num_images),
                (
                    glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
                    usage.num_combined_uniform_components,
                ),
                (
                    glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
                    usage.num_shader_storage_blocks,
                ),
            ],
        ),

        ShaderType::Compute => (
            "Compute shader:",
            vec![
                (glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                (glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                (
                    glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS,
                    usage.num_default_block_uniform_components,
                ),
                (
                    glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS,
                    usage.num_atomic_counter_buffers,
                ),
                (glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS, usage.num_atomic_counters),
                (glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, usage.num_images),
                (
                    glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS,
                    usage.num_combined_uniform_components,
                ),
                (
                    glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS,
                    usage.num_shader_storage_blocks,
                ),
            ],
        ),

        ShaderType::Geometry => {
            let total_output_components = program.geometry_num_output_vertices() as i32 * usage.num_output_components;
            (
                "Geometry shader:",
                vec![
                    (
                        glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
                        usage.num_default_block_uniform_components,
                    ),
                    (glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                    (glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS, usage.num_input_components),
                    (glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS, usage.num_output_components),
                    (
                        glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES,
                        program.geometry_num_output_vertices() as i32,
                    ),
                    (glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS, total_output_components),
                    (glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                    (
                        glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS,
                        usage.num_atomic_counter_buffers,
                    ),
                    (glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS, usage.num_atomic_counters),
                    (glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS, usage.num_images),
                    (
                        glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS,
                        usage.num_shader_storage_blocks,
                    ),
                ],
            )
        }

        ShaderType::TessControl => {
            let patch_vertices = program.tessellation_num_output_patch_vertices() as i32;
            let total_output_components =
                patch_vertices * usage.num_output_components + usage.num_patch_output_components;
            (
                "Tessellation control shader:",
                vec![
                    (glw::GL_MAX_PATCH_VERTICES, patch_vertices),
                    (glw::GL_MAX_TESS_PATCH_COMPONENTS, usage.num_patch_output_components),
                    (
                        glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
                        usage.num_default_block_uniform_components,
                    ),
                    (glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                    (glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS, usage.num_input_components),
                    (glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS, usage.num_output_components),
                    (
                        glw::GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS,
                        total_output_components,
                    ),
                    (glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                    (
                        glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS,
                        usage.num_atomic_counter_buffers,
                    ),
                    (glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS, usage.num_atomic_counters),
                    (glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS, usage.num_images),
                    (
                        glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
                        usage.num_shader_storage_blocks,
                    ),
                ],
            )
        }

        ShaderType::TessEvaluation => (
            "Tessellation evaluation shader:",
            vec![
                (
                    glw::GL_MAX_PATCH_VERTICES,
                    program.tessellation_num_output_patch_vertices() as i32,
                ),
                (glw::GL_MAX_TESS_PATCH_COMPONENTS, usage.num_patch_input_components),
                (
                    glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
                    usage.num_default_block_uniform_components,
                ),
                (glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS, usage.num_uniform_blocks),
                (glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS, usage.num_input_components),
                (
                    glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS,
                    usage.num_output_components,
                ),
                (glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS, usage.num_samplers),
                (
                    glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS,
                    usage.num_atomic_counter_buffers,
                ),
                (glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS, usage.num_atomic_counters),
                (glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS, usage.num_images),
                (
                    glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
                    usage.num_shader_storage_blocks,
                ),
            ],
        ),
    };

    log::debug!("{label}");
    restrictions.into_iter().fold(true, |all_ok, (pname, usage)| {
        check_limit(context, pname, usage) && all_ok
    })
}

/// `checkProgramCombinedResourceUsage`
fn check_program_combined_resource_usage(program: &Program, context: &Context) -> bool {
    let usage = combined_program_resource_usage(program);

    let restrictions = [
        (
            glw::GL_MAX_UNIFORM_BUFFER_BINDINGS,
            usage.uniform_buffer_max_binding + 1,
        ),
        (glw::GL_MAX_UNIFORM_BLOCK_SIZE, usage.uniform_buffer_max_size),
        (glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, usage.num_uniform_blocks),
        (
            glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
            usage.num_combined_vertex_uniform_components,
        ),
        (
            glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
            usage.num_combined_fragment_uniform_components,
        ),
        (
            glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
            usage.num_combined_geometry_uniform_components,
        ),
        (
            glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS,
            usage.num_combined_tess_control_uniform_components,
        ),
        (
            glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS,
            usage.num_combined_tess_eval_uniform_components,
        ),
        (glw::GL_MAX_VARYING_COMPONENTS, usage.num_varying_components),
        (glw::GL_MAX_VARYING_VECTORS, usage.num_varying_vectors),
        (glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, usage.num_combined_samplers),
        (
            glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES,
            usage.num_combined_output_resources,
        ),
        (
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            usage.atomic_counter_buffer_max_binding + 1,
        ),
        (
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE,
            usage.atomic_counter_buffer_max_size,
        ),
        (
            glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS,
            usage.num_atomic_counter_buffers,
        ),
        (glw::GL_MAX_COMBINED_ATOMIC_COUNTERS, usage.num_atomic_counters),
        (glw::GL_MAX_IMAGE_UNITS, usage.max_image_binding + 1),
        (glw::GL_MAX_COMBINED_IMAGE_UNIFORMS, usage.num_combined_images),
        (
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            usage.shader_storage_buffer_max_binding + 1,
        ),
        (
            glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE,
            usage.shader_storage_buffer_max_size,
        ),
        (
            glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS,
            usage.num_shader_storage_blocks,
        ),
        (
            glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
            usage.num_xfb_interleaved_components,
        ),
        (
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
            usage.num_xfb_separate_attribs,
        ),
        (
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
            usage.num_xfb_separate_components,
        ),
        (glw::GL_MAX_DRAW_BUFFERS, usage.fragment_output_max_binding + 1),
    ];

    log::debug!("Program combined:");
    restrictions.into_iter().fold(true, |all_ok, (pname, usage)| {
        check_limit(context, pname, usage) && all_ok
    })
}

/// `checkProgramResourceUsage` - a program that does not build is only a failure if it fit
/// within every limit; otherwise the case is NotSupported on this driver.
pub fn check_program_resource_usage(program: &Program, context: &Context) -> Result<(), crate::tcu::TestError> {
    let mut limit_exceeded = false;

    for shader in program.shaders() {
        limit_exceeded |= !check_shader_resource_usage(program, shader, context);
    }

    limit_exceeded |= !check_program_combined_resource_usage(program, context);

    if limit_exceeded {
        log::debug!("One or more resource limits exceeded");
        return Err(crate::tcu::TestError::NotSupported(
            "one or more resource limits exceeded".to_string(),
        ));
    }

    Ok(())
}
