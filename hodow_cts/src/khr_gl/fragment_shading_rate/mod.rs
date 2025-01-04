// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateTests.cpp / .hpp
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateAPI.cpp / .hpp
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateComplex.cpp / .hpp
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateRenderTarget.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `TestCaseGroupBase` subclasses (`FragmentShadingRateAPI`, `...Complex`, `...RenderTarget`) are the `create_*` functions below, and each case's `init`/`iterate`/`deinit` is one `iterate`: the support checks first (a NotSupported result), then the body, then the `deinit` resets whatever the body did.

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

mod api;
mod attachment;
mod combined;

use super::esext::{ExtParameters, TestCaseBase};
use crate::glu::{TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLsizei};
use crate::tcu::TestError;

pub(super) const FRAGMENT_SHADING_RATE_NOT_SUPPORTED: &str =
    "Fragment shading rate functionality not supported, skipping";
pub(super) const TRIANGLE_COUNT: u32 = 100;
pub(super) const MAX_RATE_COUNT: usize = 16;

pub(super) fn not_supported(message: &str) -> TestError {
    TestError::NotSupported(message.to_string())
}

/// `fsrutils::packShadingRate`: the combined log of the width and the height of the rate.
pub(super) fn pack_shading_rate(shading_rate: GLenum) -> u32 {
    let (width_shift, height_shift) = match shading_rate {
        glw::GL_SHADING_RATE_1X1_PIXELS_EXT => (0, 0),
        glw::GL_SHADING_RATE_1X2_PIXELS_EXT => (0, 1),
        glw::GL_SHADING_RATE_1X4_PIXELS_EXT => (0, 2),
        glw::GL_SHADING_RATE_2X1_PIXELS_EXT => (1, 0),
        glw::GL_SHADING_RATE_2X2_PIXELS_EXT => (1, 1),
        glw::GL_SHADING_RATE_2X4_PIXELS_EXT => (1, 2),
        glw::GL_SHADING_RATE_4X1_PIXELS_EXT => (2, 0),
        glw::GL_SHADING_RATE_4X2_PIXELS_EXT => (2, 1),
        glw::GL_SHADING_RATE_4X4_PIXELS_EXT => (2, 2),
        _ => (0, 0),
    };
    (width_shift << 2) | height_shift
}

/// The first part of every case's `deinit`: put the shading rate state back.
pub(super) fn reset_shading_rate_state(gl: &glw::Functions, base: &TestCaseBase) {
    if base.is_fragment_shading_rate_supported {
        // SAFETY: plain state setters on the current context, guarded by the extension flag.
        unsafe {
            gl.shading_rate_ext(glw::GL_SHADING_RATE_1X1_PIXELS_EXT);
            gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT,
            );
        }
    }

    if base.is_fragment_shading_rate_attachment_supported {
        // SAFETY: as above.
        unsafe {
            gl.framebuffer_shading_rate_ext(glw::GL_FRAMEBUFFER, glw::GL_SHADING_RATE_ATTACHMENT_EXT, 0, 0, 1, 1, 1)
        };
    }
}

/// The shading rates `glGetFragmentShadingRatesEXT` reports for `samples` samples.
pub(super) fn available_shading_rates(gl: &glw::Functions, samples: GLsizei) -> Result<Vec<GLenum>, TestError> {
    let mut shading_rates = [0 as GLenum; MAX_RATE_COUNT];
    let mut count: GLsizei = 0;

    // SAFETY: room for `MAX_RATE_COUNT` rates and one count.
    unsafe {
        gl.get_fragment_shading_rates_ext(
            samples,
            MAX_RATE_COUNT as GLsizei,
            &mut count,
            shading_rates.as_mut_ptr(),
        )
    };
    crate::glu::expect_no_error(gl, "Error to get shading rate getFragmentShadingRatesEXT")?;
    if count <= 0 {
        return Err(TestError::Fail(
            "glGetFragmentShadingRatesEXT returned no shading rate".to_string(),
        ));
    }
    Ok(shading_rates[..count as usize].to_vec())
}

/// The vertices `iterate` draws from: `TRIANGLE_COUNT * 3` random 2D positions in [-1, 1).
pub(super) fn random_vertices(seed: u32) -> Vec<f32> {
    let mut rnd = crate::tcu::Random::new(seed);
    (0..TRIANGLE_COUNT * 3 * 2)
        .map(|_| rnd.get_float() * 2.0 - 1.0)
        .collect()
}

/// `FragmentShadingRateAPI::init`
fn create_api_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("api");
    group.add_child(Box::new(api::Basic { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(api::Errors { ext_params }) as Box<dyn TestCase>);
    group
}

/// `FragmentShadingRateComplex::init`
fn create_complex_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("complex");

    let booleans = |true_name: &'static str| [(false, ""), (true, true_name)];
    let combiners: [(GLenum, &str); 5] = [
        (glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT, "keep_"),
        (glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT, "replace_"),
        (glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MIN_EXT, "min_"),
        (glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MAX_EXT, "max_"),
        (glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MUL_EXT, "mul_"),
    ];
    let sizes: [(i32, &str); 3] = [(6, "6x6"), (37, "37x37"), (256, "256x256")];

    for (use_shading_rate_api, api_name) in booleans("api_") {
        for (use_shading_rate_primitive, primitive_name) in booleans("primitive_") {
            for (use_shading_rate_attachment, attachment_name) in booleans("attachment_") {
                if !use_shading_rate_api && !use_shading_rate_primitive && !use_shading_rate_attachment {
                    // fragment shading rate does not use
                    continue;
                }

                for (combiner_op0, op0_name) in combiners {
                    for (combiner_op1, op1_name) in combiners {
                        for (msaa, msaa_name) in booleans("msaa_") {
                            for (framebuffer_size, size_name) in sizes {
                                let name = format!(
                                    "{api_name}{primitive_name}{attachment_name}{op0_name}{op1_name}{msaa_name}{size_name}"
                                );
                                let param = combined::TestcaseParam {
                                    use_shading_rate_api,
                                    use_shading_rate_primitive,
                                    use_shading_rate_attachment,
                                    combiner_op0,
                                    combiner_op1,
                                    msaa,
                                    framebuffer_size,
                                };
                                group.add_child(
                                    Box::new(combined::Combined::new(ext_params, param, name)) as Box<dyn TestCase>
                                );
                            }
                        }
                    }
                }
            }
        }
    }
    group
}

/// `FragmentShadingRateRenderTarget::init`
fn create_render_target_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("render_target");

    let test_kinds = [
        (attachment::TestKind::Scissor, "scissor_"),
        (attachment::TestKind::MultiView, "multiview_"),
    ];
    let attachment_shading_rates = [(false, "api_"), (true, "attachment_")];
    let multi_shading_rates = [(false, ""), (true, "multishadingratelayer_")];
    let sizes: [(u32, &str); 3] = [(6, "6x6"), (37, "37x37"), (256, "256x256")];

    for (test_kind, kind_name) in test_kinds {
        for (attachment_shading_rate, attachment_name) in attachment_shading_rates {
            for (multi_shading_rate, multi_name) in multi_shading_rates {
                for (framebuffer_size, size_name) in sizes {
                    let layer_count = if test_kind == attachment::TestKind::MultiView {
                        2
                    } else {
                        1
                    };

                    if multi_shading_rate && (layer_count <= 1 || !attachment_shading_rate) {
                        continue;
                    }

                    let name = format!("{kind_name}{attachment_name}{multi_name}{size_name}");
                    let param = attachment::TestcaseParam {
                        test_kind,
                        attachment_shading_rate,
                        multi_shading_rate,
                        framebuffer_size,
                        layer_count,
                    };
                    group
                        .add_child(Box::new(attachment::Attachment::new(ext_params, param, name)) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}

/// `FragmentShadingRateTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment_shading_rate");
    group.add_child(create_api_tests(ext_params));
    group.add_child(create_complex_tests(ext_params));
    group.add_child(create_render_target_tests(ext_params));
    group
}
