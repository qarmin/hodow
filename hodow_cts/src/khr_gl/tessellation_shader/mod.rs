// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. One file per upstream test file next to this one; `utils.rs` is `TessellationShaderUtils`. All 140 cases of the group are registered. Written without compiling.

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

mod barrier;
mod errors;
mod invariance;
mod invariance_rules_1_to_5;
mod invariance_rules_6_7;
mod isolines;
mod max_patch_vertices;
mod points;
mod primitive_coverage;
mod program_interfaces;
mod properties;
mod quads;
mod tcte_data_pass_through;
mod tcte_gl_in;
mod tcte_max_patch_vertices;
mod tcte_patch_vertices_in;
mod tcte_tess_level;
mod tess_input_patch_discard;
mod tess_invocation_id;
mod tess_max_in_out;
mod tess_tess_coord;
mod triangles;
mod utils;
mod vertex_ordering;
mod vertex_spacing;
mod winding;
mod xfb;

use utils::{PrimitiveMode, VertexOrdering, VertexSpacing};

use super::esext::{ExtParameters, TestCaseBase};
use crate::glu::{TestCase, TestCaseGroup, TestNode};
use crate::glw::{self, GLint, GLuint};

const TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Tessellation shader functionality not supported, skipping";

/// `TestCaseBase::shaderSourceSpecialized` for one source string.
fn shader_source_specialized(gl: &glw::Functions, base: &TestCaseBase, shader: GLuint, body: &str) {
    let merged = base.specialize_shader(&[body]);
    let pointer = merged.as_ptr().cast::<glw::GLchar>();
    let length = merged.len() as GLint;
    gl!(gl.shader_source(shader, 1, &pointer, &length));
}

/// `TessellationShaderTests::init`
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tessellation_shader");

    let mut vertex_group = TestCaseGroup::new("vertex");
    vertex_group.add_child(Box::new(vertex_ordering::VertexOrderingCase { ext_params }) as Box<dyn TestCase>);
    for primitive_mode in [PrimitiveMode::Isolines, PrimitiveMode::Triangles, PrimitiveMode::Quads] {
        for vs_mode in VertexSpacing::ALL {
            vertex_group.add_child(Box::new(vertex_spacing::VertexSpacingCase::new(
                ext_params,
                primitive_mode,
                vs_mode,
            )) as Box<dyn TestCase>);
        }
    }
    group.add_child(TestNode::Group(vertex_group));

    let mut single = TestCaseGroup::new("single");
    single.add_child(Box::new(properties::DefaultContextWideValues { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(isolines::Isolines { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(program_interfaces::ProgramInterfaces { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(properties::ProgramObject { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(xfb::Xfb { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(max_patch_vertices::MaxPatchVertices { ext_params }) as Box<dyn TestCase>);
    single.add_child(Box::new(primitive_coverage::PrimitiveCoverage { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(single));

    let mut quads_group = TestCaseGroup::new("tessellation_shader_quads_tessellation");
    quads_group.add_child(Box::new(quads::DegenerateCase { ext_params }) as Box<dyn TestCase>);
    quads_group.add_child(Box::new(quads::InnerTessellationLevelRounding { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(quads_group));

    let mut points_group = TestCaseGroup::new("tessellation_shader_point_mode");
    points_group.add_child(Box::new(points::PointSize { ext_params }) as Box<dyn TestCase>);
    points_group.add_child(Box::new(points::Verification { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(points_group));

    let mut tessellation_group = TestCaseGroup::new("tessellation_shader_tessellation");
    tessellation_group.add_child(
        Box::new(tess_invocation_id::InvocationIdPatchVerticesInPrimitiveId { ext_params }) as Box<dyn TestCase>,
    );
    tessellation_group.add_child(Box::new(tess_tess_coord::TessCoord {
        ext_params,
        test_type: utils::TestType::TcsTes,
    }) as Box<dyn TestCase>);
    tessellation_group.add_child(Box::new(tess_tess_coord::TessCoord {
        ext_params,
        test_type: utils::TestType::Tes,
    }) as Box<dyn TestCase>);
    tessellation_group
        .add_child(Box::new(tess_input_patch_discard::InputPatchDiscard { ext_params }) as Box<dyn TestCase>);
    tessellation_group.add_child(Box::new(tess_max_in_out::MaxInOut { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(tessellation_group));

    let mut triangles_group = TestCaseGroup::new("tessellation_shader_triangles_tessellation");
    triangles_group.add_child(Box::new(triangles::DegenerateTriangle { ext_params }) as Box<dyn TestCase>);
    triangles_group.add_child(Box::new(triangles::IdenticalTriangles { ext_params }) as Box<dyn TestCase>);
    triangles_group.add_child(Box::new(triangles::InnerTessellationLevelRounding { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(triangles_group));

    let mut tcte = TestCaseGroup::new("tessellation_control_to_tessellation_evaluation");
    tcte.add_child(Box::new(tcte_data_pass_through::DataPassThrough { ext_params }) as Box<dyn TestCase>);
    tcte.add_child(Box::new(tcte_gl_in::GlIn { ext_params }) as Box<dyn TestCase>);
    for primitive_mode in [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles] {
        for vertex_ordering in [VertexOrdering::Ccw, VertexOrdering::Cw, VertexOrdering::Default] {
            for vertex_spacing in VertexSpacing::ALL {
                for point_mode in [false, true] {
                    tcte.add_child(
                        Box::new(tcte_max_patch_vertices::MaxPatchVerticesPositionPointSize::new(
                            ext_params,
                            primitive_mode,
                            vertex_ordering,
                            vertex_spacing,
                            point_mode,
                        )) as Box<dyn TestCase>,
                    );
                }
            }
        }
    }
    tcte.add_child(Box::new(tcte_patch_vertices_in::GlPatchVerticesIn { ext_params }) as Box<dyn TestCase>);
    tcte.add_child(Box::new(tcte_tess_level::GlTessLevel { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(tcte));

    let mut barrier_group = TestCaseGroup::new("tessellation_shader_tc_barriers");
    for kind in [
        barrier::Kind::GuardedReadCalls,
        barrier::Kind::GuardedWriteCalls,
        barrier::Kind::GuardedReadWriteCalls,
    ] {
        barrier_group.add_child(Box::new(barrier::Barrier { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(barrier_group));

    let mut errors_group = TestCaseGroup::new("compilation_and_linking_errors");
    for kind in errors::ALL_KINDS {
        errors_group.add_child(Box::new(errors::ErrorCase { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(errors_group));

    let mut invariance_group = TestCaseGroup::new("tessellation_invariance");
    for (name, kind) in [
        ("invariance_rule1", invariance::RuleKind::Rule1),
        ("invariance_rule2", invariance::RuleKind::Rule2),
        ("invariance_rule3", invariance::RuleKind::Rule3),
        ("invariance_rule4", invariance::RuleKind::Rule4),
        ("invariance_rule5", invariance::RuleKind::Rule5),
        ("invariance_rule6", invariance::RuleKind::Rule6),
        ("invariance_rule7", invariance::RuleKind::Rule7),
    ] {
        invariance_group.add_child(Box::new(invariance::Invariance { ext_params, name, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(invariance_group));

    let mut winding_group = TestCaseGroup::new("winding");
    for (name, primitive_type, winding) in [
        ("triangles_ccw", "triangles", "ccw"),
        ("triangles_cw", "triangles", "cw"),
        ("quads_ccw", "quads", "ccw"),
        ("quads_cw", "quads", "cw"),
    ] {
        winding_group.add_child(Box::new(winding::WindingCase {
            ext_params,
            name,
            primitive_type,
            winding,
        }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(winding_group));

    group
}
