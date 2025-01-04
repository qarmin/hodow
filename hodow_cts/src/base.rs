//! Everything in hodow_cts except the Vulkan test groups and the command line: the frameworks (`tcu`, `vk`, `vkt`, `rr`, `glu`),
//! the OpenGL ES and desktop OpenGL halves, the runner, the fuzzer and the board driver.
//!
//! It is its own crate so the Vulkan groups, which are most of the code, can be compiled in crates of their own (see
//! `vk_crates.toml`): each of them needs the frameworks, and a crate cannot depend on the crate that assembles it. `hodow_cts`
//! re-exports all of this, so `hodow_cts::tcu` and the rest are where they always were.
//!
//! What cannot live here is the one thing that needs every crate: the list of cases. The runner and the fuzzer ask for it
//! through `all_cases`/`gl_cases`, which return what `hodow_cts` registered with `set_case_providers` (its `cli::main_from`
//! does that before anything runs).

use std::sync::OnceLock;

pub mod board;
pub mod color;
pub mod eglu;
pub mod eglw;
pub mod fuzz;
pub mod generated;
pub mod gles2;
pub mod gles3;
pub mod gles31;
#[cfg(feature = "gles")]
pub mod gls;
pub mod glu;
pub mod glw;
#[cfg(feature = "gl")]
pub mod khr_gl;
pub mod report;
pub mod rr;
#[cfg(feature = "gles")]
pub mod rsg;
pub mod runner;
#[cfg(feature = "gles")]
pub mod sglr;
pub mod tcu;
pub mod vk;
pub mod vkt;

/// How to build the case trees, supplied by the crate that has all the halves.
#[derive(Clone, Copy)]
pub struct CaseProviders {
    /// The Vulkan cases (`dEQP-VK`).
    pub vulkan: fn() -> Vec<vkt::FlatCase>,
    /// The GL cases of the given APIs alone.
    pub gl: fn(&[runner::Api]) -> Vec<glu::FlatCase>,
}

static PROVIDERS: OnceLock<CaseProviders> = OnceLock::new();

pub fn set_case_providers(providers: CaseProviders) {
    let _ = PROVIDERS.set(providers);
}

/// The flat, ordered list of every Vulkan case, empty until providers are registered.
pub fn all_cases() -> Vec<vkt::FlatCase> {
    PROVIDERS.get().map_or_else(Vec::new, |p| (p.vulkan)())
}

/// The GL case trees of `apis` alone, in `Api::ALL` order.
pub fn gl_cases(apis: &[runner::Api]) -> Vec<glu::FlatCase> {
    PROVIDERS.get().map_or_else(Vec::new, |p| (p.gl)(apis))
}

pub fn all_gl_cases() -> Vec<glu::FlatCase> {
    gl_cases(&runner::Api::ALL)
}

/// Every case name, Vulkan first, in registration order.
pub fn all_case_names() -> Vec<String> {
    let mut names: Vec<String> = all_cases().into_iter().map(|c| c.full_name).collect();
    names.extend(all_gl_cases().into_iter().map(|c| c.full_name));
    names
}
