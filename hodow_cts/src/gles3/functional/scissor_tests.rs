// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fScissorTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// All 26 of upstream's cases are registered: the 14 `ScissorPrimitiveCase`s
// (`contained_quads`/`partial_quads`/.../`outside_render_point` - note the first two
// names differ from GLES2's own `contained_tris`/`partial_tris`, the only naming
// difference between the two APIs' otherwise-identical tables), the 3
// `ScissorClearCase`s (`clear_depth`/`clear_stencil`/`clear_color`), the 6
// `FramebufferClearCase`s and the 3 `FramebufferBlitCase`s - closing the group.

use crate::gls::scissor_tests::{
    PrimitiveType, create_clear_tests, create_framebuffer_blit_tests, create_framebuffer_clear_tests,
    scissor_primitive_case,
};
use crate::glu::TestCaseGroup;
use crate::tcu::Vec4;

/// `ScissorTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("scissor");

    #[rustfmt::skip]
    let primitive_cases: [(&'static str, Vec4, Vec4, PrimitiveType, i32); 14] = [
        ("contained_quads",      Vec4::new(0.1, 0.1, 0.8, 0.8), Vec4::new(0.2, 0.2, 0.6, 0.6), PrimitiveType::Triangle, 30),
        ("partial_quads",        Vec4::new(0.3, 0.3, 0.4, 0.4), Vec4::new(0.2, 0.2, 0.6, 0.6), PrimitiveType::Triangle, 30),
        ("contained_tri",        Vec4::new(0.1, 0.1, 0.8, 0.8), Vec4::new(0.2, 0.2, 0.6, 0.6), PrimitiveType::Triangle, 1),
        ("enclosing_tri",        Vec4::new(0.4, 0.4, 0.2, 0.2), Vec4::new(0.2, 0.2, 0.6, 0.6), PrimitiveType::Triangle, 1),
        ("partial_tri",          Vec4::new(0.4, 0.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 1.0, 1.0), PrimitiveType::Triangle, 1),
        ("outside_render_tri",   Vec4::new(1.4, 1.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 0.6, 0.6), PrimitiveType::Triangle, 1),
        ("partial_lines",        Vec4::new(0.4, 0.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 1.0, 1.0), PrimitiveType::Line, 30),
        ("contained_line",       Vec4::new(0.1, 0.1, 0.8, 0.8), Vec4::new(0.2, 0.2, 0.6, 0.6), PrimitiveType::Line, 1),
        ("partial_line",         Vec4::new(0.4, 0.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 1.0, 1.0), PrimitiveType::Line, 1),
        ("outside_render_line",  Vec4::new(1.4, 1.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 0.6, 0.6), PrimitiveType::Line, 1),
        ("contained_point",      Vec4::new(0.1, 0.1, 0.8, 0.8), Vec4::new(0.5, 0.5, 0.0, 0.0), PrimitiveType::Point, 1),
        ("partial_points",       Vec4::new(0.4, 0.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 1.0, 1.0), PrimitiveType::Point, 30),
        ("outside_point",        Vec4::new(0.4, 0.4, 0.6, 0.6), Vec4::new(0.0, 0.0, 0.0, 0.0), PrimitiveType::Point, 1),
        ("outside_render_point", Vec4::new(1.4, 1.4, 0.6, 0.6), Vec4::new(0.5, 0.5, 0.0, 0.0), PrimitiveType::Point, 1),
    ];

    for (name, scissor_area, render_area, primitive_type, primitive_count) in primitive_cases {
        group.add_child(scissor_primitive_case(
            name,
            scissor_area,
            render_area,
            primitive_type,
            primitive_count,
        ));
    }

    for case in create_clear_tests() {
        group.add_child(case);
    }
    for case in create_framebuffer_clear_tests() {
        group.add_child(case);
    }
    for case in create_framebuffer_blit_tests() {
        group.add_child(case);
    }
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn create_tests_registers_exactly_the_real_mustpass_names() {
        let group = create_tests();
        let mut names: Vec<String> = group
            .children()
            .iter()
            .map(|c| match c {
                crate::tcu::TestNode::Case(c) => c.name().to_string(),
                crate::tcu::TestNode::Group(_) => panic!("scissor has no nested groups"),
            })
            .collect();
        names.sort();

        let mut expected: Vec<String> = [
            "contained_quads",
            "partial_quads",
            "contained_tri",
            "enclosing_tri",
            "partial_tri",
            "outside_render_tri",
            "partial_lines",
            "contained_line",
            "partial_line",
            "outside_render_line",
            "contained_point",
            "partial_points",
            "outside_point",
            "outside_render_point",
            "clear_depth",
            "clear_stencil",
            "clear_color",
            "clear_fixed_buffer",
            "clear_int_buffer",
            "clear_uint_buffer",
            "clear_depth_buffer",
            "clear_stencil_buffer",
            "clear_depth_stencil_buffer",
            "framebuffer_blit_center",
            "framebuffer_blit_corner",
            "framebuffer_blit_none",
        ]
        .iter()
        .map(|s| s.to_string())
        .collect();
        expected.sort();

        assert_eq!(names.len(), 26);
        assert_eq!(names, expected);
    }
}
