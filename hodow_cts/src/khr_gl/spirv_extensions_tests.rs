// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSpirvExtensionsTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `SpirvExtensionsQueriesTestCase`
struct QueriesTestCase;

impl TestCase for QueriesTestCase {
    fn name(&self) -> &str {
        "spirv_extensions_queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let core_46 = context.context_type().supports_core(4, 6);
        if !core_46 && !context.context_info.is_extension_supported("GL_ARB_spirv_extensions") {
            return Err(TestError::NotSupported(
                "GL_ARB_spirv_extensions not supported".to_string(),
            ));
        }
        if !core_46 && !context.context_info.is_extension_supported("GL_ARB_gl_spirv") {
            return Err(TestError::NotSupported("GL_ARB_gl_spirv not supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let mut num_spirv_extensions: GLint = 0;
        // SAFETY: the pointer refers to a live GLint.
        unsafe { gl.get_integerv(glw::GL_NUM_SPIR_V_EXTENSIONS, &mut num_spirv_extensions) };
        glu::expect_no_error(gl, "getIntegerv")?;

        log::info!("GL_NUM_SPIR_V_EXTENSIONS = {num_spirv_extensions}");
        for i in 0..num_spirv_extensions {
            // SAFETY: glGetStringi returns a driver-owned NUL-terminated string or null.
            let spirv_extension = unsafe { glw::string_from(gl.get_stringi(glw::GL_SPIR_V_EXTENSIONS, i as u32)) };
            glu::expect_no_error(gl, "getStringi")?;

            if spirv_extension.is_empty() {
                log::info!("Failed to fetch GL_SPIRV_EXTENSIONS string for index: {i}");
                return Ok(TestStatus::fail("Fail"));
            }
            log::info!("GL_SPIR_V_EXTENSION {i}: {spirv_extension}");
        }

        // SAFETY: out-of-range index is the point of the query; the return value is ignored.
        unsafe { gl.get_stringi(glw::GL_SPIR_V_EXTENSIONS, num_spirv_extensions as u32) };
        // SAFETY: glGetError needs only a current context.
        let err = unsafe { gl.get_error() };
        if err != glw::GL_INVALID_VALUE {
            log::info!(
                "GetStringi query for GL_SPIRV_EXTENSIONS with index: {num_spirv_extensions} should generate INVALID_VALUE error instead of {}",
                glw::error_name(err)
            );
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SpirvExtensionsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("spirv_extensions");
    group.add_child(Box::new(QueriesTestCase) as Box<dyn TestCase>);
    group
}
