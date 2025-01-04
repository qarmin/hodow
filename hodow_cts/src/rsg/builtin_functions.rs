// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgBuiltinFunctions.hpp (its `.cpp` is `DE_EMPTY_CPP_FILE`,
//   confirmed by reading it - everything real lives in the header, templates and all)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **One struct with a `BuiltinFunctionKind` discriminant, replacing upstream's
// three-level template hierarchy** (`UnaryBuiltinVecFunc<GetValueRangeWeight,
// ComputeValueRange, Evaluate>` -> `UnaryBuiltinVecTemplateProxy<C>` ->
// `UnaryTrigonometricFunc<C>`/`UnaryExponentialFunc<C>` -> `SinOp`/`CosOp`/.../`ExpOp`/
// `LogOp`/...) - the same "closed, enumerable list of concrete operators, not an
// open-ended hierarchy" call `rsg::expression`'s `BinaryOp`/`RelationalOp` already made
// for the sibling `rsgBinaryOps` cluster. All 12 concrete classes upstream declares are
// ported (`Sin`/`Cos`/`Tan`/`Asin`/`Acos`/`Atan`/`Exp`/`Log`/`Exp2`/`Log2`/`Sqrt`/
// `InvSqrt`) - this is the *whole* of `rsgBuiltinFunctions.hpp`, not a slice of it.
//
// **The two per-family templates (`UnaryTrigonometricFunc`/`UnaryExponentialFunc`) are
// identical code reading two different `ProgramParameters` fields** - confirmed by
// diffing the two class bodies directly: `getCompWeight`/`computeValueRange` are
// byte-for-byte the same algorithm in both, and the only real difference anywhere is
// `getWeight` multiplying by `trigonometricBaseWeight` vs `exponentialBaseWeight`. This
// port keeps one shared `unary_builtin_vec_get_weight` (the common
// `UnaryBuiltinVecFunc::getWeight` body both families inherit unchanged) and
// `BuiltinFunctionKind::base_weight` picks the right `ProgramParameters` field - no
// need for two near-identical Rust functions where upstream needed two template
// instantiations.
//
// **`deFloatAtanOver`/`deFloatSinh`/etc. are plain libm calls under upstream's own
// naming** (confirmed by reading `deMath.h` directly - `deFloatAtanOver(x)` is
// `(float)atan(x)`, nothing more), so every `evaluate_comp`/`transform_value_range`
// below calls straight through to the matching stable `f32` method
// (`f32::sin`/`asin`/`exp2`/`log2`/...) rather than reimplementing anything.
//
// **`DE_VERIFY` (upstream's "evaluate this and panic if false, in every build, unlike
// `DE_ASSERT` which compiles out under release" macro) is ported as an `.expect()`/
// `assert!` pair in `compute_value_range`** - both calls there are expected to always
// succeed, because `get_weight` already filtered out any range `transform_value_range`/
// `quantize_float_range` would refuse; a panic there means `create_random`'s own
// weighted dispatch picked a kind whose `get_weight` lied, which is exactly the
// programming-error case `DE_VERIFY` exists to catch loudly rather than silently
// propagate a bad range into the generated tree.

use super::execution_context::{EXEC_VEC_WIDTH, ExecConstValueAccess, ExecutionContext};
use super::expression::Expression;
use super::generator_state::GeneratorState;
use super::parameters::Version;
use super::token::{Token, TokenStream};
use super::utils::{get_conservative_value_expr_depth, quantize_float_range};
use super::variable::ShaderType;
use super::variable_manager::VariableManager;
use super::variable_value::{ConstValueRangeAccess, Scalar, ValueRange, ValueStorage};

/// `rsg::SinOp`/`CosOp`/.../`ExpOp`/`LogOp`/... - see this module's own top doc comment
/// for why these 12 concrete upstream classes collapse into one enum.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BuiltinFunctionKind {
    Sin,
    Cos,
    Tan,
    Asin,
    Acos,
    Atan,
    Exp,
    Log,
    Exp2,
    Log2,
    Sqrt,
    InvSqrt,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Family {
    Trigonometric,
    Exponential,
}

impl BuiltinFunctionKind {
    fn family(self) -> Family {
        match self {
            BuiltinFunctionKind::Sin
            | BuiltinFunctionKind::Cos
            | BuiltinFunctionKind::Tan
            | BuiltinFunctionKind::Asin
            | BuiltinFunctionKind::Acos
            | BuiltinFunctionKind::Atan => Family::Trigonometric,
            BuiltinFunctionKind::Exp
            | BuiltinFunctionKind::Log
            | BuiltinFunctionKind::Exp2
            | BuiltinFunctionKind::Log2
            | BuiltinFunctionKind::Sqrt
            | BuiltinFunctionKind::InvSqrt => Family::Exponential,
        }
    }

    /// `UnaryTrigonometricFunc<C>::getWeight` / `UnaryExponentialFunc<C>::getWeight`'s
    /// own `state.getProgramParameters().trigonometricBaseWeight`/
    /// `exponentialBaseWeight` read, factored out since both bodies are otherwise
    /// identical (see this module's own top doc comment).
    fn base_weight(self, state: &GeneratorState<'_>) -> f32 {
        match self.family() {
            Family::Trigonometric => state.get_program_parameters().trigonometric_base_weight,
            Family::Exponential => state.get_program_parameters().exponential_base_weight,
        }
    }

    pub fn function_name(self) -> &'static str {
        match self {
            BuiltinFunctionKind::Sin => "sin",
            BuiltinFunctionKind::Cos => "cos",
            BuiltinFunctionKind::Tan => "tan",
            BuiltinFunctionKind::Asin => "asin",
            BuiltinFunctionKind::Acos => "acos",
            BuiltinFunctionKind::Atan => "atan",
            BuiltinFunctionKind::Exp => "exp",
            BuiltinFunctionKind::Log => "log",
            BuiltinFunctionKind::Exp2 => "exp2",
            BuiltinFunctionKind::Log2 => "log2",
            BuiltinFunctionKind::Sqrt => "sqrt",
            BuiltinFunctionKind::InvSqrt => "inversesqrt",
        }
    }

    /// `SinOp`/`CosOp`/.../`InvSqrtOp::transformValueRange` - `None` is upstream's
    /// `return false` ("not possible to transform this output range - out of range").
    fn transform_value_range(self, out_min: f32, out_max: f32) -> Option<(f32, f32)> {
        match self {
            BuiltinFunctionKind::Sin => {
                if out_max < -1.0 || out_min > 1.0 {
                    return None;
                }
                let in_min = if out_min >= -1.0 {
                    out_min.asin()
                } else {
                    -0.5 * std::f32::consts::PI
                };
                let in_max = if out_max <= 1.0 {
                    out_max.asin()
                } else {
                    0.5 * std::f32::consts::PI
                };
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Cos => {
                if out_max < -1.0 || out_min > 1.0 {
                    return None;
                }
                let in_max = if out_min >= -1.0 {
                    out_min.acos()
                } else {
                    std::f32::consts::PI
                };
                let in_min = if out_max <= 1.0 {
                    out_max.acos()
                } else {
                    -std::f32::consts::PI
                };
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Tan => {
                const RANGE_MIN: f32 = -4.0;
                const RANGE_MAX: f32 = 4.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).atan();
                let in_max = out_max.min(RANGE_MAX).atan();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Asin => {
                const RANGE_MIN: f32 = -std::f32::consts::FRAC_PI_2;
                const RANGE_MAX: f32 = std::f32::consts::FRAC_PI_2;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).sin();
                let in_max = out_max.min(RANGE_MAX).sin();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Acos => {
                const RANGE_MIN: f32 = 0.0;
                const RANGE_MAX: f32 = std::f32::consts::PI;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_max = out_min.max(RANGE_MIN).cos();
                let in_min = out_max.min(RANGE_MAX).cos();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Atan => {
                const RANGE_MIN: f32 = -1.0;
                const RANGE_MAX: f32 = 1.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).tan();
                let in_max = out_max.min(RANGE_MAX).tan();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Exp => {
                const RANGE_MIN: f32 = 0.1;
                const RANGE_MAX: f32 = 10.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).ln();
                let in_max = out_max.min(RANGE_MAX).ln();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Log => {
                const RANGE_MIN: f32 = 0.1;
                const RANGE_MAX: f32 = 6.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).exp();
                let in_max = out_max.min(RANGE_MAX).exp();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Exp2 => {
                const RANGE_MIN: f32 = 0.1;
                const RANGE_MAX: f32 = 10.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).log2();
                let in_max = out_max.min(RANGE_MAX).log2();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Log2 => {
                const RANGE_MIN: f32 = 0.1;
                const RANGE_MAX: f32 = 6.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let in_min = out_min.max(RANGE_MIN).exp2();
                let in_max = out_max.min(RANGE_MAX).exp2();
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::Sqrt => {
                const RANGE_MIN: f32 = 0.0;
                const RANGE_MAX: f32 = 4.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let mut in_min = out_min.max(RANGE_MIN);
                let mut in_max = out_max.min(RANGE_MAX);
                in_min *= in_min;
                in_max *= in_max;
                Some((in_min, in_max))
            }
            BuiltinFunctionKind::InvSqrt => {
                const RANGE_MIN: f32 = 0.4;
                const RANGE_MAX: f32 = 3.0;
                if out_max < RANGE_MIN || out_min > RANGE_MAX {
                    return None;
                }
                let mut in_max = 1.0 / out_min.max(RANGE_MIN);
                let mut in_min = 1.0 / out_max.min(RANGE_MAX);
                in_min *= in_min;
                in_max *= in_max;
                Some((in_min, in_max))
            }
        }
    }

    /// `SinOp`/`CosOp`/.../`InvSqrtOp::evaluateComp`.
    fn evaluate_comp(self, in_val: f32) -> f32 {
        match self {
            BuiltinFunctionKind::Sin => in_val.sin(),
            BuiltinFunctionKind::Cos => in_val.cos(),
            BuiltinFunctionKind::Tan => in_val.tan(),
            BuiltinFunctionKind::Asin => in_val.asin(),
            BuiltinFunctionKind::Acos => in_val.acos(),
            BuiltinFunctionKind::Atan => in_val.atan(),
            BuiltinFunctionKind::Exp => in_val.exp(),
            BuiltinFunctionKind::Log => in_val.ln(),
            BuiltinFunctionKind::Exp2 => in_val.exp2(),
            BuiltinFunctionKind::Log2 => in_val.log2(),
            BuiltinFunctionKind::Sqrt => in_val.sqrt(),
            BuiltinFunctionKind::InvSqrt => 1.0 / in_val.sqrt(),
        }
    }

    /// `UnaryTrigonometricFunc<C>::getCompWeight` / `UnaryExponentialFunc<C>::
    /// getCompWeight` - identical bodies in both upstream templates (see this module's
    /// own top doc comment).
    fn get_comp_weight(self, out_min: f32, out_max: f32) -> f32 {
        if out_min == Scalar::min_float().as_float() || out_max == Scalar::max_float().as_float() {
            return 1.0; // Infinite value range, anything goes.
        }

        let Some((mut in_min, mut in_max)) = self.transform_value_range(out_min, out_max) else {
            return 0.0; // Not possible to transform value range (out of range perhaps).
        };

        if !quantize_float_range(&mut in_min, &mut in_max) {
            return 0.0; // Not possible to quantize - would cause accuracy issues.
        }

        if out_min == out_max {
            return 1.0; // Constant value and passed quantization.
        }

        let intersection_len = self.evaluate_comp(in_max) - self.evaluate_comp(in_min);
        let val_range_len = out_max - out_min;

        (intersection_len / val_range_len).max(0.1)
    }

    /// `UnaryTrigonometricFunc<C>::computeValueRange` / `UnaryExponentialFunc<C>::
    /// computeValueRange` - see this module's own top doc comment for why the two
    /// `DE_VERIFY` calls are ported as an always-evaluated panic rather than a
    /// debug-only `debug_assert!`.
    fn compute_value_range(self, out_min: f32, out_max: f32) -> (f32, f32) {
        let (mut in_min, mut in_max) = self
            .transform_value_range(out_min, out_max)
            .expect("BuiltinFunctionKind::compute_value_range: transform_value_range failed (DE_VERIFY)");

        assert!(
            quantize_float_range(&mut in_min, &mut in_max),
            "BuiltinFunctionKind::compute_value_range: quantize_float_range failed (DE_VERIFY)"
        );
        debug_assert!(in_min <= in_max);

        (in_min, in_max)
    }
}

/// `rsg::UnaryBuiltinVecFunc<GetValueRangeWeight, ComputeValueRange, Evaluate>` - see
/// this module's own top doc comment for why one struct replaces the whole template
/// stack. Operates elementwise over a `GenType` (scalar or vector) in one pass, unlike
/// `ConstructorOp`'s per-scalar-component children: there is exactly one child here,
/// matching upstream's own single `m_child`.
pub struct BuiltinFunctionOp {
    kind: BuiltinFunctionKind,
    in_value_range: ValueRange,
    value: ValueStorage,
    child: Option<Box<Expression>>,
}

impl BuiltinFunctionOp {
    /// `UnaryBuiltinVecFunc::UnaryBuiltinVecFunc(GeneratorState&, const char*,
    /// ConstValueRangeAccess)` - `state` is accepted (matching every sibling
    /// `Expression` constructor's own signature) but unused, exactly like upstream's own
    /// `DE_UNREF(state)`.
    pub fn new(
        _state: &mut GeneratorState<'_>,
        kind: BuiltinFunctionKind,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        debug_assert!(value_range.get_type().is_float_or_vec());

        let type_ = value_range.get_type().clone();
        let mut in_value_range = ValueRange::new(type_.clone());
        let value = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);

        for ndx in 0..type_.num_elements() {
            let out_comp = value_range.component(ndx);
            let (in_min, in_max) =
                kind.compute_value_range(out_comp.get_min().as_float(), out_comp.get_max().as_float());

            let mut in_access = in_value_range.as_access();
            let mut in_comp = in_access.component(ndx);
            in_comp.get_min().set_float(in_min);
            in_comp.get_max().set_float(in_max);
        }

        Self {
            kind,
            in_value_range,
            value,
            child: None,
        }
    }

    /// `UnaryBuiltinVecFunc::getWeight` - the "is this output range/depth budget even
    /// feasible" check shared by both families, with
    /// `UnaryTrigonometricFunc`/`UnaryExponentialFunc::getWeight`'s own
    /// `trigonometricBaseWeight`/`exponentialBaseWeight` gate applied first (matching
    /// upstream's own order: both subclasses check their base weight *before* calling
    /// into the shared body, short-circuiting it entirely when the base weight is
    /// `<= 0`, which is this port's default - see `rsg::parameters`).
    pub fn get_weight(
        kind: BuiltinFunctionKind,
        state: &GeneratorState<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        let base_weight = kind.base_weight(state);
        if base_weight <= 0.0 {
            return 0.0;
        }

        unary_builtin_vec_get_weight(kind, state, value_range) * base_weight
    }

    /// `UnaryBuiltinVecFunc::createNextChild` - a single child, exactly like
    /// `ParenOp::create_next_child`.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.child.is_some() {
            return None;
        }

        let child =
            super::expression_generator::create_random(state, var_manager, &self.in_value_range.as_const_access());
        self.child = Some(Box::new(child));
        self.child.as_deref_mut()
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        stream.push(Token::identifier(self.kind.function_name()));
        stream.push(Token::LeftParen);
        self.child
            .as_ref()
            .expect("BuiltinFunctionOp::tokenize: child not set")
            .tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::RightParen);
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.child
            .as_deref_mut()
            .expect("BuiltinFunctionOp::evaluate: child not set")
            .evaluate(var_manager, ctx);

        let type_ = self.in_value_range.get_type().clone();
        self.value.set_storage(&type_);

        let src = self.child.as_ref().unwrap().get_value(var_manager, ctx);
        for elem_ndx in 0..type_.num_elements() {
            let src_comp = src.component(elem_ndx);
            let mut dst = self.value.get_value(&type_);
            let mut dst_comp = dst.component(elem_ndx);
            for lane in 0..EXEC_VEC_WIDTH {
                let result = self.kind.evaluate_comp(src_comp.as_float_at(lane));
                dst_comp.set_float_at(lane, result);
            }
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(self.in_value_range.get_type())
    }
}

/// `UnaryBuiltinVecFunc<...>::getWeight`'s shared body (the part both
/// `UnaryTrigonometricFunc`/`UnaryExponentialFunc` inherit unchanged, before either
/// family's own base-weight multiply).
fn unary_builtin_vec_get_weight(
    kind: BuiltinFunctionKind,
    state: &GeneratorState<'_>,
    value_range: &ConstValueRangeAccess<'_>,
) -> f32 {
    let type_ = value_range.get_type();
    if !type_.is_float_or_vec() {
        return 0.0;
    }

    let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();
    if available_levels < get_conservative_value_expr_depth(state, value_range) + 1 {
        return 0.0;
    }

    let mut combined_weight = 1.0f32;
    for ndx in 0..type_.num_elements() {
        let comp = value_range.component(ndx);
        let elem_weight = kind.get_comp_weight(comp.get_min().as_float(), comp.get_max().as_float());
        combined_weight *= elem_weight;
    }

    combined_weight
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use super::*;
    use crate::rsg::expression::{Expression, FloatLiteral};
    use crate::rsg::parameters::ProgramParameters;
    use crate::rsg::samplers::{Sampler2DMap, SamplerCubeMap};
    use crate::rsg::variable_type::{Type, VariableType};
    use crate::tcu::random::Random;

    fn new_state<'a>(params: &'a ProgramParameters, random: &'a mut Random) -> GeneratorState<'a> {
        GeneratorState::new(params, random)
    }

    fn scalar_float_range(min: f32, max: f32) -> ValueRange {
        let mut r = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        r.get_min().set_float(min);
        r.get_max().set_float(max);
        r
    }

    #[test]
    fn transform_value_range_matches_hand_computed_asin_acos_for_sin_and_cos() {
        // SinOp: outMin=0, outMax=1 -> inMin=asin(0)=0, inMax=asin(1)=pi/2.
        let (in_min, in_max) = BuiltinFunctionKind::Sin.transform_value_range(0.0, 1.0).unwrap();
        assert!((in_min - 0.0).abs() < 1e-6);
        assert!((in_max - std::f32::consts::FRAC_PI_2).abs() < 1e-6);

        // CosOp: outMin=0, outMax=1 -> inMax=acos(0)=pi/2, inMin=acos(1)=0 (note the
        // min/max swap relative to Sin - cos is decreasing).
        let (in_min, in_max) = BuiltinFunctionKind::Cos.transform_value_range(0.0, 1.0).unwrap();
        assert!((in_min - 0.0).abs() < 1e-6);
        assert!((in_max - std::f32::consts::FRAC_PI_2).abs() < 1e-6);

        // Out of range for both: outMin=2, outMax=3 is entirely above [-1, 1].
        assert!(BuiltinFunctionKind::Sin.transform_value_range(2.0, 3.0).is_none());
        assert!(BuiltinFunctionKind::Cos.transform_value_range(2.0, 3.0).is_none());
    }

    #[test]
    fn transform_value_range_sqrt_and_inv_sqrt_square_their_clamped_bounds() {
        // SqrtOp: outMin=1, outMax=2 (within [0,4]) -> inMin=1*1=1, inMax=2*2=4.
        let (in_min, in_max) = BuiltinFunctionKind::Sqrt.transform_value_range(1.0, 2.0).unwrap();
        assert!((in_min - 1.0).abs() < 1e-6);
        assert!((in_max - 4.0).abs() < 1e-6);

        // Sqrt evaluated back: sqrt(1)=1, sqrt(4)=2 - round-trips the output range.
        assert!((BuiltinFunctionKind::Sqrt.evaluate_comp(in_min) - 1.0).abs() < 1e-6);
        assert!((BuiltinFunctionKind::Sqrt.evaluate_comp(in_max) - 2.0).abs() < 1e-6);

        // InvSqrtOp: outMin=1, outMax=2 (within [0.4,3]) -> inMax=(1/1)^2=1, inMin=(1/2)^2=0.25.
        let (in_min, in_max) = BuiltinFunctionKind::InvSqrt.transform_value_range(1.0, 2.0).unwrap();
        assert!((in_min - 0.25).abs() < 1e-6);
        assert!((in_max - 1.0).abs() < 1e-6);
        assert!((BuiltinFunctionKind::InvSqrt.evaluate_comp(in_min) - 2.0).abs() < 1e-5);
        assert!((BuiltinFunctionKind::InvSqrt.evaluate_comp(in_max) - 1.0).abs() < 1e-5);
    }

    #[test]
    fn get_weight_is_zero_without_a_positive_base_weight_and_positive_once_set() {
        let mut params = ProgramParameters::default();
        let mut random = Random::new(1);
        let state = new_state(&params, &mut random);

        let range = scalar_float_range(0.0, 1.0);

        // Default base weights are both 0.0 (see `rsg::parameters`), so every builtin
        // function must report zero weight regardless of range.
        assert_eq!(
            BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sin, &state, &range.as_const_access()),
            0.0
        );
        assert_eq!(
            BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sqrt, &state, &range.as_const_access()),
            0.0
        );

        drop(state);
        params.trigonometric_base_weight = 1.0;
        params.exponential_base_weight = 1.0;
        let mut state = new_state(&params, &mut random);
        let shader_params = crate::rsg::parameters::ShaderParameters::default();
        state.set_shader_parameters(&shader_params);
        assert!(BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sin, &state, &range.as_const_access()) > 0.0);
        assert!(BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sqrt, &state, &range.as_const_access()) > 0.0);
    }

    #[test]
    fn get_weight_is_zero_for_a_non_float_type() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let state = new_state(&params, &mut random);

        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(
            BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sin, &state, &int_range.as_const_access()),
            0.0
        );
    }

    #[test]
    fn get_weight_is_zero_when_the_expression_depth_budget_is_exhausted() {
        let params = ProgramParameters {
            trigonometric_base_weight: 1.0,
            ..ProgramParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);
        let shader_params = crate::rsg::parameters::ShaderParameters {
            max_expression_depth: 1,
            ..Default::default()
        };
        state.set_shader_parameters(&shader_params);
        state.set_expression_depth(1);

        // `get_conservative_value_expr_depth` for a scalar float is 2 (one node for the
        // ctor, one for the value), so `available_levels (1-1=0) < 2 + 1` is always
        // true here - no budget left for a unary function at all.
        let range = scalar_float_range(0.0, 1.0);
        assert_eq!(
            BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sin, &state, &range.as_const_access()),
            0.0
        );
    }

    #[test]
    fn evaluate_sin_of_a_hand_built_zero_literal_child_is_zero() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);

        let range = scalar_float_range(-1.0, 1.0);
        let mut op = BuiltinFunctionOp::new(&mut state, BuiltinFunctionKind::Sin, &range.as_const_access());
        op.child = Some(Box::new(Expression::Float(FloatLiteral::new_custom(0.0))));

        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let var_manager = crate::rsg::variable_manager::VariableManager::new(&mut alloc);
        let mut expr = Expression::Builtin(op);
        expr.evaluate(&var_manager, &mut ctx);
        let value = expr.get_value(&var_manager, &mut ctx);
        for lane in 0..EXEC_VEC_WIDTH {
            assert!(value.as_float_at(lane).abs() < 1e-6, "lane {lane}");
        }
    }

    #[test]
    fn evaluate_sqrt_of_a_hand_built_four_literal_child_is_two() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);

        let range = scalar_float_range(0.0, 4.0);
        let mut op = BuiltinFunctionOp::new(&mut state, BuiltinFunctionKind::Sqrt, &range.as_const_access());
        op.child = Some(Box::new(Expression::Float(FloatLiteral::new_custom(4.0))));

        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let var_manager = crate::rsg::variable_manager::VariableManager::new(&mut alloc);
        let mut expr = Expression::Builtin(op);
        expr.evaluate(&var_manager, &mut ctx);
        let value = expr.get_value(&var_manager, &mut ctx);
        for lane in 0..EXEC_VEC_WIDTH {
            assert!((value.as_float_at(lane) - 2.0).abs() < 1e-5, "lane {lane}");
        }
    }

    #[test]
    fn tokenize_emits_function_name_and_parens_around_the_child() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);

        let range = scalar_float_range(-1.0, 1.0);
        let mut op = BuiltinFunctionOp::new(&mut state, BuiltinFunctionKind::Cos, &range.as_const_access());
        op.child = Some(Box::new(Expression::Float(FloatLiteral::new_custom(0.0))));

        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let var_manager = crate::rsg::variable_manager::VariableManager::new(&mut alloc);
        let mut stream = TokenStream::new();
        op.tokenize(&var_manager, Version::Version100, ShaderType::Vertex, &mut stream);

        assert_eq!(stream.tokens()[0], Token::Identifier("cos".to_string()));
        assert_eq!(stream.tokens()[1], Token::LeftParen);
        assert_eq!(*stream.tokens().last().unwrap(), Token::RightParen);
    }
}
