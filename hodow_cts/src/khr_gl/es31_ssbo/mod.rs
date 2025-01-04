// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `glcts::ShaderStorageBufferObjectTests` is the `shader_storage_buffer_object` group of `es_31_compatibility` (and of the ES 3.1 root upstream); the shaders keep their `#version 310 es` header, which a desktop context accepts through GL_ARB_ES3_1_compatibility.

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

mod advanced1;
mod advanced2;
mod advanced3;
mod advanced4;
mod array_length;
mod atomic;
mod base;
mod basic;
pub(in crate::khr_gl) mod layout;
mod layout2;

use super::subcase::{Subcase, TestSubcase};
use crate::glu::{TestCase, TestCaseGroup};

fn add_case<S: Subcase + Default + 'static>(group: &mut TestCaseGroup, name: &str) {
    group.add_child(Box::new(TestSubcase::new(name, || Box::new(S::default()))) as Box<dyn TestCase>);
}

fn add_with(group: &mut TestCaseGroup, name: &str, factory: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

fn add_std_layout(group: &mut TestCaseGroup, base: &str, get_input: layout::GetInput) {
    add_with(group, &format!("{base}-vs"), move || {
        Box::new(layout::BasicStdLayoutBaseVs::new(get_input))
    });
    add_with(group, &format!("{base}-cs"), move || {
        Box::new(layout::BasicStdLayoutBaseCs::new(get_input))
    });
}

fn add_pair(
    group: &mut TestCaseGroup,
    base: &str,
    vs: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static,
    cs: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static,
) {
    add_with(group, &format!("{base}-vs"), vs);
    add_with(group, &format!("{base}-cs"), cs);
}

fn add_unsized2(group: &mut TestCaseGroup, name: &str, path: array_length::Path) {
    add_with(group, name, move || {
        Box::new(array_length::UnsizedArrayLength2::new(path))
    });
}

/// `glcts::ShaderStorageBufferObjectTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_storage_buffer_object");
    add_case::<basic::BasicBasicVs>(&mut group, "basic-basic-vs");
    add_case::<basic::BasicBasicCs>(&mut group, "basic-basic-cs");
    add_case::<basic::BasicMax>(&mut group, "basic-max");
    add_case::<basic::BasicBinding>(&mut group, "basic-binding");
    add_case::<basic::BasicSyntaxVs>(&mut group, "basic-syntax-vs");
    add_case::<basic::BasicSyntaxCs>(&mut group, "basic-syntax-cs");
    add_case::<basic::BasicSyntaxSso>(&mut group, "basic-syntaxSSO");
    let std430: [layout::GetInput; 7] = [
        layout::get_input_430c1,
        layout::get_input_430c2,
        layout::get_input_430c3,
        layout::get_input_430c4,
        layout::get_input_430c5,
        layout::get_input_430c6,
        layout::get_input_430c7,
    ];
    for (n, get_input) in std430.into_iter().enumerate() {
        add_std_layout(&mut group, &format!("basic-std430Layout-case{}", n + 1), get_input);
    }
    let std140: [layout::GetInput; 6] = [
        layout::get_input_140c1,
        layout::get_input_140c2,
        layout::get_input_140c3,
        layout::get_input_140c4,
        layout::get_input_140c5,
        layout::get_input_140c6,
    ];
    for (n, get_input) in std140.into_iter().enumerate() {
        add_std_layout(&mut group, &format!("basic-std140Layout-case{}", n + 1), get_input);
    }
    add_case::<atomic::BasicAtomicCase1Vsfs>(&mut group, "basic-atomic-case1-vsfs");
    add_case::<atomic::BasicAtomicCase1Cs>(&mut group, "basic-atomic-case1-cs");
    add_case::<atomic::BasicAtomicCase3Vsfs>(&mut group, "basic-atomic-case3-vsfs");
    add_case::<atomic::BasicAtomicCase3Cs>(&mut group, "basic-atomic-case3-cs");
    add_case::<atomic::BasicAtomicCase4Vsfs>(&mut group, "basic-atomic-case4-vsfs");
    add_case::<atomic::BasicAtomicCase4Cs>(&mut group, "basic-atomic-case4-cs");
    let std_layout: [layout2::GetInput4; 4] = [
        layout2::get_input_c1,
        layout2::get_input_c2,
        layout2::get_input_c3,
        layout2::get_input_c4,
    ];
    for (n, get_input) in std_layout.into_iter().enumerate() {
        add_pair(
            &mut group,
            &format!("basic-stdLayout-case{}", n + 1),
            move || Box::new(layout2::BasicStdLayoutBase2Vs::new(get_input)),
            move || Box::new(layout2::BasicStdLayoutBase2Cs::new(get_input)),
        );
    }
    let operations: [layout2::GetInputOp; 2] = [layout2::get_input_op1, layout2::get_input_op2];
    for (n, get_input) in operations.into_iter().enumerate() {
        add_pair(
            &mut group,
            &format!("basic-operations-case{}", n + 1),
            move || Box::new(layout2::BasicOperationsBaseVs::new(get_input)),
            move || Box::new(layout2::BasicOperationsBaseCs::new(get_input)),
        );
    }
    let ubo_ssbo: [layout2::GetInput2; 2] = [layout2::get_input_ubo1, layout2::get_input_ubo2];
    for (n, get_input) in ubo_ssbo.into_iter().enumerate() {
        add_pair(
            &mut group,
            &format!("basic-stdLayout_UBO_SSBO-case{}", n + 1),
            move || Box::new(layout2::BasicStdLayoutBase3Vs::new(get_input)),
            move || Box::new(layout2::BasicStdLayoutBase3Cs::new(get_input)),
        );
    }
    let matrix: [layout2::GetInputMat; 7] = [
        layout2::get_input_m1,
        layout2::get_input_m2,
        layout2::get_input_m3,
        layout2::get_input_m4,
        layout2::get_input_m5,
        layout2::get_input_m6,
        layout2::get_input_m7,
    ];
    for (n, get_input) in matrix.into_iter().enumerate() {
        add_pair(
            &mut group,
            &format!("basic-matrixOperations-case{}", n + 1),
            move || Box::new(layout2::BasicMatrixOperationsBaseVs::new(get_input)),
            move || Box::new(layout2::BasicMatrixOperationsBaseCs::new(get_input)),
        );
    }
    add_case::<basic::BasicReadonlyWriteonly>(&mut group, "basic-readonly-writeonly");
    add_case::<basic::BasicNameMatch>(&mut group, "basic-name-match");
    add_case::<advanced1::AdvancedSwitchBuffersVs>(&mut group, "advanced-switchBuffers-vs");
    add_case::<advanced1::AdvancedSwitchBuffersCs>(&mut group, "advanced-switchBuffers-cs");
    add_case::<advanced1::AdvancedSwitchProgramsVs>(&mut group, "advanced-switchPrograms-vs");
    add_case::<advanced1::AdvancedSwitchProgramsCs>(&mut group, "advanced-switchPrograms-cs");
    add_case::<advanced1::AdvancedWriteFragmentFs>(&mut group, "advanced-write-fragment-fs");
    add_case::<advanced1::AdvancedWriteFragmentCs>(&mut group, "advanced-write-fragment-cs");
    add_case::<advanced2::AdvancedIndirectAddressingCase1Vs>(&mut group, "advanced-indirectAddressing-case1-vs");
    add_case::<advanced2::AdvancedIndirectAddressingCase1Cs>(&mut group, "advanced-indirectAddressing-case1-cs");
    add_case::<advanced2::AdvancedIndirectAddressingCase2Vsfs>(&mut group, "advanced-indirectAddressing-case2-vsfs");
    add_case::<advanced2::AdvancedIndirectAddressingCase2Cs>(&mut group, "advanced-indirectAddressing-case2-cs");
    add_case::<advanced3::AdvancedReadWriteCase1Vsfs>(&mut group, "advanced-readWrite-case1-vsfs");
    add_case::<advanced3::AdvancedReadWriteCase1Cs>(&mut group, "advanced-readWrite-case1-cs");
    add_case::<advanced3::AdvancedUsageCase1>(&mut group, "advanced-usage-case1");
    add_case::<advanced3::AdvancedUsageSyncVsfs>(&mut group, "advanced-usage-sync-vsfs");
    add_case::<advanced3::AdvancedUsageSyncCs>(&mut group, "advanced-usage-sync-cs");
    add_case::<advanced3::AdvancedUsageOperatorsVs>(&mut group, "advanced-usage-operators-vs");
    add_case::<advanced3::AdvancedUsageOperatorsCs>(&mut group, "advanced-usage-operators-cs");
    for (name, stage) in [
        ("cs", array_length::Stage::Compute),
        ("fs", array_length::Stage::Fragment),
        ("vs", array_length::Stage::Vertex),
    ] {
        add_with(
            &mut group,
            &format!("advanced-unsizedArrayLength-{name}-int"),
            move || Box::new(array_length::UnsizedArrayLength::new(stage)),
        );
    }
    {
        use array_length::{BindingSeq, BufferLayout, ElementType, Path, Stage};
        let compute = Path::default();
        let fragment = Path {
            stage: Stage::Fragment,
            ..compute
        };
        let vertex = Path {
            stage: Stage::Vertex,
            ..compute
        };
        let with = |base: Path, etype: ElementType, layout: BufferLayout, other_members: bool| Path {
            etype,
            layout,
            other_members,
            ..base
        };
        let (vec, mat_c, mat_r, strukt) = (
            ElementType::Vector,
            ElementType::MatrixCm,
            ElementType::MatrixRm,
            ElementType::Structure,
        );
        let (std430, std140, packed, shared) = (
            BufferLayout::Std430,
            BufferLayout::Std140,
            BufferLayout::Packed,
            BufferLayout::Shared,
        );
        let cases: [(&str, Path); 26] = [
            ("cs-std430-vec", with(compute, vec, std430, false)),
            ("cs-std430-matC", with(compute, mat_c, std430, false)),
            ("cs-std430-matR", with(compute, mat_r, std430, false)),
            ("cs-std430-struct", with(compute, strukt, std430, false)),
            ("cs-std140-vec", with(compute, vec, std140, false)),
            ("cs-std140-matC", with(compute, mat_c, std140, false)),
            ("cs-std140-matR", with(compute, mat_r, std140, false)),
            ("cs-std140-struct", with(compute, strukt, std140, false)),
            ("cs-packed-vec", with(compute, vec, packed, false)),
            ("cs-packed-matC", with(compute, mat_c, packed, false)),
            ("cs-shared-matR", with(compute, mat_r, shared, false)),
            ("fs-std430-vec", with(fragment, vec, std430, false)),
            ("fs-std430-matC-pad", with(fragment, mat_c, std430, true)),
            ("fs-std140-matR", with(fragment, mat_r, std140, false)),
            ("fs-std140-struct", with(fragment, strukt, std140, false)),
            ("vs-std430-vec", with(vertex, vec, std430, true)),
            ("vs-std140-matC", with(vertex, mat_c, std140, false)),
            ("vs-packed-matR", with(vertex, mat_r, packed, false)),
            ("vs-std140-struct", with(vertex, strukt, std140, false)),
            ("cs-std430-vec-pad", with(compute, vec, std430, true)),
            ("cs-std430-matC-pad", with(compute, mat_c, std430, true)),
            ("cs-std140-matR-pad", with(compute, mat_r, std140, true)),
            ("cs-std430-struct-pad", with(compute, strukt, std430, true)),
            (
                "cs-std430-vec-bindrangeOffset",
                Path {
                    bind_seq: BindingSeq::BindRangeOffset,
                    ..compute
                },
            ),
            (
                "cs-std430-vec-bindrangeSize",
                Path {
                    bind_seq: BindingSeq::BindRangeSize,
                    ..compute
                },
            ),
            (
                "cs-std430-vec-bindbaseAfter",
                Path {
                    bind_seq: BindingSeq::BindBaseAfter,
                    ..compute
                },
            ),
        ];
        for (name, path) in cases {
            add_unsized2(&mut group, &format!("advanced-unsizedArrayLength-{name}"), path);
        }
        add_unsized2(
            &mut group,
            "advanced-unsizedArrayLength-cs-std430-vec-indexing",
            Path {
                length_as_index: true,
                ..compute
            },
        );
    }
    add_case::<advanced4::AdvancedMatrixVsfs>(&mut group, "advanced-matrix-vsfs");
    add_case::<advanced4::AdvancedMatrixCs>(&mut group, "advanced-matrix-cs");
    add_case::<advanced4::NegativeApiBind>(&mut group, "negative-api-bind");
    add_case::<advanced4::NegativeGlslCompileTime>(&mut group, "negative-glsl-compileTime");
    add_case::<advanced4::NegativeGlslLinkTime>(&mut group, "negative-glsl-linkTime");
    group
}
