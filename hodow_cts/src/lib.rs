// SPDX-License-Identifier: Apache-2.0
//
// hodow_cts - a Rust rewrite of the Khronos Conformance Test Suite (Vulkan and
// OpenGL ES).
//
// Copyright 2026 Rafal Mikrut
// Portions derived from VK-GL-CTS, Copyright (c) The Khronos Group Inc. and others,
// licensed under the Apache License, Version 2.0. See LICENSE and NOTICE at the
// repository root, and hodow_cts/upstream/ for the exact upstream sources each ported
// file was derived from.
//
// Layout mirrors upstream so a file can be found from its C++ counterpart:
//   tcu/     <- framework/common, framework/delibs   (tcu::, de::)
//   vk/      <- external/vulkancts/framework/vulkan  (vk::)
//   vkt/     <- external/vulkancts/modules/vulkan    (vkt::)
//   eglw/    <- framework/egl/wrapper                (eglw::)
//   eglu/    <- framework/egl                        (eglu::)
//   glw/     <- framework/opengl/wrapper             (glw::)
//   glu/     <- framework/opengl                     (glu::)
//   gls/     <- modules/glshared                     (gls::)
//   gles2/   <- modules/gles2                        (deqp::gles2)
//   gles3/   <- modules/gles3                        (deqp::gles3)
//   gles31/  <- modules/gles31                       (deqp::gles31)
//
// `tcu`, `report` and `runner` are shared by both APIs; everything under them is one
// API's own.

#[cfg(not(any(feature = "gles", feature = "gl", feature = "vulkan")))]
compile_error!(
    "hodow_cts needs at least one of the `gles`, `gl` and `vulkan` features; with neither it registers no cases at all"
);

pub mod cli;

// Everything that is not the case lists is `hodow_cts_base`; the paths (`hodow_cts::tcu`, `hodow_cts::runner`, ...) are as they were.
pub use hodow_cts_base::*;

pub mod vkt {
    pub use hodow_cts_base::vkt::*;

    #[cfg(feature = "vulkan")]
    #[path = "tests_vulkan.rs"]
    pub mod tests;
}

/// Builds the Vulkan test hierarchy, rooted at `dEQP-VK`.
///
/// Mirrors `createTestPackage` / `TestPackage::init` upstream: the root package name
/// is what makes the full case names identical to `deqp-vk`'s, which is what the
/// differential comparison and the upstream mustpass files both depend on.
pub fn create_test_hierarchy() -> vkt::TestCaseGroup {
    #[allow(unused_mut)]
    let mut root = vkt::TestCaseGroup::new("dEQP-VK");
    #[cfg(feature = "vulkan")]
    {
        root.add_child(vkt::tests::info::create_tests());
        root.add_child(vkt::tests::api::create_tests());
        root.add_child(vkt::tests::binding_model::create_tests());
        root.add_child(vkt::tests::clipping::create_tests());
        root.add_child(vkt::tests::compute::create_tests());
        root.add_child(vkt::tests::cooperative_vector::create_tests());
        root.add_child(vkt::tests::conditional_rendering::create_tests());
        root.add_child(vkt::tests::data_graph::create_tests());
        root.add_child(vkt::tests::depth::create_tests());
        root.add_child(vkt::tests::descriptor_indexing::create_tests());
        root.add_child(vkt::tests::draw::create_tests());
        root.add_child(vkt::tests::drm_format_modifiers::create_tests());
        root.add_child(vkt::tests::dynamic_state::create_tests());
        root.add_child(vkt::tests::fragment_ops::create_tests());
        root.add_child(vkt::tests::fragment_shader_interlock::create_tests());
        root.add_child(vkt::tests::fragment_shading_barycentric::create_tests());
        root.add_child(vkt::tests::fragment_shading_rate::create_tests());
        root.add_child(vkt::tests::geometry::create_tests());
        root.add_child(vkt::tests::glsl::create_tests());
        root.add_child(vkt::tests::graphicsfuzz::create_tests());
        root.add_child(vkt::tests::image::create_tests());
        root.add_child(vkt::tests::imageless_framebuffer::create_tests());
        root.add_child(vkt::tests::image_processing::create_tests());
        root.add_child(vkt::tests::memory::create_tests());
        root.add_child(vkt::tests::memory_model::create_tests());
        root.add_child(vkt::tests::mesh_shader::create_tests());
        root.add_child(vkt::tests::multiview::create_tests());
        root.add_child(vkt::tests::pipeline::create_tests());
        root.add_child(vkt::tests::postmortem::create_tests());
        root.add_child(vkt::tests::protected_memory::create_tests());
        root.add_child(vkt::tests::postmortem::create_shader_abort_tests());
        root.add_child(vkt::tests::query_pool::create_tests());
        root.add_child(vkt::tests::rasterization::create_tests());
        root.add_child(vkt::tests::ray_query::create_tests());
        root.add_child(vkt::tests::ray_tracing_pipeline::create_tests());
        root.add_child(vkt::tests::renderpass::create_tests());
        root.add_child(vkt::tests::robustness::create_tests());
        root.add_child(vkt::tests::sparse_resources::create_tests());
        root.add_child(vkt::tests::spirv_assembly::create_tests());
        root.add_child(vkt::tests::ssbo::create_tests());
        root.add_child(vkt::tests::subgroups::create_tests());
        root.add_child(vkt::tests::tensor::create_tests());
        root.add_child(vkt::tests::dgc::create_tests());
        root.add_child(vkt::tests::tessellation::create_tests());
        root.add_child(vkt::tests::texture::create_tests());
        root.add_child(vkt::tests::ubo::create_tests());
        root.add_child(vkt::tests::transform_feedback::create_tests());
        root.add_child(vkt::tests::video::create_tests());
        root.add_child(vkt::tests::wsi::create_tests());
        root.add_child(vkt::tests::ycbcr::create_tests());
        root.add_child(vkt::tests::shader_object::create_tests());
        root.add_child(vkt::tests::reconvergence::create_tests());
        // Upstream registers these as two sibling top-level groups rather than one.
        for group in vkt::tests::synchronization::single_queue_tests::create_tests() {
            root.add_child(group);
        }
    }
    root
}

/// The flat, ordered list of every Vulkan case hodow_cts knows about.
pub fn all_cases() -> Vec<vkt::FlatCase> {
    tcu::flatten(create_test_hierarchy())
}

/// Tells `hodow_cts_base` how to build the case trees. The command line does it before it lists or runs anything.
pub fn install_case_providers() {
    hodow_cts_base::set_case_providers(hodow_cts_base::CaseProviders {
        vulkan: all_cases,
        gl: gl_cases,
    });
}

/// The flat, ordered list of every GL case: `dEQP-GLES2`, `dEQP-GLES3`, `dEQP-GLES31`, then
/// the Khronos `KHR-GL*` roots.
///
/// All three share one list because they share one case type - the difference between
/// them is the context version the runner asks for, which comes from `runner::Api`.
/// They are kept apart from the Vulkan list because *that* is a genuinely different
/// type: a Vulkan case hands the runner an ahead-of-time program collection and runs
/// against a device, a GL case compiles its own GLSL against a current context. What
/// matters is that the hierarchy walker, the name filter, the report and the crash
/// isolation are shared, and all of those are generic over the case type.
///
/// Lowest version first, which is the order they run in: on a driver that is failing,
/// the ES 2.0 verdicts are the ones worth reading first.
pub fn all_gl_cases() -> Vec<glu::FlatCase> {
    gl_cases(&runner::Api::ALL)
}

/// The GL case trees of `apis` alone, in `Api::ALL` order. On a Cortex-A9 building all
/// three takes over twenty seconds, which every worker process paid for one root.
pub fn gl_cases(apis: &[runner::Api]) -> Vec<glu::FlatCase> {
    #[allow(unused_mut)]
    let mut cases = Vec::new();
    #[cfg(feature = "gles")]
    {
        if apis.contains(&runner::Api::Gles2) {
            cases.extend(tcu::flatten(gles2::create_tests()));
        }
        if apis.contains(&runner::Api::Gles3) {
            cases.extend(tcu::flatten(gles3::create_tests()));
        }
        if apis.contains(&runner::Api::Gles31) {
            cases.extend(tcu::flatten(gles31::create_tests()));
        }
    }
    #[cfg(feature = "gl")]
    for api in apis {
        if let runner::Api::GlKhr(version) = api {
            cases.extend(tcu::flatten(khr_gl::create_tests(*version)));
        }
    }
    #[cfg(not(any(feature = "gles", feature = "gl")))]
    let _ = apis;
    cases
}

/// Whether each half of the suite is compiled into this binary.
///
/// Read through `cfg!` rather than exported per feature, so a caller can *report* the
/// answer without itself being gated. That distinction matters: a root with no cases
/// because its half was left out has to be visibly different from a filter that matched
/// nothing, or the first thing anyone does is go looking for the bug.
pub const HAS_GLES: bool = cfg!(feature = "gles");
pub const HAS_GL: bool = cfg!(feature = "gl");
pub const HAS_VULKAN: bool = cfg!(feature = "vulkan");

/// Every case name this binary knows, Vulkan first, in registration order.
///
/// This is what `--list` prints and what the case filters are applied to, so a caller
/// that only wants names never has to know which API a case belongs to.
pub fn all_case_names() -> Vec<String> {
    let mut names: Vec<String> = all_cases().into_iter().map(|c| c.full_name).collect();
    names.extend(all_gl_cases().into_iter().map(|c| c.full_name));
    names
}
