// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramInterfaceQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `ResourceDefinition` node tree and
// the program generator live in `program_interface_resource_definition`; this file is the
// cases built on top of them and the group tree that registers those cases.
//
// Upstream's case classes take a `ResourceDefinition::Node::SharedPtr` and derive their own
// name from it in the constructor; the same helpers are free functions here, since a Rust
// test case is a value rather than a class to subclass.

use std::sync::Arc;

use crate::gles31::functional::program_interface_definition::{Program, ProgramInterface};
use crate::gles31::functional::program_interface_definition_util::{
    generate_program_interface_program_sources, no_opt_vertex_attrib_name, program_contains_io_blocks,
    program_interface_resource_list, unused_zero_uniform_name,
};
use crate::gles31::functional::program_interface_query_test_case::{
    ProgramInterfaceQueryTestCase, ProgramResourceQueryTestTarget, check_program_resource_usage,
};
use crate::gles31::functional::program_interface_resource_definition::{
    ARRAY_UNSIZED, Node, NodeKind, NodePtr, generate_program_definition, shader_set_referencing_mask,
};
use crate::glu::var_type::Storage;
use crate::glu::{Context, ShaderProgram, ShaderType, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `convertGLTypeNameToTestName` - the GLSL type name as a case name: vectors and matrices
/// are already fine, everything else goes from camel case to underscores.
pub fn convert_gl_type_name_to_test_name(gl_name: &str) -> String {
    for prefix in ["vec", "ivec", "uvec", "bvec", "mat"] {
        if gl_name.starts_with(prefix) {
            return gl_name.to_string();
        }
    }

    let mut out = String::new();
    let mut merge_next_token = false;
    let mut previous_token_was_digit = false;
    let mut chars = gl_name.chars().peekable();

    while chars.peek().is_some() {
        let mut token = String::new();

        while let Some(&c) = chars.peek() {
            if (c.is_ascii_digit() || c.is_ascii_uppercase()) && !token.is_empty() {
                break;
            }
            token.push(c.to_ascii_lowercase());
            chars.next();
        }

        if out.is_empty() || merge_next_token {
            out.push_str(&token);
        } else {
            out.push('_');
            out.push_str(&token);
        }

        // A single char merges the next one - don't split initialisms or acronyms - unless
        // it is a 'd' right after a number, which splits to "..._2d_...".
        merge_next_token = false;
        if token.chars().count() == 1 {
            let first = token.chars().next().expect("one char");
            if !previous_token_was_digit || first != 'd' {
                merge_next_token = true;
            }
            previous_token_was_digit = first.is_ascii_digit();
        } else {
            previous_token_was_digit = false;
        }
    }

    out
}

/// `getProgramInterfaceGLEnum`
fn program_interface_gl_enum(interface: ProgramInterface) -> GLenum {
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

/// `getShaderMaskFirstStage`
fn shader_mask_first_stage(mask: u32) -> ShaderType {
    for stage in [
        ShaderType::Compute,
        ShaderType::Vertex,
        ShaderType::TessControl,
        ShaderType::TessEvaluation,
        ShaderType::Geometry,
        ShaderType::Fragment,
    ] {
        if mask & (1 << (stage as u32)) != 0 {
            return stage;
        }
    }
    unreachable!("an empty stage mask has no first stage");
}

/// `getShaderMaskLastStage`
fn shader_mask_last_stage(mask: u32) -> ShaderType {
    for stage in [
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessEvaluation,
        ShaderType::TessControl,
        ShaderType::Vertex,
        ShaderType::Compute,
    ] {
        if mask & (1 << (stage as u32)) != 0 {
            return stage;
        }
    }
    unreachable!("an empty stage mask has no last stage");
}

/// The extension checks `ResourceListTestCase::init` and its siblings all run.
fn check_program_stage_support(context: &Context, program: &Program) -> Result<(), TestError> {
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

    if program.has_stage(ShaderType::Geometry) && !context.context_info.is_extension_supported("GL_EXT_geometry_shader")
    {
        return Err(TestError::NotSupported(
            "Test requires GL_EXT_geometry_shader extension".to_string(),
        ));
    }

    if program_contains_io_blocks(program) && !context.context_info.is_extension_supported("GL_EXT_shader_io_blocks") {
        return Err(TestError::NotSupported(
            "Test requires GL_EXT_shader_io_blocks extension".to_string(),
        ));
    }

    Ok(())
}

/// `checkAndLogProgram` - a program that did not build is only a failure if it fit within
/// every limit.
fn check_and_log_program(
    program: &ShaderProgram<'_>,
    program_definition: &Program,
    context: &Context,
) -> Result<(), TestError> {
    if !program.is_ok() {
        log::debug!("Program build failed, checking if program exceeded implementation limits");
        check_program_resource_usage(program_definition, context)?;

        // within limits
        return Err(TestError::Fail("could not build program".to_string()));
    }
    Ok(())
}

/// `ResourceListTestCase::isArrayedInterface`
fn is_arrayed_interface(interface: ProgramInterface, stage_bits: u32) -> bool {
    match interface {
        ProgramInterface::ProgramInput => matches!(
            shader_mask_first_stage(stage_bits),
            ShaderType::TessControl | ShaderType::TessEvaluation | ShaderType::Geometry
        ),
        ProgramInterface::ProgramOutput => shader_mask_last_stage(stage_bits) == ShaderType::TessControl,
        _ => false,
    }
}

/// `ResourceListTestCase::genTestCaseName`
pub fn gen_resource_list_test_case_name(interface: ProgramInterface, root: &Node) -> String {
    let mut is_implicitly_sized_array = false;
    let mut has_variable = false;
    let mut accumulate_name = true;
    let mut buf = String::from("var");
    let mut prefix = String::new();

    let mut node = Some(root.clone());
    while let Some(current) = node {
        match &current.kind {
            NodeKind::Variable { .. } => has_variable = true,

            NodeKind::StructMember => {
                if accumulate_name {
                    buf.push_str("_struct");
                }
            }

            NodeKind::ArrayElement { array_size } => {
                is_implicitly_sized_array = *array_size == ARRAY_UNSIZED;
                if accumulate_name {
                    buf.push_str("_array");
                }
            }

            NodeKind::StorageQualifier { storage } => {
                if matches!(storage, Storage::PatchIn | Storage::PatchOut) && accumulate_name {
                    prefix.push_str("patch_");
                }
            }

            NodeKind::Shader { shader_type, .. } => {
                if is_arrayed_interface(interface, 1 << (*shader_type as u32)) && is_implicitly_sized_array {
                    // omit implicit arrayness from the name
                    buf = buf
                        .strip_suffix("_array")
                        .expect("an implicit array named itself")
                        .to_string();
                }
            }

            NodeKind::ShaderSet { .. } => {
                if is_arrayed_interface(interface, shader_set_referencing_mask(&current)) && is_implicitly_sized_array {
                    buf = buf
                        .strip_suffix("_array")
                        .expect("an implicit array named itself")
                        .to_string();
                }
            }

            NodeKind::InterfaceBlock { .. } => accumulate_name = false,

            _ => {}
        }

        node = current.enclosing.as_ref().map(|e| (**e).clone());
    }

    if has_variable { prefix + &buf } else { prefix + "empty" }
}

/// `ResourceTestCase::genTestCaseName`
pub fn gen_resource_test_case_name(resource: &Node) -> String {
    match &resource.kind {
        NodeKind::Variable { data_type } => convert_gl_type_name_to_test_name(data_type.name()),
        other => unreachable!("a resource case names itself after its variable, not {other:?}"),
    }
}

/// `ResourceTestCase::genMultilineDescription`
fn gen_multiline_description(resource: &Node) -> String {
    match &resource.kind {
        NodeKind::Variable { data_type } => {
            let mut uniform_type = String::new();
            let mut structure_descriptor = String::new();

            let mut node = Some(resource.clone());
            while let Some(current) = node {
                match &current.kind {
                    NodeKind::StorageQualifier { storage } => {
                        uniform_type = format!(" {}", storage.name());
                        structure_descriptor += &format!("\n\tdeclared as \"{}\"", storage.name());
                    }
                    NodeKind::ArrayElement { .. } => structure_descriptor += "\n\tarray",
                    NodeKind::StructMember => structure_descriptor += "\n\tin a struct",
                    NodeKind::DefaultBlock => structure_descriptor += "\n\tin the default block",
                    NodeKind::InterfaceBlock { .. } => structure_descriptor += "\n\tin an interface block",
                    _ => {}
                }
                node = current.enclosing.as_ref().map(|e| (**e).clone());
            }

            format!(
                "Querying properties of {}{uniform_type} variable.\nVariable is:\n\t{}{structure_descriptor}",
                data_type.name(),
                data_type.name()
            )
        }

        NodeKind::TransformFeedbackTarget { builtin_var_name } => format!(
            "Querying properties of a builtin variable {}",
            builtin_var_name.expect("a standalone feedback target names a builtin")
        ),

        other => unreachable!("no description for {other:?}"),
    }
}

/// `ResourceTestCase` - the property-query case for one resource definition.
pub fn resource_test_case(
    target_resource: &NodePtr,
    query_target: ProgramResourceQueryTestTarget,
    name: Option<&str>,
) -> ProgramInterfaceQueryTestCase {
    let name = name.map_or_else(|| gen_resource_test_case_name(target_resource), str::to_string);
    let resource = Arc::clone(target_resource);

    ProgramInterfaceQueryTestCase::new(name, query_target, move |glsl_version| {
        log::debug!("{}", gen_multiline_description(&resource));
        generate_program_definition(&resource, glsl_version)
    })
}

/// `ResourceListTestCase` - checks the whole resource list of one interface against what
/// the definition says it must be, plus the index query and MAX_NAME_LENGTH that have to
/// agree with it.
pub struct ResourceListTestCase {
    name: String,
    program_interface: ProgramInterface,
    target_resource: NodePtr,
    /// `FeedbackResourceListTestCase` differs only in logging the varyings it captures.
    log_feedback_varyings: bool,
}

impl ResourceListTestCase {
    pub fn new(target_resource: &NodePtr, interface: ProgramInterface, name: Option<&str>) -> Self {
        // GL_ATOMIC_COUNTER_BUFFER: no resource names
        debug_assert_ne!(interface, ProgramInterface::AtomicCounterBuffer);

        let name = name.map_or_else(
            || gen_resource_list_test_case_name(interface, target_resource),
            str::to_string,
        );
        Self {
            name,
            program_interface: interface,
            target_resource: Arc::clone(target_resource),
            log_feedback_varyings: false,
        }
    }

    /// `FeedbackResourceListTestCase`
    pub fn feedback(target_resource: &NodePtr, name: &str) -> Self {
        Self {
            log_feedback_varyings: true,
            ..Self::new(target_resource, ProgramInterface::TransformFeedbackVarying, Some(name))
        }
    }

    /// `queryResourceList`
    fn query_resource_list(&self, context: &Context, program: GLuint) -> Vec<String> {
        let gl = context.gl();
        let program_interface = program_interface_gl_enum(self.program_interface);
        let mut num_active_resources: GLint = 0;
        let mut max_name_length: GLint = 0;

        // SAFETY: one GLint out per query, then one name per active resource into a buffer
        // the driver itself sized.
        unsafe {
            gl.get_program_interfaceiv(
                program,
                program_interface,
                glw::GL_ACTIVE_RESOURCES,
                &mut num_active_resources,
            );
            gl.get_program_interfaceiv(
                program,
                program_interface,
                glw::GL_MAX_NAME_LENGTH,
                &mut max_name_length,
            );
        }

        log::debug!("\tGL_ACTIVE_RESOURCES = {num_active_resources}\n\tGL_MAX_NAME_LENGTH = {max_name_length}");
        log::debug!("Querying all active resources");

        let mut resources = Vec::with_capacity(num_active_resources.max(0) as usize);
        let mut buffer = vec![0u8; max_name_length.max(0) as usize + 1];

        for resource_ndx in 0..num_active_resources.max(0) {
            let mut written: glw::GLsizei = 0;
            // SAFETY: as above.
            unsafe {
                gl.get_program_resource_name(
                    program,
                    program_interface,
                    resource_ndx as GLuint,
                    max_name_length,
                    &mut written,
                    buffer.as_mut_ptr().cast(),
                );
            }
            resources.push(String::from_utf8_lossy(&buffer[..written.max(0) as usize]).into_owned());
        }

        resources
    }

    /// `verifyResourceList`
    fn verify_resource_list(&self, resource_list: &[String], expected_resources: &[String]) -> bool {
        let mut error = false;

        log::debug!("GL returned resources:");
        for (ndx, resource) in resource_list.iter().enumerate() {
            // `unusedZero` is a uniform generateProgramInterfaceProgramSources may add;
            // leaving it out of the log avoids confusion about the output.
            if resource != unused_zero_uniform_name() {
                log::debug!("\t{ndx}: {resource}");
            }
        }

        log::debug!("Expected list of resources:");
        for (ndx, resource) in expected_resources.iter().enumerate() {
            log::debug!("\t{ndx}: {resource}");
        }

        log::debug!("Verifying resource list contents.");

        for expected in expected_resources {
            if !resource_list.contains(expected) {
                log::debug!("Error, resource list did not contain active resource {expected}");
                error = true;
            }
        }

        for resource in resource_list {
            if expected_resources.contains(resource) {
                continue;
            }

            // Every builtin, and the two variables the source generator adds, are ignored;
            // a mismatch on them would be noise rather than a finding.
            if !resource.starts_with("gl_")
                && resource != unused_zero_uniform_name()
                && resource != no_opt_vertex_attrib_name()
            {
                log::debug!("Error, resource list contains unexpected resource name {resource}");
                error = true;
            } else {
                log::debug!("Note, resource list contains unknown built-in {resource}. This variable is ignored.");
            }
        }

        !error
    }

    /// `verifyResourceIndexQuery`
    fn verify_resource_index_query(
        &self,
        context: &Context,
        resource_list: &[String],
        reference_resources: &[String],
        program: GLuint,
    ) -> bool {
        let program_interface = program_interface_gl_enum(self.program_interface);
        let mut error = false;

        log::debug!("Verifying GetProgramResourceIndex returns correct indices for resource names.");

        let resource_index = |name: &str| {
            let name = std::ffi::CString::new(name).expect("a resource name has no interior NUL");
            // SAFETY: the name outlives the call.
            unsafe {
                context
                    .gl()
                    .get_program_resource_index(program, program_interface, name.as_ptr())
            }
        };

        for reference in reference_resources {
            let index = resource_index(reference);

            if index == glw::GL_INVALID_INDEX {
                log::debug!("Error, for active resource \"{reference}\" got index GL_INVALID_INDEX.");
                error = true;
            } else if index as usize >= resource_list.len() {
                log::debug!(
                    "Error, for active resource \"{reference}\" got index {index} (larger or equal to GL_ACTIVE_RESOURCES)."
                );
                error = true;
            } else if &resource_list[index as usize] != reference {
                log::debug!(
                    "Error, for active resource \"{reference}\" got index (index = {index}) of another resource ({}).",
                    resource_list[index as usize]
                );
                error = true;
            }
        }

        // A query for "name" should match "name[0]", except on the XFB interface.
        if self.program_interface != ProgramInterface::TransformFeedbackVarying {
            for reference in reference_resources {
                let Some(query_string) = reference.strip_suffix("[0]") else {
                    continue;
                };
                let index = resource_index(query_string);

                if index == glw::GL_INVALID_INDEX {
                    log::debug!("Error, query for \"{query_string}\" resulted in index GL_INVALID_INDEX.");
                    error = true;
                } else if index as usize >= resource_list.len() {
                    log::debug!(
                        "Error, query for \"{query_string}\" resulted in index {index} (larger or equal to GL_ACTIVE_RESOURCES)."
                    );
                    error = true;
                } else if resource_list[index as usize] != format!("{query_string}[0]") {
                    log::debug!(
                        "Error, query for \"{query_string}\" got index (index = {index}) of another resource (\"{}\").",
                        resource_list[index as usize]
                    );
                    error = true;
                }
            }
        }

        !error
    }

    /// `verifyMaxNameLength`
    fn verify_max_name_length(&self, context: &Context, resource_list: &[String], program: GLuint) -> bool {
        let program_interface = program_interface_gl_enum(self.program_interface);
        let mut max_name_length: GLint = 0;
        // SAFETY: one GLint out.
        unsafe {
            context.gl().get_program_interfaceiv(
                program,
                program_interface,
                glw::GL_MAX_NAME_LENGTH,
                &mut max_name_length,
            );
        }

        let expected_max_name_length = resource_list.iter().map(|r| r.len() as GLint + 1).max().unwrap_or(0);

        log::debug!(
            "Verifying MAX_NAME_LENGTH, expecting {expected_max_name_length} (i.e. consistent with the queried resource list)"
        );

        if expected_max_name_length != max_name_length {
            log::debug!("Error, got {max_name_length}");
            return false;
        }

        true
    }
}

impl TestCase for ResourceListTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let program_definition =
            generate_program_definition(&self.target_resource, context.context_type().glsl_version());
        check_program_stage_support(context, &program_definition)?;

        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);

        if self.log_feedback_varyings {
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

        check_and_log_program(&program, &program_definition, context)?;

        let resource_list = self.query_resource_list(context, program.program());
        let expected_resources = program_interface_resource_list(&program_definition, self.program_interface);

        // the list and the expected list must match
        if !self.verify_resource_list(&resource_list, &expected_resources) {
            return Ok(TestStatus::fail("invalid resource list"));
        }

        // GetProgramResourceIndex must match the indices of the list
        if !self.verify_resource_index_query(context, &resource_list, &expected_resources, program.program()) {
            return Ok(TestStatus::fail("GetProgramResourceIndex returned unexpected values"));
        }

        if !self.verify_max_name_length(context, &resource_list, program.program()) {
            return Ok(TestStatus::fail("MAX_NAME_LENGTH invalid"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `specializeShader` - the only substitution this file's hand-written sources need.
fn specialize_shader(context: &Context, code: &str) -> String {
    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
}

/// Builds one compute program from a hand-written source and answers it, or the build
/// failure as a test error.
fn build_compute_program<'gl>(context: &'gl Context, source: &str) -> Result<ShaderProgram<'gl>, TestError> {
    let sources = crate::glu::ProgramSources::compute(specialize_shader(context, source));
    let program = ShaderProgram::new(context.gl(), &sources);

    if !program.is_ok() {
        return Err(TestError::Fail("could not build program".to_string()));
    }

    Ok(program)
}

/// `gl.getProgramResourceIndex`, failing the case if the resource is not there at all.
fn require_resource_index(
    context: &Context,
    program: GLuint,
    interface: GLenum,
    name: &str,
) -> Result<GLuint, TestError> {
    let c_name = std::ffi::CString::new(name).expect("a resource name has no interior NUL");
    // SAFETY: the name outlives the call.
    let index = unsafe {
        context
            .gl()
            .get_program_resource_index(program, interface, c_name.as_ptr())
    };

    if index == glw::GL_INVALID_INDEX {
        return Err(TestError::Fail(format!(
            "Uniform {name} resource index was GL_INVALID_INDEX"
        )));
    }

    Ok(index)
}

/// `ResourceNameBufferLimitCase` - `glGetProgramResourceName` into buffers of every
/// interesting size, including zero and one byte too small.
pub struct ResourceNameBufferLimitCase {
    name: String,
}

impl ResourceNameBufferLimitCase {
    pub fn new(name: impl Into<String>) -> Self {
        Self { name: name.into() }
    }
}

impl TestCase for ResourceNameBufferLimitCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COMPUTE_SOURCE: &str = "${GLSL_VERSION_DECL}\nlayout(local_size_x = 1) in;\nuniform highp int u_uniformWithALongName;\nwriteonly buffer \
                                      OutputBufferBlock { highp int b_output_int; };\nvoid main ()\n{\n    b_output_int = u_uniformWithALongName;\n}\n";

        /// One row of upstream's `querySizes` table.
        struct QuerySize {
            description: &'static str,
            query_size: i32,
            return_length: bool,
        }

        const QUERY_SIZES: &[QuerySize] = &[
            QuerySize {
                description: "Query to larger buffer",
                query_size: 24,
                return_length: true,
            },
            QuerySize {
                description: "Query to buffer the same size",
                query_size: 23,
                return_length: true,
            },
            QuerySize {
                description: "Query to one byte too small buffer",
                query_size: 22,
                return_length: true,
            },
            QuerySize {
                description: "Query to one byte buffer",
                query_size: 1,
                return_length: true,
            },
            QuerySize {
                description: "Query to zero sized buffer",
                query_size: 0,
                return_length: true,
            },
            QuerySize {
                description: "Query to one byte too small buffer, null length argument",
                query_size: 22,
                return_length: false,
            },
            QuerySize {
                description: "Query to one byte buffer, null length argument",
                query_size: 1,
                return_length: false,
            },
            QuerySize {
                description: "Query to zero sized buffer, null length argument",
                query_size: 0,
                return_length: false,
            },
        ];

        let program = build_compute_program(context, COMPUTE_SOURCE)?;
        let uniform_index =
            require_resource_index(context, program.program(), glw::GL_UNIFORM, "u_uniformWithALongName")?;

        // len("u_uniformWithALongName") == 22
        const UNIFORM_NAME_LEN: i32 = 22;

        for query in QUERY_SIZES {
            log::debug!("{}", query.description);
            let expected_write_len = if query.query_size != 0 {
                UNIFORM_NAME_LEN.min(query.query_size - 1)
            } else {
                0
            };

            // One byte for the guard
            let mut buffer = [b'x'; 26];
            let mut written: glw::GLsizei = -1;

            if query.query_size != 0 {
                log::debug!(
                    "Querying uniform name to a buffer of size {}, expecting query to write {expected_write_len} bytes followed by a null terminator",
                    query.query_size
                );
            } else {
                log::debug!(
                    "Querying uniform name to a buffer of size {}, expecting query to write 0 bytes",
                    query.query_size
                );
            }

            // SAFETY: the driver writes at most `query_size` bytes into a 26-byte buffer,
            // and the length pointer is optional exactly as the entry point allows.
            unsafe {
                context.gl().get_program_resource_name(
                    program.program(),
                    glw::GL_UNIFORM,
                    uniform_index,
                    query.query_size,
                    if query.return_length {
                        &mut written
                    } else {
                        std::ptr::null_mut()
                    },
                    buffer.as_mut_ptr().cast(),
                );
            }

            let ndx = expected_write_len as usize;
            if query.return_length && written != expected_write_len {
                log::debug!("Error, expected write length of {expected_write_len}, got {written}");
                return Ok(TestStatus::fail("Unexpected write lenght"));
            } else if query.query_size != 0 && buffer[ndx] != 0 {
                log::debug!(
                    "Error, expected null terminator at {expected_write_len}, got dec={}",
                    buffer[ndx]
                );
                return Ok(TestStatus::fail("Missing null terminator"));
            } else if query.query_size != 0 && buffer[ndx + 1] != b'x' {
                log::debug!(
                    "Error, guard at index {} was modified, got dec={}",
                    ndx + 1,
                    buffer[ndx + 1]
                );
                return Ok(TestStatus::fail("Wrote over buffer size"));
            } else if query.query_size == 0 && buffer[0] != b'x' {
                log::debug!(
                    "Error, buffer size was 0 but buffer contents were modified. At index 0 got dec={}",
                    buffer[0]
                );
                return Ok(TestStatus::fail("Buffer contents were modified"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ResourceQueryBufferLimitCase` - `glGetProgramResourceiv` into buffers smaller than the
/// property list.
pub struct ResourceQueryBufferLimitCase {
    name: String,
}

impl ResourceQueryBufferLimitCase {
    pub fn new(name: impl Into<String>) -> Self {
        Self { name: name.into() }
    }
}

impl TestCase for ResourceQueryBufferLimitCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COMPUTE_SOURCE: &str = "${GLSL_VERSION_DECL}\nlayout(local_size_x = 1) in;\nuniform highp int u_uniform;\nwriteonly buffer OutputBufferBlock \
                                      { highp int b_output_int; };\nvoid main ()\n{\n    b_output_int = u_uniform;\n}\n";

        /// One row of upstream's `querySizes` table.
        struct QuerySize {
            description: &'static str,
            num_props: i32,
            buffer_size: i32,
            return_length: bool,
        }

        const QUERY_SIZES: &[QuerySize] = &[
            QuerySize {
                description: "Query to a larger buffer",
                num_props: 2,
                buffer_size: 3,
                return_length: true,
            },
            QuerySize {
                description: "Query to too small a buffer",
                num_props: 3,
                buffer_size: 2,
                return_length: true,
            },
            QuerySize {
                description: "Query to zero sized buffer",
                num_props: 3,
                buffer_size: 0,
                return_length: true,
            },
            QuerySize {
                description: "Query to a larger buffer, null length argument",
                num_props: 2,
                buffer_size: 3,
                return_length: false,
            },
            QuerySize {
                description: "Query to too small a buffer, null length argument",
                num_props: 3,
                buffer_size: 2,
                return_length: false,
            },
            QuerySize {
                description: "Query to zero sized buffer, null length argument",
                num_props: 3,
                buffer_size: 0,
                return_length: false,
            },
        ];

        let program = build_compute_program(context, COMPUTE_SOURCE)?;
        let uniform_index = require_resource_index(context, program.program(), glw::GL_UNIFORM, "u_uniform")?;

        for query in QUERY_SIZES {
            log::debug!("{}", query.description);

            let props = [glw::GL_LOCATION; 3];
            let expected_write_len = query.buffer_size.min(query.num_props);
            // The last element is never asked for, so it stays 255 and catches an overflow.
            let mut params = [255 as GLint; 4];
            let mut written: glw::GLsizei = -1;

            log::debug!(
                "Querying {} uniform prop(s) to a buffer with size {}. Expecting query to return {expected_write_len} prop(s)",
                query.num_props,
                query.buffer_size
            );

            // SAFETY: at most `buffer_size` of the four slots are written, and the length
            // pointer is optional exactly as the entry point allows.
            unsafe {
                context.gl().get_program_resourceiv(
                    program.program(),
                    glw::GL_UNIFORM,
                    uniform_index,
                    query.num_props,
                    props.as_ptr(),
                    query.buffer_size,
                    if query.return_length {
                        &mut written
                    } else {
                        std::ptr::null_mut()
                    },
                    params.as_mut_ptr(),
                );
            }

            if query.return_length && written != expected_write_len {
                log::debug!("Error, expected write length of {expected_write_len}, got {written}");
                return Ok(TestStatus::fail("Unexpected write lenght"));
            } else if params[expected_write_len as usize] != 255 {
                log::debug!(
                    "Error, guard at index {expected_write_len} was modified. Was 255 before call, got dec={}",
                    params[expected_write_len as usize]
                );
                return Ok(TestStatus::fail("Wrote over buffer size"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `getTypeSize` - in basic machine units.
fn type_size(data_type: crate::glu::shader_util::DataType) -> i32 {
    use crate::glu::shader_util::DataType;
    match data_type {
        // a bool is a uint on the wire
        DataType::Float | DataType::Int | DataType::Uint | DataType::Bool => 4,
        other => unreachable!("no machine size for {other:?}"),
    }
}

/// `getVarTypeSize`
fn var_type_size(ty: &crate::glu::VarType) -> i32 {
    use crate::glu::VarType;
    use crate::glu::var_type::UNSIZED_ARRAY;

    match ty {
        VarType::Basic(basic_type, _) => basic_type.scalar_size() * type_size(basic_type.scalar_type()),
        VarType::Struct(struct_ptr) => struct_ptr.members.iter().map(|m| var_type_size(&m.ty)).sum(),
        VarType::Array(element, size) => {
            if *size == UNSIZED_ARRAY {
                var_type_size(element)
            } else {
                *size * var_type_size(element)
            }
        }
    }
}

/// `InterfaceBlockBaseCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum InterfaceBlockCaseType {
    NamedBlock,
    UnnamedBlock,
    BlockArray,
}

/// `InterfaceBlockBaseCase::init` - a compute program with three blocks, the middle one
/// being the target and the other two there to make sure the query picks the right one.
fn build_interface_block_program(context: &Context, storage: Storage, case_type: InterfaceBlockCaseType) -> Program {
    use crate::glu::shader_util::{DataType, Precision};
    use crate::glu::var_type::{InterfaceBlock, StructType, UNSIZED_ARRAY, VarType, VariableDeclaration};

    debug_assert!(matches!(storage, Storage::Uniform | Storage::Buffer));

    let highp_vec4 = || VarType::basic(DataType::FloatVec4, Some(Precision::HighP));
    let highp_float = || VarType::basic(DataType::Float, Some(Precision::HighP));

    let mut program = Program::new();
    let shader = program.add_shader(ShaderType::Compute, context.context_type().glsl_version());

    // PrecedingInterface
    {
        let mut block = InterfaceBlock {
            interface_name: "PrecedingInterface".to_string(),
            instance_name: "precedingInstance".to_string(),
            storage: Some(storage),
            ..InterfaceBlock::default()
        };
        block.layout.binding = Some(0);
        block
            .variables
            .push(VariableDeclaration::new(highp_vec4(), "precedingMember", None));

        // Unsized array type
        if storage == Storage::Buffer {
            block.variables.push(VariableDeclaration::new(
                VarType::array(highp_float(), UNSIZED_ARRAY),
                "precedingMemberUnsizedArray",
                None,
            ));
        } else {
            block.variables.push(VariableDeclaration::new(
                VarType::array(highp_float(), 2),
                "precedingMemberArray",
                None,
            ));
        }

        shader.default_block.interface_blocks.push(block);
    }

    // TargetInterface
    {
        let mut block = InterfaceBlock {
            interface_name: "TargetInterface".to_string(),
            instance_name: if case_type == InterfaceBlockCaseType::UnnamedBlock {
                String::new()
            } else {
                "targetInstance".to_string()
            },
            storage: Some(storage),
            ..InterfaceBlock::default()
        };
        block.layout.binding = Some(1);

        if case_type == InterfaceBlockCaseType::BlockArray {
            block.dimensions.push(2);
        }

        // Basic type
        block
            .variables
            .push(VariableDeclaration::new(highp_vec4(), "blockMemberBasic", None));

        // Array type
        block.variables.push(VariableDeclaration::new(
            VarType::array(highp_float(), 3),
            "blockMemberArray",
            None,
        ));

        // Struct type
        {
            let mut struct_type = StructType::new("StructType");
            struct_type.add_member("structMemberBasic", highp_vec4());
            struct_type.add_member("structMemberArray", VarType::array(highp_float(), 2));

            block.variables.push(VariableDeclaration::new(
                VarType::array(VarType::structure(&Arc::new(struct_type)), 2),
                "blockMemberStruct",
                None,
            ));
        }

        // Unsized array type
        if storage == Storage::Buffer {
            block.variables.push(VariableDeclaration::new(
                VarType::array(highp_float(), UNSIZED_ARRAY),
                "blockMemberUnsizedArray",
                None,
            ));
        }

        shader.default_block.interface_blocks.push(block);
    }

    // TrailingInterface
    {
        let mut block = InterfaceBlock {
            interface_name: "TrailingInterface".to_string(),
            instance_name: "trailingInstance".to_string(),
            storage: Some(storage),
            ..InterfaceBlock::default()
        };
        block.layout.binding = Some(3);
        block
            .variables
            .push(VariableDeclaration::new(highp_vec4(), "trailingMember", None));

        shader.default_block.interface_blocks.push(block);
    }

    debug_assert!(program.is_valid());
    program
}

/// The program interface a block of this storage lives on.
fn block_program_interface(storage: Storage) -> ProgramInterface {
    match storage {
        Storage::Uniform => ProgramInterface::UniformBlock,
        Storage::Buffer => ProgramInterface::ShaderStorageBlock,
        other => unreachable!("{other:?} is not buffer backed"),
    }
}

/// `InterfaceBlockActiveVariablesTestCase` - GL_ACTIVE_VARIABLES of each block must name
/// exactly the members the definition puts in it, and MAX_NUM_ACTIVE_VARIABLES must match
/// the largest of them.
pub struct InterfaceBlockActiveVariablesTestCase {
    name: String,
    storage: Storage,
    case_type: InterfaceBlockCaseType,
}

impl InterfaceBlockActiveVariablesTestCase {
    pub fn new(name: impl Into<String>, storage: Storage, case_type: InterfaceBlockCaseType) -> Self {
        Self {
            name: name.into(),
            storage,
            case_type,
        }
    }
}

impl TestCase for InterfaceBlockActiveVariablesTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        use crate::gles31::functional::program_interface_definition_util::program_interface_block_member_resource_list;

        let program_definition = build_interface_block_program(context, self.storage, self.case_type);
        let program_interface = block_program_interface(self.storage);
        let gl_interface = program_interface_gl_enum(program_interface);
        let member_interface = if self.storage == Storage::Uniform {
            glw::GL_UNIFORM
        } else {
            glw::GL_BUFFER_VARIABLE
        };

        let block_names = program_interface_resource_list(&program_definition, program_interface);
        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);
        check_and_log_program(&program, &program_definition, context)?;

        let gl = context.gl();
        let mut expected_max_num_active_variables = 0;
        let mut failure: Option<&'static str> = None;

        for block_name in &block_names {
            log::debug!("Block \"{block_name}\"");

            let c_name = std::ffi::CString::new(block_name.as_str()).expect("a block name has no interior NUL");
            // SAFETY: the name outlives the call.
            let resource_ndx =
                unsafe { gl.get_program_resource_index(program.program(), gl_interface, c_name.as_ptr()) };

            if resource_ndx == glw::GL_INVALID_INDEX {
                log::debug!("Error, getProgramResourceIndex returned GL_INVALID_INDEX for \"{block_name}\"");
                failure = failure.or(Some("Resource not found"));
                continue;
            }

            // query block information
            let num_active_resources;
            {
                let props = [glw::GL_NUM_ACTIVE_VARIABLES];
                let mut ret_buffer = [-1 as GLint; 2];
                let mut written: glw::GLsizei = -1;

                // SAFETY: one property in, one slot asked for out of a two-slot buffer, so
                // the second slot catches a driver writing too much.
                unsafe {
                    gl.get_program_resourceiv(
                        program.program(),
                        gl_interface,
                        resource_ndx,
                        props.len() as glw::GLsizei,
                        props.as_ptr(),
                        1,
                        &mut written,
                        ret_buffer.as_mut_ptr(),
                    );
                }

                num_active_resources = ret_buffer[0];
                expected_max_num_active_variables = expected_max_num_active_variables.max(num_active_resources);
                log::debug!("NUM_ACTIVE_VARIABLES = {num_active_resources}");

                if written == -1 || ret_buffer[0] == -1 {
                    log::debug!("Error, Query for NUM_ACTIVE_VARIABLES did not return a value");
                    failure = failure.or(Some("Query for NUM_ACTIVE_VARIABLES failed"));
                    continue;
                } else if ret_buffer[1] != -1 {
                    log::debug!("Error, Query for NUM_ACTIVE_VARIABLES returned too many values");
                    failure = failure.or(Some("Query for NUM_ACTIVE_VARIABLES returned too many values"));
                    continue;
                } else if ret_buffer[0] < 0 {
                    log::debug!("Error, NUM_ACTIVE_VARIABLES < 0");
                    failure = failure.or(Some("NUM_ACTIVE_VARIABLES < 0"));
                    continue;
                }
            }

            // query block variable information
            let mut active_resource_names: Vec<String> = Vec::new();
            {
                let props = [glw::GL_ACTIVE_VARIABLES];
                // One extra trailing slot to detect a wrong write length.
                let mut active_variable_indices = vec![-1 as GLint; num_active_resources as usize + 1];
                let mut written: glw::GLsizei = -1;

                // SAFETY: as above.
                unsafe {
                    gl.get_program_resourceiv(
                        program.program(),
                        gl_interface,
                        resource_ndx,
                        props.len() as glw::GLsizei,
                        props.as_ptr(),
                        active_variable_indices.len() as glw::GLsizei,
                        &mut written,
                        active_variable_indices.as_mut_ptr(),
                    );
                }

                if written == -1 {
                    log::debug!("Error, Query for GL_ACTIVE_VARIABLES did not return any values");
                    failure = failure.or(Some("Query for GL_ACTIVE_VARIABLES failed"));
                    continue;
                } else if written != num_active_resources {
                    log::debug!("Error, Query for GL_ACTIVE_VARIABLES did not return NUM_ACTIVE_VARIABLES values");
                    failure = failure.or(Some("Query for GL_ACTIVE_VARIABLES returned invalid number of values"));
                    continue;
                } else if *active_variable_indices.last().expect("one extra slot") != -1 {
                    log::debug!(
                        "Error, GL_ACTIVE_VARIABLES query return buffer trailing guard value was modified, getProgramResourceiv returned more than \
                         NUM_ACTIVE_VARIABLES values"
                    );
                    failure = failure.or(Some("Query for GL_ACTIVE_VARIABLES returned too many values"));
                    continue;
                }

                log::debug!(
                    "Active variable indices: {{{}}}",
                    active_variable_indices[..num_active_resources as usize]
                        .iter()
                        .map(ToString::to_string)
                        .collect::<Vec<_>>()
                        .join(", ")
                );

                // collect names
                let mut name_query_failed = None;
                for &variable_index in &active_variable_indices[..num_active_resources as usize] {
                    let name_prop = glw::GL_NAME_LENGTH;
                    let mut name_length: GLint = -1;
                    let mut written: glw::GLsizei = -1;

                    // SAFETY: one property in, one GLint out.
                    unsafe {
                        gl.get_program_resourceiv(
                            program.program(),
                            member_interface,
                            variable_index as GLuint,
                            1,
                            &name_prop,
                            1,
                            &mut written,
                            &mut name_length,
                        );
                    }

                    if name_length <= 0 || written <= 0 {
                        log::debug!("Error, GL_NAME_LENGTH query failed");
                        name_query_failed = Some("GL_NAME_LENGTH query failed");
                        break;
                    }

                    // allocate more than required
                    let mut name_buffer = vec![b'X'; name_length as usize + 2];
                    let mut written: glw::GLsizei = -1;
                    // SAFETY: at most `name_length + 1` bytes into a buffer two larger.
                    unsafe {
                        gl.get_program_resource_name(
                            program.program(),
                            member_interface,
                            variable_index as GLuint,
                            name_length + 1,
                            &mut written,
                            name_buffer.as_mut_ptr().cast(),
                        );
                    }

                    if written <= 0 {
                        log::debug!("Error, name query failed, no data written");
                        name_query_failed = Some("name query failed");
                        break;
                    } else if written > name_length {
                        log::debug!("Error, name query failed, query returned too much data");
                        name_query_failed = Some("name query failed");
                        break;
                    }

                    active_resource_names.push(String::from_utf8_lossy(&name_buffer[..written as usize]).into_owned());
                }

                if let Some(err) = name_query_failed {
                    failure = failure.or(Some(err));
                    continue;
                }

                log::debug!(
                    "Active variables:\n{}",
                    active_resource_names
                        .iter()
                        .map(|n| format!("\t{n}\n"))
                        .collect::<String>()
                );
            }

            // verify names
            {
                let block_short_name = crate::glu::var_type::parse_variable_name(block_name);
                let Some(block) = program_definition.shaders()[0]
                    .default_block
                    .interface_blocks
                    .iter()
                    .find(|b| b.interface_name == block_short_name)
                else {
                    return Err(TestError::InternalError(
                        "could not find block referenced in the reference resource list".to_string(),
                    ));
                };

                let reference_list = program_interface_block_member_resource_list(block);
                log::debug!(
                    "Expected variable names:\n{}",
                    reference_list.iter().map(|n| format!("\t{n}\n")).collect::<String>()
                );

                let mut lists_identical = true;

                for reference in &reference_list {
                    if !active_resource_names.contains(reference) {
                        log::debug!("Error, variable name list did not contain active variable {reference}");
                        lists_identical = false;
                    }
                }

                for active in &active_resource_names {
                    if !reference_list.contains(active) {
                        log::debug!("Error, variable name list contains unexpected resource \"{active}\"");
                        lists_identical = false;
                    }
                }

                if lists_identical {
                    log::debug!("Lists identical");
                } else {
                    log::debug!("Error, invalid active variable list");
                    failure = failure.or(Some("invalid active variable list"));
                    continue;
                }
            }
        }

        // Max num active variables
        {
            let mut max_num_active_variables: GLint = -1;
            // SAFETY: one GLint out.
            unsafe {
                gl.get_program_interfaceiv(
                    program.program(),
                    gl_interface,
                    glw::GL_MAX_NUM_ACTIVE_VARIABLES,
                    &mut max_num_active_variables,
                );
            }

            log::debug!("MAX_NUM_ACTIVE_VARIABLES = {max_num_active_variables}");

            if expected_max_num_active_variables != max_num_active_variables {
                log::debug!("Error, got unexpected MAX_NUM_ACTIVE_VARIABLES");
                failure = failure.or(Some("unexpected MAX_NUM_ACTIVE_VARIABLES"));
            } else {
                log::debug!("MAX_NUM_ACTIVE_VARIABLES valid");
            }
        }

        match failure {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `InterfaceBlockDataSizeTestCase` - BUFFER_DATA_SIZE must be at least what a tightly
/// packed block of the same members would need.
pub struct InterfaceBlockDataSizeTestCase {
    name: String,
    storage: Storage,
    case_type: InterfaceBlockCaseType,
}

impl InterfaceBlockDataSizeTestCase {
    pub fn new(name: impl Into<String>, storage: Storage, case_type: InterfaceBlockCaseType) -> Self {
        Self {
            name: name.into(),
            storage,
            case_type,
        }
    }
}

impl TestCase for InterfaceBlockDataSizeTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let program_definition = build_interface_block_program(context, self.storage, self.case_type);
        let program_interface = block_program_interface(self.storage);
        let gl_interface = program_interface_gl_enum(program_interface);
        let block_names = program_interface_resource_list(&program_definition, program_interface);

        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);
        check_and_log_program(&program, &program_definition, context)?;

        let gl = context.gl();
        let mut failure: Option<&'static str> = None;

        for block_name in &block_names {
            log::debug!("Block \"{block_name}\"");

            let c_name = std::ffi::CString::new(block_name.as_str()).expect("a block name has no interior NUL");
            // SAFETY: the name outlives the call.
            let resource_ndx =
                unsafe { gl.get_program_resource_index(program.program(), gl_interface, c_name.as_ptr()) };

            // `getBlockMinDataSize` - the block with this name and this storage, packed tight.
            let block_short_name = crate::glu::var_type::parse_variable_name(block_name);
            let expected_min_data_size: i32 = program_definition.shaders()[0]
                .default_block
                .interface_blocks
                .iter()
                .find(|b| b.interface_name == block_short_name && b.storage == Some(self.storage))
                .map(|b| b.variables.iter().map(|v| var_type_size(&v.var_type)).sum())
                .expect("the resource list only names blocks the definition has");

            if resource_ndx == glw::GL_INVALID_INDEX {
                log::debug!("Error, getProgramResourceIndex returned GL_INVALID_INDEX for \"{block_name}\"");
                failure = failure.or(Some("Resource not found"));
                continue;
            }

            let mut query_data_size: GLint = -1;
            let prop = glw::GL_BUFFER_DATA_SIZE;
            // SAFETY: one property in, one GLint out, and the length pointer is optional.
            unsafe {
                gl.get_program_resourceiv(
                    program.program(),
                    gl_interface,
                    resource_ndx,
                    1,
                    &prop,
                    1,
                    std::ptr::null_mut(),
                    &mut query_data_size,
                );
            }

            log::debug!(
                "BUFFER_DATA_SIZE = {query_data_size}\nBuffer data size with tight packing: {expected_min_data_size}"
            );

            if query_data_size < expected_min_data_size {
                log::debug!("Error, buffer size was less than minimum buffer data size");
                failure = failure.or(Some("Buffer data size invalid"));
            } else {
                log::debug!("Buffer size valid");
            }
        }

        match failure {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `AtomicCounterCase::init` - three counters over two bindings, the second of which
/// carries an explicit offset.
fn build_atomic_counter_program(context: &Context) -> Program {
    use crate::glu::shader_util::DataType;
    use crate::glu::var_type::{VarType, VariableDeclaration};

    let mut program = Program::new();
    let shader = program.add_shader(ShaderType::Compute, context.context_type().glsl_version());

    let counter = |name: &str, binding: i32, offset: Option<i32>| {
        let mut decl = VariableDeclaration::new(
            VarType::basic(DataType::UintAtomicCounter, None),
            name,
            Some(Storage::Uniform),
        );
        decl.layout.binding = Some(binding);
        decl.layout.offset = offset;
        decl
    };

    shader
        .default_block
        .variables
        .push(counter("binding1_counter1", 1, None));
    shader
        .default_block
        .variables
        .push(counter("binding1_counter2", 1, Some(8)));
    shader
        .default_block
        .variables
        .push(counter("binding2_counter1", 2, None));

    debug_assert!(program.is_valid());
    program
}

/// Every atomic counter in the program's one shader, as (name, binding, offset).
fn atomic_counters(program: &Program) -> Vec<(&str, i32, Option<i32>)> {
    program.shaders()[0]
        .default_block
        .variables
        .iter()
        .filter(|v| v.var_type.is_basic_type() && v.var_type.basic_type().is_atomic_counter())
        .map(|v| {
            (
                v.name.as_str(),
                v.layout.binding.expect("an atomic counter always carries a binding"),
                v.layout.offset,
            )
        })
        .collect()
}

/// `AtomicCounterCase::getNumAtomicCounterBuffers`
fn num_atomic_counter_buffers(program: &Program) -> i32 {
    let bindings: std::collections::BTreeSet<i32> = atomic_counters(program)
        .into_iter()
        .map(|(_, binding, _)| binding)
        .collect();
    bindings.len() as i32
}

/// `AtomicCounterCase::getBufferVariableCount`
fn atomic_buffer_variable_count(program: &Program, binding: i32) -> i32 {
    atomic_counters(program)
        .into_iter()
        .filter(|&(_, b, _)| b == binding)
        .count() as i32
}

/// `AtomicCounterCase::getMaxNumActiveVariables`
fn atomic_max_num_active_variables(program: &Program) -> i32 {
    let mut num_buffer_vars: std::collections::BTreeMap<i32, i32> = std::collections::BTreeMap::new();
    for (_, binding, _) in atomic_counters(program) {
        *num_buffer_vars.entry(binding).or_insert(0) += 1;
    }
    num_buffer_vars.values().copied().max().unwrap_or(0)
}

/// `AtomicCounterCase::getBufferMinimumDataSize` - `-1` where upstream answers -1, i.e.
/// there is no such binding at all.
fn atomic_buffer_minimum_data_size(program: &Program, binding: i32) -> i32 {
    let mut min_size = -1;
    let mut current_offset = 0;

    for (_, var_binding, offset) in atomic_counters(program) {
        if var_binding != binding {
            continue;
        }
        let this_offset = offset.unwrap_or(current_offset);
        current_offset = this_offset + 4;
        min_size = min_size.max(this_offset + 4);
    }

    min_size
}

/// `gl.getProgramResourceiv` for one property, answering the value and how many values the
/// driver said it wrote.
fn query_resource_prop(
    context: &Context,
    program: GLuint,
    interface: GLenum,
    index: GLuint,
    prop: GLenum,
) -> (GLint, glw::GLsizei) {
    let mut value: GLint = -1;
    let mut written: glw::GLsizei = -1;
    // SAFETY: one property in, one GLint out.
    unsafe {
        context
            .gl()
            .get_program_resourceiv(program, interface, index, 1, &prop, 1, &mut written, &mut value);
    }
    (value, written)
}

/// `gl.getProgramResourceName` for one resource, sized from its own GL_NAME_LENGTH.
fn query_resource_name(context: &Context, program: GLuint, interface: GLenum, index: GLuint) -> Option<String> {
    let (name_length, written) = query_resource_prop(context, program, interface, index, glw::GL_NAME_LENGTH);
    if written <= 0 || name_length == -1 {
        return None;
    }

    // +2 to tolerate an off-by-one; the name-length cases check that properly.
    let mut name_buf = vec![b'X'; name_length as usize + 2];
    let mut written: glw::GLsizei = -1;
    // SAFETY: at most `name_buf.len()` bytes out, and the driver reports how many.
    unsafe {
        context.gl().get_program_resource_name(
            program,
            interface,
            index,
            name_buf.len() as glw::GLsizei,
            &mut written,
            name_buf.as_mut_ptr().cast(),
        );
    }

    if written <= 0 {
        return None;
    }

    Some(String::from_utf8_lossy(&name_buf[..written as usize]).into_owned())
}

/// The three atomic-counter-buffer cases that only differ in what they check per buffer.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum AtomicCounterCaseKind {
    /// `AtomicCounterResourceListCase`
    ResourceList,
    /// `AtomicCounterActiveVariablesCase`
    ActiveVariables,
    /// `AtomicCounterBufferBindingCase`
    BufferBinding,
    /// `AtomicCounterBufferDataSizeCase`
    BufferDataSize,
}

/// `AtomicCounterCase` and its four subclasses.
pub struct AtomicCounterCase {
    name: String,
    kind: AtomicCounterCaseKind,
}

impl AtomicCounterCase {
    pub fn new(name: impl Into<String>, kind: AtomicCounterCaseKind) -> Self {
        Self {
            name: name.into(),
            kind,
        }
    }
}

impl TestCase for AtomicCounterCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let program_definition = build_atomic_counter_program(context);
        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);
        check_and_log_program(&program, &program_definition, context)?;

        let gl = context.gl();
        let num_atomic_buffers = num_atomic_counter_buffers(&program_definition);
        let mut failure: Option<String> = None;

        if self.kind == AtomicCounterCaseKind::ResourceList {
            // 2 buffer bindings
            const NUM_EXPECTED_ACTIVE_RESOURCES: GLint = 2;
            let mut num_active_resources: GLint = -1;

            log::debug!("Verifying ACTIVE_RESOURCES, expecting {NUM_EXPECTED_ACTIVE_RESOURCES}");
            // SAFETY: one GLint out.
            unsafe {
                gl.get_program_interfaceiv(
                    program.program(),
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    glw::GL_ACTIVE_RESOURCES,
                    &mut num_active_resources,
                );
            }
            log::debug!("ACTIVE_RESOURCES = {num_active_resources}");

            if num_active_resources != NUM_EXPECTED_ACTIVE_RESOURCES {
                log::debug!("Error, got unexpected ACTIVE_RESOURCES");
                return Ok(TestStatus::fail("got unexpected ACTIVE_RESOURCES"));
            }
            log::debug!("ACTIVE_RESOURCES valid");
            return Ok(TestStatus::pass("Pass"));
        }

        if self.kind == AtomicCounterCaseKind::ActiveVariables {
            let expected_max_num_active_variables = atomic_max_num_active_variables(&program_definition);
            let mut query_active_resources: GLint = -1;
            let mut query_max_num_active_variables: GLint = -1;

            // SAFETY: one GLint out per query.
            unsafe {
                gl.get_program_interfaceiv(
                    program.program(),
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    glw::GL_ACTIVE_RESOURCES,
                    &mut query_active_resources,
                );
                gl.get_program_interfaceiv(
                    program.program(),
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    glw::GL_MAX_NUM_ACTIVE_VARIABLES,
                    &mut query_max_num_active_variables,
                );
            }

            log::debug!(
                "GL_ACTIVE_RESOURCES = {query_active_resources}\nGL_MAX_NUM_ACTIVE_VARIABLES = {query_max_num_active_variables}"
            );

            if query_active_resources != num_atomic_buffers {
                log::debug!("Error, got unexpected GL_ACTIVE_RESOURCES, expected {num_atomic_buffers}");
                failure = failure.or_else(|| Some("got unexpected GL_ACTIVE_RESOURCES".to_string()));
            }

            if query_max_num_active_variables != expected_max_num_active_variables {
                log::debug!(
                    "Error, got unexpected GL_MAX_NUM_ACTIVE_VARIABLES, expected {expected_max_num_active_variables}"
                );
                failure = failure.or_else(|| Some("got unexpected GL_MAX_NUM_ACTIVE_VARIABLES".to_string()));
            }
        }

        for buffer_ndx in 0..num_atomic_buffers {
            log::debug!("Resource index {buffer_ndx}");
            let buffer_ndx = buffer_ndx as GLuint;

            match self.kind {
                AtomicCounterCaseKind::ResourceList => unreachable!("handled above"),

                AtomicCounterCaseKind::ActiveVariables => {
                    let (num_active_variables, written) = query_resource_prop(
                        context,
                        program.program(),
                        glw::GL_ATOMIC_COUNTER_BUFFER,
                        buffer_ndx,
                        glw::GL_NUM_ACTIVE_VARIABLES,
                    );

                    if num_active_variables <= 0 {
                        log::debug!("Error, got unexpected NUM_ACTIVE_VARIABLES: {num_active_variables}");
                        failure = failure.or_else(|| Some("got unexpected NUM_ACTIVE_VARIABLES".to_string()));
                        continue;
                    }
                    if written <= 0 {
                        log::debug!("Error, query for NUM_ACTIVE_VARIABLES returned no values");
                        failure = failure.or_else(|| Some("NUM_ACTIVE_VARIABLES query failed".to_string()));
                        continue;
                    }

                    log::debug!("GL_NUM_ACTIVE_VARIABLES = {num_active_variables}");

                    // One extra slot, kept at -2, to catch a driver writing too much.
                    let mut active_variables = vec![-2 as GLint; num_active_variables as usize + 1];
                    let prop = glw::GL_ACTIVE_VARIABLES;
                    let mut written: glw::GLsizei = -1;
                    // SAFETY: one property in, `num_active_variables` slots asked for.
                    unsafe {
                        gl.get_program_resourceiv(
                            program.program(),
                            glw::GL_ATOMIC_COUNTER_BUFFER,
                            buffer_ndx,
                            1,
                            &prop,
                            num_active_variables,
                            &mut written,
                            active_variables.as_mut_ptr(),
                        );
                    }

                    if written != num_active_variables {
                        log::debug!(
                            "Error, unexpected number of ACTIVE_VARIABLES, NUM_ACTIVE_VARIABLES = {num_active_variables}, query returned {written} values"
                        );
                        failure = failure.or_else(|| Some("got unexpected ACTIVE_VARIABLES".to_string()));
                        continue;
                    }
                    if *active_variables.last().expect("one extra slot") != -2 {
                        log::debug!("Error, query for ACTIVE_VARIABLES wrote over target buffer bounds");
                        failure = failure.or_else(|| Some("ACTIVE_VARIABLES query failed".to_string()));
                        continue;
                    }
                    active_variables.pop();

                    log::debug!(
                        "Active variable indices: {{{}}}",
                        active_variables
                            .iter()
                            .map(ToString::to_string)
                            .collect::<Vec<_>>()
                            .join(", ")
                    );

                    // collect member names
                    let mut member_names = Vec::new();
                    for &variable_index in &active_variables {
                        match query_resource_name(context, program.program(), glw::GL_UNIFORM, variable_index as GLuint)
                        {
                            Some(name) => member_names.push(name),
                            None => {
                                log::debug!("Error, query for a resource name returned no name");
                                failure = failure.or_else(|| Some("Name query failed".to_string()));
                            }
                        }
                    }

                    log::debug!(
                        "Active variables:\n{}",
                        member_names.iter().map(|n| format!("\t{n}\n")).collect::<String>()
                    );

                    // check the names are all in the same buffer
                    log::debug!("Verifying names");
                    let mut bindings_valid = true;

                    for member_name in &member_names {
                        let mut prev_binding = -1;

                        for (name, binding, _) in atomic_counters(&program_definition) {
                            if name == member_name {
                                if prev_binding == -1 || prev_binding == binding {
                                    prev_binding = binding;
                                } else {
                                    bindings_valid = false;
                                }
                            }
                        }

                        if prev_binding == -1 {
                            log::debug!("Error, could not find variable with name \"{member_name}\"");
                            failure = failure.or_else(|| Some("Variable name invalid".to_string()));
                        } else if atomic_buffer_variable_count(&program_definition, prev_binding)
                            != member_names.len() as i32
                        {
                            log::debug!(
                                "Error, unexpected variable count for binding {prev_binding}. Expected {}, got {}",
                                atomic_buffer_variable_count(&program_definition, prev_binding),
                                member_names.len()
                            );
                            failure = failure.or_else(|| Some("Variable names invalid".to_string()));
                        }
                    }

                    if !bindings_valid {
                        log::debug!("Error, all resource do not share the same buffer");
                        failure = failure.or_else(|| Some("Active variables invalid".to_string()));
                    }
                }

                AtomicCounterCaseKind::BufferBinding => {
                    let (buffer_binding, written) = query_resource_prop(
                        context,
                        program.program(),
                        glw::GL_ATOMIC_COUNTER_BUFFER,
                        buffer_ndx,
                        glw::GL_BUFFER_BINDING,
                    );

                    if written <= 0 {
                        log::debug!("Error, query for BUFFER_BINDING returned no values.");
                        failure = failure.or_else(|| Some("BUFFER_BINDING query failed".to_string()));
                    }

                    log::debug!("GL_BUFFER_BINDING = {buffer_binding}");

                    // no such buffer binding?
                    if atomic_buffer_variable_count(&program_definition, buffer_binding) == 0 {
                        log::debug!(
                            "Error, got buffer with BUFFER_BINDING = {buffer_binding}, but such buffer does not exist."
                        );
                        failure = failure.or_else(|| Some("got unexpected BUFFER_BINDING".to_string()));
                    }
                }

                AtomicCounterCaseKind::BufferDataSize => {
                    let props = [glw::GL_BUFFER_BINDING, glw::GL_BUFFER_DATA_SIZE];
                    let mut values = [-1 as GLint; 2];
                    let mut written: glw::GLsizei = -1;
                    // SAFETY: two properties in, two slots out.
                    unsafe {
                        gl.get_program_resourceiv(
                            program.program(),
                            glw::GL_ATOMIC_COUNTER_BUFFER,
                            buffer_ndx,
                            props.len() as glw::GLsizei,
                            props.as_ptr(),
                            values.len() as glw::GLsizei,
                            &mut written,
                            values.as_mut_ptr(),
                        );
                    }

                    if written != 2 {
                        log::debug!("Error, query for (BUFFER_BINDING, BUFFER_DATA_SIZE) returned {written} value(s).");
                        failure = failure.or_else(|| Some("property query failed".to_string()));
                        continue;
                    }

                    log::debug!("GL_BUFFER_BINDING = {}\nGL_BUFFER_DATA_SIZE = {}", values[0], values[1]);

                    let buffer_min_data_size = atomic_buffer_minimum_data_size(&program_definition, values[0]);
                    log::debug!("Verifying data size, expected greater than or equal to {buffer_min_data_size}");

                    // no such buffer binding?
                    if buffer_min_data_size == -1 {
                        log::debug!(
                            "Error, got buffer with BUFFER_BINDING = {}, but such buffer does not exist.",
                            values[0]
                        );
                        failure = failure.or_else(|| Some("got unexpected BUFFER_BINDING".to_string()));
                    } else if values[1] < buffer_min_data_size {
                        log::debug!(
                            "Error, got buffer with BUFFER_DATA_SIZE = {}, expected greater than or equal to {buffer_min_data_size}",
                            values[1]
                        );
                        failure = failure.or_else(|| Some("got unexpected BUFFER_BINDING".to_string()));
                    } else {
                        log::debug!("Data size valid");
                    }
                }
            }
        }

        match failure {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// The `REFERENCED_BY_*_SHADER` property of each stage, with the extension that stage needs
/// below ES 3.2.
const REFERENCED_BY_PROPS: [(GLenum, ShaderType, Option<&str>); 6] = [
    (glw::GL_REFERENCED_BY_VERTEX_SHADER, ShaderType::Vertex, None),
    (glw::GL_REFERENCED_BY_FRAGMENT_SHADER, ShaderType::Fragment, None),
    (glw::GL_REFERENCED_BY_COMPUTE_SHADER, ShaderType::Compute, None),
    (
        glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
        ShaderType::TessControl,
        Some("GL_EXT_tessellation_shader"),
    ),
    (
        glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
        ShaderType::TessEvaluation,
        Some("GL_EXT_tessellation_shader"),
    ),
    (
        glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
        ShaderType::Geometry,
        Some("GL_EXT_geometry_shader"),
    ),
];

/// `AtomicCounterReferencedByCase` - one atomic counter, declared in some stages and only
/// present in others, so REFERENCED_BY_* must answer for the declaring ones alone.
pub struct AtomicCounterReferencedByCase {
    name: String,
    separable: bool,
    present_stages_mask: u32,
    active_stages_mask: u32,
}

impl AtomicCounterReferencedByCase {
    pub fn new(name: impl Into<String>, separable: bool, present_stages_mask: u32, active_stages_mask: u32) -> Self {
        debug_assert_eq!(active_stages_mask & present_stages_mask, active_stages_mask);
        Self {
            name: name.into(),
            separable,
            present_stages_mask,
            active_stages_mask,
        }
    }
}

impl TestCase for AtomicCounterReferencedByCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        use crate::gles31::functional::program_interface_resource_definition::ALL_SHADER_TYPES;
        use crate::glu::shader_util::DataType;
        use crate::glu::var_type::{VarType, VariableDeclaration};

        let geometry_mask = 1 << (ShaderType::Geometry as u32);
        let tessellation_mask = (1 << (ShaderType::TessControl as u32)) | (1 << (ShaderType::TessEvaluation as u32));
        let supports_es32 = context.context_type().supports(3, 2);

        if self.present_stages_mask & tessellation_mask != 0
            && !supports_es32
            && !context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader extension".to_string(),
            ));
        }
        if self.present_stages_mask & geometry_mask != 0
            && !supports_es32
            && !context.context_info.is_extension_supported("GL_EXT_geometry_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_geometry_shader extension".to_string(),
            ));
        }

        let mut atomic_var = VariableDeclaration::new(
            VarType::basic(DataType::UintAtomicCounter, None),
            "targetCounter",
            Some(Storage::Uniform),
        );
        atomic_var.layout.binding = Some(1);

        let glsl_version = context.context_type().glsl_version();
        let mut program_definition = Program::new();
        program_definition.set_separable(self.separable);

        for shader_type in ALL_SHADER_TYPES {
            let mask = 1 << (shader_type as u32);
            if self.active_stages_mask & mask != 0 {
                program_definition
                    .add_shader(shader_type, glsl_version)
                    .default_block
                    .variables
                    .push(atomic_var.clone());
            } else if self.present_stages_mask & mask != 0 {
                program_definition.add_shader(shader_type, glsl_version);
            }
        }

        if program_definition.has_stage(ShaderType::Geometry) {
            program_definition.set_geometry_num_output_vertices(1);
        }
        if program_definition.has_stage(ShaderType::TessControl)
            || program_definition.has_stage(ShaderType::TessEvaluation)
        {
            program_definition.set_tessellation_num_output_patch_vertices(1);
        }
        debug_assert!(program_definition.is_valid());

        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);
        check_and_log_program(&program, &program_definition, context)?;

        let mut failure: Option<&'static str> = None;

        for (prop, shader_type, extension) in REFERENCED_BY_PROPS {
            // An ES 3.2 context has every stage core, so the extension check only applies
            // below it.
            let needs_extension = extension.filter(|_| !supports_es32);
            if needs_extension.is_some_and(|e| !context.context_info.is_extension_supported(e)) {
                continue;
            }

            let expected = GLint::from(self.active_stages_mask & (1 << (shader_type as u32)) != 0);
            log::debug!(
                "Verifying {prop:#x}, expecting {}",
                if expected != 0 { "GL_TRUE" } else { "GL_FALSE" }
            );

            let (value, written) =
                query_resource_prop(context, program.program(), glw::GL_ATOMIC_COUNTER_BUFFER, 0, prop);

            if written != 1 {
                log::debug!("Error, query for referenced_by_* returned invalid number of values.");
                failure = failure.or(Some("property query failed"));
                continue;
            }

            log::debug!("{prop:#x} = {value}");

            if value != expected {
                log::debug!("Error, got unexpected value");
                failure = failure.or(Some("unexpected property value"));
            }
        }

        match failure {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `ProgramInputOutputReferencedByCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum InputOutputReferencedByCaseType {
    VertexFragment,
    VertexGeoFragment,
    VertexTessFragment,
    VertexTessGeoFragment,
    SeparableVertex,
    SeparableFragment,
    SeparableGeometry,
    SeparableTessCtrl,
    SeparableTessEval,
}

impl InputOutputReferencedByCaseType {
    /// The single stage a separable case builds, or `None` for the linked-pipeline cases.
    fn separable_stage(self) -> Option<ShaderType> {
        match self {
            Self::SeparableVertex => Some(ShaderType::Vertex),
            Self::SeparableFragment => Some(ShaderType::Fragment),
            Self::SeparableGeometry => Some(ShaderType::Geometry),
            Self::SeparableTessCtrl => Some(ShaderType::TessControl),
            Self::SeparableTessEval => Some(ShaderType::TessEvaluation),
            _ => None,
        }
    }

    fn has_tessellation_shader(self) -> bool {
        matches!(
            self,
            Self::VertexTessFragment | Self::VertexTessGeoFragment | Self::SeparableTessCtrl | Self::SeparableTessEval
        )
    }

    fn has_geometry_shader(self) -> bool {
        matches!(
            self,
            Self::VertexGeoFragment | Self::VertexTessGeoFragment | Self::SeparableGeometry
        )
    }
}

/// `ProgramInputOutputReferencedByCase` - the program input/output interface only ever
/// reports the first and the last stage, whatever the middle ones declare.
pub struct ProgramInputOutputReferencedByCase {
    name: String,
    target_storage: Storage,
    case_type: InputOutputReferencedByCaseType,
}

impl ProgramInputOutputReferencedByCase {
    pub fn new(name: impl Into<String>, target_storage: Storage, case_type: InputOutputReferencedByCaseType) -> Self {
        Self {
            name: name.into(),
            target_storage,
            case_type,
        }
    }

    /// `ProgramInputOutputReferencedByCase::init`
    fn build_program(&self, context: &Context) -> Result<Program, TestError> {
        use crate::glu::shader_util::{DataType, Precision};
        use crate::glu::var_type::{Layout, UNSIZED_ARRAY, VarType, VariableDeclaration};

        let supports_es32 = context.context_type().supports(3, 2);

        if self.case_type.has_tessellation_shader()
            && !supports_es32
            && !context
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_tessellation_shader extension".to_string(),
            ));
        }
        if self.case_type.has_geometry_shader()
            && !supports_es32
            && !context.context_info.is_extension_supported("GL_EXT_geometry_shader")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_geometry_shader extension".to_string(),
            ));
        }

        let glsl_version = context.context_type().glsl_version();
        let mut program = Program::new();
        let highp_vec4 = || VarType::basic(DataType::FloatVec4, Some(Precision::HighP));

        if let Some(shader_type) = self.case_type.separable_stage() {
            let is_input_case = matches!(self.target_storage, Storage::In | Storage::PatchIn);
            let per_patch_storage = matches!(self.target_storage, Storage::PatchIn | Storage::PatchOut);
            let var_name = if is_input_case { "shaderInput" } else { "shaderOutput" };

            let arrayed_interface = if is_input_case {
                matches!(
                    shader_type,
                    ShaderType::Geometry | ShaderType::TessControl | ShaderType::TessEvaluation
                )
            } else {
                shader_type == ShaderType::TessControl
            };

            program.set_separable(true);

            let var_type = if arrayed_interface && !per_patch_storage {
                VarType::array(highp_vec4(), UNSIZED_ARRAY)
            } else {
                highp_vec4()
            };

            program
                .add_shader(shader_type, glsl_version)
                .default_block
                .variables
                .push(VariableDeclaration::new(var_type, var_name, Some(self.target_storage)));
        } else {
            program.set_separable(false);

            let with_location = |var_type: VarType, name: &str, storage: Storage, location: i32| {
                let mut decl = VariableDeclaration::new(var_type, name, Some(storage));
                decl.layout = Layout::location(location);
                decl
            };

            {
                let vertex = program.add_shader(ShaderType::Vertex, glsl_version);
                vertex.default_block.variables.push(VariableDeclaration::new(
                    highp_vec4(),
                    "shaderInput",
                    Some(Storage::In),
                ));
                vertex
                    .default_block
                    .variables
                    .push(with_location(highp_vec4(), "shaderOutput", Storage::Out, 1));
            }

            {
                let fragment = program.add_shader(ShaderType::Fragment, glsl_version);
                fragment
                    .default_block
                    .variables
                    .push(with_location(highp_vec4(), "shaderOutput", Storage::Out, 0));
                fragment
                    .default_block
                    .variables
                    .push(with_location(highp_vec4(), "shaderInput", Storage::In, 1));
            }

            if self.case_type.has_tessellation_shader() {
                let arrayed = || VarType::array(highp_vec4(), UNSIZED_ARRAY);

                {
                    let tess_ctrl = program.add_shader(ShaderType::TessControl, glsl_version);
                    tess_ctrl
                        .default_block
                        .variables
                        .push(with_location(arrayed(), "shaderInput", Storage::In, 1));
                    tess_ctrl
                        .default_block
                        .variables
                        .push(with_location(arrayed(), "shaderOutput", Storage::Out, 1));
                }

                {
                    let tess_eval = program.add_shader(ShaderType::TessEvaluation, glsl_version);
                    tess_eval
                        .default_block
                        .variables
                        .push(with_location(arrayed(), "shaderInput", Storage::In, 1));
                    tess_eval.default_block.variables.push(with_location(
                        highp_vec4(),
                        "shaderOutput",
                        Storage::Out,
                        1,
                    ));
                }
            }

            if self.case_type.has_geometry_shader() {
                let geometry = program.add_shader(ShaderType::Geometry, glsl_version);
                geometry.default_block.variables.push(with_location(
                    VarType::array(highp_vec4(), UNSIZED_ARRAY),
                    "shaderInput",
                    Storage::In,
                    1,
                ));
                geometry
                    .default_block
                    .variables
                    .push(with_location(highp_vec4(), "shaderOutput", Storage::Out, 1));
            }
        }

        if program.has_stage(ShaderType::Geometry) {
            program.set_geometry_num_output_vertices(1);
        }
        if program.has_stage(ShaderType::TessControl) || program.has_stage(ShaderType::TessEvaluation) {
            program.set_tessellation_num_output_patch_vertices(1);
        }
        debug_assert!(program.is_valid());

        Ok(program)
    }
}

impl TestCase for ProgramInputOutputReferencedByCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let program_definition = self.build_program(context)?;
        let is_input_case = matches!(self.target_storage, Storage::In | Storage::PatchIn);
        let target_resource_name = if is_input_case { "shaderInput" } else { "shaderOutput" };
        let gl_interface = if is_input_case {
            glw::GL_PROGRAM_INPUT
        } else {
            glw::GL_PROGRAM_OUTPUT
        };

        let sources = generate_program_interface_program_sources(&program_definition);
        let program = ShaderProgram::new(context.gl(), &sources);
        check_and_log_program(&program, &program_definition, context)?;

        let c_name = std::ffi::CString::new(target_resource_name).expect("a resource name has no interior NUL");
        // SAFETY: the name outlives the call.
        let resource_index = unsafe {
            context
                .gl()
                .get_program_resource_index(program.program(), gl_interface, c_name.as_ptr())
        };

        if resource_index == glw::GL_INVALID_INDEX {
            log::debug!("Error, query for resource \"{target_resource_name}\" index returned invalid index.");
            return Ok(TestStatus::fail("could not find target resource"));
        }

        let mut failure: Option<&'static str> = None;

        for (prop, shader_type, extension) in REFERENCED_BY_PROPS {
            // \note unlike the atomic counter case, upstream checks the extension here
            // whatever the context version is.
            if extension.is_some_and(|e| !context.context_info.is_extension_supported(e)) {
                continue;
            }

            let expected = if is_input_case {
                Some(shader_type) == program_definition.first_stage()
            } else {
                Some(shader_type) == program_definition.last_stage()
            };

            log::debug!(
                "Verifying {prop:#x}, expecting {}",
                if expected { "TRUE" } else { "FALSE" }
            );

            let (value, written) = query_resource_prop(context, program.program(), gl_interface, resource_index, prop);

            if written != 1 {
                log::debug!("Error, query for referenced_by_* returned invalid number of values.");
                failure = failure.or(Some("property query failed"));
                continue;
            }

            log::debug!("{prop:#x} = {value}");

            if value != GLint::from(expected) {
                log::debug!("Error, got unexpected value");
                failure = failure.or(Some("unexpected property value"));
            }
        }

        match failure {
            Some(err) => Ok(TestStatus::fail(err)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

// The case-tree generators. Upstream builds the tree with a `Context` in hand; here the
// tree is built without one, which is why a `Shader` node carries no GLSL version.

use crate::gles31::functional::program_interface_query_test_case::prop;
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::var_type::{Interpolation, Layout, MatrixOrder};

/// One case, as the node a group takes.
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

/// A `ResourceTestCase` node.
fn resource_case(resource: &NodePtr, target: ProgramResourceQueryTestTarget, name: Option<&str>) -> Box<dyn TestCase> {
    boxed(resource_test_case(resource, target, name))
}

/// A `ResourceListTestCase` node.
fn resource_list_case(resource: &NodePtr, interface: ProgramInterface) -> Box<dyn TestCase> {
    boxed(ResourceListTestCase::new(resource, interface, None))
}

/// `isDataTypeLayoutQualified`
fn is_data_type_layout_qualified(data_type: DataType) -> bool {
    data_type.is_image() || data_type.is_atomic_counter()
}

/// `generateVariableCases`'s type table: the expansion level each type first appears at.
const VARIABLE_TYPES: &[(i32, DataType)] = &[
    (0, DataType::Float),
    (1, DataType::Int),
    (1, DataType::Uint),
    (1, DataType::Bool),
    (3, DataType::FloatVec2),
    (1, DataType::FloatVec3),
    (1, DataType::FloatVec4),
    (3, DataType::IntVec2),
    (2, DataType::IntVec3),
    (3, DataType::IntVec4),
    (3, DataType::UintVec2),
    (2, DataType::UintVec3),
    (3, DataType::UintVec4),
    (3, DataType::BoolVec2),
    (2, DataType::BoolVec3),
    (3, DataType::BoolVec4),
    (2, DataType::FloatMat2),
    (3, DataType::FloatMat2x3),
    (3, DataType::FloatMat2x4),
    (2, DataType::FloatMat3x2),
    (2, DataType::FloatMat3),
    (3, DataType::FloatMat3x4),
    (2, DataType::FloatMat4x2),
    (3, DataType::FloatMat4x3),
    (2, DataType::FloatMat4),
];

/// `generateOpaqueTypeCases`'s type table.
const OPAQUE_TYPES: &[(i32, DataType)] = &[
    (0, DataType::Sampler2D),
    (2, DataType::SamplerCube),
    (1, DataType::Sampler2DArray),
    (1, DataType::Sampler3D),
    (2, DataType::Sampler2DShadow),
    (3, DataType::SamplerCubeShadow),
    (3, DataType::Sampler2DArrayShadow),
    (1, DataType::IntSampler2D),
    (3, DataType::IntSamplerCube),
    (3, DataType::IntSampler2DArray),
    (3, DataType::IntSampler3D),
    (2, DataType::UintSampler2D),
    (3, DataType::UintSamplerCube),
    (3, DataType::UintSampler2DArray),
    (3, DataType::UintSampler3D),
    (2, DataType::Sampler2DMultisample),
    (2, DataType::IntSampler2DMultisample),
    (3, DataType::UintSampler2DMultisample),
    (1, DataType::Image2D),
    (3, DataType::ImageCube),
    (3, DataType::Image2DArray),
    (3, DataType::Image3D),
    (3, DataType::IntImage2D),
    (3, DataType::IntImageCube),
    (1, DataType::IntImage2DArray),
    (3, DataType::IntImage3D),
    (2, DataType::UintImage2D),
    (3, DataType::UintImageCube),
    (3, DataType::UintImage2DArray),
    (3, DataType::UintImage3D),
    (1, DataType::UintAtomicCounter),
];

/// Runs `body` against either a fresh sub-group of `target_group` or `target_group` itself,
/// which is what upstream's `createTestGroup` flag chooses between.
fn in_group(target_group: &mut TestCaseGroup, create: bool, name: &str, body: impl FnOnce(&mut TestCaseGroup)) {
    if create {
        let mut group = TestCaseGroup::new(name);
        body(&mut group);
        target_group.add_child(group);
    } else {
        body(target_group);
    }
}

/// `generateVariableCases`
fn generate_variable_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
    create_test_group: bool,
) {
    in_group(target_group, create_test_group, "basic_type", |group| {
        for &(level, data_type) in VARIABLE_TYPES {
            if level <= expand_level {
                group.add_child(resource_case(&Node::variable(parent, data_type), query_target, None));
            }
        }
    });
}

/// `generateOpaqueTypeCases`
fn generate_opaque_type_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
    create_test_group: bool,
) {
    // Requirements: opaque types cannot go inside an interface block, and a layout
    // qualifier cannot go on a struct member.
    let mut is_struct_member = false;
    let mut node = Some(Arc::clone(parent));
    while let Some(current) = node {
        if matches!(current.kind, NodeKind::InterfaceBlock { .. }) {
            return;
        }
        is_struct_member |= matches!(current.kind, NodeKind::StructMember);
        node = current.enclosing.clone();
    }

    in_group(target_group, create_test_group, "opaque_type", |group| {
        for &(level, data_type) in OPAQUE_TYPES {
            if level > expand_level {
                continue;
            }
            if is_data_type_layout_qualified(data_type) && is_struct_member {
                continue;
            }
            group.add_child(resource_case(&Node::variable(parent, data_type), query_target, None));
        }
    });
}

/// `generateVariableArrayCases`
fn generate_variable_array_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
) {
    if expand_level <= 0 {
        return;
    }

    let array_element = Node::array_element_default(parent);
    let mut block_group = TestCaseGroup::new("array");

    // Arrays of basic variables
    generate_variable_cases(
        &array_element,
        &mut block_group,
        query_target,
        expand_level,
        expand_level != 1,
    );
    // Arrays of opaque types
    generate_opaque_type_cases(
        &array_element,
        &mut block_group,
        query_target,
        expand_level,
        expand_level != 1,
    );
    // Arrays of arrays
    generate_variable_array_cases(&array_element, &mut block_group, query_target, expand_level - 1);
    // Arrays of structs
    generate_compound_variable_cases(&array_element, &mut block_group, query_target, expand_level - 1);

    target_group.add_child(block_group);
}

/// `generateCompoundVariableCases`
fn generate_compound_variable_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
) {
    if expand_level <= 0 {
        return;
    }

    let struct_member = Node::struct_member(parent);
    let mut block_group = TestCaseGroup::new("struct");

    // Struct containing a basic variable
    generate_variable_cases(
        &struct_member,
        &mut block_group,
        query_target,
        expand_level,
        expand_level != 1,
    );
    // Struct containing opaque types
    generate_opaque_type_cases(
        &struct_member,
        &mut block_group,
        query_target,
        expand_level,
        expand_level != 1,
    );
    // Struct containing arrays
    generate_variable_array_cases(&struct_member, &mut block_group, query_target, expand_level - 1);
    // Struct containing a struct
    generate_compound_variable_cases(&struct_member, &mut block_group, query_target, expand_level - 1);

    target_group.add_child(block_group);
}

/// `BlockFlags`
pub mod block_flag {
    pub const DEFAULT: u32 = 0x01;
    pub const NAMED: u32 = 0x02;
    pub const UNNAMED: u32 = 0x04;
    pub const ARRAY: u32 = 0x08;
    pub const ALL: u32 = 0x0F;
}

/// `generateUniformCaseBlocks`
fn generate_uniform_case_blocks(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    block_flags: u32,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup),
) {
    let default_block = Node::default_block(parent);
    let uniform = Node::storage_qualifier(&default_block, Storage::Uniform);

    // .default_block
    if block_flags & block_flag::DEFAULT != 0 {
        let mut block_group = TestCaseGroup::new("default_block");
        block_content(&uniform, &mut block_group);
        target_group.add_child(block_group);
    }

    // .named_block
    if block_flags & block_flag::NAMED != 0 {
        let block = Node::interface_block(&uniform, true);
        let mut block_group = TestCaseGroup::new("named_block");
        block_content(&block, &mut block_group);
        target_group.add_child(block_group);
    }

    // .unnamed_block
    if block_flags & block_flag::UNNAMED != 0 {
        let block = Node::interface_block(&uniform, false);
        let mut block_group = TestCaseGroup::new("unnamed_block");
        block_content(&block, &mut block_group);
        target_group.add_child(block_group);
    }

    // .block_array
    if block_flags & block_flag::ARRAY != 0 {
        let array_element = Node::array_element_default(&uniform);
        let block = Node::interface_block(&array_element, true);
        let mut block_group = TestCaseGroup::new("block_array");
        block_content(&block, &mut block_group);
        target_group.add_child(block_group);
    }
}

/// `generateBufferBackedResourceListBlockContentCases`
fn generate_buffer_backed_resource_list_block_content_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    depth: i32,
) {
    // variable
    target_group.add_child(resource_list_case(
        &Node::variable(parent, DataType::FloatVec4),
        interface,
    ));

    if depth > 0 {
        // struct
        generate_buffer_backed_resource_list_block_content_cases(
            &Node::struct_member(parent),
            target_group,
            interface,
            depth - 1,
        );
        // array
        generate_buffer_backed_resource_list_block_content_cases(
            &Node::array_element_default(parent),
            target_group,
            interface,
            depth - 1,
        );
    }
}

/// `generateBufferBackedVariableAggregateTypeCases`
fn generate_buffer_backed_variable_aggregate_type_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    target_prop: u32,
    data_type: DataType,
    name_suffix: &str,
    depth: i32,
) {
    let target = ProgramResourceQueryTestTarget::new(interface, target_prop);

    // variable
    target_group.add_child(resource_case(
        &Node::variable(parent, data_type),
        target,
        Some(&format!("var{name_suffix}")),
    ));

    if depth > 0 {
        // struct
        generate_buffer_backed_variable_aggregate_type_cases(
            &Node::struct_member(parent),
            target_group,
            interface,
            target_prop,
            data_type,
            &format!("_struct{name_suffix}"),
            depth - 1,
        );
        // array
        generate_buffer_backed_variable_aggregate_type_cases(
            &Node::array_element_default(parent),
            target_group,
            interface,
            target_prop,
            data_type,
            &format!("_array{name_suffix}"),
            depth - 1,
        );
    }
}

/// Whether the parent is an interface block, and whether it is a named non-array one - the
/// two questions almost every uniform content generator opens with.
fn block_shape(parent: &NodePtr) -> (bool, bool) {
    let NodeKind::InterfaceBlock { named } = parent.kind else {
        return (false, false);
    };

    let enclosing_is_array = parent
        .enclosing
        .as_ref()
        .is_some_and(|e| matches!(e.kind, NodeKind::ArrayElement { .. }));

    (true, named && !enclosing_is_array)
}

/// `generateUniformResourceListBlockContents`
fn generate_uniform_resource_list_block_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    generate_buffer_backed_resource_list_block_content_cases(parent, target_group, ProgramInterface::Uniform, 4);
}

/// `generateUniformBlockArraySizeContents`
fn generate_uniform_block_array_size_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::ARRAY_SIZE);
    let (is_interface_block, named_non_array_block) = block_shape(parent);

    if !is_interface_block || named_non_array_block {
        // .types
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(parent, &mut block_group, query_target, 2, false);
        generate_opaque_type_cases(parent, &mut block_group, query_target, 2, false);
        target_group.add_child(block_group);

        // .aggregates
        let mut block_group = TestCaseGroup::new("aggregates");
        generate_buffer_backed_variable_aggregate_type_cases(
            parent,
            &mut block_group,
            query_target.interface,
            prop::ARRAY_SIZE,
            DataType::Float,
            "",
            3,
        );
        target_group.add_child(block_group);
    } else {
        generate_buffer_backed_variable_aggregate_type_cases(
            parent,
            target_group,
            query_target.interface,
            prop::ARRAY_SIZE,
            DataType::Float,
            "",
            2,
        );
    }
}

/// `generateBufferBackedArrayStrideTypeAggregateSubCases`
fn generate_buffer_backed_array_stride_type_aggregate_sub_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    name_prefix: &str,
    interface: ProgramInterface,
    data_type: DataType,
    expand_level: i32,
) {
    let target = ProgramResourceQueryTestTarget::new(interface, prop::ARRAY_STRIDE);
    target_group.add_child(resource_case(
        &Node::variable(parent, data_type),
        target,
        Some(name_prefix),
    ));

    if expand_level > 0 {
        generate_buffer_backed_array_stride_type_aggregate_sub_cases(
            &Node::struct_member(parent),
            target_group,
            &format!("{name_prefix}_struct"),
            interface,
            data_type,
            expand_level - 1,
        );
        generate_buffer_backed_array_stride_type_aggregate_sub_cases(
            &Node::array_element_default(parent),
            target_group,
            &format!("{name_prefix}_array"),
            interface,
            data_type,
            expand_level - 1,
        );
    }
}

/// `generateBufferBackedArrayStrideTypeAggregateCases`
fn generate_buffer_backed_array_stride_type_aggregate_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    data_type: DataType,
    expand_level: i32,
    include_base_case: bool,
) {
    let name_prefix = data_type.name();
    let target = ProgramResourceQueryTestTarget::new(interface, prop::ARRAY_STRIDE);

    if expand_level == 0 || include_base_case {
        target_group.add_child(resource_case(
            &Node::variable(parent, data_type),
            target,
            Some(name_prefix),
        ));
    }

    if expand_level >= 1 {
        // _struct - an atomic counter cannot be a struct member
        if !data_type.is_atomic_counter() {
            generate_buffer_backed_array_stride_type_aggregate_sub_cases(
                &Node::struct_member(parent),
                target_group,
                &format!("{name_prefix}_struct"),
                interface,
                data_type,
                expand_level - 1,
            );
        }

        // _array
        generate_buffer_backed_array_stride_type_aggregate_sub_cases(
            &Node::array_element_default(parent),
            target_group,
            &format!("{name_prefix}_array"),
            interface,
            data_type,
            expand_level - 1,
        );
    }
}

/// `generateUniformBlockArrayStrideContents`
fn generate_uniform_block_array_stride_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::ARRAY_STRIDE);
    let (is_interface_block, named_non_array_block) = block_shape(parent);

    if !is_interface_block || named_non_array_block {
        // .types
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(parent, &mut block_group, query_target, 2, false);
        generate_opaque_type_cases(parent, &mut block_group, query_target, 2, false);
        target_group.add_child(block_group);

        // .aggregates
        let mut block_group = TestCaseGroup::new("aggregates");

        if !is_interface_block {
            // .sampler_2d_*
            generate_buffer_backed_array_stride_type_aggregate_cases(
                parent,
                &mut block_group,
                query_target.interface,
                DataType::Sampler2D,
                1,
                false,
            );

            // .atomic_counter_*
            let layout = Node::layout_qualifier(parent, Layout::binding(0));
            generate_buffer_backed_array_stride_type_aggregate_cases(
                &layout,
                &mut block_group,
                query_target.interface,
                DataType::UintAtomicCounter,
                1,
                false,
            );
        }

        for (data_type, expand) in [
            (DataType::Float, 2),
            (DataType::Bool, 1),
            (DataType::BoolVec3, 2),
            (DataType::FloatVec3, 2),
            // \note upstream's comment says .ivec2_*, but the type it passes is ivec3.
            (DataType::IntVec3, 2),
        ] {
            generate_buffer_backed_array_stride_type_aggregate_cases(
                parent,
                &mut block_group,
                query_target.interface,
                data_type,
                expand,
                false,
            );
        }

        target_group.add_child(block_group);
    } else {
        generate_variable_cases(parent, target_group, query_target, 1, true);
        generate_variable_array_cases(parent, target_group, query_target, 1);
        generate_compound_variable_cases(parent, target_group, query_target, 1);
    }
}

/// `generateUniformBlockLocationContents`
fn generate_uniform_block_location_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::LOCATION);
    let (is_interface_block, _) = block_shape(parent);

    if is_interface_block {
        generate_variable_cases(parent, target_group, query_target, 1, false);
    } else {
        generate_variable_cases(parent, target_group, query_target, 3, true);
        generate_opaque_type_cases(parent, target_group, query_target, 3, true);
        generate_variable_array_cases(parent, target_group, query_target, 2);
        generate_compound_variable_cases(parent, target_group, query_target, 2);
    }
}

/// `generateUniformBlockBlockIndexContents`
fn generate_uniform_block_block_index_contents(target_group: &mut TestCaseGroup) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::BLOCK_INDEX);

    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let uniform = Node::storage_qualifier(&default_block, Storage::Uniform);
    let binding = Node::layout_qualifier(&uniform, Layout::binding(0));

    // .default_block
    target_group.add_child(resource_case(
        &Node::variable(&uniform, DataType::FloatVec4),
        target,
        Some("default_block"),
    ));

    // .named_block
    let block = Node::interface_block(&binding, true);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::FloatVec4),
        target,
        Some("named_block"),
    ));

    // .unnamed_block
    let block = Node::interface_block(&binding, false);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::FloatVec4),
        target,
        Some("unnamed_block"),
    ));

    // .block_array
    let array_element = Node::array_element_default(&binding);
    let block = Node::interface_block(&array_element, true);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::FloatVec4),
        target,
        Some("block_array"),
    ));
}

/// `generateUniformBlockAtomicCounterBufferIndexContents`
fn generate_uniform_block_atomic_counter_buffer_index_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target =
        ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::ATOMIC_COUNTER_BUFFER_INDEX);
    let (is_interface_block, _) = block_shape(parent);

    if is_interface_block {
        generate_variable_cases(parent, target_group, query_target, 1, false);
        return;
    }

    generate_variable_cases(parent, target_group, query_target, 3, true);
    generate_opaque_type_cases(parent, target_group, query_target, 3, true);

    // .array
    let array_element = Node::array_element_default(parent);
    let array_array_element = Node::array_element_default(&array_element);
    let mut block_group = TestCaseGroup::new("array");

    block_group.add_child(resource_case(
        &Node::variable(&array_element, DataType::UintAtomicCounter),
        query_target,
        Some("var_array"),
    ));
    block_group.add_child(resource_case(
        &Node::variable(&array_array_element, DataType::UintAtomicCounter),
        query_target,
        Some("var_array_array"),
    ));

    target_group.add_child(block_group);
}

/// `generateUniformBlockNameLengthContents`
fn generate_uniform_block_name_length_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let (is_interface_block, named_non_array_block) = block_shape(parent);
    let depth = if !is_interface_block || named_non_array_block {
        2
    } else {
        1
    };

    generate_buffer_backed_variable_aggregate_type_cases(
        parent,
        target_group,
        ProgramInterface::Uniform,
        prop::NAME_LENGTH,
        DataType::Float,
        "",
        depth,
    );
}

/// `generateUniformBlockTypeContents`
fn generate_uniform_block_type_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::TYPE);
    let (is_interface_block, named_non_array_block) = block_shape(parent);

    if !is_interface_block || named_non_array_block {
        // .types
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(parent, &mut block_group, query_target, 3, false);
        generate_opaque_type_cases(parent, &mut block_group, query_target, 3, false);
        target_group.add_child(block_group);

        generate_variable_array_cases(parent, target_group, query_target, 1);
        generate_compound_variable_cases(parent, target_group, query_target, 1);
    } else {
        generate_variable_cases(parent, target_group, query_target, 1, true);
        generate_variable_array_cases(parent, target_group, query_target, 1);
        generate_compound_variable_cases(parent, target_group, query_target, 1);
    }
}

/// `generateUniformBlockOffsetContents`
fn generate_uniform_block_offset_contents(parent: &NodePtr, target_group: &mut TestCaseGroup) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::OFFSET);
    let (is_interface_block, named_non_array_block) = block_shape(parent);

    if !is_interface_block {
        // .types
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(parent, &mut block_group, query_target, 3, false);
        generate_opaque_type_cases(parent, &mut block_group, query_target, 3, false);
        target_group.add_child(block_group);

        // .aggregates
        let mut block_group = TestCaseGroup::new("aggregates");

        // .atomic_uint_array
        {
            let offset = Node::layout_qualifier(
                parent,
                Layout {
                    offset: Some(4),
                    ..Layout::default()
                },
            );
            let array_element = Node::array_element_default(&offset);
            block_group.add_child(resource_case(
                &Node::variable(&array_element, DataType::UintAtomicCounter),
                query_target,
                Some("atomic_uint_array"),
            ));
        }

        // .float_struct, .float_array
        {
            let struct_member = Node::struct_member(parent);
            let array_element = Node::array_element_default(parent);
            block_group.add_child(resource_case(
                &Node::variable(&struct_member, DataType::Float),
                query_target,
                Some("float_struct"),
            ));
            block_group.add_child(resource_case(
                &Node::variable(&array_element, DataType::Float),
                query_target,
                Some("float_array"),
            ));
        }

        target_group.add_child(block_group);
    } else if named_non_array_block {
        // .types
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(parent, &mut block_group, query_target, 3, false);
        generate_opaque_type_cases(parent, &mut block_group, query_target, 3, false);
        target_group.add_child(block_group);

        // .aggregates
        let mut block_group = TestCaseGroup::new("aggregates");

        // \note upstream builds both of these out of a StructMember, so "float_array" is
        // a second struct case rather than an array one.
        let struct_member = Node::struct_member(parent);
        let array_element = Node::struct_member(parent);
        block_group.add_child(resource_case(
            &Node::variable(&struct_member, DataType::Float),
            query_target,
            Some("float_struct"),
        ));
        block_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::Float),
            query_target,
            Some("float_array"),
        ));

        target_group.add_child(block_group);
    } else {
        generate_variable_cases(parent, target_group, query_target, 1, true);
        generate_variable_array_cases(parent, target_group, query_target, 1);
        generate_compound_variable_cases(parent, target_group, query_target, 1);
    }
}

/// `generateMatrixVariableCases`'s type table: the priority each matrix type has.
const MATRIX_TYPES: &[(i32, DataType)] = &[
    (0, DataType::FloatMat2),
    (1, DataType::FloatMat2x3),
    (2, DataType::FloatMat2x4),
    (2, DataType::FloatMat3x2),
    (1, DataType::FloatMat3),
    (0, DataType::FloatMat3x4),
    (2, DataType::FloatMat4x2),
    (1, DataType::FloatMat4x3),
    (0, DataType::FloatMat4),
];

/// `generateMatrixVariableCases`
fn generate_matrix_variable_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    create_test_group: bool,
    expand_level: i32,
) {
    in_group(target_group, create_test_group, "matrix", |group| {
        for &(priority, data_type) in MATRIX_TYPES {
            if priority < expand_level {
                group.add_child(resource_case(&Node::variable(parent, data_type), query_target, None));
            }
        }
    });
}

/// `generateMatrixArrayCases` - \note dead upstream too: these two only call each other,
/// and nothing calls either. Kept so the file stays comparable against the C++.
#[expect(dead_code, reason = "upstream declares these but never calls them")]
fn generate_matrix_array_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
) {
    if expand_level <= 0 {
        return;
    }

    let array_element = Node::array_element_default(parent);
    let mut block_group = TestCaseGroup::new("array");

    generate_matrix_variable_cases(
        &array_element,
        &mut block_group,
        query_target,
        expand_level != 1,
        expand_level,
    );
    generate_matrix_array_cases(&array_element, &mut block_group, query_target, expand_level - 1);
    generate_matrix_struct_cases(&array_element, &mut block_group, query_target, expand_level - 1);

    target_group.add_child(block_group);
}

/// `generateMatrixStructCases`
#[expect(dead_code, reason = "upstream declares these but never calls them")]
fn generate_matrix_struct_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    expand_level: i32,
) {
    if expand_level <= 0 {
        return;
    }

    let struct_member = Node::struct_member(parent);
    let mut block_group = TestCaseGroup::new("struct");

    generate_matrix_variable_cases(
        &struct_member,
        &mut block_group,
        query_target,
        expand_level != 1,
        expand_level,
    );
    generate_matrix_array_cases(&struct_member, &mut block_group, query_target, expand_level - 1);
    generate_matrix_struct_cases(&struct_member, &mut block_group, query_target, expand_level - 1);

    target_group.add_child(block_group);
}

/// The three matrix-order qualifier groups both matrix content generators walk.
const MATRIX_ORDER_QUALIFIERS: [(&str, Option<MatrixOrder>); 3] = [
    ("no_qualifier", None),
    ("row_major", Some(MatrixOrder::RowMajor)),
    ("column_major", Some(MatrixOrder::ColumnMajor)),
];

/// `generateUniformMatrixOrderCaseBlockContentCases`
fn generate_uniform_matrix_order_case_block_content_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    extended_basic_type_cases: bool,
    opaque_cases: bool,
) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::MATRIX_ROW_MAJOR);

    for (name, order) in MATRIX_ORDER_QUALIFIERS {
        // Layout qualifiers only go on block members.
        if order.is_some() && !matches!(parent.kind, NodeKind::InterfaceBlock { .. }) {
            continue;
        }

        let mut qualifier_group = TestCaseGroup::new(name);
        let sub_structure = match order {
            Some(order) => Node::layout_qualifier(
                parent,
                Layout {
                    matrix_order: Some(order),
                    ..Layout::default()
                },
            ),
            None => Arc::clone(parent),
        };

        if extended_basic_type_cases && order.is_none() {
            // .types
            let mut block_group = TestCaseGroup::new("types");
            generate_variable_cases(&sub_structure, &mut block_group, query_target, 1, false);
            generate_matrix_variable_cases(&sub_structure, &mut block_group, query_target, false, 2);
            if opaque_cases {
                generate_opaque_type_cases(&sub_structure, &mut block_group, query_target, 2, false);
            }
            qualifier_group.add_child(block_group);

            // .aggregates
            let mut block_group = TestCaseGroup::new("aggregates");
            generate_buffer_backed_variable_aggregate_type_cases(
                &sub_structure,
                &mut block_group,
                query_target.interface,
                prop::MATRIX_ROW_MAJOR,
                DataType::FloatMat3x2,
                "",
                1,
            );
            qualifier_group.add_child(block_group);
        } else {
            generate_buffer_backed_variable_aggregate_type_cases(
                &sub_structure,
                &mut qualifier_group,
                query_target.interface,
                prop::MATRIX_ROW_MAJOR,
                DataType::FloatMat3x2,
                "",
                1,
            );
        }

        target_group.add_child(qualifier_group);
    }
}

/// `generateUniformMatrixStrideCaseBlockContentCases` - \note the aggregate cases here ask
/// for MATRIX_ROW_MAJOR, not MATRIX_STRIDE, which is upstream's own choice.
fn generate_uniform_matrix_stride_case_block_content_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    extended_basic_type_cases: bool,
    opaque_cases: bool,
) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::MATRIX_STRIDE);

    for (name, order) in MATRIX_ORDER_QUALIFIERS {
        if order.is_some() && !matches!(parent.kind, NodeKind::InterfaceBlock { .. }) {
            continue;
        }

        let mut qualifier_group = TestCaseGroup::new(name);
        let sub_structure = match order {
            Some(order) => Node::layout_qualifier(
                parent,
                Layout {
                    matrix_order: Some(order),
                    ..Layout::default()
                },
            ),
            None => Arc::clone(parent),
        };

        if extended_basic_type_cases {
            if order.is_none() {
                // .types
                let mut block_group = TestCaseGroup::new("types");
                generate_variable_cases(&sub_structure, &mut block_group, query_target, 1, false);
                generate_matrix_variable_cases(&sub_structure, &mut block_group, query_target, false, 2);
                if opaque_cases {
                    generate_opaque_type_cases(&sub_structure, &mut block_group, query_target, 2, false);
                }
                qualifier_group.add_child(block_group);
            } else {
                // .matrix
                generate_matrix_variable_cases(&sub_structure, &mut qualifier_group, query_target, true, 2);
            }

            // .aggregates
            let mut block_group = TestCaseGroup::new("aggregates");
            generate_buffer_backed_variable_aggregate_type_cases(
                &sub_structure,
                &mut block_group,
                query_target.interface,
                prop::MATRIX_ROW_MAJOR,
                DataType::FloatMat3x2,
                "",
                1,
            );
            qualifier_group.add_child(block_group);
        } else {
            generate_buffer_backed_variable_aggregate_type_cases(
                &sub_structure,
                &mut qualifier_group,
                query_target.interface,
                prop::MATRIX_ROW_MAJOR,
                DataType::FloatMat3x2,
                "",
                1,
            );
        }

        target_group.add_child(qualifier_group);
    }
}

/// `generateUniformMatrixCaseBlocks`
fn generate_uniform_matrix_case_blocks(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup, bool, bool),
) {
    /// One row of upstream's `children` table.
    struct MatrixBlock {
        name: &'static str,
        block: bool,
        named_block: bool,
        extended_basic_type_cases: bool,
        order: Option<MatrixOrder>,
    }

    const CHILDREN: &[MatrixBlock] = &[
        MatrixBlock {
            name: "default_block",
            block: false,
            named_block: true,
            extended_basic_type_cases: true,
            order: None,
        },
        MatrixBlock {
            name: "named_block",
            block: true,
            named_block: true,
            extended_basic_type_cases: true,
            order: None,
        },
        MatrixBlock {
            name: "named_block_row_major",
            block: true,
            named_block: true,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::RowMajor),
        },
        MatrixBlock {
            name: "named_block_col_major",
            block: true,
            named_block: true,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::ColumnMajor),
        },
        MatrixBlock {
            name: "unnamed_block",
            block: true,
            named_block: false,
            extended_basic_type_cases: false,
            order: None,
        },
        MatrixBlock {
            name: "unnamed_block_row_major",
            block: true,
            named_block: false,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::RowMajor),
        },
        MatrixBlock {
            name: "unnamed_block_col_major",
            block: true,
            named_block: false,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::ColumnMajor),
        },
    ];

    let default_block = Node::default_block(parent);
    let uniform = Node::storage_qualifier(&default_block, Storage::Uniform);

    for child in CHILDREN {
        let mut block_group = TestCaseGroup::new(child.name);
        let add_opaque_cases = child.extended_basic_type_cases && !child.block;

        let mut sub_structure = Arc::clone(&uniform);
        if let Some(order) = child.order {
            sub_structure = Node::layout_qualifier(
                &sub_structure,
                Layout {
                    matrix_order: Some(order),
                    ..Layout::default()
                },
            );
        }
        if child.block {
            sub_structure = Node::interface_block(&sub_structure, child.named_block);
        }

        block_content(
            &sub_structure,
            &mut block_group,
            child.extended_basic_type_cases,
            add_opaque_cases,
        );
        target_group.add_child(block_group);
    }
}

/// `generateBufferReferencedByShaderInterfaceBlockCases`
fn generate_buffer_referenced_by_shader_interface_block_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    query_target: ProgramResourceQueryTestTarget,
    extended_cases: bool,
) {
    let is_default_block = !matches!(parent.kind, NodeKind::InterfaceBlock { .. });

    // .float, .float_array, .float_struct
    {
        let array_element = Node::array_element_default(parent);
        let struct_member = Node::struct_member(parent);

        target_group.add_child(resource_case(
            &Node::variable(parent, DataType::Float),
            query_target,
            Some("float"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::Float),
            query_target,
            Some("float_array"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&struct_member, DataType::Float),
            query_target,
            Some("float_struct"),
        ));
    }

    // .sampler, .sampler_array, .sampler_struct
    if is_default_block {
        let layout = Node::layout_qualifier(parent, Layout::binding(0));
        let array_element = Node::array_element_default(&layout);
        let struct_member = Node::struct_member(parent);

        target_group.add_child(resource_case(
            &Node::variable(&layout, DataType::Sampler2D),
            query_target,
            Some("sampler"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::Sampler2D),
            query_target,
            Some("sampler_array"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&struct_member, DataType::Sampler2D),
            query_target,
            Some("sampler_struct"),
        ));
    }

    // .atomic_uint, .atomic_uint_array
    if is_default_block {
        let layout = Node::layout_qualifier(parent, Layout::binding(0));
        let array_element = Node::array_element_default(&layout);

        target_group.add_child(resource_case(
            &Node::variable(&layout, DataType::UintAtomicCounter),
            query_target,
            Some("atomic_uint"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::UintAtomicCounter),
            query_target,
            Some("atomic_uint_array"),
        ));
    }

    if !extended_cases {
        return;
    }

    // .float_array_struct
    {
        let struct_member = Node::struct_member(parent);
        let array_element = Node::array_element_default(&struct_member);
        target_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::Float),
            query_target,
            Some("float_array_struct"),
        ));
    }

    // .float_struct_array
    {
        let array_element = Node::array_element_default(parent);
        let array_struct_member = Node::struct_member(&array_element);
        target_group.add_child(resource_case(
            &Node::variable(&array_struct_member, DataType::Float),
            query_target,
            Some("float_struct_array"),
        ));
    }

    // .float_array_array
    {
        let array_element = Node::array_element_default(parent);
        let sub_array_element = Node::array_element_default(&array_element);
        target_group.add_child(resource_case(
            &Node::variable(&sub_array_element, DataType::Float),
            query_target,
            Some("float_array_array"),
        ));
    }

    // .float_struct_struct
    {
        let struct_member = Node::struct_member(parent);
        let sub_struct_member = Node::struct_member(&struct_member);
        target_group.add_child(resource_case(
            &Node::variable(&sub_struct_member, DataType::Float),
            query_target,
            Some("float_struct_struct"),
        ));
    }

    if query_target.interface == ProgramInterface::BufferVariable {
        let array_element = Node::array_element(parent, ARRAY_UNSIZED);

        // .float_unsized_array
        target_group.add_child(resource_case(
            &Node::variable(&array_element, DataType::Float),
            query_target,
            Some("float_unsized_array"),
        ));

        // .float_unsized_struct_array
        let struct_member = Node::struct_member(&array_element);
        target_group.add_child(resource_case(
            &Node::variable(&struct_member, DataType::Float),
            query_target,
            Some("float_unsized_struct_array"),
        ));
    }
}

/// `generateUniformReferencedByShaderSingleBlockContentCases`
fn generate_uniform_referenced_by_shader_single_block_content_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    _expand_level: i32,
) {
    let default_block = Node::default_block(parent);
    let uniform = Node::storage_qualifier(&default_block, Storage::Uniform);
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::REFERENCED_BY_SHADER);
    let single_shader_case = matches!(parent.kind, NodeKind::Shader { .. });

    // .default_block
    let mut block_group = TestCaseGroup::new("default_block");
    generate_buffer_referenced_by_shader_interface_block_cases(
        &uniform,
        &mut block_group,
        query_target,
        single_shader_case,
    );
    target_group.add_child(block_group);

    // .uniform_block
    let block = Node::interface_block(&uniform, true);
    let mut block_group = TestCaseGroup::new("uniform_block");
    generate_buffer_referenced_by_shader_interface_block_cases(
        &block,
        &mut block_group,
        query_target,
        single_shader_case,
    );
    target_group.add_child(block_group);

    // .unnamed_block
    let block = Node::interface_block(&uniform, false);
    let mut block_group = TestCaseGroup::new("unnamed_block");
    generate_buffer_referenced_by_shader_interface_block_cases(&block, &mut block_group, query_target, false);
    target_group.add_child(block_group);

    // .block_array
    let array_element = Node::array_element_default(&uniform);
    let block = Node::interface_block(&array_element, true);
    let mut block_group = TestCaseGroup::new("block_array");
    generate_buffer_referenced_by_shader_interface_block_cases(&block, &mut block_group, query_target, false);
    target_group.add_child(block_group);
}

/// `generateReferencedByShaderCaseBlocks`
fn generate_referenced_by_shader_case_blocks(
    target_group: &mut TestCaseGroup,
    generate_block_content: impl Fn(&NodePtr, &mut TestCaseGroup, i32),
) {
    const SINGLE_STAGE_CASES: &[(&str, ShaderType, i32)] = &[
        ("compute", ShaderType::Compute, 3),
        ("separable_vertex", ShaderType::Vertex, 2),
        ("separable_fragment", ShaderType::Fragment, 2),
        ("separable_tess_ctrl", ShaderType::TessControl, 2),
        ("separable_tess_eval", ShaderType::TessEvaluation, 2),
        ("separable_geometry", ShaderType::Geometry, 2),
    ];

    /// One row of upstream's `pipelines` table.
    struct Pipeline {
        name: &'static str,
        flags: u32,
        expand_level: i32,
        sub_expand_level: i32,
    }

    let vertex = 1 << (ShaderType::Vertex as u32);
    let fragment = 1 << (ShaderType::Fragment as u32);
    let geometry = 1 << (ShaderType::Geometry as u32);
    let tess_ctrl = 1 << (ShaderType::TessControl as u32);
    let tess_eval = 1 << (ShaderType::TessEvaluation as u32);

    let pipelines = [
        Pipeline {
            name: "vertex_fragment",
            flags: vertex | fragment,
            expand_level: 3,
            sub_expand_level: 2,
        },
        Pipeline {
            name: "vertex_tess_fragment",
            flags: vertex | fragment | tess_ctrl | tess_eval,
            expand_level: 2,
            sub_expand_level: 2,
        },
        Pipeline {
            name: "vertex_geo_fragment",
            flags: vertex | fragment | geometry,
            expand_level: 2,
            sub_expand_level: 2,
        },
        Pipeline {
            name: "vertex_tess_geo_fragment",
            flags: vertex | fragment | tess_ctrl | tess_eval | geometry,
            expand_level: 2,
            sub_expand_level: 1,
        },
    ];

    for &(name, stage, expand_level) in SINGLE_STAGE_CASES {
        let mut block_group = TestCaseGroup::new(name);
        let program_separable = stage != ShaderType::Compute;
        let program = Node::program(program_separable);
        let stage_node = Node::shader(&program, stage);

        generate_block_content(&stage_node, &mut block_group, expand_level);
        target_group.add_child(block_group);
    }

    for pipeline in &pipelines {
        // whole pipeline
        {
            let mut block_group = TestCaseGroup::new(pipeline.name);
            let program = Node::program(false);
            let shaders = Node::shader_set_masked(&program, pipeline.flags, pipeline.flags);
            generate_block_content(&shaders, &mut block_group, pipeline.expand_level);
            target_group.add_child(block_group);
        }

        // only one stage
        for stage in crate::gles31::functional::program_interface_resource_definition::ALL_SHADER_TYPES {
            let stage_bit = 1 << (stage as u32);
            if pipeline.flags & stage_bit == 0 {
                continue;
            }

            let stage_name = match stage {
                ShaderType::Vertex => "vertex",
                ShaderType::Fragment => "fragment",
                ShaderType::Geometry => "geo",
                ShaderType::TessControl => "tess_ctrl",
                ShaderType::TessEvaluation => "tess_eval",
                ShaderType::Compute => unreachable!("no pipeline contains the compute stage"),
            };

            let program = Node::program(false);
            let shaders = Node::shader_set_masked(&program, pipeline.flags, stage_bit);
            let mut block_group = TestCaseGroup::new(format!("{}_only_{stage_name}", pipeline.name));

            generate_block_content(&shaders, &mut block_group, pipeline.sub_expand_level);
            target_group.add_child(block_group);
        }
    }
}

/// `generateRandomDataType`'s type table.
const RANDOM_TYPES: &[DataType] = &[
    DataType::Float,
    DataType::Int,
    DataType::Uint,
    DataType::Bool,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
    DataType::Sampler2D,
    DataType::SamplerCube,
    DataType::Sampler2DArray,
    DataType::Sampler3D,
    DataType::Sampler2DShadow,
    DataType::SamplerCubeShadow,
    DataType::Sampler2DArrayShadow,
    DataType::IntSampler2D,
    DataType::IntSamplerCube,
    DataType::IntSampler2DArray,
    DataType::IntSampler3D,
    DataType::UintSampler2D,
    DataType::UintSamplerCube,
    DataType::UintSampler2DArray,
    DataType::UintSampler3D,
    DataType::Sampler2DMultisample,
    DataType::IntSampler2DMultisample,
    DataType::UintSampler2DMultisample,
    DataType::Image2D,
    DataType::ImageCube,
    DataType::Image2DArray,
    DataType::Image3D,
    DataType::IntImage2D,
    DataType::IntImageCube,
    DataType::IntImage2DArray,
    DataType::IntImage3D,
    DataType::UintImage2D,
    DataType::UintImageCube,
    DataType::UintImage2DArray,
    DataType::UintImage3D,
    DataType::UintAtomicCounter,
];

/// `generateRandomDataType`
fn generate_random_data_type(rnd: &mut crate::tcu::Random, exclude_opaque_types: bool) -> DataType {
    loop {
        let data_type = RANDOM_TYPES[rnd.get_int(0, RANDOM_TYPES.len() as i32 - 1) as usize];

        if !exclude_opaque_types || data_type.is_scalar_or_vector() || data_type.is_matrix() {
            return data_type;
        }
    }
}

/// `generateRandomVariableDefinition`
fn generate_random_variable_definition(
    rnd: &mut crate::tcu::Random,
    parent: &NodePtr,
    base_type: DataType,
    layout: &Layout,
    allow_unsized: bool,
) -> NodePtr {
    const MAX_NESTING: i32 = 4;
    let mut current = Arc::clone(parent);
    let can_be_inside_a_struct = layout.binding.is_none() && !is_data_type_layout_qualified(base_type);

    for nest_ndx in 0..MAX_NESTING {
        if allow_unsized && nest_ndx == 0 && rnd.get_float() < 0.2 {
            current = Node::array_element(&current, ARRAY_UNSIZED);
        } else if rnd.get_float() < 0.3 && can_be_inside_a_struct {
            current = Node::struct_member(&current);
        } else if rnd.get_float() < 0.3 {
            current = Node::array_element_default(&current);
        } else {
            break;
        }
    }

    Node::variable(&current, base_type)
}

/// `generateRandomCoreShaderSet`
fn generate_random_core_shader_set(rnd: &mut crate::tcu::Random) -> NodePtr {
    use crate::gles31::functional::program_interface_resource_definition::shader_set_with_stage;

    if rnd.get_float() < 0.5 {
        // compute only
        let program = Node::program(false);
        Node::shader(&program, ShaderType::Compute)
    } else if rnd.get_float() < 0.5 {
        // vertex and fragment
        let program = Node::program(false);
        let mut shader_set = Node::shader_set(&program);

        if rnd.get_bool() {
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Vertex, true);
            let referencing = rnd.get_bool();
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Fragment, referencing);
        } else {
            let referencing = rnd.get_bool();
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Vertex, referencing);
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Fragment, true);
        }

        shader_set
    } else {
        // separate vertex or fragment
        let program = Node::program(true);
        let shader_type = if rnd.get_bool() {
            ShaderType::Vertex
        } else {
            ShaderType::Fragment
        };
        Node::shader(&program, shader_type)
    }
}

/// `generateRandomExtShaderSet`
fn generate_random_ext_shader_set(rnd: &mut crate::tcu::Random) -> NodePtr {
    use crate::gles31::functional::program_interface_resource_definition::shader_set_with_stage;

    if rnd.get_float() < 0.5 {
        // whole pipeline
        let program = Node::program(false);
        let mut shader_set = Node::shader_set(&program);

        let referencing = rnd.get_bool();
        shader_set = shader_set_with_stage(&shader_set, ShaderType::Vertex, referencing);
        let referencing = rnd.get_bool();
        shader_set = shader_set_with_stage(&shader_set, ShaderType::Fragment, referencing);

        // The tessellation shaders are either both present or neither; force one extended
        // shader to always carry a reference so the cases stay interesting.
        if rnd.get_bool() {
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Geometry, true);

            if rnd.get_bool() {
                let referencing = rnd.get_bool();
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessControl, referencing);
                let referencing = rnd.get_bool();
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessEvaluation, referencing);
            }
        } else {
            let referencing = rnd.get_bool();
            shader_set = shader_set_with_stage(&shader_set, ShaderType::Geometry, referencing);

            if rnd.get_bool() {
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessControl, true);
                let referencing = rnd.get_bool();
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessEvaluation, referencing);
            } else {
                let referencing = rnd.get_bool();
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessControl, referencing);
                shader_set = shader_set_with_stage(&shader_set, ShaderType::TessEvaluation, true);
            }
        }

        shader_set
    } else {
        // separate
        let program = Node::program(true);
        let shader_type = match rnd.get_int(0, 2) {
            0 => ShaderType::Geometry,
            1 => ShaderType::TessControl,
            _ => ShaderType::TessEvaluation,
        };
        Node::shader(&program, shader_type)
    }
}

/// `generateRandomShaderSet`
fn generate_random_shader_set(rnd: &mut crate::tcu::Random, only_extension_stages: bool) -> NodePtr {
    if only_extension_stages {
        generate_random_ext_shader_set(rnd)
    } else {
        generate_random_core_shader_set(rnd)
    }
}

/// `generateRandomUniformBlockLayout` (and `generateRandomBufferBlockLayout`, which is the
/// same function upstream).
fn generate_random_block_layout(rnd: &mut crate::tcu::Random) -> Layout {
    let mut layout = Layout::default();

    if rnd.get_bool() {
        layout.binding = Some(rnd.get_int(0, 5));
    }

    if rnd.get_bool() {
        layout.matrix_order = Some(if rnd.get_bool() {
            MatrixOrder::ColumnMajor
        } else {
            MatrixOrder::RowMajor
        });
    }

    layout
}

/// `generateRandomVariableLayout`
fn generate_random_variable_layout(
    rnd: &mut crate::tcu::Random,
    data_type: DataType,
    interface_block_member: bool,
) -> Layout {
    let mut layout = Layout::default();

    if (data_type.is_atomic_counter() || data_type.is_image() || data_type.is_sampler()) && rnd.get_bool() {
        layout.binding = Some(rnd.get_int(0, 5));
    }

    if data_type.is_atomic_counter() && rnd.get_bool() {
        layout.offset = Some(rnd.get_int(0, 3) * 4);
    }

    if data_type.is_matrix() && interface_block_member && rnd.get_bool() {
        layout.matrix_order = Some(if rnd.get_bool() {
            MatrixOrder::ColumnMajor
        } else {
            MatrixOrder::RowMajor
        });
    }

    layout
}

/// `generateUniformRandomCase`
fn generate_uniform_random_case(target_group: &mut TestCaseGroup, index: i32, only_extension_stages: bool) {
    let mut rnd = crate::tcu::Random::new((index * 0x12345) as u32);
    let shader = generate_random_shader_set(&mut rnd, only_extension_stages);
    let interface_block = rnd.get_bool();
    let data_type = generate_random_data_type(&mut rnd, interface_block);
    let layout = generate_random_variable_layout(&mut rnd, data_type, interface_block);

    let default_block = Node::default_block(&shader);
    let uniform = Node::storage_qualifier(&default_block, Storage::Uniform);
    let mut current = uniform;

    if interface_block {
        let named_block = rnd.get_bool();
        current = Node::layout_qualifier(&current, generate_random_block_layout(&mut rnd));

        if named_block && rnd.get_bool() {
            current = Node::array_element_default(&current);
        }

        current = Node::interface_block(&current, named_block);
    }

    current = Node::layout_qualifier(&current, layout);
    current = generate_random_variable_definition(&mut rnd, &current, data_type, &layout, false);

    target_group.add_child(resource_case(
        &current,
        ProgramResourceQueryTestTarget::new(ProgramInterface::Uniform, prop::UNIFORM_INTERFACE_MASK),
        Some(&index.to_string()),
    ));
}

/// `generateUniformCaseRandomCases`
fn generate_uniform_case_random_cases(target_group: &mut TestCaseGroup) {
    const NUM_BASIC_CASES: i32 = 40;
    const NUM_TESS_GEO_CASES: i32 = 40;

    for ndx in 0..NUM_BASIC_CASES {
        generate_uniform_random_case(target_group, ndx, false);
    }
    for ndx in 0..NUM_TESS_GEO_CASES {
        generate_uniform_random_case(target_group, NUM_BASIC_CASES + ndx, true);
    }
}

/// `UniformInterfaceTestGroup::init`
fn create_uniform_interface_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("uniform");
    let program = Node::program(false);
    let compute_shader = Node::shader(&program, ShaderType::Compute);

    /// The sub-groups that are `generateUniformCaseBlocks` over one content generator.
    struct UniformSubGroup {
        name: &'static str,
        flags: u32,
        content: fn(&NodePtr, &mut TestCaseGroup),
    }

    const SUB_GROUPS: &[UniformSubGroup] = &[
        UniformSubGroup {
            name: "resource_list",
            flags: block_flag::ALL,
            content: generate_uniform_resource_list_block_contents,
        },
        UniformSubGroup {
            name: "array_size",
            flags: block_flag::ALL,
            content: generate_uniform_block_array_size_contents,
        },
        UniformSubGroup {
            name: "array_stride",
            flags: block_flag::ALL,
            content: generate_uniform_block_array_stride_contents,
        },
        UniformSubGroup {
            name: "atomic_counter_buffer_index",
            flags: block_flag::DEFAULT | block_flag::NAMED,
            content: generate_uniform_block_atomic_counter_buffer_index_contents,
        },
    ];

    for sub in SUB_GROUPS {
        let mut block_group = TestCaseGroup::new(sub.name);
        generate_uniform_case_blocks(&compute_shader, &mut block_group, sub.flags, sub.content);
        group.add_child(block_group);
    }

    // .block_index
    let mut block_group = TestCaseGroup::new("block_index");
    generate_uniform_block_block_index_contents(&mut block_group);
    group.add_child(block_group);

    // .location
    let mut block_group = TestCaseGroup::new("location");
    generate_uniform_case_blocks(
        &compute_shader,
        &mut block_group,
        block_flag::DEFAULT | block_flag::NAMED | block_flag::UNNAMED,
        generate_uniform_block_location_contents,
    );
    group.add_child(block_group);

    // .matrix_row_major
    let mut block_group = TestCaseGroup::new("matrix_row_major");
    generate_uniform_matrix_case_blocks(
        &compute_shader,
        &mut block_group,
        generate_uniform_matrix_order_case_block_content_cases,
    );
    group.add_child(block_group);

    // .matrix_stride
    let mut block_group = TestCaseGroup::new("matrix_stride");
    generate_uniform_matrix_case_blocks(
        &compute_shader,
        &mut block_group,
        generate_uniform_matrix_stride_case_block_content_cases,
    );
    group.add_child(block_group);

    // .name_length
    let mut block_group = TestCaseGroup::new("name_length");
    generate_uniform_case_blocks(
        &compute_shader,
        &mut block_group,
        block_flag::ALL,
        generate_uniform_block_name_length_contents,
    );
    group.add_child(block_group);

    // .offset
    let mut block_group = TestCaseGroup::new("offset");
    generate_uniform_case_blocks(
        &compute_shader,
        &mut block_group,
        block_flag::ALL,
        generate_uniform_block_offset_contents,
    );
    group.add_child(block_group);

    // .referenced_by_shader
    let mut block_group = TestCaseGroup::new("referenced_by_shader");
    generate_referenced_by_shader_case_blocks(
        &mut block_group,
        generate_uniform_referenced_by_shader_single_block_content_cases,
    );
    group.add_child(block_group);

    // .type
    let mut block_group = TestCaseGroup::new("type");
    generate_uniform_case_blocks(
        &compute_shader,
        &mut block_group,
        block_flag::ALL,
        generate_uniform_block_type_contents,
    );
    group.add_child(block_group);

    // .random
    let mut block_group = TestCaseGroup::new("random");
    generate_uniform_case_random_cases(&mut block_group);
    group.add_child(block_group);

    group
}

/// `generateBufferBackedInterfaceResourceBasicBlockTypes` - the four block shapes both the
/// resource-list and the name-length group build.
fn generate_buffer_backed_interface_resource_basic_block_types(
    target_group: &mut TestCaseGroup,
    storage: Storage,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup, ProgramInterface, &str),
) {
    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let storage_qualifier = Node::storage_qualifier(&default_block, storage);
    let binding = Node::layout_qualifier(&storage_qualifier, Layout::binding(1));
    let program_interface = block_program_interface(storage);

    // .named_block
    let block = Node::interface_block(&binding, true);
    let unused_variable = Node::variable(&block, DataType::BoolVec3);
    block_content(&unused_variable, target_group, program_interface, "named_block");

    // .unnamed_block
    let block = Node::interface_block(&binding, false);
    let unused_variable = Node::variable(&block, DataType::BoolVec3);
    block_content(&unused_variable, target_group, program_interface, "unnamed_block");

    // .block_array
    let array_element = Node::array_element(&binding, 3);
    let block = Node::interface_block(&array_element, true);
    let unused_variable = Node::variable(&block, DataType::BoolVec3);
    block_content(&unused_variable, target_group, program_interface, "block_array");

    // .block_array_single_element
    let array_element = Node::array_element(&binding, 1);
    let block = Node::interface_block(&array_element, true);
    let unused_variable = Node::variable(&block, DataType::BoolVec3);
    block_content(
        &unused_variable,
        target_group,
        program_interface,
        "block_array_single_element",
    );
}

/// `generateBufferBackedInterfaceResourceBufferBindingCases`
fn generate_buffer_backed_interface_resource_buffer_binding_cases(target_group: &mut TestCaseGroup, storage: Storage) {
    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let storage_qualifier = Node::storage_qualifier(&default_block, storage);
    let program_interface = block_program_interface(storage);
    let target = ProgramResourceQueryTestTarget::new(program_interface, prop::BUFFER_BINDING);

    for explicit_binding in [false, true] {
        let name_suffix = if explicit_binding { "_explicit_binding" } else { "" };
        let layout = if explicit_binding {
            Layout::binding(1)
        } else {
            Layout::default()
        };
        let binding = Node::layout_qualifier(&storage_qualifier, layout);

        // .named_block*
        let block = Node::interface_block(&binding, true);
        let unused_variable = Node::variable(&block, DataType::BoolVec3);
        target_group.add_child(resource_case(
            &unused_variable,
            target,
            Some(&format!("named_block{name_suffix}")),
        ));

        // .unnamed_block*
        let block = Node::interface_block(&binding, false);
        let unused_variable = Node::variable(&block, DataType::BoolVec3);
        target_group.add_child(resource_case(
            &unused_variable,
            target,
            Some(&format!("unnamed_block{name_suffix}")),
        ));

        // .block_array*
        let array_element = Node::array_element(&binding, 3);
        let block = Node::interface_block(&array_element, true);
        let unused_variable = Node::variable(&block, DataType::BoolVec3);
        target_group.add_child(resource_case(
            &unused_variable,
            target,
            Some(&format!("block_array{name_suffix}")),
        ));
    }
}

/// `generateBufferBlockReferencedByShaderSingleBlockContentCases`
fn generate_buffer_block_referenced_by_shader_single_block_content_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    storage: Storage,
) {
    let program_interface = block_program_interface(storage);
    let target = ProgramResourceQueryTestTarget::new(program_interface, prop::REFERENCED_BY_SHADER);
    let default_block = Node::default_block(parent);
    let storage_qualifier = Node::storage_qualifier(&default_block, storage);

    // .named_block
    let block = Node::interface_block(&storage_qualifier, true);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::BoolVec3),
        target,
        Some("named_block"),
    ));

    // .unnamed_block
    let block = Node::interface_block(&storage_qualifier, false);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::BoolVec3),
        target,
        Some("unnamed_block"),
    ));

    // .block_array
    let array_element = Node::array_element(&storage_qualifier, 3);
    let block = Node::interface_block(&array_element, true);
    target_group.add_child(resource_case(
        &Node::variable(&block, DataType::BoolVec3),
        target,
        Some("block_array"),
    ));
}

/// `BufferBackedBlockInterfaceTestGroup::init`
fn create_buffer_backed_block_interface_group(storage: Storage) -> TestCaseGroup {
    let name = match storage {
        Storage::Uniform => "uniform_block",
        Storage::Buffer => "shader_storage_block",
        other => unreachable!("{other:?} is not buffer backed"),
    };
    let mut group = TestCaseGroup::new(name);

    // .resource_list
    let mut block_group = TestCaseGroup::new("resource_list");
    generate_buffer_backed_interface_resource_basic_block_types(
        &mut block_group,
        storage,
        |resource, target_group, interface, block_name| {
            target_group.add_child(boxed(ResourceListTestCase::new(resource, interface, Some(block_name))));
        },
    );
    group.add_child(block_group);

    // .active_variables
    let mut block_group = TestCaseGroup::new("active_variables");
    for (case_name, case_type) in [
        ("named_block", InterfaceBlockCaseType::NamedBlock),
        ("unnamed_block", InterfaceBlockCaseType::UnnamedBlock),
        ("block_array", InterfaceBlockCaseType::BlockArray),
    ] {
        block_group.add_child(boxed(InterfaceBlockActiveVariablesTestCase::new(
            case_name, storage, case_type,
        )));
    }
    group.add_child(block_group);

    // .buffer_binding
    let mut block_group = TestCaseGroup::new("buffer_binding");
    generate_buffer_backed_interface_resource_buffer_binding_cases(&mut block_group, storage);
    group.add_child(block_group);

    // .buffer_data_size
    let mut block_group = TestCaseGroup::new("buffer_data_size");
    for (case_name, case_type) in [
        ("named_block", InterfaceBlockCaseType::NamedBlock),
        ("unnamed_block", InterfaceBlockCaseType::UnnamedBlock),
        ("block_array", InterfaceBlockCaseType::BlockArray),
    ] {
        block_group.add_child(boxed(InterfaceBlockDataSizeTestCase::new(
            case_name, storage, case_type,
        )));
    }
    group.add_child(block_group);

    // .name_length
    let mut block_group = TestCaseGroup::new("name_length");
    generate_buffer_backed_interface_resource_basic_block_types(
        &mut block_group,
        storage,
        |resource, target_group, interface, block_name| {
            target_group.add_child(resource_case(
                resource,
                ProgramResourceQueryTestTarget::new(interface, prop::NAME_LENGTH),
                Some(block_name),
            ));
        },
    );
    group.add_child(block_group);

    // .referenced_by
    let mut block_group = TestCaseGroup::new("referenced_by");
    generate_referenced_by_shader_case_blocks(&mut block_group, |parent, target_group, _expand_level| {
        generate_buffer_block_referenced_by_shader_single_block_content_cases(parent, target_group, storage);
    });
    group.add_child(block_group);

    group
}

/// The four pipelines the atomic-counter and program-input/output groups both enumerate.
fn referenced_by_pipelines() -> [(&'static str, u32); 4] {
    let vertex = 1 << (ShaderType::Vertex as u32);
    let fragment = 1 << (ShaderType::Fragment as u32);
    let geometry = 1 << (ShaderType::Geometry as u32);
    let tess_ctrl = 1 << (ShaderType::TessControl as u32);
    let tess_eval = 1 << (ShaderType::TessEvaluation as u32);

    [
        ("vertex_fragment", vertex | fragment),
        ("vertex_tess_fragment", vertex | fragment | tess_ctrl | tess_eval),
        ("vertex_geo_fragment", vertex | fragment | geometry),
        (
            "vertex_tess_geo_fragment",
            vertex | fragment | tess_ctrl | tess_eval | geometry,
        ),
    ]
}

/// The short name each stage has in a `*_only_<stage>` case name.
fn stage_short_name(stage: ShaderType) -> &'static str {
    match stage {
        ShaderType::Vertex => "vertex",
        ShaderType::Fragment => "fragment",
        ShaderType::Geometry => "geo",
        ShaderType::TessControl => "tess_ctrl",
        ShaderType::TessEvaluation => "tess_eval",
        ShaderType::Compute => "compute",
    }
}

/// `AtomicCounterTestGroup::init`
fn create_atomic_counter_group() -> TestCaseGroup {
    use crate::gles31::functional::program_interface_resource_definition::ALL_SHADER_TYPES;

    let mut group = TestCaseGroup::new("atomic_counter_buffer");

    group.add_child(boxed(AtomicCounterCase::new(
        "resource_list",
        AtomicCounterCaseKind::ResourceList,
    )));
    group.add_child(boxed(AtomicCounterCase::new(
        "active_variables",
        AtomicCounterCaseKind::ActiveVariables,
    )));
    group.add_child(boxed(AtomicCounterCase::new(
        "buffer_binding",
        AtomicCounterCaseKind::BufferBinding,
    )));
    group.add_child(boxed(AtomicCounterCase::new(
        "buffer_data_size",
        AtomicCounterCaseKind::BufferDataSize,
    )));

    // .referenced_by
    for (name, stage, separable) in [
        ("referenced_by_compute", ShaderType::Compute, false),
        ("referenced_by_separable_vertex", ShaderType::Vertex, true),
        ("referenced_by_separable_fragment", ShaderType::Fragment, true),
        ("referenced_by_separable_geometry", ShaderType::Geometry, true),
        ("referenced_by_separable_tess_ctrl", ShaderType::TessControl, true),
        ("referenced_by_separable_tess_eval", ShaderType::TessEvaluation, true),
    ] {
        let mask = 1 << (stage as u32);
        group.add_child(boxed(AtomicCounterReferencedByCase::new(name, separable, mask, mask)));
    }

    for (pipeline_name, flags) in referenced_by_pipelines() {
        group.add_child(boxed(AtomicCounterReferencedByCase::new(
            format!("referenced_by_{pipeline_name}"),
            false,
            flags,
            flags,
        )));

        for stage in ALL_SHADER_TYPES {
            let current_bit = 1 << (stage as u32);
            if flags & current_bit == 0 {
                continue;
            }
            group.add_child(boxed(AtomicCounterReferencedByCase::new(
                format!("referenced_by_{pipeline_name}_only_{}", stage_short_name(stage)),
                false,
                flags,
                current_bit,
            )));
        }
    }

    group
}

/// `generateProgramInputOutputShaderCaseBlocks` - \note upstream's `isGL45` is always false
/// here, so the unnamed io block is always generated.
fn generate_program_input_output_shader_case_blocks(
    target_group: &mut TestCaseGroup,
    with_compute: bool,
    input_case: bool,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup, u32),
) {
    use crate::gles31::functional::program_interface_resource_definition::shader_set_with_stage;

    const SINGLE_STAGE_CASES: &[(&str, ShaderType)] = &[
        ("separable_vertex", ShaderType::Vertex),
        ("separable_fragment", ShaderType::Fragment),
        ("separable_tess_ctrl", ShaderType::TessControl),
        ("separable_tess_eval", ShaderType::TessEvaluation),
        ("separable_geometry", ShaderType::Geometry),
    ];

    // .vertex_fragment
    {
        let mut block_group = TestCaseGroup::new("vertex_fragment");
        let program = Node::program(false);
        let mut shader_set = Node::shader_set(&program);
        shader_set = shader_set_with_stage(&shader_set, ShaderType::Vertex, input_case);
        shader_set = shader_set_with_stage(&shader_set, ShaderType::Fragment, !input_case);
        let default_block = Node::default_block(&shader_set);

        let mask = (1 << (ShaderType::Vertex as u32)) | (1 << (ShaderType::Fragment as u32));
        block_content(&default_block, &mut block_group, mask);
        target_group.add_child(block_group);
    }

    // .separable_*
    for &(name, stage) in SINGLE_STAGE_CASES {
        let mut block_group = TestCaseGroup::new(name);
        let program = Node::program(true);
        let shader = Node::shader(&program, stage);
        let default_block = Node::default_block(&shader);

        block_content(&default_block, &mut block_group, 1 << (stage as u32));
        target_group.add_child(block_group);
    }

    // .compute
    if with_compute {
        let mut block_group = TestCaseGroup::new("compute");
        let program = Node::program(true);
        let shader = Node::shader(&program, ShaderType::Compute);
        let default_block = Node::default_block(&shader);

        block_content(&default_block, &mut block_group, 1 << (ShaderType::Compute as u32));
        target_group.add_child(block_group);
    }

    // .interface_blocks
    {
        /// One row of upstream's `ioBlockTypes` table.
        struct IoBlockType {
            input_name: &'static str,
            input_stage: ShaderType,
            input_storage: Storage,
            output_name: &'static str,
            output_stage: ShaderType,
            output_storage: Storage,
        }

        const IO_BLOCK_TYPES: &[IoBlockType] = &[
            IoBlockType {
                input_name: "in",
                input_stage: ShaderType::Fragment,
                input_storage: Storage::In,
                output_name: "out",
                output_stage: ShaderType::Vertex,
                output_storage: Storage::Out,
            },
            IoBlockType {
                input_name: "patch_in",
                input_stage: ShaderType::TessEvaluation,
                input_storage: Storage::PatchIn,
                output_name: "patch_out",
                output_stage: ShaderType::TessControl,
                output_storage: Storage::PatchOut,
            },
        ];

        let mut io_blocks_group = TestCaseGroup::new("interface_blocks");

        for io_block in IO_BLOCK_TYPES {
            let (name, shader_type, storage_type) = if input_case {
                (io_block.input_name, io_block.input_stage, io_block.input_storage)
            } else {
                (io_block.output_name, io_block.output_stage, io_block.output_storage)
            };

            let mut io_block_group = TestCaseGroup::new(name);
            let program = Node::program(true);
            let shader = Node::shader(&program, shader_type);
            let default_block = Node::default_block(&shader);
            let storage = Node::storage_qualifier(&default_block, storage_type);
            let stage_mask = 1 << (shader_type as u32);

            // .named_block
            let block = Node::interface_block(&storage, true);
            let mut block_group = TestCaseGroup::new("named_block");
            block_content(&block, &mut block_group, stage_mask);
            io_block_group.add_child(block_group);

            // .named_block_explicit_location
            let layout = Node::layout_qualifier(&storage, Layout::location(3));
            let block = Node::interface_block(&layout, true);
            let mut block_group = TestCaseGroup::new("named_block_explicit_location");
            block_content(&block, &mut block_group, stage_mask);
            io_block_group.add_child(block_group);

            // .unnamed_block
            let block = Node::interface_block(&storage, false);
            let mut block_group = TestCaseGroup::new("unnamed_block");
            block_content(&block, &mut block_group, stage_mask);
            io_block_group.add_child(block_group);

            // .block_array
            let array_element = Node::array_element_default(&storage);
            let block = Node::interface_block(&array_element, true);
            let mut block_group = TestCaseGroup::new("block_array");
            block_content(&block, &mut block_group, stage_mask);
            io_block_group.add_child(block_group);

            io_blocks_group.add_child(io_block_group);
        }

        target_group.add_child(io_blocks_group);
    }
}

/// `generateProgramInputBlockContents`
fn generate_program_input_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
    include_empty: bool,
    gen_case: impl Fn(&NodePtr, &mut TestCaseGroup, ProgramInterface, &str),
) {
    let interface = ProgramInterface::ProgramInput;
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let input = if in_default_block {
        Node::storage_qualifier(parent, Storage::In)
    } else {
        Arc::clone(parent)
    };
    let first_stage = shader_mask_first_stage(present_shaders_mask);

    // .empty
    if include_empty && in_default_block {
        gen_case(parent, target_group, interface, "empty");
    }

    // \note the `!in_default_block` disjunct in the second branch is what makes an io
    // block take the fragment shape whatever stage it is declared in.
    if first_stage == ShaderType::Vertex {
        // .var
        gen_case(
            &Node::variable(&input, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );
    } else if first_stage == ShaderType::Fragment || !in_default_block {
        // .var
        gen_case(
            &Node::variable(&input, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );
        // .var_struct
        let struct_mbr = Node::struct_member(&input);
        gen_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target_group,
            interface,
            "var_struct",
        );
        // .var_array
        let array_elem = Node::array_element_default(&input);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var_array",
        );
    } else if matches!(first_stage, ShaderType::TessControl | ShaderType::Geometry) {
        // arrayed interface. The extension forbids arrays of structs and arrays of arrays.
        let array_elem = Node::array_element(&input, ARRAY_UNSIZED);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );
    } else if first_stage == ShaderType::TessEvaluation {
        // arrayed interface
        let patch_input = Node::storage_qualifier(parent, Storage::PatchIn);

        // .var
        let array_elem = Node::array_element(&input, ARRAY_UNSIZED);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );

        // .patch_var
        gen_case(
            &Node::variable(&patch_input, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var",
        );
        // .patch_var_struct
        let struct_mbr = Node::struct_member(&patch_input);
        gen_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var_struct",
        );
        // .patch_var_array
        let array_elem = Node::array_element_default(&patch_input);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var_array",
        );
    }
    // the compute stage generates nothing
}

/// `generateProgramOutputBlockContents`
fn generate_program_output_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
    include_empty: bool,
    gen_case: impl Fn(&NodePtr, &mut TestCaseGroup, ProgramInterface, &str),
) {
    let interface = ProgramInterface::ProgramOutput;
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let output = if in_default_block {
        Node::storage_qualifier(parent, Storage::Out)
    } else {
        Arc::clone(parent)
    };
    let last_stage = shader_mask_last_stage(present_shaders_mask);

    // .empty
    if include_empty && in_default_block {
        gen_case(parent, target_group, interface, "empty");
    }

    if matches!(
        last_stage,
        ShaderType::Vertex | ShaderType::Geometry | ShaderType::TessEvaluation
    ) || !in_default_block
    {
        gen_case(
            &Node::variable(&output, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );
        let struct_mbr = Node::struct_member(&output);
        gen_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target_group,
            interface,
            "var_struct",
        );
        let array_elem = Node::array_element_default(&output);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var_array",
        );
    } else if last_stage == ShaderType::Fragment {
        gen_case(
            &Node::variable(&output, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );
        let array_elem = Node::array_element_default(&output);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var_array",
        );
    } else if last_stage == ShaderType::TessControl {
        // arrayed interface
        let patch_output = Node::storage_qualifier(parent, Storage::PatchOut);

        let array_elem = Node::array_element(&output, ARRAY_UNSIZED);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "var",
        );

        gen_case(
            &Node::variable(&patch_output, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var",
        );
        let struct_mbr = Node::struct_member(&patch_output);
        gen_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var_struct",
        );
        let array_elem = Node::array_element_default(&patch_output);
        gen_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target_group,
            interface,
            "patch_var_array",
        );
    }
    // the compute stage generates nothing
}

/// `addProgramInputOutputResourceListCase` - the case names itself from its resource, and
/// upstream asserts that name matches what the generator asked for.
fn add_program_input_output_resource_list_case(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    name: &str,
) {
    let case = ResourceListTestCase::new(parent, interface, None);
    debug_assert_eq!(case.name(), name);
    target_group.add_child(boxed(case));
}

/// `addProgramInputOutputResourceTestCase`
fn add_program_input_output_resource_test_case(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    name: &str,
    target_prop: u32,
) {
    target_group.add_child(resource_case(
        parent,
        ProgramResourceQueryTestTarget::new(interface, target_prop),
        Some(name),
    ));
}

/// `generateProgramInputLocationBlockContents`
fn generate_program_input_location_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::ProgramInput, prop::LOCATION);
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let input = if in_default_block {
        Node::storage_qualifier(parent, Storage::In)
    } else {
        Arc::clone(parent)
    };
    let first_stage = shader_mask_first_stage(present_shaders_mask);

    // An explicit location on a block-array member would collide with the array's own
    // locations, so upstream leaves those cases out.
    let in_block_array = target_group.name() == "block_array";
    let explicit = || Node::layout_qualifier(&input, Layout::location(2));

    if first_stage == ShaderType::Vertex {
        target_group.add_child(resource_case(
            &Node::variable(&input, DataType::FloatVec4),
            target,
            Some("var"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&explicit(), DataType::FloatVec4),
            target,
            Some("var_explicit_location"),
        ));
    } else if first_stage == ShaderType::Fragment || !in_default_block {
        target_group.add_child(resource_case(
            &Node::variable(&input, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        if !in_block_array {
            target_group.add_child(resource_case(
                &Node::variable(&explicit(), DataType::FloatVec4),
                target,
                Some("var_explicit_location"),
            ));
        }

        let struct_mbr = Node::struct_member(&input);
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("var_struct"),
        ));

        if !in_block_array {
            let struct_mbr = Node::struct_member(&explicit());
            target_group.add_child(resource_case(
                &Node::variable(&struct_mbr, DataType::FloatVec4),
                target,
                Some("var_struct_explicit_location"),
            ));
        }

        let array_elem = Node::array_element_default(&input);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_array"),
        ));

        if !in_block_array {
            let array_elem = Node::array_element_default(&explicit());
            target_group.add_child(resource_case(
                &Node::variable(&array_elem, DataType::FloatVec4),
                target,
                Some("var_array_explicit_location"),
            ));
        }
    } else if matches!(first_stage, ShaderType::TessControl | ShaderType::Geometry) {
        // arrayed interface; the extension forbids arrays of structs and of arrays
        let array_elem = Node::array_element(&input, ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        let array_elem = Node::array_element(&explicit(), ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_explicit_location"),
        ));
    } else if first_stage == ShaderType::TessEvaluation {
        // arrayed interface
        let patch_input = Node::storage_qualifier(parent, Storage::PatchIn);
        let patch_explicit = || Node::layout_qualifier(&patch_input, Layout::location(2));

        let array_elem = Node::array_element(&input, ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        let array_elem = Node::array_element(&explicit(), ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_explicit_location"),
        ));

        target_group.add_child(resource_case(
            &Node::variable(&patch_input, DataType::FloatVec4),
            target,
            Some("patch_var"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&patch_explicit(), DataType::FloatVec4),
            target,
            Some("patch_var_explicit_location"),
        ));

        let struct_mbr = Node::struct_member(&patch_input);
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("patch_var_struct"),
        ));
        let struct_mbr = Node::struct_member(&patch_explicit());
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("patch_var_struct_explicit_location"),
        ));

        let array_elem = Node::array_element_default(&patch_input);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("patch_var_array"),
        ));
        let array_elem = Node::array_element_default(&patch_explicit());
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("patch_var_array_explicit_location"),
        ));
    }
    // the compute stage generates nothing
}

/// `generateProgramOutputLocationBlockContents`
fn generate_program_output_location_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::ProgramOutput, prop::LOCATION);
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let output = if in_default_block {
        Node::storage_qualifier(parent, Storage::Out)
    } else {
        Arc::clone(parent)
    };
    let last_stage = shader_mask_last_stage(present_shaders_mask);

    let in_block_array = target_group.name() == "block_array";
    let explicit = |location| Node::layout_qualifier(&output, Layout::location(location));

    if matches!(
        last_stage,
        ShaderType::Vertex | ShaderType::Geometry | ShaderType::TessEvaluation
    ) || !in_default_block
    {
        target_group.add_child(resource_case(
            &Node::variable(&output, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        if !in_block_array {
            target_group.add_child(resource_case(
                &Node::variable(&explicit(2), DataType::FloatVec4),
                target,
                Some("var_explicit_location"),
            ));
        }

        let struct_mbr = Node::struct_member(&output);
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("var_struct"),
        ));

        if !in_block_array {
            let struct_mbr = Node::struct_member(&explicit(2));
            target_group.add_child(resource_case(
                &Node::variable(&struct_mbr, DataType::FloatVec4),
                target,
                Some("var_struct_explicit_location"),
            ));
        }

        let array_elem = Node::array_element_default(&output);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_array"),
        ));

        if !in_block_array {
            let array_elem = Node::array_element_default(&explicit(2));
            target_group.add_child(resource_case(
                &Node::variable(&array_elem, DataType::FloatVec4),
                target,
                Some("var_array_explicit_location"),
            ));
        }
    } else if last_stage == ShaderType::Fragment {
        target_group.add_child(resource_case(
            &Node::variable(&output, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        if !in_block_array {
            target_group.add_child(resource_case(
                &Node::variable(&explicit(2), DataType::FloatVec4),
                target,
                Some("var_explicit_location"),
            ));
        }

        let array_elem = Node::array_element_default(&output);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_array"),
        ));

        if !in_block_array {
            // \note location 1 here, not 2: a fragment output array at location 2 would
            // run past GL_MAX_DRAW_BUFFERS on a minimal implementation.
            let array_elem = Node::array_element_default(&explicit(1));
            target_group.add_child(resource_case(
                &Node::variable(&array_elem, DataType::FloatVec4),
                target,
                Some("var_array_explicit_location"),
            ));
        }
    } else if last_stage == ShaderType::TessControl {
        // arrayed interface
        let patch_output = Node::storage_qualifier(parent, Storage::PatchOut);
        let patch_explicit = || Node::layout_qualifier(&patch_output, Layout::location(2));

        let array_elem = Node::array_element(&output, ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var"),
        ));

        let array_elem = Node::array_element(&explicit(2), ARRAY_UNSIZED);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("var_explicit_location"),
        ));

        target_group.add_child(resource_case(
            &Node::variable(&patch_output, DataType::FloatVec4),
            target,
            Some("patch_var"),
        ));
        target_group.add_child(resource_case(
            &Node::variable(&patch_explicit(), DataType::FloatVec4),
            target,
            Some("patch_var_explicit_location"),
        ));

        let struct_mbr = Node::struct_member(&patch_output);
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("patch_var_struct"),
        ));
        let struct_mbr = Node::struct_member(&patch_explicit());
        target_group.add_child(resource_case(
            &Node::variable(&struct_mbr, DataType::FloatVec4),
            target,
            Some("patch_var_struct_explicit_location"),
        ));

        let array_elem = Node::array_element_default(&patch_output);
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("patch_var_array"),
        ));
        let array_elem = Node::array_element_default(&patch_explicit());
        target_group.add_child(resource_case(
            &Node::variable(&array_elem, DataType::FloatVec4),
            target,
            Some("patch_var_array_explicit_location"),
        ));
    }
    // the compute stage generates nothing
}

/// `generateProgramInputOutputReferencedByCases`
fn generate_program_input_output_referenced_by_cases(target_group: &mut TestCaseGroup, storage: Storage) {
    use InputOutputReferencedByCaseType as Case;

    // all whole pipelines
    for (name, case_type) in [
        ("referenced_by_vertex_fragment", Case::VertexFragment),
        ("referenced_by_vertex_tess_fragment", Case::VertexTessFragment),
        ("referenced_by_vertex_geo_fragment", Case::VertexGeoFragment),
        ("referenced_by_vertex_tess_geo_fragment", Case::VertexTessGeoFragment),
        // all partial pipelines
        ("referenced_by_separable_vertex", Case::SeparableVertex),
        ("referenced_by_separable_fragment", Case::SeparableFragment),
        ("referenced_by_separable_geometry", Case::SeparableGeometry),
        ("referenced_by_separable_tess_eval", Case::SeparableTessEval),
        ("referenced_by_separable_tess_ctrl", Case::SeparableTessCtrl),
    ] {
        target_group.add_child(boxed(ProgramInputOutputReferencedByCase::new(name, storage, case_type)));
    }

    // patch
    match storage {
        Storage::In => target_group.add_child(boxed(ProgramInputOutputReferencedByCase::new(
            "referenced_by_separable_tess_eval_patch_in",
            Storage::PatchIn,
            Case::SeparableTessEval,
        ))),
        Storage::Out => target_group.add_child(boxed(ProgramInputOutputReferencedByCase::new(
            "referenced_by_separable_tess_ctrl_patch_out",
            Storage::PatchOut,
            Case::SeparableTessCtrl,
        ))),
        other => unreachable!("{other:?} is not a program input or output"),
    };
}

/// `generateProgramInputOutputTypeBasicTypeCases`'s type table.
const PROGRAM_IO_TYPES: &[(DataType, bool, i32)] = &[
    (DataType::Float, false, 0),
    (DataType::Int, false, 1),
    (DataType::Uint, false, 1),
    (DataType::FloatVec2, false, 2),
    (DataType::FloatVec3, false, 1),
    (DataType::FloatVec4, false, 2),
    (DataType::IntVec2, false, 0),
    (DataType::IntVec3, false, 2),
    (DataType::IntVec4, false, 2),
    (DataType::UintVec2, false, 2),
    (DataType::UintVec3, false, 2),
    (DataType::UintVec4, false, 0),
    (DataType::FloatMat2, true, 2),
    (DataType::FloatMat2x3, true, 2),
    (DataType::FloatMat2x4, true, 2),
    (DataType::FloatMat3x2, true, 0),
    (DataType::FloatMat3, true, 2),
    (DataType::FloatMat3x4, true, 2),
    (DataType::FloatMat4x2, true, 2),
    (DataType::FloatMat4x3, true, 2),
    (DataType::FloatMat4, true, 2),
];

/// `generateProgramInputOutputTypeBasicTypeCases`
fn generate_program_input_output_type_basic_type_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    interface: ProgramInterface,
    allow_matrix_cases: bool,
    expand_level: i32,
) {
    let target = ProgramResourceQueryTestTarget::new(interface, prop::TYPE);

    for &(data_type, is_matrix, level) in PROGRAM_IO_TYPES {
        if !allow_matrix_cases && is_matrix {
            continue;
        }
        if level <= expand_level {
            target_group.add_child(resource_case(&Node::variable(parent, data_type), target, None));
        }
    }
}

/// `generateProgramInputTypeBlockContents`
fn generate_program_input_type_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
) {
    let interface = ProgramInterface::ProgramInput;
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let input = if in_default_block {
        Node::storage_qualifier(parent, Storage::In)
    } else {
        Arc::clone(parent)
    };
    let first_stage = shader_mask_first_stage(present_shaders_mask);
    // lesser expansions on block members, to keep the case counts reasonable
    let interface_block_expansion_reducement = i32::from(!in_default_block);

    if first_stage == ShaderType::Vertex {
        // Only basic types (and no booleans)
        generate_program_input_output_type_basic_type_cases(
            &input,
            target_group,
            interface,
            true,
            2 - interface_block_expansion_reducement,
        );
    } else if first_stage == ShaderType::Fragment || !in_default_block {
        let flat_shading = Node::interpolation_qualifier(&input, Interpolation::Flat);

        let mut block_group = TestCaseGroup::new("basic_type");
        generate_program_input_output_type_basic_type_cases(
            &flat_shading,
            &mut block_group,
            interface,
            true,
            2 - interface_block_expansion_reducement,
        );
        target_group.add_child(block_group);

        let array_element = Node::array_element_default(&flat_shading);
        let mut block_group = TestCaseGroup::new("array");
        generate_program_input_output_type_basic_type_cases(
            &array_element,
            &mut block_group,
            interface,
            true,
            2 - interface_block_expansion_reducement,
        );
        target_group.add_child(block_group);

        let struct_member = Node::struct_member(&flat_shading);
        let mut block_group = TestCaseGroup::new("struct");
        generate_program_input_output_type_basic_type_cases(
            &struct_member,
            &mut block_group,
            interface,
            true,
            2 - interface_block_expansion_reducement,
        );
        target_group.add_child(block_group);
    } else if matches!(first_stage, ShaderType::TessControl | ShaderType::Geometry) {
        // arrayed interface, only basic types (and no booleans)
        let array_element = Node::array_element(&input, ARRAY_UNSIZED);
        generate_program_input_output_type_basic_type_cases(&array_element, target_group, interface, true, 2);
    } else if first_stage == ShaderType::TessEvaluation {
        // arrayed interface
        let patch_input = Node::storage_qualifier(parent, Storage::PatchIn);

        let array_elem = Node::array_element(&input, ARRAY_UNSIZED);
        let mut block_group = TestCaseGroup::new("basic_type");
        generate_program_input_output_type_basic_type_cases(&array_elem, &mut block_group, interface, true, 2);
        target_group.add_child(block_group);

        let mut block_group = TestCaseGroup::new("patch_var");
        generate_program_input_output_type_basic_type_cases(&patch_input, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);

        let struct_mbr = Node::struct_member(&patch_input);
        let mut block_group = TestCaseGroup::new("patch_var_struct");
        generate_program_input_output_type_basic_type_cases(&struct_mbr, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);

        let array_elem = Node::array_element_default(&patch_input);
        let mut block_group = TestCaseGroup::new("patch_var_array");
        generate_program_input_output_type_basic_type_cases(&array_elem, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);
    }
    // the compute stage generates nothing
}

/// `generateProgramOutputTypeBlockContents`
fn generate_program_output_type_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    present_shaders_mask: u32,
) {
    let interface = ProgramInterface::ProgramOutput;
    let in_default_block = matches!(parent.kind, NodeKind::DefaultBlock);
    let output = if in_default_block {
        Node::storage_qualifier(parent, Storage::Out)
    } else {
        Arc::clone(parent)
    };
    let last_stage = shader_mask_last_stage(present_shaders_mask);
    let interface_block_expansion_reducement = i32::from(!in_default_block);

    if matches!(
        last_stage,
        ShaderType::Vertex | ShaderType::Geometry | ShaderType::TessEvaluation
    ) || !in_default_block
    {
        let flat_shading = Node::interpolation_qualifier(&output, Interpolation::Flat);
        // lesser expansions on the stages that are not vertex
        let type_expansion_reducement = i32::from(last_stage != ShaderType::Vertex);
        let expansion_level = 2 - interface_block_expansion_reducement - type_expansion_reducement;

        let mut block_group = TestCaseGroup::new("basic_type");
        generate_program_input_output_type_basic_type_cases(
            &flat_shading,
            &mut block_group,
            interface,
            true,
            2 - interface_block_expansion_reducement,
        );
        target_group.add_child(block_group);

        let array_element = Node::array_element_default(&flat_shading);
        let mut block_group = TestCaseGroup::new("array");
        generate_program_input_output_type_basic_type_cases(
            &array_element,
            &mut block_group,
            interface,
            true,
            expansion_level,
        );
        target_group.add_child(block_group);

        let struct_member = Node::struct_member(&flat_shading);
        let mut block_group = TestCaseGroup::new("struct");
        generate_program_input_output_type_basic_type_cases(
            &struct_member,
            &mut block_group,
            interface,
            true,
            expansion_level,
        );
        target_group.add_child(block_group);
    } else if last_stage == ShaderType::Fragment {
        // only basic types and arrays of them (and no booleans or matrices)
        let mut block_group = TestCaseGroup::new("basic_type");
        generate_program_input_output_type_basic_type_cases(&output, &mut block_group, interface, false, 2);
        target_group.add_child(block_group);

        let array_element = Node::array_element_default(&output);
        let mut block_group = TestCaseGroup::new("array");
        generate_program_input_output_type_basic_type_cases(&array_element, &mut block_group, interface, false, 2);
        target_group.add_child(block_group);
    } else if last_stage == ShaderType::TessControl {
        // arrayed interface
        let patch_output = Node::storage_qualifier(parent, Storage::PatchOut);

        let array_elem = Node::array_element(&output, ARRAY_UNSIZED);
        let mut block_group = TestCaseGroup::new("basic_type");
        generate_program_input_output_type_basic_type_cases(&array_elem, &mut block_group, interface, true, 2);
        target_group.add_child(block_group);

        let mut block_group = TestCaseGroup::new("patch_var");
        generate_program_input_output_type_basic_type_cases(&patch_output, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);

        let struct_mbr = Node::struct_member(&patch_output);
        let mut block_group = TestCaseGroup::new("patch_var_struct");
        generate_program_input_output_type_basic_type_cases(&struct_mbr, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);

        let array_elem = Node::array_element_default(&patch_output);
        let mut block_group = TestCaseGroup::new("patch_var_array");
        generate_program_input_output_type_basic_type_cases(&array_elem, &mut block_group, interface, true, 1);
        target_group.add_child(block_group);
    }
    // the compute stage generates nothing
}

/// `ProgramInputTestGroup::init` / `ProgramOutputTestGroup::init` - the two differ only in
/// which half of each generator pair they use.
fn create_program_input_output_group(input_case: bool) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(if input_case { "program_input" } else { "program_output" });

    // .resource_list
    let mut block_group = TestCaseGroup::new("resource_list");
    generate_program_input_output_shader_case_blocks(
        &mut block_group,
        true,
        input_case,
        |parent, target_group, mask| {
            if input_case {
                generate_program_input_block_contents(
                    parent,
                    target_group,
                    mask,
                    true,
                    add_program_input_output_resource_list_case,
                );
            } else {
                generate_program_output_block_contents(
                    parent,
                    target_group,
                    mask,
                    true,
                    add_program_input_output_resource_list_case,
                );
            }
        },
    );
    group.add_child(block_group);

    // The three sub-groups that are one property over the basic block contents.
    let basic_group = |name: &str, target_prop: u32| {
        let mut block_group = TestCaseGroup::new(name);
        generate_program_input_output_shader_case_blocks(
            &mut block_group,
            false,
            input_case,
            |parent, target_group, mask| {
                let gen_case = |p: &NodePtr, g: &mut TestCaseGroup, i: ProgramInterface, n: &str| {
                    add_program_input_output_resource_test_case(p, g, i, n, target_prop);
                };
                if input_case {
                    generate_program_input_block_contents(parent, target_group, mask, false, gen_case);
                } else {
                    generate_program_output_block_contents(parent, target_group, mask, false, gen_case);
                }
            },
        );
        block_group
    };

    // .array_size
    group.add_child(basic_group("array_size", prop::ARRAY_SIZE));

    // .location
    let mut block_group = TestCaseGroup::new("location");
    generate_program_input_output_shader_case_blocks(
        &mut block_group,
        false,
        input_case,
        |parent, target_group, mask| {
            if input_case {
                generate_program_input_location_block_contents(parent, target_group, mask);
            } else {
                generate_program_output_location_block_contents(parent, target_group, mask);
            }
        },
    );
    group.add_child(block_group);

    // .name_length
    group.add_child(basic_group("name_length", prop::NAME_LENGTH));

    // .referenced_by
    let mut block_group = TestCaseGroup::new("referenced_by");
    generate_program_input_output_referenced_by_cases(
        &mut block_group,
        if input_case { Storage::In } else { Storage::Out },
    );
    group.add_child(block_group);

    // .type
    let mut block_group = TestCaseGroup::new("type");
    generate_program_input_output_shader_case_blocks(
        &mut block_group,
        false,
        input_case,
        |parent, target_group, mask| {
            if input_case {
                generate_program_input_type_block_contents(parent, target_group, mask);
            } else {
                generate_program_output_type_block_contents(parent, target_group, mask);
            }
        },
    );
    group.add_child(block_group);

    // .is_per_patch
    group.add_child(basic_group("is_per_patch", prop::IS_PER_PATCH));

    group
}

/// `generateTransformFeedbackShaderCaseBlocks`
fn generate_transform_feedback_shader_case_blocks(
    target_group: &mut TestCaseGroup,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup, bool),
) {
    /// One row of upstream's `pipelines` table.
    struct XfbPipeline {
        name: &'static str,
        stage_bits: u32,
        last_stage_bit: u32,
        reduced_set: bool,
    }

    let vertex = 1 << (ShaderType::Vertex as u32);
    let fragment = 1 << (ShaderType::Fragment as u32);
    let geometry = 1 << (ShaderType::Geometry as u32);
    let tess_ctrl = 1 << (ShaderType::TessControl as u32);
    let tess_eval = 1 << (ShaderType::TessEvaluation as u32);

    let pipelines = [
        XfbPipeline {
            name: "vertex_fragment",
            stage_bits: vertex | fragment,
            last_stage_bit: vertex,
            reduced_set: false,
        },
        XfbPipeline {
            name: "vertex_tess_fragment",
            stage_bits: vertex | fragment | tess_ctrl | tess_eval,
            last_stage_bit: tess_eval,
            reduced_set: true,
        },
        XfbPipeline {
            name: "vertex_geo_fragment",
            stage_bits: vertex | fragment | geometry,
            last_stage_bit: geometry,
            reduced_set: true,
        },
        XfbPipeline {
            name: "vertex_tess_geo_fragment",
            stage_bits: vertex | fragment | tess_ctrl | tess_eval | geometry,
            last_stage_bit: geometry,
            reduced_set: true,
        },
    ];

    const SINGLE_STAGE_CASES: &[(&str, ShaderType, bool)] = &[
        ("separable_vertex", ShaderType::Vertex, false),
        ("separable_tess_eval", ShaderType::TessEvaluation, true),
        ("separable_geometry", ShaderType::Geometry, true),
    ];

    // monolithic pipeline
    for pipeline in &pipelines {
        let mut block_group = TestCaseGroup::new(pipeline.name);
        let program = Node::program(false);
        let shader_set = Node::shader_set_masked(&program, pipeline.stage_bits, pipeline.last_stage_bit);

        block_content(&shader_set, &mut block_group, pipeline.reduced_set);
        target_group.add_child(block_group);
    }

    // separable pipeline
    for &(name, stage, reduced_set) in SINGLE_STAGE_CASES {
        let mut block_group = TestCaseGroup::new(name);
        let program = Node::program(true);
        let shader = Node::shader(&program, stage);

        block_content(&shader, &mut block_group, reduced_set);
        target_group.add_child(block_group);
    }
}

/// The five xfb targets both the resource-list and the variable content generators build.
fn transform_feedback_targets(parent: &NodePtr) -> [(&'static str, NodePtr); 5] {
    let default_block = Node::default_block(parent);
    let output = Node::storage_qualifier(&default_block, Storage::Out);

    // .builtin_gl_position
    let builtin = Node::transform_feedback_target(&default_block, Some("gl_Position"));

    // .default_block_basic_type
    let xfb_target = Node::transform_feedback_target(&output, None);
    let basic_type = Node::variable(&xfb_target, DataType::FloatVec4);

    // .default_block_struct_member
    let struct_mbr = Node::struct_member(&output);
    let xfb_target = Node::transform_feedback_target(&struct_mbr, None);
    let struct_member = Node::variable(&xfb_target, DataType::FloatVec4);

    // .default_block_array
    let xfb_target = Node::transform_feedback_target(&output, None);
    let array_elem = Node::array_element_default(&xfb_target);
    let array = Node::variable(&array_elem, DataType::FloatVec4);

    // .default_block_array_element
    let array_elem = Node::array_element_default(&output);
    let xfb_target = Node::transform_feedback_target(&array_elem, None);
    let array_element = Node::variable(&xfb_target, DataType::FloatVec4);

    [
        ("builtin_gl_position", builtin),
        ("default_block_basic_type", basic_type),
        ("default_block_struct_member", struct_member),
        ("default_block_array", array),
        ("default_block_array_element", array_element),
    ]
}

/// `generateTransformFeedbackResourceListBlockContents`
fn generate_transform_feedback_resource_list_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    _reduced_set: bool,
) {
    for (name, resource) in transform_feedback_targets(parent) {
        target_group.add_child(boxed(ResourceListTestCase::feedback(&resource, name)));
    }
}

/// `generateTransformFeedbackVariableBlockContents`
fn generate_transform_feedback_variable_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    _reduced_set: bool,
    target_prop: u32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::TransformFeedbackVarying, target_prop);

    for (name, resource) in transform_feedback_targets(parent) {
        target_group.add_child(resource_case(&resource, target, Some(name)));
    }
}

/// `generateTransformFeedbackVariableBasicTypeCases`'s type table: `true` marks the types
/// that stay even in the reduced set.
const XFB_TYPES: &[(DataType, bool)] = &[
    (DataType::Float, true),
    (DataType::Int, true),
    (DataType::Uint, true),
    (DataType::FloatVec2, false),
    (DataType::FloatVec3, true),
    (DataType::FloatVec4, false),
    (DataType::IntVec2, false),
    (DataType::IntVec3, true),
    (DataType::IntVec4, false),
    (DataType::UintVec2, true),
    (DataType::UintVec3, false),
    (DataType::UintVec4, false),
    (DataType::FloatMat2, false),
    (DataType::FloatMat2x3, false),
    (DataType::FloatMat2x4, false),
    (DataType::FloatMat3x2, false),
    (DataType::FloatMat3, false),
    (DataType::FloatMat3x4, true),
    (DataType::FloatMat4x2, false),
    (DataType::FloatMat4x3, false),
    (DataType::FloatMat4, false),
];

/// `generateTransformFeedbackVariableBasicTypeCases`
fn generate_transform_feedback_variable_basic_type_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    reduced_set: bool,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::TransformFeedbackVarying, prop::TYPE);

    for &(data_type, important) in XFB_TYPES {
        if important || !reduced_set {
            target_group.add_child(resource_case(&Node::variable(parent, data_type), target, None));
        }
    }
}

/// `generateTransformFeedbackVariableTypeBlockContents`
fn generate_transform_feedback_variable_type_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    reduced_set: bool,
) {
    let default_block = Node::default_block(parent);
    let output = Node::storage_qualifier(&default_block, Storage::Out);
    let flat_shading = Node::interpolation_qualifier(&output, Interpolation::Flat);

    // Only builtins, basic types, arrays of basic types and structs of basic types (and no
    // booleans).
    {
        let xfb_target = Node::transform_feedback_target(&default_block, Some("gl_Position"));
        let mut block_group = TestCaseGroup::new("builtin");
        block_group.add_child(resource_case(
            &xfb_target,
            ProgramResourceQueryTestTarget::new(ProgramInterface::TransformFeedbackVarying, prop::TYPE),
            Some("gl_position"),
        ));
        target_group.add_child(block_group);
    }

    {
        let xfb_target = Node::transform_feedback_target(&flat_shading, None);
        let mut block_group = TestCaseGroup::new("basic_type");
        generate_transform_feedback_variable_basic_type_cases(&xfb_target, &mut block_group, reduced_set);
        target_group.add_child(block_group);
    }

    {
        let array_element = Node::array_element_default(&flat_shading);
        let xfb_target = Node::transform_feedback_target(&array_element, None);
        let mut block_group = TestCaseGroup::new("array");
        generate_transform_feedback_variable_basic_type_cases(&xfb_target, &mut block_group, reduced_set);
        target_group.add_child(block_group);
    }

    {
        let xfb_target = Node::transform_feedback_target(&flat_shading, None);
        let array_element = Node::array_element_default(&xfb_target);
        let mut block_group = TestCaseGroup::new("whole_array");
        generate_transform_feedback_variable_basic_type_cases(&array_element, &mut block_group, reduced_set);
        target_group.add_child(block_group);
    }

    {
        let struct_member = Node::struct_member(&flat_shading);
        let xfb_target = Node::transform_feedback_target(&struct_member, None);
        let mut block_group = TestCaseGroup::new("struct");
        generate_transform_feedback_variable_basic_type_cases(&xfb_target, &mut block_group, reduced_set);
        target_group.add_child(block_group);
    }
}

/// `TransformFeedbackVaryingTestGroup::init`
fn create_transform_feedback_varying_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback_varying");

    // .resource_list
    let mut block_group = TestCaseGroup::new("resource_list");
    generate_transform_feedback_shader_case_blocks(
        &mut block_group,
        generate_transform_feedback_resource_list_block_contents,
    );
    group.add_child(block_group);

    // .array_size, .name_length
    for (name, target_prop) in [("array_size", prop::ARRAY_SIZE), ("name_length", prop::NAME_LENGTH)] {
        let mut block_group = TestCaseGroup::new(name);
        generate_transform_feedback_shader_case_blocks(&mut block_group, |parent, target_group, reduced_set| {
            generate_transform_feedback_variable_block_contents(parent, target_group, reduced_set, target_prop);
        });
        group.add_child(block_group);
    }

    // .type
    let mut block_group = TestCaseGroup::new("type");
    generate_transform_feedback_shader_case_blocks(
        &mut block_group,
        generate_transform_feedback_variable_type_block_contents,
    );
    group.add_child(block_group);

    group
}

/// `generateBufferVariableBufferCaseBlocks`
fn generate_buffer_variable_buffer_case_blocks(
    target_group: &mut TestCaseGroup,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup),
) {
    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let buffer_storage = Node::storage_qualifier(&default_block, Storage::Buffer);
    let binding = Node::layout_qualifier(&buffer_storage, Layout::binding(0));

    // .named_block
    let buffer = Node::interface_block(&binding, true);
    let mut block_group = TestCaseGroup::new("named_block");
    block_content(&buffer, &mut block_group);
    target_group.add_child(block_group);

    // .unnamed_block
    let buffer = Node::interface_block(&binding, false);
    let mut block_group = TestCaseGroup::new("unnamed_block");
    block_content(&buffer, &mut block_group);
    target_group.add_child(block_group);

    // .block_array
    let array_element = Node::array_element_default(&binding);
    let buffer = Node::interface_block(&array_element, true);
    let mut block_group = TestCaseGroup::new("block_array");
    block_content(&buffer, &mut block_group);
    target_group.add_child(block_group);
}

/// `generateBufferVariableArraySizeSubCases`
fn generate_buffer_variable_array_size_sub_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    target_prop: u32,
    sized_array: bool,
    extended_cases: bool,
) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, target_prop);

    // .types
    if extended_cases {
        let mut block_group = TestCaseGroup::new("types");
        generate_variable_cases(
            parent,
            &mut block_group,
            query_target,
            if sized_array { 2 } else { 1 },
            false,
        );
        target_group.add_child(block_group);
    }

    // .aggregates
    let mut aggregate_group = if extended_cases {
        TestCaseGroup::new("aggregates")
    } else {
        TestCaseGroup::new("")
    };
    let group: &mut TestCaseGroup = if extended_cases {
        &mut aggregate_group
    } else {
        target_group
    };

    for (data_type, expand_when_sized, expand_otherwise) in [
        (DataType::Float, 2, 1),
        (DataType::Bool, 1, 0),
        (DataType::BoolVec3, 2, 1),
        (DataType::FloatVec4, 2, 1),
        (DataType::IntVec2, 2, 1),
    ] {
        let expand_level = if extended_cases && sized_array {
            expand_when_sized
        } else {
            expand_otherwise
        };
        generate_buffer_backed_array_stride_type_aggregate_cases(
            parent,
            group,
            query_target.interface,
            data_type,
            expand_level,
            !extended_cases,
        );
    }

    if extended_cases {
        target_group.add_child(aggregate_group);
    }
}

/// `generateBufferVariableArrayCases`
fn generate_buffer_variable_array_cases(parent: &NodePtr, target_group: &mut TestCaseGroup, target_prop: u32) {
    let query_target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, target_prop);
    let (_, named_non_array_block) = block_shape(parent);

    // .non_array
    if named_non_array_block {
        let mut block_group = TestCaseGroup::new("non_array");
        generate_variable_cases(parent, &mut block_group, query_target, 1, false);
        target_group.add_child(block_group);
    }

    // .sized
    let sized = Node::array_element_default(parent);
    let mut block_group = TestCaseGroup::new("sized");
    generate_buffer_variable_array_size_sub_cases(&sized, &mut block_group, target_prop, true, named_non_array_block);
    target_group.add_child(block_group);

    // .unsized
    let unsized_array = Node::array_element(parent, ARRAY_UNSIZED);
    let mut block_group = TestCaseGroup::new("unsized");
    generate_buffer_variable_array_size_sub_cases(
        &unsized_array,
        &mut block_group,
        target_prop,
        false,
        named_non_array_block,
    );
    target_group.add_child(block_group);
}

/// `generateBufferVariableBlockIndexCases`
fn generate_buffer_variable_block_index_cases(target_group: &mut TestCaseGroup) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, prop::BLOCK_INDEX);

    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let buffer_storage = Node::storage_qualifier(&default_block, Storage::Buffer);
    let binding = Node::layout_qualifier(&buffer_storage, Layout::binding(0));

    // .named_block
    let buffer = Node::interface_block(&binding, true);
    target_group.add_child(resource_case(
        &Node::variable(&buffer, DataType::FloatVec4),
        target,
        Some("named_block"),
    ));

    // .unnamed_block
    let buffer = Node::interface_block(&binding, false);
    target_group.add_child(resource_case(
        &Node::variable(&buffer, DataType::FloatVec4),
        target,
        Some("unnamed_block"),
    ));

    // .block_array
    let array_element = Node::array_element_default(&binding);
    let buffer = Node::interface_block(&array_element, true);
    target_group.add_child(resource_case(
        &Node::variable(&buffer, DataType::FloatVec4),
        target,
        Some("block_array"),
    ));
}

/// `generateBufferVariableMatrixCaseBlocks`
fn generate_buffer_variable_matrix_case_blocks(
    target_group: &mut TestCaseGroup,
    block_content: impl Fn(&NodePtr, &mut TestCaseGroup, bool),
) {
    /// One row of upstream's `children` table.
    struct MatrixBlock {
        name: &'static str,
        named_block: bool,
        extended_basic_type_cases: bool,
        order: Option<MatrixOrder>,
    }

    const CHILDREN: &[MatrixBlock] = &[
        MatrixBlock {
            name: "named_block",
            named_block: true,
            extended_basic_type_cases: true,
            order: None,
        },
        MatrixBlock {
            name: "named_block_row_major",
            named_block: true,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::RowMajor),
        },
        MatrixBlock {
            name: "named_block_col_major",
            named_block: true,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::ColumnMajor),
        },
        MatrixBlock {
            name: "unnamed_block",
            named_block: false,
            extended_basic_type_cases: false,
            order: None,
        },
        MatrixBlock {
            name: "unnamed_block_row_major",
            named_block: false,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::RowMajor),
        },
        MatrixBlock {
            name: "unnamed_block_col_major",
            named_block: false,
            extended_basic_type_cases: false,
            order: Some(MatrixOrder::ColumnMajor),
        },
    ];

    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let buffer = Node::storage_qualifier(&default_block, Storage::Buffer);

    for child in CHILDREN {
        let mut block_group = TestCaseGroup::new(child.name);
        let mut parent_structure = Arc::clone(&buffer);

        if let Some(order) = child.order {
            parent_structure = Node::layout_qualifier(
                &parent_structure,
                Layout {
                    matrix_order: Some(order),
                    ..Layout::default()
                },
            );
        }
        parent_structure = Node::interface_block(&parent_structure, child.named_block);

        block_content(&parent_structure, &mut block_group, child.extended_basic_type_cases);
        target_group.add_child(block_group);
    }
}

/// `generateBufferVariableMatrixVariableBasicTypeCases` - all the matrix types and a couple
/// of non-matrix ones.
const BUFFER_VARIABLE_MATRIX_TYPES: &[DataType] = &[
    DataType::Float,
    DataType::IntVec3,
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
];

/// `generateBufferVariableMatrixVariableCases`
fn generate_buffer_variable_matrix_variable_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    target_prop: u32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, target_prop);

    // Basic aggregates
    generate_buffer_backed_variable_aggregate_type_cases(
        parent,
        target_group,
        ProgramInterface::BufferVariable,
        target_prop,
        DataType::FloatMat3x2,
        "",
        2,
    );

    // Unsized array
    let unsized_array = Node::array_element(parent, ARRAY_UNSIZED);
    target_group.add_child(resource_case(
        &Node::variable(&unsized_array, DataType::FloatMat3x2),
        target,
        Some("var_unsized_array"),
    ));
}

/// `generateBufferVariableMatrixCases`
fn generate_buffer_variable_matrix_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    extended_type_cases: bool,
    target_prop: u32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, target_prop);

    // .types
    if extended_type_cases {
        let mut block_group = TestCaseGroup::new("types");
        for &data_type in BUFFER_VARIABLE_MATRIX_TYPES {
            block_group.add_child(resource_case(&Node::variable(parent, data_type), target, None));
        }
        target_group.add_child(block_group);
    }

    // .no_qualifier
    let mut block_group = TestCaseGroup::new("no_qualifier");
    generate_buffer_variable_matrix_variable_cases(parent, &mut block_group, target_prop);
    target_group.add_child(block_group);

    // .column_major, .row_major
    for (name, order) in [
        ("column_major", MatrixOrder::ColumnMajor),
        ("row_major", MatrixOrder::RowMajor),
    ] {
        let matrix_order = Node::layout_qualifier(
            parent,
            Layout {
                matrix_order: Some(order),
                ..Layout::default()
            },
        );
        let mut block_group = TestCaseGroup::new(name);
        generate_buffer_variable_matrix_variable_cases(&matrix_order, &mut block_group, target_prop);
        target_group.add_child(block_group);
    }
}

/// `generateBufferVariableNameLengthCases` / `generateBufferVariableOffsetCases` - the two
/// differ only in the property they ask for.
fn generate_buffer_variable_sized_unsized_cases(parent: &NodePtr, target_group: &mut TestCaseGroup, target_prop: u32) {
    // .sized
    let mut block_group = TestCaseGroup::new("sized");
    generate_buffer_backed_variable_aggregate_type_cases(
        parent,
        &mut block_group,
        ProgramInterface::BufferVariable,
        target_prop,
        DataType::Float,
        "",
        3,
    );
    target_group.add_child(block_group);

    // .unsized
    let unsized_array = Node::array_element(parent, ARRAY_UNSIZED);
    let mut block_group = TestCaseGroup::new("unsized");
    generate_buffer_backed_variable_aggregate_type_cases(
        &unsized_array,
        &mut block_group,
        ProgramInterface::BufferVariable,
        target_prop,
        DataType::Float,
        "",
        2,
    );
    target_group.add_child(block_group);
}

/// `generateBufferVariableReferencedByBlockContents`
fn generate_buffer_variable_referenced_by_block_contents(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    _expand_level: i32,
) {
    let query_target =
        ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, prop::REFERENCED_BY_SHADER);
    let default_block = Node::default_block(parent);
    let storage = Node::storage_qualifier(&default_block, Storage::Buffer);
    let single_shader_case = matches!(parent.kind, NodeKind::Shader { .. });

    // .named_block
    let buffer = Node::interface_block(&storage, true);
    let mut block_group = TestCaseGroup::new("named_block");
    generate_buffer_referenced_by_shader_interface_block_cases(
        &buffer,
        &mut block_group,
        query_target,
        single_shader_case,
    );
    target_group.add_child(block_group);

    // .unnamed_block
    let buffer = Node::interface_block(&storage, false);
    let mut block_group = TestCaseGroup::new("unnamed_block");
    generate_buffer_referenced_by_shader_interface_block_cases(&buffer, &mut block_group, query_target, false);
    target_group.add_child(block_group);

    // .block_array
    let array_element = Node::array_element_default(&storage);
    let buffer = Node::interface_block(&array_element, true);
    let mut block_group = TestCaseGroup::new("block_array");
    generate_buffer_referenced_by_shader_interface_block_cases(&buffer, &mut block_group, query_target, false);
    target_group.add_child(block_group);
}

/// `generateBufferVariableTopLevelCases`
fn generate_buffer_variable_top_level_cases(parent: &NodePtr, target_group: &mut TestCaseGroup, target_prop: u32) {
    // basic and aggregate types
    generate_buffer_backed_variable_aggregate_type_cases(
        parent,
        target_group,
        ProgramInterface::BufferVariable,
        target_prop,
        DataType::FloatVec4,
        "",
        3,
    );

    // basic and aggregate types in an unsized array
    let unsized_array = Node::array_element(parent, ARRAY_UNSIZED);
    generate_buffer_backed_variable_aggregate_type_cases(
        &unsized_array,
        target_group,
        ProgramInterface::BufferVariable,
        target_prop,
        DataType::FloatVec4,
        "_unsized_array",
        2,
    );
}

/// `generateBufferVariableTypeBasicTypeCases` - the same table as `generateVariableCases`.
fn generate_buffer_variable_type_basic_type_cases(
    parent: &NodePtr,
    target_group: &mut TestCaseGroup,
    expand_level: i32,
) {
    let target = ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, prop::TYPE);

    for &(level, data_type) in VARIABLE_TYPES {
        if level <= expand_level {
            target_group.add_child(resource_case(&Node::variable(parent, data_type), target, None));
        }
    }
}

/// `generateBufferVariableTypeCases`
fn generate_buffer_variable_type_cases(parent: &NodePtr, target_group: &mut TestCaseGroup, depth: i32) {
    // .basic_type
    if depth > 0 {
        let mut block_group = TestCaseGroup::new("basic_type");
        generate_buffer_variable_type_basic_type_cases(parent, &mut block_group, depth);
        target_group.add_child(block_group);
    } else {
        // flatten the bottom level
        generate_buffer_variable_type_basic_type_cases(parent, target_group, depth);
    }

    if depth > 0 {
        // .array
        let array_element = Node::array_element_default(parent);
        let mut block_group = TestCaseGroup::new("array");
        generate_buffer_variable_type_cases(&array_element, &mut block_group, depth - 1);
        target_group.add_child(block_group);

        // .struct
        let struct_member = Node::struct_member(parent);
        let mut block_group = TestCaseGroup::new("struct");
        generate_buffer_variable_type_cases(&struct_member, &mut block_group, depth - 1);
        target_group.add_child(block_group);
    }
}

/// `generateBufferVariableTypeBlock`
fn generate_buffer_variable_type_block(target_group: &mut TestCaseGroup) {
    let program = Node::program(false);
    let shader = Node::shader(&program, ShaderType::Compute);
    let default_block = Node::default_block(&shader);
    let buffer = Node::storage_qualifier(&default_block, Storage::Buffer);
    let block = Node::interface_block(&buffer, true);

    generate_buffer_variable_type_cases(&block, target_group, 3);
}

/// `generateBufferVariableRandomCase`
fn generate_buffer_variable_random_case(target_group: &mut TestCaseGroup, index: i32, only_extension_stages: bool) {
    let mut rnd = crate::tcu::Random::new((index * 0x12345) as u32);
    let shader = generate_random_shader_set(&mut rnd, only_extension_stages);
    let data_type = generate_random_data_type(&mut rnd, true);
    let layout = generate_random_variable_layout(&mut rnd, data_type, true);
    let named_block = rnd.get_bool();

    let default_block = Node::default_block(&shader);
    let buffer = Node::storage_qualifier(&default_block, Storage::Buffer);
    let mut current = Node::layout_qualifier(&buffer, generate_random_block_layout(&mut rnd));

    if named_block && rnd.get_bool() {
        current = Node::array_element_default(&current);
    }
    current = Node::interface_block(&current, named_block);

    current = Node::layout_qualifier(&current, layout);
    current = generate_random_variable_definition(&mut rnd, &current, data_type, &layout, true);

    target_group.add_child(resource_case(
        &current,
        ProgramResourceQueryTestTarget::new(ProgramInterface::BufferVariable, prop::BUFFER_VARIABLE_MASK),
        Some(&index.to_string()),
    ));
}

/// `generateBufferVariableRandomCases`
fn generate_buffer_variable_random_cases(target_group: &mut TestCaseGroup) {
    const NUM_BASIC_CASES: i32 = 40;
    const NUM_TESS_GEO_CASES: i32 = 40;

    for ndx in 0..NUM_BASIC_CASES {
        generate_buffer_variable_random_case(target_group, ndx, false);
    }
    for ndx in 0..NUM_TESS_GEO_CASES {
        generate_buffer_variable_random_case(target_group, NUM_BASIC_CASES + ndx, true);
    }
}

/// `BufferVariableTestGroup::init`
fn create_buffer_variable_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_variable");

    // .resource_list
    let mut block_group = TestCaseGroup::new("resource_list");
    generate_buffer_variable_buffer_case_blocks(&mut block_group, |parent, target_group| {
        generate_buffer_backed_resource_list_block_content_cases(
            parent,
            target_group,
            ProgramInterface::BufferVariable,
            4,
        );
    });
    group.add_child(block_group);

    // .array_size, .array_stride
    for (name, target_prop) in [("array_size", prop::ARRAY_SIZE), ("array_stride", prop::ARRAY_STRIDE)] {
        let mut block_group = TestCaseGroup::new(name);
        generate_buffer_variable_buffer_case_blocks(&mut block_group, |parent, target_group| {
            generate_buffer_variable_array_cases(parent, target_group, target_prop);
        });
        group.add_child(block_group);
    }

    // .block_index
    let mut block_group = TestCaseGroup::new("block_index");
    generate_buffer_variable_block_index_cases(&mut block_group);
    group.add_child(block_group);

    // .is_row_major, .matrix_stride
    for (name, target_prop) in [
        ("is_row_major", prop::MATRIX_ROW_MAJOR),
        ("matrix_stride", prop::MATRIX_STRIDE),
    ] {
        let mut block_group = TestCaseGroup::new(name);
        generate_buffer_variable_matrix_case_blocks(&mut block_group, |parent, target_group, extended| {
            generate_buffer_variable_matrix_cases(parent, target_group, extended, target_prop);
        });
        group.add_child(block_group);
    }

    // .name_length, .offset
    for (name, target_prop) in [("name_length", prop::NAME_LENGTH), ("offset", prop::OFFSET)] {
        let mut block_group = TestCaseGroup::new(name);
        generate_buffer_variable_buffer_case_blocks(&mut block_group, |parent, target_group| {
            generate_buffer_variable_sized_unsized_cases(parent, target_group, target_prop);
        });
        group.add_child(block_group);
    }

    // .referenced_by
    let mut block_group = TestCaseGroup::new("referenced_by");
    generate_referenced_by_shader_case_blocks(&mut block_group, generate_buffer_variable_referenced_by_block_contents);
    group.add_child(block_group);

    // .top_level_array_size, .top_level_array_stride
    for (name, target_prop) in [
        ("top_level_array_size", prop::TOP_LEVEL_ARRAY_SIZE),
        ("top_level_array_stride", prop::TOP_LEVEL_ARRAY_STRIDE),
    ] {
        let mut block_group = TestCaseGroup::new(name);
        generate_buffer_variable_buffer_case_blocks(&mut block_group, |parent, target_group| {
            generate_buffer_variable_top_level_cases(parent, target_group, target_prop);
        });
        group.add_child(block_group);
    }

    // .type
    let mut block_group = TestCaseGroup::new("type");
    generate_buffer_variable_type_block(&mut block_group);
    group.add_child(block_group);

    // .random
    let mut block_group = TestCaseGroup::new("random");
    generate_buffer_variable_random_cases(&mut block_group);
    group.add_child(block_group);

    group
}

/// `ProgramInterfaceQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("program_interface_query");

    // .buffer_limited_query
    let mut block_group = TestCaseGroup::new("buffer_limited_query");
    block_group.add_child(boxed(ResourceNameBufferLimitCase::new("resource_name_query")));
    block_group.add_child(boxed(ResourceQueryBufferLimitCase::new("resource_query")));
    group.add_child(block_group);

    // Interfaces
    group.add_child(create_uniform_interface_group());
    group.add_child(create_buffer_backed_block_interface_group(Storage::Uniform));
    group.add_child(create_atomic_counter_group());
    group.add_child(create_program_input_output_group(true));
    group.add_child(create_program_input_output_group(false));
    group.add_child(create_transform_feedback_varying_group());
    group.add_child(create_buffer_variable_group());
    group.add_child(create_buffer_backed_block_interface_group(Storage::Buffer));

    group
}
