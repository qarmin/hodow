// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fBuiltinPrecisionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The actual framework and every ported function class live in `gls::
// builtin_precision_tests` (upstream's own `glsBuiltinPrecisionTests.cpp` is itself
// `modules/glshared/`, shared with `gles3::functional::builtin_precision_tests`) - this
// is only the thin per-API wrapper `es31fBuiltinPrecisionTests.cpp` is: which shader
// stages to run every ported function (`createES3BuiltinCases`) in, and where in the
// tree to nest the result. Upstream also registers `es31Cases`
// (`FrExp`/`LdExp`/`Fma`) run with `{Vertex, Fragment, Compute}`; not ported, so only
// the `es3Cases`/`{Compute}` half is here.

use crate::gls::builtin_precision_tests::{BinaryOp, TernaryOp, UnaryOp, VecScalarOp2};
use crate::glu::{ShaderType, TestCaseGroup};

/// `createBuiltinPrecisionTests` - upstream's `group` is named `"precision"` and
/// registered as a child of `ShaderBuiltinFunctionTests` (`"builtin_functions"`), which
/// is where `dEQP-GLES31.functional.shaders.builtin_functions.precision.*` comes from.
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
            &[ShaderType::Compute],
        ));
    }
    for op in [TernaryOp::Clamp, TernaryOp::Mix, TernaryOp::SmoothStep] {
        precision_group.add_child(crate::gls::builtin_precision_tests::ternary_op_group(
            op,
            &[ShaderType::Compute],
        ));
    }
    // `Fma` comes from upstream's `es31Cases` (`FrExp`/`LdExp`/`Fma`), not the shared
    // `es3Cases` every other function above comes from, and runs in all three stages
    // there (`{Vertex, Fragment, Compute}`), not `{Compute}` alone - confirmed against
    // the real mustpass (`gles31-main.txt`'s 36 `precision.fma.*` cases span
    // `highp_vertex`/`highp_fragment`/`highp_compute`/... for every `GenType`). See
    // `TernaryOp::Fma`'s own doc comment for its extension requirement.
    precision_group.add_child(crate::gls::builtin_precision_tests::ternary_op_group(
        TernaryOp::Fma,
        &[ShaderType::Vertex, ShaderType::Fragment, ShaderType::Compute],
    ));
    // `Modf` (`es3Cases`, `{Compute}` here) - scalar-only/two-output, see its module
    // note in `gls::builtin_precision_tests`.
    precision_group.add_child(crate::gls::builtin_precision_tests::modf_group(&[ShaderType::Compute]));
    for op in [VecScalarOp2::Dot, VecScalarOp2::Distance] {
        precision_group.add_child(crate::gls::builtin_precision_tests::vec_scalar2_group(
            op,
            &[ShaderType::Compute],
        ));
    }
    precision_group.add_child(crate::gls::builtin_precision_tests::length_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::normalize_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::cross_group(&[ShaderType::Compute]));
    precision_group.add_child(crate::gls::builtin_precision_tests::face_forward_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::reflect_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::refract_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::matrix_comp_mult_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::outer_product_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::transpose_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::determinant_group(&[
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::inverse_group(&[
        ShaderType::Compute,
    ]));
    // `FrExp`/`LdExp` come from upstream's `es31Cases` (`FrExp`/`LdExp`/`Fma`), same as
    // `Fma` above - `{Vertex, Fragment, Compute}`, not `{Compute}` alone. Confirmed
    // against the real mustpass (`gles31-main.txt` has 36 `precision.frexp.*` and 36
    // `precision.ldexp.*` cases spanning all three stages; `gles3-main.txt` has zero of
    // either).
    precision_group.add_child(crate::gls::builtin_precision_tests::ldexp_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Compute,
    ]));
    precision_group.add_child(crate::gls::builtin_precision_tests::frexp_group(&[
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Compute,
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
            &[ShaderType::Compute],
        ));
    }
    group.add_child(precision_group);
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn matches_the_real_gles31_mustpass_case_names() {
        let group = create_tests();
        let flat = crate::tcu::flatten(group);
        let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
        names.sort();
        assert_eq!(names.len(), 777);
        assert!(names.contains(&"builtin_functions.precision.fma.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.fma.mediump_vertex.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.fma.lowp_fragment.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.modf.highp_compute".to_string()));
        assert!(names.contains(&"builtin_functions.precision.dot.lowp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.distance.mediump_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.length.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.normalize.lowp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cross.mediump_compute".to_string()));
        assert!(names.contains(&"builtin_functions.precision.faceforward.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.reflect.lowp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.refract.mediump_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.matrixcompmult.highp_compute.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.outerproduct.lowp_compute.mat4x3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.transpose.mediump_compute.mat3x4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.determinant.highp_compute.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.inverse.lowp_compute.mat2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.ldexp.highp_vertex.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.frexp.mediump_fragment.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.add.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atan2.lowp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sub.lowp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mul.mediump_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.div.highp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sin.highp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cos.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.asin.lowp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.acos.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atan.mediump_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.min.lowp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.max.mediump_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.clamp.highp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.radians.mediump_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.degrees.highp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.exp.highp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.log.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.tan.lowp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sinh.highp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.cosh.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.tanh.lowp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.atanh.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.inversesqrt.mediump_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sqrt.highp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.exp2.lowp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.log2.highp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.asinh.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.acosh.lowp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.pow.highp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.abs.mediump_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.sign.highp_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.floor.lowp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.trunc.highp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.round.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.roundeven.lowp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.ceil.highp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.fract.mediump_compute.scalar".to_string()));
        assert!(names.contains(&"builtin_functions.precision.step.highp_compute.vec3".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mod.lowp_compute.vec4".to_string()));
        assert!(names.contains(&"builtin_functions.precision.mix.highp_compute.vec2".to_string()));
        assert!(names.contains(&"builtin_functions.precision.smoothstep.mediump_compute.scalar".to_string()));
    }
}
