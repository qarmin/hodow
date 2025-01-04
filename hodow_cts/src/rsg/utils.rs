// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgUtils.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **Three prior sessions in this same effort (including this file's own earlier
// drafts) flagged `rsgUtils` as "not a leaf" because its header includes
// `rsgShader.hpp`** - true at the file level, but wrong at the function level: of the
// eleven free functions this file declares, only three
// (`addNewUniforms`/`computeUnifiedUniforms`/`computeUniformValues`) actually touch
// `Shader`/`ShaderInput`. The other eight need nothing beyond `tcu::random::Random`,
// `rsg::variable_type`/`rsg::variable_value` (both long ported), and - for exactly two
// of them - `rsg::generator_state`'s already-ported half (`GeneratorState::
// get_random()`). This is the exact "check which methods, not which files" mistake
// `rsg::variable`'s own doc comment already named and warned a future session not to
// repeat - and it still had to be rediscovered here, which is itself worth recording:
// the per-file include list is cheap to check and easy to trust by itself, so it keeps
// being checked instead of the real per-function dependency.
//
// **The three `Shader`-dependent functions are ported now too, once `rsg::shader`
// supplied `Shader`/`ShaderInput`**: `addNewUniforms` (file-local upstream, `static`
// equivalent - ported as a private `add_new_uniforms` helper),
// `computeUnifiedUniforms`, and `computeUniformValues`. All three needed only an
// explicit `&VariableManager` parameter beyond what `rsg::shader` already exposes - the
// same explicit-threading convention `rsg::generator_state`'s own top doc comment lays
// out, since `ShaderInput`/`VariableScope` hold `VariableId` handles rather than
// upstream's `const Variable*` (see `rsg::shader`'s own top doc comment). Two
// deliberate, Rust-idiomatic deviations, neither a behaviour change:
// `computeUnifiedUniforms`/`computeUniformValues` *return* their `Vec` rather than
// filling an out-parameter (upstream's own `DE_ASSERT(values.empty())` precondition on
// the out-parameter has nothing to assert here, since the returned `Vec` is always
// freshly built), and `addNewUniforms`'s `std::set<string>` becomes a `HashSet<String>`
// (membership-only use, confirmed by reading the whole function - nothing iterates it
// in order).
//
// **Two confirmed upstream bugs, ported faithfully rather than fixed** (per this
// project's own standing practice - see e.g. `rsg::parameters`' `declaration_statement_
// base_weight` or the SSE4A `EXTRQI`/`INSERTQI` note in `CLAUDE.md`): both
// `computeRandomValue`'s and `computeRangeLengthSum`'s `TYPE_BOOL` branch compute
// *both* `minVal` and `maxVal` from `valueRange.getMin()` - `getMax()` is never called
// for a bool range in either function. The practical effect: `compute_random_value`
// always produces a bool equal to the range's own *minimum* bound regardless of what
// the maximum bound says (`get_int(1, 1) == 1` is always true, `get_int(0, 0) == 1` is
// always false), and `compute_range_length_sum` always reports a zero-length range for
// any bool component. Confirmed by hand-tracing `rsgUtils.cpp` lines 77-78 and 312-313
// directly, not inferred - both read `.getMin()` twice, `.getMax()` nowhere in either
// branch. Each is reproduced below with a doc comment pointing back to this paragraph,
// and a unit test exercises the exact degenerate behaviour so a future "fix" doesn't
// silently change what this module checks against. Not yet a `QUIRKS.md` entry per the
// task's own rule (nothing consumes either function yet).
//
// **`compute_unified_uniforms`/`compute_uniform_values`'s own `&VariableManager`
// parameter is the same architectural gap `rsg::program_executor`'s own top doc comment
// documents for `ProgramExecutor::execute` (see its "KNOWN GAP" section) - found here
// independently, one step earlier in the real pipeline, not yet written down anywhere
// before this paragraph.** Upstream's real `computeUnifiedUniforms(const Shader
// &vertexShader, const Shader &fragmentShader, ...)` takes no `VariableManager` at all,
// because `ShaderInput::getVariable()` returns a `const Variable*` that resolves on its
// own regardless of which `VariableManager` built it. This port's `ShaderInput` instead
// holds a `VariableId`, which only resolves correctly against the *one* manager that
// allocated it - and `add_new_uniforms`'s real call shape (see immediately below) is fed
// `vertex_shader` and `fragment_shader` **both**, resolving uniforms from each through a
// **single** `var_manager` parameter. `rsg::program_generator::generate` - the only real
// producer of a `(vertex_shader, fragment_shader)` pair in this whole cluster - builds
// each shader through its *own*, independently-numbered `VariableManager` (see
// `rsg::shader_generator`'s own top doc comment and `rsg::program_executor`'s "KNOWN
// GAP" section for the full account of why), so a real caller threading either shader's
// own manager into `compute_unified_uniforms` here resolves the *other* shader's own
// uniforms through the wrong manager - silently, since `VariableId` is a bare, untagged
// `usize` index (`VariableManager::get_variable` is a direct `self.variables[id.0]`,
// confirmed by reading it, with no manager-identity check anywhere) and a numerically
// coincidental index (near-certain here: both managers number their own uniforms
// starting from 0) resolves to *some* `Variable` in the wrong manager rather than
// failing loudly. `compute_unified_uniforms_silently_corrupts_an_entry_when_fed_two_
// shaders_from_independent_managers` below demonstrates the concrete failure by hand:
// two separately-numbered managers, one uniform each (both landing on `VariableId(0)`),
// and the fragment shader's own uniform vanishes from the unified list - not because it
// shares a name with the vertex shader's (it does not), but because `add_new_uniforms`
// reads the *vertex* manager's name for it (whatever `VariableId(0)` happens to name
// there) and that name collides with the vertex uniform's own already-recorded one. The
// one existing test here *before* this finding
// (`compute_unified_uniforms_dedups_by_variable_name_across_both_shaders`) does not
// catch this because it allocates both shaders' uniforms through one shared manager -
// representative of nothing this cluster's own real call shape ever actually produces
// (confirmed by reading `rsg::shader_generator::generate`'s own body: it always
// constructs a brand new `VariableManager::new(name_allocator)` per call, never reuses
// one across the two shaders), so it never exercises the cross-manager case at all. Not
// fixed here, for the identical reason `rsg::program_executor`'s own "KNOWN GAP" section
// gives for not fixing its sibling instance: the real fix is the same `VariableManager`-
// lifetime redesign (returning each shader's manager back to a caller that can then
// thread the *right* one per shader, or resolving by `(shader, VariableId)` pair rather
// than a single shared manager), and attempting it blind under this round's "never
// compile" rule is too large a blast radius for one sitting. Flagged here as a second,
// independently-confirmed symptom of the same root cause, so a future session fixing one
// does not stop believing the job is done once the other still silently misresolves.

use std::collections::HashSet;

use super::generator_state::GeneratorState;
use super::shader::{Shader, ShaderInput};
use super::variable_manager::VariableManager;
use super::variable_type::{Type, VariableType};
use super::variable_value::{ConstValueRangeAccess, Scalar, ValueAccess, ValueRangeAccess, VariableValue};
use crate::tcu::random::Random;

/// `addNewUniforms` (file-local upstream) - appends every uniform of `shader` whose
/// *variable name* has not already been seen, into `uniforms`, recording each newly
/// seen name in `added_uniforms`. Deduplication is by name (not by `VariableId`)
/// because this is how a vertex shader's uniform and a fragment shader's
/// identically-named uniform in the same linked program are the same GLSL uniform,
/// confirmed by reading the one caller (`computeUnifiedUniforms`, immediately below).
fn add_new_uniforms<'a>(
    uniforms: &mut Vec<&'a ShaderInput>,
    added_uniforms: &mut HashSet<String>,
    shader: &'a Shader,
    var_manager: &VariableManager<'_>,
) {
    for uniform in shader.get_uniforms() {
        let name = var_manager.get_variable(uniform.get_variable()).get_name().to_string();
        if added_uniforms.insert(name) {
            uniforms.push(uniform);
        }
    }
}

/// `rsg::computeUnifiedUniforms` - the vertex shader's uniforms first, then any of the
/// fragment shader's not already named by one of those (see `add_new_uniforms`'s own
/// doc comment). Returns the unified list rather than filling an out-parameter -
/// upstream's own `DE_ASSERT` precondition on that parameter being empty has nothing to
/// assert here, since this always builds a fresh `Vec`.
pub fn compute_unified_uniforms<'a>(
    var_manager: &VariableManager<'_>,
    vertex_shader: &'a Shader,
    fragment_shader: &'a Shader,
) -> Vec<&'a ShaderInput> {
    let mut uniforms = Vec::new();
    let mut added_uniforms = HashSet::new();
    add_new_uniforms(&mut uniforms, &mut added_uniforms, vertex_shader, var_manager);
    add_new_uniforms(&mut uniforms, &mut added_uniforms, fragment_shader, var_manager);
    uniforms
}

/// `rsg::computeRandomValue`
pub fn compute_random_value(rnd: &mut Random, mut dst: ValueAccess<'_>, value_range: &ConstValueRangeAccess<'_>) {
    match dst.get_type().base_type() {
        Type::Float => {
            const QUANTIZE_STEP: f32 = 1.0 / 8.0;
            for ndx in 0..dst.get_type().num_elements() {
                let min_val = value_range.component(ndx).get_min().as_float();
                let max_val = value_range.component(ndx).get_max().as_float();
                dst.component(ndx)
                    .set_float(get_quantized_float(rnd, min_val, max_val, QUANTIZE_STEP));
            }
        }

        // See this module's own top doc comment: both bounds come from `getMin()` in
        // upstream, faithfully reproduced here.
        Type::Bool => {
            for ndx in 0..dst.get_type().num_elements() {
                let min_val = i32::from(value_range.component(ndx).get_min().as_bool());
                let max_val = i32::from(value_range.component(ndx).get_min().as_bool());
                dst.component(ndx).set_bool(rnd.get_int(min_val, max_val) == 1);
            }
        }

        Type::Int | Type::Sampler2D | Type::SamplerCube => {
            for ndx in 0..dst.get_type().num_elements() {
                let min_val = value_range.component(ndx).get_min().as_int();
                let max_val = value_range.component(ndx).get_max().as_int();
                dst.component(ndx).set_int(rnd.get_int(min_val, max_val));
            }
        }

        Type::Array => {
            for ndx in 0..dst.get_type().num_elements() {
                compute_random_value(rnd, dst.array_element(ndx), &value_range.array_element(ndx));
            }
        }

        Type::Struct => {
            for ndx in 0..dst.get_type().members().len() as i32 {
                compute_random_value(rnd, dst.member(ndx), &value_range.member(ndx));
            }
        }

        _ => panic!("rsg::compute_random_value: invalid type"),
    }
}

/// `rsg::computeUniformValues` - one freshly-randomized `VariableValue` per uniform,
/// via `compute_random_value` above (the very same function; upstream's own
/// `computeRandomValue` is one function used by both this and the generic value-range
/// code, not two near-duplicates). Returns the built `Vec` rather than filling an
/// out-parameter - see `compute_unified_uniforms`'s own doc comment for why.
pub fn compute_uniform_values<'a>(
    rnd: &mut Random,
    var_manager: &'a VariableManager<'_>,
    uniforms: &[&ShaderInput],
) -> Vec<VariableValue<'a>> {
    let mut values = Vec::with_capacity(uniforms.len());
    for uniform in uniforms {
        let variable = var_manager.get_variable(uniform.get_variable());
        let mut value = VariableValue::new(variable);
        compute_random_value(rnd, value.get_value(), &uniform.get_value_range());
        values.push(value);
    }
    values
}

/// `rsg::isUndefinedValueRange`
pub fn is_undefined_value_range(value_range: &ConstValueRangeAccess<'_>) -> bool {
    match value_range.get_type().base_type() {
        Type::Float | Type::Int => {
            let is_float = value_range.get_type().base_type() == Type::Float;
            let (inf_min, inf_max) = if is_float {
                (Scalar::min_float(), Scalar::max_float())
            } else {
                (Scalar::min_int(), Scalar::max_int())
            };

            (0..value_range.get_type().num_elements()).all(|ndx| {
                value_range.get_min().component(ndx).as_scalar() == inf_min
                    && value_range.get_max().component(ndx).as_scalar() == inf_max
            })
        }

        Type::Bool => false,

        _ => panic!("rsg::is_undefined_value_range: unsupported type"),
    }
}

const RANDOM_TYPE_BASE_TYPES: [Type; 3] = [Type::Bool, Type::Int, Type::Float];

/// `rsg::computeRandomType`
pub fn compute_random_type(state: &mut GeneratorState<'_>, max_scalars: i32) -> VariableType {
    debug_assert!(max_scalars >= 1);

    let base_type = *state.get_random().choose(&RANDOM_TYPE_BASE_TYPES);

    match base_type {
        Type::Bool | Type::Int | Type::Float => {
            const MIN_VEC_LENGTH: i32 = 1;
            const MAX_VEC_LENGTH: i32 = 4;
            VariableType::new_basic(
                base_type,
                state
                    .get_random()
                    .get_int(MIN_VEC_LENGTH, max_scalars.min(MAX_VEC_LENGTH)),
            )
        }
        _ => unreachable!("rsg::compute_random_type: RANDOM_TYPE_BASE_TYPES only contains Bool/Int/Float"),
    }
}

/// `rsg::computeRandomValueRange`
pub fn compute_random_value_range(state: &mut GeneratorState<'_>, mut value_range: ValueRangeAccess<'_>) {
    let type_ = value_range.get_type().clone();
    let rnd = state.get_random();

    match type_.base_type() {
        Type::Bool => {
            for ndx in 0..type_.num_elements() {
                let min_val = rnd.get_bool();
                let max_val = if min_val { true } else { rnd.get_bool() };
                value_range.get_min().component(ndx).set_bool(min_val);
                value_range.get_max().component(ndx).set_bool(max_val);
            }
        }

        Type::Int => {
            const MIN_INT_VAL: i32 = -16;
            const MAX_INT_VAL: i32 = 16;
            const MAX_RANGE_LEN: i32 = MAX_INT_VAL - MIN_INT_VAL;

            for ndx in 0..type_.num_elements() {
                let range_len = rnd.get_int(0, MAX_RANGE_LEN);
                let min_val = MIN_INT_VAL + rnd.get_int(0, MAX_RANGE_LEN - range_len);
                let max_val = min_val + range_len;
                value_range.get_min().component(ndx).set_int(min_val);
                value_range.get_max().component(ndx).set_int(max_val);
            }
        }

        Type::Float => {
            const STEP: f32 = 0.1;
            const MAX_STEPS: i32 = 320;
            const MIN_FLOAT_VAL: f32 = -16.0;

            for ndx in 0..type_.num_elements() {
                let range_len = rnd.get_int(0, MAX_STEPS);
                let min_step = rnd.get_int(0, MAX_STEPS - range_len);
                let min_val = MIN_FLOAT_VAL + STEP * min_step as f32;
                let max_val = min_val + STEP * range_len as f32;
                value_range.get_min().component(ndx).set_float(min_val);
                value_range.get_max().component(ndx).set_float(max_val);
            }
        }

        _ => panic!("rsg::compute_random_value_range: unsupported type"),
    }
}

/// `rsg::getTypeConstructorDepth`
pub fn get_type_constructor_depth(type_: &VariableType) -> i32 {
    match type_.base_type() {
        Type::Struct => {
            let mut max_depth = 0;
            for member in type_.members() {
                let member_type = member.get_type();
                let depth = match member_type.base_type() {
                    Type::Struct => get_type_constructor_depth(member_type),
                    Type::Bool | Type::Float | Type::Int => {
                        if member_type.num_elements() == 1 {
                            1
                        } else {
                            2
                        }
                    }
                    _ => 0, // `DE_ASSERT(false)` upstream.
                };
                max_depth = max_depth.max(depth);
            }
            max_depth + 1
        }

        Type::Bool | Type::Float | Type::Int => 2, // One node for ctor, another for value.

        _ => 0, // `DE_ASSERT(false)` upstream.
    }
}

/// `rsg::getConservativeValueExprDepth` - `state` is accepted but unused, matching
/// upstream's own `DE_UNREF(state)` and its `\todo` about one day consulting the
/// variable manager.
pub fn get_conservative_value_expr_depth(_state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> i32 {
    get_type_constructor_depth(value_range.get_type())
}

/// `computeRangeLengthSum` (file-local upstream).
fn compute_range_length_sum(value_range: &ConstValueRangeAccess<'_>) -> f32 {
    let type_ = value_range.get_type();

    match type_.base_type() {
        Type::Float => (0..type_.num_elements())
            .map(|ndx| {
                value_range.component(ndx).get_max().as_float() - value_range.component(ndx).get_min().as_float()
            })
            .sum(),

        // See this module's own top doc comment: both bounds come from `getMin()` in
        // upstream, faithfully reproduced here - this always sums to zero.
        Type::Bool => (0..type_.num_elements())
            .map(|ndx| {
                let min_val = i32::from(value_range.component(ndx).get_min().as_bool());
                let max_val = i32::from(value_range.component(ndx).get_min().as_bool());
                (max_val - min_val) as f32
            })
            .sum(),

        Type::Int | Type::Sampler2D | Type::SamplerCube => (0..type_.num_elements())
            .map(|ndx| {
                let min_val = value_range.component(ndx).get_min().as_int() as i64;
                let max_val = value_range.component(ndx).get_max().as_int() as i64;
                (max_val - min_val) as i32 as f32
            })
            .sum(),

        Type::Array => (0..type_.num_elements())
            .map(|ndx| compute_range_length_sum(&value_range.array_element(ndx)))
            .sum(),

        Type::Struct => (0..type_.members().len() as i32)
            .map(|ndx| compute_range_length_sum(&value_range.member(ndx)))
            .sum(),

        _ => panic!("rsg::compute_range_length_sum: invalid type"),
    }
}

/// `rsg::computeDynamicRangeWeight`
pub fn compute_dynamic_range_weight(value_range: &ConstValueRangeAccess<'_>) -> f32 {
    let range_len_sum = compute_range_length_sum(value_range);
    let num_scalars = value_range.get_type().scalar_size();
    range_len_sum / num_scalars as f32
}

/// `rsg::getQuantizedFloat`
pub fn get_quantized_float(rnd: &mut Random, min: f32, max: f32, step: f32) -> f32 {
    let num_steps = ((max - min) / step) as i32;
    min + step * rnd.get_int(0, num_steps) as f32
}

/// `rsg::quantizeFloatRange`
pub fn quantize_float_range(min: &mut f32, max: &mut f32) -> bool {
    const SUBDIV: f32 = 8.0;

    let new_min = (*min * SUBDIV).ceil() / SUBDIV;
    if new_min <= *max {
        *min = new_min; // Minimum value quantized.
    } else {
        return false;
    }

    let new_max = (*max * SUBDIV).floor() / SUBDIV;
    if *min <= new_max {
        *max = new_max;
    } else {
        return false;
    }

    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::ProgramParameters;
    use crate::rsg::variable::{ShaderType, Storage};
    use crate::rsg::variable_manager::{ValueScope, VariableScope};
    use crate::rsg::variable_value::{ValueRange, ValueStorage};

    fn new_state<'a>(params: &'a ProgramParameters, random: &'a mut Random) -> GeneratorState<'a> {
        GeneratorState::new(params, random)
    }

    fn new_var_manager(alloc: &mut NameAllocator) -> VariableManager<'_> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    #[test]
    fn get_type_constructor_depth_matches_hand_computed_values() {
        assert_eq!(get_type_constructor_depth(&VariableType::new_basic(Type::Float, 1)), 2);
        assert_eq!(get_type_constructor_depth(&VariableType::new_basic(Type::Float, 3)), 2);

        let mut s = VariableType::new_struct("S");
        s.members_mut().push(crate::rsg::variable_type::Member::new(
            VariableType::new_basic(Type::Float, 1),
            "a",
        ));
        s.members_mut().push(crate::rsg::variable_type::Member::new(
            VariableType::new_basic(Type::Int, 3),
            "b",
        ));
        // max(depth(a)=1, depth(b)=2) + 1 = 3.
        assert_eq!(get_type_constructor_depth(&s), 3);

        let mut nested = VariableType::new_struct("T");
        nested
            .members_mut()
            .push(crate::rsg::variable_type::Member::new(s, "inner"));
        // max(depth(inner)=3) + 1 = 4.
        assert_eq!(get_type_constructor_depth(&nested), 4);
    }

    #[test]
    fn get_conservative_value_expr_depth_ignores_state_and_matches_constructor_depth() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let state = new_state(&params, &mut random);

        let type_ = VariableType::new_basic(Type::Int, 2);
        let range = ValueRange::new(type_.clone());
        assert_eq!(
            get_conservative_value_expr_depth(&state, &range.as_const_access()),
            get_type_constructor_depth(&type_)
        );
    }

    #[test]
    fn is_undefined_value_range_true_only_for_the_full_float_or_int_span() {
        let type_ = VariableType::new_basic(Type::Float, 1);
        let mut full = ValueRange::new(type_.clone());
        full.get_min().set_scalar(Scalar::min_float());
        full.get_max().set_scalar(Scalar::max_float());
        assert!(is_undefined_value_range(&full.as_const_access()));

        let mut narrow = ValueRange::new(type_);
        narrow.get_min().set_float(0.0);
        narrow.get_max().set_float(1.0);
        assert!(!is_undefined_value_range(&narrow.as_const_access()));

        // Bool is never considered "undefined", matching upstream's own `return false`.
        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        assert!(!is_undefined_value_range(&bool_range.as_const_access()));
    }

    #[test]
    fn compute_random_value_quantizes_a_float_into_eighths_within_range() {
        let mut rnd = Random::new(42);
        let type_ = VariableType::new_basic(Type::Float, 1);

        let mut range = ValueRange::new(type_.clone());
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        let mut storage = ValueStorage::with_type(1, &type_);
        for _ in 0..50 {
            compute_random_value(&mut rnd, storage.get_value(&type_), &range.as_const_access());
            let v = storage.get_value_const(&type_).as_float();
            assert!((0.0..=1.0).contains(&v), "{v} out of range");
            // Must land on an eighth: 0, 0.125, 0.25, ..., 1.0.
            let eighths = v * 8.0;
            assert!((eighths - eighths.round()).abs() < 1e-5, "{v} is not a multiple of 1/8");
        }
    }

    #[test]
    fn compute_random_value_reproduces_the_upstream_bool_bug() {
        // See this module's own top doc comment: both bounds come from `getMin()`, so
        // the result always equals the range's minimum bound, regardless of what the
        // maximum bound actually is.
        let mut rnd = Random::new(7);
        let type_ = VariableType::new_basic(Type::Bool, 1);
        let mut storage = ValueStorage::with_type(1, &type_);

        // Range [true, true] (min bound true) -> always true.
        let mut range_true = ValueRange::new(type_.clone());
        range_true.get_min().set_bool(true);
        range_true.get_max().set_bool(true);
        for _ in 0..10 {
            compute_random_value(&mut rnd, storage.get_value(&type_), &range_true.as_const_access());
            assert!(storage.get_value_const(&type_).as_bool());
        }

        // Range [false, true] (min bound false) -> always false, even though `true` is
        // a legal value per the max bound - the bug.
        let mut range_false_min = ValueRange::new(type_.clone());
        range_false_min.get_min().set_bool(false);
        range_false_min.get_max().set_bool(true);
        for _ in 0..10 {
            compute_random_value(&mut rnd, storage.get_value(&type_), &range_false_min.as_const_access());
            assert!(!storage.get_value_const(&type_).as_bool());
        }
    }

    #[test]
    fn compute_random_value_range_produces_a_well_ordered_range_for_every_base_type() {
        let params = ProgramParameters::default();
        let mut random = Random::new(123);
        let mut state = new_state(&params, &mut random);

        for base_type in [Type::Bool, Type::Int, Type::Float] {
            let type_ = VariableType::new_basic(base_type, 1);
            let mut range = ValueRange::new(type_);
            compute_random_value_range(&mut state, range.as_access());

            match base_type {
                Type::Bool => {
                    let min_v = range.get_min_const().as_bool();
                    let max_v = range.get_max_const().as_bool();
                    assert!(!min_v || max_v); // min => max (min can't be true while max is false).
                }
                Type::Int => assert!(range.get_min_const().as_int() <= range.get_max_const().as_int()),
                Type::Float => assert!(range.get_min_const().as_float() <= range.get_max_const().as_float()),
                _ => unreachable!(),
            }
        }
    }

    #[test]
    fn compute_random_type_stays_within_the_requested_scalar_budget() {
        let params = ProgramParameters::default();
        let mut random = Random::new(99);
        let mut state = new_state(&params, &mut random);

        for _ in 0..50 {
            let t = compute_random_type(&mut state, 3);
            assert!(matches!(t.base_type(), Type::Bool | Type::Int | Type::Float));
            assert!((1..=3).contains(&t.num_elements()));
        }
    }

    #[test]
    fn compute_dynamic_range_weight_is_the_mean_component_range_length() {
        let type_ = VariableType::new_basic(Type::Float, 2);
        let mut range = ValueRange::new(type_);
        range.as_access().component(0).get_min().set_float(0.0);
        range.as_access().component(0).get_max().set_float(1.0);
        range.as_access().component(1).get_min().set_float(0.0);
        range.as_access().component(1).get_max().set_float(2.0);

        // (1.0 + 2.0) / 2 components = 1.5.
        assert!((compute_dynamic_range_weight(&range.as_const_access()) - 1.5).abs() < 1e-6);
    }

    #[test]
    fn get_quantized_float_lands_on_a_step_boundary_within_range() {
        let mut rnd = Random::new(5);
        for _ in 0..20 {
            let v = get_quantized_float(&mut rnd, 0.0, 1.0, 0.25);
            assert!((0.0..=1.0).contains(&v));
            let quarters = v * 4.0;
            assert!((quarters - quarters.round()).abs() < 1e-5);
        }
    }

    #[test]
    fn quantize_float_range_rounds_inward_and_can_fail_when_they_cross() {
        let mut min = 0.3;
        let mut max = 0.7;
        assert!(quantize_float_range(&mut min, &mut max));
        // ceil(0.3*8)/8 = ceil(2.4)/8 = 3/8 = 0.375; floor(0.7*8)/8 = floor(5.6)/8 = 5/8 = 0.625.
        assert!((min - 0.375).abs() < 1e-6);
        assert!((max - 0.625).abs() < 1e-6);

        // A range too narrow to contain any eighth-boundary fails at the very first
        // check (`ceil(0.01*8)/8 == 0.125 > 0.02`), leaving `min` untouched - matches
        // upstream, which only ever writes `min` once that check has already passed.
        let mut min2 = 0.01;
        let mut max2 = 0.02;
        assert!(!quantize_float_range(&mut min2, &mut max2));
        assert!((min2 - 0.01).abs() < 1e-6);
        assert!((max2 - 0.02).abs() < 1e-6);
    }

    #[test]
    fn compute_unified_uniforms_dedups_by_variable_name_across_both_shaders() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let float1 = VariableType::new_basic(Type::Float, 1);
        let mut range = ValueRange::new(float1.clone());
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        // Same GLSL uniform name declared independently in both shaders, as it would
        // be by a real vertex/fragment pair - these must collapse into one entry.
        let v_color = mgr.allocate_named(float1.clone(), Storage::Uniform, "u_color");
        let f_color = mgr.allocate_named(float1.clone(), Storage::Uniform, "u_color");
        let f_scale = mgr.allocate_named(float1, Storage::Uniform, "u_scale");

        let mut vertex_shader = Shader::new(ShaderType::Vertex);
        vertex_shader
            .get_uniforms_mut()
            .push(ShaderInput::new(v_color, "u_color", &range.as_const_access()));

        let mut fragment_shader = Shader::new(ShaderType::Fragment);
        fragment_shader
            .get_uniforms_mut()
            .push(ShaderInput::new(f_color, "u_color", &range.as_const_access()));
        fragment_shader
            .get_uniforms_mut()
            .push(ShaderInput::new(f_scale, "u_scale", &range.as_const_access()));

        let unified = compute_unified_uniforms(&mgr, &vertex_shader, &fragment_shader);

        // The vertex shader's own "u_color" wins (processed first); the fragment
        // shader's identically-named one is dropped; "u_scale" is unique and kept.
        assert_eq!(unified.len(), 2);
        assert_eq!(unified[0].get_variable(), v_color);
        assert_eq!(unified[1].get_variable(), f_scale);
    }

    /// Demonstrates the gap this file's own top doc comment now documents (the
    /// `compute_unified_uniforms`/`ProgramExecutor::execute` "same root cause, two
    /// symptoms" paragraph): unlike the test just above, this one builds `vertex_shader`
    /// and `fragment_shader` the way `rsg::program_generator::generate` *actually* does -
    /// through two **independent** `VariableManager`s, each numbering its own uniforms
    /// from `VariableId(0)` - and passes only one of them (`mgr_v`) to
    /// `compute_unified_uniforms`, exactly the shape a real caller following this
    /// cluster's own established "thread one manager explicitly" convention would be led
    /// to write, since nothing in the signature itself warns that only one shader's own
    /// manager can ever be given.
    #[test]
    fn compute_unified_uniforms_silently_corrupts_an_entry_when_fed_two_shaders_from_independent_managers() {
        let float1 = VariableType::new_basic(Type::Float, 1);
        let mut range = ValueRange::new(float1.clone());
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        // The vertex shader's own manager - the one actually passed to
        // `compute_unified_uniforms` below.
        let mut alloc_v = NameAllocator::new();
        let mut mgr_v = new_var_manager(&mut alloc_v);
        // Its one uniform becomes `VariableId(0)` *in `mgr_v`*.
        let v_var = mgr_v.allocate_named(float1.clone(), Storage::Uniform, "v_only_uniform");

        // The fragment shader's own, entirely separate manager - never passed to
        // `compute_unified_uniforms` at all, matching `rsg::shader_generator::generate`'s
        // real call shape (a fresh `VariableManager::new(name_allocator)` per shader).
        let mut alloc_f = NameAllocator::new();
        let f_var = {
            let mut mgr_f = new_var_manager(&mut alloc_f);
            // Also lands on `VariableId(0)`, *in `mgr_f`* - a different manager, a
            // different uniform, an uncoincidentally identical numeric id (both
            // managers start counting from zero independently).
            mgr_f.allocate_named(float1, Storage::Uniform, "f_only_uniform")
        }; // `mgr_f` is dropped here - its own `VariableId`s remain a plain `usize`,
        // resolvable against *any* manager, correctly or not.

        let mut vertex_shader = Shader::new(ShaderType::Vertex);
        vertex_shader
            .get_uniforms_mut()
            .push(ShaderInput::new(v_var, "v_only_uniform", &range.as_const_access()));

        let mut fragment_shader = Shader::new(ShaderType::Fragment);
        fragment_shader
            .get_uniforms_mut()
            .push(ShaderInput::new(f_var, "f_only_uniform", &range.as_const_access()));

        // `vertex_shader`'s own uniform is processed first against `mgr_v` - correctly,
        // since `v_var` really was allocated there - recording "v_only_uniform" as seen.
        // `fragment_shader`'s own uniform is processed next, but `add_new_uniforms`
        // resolves `f_var` (== `VariableId(0)`, really an `mgr_f` id) against `mgr_v`
        // instead (the only manager this call was given) - which hands back `mgr_v`'s
        // own `VariableId(0)`, i.e. the *vertex* shader's `"v_only_uniform"` entry, not
        // the fragment shader's real `"f_only_uniform"` name. That name is already in
        // `added_uniforms`, so the fragment shader's own, genuinely uniquely-named
        // uniform is dropped as a false "duplicate" of a name it never actually shared.
        let unified = compute_unified_uniforms(&mgr_v, &vertex_shader, &fragment_shader);

        // The bug, made concrete: two uniforms with two genuinely distinct names went
        // in, and only one came out - not because of a real name collision (there is
        // none), but because of the cross-manager index collision traced above. A
        // correct implementation (resolving each `ShaderInput` against *its own*
        // shader's manager) would report `unified.len() == 2` here instead.
        assert_eq!(unified.len(), 1);
        assert_eq!(unified[0].get_variable(), v_var);
    }

    #[test]
    fn compute_uniform_values_draws_one_deterministic_value_per_uniform_from_a_point_range() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let var = mgr.allocate_named(int_type.clone(), Storage::Uniform, "u_count");

        // A point range (min == max) makes the random draw deterministic regardless of
        // seed - the same trick this file's other tests already use.
        let mut range = ValueRange::new(int_type);
        range.get_min().set_int(5);
        range.get_max().set_int(5);
        let input = ShaderInput::new(var, "u_count", &range.as_const_access());

        let mut rnd = Random::new(1);
        let values = compute_uniform_values(&mut rnd, &mgr, &[&input]);

        assert_eq!(values.len(), 1);
        assert_eq!(values[0].get_variable().get_name(), "u_count");
        assert_eq!(values[0].get_value_const().as_int(), 5);
    }
}
