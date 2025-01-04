// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBuiltinPrecisionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The actual framework and every ported function class live in `gls::
// builtin_precision_tests` (upstream's own `glsBuiltinPrecisionTests.cpp` is itself
// `modules/glshared/`, shared with `gles31::functional::builtin_precision_tests`) -
// this is only the thin per-API wrapper `es3fBuiltinPrecisionTests.cpp` is: which
// shader stages to run every ported function (`createES3BuiltinCases`) in -
// `{Vertex, Fragment}` here, since GLES3 has no compute shaders at all - and where in
// the tree to nest the result.

use crate::gls::builtin_precision_tests::{BinaryOp, TernaryOp, UnaryOp, VecScalarOp2};
use crate::glu::{ShaderType, TestCaseGroup};

/// `createBuiltinPrecisionTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin_functions");
    let mut precision_group = TestCaseGroup::new("precision");
    for op in [
        BinaryOp::Add,
        BinaryOp::Sub,
        BinaryOp::Mul,
        BinaryOp::Div,
        BinaryOp::Min,
        BinaryOp::Max,
        BinaryOp::ATan2,
        BinaryOp::Pow,
        BinaryOp::Step,
        BinaryOp::Mod,
    ] {
        precision_group.add_child(crate::gls::builtin_precision_tests::binary_op_group(
            op,
            &[ShaderType::Vertex, ShaderType::Fragment],
        ));
    }
    for op in [TernaryOp::Clamp, TernaryOp::Mix, TernaryOp::SmoothStep] {
        precision_group.add_child(crate::gls::builtin_precision_tests::ternary_op_group(
            op,
            &[ShaderType::Vertex, ShaderType::Fragment],
        ));
    }
    // `Modf` is scalar-only/two-output (`SimpleFuncCaseFactory`), not vectorized over
    // `GenType` - see its own module note in `gls::builtin_precision_tests`. `Fma` is
    // deliberately absent here: it comes from upstream's `es31Cases`, not the shared
    // `es3Cases` this wrapper's whole function list comes from - confirmed against the
    // real mustpass (`gles3-main.txt` has zero `precision.fma.*` cases) - see
    // `TernaryOp::Fma`'s own doc comment.
    precision_group.add_child(crate::gls::builtin_precision_tests::modf_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    for op in [VecScalarOp2::Dot, VecScalarOp2::Distance] {
        precision_group.add_child(crate::gls::builtin_precision_tests::vec_scalar2_group(
            op,
            &[ShaderType::Vertex, ShaderType::Fragment],
        ));
    }
    precision_group.add_child(crate::gls::builtin_precision_tests::length_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::normalize_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::cross_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::face_forward_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::reflect_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::refract_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::matrix_comp_mult_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::outer_product_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::transpose_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::determinant_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::inverse_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
    ]));
    for op in [
        UnaryOp::Radians,
        UnaryOp::Degrees,
        UnaryOp::Sin,
        UnaryOp::Cos,
        UnaryOp::ASin,
        UnaryOp::ACos,
        UnaryOp::ATan,
        UnaryOp::Exp,
        UnaryOp::Log,
        UnaryOp::Tan,
        UnaryOp::Sinh,
        UnaryOp::Cosh,
        UnaryOp::Tanh,
        UnaryOp::ATanh,
        UnaryOp::InverseSqrt,
        UnaryOp::Sqrt,
        UnaryOp::Exp2,
        UnaryOp::Log2,
        UnaryOp::ASinh,
        UnaryOp::ACosh,
        UnaryOp::Abs,
        UnaryOp::Sign,
        UnaryOp::Floor,
        UnaryOp::Trunc,
        UnaryOp::Round,
        UnaryOp::RoundEven,
        UnaryOp::Ceil,
        UnaryOp::Fract,
    ] {
        precision_group.add_child(crate::gls::builtin_precision_tests::unary_op_group(
            op,
            &[ShaderType::Vertex, ShaderType::Fragment],
        ));
    }
    group.add_child(precision_group);
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn matches_the_real_gles3_mustpass_case_names() {
        let group = create_tests();
        let flat = crate::tcu::flatten(group);
        let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
        names.sort();
        assert_eq!(names.len(), 1338);
        assert!(names.contains(&"builtin_functions.precision.modf.highp_vertex".to_string()));
        assert!(names.contains(&"builtin_functions.precision.modf.lowp_fragment".to_string()));
        assert!(names.contains(&"builtin_functions.precision.dot.mediump_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.distance.highp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.length.lowp_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.normalize.mediump_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cross.highp_vertex".to_string()));
        assert!(names.contains(&"builtin_functions.precision.faceforward.mediump_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.reflect.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.refract.lowp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.matrixcompmult.highp_vertex.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.outerproduct.mediump_fragment.mat3x2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.transpose.lowp_vertex.mat4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.determinant.highp_fragment.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.inverse.mediump_vertex.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.add.highp_vertex.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atan2.mediump_fragment.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sub.mediump_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mul.lowp_vertex.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.div.highp_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.min.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.max.lowp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.clamp.mediump_vertex.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sin.highp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cos.mediump_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.asin.lowp_fragment.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.acos.highp_vertex.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atan.mediump_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.radians.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.degrees.lowp_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.exp.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.log.mediump_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.tan.lowp_vertex.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sinh.highp_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cosh.mediump_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.tanh.lowp_fragment.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atanh.highp_vertex.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.inversesqrt.mediump_fragment.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sqrt.highp_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.exp2.lowp_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.log2.highp_vertex.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.asinh.mediump_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.acosh.lowp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.pow.highp_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.abs.mediump_vertex.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sign.highp_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.floor.lowp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.trunc.highp_fragment.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.round.mediump_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.roundeven.lowp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.ceil.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.fract.mediump_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.step.highp_vertex.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mod.lowp_fragment.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mix.highp_vertex.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.smoothstep.mediump_fragment.scalar".to_string()));
    }
}
