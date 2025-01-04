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
pub mod etc1;
pub mod info_tests;
pub mod objects;
pub mod pixel_transfer;
pub mod program_interface_query;
pub mod render_context;
pub mod shader_program;
pub mod shader_util;
pub mod state_reset;
pub mod state_reset_core;
pub mod str_util;
pub mod texture;
pub mod texture_2d_array;
pub mod texture_3d;
pub mod texture_cube;
pub mod texture_test_util;
#[cfg(feature = "gles")]
pub mod texture_test_util_surface;
pub mod texture_util;
pub mod var_type;

pub use api_case::{ApiCase, ApiCaseFn, BAD_ENUM, add_api_case, add_api_cases};
pub use context_info::{
    ContextInfo, is_es3_compatible, is_fragment_dynamic_loop_supported, is_fragment_uniform_loop_supported,
    is_vertex_dynamic_loop_supported, is_vertex_uniform_loop_supported,
};
pub use draw_util::{
    BindingPoint, PrimitiveList, PrimitiveType, VertexArrayBinding, VertexArrayPointer, VertexComponentType, draw,
    draw_from_user_pointers, draw_from_vao_buffers, pr, va,
};
pub use objects::{Buffer, Framebuffer, ProgramPipeline, Query, Renderbuffer, Texture, TransformFeedback, VertexArray};
pub use pixel_transfer::read_pixels;
pub use program_interface_query::{
    InterfaceBlockInfo, InterfaceVariableInfo, get_program_interface_block_info, get_program_interface_variable_info,
    get_program_resource_int,
};
pub use render_context::{ApiType, ContextType, RenderContext, RenderTarget};
pub use shader_program::{ProgramSources, ShaderProgram, ShaderType};
pub use shader_util::{
    DataType, Precision, get_data_type_bool_vec, get_data_type_float_vec, get_data_type_from_gl_type,
    get_data_type_int_vec, get_data_type_matrix, get_data_type_uint_vec, get_data_type_vector,
};
pub use state_reset::reset_state_es;
pub use state_reset_core::reset_state_gl_core as reset_state_core;
pub use str_util::{texture_format_name, type_name};
pub use texture_util::{TransferFormat, get_internal_format, get_transfer_format};
pub use var_type::{
    FormatLayout, InterfaceBlock, Interpolation, Layout, MatrixOrder, Storage, StructType, VarType, VarTypeComponent,
    VariableDeclaration, declare_struct, declare_var, indent, memory_access,
};

use crate::glw::{self, GLint};
use crate::tcu::{TestError, TestNodeInfo, TestOutcome};

/// `glu::GLSLVersion`, in upstream's order: the ES versions, then the desktop ones. The derived ordering is
/// upstream's enum order, so it is only meaningful between two versions of the same family.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub enum GlslVersion {
    Es100,
    Es300,
    Es310,
    Es320,
    Glsl130,
    Glsl140,
    Glsl150,
    Glsl330,
    Glsl400,
    Glsl410,
    Glsl420,
    Glsl430,
    Glsl440,
    Glsl450,
    Glsl460,
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
            Self::Glsl130 => "#version 130",
            Self::Glsl140 => "#version 140",
            Self::Glsl150 => "#version 150",
            Self::Glsl330 => "#version 330",
            Self::Glsl400 => "#version 400",
            Self::Glsl410 => "#version 410",
            Self::Glsl420 => "#version 420",
            Self::Glsl430 => "#version 430",
            Self::Glsl440 => "#version 440",
            Self::Glsl450 => "#version 450",
            Self::Glsl460 => "#version 460",
        }
    }

    /// `glu::glslVersionIsES`
    pub fn is_es(self) -> bool {
        self <= Self::Es320
    }

    /// `glu::glslVersionUsesInOutQualifiers`: 1.00 ES and desktop 1.30 to 1.50 still spell shader interfaces `attribute`/`varying`.
    pub fn uses_in_out_qualifiers(self) -> bool {
        (Self::Es300..=Self::Es320).contains(&self) || (Self::Glsl330..=Self::Glsl460).contains(&self)
    }

    /// `getMinAPIForGLSLVersion`: the lowest context that accepts this version.
    pub fn min_api(self) -> ApiType {
        match self {
            Self::Es100 => ApiType::es(2, 0),
            Self::Es300 => ApiType::es(3, 0),
            Self::Es310 => ApiType::es(3, 1),
            Self::Es320 => ApiType::es(3, 2),
            Self::Glsl130 => ApiType::core(3, 0),
            Self::Glsl140 => ApiType::core(3, 1),
            Self::Glsl150 => ApiType::core(3, 2),
            Self::Glsl330 => ApiType::core(3, 3),
            Self::Glsl400 => ApiType::core(4, 0),
            Self::Glsl410 => ApiType::core(4, 1),
            Self::Glsl420 => ApiType::core(4, 2),
            Self::Glsl430 => ApiType::core(4, 3),
            Self::Glsl440 => ApiType::core(4, 4),
            Self::Glsl450 => ApiType::core(4, 5),
            Self::Glsl460 => ApiType::core(4, 6),
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
        return Err(TestError::Fail(format!(
            "{message} returned {}",
            glw::error_name(error)
        )));
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

    /// `gls::FboUtil::checkExtensionSupport(ctx, "DEQP_gles3_core_compatible")`, which
    /// goes through `detectGLESCompatibleContext(ctx, 3, 0)`.
    ///
    /// This asks the *driver* what version it is, not what version the context was
    /// requested at, and those differ: an ES 2.0 context on ES 3 capable hardware still
    /// answers `GL_MAJOR_VERSION` = 3, and follows the ES 3 error codes while doing so.
    /// Answering from `ContextType` instead made
    /// `dEQP-GLES2.functional.fbo.api.attachment_query_empty_fbo` expect
    /// `GL_INVALID_ENUM` where the driver correctly raised `GL_INVALID_OPERATION`.
    /// `GL_MAJOR_VERSION` does not exist on ES 2.0, so a failing query means 2.0.
    pub fn is_es3_compatible(&self) -> bool {
        self.is_gles_compatible(3, 0)
    }

    /// `gls::FboUtil::detectGLESCompatibleContext` - see `is_es3_compatible`, which is
    /// the `(3, 0)` case of this.
    pub fn is_gles_compatible(&self, required_major: GLint, required_minor: GLint) -> bool {
        let gl = self.gl();
        let mut major_version = 0;
        let mut minor_version = 0;

        // SAFETY: each query writes one integer, and a driver that does not know the
        // name writes nothing and raises GL_INVALID_ENUM instead.
        unsafe {
            gl.get_integerv(glw::GL_MAJOR_VERSION, &mut major_version);
            if gl.get_error() != glw::GL_NO_ERROR {
                major_version = 2;
            }

            gl.get_integerv(glw::GL_MINOR_VERSION, &mut minor_version);
            if gl.get_error() != glw::GL_NO_ERROR {
                minor_version = 0;
            }
        }

        (major_version, minor_version) >= (required_major, required_minor)
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
