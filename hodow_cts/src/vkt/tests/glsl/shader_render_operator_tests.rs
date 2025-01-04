// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderOperatorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders (`ShaderOperatorCase::setupShaderData`) and the case table are written by
// `scripts/gen_shader_render_operator.py` for the table-driven entries of upstream's init; the binary operators of its `isNormalOp` loops, the selection and
// the sequence cases are not ported. The ~60 `eval_<name>_<type>` functions of upstream are one generic evaluator keyed by the name of the operation: the inputs are
// the user attributes read through the same swizzles as the shader, converted to the type of the input, combined componentwise (a scalar operand is broadcast), and the
// result goes through the `OperatorShaderEvaluator` scale and bias on the output channels.

use super::shader_render::{AttribTransform, ShaderEvalContext, ShaderRenderCase, case_key};
use super::shader_render_operator_cases::OPERATOR_CASES;
use crate::vkt::{TestCase, TestCaseGroup};

/// `ShaderValue`: the kind (`f`, `i`, `u`, `b`), the size and the range of one input
pub struct OperatorInput {
    pub kind: char,
    pub size: usize,
    pub min: f32,
    pub max: f32,
}

/// One row of the table `gen_shader_render_operator.py` writes.
pub struct OperatorCaseData {
    pub group: &'static str,
    pub inner: &'static str,
    pub name: &'static str,
    pub is_vertex: bool,
    pub eval: &'static str,
    pub inputs: &'static [OperatorInput],
    pub out_kind: char,
    pub out_size: usize,
    pub ref_scale: f32,
    pub ref_bias: f32,
}

const IN_SWIZZLES: [[&[usize]; 4]; 3] = [
    [&[2], &[3, 1], &[2, 0, 1], &[1, 2, 3, 0]],
    [&[0], &[1, 0], &[1, 2, 0], &[3, 2, 1, 0]],
    [&[1], &[2, 1], &[3, 1, 2], &[0, 3, 2, 1]],
];
const OUT_CHANNELS: [&[usize]; 4] = [&[0], &[1, 2], &[0, 1, 2], &[0, 1, 2, 3]];

/// `OperatorShaderEvaluator`'s `ShaderEvalContext::in[n]` through the swizzle of the shader, converted to the kind of the input
fn read_input(c: &ShaderEvalContext, ndx: usize, input: &OperatorInput) -> Vec<f64> {
    IN_SWIZZLES[ndx][input.size - 1]
        .iter()
        .map(|&channel| {
            let raw = c.inputs[ndx][channel];
            match input.kind {
                'f' => f64::from(raw),
                'i' => f64::from(raw as i32),
                'u' => f64::from(raw as u32),
                _ => f64::from(u8::from(raw > 0.0)),
            }
        })
        .collect()
}

fn wrap(kind: char, value: i64) -> f64 {
    match kind {
        'i' => f64::from(value as i32),
        'u' => f64::from(value as u32),
        _ => value as f64,
    }
}

/// One component of a componentwise operation over values of `kind`; `None` when the operation is not one of the componentwise ones
fn component(name: &str, kind: char, a: f64, b: f64, c: f64) -> Option<f64> {
    let float = kind == 'f';
    let (ai, bi) = (a as i64, b as i64);
    let (af, bf) = (a as f32, b as f32);
    let bool_of = |value: bool| f64::from(u8::from(value));
    Some(match name {
        "add" => {
            if float {
                f64::from(af + bf)
            } else {
                wrap(kind, ai.wrapping_add(bi))
            }
        }
        "sub" => {
            if float {
                f64::from(af - bf)
            } else {
                wrap(kind, ai.wrapping_sub(bi))
            }
        }
        "mul" => {
            if float {
                f64::from(af * bf)
            } else {
                wrap(kind, ai.wrapping_mul(bi))
            }
        }
        "div" => {
            if float {
                f64::from(af / bf)
            } else {
                wrap(kind, ai.wrapping_div(bi))
            }
        }
        "mod" => {
            if float {
                f64::from(af - bf * (af / bf).floor())
            } else {
                wrap(kind, ai.wrapping_rem(bi))
            }
        }
        "min" => {
            if float {
                f64::from(af.min(bf))
            } else {
                a.min(b)
            }
        }
        "max" => {
            if float {
                f64::from(af.max(bf))
            } else {
                a.max(b)
            }
        }
        "clamp" => {
            if float {
                f64::from(af.max(bf).min(c as f32))
            } else {
                a.max(b).min(c)
            }
        }
        "bitwiseAnd" => wrap(kind, ai & bi),
        "bitwiseOr" => wrap(kind, ai | bi),
        "bitwiseXor" => wrap(kind, ai ^ bi),
        "leftShift" => wrap(
            kind,
            if kind == 'u' {
                i64::from((ai as u32).wrapping_shl(bi as u32))
            } else {
                i64::from((ai as i32).wrapping_shl(bi as u32))
            },
        ),
        "rightShift" => wrap(
            kind,
            if kind == 'u' {
                i64::from((ai as u32).wrapping_shr(bi as u32))
            } else {
                i64::from((ai as i32).wrapping_shr(bi as u32))
            },
        ),
        "negate" => {
            if float {
                f64::from(-af)
            } else {
                wrap(kind, ai.wrapping_neg())
            }
        }
        "bitwiseNot" => wrap(kind, !ai),
        "nop" => a,
        "addOne" => {
            if float {
                f64::from(af + 1.0)
            } else {
                wrap(kind, ai.wrapping_add(1))
            }
        }
        "subOne" => {
            if float {
                f64::from(af - 1.0)
            } else {
                wrap(kind, ai.wrapping_sub(1))
            }
        }
        "equal" => bool_of(a == b),
        "notEqual" => bool_of(a != b),
        "lessThan" => bool_of(a < b),
        "lessThanEqual" => bool_of(a <= b),
        "greaterThan" => bool_of(a > b),
        "greaterThanEqual" => bool_of(a >= b),
        "logicalAnd" => bool_of(a != 0.0 && b != 0.0),
        "logicalOr" => bool_of(a != 0.0 || b != 0.0),
        "logicalXor" => bool_of((a != 0.0) != (b != 0.0)),
        "boolNot" => bool_of(a == 0.0),
        _ => return None,
    })
}

/// The evaluation of `name` over the inputs, one value per output component (the reductions give one)
fn evaluate(name: &str, inputs: &[Vec<f64>], kinds: &[char]) -> Option<Vec<f64>> {
    let base = ["VecScalar", "ScalarVec"]
        .iter()
        .fold(name, |name, suffix| name.strip_suffix(suffix).unwrap_or(name));
    let size = inputs.iter().map(Vec::len).max().unwrap_or(1);
    let at = |input: usize, ndx: usize| -> f64 {
        let values = &inputs[input];
        values[if values.len() == 1 { 0 } else { ndx }]
    };
    match base {
        "all" => Some(vec![f64::from(u8::from(inputs[0].iter().all(|&v| v != 0.0)))]),
        "any" => Some(vec![f64::from(u8::from(inputs[0].iter().any(|&v| v != 0.0)))]),
        "allEqual" => Some(vec![f64::from(u8::from(
            inputs[0].iter().zip(&inputs[1]).all(|(a, b)| a == b),
        ))]),
        "anyNotEqual" => Some(vec![f64::from(u8::from(
            inputs[0].iter().zip(&inputs[1]).any(|(a, b)| a != b),
        ))]),
        "seq_nse0" => Some((0..4).map(|i| inputs[1][i] + inputs[0][i]).collect()),
        "seq_nse1" => Some(vec![wrap('u', inputs[1][0] as i64 * 2)]),
        "seq_nse2" => Some((0..2).map(|i| (inputs[0][0] + inputs[2][i]).trunc()).collect()),
        "seq_nse3" => Some(inputs[1].clone()),
        "seq_se0" => Some(
            (0..4)
                .map(|i| f64::from((inputs[0][i] + 1.0 + inputs[2][i]) as f32))
                .collect(),
        ),
        "seq_se1" => Some(vec![wrap(
            'u',
            (inputs[1][0] as f32 + 1.0 + inputs[2][0] as f32) as i64,
        )]),
        "seq_se2" => Some((0..2).map(|i| (inputs[2][i] + 1.0 + inputs[0][0]).trunc()).collect()),
        "seq_se3" => Some(
            (0..4)
                .map(|i| wrap('i', inputs[1][i] as i64 + (inputs[0][i] + inputs[2][i]).trunc() as i64))
                .collect(),
        ),
        "selection" => (0..size)
            .map(|ndx| Some(if at(0, 0) != 0.0 { at(1, ndx) } else { at(2, ndx) }))
            .collect(),
        _ => (0..size)
            .map(|ndx| {
                component(
                    base,
                    kinds[0],
                    at(0, ndx),
                    if inputs.len() > 1 { at(1, ndx) } else { 0.0 },
                    if inputs.len() > 2 { at(2, ndx) } else { 0.0 },
                )
            })
            .collect(),
    }
}

/// `OperatorShaderEvaluator::evaluate` with the evaluation function of the case
fn eval_func(data: &'static OperatorCaseData) -> Box<dyn Fn(&mut ShaderEvalContext) + Send + Sync> {
    Box::new(move |c: &mut ShaderEvalContext| {
        let kinds: Vec<char> = data.inputs.iter().map(|input| input.kind).collect();
        let values: Vec<Vec<f64>> = data
            .inputs
            .iter()
            .enumerate()
            .map(|(ndx, input)| read_input(c, ndx, input))
            .collect();
        let Some(result) = evaluate(data.eval, &values, &kinds) else {
            return;
        };
        let channels = OUT_CHANNELS[data.out_size - 1];
        for (&channel, value) in channels.iter().zip(&result) {
            c.color[channel] = *value as f32 * data.ref_scale + data.ref_bias;
        }
    })
}

/// The `ShaderOperatorCaseInstance` constructor: the attribute matrices of the inputs
fn attribute_transforms(inputs: &[OperatorInput]) -> Vec<AttribTransform> {
    inputs
        .iter()
        .enumerate()
        .map(|(input_ndx, input)| {
            let (min, max) = (input.min, input.max);
            let scale = max - min;
            std::array::from_fn(|row| match (row + input_ndx) % 4 {
                0 => [scale, 0.0, 0.0, min],
                1 => [0.0, scale, 0.0, min],
                2 => [-scale, 0.0, 0.0, max],
                _ => [0.0, -scale, 0.0, max],
            })
        })
        .collect()
}

/// The cases of `ShaderOperatorTests::init` that the generator reads
pub fn create_operator_tests() -> TestCaseGroup {
    let mut tree: Vec<(&str, Vec<(&str, TestCaseGroup)>)> = Vec::new();
    for data in OPERATOR_CASES.iter() {
        if !tree.iter().any(|(name, _)| *name == data.group) {
            tree.push((data.group, Vec::new()));
        }
        let inner_groups = &mut tree
            .iter_mut()
            .find(|(name, _)| *name == data.group)
            .expect("the group")
            .1;
        if !inner_groups.iter().any(|(name, _)| *name == data.inner) {
            inner_groups.push((
                data.inner,
                TestCaseGroup::new(if data.inner.is_empty() { data.group } else { data.inner }),
            ));
        }
        let inner = &mut inner_groups
            .iter_mut()
            .find(|(name, _)| *name == data.inner)
            .expect("the inner group")
            .1;
        let key = case_key(
            "operator",
            &format!("{}_{}_{}", data.group, data.inner, data.name).replace("__", "_"),
        );
        let case =
            ShaderRenderCase::with_closure(data.name.to_string(), key, data.is_vertex, eval_func(data), Vec::new())
                .with_user_attributes(attribute_transforms(data.inputs))
                .with_grid_size(if data.is_vertex { 92 } else { 4 });
        inner.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    let mut group = TestCaseGroup::new("operator");
    for (outer_name, inner_groups) in tree {
        let mut outer = TestCaseGroup::new(outer_name);
        for (inner_name, inner) in inner_groups {
            // `selection` has its cases directly in the group: they were collected under the empty inner name
            if inner_name.is_empty() {
                outer = inner;
                continue;
            }
            outer.add_child(inner);
        }
        group.add_child(outer);
    }
    group
}
