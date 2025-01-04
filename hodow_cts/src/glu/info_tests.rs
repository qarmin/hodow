// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/tes2InfoTests.cpp
//   modules/gles3/tes3InfoTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream keeps a byte-identical copy of this group per module (only the namespace
// differs), and each root registers its own. One copy here serves every root; the
// registration stays per-root, so the case names are still exactly upstream's.
//
// These cases assert almost nothing: they query and log. Their value is that they are
// the first thing to run on a new board - if `info.version` cannot even produce a
// string, nothing after it is worth reading.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestOutcome, TestStatus};

/// `QueryStringCase`
struct QueryStringCase {
    name: &'static str,
    query: glw::GLenum,
}

impl TestCase for QueryStringCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        // SAFETY: glGetString with one of the four names below is valid on every
        // version; the string it returns is driver-owned and null-terminated.
        let result = unsafe { glw::string_from(gl.get_string(self.query)) };
        crate::glu::expect_no_error(gl, "glGetString() failed")?;

        log::info!("{result}");
        Ok(TestStatus::pass("Pass"))
    }
}

/// `QueryExtensionsCase`
struct QueryExtensionsCase;

impl TestCase for QueryExtensionsCase {
    fn name(&self) -> &str {
        "extensions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        for extension in &context.context_info.extensions {
            log::info!("{extension}");
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `RenderTargetInfoCase`
struct RenderTargetInfoCase;

impl TestCase for RenderTargetInfoCase {
    fn name(&self) -> &str {
        "render_target"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let target = context.render_context.render_target();
        log::info!(
            "RedBits: {}, GreenBits: {}, BlueBits: {}, AlphaBits: {}, DepthBits: {}, StencilBits: {}, NumSamples: {}, Width: {}, Height: {}",
            target.red_bits,
            target.green_bits,
            target.blue_bits,
            target.alpha_bits,
            target.depth_bits,
            target.stencil_bits,
            target.num_samples,
            target.width,
            target.height
        );
        Ok(TestStatus::pass("Pass"))
    }
}

/// `InfoTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("info");

    for (name, query) in [
        ("vendor", glw::GL_VENDOR),
        ("renderer", glw::GL_RENDERER),
        ("version", glw::GL_VERSION),
        ("shading_language_version", glw::GL_SHADING_LANGUAGE_VERSION),
    ] {
        group.add_child(Box::new(QueryStringCase { name, query }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(QueryExtensionsCase) as Box<dyn TestCase>);
    group.add_child(Box::new(RenderTargetInfoCase) as Box<dyn TestCase>);

    group
}
