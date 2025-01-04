// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::DrawTest::init / iterate)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// `gls::draw_test::DrawTest` is only the spec list and the per-iteration draw/compare
// steps; this is the `glu::TestCase` that drives it, i.e. upstream's `DrawTest::init`
// (the two contexts and packs) and the `iterate` loop collapsed into one call.
//
// Narrowings: the reference context is always single sample (upstream uses four samples
// when the render target is multisampled and the spec has line primitives), and an
// indexed spec with `Storage::User` indices is reported by `draw_iteration` as an error.

use crate::gls::draw_test::attribute_pack::AttributePack;
use crate::gls::draw_test::draw_test::{DrawStepOutcome, DrawTest};
use crate::gls::draw_test::spec::{CompatibilityTestType, DrawMethod, DrawTestSpec};
use crate::glu::{Context, TestCase};
use crate::sglr::gl_context::GLContext;
use crate::sglr::reference_context::ReferenceContext;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestResult};

/// `MAX_RENDER_TARGET_SIZE`
const MAX_RENDER_TARGET_SIZE: i32 = 512;

/// `gls::DrawTest` as a case: a name and the iterations `addIteration` collected.
pub struct DrawTestCase {
    name: String,
    iterations: Vec<(DrawTestSpec, String)>,
}

impl DrawTestCase {
    pub fn new(name: impl Into<String>) -> Self {
        Self {
            name: name.into(),
            iterations: Vec::new(),
        }
    }

    /// `DrawTest::addIteration`
    pub fn add_iteration(&mut self, spec: DrawTestSpec, description: &str) {
        self.iterations.push((spec, description.to_string()));
    }
}

fn is_base_vertex_method(method: DrawMethod) -> bool {
    matches!(
        method,
        DrawMethod::DrawElementsBaseVertex
            | DrawMethod::DrawElementsInstancedBaseVertex
            | DrawMethod::DrawElementsRangedBaseVertex
    )
}

impl TestCase for DrawTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let needs_base_vertex = self
            .iterations
            .iter()
            .any(|(spec, _)| is_base_vertex_method(spec.draw_method));
        if needs_base_vertex
            && !context.context_type().supports(3, 2)
            && !context
                .context_info
                .is_extension_supported("GL_EXT_draw_elements_base_vertex")
        {
            return Err(TestError::NotSupported(
                "GL_EXT_draw_elements_base_vertex is not supported.".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let render_target = context.render_target();
        let width = MAX_RENDER_TARGET_SIZE.min(render_target.width);
        let height = MAX_RENDER_TARGET_SIZE.min(render_target.height);
        let context_type = context.context_type();
        // ES 2.0 and 3.0 have no default VAO handling worth the name; everything this port runs is 3.1+.
        let use_vao = context_type.supports(3, 1);

        let mut draw_test = DrawTest::new(render_target.pixel_format(), render_target.num_samples);
        for (spec, description) in &self.iterations {
            if !draw_test.add_iteration(spec.clone(), Some(description.clone())) {
                return Err(TestError::InternalError("DrawTest rejected an iteration".to_string()));
            }
        }

        let mut gl_ctx = GLContext::new(&context.render_context, (0, 0, width, height));
        let color = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            width as u32,
            height as u32,
            1,
        )?;
        let mut rr_ctx = ReferenceContext::new(16, color, None, 8);

        let mut gl_pack = AttributePack::new(&mut gl_ctx, context_type, width, height, use_vao);
        let mut rr_pack = AttributePack::new(&mut rr_ctx, context.context_type(), width, height, use_vao);

        let mut result = ResultCollector::new("");

        for spec_ndx in 0..draw_test.spec_count() {
            let spec = draw_test.spec(spec_ndx).clone();
            log::debug!(
                "DrawTest iteration {spec_ndx}: {}",
                draw_test.description(spec_ndx).unwrap_or("")
            );

            match draw_test.draw_iteration(spec_ndx, &mut gl_ctx, &mut gl_pack, &mut rr_ctx, &mut rr_pack) {
                Ok(DrawStepOutcome::Ok | DrawStepOutcome::CompatibilityWarning(_)) => {}
                Err(message) => {
                    result.fail(message);
                    continue;
                }
            }

            if !draw_test.compare_iteration(spec_ndx, &gl_pack, &rr_pack) {
                match spec.is_compatibility_test() {
                    CompatibilityTestType::UnalignedOffset => result.add_result(
                        TestResult::CompatibilityWarning,
                        "Failed to draw with unaligned buffers.".to_string(),
                    ),
                    CompatibilityTestType::UnalignedStride => result.add_result(
                        TestResult::CompatibilityWarning,
                        "Failed to draw with unaligned stride.".to_string(),
                    ),
                    _ => result.fail("Image comparison failed."),
                }
            }
        }

        gl_pack.destroy(&mut gl_ctx);
        rr_pack.destroy(&mut rr_ctx);

        Ok(result.to_status())
    }
}
