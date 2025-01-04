// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderUniformIntegerFunctionTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2018 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The sixth and last `shaders.builtin_functions` subgroup (`uniform`, 72 gles31 cases, 0
// gles3 - this file has no ES3 counterpart at all). Small and self-contained (235 lines
// upstream): checks that `findMSB`/`findLSB` at their two edge inputs (`0`, `-1` - the
// two values every lane's bits equal the sign bit, where GLSL defines the answer as `-1`)
// give the same answer whether read out through an output variable or used directly
// inside a boolean expression, since a driver could constant-fold the two call sites
// differently. Uses `gls::shader_exec_util` like every other function here - no
// rendering, so this is squarely in scope (unlike `texture_size`, sized but not started
// this session - see the progress log's own note on why).
//
// The one shape this file has that no other function in this campaign needed yet: `value`
// is a real GLSL `uniform`, set through `gl.uniform_1i` after linking, not one of
// `ShaderSpec`'s own `inputs` - `m_spec.inputs` stays empty and `execute()` is called with
// no input buffers at all (matches upstream's own `m_executor->execute(1, nullptr,
// &outputPointers[0])`).

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::{TestError, TestOutcome, TestStatus};

fn stage_name_postfix(stage: ShaderType) -> &'static str {
    match stage {
        ShaderType::Vertex => "vertex",
        ShaderType::Fragment => "fragment",
        ShaderType::Geometry => "geometry",
        ShaderType::TessControl => "tess_control",
        ShaderType::TessEvaluation => "tess_eval",
        ShaderType::Compute => "compute",
    }
}

const ALL_STAGES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];
const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

/// `de::findMSB(int32_t)`
fn find_msb_i32(value: i32) -> i32 {
    let as_u32 = if value < 0 { !(value as u32) } else { value as u32 };
    31 - as_u32.leading_zeros() as i32
}

/// `de::findLSB(uint32_t)` - `value ? deCtz32(value) : -1`.
fn find_lsb_i32(value: i32) -> i32 {
    if value == 0 { -1 } else { value.trailing_zeros() as i32 }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum UniformFn {
    FindMsb,
    FindLsb,
}

impl UniformFn {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::FindMsb => "findMSB",
            Self::FindLsb => "findLSB",
        }
    }

    fn expected(self, input: i32) -> i32 {
        match self {
            Self::FindMsb => find_msb_i32(input),
            Self::FindLsb => find_lsb_i32(input),
        }
    }
}

/// `UniformIntegerFunctionCase`
struct UniformIntegerCase {
    name: String,
    func: UniformFn,
    input: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for UniformIntegerCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let expected = self.func.expected(self.input);
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es310);
        spec.global_declarations = format!("uniform {} int value;\n", self.precision.name());
        spec.outputs.push(Symbol::new(
            "result",
            VarType::basic(DataType::Int, Some(Precision::LowP)),
        ));
        spec.outputs
            .push(Symbol::new("comparison", VarType::basic(DataType::Bool, None)));
        spec.source = format!(
            "result = {}(value);\ncomparison = ({}(value) == {});\n",
            self.func.glsl_name(),
            self.func.glsl_name(),
            expected
        );
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let value_loc = unsafe { gl.get_uniform_location(executor.program(), c"value".as_ptr()) };
        unsafe { gl.uniform_1i(value_loc, self.input) };

        let mut result = [0u8; 4];
        let mut comparison = [0u8; 4];
        {
            let inputs: [&[u8]; 0] = [];
            let mut outputs: [&mut [u8]; 2] = [&mut result, &mut comparison];
            executor.execute(1, &inputs, &mut outputs)?;
        }

        let result_i = i32::from_ne_bytes(result);
        let comparison_i = i32::from_ne_bytes(comparison);

        if result_i != expected {
            Ok(TestStatus::fail(format!(
                "{}({}) == {expected}, got {result_i}",
                self.func.glsl_name(),
                self.input
            )))
        } else if comparison_i == 0 {
            Ok(TestStatus::fail(format!(
                "{}({}) == {expected} as a value, but not when used directly in a boolean expression",
                self.func.glsl_name(),
                self.input
            )))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn edge_case_group(func: UniformFn, name: &str, input: i32) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &precision in &PRECISIONS {
        for &stage in &ALL_STAGES {
            let case_name = format!("{}_{}", precision.name(), stage_name_postfix(stage));
            group.add_child(Box::new(UniformIntegerCase {
                name: case_name,
                func,
                input,
                precision,
                stage,
            }) as Box<dyn TestCase>);
        }
    }
    group
}

/// `ShaderUniformIntegerFunctionTests::init`.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("uniform");
    group.add_child(edge_case_group(UniformFn::FindMsb, "findMSBZero", 0));
    group.add_child(edge_case_group(UniformFn::FindMsb, "findMSBMinusOne", -1));
    group.add_child(edge_case_group(UniformFn::FindLsb, "findLSBZero", 0));
    group.add_child(edge_case_group(UniformFn::FindLsb, "findLSBMinusOne", -1));
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn registers_every_expected_case_name() {
        let group = create_tests();
        let flat = crate::tcu::flatten(group);
        let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
        names.sort();
        // 4 groups x 3 precisions x 6 stages. Matches the real gles31-main mustpass
        // exactly (72 cases, confirmed via `grep -c
        // 'shaders\.builtin_functions\.uniform\.'` before writing this).
        let expected = 4 * 3 * 6;
        assert_eq!(expected, 72);
        assert_eq!(names.len(), expected);
        assert!(names.contains(&"uniform.findMSBZero.highp_vertex".to_string()));
        assert!(names.contains(&"uniform.findMSBMinusOne.lowp_compute".to_string()));
        assert!(names.contains(&"uniform.findLSBZero.mediump_geometry".to_string()));
        assert!(names.contains(&"uniform.findLSBMinusOne.highp_compute".to_string()));
    }

    #[test]
    fn find_msb_lsb_match_known_edge_values() {
        // 0 and -1 are the two inputs whose bits equal the sign bit everywhere, which is
        // exactly what makes findMSB (defined as "the first bit that differs from the
        // sign bit") edge cases for both: -1.
        assert_eq!(find_msb_i32(0), -1);
        assert_eq!(find_msb_i32(-1), -1);
        // findLSB looks for the lowest *set* bit instead, so 0 (no bits set) is its own
        // edge case (-1), but -1 (every bit set) is not - its lowest set bit is bit 0,
        // an entirely ordinary answer. This file's own "findLSBMinusOne" group still
        // exercises it (matching upstream's own registration, which tests -1 for both
        // functions symmetrically regardless of whether it is actually an edge case for
        // findLSB specifically).
        assert_eq!(find_lsb_i32(0), -1);
        assert_eq!(find_lsb_i32(-1), 0);
        // Sanity check away from the edge cases this file exercises.
        assert_eq!(find_msb_i32(4), 2);
        assert_eq!(find_lsb_i32(4), 2);
    }
}
