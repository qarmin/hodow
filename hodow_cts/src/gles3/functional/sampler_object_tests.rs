// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fSamplerObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Pure data: every case is a
// `gls::sampler_object_tests::TestSpec`/`MultiTestSpec`, and the six groups below only
// differ in which texture target they exercise - the `SamplingState` values are
// identical across `single_tex_2d`/`single_tex_3d`/`single_cubemap` (and again across
// the three `multi_*` groups) in upstream's own source, so they are transcribed once
// and reused for all three targets rather than retyped three times over.

use crate::gls::sampler_object_tests::{
    MultiTestSpec, SamplingState, TestSpec, make_multi_texture_sampler_case, make_texture_sampler_case,
};
use crate::glu::TestCaseGroup;
use crate::glw::{self, GLenum};

/// `SamplerObjectTests::init`'s `simpleTestCases`/`simpleTestCases3D`/
/// `simpleTestCasesCube` - identical `SamplingState` data across all three targets.
const SINGLE_CASES: &[(&str, SamplingState, SamplingState)] = &[
    (
        "diff_wrap_t",
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_MIRRORED_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
    ),
    (
        "diff_wrap_s",
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_MIRRORED_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
    ),
    (
        "diff_wrap_r",
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_MIRRORED_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
    ),
    (
        "diff_min_filter",
        SamplingState {
            min_filter: glw::GL_LINEAR,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
    ),
    (
        "diff_mag_filter",
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_LINEAR,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
    ),
    (
        "diff_max_lod",
        SamplingState {
            min_filter: glw::GL_NEAREST_MIPMAP_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST_MIPMAP_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: -1000.0,
            max_lod: -999.0,
        },
    ),
    (
        "diff_min_lod",
        SamplingState {
            min_filter: glw::GL_NEAREST_MIPMAP_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: 0.0,
            max_lod: 1000.0,
        },
        SamplingState {
            min_filter: glw::GL_NEAREST_MIPMAP_NEAREST,
            mag_filter: glw::GL_NEAREST,
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_lod: 100.0,
            max_lod: 1000.0,
        },
    ),
];

/// `SamplerObjectTests::init`'s `multiTestCases`/`multiTestCases3D`/
/// `multiTestCasesCube` - `textureState1`/`textureState2` are identical to each other in
/// every one of upstream's own case entries.
const MULTI_CASES: &[(&str, SamplingState, SamplingState)] = SINGLE_CASES;

fn single_group(name: &'static str, target: GLenum) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &(case_name, texture_state, sampler_state) in SINGLE_CASES {
        group.add_child(make_texture_sampler_case(TestSpec {
            name: case_name,
            target,
            texture_state,
            sampler_state,
        }));
    }
    group
}

fn multi_group(name: &'static str, target: GLenum) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &(case_name, texture_state, sampler_state) in MULTI_CASES {
        group.add_child(make_multi_texture_sampler_case(MultiTestSpec {
            name: case_name,
            target,
            texture_state1: texture_state,
            texture_state2: texture_state,
            sampler_state,
        }));
    }
    group
}

/// `SamplerObjectTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("samplers");
    group.add_child(single_group("single_tex_2d", glw::GL_TEXTURE_2D));
    group.add_child(multi_group("multi_tex_2d", glw::GL_TEXTURE_2D));
    group.add_child(single_group("single_tex_3d", glw::GL_TEXTURE_3D));
    group.add_child(multi_group("multi_tex_3d", glw::GL_TEXTURE_3D));
    group.add_child(single_group("single_cubemap", glw::GL_TEXTURE_CUBE_MAP));
    group.add_child(multi_group("multi_cubemap", glw::GL_TEXTURE_CUBE_MAP));
    group
}
