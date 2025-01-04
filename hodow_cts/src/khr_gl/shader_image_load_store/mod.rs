// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. This is the desktop `gl4cts::ShaderImageLoadStoreTests` (GL42 `shader_image_load_store`, `#version 420 core` shaders carried as complete sources), a different set of cases from the ES one in `es31_image_load_store`. All 51 cases are ported (written without compiling) and registered in upstream's order. The shader sources of the larger cases are the upstream literals expanded by hodow_cts/scripts/expand_cxx_literals.py from scripts/templates/ssbo/ils_*.tpl.

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

mod advanced_images;
mod advanced_misc;
mod advanced_sso;
mod advanced_sync;
mod alignment;
mod base;
mod basic_api;
mod basic_glsl;
mod early_fragment;
mod formats;
mod formats_stages;
mod incomplete;
mod machines;
mod multiple_uniforms;
mod negative;
mod nonlayered;
mod targets_atomic;
mod targets_load;
mod targets_store;
mod uniform_limits;

use crate::glu::{TestCase, TestCaseGroup};
use crate::khr_gl::subcase::{Subcase, TestSubcase};

fn add_case<S: Subcase + Default + 'static>(group: &mut TestCaseGroup, name: &str) {
    group.add_child(Box::new(TestSubcase::new(name, || Box::new(S::default()))) as Box<dyn TestCase>);
}

fn add_with(group: &mut TestCaseGroup, name: &str, factory: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `ShaderImageLoadStoreTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_image_load_store");
    add_case::<basic_api::BasicApiGet>(&mut group, "basic-api-get");
    add_case::<basic_api::BasicApiBind>(&mut group, "basic-api-bind");
    add_case::<basic_api::BasicApiBarrier>(&mut group, "basic-api-barrier");
    add_case::<basic_api::BasicApiTexParam>(&mut group, "basic-api-texParam");
    add_case::<formats::BasicAllFormatsStore>(&mut group, "basic-allFormats-store");
    add_case::<formats::BasicAllFormatsLoad>(&mut group, "basic-allFormats-load");
    add_case::<formats_stages::BasicAllFormatsStoreGeometryStages>(&mut group, "basic-allFormats-storeGeometryStages");
    add_case::<formats_stages::BasicAllFormatsLoadGeometryStages>(&mut group, "basic-allFormats-loadGeometryStages");
    add_case::<formats_stages::BasicAllFormatsLoadStoreComputeStage>(
        &mut group,
        "basic-allFormats-loadStoreComputeStage",
    );
    add_case::<targets_store::BasicAllTargetsStore>(&mut group, "basic-allTargets-store");
    add_case::<targets_load::BasicAllTargetsLoadNonMs>(&mut group, "basic-allTargets-load-nonMS");
    add_case::<targets_load::BasicAllTargetsLoadMs>(&mut group, "basic-allTargets-load-ms");
    add_case::<targets_atomic::BasicAllTargetsAtomic>(&mut group, "basic-allTargets-atomic");
    add_with(&mut group, "basic-allTargets-loadStoreVS", || {
        Box::new(machines::LoadStoreMachine::new(0))
    });
    add_with(&mut group, "basic-allTargets-loadStoreTCS", || {
        Box::new(machines::LoadStoreMachine::new(1))
    });
    add_with(&mut group, "basic-allTargets-loadStoreTES", || {
        Box::new(machines::LoadStoreMachine::new(2))
    });
    add_with(&mut group, "basic-allTargets-loadStoreGS", || {
        Box::new(machines::LoadStoreMachine::new(3))
    });
    add_with(&mut group, "basic-allTargets-loadStoreCS", || {
        Box::new(machines::LoadStoreMachine::new(4))
    });
    add_with(&mut group, "basic-allTargets-atomicVS", || {
        Box::new(machines::AtomicMachine::new(0))
    });
    add_with(&mut group, "basic-allTargets-atomicTCS", || {
        Box::new(machines::AtomicMachine::new(1))
    });
    add_with(&mut group, "basic-allTargets-atomicGS", || {
        Box::new(machines::AtomicMachine::new(3))
    });
    add_with(&mut group, "basic-allTargets-atomicCS", || {
        Box::new(machines::AtomicMachine::new(4))
    });
    add_case::<basic_glsl::BasicGlslMisc>(&mut group, "basic-glsl-misc");
    add_case::<basic_glsl::BasicGlslEarlyFragTests>(&mut group, "basic-glsl-earlyFragTests");
    add_case::<basic_glsl::BasicGlslConst>(&mut group, "basic-glsl-const");
    add_case::<advanced_sync::AdvancedSyncImageAccess>(&mut group, "advanced-sync-imageAccess");
    add_case::<advanced_sync::AdvancedSyncVertexArray>(&mut group, "advanced-sync-vertexArray");
    add_case::<advanced_sync::AdvancedSyncDrawIndirect>(&mut group, "advanced-sync-drawIndirect");
    add_case::<advanced_sync::AdvancedSyncTextureUpdate>(&mut group, "advanced-sync-textureUpdate");
    add_case::<advanced_sync::AdvancedSyncImageAccess2>(&mut group, "advanced-sync-imageAccess2");
    add_case::<advanced_sync::AdvancedSyncBufferUpdate>(&mut group, "advanced-sync-bufferUpdate");
    add_case::<advanced_misc::AdvancedAllStagesOneImage>(&mut group, "advanced-allStages-oneImage");
    add_case::<advanced_misc::AdvancedMemoryDependentInvocation>(&mut group, "advanced-memory-dependentInvocation");
    add_case::<advanced_misc::AdvancedMemoryOrder>(&mut group, "advanced-memory-order");
    add_case::<advanced_sso::AdvancedSsoSimple>(&mut group, "advanced-sso-simple");
    add_case::<advanced_sso::AdvancedSsoAtomicCounters>(&mut group, "advanced-sso-atomicCounters");
    add_case::<advanced_sso::AdvancedSsoSubroutine>(&mut group, "advanced-sso-subroutine");
    add_case::<advanced_sso::AdvancedSsoPerSample>(&mut group, "advanced-sso-perSample");
    add_case::<advanced_images::AdvancedCopyImage>(&mut group, "advanced-copyImage");
    add_case::<advanced_images::AdvancedAllMips>(&mut group, "advanced-allMips");
    add_case::<advanced_images::AdvancedCast>(&mut group, "advanced-cast");
    add_case::<alignment::ImageLoadStoreDataAlignmentTest>(&mut group, "single-byte_data_alignment");
    add_case::<nonlayered::ImageLoadStoreNonLayeredBindingTest>(&mut group, "non-layered_binding");
    add_case::<incomplete::ImageLoadStoreIncompleteTexturesTest>(&mut group, "incomplete_textures");
    add_case::<multiple_uniforms::ImageLoadStoreMultipleUniformsTest>(&mut group, "multiple-uniforms");
    add_case::<early_fragment::ImageLoadStoreEarlyFragmentTestsTest>(&mut group, "early-fragment-tests");
    add_case::<negative::NegativeUniform>(&mut group, "negative-uniform");
    add_case::<negative::NegativeBind>(&mut group, "negative-bind");
    add_case::<negative::NegativeCompileErrors>(&mut group, "negative-compileErrors");
    add_case::<negative::NegativeLinkErrors>(&mut group, "negative-linkErrors");
    add_case::<uniform_limits::ImageLoadStoreUniformLimitsTest>(&mut group, "uniform-limits");
    group
}
