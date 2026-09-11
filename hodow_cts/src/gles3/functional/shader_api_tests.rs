// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All five of upstream's sub-groups are
// here. `program_binary`'s `drawWithProgram` goes through `glu::draw` upstream; this port
// has no `drawUtil`, so the quad is drawn from a client-side array instead.
//
// `glu::Shader` is not ported either, so the file-local `Shader` below stands in for
// it - the same shape the ES 3.1 `state_query.program` port uses.

use std::ffi::CString;

use crate::glu::{ApiCase, ShaderType, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLfloat, GLint, GLsizei, GLuint};
use crate::tcu::{Random, de_string_hash};

/// `getSimpleShaderSource`
fn simple_shader_source(shader_type: ShaderType) -> &'static str {
    match shader_type {
        ShaderType::Vertex => "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n",
        _ => "#version 300 es\nlayout(location = 0) out mediump vec4 o_fragColor;\nvoid main (void)\n{\n    o_fragColor = vec4(0.0);\n}\n",
    }
}

/// `glu::Shader` - one shader name, deleted on drop.
struct Shader<'gl> {
    gl: &'gl glw::Functions,
    shader: GLuint,
}

impl<'gl> Shader<'gl> {
    fn new(gl: &'gl glw::Functions, shader_type: ShaderType) -> Self {
        // SAFETY: a fresh shader name.
        let shader = unsafe { gl.create_shader(shader_type.gl_enum()) };
        Self { gl, shader }
    }

    fn get_shader(&self) -> GLuint {
        self.shader
    }

    /// `glu::Shader::setSources` - `lengths` is `None` for "all null-terminated".
    fn set_sources(&self, sources: &[String], lengths: Option<&[GLint]>) {
        let owned: Vec<CString> = sources.iter().map(|source| CString::new(source.as_str()).expect("no interior nul")).collect();
        let pointers: Vec<*const GLchar> = owned.iter().map(|source| source.as_ptr()).collect();
        // SAFETY: `count` matches both arrays and every pointer is live for the call.
        unsafe {
            match lengths {
                Some(lengths) => self.gl.shader_source(self.shader, pointers.len() as GLsizei, pointers.as_ptr(), lengths.as_ptr()),
                None => self.gl.shader_source(self.shader, pointers.len() as GLsizei, pointers.as_ptr(), std::ptr::null()),
            }
        }
    }

    fn compile(&self) {
        // SAFETY: the shader has source attached.
        unsafe { self.gl.compile_shader(self.shader) };
    }

    fn get_compile_status(&self) -> bool {
        let mut status: GLint = 0;
        // SAFETY: one GLint out for this struct's own name.
        unsafe { self.gl.get_shaderiv(self.shader, glw::GL_COMPILE_STATUS, &raw mut status) };
        status == GLint::from(glw::TRUE)
    }
}

impl Drop for Shader<'_> {
    fn drop(&mut self) {
        // SAFETY: this struct's own name, deleted exactly once.
        unsafe { self.gl.delete_shader(self.shader) };
    }
}

/// `CreateShaderCase`
fn create_shader_case(case: &mut ApiCase<'_>, shader_type: ShaderType) {
    // SAFETY: a legal shader type; the name is deleted below.
    let shader_object = unsafe { case.gl().create_shader(shader_type.gl_enum()) };

    if shader_object == 0 {
        case.fail("glCreateShader returned 0".to_string(), "glCreateShader returned 0");
        return;
    }

    // SAFETY: the name this case just created.
    unsafe { case.gl().delete_shader(shader_object) };
}

/// `CompileShaderCase`
fn compile_shader_case(case: &mut ApiCase<'_>, shader_type: ShaderType) {
    let source = simple_shader_source(shader_type);
    // SAFETY: a legal shader type; the name is deleted below.
    let shader_object = unsafe { case.gl().create_shader(shader_type.gl_enum()) };

    if shader_object == 0 {
        case.fail("glCreateShader returned 0".to_string(), "glCreateShader returned 0");
        return;
    }

    let owned = CString::new(source).expect("no interior nul");
    let pointer: *const GLchar = owned.as_ptr();
    // SAFETY: one live null-terminated string; a null `length` means "null-terminated".
    unsafe {
        case.gl().shader_source(shader_object, 1, &raw const pointer, std::ptr::null());
        case.gl().compile_shader(shader_object);
    }

    let mut compile_status: GLint = -1;
    // SAFETY: one GLint out for a name this case owns.
    unsafe { case.gl().get_shaderiv(shader_object, glw::GL_COMPILE_STATUS, &raw mut compile_status) };
    if compile_status != GLint::from(glw::TRUE) {
        case.fail("Compilation failed".to_string(), "Compilation failed");
    }

    // SAFETY: the name this case created.
    unsafe { case.gl().delete_shader(shader_object) };
}

/// `SimpleProgramCase::compileShaders` + `linkProgram` - returns
/// `(vert_shader, frag_shader, program)`, all owned by the caller.
fn simple_program(case: &mut ApiCase<'_>) -> (GLuint, GLuint, GLuint) {
    let gl = case.gl();
    // SAFETY: two fresh shader names, returned to the caller.
    let (vert_shader, frag_shader) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
        )
    };

    for (shader, source) in [
        (vert_shader, simple_shader_source(ShaderType::Vertex)),
        (frag_shader, simple_shader_source(ShaderType::Fragment)),
    ] {
        let owned = CString::new(source).expect("no interior nul");
        let pointer: *const GLchar = owned.as_ptr();
        // SAFETY: one live null-terminated string for the duration of the call.
        unsafe {
            gl.shader_source(shader, 1, &raw const pointer, std::ptr::null());
            gl.compile_shader(shader);
        }
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, vert_shader);
        gl.attach_shader(program, frag_shader);
    }
    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: as above.
    unsafe { gl.link_program(program) };

    (vert_shader, frag_shader, program)
}

/// `DeleteShaderCase`
fn delete_shader_case(case: &mut ApiCase<'_>) {
    let (vert_shader, frag_shader, program) = simple_program(case);
    let gl = case.gl();
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: names this case owns.
    unsafe {
        gl.delete_shader(vert_shader);
        gl.delete_shader(frag_shader);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // The shaders are still attached to the program, so DELETE_STATUS must be TRUE
    // while the names stay valid.
    for shader in [vert_shader, frag_shader] {
        let mut delete_status: GLint = -1;
        // SAFETY: one GLint out for a name that is still valid (attached).
        unsafe { gl.get_shaderiv(shader, glw::GL_DELETE_STATUS, &raw mut delete_status) };
        if delete_status != GLint::from(glw::TRUE) {
            case.fail("Expected DELETE_STATUS to be TRUE".to_string(), "Expected DELETE_STATUS to be TRUE");
        }
    }

    // SAFETY: the program name this case owns; deleting it releases the shaders.
    unsafe { gl.delete_program(program) };

    // SAFETY: both names are now gone, which is exactly what glIsShader answers on.
    let still_shaders = unsafe { gl.is_shader(vert_shader) != glw::FALSE || gl.is_shader(frag_shader) != glw::FALSE };
    if still_shaders {
        case.fail("Shader was not deleted".to_string(), "Shader was not deleted");
    }
}

/// `LinkVertexFragmentCase`
fn link_vertex_fragment_case(case: &mut ApiCase<'_>) {
    let (vert_shader, frag_shader, program) = simple_program(case);
    let gl = case.gl();
    case.expect_error(glw::GL_NO_ERROR);

    let mut link_status: GLint = -1;
    // SAFETY: one GLint out for a program this case owns.
    unsafe { gl.get_programiv(program, glw::GL_LINK_STATUS, &raw mut link_status) };
    if link_status != GLint::from(glw::TRUE) {
        case.fail(
            "Fail, expected LINK_STATUS to be TRUE.".to_string(),
            "Fail, expected LINK_STATUS to be TRUE.",
        );
    }

    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(vert_shader);
        gl.delete_shader(frag_shader);
        gl.delete_program(program);
    }
}

/// `ShaderSourceSplitCase::generateFullSource`, also
/// `ShaderSourceReplaceCase::generateSecondSource`.
fn full_source(shader_type: ShaderType) -> String {
    let mut out = String::from("#version 300 es\nprecision mediump float;\n");
    if shader_type == ShaderType::Fragment {
        out.push_str("layout(location = 0) out mediump vec4 o_fragColor;\n");
    }
    out.push_str("void main()\n{\n    float variable = 1.0f;\n");
    if shader_type == ShaderType::Vertex {
        out.push_str("    gl_Position = vec4(variable);\n");
    } else if shader_type == ShaderType::Fragment {
        out.push_str("    o_fragColor = vec4(variable);\n");
    }
    out.push_str("}\n");
    out
}

/// `ShaderSourceReplaceCase`
fn shader_source_replace_case(case: &mut ApiCase<'_>, shader_type: ShaderType) {
    let shader = Shader::new(case.gl(), shader_type);

    let first_source = simple_shader_source(shader_type).to_string();
    let second_source = full_source(shader_type);

    case.section("Setting shader source.");
    shader.set_sources(std::slice::from_ref(&first_source), None);
    case.expect_error(glw::GL_NO_ERROR);

    case.section("Replacing shader source.");
    shader.set_sources(std::slice::from_ref(&second_source), None);
    case.expect_error(glw::GL_NO_ERROR);

    // `verifyShaderSourceReplaced` - read the source back and compare.
    let mut source_length: GLint = 0;
    // SAFETY: one GLint out for a shader this case owns.
    unsafe {
        case.gl()
            .get_shaderiv(shader.get_shader(), glw::GL_SHADER_SOURCE_LENGTH, &raw mut source_length)
    };
    case.expect_error(glw::GL_NO_ERROR);

    let mut buffer = vec![0 as GLchar; (source_length + 1) as usize];
    // SAFETY: bufSize is the buffer's own length; a null `length` is allowed.
    unsafe {
        case.gl()
            .get_shader_source(shader.get_shader(), buffer.len() as GLsizei, std::ptr::null_mut(), buffer.as_mut_ptr())
    };

    let bytes: Vec<u8> = buffer.iter().take_while(|b| **b != 0).map(|b| *b as u8).collect();
    let result = String::from_utf8_lossy(&bytes).into_owned();

    if result == first_source {
        case.fail("Fail, source was not replaced.".to_string(), "Shader source nor replaced");
    } else if result != second_source {
        case.fail("Fail, invalid shader source.".to_string(), "Invalid source");
    }
}

/// `sliceSourceString`
fn slice_source_string(input: &str, num_slices: usize, padding_length: usize) -> (Vec<String>, Vec<GLint>) {
    let padding: String = "E".repeat(padding_length);
    let slice_size = input.len() / num_slices;
    let slice_size_remainder = input.len() - (slice_size * num_slices);

    let mut strings = Vec::new();
    let mut lengths = Vec::new();

    for ndx in 0..num_slices {
        strings.push(format!("{}{padding}", &input[ndx * slice_size..(ndx + 1) * slice_size]));
        if padding_length > 0 {
            lengths.push(slice_size as GLint);
        }
    }

    if slice_size_remainder > 0 {
        let last = &input[num_slices * slice_size..];
        strings.push(format!("{last}{padding}"));
        if padding_length > 0 {
            lengths.push(last.len() as GLint);
        }
    }

    (strings, lengths)
}

/// `ShaderSourceSplitCase`
fn shader_source_split_case(
    case: &mut ApiCase<'_>,
    name: &str,
    shader_type: ShaderType,
    num_slices: usize,
    explicit_lengths: bool,
    random_null_term: bool,
) {
    let mut rnd = Random::new(de_string_hash(name) ^ 0x4fb2_337d);

    let padding_length = if explicit_lengths { 10 } else { 0 };
    let (mut strings, mut lengths) = slice_source_string(&full_source(shader_type), num_slices, padding_length);

    if random_null_term {
        // `insertRandomNullTermStrings` - a negative length asks the driver to treat
        // that string as null-terminated, so the padding must be dropped from it.
        let num_inserts = (num_slices >> 2).max(1);
        let mut indices: Vec<usize> = (0..strings.len()).collect();
        rnd.shuffle(&mut indices);

        for &ndx in indices.iter().take(num_inserts) {
            let unpadded_length = lengths[ndx] as usize;
            strings[ndx].truncate(unpadded_length);
            lengths[ndx] = rnd.get_int(-10, -1);
        }
    }

    let shader = Shader::new(case.gl(), shader_type);
    shader.set_sources(&strings, if lengths.is_empty() { None } else { Some(&lengths) });
    shader.compile();

    // `buildProgram` - link against a simple shader of the other stage. Upstream only
    // does this to log the program; nothing is verified about the link.
    {
        let support_type = if shader_type == ShaderType::Fragment { ShaderType::Vertex } else { ShaderType::Fragment };
        let support_shader = Shader::new(case.gl(), support_type);
        support_shader.set_sources(&[simple_shader_source(support_type).to_string()], None);
        support_shader.compile();

        // SAFETY: a fresh program name; both shaders are live for this scope.
        let program = unsafe { case.gl().create_program() };
        // SAFETY: as above.
        unsafe {
            case.gl().attach_shader(program, shader.get_shader());
            case.gl().attach_shader(program, support_shader.get_shader());
            case.gl().link_program(program);
            case.gl().delete_program(program);
        }
    }

    if !shader.get_compile_status() {
        case.fail("Compilation failed.".to_string(), "Compile failed");
    }
}

/// `ConstantShaderGenerator::next` - a fresh random constant every call, so
/// "replace the source" really does change it.
fn constant_shader_source(rnd: &mut Random, shader_type: ShaderType) -> String {
    let value = rnd.get_float_range(0.0, 1.0);
    let output_name = if shader_type == ShaderType::Vertex { "gl_Position" } else { "o_fragColor" };

    let mut out = String::from("#version 300 es\n");
    if shader_type == ShaderType::Fragment {
        out.push_str("layout(location = 0) out mediump vec4 o_fragColor;\n");
    }
    out.push_str(&format!("void main (void)\n{{\n    {output_name} = vec4({value});\n}}\n"));
    out
}

/// `ShaderAllocator` - one shader per stage, each created with a fresh generated
/// source. Upstream's is a `map<ShaderType, glu::Shader*>`; two `Option`s cover the
/// two stages these cases use.
struct ShaderAllocator<'gl> {
    gl: &'gl glw::Functions,
    rnd: Random,
    vertex: Option<Shader<'gl>>,
    fragment: Option<Shader<'gl>>,
}

impl<'gl> ShaderAllocator<'gl> {
    fn new(gl: &'gl glw::Functions, rnd: Random) -> Self {
        Self { gl, rnd, vertex: None, fragment: None }
    }

    fn slot(&mut self, shader_type: ShaderType) -> &mut Option<Shader<'gl>> {
        if shader_type == ShaderType::Vertex { &mut self.vertex } else { &mut self.fragment }
    }

    /// `createShader` - also sets the source, as upstream's does.
    fn create_shader(&mut self, shader_type: ShaderType) -> GLuint {
        let shader = Shader::new(self.gl, shader_type);
        let name = shader.get_shader();
        *self.slot(shader_type) = Some(shader);
        self.set_source(shader_type);
        name
    }

    fn delete_shader(&mut self, shader_type: ShaderType) {
        *self.slot(shader_type) = None;
    }

    fn get(&mut self, shader_type: ShaderType) -> GLuint {
        self.slot(shader_type).as_ref().expect("shader exists").get_shader()
    }

    fn set_source(&mut self, shader_type: ShaderType) {
        let source = constant_shader_source(&mut self.rnd, shader_type);
        self.slot(shader_type).as_ref().expect("shader exists").set_sources(&[source], None);
    }

    fn compile(&mut self, shader_type: ShaderType) {
        self.slot(shader_type).as_ref().expect("shader exists").compile();
    }
}

/// `glu::ProgramInfo`, minus `linkTimeUs` - this port has no link timing, so the
/// "reported link time changed" check upstream makes is dropped.
struct ProgramInfo {
    link_ok: bool,
    info_log: String,
}

fn program_info(gl: &glw::Functions, program: GLuint) -> ProgramInfo {
    let mut link_status: GLint = 0;
    let mut log_length: GLint = 0;
    // SAFETY: two GLints out for a live program name.
    unsafe {
        gl.get_programiv(program, glw::GL_LINK_STATUS, &raw mut link_status);
        gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &raw mut log_length);
    }

    let mut info_log = String::new();
    if log_length > 0 {
        let mut buffer = vec![0 as GLchar; log_length as usize];
        // SAFETY: bufSize is the buffer's own length; a null `length` is allowed.
        unsafe { gl.get_program_info_log(program, buffer.len() as GLsizei, std::ptr::null_mut(), buffer.as_mut_ptr()) };
        let bytes: Vec<u8> = buffer.iter().take_while(|b| **b != 0).map(|b| *b as u8).collect();
        info_log = String::from_utf8_lossy(&bytes).into_owned();
    }

    ProgramInfo { link_ok: link_status == GLint::from(glw::TRUE), info_log }
}

/// What a `ProgramStateCase` subclass does between the two program queries.
#[derive(Clone, Copy)]
enum ProgramStateOp {
    DetachShader,
    ReattachShader,
    DeleteShader,
    ReplaceShader,
    RecompileShader,
    ReplaceSource,
}

/// `ProgramStateCase::test` + each subclass's `executeForProgram`
fn program_state_case(case: &mut ApiCase<'_>, name: &str, shader_type: ShaderType, op: ProgramStateOp) {
    let gl = case.gl();
    let mut shaders = ShaderAllocator::new(gl, Random::new(de_string_hash(name) ^ 0x713d_e0ca));

    // SAFETY: a fresh program name, deleted at the end of this function.
    let program = unsafe { gl.create_program() };

    // `buildProgram`
    let vert_shader = shaders.create_shader(ShaderType::Vertex);
    let frag_shader = shaders.create_shader(ShaderType::Fragment);
    shaders.compile(ShaderType::Vertex);
    shaders.compile(ShaderType::Fragment);
    // SAFETY: both shaders are live and owned by `shaders`.
    unsafe {
        gl.attach_shader(program, vert_shader);
        gl.attach_shader(program, frag_shader);
        gl.link_program(program);
    }

    let reference = program_info(gl, program);
    if !reference.link_ok {
        case.fail("Fail, couldn't link program.".to_string(), "Linking failed");
        // SAFETY: this function's own program name.
        unsafe { gl.delete_program(program) };
        return;
    }

    let case_shader = shaders.get(shader_type);
    match op {
        ProgramStateOp::DetachShader => {
            case.section("Detaching shader");
            // SAFETY: a shader this program has attached.
            unsafe { gl.detach_shader(program, case_shader) };
        }
        ProgramStateOp::ReattachShader => {
            case.section("Reattaching shader");
            // SAFETY: as above; the name stays valid because `shaders` still owns it.
            unsafe {
                gl.detach_shader(program, case_shader);
                gl.attach_shader(program, case_shader);
            }
        }
        ProgramStateOp::DeleteShader => {
            case.section("Deleting shader");
            // SAFETY: as above.
            unsafe { gl.detach_shader(program, case_shader) };
            shaders.delete_shader(shader_type);
        }
        ProgramStateOp::ReplaceShader => {
            case.section("Deleting and replacing shader");
            // SAFETY: as above.
            unsafe { gl.detach_shader(program, case_shader) };
            shaders.delete_shader(shader_type);
            let replacement = shaders.create_shader(shader_type);
            // SAFETY: the replacement is live and owned by `shaders`.
            unsafe { gl.attach_shader(program, replacement) };
        }
        ProgramStateOp::RecompileShader => {
            case.section("Recompiling shader");
            shaders.compile(shader_type);
        }
        ProgramStateOp::ReplaceSource => {
            case.section("Replacing shader source and recompiling");
            shaders.set_source(shader_type);
            shaders.compile(shader_type);
        }
    }

    // `verify` - none of the operations above may change the program's link state.
    let after = program_info(gl, program);
    if !after.link_ok {
        case.fail(
            "Fail, link status may only change as a result of linking or loading a program binary.".to_string(),
            "Link status changed",
        );
    }
    if after.info_log != reference.info_log {
        case.fail("Fail, program infolog changed.".to_string(), "Infolog changed");
    }

    // SAFETY: this function's own program name.
    unsafe { gl.delete_program(program) };
}

/// `ProgramBinary`
struct ProgramBinary {
    format: GLenum,
    data: Vec<u8>,
}

/// `programBinariesEqual`
fn program_binaries_equal(first: &ProgramBinary, second: &ProgramBinary) -> bool {
    first.format == second.format && first.data == second.data
}

/// `ProgramBinaryCase::getBinaryFormats`
fn binary_formats(case: &ApiCase<'_>) -> Vec<GLenum> {
    let gl = case.gl();
    let mut num_formats: GLint = -1;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_NUM_PROGRAM_BINARY_FORMATS, &raw mut num_formats) };

    let mut out: Vec<GLenum> = Vec::new();
    if num_formats > 0 {
        out.resize(num_formats as usize, 0);
        // SAFETY: the buffer holds exactly the reported number of formats; GLenum and
        // GLint are both 32-bit, which is what upstream's own cast relies on.
        unsafe { gl.get_integerv(glw::GL_PROGRAM_BINARY_FORMATS, out.as_mut_ptr().cast::<GLint>()) };
    }
    out
}

/// `ProgramBinaryCase::getProgramBinary`
fn get_program_binary(case: &mut ApiCase<'_>, program: GLuint) -> ProgramBinary {
    let gl = case.gl();
    let mut binary_length: GLint = -1;
    // SAFETY: one GLint out for a live program name.
    unsafe { gl.get_programiv(program, glw::GL_PROGRAM_BINARY_LENGTH, &raw mut binary_length) };

    let mut out = ProgramBinary { format: 0, data: Vec::new() };
    if binary_length > 0 {
        let mut actual_length: GLsizei = 0;
        let mut format: GLenum = 0;
        out.data = vec![0u8; binary_length as usize];
        // SAFETY: bufSize is the buffer's own length; both out params are live locals.
        unsafe {
            gl.get_program_binary(
                program,
                out.data.len() as GLsizei,
                &raw mut actual_length,
                &raw mut format,
                out.data.as_mut_ptr().cast(),
            );
        }
        case.expect_no_error("glGetProgramBinary");

        // upstream's TCU_CHECK - a short write is an internal error there, a fail here.
        if actual_length != binary_length as GLsizei {
            case.fail(
                format!("Fail, expected {binary_length} bytes of program binary, got {actual_length}."),
                "Invalid binary length",
            );
        }

        out.format = format;
    }
    out
}

/// `ProgramBinaryCase::loadProgramBinary`
fn load_program_binary(case: &mut ApiCase<'_>, binary: &ProgramBinary, program: GLuint) {
    let gl = case.gl();
    // SAFETY: the binary blob outlives the call; length is its own byte length.
    unsafe { gl.program_binary(program, binary.format, binary.data.as_ptr().cast(), binary.data.len() as GLsizei) };
    case.expect_no_error("Failed to load program binary.");
}

/// `ProgramBinaryCase::verifyProgramBinary`
fn verify_program_binary(case: &mut ApiCase<'_>, formats: &[GLenum], binary: &ProgramBinary) {
    if !formats.contains(&binary.format) {
        case.fail(
            format!(
                "Program binary format {} is not among the supported formats reported by the platform.",
                binary.format
            ),
            "Invalid format",
        );
    }
}

/// `drawWithProgram` - upstream goes through `glu::draw`; this port has no `drawUtil`,
/// so the quad is drawn from a client-side array, as the other ported ES 3.0 draw
/// cases do.
fn draw_with_program(case: &mut ApiCase<'_>, program: GLuint) {
    let gl = case.gl();
    let position: [GLfloat; 16] = [
        -1.0, -1.0, 0.0, 1.0, //
        -1.0, 1.0, 0.0, 1.0, //
        1.0, -1.0, 0.0, 1.0, //
        1.0, 1.0, 0.0, 1.0,
    ];
    let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    // SAFETY: a live linked program name.
    unsafe { gl.use_program(program) };

    let attrib = CString::new("a_position").expect("no interior nul");
    // SAFETY: one live null-terminated string.
    let location = unsafe { gl.get_attrib_location(program, attrib.as_ptr()) };
    if location >= 0 {
        let index = location as GLuint;
        // SAFETY: both client-side arrays outlive the draw; VAO 0 is bound (the runner's
        // per-case state reset unbinds any VAO the previous case left).
        unsafe {
            gl.enable_vertex_attrib_array(index);
            gl.vertex_attrib_pointer(index, 4, glw::GL_FLOAT, glw::FALSE, 0, position.as_ptr().cast());
            gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, quad_indices.as_ptr().cast());
            gl.disable_vertex_attrib_array(index);
        }
    }

    case.expect_no_error("Draw test quad");
}

/// Build and link a vertex+fragment program from the given sources; returns
/// `(vertShader, fragShader, program)`. Upstream uses `glu::ShaderProgram`.
fn build_vtx_frag_program(case: &mut ApiCase<'_>, vert_src: &str, frag_src: &str) -> (GLuint, GLuint, GLuint) {
    let gl = case.gl();
    // SAFETY: two fresh shader names, returned to the caller.
    let (vert_shader, frag_shader) =
        unsafe { (gl.create_shader(glw::GL_VERTEX_SHADER), gl.create_shader(glw::GL_FRAGMENT_SHADER)) };

    for (shader, source) in [(vert_shader, vert_src), (frag_shader, frag_src)] {
        let owned = CString::new(source).expect("no interior nul");
        let pointer: *const GLchar = owned.as_ptr();
        // SAFETY: one live null-terminated string for the duration of the call.
        unsafe {
            gl.shader_source(shader, 1, &raw const pointer, std::ptr::null());
            gl.compile_shader(shader);
        }
    }

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, vert_shader);
        gl.attach_shader(program, frag_shader);
        gl.link_program(program);
    }

    (vert_shader, frag_shader, program)
}

fn delete_vtx_frag_program(case: &ApiCase<'_>, vert_shader: GLuint, frag_shader: GLuint, program: GLuint) {
    let gl = case.gl();
    // SAFETY: names this file created and has not deleted.
    unsafe {
        gl.delete_shader(vert_shader);
        gl.delete_shader(frag_shader);
        gl.delete_program(program);
    }
}

/// `ProgramBinarySimpleCase::test`
fn program_binary_simple_case(case: &mut ApiCase<'_>) {
    let formats = binary_formats(case);
    if formats.is_empty() {
        case.not_supported("No program binary formats are supported.");
        return;
    }

    let (vert_shader, frag_shader, program) = build_vtx_frag_program(
        case,
        simple_shader_source(ShaderType::Vertex),
        simple_shader_source(ShaderType::Fragment),
    );

    if program_info(case.gl(), program).link_ok {
        let binary = get_program_binary(case, program);
        verify_program_binary(case, &formats, &binary);
    }

    delete_vtx_frag_program(case, vert_shader, frag_shader, program);
}

/// `ProgramBinaryUniformResetCase::getShaderSource`
fn uniform_reset_shader_source(shader_type: ShaderType) -> &'static str {
    match shader_type {
        ShaderType::Vertex => {
            "#version 300 es\n\
             uniform bool u_boolVar;\n\
             uniform highp int u_intVar;\n\
             uniform highp float u_floatVar;\n\n\
             in highp vec4 a_position;\n\n\
             void main (void)\n\
             {\n\
             \x20   gl_Position = a_position;\n\
             }\n"
        }
        _ => {
            "#version 300 es\n\
             uniform bool u_boolVar;\n\
             uniform highp int u_intVar;\n\
             uniform highp float u_floatVar;\n\n\
             layout(location = 0) out mediump vec4 o_fragColor;\n\n\
             void main (void)\n\
             {\n\
             \x20   mediump float refAll = float(u_boolVar) + float(u_intVar) + u_floatVar;\n\
             \x20   o_fragColor = vec4(refAll);\n\
             }\n"
        }
    }
}

fn uniform_location(case: &ApiCase<'_>, program: GLuint, name: &str) -> GLint {
    let owned = CString::new(name).expect("no interior nul");
    // SAFETY: one live null-terminated string.
    unsafe { case.gl().get_uniform_location(program, owned.as_ptr()) }
}

/// `ProgramBinaryUniformResetCase::verifyUniformInt`
fn verify_uniform_int(case: &mut ApiCase<'_>, program: GLuint, name: &str) {
    let location = uniform_location(case, program, name);
    let mut value: GLint = -1;
    // SAFETY: one GLint out for a scalar uniform.
    unsafe { case.gl().get_uniformiv(program, location, &raw mut value) };

    if value != 0 {
        case.fail(format!("Fail, expected zero value for {name}, received: {value}"), "Uniform value not reset");
    }
}

/// `ProgramBinaryUniformResetCase::verifyUniformFloat`
fn verify_uniform_float(case: &mut ApiCase<'_>, program: GLuint, name: &str) {
    let location = uniform_location(case, program, name);
    let mut value: GLfloat = -1.0;
    // SAFETY: one GLfloat out for a scalar uniform.
    unsafe { case.gl().get_uniformfv(program, location, &raw mut value) };

    if value != 0.0 {
        case.fail(format!("Fail, expected zero value for {name}, received: {value}"), "Uniform value not reset");
    }
}

/// `ProgramBinaryUniformResetCase::test`
fn program_binary_uniform_reset_case(case: &mut ApiCase<'_>, name: &str) {
    let formats = binary_formats(case);
    if formats.is_empty() {
        case.not_supported("No program binary formats are supported.");
        return;
    }

    let mut rnd = Random::new(de_string_hash(name) ^ 0xf2b4_8c6a);

    let (vert_shader, frag_shader, program) = build_vtx_frag_program(
        case,
        uniform_reset_shader_source(ShaderType::Vertex),
        uniform_reset_shader_source(ShaderType::Fragment),
    );

    if !program_info(case.gl(), program).link_ok {
        // upstream's TCU_CHECK_MSG - an internal error there, a fail here.
        case.fail("Couldn't build program".to_string(), "Linking failed");
        delete_vtx_frag_program(case, vert_shader, frag_shader, program);
        return;
    }

    let binary = get_program_binary(case, program);
    verify_program_binary(case, &formats, &binary);

    // `setUniformsRandom`
    case.section("Setting uniforms to random non-zero values.");
    {
        let gl = case.gl();
        // SAFETY: a live linked program.
        unsafe { gl.use_program(program) };

        let bool_loc = uniform_location(case, program, "u_boolVar");
        let int_loc = uniform_location(case, program, "u_intVar");
        let float_loc = uniform_location(case, program, "u_floatVar");

        let int_val = rnd.get_int(1, 1000);
        let float_val = rnd.get_float_range(1.0, 1000.0);

        // SAFETY: scalar uniform writes on the program in use.
        unsafe {
            gl.uniform_1i(bool_loc, GLint::from(glw::TRUE));
            gl.uniform_1f(float_loc, float_val);
            gl.uniform_1i(int_loc, int_val);
        }
    }

    case.section("Rendering test image and reloading binary");
    draw_with_program(case, program);
    load_program_binary(case, &binary, program);

    // `verifyUniformsReset`
    case.section("Verifying uniform reset to 0/false.");
    verify_uniform_int(case, program, "u_boolVar");
    verify_uniform_int(case, program, "u_intVar");
    verify_uniform_float(case, program, "u_floatVar");

    delete_vtx_frag_program(case, vert_shader, frag_shader, program);
}

/// `ProgramBinaryPersistenceCase::test` + each subclass's `executeForProgram`. The
/// operations are exactly `ProgramStateCase`'s; only the verification differs - the
/// program binary, not the link status, is what may not change.
fn program_binary_persistence_case(case: &mut ApiCase<'_>, name: &str, shader_type: ShaderType, op: ProgramStateOp) {
    let formats = binary_formats(case);
    if formats.is_empty() {
        case.not_supported("No program binary formats are supported.");
        return;
    }

    let gl = case.gl();
    let mut shaders = ShaderAllocator::new(gl, Random::new(de_string_hash(name) ^ 0x713d_e0ca));

    // SAFETY: a fresh program name, deleted at the end of this function.
    let program = unsafe { gl.create_program() };

    // `buildProgram`
    let vert_shader = shaders.create_shader(ShaderType::Vertex);
    let frag_shader = shaders.create_shader(ShaderType::Fragment);
    shaders.compile(ShaderType::Vertex);
    shaders.compile(ShaderType::Fragment);
    // SAFETY: both shaders are live and owned by `shaders`.
    unsafe {
        gl.attach_shader(program, vert_shader);
        gl.attach_shader(program, frag_shader);
        gl.link_program(program);
    }

    if !program_info(gl, program).link_ok {
        case.fail("Fail, couldn't link program.".to_string(), "Linking failed");
        // SAFETY: this function's own program name.
        unsafe { gl.delete_program(program) };
        return;
    }

    let reference = get_program_binary(case, program);

    let case_shader = shaders.get(shader_type);
    match op {
        ProgramStateOp::DetachShader => {
            case.section("Detaching shader");
            // SAFETY: a shader this program has attached.
            unsafe { gl.detach_shader(program, case_shader) };
        }
        ProgramStateOp::ReattachShader => {
            case.section("Reattaching shader");
            // SAFETY: as above; the name stays valid because `shaders` still owns it.
            unsafe {
                gl.detach_shader(program, case_shader);
                gl.attach_shader(program, case_shader);
            }
        }
        ProgramStateOp::DeleteShader => {
            case.section("Deleting shader");
            // SAFETY: as above.
            unsafe { gl.detach_shader(program, case_shader) };
            shaders.delete_shader(shader_type);
        }
        ProgramStateOp::ReplaceShader => {
            case.section("Deleting and replacing shader");
            // SAFETY: as above.
            unsafe { gl.detach_shader(program, case_shader) };
            shaders.delete_shader(shader_type);
            let replacement = shaders.create_shader(shader_type);
            // SAFETY: the replacement is live and owned by `shaders`.
            unsafe { gl.attach_shader(program, replacement) };
        }
        ProgramStateOp::RecompileShader => {
            case.section("Recompiling shader");
            shaders.compile(shader_type);
        }
        ProgramStateOp::ReplaceSource => {
            case.section("Replacing shader source and recompiling");
            shaders.set_source(shader_type);
            shaders.compile(shader_type);
        }
    }

    // `verify`
    let current = get_program_binary(case, program);
    if !program_binaries_equal(&reference, &current) {
        case.fail(
            "Fail, program binary may only change as a result of linking or loading.".to_string(),
            "Program binary changed",
        );
    }

    // SAFETY: this function's own program name.
    unsafe { gl.delete_program(program) };
}

/// `ShaderApiTests::init`, restricted to the four ported sub-groups.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_api");

    {
        let mut create_delete = TestCaseGroup::new("create_delete");
        add_api_case(&mut create_delete, "create_vertex_shader", |case: &mut ApiCase<'_>| {
            create_shader_case(case, ShaderType::Vertex);
        });
        add_api_case(&mut create_delete, "create_fragment_shader", |case: &mut ApiCase<'_>| {
            create_shader_case(case, ShaderType::Fragment);
        });
        add_api_case(&mut create_delete, "delete_vertex_fragment", delete_shader_case);
        group.add_child(create_delete);
    }

    {
        let mut compile_link = TestCaseGroup::new("compile_link");
        add_api_case(&mut compile_link, "compile_vertex_shader", |case: &mut ApiCase<'_>| {
            compile_shader_case(case, ShaderType::Vertex);
        });
        add_api_case(&mut compile_link, "compile_fragment_shader", |case: &mut ApiCase<'_>| {
            compile_shader_case(case, ShaderType::Fragment);
        });
        add_api_case(&mut compile_link, "link_vertex_fragment", link_vertex_fragment_case);
        group.add_child(compile_link);
    }

    {
        let mut shader_source = TestCaseGroup::new("shader_source");

        for shader_type in [ShaderType::Vertex, ShaderType::Fragment] {
            add_api_case(
                &mut shader_source,
                format!("replace_source_{}", shader_type.as_str()),
                move |case: &mut ApiCase<'_>| shader_source_replace_case(case, shader_type),
            );
        }

        // Upstream's loop nesting, in its order: string-lengths mode, then slice count,
        // then shader type.
        for string_lengths in 0..3 {
            for case_ndx in 1..=3 {
                for shader_type in [ShaderType::Vertex, ShaderType::Fragment] {
                    let num_slices = 1usize << case_ndx;
                    let explicit_lengths = string_lengths != 0;
                    let random_null_term = string_lengths == 2;

                    let lengths_suffix = if random_null_term {
                        "_random_negative_length"
                    } else if explicit_lengths {
                        "_specify_lengths"
                    } else {
                        "_null_terminated"
                    };
                    let type_suffix = if shader_type == ShaderType::Fragment { "_fragment" } else { "_vertex" };
                    let name = format!("split_source_{num_slices}{lengths_suffix}{type_suffix}");

                    add_api_case(&mut shader_source, name.clone(), move |case: &mut ApiCase<'_>| {
                        shader_source_split_case(case, &name, shader_type, num_slices, explicit_lengths, random_null_term);
                    });
                }
            }
        }

        group.add_child(shader_source);
    }

    {
        // `addProgramStateCase` - one case per (operation, shader type), in this order.
        let mut program_state = TestCaseGroup::new("program_state");
        for (op_name, op) in [
            ("detach_shader", ProgramStateOp::DetachShader),
            ("reattach_shader", ProgramStateOp::ReattachShader),
            ("delete_shader", ProgramStateOp::DeleteShader),
            ("replace_shader", ProgramStateOp::ReplaceShader),
            ("recompile_shader", ProgramStateOp::RecompileShader),
            ("replace_source", ProgramStateOp::ReplaceSource),
        ] {
            for shader_type in [ShaderType::Vertex, ShaderType::Fragment] {
                let name = format!("{op_name}_{}", shader_type.as_str());
                add_api_case(&mut program_state, name.clone(), move |case: &mut ApiCase<'_>| {
                    program_state_case(case, &name, shader_type, op);
                });
            }
        }
        group.add_child(program_state);
    }

    {
        let mut program_binary = TestCaseGroup::new("program_binary");

        {
            let mut simple = TestCaseGroup::new("simple");
            add_api_case(&mut simple, "get_program_binary_vertex_fragment", program_binary_simple_case);
            {
                let name = "uniform_reset_on_binary_load";
                add_api_case(&mut simple, name, move |case: &mut ApiCase<'_>| {
                    program_binary_uniform_reset_case(case, name);
                });
            }
            program_binary.add_child(simple);
        }

        {
            // `addProgramBinaryPersistenceCase` - one case per (operation, shader type).
            let mut binary_persistence = TestCaseGroup::new("binary_persistence");
            for (op_name, op) in [
                ("detach_shader", ProgramStateOp::DetachShader),
                ("reattach_shader", ProgramStateOp::ReattachShader),
                ("delete_shader", ProgramStateOp::DeleteShader),
                ("replace_shader", ProgramStateOp::ReplaceShader),
                ("recompile_shader", ProgramStateOp::RecompileShader),
                ("replace_source", ProgramStateOp::ReplaceSource),
            ] {
                for shader_type in [ShaderType::Vertex, ShaderType::Fragment] {
                    let name = format!("{op_name}_{}", shader_type.as_str());
                    add_api_case(&mut binary_persistence, name.clone(), move |case: &mut ApiCase<'_>| {
                        program_binary_persistence_case(case, &name, shader_type, op);
                    });
                }
            }
            program_binary.add_child(binary_persistence);
        }

        group.add_child(program_binary);
    }

    group
}
