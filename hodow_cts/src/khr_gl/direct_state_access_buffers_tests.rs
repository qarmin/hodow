//! The remaining `Buffers` cases of `gl4cDirectStateAccessBuffersTests.cpp` (the others are in `direct_state_access_tests`).

use std::ffi::{CString, c_void};

use super::common_bugs_tests::Shader;
use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome};

fn no_error(gl: &glw::Functions) -> bool {
    // SAFETY: plain state query.
    unsafe { gl.get_error() == glw::GL_NO_ERROR }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Buffers::FunctionalTest`
struct BuffersFunctionalTest;

#[derive(Default)]
struct BuffersFunctionalObjects {
    po: glw::GLuint,
    vao: glw::GLuint,
    bo_in: glw::GLuint,
    bo_out: glw::GLuint,
    attrib_location: Option<glw::GLuint>,
}

impl BuffersFunctionalTest {
    const VERTEX_SHADER: &'static str = "#version 450\n\nin  int data_in;\nout int data_out;\n\nvoid main()\n{\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n\n    data_out = data_in * data_in;\n}\n";
    const FRAGMENT_SHADER: &'static str =
        "#version 450\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(0.0);\n}\n";
    const VERTEX_SHADER_INPUT_NAME: &'static str = "data_in";
    const VERTEX_SHADER_OUTPUT_NAME: &'static str = "data_out";
    const INITIAL_DATA_A: [glw::GLint; 6] = [1, 2, 3, 4, 5, 5];
    const INITIAL_DATA_B: [glw::GLint; 7] = [0, 0, 0, 0, 0, 0, 36];
    const EXPECTED_DATA: [glw::GLint; 7] = [0, 1, 4, 9, 16, 25, 36];

    fn build_program(gl: &glw::Functions, o: &mut BuffersFunctionalObjects) -> Result<(), TestError> {
        let result = (|| -> Result<(), TestError> {
            // SAFETY: plain object creation with a current context.
            o.po = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram call failed.")?;

            let mut shaders = Vec::new();
            for (source, shader_type) in [
                (Self::VERTEX_SHADER, glw::GL_VERTEX_SHADER),
                (Self::FRAGMENT_SHADER, glw::GL_FRAGMENT_SHADER),
            ] {
                let shader = Shader::new(gl, shader_type)?;
                // SAFETY: both objects are alive.
                unsafe { gl.attach_shader(o.po, shader.id) };
                glu::expect_no_error(gl, "glAttachShader call failed.")?;
                shader.source(&[source])?;
                if !shader.compile()? {
                    log::info!("Shader type {shader_type:#x} compilation failed. Shader source code:\n{source}");
                    return Err(TestError::Fail("shader compilation failed".to_string()));
                }
                shaders.push(shader);
            }

            let output_name = CString::new(Self::VERTEX_SHADER_OUTPUT_NAME).expect("no NUL in the name");
            let varyings = [output_name.as_ptr()];
            // SAFETY: one live NUL-terminated name is passed.
            unsafe { gl.transform_feedback_varyings(o.po, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
            glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;
            // SAFETY: the program is alive.
            unsafe { gl.link_program(o.po) };
            glu::expect_no_error(gl, "glLinkProgram call failed.")?;
            let mut status = glw::GL_FALSE as glw::GLint;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_programiv(o.po, glw::GL_LINK_STATUS, &mut status) };
            if status != glw::GL_TRUE as glw::GLint {
                log::info!("Program linking failed.");
                return Err(TestError::Fail("program link failed".to_string()));
            }
            for shader in &shaders {
                // SAFETY: both objects are alive.
                unsafe { gl.detach_shader(o.po, shader.id) };
                glu::expect_no_error(gl, "glDetachShader call failed.")?;
            }
            Ok(())
        })();

        if result.is_err() && o.po != 0 {
            // SAFETY: deletes the program created above.
            unsafe { gl.delete_program(o.po) };
            o.po = 0;
        }
        if o.po == 0 {
            return Err(TestError::Fail("no program".to_string()));
        }
        // SAFETY: plain state change.
        unsafe { gl.use_program(o.po) };
        glu::expect_no_error(gl, "glUseProgram call failed.")
    }

    fn prepare_vertex_array_object(gl: &glw::Functions, o: &mut BuffersFunctionalObjects) -> Result<(), TestError> {
        // SAFETY: the name is written to the live field and then bound.
        unsafe {
            gl.gen_vertex_arrays(1, &mut o.vao);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
            gl.bind_vertex_array(o.vao);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")
        }
    }

    fn prepare_input_buffer(gl: &glw::Functions, o: &mut BuffersFunctionalObjects) -> Result<bool, TestError> {
        let int_size = std::mem::size_of::<glw::GLint>();
        let zero: glw::GLint = 0;
        let one: glw::GLint = 1;

        // SAFETY: each call below works on the buffer created here; pointers refer to live data of the stated sizes.
        unsafe {
            gl.create_buffers(1, &mut o.bo_in);
            if !no_error(gl) {
                log::info!("CreateBuffers has unexpectedly generated an error.");
                return Ok(false);
            }

            gl.named_buffer_storage(
                o.bo_in,
                std::mem::size_of_val(&Self::INITIAL_DATA_A) as glw::GLsizeiptr,
                Self::INITIAL_DATA_A.as_ptr().cast(),
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_PERSISTENT_BIT,
            );
            if !no_error(gl) {
                log::info!("NamedBufferStorage has unexpectedly generated an error.");
                return Ok(false);
            }

            gl.clear_named_buffer_sub_data(
                o.bo_in,
                glw::GL_R8,
                0,
                int_size as glw::GLsizeiptr,
                glw::GL_RED,
                glw::GL_INT,
                (&zero as *const glw::GLint).cast(),
            );
            if !no_error(gl) {
                log::info!("ClearNamedBufferSubData has unexpectedly generated an error.");
                return Ok(false);
            }

            gl.named_buffer_sub_data(
                o.bo_in,
                int_size as glw::GLintptr,
                int_size as glw::GLsizeiptr,
                (&one as *const glw::GLint).cast(),
            );
            if !no_error(gl) {
                log::info!("NamedBufferSubData has unexpectedly generated an error.");
                return Ok(false);
            }

            let p = gl.map_named_buffer(o.bo_in, glw::GL_READ_WRITE) as *mut glw::GLint;
            // Upstream proceeds when the pointer is NULL even if an error was generated; the write is guarded here.
            if !(no_error(gl) || p.is_null()) {
                log::info!("MapNamedBuffer has unexpectedly generated an error.");
                return Ok(false);
            }
            if !p.is_null() {
                p.add(2).write(2);
            }
            gl.unmap_named_buffer(o.bo_in);
            if !no_error(gl) {
                log::info!("UnmapNamedBuffer has unexpectedly generated an error.");
                return Ok(false);
            }

            gl.copy_named_buffer_sub_data(
                o.bo_in,
                o.bo_in,
                (int_size * 3) as glw::GLintptr,
                (int_size * 4) as glw::GLintptr,
                int_size as glw::GLsizeiptr,
            );
            if !no_error(gl) {
                log::info!("CopyNamedBufferSubData has unexpectedly generated an error.");
                return Ok(false);
            }

            let p = gl.map_named_buffer_range(
                o.bo_in,
                (int_size * 3) as glw::GLintptr,
                int_size as glw::GLsizeiptr,
                glw::GL_MAP_READ_BIT
                    | glw::GL_MAP_WRITE_BIT
                    | glw::GL_MAP_PERSISTENT_BIT
                    | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
            );
            if !no_error(gl) {
                log::info!("MapNamedBufferRange has unexpectedly generated an error.");
                return Ok(false);
            }

            if !p.is_null() {
                *p.cast::<glw::GLint>() = 3;
            }

            gl.flush_mapped_named_buffer_range(o.bo_in, 0, int_size as glw::GLsizeiptr);
            if !no_error(gl) {
                gl.unmap_named_buffer(o.bo_in);
                log::info!("FlushMappedNamedBufferRange has unexpectedly generated an error.");
                return Ok(false);
            }

            let mut is_p: *mut c_void = std::ptr::null_mut();
            gl.get_named_buffer_pointerv(o.bo_in, glw::GL_BUFFER_MAP_POINTER, &mut is_p);
            if !no_error(gl) {
                gl.unmap_named_buffer(o.bo_in);
                log::info!("GetNamedBufferPointerv has unexpectedly generated an error.");
                return Ok(false);
            }

            if p != is_p {
                gl.unmap_named_buffer(o.bo_in);
                log::info!("Pointer returned by GetNamedBufferPointerv is not proper.");
                return Ok(false);
            }

            gl.unmap_named_buffer(o.bo_in);
            if !no_error(gl) {
                log::info!("UnmapNamedBuffer has unexpectedly generated an error.");
                return Ok(false);
            }

            let input_name = CString::new(Self::VERTEX_SHADER_INPUT_NAME).expect("no NUL in the name");
            let location = gl.get_attrib_location(o.po, input_name.as_ptr()) as glw::GLuint;
            o.attrib_location = Some(location);
            glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.bo_in);
            glu::expect_no_error(gl, "glBindBuffer call failed.")?;
            gl.vertex_attrib_i_pointer(location, 1, glw::GL_INT, 0, std::ptr::null());
            glu::expect_no_error(gl, "glVertexAttribIPointer call failed.")?;
            gl.enable_vertex_attrib_array(location);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
        }
        Ok(true)
    }

    fn prepare_output_buffer(gl: &glw::Functions, o: &mut BuffersFunctionalObjects) -> Result<bool, TestError> {
        // SAFETY: names are written to live fields; the data pointer refers to a live array of the stated size.
        unsafe {
            gl.gen_buffers(1, &mut o.bo_out);
            if !no_error(gl) {
                log::info!("GenBuffers has unexpectedly generated an error.");
                return Err(TestError::Fail("GenBuffers failed".to_string()));
            }

            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, o.bo_out);
            if !no_error(gl) {
                log::info!("BindBuffer has unexpectedly generated an error.");
                return Err(TestError::Fail("BindBuffer failed".to_string()));
            }

            gl.named_buffer_data(
                o.bo_out,
                std::mem::size_of_val(&Self::INITIAL_DATA_B) as glw::GLsizeiptr,
                Self::INITIAL_DATA_B.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );
            if !no_error(gl) {
                log::info!("NamedBufferData has unexpectedly generated an error.");
                return Ok(false);
            }

            // Intentionally smaller than the output buffer.
            gl.bind_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                o.bo_out,
                0,
                std::mem::size_of_val(&Self::INITIAL_DATA_A) as glw::GLsizeiptr,
            );
            if !no_error(gl) {
                log::info!("BindBufferRange has unexpectedly generated an error.");
                return Err(TestError::Fail("BindBufferRange failed".to_string()));
            }
        }
        Ok(true)
    }

    fn draw(gl: &glw::Functions) -> Result<(), TestError> {
        // SAFETY: draws into the feedback buffer bound by `prepare_output_buffer`.
        unsafe {
            gl.disable(glw::GL_RASTERIZER_DISCARD);
            glu::expect_no_error(gl, "glDisable call failed.")?;
            gl.begin_transform_feedback(glw::GL_POINTS);
            glu::expect_no_error(gl, "glBeginTransformFeedback call failed.")?;
            gl.draw_arrays(glw::GL_POINTS, 0, Self::INITIAL_DATA_A.len() as glw::GLsizei);
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;
            gl.end_transform_feedback();
            glu::expect_no_error(gl, "glEndTransformFeedback call failed.")?;
            gl.enable(glw::GL_RASTERIZER_DISCARD);
            glu::expect_no_error(gl, "glEnable call failed.")
        }
    }

    fn check_array_buffer_immutable_flag(gl: &glw::Functions, o: &BuffersFunctionalObjects) -> bool {
        let mut is_storage_immutable: glw::GLint = -1;
        // SAFETY: writes one integer to the live local.
        unsafe {
            gl.get_named_buffer_parameteriv(o.bo_in, glw::GL_BUFFER_IMMUTABLE_STORAGE, &mut is_storage_immutable)
        };
        if !no_error(gl) {
            log::info!("GetNamedBufferParameteriv has unexpectedly generated an error.");
            return false;
        }
        if is_storage_immutable == -1 {
            log::info!("GetNamedBufferParameteriv has not written the GL_BUFFER_IMMUTABLE_STORAGE value.");
            return false;
        }
        if is_storage_immutable != glw::GL_TRUE as glw::GLint {
            log::info!("GL_BUFFER_IMMUTABLE_STORAGE of a buffer created with NamedBufferStorage is not GL_TRUE.");
            return false;
        }
        true
    }

    fn check_transform_feedback_buffer_size(gl: &glw::Functions, o: &BuffersFunctionalObjects) -> bool {
        let mut size: glw::GLint64 = -1;
        // SAFETY: writes one 64-bit integer to the live local.
        unsafe { gl.get_named_buffer_parameteri_64v(o.bo_out, glw::GL_BUFFER_SIZE, &mut size) };
        if !no_error(gl) {
            log::info!("GetNamedBufferParameteri64v has unexpectedly generated an error.");
            return false;
        }
        if size == -1 {
            log::info!("GetNamedBufferParameteri64v has not written the GL_BUFFER_SIZE value.");
            return false;
        }
        if size != std::mem::size_of_val(&Self::INITIAL_DATA_B) as glw::GLint64 {
            log::info!(
                "GL_BUFFER_SIZE of the transform feedback buffer is {size}, but {} was expected.",
                std::mem::size_of_val(&Self::INITIAL_DATA_B)
            );
            return false;
        }
        true
    }

    fn check_transform_feedback_result(gl: &glw::Functions, o: &BuffersFunctionalObjects) -> bool {
        let mut output_data = [0 as glw::GLint; 7];
        // SAFETY: the array holds the stated number of bytes.
        unsafe {
            gl.get_named_buffer_sub_data(
                o.bo_out,
                0,
                std::mem::size_of_val(&output_data) as glw::GLsizeiptr,
                output_data.as_mut_ptr().cast(),
            )
        };
        if !no_error(gl) {
            log::info!("GetNamedBufferSubData has unexpectedly generated an error.");
            return false;
        }
        for (i, value) in output_data.iter().enumerate() {
            if Self::EXPECTED_DATA[i] != *value {
                log::info!(
                    "Transform feedback result {output_data:?} is not the expected {:?}.",
                    Self::EXPECTED_DATA
                );
                return false;
            }
        }
        true
    }

    fn cleanup(gl: &glw::Functions, o: &mut BuffersFunctionalObjects) {
        // SAFETY: deletes names created by the test.
        unsafe {
            if o.po != 0 {
                gl.use_program(0);
                gl.delete_program(o.po);
                o.po = 0;
            }
            if o.vao != 0 {
                gl.delete_vertex_arrays(1, &o.vao);
                o.vao = 0;
            }
            if let Some(location) = o.attrib_location.take() {
                gl.disable_vertex_attrib_array(location);
            }
            for bo in [&mut o.bo_in, &mut o.bo_out] {
                if *bo != 0 {
                    gl.delete_buffers(1, bo);
                    *bo = 0;
                }
            }
            gl.enable(glw::GL_RASTERIZER_DISCARD);
        }
        clean_errors(gl);
    }
}

impl TestCase for BuffersFunctionalTest {
    fn name(&self) -> &str {
        "buffers_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = BuffersFunctionalObjects::default();

        let outcome = dsa_outcome(|| {
            let entry_points = [
                gl.clear_named_buffer_data.is_some(),
                gl.clear_named_buffer_sub_data.is_some(),
                gl.copy_named_buffer_sub_data.is_some(),
                gl.flush_mapped_named_buffer_range.is_some(),
                gl.get_named_buffer_parameteri_64v.is_some(),
                gl.get_named_buffer_parameteriv.is_some(),
                gl.get_named_buffer_pointerv.is_some(),
                gl.get_named_buffer_sub_data.is_some(),
                gl.map_named_buffer.is_some(),
                gl.map_named_buffer_range.is_some(),
                gl.named_buffer_data.is_some(),
                gl.named_buffer_storage.is_some(),
                gl.named_buffer_sub_data.is_some(),
                gl.unmap_named_buffer.is_some(),
            ];
            if entry_points.contains(&false) {
                return Err(TestError::Fail(
                    "a direct state access entry point is missing".to_string(),
                ));
            }

            let mut is_ok = true;
            Self::build_program(gl, &mut o)?;
            Self::prepare_vertex_array_object(gl, &mut o)?;
            is_ok = is_ok && Self::prepare_input_buffer(gl, &mut o)?;
            is_ok = is_ok && Self::prepare_output_buffer(gl, &mut o)?;
            if is_ok {
                Self::draw(gl)?;
            }
            is_ok = is_ok && Self::check_array_buffer_immutable_flag(gl, &o);
            is_ok = is_ok && Self::check_transform_feedback_buffer_size(gl, &o);
            is_ok = is_ok && Self::check_transform_feedback_result(gl, &o);
            Ok(is_ok)
        });

        Self::cleanup(gl, &mut o);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// A buffer object that is deleted when it goes out of scope (upstream's explicit `deleteBuffers` in the cleanup of each sub-test).
struct TestBuffer<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl<'gl> TestBuffer<'gl> {
    /// `createBuffers` + `NamedBufferStorage` with the checks every sub-test starts with.
    fn with_storage(gl: &'gl glw::Functions, data: &[glw::GLubyte], flags: glw::GLbitfield) -> Result<Self, TestError> {
        let mut buffer = Self { gl, id: 0 };
        // SAFETY: the name is written to the live field; the data pointer refers to a live slice of the stated size.
        unsafe {
            gl.create_buffers(1, &mut buffer.id);
            glu::expect_no_error(gl, "glCreateBuffers failed.")?;
            gl.named_buffer_storage(buffer.id, data.len() as glw::GLsizeiptr, data.as_ptr().cast(), flags);
        }
        glu::expect_no_error(gl, "glNamedBuffeStorage failed.")?;
        Ok(buffer)
    }

    fn map(&self, access: glw::GLenum) -> Result<(), TestError> {
        // SAFETY: plain call on a live buffer; the pointer is not used.
        unsafe { self.gl.map_named_buffer(self.id, access) };
        glu::expect_no_error(self.gl, "glMapNamedBuffer failed.")
    }

    fn map_range(
        &self,
        offset: glw::GLintptr,
        length: glw::GLsizeiptr,
        access: glw::GLbitfield,
    ) -> Result<(), TestError> {
        // SAFETY: plain call on a live buffer; the pointer is not used.
        unsafe { self.gl.map_named_buffer_range(self.id, offset, length, access) };
        glu::expect_no_error(self.gl, "glMapNamedBuffer failed.")
    }

    fn unmap(&self) -> Result<(), TestError> {
        // SAFETY: plain call on a live buffer.
        unsafe { self.gl.unmap_named_buffer(self.id) };
        glu::expect_no_error(self.gl, "glUnmapNamedBuffer failed.")
    }
}

impl Drop for TestBuffer<'_> {
    fn drop(&mut self) {
        if self.id != 0 {
            // SAFETY: deletes a name created by this guard.
            unsafe { self.gl.delete_buffers(1, &self.id) };
        }
    }
}

/// `ErrorsTest::ErrorCheckAndLog`
fn error_check_and_log(
    gl: &glw::Functions,
    function_name: &str,
    expected_error: glw::GLenum,
    when_shall_be_generated: &str,
) -> bool {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    if expected_error != error {
        log::info!(
            "{function_name} {when_shall_be_generated} The error value of {} was observed.",
            glw::error_name(error)
        );
        clean_errors(gl);
        return false;
    }
    true
}

fn not_a_buffer_name(gl: &glw::Functions) -> glw::GLuint {
    let mut name: glw::GLuint = 0;
    loop {
        name += 1;
        // SAFETY: plain query.
        if unsafe { gl.is_buffer(name) } == 0 {
            return name;
        }
    }
}

/// The `std::find` loops: the first value from 1 upwards that is not among `valid` without its last element.
fn first_invalid(valid: &[glw::GLenum]) -> glw::GLenum {
    let searched = &valid[..valid.len() - 1];
    let mut value: glw::GLenum = 0;
    loop {
        value += 1;
        if !searched.contains(&value) {
            return value;
        }
    }
}

static UNUSED_DATA: [glw::GLubyte; 4] = [0; 4];
const UNUSED_SIZE: glw::GLsizeiptr = 4;

const VALID_INTERNAL_FORMATS: [glw::GLenum; 34] = [
    glw::GL_R8,
    glw::GL_R16,
    glw::GL_R16F,
    glw::GL_R32F,
    glw::GL_R8I,
    glw::GL_R16I,
    glw::GL_R32I,
    glw::GL_R8UI,
    glw::GL_R16UI,
    glw::GL_R32UI,
    glw::GL_RG8,
    glw::GL_RG16,
    glw::GL_RG16F,
    glw::GL_RG32F,
    glw::GL_RG8I,
    glw::GL_RG16I,
    glw::GL_RG32I,
    glw::GL_RG8UI,
    glw::GL_RG16UI,
    glw::GL_RG32UI,
    glw::GL_RGB32F,
    glw::GL_RGB32I,
    glw::GL_RGB32UI,
    glw::GL_RGBA8,
    glw::GL_RGBA16,
    glw::GL_RGBA16F,
    glw::GL_RGBA32F,
    glw::GL_RGBA8I,
    glw::GL_RGBA16I,
    glw::GL_RGBA32I,
    glw::GL_RGBA8UI,
    glw::GL_RGBA16UI,
    glw::GL_RGBA32UI,
    glw::GL_NONE,
];

const VALID_FORMATS: [glw::GLenum; 15] = [
    glw::GL_RED,
    glw::GL_RG,
    glw::GL_RGB,
    glw::GL_BGR,
    glw::GL_RGBA,
    glw::GL_BGRA,
    glw::GL_RED_INTEGER,
    glw::GL_RG_INTEGER,
    glw::GL_RGB_INTEGER,
    glw::GL_BGR_INTEGER,
    glw::GL_RGBA_INTEGER,
    glw::GL_BGRA_INTEGER,
    glw::GL_STENCIL_INDEX,
    glw::GL_DEPTH_COMPONENT,
    glw::GL_DEPTH_STENCIL,
];

const MAPPED_UNLESS_PERSISTENT: &str = "if any part of the specified range of the buffer object is mapped with MapBuffer or MapBufferRange, unless it was mapped with the MAP_PERSISTENT_BIT bit set in the MapBufferRange access flags.";
const NOT_A_BUFFER: &str = "if buffer is not the name of an existing buffer object.";

const RW_PERSISTENT: glw::GLbitfield = glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT;

/// `ErrorsTest::TestErrorsOfClearNamedBufferData`
fn test_errors_of_clear_named_buffer_data(gl: &glw::Functions) -> Result<bool, TestError> {
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA[..1], RW_PERSISTENT)?;
    let data = UNUSED_DATA.as_ptr().cast::<c_void>();

    // SAFETY: every call below either fails validation or clears one byte of the live buffer; the data pointer is a live array.
    unsafe {
        gl.clear_named_buffer_data(
            not_a_buffer_name(gl),
            glw::GL_R8,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            data,
        );
        is_ok &= error_check_and_log(gl, "glClearNamedBufferData", glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        gl.clear_named_buffer_data(
            buffer.id,
            first_invalid(&VALID_INTERNAL_FORMATS),
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            data,
        );
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_INVALID_ENUM,
            "if internal format is not one of the valid sized internal formats.",
        );

        buffer.map(glw::GL_READ_ONLY)?;
        gl.clear_named_buffer_data(buffer.id, glw::GL_R8, glw::GL_RED, glw::GL_UNSIGNED_BYTE, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_INVALID_OPERATION,
            MAPPED_UNLESS_PERSISTENT,
        );
        buffer.unmap()?;

        buffer.map_range(0, 1, glw::GL_MAP_READ_BIT)?;
        gl.clear_named_buffer_data(buffer.id, glw::GL_R8, glw::GL_RED, glw::GL_UNSIGNED_BYTE, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_INVALID_OPERATION,
            MAPPED_UNLESS_PERSISTENT,
        );
        buffer.unmap()?;

        buffer.map_range(0, 1, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.clear_named_buffer_data(buffer.id, glw::GL_R8, glw::GL_RED, glw::GL_UNSIGNED_BYTE, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_NO_ERROR,
            "if any part of the specified range of the buffer object is mapped with the MAP_PERSISTENT_BIT bit set.",
        );
        buffer.unmap()?;

        gl.clear_named_buffer_data(
            buffer.id,
            glw::GL_R8,
            first_invalid(&VALID_FORMATS),
            glw::GL_UNSIGNED_BYTE,
            data,
        );
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_INVALID_VALUE,
            "if format is not a valid format.",
        );

        gl.clear_named_buffer_data(buffer.id, glw::GL_R8, glw::GL_RED, first_invalid(&VALID_FORMATS), data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferData",
            glw::GL_INVALID_VALUE,
            "if format is not a valid type.",
        );
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfClearNamedBufferSubData`
fn test_errors_of_clear_named_buffer_sub_data(gl: &glw::Functions) -> Result<bool, TestError> {
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT)?;
    let data = UNUSED_DATA.as_ptr().cast::<c_void>();
    let (rgba, ubyte) = (glw::GL_RGBA, glw::GL_UNSIGNED_BYTE);

    // SAFETY: every call below either fails validation or clears bytes of the live buffer; the data pointer is a live array.
    unsafe {
        gl.clear_named_buffer_sub_data(not_a_buffer_name(gl), glw::GL_R8, 0, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(gl, "glClearNamedBufferSubData", glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        gl.clear_named_buffer_data(buffer.id, first_invalid(&VALID_INTERNAL_FORMATS), rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_ENUM,
            "if internal format is not one of the valid sized internal formats.",
        );

        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_RGBA8, 1, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if offset is not multiples of the number of basic machine units (GLubyte) per-element for the internal format (GL_RGBA) specified by internal format.",
        );

        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_RGBA8, 0, UNUSED_SIZE - 1, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if range is not multiples of the number of basic machine units (GLubyte) per-element for the internal format (GL_RGBA) specified by internal format.",
        );

        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, -1, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if offset or size is negative.",
        );

        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, 0, -UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if offset or size is negative.",
        );

        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, 0, 2 * UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if offset+size is greater than the value of BUFFER_SIZE for the specified buffer object.",
        );

        buffer.map(glw::GL_READ_ONLY)?;
        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, 0, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_OPERATION,
            MAPPED_UNLESS_PERSISTENT,
        );
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT)?;
        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, 0, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_OPERATION,
            MAPPED_UNLESS_PERSISTENT,
        );
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.clear_named_buffer_sub_data(buffer.id, glw::GL_R8, 0, UNUSED_SIZE, rgba, ubyte, data);
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_NO_ERROR,
            "if any part of the specified range of the buffer object is mapped with the MAP_PERSISTENT_BIT bit set.",
        );
        buffer.unmap()?;

        gl.clear_named_buffer_sub_data(
            buffer.id,
            glw::GL_R8,
            0,
            UNUSED_SIZE,
            first_invalid(&VALID_FORMATS),
            ubyte,
            data,
        );
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if format is not a valid format.",
        );

        let mut valid_types = VALID_FORMATS.to_vec();
        valid_types.push(glw::GL_NONE);
        gl.clear_named_buffer_sub_data(
            buffer.id,
            glw::GL_R8,
            0,
            UNUSED_SIZE,
            rgba,
            first_invalid(&valid_types),
            data,
        );
        is_ok &= error_check_and_log(
            gl,
            "glClearNamedBufferSubData",
            glw::GL_INVALID_VALUE,
            "if type is not a valid type.",
        );
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfCopyNamedBufferSubData`
fn test_errors_of_copy_named_buffer_sub_data(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glCopyNamedBufferSubData";
    let mut is_ok = true;
    let buffer_r = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT)?;
    let buffer_w = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT)?;
    let (r, w) = (buffer_r.id, buffer_w.id);
    let not_a_buffer = not_a_buffer_name(gl);

    // SAFETY: every call below either fails validation or copies bytes between live buffers.
    unsafe {
        gl.copy_named_buffer_sub_data(not_a_buffer, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if readBuffer is not the name of an existing buffer object.",
        );
        gl.copy_named_buffer_sub_data(r, not_a_buffer, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if writeBuffer is not the name of an existing buffer object.",
        );
        gl.copy_named_buffer_sub_data(r, w, -1, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if readOffset is negative.");
        gl.copy_named_buffer_sub_data(r, w, 0, -1, UNUSED_SIZE);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if writeOffset is negative.");
        gl.copy_named_buffer_sub_data(r, w, 0, 0, -1);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if size is negative.");
        gl.copy_named_buffer_sub_data(r, w, 0, 0, 2 * UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if readOffset+size is greater than the size of the source buffer object.",
        );
        gl.copy_named_buffer_sub_data(r, w, UNUSED_SIZE / 2, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if readOffset+size is greater than the size of the source buffer object.",
        );
        gl.copy_named_buffer_sub_data(r, w, 0, UNUSED_SIZE / 2, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if writeOffset+size is greater than the size of the destination buffer object.",
        );
        gl.copy_named_buffer_sub_data(w, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if readBuffer and writeBuffer are the same buffer object and the ranges overlap.",
        );

        buffer_r.map(glw::GL_READ_ONLY)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the source buffer object is mapped with MapBuffer.",
        );
        buffer_r.unmap()?;

        buffer_w.map(glw::GL_READ_ONLY)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the destination buffer object is mapped with MapBuffer.",
        );
        buffer_w.unmap()?;

        buffer_r.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the source buffer object is mapped with MapBufferRange without MAP_PERSISTENT_BIT.",
        );
        buffer_r.unmap()?;

        buffer_w.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the destination buffer object is mapped with MapBufferRange without MAP_PERSISTENT_BIT.",
        );
        buffer_w.unmap()?;

        buffer_r.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_NO_ERROR,
            "if the source buffer object is mapped with MAP_PERSISTENT_BIT.",
        );
        buffer_r.unmap()?;

        buffer_w.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.copy_named_buffer_sub_data(r, w, 0, 0, UNUSED_SIZE);
        glu::expect_no_error(gl, "glMapNamedBuffer failed.")?;
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_NO_ERROR,
            "if the destination buffer object is mapped with MAP_PERSISTENT_BIT.",
        );
        buffer_w.unmap()?;
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfCreateBuffers`
fn test_errors_of_create_buffers(gl: &glw::Functions) -> Result<bool, TestError> {
    let mut buffer: glw::GLuint = 0;
    // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
    unsafe { gl.create_buffers(-1, &mut buffer) };
    let is_ok = error_check_and_log(gl, "glCreateBuffers", glw::GL_INVALID_VALUE, "if n is negative.");
    if buffer != 0 {
        // SAFETY: deletes a name the driver wrote despite the error.
        unsafe { gl.delete_buffers(1, &buffer) };
        clean_errors(gl);
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfFlushMappedNamedBufferRange`
fn test_errors_of_flush_mapped_named_buffer_range(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glFlushMappedNamedBufferRange";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
    let flush_explicit = glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT;

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.flush_mapped_named_buffer_range(not_a_buffer_name(gl), 0, 1);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        buffer.map_range(0, UNUSED_SIZE, flush_explicit)?;
        gl.flush_mapped_named_buffer_range(buffer.id, -1, 1);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if offset is negative.");
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, flush_explicit)?;
        gl.flush_mapped_named_buffer_range(buffer.id, 0, -1);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if length is negative.");
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE / 2, flush_explicit)?;
        gl.flush_mapped_named_buffer_range(buffer.id, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+length is greater than the length of the mapped range.",
        );
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, flush_explicit)?;
        gl.flush_mapped_named_buffer_range(buffer.id, 1, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+length is greater than the length of the mapped range.",
        );
        buffer.unmap()?;

        gl.flush_mapped_named_buffer_range(buffer.id, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the buffer object is not mapped.",
        );

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_WRITE_BIT)?;
        gl.flush_mapped_named_buffer_range(buffer.id, 0, UNUSED_SIZE);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the buffer is mapped without MAP_FLUSH_EXPLICIT_BIT.",
        );
        buffer.unmap()?;
    }
    Ok(is_ok)
}

const VALID_BUFFER_PARAMETERS: [glw::GLenum; 10] = [
    glw::GL_BUFFER_ACCESS,
    glw::GL_BUFFER_ACCESS_FLAGS,
    glw::GL_BUFFER_IMMUTABLE_STORAGE,
    glw::GL_BUFFER_MAPPED,
    glw::GL_BUFFER_MAP_LENGTH,
    glw::GL_BUFFER_MAP_OFFSET,
    glw::GL_BUFFER_SIZE,
    glw::GL_BUFFER_STORAGE_FLAGS,
    glw::GL_BUFFER_USAGE,
    glw::GL_NONE,
];

/// `ErrorsTest::TestErrorsOfGetNamedBufferParameter`
fn test_errors_of_get_named_buffer_parameter(gl: &glw::Functions) -> Result<bool, TestError> {
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT)?;

    let mut value: glw::GLint = 0;
    let mut value_64: glw::GLint64 = 0;
    // SAFETY: every call below is expected to fail validation; the pointers refer to live locals.
    unsafe {
        gl.get_named_buffer_parameteriv(not_a_buffer_name(gl), glw::GL_BUFFER_MAPPED, &mut value);
        is_ok &= error_check_and_log(
            gl,
            "glGetNamedBufferParameteriv",
            glw::GL_INVALID_OPERATION,
            NOT_A_BUFFER,
        );

        gl.get_named_buffer_parameteri_64v(not_a_buffer_name(gl), glw::GL_BUFFER_MAPPED, &mut value_64);
        is_ok &= error_check_and_log(
            gl,
            "glGetNamedBufferParameteri64v",
            glw::GL_INVALID_OPERATION,
            NOT_A_BUFFER,
        );

        gl.get_named_buffer_parameteriv(buffer.id, first_invalid(&VALID_BUFFER_PARAMETERS), &mut value);
        is_ok &= error_check_and_log(
            gl,
            "glGetNamedBufferParameteriv",
            glw::GL_INVALID_ENUM,
            "if pname is not one of the accepted values.",
        );

        gl.get_named_buffer_parameteri_64v(buffer.id, first_invalid(&VALID_BUFFER_PARAMETERS), &mut value_64);
        is_ok &= error_check_and_log(
            gl,
            "glGetNamedBufferParameteri64v",
            glw::GL_INVALID_ENUM,
            "if pname is not one of the accepted values.",
        );
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfGetNamedBufferPointerv`
fn test_errors_of_get_named_buffer_pointerv(gl: &glw::Functions) -> Result<bool, TestError> {
    let _buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
    let mut pointer: *mut c_void = std::ptr::null_mut();
    // SAFETY: the call is expected to fail validation; the pointer refers to a live local.
    unsafe { gl.get_named_buffer_pointerv(not_a_buffer_name(gl), glw::GL_BUFFER_MAP_POINTER, &mut pointer) };
    Ok(error_check_and_log(
        gl,
        "glGetNamedBufferPointerv",
        glw::GL_INVALID_OPERATION,
        NOT_A_BUFFER,
    ))
}

/// `ErrorsTest::TestErrorsOfGetNamedBufferSubData`
fn test_errors_of_get_named_buffer_sub_data(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glGetNamedBufferSubData";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
    let mut query = [0 as glw::GLubyte; 4];
    let out = query.as_mut_ptr().cast::<c_void>();

    // SAFETY: every call below either fails validation or writes at most four bytes to the live array.
    unsafe {
        gl.get_named_buffer_sub_data(not_a_buffer_name(gl), 0, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);
        gl.get_named_buffer_sub_data(buffer.id, -1, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if offset is negative.");
        gl.get_named_buffer_sub_data(buffer.id, 0, -1, out);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if size is negative.");
        gl.get_named_buffer_sub_data(buffer.id, 0, 2 * UNUSED_SIZE, out);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+size is greater than the value of BUFFER_SIZE.",
        );
        gl.get_named_buffer_sub_data(buffer.id, UNUSED_SIZE / 2, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+size is greater than the value of BUFFER_SIZE.",
        );
        gl.get_named_buffer_sub_data(buffer.id, UNUSED_SIZE + 1, 0, out);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset is greater than the value of BUFFER_SIZE.",
        );

        buffer.map(glw::GL_WRITE_ONLY)?;
        gl.get_named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, MAPPED_UNLESS_PERSISTENT);
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_WRITE_BIT)?;
        gl.get_named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, MAPPED_UNLESS_PERSISTENT);
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_WRITE_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.get_named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, out);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_NO_ERROR,
            "if the range is mapped with the MAP_PERSISTENT_BIT bit set.",
        );
        buffer.unmap()?;
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfMapNamedBuffer`
fn test_errors_of_map_named_buffer(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glMapNamedBuffer";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;

    // SAFETY: every call below is expected to fail validation; a mapping that unexpectedly succeeds is unmapped.
    unsafe {
        gl.map_named_buffer(not_a_buffer_name(gl), glw::GL_READ_ONLY);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        let valid_access_flags = [glw::GL_READ_ONLY, glw::GL_WRITE_ONLY, glw::GL_READ_WRITE, glw::GL_NONE];
        let mapped_data = gl.map_named_buffer(buffer.id, first_invalid(&valid_access_flags));
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_ENUM,
            "if access is not READ_ONLY, WRITE_ONLY, or READ_WRITE.",
        );
        if !mapped_data.is_null() {
            gl.unmap_named_buffer(buffer.id);
            clean_errors(gl);
        }

        buffer.map(glw::GL_READ_ONLY)?;
        let subsequent_mapped_data = gl.map_named_buffer(buffer.id, glw::GL_READ_ONLY);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the buffer object is in a mapped state.",
        );
        gl.unmap_named_buffer(buffer.id);
        if !subsequent_mapped_data.is_null() {
            log::info!("glMapNamedBuffer called on mapped buffer returned non-NULL pointer when error shall occure.");
            return Err(TestError::Fail("non-NULL pointer".to_string()));
        }
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfMapNamedBufferRange`
fn test_errors_of_map_named_buffer_range(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glMapNamedBufferRange";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT)?;
    let read = glw::GL_MAP_READ_BIT;

    // SAFETY: every call below is expected to fail validation; a mapping that unexpectedly succeeds is unmapped.
    unsafe {
        let unmap_if_mapped = |mapped_data: *mut c_void| {
            if !mapped_data.is_null() {
                gl.unmap_named_buffer(buffer.id);
                clean_errors(gl);
            }
        };

        gl.map_named_buffer_range(not_a_buffer_name(gl), 0, UNUSED_SIZE, read);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        let mapped_data = gl.map_named_buffer_range(buffer.id, -1, UNUSED_SIZE, read);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if offset is negative.");
        unmap_if_mapped(mapped_data);

        let mapped_data = gl.map_named_buffer_range(buffer.id, 0, -1, read);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if length is negative.");
        unmap_if_mapped(mapped_data);

        let mapped_data = gl.map_named_buffer_range(buffer.id, 0, UNUSED_SIZE * 2, read);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+length is greater than the value of BUFFER_SIZE.",
        );
        unmap_if_mapped(mapped_data);

        let mapped_data = gl.map_named_buffer_range(buffer.id, UNUSED_SIZE / 2, UNUSED_SIZE, read);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+length is greater than the value of BUFFER_SIZE.",
        );
        unmap_if_mapped(mapped_data);

        let mapped_data = gl.map_named_buffer_range(buffer.id, 0, 0, read);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, "if length is zero.");
        unmap_if_mapped(mapped_data);

        buffer.map_range(0, UNUSED_SIZE, read)?;
        let subsequent_mapped_data = gl.map_named_buffer_range(buffer.id, 0, UNUSED_SIZE, read);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the buffer object is in a mapped state.",
        );
        gl.unmap_named_buffer(buffer.id);
        if !subsequent_mapped_data.is_null() {
            log::info!(
                "glMapNamedBufferRange called on mapped buffer returned non-NULL pointer when error shall occure."
            );
            return Err(TestError::Fail("non-NULL pointer".to_string()));
        }

        let mapped_data = gl.map_named_buffer_range(buffer.id, 0, UNUSED_SIZE, 0);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if neither MAP_READ_BIT nor MAP_WRITE_BIT is set.",
        );
        unmap_if_mapped(mapped_data);

        for (flag, log_message) in [
            (
                glw::GL_MAP_INVALIDATE_RANGE_BIT,
                "if MAP_READ_BIT is set and MAP_INVALIDATE_RANGE_BIT is set.",
            ),
            (
                glw::GL_MAP_INVALIDATE_BUFFER_BIT,
                "if MAP_READ_BIT is set and MAP_INVALIDATE_BUFFER_BIT is set.",
            ),
            (
                glw::GL_MAP_UNSYNCHRONIZED_BIT,
                "if MAP_READ_BIT is set and MAP_UNSYNCHRONIZED_BIT is set.",
            ),
        ] {
            let mapped_data = gl.map_named_buffer_range(buffer.id, 0, UNUSED_SIZE, read | flag);
            is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, log_message);
            unmap_if_mapped(mapped_data);
        }

        let mapped_data = gl.map_named_buffer_range(buffer.id, 0, UNUSED_SIZE, read | glw::GL_MAP_FLUSH_EXPLICIT_BIT);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if MAP_FLUSH_EXPLICIT_BIT is set and MAP_WRITE_BIT is not set.",
        );
        unmap_if_mapped(mapped_data);

        let write = glw::GL_MAP_WRITE_BIT;
        let persistent = glw::GL_MAP_PERSISTENT_BIT;
        let cases = [
            (
                write,
                read,
                "if MAP_READ_BIT is set and the buffer was created without MAP_READ_BIT.",
            ),
            (
                read,
                write,
                "if MAP_WRITE_BIT is set and the buffer was created without MAP_WRITE_BIT.",
            ),
            (
                write,
                write | persistent,
                "if MAP_PERSISTENT_BIT is set and the buffer was created without MAP_PERSISTENT_BIT.",
            ),
            (
                write | persistent,
                write | persistent | glw::GL_MAP_COHERENT_BIT,
                "if MAP_COHERENT_BIT is set and the buffer was created without MAP_COHERENT_BIT.",
            ),
        ];
        for (buffer_flags, mapping_flags, log_message) in cases {
            let buffer_special_flags = TestBuffer::with_storage(gl, &UNUSED_DATA, buffer_flags)?;
            let mapped_data = gl.map_named_buffer_range(buffer_special_flags.id, 0, UNUSED_SIZE, mapping_flags);
            is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, log_message);
            // Upstream unmaps `buffer` here, not the special-flags buffer.
            unmap_if_mapped(mapped_data);
        }
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfNamedBufferData`
fn test_errors_of_named_buffer_data(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glNamedBufferData";
    let mut is_ok = true;
    let buffer = create_buffer(gl)?;
    let immutable_buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_READ_BIT)?;
    let data = UNUSED_DATA.as_ptr().cast::<c_void>();

    // SAFETY: every call below is expected to fail validation; the data pointer is a live array.
    unsafe {
        gl.named_buffer_data(not_a_buffer_name(gl), UNUSED_SIZE, data, glw::GL_DYNAMIC_COPY);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        let valid_usages = [
            glw::GL_STREAM_DRAW,
            glw::GL_STREAM_READ,
            glw::GL_STREAM_COPY,
            glw::GL_STATIC_DRAW,
            glw::GL_STATIC_READ,
            glw::GL_STATIC_COPY,
            glw::GL_DYNAMIC_DRAW,
            glw::GL_DYNAMIC_READ,
            glw::GL_DYNAMIC_COPY,
            glw::GL_NONE,
        ];
        gl.named_buffer_data(buffer.id, UNUSED_SIZE, data, first_invalid(&valid_usages));
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_ENUM,
            "if usage is not STREAM_DRAW, STREAM_READ, STREAM_COPY, STATIC_DRAW, STATIC_READ, STATIC_COPY, DYNAMIC_DRAW, DYNAMIC_READ, or DYNAMIC_COPY.",
        );

        gl.named_buffer_data(buffer.id, -1, data, glw::GL_DYNAMIC_COPY);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if size is negative.");

        gl.named_buffer_data(immutable_buffer.id, UNUSED_SIZE / 2, data, glw::GL_DYNAMIC_COPY);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the BUFFER_IMMUTABLE_STORAGE flag of the buffer object is TRUE.",
        );
    }
    Ok(is_ok)
}

fn create_buffer(gl: &glw::Functions) -> Result<TestBuffer<'_>, TestError> {
    let mut id: glw::GLuint = 0;
    // SAFETY: the name is written to the live local.
    unsafe { gl.create_buffers(1, &mut id) };
    let buffer = TestBuffer { gl, id };
    glu::expect_no_error(gl, "glCreateBuffers failed.")?;
    Ok(buffer)
}

/// `ErrorsTest::TestErrorsOfNamedBufferStorage`
fn test_errors_of_named_buffer_storage(context: &Context) -> Result<bool, TestError> {
    const NAME: &str = "glNamedBufferStorage";
    let gl = context.gl();
    let mut is_ok = true;
    let data = UNUSED_DATA.as_ptr().cast::<c_void>();

    let create = || create_buffer(gl);

    // SAFETY: every call below is expected to fail validation; the data pointer is a live array.
    unsafe {
        gl.named_buffer_storage(not_a_buffer_name(gl), UNUSED_SIZE, data, glw::GL_MAP_WRITE_BIT);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);

        {
            let buffer = create()?;
            gl.named_buffer_storage(buffer.id, -1, data, glw::GL_DYNAMIC_COPY);
            is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if size is negative.");
            gl.named_buffer_storage(buffer.id, 0, data, glw::GL_DYNAMIC_COPY);
            is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if size zero.");
            drop(buffer);
            glu::expect_no_error(gl, "glDeleteBuffers failed.")?;
        }

        {
            let mut valid_bits: glw::GLuint = glw::GL_DYNAMIC_STORAGE_BIT
                | glw::GL_MAP_READ_BIT
                | glw::GL_MAP_WRITE_BIT
                | glw::GL_MAP_PERSISTENT_BIT
                | glw::GL_MAP_COHERENT_BIT
                | glw::GL_CLIENT_STORAGE_BIT;
            if context.context_info.is_extension_supported("GL_ARB_sparse_buffer") {
                valid_bits |= glw::GL_SPARSE_STORAGE_BIT_ARB;
            }
            if context.context_info.is_extension_supported("GL_NV_gpu_multicast")
                || context
                    .context_info
                    .is_extension_supported("GL_NVX_linked_gpu_multicast")
            {
                valid_bits |= glw::GL_PER_GPU_STORAGE_BIT_NV;
            }
            if context
                .context_info
                .is_extension_supported("GL_NVX_cross_process_interop")
            {
                valid_bits |= glw::GL_EXTERNAL_STORAGE_BIT_NVX;
            }

            let invalid_bits = !valid_bits;
            for i in 0..glw::GLuint::BITS {
                let possibly_invalid_bit: glw::GLuint = 1 << i;
                if invalid_bits & possibly_invalid_bit != 0 {
                    let buffer = create()?;
                    gl.named_buffer_storage(buffer.id, UNUSED_SIZE, data, possibly_invalid_bit);
                    is_ok &= error_check_and_log(
                        gl,
                        NAME,
                        glw::GL_INVALID_VALUE,
                        "if flags contains any unsupported bit.",
                    );
                    drop(buffer);
                    glu::expect_no_error(gl, "glDeleteBuffers failed.")?;
                }
            }
        }

        {
            let buffer = create()?;
            gl.named_buffer_storage(buffer.id, UNUSED_SIZE, data, glw::GL_MAP_PERSISTENT_BIT);
            is_ok &= error_check_and_log(
                gl,
                NAME,
                glw::GL_INVALID_VALUE,
                "if flags contains MAP_PERSISTENT_BIT but does not contain at least one of MAP_READ_BIT or MAP_WRITE_BIT.",
            );
            drop(buffer);
            glu::expect_no_error(gl, "glDeleteBuffers failed.")?;
        }

        {
            let buffer = create()?;
            gl.named_buffer_storage(
                buffer.id,
                UNUSED_SIZE,
                data,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT | glw::GL_MAP_COHERENT_BIT,
            );
            is_ok &= error_check_and_log(
                gl,
                NAME,
                glw::GL_INVALID_VALUE,
                "if flags contains MAP_COHERENT_BIT, and does not also contain MAP_PERSISTENT_BIT.",
            );
            drop(buffer);
            glu::expect_no_error(gl, "glDeleteBuffers failed.")?;
        }
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfNamedBufferSubData`
fn test_errors_of_named_buffer_sub_data(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glNamedBufferSubData";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT | glw::GL_DYNAMIC_STORAGE_BIT)?;
    let immutable_storage_buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, glw::GL_MAP_READ_BIT)?;
    let data = UNUSED_DATA.as_ptr().cast::<c_void>();

    // SAFETY: every call below either fails validation or writes bytes to live buffers; the data pointer is a live array.
    unsafe {
        gl.named_buffer_sub_data(not_a_buffer_name(gl), 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);
        gl.named_buffer_sub_data(buffer.id, -1, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if offset or size is negative.");
        gl.named_buffer_sub_data(buffer.id, 0, -1, data);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_VALUE, "if offset or size is negative.");
        gl.named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE * 2, data);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+size is greater than the value of BUFFER_SIZE.",
        );
        gl.named_buffer_sub_data(buffer.id, UNUSED_SIZE / 2, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_VALUE,
            "if offset+size is greater than the value of BUFFER_SIZE.",
        );

        buffer.map(glw::GL_READ_ONLY)?;
        gl.named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, MAPPED_UNLESS_PERSISTENT);
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT)?;
        gl.named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, MAPPED_UNLESS_PERSISTENT);
        buffer.unmap()?;

        buffer.map_range(0, UNUSED_SIZE, glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT)?;
        gl.named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_NO_ERROR,
            "if the range is mapped with the MAP_PERSISTENT_BIT bit set.",
        );
        buffer.unmap()?;

        gl.named_buffer_sub_data(immutable_storage_buffer.id, 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the value of BUFFER_IMMUTABLE_STORAGE is TRUE and the value of BUFFER_STORAGE_FLAGS for the buffer does not have the DYNAMIC_STORAGE_BIT set.",
        );
        gl.named_buffer_sub_data(buffer.id, 0, UNUSED_SIZE, data);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_NO_ERROR,
            "if the value of BUFFER_IMMUTABLE_STORAGE is TRUE and the value of BUFFER_STORAGE_FLAGS for the buffer has the DYNAMIC_STORAGE_BIT set.",
        );
    }
    Ok(is_ok)
}

/// `ErrorsTest::TestErrorsOfUnmapNamedBuffer`
fn test_errors_of_unmap_named_buffer(gl: &glw::Functions) -> Result<bool, TestError> {
    const NAME: &str = "glUnmapNamedBuffer";
    let mut is_ok = true;
    let buffer = TestBuffer::with_storage(gl, &UNUSED_DATA, RW_PERSISTENT | glw::GL_DYNAMIC_STORAGE_BIT)?;

    // SAFETY: both calls are expected to fail validation.
    unsafe {
        gl.unmap_named_buffer(not_a_buffer_name(gl));
        is_ok &= error_check_and_log(gl, NAME, glw::GL_INVALID_OPERATION, NOT_A_BUFFER);
        gl.unmap_named_buffer(buffer.id);
        is_ok &= error_check_and_log(
            gl,
            NAME,
            glw::GL_INVALID_OPERATION,
            "if the buffer object is not in a mapped state.",
        );
    }
    Ok(is_ok)
}

/// `Buffers::ErrorsTest`
struct BuffersErrorsTest;

impl TestCase for BuffersErrorsTest {
    fn name(&self) -> &str {
        "buffers_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let outcome = dsa_outcome(|| {
            let entry_points = [
                gl.clear_named_buffer_data.is_some(),
                gl.clear_named_buffer_sub_data.is_some(),
                gl.copy_named_buffer_sub_data.is_some(),
                gl.flush_mapped_named_buffer_range.is_some(),
                gl.get_named_buffer_parameteri_64v.is_some(),
                gl.get_named_buffer_parameteriv.is_some(),
                gl.get_named_buffer_pointerv.is_some(),
                gl.get_named_buffer_sub_data.is_some(),
                gl.map_named_buffer.is_some(),
                gl.map_named_buffer_range.is_some(),
                gl.named_buffer_data.is_some(),
                gl.named_buffer_storage.is_some(),
                gl.named_buffer_sub_data.is_some(),
                gl.unmap_named_buffer.is_some(),
            ];
            if entry_points.contains(&false) {
                return Err(TestError::Fail(
                    "a direct state access entry point is missing".to_string(),
                ));
            }

            let mut is_ok = true;
            let tests: [&dyn Fn() -> Result<bool, TestError>; 14] = [
                &|| test_errors_of_clear_named_buffer_data(gl),
                &|| test_errors_of_clear_named_buffer_sub_data(gl),
                &|| test_errors_of_copy_named_buffer_sub_data(gl),
                &|| test_errors_of_create_buffers(gl),
                &|| test_errors_of_flush_mapped_named_buffer_range(gl),
                &|| test_errors_of_get_named_buffer_parameter(gl),
                &|| test_errors_of_get_named_buffer_pointerv(gl),
                &|| test_errors_of_get_named_buffer_sub_data(gl),
                &|| test_errors_of_map_named_buffer(gl),
                &|| test_errors_of_map_named_buffer_range(gl),
                &|| test_errors_of_named_buffer_data(gl),
                &|| test_errors_of_named_buffer_storage(context),
                &|| test_errors_of_named_buffer_sub_data(gl),
                &|| test_errors_of_unmap_named_buffer(gl),
            ];
            for test in tests {
                is_ok &= test()?;
                clean_errors(gl);
            }
            Ok(is_ok)
        });

        clean_errors(gl);
        outcome
    }
}

/// The remaining `Buffers` cases, to be registered after `buffers_defaults`.
pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(BuffersErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(BuffersFunctionalTest) as Box<dyn TestCase>);
}
