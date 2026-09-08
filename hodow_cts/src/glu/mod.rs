// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl  (glu::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported on demand, exactly like `tcu`: a helper no ported test uses yet is left out
// rather than guessed at.

pub mod api_case;
pub mod context_info;
pub mod draw_util;
pub mod info_tests;
pub mod objects;
pub mod pixel_transfer;
pub mod program_interface_query;
pub mod render_context;
pub mod shader_program;
pub mod state_reset;
pub mod texture_util;

pub use api_case::{ApiCase, ApiCaseFn, BAD_ENUM, add_api_case, add_api_cases};
pub use context_info::ContextInfo;
pub use draw_util::{PrimitiveList, PrimitiveType, VertexArrayBinding, VertexArrayPointer, VertexComponentType, draw, draw_from_user_pointers, pr, va};
pub use objects::{Buffer, Framebuffer, Renderbuffer, Texture, VertexArray};
pub use pixel_transfer::read_pixels;
pub use program_interface_query::{InterfaceBlockInfo, InterfaceVariableInfo, get_program_interface_block_info, get_program_interface_variable_info, get_program_resource_int};
pub use render_context::{ApiType, ContextType, RenderContext, RenderTarget};
pub use shader_program::{ProgramSources, ShaderProgram, ShaderType};
pub use state_reset::reset_state_es;
pub use texture_util::{TransferFormat, get_transfer_format};

use crate::glw;
use crate::tcu::{TestError, TestNodeInfo, TestOutcome};

/// `glu::GLSLVersion` - only the ES versions, which is all this suite can reach.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub enum GlslVersion {
    Es100,
    Es300,
    Es310,
    Es320,
}

impl GlslVersion {
    /// `glu::getGLSLVersionDeclaration` - the `#version` line, which every generated
    /// shader starts with.
    pub fn declaration(self) -> &'static str {
        match self {
            Self::Es100 => "#version 100",
            Self::Es300 => "#version 300 es",
            Self::Es310 => "#version 310 es",
            Self::Es320 => "#version 320 es",
        }
    }
}

/// `GLU_EXPECT_NO_ERROR` - fails the case if the call left an error behind.
///
/// Upstream throws `glu::Error` here, which its handler turns into a Fail; this
/// returns the `?`-able equivalent. The message is the GL call, as upstream writes it,
/// so a failure says which call produced the error rather than only that one did.
pub fn expect_no_error(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    // SAFETY: glGetError needs nothing but a current context, which a RenderContext
    // guarantees for as long as it exists.
    let error = unsafe { gl.get_error() };
    if error != glw::GL_NO_ERROR {
        return Err(TestError::Fail(format!("{message} returned {}", glw::error_name(error))));
    }
    Ok(())
}

/// Drains and discards any pending error.
///
/// Upstream does not need this: it starts every case in a fresh context. Here a batch
/// shares one context across cases, so an error a failing case left behind would be
/// reported against the next one.
pub fn drain_errors(gl: &glw::Functions) -> usize {
    let mut drained = 0;
    // SAFETY: as above.
    while unsafe { gl.get_error() } != glw::GL_NO_ERROR {
        drained += 1;
        // A context that has been lost answers with an error forever, so this cannot
        // be an unbounded loop.
        if drained > 64 {
            break;
        }
    }
    drained
}

/// `deqp::gles31::Context` - what a test is handed: the context and what it supports.
pub struct Context {
    pub render_context: RenderContext,
    pub context_info: ContextInfo,
}

impl Context {
    pub fn gl(&self) -> &glw::Functions {
        self.render_context.functions()
    }

    pub fn context_type(&self) -> ContextType {
        self.render_context.context_type()
    }

    /// `deqp::Context::getRenderTarget`
    pub fn render_target(&self) -> RenderTarget {
        self.render_context.render_target()
    }

    /// `glu::ContextInfo::isES3Compatible`
    pub fn is_es3_compatible(&self) -> bool {
        self.context_type().supports(3, 0)
    }
}

/// `tcu::TestCase` for the GL modules.
///
/// The shape differs from `vkt::TestCase` on purpose, because upstream's does: a GL
/// test has no ahead-of-time program collection to hand over (the driver compiles the
/// GLSL, and that compiler is part of what is under test), so there is no
/// `initPrograms` phase and the case builds its own shaders inside `iterate`.
pub trait TestCase: Send + Sync {
    /// `TestNode::getName`
    fn name(&self) -> &str;

    /// `TestCase::checkSupport`. GLES tests upstream do this at the top of `init` or
    /// `iterate`; splitting it out keeps NotSupported reportable without running
    /// anything, exactly as on the Vulkan side.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let _ = context;
        Ok(())
    }

    /// `TestCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome;

    /// Whether this case is registered but has no test logic behind it yet.
    fn is_stub(&self) -> bool {
        false
    }
}

/// The GL flavours of the API-agnostic hierarchy types in `tcu`.
pub type TestCaseGroup = crate::tcu::TestCaseGroup<dyn TestCase>;
pub type TestNode = crate::tcu::TestNode<dyn TestCase>;
pub type FlatCase = crate::tcu::FlatCase<dyn TestCase>;

impl TestNodeInfo for dyn TestCase {
    fn name(&self) -> &str {
        TestCase::name(self)
    }

    fn is_stub(&self) -> bool {
        TestCase::is_stub(self)
    }
}
