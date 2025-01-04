// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeTestShared.cpp / .hpp
//   modules/gles31/functional/es31fDebugTests.cpp  (BaseCase, CallbackErrorCase,
//                                                   LogErrorCase, GetErrorCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream splits this across a `NegativeTestContext` (what a negative test function is
// handed) and three `ErrorCase` subclasses that differ only in how they check that the
// error was reported - `glGetError`, a `GL_KHR_debug` callback, or the debug message
// log. The subclass hierarchy is a `Reporting` enum here, since the only virtual that
// ever differs is `expectError`.
//
// The same ~500 test functions run under all three, which is the whole point of the
// group: an error the driver raises but never reports through `GL_KHR_debug` is a real
// defect that `glGetError` alone cannot see.

/// The `-1` these cases pass wherever an enum is expected; see `glu::BAD_ENUM`.
pub use crate::glu::BAD_ENUM;
use crate::glu::{Context, ShaderType, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult};

/// `TestFunc` - one negative test function.
pub type TestFunc = fn(&mut NegativeTestContext<'_>) -> Result<(), TestError>;

/// `NegativeTestShared::FunctionContainer`
pub struct FunctionContainer {
    pub function: TestFunc,
    pub name: &'static str,
}

/// Which of upstream's three `ErrorCase` subclasses is checking the error.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Reporting {
    /// `GetErrorCase` - `glGetError` must answer with the expected code.
    GetError,
    /// `CallbackErrorCase` - a `GL_KHR_debug` callback must have fired.
    Callback,
    /// `LogErrorCase` - the debug message log must hold the message.
    Log,
    /// `FilterCase` - nothing is checked per call. `FilterCase::expectMessage` is a
    /// no-op override (and `BaseCase::expectError` only ever reaches it), because those
    /// cases care about *how many* of each message arrived over a whole run, not about
    /// any single one. The messages are collected by the case's own callback instead.
    Filter,
    /// `AsyncCase` - counts messages the same way `Filter` does, but its
    /// `expectMessage` is not quite a no-op: the non-callback variant drains the debug
    /// message log there ("a good time to clean up the queue as this should be called
    /// after most messages are generated"). The draining is supplied by the case as
    /// `expect_message_hook`, so this module stays unaware of its counters.
    Async,
}

/// The message a callback or the log reported, in the shape both harnesses check.
#[derive(Default, Clone)]
struct MessageData {
    source: GLenum,
    ty: GLenum,
    message: String,
}

/// `NegativeTestShared::NegativeTestContext`
pub struct NegativeTestContext<'a> {
    context: &'a Context,
    reporting: Reporting,
    results: ResultCollector,
    /// `CallbackErrorCase::m_lastMessage`, filled by the callback below.
    last_message: Box<MessageData>,
    /// `AsyncCase::expectMessage`'s body - see `Reporting::Async`. Set only by that
    /// case, and only for its log-fetching half.
    expect_message_hook: Option<&'a dyn Fn()>,
}

/// `callbackHandle` - the `extern "C"` trampoline `glDebugMessageCallback` is given.
///
/// # Safety
/// `user_param` must be the `*mut MessageData` handed to `glDebugMessageCallback`, and
/// the driver must keep its own contract about `message`/`length`.
unsafe extern "C" fn debug_callback(
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
    length: glw::GLsizei,
    message: *const glw::GLchar,
    user_param: *const std::ffi::c_void,
) {
    let _ = (id, severity);

    // SAFETY: the caller's contract - this is the pointer passed to
    // `glDebugMessageCallback`, and it outlives every call the driver can make.
    let dst = unsafe { &mut *(user_param as *mut MessageData) };
    // SAFETY: the driver promises `length` bytes at `message`, or a null-terminated
    // string when `length` is negative.
    let text = unsafe {
        if message.is_null() {
            String::new()
        } else if length < 0 {
            std::ffi::CStr::from_ptr(message).to_string_lossy().into_owned()
        } else {
            String::from_utf8_lossy(std::slice::from_raw_parts(message.cast::<u8>(), length as usize)).into_owned()
        }
    };

    *dst = MessageData {
        source,
        ty,
        message: text,
    };
}

impl<'a> NegativeTestContext<'a> {
    /// Public because `FilterCase` builds one per `genMessages` run of its own, the way
    /// upstream builds a `DebugMessageTestContext` there.
    pub fn new(context: &'a Context, reporting: Reporting) -> Self {
        Self {
            context,
            reporting,
            results: ResultCollector::new("// ERROR: "),
            last_message: Box::new(MessageData::default()),
            expect_message_hook: None,
        }
    }

    /// Install `AsyncCase::expectMessage`'s log-draining body. Separate from `new` so
    /// the hook only has to outlive the run, not the render context.
    pub fn set_expect_message_hook(&mut self, hook: &'a dyn Fn()) {
        self.expect_message_hook = Some(hook);
    }

    pub fn gl(&self) -> &'a glw::Functions {
        self.context.gl()
    }

    /// `NegativeTestContext::getRenderContext`, in the shape this port hands around.
    pub fn context(&self) -> &'a Context {
        self.context
    }

    /// Upstream passes the *case's* `tcu::ResultCollector&` into the context; here the
    /// context owns one and the case folds it back when the run is over.
    pub fn results(&self) -> &ResultCollector {
        &self.results
    }

    /// `NegativeTestContext::fail`
    pub fn fail(&mut self, msg: impl Into<String>) {
        self.results.add_result(TestResult::Fail, msg.into());
    }

    /// `NegativeTestContext::getInteger`
    pub fn get_integer(&self, pname: GLenum) -> GLint {
        let mut retval = 0;
        // SAFETY: one GLint out.
        unsafe { self.gl().get_integerv(pname, &mut retval) };
        retval
    }

    /// `NegativeTestContext::beginSection` - the spec sentence the following calls are
    /// checking. Logged at debug: a passing run would otherwise print a paragraph of
    /// specification text per call.
    pub fn begin_section(&self, description: &str) {
        log::debug!("{description}");
    }

    /// `NegativeTestContext::endSection`
    pub fn end_section(&self) {}

    /// `NegativeTestContext::isExtensionSupported`
    pub fn is_extension_supported(&self, extension: &str) -> bool {
        self.context.context_info.is_extension_supported(extension)
    }

    /// `contextSupports(ctx.getRenderContext().getType(), glu::ApiType::es(major, minor))`
    pub fn context_supports(&self, major: i32, minor: i32) -> bool {
        self.context.context_type().supports(major, minor)
    }

    /// `NegativeTestContext::isShaderSupported`
    pub fn is_shader_supported(&self, shader_type: ShaderType) -> bool {
        if self.context_supports(3, 2) {
            return true;
        }

        match shader_type {
            ShaderType::Geometry => self.is_extension_supported("GL_EXT_geometry_shader"),
            ShaderType::TessControl | ShaderType::TessEvaluation => {
                self.is_extension_supported("GL_EXT_tessellation_shader")
            }
            _ => true,
        }
    }

    /// `${GLSL_VERSION_DECL}` - 3.2 where the context has it, 3.1 otherwise.
    ///
    /// Every negative shader test picks its version this way, because the features they
    /// probe are core in ES 3.2 and an extension below it.
    pub fn glsl_version_decl(&self) -> &'static str {
        if self.context_supports(3, 2) {
            "#version 320 es"
        } else {
            "#version 310 es"
        }
    }

    /// `#extension <name> : enable`, but only below ES 3.2 where the feature is core.
    pub fn extension_directive(&self, name: &str) -> String {
        if self.context_supports(3, 2) {
            String::new()
        } else {
            format!("#extension {name} : enable\n")
        }
    }

    /// Upstream's `generateAndVerifyShader`: compile one standalone shader and fail the
    /// case if it compiled, since every caller is feeding it source the spec rejects.
    pub fn verify_shader_does_not_compile(&mut self, shader_type: ShaderType, source: &str) {
        if self.compile_shader(shader_type, source) {
            self.fail("Shader was not expected to compile.");
        }
    }

    /// `glu::Shader` + `setSources` + `compile`, answering the compile status. The info
    /// log is logged either way - it is the only thing that says *why* a driver disagreed.
    pub fn compile_shader(&self, shader_type: ShaderType, source: &str) -> bool {
        let gl = self.gl();
        let source_bytes = std::ffi::CString::new(source).expect("shader source has no interior NUL");
        let ptr = source_bytes.as_ptr();
        let length = source.len() as GLint;

        // SAFETY: one source string of `length` bytes, and every out parameter below is a
        // single slot the driver fills. The shader is deleted before returning.
        unsafe {
            let shader = gl.create_shader(shader_type.gl_enum());
            gl.shader_source(shader, 1, &ptr, &length);
            gl.compile_shader(shader);

            let mut status: GLint = 0;
            gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status);

            let mut log_len: GLint = 0;
            gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut log_len);
            if log_len > 1 {
                let mut buf = vec![0u8; log_len as usize];
                let mut written = 0;
                gl.get_shader_info_log(shader, log_len, &mut written, buf.as_mut_ptr().cast());
                buf.truncate(written.max(0) as usize);
                log::debug!("// {}", String::from_utf8_lossy(&buf));
            }

            gl.delete_shader(shader);
            status != 0
        }
    }

    /// `NegativeTestContext::expectError(error)`
    pub fn expect_error(&mut self, error: GLenum) {
        self.expect_error2(error, error);
    }

    /// `NegativeTestContext::expectError(error0, error1)` - the spec allows either.
    ///
    /// This is upstream's one virtual: `GetErrorCase` compares `glGetError`, the other
    /// two check that a debug message was reported and drain the error afterwards so a
    /// later `glu::ShaderProgram` does not trip over the leftover state.
    pub fn expect_error2(&mut self, error0: GLenum, error1: GLenum) {
        match self.reporting {
            Reporting::GetError => {
                // SAFETY: glGetError needs only a current context.
                let result = unsafe { self.gl().get_error() };
                if result != error0 && result != error1 {
                    let msg = if error0 == error1 {
                        format!(
                            "{} was expected but got {}",
                            glw::error_name(error0),
                            glw::error_name(result)
                        )
                    } else {
                        format!(
                            "{} or {} was expected but got {}",
                            glw::error_name(error0),
                            glw::error_name(error1),
                            glw::error_name(result)
                        )
                    };
                    log::warn!("{msg}");
                    self.results
                        .add_result(TestResult::Fail, "Incorrect error was reported".to_string());
                }
            }
            // `BaseCase::expectError`: an expected GL error must show up as an
            // API/ERROR debug message; expecting GL_NO_ERROR expects nothing.
            Reporting::Callback | Reporting::Log | Reporting::Async => {
                if error0 != glw::GL_NO_ERROR || error1 != glw::GL_NO_ERROR {
                    self.expect_message(glw::GL_DEBUG_SOURCE_API, glw::GL_DEBUG_TYPE_ERROR);
                } else {
                    self.expect_message(glw::GL_DONT_CARE, glw::GL_DONT_CARE);
                }
            }
            // `BaseCase::expectError` reaches `FilterCase::expectMessage`, which is a
            // no-op override.
            Reporting::Filter => {}
        }
    }

    /// `CallbackErrorCase::expectMessage` / `LogErrorCase::expectMessage`
    ///
    /// Public because it is also `DebugMessageTestContext::expectMessage`: the
    /// externally-generated-message functions insert a message themselves and then ask
    /// for it back, rather than reaching it through `expectError`.
    pub fn expect_message(&mut self, source: GLenum, ty: GLenum) {
        let message = match self.reporting {
            Reporting::Callback => std::mem::take(&mut *self.last_message),
            Reporting::Log => self.take_logged_message(source, ty),
            // `FilterCase::expectMessage` - a no-op override.
            Reporting::Filter => return,
            // `AsyncCase::expectMessage` - drains the log and checks nothing.
            Reporting::Async => {
                if let Some(hook) = self.expect_message_hook {
                    hook();
                }
                return;
            }
            Reporting::GetError => unreachable!("GetErrorCase cannot handle anything other than error codes"),
        };

        self.verify_message(&message, source, ty);

        // Reset the error so that code afterwards (a `glu::ShaderProgram`, say) does not
        // break because of lingering error state.
        // SAFETY: glGetError needs only a current context.
        unsafe { self.gl().get_error() };
    }

    /// The message-log half of `LogErrorCase::expectMessage`.
    fn take_logged_message(&mut self, source: GLenum, ty: GLenum) -> MessageData {
        let gl = self.gl();

        if source == glw::GL_DONT_CARE || ty == glw::GL_DONT_CARE {
            return MessageData::default();
        }

        let mut num_msg = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_DEBUG_LOGGED_MESSAGES, &mut num_msg) };

        if num_msg == 0 {
            return MessageData::default();
        }

        // There may be messages other than the error being looked for. Nothing stops an
        // implementation from producing more than the required error, but a call that
        // produces an error should not change GL state, so it should have nothing else
        // to report - hence: keep only the last.
        if num_msg > 1 {
            // SAFETY: every output pointer is null, which the entry point accepts.
            unsafe {
                gl.get_debug_message_log(
                    (num_msg - 1) as GLuint,
                    0,
                    std::ptr::null_mut(),
                    std::ptr::null_mut(),
                    std::ptr::null_mut(),
                    std::ptr::null_mut(),
                    std::ptr::null_mut(),
                    std::ptr::null_mut(),
                );
            }
        }

        let mut msg_len = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH, &mut msg_len) };

        if !(0..100_000).contains(&msg_len) {
            self.results
                .add_result(TestResult::Fail, format!("Message length out of range: {msg_len}"));
            return MessageData::default();
        }

        let mut buf = vec![0u8; msg_len as usize];
        let mut out_source = 0;
        let mut out_type = 0;
        let mut out_id = 0;
        let mut out_severity = 0;
        let mut out_len = 0;

        // SAFETY: one message is asked for and the buffer holds the length the driver
        // just reported for it.
        unsafe {
            gl.get_debug_message_log(
                1,
                msg_len,
                &mut out_source,
                &mut out_type,
                &mut out_id,
                &mut out_severity,
                &mut out_len,
                buf.as_mut_ptr().cast(),
            );
        }

        MessageData {
            source: out_source,
            ty: out_type,
            message: String::from_utf8_lossy(&buf).trim_end_matches('\0').to_string(),
        }
    }

    /// `BaseCase::verifyMessage`, over `verifyMessageExists`, `verifyMessageString` and
    /// `verifyMessageGroup`.
    fn verify_message(&mut self, message: &MessageData, source: GLenum, ty: GLenum) {
        if source == glw::GL_DONT_CARE || ty == glw::GL_DONT_CARE {
            return;
        }

        if message.source == glw::GL_NONE || message.ty == glw::GL_NONE {
            // This port never asks for a debug context, so a driver is within its rights
            // to report nothing at all here - which upstream downgrades to a warning for
            // exactly the same reason.
            self.results.add_result(
                TestResult::QualityWarning,
                "Verification accuracy is lacking without a debug context".to_string(),
            );
            return;
        }

        if message.message.is_empty() {
            self.results
                .add_result(TestResult::QualityWarning, "Empty message".to_string());
        }

        if message.source != source {
            self.results.add_result(
                TestResult::Fail,
                format!("Incorrect message source: {:#x}", message.source),
            );
        }

        if message.ty != ty {
            self.results
                .add_result(TestResult::Fail, format!("Incorrect message type: {:#x}", message.ty));
        }
    }
}

/// `isKHRDebugSupported`
pub fn is_khr_debug_supported(context: &Context) -> bool {
    context.context_type().supports(3, 2) || context.context_info.is_extension_supported("GL_KHR_debug")
}

/// One negative case: a test function plus the reporting mechanism it runs under.
struct NegativeCase {
    name: &'static str,
    function: TestFunc,
    reporting: Reporting,
}

impl TestCase for NegativeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.reporting != Reporting::GetError && !is_khr_debug_supported(context) {
            return Err(TestError::NotSupported("GL_KHR_debug is not supported".to_string()));
        }
        Ok(())
    }

    /// `GetErrorCase::iterate`, `CallbackErrorCase::iterate` and `LogErrorCase::iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ctx = NegativeTestContext::new(context, self.reporting);

        // SAFETY: the callback pointer below is handed a `MessageData` that outlives
        // every call the driver can make, and is unregistered before this returns.
        unsafe {
            match self.reporting {
                // `FilterCase`/`AsyncCase` run the functions themselves, so neither
                // ever builds one of these.
                Reporting::GetError | Reporting::Filter | Reporting::Async => {}
                Reporting::Callback => {
                    gl.enable(glw::GL_DEBUG_OUTPUT);
                    gl.enable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
                    // Disable all, then re-enable only the sources these cases look at.
                    gl.debug_message_control(
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::FALSE,
                    );
                    gl.debug_message_control(
                        glw::GL_DEBUG_SOURCE_API,
                        glw::GL_DEBUG_TYPE_ERROR,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::TRUE,
                    );
                    gl.debug_message_control(
                        glw::GL_DEBUG_SOURCE_APPLICATION,
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::TRUE,
                    );
                    gl.debug_message_control(
                        glw::GL_DEBUG_SOURCE_THIRD_PARTY,
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::TRUE,
                    );
                    let user_param: *const std::ffi::c_void = std::ptr::addr_of!(*ctx.last_message).cast();
                    gl.debug_message_callback(Some(debug_callback), user_param);
                }
                Reporting::Log => {
                    gl.enable(glw::GL_DEBUG_OUTPUT);
                    gl.enable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
                    gl.debug_message_control(
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::FALSE,
                    );
                    gl.debug_message_control(
                        glw::GL_DEBUG_SOURCE_API,
                        glw::GL_DEBUG_TYPE_ERROR,
                        glw::GL_DONT_CARE,
                        0,
                        std::ptr::null(),
                        glw::TRUE,
                    );
                    // A null callback means "log it" rather than "call me".
                    gl.debug_message_callback(None, std::ptr::null());

                    let mut num_msg = 0;
                    gl.get_integerv(glw::GL_DEBUG_LOGGED_MESSAGES, &mut num_msg);
                    gl.get_debug_message_log(
                        num_msg as GLuint,
                        0,
                        std::ptr::null_mut(),
                        std::ptr::null_mut(),
                        std::ptr::null_mut(),
                        std::ptr::null_mut(),
                        std::ptr::null_mut(),
                        std::ptr::null_mut(),
                    );
                }
            }
        }

        let result = (self.function)(&mut ctx);

        // SAFETY: as above; unregistering is what makes the borrow above end here.
        unsafe {
            match self.reporting {
                Reporting::GetError | Reporting::Filter | Reporting::Async => {}
                Reporting::Callback => {
                    gl.debug_message_callback(None, std::ptr::null());
                    gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
                    gl.disable(glw::GL_DEBUG_OUTPUT);
                }
                Reporting::Log => {
                    gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
                    gl.disable(glw::GL_DEBUG_OUTPUT);
                }
            }
        }

        result?;
        Ok(ctx.results.to_status())
    }
}

/// `createChildCases` - one sub-group of one reporting mechanism.
pub fn create_child_cases(
    reporting: Reporting,
    name: &str,
    funcs: &'static [FunctionContainer],
) -> crate::glu::TestCaseGroup {
    let mut group = crate::glu::TestCaseGroup::new(name);

    for container in funcs {
        group.add_child(Box::new(NegativeCase {
            name: container.name,
            function: container.function,
            reporting,
        }) as Box<dyn TestCase>);
    }

    group
}
