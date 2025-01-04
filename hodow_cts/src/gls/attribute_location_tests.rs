// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsAttributeLocationTests.cpp / .hpp  (gls::AttributeLocationTestUtil)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's 21 `tcu::TestCase`
// subclasses differ only in the attribute and binding lists they hand to `runTest`, so
// they are one `CaseKind` enum built by one function here.
//
// Nothing in this group draws: every case links a program and checks what
// `glGetActiveAttrib` and `glGetAttribLocation` answer, which is why it is worth having
// on an embedded driver - a wrong answer here is a linker bug, not a rasteriser one.

use std::collections::{BTreeMap, BTreeSet};

use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::string_template::StringTemplate;
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `Attribute::LOC_UNDEF` - the location is not defined.
pub const LOC_UNDEF: i32 = -1;
/// `Attribute::NOT_ARRAY`
pub const NOT_ARRAY: i32 = -1;

/// `AttributeLocationTestUtil::AttribType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct AttribType {
    pub name: &'static str,
    pub location_size: u32,
    pub gl_type_enum: GLenum,
}

impl AttribType {
    pub const fn new(name: &'static str, location_size: u32, gl_type_enum: GLenum) -> Self {
        Self {
            name,
            location_size,
            gl_type_enum,
        }
    }
}

/// `vec4`, which every case that fills the location space around the type under test
/// pads with.
const VEC4: AttribType = AttribType::new("vec4", 1, glw::GL_FLOAT_VEC4);
const VEC2: AttribType = AttribType::new("vec2", 1, glw::GL_FLOAT_VEC2);

/// `AttributeLocationTestUtil::Cond` - whether the attribute is read, and under what.
///
/// `COND_ALWAYS`/`COND_NEVER` are upstream's `Cond(ConstCond)`, both named `__always__`
/// and told apart by `m_negate`; a named condition reads a `u_<name>` uniform.
#[derive(Clone, PartialEq, Eq, Debug)]
pub struct Cond {
    negate: bool,
    name: String,
}

impl Cond {
    pub fn always() -> Self {
        Self {
            negate: true,
            name: "__always__".to_string(),
        }
    }

    pub fn never() -> Self {
        Self {
            negate: false,
            name: "__always__".to_string(),
        }
    }

    pub fn named(name: &str, negate: bool) -> Self {
        Self {
            negate,
            name: name.to_string(),
        }
    }

    fn is_always(&self) -> bool {
        *self == Self::always()
    }

    fn is_never(&self) -> bool {
        *self == Self::never()
    }
}

/// `AttributeLocationTestUtil::Attribute`
#[derive(Clone, Debug)]
pub struct Attribute {
    ty: AttribType,
    name: String,
    layout_location: i32,
    cond: Cond,
    array_size: i32,
}

impl Attribute {
    pub fn new(ty: AttribType, name: impl Into<String>) -> Self {
        Self {
            ty,
            name: name.into(),
            layout_location: LOC_UNDEF,
            cond: Cond::always(),
            array_size: NOT_ARRAY,
        }
    }

    pub fn with_location(mut self, location: i32) -> Self {
        self.layout_location = location;
        self
    }

    pub fn with_cond(mut self, cond: Cond) -> Self {
        self.cond = cond;
        self
    }

    pub fn with_array_size(mut self, array_size: i32) -> Self {
        self.array_size = array_size;
        self
    }
}

/// `AttributeLocationTestUtil::Bind`
#[derive(Clone, Debug)]
pub struct Bind {
    attribute: String,
    location: u32,
}

impl Bind {
    pub fn new(attribute: impl Into<String>, location: u32) -> Self {
        Self {
            attribute: attribute.into(),
            location,
        }
    }
}

/// `getBoundLocation`
fn bound_location(bindings: &BTreeMap<String, u32>, attrib: &str) -> i32 {
    bindings.get(attrib).map_or(LOC_UNDEF, |loc| *loc as i32)
}

/// `hasAttributeAliasing` - two attributes reserving the same location. It decides the
/// GLSL version the shaders are built at, since only `#version 100` allows it on ES.
fn has_attribute_aliasing(attributes: &[Attribute], bindings: &BTreeMap<String, u32>) -> bool {
    let mut reserved_spaces: Vec<bool> = Vec::new();

    for attrib in attributes {
        let location = bound_location(bindings, &attrib.name);
        let size = attrib.ty.location_size;

        if location != LOC_UNDEF {
            let end = location as usize + size as usize;
            if reserved_spaces.len() < end {
                reserved_spaces.resize(end, false);
            }

            for i in 0..size as usize {
                if reserved_spaces[location as usize + i] {
                    return true;
                }
                reserved_spaces[location as usize + i] = true;
            }
        }
    }

    false
}

/// `getMaxAttributeLocations`
fn max_attribute_locations(context: &Context) -> Result<i32, TestError> {
    let gl = context.gl();
    let mut max_attribs = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_attribs) };
    glu::expect_no_error(gl, "glGetIntegerv()")?;
    Ok(max_attribs)
}

/// `generateAttributeDefinitions`
fn generate_attribute_definitions(attributes: &[Attribute]) -> String {
    let mut src = String::new();

    for attrib in attributes {
        if attrib.layout_location != LOC_UNDEF {
            src.push_str(&format!("layout(location = {}) ", attrib.layout_location));
        }

        src.push_str(&format!(
            "${{VTX_INPUT}} mediump {} {}{};\n",
            attrib.ty.name,
            attrib.name,
            if attrib.array_size != NOT_ARRAY {
                format!("[{}]", attrib.array_size)
            } else {
                String::new()
            }
        ));
    }

    src
}

/// `generateConditionUniformDefinitions`
fn generate_condition_uniform_definitions(attributes: &[Attribute]) -> String {
    let conditions: BTreeSet<&str> = attributes
        .iter()
        .filter(|a| !a.cond.is_never() && !a.cond.is_always())
        .map(|a| a.cond.name.as_str())
        .collect();

    conditions
        .iter()
        .map(|name| format!("uniform mediump float u_{name};\n"))
        .collect()
}

/// `generateToVec4Expression` - `id` is `None` where upstream passes its default `-1`,
/// which only ever reaches a non-array attribute.
fn generate_to_vec4_expression(attrib: &Attribute, id: Option<i32>) -> String {
    let variable_name = if attrib.array_size != NOT_ARRAY {
        format!("{}[{}]", attrib.name, id.unwrap_or(-1))
    } else {
        attrib.name.clone()
    };

    match attrib.ty.gl_type_enum {
        glw::GL_INT_VEC2 | glw::GL_UNSIGNED_INT_VEC2 | glw::GL_FLOAT_VEC2 => {
            format!("vec4({variable_name}.xy, {variable_name}.yx)")
        }
        glw::GL_INT_VEC3 | glw::GL_UNSIGNED_INT_VEC3 | glw::GL_FLOAT_VEC3 => {
            format!("vec4({variable_name}.xyz, {variable_name}.x)")
        }
        _ => format!("vec4({variable_name})"),
    }
}

/// `generateOutputCode`
fn generate_output_code(attributes: &[Attribute]) -> String {
    let mut src = String::new();

    for attrib in attributes {
        let adds = |indent: &str| -> String {
            if attrib.array_size == NOT_ARRAY {
                format!("{indent}color += {};\n", generate_to_vec4_expression(attrib, None))
            } else {
                (0..attrib.array_size)
                    .map(|i| format!("{indent}color += {};\n", generate_to_vec4_expression(attrib, Some(i))))
                    .collect()
            }
        };

        if attrib.cond.is_never() {
            src.push_str("\tif (0 != 0)\n\t{\n");
            src.push_str(&adds("\t\t"));
            src.push_str("\t}\n");
        } else if attrib.cond.is_always() {
            src.push_str(&adds("\t"));
        } else {
            src.push_str(&format!(
                "\tif (u_{} {} 0.0)\n\t{{\n",
                attrib.cond.name,
                if attrib.cond.negate { "!=" } else { "==" }
            ));
            src.push_str(&adds("\t\t"));
            src.push_str("\t}\n");
        }
    }

    src
}

/// `generateVertexShaderTemplate`
fn generate_vertex_shader_template(attributes: &[Attribute]) -> String {
    format!(
        "${{VERSION}}\n\
         ${{VTX_OUTPUT}} mediump vec4 v_color;\n\
         {}\n{}\n\
         void main (void)\n\
         {{\n\
         \tmediump vec4 color = vec4(0.0);\n\
         \n\
         {}\n\
         \tv_color = color;\n\
         \tgl_Position = color;\n\
         }}\n",
        generate_attribute_definitions(attributes),
        generate_condition_uniform_definitions(attributes),
        generate_output_code(attributes),
    )
}

/// The `${...}` parameters both shaders are specialized with.
///
/// On GLES only GLSL `#version 100` supports aliasing, so a case that deliberately
/// aliases two attributes drops to it whatever the context version is.
fn shader_parameters(context: &Context, attribute_aliasing: bool) -> Vec<(&'static str, String)> {
    let context_glsl_version = context.context_type().glsl_version();
    let glsl_version = if attribute_aliasing {
        GlslVersion::Es100
    } else {
        context_glsl_version
    };
    let uses_in_out = glsl_version >= GlslVersion::Es300;

    vec![
        ("VERSION", glsl_version.declaration().to_string()),
        ("VTX_OUTPUT", (if uses_in_out { "out" } else { "varying" }).to_string()),
        ("VTX_INPUT", (if uses_in_out { "in" } else { "attribute" }).to_string()),
        ("FRAG_INPUT", (if uses_in_out { "in" } else { "varying" }).to_string()),
        (
            "FRAG_OUTPUT_VAR",
            (if uses_in_out { "dEQP_FragColor" } else { "gl_FragColor" }).to_string(),
        ),
        (
            "FRAG_OUTPUT_DECLARATION",
            (if uses_in_out {
                "layout(location=0) out mediump vec4 dEQP_FragColor;"
            } else {
                ""
            })
            .to_string(),
        ),
    ]
}

/// `createVertexShaderSource`
fn create_vertex_shader_source(
    context: &Context,
    attributes: &[Attribute],
    attribute_aliasing: bool,
) -> Result<String, TestError> {
    StringTemplate::new(generate_vertex_shader_template(attributes))
        .specialize(&shader_parameters(context, attribute_aliasing))
}

/// `createFragmentShaderSource`
fn create_fragment_shader_source(context: &Context, attribute_aliasing: bool) -> Result<String, TestError> {
    const SOURCE: &str = "${VERSION}\n\
                          ${FRAG_OUTPUT_DECLARATION}\n\
                          ${FRAG_INPUT} mediump vec4 v_color;\n\
                          void main (void)\n\
                          {\n\
                          \t${FRAG_OUTPUT_VAR} = v_color;\n\
                          }\n";

    StringTemplate::new(SOURCE).specialize(&shader_parameters(context, attribute_aliasing))
}

/// `getShaderCompileStatus` / `getProgramLinkStatus`
fn shader_compile_status(gl: &glw::Functions, shader: GLuint) -> bool {
    let mut status = 0;
    // SAFETY: one GLint out for a shader this module created.
    unsafe { gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status) };
    status == glw::TRUE as GLint
}

fn program_link_status(gl: &glw::Functions, program: GLuint) -> bool {
    let mut status = 0;
    // SAFETY: one GLint out for a program this module created.
    unsafe { gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status) };
    status == glw::TRUE as GLint
}

/// `getShaderInfoLog` / `getProgramInfoLog`, which upstream logs either way.
fn shader_info_log(gl: &glw::Functions, shader: GLuint) -> String {
    let mut length = 0;
    // SAFETY: one GLint out, then a buffer of exactly the length it reported.
    unsafe {
        gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length);
        let mut buf = vec![0u8; length.max(0) as usize];
        gl.get_shader_info_log(shader, buf.len() as i32, std::ptr::null_mut(), buf.as_mut_ptr().cast());
        String::from_utf8_lossy(&buf).trim_end_matches('\0').to_string()
    }
}

fn program_info_log(gl: &glw::Functions, program: GLuint) -> String {
    let mut length = 0;
    // SAFETY: as above.
    unsafe {
        gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length);
        let mut buf = vec![0u8; length.max(0) as usize];
        gl.get_program_info_log(program, buf.len() as i32, std::ptr::null_mut(), buf.as_mut_ptr().cast());
        String::from_utf8_lossy(&buf).trim_end_matches('\0').to_string()
    }
}

/// `createAndAttachShaders` - returns the two shader names, which stay attached after
/// being deleted so that a later `glDetachShader` can name them.
fn create_and_attach_shaders(
    context: &Context,
    program: GLuint,
    attributes: &[Attribute],
    attribute_aliasing: bool,
) -> Result<(GLuint, GLuint), TestError> {
    let gl = context.gl();
    let vertex_source = create_vertex_shader_source(context, attributes, attribute_aliasing)?;
    let fragment_source = create_fragment_shader_source(context, attribute_aliasing)?;

    // SAFETY: each source pointer is valid for the duration of the `glShaderSource`
    // call, which is all the driver may read it for.
    unsafe {
        let vertex_shader = gl.create_shader(glw::GL_VERTEX_SHADER);
        let fragment_shader = gl.create_shader(glw::GL_FRAGMENT_SHADER);
        glu::expect_no_error(gl, "glCreateShader()")?;

        for (shader, source) in [(vertex_shader, &vertex_source), (fragment_shader, &fragment_source)] {
            let c_source = std::ffi::CString::new(source.as_str()).expect("generated GLSL has no interior nul");
            let ptr = c_source.as_ptr();
            gl.shader_source(shader, 1, &ptr, std::ptr::null());
        }
        glu::expect_no_error(gl, "glShaderSource()")?;

        gl.compile_shader(vertex_shader);
        gl.compile_shader(fragment_shader);
        glu::expect_no_error(gl, "glCompileShader()")?;

        gl.attach_shader(program, vertex_shader);
        gl.attach_shader(program, fragment_shader);
        glu::expect_no_error(gl, "glAttachShader()")?;

        let vertex_compile_ok = shader_compile_status(gl, vertex_shader);
        let fragment_compile_ok = shader_compile_status(gl, fragment_shader);

        if !vertex_compile_ok {
            log::warn!("vertex shader info log: {}", shader_info_log(gl, vertex_shader));
        }
        if !fragment_compile_ok {
            log::warn!("fragment shader info log: {}", shader_info_log(gl, fragment_shader));
        }

        gl.delete_shader(vertex_shader);
        gl.delete_shader(fragment_shader);

        if !vertex_compile_ok {
            return Err(TestError::Fail("Vertex shader compilation failed".to_string()));
        }
        if !fragment_compile_ok {
            return Err(TestError::Fail("Fragment shader compilation failed".to_string()));
        }

        Ok((vertex_shader, fragment_shader))
    }
}

/// `bindAttributes`
fn bind_attributes(gl: &glw::Functions, program: GLuint, binds: &[Bind]) -> Result<(), TestError> {
    for bind in binds {
        log::info!("Bind attribute: '{}' to {}", bind.attribute, bind.location);
        let name = std::ffi::CString::new(bind.attribute.as_str()).expect("generated name has no interior nul");
        // SAFETY: the program is this module's own and the name lives past the call.
        unsafe { gl.bind_attrib_location(program, bind.location, name.as_ptr()) };
        glu::expect_no_error(gl, "glBindAttribLocation()")?;
    }
    Ok(())
}

/// `checkActiveAttribQuery`
fn check_active_attrib_query(
    gl: &glw::Functions,
    program: GLuint,
    attributes: &[Attribute],
) -> Result<bool, TestError> {
    let mut active_attrib_count = 0;
    let mut active_attributes: BTreeSet<String> = BTreeSet::new();
    let mut is_ok = true;

    // SAFETY: one GLint out for a linked program.
    unsafe { gl.get_programiv(program, glw::GL_ACTIVE_ATTRIBUTES, &mut active_attrib_count) };
    glu::expect_no_error(gl, "glGetProgramiv(program, GL_ACTIVE_ATTRIBUTES, &activeAttribCount)")?;

    for active_attrib_ndx in 0..active_attrib_count.max(0) {
        // Upstream's own buffer; a longer name is truncated on both sides alike.
        let mut name = [0u8; 128];
        let mut length = 0;
        let mut size = 0;
        let mut ty = 0;

        // SAFETY: the index is below GL_ACTIVE_ATTRIBUTES, and the buffer size passed
        // leaves room for the terminator the driver writes.
        unsafe {
            gl.get_active_attrib(
                program,
                active_attrib_ndx as GLuint,
                name.len() as i32 - 1,
                &mut length,
                &mut size,
                &mut ty,
                name.as_mut_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "glGetActiveAttrib()")?;

        let name = String::from_utf8_lossy(&name[..length.max(0) as usize]).to_string();
        log::info!(
            "glGetActiveAttrib(program, index={active_attrib_ndx}, length={length}, size={size}, type={ty:#x}, name='{name}')"
        );

        match attributes.iter().find(|a| a.name == name) {
            Some(attrib) => {
                if ty != attrib.ty.gl_type_enum {
                    log::warn!("Error: Wrong type {ty:#x} expected {:#x}", attrib.ty.gl_type_enum);
                    is_ok = false;
                }

                let expected_size = if attrib.array_size == NOT_ARRAY {
                    1
                } else {
                    attrib.array_size
                };
                if size != expected_size {
                    log::warn!("Error: Wrong size {size} expected {expected_size}");
                    is_ok = false;
                }
            }
            None => {
                log::warn!("Error: Unknown attribute '{name}' returned by glGetActiveAttrib().");
                is_ok = false;
            }
        }

        active_attributes.insert(name);
    }

    for attrib in attributes {
        if !attrib.cond.is_never() {
            if !active_attributes.contains(&attrib.name) {
                log::warn!(
                    "Error: Active attribute {} wasn't returned by glGetActiveAttrib().",
                    attrib.name
                );
                is_ok = false;
            }
        } else if active_attributes.contains(&attrib.name) {
            log::info!(
                "Note: Inactive attribute {} was returned by glGetActiveAttrib().",
                attrib.name
            );
        }
    }

    Ok(is_ok)
}

/// `checkAttribLocationQuery`
fn check_attrib_location_query(
    gl: &glw::Functions,
    program: GLuint,
    attributes: &[Attribute],
    bindings: &BTreeMap<String, u32>,
) -> Result<bool, TestError> {
    let mut is_ok = true;

    for attrib in attributes {
        // A layout qualifier wins over a bind, which is the whole point of the `mixed`
        // sub-groups.
        let expected_location = if attrib.layout_location != LOC_UNDEF {
            attrib.layout_location
        } else {
            bound_location(bindings, &attrib.name)
        };

        let name = std::ffi::CString::new(attrib.name.as_str()).expect("generated name has no interior nul");
        // SAFETY: the program is linked and the name lives past the call.
        let location = unsafe { gl.get_attrib_location(program, name.as_ptr()) };
        glu::expect_no_error(gl, "glGetAttribLocation()")?;

        log::info!("{location} = glGetAttribLocation(program, \"{}\").", attrib.name);

        if attrib.cond.is_never() && location != -1 {
            log::info!("\tNote: Inactive attribute with location.");
        }

        if !attrib.cond.is_never() && expected_location != LOC_UNDEF && expected_location != location {
            log::warn!("\tError: Invalid attribute location.");
        }

        is_ok &= attrib.cond.is_never() || expected_location == LOC_UNDEF || expected_location == location;
    }

    Ok(is_ok)
}

/// `checkQuery`
fn check_query(
    gl: &glw::Functions,
    program: GLuint,
    attributes: &[Attribute],
    bindings: &BTreeMap<String, u32>,
) -> Result<bool, TestError> {
    let active_ok = check_active_attrib_query(gl, program, attributes)?;
    let location_ok = check_attrib_location_query(gl, program, attributes, bindings)?;
    Ok(active_ok && location_ok)
}

/// What one case hands to `run_test`.
#[derive(Default)]
struct TestPlan {
    attributes: Vec<Attribute>,
    pre_attach_bind: Vec<Bind>,
    pre_link_bind: Vec<Bind>,
    post_link_bind: Vec<Bind>,
    relink: bool,
    reattach_attributes: Option<Vec<Attribute>>,
}

/// `AttributeLocationTestUtil::runTest`
fn run_test(context: &Context, plan: &TestPlan) -> TestOutcome {
    let gl = context.gl();
    let mut is_ok = true;
    let mut active_bindings: BTreeMap<String, u32> = BTreeMap::new();

    for bind in plan.pre_attach_bind.iter().chain(&plan.pre_link_bind) {
        active_bindings.insert(bind.attribute.clone(), bind.location);
    }

    for attrib in &plan.attributes {
        log::info!(
            "Type: {}, Name: {}{}",
            attrib.ty.name,
            attrib.name,
            if attrib.layout_location != LOC_UNDEF {
                format!(", Layout location {}", attrib.layout_location)
            } else {
                String::new()
            }
        );
    }

    // SAFETY: the program name below is this call's own and is deleted on every path
    // out, including the `?` ones, through `ProgramGuard`.
    let program = unsafe { gl.create_program() };
    glu::expect_no_error(gl, "glCreateProgram()")?;
    let program = ProgramGuard { gl, program };

    if !plan.pre_attach_bind.is_empty() {
        bind_attributes(gl, program.program, &plan.pre_attach_bind)?;
    }

    let aliasing = has_attribute_aliasing(&plan.attributes, &active_bindings);
    let shaders = create_and_attach_shaders(context, program.program, &plan.attributes, aliasing)?;

    if !plan.pre_link_bind.is_empty() {
        bind_attributes(gl, program.program, &plan.pre_link_bind)?;
    }

    // SAFETY: the program has both shaders attached.
    unsafe { gl.link_program(program.program) };
    glu::expect_no_error(gl, "glLinkProgram()")?;

    if !program_link_status(gl, program.program) {
        log::warn!("program info log: {}", program_info_log(gl, program.program));
        return Err(TestError::Fail("Program link failed".to_string()));
    }

    if !check_query(gl, program.program, &plan.attributes, &active_bindings)? {
        is_ok = false;
    }

    if !plan.post_link_bind.is_empty() {
        bind_attributes(gl, program.program, &plan.post_link_bind)?;

        // A bind made after linking must not take effect until the next link, which is
        // exactly what this second query checks.
        if !check_query(gl, program.program, &plan.attributes, &active_bindings)? {
            is_ok = false;
        }
    }

    if plan.relink {
        // SAFETY: as above.
        unsafe { gl.link_program(program.program) };
        glu::expect_no_error(gl, "glLinkProgram()")?;

        if !program_link_status(gl, program.program) {
            log::warn!("program info log: {}", program_info_log(gl, program.program));
            return Err(TestError::Fail("Program link failed".to_string()));
        }

        for bind in &plan.post_link_bind {
            active_bindings.insert(bind.attribute.clone(), bind.location);
        }

        if !check_query(gl, program.program, &plan.attributes, &active_bindings)? {
            is_ok = false;
        }
    }

    if let Some(reattach_attributes) = &plan.reattach_attributes {
        // SAFETY: both shader names came from this program's own attachments.
        unsafe {
            gl.detach_shader(program.program, shaders.0);
            gl.detach_shader(program.program, shaders.1);
        }
        glu::expect_no_error(gl, "glDetachShader()")?;

        let aliasing = has_attribute_aliasing(reattach_attributes, &active_bindings);
        create_and_attach_shaders(context, program.program, reattach_attributes, aliasing)?;

        // SAFETY: as above.
        unsafe { gl.link_program(program.program) };
        glu::expect_no_error(gl, "glLinkProgram()")?;

        if !program_link_status(gl, program.program) {
            log::warn!("program info log: {}", program_info_log(gl, program.program));
            return Err(TestError::Fail("Program link failed".to_string()));
        }

        if !check_query(gl, program.program, reattach_attributes, &active_bindings)? {
            is_ok = false;
        }
    }

    Ok(if is_ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// Upstream's `catch (...) { glDeleteProgram(program); throw; }`.
struct ProgramGuard<'gl> {
    gl: &'gl glw::Functions,
    program: GLuint,
}

impl Drop for ProgramGuard<'_> {
    fn drop(&mut self) {
        // SAFETY: the name is this guard's own and is deleted exactly once.
        unsafe { self.gl.delete_program(self.program) };
    }
}

/// Which of upstream's 21 case classes this is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum CaseKind {
    /// `BindAttributeTest`
    Bind,
    /// `BindMaxAttributesTest`
    BindMax,
    /// `BindAliasingAttributeTest`, with the second attribute's bind offset.
    BindAliasing(i32),
    /// `BindMaxAliasingAttributeTest`
    BindMaxAliasing,
    /// `BindInactiveAliasingAttributeTest`
    BindInactiveAliasing,
    /// `BindHoleAttributeTest`
    BindHole,
    /// `PreAttachBindAttributeTest`
    PreAttachBind,
    /// `PreLinkBindAttributeTest`
    PreLinkBind,
    /// `PostLinkBindAttributeTest`
    PostLinkBind,
    /// `BindRelinkAttributeTest`
    BindRelink,
    /// `BindReattachAttributeTest`
    BindReattach,
    /// `LocationAttributeTest`
    Location,
    /// `LocationMaxAttributesTest`
    LocationMax,
    /// `LocationHoleAttributeTest`
    LocationHole,
    /// `MixedAttributeTest`
    Mixed,
    /// `MixedMaxAttributesTest`
    MixedMax,
    /// `MixedHoleAttributeTest`
    MixedHole,
    /// `BindRelinkHoleAttributeTest`
    BindRelinkHole,
    /// `MixedRelinkHoleAttributeTest`
    MixedRelinkHole,
    /// `PreAttachMixedAttributeTest`
    PreAttachMixed,
    /// `PreLinkMixedAttributeTest`
    PreLinkMixed,
    /// `PostLinkMixedAttributeTest`
    PostLinkMixed,
    /// `MixedRelinkAttributeTest`
    MixedRelink,
    /// `MixedReattachAttributeTest`
    MixedReattach,
}

/// Each case class's `iterate` body, up to the `runTest` call.
fn build_plan(kind: CaseKind, ty: AttribType, array_size: i32, context: &Context) -> Result<TestPlan, TestError> {
    let mut plan = TestPlan::default();
    let array_element_count = if array_size != NOT_ARRAY { array_size } else { 1 };

    match kind {
        CaseKind::Bind => {
            plan.attributes
                .push(Attribute::new(ty, "a_0").with_array_size(array_size));
            plan.pre_link_bind.push(Bind::new("a_0", 3));
        }
        CaseKind::BindMax | CaseKind::LocationMax | CaseKind::MixedMax => {
            let max_attributes = max_attribute_locations(context)?;
            log::info!("GL_MAX_VERTEX_ATTRIBS: {max_attributes}");

            let step = array_element_count * ty.location_size as i32;
            let mut ndx = 0;
            let mut loc = max_attributes - step;
            while loc >= 0 {
                let name = format!("a_{ndx}");
                match kind {
                    CaseKind::BindMax => {
                        plan.attributes
                            .push(Attribute::new(ty, &name).with_array_size(array_size));
                        plan.pre_link_bind.push(Bind::new(&name, loc as u32));
                    }
                    CaseKind::LocationMax => {
                        plan.attributes
                            .push(Attribute::new(ty, &name).with_location(loc).with_array_size(array_size));
                    }
                    // `mixed_max_attributes` alternates: odd indices take a layout
                    // qualifier, even ones a bind, so both paths fill the same space.
                    _ if ndx % 2 != 0 => {
                        plan.attributes
                            .push(Attribute::new(ty, &name).with_location(loc).with_array_size(array_size));
                    }
                    _ => {
                        plan.attributes
                            .push(Attribute::new(ty, &name).with_array_size(array_size));
                        plan.pre_link_bind.push(Bind::new(&name, loc as u32));
                    }
                }
                ndx += 1;
                loc -= step;
            }
        }
        CaseKind::BindAliasing(offset) => {
            plan.attributes.push(
                Attribute::new(ty, "a_0")
                    .with_cond(Cond::named("A", true))
                    .with_array_size(array_size),
            );
            plan.attributes
                .push(Attribute::new(VEC4, "a_1").with_cond(Cond::named("A", false)));
            plan.pre_link_bind.push(Bind::new("a_0", 1));
            plan.pre_link_bind.push(Bind::new("a_1", (1 + offset) as u32));
        }
        CaseKind::BindMaxAliasing | CaseKind::BindInactiveAliasing => {
            let max_attributes = max_attribute_locations(context)?;
            log::info!("GL_MAX_VERTEX_ATTRIBS: {max_attributes}");

            let step = ty.location_size as i32 * array_element_count;
            let mut ndx = 0;
            let mut loc = max_attributes - step;
            while loc >= 0 {
                let first = format!("a_{ndx}");
                let second = format!("a_{}", ndx + max_attributes);

                plan.attributes
                    .push(Attribute::new(ty, &first).with_cond(Cond::named("A", true)));
                plan.pre_link_bind.push(Bind::new(&first, loc as u32));

                let second_cond = if kind == CaseKind::BindMaxAliasing {
                    Cond::named("A", false)
                } else {
                    Cond::never()
                };
                plan.attributes.push(Attribute::new(ty, &second).with_cond(second_cond));
                plan.pre_link_bind.push(Bind::new(&second, loc as u32));

                ndx += 1;
                loc -= step;
            }
        }
        CaseKind::BindHole
        | CaseKind::LocationHole
        | CaseKind::MixedHole
        | CaseKind::BindRelinkHole
        | CaseKind::MixedRelinkHole => {
            let max_attributes = max_attribute_locations(context)?;
            let uses_layout = matches!(kind, CaseKind::LocationHole);

            // `a_0` pins location 0, `a_1` is the attribute the hole is left for, and
            // the rest fill every location above it.
            if uses_layout {
                plan.attributes.push(Attribute::new(VEC4, "a_0").with_location(0));
            } else {
                plan.attributes.push(Attribute::new(VEC4, "a_0"));
                plan.pre_link_bind.push(Bind::new("a_0", 0));
            }

            plan.attributes
                .push(Attribute::new(ty, "a_1").with_array_size(array_size));

            for (ndx, loc) in (2..).zip((1 + ty.location_size as i32 * array_element_count)..max_attributes) {
                let name = format!("a_{ndx}");
                match kind {
                    CaseKind::LocationHole => plan.attributes.push(Attribute::new(VEC4, &name).with_location(loc)),
                    CaseKind::BindHole | CaseKind::BindRelinkHole => {
                        plan.attributes.push(Attribute::new(VEC4, &name));
                        plan.pre_link_bind.push(Bind::new(&name, loc as u32));
                    }
                    // `mixed_hole` gives every attribute a layout qualifier and binds
                    // the even ones on top of it; `mixed_relink_hole` alternates.
                    CaseKind::MixedHole => {
                        plan.attributes.push(Attribute::new(VEC4, &name).with_location(loc));
                        if ndx % 2 == 0 {
                            plan.pre_link_bind.push(Bind::new(&name, loc as u32));
                        }
                    }
                    _ if ndx % 2 != 0 => plan.attributes.push(Attribute::new(VEC4, &name).with_location(loc)),
                    _ => {
                        plan.attributes.push(Attribute::new(VEC4, &name));
                        plan.pre_link_bind.push(Bind::new(&name, loc as u32));
                    }
                }
            }

            if matches!(kind, CaseKind::BindRelinkHole | CaseKind::MixedRelinkHole) {
                plan.post_link_bind.push(Bind::new("a_2", 1));
                plan.relink = true;
            }
        }
        CaseKind::PreAttachBind | CaseKind::PreLinkBind | CaseKind::PostLinkBind => {
            plan.attributes.push(Attribute::new(VEC4, "a_0"));
            let bind = vec![Bind::new("a_0", 3)];
            match kind {
                CaseKind::PreAttachBind => plan.pre_attach_bind = bind,
                CaseKind::PreLinkBind => plan.pre_link_bind = bind,
                _ => plan.post_link_bind = bind,
            }
        }
        CaseKind::PreAttachMixed | CaseKind::PreLinkMixed | CaseKind::PostLinkMixed => {
            plan.attributes.push(Attribute::new(VEC4, "a_0").with_location(1));
            let bind = vec![Bind::new("a_0", 3)];
            match kind {
                CaseKind::PreAttachMixed => plan.pre_attach_bind = bind,
                CaseKind::PreLinkMixed => plan.pre_link_bind = bind,
                _ => plan.post_link_bind = bind,
            }
        }
        CaseKind::BindRelink | CaseKind::MixedRelink => {
            let a_0 = Attribute::new(VEC4, "a_0");
            plan.attributes.push(if kind == CaseKind::MixedRelink {
                a_0.with_location(1)
            } else {
                a_0
            });
            plan.attributes.push(Attribute::new(VEC4, "a_1"));

            // Two binds of the same attribute: the later one wins.
            plan.pre_link_bind.push(Bind::new("a_0", 3));
            plan.pre_link_bind.push(Bind::new("a_0", 5));
            plan.post_link_bind.push(Bind::new("a_0", 6));
            plan.relink = true;
        }
        CaseKind::BindReattach | CaseKind::MixedReattach => {
            let a_0 = Attribute::new(VEC4, "a_0");
            plan.attributes.push(if kind == CaseKind::MixedReattach {
                a_0.with_location(2)
            } else {
                a_0
            });
            plan.pre_link_bind.push(Bind::new("a_0", 1));
            // `a_1` does not exist yet; the bind is there for the reattached shader.
            plan.pre_link_bind.push(Bind::new("a_1", 1));
            plan.reattach_attributes = Some(vec![Attribute::new(VEC2, "a_1")]);
        }
        CaseKind::Location => {
            plan.attributes
                .push(Attribute::new(ty, "a_0").with_location(3).with_array_size(array_size));
        }
        CaseKind::Mixed => {
            plan.attributes
                .push(Attribute::new(ty, "a_0").with_location(3).with_array_size(array_size));
            plan.pre_link_bind.push(Bind::new("a_0", 4));
        }
    }

    Ok(plan)
}

struct AttributeLocationCase {
    name: String,
    kind: CaseKind,
    ty: AttribType,
    array_size: i32,
}

impl TestCase for AttributeLocationCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let plan = build_plan(self.kind, self.ty, self.array_size, context)?;
        run_test(context, &plan)
    }
}

/// `generateTestName`
fn generate_test_name(ty: AttribType, array_size: i32) -> String {
    if array_size != NOT_ARRAY {
        format!("{}_array_{array_size}", ty.name)
    } else {
        ty.name.to_string()
    }
}

/// The name each case class gives itself, which is only sometimes `generateTestName`.
fn case_name(kind: CaseKind, ty: AttribType, array_size: i32) -> String {
    match kind {
        CaseKind::BindAliasing(offset) => {
            let base = format!("cond_{}", generate_test_name(ty, array_size));
            if offset != 0 {
                format!("{base}_offset_{offset}")
            } else {
                base
            }
        }
        CaseKind::BindMaxAliasing => format!("max_cond_{}", generate_test_name(ty, array_size)),
        CaseKind::BindInactiveAliasing => format!("max_inactive_{}", generate_test_name(ty, array_size)),
        CaseKind::PreAttachBind | CaseKind::PreAttachMixed => "pre_attach".to_string(),
        CaseKind::PreLinkBind | CaseKind::PreLinkMixed => "pre_link".to_string(),
        CaseKind::PostLinkBind | CaseKind::PostLinkMixed => "post_link".to_string(),
        CaseKind::BindRelink | CaseKind::MixedRelink => "relink".to_string(),
        CaseKind::BindReattach | CaseKind::MixedReattach => "reattach".to_string(),
        _ => generate_test_name(ty, array_size),
    }
}

/// Builds one case; `ty` is ignored by the kinds that hardcode `vec4`.
pub fn case(kind: CaseKind, ty: AttribType) -> Box<dyn TestCase> {
    Box::new(AttributeLocationCase {
        name: case_name(kind, ty, NOT_ARRAY),
        kind,
        ty,
        array_size: NOT_ARRAY,
    })
}

/// Adds every case of `kind` over `types`, which is the shape every sub-group but the
/// `*_time` ones has.
pub fn add_type_cases(group: &mut TestCaseGroup, kind: CaseKind, types: &[AttribType]) {
    for ty in types {
        group.add_child(case(kind, *ty));
    }
}
