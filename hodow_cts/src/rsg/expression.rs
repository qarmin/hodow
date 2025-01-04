// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgExpression.hpp / .cpp, rsgBinaryOps.hpp / .cpp
//   (`rsgBuiltinFunctions.hpp/.cpp` is `rsg::builtin_functions`, a separate file - this
//   one only references its `BuiltinFunctionOp` as an `Expression` enum payload)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **This file now carries essentially all of `rsgExpression`/`rsgBinaryOps`/
// `rsgBuiltinFunctions`'s real node kinds as real `Expression` enum variants** - see the
// enum's own definition below for the exhaustive current list (`Float`/`Int`/`Bool`/
// `VariableRead`/`VariableWrite`/`Paren`/`Assign`/`Constructor`/`Binary`/`Relational`/
// `Builtin`/`EpsilonAdd`/`Swizzle`/`Equality`/`TexLookup`/`CustomAbs`/`CustomSub`/
// `CustomLessThan`). This paragraph used to describe an early, much narrower slice
// (only the three literals plus `VariableRead`/`VariableWrite`, with everything else -
// `ConstructorOp`/`AssignOp`/`ParenOp`/`SwizzleOp`/`TexLookup` and all of
// `BinaryOps`/`BuiltinFunctions` - "remaining unported"); that was true only of an
// early commit in this file's own history and is stale now, left uncorrected across
// several later sessions that extended the enum without revisiting this header. The
// full upstream hierarchy this file now covers: `rsgExpression.hpp` alone declares 11
// node kinds, and `rsgBinaryOps.hpp` (343 lines)/`rsgBuiltinFunctions.hpp` (642 lines,
// almost entirely inline - its own `.cpp` is 26 lines) each extend the *same*
// `Expression` base with roughly 9 and 12 more respectively (`Mul`/`Add`/`Sub`/
// `LessThan`/`LessOrEqual`/`GreaterThan`/`GreaterOrEqual`/`Equal`/`NotEqual`;
// `Sin`/`Cos`/`Tan`/`Asin`/`Acos`/`Atan`/`Exp`/`Log`/`Exp2`/`Log2`/`Sqrt`/`InvSqrt`) -
// roughly 32 node kinds in total. See each kind's own section doc comment below (and
// `rsg::mod`'s own top doc comment, which narrates the order these landed in across
// several sessions) for anything still genuinely partial *within* a given kind - as of
// this writing that is nothing: every node kind, every algorithm-level corner case
// (including `Equal`'s own `CMP_EQ` epsilon-correction rewrite, the last one), and the
// full `create_random` dispatch table are complete.
//
// **Modelled as a Rust `enum`, not a `dyn Trait` object hierarchy** - a deliberate
// departure from upstream's C++ virtual dispatch, chosen because the full set of
// `Expression` kinds is a small, closed, enumerable list known in full today (unlike
// e.g. `rsg::variable_manager`'s arena-of-opaque-handles redesign, which was forced by
// an aliasing conflict, this one is a plain "which shape fits a closed sum type better"
// call). `Expression::evaluate`/`get_value`/`tokenize` dispatch through a `match` below;
// adding a new kind later is one new enum variant and one new match arm per method,
// same cost as upstream's one new subclass, with no `Box<dyn ...>`/`Rc<dyn ...>` or
// trait-object-safety concerns to design around as the hierarchy grows.
//
// **Two real, independent formulas, not shareable with `rsg::utils::
// get_quantized_float`**: `FloatLiteral`'s own random-value quantization adds `+ 1` to
// its step count (`(int)((maxVal - minVal) / step) + 1`) where `get_quantized_float`
// does not, and additionally clamps the result into `[minVal, maxVal]` (`deFloatClamp`)
// where `get_quantized_float` does not - confirmed by reading both formulas side by
// side rather than assuming they were meant to be the same code path reused twice.
// `IntLiteral`/`BoolLiteral` use `GeneratorState::get_random().get_int(min, max)`
// directly, no quantization at all.
//
// **`getWeight`'s unbounded-range check compares against `Scalar::min_float()`/
// `max_float()`** (this port's bit-pattern constants for the C++ `Scalar::min<float>
// ()`/`max<float>()` that upstream's own `ValueRange::new` leaves every unset bound
// at) - note these are the port's own `-inf`/`+inf` sentinels for "no bound was ever
// set", not a GLSL-visible value.

use super::builtin_functions::BuiltinFunctionOp;
use super::execution_context::{
    EXEC_VEC_WIDTH, ExecConstValueAccess, ExecMaskStorage, ExecValueAccess, ExecutionContext, assign_masked,
};
use super::generator_state::{CONST_EXPR, GeneratorState, NO_VAR_ALLOCATION};
use super::parameters::{NUM_RESERVED_SHADER_INPUTS, Version};
use super::token::{Token, TokenStream};
use super::utils::{
    compute_dynamic_range_weight, compute_random_type, compute_random_value_range, get_conservative_value_expr_depth,
    get_quantized_float, get_type_constructor_depth, is_undefined_value_range, quantize_float_range,
};
use super::variable::{ShaderType, Storage};
use super::variable_manager::{ValueEntryId, VariableId, VariableManager, is_writable_entry};
use super::variable_type::{Type, VariableType};
use super::variable_value::{ConstValueRangeAccess, Scalar, ValueRange, ValueRangeAccess, ValueStorage};
use crate::tcu::random::Random;

/// `rsg::unusedValueWeight`
pub const UNUSED_VALUE_WEIGHT: f32 = 0.05;

/// `rsg::Expression` - see this module's own top doc comment for the current scope.
/// **`VariableRead`/`VariableWrite` joined as real variants alongside `ParenOp`** - the
/// signature unification once deferred (see the "Why literals, and only literals"
/// history still visible in this module's git log) is applied here, now that `ParenOp`
/// is a real forcing consumer: `get_value`/`get_lvalue`/`tokenize` take `&VariableManager`
/// and (for the value-returning ones) tie `&self` and `&mut ExecutionContext` to one
/// lifetime, so a kind whose value lives in `ExecutionContext`'s own storage
/// (`VariableRead`/`VariableWrite`) and a kind whose value lives in `self`
/// (the three literals) can share one signature.
pub enum Expression {
    Float(FloatLiteral),
    Int(IntLiteral),
    Bool(BoolLiteral),
    VariableRead(VariableRead),
    VariableWrite(VariableWrite),
    Paren(ParenOp),
    Assign(AssignOp),
    Constructor(ConstructorOp),
    Binary(BinaryOp),
    Relational(RelationalOp),
    Builtin(BuiltinFunctionOp),
    EpsilonAdd(EpsilonAddOp),
    CustomAbs(CustomAbsOp),
    CustomSub(CustomSubOp),
    CustomLessThan(CustomLessThanOp),
    Swizzle(SwizzleOp),
    Equality(EqualityComparisonOp),
    TexLookup(TexLookup),
}

impl Expression {
    /// `Expression::evaluate` - every currently-ported leaf kind's own `evaluate` is a
    /// no-op; `ParenOp` is a pure pass-through to its child's own. `AssignOp`/
    /// `ConstructorOp`/`BinaryOp` have real evaluation work of their own, which is why
    /// this takes `&mut self` rather than upstream's uniformly non-`const` method
    /// applied blindly - the simpler kinds still don't need it.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        match self {
            Expression::Float(_) | Expression::Int(_) | Expression::Bool(_) => {}
            Expression::VariableRead(v) => v.evaluate(),
            Expression::VariableWrite(v) => v.evaluate(),
            Expression::Paren(p) => p.evaluate(var_manager, ctx),
            Expression::Assign(a) => a.evaluate(var_manager, ctx),
            Expression::Constructor(c) => c.evaluate(var_manager, ctx),
            Expression::Binary(b) => b.evaluate(var_manager, ctx),
            Expression::Relational(r) => r.evaluate(var_manager, ctx),
            Expression::Builtin(f) => f.evaluate(var_manager, ctx),
            Expression::EpsilonAdd(e) => e.evaluate(var_manager, ctx),
            Expression::CustomAbs(a) => a.evaluate(var_manager, ctx),
            Expression::CustomSub(s) => s.evaluate(var_manager, ctx),
            Expression::CustomLessThan(l) => l.evaluate(var_manager, ctx),
            Expression::Swizzle(s) => s.evaluate(var_manager, ctx),
            Expression::Equality(e) => e.evaluate(var_manager, ctx),
            Expression::TexLookup(t) => t.evaluate(var_manager, ctx),
        }
    }

    pub fn get_value<'s>(
        &'s self,
        var_manager: &VariableManager<'_>,
        ctx: &'s mut ExecutionContext<'_>,
    ) -> ExecConstValueAccess<'s> {
        match self {
            Expression::Float(l) => l.get_value(),
            Expression::Int(l) => l.get_value(),
            Expression::Bool(l) => l.get_value(),
            Expression::VariableRead(v) => v.get_value(var_manager, ctx),
            Expression::VariableWrite(v) => v.get_value(var_manager, ctx),
            Expression::Paren(p) => p.get_value(var_manager, ctx),
            Expression::Assign(a) => a.get_value(),
            Expression::Constructor(c) => c.get_value(),
            Expression::Binary(b) => b.get_value(),
            Expression::Relational(r) => r.get_value(),
            Expression::Builtin(f) => f.get_value(),
            Expression::EpsilonAdd(e) => e.get_value(),
            Expression::CustomAbs(a) => a.get_value(),
            Expression::CustomSub(s) => s.get_value(),
            Expression::CustomLessThan(l) => l.get_value(),
            Expression::Swizzle(s) => s.get_value(),
            Expression::Equality(e) => e.get_value(),
            Expression::TexLookup(t) => t.get_value(),
        }
    }

    /// `Expression::getLValue` - upstream's default implementation throws ("not an
    /// L-value node"); only `VariableRead`/`VariableWrite` (via `VariableAccess`)
    /// override it. This port panics instead, matching the "should never be reached on
    /// a well-formed tree" intent.
    pub fn get_lvalue<'s>(
        &'s self,
        var_manager: &VariableManager<'_>,
        ctx: &'s mut ExecutionContext<'_>,
    ) -> ExecValueAccess<'s> {
        match self {
            Expression::VariableRead(v) => v.get_lvalue(var_manager, ctx),
            Expression::VariableWrite(v) => v.get_lvalue(var_manager, ctx),
            _ => panic!("Expression::get_lvalue: not an L-value node"),
        }
    }

    /// `version`/`shader_type` exist only for `TexLookup` (via `Variable::
    /// tokenize_declaration`'s own `ShaderType` convention) - every other kind ignores
    /// them, but a kind holding children must still accept and forward them, since a
    /// `TexLookup` could be nested anywhere in the tree.
    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        match self {
            Expression::Float(l) => l.tokenize(stream),
            Expression::Int(l) => l.tokenize(stream),
            Expression::Bool(l) => l.tokenize(stream),
            Expression::VariableRead(v) => v.tokenize(var_manager, stream),
            Expression::VariableWrite(v) => v.tokenize(var_manager, stream),
            Expression::Paren(p) => p.tokenize(var_manager, version, shader_type, stream),
            Expression::Assign(a) => a.tokenize(var_manager, version, shader_type, stream),
            Expression::Constructor(c) => c.tokenize(var_manager, version, shader_type, stream),
            Expression::Binary(b) => b.tokenize(var_manager, version, shader_type, stream),
            Expression::Relational(r) => r.tokenize(var_manager, version, shader_type, stream),
            Expression::Builtin(f) => f.tokenize(var_manager, version, shader_type, stream),
            Expression::EpsilonAdd(e) => e.tokenize(var_manager, version, shader_type, stream),
            Expression::CustomAbs(a) => a.tokenize(var_manager, version, shader_type, stream),
            Expression::CustomSub(s) => s.tokenize(var_manager, version, shader_type, stream),
            Expression::CustomLessThan(l) => l.tokenize(var_manager, version, shader_type, stream),
            Expression::Swizzle(s) => s.tokenize(var_manager, version, shader_type, stream),
            Expression::Equality(e) => e.tokenize(var_manager, version, shader_type, stream),
            Expression::TexLookup(t) => t.tokenize(var_manager, version, shader_type, stream),
        }
    }

    /// `Expression::createNextChild` - every leaf kind is always `None`; see
    /// `rsg::expression_generator` for the driver that actually walks this across a
    /// whole tree.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        match self {
            Expression::Float(_) | Expression::Int(_) | Expression::Bool(_) => None,
            Expression::VariableRead(_) | Expression::VariableWrite(_) => None,
            Expression::Paren(p) => p.create_next_child(state, var_manager),
            Expression::Assign(a) => a.create_next_child(state, var_manager),
            Expression::Constructor(c) => c.create_next_child(state, var_manager),
            Expression::Binary(b) => b.create_next_child(state, var_manager),
            Expression::Relational(r) => r.create_next_child(state, var_manager),
            Expression::Builtin(f) => f.create_next_child(state, var_manager),
            Expression::EpsilonAdd(e) => e.create_next_child(state, var_manager),
            Expression::CustomAbs(a) => a.create_next_child(state, var_manager),
            Expression::CustomSub(s) => s.create_next_child(state, var_manager),
            Expression::CustomLessThan(l) => l.create_next_child(state, var_manager),
            Expression::Swizzle(s) => s.create_next_child(state, var_manager),
            Expression::Equality(e) => e.create_next_child(state, var_manager),
            Expression::TexLookup(t) => t.create_next_child(state, var_manager),
        }
    }
}

/// `rsg::FloatLiteral`
pub struct FloatLiteral {
    value: ValueStorage,
}

impl FloatLiteral {
    fn storage_from(value: f32) -> ValueStorage {
        let type_ = VariableType::scalar_type(Type::Float);
        let mut storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        let mut access = storage.get_value(&type_);
        for ndx in 0..EXEC_VEC_WIDTH {
            access.set_float_at(ndx, value);
        }
        storage
    }

    /// `FloatLiteral::FloatLiteral(GeneratorState&, ConstValueRangeAccess)`
    pub fn new_random(state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut min_val = -10.0f32;
        let mut max_val = 10.0f32;
        let step = 0.25f32;

        if *value_range.get_type() == VariableType::new_basic(Type::Float, 1) {
            min_val = value_range.get_min().component(0).as_float();
            max_val = value_range.get_max().component(0).as_float();

            if min_val == Scalar::min_float().as_float() {
                min_val = -10.0;
            }
            if max_val == Scalar::max_float().as_float() {
                max_val = 10.0;
            }
        }

        let num_steps = ((max_val - min_val) / step) as i32 + 1;
        let value = (min_val + step * state.get_random().get_int(0, num_steps) as f32).clamp(min_val, max_val);

        Self {
            value: Self::storage_from(value),
        }
    }

    /// `FloatLiteral::FloatLiteral(float)` - upstream's own comment: needed to handle
    /// the corner case where comparing two "same" floats produced different results,
    /// resolved by adding an epsilon-valued literal to one side.
    pub fn new_custom(custom_value: f32) -> Self {
        Self {
            value: Self::storage_from(custom_value),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Float))
    }

    pub fn tokenize(&self, stream: &mut TokenStream) {
        stream.push(Token::FloatLiteral(self.get_value().as_float_at(0)));
    }

    /// `FloatLiteral::getWeight`
    pub fn get_weight(_state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        let type_ = value_range.get_type();
        if *type_ == VariableType::new_basic(Type::Float, 1) {
            let min_val = value_range.get_min().as_float();
            let max_val = value_range.get_max().as_float();

            if min_val == Scalar::min_float().as_float() && max_val == Scalar::max_float().as_float() {
                return 0.1;
            }

            let range_length = max_val - min_val;
            debug_assert!(range_length >= 0.0);
            (1.0 - range_length).max(0.1)
        } else if type_.is_void() {
            UNUSED_VALUE_WEIGHT
        } else {
            0.0
        }
    }
}

/// `rsg::IntLiteral`
pub struct IntLiteral {
    value: ValueStorage,
}

impl IntLiteral {
    fn storage_from(value: i32) -> ValueStorage {
        let type_ = VariableType::scalar_type(Type::Int);
        let mut storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        let mut access = storage.get_value(&type_);
        for ndx in 0..EXEC_VEC_WIDTH {
            access.set_int_at(ndx, value);
        }
        storage
    }

    /// `IntLiteral::IntLiteral(GeneratorState&, ConstValueRangeAccess)`
    pub fn new_random(state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut min_val = -16;
        let mut max_val = 16;

        if *value_range.get_type() == VariableType::new_basic(Type::Int, 1) {
            min_val = value_range.get_min().component(0).as_int();
            max_val = value_range.get_max().component(0).as_int();

            if min_val == Scalar::min_int().as_int() {
                min_val = -16;
            }
            if max_val == Scalar::max_int().as_int() {
                max_val = 16;
            }
        }

        let value = state.get_random().get_int(min_val, max_val);
        Self {
            value: Self::storage_from(value),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Int))
    }

    pub fn tokenize(&self, stream: &mut TokenStream) {
        stream.push(Token::IntLiteral(self.get_value().as_int_at(0)));
    }

    /// `IntLiteral::getWeight`
    pub fn get_weight(_state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        let type_ = value_range.get_type();
        if *type_ == VariableType::new_basic(Type::Int, 1) {
            let min_val = value_range.get_min().as_int();
            let max_val = value_range.get_max().as_int();

            if min_val == Scalar::min_int().as_int() && max_val == Scalar::max_int().as_int() {
                return 0.1;
            }

            let range_length = max_val - min_val;
            debug_assert!(range_length >= 0);
            (1.0 - range_length as f32 / 4.0).max(0.1)
        } else if type_.is_void() {
            UNUSED_VALUE_WEIGHT
        } else {
            0.0
        }
    }
}

/// `rsg::BoolLiteral`
pub struct BoolLiteral {
    value: ValueStorage,
}

impl BoolLiteral {
    fn storage_from(value: bool) -> ValueStorage {
        let type_ = VariableType::scalar_type(Type::Bool);
        let mut storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        let mut access = storage.get_value(&type_);
        for ndx in 0..EXEC_VEC_WIDTH {
            access.set_bool_at(ndx, value);
        }
        storage
    }

    /// `BoolLiteral::BoolLiteral(GeneratorState&, ConstValueRangeAccess)`
    pub fn new_random(state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut min_val = 0;
        let mut max_val = 1;

        if *value_range.get_type() == VariableType::new_basic(Type::Bool, 1) {
            min_val = i32::from(value_range.get_min().component(0).as_bool());
            max_val = i32::from(value_range.get_max().component(0).as_bool());
        }

        let value = state.get_random().get_int(min_val, max_val) == 1;
        Self {
            value: Self::storage_from(value),
        }
    }

    /// `BoolLiteral::BoolLiteral(bool)`
    pub fn new_custom(custom_value: bool) -> Self {
        Self {
            value: Self::storage_from(custom_value),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Bool))
    }

    pub fn tokenize(&self, stream: &mut TokenStream) {
        stream.push(Token::BoolLiteral(self.get_value().as_bool_at(0)));
    }

    /// `BoolLiteral::getWeight`
    pub fn get_weight(_state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        let type_ = value_range.get_type();
        if *type_ == VariableType::new_basic(Type::Bool, 1) {
            0.5
        } else if type_.is_void() {
            UNUSED_VALUE_WEIGHT
        } else {
            0.0
        }
    }
}

// `rsg::VariableRead`/`rsg::VariableWrite` - now real `Expression` variants (see the
// enum's own doc comment above for the unified `get_value` signature that made this
// possible). Worth keeping the history of *why* this took two steps: upstream's
// `VariableAccess::evaluate` caches a *view* into `ExecutionContext`'s own per-variable
// storage (`m_valueAccess = ctx.getValue(m_variable)`), not a value, so a later
// `getValue()`/`getLValue()` call can still observe whatever another expression wrote to
// the same variable in between. This port never caches that view at all - `get_value`/
// `get_lvalue` re-derive it fresh from `ctx.get_value(id, type)` on every call, which is
// observably equivalent (`ExecutionContext`'s per-variable storage is a single
// persistent slot reused across the whole generation run, so two views into it obtained
// at different times are views into the same data, not two different snapshots) and
// avoids a real lifetime problem a cached view would have hit: `VariableRead`/
// `VariableWrite` have to outlive any one `evaluate`/`get_value` call (they live inside
// the long-lived AST), so a struct field borrowing `ExecutionContext` would tie up the
// whole context for the AST's entire lifetime. The one thing re-deriving the view does
// need - a signature letting `get_value` return something borrowed from either `self`
// (literals) or `ctx` (these two) - is the unification the enum now uses.

fn get_weighted_bool(rnd: &mut Random, true_weight: f32) -> bool {
    debug_assert!((0.0..=1.0).contains(&true_weight));
    rnd.get_float() < true_weight
}

/// `rsg::IsReadableEntry`
#[allow(clippy::needless_bool)]
fn is_readable_entry(mgr: &VariableManager, id: ValueEntryId, expr_flags: u32) -> bool {
    if (expr_flags & CONST_EXPR) != 0
        && mgr.get_variable(mgr.get_entry(id).get_variable()).get_storage() != Storage::Const
    {
        return false;
    }
    true
}

/// `rsg::IsReadableIntersectingEntry`
fn is_readable_intersecting_entry(
    mgr: &VariableManager,
    id: ValueEntryId,
    value_range: &ConstValueRangeAccess<'_>,
    expr_flags: u32,
) -> bool {
    if !is_readable_entry(mgr, id, expr_flags) {
        return false;
    }
    let entry_range = mgr.get_entry(id).get_value_range_const();
    if entry_range.get_type() != value_range.get_type() {
        return false;
    }
    entry_range.intersects(value_range)
}

/// `rsg::IsWritableIntersectingEntry`
fn is_writable_intersecting_entry(
    mgr: &VariableManager,
    id: ValueEntryId,
    value_range: &ConstValueRangeAccess<'_>,
) -> bool {
    if !is_writable_entry(mgr, id) {
        return false;
    }
    let var_type = mgr.get_variable(mgr.get_entry(id).get_variable()).get_type();
    if var_type != value_range.get_type() {
        return false;
    }
    mgr.get_entry(id).get_value_range_const().intersects(value_range)
}

/// `rsg::IsWritableSupersetEntry`
fn is_writable_superset_entry(
    mgr: &VariableManager,
    id: ValueEntryId,
    value_range: &ConstValueRangeAccess<'_>,
) -> bool {
    if !is_writable_entry(mgr, id) {
        return false;
    }
    let var_type = mgr.get_variable(mgr.get_entry(id).get_variable()).get_type();
    if var_type != value_range.get_type() {
        return false;
    }
    mgr.get_entry(id).get_value_range_const().is_superset_of(value_range)
}

/// `rsg::canAllocateVariable`
pub fn can_allocate_variable(
    state: &GeneratorState<'_>,
    var_manager: &VariableManager<'_>,
    type_: &VariableType,
) -> bool {
    debug_assert!(!type_.is_void());

    if (state.get_expression_flags() & NO_VAR_ALLOCATION) != 0 {
        return false;
    }

    var_manager.get_num_allocated_scalars() + type_.scalar_size()
        <= state.get_shader_parameters().max_combined_variable_scalars
}

fn is_shader_in_out_supported_type(type_: &VariableType) -> bool {
    // \todo [2011-03-11 pyry] Float arrays, structs?
    type_.base_type() == Type::Float
}

/// `allocateNewVariable` (file-local upstream) - allocates, sets its value range, then
/// picks a storage class weighted by `compute_dynamic_range_weight` (a narrow dynamic
/// range favours `Const`/`Uniform`, a wide one favours `Local`/`ShaderIn`).
fn allocate_new_variable(
    state: &mut GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
    value_range: &ConstValueRangeAccess<'_>,
) -> VariableId {
    let variable_id = var_manager.allocate(value_range.get_type().clone());
    var_manager.set_value(variable_id, value_range);

    let storages = [Storage::Const, Storage::Uniform, Storage::Local, Storage::ShaderIn];

    let dyn_weight = compute_dynamic_range_weight(value_range);
    let num_scalars = value_range.get_type().scalar_size();
    let uniform_ok = var_manager.get_num_allocated_uniform_scalars() + num_scalars
        <= state.get_shader_parameters().max_uniform_scalars;
    let shader_in_ok = is_shader_in_out_supported_type(value_range.get_type())
        && var_manager.get_num_allocated_shader_in_variables() + (NUM_RESERVED_SHADER_INPUTS as i32)
            < state.get_shader_parameters().max_input_variables;

    let weights = [
        (1.0 - dyn_weight).max(0.1),
        if uniform_ok { dyn_weight * 0.5 } else { 0.0 },
        dyn_weight,
        if shader_in_ok { dyn_weight * 2.0 } else { 0.0 },
    ];

    let chosen_storage = *state.get_random().choose_weighted(&storages, &weights);
    var_manager.set_storage(variable_id, chosen_storage);

    variable_id
}

fn combine_weight(cur_combined_weight: f32, partial_weight: f32) -> f32 {
    cur_combined_weight * partial_weight
}

/// `computeEntryReadWeight` (file-local upstream) - how well an existing entry's own
/// value range matches a desired read range: an unbounded (-inf..inf) component never
/// lowers the weight (`continue`s past it), otherwise it is the average of "how much of
/// the entry's own range the intersection covers" and "how much of the read's own
/// requested range the intersection covers".
fn compute_entry_read_weight(
    entry_value_range: &ConstValueRangeAccess<'_>,
    read_value_range: &ConstValueRangeAccess<'_>,
) -> f32 {
    let type_ = entry_value_range.get_type();
    debug_assert!(*type_ == *read_value_range.get_type());

    let mut weight = 1.0f32;

    match type_.base_type() {
        Type::Float => {
            for elem_ndx in 0..type_.num_elements() {
                let entry_min = entry_value_range.component(elem_ndx).get_min().as_float();
                let entry_max = entry_value_range.component(elem_ndx).get_max().as_float();
                let read_min = read_value_range.component(elem_ndx).get_min().as_float();
                let read_max = read_value_range.component(elem_ndx).get_max().as_float();

                if entry_min == Scalar::min_float().as_float() && entry_max == Scalar::max_float().as_float() {
                    continue; // Check for -inf..inf ranges - they don't bring down the weight.
                }

                let intersection_min = entry_min.max(read_min);
                let intersection_max = entry_max.min(read_max);
                let entry_range_len = entry_max - entry_min;
                let read_range_len = read_max - read_min;
                let intersection_len = intersection_max - intersection_min;
                let entry_ratio = if entry_range_len > 0.0 {
                    intersection_len / entry_range_len
                } else {
                    1.0
                };
                let read_ratio = if read_range_len > 0.0 {
                    intersection_len / read_range_len
                } else {
                    1.0
                };
                weight = combine_weight(weight, 0.5 * read_ratio + 0.5 * entry_ratio);
            }
        }

        Type::Int => {
            for elem_ndx in 0..type_.num_elements() {
                let entry_min = entry_value_range.component(elem_ndx).get_min().as_int();
                let entry_max = entry_value_range.component(elem_ndx).get_max().as_int();
                let read_min = read_value_range.component(elem_ndx).get_min().as_int();
                let read_max = read_value_range.component(elem_ndx).get_max().as_int();

                if entry_min == Scalar::min_int().as_int() && entry_max == Scalar::max_int().as_int() {
                    continue;
                }

                let intersection_min = entry_min.max(read_min) as i64;
                let intersection_max = entry_max.min(read_max) as i64;
                let entry_range_len = entry_max as i64 - entry_min as i64;
                let read_range_len = read_max as i64 - read_min as i64;
                let intersection_len = intersection_max - intersection_min;
                let entry_ratio = if entry_range_len > 0 {
                    intersection_len as f32 / entry_range_len as f32
                } else {
                    1.0
                };
                let read_ratio = if read_range_len > 0 {
                    intersection_len as f32 / read_range_len as f32
                } else {
                    1.0
                };
                weight = combine_weight(weight, 0.5 * read_ratio + 0.5 * entry_ratio);
            }
        }

        Type::Bool => {
            // \todo upstream - left empty there too.
        }

        _ => panic!("rsg::compute_entry_read_weight: unsupported type"),
    }

    weight.max(0.01)
}

/// `setInfiniteRange` (file-local upstream).
fn set_infinite_range(value_range: &mut ValueRange) {
    let type_ = value_range.get_type().clone();
    match type_.base_type() {
        Type::Bool => {
            for ndx in 0..type_.num_elements() {
                let mut access = value_range.as_access();
                access.component(ndx).get_min().set_scalar(Scalar::min_bool());
                access.component(ndx).get_max().set_scalar(Scalar::max_bool());
            }
        }
        Type::Int => {
            for ndx in 0..type_.num_elements() {
                let mut access = value_range.as_access();
                access.component(ndx).get_min().set_scalar(Scalar::min_int());
                access.component(ndx).get_max().set_scalar(Scalar::max_int());
            }
        }
        Type::Float => {
            for ndx in 0..type_.num_elements() {
                let mut access = value_range.as_access();
                access.component(ndx).get_min().set_scalar(Scalar::min_float());
                access.component(ndx).get_max().set_scalar(Scalar::max_float());
            }
        }
        _ => panic!("rsg::set_infinite_range: unsupported type"),
    }
}

/// `computeRandomValueRangeForInfElements` (file-local upstream) - like `rsg::utils::
/// compute_random_value_range`, but only touches components that are still exactly
/// `-inf..inf`; an already-bounded component is left untouched (`continue`s past it).
fn compute_random_value_range_for_inf_elements(state: &mut GeneratorState<'_>, mut value_range: ValueRangeAccess<'_>) {
    let type_ = value_range.get_type().clone();

    match type_.base_type() {
        Type::Bool => {
            // No need to handle bool as it will be false, true.
        }

        Type::Int => {
            const MIN_INT_VAL: i32 = -16;
            const MAX_INT_VAL: i32 = 16;
            const MAX_RANGE_LEN: i32 = MAX_INT_VAL - MIN_INT_VAL;

            for ndx in 0..type_.num_elements() {
                if value_range.component(ndx).get_min().as_scalar() != Scalar::min_int()
                    || value_range.component(ndx).get_max().as_scalar() != Scalar::max_int()
                {
                    continue;
                }

                let range_len = state.get_random().get_int(0, MAX_RANGE_LEN);
                let min_val = MIN_INT_VAL + state.get_random().get_int(0, MAX_RANGE_LEN - range_len);
                let max_val = min_val + range_len;
                value_range.component(ndx).get_min().set_int(min_val);
                value_range.component(ndx).get_max().set_int(max_val);
            }
        }

        Type::Float => {
            const STEP: f32 = 0.1;
            const MAX_STEPS: i32 = 320;
            const MIN_FLOAT_VAL: f32 = -16.0;

            for ndx in 0..type_.num_elements() {
                if value_range.component(ndx).get_min().as_scalar() != Scalar::min_float()
                    || value_range.component(ndx).get_max().as_scalar() != Scalar::max_float()
                {
                    continue;
                }

                let range_len = state.get_random().get_int(0, MAX_STEPS);
                let min_step = state.get_random().get_int(0, MAX_STEPS - range_len);
                let min_val = MIN_FLOAT_VAL + STEP * min_step as f32;
                let max_val = min_val + STEP * range_len as f32;
                value_range.component(ndx).get_min().set_float(min_val);
                value_range.component(ndx).get_max().set_float(max_val);
            }
        }

        _ => panic!("rsg::compute_random_value_range_for_inf_elements: unsupported type"),
    }
}

fn resolve_value<'c>(
    variable_id: VariableId,
    var_manager: &VariableManager<'_>,
    ctx: &'c mut ExecutionContext<'_>,
) -> ExecValueAccess<'c> {
    let type_ = var_manager.get_variable(variable_id).get_type().clone();
    ctx.get_value(variable_id, &type_)
}

/// `rsg::VariableRead`
pub struct VariableRead {
    variable_id: VariableId,
}

impl VariableRead {
    /// `VariableRead::VariableRead(GeneratorState&, ConstValueRangeAccess)`
    pub fn new_random(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        let variable_id = if value_range.get_type().is_void() {
            let expr_flags = state.get_expression_flags();
            let max_scalars =
                state.get_shader_parameters().max_combined_variable_scalars - var_manager.get_num_allocated_scalars();
            let has_readable = var_manager.has_entry(|m, id| is_readable_entry(m, id, expr_flags));
            let use_random_range = !has_readable || (max_scalars > 0 && get_weighted_bool(state.get_random(), 0.5));

            if use_random_range {
                debug_assert!(max_scalars > 0);
                let random_type = compute_random_type(state, max_scalars);
                let mut new_var_range = ValueRange::new(random_type);
                compute_random_value_range(state, new_var_range.as_access());
                allocate_new_variable(state, var_manager, &new_var_range.as_const_access())
            } else {
                let entries: Vec<ValueEntryId> = var_manager
                    .entries_matching(|m, id| is_readable_entry(m, id, expr_flags))
                    .collect();
                let chosen = *state.get_random().choose(&entries);
                var_manager.get_entry(chosen).get_variable()
            }
        } else {
            let expr_flags = state.get_expression_flags();
            let matching: Vec<ValueEntryId> = var_manager
                .entries_matching(|m, id| is_readable_intersecting_entry(m, id, value_range, expr_flags))
                .collect();

            const CREATE_ON_READ_WEIGHT: f32 = 0.5;
            let create_var = can_allocate_variable(state, var_manager, value_range.get_type())
                && (matching.is_empty() || get_weighted_bool(state.get_random(), CREATE_ON_READ_WEIGHT));

            if create_var {
                allocate_new_variable(state, var_manager, value_range)
            } else {
                debug_assert!(!matching.is_empty());

                let weights: Vec<f32> = matching
                    .iter()
                    .map(|&id| {
                        compute_entry_read_weight(&var_manager.get_entry(id).get_value_range_const(), value_range)
                    })
                    .collect();

                let chosen_entry_id = *state.get_random().choose_weighted(&matching, &weights);
                let variable_id = var_manager.get_entry(chosen_entry_id).get_variable();

                let mut intersection = ValueRange::new(var_manager.get_variable(variable_id).get_type().clone());
                {
                    let entry_range = var_manager.get_entry(chosen_entry_id).get_value_range_const();
                    ValueRange::compute_intersection(&mut intersection, &entry_range, value_range);
                }
                var_manager.set_value(variable_id, &intersection.as_const_access());

                variable_id
            }
        };

        Self { variable_id }
    }

    /// `VariableRead::VariableRead(const Variable*)`
    pub fn from_variable(variable_id: VariableId) -> Self {
        Self { variable_id }
    }

    pub fn get_variable(&self) -> VariableId {
        self.variable_id
    }

    /// `VariableRead::getWeight`
    pub fn get_weight(
        state: &GeneratorState<'_>,
        var_manager: &VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        let expr_flags = state.get_expression_flags();

        if value_range.get_type().is_void() {
            return if var_manager.has_entry(|m, id| is_readable_entry(m, id, expr_flags))
                || var_manager.get_num_allocated_scalars() < state.get_shader_parameters().max_combined_variable_scalars
            {
                UNUSED_VALUE_WEIGHT
            } else {
                0.0
            };
        }

        if !can_allocate_variable(state, var_manager, value_range.get_type())
            && !var_manager.has_entry(|m, id| is_readable_intersecting_entry(m, id, value_range, expr_flags))
        {
            0.0
        } else {
            1.0
        }
    }

    /// `VariableAccess::evaluate` - a no-op here (nothing to cache) - see this file's
    /// own section doc comment for why.
    pub fn evaluate(&self) {}

    pub fn get_value<'c>(
        &self,
        var_manager: &VariableManager<'_>,
        ctx: &'c mut ExecutionContext<'_>,
    ) -> ExecConstValueAccess<'c> {
        resolve_value(self.variable_id, var_manager, ctx).into_const()
    }

    pub fn get_lvalue<'c>(
        &self,
        var_manager: &VariableManager<'_>,
        ctx: &'c mut ExecutionContext<'_>,
    ) -> ExecValueAccess<'c> {
        resolve_value(self.variable_id, var_manager, ctx)
    }

    pub fn tokenize(&self, var_manager: &VariableManager<'_>, stream: &mut TokenStream) {
        stream.push(Token::identifier(var_manager.get_variable(self.variable_id).get_name()));
    }
}

/// `rsg::VariableWrite`
pub struct VariableWrite {
    variable_id: VariableId,
}

impl VariableWrite {
    /// `VariableWrite::VariableWrite(GeneratorState&, ConstValueRangeAccess)`
    pub fn new(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        debug_assert!(!value_range.get_type().is_void());

        let matching: Vec<ValueEntryId> = var_manager
            .entries_matching(|m, id| is_writable_superset_entry(m, id, value_range))
            .collect();

        const CREATE_ON_ASSIGN_WEIGHT: f32 = 0.1; // Will essentially create an unused variable.
        let create_var = can_allocate_variable(state, var_manager, value_range.get_type())
            && (matching.is_empty() || get_weighted_bool(state.get_random(), CREATE_ON_ASSIGN_WEIGHT));

        let variable_id = if create_var {
            var_manager.allocate(value_range.get_type().clone())
            // \note Storage will be LOCAL.
        } else {
            debug_assert!(!matching.is_empty());
            let chosen_entry_id = *state.get_random().choose(&matching);
            var_manager.get_entry(chosen_entry_id).get_variable()
        };

        // Reset value range.
        let parent_range = var_manager
            .get_parent_value(variable_id)
            .map(|e| ValueRange::from_access(&e.get_value_range_const()));
        if let Some(parent_range) = parent_range {
            // Use parent value range.
            var_manager.set_value(variable_id, &parent_range.as_const_access());
        } else {
            // Use infinite range.
            let mut inf_range = ValueRange::new(var_manager.get_variable(variable_id).get_type().clone());
            set_infinite_range(&mut inf_range);
            var_manager.set_value(variable_id, &inf_range.as_const_access());
        }

        Self { variable_id }
    }

    pub fn get_variable(&self) -> VariableId {
        self.variable_id
    }

    /// `VariableWrite::getWeight`
    pub fn get_weight(
        state: &GeneratorState<'_>,
        var_manager: &VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        if !can_allocate_variable(state, var_manager, value_range.get_type())
            && !var_manager.has_entry(|m, id| is_writable_superset_entry(m, id, value_range))
        {
            0.0
        } else {
            1.0
        }
    }

    /// `VariableAccess::evaluate` - a no-op here, see this file's own section doc
    /// comment for why.
    pub fn evaluate(&self) {}

    pub fn get_value<'c>(
        &self,
        var_manager: &VariableManager<'_>,
        ctx: &'c mut ExecutionContext<'_>,
    ) -> ExecConstValueAccess<'c> {
        resolve_value(self.variable_id, var_manager, ctx).into_const()
    }

    pub fn get_lvalue<'c>(
        &self,
        var_manager: &VariableManager<'_>,
        ctx: &'c mut ExecutionContext<'_>,
    ) -> ExecValueAccess<'c> {
        resolve_value(self.variable_id, var_manager, ctx)
    }

    pub fn tokenize(&self, var_manager: &VariableManager<'_>, stream: &mut TokenStream) {
        stream.push(Token::identifier(var_manager.get_variable(self.variable_id).get_name()));
    }
}

/// `rsg::ParenOp` - the first `Expression` kind to hold a child `Expression`
/// (`Box<Expression>`, Rust's own indirection for a recursive enum - upstream's raw
/// `Expression *m_child` needed no such annotation). **`createNextChild` is ported
/// too now** (stale note from an earlier pass here removed) - it drives
/// `expression_generator::create_random` (this port's `Expression::createRandom`),
/// upstream's weighted dispatcher across *every* `Expression` kind's own
/// `getWeight`/constructor (`s_expressionSpecs`), which now covers the real, complete
/// set of all 30 entries - see `rsg::expression_generator`'s own doc comment.
/// `set_child` additionally lets a caller supply the child directly (hand-written
/// code, mainly for tests), bypassing the dispatcher entirely.
pub struct ParenOp {
    value_range: ValueRange,
    child: Option<Box<Expression>>,
}

impl ParenOp {
    /// `ParenOp::ParenOp(GeneratorState&, ConstValueRangeAccess)` - `state` is taken
    /// upstream only because every constructor's signature includes it, unused here
    /// (`DE_UNREF(state)`); not threaded through at all in this port since nothing
    /// downstream of it needs `GeneratorState` either.
    pub fn new(value_range: ValueRange) -> Self {
        Self {
            value_range,
            child: None,
        }
    }

    /// `ParenOp::setChild`
    pub fn set_child(&mut self, child: Expression) {
        self.child = Some(Box::new(child));
    }

    /// `ParenOp::createNextChild` - delegates to `expression_generator::create_random`
    /// (this module's own `Expression::createRandom`) for the one child a `ParenOp`
    /// ever has, matching upstream's own body exactly (`if (m_child) return nullptr;
    /// m_child = Expression::createRandom(state, m_valueRange.asAccess()); return
    /// m_child;`).
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.child.is_some() {
            return None;
        }

        let child = super::expression_generator::create_random(state, var_manager, &self.value_range.as_const_access());
        self.child = Some(Box::new(child));
        self.child.as_deref_mut()
    }

    /// `ParenOp::getWeight`
    pub fn get_weight(state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        if value_range.get_type().is_void() {
            if state.get_expression_depth() + 2 <= state.get_shader_parameters().max_expression_depth {
                UNUSED_VALUE_WEIGHT
            } else {
                0.0
            }
        } else {
            let required_depth = 1 + get_conservative_value_expr_depth(state, value_range);
            if state.get_expression_depth() + required_depth <= state.get_shader_parameters().max_expression_depth {
                1.0
            } else {
                0.0
            }
        }
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.child
            .as_deref_mut()
            .expect("ParenOp::evaluate: child not set")
            .evaluate(var_manager, ctx);
    }

    pub fn get_value<'s>(
        &'s self,
        var_manager: &VariableManager<'_>,
        ctx: &'s mut ExecutionContext<'_>,
    ) -> ExecConstValueAccess<'s> {
        self.child
            .as_ref()
            .expect("ParenOp::get_value: child not set")
            .get_value(var_manager, ctx)
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        stream.push(Token::LeftParen);
        self.child.as_ref().expect("ParenOp::tokenize: child not set").tokenize(
            var_manager,
            version,
            shader_type,
            stream,
        );
        stream.push(Token::RightParen);
    }
}

/// `rsg::AssignOp` - the first `Expression` kind holding *two* children (`m_lvalueExpr`/
/// `m_rvalueExpr`) and the first with genuine evaluation work of its own: it caches the
/// rvalue's evaluated result in its own storage, then writes that through the lvalue's
/// own storage via `assign_masked`, masked by the execution context's *current* mask -
/// the mechanism that makes a conditionally-executed assignment (inside a divergent
/// branch) only take effect on the lanes actually taking that branch.
pub struct AssignOp {
    value_range: ValueRange,
    value: ValueStorage,
    lvalue_expr: Option<Box<Expression>>,
    rvalue_expr: Option<Box<Expression>>,
}

impl AssignOp {
    /// `AssignOp::AssignOp(GeneratorState&, ConstValueRangeAccess)` - negotiates a
    /// concrete, writable value range: a `Void` input range picks either a fresh random
    /// type/range or an existing writable variable's own range (filling in any of its
    /// still-unbounded components with a fresh random sub-range via
    /// `compute_random_value_range_for_inf_elements`); either way, the result is then
    /// narrowed again against whatever variables are actually available to assign into
    /// (reusing an existing superset range if one exists, otherwise intersecting with
    /// whichever writable range was chosen).
    pub fn new(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        let mut resolved_range = ValueRange::from_access(value_range);

        if resolved_range.get_type().is_void() {
            let max_scalars =
                state.get_shader_parameters().max_combined_variable_scalars - var_manager.get_num_allocated_scalars();
            let has_writable = var_manager.has_entry(is_writable_entry);
            let use_random_range = !has_writable || (max_scalars > 0 && get_weighted_bool(state.get_random(), 0.1));

            if use_random_range {
                debug_assert!(max_scalars > 0);
                let random_type = compute_random_type(state, max_scalars);
                resolved_range = ValueRange::new(random_type);
                compute_random_value_range(state, resolved_range.as_access());
            } else {
                // Use value range from a random writable entry.
                let writable: Vec<ValueEntryId> = var_manager.entries_matching(is_writable_entry).collect();
                let chosen = *state.get_random().choose(&writable);
                let entry_range = var_manager.get_entry(chosen).get_value_range_const();
                resolved_range = ValueRange::from_access(&entry_range);

                compute_random_value_range_for_inf_elements(state, resolved_range.as_access());

                debug_assert!(var_manager.has_entry(|m, id| is_writable_intersecting_entry(
                    m,
                    id,
                    &resolved_range.as_const_access()
                )));
            }
        }

        let matching: Vec<ValueEntryId> = var_manager
            .entries_matching(|m, id| is_writable_intersecting_entry(m, id, &resolved_range.as_const_access()))
            .collect();

        let possibly_create_var = can_allocate_variable(state, var_manager, resolved_range.get_type())
            && (matching.is_empty() || get_weighted_bool(state.get_random(), 0.5));

        if !possibly_create_var {
            debug_assert!(!matching.is_empty());

            // Try to select one closest to the given range but bigger (a superset).
            let superset_exists = matching.iter().any(|&id| {
                var_manager
                    .get_entry(id)
                    .get_value_range_const()
                    .is_superset_of(&resolved_range.as_const_access())
            });

            if !superset_exists {
                // Select some other range and compute the intersection.
                let chosen = *state.get_random().choose(&matching);
                let selected_range = var_manager.get_entry(chosen).get_value_range_const();
                let mut intersected = ValueRange::new(resolved_range.get_type().clone());
                ValueRange::compute_intersection(&mut intersected, &resolved_range.as_const_access(), &selected_range);
                resolved_range = intersected;
            }
        }

        Self {
            value_range: resolved_range,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            lvalue_expr: None,
            rvalue_expr: None,
        }
    }

    /// `AssignOp::getWeight`
    pub fn get_weight(
        state: &GeneratorState<'_>,
        var_manager: &VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        let type_ = value_range.get_type();

        if !type_.is_void()
            && !can_allocate_variable(state, var_manager, type_)
            && !var_manager.has_entry(|m, id| is_writable_intersecting_entry(m, id, value_range))
        {
            return 0.0; // Would require creating a new variable.
        }

        if !type_.is_void()
            && state.get_expression_depth() + get_type_constructor_depth(type_) + 1
                >= state.get_shader_parameters().max_expression_depth
        {
            return 0.0;
        }

        if type_.is_void()
            && !var_manager.has_entry(is_writable_entry)
            && var_manager.get_num_allocated_scalars() >= state.get_shader_parameters().max_combined_variable_scalars
        {
            return 0.0; // Cannot allocate a new entry.
        }

        if state.get_expression_depth() == 0 {
            4.0
        } else {
            0.0 // \todo [pyry] Fix assign ops - upstream's own comment, carried verbatim.
        }
    }

    /// `AssignOp::createNextChild` - the lvalue is always built first, matching
    /// upstream's own order (and its own `\todo` about proper l-value generation, also
    /// carried verbatim: "pure L-value part is generated first - variable valuerange is
    /// made unbound - R-value is generated - R-values in L-value are generated" - none
    /// of which this port implements either, same gap as upstream currently has).
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.lvalue_expr.is_none() {
            let lvalue = super::expression_generator::create_random_lvalue(
                state,
                var_manager,
                &self.value_range.as_const_access(),
            );
            self.lvalue_expr = Some(Box::new(lvalue));
            self.lvalue_expr.as_deref_mut()
        } else if self.rvalue_expr.is_none() {
            let rvalue =
                super::expression_generator::create_random(state, var_manager, &self.value_range.as_const_access());
            self.rvalue_expr = Some(Box::new(rvalue));
            self.rvalue_expr.as_deref_mut()
        } else {
            None
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.lvalue_expr
            .as_ref()
            .expect("AssignOp::tokenize: lvalue not set")
            .tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::Equal);
        self.rvalue_expr
            .as_ref()
            .expect("AssignOp::tokenize: rvalue not set")
            .tokenize(var_manager, version, shader_type, stream);
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.lvalue_expr
            .as_deref_mut()
            .expect("AssignOp::evaluate: lvalue not set")
            .evaluate(var_manager, ctx);
        self.rvalue_expr
            .as_deref_mut()
            .expect("AssignOp::evaluate: rvalue not set")
            .evaluate(var_manager, ctx);

        let value_type = self.value_range.get_type().clone();
        self.value.set_storage(&value_type);
        {
            let src = self.rvalue_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            self.value.get_value(&value_type).assign_from(&src);
        }

        // Snapshot the current execution mask into owned storage before taking a
        // mutable borrow of `ctx` for the lvalue - `ExecMaskStorage` owns a fixed-size
        // array, so this is a real, independent copy, not a lingering borrow of `ctx`.
        let mut mask_storage = ExecMaskStorage::new(true);
        {
            let mask_src = ctx.get_execution_mask().value();
            mask_storage.get_value().assign_from(&mask_src);
        }

        let src_access = self.value.get_value_const(&value_type);
        let dst = self.lvalue_expr.as_ref().unwrap().get_lvalue(var_manager, ctx);
        assign_masked(dst, &src_access, &mask_storage.get_value_const());
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(self.value_range.get_type())
    }
}

/// `rsg::convert<SrcType, DstType>` - the 9 scalar conversion functions (one per
/// (float,int,bool) x (float,int,bool) pair), used by `convert_exec_value` below (and,
/// for the two pairs upstream does *not* special-case at the range level, by
/// `convert_value_range` too). Where upstream has no `template<>` specialization
/// (float->float, int->float, int->int, bool->float, bool->int, bool->bool), its
/// generic default is a sentinel-preserving numeric cast - which collapses to a plain
/// identity for the three same-type pairs, confirmed by reading the generic template
/// itself (`Scalar::min/max<Src>() == src ? Scalar::min/max<Dst>() : DstType(src)`,
/// trivially `src` unchanged when `Src == Dst`).
mod scalar_convert {
    use super::super::variable_value::Scalar;

    pub fn float_to_float(src: f32) -> f32 {
        src
    }
    pub fn int_to_int(src: i32) -> i32 {
        src
    }
    pub fn bool_to_bool(src: bool) -> bool {
        src
    }

    /// `convert<float, int>` - sentinel-preserving, otherwise rounds toward zero
    /// (`floor` for positive, `ceil` for negative) - a scalar *value* conversion, not
    /// to be confused with `convertValueRange<float, int>`'s own inward-rounding rule.
    pub fn float_to_int(src: f32) -> i32 {
        if src == Scalar::min_float().as_float() {
            Scalar::min_int().as_int()
        } else if src == Scalar::max_float().as_float() {
            Scalar::max_int().as_int()
        } else if src > 0.0 {
            src.floor() as i32
        } else {
            src.ceil() as i32
        }
    }

    /// `convert<float, bool>` - "According to GLSL ES spec", upstream's own comment.
    pub fn float_to_bool(src: f32) -> bool {
        src != 0.0
    }

    pub fn int_to_float(src: i32) -> f32 {
        if src == Scalar::min_int().as_int() {
            Scalar::min_float().as_float()
        } else if src == Scalar::max_int().as_int() {
            Scalar::max_float().as_float()
        } else {
            src as f32
        }
    }

    pub fn int_to_bool(src: i32) -> bool {
        src != 0
    }

    pub fn bool_to_float(src: bool) -> f32 {
        if src { 1.0 } else { 0.0 }
    }

    pub fn bool_to_int(src: bool) -> i32 {
        i32::from(src)
    }
}

fn scalar_le(type_: Type, a: Scalar, b: Scalar) -> bool {
    match type_ {
        Type::Float => a.as_float() <= b.as_float(),
        Type::Int => a.as_int() <= b.as_int(),
        Type::Bool => i32::from(a.as_bool()) <= i32::from(b.as_bool()),
        _ => unreachable!("rsg::scalar_le: base type must be Float, Int or Bool"),
    }
}

/// `rsg::convert<SrcType, DstType>(SrcType)` - the plain *scalar* conversion (every
/// `scalar_convert::*_to_*` function), dispatched on a runtime `(src_type, dst_type)`
/// pair rather than a compile-time template instantiation. **Not the same function as
/// `convert_value_range` below** - upstream's own `convertValueRange<float, int>`/
/// `<float, bool>` specializations exist precisely *because* they differ from this one
/// (inward ceil/floor on a range vs. round-toward-zero on a value; `> 0.0` on a range
/// bound vs. `!= 0.0` on a value) - `is_conversion_ok`'s own round-trip check needs this
/// one, matching upstream's `convert<SrcType, DstType>(sMin)`/`(sMax)` exactly.
fn convert_scalar(src_type: Type, dst_type: Type, src: Scalar) -> Scalar {
    match (src_type, dst_type) {
        (Type::Float, Type::Float) => Scalar::from_float(scalar_convert::float_to_float(src.as_float())),
        (Type::Float, Type::Int) => Scalar::from_int(scalar_convert::float_to_int(src.as_float())),
        (Type::Float, Type::Bool) => Scalar::from_bool(scalar_convert::float_to_bool(src.as_float())),
        (Type::Int, Type::Float) => Scalar::from_float(scalar_convert::int_to_float(src.as_int())),
        (Type::Int, Type::Int) => Scalar::from_int(scalar_convert::int_to_int(src.as_int())),
        (Type::Int, Type::Bool) => Scalar::from_bool(scalar_convert::int_to_bool(src.as_int())),
        (Type::Bool, Type::Float) => Scalar::from_float(scalar_convert::bool_to_float(src.as_bool())),
        (Type::Bool, Type::Int) => Scalar::from_int(scalar_convert::bool_to_int(src.as_bool())),
        (Type::Bool, Type::Bool) => Scalar::from_bool(scalar_convert::bool_to_bool(src.as_bool())),
        _ => unreachable!("rsg::convert_scalar: base type must be Float, Int or Bool"),
    }
}

/// `rsg::convertValueRange(ConstValueRangeAccess, ValueRangeAccess)`, specialized to a
/// single scalar bound pair (every call site here is per-component, never a whole
/// vector at once). Dispatches on the (src, dst) base-type pair, matching upstream's own
/// 3x3 function-pointer table: `(Float, Int)` and `(Float, Bool)` use upstream's own
/// named specializations (genuinely different rules from the scalar `convert` function -
/// see each arm's own comment), the other seven pairs use upstream's generic default,
/// which *is* just `scalar_convert::*` applied to each bound independently.
fn convert_value_range(src_type: Type, dst_type: Type, src_min: Scalar, src_max: Scalar) -> (Scalar, Scalar) {
    match (src_type, dst_type) {
        (Type::Float, Type::Float) => (
            Scalar::from_float(scalar_convert::float_to_float(src_min.as_float())),
            Scalar::from_float(scalar_convert::float_to_float(src_max.as_float())),
        ),
        (Type::Float, Type::Int) => {
            // `convertValueRange<float, int>` - rounds *inward* (`ceil` the min up,
            // `floor` the max down), the opposite direction from the scalar `convert`
            // function's own round-toward-zero rule, so the resulting int range never
            // claims a value the float range couldn't actually produce.
            let min = src_min.as_float();
            let max = src_max.as_float();
            let dst_min = if min == Scalar::min_float().as_float() {
                Scalar::min_int().as_int()
            } else {
                min.ceil() as i32
            };
            let dst_max = if max == Scalar::max_float().as_float() {
                Scalar::max_int().as_int()
            } else {
                max.floor() as i32
            };
            (Scalar::from_int(dst_min), Scalar::from_int(dst_max))
        }
        (Type::Float, Type::Bool) => {
            // `convertValueRange<float, bool>` - `> 0.0`, deliberately not the scalar
            // `convert` function's own `!= 0.0` rule.
            (
                Scalar::from_bool(src_min.as_float() > 0.0),
                Scalar::from_bool(src_max.as_float() > 0.0),
            )
        }
        (Type::Int, Type::Float) => (
            Scalar::from_float(scalar_convert::int_to_float(src_min.as_int())),
            Scalar::from_float(scalar_convert::int_to_float(src_max.as_int())),
        ),
        (Type::Int, Type::Int) => (
            Scalar::from_int(scalar_convert::int_to_int(src_min.as_int())),
            Scalar::from_int(scalar_convert::int_to_int(src_max.as_int())),
        ),
        (Type::Int, Type::Bool) => (
            Scalar::from_bool(scalar_convert::int_to_bool(src_min.as_int())),
            Scalar::from_bool(scalar_convert::int_to_bool(src_max.as_int())),
        ),
        (Type::Bool, Type::Float) => (
            Scalar::from_float(scalar_convert::bool_to_float(src_min.as_bool())),
            Scalar::from_float(scalar_convert::bool_to_float(src_max.as_bool())),
        ),
        (Type::Bool, Type::Int) => (
            Scalar::from_int(scalar_convert::bool_to_int(src_min.as_bool())),
            Scalar::from_int(scalar_convert::bool_to_int(src_max.as_bool())),
        ),
        (Type::Bool, Type::Bool) => (
            Scalar::from_bool(scalar_convert::bool_to_bool(src_min.as_bool())),
            Scalar::from_bool(scalar_convert::bool_to_bool(src_max.as_bool())),
        ),
        _ => unreachable!("rsg::convert_value_range: base type must be Float, Int or Bool"),
    }
}

/// `rsg::convertExecValue(ExecConstValueAccess, ExecValueAccess)` - per-lane, using the
/// plain scalar `convert` function for *every* pair (upstream's `convertExecValueTempl`
/// has no range-level special cases at all, unlike `convertValueRange` above - confirmed
/// by reading it, not assumed. A same-type pair is exactly a bit-pattern copy (see
/// `scalar_convert`'s own doc comment), so this one function also replaces what used to
/// be a separate raw-copy path for the no-conversion case.
fn convert_exec_value(src_type: Type, dst_type: Type, src: &ExecConstValueAccess<'_>, dst: &mut ExecValueAccess<'_>) {
    for lane in 0..EXEC_VEC_WIDTH {
        let converted = match (src_type, dst_type) {
            (Type::Float, Type::Float) => Scalar::from_float(scalar_convert::float_to_float(src.as_float_at(lane))),
            (Type::Float, Type::Int) => Scalar::from_int(scalar_convert::float_to_int(src.as_float_at(lane))),
            (Type::Float, Type::Bool) => Scalar::from_bool(scalar_convert::float_to_bool(src.as_float_at(lane))),
            (Type::Int, Type::Float) => Scalar::from_float(scalar_convert::int_to_float(src.as_int_at(lane))),
            (Type::Int, Type::Int) => Scalar::from_int(scalar_convert::int_to_int(src.as_int_at(lane))),
            (Type::Int, Type::Bool) => Scalar::from_bool(scalar_convert::int_to_bool(src.as_int_at(lane))),
            (Type::Bool, Type::Float) => Scalar::from_float(scalar_convert::bool_to_float(src.as_bool_at(lane))),
            (Type::Bool, Type::Int) => Scalar::from_int(scalar_convert::bool_to_int(src.as_bool_at(lane))),
            (Type::Bool, Type::Bool) => Scalar::from_bool(scalar_convert::bool_to_bool(src.as_bool_at(lane))),
            _ => unreachable!("rsg::convert_exec_value: base type must be Float, Int or Bool"),
        };
        dst.set_scalar_at(lane, converted);
    }
}

/// `rsg::isConversionOk(VariableType::Type, VariableType::Type, ConstValueRangeAccess)` -
/// is `src_type` a usable input type for a constructor argument whose converted value
/// must land back within `[dst_min, dst_max]`? Converts the requested `dst` range
/// *backward* into `src_type`'s own representation (via `convert_value_range`, same as
/// upstream's own first step - a genuine range operation on the real bounds, so
/// `(Float, Int)`/`(Float, Bool)`'s inward-rounding specializations are exactly right
/// here), checks the result is still well-ordered, then converts *each* of those two
/// bounds *forward* again **through the plain scalar `convert_scalar`, not
/// `convert_value_range`** and checks they still land inside the original
/// `[dst_min, dst_max]` - a round-trip fidelity check, matching upstream's real body
/// exactly (confirmed by reading it, not inferred from the name: upstream's second step
/// is `convert<SrcType, DstType>(sMin)`/`(sMax)`, the bare scalar conversion template,
/// never `convertValueRange`, which is why `(Float, Int)`/`(Float, Bool)` need their own
/// `convert_scalar` arms distinct from `convert_value_range`'s - using
/// `convert_value_range` for this second step, as an earlier draft of this port did,
/// silently reintroduces the inward-rounding/`> 0.0` range rules into what upstream
/// deliberately keeps a round-toward-zero/`!= 0.0` single-value check). `(Float, Float)`
/// is hardcoded `true` upstream ("work-around for non-deterministic float behavior"),
/// carried over verbatim.
///
/// **Confirmed behaviorally inert in this port today, fixed anyway for algorithmic
/// fidelity**: the only two `(src_type, dst_type)` pairs where `convert_value_range`
/// and `convert_scalar` actually disagree are `(Float, Int)` (inward ceil/floor vs.
/// round-toward-zero) and `(Float, Bool)` (`> 0.0` vs. `!= 0.0` - these differ only for
/// a *negative* input). But every call site in this file only ever passes a `dst_min`/
/// `dst_max` whose own type is `dst_type`, so the Step-1 candidate (`src_min`/`src_max`
/// above) reaching this second step with `src_type == Float` is itself always the exact
/// image of a real `Int` or `Bool` value under `int_to_float`/`bool_to_float` - always
/// already a whole number, and for `Bool` always exactly `0.0` or `1.0`, never negative -
/// so ceil/floor and `>`/`!=` agree on every value this function can actually be asked
/// about right now. Worth re-checking if a future caller ever feeds this function a
/// genuinely fractional or negative `Float`-shaped `src_min`/`src_max` by some other
/// route (e.g. a struct/array component whose range isn't itself derived from a plain
/// `Int`/`Bool` scalar) - that is exactly the case this fix protects against.
fn is_conversion_ok(src_type: Type, dst_type: Type, dst_min: Scalar, dst_max: Scalar) -> bool {
    if src_type == Type::Float && dst_type == Type::Float {
        return true;
    }

    let (src_min, src_max) = convert_value_range(dst_type, src_type, dst_min, dst_max);

    if !scalar_le(src_type, src_min, src_max) {
        return false;
    }

    let back_min = convert_scalar(src_type, dst_type, src_min);
    let back_max = convert_scalar(src_type, dst_type, src_max);

    (scalar_le(dst_type, dst_min, back_min) && scalar_le(dst_type, back_min, dst_max))
        && (scalar_le(dst_type, dst_min, back_max) && scalar_le(dst_type, back_max, dst_max))
}

/// `rsg::ConstructorOp` - builds a vector (or, trivially, a scalar) from one child
/// expression per scalar component, created and evaluated in *reverse* order (matching
/// upstream's own `\note Created in reverse order!` and its mirrored reverse-iteration
/// in `tokenize`/`evaluate`) and tokenized as `<type>(<args>)`.
///
/// **`ProgramParameters::use_scalar_conversions == true` is now ported too** - when a
/// component's own input type is allowed to differ from the constructor's overall
/// output type (`vec3(1, 0.5, true)`), `is_conversion_ok` picks which of
/// `{Float, Int, Bool}` are usable input types for that component (upstream asserts at
/// least one always is - the identity conversion), `state.get_random().choose` picks one,
/// and `convert_value_range`/`convert_exec_value` do the actual range/per-lane
/// conversion. When `use_scalar_conversions` is `false` (upstream's own default), every
/// child's value range is simply a same-typed single-component slice of the whole range,
/// exactly as before.
pub struct ConstructorOp {
    value_range: ValueRange,
    value: ValueStorage,
    input_value_ranges: Vec<ValueRange>,
    input_expressions: Vec<Expression>,
}

impl ConstructorOp {
    /// `ConstructorOp::ConstructorOp(GeneratorState&, ConstValueRangeAccess)`
    pub fn new(state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut resolved_range = ValueRange::from_access(value_range);

        if resolved_range.get_type().is_void() {
            // Use random range. We don't have to be able to assign this value to
            // anywhere, so the scalar budget is just a fixed, small cap.
            const MAX_SCALARS: i32 = 4;
            let random_type = compute_random_type(state, MAX_SCALARS);
            resolved_range = ValueRange::new(random_type);
            compute_random_value_range(state, resolved_range.as_access());
        }

        let type_ = resolved_range.get_type().clone();
        debug_assert!(type_.is_float_or_vec() || type_.is_int_or_vec() || type_.is_bool_or_vec());

        let scalar_conversions = state.get_program_parameters().use_scalar_conversions;
        let base_type = type_.base_type();
        let num_scalars = type_.num_elements();
        let mut input_value_ranges = Vec::with_capacity(num_scalars as usize);

        for cur_scalar_ndx in 0..num_scalars {
            let comp = resolved_range.as_const_access().component(cur_scalar_ndx);

            if scalar_conversions {
                let dst_min = comp.get_min().as_scalar();
                let dst_max = comp.get_max().as_scalar();

                let candidate_types = [Type::Float, Type::Int, Type::Bool];
                let in_types: Vec<Type> = candidate_types
                    .into_iter()
                    .filter(|&in_type| is_conversion_ok(in_type, base_type, dst_min, dst_max))
                    .collect();
                debug_assert!(!in_types.is_empty(), "at least the nop conversion should be ok");

                let in_type = *state.get_random().choose(&in_types);
                let (conv_min, conv_max) = convert_value_range(base_type, in_type, dst_min, dst_max);

                let mut in_range = ValueRange::new(VariableType::new_basic(in_type, 1));
                in_range.get_min().set_scalar(conv_min);
                in_range.get_max().set_scalar(conv_max);
                input_value_ranges.push(in_range);
            } else {
                input_value_ranges.push(ValueRange::from_access(&comp));
            }
        }

        Self {
            value_range: resolved_range,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            input_value_ranges,
            input_expressions: Vec::new(),
        }
    }

    /// `ConstructorOp::getWeight`
    pub fn get_weight(state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        let type_ = value_range.get_type();

        if type_.is_void() {
            return UNUSED_VALUE_WEIGHT;
        }

        if !type_.is_float_or_vec() && !type_.is_int_or_vec() && !type_.is_bool_or_vec() {
            return 0.0;
        }

        if state.get_expression_depth() + get_type_constructor_depth(type_)
            > state.get_shader_parameters().max_expression_depth
        {
            return 0.0;
        }

        1.0
    }

    /// `ConstructorOp::createNextChild` - built in reverse order, matching upstream's
    /// own `\note`.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        let num_children = self.input_expressions.len();
        if num_children < self.input_value_ranges.len() {
            let in_value_range = &self.input_value_ranges[self.input_value_ranges.len() - 1 - num_children];
            let child =
                super::expression_generator::create_random(state, var_manager, &in_value_range.as_const_access());
            self.input_expressions.push(child);
            self.input_expressions.last_mut()
        } else {
            None
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.value_range.get_type().tokenize_short_type(stream);

        stream.push(Token::LeftParen);
        for (ndx, expr) in self.input_expressions.iter().rev().enumerate() {
            if ndx > 0 {
                stream.push(Token::Comma);
            }
            expr.tokenize(var_manager, version, shader_type, stream);
        }
        stream.push(Token::RightParen);
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        // Evaluate children.
        for expr in self.input_expressions.iter_mut().rev() {
            expr.evaluate(var_manager, ctx);
        }

        // Compute value.
        let type_ = self.value_range.get_type().clone();
        self.value.set_storage(&type_);

        let dst_base_type = type_.base_type();
        let mut cur_scalar_ndx = 0;
        for expr in self.input_expressions.iter().rev() {
            let src = expr.get_value(var_manager, ctx);
            let src_base_type = src.get_type().base_type();
            for elem_ndx in 0..src.get_type().num_elements() {
                let src_elem = src.component(elem_ndx);
                let mut dst = self.value.get_value(&type_);
                let mut dst_elem = dst.component(cur_scalar_ndx);
                // `convertExecValue` - without `use_scalar_conversions`, `src_elem`'s
                // type always matches `dst_elem`'s and this is exactly a bit-pattern
                // copy (see `scalar_convert`'s own doc comment); with it, `src_elem`
                // may be a differently-typed input that needs an actual conversion.
                convert_exec_value(src_base_type, dst_base_type, &src_elem, &mut dst_elem);
                cur_scalar_ndx += 1;
            }
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(self.value_range.get_type())
    }
}

/// `BinaryOp<P,A>::getWeight` - the precedence/depth-budget check shared by every
/// `BinaryOp<P,A>`-derived class regardless of which concrete subclass it is
/// (`BinaryVecOp` and `RelationalOp` both inherit it unchanged), so it is factored out
/// here once rather than duplicated between `BinaryOp::get_weight` and
/// `RelationalOp::get_weight`.
fn binary_op_base_get_weight(
    precedence: i32,
    state: &GeneratorState<'_>,
    value_range: &ConstValueRangeAccess<'_>,
) -> f32 {
    if state.get_precedence() < precedence {
        return 0.0;
    }

    let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();

    if value_range.get_type().is_void() {
        return if available_levels >= 2 {
            UNUSED_VALUE_WEIGHT
        } else {
            0.0
        };
    }

    if available_levels < get_conservative_value_expr_depth(state, value_range) + 1 {
        return 0.0;
    }

    1.0
}

/// `rsg::BinaryOp<Precedence, Associativity>`/`rsg::BinaryVecOp<...>` - a single struct
/// with a `BinaryOpKind` discriminant, replacing upstream's C++ template hierarchy
/// (`BinaryOp<P,A>` -> `BinaryVecOp<P,F,I,B,ComputeRange,Evaluate>` -> `AddOp`/`MulOp`/
/// ..., one concrete class per operator). **`Add`/`Sub`/`Mul` are ported** - see
/// this type's own doc comment on `BinaryOpKind` for exactly why the relational/
/// equality operators still wait.
///
/// **`Associativity::Right` is dead upstream code, confirmed by grep**: the enum
/// declares it (`ASSOCIATIVITY_LEFT`/`ASSOCIATIVITY_RIGHT`), but not one of the ~9
/// `BinaryOp`-derived classes across `rsgBinaryOps.hpp`/`.cpp` ever instantiates a
/// template with it - every real operator is left-associative. This port hardcodes
/// left-associativity (`createNextChild`'s `leftPrec = Precedence`, `rightPrec =
/// Precedence - 1`) rather than modelling an associativity no concrete operator uses.
pub struct BinaryOp {
    kind: BinaryOpKind,
    type_: VariableType,
    value: ValueStorage,
    left_value_range: ValueRange,
    right_value_range: ValueRange,
    left_expr: Option<Box<Expression>>,
    right_expr: Option<Box<Expression>>,
}

/// `rsg::BinaryVecOp`'s `Precedence`/`Float`/`Int`/`Bool` template parameters plus the
/// `ComputeValueRange`/`EvaluateComp` strategy types, collapsed into one enum with a
/// method per upstream template parameter/strategy.
///
/// **`Mul` ported** (`ComputeMulRange`'s own scale-search algorithm - see
/// `compute_mul_range_float`/`compute_mul_range_int` below for why it needed its own
/// free functions rather than fitting the shared `Add`/`Sub` formula).
///
/// **Never a `BinaryOpKind` variant, but all six are ported anyway, elsewhere in this
/// file**: the relational/equality operators (`LessThan`/`LessOrEqual`/`GreaterThan`/
/// `GreaterOrEqual`/`Equal`/`NotEqual`) use the sibling `RelationalOp`/
/// `EqualityComparisonOp` base classes, not `BinaryVecOp` at all - a different
/// evaluate/compute-range shape, which is why they are not (and never will be) a
/// `BinaryOpKind` arm. `LessThan`/`GreaterThan`/`LessOrEqual`/`GreaterOrEqual` are the
/// separate `RelationalOp` struct below; `Equal`/`NotEqual` are `EqualityComparisonOp`,
/// further below still. Found while reading `BinaryOp<P,A>::createNextChild`'s own
/// corner-case switch: `LessOrEqual`/`GreaterOrEqual`/`Equal` additionally needed
/// `CustomAbsOp`/`CustomBinaryOp` (file-local `Expression` kinds that rewrite the tree
/// to inject a `+0.001` epsilon around float comparisons, "to resolve float comparison
/// corner case[s]" in upstream's own words) - a genuinely separate piece of machinery,
/// confirmed by reading the whole switch rather than assumed from the class
/// declarations alone, and ported in full too (`EpsilonAddOp` for `LessOrEqual`/
/// `GreaterOrEqual`, `CustomAbsOp`/`CustomSubOp`/`CustomLessThanOp` for `Equal`'s own
/// `CMP_EQ` rewrite). `Add`/`Sub`/`Mul` use neither (their operator tokens, `PLUS`/
/// `MINUS`/`MUL`, never match that switch's `CMP_LE`/`CMP_GE`/`CMP_EQ` cases).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BinaryOpKind {
    Add,
    Sub,
    Mul,
}

impl BinaryOpKind {
    /// `AddBase`/`SubBase` are `BinaryVecOp<5, ...>`; `MulBase` is `BinaryVecOp<4, ...>`
    /// (confirmed by reading both `typedef`s in `rsgBinaryOps.hpp` directly - `Mul`
    /// binds tighter than `Add`/`Sub`, matching ordinary arithmetic precedence).
    fn precedence(self) -> i32 {
        match self {
            BinaryOpKind::Add | BinaryOpKind::Sub => 5,
            BinaryOpKind::Mul => 4,
        }
    }

    fn token(self) -> Token {
        match self {
            BinaryOpKind::Add => Token::Plus,
            BinaryOpKind::Sub => Token::Minus,
            BinaryOpKind::Mul => Token::Mul,
        }
    }

    /// `BinaryVecOp<Precedence, Float, Int, Bool, ...>`'s own `Float`/`Int`/`Bool`
    /// template booleans - `Add`/`Sub`/`Mul` are all `<..., true, true, false, ...>`.
    fn allows_float(self) -> bool {
        true
    }
    fn allows_int(self) -> bool {
        true
    }
    fn allows_bool(self) -> bool {
        false
    }

    /// `ComputeAddRange`/`ComputeSubRange::operator()<float>` for `Add`/`Sub` (both
    /// share the same `GetRandom` helper, `getQuantizedFloat(rnd, min, max, 0.5)`, and
    /// the same `aMin`/`aMax` computation; only how `bMin`/`bMax` derive from
    /// `aOffset`/`subRangeLen`/`rangeLen` differs between the two), delegating to
    /// `compute_mul_range_float` for `Mul` (a genuinely different algorithm, not a
    /// variant of this shared formula).
    fn compute_value_range_float(self, rnd: &mut Random, dst_min: f32, dst_max: f32) -> (f32, f32, f32, f32) {
        if self == BinaryOpKind::Mul {
            return compute_mul_range_float(rnd, dst_min, dst_max);
        }

        let range_len = dst_max - dst_min;
        let sub_range_len = get_quantized_float(rnd, 0.0, range_len, 0.5);
        let a_offset = get_quantized_float(rnd, -8.0, 8.0, 0.5);

        let a_min = dst_min + a_offset;
        let a_max = a_min + sub_range_len;

        let (b_min, b_max) = match self {
            BinaryOpKind::Add => (-a_offset, -a_offset + (range_len - sub_range_len)),
            BinaryOpKind::Sub => (a_offset - (range_len - sub_range_len), a_offset),
            BinaryOpKind::Mul => unreachable!("handled by the early return above"),
        };

        (a_min, a_max, b_min, b_max)
    }

    /// `ComputeAddRange`/`ComputeSubRange::operator()<int>` for `Add`/`Sub` - same
    /// shape as the `float` overload, with `GetRandom` resolving to a plain
    /// `rnd.getInt(min, max)` instead; `Mul` delegates to `compute_mul_range_int`.
    fn compute_value_range_int(self, rnd: &mut Random, dst_min: i32, dst_max: i32) -> (i32, i32, i32, i32) {
        if self == BinaryOpKind::Mul {
            return compute_mul_range_int(rnd, dst_min, dst_max);
        }

        let range_len = dst_max - dst_min;
        let sub_range_len = rnd.get_int(0, range_len);
        let a_offset = rnd.get_int(-8, 8);

        let a_min = dst_min + a_offset;
        let a_max = a_min + sub_range_len;

        let (b_min, b_max) = match self {
            BinaryOpKind::Add => (-a_offset, -a_offset + (range_len - sub_range_len)),
            BinaryOpKind::Sub => (a_offset - (range_len - sub_range_len), a_offset),
            BinaryOpKind::Mul => unreachable!("handled by the early return above"),
        };

        (a_min, a_max, b_min, b_max)
    }

    /// `EvaluateAdd`/`EvaluateSub`/`EvaluateMul::operator()`.
    fn evaluate_float(self, a: f32, b: f32) -> f32 {
        match self {
            BinaryOpKind::Add => a + b,
            BinaryOpKind::Sub => a - b,
            BinaryOpKind::Mul => a * b,
        }
    }
    /// Wrapping, as upstream's plain `int` arithmetic does in practice: a generated
    /// expression may overflow on lanes whose result never reaches the output.
    fn evaluate_int(self, a: i32, b: i32) -> i32 {
        match self {
            BinaryOpKind::Add => a.wrapping_add(b),
            BinaryOpKind::Sub => a.wrapping_sub(b),
            BinaryOpKind::Mul => a.wrapping_mul(b),
        }
    }
}

/// `ComputeMulRange::operator()<float>` - a scale-search algorithm, genuinely different
/// from `Add`/`Sub`'s shared offset-split formula: pick a random scale, quantize the
/// output range divided by that scale into operand `a`'s range, then widen outward from
/// that scale (in `SCALE_STEP` increments, up to 5 steps either way) to find the widest
/// `b` range that still keeps `a * b` inside `[dstMin, dstMax)` for every combination of
/// `a`'s own extremes - `de::inBounds` is upstream's half-open `a <= x < b`, not the
/// closed `is_subset_of`-style range this port's `ValueRange` normally uses, so the
/// `in_bounds` helper below is deliberately its own thing. Finally, a coin flip
/// negates (and swaps the min/max of) both operand ranges, so roughly half of all
/// generated `Mul` expressions multiply two negative-leaning ranges instead.
fn compute_mul_range_float(rnd: &mut Random, dst_min: f32, dst_max: f32) -> (f32, f32, f32, f32) {
    const MIN_SCALE: f32 = 0.25;
    const MAX_SCALE: f32 = 2.0;
    const SUB_RANGE_STEP: f32 = 0.25;
    const SCALE_STEP: f32 = 0.25;

    fn in_bounds(x: f32, a: f32, b: f32) -> bool {
        a <= x && x < b
    }

    let mut scale = get_quantized_float(rnd, MIN_SCALE, MAX_SCALE, SCALE_STEP);
    let mut scaled_min = dst_min / scale;
    let mut scaled_max = dst_max / scale;

    if !quantize_float_range(&mut scaled_min, &mut scaled_max) {
        // Fall back to 1.0 as a scale.
        scale = 1.0;
        scaled_min = dst_min;
        scaled_max = dst_max;
    }

    let sub_range_len = get_quantized_float(rnd, 0.0, scaled_max - scaled_min, SUB_RANGE_STEP);
    let a_min = scaled_min + get_quantized_float(rnd, 0.0, (scaled_max - scaled_min) - sub_range_len, SUB_RANGE_STEP);
    let a_max = a_min + sub_range_len;

    // Find scale range.
    let mut b_min = scale;
    let mut b_max = scale;
    for i in 0..5 {
        let step = i as f32 * SCALE_STEP;

        if in_bounds(a_min * (scale - step), dst_min, dst_max) && in_bounds(a_max * (scale - step), dst_min, dst_max) {
            b_min = scale - step;
        }

        if in_bounds(a_min * (scale + step), dst_min, dst_max) && in_bounds(a_max * (scale + step), dst_min, dst_max) {
            b_max = scale + step;
        }
    }

    let (mut a_min, mut a_max, mut b_min, mut b_max) = (a_min, a_max, b_min, b_max);

    // Negative scale?
    if rnd.get_bool() {
        let (old_a_min, old_a_max, old_b_min, old_b_max) = (a_min, a_max, b_min, b_max);
        a_min = -old_a_max;
        a_max = -old_a_min;
        b_min = -old_b_max;
        b_max = -old_b_min;
    }

    debug_assert!(a_min <= a_max && b_min <= b_max);

    (a_min, a_max, b_min, b_max)
}

/// `ComputeMulRange::operator()<int>` - a confirmed upstream degenerate case, ported
/// faithfully rather than "fixed": the real body never reads `rnd` at all (unlike the
/// `float` overload) and always returns `bMin == bMax == 1`, so an integer `Mul`
/// expression can only ever multiply its `a` operand (whose range becomes the whole
/// requested output range, unchanged) by the literal `1`.
fn compute_mul_range_int(_rnd: &mut Random, dst_min: i32, dst_max: i32) -> (i32, i32, i32, i32) {
    (dst_min, dst_max, 1, 1)
}

impl BinaryOp {
    /// `BinaryVecOp::BinaryVecOp(GeneratorState&, Token::Type, ConstValueRangeAccess)`
    pub fn new(kind: BinaryOpKind, state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut resolved_range = ValueRange::from_access(value_range);

        if resolved_range.get_type().is_void() {
            let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();

            let mut base_types = Vec::new();
            if kind.allows_float() {
                base_types.push(Type::Float);
            }
            if kind.allows_int() {
                base_types.push(Type::Int);
            }
            if kind.allows_bool() {
                base_types.push(Type::Bool);
            }

            let base_type = *state.get_random().choose(&base_types);
            let num_elements = state.get_random().get_int(1, if available_levels >= 3 { 4 } else { 1 });

            resolved_range = ValueRange::new(VariableType::new_basic(base_type, num_elements));
            compute_random_value_range(state, resolved_range.as_access());
        }

        let type_ = resolved_range.get_type().clone();
        let mut value = ValueStorage::new(EXEC_VEC_WIDTH);
        value.set_storage(&type_);

        let mut left_value_range = ValueRange::new(type_.clone());
        let mut right_value_range = ValueRange::new(type_.clone());
        let base_type = type_.base_type();

        for elem_ndx in 0..type_.num_elements() {
            let dst = resolved_range.as_const_access().component(elem_ndx);

            if (base_type == Type::Float || base_type == Type::Int) && is_undefined_value_range(&dst) {
                // Just pass undefined ranges through, unchanged, on both sides.
                let min_read = dst.get_min().value();
                let max_read = dst.get_max().value();
                left_value_range
                    .as_access()
                    .component(elem_ndx)
                    .get_min()
                    .assign_from(&min_read);
                left_value_range
                    .as_access()
                    .component(elem_ndx)
                    .get_max()
                    .assign_from(&max_read);
                right_value_range
                    .as_access()
                    .component(elem_ndx)
                    .get_min()
                    .assign_from(&min_read);
                right_value_range
                    .as_access()
                    .component(elem_ndx)
                    .get_max()
                    .assign_from(&max_read);
                continue;
            }

            match base_type {
                Type::Float => {
                    let (a_min, a_max, b_min, b_max) = kind.compute_value_range_float(
                        state.get_random(),
                        dst.get_min().as_float(),
                        dst.get_max().as_float(),
                    );
                    let mut left_access = left_value_range.as_access();
                    let mut left_comp = left_access.component(elem_ndx);
                    left_comp.get_min().set_float(a_min);
                    left_comp.get_max().set_float(a_max);
                    let mut right_access = right_value_range.as_access();
                    let mut right_comp = right_access.component(elem_ndx);
                    right_comp.get_min().set_float(b_min);
                    right_comp.get_max().set_float(b_max);
                }
                Type::Int => {
                    let (a_min, a_max, b_min, b_max) = kind.compute_value_range_int(
                        state.get_random(),
                        dst.get_min().as_int(),
                        dst.get_max().as_int(),
                    );
                    let mut left_access = left_value_range.as_access();
                    let mut left_comp = left_access.component(elem_ndx);
                    left_comp.get_min().set_int(a_min);
                    left_comp.get_max().set_int(a_max);
                    let mut right_access = right_value_range.as_access();
                    let mut right_comp = right_access.component(elem_ndx);
                    right_comp.get_min().set_int(b_min);
                    right_comp.get_max().set_int(b_max);
                }
                _ => unreachable!("rsg::BinaryOp (Add/Sub/Mul): bool is never an allowed base type"),
            }
        }

        Self {
            kind,
            type_,
            value,
            left_value_range,
            right_value_range,
            left_expr: None,
            right_expr: None,
        }
    }

    /// `BinaryOp<P,A>::getWeight`, with `AddOp`/`MulOp::getWeight`'s own extra type
    /// filter applied first (both reject anything that is not `Void`/float/int).
    pub fn get_weight(kind: BinaryOpKind, state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        let type_ = value_range.get_type();
        if !(type_.is_void() || type_.is_float_or_vec() || type_.is_int_or_vec()) {
            return 0.0;
        }

        binary_op_base_get_weight(kind.precedence(), state, value_range)
    }

    /// `BinaryOp<P,A>::createNextChild` - built right-then-left, matching upstream's
    /// own (unexplained) order exactly. The corner-case `switch` upstream has here
    /// (injecting `CustomAbsOp`/`CustomBinaryOp` epsilon-correction nodes for
    /// `CMP_LE`/`CMP_GE`/`CMP_EQ`) is not reproduced - `Add`/`Sub`/`Mul`'s own tokens
    /// (`PLUS`/`MINUS`/`MUL`) never match any of those cases upstream either, so the
    /// omission changes nothing observable for the three kinds ported so far. See
    /// `BinaryOpKind`'s own doc comment for what a future comparison operator needs.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        let left_prec = self.kind.precedence();
        let right_prec = self.kind.precedence() - 1;

        if self.right_expr.is_none() {
            state.push_precedence(right_prec);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.right_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.right_expr = Some(Box::new(child));
            self.right_expr.as_deref_mut()
        } else if self.left_expr.is_none() {
            state.push_precedence(left_prec);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.left_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.left_expr = Some(Box::new(child));
            self.left_expr.as_deref_mut()
        } else {
            None
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left_expr
            .as_ref()
            .expect("BinaryOp::tokenize: left not set")
            .tokenize(var_manager, version, shader_type, stream);
        stream.push(self.kind.token());
        self.right_expr
            .as_ref()
            .expect("BinaryOp::tokenize: right not set")
            .tokenize(var_manager, version, shader_type, stream);
    }

    /// `BinaryOp<P,A>::evaluate(ExecutionContext&)` + `BinaryVecOp::evaluate(dst, a, b)`
    /// folded into one: both operands are snapshotted into owned storage first, since
    /// `get_value`'s unified-lifetime signature ties its return to `&mut ctx`'s own
    /// borrow - two such views (needed simultaneously to compute `f(left, right)` per
    /// lane) cannot both be held live from the same `ctx` at once, unlike upstream's
    /// two independent `ExecConstValueAccess` locals.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left_expr
            .as_deref_mut()
            .expect("BinaryOp::evaluate: left not set")
            .evaluate(var_manager, ctx);
        self.right_expr
            .as_deref_mut()
            .expect("BinaryOp::evaluate: right not set")
            .evaluate(var_manager, ctx);

        let type_ = self.type_.clone();

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.left_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            left_storage.get_value(&type_).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.right_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            right_storage.get_value(&type_).assign_from(&src);
        }

        self.value.set_storage(&type_);

        let left = left_storage.get_value_const(&type_);
        let right = right_storage.get_value_const(&type_);

        match type_.base_type() {
            Type::Float => {
                for elem_ndx in 0..type_.num_elements() {
                    let left_elem = left.component(elem_ndx);
                    let right_elem = right.component(elem_ndx);
                    let mut dst = self.value.get_value(&type_);
                    let mut dst_elem = dst.component(elem_ndx);
                    for lane in 0..EXEC_VEC_WIDTH {
                        let result = self
                            .kind
                            .evaluate_float(left_elem.as_float_at(lane), right_elem.as_float_at(lane));
                        dst_elem.set_float_at(lane, result);
                    }
                }
            }
            Type::Int => {
                for elem_ndx in 0..type_.num_elements() {
                    let left_elem = left.component(elem_ndx);
                    let right_elem = right.component(elem_ndx);
                    let mut dst = self.value.get_value(&type_);
                    let mut dst_elem = dst.component(elem_ndx);
                    for lane in 0..EXEC_VEC_WIDTH {
                        let result = self
                            .kind
                            .evaluate_int(left_elem.as_int_at(lane), right_elem.as_int_at(lane));
                        dst_elem.set_int_at(lane, result);
                    }
                }
            }
            _ => unreachable!("rsg::BinaryOp (Add/Sub/Mul): invalid type for arithmetic"),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&self.type_)
    }
}

/// `rsg::RelationalOp<ComputeValueRange, EvaluateComp>` - a genuinely different shape
/// from `BinaryOp`/`BinaryVecOp` despite sharing the same `BinaryOp<P,A>` C++ base:
/// the *output* is always a scalar `bool` regardless of the operand type, and the
/// operand type itself (`Float`/`Int`) is chosen randomly by the operator rather than
/// derived from the requested output range the way `BinaryVecOp`'s element type is -
/// which is why this is its own struct rather than a `BinaryOpKind` variant.
///
/// **`LessThan`/`GreaterThan`/`LessOrEqual`/`GreaterOrEqual` are ported**
/// (`BinaryOp<7, ASSOCIATIVITY_LEFT>`, `ComputeLessThanRange`/`ComputeGreaterThanRange`/
/// `ComputeLessOrEqualRange`/`ComputeGreaterOrEqualRange`). `LessOrEqual`/
/// `GreaterOrEqual` are the first kinds in this port needing the epsilon-correction
/// machinery the task description warned about: `RelationalOp::create_next_child`'s own
/// `CMP_LE`/`CMP_GE` corner case (ported below, see `EpsilonAddOp`) adds a `+0.001`
/// literal to one float operand, "to resolve float comparison corner case[s]" in
/// upstream's own words. `NotEqualOp`/`EqualOp` use a third, different constructor shape
/// (`EqualityComparisonOp<bool IsEqual>`, also ported, below) that additionally compares
/// *per-component* over a potentially-vector operand (confirmed by reading
/// `rsgBinaryOps.cpp` in full - this is a materially different evaluate/range shape from
/// every other `RelationalOp`/`BinaryOp` kind here, not just "the two remaining enum
/// variants"). **`EqualOp`'s own `CMP_EQ` corner case is ported too** (`CustomAbsOp`/
/// `CustomSubOp`/`CustomLessThanOp`, see `EqualityComparisonOp`'s own doc comment) -
/// this stale note used to say otherwise; trust that struct's doc comment over this one
/// if the two ever disagree again.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum RelationalOpKind {
    LessThan,
    GreaterThan,
    LessOrEqual,
    GreaterOrEqual,
}

impl RelationalOpKind {
    /// `LessThanBase`/`GreaterThanBase`/`LessOrEqualBase`/`GreaterOrEqualBase` are all
    /// `RelationalOp<...>`, itself `BinaryOp<7, ASSOCIATIVITY_LEFT>`.
    fn precedence(self) -> i32 {
        7
    }

    fn token(self) -> Token {
        match self {
            RelationalOpKind::LessThan => Token::CmpLt,
            RelationalOpKind::GreaterThan => Token::CmpGt,
            RelationalOpKind::LessOrEqual => Token::CmpLe,
            RelationalOpKind::GreaterOrEqual => Token::CmpGe,
        }
    }

    /// `ComputeLessThanRange`/`ComputeGreaterThanRange`/`ComputeLessOrEqualRange`/
    /// `ComputeGreaterOrEqualRange::operator()<float>` - `GreaterThan`/`GreaterOrEqual`
    /// are each defined upstream, inline, as their `LessThan`/`LessOrEqual` sibling with
    /// `a`/`b` swapped (confirmed by reading both real header definitions, not assumed
    /// from the names).
    fn compute_value_range_float(self, rnd: &mut Random, dst_min: bool, dst_max: bool) -> (f32, f32, f32, f32) {
        match self {
            RelationalOpKind::LessThan => compute_less_than_range_float(rnd, dst_min, dst_max),
            RelationalOpKind::GreaterThan => {
                let (a_min, a_max, b_min, b_max) = compute_less_than_range_float(rnd, dst_min, dst_max);
                (b_min, b_max, a_min, a_max)
            }
            RelationalOpKind::LessOrEqual => compute_less_or_equal_range_float(rnd, dst_min, dst_max),
            RelationalOpKind::GreaterOrEqual => {
                let (a_min, a_max, b_min, b_max) = compute_less_or_equal_range_float(rnd, dst_min, dst_max);
                (b_min, b_max, a_min, a_max)
            }
        }
    }

    /// `ComputeLessThanRange`/`ComputeGreaterThanRange`/`ComputeLessOrEqualRange`/
    /// `ComputeGreaterOrEqualRange::operator()<int>`
    fn compute_value_range_int(self, rnd: &mut Random, dst_min: bool, dst_max: bool) -> (i32, i32, i32, i32) {
        match self {
            RelationalOpKind::LessThan => compute_less_than_range_int(rnd, dst_min, dst_max),
            RelationalOpKind::GreaterThan => {
                let (a_min, a_max, b_min, b_max) = compute_less_than_range_int(rnd, dst_min, dst_max);
                (b_min, b_max, a_min, a_max)
            }
            RelationalOpKind::LessOrEqual => compute_less_or_equal_range_int(rnd, dst_min, dst_max),
            RelationalOpKind::GreaterOrEqual => {
                let (a_min, a_max, b_min, b_max) = compute_less_or_equal_range_int(rnd, dst_min, dst_max);
                (b_min, b_max, a_min, a_max)
            }
        }
    }

    /// `EvaluateLessThan`/`EvaluateGreaterThan`/`EvaluateLessOrEqual`/
    /// `EvaluateGreaterOrEqual::operator()`.
    fn evaluate_float(self, a: f32, b: f32) -> bool {
        match self {
            RelationalOpKind::LessThan => a < b,
            RelationalOpKind::GreaterThan => a > b,
            RelationalOpKind::LessOrEqual => a <= b,
            RelationalOpKind::GreaterOrEqual => a >= b,
        }
    }
    fn evaluate_int(self, a: i32, b: i32) -> bool {
        match self {
            RelationalOpKind::LessThan => a < b,
            RelationalOpKind::GreaterThan => a > b,
            RelationalOpKind::LessOrEqual => a <= b,
            RelationalOpKind::GreaterOrEqual => a >= b,
        }
    }
}

/// `ComputeLessThanRange::operator()<float>` - the one real algorithm
/// `RelationalOpKind::compute_value_range_float` shares between `LessThan` (used
/// directly) and `GreaterThan` (used with `a`/`b` swapped).
fn compute_less_than_range_float(rnd: &mut Random, dst_min: bool, dst_max: bool) -> (f32, f32, f32, f32) {
    const STEP: f32 = 0.25;

    let r_len = get_quantized_float(rnd, 0.0, 8.0, STEP);
    let r_min = get_quantized_float(rnd, -4.0, 4.0, STEP);
    let r_max = r_min + r_len;

    if !dst_min && dst_max {
        // Both values are possible, use the same range for both inputs.
        (r_min, r_max, r_min, r_max)
    } else if dst_min && dst_max {
        // Compute a range that is less than rMin..rMax.
        let a_len = get_quantized_float(rnd, 0.0, 8.0 - r_len, STEP);
        let a_max = r_min - STEP;
        let a_min = a_max - a_len;
        (a_min, a_max, r_min, r_max)
    } else {
        // Compute a range that is greater than or equal to rMin..rMax.
        let a_len = get_quantized_float(rnd, 0.0, 8.0 - r_len, STEP);
        let a_min = r_max;
        let a_max = a_min + a_len;
        (a_min, a_max, r_min, r_max)
    }
}

/// `ComputeLessThanRange::operator()<int>`
fn compute_less_than_range_int(rnd: &mut Random, dst_min: bool, dst_max: bool) -> (i32, i32, i32, i32) {
    const STEP: i32 = 1;

    let r_len = rnd.get_int(0, 8);
    let r_min = rnd.get_int(-4, 4);
    let r_max = r_min + r_len;

    if !dst_min && dst_max {
        (r_min, r_max, r_min, r_max)
    } else if dst_min && dst_max {
        let a_len = rnd.get_int(0, 8 - r_len);
        let a_max = r_min - STEP;
        let a_min = a_max - a_len;
        (a_min, a_max, r_min, r_max)
    } else {
        let a_len = rnd.get_int(0, 8 - r_len);
        let a_min = r_max;
        let a_max = a_min + a_len;
        (a_min, a_max, r_min, r_max)
    }
}

/// `ComputeLessOrEqualRange::operator()<float>` - the one real algorithm
/// `RelationalOpKind::compute_value_range_float` shares between `LessOrEqual` (used
/// directly) and `GreaterOrEqual` (used with `a`/`b` swapped). Differs from
/// `compute_less_than_range_float` in exactly where the `STEP` offset moves between the
/// second and third branch: `<=` allows equality in branch 2 (no offset, `a_max =
/// r_min`) and excludes it in branch 3 (`a_min = r_max + STEP`), the opposite of `<`'s
/// own placement - confirmed by reading `ComputeLessOrEqualRange`'s real body
/// side-by-side with `ComputeLessThanRange`'s, not inferred from the operator name.
fn compute_less_or_equal_range_float(rnd: &mut Random, dst_min: bool, dst_max: bool) -> (f32, f32, f32, f32) {
    const STEP: f32 = 0.25;

    let r_len = get_quantized_float(rnd, 0.0, 8.0, STEP);
    let r_min = get_quantized_float(rnd, -4.0, 4.0, STEP);
    let r_max = r_min + r_len;

    if !dst_min && dst_max {
        // Both values are possible, use the same range for both inputs.
        (r_min, r_max, r_min, r_max)
    } else if dst_min && dst_max {
        // Compute a range that is less than or equal to rMin..rMax.
        let a_len = get_quantized_float(rnd, 0.0, 8.0 - r_len, STEP);
        let a_max = r_min;
        let a_min = a_max - a_len;
        (a_min, a_max, r_min, r_max)
    } else {
        // Compute a range that is greater than rMin..rMax.
        let a_len = get_quantized_float(rnd, 0.0, 8.0 - r_len, STEP);
        let a_min = r_max + STEP;
        let a_max = a_min + a_len;
        (a_min, a_max, r_min, r_max)
    }
}

/// `ComputeLessOrEqualRange::operator()<int>`
fn compute_less_or_equal_range_int(rnd: &mut Random, dst_min: bool, dst_max: bool) -> (i32, i32, i32, i32) {
    const STEP: i32 = 1;

    let r_len = rnd.get_int(0, 8);
    let r_min = rnd.get_int(-4, 4);
    let r_max = r_min + r_len;

    if !dst_min && dst_max {
        (r_min, r_max, r_min, r_max)
    } else if dst_min && dst_max {
        let a_len = rnd.get_int(0, 8 - r_len);
        let a_max = r_min;
        let a_min = a_max - a_len;
        (a_min, a_max, r_min, r_max)
    } else {
        let a_len = rnd.get_int(0, 8 - r_len);
        let a_min = r_max + STEP;
        let a_max = a_min + a_len;
        (a_min, a_max, r_min, r_max)
    }
}

/// `rsg::CustomBinaryOp<EvaluateAdd>` - the epsilon-correction node upstream's
/// `BinaryOp<P,A>::createNextChild` splices into an already-finished tree for the
/// `CMP_LE`/`CMP_GE` corner case (see `RelationalOp::create_next_child` below): wraps an
/// already-built float-scalar expression as `(expr + 0.001)`, with no space/parens -
/// upstream's own `CustomBinaryOp` is itself a bare `BinaryOp<5, ASSOCIATIVITY_LEFT>`
/// whose `tokenize`/`evaluate` are the plain inherited ones, just with its children set
/// directly (`setLeftValue`/`setRightValue`) instead of built through
/// `createNextChild`. **This node's own `createNextChild` is never called** - upstream's
/// real one is `DE_ASSERT(0); return nullptr;`, i.e. a trap for "this should be
/// unreachable" - because `generate_children`'s walk has already finished with this
/// `RelationalOp` by the time the wrap happens (the wrap occurs on the *third*
/// `create_next_child` call, which returns `None` and ends the walk - see that method's
/// own doc comment for the exact sequencing), so this port's own `create_next_child`
/// just returns `None` rather than reproducing the trap, since Rust never calls it either.
pub struct EpsilonAddOp {
    left: Box<Expression>,
    right: Box<Expression>,
    value: ValueStorage,
}

impl EpsilonAddOp {
    /// Wraps `expr` as `expr + 0.001`.
    pub fn wrap(expr: Expression) -> Self {
        Self {
            left: Box::new(expr),
            right: Box::new(Expression::Float(FloatLiteral::new_custom(0.001))),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        }
    }

    pub fn create_next_child(
        &mut self,
        _state: &mut GeneratorState<'_>,
        _var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        None
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::Plus);
        self.right.tokenize(var_manager, version, shader_type, stream);
    }

    /// Same operand-snapshotting shape as `BinaryOp::evaluate` - see that method's own
    /// doc comment for why both operands need their own owned storage first.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left.evaluate(var_manager, ctx);
        self.right.evaluate(var_manager, ctx);

        let type_ = VariableType::scalar_type(Type::Float);

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.left.get_value(var_manager, ctx).value();
            left_storage.get_value(&type_).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.right.get_value(var_manager, ctx).value();
            right_storage.get_value(&type_).assign_from(&src);
        }

        self.value.set_storage(&type_);
        let left = left_storage.get_value_const(&type_);
        let right = right_storage.get_value_const(&type_);
        let mut dst = self.value.get_value(&type_);
        for lane in 0..EXEC_VEC_WIDTH {
            dst.set_float_at(lane, left.as_float_at(lane) + right.as_float_at(lane));
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Float))
    }
}

/// `rsg::CustomAbsOp` - the `abs()` wrapper `EqualityComparisonOp`'s own `CMP_EQ`
/// epsilon-correction corner case needs on top of what `EpsilonAddOp`
/// (`CustomBinaryOp<EvaluateAdd>`) already covers for `LessOrEqual`/`GreaterOrEqual` -
/// see that struct's own doc comment, and `EqualityComparisonOp::create_next_child`
/// below for the full spliced tree this and `CustomSubOp`/`CustomLessThanOp` build.
/// Upstream's own `CustomAbsOp` is a bare `Expression` (not a `BinaryOp` subclass, since
/// it only ever has one child): `m_function("abs")`/`m_type(TYPE_FLOAT, 1)`, with
/// `setChild` taking the already-built operand directly instead of `createNextChild`
/// driving it. Same "never actually dispatched through `create_next_child`" shape
/// `EpsilonAddOp` already has, and for the identical reason: upstream's real
/// `createNextChild` is `DE_ASSERT(0); return nullptr;`, unreachable because the splice
/// happens only after the walk that would have called it has already finished - this
/// port's own version just returns `None` rather than reproducing the trap.
pub struct CustomAbsOp {
    child: Box<Expression>,
    value: ValueStorage,
}

impl CustomAbsOp {
    /// `CustomAbsOp::setChild`, folded into construction since nothing here needs the
    /// two-step upstream shape (`setChild` is upstream's only way to supply the child -
    /// there is no constructor-time equivalent there either).
    pub fn wrap(child: Expression) -> Self {
        Self {
            child: Box::new(child),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        }
    }

    pub fn create_next_child(
        &mut self,
        _state: &mut GeneratorState<'_>,
        _var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        None
    }

    /// `CustomAbsOp::tokenize` - `abs(<child>)`, the one node in this file emitting a
    /// bare function-call shape outside `BuiltinFunctionOp` (same `Token::identifier` +
    /// paren pattern that struct already uses).
    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        stream.push(Token::identifier("abs"));
        stream.push(Token::LeftParen);
        self.child.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::RightParen);
    }

    /// `CustomAbsOp::evaluate` - per-lane `deFloatAbs`.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.child.evaluate(var_manager, ctx);

        let type_ = VariableType::scalar_type(Type::Float);
        self.value.set_storage(&type_);

        let src = self.child.get_value(var_manager, ctx);
        let mut dst = self.value.get_value(&type_);
        for lane in 0..EXEC_VEC_WIDTH {
            dst.set_float_at(lane, src.as_float_at(lane).abs());
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Float))
    }
}

/// `rsg::CustomBinaryOp<EvaluateSub>` - the float-subtraction sibling of `EpsilonAddOp`
/// (`CustomBinaryOp<EvaluateAdd>`), needed by the same `CMP_EQ` corner case for `lhs -
/// (rhs)`. Same shape and same "never dispatched through `create_next_child`" note as
/// `EpsilonAddOp`/`CustomAbsOp` above - see `EpsilonAddOp`'s own doc comment for why.
pub struct CustomSubOp {
    left: Box<Expression>,
    right: Box<Expression>,
    value: ValueStorage,
}

impl CustomSubOp {
    pub fn new(left: Expression, right: Expression) -> Self {
        Self {
            left: Box::new(left),
            right: Box::new(right),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        }
    }

    pub fn create_next_child(
        &mut self,
        _state: &mut GeneratorState<'_>,
        _var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        None
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::Minus);
        self.right.tokenize(var_manager, version, shader_type, stream);
    }

    /// Same operand-snapshotting shape as `EpsilonAddOp::evaluate` - see that method's
    /// own doc comment for why both operands need their own owned storage first.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left.evaluate(var_manager, ctx);
        self.right.evaluate(var_manager, ctx);

        let type_ = VariableType::scalar_type(Type::Float);

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.left.get_value(var_manager, ctx).value();
            left_storage.get_value(&type_).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.right.get_value(var_manager, ctx).value();
            right_storage.get_value(&type_).assign_from(&src);
        }

        self.value.set_storage(&type_);
        let left = left_storage.get_value_const(&type_);
        let right = right_storage.get_value_const(&type_);
        let mut dst = self.value.get_value(&type_);
        for lane in 0..EXEC_VEC_WIDTH {
            dst.set_float_at(lane, left.as_float_at(lane) - right.as_float_at(lane));
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Float))
    }
}

/// `rsg::CustomBinaryOp<EvaluateLessThan>` - the last of the three epsilon-correction
/// helpers the `CMP_EQ` corner case needs (`abs(...) < epsilon`). Unlike `EpsilonAddOp`/
/// `CustomSubOp`, its *output* is `bool` while both operands stay `float` - matching
/// upstream's own `CustomBinaryOp<EvaluateLessThan>` constructor specialization exactly
/// (`m_type = VariableType(TYPE_BOOL, 1)`, `m_leftValueRange`/`m_rightValueRange` both
/// still float scalar).
pub struct CustomLessThanOp {
    left: Box<Expression>,
    right: Box<Expression>,
    value: ValueStorage,
}

impl CustomLessThanOp {
    pub fn new(left: Expression, right: Expression) -> Self {
        Self {
            left: Box::new(left),
            right: Box::new(right),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        }
    }

    pub fn create_next_child(
        &mut self,
        _state: &mut GeneratorState<'_>,
        _var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        None
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::CmpLt);
        self.right.tokenize(var_manager, version, shader_type, stream);
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left.evaluate(var_manager, ctx);
        self.right.evaluate(var_manager, ctx);

        let in_type = VariableType::scalar_type(Type::Float);

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.left.get_value(var_manager, ctx).value();
            left_storage.get_value(&in_type).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.right.get_value(var_manager, ctx).value();
            right_storage.get_value(&in_type).assign_from(&src);
        }

        let bool_type = VariableType::scalar_type(Type::Bool);
        self.value.set_storage(&bool_type);

        let left = left_storage.get_value_const(&in_type);
        let right = right_storage.get_value_const(&in_type);
        let mut dst = self.value.get_value(&bool_type);
        for lane in 0..EXEC_VEC_WIDTH {
            dst.set_bool_at(lane, left.as_float_at(lane) < right.as_float_at(lane));
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::scalar_type(Type::Bool))
    }
}

pub struct RelationalOp {
    kind: RelationalOpKind,
    in_type: VariableType,
    value: ValueStorage,
    left_value_range: ValueRange,
    right_value_range: ValueRange,
    left_expr: Option<Box<Expression>>,
    right_expr: Option<Box<Expression>>,
}

impl RelationalOp {
    /// `RelationalOp::RelationalOp(GeneratorState&, Token::Type, ConstValueRangeAccess)`
    pub fn new(
        kind: RelationalOpKind,
        state: &mut GeneratorState<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        let mut resolved_range = ValueRange::from_access(value_range);

        if resolved_range.get_type().is_void() {
            resolved_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
            compute_random_value_range(state, resolved_range.as_access());
        }

        let out_type = resolved_range.get_type().clone();
        let mut value = ValueStorage::new(EXEC_VEC_WIDTH);
        value.set_storage(&out_type);

        let in_base_types = [Type::Float, Type::Int];
        let in_base_type = *state.get_random().choose(&in_base_types);

        let mut left_value_range = ValueRange::new(VariableType::new_basic(in_base_type, 1));
        let mut right_value_range = ValueRange::new(VariableType::new_basic(in_base_type, 1));

        let dst_min = resolved_range.get_min_const().as_bool();
        let dst_max = resolved_range.get_max_const().as_bool();

        match in_base_type {
            Type::Float => {
                let (a_min, a_max, b_min, b_max) = kind.compute_value_range_float(state.get_random(), dst_min, dst_max);
                left_value_range.get_min().set_float(a_min);
                left_value_range.get_max().set_float(a_max);
                right_value_range.get_min().set_float(b_min);
                right_value_range.get_max().set_float(b_max);
            }
            Type::Int => {
                let (a_min, a_max, b_min, b_max) = kind.compute_value_range_int(state.get_random(), dst_min, dst_max);
                left_value_range.get_min().set_int(a_min);
                left_value_range.get_max().set_int(a_max);
                right_value_range.get_min().set_int(b_min);
                right_value_range.get_max().set_int(b_max);
            }
            _ => unreachable!("rsg::RelationalOp: operand base type is always Float or Int"),
        }

        Self {
            kind,
            in_type: VariableType::new_basic(in_base_type, 1),
            value,
            left_value_range,
            right_value_range,
            left_expr: None,
            right_expr: None,
        }
    }

    /// `RelationalOp<...>::getWeight`
    pub fn get_weight(
        kind: RelationalOpKind,
        state: &GeneratorState<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        if !state.get_program_parameters().use_comparison_ops {
            return 0.0;
        }

        let type_ = value_range.get_type();
        if !(type_.is_void() || (type_.base_type() == Type::Bool && type_.num_elements() == 1)) {
            return 0.0;
        }

        binary_op_base_get_weight(kind.precedence(), state, value_range)
    }

    /// `BinaryOp<P,A>::createNextChild`, inherited unchanged by `RelationalOp` - built
    /// right-then-left, same as `BinaryOp::create_next_child`, with upstream's own
    /// corner-case `switch` now reproduced for the two kinds that need it:
    /// `LessOrEqual`/`GreaterOrEqual` wrap the just-finished right/left child in an
    /// `EpsilonAddOp` (`expr + 0.001`) once both children exist, but only when that
    /// operand's own type is float scalar - matching upstream's `m_rightValueRange.
    /// getType() == floatType`/`m_leftValueRange.getType() == floatType` guards exactly
    /// (here, simply `self.in_type == float scalar`, since `RelationalOp`'s own left/
    /// right ranges always share one type). `LessThan`/`GreaterThan` never match this
    /// switch's `CMP_LE`/`CMP_GE`/`CMP_EQ` cases, so they are unaffected.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        let left_prec = self.kind.precedence();
        let right_prec = self.kind.precedence() - 1;

        if self.right_expr.is_none() {
            state.push_precedence(right_prec);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.right_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.right_expr = Some(Box::new(child));
            self.right_expr.as_deref_mut()
        } else if self.left_expr.is_none() {
            state.push_precedence(left_prec);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.left_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.left_expr = Some(Box::new(child));
            self.left_expr.as_deref_mut()
        } else {
            let is_float_scalar = self.in_type == VariableType::new_basic(Type::Float, 1);

            match self.kind {
                RelationalOpKind::LessOrEqual if is_float_scalar => {
                    let right = self.right_expr.take().expect("right_expr just checked Some above");
                    self.right_expr = Some(Box::new(Expression::EpsilonAdd(EpsilonAddOp::wrap(*right))));
                }
                RelationalOpKind::GreaterOrEqual if is_float_scalar => {
                    let left = self.left_expr.take().expect("left_expr just checked Some above");
                    self.left_expr = Some(Box::new(Expression::EpsilonAdd(EpsilonAddOp::wrap(*left))));
                }
                _ => {}
            }

            None
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left_expr
            .as_ref()
            .expect("RelationalOp::tokenize: left not set")
            .tokenize(var_manager, version, shader_type, stream);
        stream.push(self.kind.token());
        self.right_expr
            .as_ref()
            .expect("RelationalOp::tokenize: right not set")
            .tokenize(var_manager, version, shader_type, stream);
    }

    /// `RelationalOp<...>::evaluate(dst, a, b)` (`BinaryOp<P,A>::evaluate(ExecutionContext&)`
    /// inherited unchanged) - same operand-snapshotting shape as `BinaryOp::evaluate`,
    /// see that method's own doc comment for why.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left_expr
            .as_deref_mut()
            .expect("RelationalOp::evaluate: left not set")
            .evaluate(var_manager, ctx);
        self.right_expr
            .as_deref_mut()
            .expect("RelationalOp::evaluate: right not set")
            .evaluate(var_manager, ctx);

        let in_type = self.in_type.clone();

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.left_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            left_storage.get_value(&in_type).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.right_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            right_storage.get_value(&in_type).assign_from(&src);
        }

        let bool_type = VariableType::new_basic(Type::Bool, 1);
        self.value.set_storage(&bool_type);

        let left = left_storage.get_value_const(&in_type);
        let right = right_storage.get_value_const(&in_type);
        let mut dst = self.value.get_value(&bool_type);

        match in_type.base_type() {
            Type::Float => {
                for lane in 0..EXEC_VEC_WIDTH {
                    let result = self
                        .kind
                        .evaluate_float(left.as_float_at(lane), right.as_float_at(lane));
                    dst.set_bool_at(lane, result);
                }
            }
            Type::Int => {
                for lane in 0..EXEC_VEC_WIDTH {
                    let result = self.kind.evaluate_int(left.as_int_at(lane), right.as_int_at(lane));
                    dst.set_bool_at(lane, result);
                }
            }
            _ => unreachable!("rsg::RelationalOp: operand base type is always Float or Int"),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::new_basic(Type::Bool, 1))
    }
}

/// `rsg::EqualityComparisonOp<bool IsEqual>` - `EqualOp`/`NotEqualOp`'s shared base,
/// a third shape genuinely different from both `BinaryOp` and `RelationalOp`: unlike
/// `RelationalOp`'s always-scalar operands, this compares *per-component* over a
/// potentially-vector operand (`num_elements` drawn 1..=4 the same way `BinaryVecOp`'s
/// is) and combines the per-component boolean results with `&&` (`Equal`) or `||`
/// (`NotEqual`) - confirmed by reading `EqualityComparisonOp<IsEqual>::evaluate`'s real
/// body in full, not assumed from the name. `BinaryOp<8, ASSOCIATIVITY_LEFT>` for both
/// kinds (one precedence higher/tighter-binding than `RelationalOp`'s 7).
///
/// **The `CMP_EQ` epsilon-correction corner case is now ported** (`CustomAbsOp`/
/// `CustomSubOp`/`CustomLessThanOp` above). Reading
/// `BinaryOp<P,A>::createNextChild`'s own switch in full: `Equal`'s `createNextChild`
/// rewrites the *whole* tree into `((abs(lhs - (rhs)) < epsilon) == true)` whenever both
/// operands are scalar float (`m_leftValueRange.getType() == VariableType(TYPE_FLOAT,
/// 1)` - an *exact* match, so a vector or int operand is unaffected), needing
/// `CustomAbsOp` - `EpsilonAddOp`
/// already covers the sibling `CustomBinaryOp<EvaluateAdd>` instance the `LessOrEqual`/
/// `GreaterOrEqual` corner case needs, but this one additionally chains
/// `CustomSubOp`/`CustomLessThanOp` (`CustomBinaryOp<EvaluateSub>`/`<EvaluateLessThan>`),
/// a `ParenOp` wrapped around the original right-hand side (for the subtraction's own
/// precedence), a second `ParenOp` wrapped around the final `<` comparison, and a
/// `BoolLiteral(true)` on the right - all five spliced directly into `self.left_expr`/
/// `self.right_expr` in the third `create_next_child` call, exactly where `RelationalOp`'s
/// own `CMP_LE`/`CMP_GE` rewrite splices its single `EpsilonAddOp`. `NotEqual`'s own token
/// (`CMP_NE`) never matches this switch case at all, so `NotEqualOp` carries no such gap
/// - confirmed, not assumed, by reading the switch's own `case` labels, and reproduced
///   here by gating the rewrite on `self.kind == EqualityOpKind::Equal` explicitly.
///
/// **The generic `computeEqualityValueRange` template's explicit `bool` specializations
/// are dead code at this call site, not ported**: `inBaseTypes` (the array `new`'s own
/// random draw picks the *constructor's* input base type from) is `{TYPE_FLOAT,
/// TYPE_INT}` only - `TYPE_BOOL` is never a reachable choice there, confirmed by reading
/// the constructor's own array literal, not inferred. This port's
/// `compute_equality_value_range_float`/`_int` therefore only need to reproduce the
/// *generic* (non-bool-specialized) `computeEqualityValueRange<IsEqual, T>` template,
/// which itself reduces to `ComputeLessThanRange` calls plus one "must be exactly equal"
/// branch - no new range algorithm beyond what `compute_less_than_range_float`/`_int`
/// already provide.
///
/// **`EqualityComparisonOp::evaluate`'s own `switch` DOES need its `TYPE_BOOL` case
/// ported, though** (added alongside the `CMP_EQ` rewrite above) - that one is reachable
/// after all, just not through the constructor's input-type choice: the rewrite's own
/// output tree evaluates to bool, and `evaluate`'s 3-arg override reads its operand type
/// dynamically off whatever `left_expr`/`right_expr` currently report (see that
/// method's own doc comment for the full reasoning and the `debug_assert!` that would
/// have caught the mismatch if this had been missed).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum EqualityOpKind {
    Equal,
    NotEqual,
}

impl EqualityOpKind {
    fn is_equal(self) -> bool {
        matches!(self, EqualityOpKind::Equal)
    }

    fn token(self) -> Token {
        match self {
            EqualityOpKind::Equal => Token::CmpEq,
            EqualityOpKind::NotEqual => Token::CmpNe,
        }
    }
}

/// `computeEqualityValueRange<IsEqual, float>` - see `EqualityComparisonOp`'s own doc
/// comment for why only the generic (non-`bool`) template needs reproducing here.
fn compute_equality_value_range_float(
    kind: EqualityOpKind,
    rnd: &mut Random,
    dst_min: bool,
    dst_max: bool,
) -> (f32, f32, f32, f32) {
    if !dst_min && dst_max {
        compute_less_than_range_float(rnd, false, true)
    } else if (kind.is_equal() && !dst_min) || (!kind.is_equal() && dst_min) {
        compute_less_than_range_float(rnd, true, true)
    } else {
        // Must have exactly the same value.
        let val = get_quantized_float(rnd, -1.0, 1.0, 0.5);
        (val, val, val, val)
    }
}

/// `computeEqualityValueRange<IsEqual, int>`
fn compute_equality_value_range_int(
    kind: EqualityOpKind,
    rnd: &mut Random,
    dst_min: bool,
    dst_max: bool,
) -> (i32, i32, i32, i32) {
    if !dst_min && dst_max {
        compute_less_than_range_int(rnd, false, true)
    } else if (kind.is_equal() && !dst_min) || (!kind.is_equal() && dst_min) {
        compute_less_than_range_int(rnd, true, true)
    } else {
        let val = rnd.get_int(-1, 1);
        (val, val, val, val)
    }
}

const EQUALITY_PRECEDENCE: i32 = 8;

pub struct EqualityComparisonOp {
    kind: EqualityOpKind,
    in_type: VariableType,
    value: ValueStorage,
    left_value_range: ValueRange,
    right_value_range: ValueRange,
    left_expr: Option<Box<Expression>>,
    right_expr: Option<Box<Expression>>,
}

impl EqualityComparisonOp {
    /// `EqualityComparisonOp<IsEqual>::EqualityComparisonOp(GeneratorState&,
    /// ConstValueRangeAccess)`
    pub fn new(kind: EqualityOpKind, state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let mut resolved_range = ValueRange::from_access(value_range);

        if resolved_range.get_type().is_void() {
            resolved_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
            compute_random_value_range(state, resolved_range.as_access());
        }

        let out_type = resolved_range.get_type().clone();
        let mut value = ValueStorage::new(EXEC_VEC_WIDTH);
        value.set_storage(&out_type);

        let in_base_types = [Type::Float, Type::Int];
        let in_base_type = *state.get_random().choose(&in_base_types);
        let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();
        let num_elements = state.get_random().get_int(1, if available_levels >= 3 { 4 } else { 1 });

        let mut left_value_range = ValueRange::new(VariableType::new_basic(in_base_type, num_elements));
        let mut right_value_range = ValueRange::new(VariableType::new_basic(in_base_type, num_elements));

        let dst_min = resolved_range.get_min_const().as_bool();
        let dst_max = resolved_range.get_max_const().as_bool();

        for elem_ndx in 0..num_elements {
            match in_base_type {
                Type::Float => {
                    let (a_min, a_max, b_min, b_max) =
                        compute_equality_value_range_float(kind, state.get_random(), dst_min, dst_max);
                    let mut left_access = left_value_range.as_access();
                    let mut left_comp = left_access.component(elem_ndx);
                    left_comp.get_min().set_float(a_min);
                    left_comp.get_max().set_float(a_max);
                    let mut right_access = right_value_range.as_access();
                    let mut right_comp = right_access.component(elem_ndx);
                    right_comp.get_min().set_float(b_min);
                    right_comp.get_max().set_float(b_max);
                }
                Type::Int => {
                    let (a_min, a_max, b_min, b_max) =
                        compute_equality_value_range_int(kind, state.get_random(), dst_min, dst_max);
                    let mut left_access = left_value_range.as_access();
                    let mut left_comp = left_access.component(elem_ndx);
                    left_comp.get_min().set_int(a_min);
                    left_comp.get_max().set_int(a_max);
                    let mut right_access = right_value_range.as_access();
                    let mut right_comp = right_access.component(elem_ndx);
                    right_comp.get_min().set_int(b_min);
                    right_comp.get_max().set_int(b_max);
                }
                _ => unreachable!("rsg::EqualityComparisonOp: operand base type is always Float or Int"),
            }
        }

        Self {
            kind,
            in_type: VariableType::new_basic(in_base_type, num_elements),
            value,
            left_value_range,
            right_value_range,
            left_expr: None,
            right_expr: None,
        }
    }

    /// `EqualityComparisonOp<IsEqual>::getWeight`
    pub fn get_weight(
        kind: EqualityOpKind,
        state: &GeneratorState<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> f32 {
        if !state.get_program_parameters().use_comparison_ops {
            return 0.0;
        }

        let type_ = value_range.get_type();
        if !(type_.is_void() || (type_.base_type() == Type::Bool && type_.num_elements() == 1)) {
            return 0.0;
        }

        let _ = kind; // Both kinds share one precedence/weight shape.
        binary_op_base_get_weight(EQUALITY_PRECEDENCE, state, value_range)
    }

    /// `BinaryOp<P,A>::createNextChild` - built right-then-left, same as
    /// `BinaryOp`/`RelationalOp`'s own, with `Equal`'s own `CMP_EQ` corner case (see
    /// this struct's own doc comment) now reproduced on the third call: once both
    /// children exist, a scalar-float `Equal` comparison has its whole tree rewritten
    /// into `((abs(lhs - (rhs)) < 0.001) == true)`, matching upstream's exact-type guard
    /// (`m_leftValueRange.getType() == VariableType(TYPE_FLOAT, 1)`) - a vector or int
    /// operand, or a `NotEqual` kind, leaves `left_expr`/`right_expr` untouched.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.right_expr.is_none() {
            state.push_precedence(EQUALITY_PRECEDENCE - 1);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.right_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.right_expr = Some(Box::new(child));
            self.right_expr.as_deref_mut()
        } else if self.left_expr.is_none() {
            state.push_precedence(EQUALITY_PRECEDENCE);
            let child = super::expression_generator::create_random(
                state,
                var_manager,
                &self.left_value_range.as_const_access(),
            );
            state.pop_precedence();
            self.left_expr = Some(Box::new(child));
            self.left_expr.as_deref_mut()
        } else {
            let is_float_scalar =
                self.kind == EqualityOpKind::Equal && self.in_type == VariableType::new_basic(Type::Float, 1);

            if is_float_scalar {
                let right = self.right_expr.take().expect("right_expr just checked Some above");
                let left = self.left_expr.take().expect("left_expr just checked Some above");

                let bool_type = VariableType::new_basic(Type::Bool, 1);

                // `(rhs)` - matches upstream's own `ParenOp parenRight` around the
                // original right-hand side before the subtraction.
                let mut paren_right = ParenOp::new(ValueRange::new(bool_type.clone()));
                paren_right.set_child(*right);

                // `lhs - (rhs)`, then `abs(lhs - (rhs))`.
                let sub_operation = CustomSubOp::new(*left, Expression::Paren(paren_right));
                let abs_operation = CustomAbsOp::wrap(Expression::CustomSub(sub_operation));

                // `abs(lhs - (rhs)) < 0.001`.
                let epsilon_literal = Expression::Float(FloatLiteral::new_custom(0.001));
                let less_operation = CustomLessThanOp::new(Expression::CustomAbs(abs_operation), epsilon_literal);

                // `(abs(lhs - (rhs)) < 0.001)`.
                let mut paren_operation = ParenOp::new(ValueRange::new(bool_type));
                paren_operation.set_child(Expression::CustomLessThan(less_operation));

                // EQ can't just be removed, so it is replaced with:
                // ((abs(lhs - (rhs)) < 0.001) == true).
                self.left_expr = Some(Box::new(Expression::Paren(paren_operation)));
                self.right_expr = Some(Box::new(Expression::Bool(BoolLiteral::new_custom(true))));
            }

            None
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.left_expr
            .as_ref()
            .expect("EqualityComparisonOp::tokenize: left not set")
            .tokenize(var_manager, version, shader_type, stream);
        stream.push(self.kind.token());
        self.right_expr
            .as_ref()
            .expect("EqualityComparisonOp::tokenize: right not set")
            .tokenize(var_manager, version, shader_type, stream);
    }

    /// `EqualityComparisonOp<IsEqual>::evaluate(dst, a, b)` - per-lane, per-component
    /// comparison combined with `&&`/`||`, matching upstream's real body (confirmed by
    /// reading it, not assumed from the class name alone).
    ///
    /// **The type compared here is read off the (possibly-rewritten) left operand
    /// itself, not `self.in_type`.** Upstream's own base `BinaryOp<P,A>::evaluate
    /// (ExecutionContext&)` calls this 3-arg override with `a`/`b` read dynamically via
    /// `m_leftValueExpr->getValue()`/`m_rightValueExpr->getValue()` - each of which
    /// carries its *own* runtime type tag (`a.getType()`), not a type fixed at
    /// construction time. That only matters once `create_next_child`'s own `CMP_EQ`
    /// corner case (see this struct's own doc comment) has fired: it replaces
    /// `left_expr`/`right_expr` with a bool-typed tree, so `self.in_type` (still
    /// `Float`, unchanged) would read a bool-shaped value as if it were a float one -
    /// `ValueStorage::assign_from`'s own `debug_assert!(self.type_ == src.type_)` would
    /// panic on exactly this mismatch in a debug build the first time the rewrite path
    /// is actually evaluated. Reading `get_value(...).get_type()` instead (cloned out
    /// before the real value snapshot below, so the borrow it needs doesn't overlap with
    /// anything else) makes this match upstream's own dynamic dispatch, and brings the
    /// `TYPE_BOOL` case upstream's own `switch` always had back into play - previously
    /// dead at this call site (nothing ever produced a bool-typed operand here), now the
    /// rewrite's own exit path.
    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.left_expr
            .as_deref_mut()
            .expect("EqualityComparisonOp::evaluate: left not set")
            .evaluate(var_manager, ctx);
        self.right_expr
            .as_deref_mut()
            .expect("EqualityComparisonOp::evaluate: right not set")
            .evaluate(var_manager, ctx);

        let in_type = self
            .left_expr
            .as_ref()
            .unwrap()
            .get_value(var_manager, ctx)
            .get_type()
            .clone();

        let mut left_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.left_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            left_storage.get_value(&in_type).assign_from(&src);
        }
        let mut right_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &in_type);
        {
            let src = self.right_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            right_storage.get_value(&in_type).assign_from(&src);
        }

        let bool_type = VariableType::new_basic(Type::Bool, 1);
        self.value.set_storage(&bool_type);

        let left = left_storage.get_value_const(&in_type);
        let right = right_storage.get_value_const(&in_type);
        let mut dst = self.value.get_value(&bool_type);

        let is_equal = self.kind.is_equal();
        let num_elements = in_type.num_elements();

        match in_type.base_type() {
            Type::Float => {
                for lane in 0..EXEC_VEC_WIDTH {
                    let mut result = is_equal;
                    for elem_ndx in 0..num_elements {
                        let a = left.component(elem_ndx).as_float_at(lane);
                        let b = right.component(elem_ndx).as_float_at(lane);
                        let cmp = if is_equal { a == b } else { a != b };
                        result = if is_equal { result && cmp } else { result || cmp };
                    }
                    dst.set_bool_at(lane, result);
                }
            }
            Type::Int => {
                for lane in 0..EXEC_VEC_WIDTH {
                    let mut result = is_equal;
                    for elem_ndx in 0..num_elements {
                        let a = left.component(elem_ndx).as_int_at(lane);
                        let b = right.component(elem_ndx).as_int_at(lane);
                        let cmp = if is_equal { a == b } else { a != b };
                        result = if is_equal { result && cmp } else { result || cmp };
                    }
                    dst.set_bool_at(lane, result);
                }
            }
            // Only reachable once the `CMP_EQ` rewrite has fired (see this method's own
            // doc comment) - `self.left_value_range`/`self.right_value_range` (the
            // `Float`/`Int` choice `new` makes) are never `Bool` themselves, matching
            // upstream's own `inBaseTypes = {TYPE_FLOAT, TYPE_INT}` array.
            Type::Bool => {
                for lane in 0..EXEC_VEC_WIDTH {
                    let mut result = is_equal;
                    for elem_ndx in 0..num_elements {
                        let a = left.component(elem_ndx).as_bool_at(lane);
                        let b = right.component(elem_ndx).as_bool_at(lane);
                        let cmp = if is_equal { a == b } else { a != b };
                        result = if is_equal { result && cmp } else { result || cmp };
                    }
                    dst.set_bool_at(lane, result);
                }
            }
            _ => unreachable!(
                "rsg::EqualityComparisonOp: operand base type is always Float, Int, or (post-rewrite) Bool"
            ),
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::new_basic(Type::Bool, 1))
    }
}

const SWIZZLE_PRECEDENCE: i32 = 2;

/// `rsg::SwizzleOp` - swizzles `num_input_elements` (2..=4, randomly drawn, at least as
/// many as the output needs) components of a freshly generated input vector down to the
/// output type's own lane count, picking `num_input_elements` distinct source indices
/// without replacement (upstream's `std::set<int> availableElements`, iterated in
/// ascending order via `rnd.choose` - this port keeps a sorted `Vec<i32>`, filtering out
/// the chosen value each draw, which has the identical "index into the sorted remaining
/// set" semantics `std::set`'s own ordered iteration gives `de::Random::choose`).
///
/// The component letter set (`rgba`/`xyzw`/`stpq`) is drawn in `tokenize`, as upstream
/// does, from the generator's RNG installed by [`with_tokenize_random`]. Drawing it in the
/// constructor instead shifts every later draw and generates a different program.
pub struct SwizzleOp {
    out_value_range: ValueRange,
    num_input_elements: i32,
    swizzle: [u8; 4],
    child: Option<Box<Expression>>,
    value: ValueStorage,
}

thread_local! {
    static TOKENIZE_RANDOM: std::cell::Cell<Option<Random>> = const { std::cell::Cell::new(None) };
}

/// Makes `random` available to `SwizzleOp::tokenize` for the duration of `f` and writes
/// the advanced state back - upstream's `tokenize` takes the `GeneratorState` and draws
/// from it, the port's takes no state at all.
pub fn with_tokenize_random<R>(random: &mut Random, f: impl FnOnce() -> R) -> R {
    let previous = TOKENIZE_RANDOM.with(|slot| slot.replace(Some(*random)));
    let result = f();
    *random = TOKENIZE_RANDOM
        .with(|slot| slot.replace(previous))
        .expect("tokenize random taken");
    result
}

impl SwizzleOp {
    /// `SwizzleOp::SwizzleOp(GeneratorState&, ConstValueRangeAccess)` - upstream asserts
    /// the range is never void ("`\todo` Void support"); this port debug_asserts the
    /// same, relying on `get_weight` (`is_float_or_vec`/`is_int_or_vec`/`is_bool_or_vec`
    /// are all false for `Void`) to have already filtered it out before any caller
    /// reaches this constructor.
    pub fn new(state: &mut GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        let out_value_range = ValueRange::from_access(value_range);
        let type_ = out_value_range.get_type();
        debug_assert!(!type_.is_void());
        debug_assert!(type_.is_float_or_vec() || type_.is_int_or_vec() || type_.is_bool_or_vec());

        let mut value = ValueStorage::new(EXEC_VEC_WIDTH);
        value.set_storage(type_);

        let num_output_elements = type_.num_elements();
        // \note Swizzle works for vector types only - at least 2 input components, even
        // when the output itself is a scalar (e.g. `vec2(...).x`).
        let num_input_elements = state.get_random().get_int(num_output_elements.max(2), 4);

        let mut available: Vec<i32> = (0..num_input_elements).collect();
        let mut swizzle = [0u8; 4];
        for (elem_ndx, slot) in swizzle.iter_mut().enumerate() {
            if (elem_ndx as i32) < num_output_elements {
                let chosen = *state.get_random().choose(&available);
                available.retain(|&v| v != chosen);
                *slot = chosen as u8;
            }
        }

        Self {
            out_value_range,
            num_input_elements,
            swizzle,
            child: None,
            value,
        }
    }

    /// `SwizzleOp::getWeight`
    pub fn get_weight(state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        if !state.get_program_parameters().use_swizzle {
            return 0.0;
        }

        if state.get_precedence() < SWIZZLE_PRECEDENCE {
            return 0.0;
        }

        let type_ = value_range.get_type();
        if !type_.is_float_or_vec() && !type_.is_int_or_vec() && !type_.is_bool_or_vec() {
            return 0.0;
        }

        let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();

        // Swizzle + Constructor + Values.
        if available_levels < 3 {
            return 0.0;
        }

        1.0
    }

    /// `SwizzleOp::createNextChild` - the input value range starts at `-inf..inf` on
    /// every component (`set_infinite_range`) and is then narrowed to the output's own
    /// requested range, one output element at a time. **Not reproduced**: upstream's own
    /// `ValueRange::computeIntersection(x, x, y)` call, which intersects an input
    /// component with *itself* and `y` simultaneously - not expressible under Rust's
    /// borrow checker (`x` would be both the mutable destination and a shared source at
    /// once). Since `swizzle`'s indices are drawn without replacement, every `in_elem_ndx`
    /// reached here is still untouched (still exactly `-inf..inf`) the first and only
    /// time this loop writes to it, so intersecting with that identity element is
    /// exactly equivalent to a plain copy, which is what this port does instead.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.child.is_some() {
            return None;
        }

        let base_type = self.out_value_range.get_type().base_type();
        let in_type = VariableType::new_basic(base_type, self.num_input_elements);
        let mut in_value_range = ValueRange::new(in_type);
        set_infinite_range(&mut in_value_range);

        let num_output_elements = self.out_value_range.get_type().num_elements();
        for out_elem_ndx in 0..num_output_elements {
            let in_elem_ndx = i32::from(self.swizzle[out_elem_ndx as usize]);
            let out_component = self.out_value_range.as_const_access().component(out_elem_ndx);
            let min_read = out_component.get_min().value();
            let max_read = out_component.get_max().value();

            let mut in_access = in_value_range.as_access();
            let mut in_component = in_access.component(in_elem_ndx);
            in_component.get_min().assign_from(&min_read);
            in_component.get_max().assign_from(&max_read);
        }

        state.push_precedence(SWIZZLE_PRECEDENCE);
        let child = super::expression_generator::create_random(state, var_manager, &in_value_range.as_const_access());
        state.pop_precedence();

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
        self.child
            .as_ref()
            .expect("SwizzleOp::tokenize: child not set")
            .tokenize(var_manager, version, shader_type, stream);
        const RGBA: [&str; 4] = ["r", "g", "b", "a"];
        const XYZW: [&str; 4] = ["x", "y", "z", "w"];
        const STPQ: [&str; 4] = ["s", "t", "p", "q"];
        // Outside a generator's tokenize pass (a hand-built tree in a unit test) there is
        // no RNG to draw from, and `xyzw` is used.
        let set_ndx = TOKENIZE_RANDOM.with(|slot| {
            slot.take().map(|mut random| {
                let ndx = random.get_int(0, 2);
                slot.set(Some(random));
                ndx
            })
        });
        let swizzle_set = match set_ndx.unwrap_or(1) {
            0 => &RGBA,
            1 => &XYZW,
            2 => &STPQ,
            _ => unreachable!("rsg::SwizzleOp: get_int(0, 2) is always 0, 1 or 2"),
        };
        let num_output_elements = self.out_value_range.get_type().num_elements();
        let swizzle_str: String = (0..num_output_elements)
            .map(|ndx| swizzle_set[self.swizzle[ndx as usize] as usize])
            .collect();
        stream.push(Token::Dot);
        stream.push(Token::identifier(swizzle_str));
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.child
            .as_deref_mut()
            .expect("SwizzleOp::evaluate: child not set")
            .evaluate(var_manager, ctx);

        let out_type = self.out_value_range.get_type().clone();
        self.value.set_storage(&out_type);

        let src = self.child.as_ref().unwrap().get_value(var_manager, ctx);
        for out_elem_ndx in 0..out_type.num_elements() {
            let in_elem_ndx = i32::from(self.swizzle[out_elem_ndx as usize]);
            let src_elem = src.component(in_elem_ndx);
            let mut dst = self.value.get_value(&out_type);
            let mut dst_elem = dst.component(out_elem_ndx);
            for lane in 0..EXEC_VEC_WIDTH {
                dst_elem.set_scalar_at(lane, src_elem.as_scalar_at(lane));
            }
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(self.out_value_range.get_type())
    }
}

/// `rsg::TexLookup` - the last of `rsgExpression.hpp`'s own kinds, and (as of
/// `8368644a`, which predates this file's current branch point - see git history, not a
/// claim made and then immediately falsified in this session) **fully wired into the
/// `Expression` enum and `expression_generator::create_random`'s dispatch table**, not
/// merely constructible standalone. `Expression::TexLookup(TexLookup)` is a real enum
/// variant with its own `evaluate`/`get_value`/`tokenize`/`create_next_child` match arms
/// right above, `expression_generator::create_random`'s `kinds`/`weights` arrays include
/// it (`ExpressionKind::TexLookup`, dispatched through `TexLookup::get_weight`/`new`
/// exactly like every other kind), and a dedicated `expression_generator` test
/// (`create_random_can_produce_a_tex_lookup_once_its_base_weight_is_enabled`) confirms
/// the dispatch path itself is reachable, not just that the struct can be built by hand.
///
/// Every piece this needed turned out to already exist, once actually checked rather
/// than assumed blocked: `ExecutionContext::get_sampler_2d`/`get_sampler_cube` (already
/// ported, confirmed by reading `rsg::execution_context` directly), `VariableType::
/// is_sampler`/the `Sampler2D`/`SamplerCube` base types (already ported, confirmed in
/// `rsg::variable_type`), sampler allocation/counting needing no new `VariableManager`
/// API at all (`countSamplers`/`IsSamplerEntry` collapse onto `entries_matching` with a
/// plain predicate closure, the same pattern every other `is_*_entry` filter in
/// `rsg::expression` already uses), and `tokenize`'s own `state.getShader().getType()`
/// read needing only the `ShaderType` bit `rsg::variable`'s own
/// `tokenize_declaration` fix already introduced - not the whole `Shader` object.
///
/// **What wiring it in cost**: `TexLookup::tokenize` is the one method here that needs
/// `Version`/`ShaderType`, so `Expression::tokenize`'s own signature grew both,
/// threaded through every variant's own `tokenize` method and every recursive
/// `.tokenize(...)` call inside them (`ParenOp`/`AssignOp`/`ConstructorOp`/`BinaryOp`/
/// `RelationalOp`/`EqualityComparisonOp`/`EpsilonAddOp`/`SwizzleOp` here,
/// `BuiltinFunctionOp` in `rsg::builtin_functions`, plus `rsg::statement`'s own
/// `ExpressionStatement`/`AssignStatement`) - this effort had twice declined that cost
/// before (`rsg::statement`'s own doc comment, and `SwizzleOp`'s own RNG-draw-order
/// note, both for lack of a second real consumer); `TexLookup` was the consumer that
/// made it worth paying.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TexLookupKind {
    Texture2D,
    Texture2DLod,
    Texture2DProj,
    Texture2DProjLod,
    TextureCube,
    TextureCubeLod,
}

impl TexLookupKind {
    fn sampler_base_type(self) -> Type {
        match self {
            TexLookupKind::Texture2D
            | TexLookupKind::Texture2DLod
            | TexLookupKind::Texture2DProj
            | TexLookupKind::Texture2DProjLod => Type::Sampler2D,
            TexLookupKind::TextureCube | TexLookupKind::TextureCubeLod => Type::SamplerCube,
        }
    }

    fn has_lod_bias(self) -> bool {
        matches!(
            self,
            TexLookupKind::Texture2DLod | TexLookupKind::Texture2DProjLod | TexLookupKind::TextureCubeLod
        )
    }

    fn is_cube(self) -> bool {
        matches!(self, TexLookupKind::TextureCube | TexLookupKind::TextureCubeLod)
    }

    fn is_proj(self) -> bool {
        matches!(self, TexLookupKind::Texture2DProj | TexLookupKind::Texture2DProjLod)
    }

    /// `TexLookup::tokenize`'s own `VERSION_300`-branch name table.
    fn function_name_es3(self, is_vertex: bool) -> &'static str {
        match self {
            TexLookupKind::Texture2D | TexLookupKind::TextureCube => "texture",
            TexLookupKind::Texture2DLod | TexLookupKind::TextureCubeLod => {
                if is_vertex {
                    "textureLod"
                } else {
                    "texture"
                }
            }
            TexLookupKind::Texture2DProj => "textureProj",
            TexLookupKind::Texture2DProjLod => {
                if is_vertex {
                    "textureProjLod"
                } else {
                    "textureProj"
                }
            }
        }
    }

    /// `TexLookup::tokenize`'s own pre-ES3 (`texture2D`/`textureCube` family) name table.
    fn function_name_es2(self, is_vertex: bool) -> &'static str {
        match self {
            TexLookupKind::Texture2D => "texture2D",
            TexLookupKind::Texture2DLod => {
                if is_vertex {
                    "texture2DLod"
                } else {
                    "texture2D"
                }
            }
            TexLookupKind::Texture2DProj => "texture2DProj",
            TexLookupKind::Texture2DProjLod => {
                if is_vertex {
                    "texture2DProjLod"
                } else {
                    "texture2DProj"
                }
            }
            TexLookupKind::TextureCube => "textureCube",
            TexLookupKind::TextureCubeLod => {
                if is_vertex {
                    "textureCubeLod"
                } else {
                    "textureCube"
                }
            }
        }
    }
}

/// `countSamplers`/`IsSamplerEntry` (file-local upstream) - collapses onto
/// `entries_matching` with a plain predicate, the same pattern every other
/// `is_*_entry` filter in this file already uses.
fn is_sampler_entry(mgr: &VariableManager<'_>, id: ValueEntryId, sampler_base_type: Type) -> bool {
    mgr.get_variable(mgr.get_entry(id).get_variable())
        .get_type()
        .base_type()
        == sampler_base_type
}

fn count_samplers(var_manager: &VariableManager<'_>, sampler_base_type: Type) -> i32 {
    var_manager
        .entries_matching(|m, id| is_sampler_entry(m, id, sampler_base_type))
        .count() as i32
}

pub struct TexLookup {
    kind: TexLookupKind,
    sampler: VariableId,
    coord_expr: Option<Box<Expression>>,
    lod_bias_expr: Option<Box<Expression>>,
    value: ValueStorage,
}

impl TexLookup {
    /// `TexLookup::TexLookup(GeneratorState&, ConstValueRangeAccess)` - upstream
    /// `DE_UNREF`s the output range entirely ("Texture output value range is
    /// constant"), only asserting it is exactly `vec4`.
    pub fn new(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        debug_assert!(*value_range.get_type() == VariableType::new_basic(Type::Float, 4));

        let mut type_candidates = Vec::new();
        if state.get_shader_parameters().use_texture_2d {
            type_candidates.extend([
                TexLookupKind::Texture2D,
                TexLookupKind::Texture2DLod,
                TexLookupKind::Texture2DProj,
                TexLookupKind::Texture2DProjLod,
            ]);
        }
        if state.get_shader_parameters().use_texture_cube {
            type_candidates.extend([TexLookupKind::TextureCube, TexLookupKind::TextureCubeLod]);
        }
        let kind = *state.get_random().choose(&type_candidates);

        let sampler_base_type = kind.sampler_base_type();
        let sampler_2d_count = count_samplers(var_manager, Type::Sampler2D);
        let sampler_cube_count = count_samplers(var_manager, Type::SamplerCube);
        let can_alloc_sampler = sampler_2d_count + sampler_cube_count < state.get_shader_parameters().max_samplers;
        let has_sampler = if sampler_base_type == Type::Sampler2D {
            sampler_2d_count > 0
        } else {
            sampler_cube_count > 0
        };
        let alloc_sampler = !has_sampler || (can_alloc_sampler && state.get_random().get_bool());

        let sampler = if alloc_sampler {
            let sampler_id = var_manager.allocate(VariableType::new_basic(sampler_base_type, 1));
            var_manager.set_storage(sampler_id, Storage::Uniform);
            sampler_id
        } else {
            let matching: Vec<ValueEntryId> = var_manager
                .entries_matching(|m, id| is_sampler_entry(m, id, sampler_base_type))
                .collect();
            let chosen = *state.get_random().choose(&matching);
            var_manager.get_entry(chosen).get_variable()
        };

        Self {
            kind,
            sampler,
            coord_expr: None,
            lod_bias_expr: None,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        }
    }

    /// `TexLookup::getWeight` - no `VariableManager` access anywhere in the real body,
    /// confirmed by reading it, so (unlike `AssignOp`/`VariableRead`'s own `get_weight`)
    /// this takes no `var_manager` parameter at all.
    pub fn get_weight(state: &GeneratorState<'_>, value_range: &ConstValueRangeAccess<'_>) -> f32 {
        if state.get_shader_parameters().tex_lookup_base_weight <= 0.0 {
            return 0.0;
        }

        let available_levels = state.get_shader_parameters().max_expression_depth - state.get_expression_depth();
        if available_levels < 3 {
            return 0.0;
        }

        if (state.get_expression_flags() & (CONST_EXPR | NO_VAR_ALLOCATION)) != 0 {
            return 0.0;
        }

        if *value_range.get_type() != VariableType::new_basic(Type::Float, 4) {
            return 0.0;
        }

        let mut tex_output_range = ValueRange::new(VariableType::new_basic(Type::Float, 4));
        for ndx in 0..4 {
            let mut access = tex_output_range.as_access();
            let mut comp = access.component(ndx);
            comp.get_min().set_float(0.0);
            comp.get_max().set_float(1.0);
        }

        if !value_range.is_superset_of(&tex_output_range.as_const_access()) {
            return 0.0;
        }

        state.get_shader_parameters().tex_lookup_base_weight
    }

    /// `TexLookup::createNextChild` - the LOD/bias child (if this kind has one) is
    /// always generated *before* the coordinate child, matching upstream's own order
    /// exactly. The cube-map coordinate range picks a random "major axis" and pushes
    /// that one component away from zero (`[2.25, 4]` or `[-4, -2.25]`) so the
    /// major-axis-selection logic a real cube sampler performs has a well-defined
    /// answer; the 2D non-cube range is `-inf..inf` except a projective `w` component,
    /// which is pushed away from zero the same way so the eventual `/w` divide in
    /// `evaluate` is never by something close to zero.
    pub fn create_next_child(
        &mut self,
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
    ) -> Option<&mut Expression> {
        if self.kind.has_lod_bias() && self.lod_bias_expr.is_none() {
            let mut lod_range = ValueRange::new(VariableType::new_basic(Type::Float, 1));
            set_infinite_range(&mut lod_range);
            let child = super::expression_generator::create_random(state, var_manager, &lod_range.as_const_access());
            self.lod_bias_expr = Some(Box::new(child));
            return self.lod_bias_expr.as_deref_mut();
        }

        if self.coord_expr.is_none() {
            let coord_range = if self.kind.is_cube() {
                let major_axis_ndx = state.get_random().get_int(0, 2);
                let mut r = ValueRange::new(VariableType::new_basic(Type::Float, 3));
                for ndx in 0..3 {
                    let mut access = r.as_access();
                    let mut comp = access.component(ndx);
                    if ndx == major_axis_ndx {
                        let neg = state.get_random().get_bool();
                        let (min, max) = if neg { (-4.0, -2.25) } else { (2.25, 4.0) };
                        comp.get_min().set_float(min);
                        comp.get_max().set_float(max);
                    } else {
                        comp.get_min().set_float(-2.0);
                        comp.get_max().set_float(2.0);
                    }
                }
                r
            } else {
                let coord_scalar_size = if self.kind.is_proj() { 3 } else { 2 };
                let mut r = ValueRange::new(VariableType::new_basic(Type::Float, coord_scalar_size));
                set_infinite_range(&mut r);
                if self.kind.is_proj() {
                    let neg = state.get_random().get_bool();
                    let (min, max) = if neg { (-4.0, -0.25) } else { (0.25, 4.0) };
                    let mut access = r.as_access();
                    let mut comp = access.component(2);
                    comp.get_min().set_float(min);
                    comp.get_max().set_float(max);
                }
                r
            };

            let child = super::expression_generator::create_random(state, var_manager, &coord_range.as_const_access());
            self.coord_expr = Some(Box::new(child));
            return self.coord_expr.as_deref_mut();
        }

        None
    }

    /// `TexLookup::tokenize` - `version`/`shader_type` stand in for upstream's
    /// `GeneratorState&`/implicit `Shader&`, see this struct's own top doc comment.
    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        let is_vertex = shader_type == ShaderType::Vertex;
        let name = if version == Version::Version300 {
            self.kind.function_name_es3(is_vertex)
        } else {
            self.kind.function_name_es2(is_vertex)
        };
        stream.push(Token::identifier(name));

        stream.push(Token::LeftParen);
        stream.push(Token::identifier(var_manager.get_variable(self.sampler).get_name()));
        stream.push(Token::Comma);
        self.coord_expr
            .as_ref()
            .expect("TexLookup::tokenize: coord not set")
            .tokenize(var_manager, version, shader_type, stream);

        if let Some(lod) = &self.lod_bias_expr {
            stream.push(Token::Comma);
            lod.tokenize(var_manager, version, shader_type, stream);
        }

        stream.push(Token::RightParen);
    }

    pub fn evaluate(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.coord_expr
            .as_deref_mut()
            .expect("TexLookup::evaluate: coord not set")
            .evaluate(var_manager, ctx);
        if let Some(lod) = &mut self.lod_bias_expr {
            lod.evaluate(var_manager, ctx);
        }

        // 3 components for a cube lookup or a projective 2D one, 2 otherwise - matches
        // `create_next_child`'s own `coord_range` construction exactly, so this never
        // needs to re-derive the type from the expression itself.
        let coord_num_elements = if self.kind.is_cube() || self.kind.is_proj() {
            3
        } else {
            2
        };
        let coord_type = VariableType::new_basic(Type::Float, coord_num_elements);
        let mut coord_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &coord_type);
        {
            let src = self.coord_expr.as_ref().unwrap().get_value(var_manager, ctx).value();
            coord_storage.get_value(&coord_type).assign_from(&src);
        }

        let lod_storage = self.lod_bias_expr.as_ref().map(|lod| {
            let lod_type = VariableType::new_basic(Type::Float, 1);
            let mut storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &lod_type);
            let src = lod.get_value(var_manager, ctx).value();
            storage.get_value(&lod_type).assign_from(&src);
            storage
        });

        let vec4_type = VariableType::new_basic(Type::Float, 4);
        self.value.set_storage(&vec4_type);

        let coords = coord_storage.get_value_const(&coord_type);
        let lod_type = VariableType::new_basic(Type::Float, 1);
        let sampler_type = VariableType::new_basic(self.kind.sampler_base_type(), 1);

        for lane in 0..EXEC_VEC_WIDTH {
            let lod_at =
                |lod_storage: &ValueStorage, lane: usize| lod_storage.get_value_const(&lod_type).as_float_at(lane);

            let sample = if self.kind.is_cube() {
                let s = coords.component(0).as_float_at(lane);
                let t = coords.component(1).as_float_at(lane);
                let r = coords.component(2).as_float_at(lane);
                let l = lod_storage.as_ref().map(|ls| lod_at(ls, lane)).unwrap_or(0.0);
                ctx.get_sampler_cube(self.sampler, &sampler_type).sample(s, t, r, l)
            } else if self.kind.is_proj() {
                let s = coords.component(0).as_float_at(lane);
                let t = coords.component(1).as_float_at(lane);
                let w = coords.component(2).as_float_at(lane);
                let l = lod_storage.as_ref().map(|ls| lod_at(ls, lane)).unwrap_or(0.0);
                ctx.get_sampler_2d(self.sampler, &sampler_type).sample(s / w, t / w, l)
            } else {
                let s = coords.component(0).as_float_at(lane);
                let t = coords.component(1).as_float_at(lane);
                let l = lod_storage.as_ref().map(|ls| lod_at(ls, lane)).unwrap_or(0.0);
                ctx.get_sampler_2d(self.sampler, &sampler_type).sample(s, t, l)
            };

            let mut dst = self.value.get_value(&vec4_type);
            for comp in 0..4 {
                dst.component(comp).set_float_at(lane, sample[comp as usize]);
            }
        }
    }

    pub fn get_value(&self) -> ExecConstValueAccess<'_> {
        self.value.get_value_const(&VariableType::new_basic(Type::Float, 4))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::parameters::ProgramParameters;
    use crate::rsg::variable_value::ValueRange;
    use crate::tcu::random::Random;

    fn new_state<'a>(params: &'a ProgramParameters, random: &'a mut Random) -> GeneratorState<'a> {
        GeneratorState::new(params, random)
    }

    fn void_range() -> ValueRange {
        ValueRange::new(VariableType::new_basic(Type::Void, 1))
    }

    #[test]
    fn float_literal_custom_broadcasts_to_every_simd_lane() {
        let lit = FloatLiteral::new_custom(2.5);
        let access = lit.get_value();
        for ndx in 0..EXEC_VEC_WIDTH {
            assert_eq!(access.as_float_at(ndx), 2.5);
        }
    }

    #[test]
    fn float_literal_random_lands_on_a_quarter_step_within_an_explicit_range() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        for _ in 0..30 {
            let lit = FloatLiteral::new_random(&mut state, &range.as_const_access());
            let v = lit.get_value().as_float_at(0);
            assert!((0.0..=1.0).contains(&v), "{v} out of range");
            let quarters = v * 4.0;
            assert!((quarters - quarters.round()).abs() < 1e-5, "{v} is not a quarter step");
        }
    }

    #[test]
    fn float_literal_random_defaults_to_minus_ten_ten_for_an_unbounded_or_void_range() {
        let params = ProgramParameters::default();
        let mut random = Random::new(2);
        let mut state = new_state(&params, &mut random);

        // An explicit -inf..+inf float range falls back to the hard-coded [-10, 10].
        let mut unbounded = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        unbounded.get_min().set_scalar(Scalar::min_float());
        unbounded.get_max().set_scalar(Scalar::max_float());
        for _ in 0..30 {
            let v = FloatLiteral::new_random(&mut state, &unbounded.as_const_access())
                .get_value()
                .as_float_at(0);
            assert!((-10.0..=10.0).contains(&v), "{v} out of [-10, 10]");
        }

        // A Void range (no float-typed constraint at all) takes the same default path.
        let void = void_range();
        for _ in 0..10 {
            let v = FloatLiteral::new_random(&mut state, &void.as_const_access())
                .get_value()
                .as_float_at(0);
            assert!((-10.0..=10.0).contains(&v), "{v} out of [-10, 10]");
        }
    }

    #[test]
    fn float_literal_weight_is_low_for_unbounded_and_falls_toward_0_1_as_the_range_widens() {
        let params = ProgramParameters::default();
        let mut random = Random::new(3);
        let state = new_state(&params, &mut random);

        let mut unbounded = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        unbounded.get_min().set_scalar(Scalar::min_float());
        unbounded.get_max().set_scalar(Scalar::max_float());
        assert_eq!(FloatLiteral::get_weight(&state, &unbounded.as_const_access()), 0.1);

        let mut narrow = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        narrow.get_min().set_float(0.0);
        narrow.get_max().set_float(0.2);
        assert!((FloatLiteral::get_weight(&state, &narrow.as_const_access()) - 0.8).abs() < 1e-6);

        let mut wide = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        wide.get_min().set_float(0.0);
        wide.get_max().set_float(5.0);
        assert_eq!(FloatLiteral::get_weight(&state, &wide.as_const_access()), 0.1); // Clamped at the 0.1 floor.

        assert_eq!(
            FloatLiteral::get_weight(&state, &void_range().as_const_access()),
            UNUSED_VALUE_WEIGHT
        );

        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(FloatLiteral::get_weight(&state, &int_range.as_const_access()), 0.0);
    }

    #[test]
    fn float_literal_tokenizes_to_its_own_value() {
        let lit = FloatLiteral::new_custom(1.5);
        let mut stream = TokenStream::new();
        lit.tokenize(&mut stream);
        assert_eq!(stream.tokens(), &[Token::FloatLiteral(1.5)]);
    }

    #[test]
    fn int_literal_random_stays_within_an_explicit_range_and_weight_matches_hand_computed() {
        let params = ProgramParameters::default();
        let mut random = Random::new(4);
        let mut state = new_state(&params, &mut random);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(-3);
        range.get_max().set_int(3);
        for _ in 0..30 {
            let v = IntLiteral::new_random(&mut state, &range.as_const_access())
                .get_value()
                .as_int_at(0);
            assert!((-3..=3).contains(&v), "{v} out of range");
        }

        // Hand-computed: rangeLength = 3 - (-3) = 6, weight = max(0.1, 1 - 6/4) = max(0.1, -0.5) = 0.1.
        assert_eq!(IntLiteral::get_weight(&state, &range.as_const_access()), 0.1);

        let mut tight = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        tight.get_min().set_int(0);
        tight.get_max().set_int(1);
        // rangeLength = 1, weight = max(0.1, 1 - 1/4) = 0.75.
        assert!((IntLiteral::get_weight(&state, &tight.as_const_access()) - 0.75).abs() < 1e-6);
    }

    #[test]
    fn int_literal_defaults_to_minus_sixteen_sixteen_when_unbounded() {
        let params = ProgramParameters::default();
        let mut random = Random::new(5);
        let mut state = new_state(&params, &mut random);

        let mut unbounded = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        unbounded.get_min().set_scalar(Scalar::min_int());
        unbounded.get_max().set_scalar(Scalar::max_int());
        for _ in 0..30 {
            let v = IntLiteral::new_random(&mut state, &unbounded.as_const_access())
                .get_value()
                .as_int_at(0);
            assert!((-16..=16).contains(&v), "{v} out of [-16, 16]");
        }
    }

    #[test]
    fn bool_literal_random_respects_a_fixed_true_range_and_tokenizes_correctly() {
        let params = ProgramParameters::default();
        let mut random = Random::new(6);
        let mut state = new_state(&params, &mut random);

        let mut always_true = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        always_true.get_min().set_bool(true);
        always_true.get_max().set_bool(true);
        for _ in 0..10 {
            let lit = BoolLiteral::new_random(&mut state, &always_true.as_const_access());
            assert!(lit.get_value().as_bool_at(0));
        }

        let lit = BoolLiteral::new_custom(false);
        let mut stream = TokenStream::new();
        lit.tokenize(&mut stream);
        assert_eq!(stream.tokens(), &[Token::BoolLiteral(false)]);

        assert_eq!(BoolLiteral::get_weight(&state, &always_true.as_const_access()), 0.5);
        assert_eq!(
            BoolLiteral::get_weight(&state, &void_range().as_const_access()),
            UNUSED_VALUE_WEIGHT
        );
    }

    #[test]
    fn expression_enum_dispatches_each_literal_kind_through_one_interface() {
        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state(&params, &mut random);
        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));

        let mut alloc = crate::rsg::name_allocator::NameAllocator::new();
        let mgr = VariableManager::new(&mut alloc);
        let empty_2d: crate::rsg::samplers::Sampler2DMap = std::collections::HashMap::new();
        let empty_cube: crate::rsg::samplers::SamplerCubeMap = std::collections::HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let mut exprs = vec![
            Expression::Float(FloatLiteral::new_custom(1.0)),
            Expression::Int(IntLiteral::new_random(&mut state, &int_range.as_const_access())),
            Expression::Bool(BoolLiteral::new_custom(true)),
        ];

        for expr in &mut exprs {
            expr.evaluate(&mgr, &mut ctx); // No-op for every literal kind; just confirm it does not panic.
        }

        assert_eq!(exprs[0].get_value(&mgr, &mut ctx).as_float_at(0), 1.0);
        assert!(exprs[2].get_value(&mgr, &mut ctx).as_bool_at(0));

        let mut stream = TokenStream::new();
        exprs[2].tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens(), &[Token::BoolLiteral(true)]);
    }

    use std::collections::HashMap;

    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::ShaderParameters;
    use crate::rsg::samplers::{Sampler2DMap, SamplerCubeMap};
    use crate::rsg::variable_manager::{ValueScope, VariableScope};

    fn new_var_manager<'a>(alloc: &'a mut NameAllocator) -> VariableManager<'a> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    fn new_state_with_budget<'a>(
        program_params: &'a ProgramParameters,
        shader_params: &'a ShaderParameters,
        random: &'a mut Random,
    ) -> GeneratorState<'a> {
        let mut state = GeneratorState::new(program_params, random);
        state.set_shader_parameters(shader_params);
        state
    }

    #[test]
    fn can_allocate_variable_respects_the_no_var_allocation_flag_and_the_scalar_budget() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_combined_variable_scalars: 4,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);

        let small = VariableType::new_basic(Type::Float, 2);
        assert!(can_allocate_variable(&state, &mgr, &small));

        let too_big = VariableType::new_basic(Type::Float, 4); // Exactly at budget - still fits (<=).
        assert!(can_allocate_variable(&state, &mgr, &too_big));

        let over_budget = VariableType::new_basic(Type::Int, 1);
        state.push_expression_flags(NO_VAR_ALLOCATION);
        assert!(!can_allocate_variable(&state, &mgr, &over_budget));
        state.pop_expression_flags();
        assert!(can_allocate_variable(&state, &mgr, &over_budget));
    }

    #[test]
    fn compute_entry_read_weight_matches_hand_computed_overlap_ratio() {
        let type_ = VariableType::new_basic(Type::Float, 1);

        let mut entry = ValueRange::new(type_.clone());
        entry.get_min().set_float(0.0);
        entry.get_max().set_float(10.0);

        let mut read = ValueRange::new(type_.clone());
        read.get_min().set_float(5.0);
        read.get_max().set_float(15.0);

        // Intersection [5, 10]: entry_ratio = 5/10 = 0.5, read_ratio = 5/10 = 0.5,
        // elementWeight = 0.5*0.5 + 0.5*0.5 = 0.5.
        let weight = compute_entry_read_weight(&entry.as_const_access(), &read.as_const_access());
        assert!((weight - 0.5).abs() < 1e-6, "{weight}");

        // An unbounded entry component never lowers the weight at all (stays 1.0, then
        // the final max(0.01) floor is irrelevant).
        let mut unbounded_entry = ValueRange::new(type_.clone());
        unbounded_entry.get_min().set_scalar(Scalar::min_float());
        unbounded_entry.get_max().set_scalar(Scalar::max_float());
        let weight_unbounded = compute_entry_read_weight(&unbounded_entry.as_const_access(), &read.as_const_access());
        assert_eq!(weight_unbounded, 1.0);
    }

    #[test]
    fn allocate_new_variable_deterministically_picks_const_storage_for_a_point_range() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(42);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        // A degenerate [5, 5] range has zero dynamic-range weight, which (per
        // allocateNewVariable's own weight formula) makes every storage class except
        // Const weigh exactly 0 - Const is picked with probability 1, not just "most
        // likely", so this is safe to assert exactly rather than statistically.
        let mut point_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        point_range.get_min().set_int(5);
        point_range.get_max().set_int(5);

        let variable_id = allocate_new_variable(&mut state, &mut mgr, &point_range.as_const_access());
        assert_eq!(mgr.get_variable(variable_id).get_storage(), Storage::Const);
        assert_eq!(
            mgr.get_value(variable_id)
                .unwrap()
                .get_value_range_const()
                .get_min()
                .as_int(),
            5
        );
        assert_eq!(
            mgr.get_value(variable_id)
                .unwrap()
                .get_value_range_const()
                .get_max()
                .as_int(),
            5
        );
    }

    #[test]
    fn variable_read_creates_a_fresh_variable_when_nothing_matches_and_budget_allows() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(7);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(0);
        range.get_max().set_int(10);

        let read = VariableRead::new_random(&mut state, &mut mgr, &range.as_const_access());
        let variable = mgr.get_variable(read.get_variable());
        assert_eq!(*variable.get_type(), VariableType::new_basic(Type::Int, 1));

        let stored = mgr
            .get_value(read.get_variable())
            .expect("a fresh variable must have a stored value range");
        assert_eq!(stored.get_value_range_const().get_min().as_int(), 0);
        assert_eq!(stored.get_value_range_const().get_max().as_int(), 10);
    }

    #[test]
    fn variable_read_reuses_an_existing_entry_and_narrows_its_range_once_the_budget_is_exhausted() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_combined_variable_scalars: 1,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(3);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        // Pre-allocate the one variable the budget allows, with a wide range.
        let mut wide = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        wide.get_min().set_int(-20);
        wide.get_max().set_int(20);
        let existing_id = allocate_new_variable(&mut state, &mut mgr, &wide.as_const_access());

        // The budget is now exactly exhausted (1 scalar allocated, max is 1), so
        // `can_allocate_variable` must refuse a new allocation and `VariableRead` is
        // forced down the reuse-and-intersect path deterministically.
        assert!(!can_allocate_variable(
            &state,
            &mgr,
            &VariableType::new_basic(Type::Int, 1)
        ));

        let mut narrow = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        narrow.get_min().set_int(0);
        narrow.get_max().set_int(10);

        let read = VariableRead::new_random(&mut state, &mut mgr, &narrow.as_const_access());
        assert_eq!(read.get_variable(), existing_id);

        // Hand-computed: intersection of [-20, 20] and [0, 10] is [0, 10].
        let stored = mgr.get_value(existing_id).unwrap();
        assert_eq!(stored.get_value_range_const().get_min().as_int(), 0);
        assert_eq!(stored.get_value_range_const().get_max().as_int(), 10);
    }

    #[test]
    fn variable_write_creates_a_fresh_variable_with_an_infinite_range_at_the_root_scope() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(11);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        let write = VariableWrite::new(&mut state, &mut mgr, &range.as_const_access());
        assert_eq!(
            *mgr.get_variable(write.get_variable()).get_type(),
            VariableType::new_basic(Type::Float, 1)
        );

        // Only one scope is on the stack, so `get_parent_value` always returns `None` -
        // the "use infinite range" branch is the only one reachable here.
        let stored = mgr.get_value(write.get_variable()).unwrap();
        assert_eq!(
            stored.get_value_range_const().get_min().as_float(),
            Scalar::min_float().as_float()
        );
        assert_eq!(
            stored.get_value_range_const().get_max().as_float(),
            Scalar::max_float().as_float()
        );
    }

    #[test]
    fn variable_write_reuses_a_superset_entry_once_the_budget_is_exhausted() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_combined_variable_scalars: 1,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(13);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut wide = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        wide.get_min().set_int(-20);
        wide.get_max().set_int(20);
        let existing_id = allocate_new_variable(&mut state, &mut mgr, &wide.as_const_access());
        mgr.set_storage(existing_id, Storage::Local); // Writable.

        assert!(!can_allocate_variable(
            &state,
            &mgr,
            &VariableType::new_basic(Type::Int, 1)
        ));

        let mut narrow = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        narrow.get_min().set_int(0);
        narrow.get_max().set_int(10);

        let write = VariableWrite::new(&mut state, &mut mgr, &narrow.as_const_access());
        assert_eq!(write.get_variable(), existing_id);
    }

    #[test]
    fn set_infinite_range_covers_the_full_domain_for_every_base_type() {
        let mut int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        set_infinite_range(&mut int_range);
        assert_eq!(int_range.get_min_const().as_int(), i32::MIN);
        assert_eq!(int_range.get_max_const().as_int(), i32::MAX);

        let mut bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        set_infinite_range(&mut bool_range);
        assert!(!bool_range.get_min_const().as_bool());
        assert!(bool_range.get_max_const().as_bool());
    }

    #[test]
    fn get_weighted_bool_is_never_true_at_zero_weight_and_always_true_at_one() {
        let mut rnd = Random::new(99);
        for _ in 0..50 {
            assert!(!get_weighted_bool(&mut rnd, 0.0));
        }
        for _ in 0..50 {
            assert!(get_weighted_bool(&mut rnd, 1.0));
        }
    }

    #[test]
    fn variable_read_and_write_evaluate_and_resolve_through_an_execution_context() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(21);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(0);
        range.get_max().set_int(10);
        let read = VariableRead::new_random(&mut state, &mut mgr, &range.as_const_access());
        read.evaluate(); // No-op - just confirm it does not panic.

        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        read.get_lvalue(&mgr, &mut ctx).set_int_at(0, 42);
        assert_eq!(read.get_value(&mgr, &mut ctx).as_int_at(0), 42);

        let mut stream = TokenStream::new();
        read.tokenize(&mgr, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::identifier(mgr.get_variable(read.get_variable()).get_name())]
        );
    }

    #[test]
    fn assign_op_constructor_keeps_a_concrete_range_unchanged_when_nothing_conflicts() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(31);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(2);
        range.get_max().set_int(8);

        let assign = AssignOp::new(&mut state, &mut mgr, &range.as_const_access());
        assert_eq!(assign.value_range.get_min_const().as_int(), 2);
        assert_eq!(assign.value_range.get_max_const().as_int(), 8);
    }

    #[test]
    fn assign_op_get_weight_is_4_at_depth_zero_and_0_deeper() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(AssignOp::get_weight(&state, &mgr, &range.as_const_access()), 4.0);

        state.set_expression_depth(1);
        // upstream's own `\todo [pyry] Fix assign ops`: deeper than the root, the
        // weight always drops straight to 0 regardless of anything else.
        assert_eq!(AssignOp::get_weight(&state, &mgr, &range.as_const_access()), 0.0);
    }

    #[test]
    fn assign_op_create_next_child_builds_lvalue_then_rvalue_then_reports_done() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(5);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(0);
        range.get_max().set_int(10);

        let mut assign = AssignOp::new(&mut state, &mut mgr, &range.as_const_access());
        assert!(assign.lvalue_expr.is_none());
        assert!(assign.create_next_child(&mut state, &mut mgr).is_some());
        assert!(assign.lvalue_expr.is_some());
        assert!(assign.rvalue_expr.is_none());
        assert!(assign.create_next_child(&mut state, &mut mgr).is_some());
        assert!(assign.rvalue_expr.is_some());
        assert!(assign.create_next_child(&mut state, &mut mgr).is_none());
    }

    #[test]
    fn assign_op_evaluate_writes_the_rvalue_through_the_lvalue_masked_by_the_execution_mask() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let type_ = VariableType::new_basic(Type::Int, 1);
        let target = mgr.allocate_named(type_.clone(), Storage::Local, "x");

        let mut range = ValueRange::new(type_);
        range.get_min().set_int(0);
        range.get_max().set_int(10);

        let mut assign = AssignOp::new(&mut state, &mut mgr, &range.as_const_access());
        assign.lvalue_expr = Some(Box::new(Expression::VariableRead(VariableRead::from_variable(target))));
        assign.rvalue_expr = Some(Box::new(Expression::Int(IntLiteral::new_random(
            &mut state,
            &range.as_const_access(),
        ))));

        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let expected = assign
            .rvalue_expr
            .as_ref()
            .unwrap()
            .get_value(&mgr, &mut ctx)
            .as_int_at(0);
        assign.evaluate(&mgr, &mut ctx);

        assert_eq!(assign.get_value().as_int_at(0), expected);
        // The write actually landed on the target variable's own storage, not just
        // `AssignOp`'s own cache.
        assert_eq!(
            ctx.get_value(target, &VariableType::new_basic(Type::Int, 1))
                .as_int_at(0),
            expected
        );

        let mut stream = TokenStream::new();
        assign.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens()[1], Token::Equal);
    }

    #[test]
    fn constructor_op_keeps_a_concrete_range_unchanged_and_slices_one_range_per_component() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 3));
        range.as_access().component(0).get_min().set_float(0.0);
        range.as_access().component(0).get_max().set_float(1.0);
        range.as_access().component(1).get_min().set_float(2.0);
        range.as_access().component(1).get_max().set_float(3.0);
        range.as_access().component(2).get_min().set_float(4.0);
        range.as_access().component(2).get_max().set_float(5.0);

        let ctor = ConstructorOp::new(&mut state, &range.as_const_access());
        assert_eq!(*ctor.value_range.get_type(), VariableType::new_basic(Type::Float, 3));
        assert_eq!(ctor.input_value_ranges.len(), 3);
        assert_eq!(ctor.input_value_ranges[0].get_min_const().as_float(), 0.0);
        assert_eq!(ctor.input_value_ranges[1].get_min_const().as_float(), 2.0);
        assert_eq!(ctor.input_value_ranges[2].get_min_const().as_float(), 4.0);
    }

    #[test]
    fn constructor_op_get_weight_respects_the_expression_depth_budget() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_expression_depth: 3,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        // getTypeConstructorDepth(float vec3) == 2 (one node for ctor, another for
        // value - same as any float/int/bool type, vector or scalar).
        let range = ValueRange::new(VariableType::new_basic(Type::Float, 3));
        assert_eq!(ConstructorOp::get_weight(&state, &range.as_const_access()), 1.0);

        state.set_expression_depth(2);
        // 2 + 2 = 4 > 3, over budget.
        assert_eq!(ConstructorOp::get_weight(&state, &range.as_const_access()), 0.0);

        state.set_expression_depth(0);
        let void_r = ValueRange::new(VariableType::new_basic(Type::Void, 1));
        assert_eq!(
            ConstructorOp::get_weight(&state, &void_r.as_const_access()),
            UNUSED_VALUE_WEIGHT
        );

        let sampler_r = ValueRange::new(VariableType::new_basic(Type::Sampler2D, 1));
        assert_eq!(ConstructorOp::get_weight(&state, &sampler_r.as_const_access()), 0.0);
    }

    #[test]
    fn constructor_op_evaluate_restores_the_correct_component_order_despite_reverse_construction() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let range = ValueRange::new(VariableType::new_basic(Type::Float, 3));
        let mut ctor = ConstructorOp::new(&mut state, &range.as_const_access());

        // Matches `create_next_child`'s own real order: the first child built
        // corresponds to the *last* component (index 2), the last child built to the
        // *first* (index 0) - see this struct's own doc comment.
        ctor.input_expressions
            .push(Expression::Float(FloatLiteral::new_custom(30.0))); // component 2
        ctor.input_expressions
            .push(Expression::Float(FloatLiteral::new_custom(20.0))); // component 1
        ctor.input_expressions
            .push(Expression::Float(FloatLiteral::new_custom(10.0))); // component 0

        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        ctor.evaluate(&mgr, &mut ctx);

        let value = ctor.get_value();
        assert_eq!(value.component(0).as_float_at(0), 10.0);
        assert_eq!(value.component(1).as_float_at(0), 20.0);
        assert_eq!(value.component(2).as_float_at(0), 30.0);

        let mut stream = TokenStream::new();
        ctor.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        // "vec3(<comp0's token>, <comp1's token>, <comp2's token>)" - `tokenize` also
        // iterates `input_expressions` in *reverse*, exactly like `evaluate` above, so
        // the printed argument order is the correct final component order, not the
        // (reversed) construction order.
        assert_eq!(
            stream.tokens(),
            &[
                Token::Vec3,
                Token::LeftParen,
                Token::FloatLiteral(10.0),
                Token::Comma,
                Token::FloatLiteral(20.0),
                Token::Comma,
                Token::FloatLiteral(30.0),
                Token::RightParen,
            ]
        );
    }

    #[test]
    fn constructor_op_create_next_child_builds_components_in_reverse_then_reports_done() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(9);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 2));
        let mut ctor = ConstructorOp::new(&mut state, &range.as_const_access());

        assert!(ctor.create_next_child(&mut state, &mut mgr).is_some());
        assert_eq!(ctor.input_expressions.len(), 1);
        assert!(ctor.create_next_child(&mut state, &mut mgr).is_some());
        assert_eq!(ctor.input_expressions.len(), 2);
        assert!(ctor.create_next_child(&mut state, &mut mgr).is_none());
        assert_eq!(ctor.input_expressions.len(), 2);
    }

    #[test]
    fn scalar_convert_matches_hand_computed_values_including_sentinels() {
        use scalar_convert::*;

        // float -> int: sign-based rounding toward zero, sentinels preserved exactly.
        assert_eq!(float_to_int(2.7), 2);
        assert_eq!(float_to_int(-2.7), -2);
        assert_eq!(float_to_int(Scalar::min_float().as_float()), Scalar::min_int().as_int());
        assert_eq!(float_to_int(Scalar::max_float().as_float()), Scalar::max_int().as_int());

        // float -> bool: "!= 0.0" per the GLSL ES spec comment upstream carries.
        assert!(!float_to_bool(0.0));
        assert!(float_to_bool(0.5));
        assert!(float_to_bool(-0.5));

        // int -> float: identity-with-sentinels (no rounding needed the other way).
        assert_eq!(int_to_float(3), 3.0);
        assert_eq!(int_to_float(Scalar::min_int().as_int()), Scalar::min_float().as_float());
        assert_eq!(int_to_float(Scalar::max_int().as_int()), Scalar::max_float().as_float());

        assert!(!int_to_bool(0));
        assert!(int_to_bool(1));
        assert!(int_to_bool(-1));

        assert_eq!(bool_to_float(true), 1.0);
        assert_eq!(bool_to_float(false), 0.0);
        assert_eq!(bool_to_int(true), 1);
        assert_eq!(bool_to_int(false), 0);

        // Same-type pairs are a plain identity.
        assert_eq!(float_to_float(1.25), 1.25);
        assert_eq!(int_to_int(-7), -7);
        assert!(bool_to_bool(true));
        assert!(!bool_to_bool(false));
    }

    #[test]
    fn convert_value_range_float_to_int_rounds_inward_not_toward_zero() {
        // Hand-computed: [1.2, 3.8] rounds *inward* (ceil the min up to 2, floor the
        // max down to 3) - a plain per-bound `float_to_int` (round toward zero) would
        // instead give [1, 3], which is NOT a subset of what [1.2, 3.8] can produce
        // (1 < 1.2). The inward direction is what `convert_value_range` must use.
        let (min, max) = convert_value_range(Type::Float, Type::Int, Scalar::from_float(1.2), Scalar::from_float(3.8));
        assert_eq!(min.as_int(), 2);
        assert_eq!(max.as_int(), 3);

        // Negative range: ceil(-3.8) = -3, floor(-1.2) = -2.
        let (min, max) = convert_value_range(
            Type::Float,
            Type::Int,
            Scalar::from_float(-3.8),
            Scalar::from_float(-1.2),
        );
        assert_eq!(min.as_int(), -3);
        assert_eq!(max.as_int(), -2);

        // Sentinels pass straight through to the int sentinels.
        let (min, max) = convert_value_range(Type::Float, Type::Int, Scalar::min_float(), Scalar::max_float());
        assert_eq!(min.as_int(), Scalar::min_int().as_int());
        assert_eq!(max.as_int(), Scalar::max_int().as_int());
    }

    #[test]
    fn convert_value_range_float_to_bool_uses_strictly_greater_than_zero() {
        // `> 0.0`, not `!= 0.0` (the scalar `convert` function's own rule) - a range
        // whose bounds are both <= 0 converts to [false, false], not [true, false].
        let (min, max) = convert_value_range(
            Type::Float,
            Type::Bool,
            Scalar::from_float(-1.0),
            Scalar::from_float(0.0),
        );
        assert!(!min.as_bool());
        assert!(!max.as_bool());

        let (min, max) = convert_value_range(
            Type::Float,
            Type::Bool,
            Scalar::from_float(0.5),
            Scalar::from_float(2.0),
        );
        assert!(min.as_bool());
        assert!(max.as_bool());
    }

    #[test]
    fn convert_scalar_is_round_toward_zero_and_not_eq_zero_unlike_convert_value_range() {
        // `convert_scalar` is upstream's plain `convert<SrcType, DstType>` - round
        // *toward zero* (floor when positive, ceil when negative), the opposite
        // direction from `convert_value_range`'s own inward ceil/floor rule.
        // `convert_value_range(Float, Int, 3.8, 3.8).0` (always `ceil`, the "min" slot)
        // gives 4; the plain scalar conversion of the same value rounds toward zero
        // (floor, since positive) and gives 3 - this is exactly the divergence
        // `is_conversion_ok`'s own round-trip check must use the scalar form for.
        assert_eq!(
            convert_scalar(Type::Float, Type::Int, Scalar::from_float(3.8)).as_int(),
            3
        );
        assert_eq!(
            convert_value_range(Type::Float, Type::Int, Scalar::from_float(3.8), Scalar::from_float(3.8))
                .0
                .as_int(),
            4
        );

        // Same divergence on the "max" slot (always `floor`) for a negative input:
        // round-toward-zero ceils a negative value, `convert_value_range`'s max slot
        // floors it.
        assert_eq!(
            convert_scalar(Type::Float, Type::Int, Scalar::from_float(-3.8)).as_int(),
            -3
        );
        assert_eq!(
            convert_value_range(
                Type::Float,
                Type::Int,
                Scalar::from_float(-3.8),
                Scalar::from_float(-3.8)
            )
            .1
            .as_int(),
            -4
        );

        // `convert_scalar(Float, Bool, ...)` is `!= 0.0` (a negative value is `true`);
        // `convert_value_range(Float, Bool, ...)` is `> 0.0` (a negative value is
        // `false`) - upstream's own `isConversionOk` round-trip needs the former.
        assert!(convert_scalar(Type::Float, Type::Bool, Scalar::from_float(-1.0)).as_bool());
        assert!(
            !convert_value_range(
                Type::Float,
                Type::Bool,
                Scalar::from_float(-1.0),
                Scalar::from_float(-1.0)
            )
            .0
            .as_bool()
        );

        // Every other pair has no such special case, so `convert_scalar` and
        // `convert_value_range` (applied to a degenerate single-point range) agree.
        assert_eq!(
            convert_scalar(Type::Int, Type::Float, Scalar::from_int(7)).as_float(),
            7.0
        );
        assert_eq!(
            convert_value_range(Type::Int, Type::Float, Scalar::from_int(7), Scalar::from_int(7))
                .0
                .as_float(),
            7.0
        );
    }

    #[test]
    fn is_conversion_ok_matches_hand_computed_cases() {
        // Float -> Float is hardcoded true regardless of the actual range.
        assert!(is_conversion_ok(
            Type::Float,
            Type::Float,
            Scalar::from_float(100.0),
            Scalar::from_float(-100.0)
        ));

        // Identity is always ok for Int and Bool too.
        assert!(is_conversion_ok(
            Type::Int,
            Type::Int,
            Scalar::from_int(-3),
            Scalar::from_int(3)
        ));
        assert!(is_conversion_ok(
            Type::Bool,
            Type::Bool,
            Scalar::from_bool(false),
            Scalar::from_bool(true)
        ));

        // Int -> Bool: the dst range [false, true] converts backward to Int as [0, 1]
        // (computeEqualityValueRange's own bool<->int convention), which round-trips
        // cleanly forward again - ok.
        assert!(is_conversion_ok(
            Type::Int,
            Type::Bool,
            Scalar::from_bool(false),
            Scalar::from_bool(true)
        ));

        // Float -> Int: a dst range of [2, 2] (a single point) converts backward to
        // Float as [2.0, 2.0], which round-trips forward (ceil(2.0)=2, floor(2.0)=2)
        // cleanly back to [2, 2] - ok.
        assert!(is_conversion_ok(
            Type::Float,
            Type::Int,
            Scalar::from_int(2),
            Scalar::from_int(2)
        ));
    }

    /// `ConstructorOp` with `ProgramParameters::use_scalar_conversions == true` -
    /// exercises the real `ConstructorOp::new`'s own `is_conversion_ok`/
    /// `convert_value_range` wiring (which of `{Float, Int, Bool}` ends up as
    /// `input_value_ranges[0]`'s own type, and what point value it holds), then a
    /// hand-built literal of exactly that type/value drives `convert_exec_value`
    /// through a real `ConstructorOp::evaluate` - confirming the round trip lands back
    /// on `true` regardless of which input type the random draw picked. (Driving this
    /// through `create_next_child`'s own `create_random` dispatch instead, and letting
    /// it pick whatever expression kind it likes, hits the same known test-methodology
    /// gap `generate_expression_builds_a_fully_resolved_tree...`'s own doc comment
    /// already describes - a `VariableRead` picked for the inner value has no concrete
    /// value assigned outside a real shader generator run, so this test builds the one
    /// leaf expression directly instead.)
    #[test]
    fn constructor_op_with_scalar_conversions_produces_the_correct_value_regardless_of_chosen_input_type() {
        let program_params = ProgramParameters {
            use_scalar_conversions: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut alloc = NameAllocator::new();
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();

        // A point range of exactly `true`, which Float (1.0), Int (1) and Bool (true)
        // can all represent and round-trip exactly - so every possible input-type draw
        // must still evaluate to `true`.
        let mut range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        range.get_min().set_bool(true);
        range.get_max().set_bool(true);

        for seed in 0..30 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mgr = new_var_manager(&mut alloc);
            let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

            let mut ctor = ConstructorOp::new(&mut state, &range.as_const_access());
            let in_type = ctor.input_value_ranges[0].get_type().clone();
            let in_min = ctor.input_value_ranges[0].get_min_const();

            let literal = match in_type.base_type() {
                Type::Float => Expression::Float(FloatLiteral::new_custom(in_min.as_float())),
                Type::Int => {
                    let point = in_min.as_int();
                    let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
                    r.get_min().set_int(point);
                    r.get_max().set_int(point);
                    Expression::Int(IntLiteral::new_random(&mut state, &r.as_const_access()))
                }
                Type::Bool => Expression::Bool(BoolLiteral::new_custom(in_min.as_bool())),
                _ => unreachable!("rsg::ConstructorOp scalar conversion input is always Float, Int or Bool"),
            };
            ctor.input_expressions.push(literal);

            ctor.evaluate(&mgr, &mut ctx);
            assert!(
                ctor.get_value().as_bool_at(0),
                "seed {seed} in_type {:?}",
                in_type.base_type()
            );
        }
    }

    /// Exhaustively verifies `ComputeAddRange`/`ComputeSubRange`'s own invariant
    /// (every corner of `[aMin,aMax] x [bMin,bMax]` lands back within
    /// `[dstMin,dstMax]`) directly against the computed sub-ranges, across several
    /// hand-picked ranges and many seeds - the same check upstream's own
    /// `DE_DEBUG`-only `DE_ASSERT`s make, but run unconditionally and for both the int
    /// and float overloads.
    #[test]
    fn binary_op_compute_value_range_keeps_every_corner_within_the_requested_range() {
        let int_ranges = [(-3, 3), (0, 10), (-16, 16), (5, 5), (-1, 1)];
        let float_ranges = [(-3.0, 3.0), (0.0, 10.0), (-16.0, 16.0), (5.0, 5.0), (-1.0, 1.0)];

        for seed in 0..50 {
            let mut rnd = Random::new(seed);
            for kind in [BinaryOpKind::Add, BinaryOpKind::Sub] {
                for &(dst_min, dst_max) in &int_ranges {
                    let (a_min, a_max, b_min, b_max) = kind.compute_value_range_int(&mut rnd, dst_min, dst_max);
                    assert!(
                        a_min <= a_max,
                        "seed {seed} int {dst_min}..{dst_max}: aMin={a_min} > aMax={a_max}"
                    );
                    assert!(
                        b_min <= b_max,
                        "seed {seed} int {dst_min}..{dst_max}: bMin={b_min} > bMax={b_max}"
                    );
                    for &a in &[a_min, a_max] {
                        for &b in &[b_min, b_max] {
                            let result = kind.evaluate_int(a, b);
                            assert!(
                                (dst_min..=dst_max).contains(&result),
                                "seed {seed} int {dst_min}..{dst_max}: a={a} b={b} -> {result}"
                            );
                        }
                    }
                }

                for &(dst_min, dst_max) in &float_ranges {
                    let (a_min, a_max, b_min, b_max) = kind.compute_value_range_float(&mut rnd, dst_min, dst_max);
                    assert!(
                        a_min <= a_max,
                        "seed {seed} float {dst_min}..{dst_max}: aMin={a_min} > aMax={a_max}"
                    );
                    assert!(
                        b_min <= b_max,
                        "seed {seed} float {dst_min}..{dst_max}: bMin={b_min} > bMax={b_max}"
                    );
                    const EPS: f32 = 0.001; // Matches upstream's own `DE_DEBUG` tolerance.
                    for &a in &[a_min, a_max] {
                        for &b in &[b_min, b_max] {
                            let result = kind.evaluate_float(a, b);
                            assert!(
                                (dst_min - EPS..=dst_max + EPS).contains(&result),
                                "seed {seed} float {dst_min}..{dst_max}: a={a} b={b} -> {result}"
                            );
                        }
                    }
                }
            }
        }
    }

    /// `ComputeMulRange`'s own invariant - a separate test from the `Add`/`Sub` one
    /// above because `Mul`'s two overloads are both genuinely different algorithms
    /// (see `compute_mul_range_float`/`compute_mul_range_int`'s own doc comments): the
    /// int overload is degenerate (always `b == 1`, `a` passed straight through) and
    /// the float overload's internal scale search uses a half-open bound
    /// (`de::inBounds`) even though the final result this test checks is the same
    /// closed-range-with-`DE_DEBUG`-epsilon invariant upstream itself asserts.
    #[test]
    fn binary_op_mul_compute_value_range_keeps_every_corner_within_the_requested_range() {
        let int_ranges = [(-3, 3), (0, 10), (-16, 16), (5, 5), (-1, 1)];
        let float_ranges = [
            (-3.0, 3.0),
            (0.0, 10.0),
            (-16.0, 16.0),
            (5.0, 5.0),
            (-1.0, 1.0),
            (1.0, 8.0),
        ];

        for seed in 0..50 {
            let mut rnd = Random::new(seed);

            for &(dst_min, dst_max) in &int_ranges {
                let (a_min, a_max, b_min, b_max) =
                    BinaryOpKind::Mul.compute_value_range_int(&mut rnd, dst_min, dst_max);
                assert_eq!(
                    (b_min, b_max),
                    (1, 1),
                    "seed {seed} int {dst_min}..{dst_max}: Mul's int overload is always b==1"
                );
                assert_eq!(
                    (a_min, a_max),
                    (dst_min, dst_max),
                    "seed {seed} int {dst_min}..{dst_max}"
                );
            }

            for &(dst_min, dst_max) in &float_ranges {
                let (a_min, a_max, b_min, b_max) =
                    BinaryOpKind::Mul.compute_value_range_float(&mut rnd, dst_min, dst_max);
                assert!(
                    a_min <= a_max,
                    "seed {seed} float {dst_min}..{dst_max}: aMin={a_min} > aMax={a_max}"
                );
                assert!(
                    b_min <= b_max,
                    "seed {seed} float {dst_min}..{dst_max}: bMin={b_min} > bMax={b_max}"
                );
                const EPS: f32 = 0.001; // Matches upstream's own `DE_DEBUG` tolerance.
                for &a in &[a_min, a_max] {
                    for &b in &[b_min, b_max] {
                        let result = BinaryOpKind::Mul.evaluate_float(a, b);
                        assert!(
                            (dst_min - EPS..=dst_max + EPS).contains(&result),
                            "seed {seed} float {dst_min}..{dst_max}: a={a} b={b} -> {result}"
                        );
                    }
                }
            }
        }
    }

    #[test]
    fn binary_op_add_and_sub_evaluate_correctly_with_hand_built_children() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 1));

        // `IntLiteral` has no `IntLiteral(int)` constructor upstream (unlike
        // `FloatLiteral`/`BoolLiteral`, which both do) - a degenerate point range
        // forces `new_random`'s own `rnd.get_int(min, max)` to land on an exact,
        // known value regardless of the draw, which is the only way to get one here.
        let point_range = |v: i32| {
            let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
            r.get_min().set_int(v);
            r.get_max().set_int(v);
            r
        };
        let literal =
            |state: &mut GeneratorState<'_>, v: i32| IntLiteral::new_random(state, &point_range(v).as_const_access());

        let mut add = BinaryOp::new(BinaryOpKind::Add, &mut state, &range.as_const_access());
        add.left_expr = Some(Box::new(Expression::Int(literal(&mut state, 7))));
        add.right_expr = Some(Box::new(Expression::Int(literal(&mut state, 5))));
        add.evaluate(&mgr, &mut ctx);
        assert_eq!(add.get_value().as_int_at(0), 12);

        let mut sub = BinaryOp::new(BinaryOpKind::Sub, &mut state, &range.as_const_access());
        sub.left_expr = Some(Box::new(Expression::Int(literal(&mut state, 7))));
        sub.right_expr = Some(Box::new(Expression::Int(literal(&mut state, 5))));
        sub.evaluate(&mgr, &mut ctx);
        assert_eq!(sub.get_value().as_int_at(0), 2);

        let mut stream = TokenStream::new();
        add.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::IntLiteral(7), Token::Plus, Token::IntLiteral(5)]
        );
    }

    #[test]
    fn binary_op_mul_evaluates_correctly_with_hand_built_children_and_tokenizes_with_mul() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        let point_range = |v: i32| {
            let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
            r.get_min().set_int(v);
            r.get_max().set_int(v);
            r
        };
        let literal =
            |state: &mut GeneratorState<'_>, v: i32| IntLiteral::new_random(state, &point_range(v).as_const_access());

        let mut mul = BinaryOp::new(BinaryOpKind::Mul, &mut state, &range.as_const_access());
        mul.left_expr = Some(Box::new(Expression::Int(literal(&mut state, 7))));
        mul.right_expr = Some(Box::new(Expression::Int(literal(&mut state, 5))));
        mul.evaluate(&mgr, &mut ctx);
        assert_eq!(mul.get_value().as_int_at(0), 35);

        let mut stream = TokenStream::new();
        mul.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::IntLiteral(7), Token::Mul, Token::IntLiteral(5)]
        );
    }

    #[test]
    fn binary_op_kind_precedence_matches_upstream_typedefs() {
        // `MulBase` is `BinaryVecOp<4, ...>`, `AddBase`/`SubBase` are `BinaryVecOp<5,
        // ...>` - confirmed by reading the real `typedef`s in `rsgBinaryOps.hpp`. A
        // lower numeric precedence binds *tighter* (matches `create_next_child`'s own
        // `leftPrec = Precedence`/`rightPrec = Precedence - 1` convention), so `Mul`
        // must report a strictly lower value than `Add`/`Sub`.
        assert_eq!(BinaryOpKind::Mul.precedence(), 4);
        assert_eq!(BinaryOpKind::Add.precedence(), 5);
        assert_eq!(BinaryOpKind::Sub.precedence(), 5);
        assert!(BinaryOpKind::Mul.precedence() < BinaryOpKind::Add.precedence());
    }

    #[test]
    fn binary_op_create_next_child_builds_right_then_left_then_reports_done() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(3);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        let mut add = BinaryOp::new(BinaryOpKind::Add, &mut state, &range.as_const_access());

        assert!(add.right_expr.is_none());
        assert!(add.create_next_child(&mut state, &mut mgr).is_some());
        assert!(add.right_expr.is_some());
        assert!(add.left_expr.is_none());
        assert!(add.create_next_child(&mut state, &mut mgr).is_some());
        assert!(add.left_expr.is_some());
        assert!(add.create_next_child(&mut state, &mut mgr).is_none());
    }

    #[test]
    fn binary_op_get_weight_respects_precedence_and_depth_budget() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_expression_depth: 3,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(
            BinaryOp::get_weight(BinaryOpKind::Add, &state, &range.as_const_access()),
            1.0
        );

        // Both Add/Sub are precedence 5 - a caller enforcing a *lower* maximum
        // precedence (as `createNextChild`'s own right-hand-side push does) must
        // refuse them.
        state.push_precedence(4);
        assert_eq!(
            BinaryOp::get_weight(BinaryOpKind::Add, &state, &range.as_const_access()),
            0.0
        );
        state.pop_precedence();

        // A bool range is never accepted (matches `AddOp`/`MulOp::getWeight`'s own
        // extra type filter).
        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        assert_eq!(
            BinaryOp::get_weight(BinaryOpKind::Add, &state, &bool_range.as_const_access()),
            0.0
        );
    }

    /// Hand-verifies `ComputeLessThanRange`/`ComputeLessOrEqualRange`'s own three
    /// branches directly, for all four kinds: for a destination range that must always
    /// be `true`, every `a` in `[aMin,aMax]` must satisfy `kind(a, b)` against every `b`
    /// in `[bMin,bMax]` (and the mirror for `false`). `LessThan`/`GreaterThan` achieve
    /// this via a `STEP`-sized gap (never merely `<=`); `LessOrEqual`/`GreaterOrEqual`
    /// move that gap to the *other* branch instead (equality is fine on the "always
    /// true" side, excluded with the gap on the "always false" side) - `kind.
    /// evaluate_int`'s own comparator (`<`/`<=`) is what actually checks either shape is
    /// satisfied, not an assumption baked into this test.
    #[test]
    fn relational_op_compute_value_range_keeps_the_promised_ordering() {
        for seed in 0..50 {
            let mut rnd = Random::new(seed);
            for kind in [
                RelationalOpKind::LessThan,
                RelationalOpKind::GreaterThan,
                RelationalOpKind::LessOrEqual,
                RelationalOpKind::GreaterOrEqual,
            ] {
                // Always true: every a must satisfy `kind(a, b)` for every b.
                let (a_min, a_max, b_min, b_max) = kind.compute_value_range_int(&mut rnd, true, true);
                assert!(a_min <= a_max && b_min <= b_max, "seed {seed}");
                for &a in &[a_min, a_max] {
                    for &b in &[b_min, b_max] {
                        assert!(kind.evaluate_int(a, b), "seed {seed} always-true a={a} b={b}");
                    }
                }

                // Always false: every a must fail `kind(a, b)` for every b.
                let (a_min, a_max, b_min, b_max) = kind.compute_value_range_int(&mut rnd, false, false);
                assert!(a_min <= a_max && b_min <= b_max, "seed {seed}");
                for &a in &[a_min, a_max] {
                    for &b in &[b_min, b_max] {
                        assert!(!kind.evaluate_int(a, b), "seed {seed} always-false a={a} b={b}");
                    }
                }

                // Either possible: the float overload must at least produce a
                // well-ordered pair of ranges (not asserting a specific outcome, since
                // both `true` and `false` are legal here).
                let (a_min, a_max, b_min, b_max) = kind.compute_value_range_float(&mut rnd, false, true);
                assert!(a_min <= a_max && b_min <= b_max, "seed {seed}");
            }
        }
    }

    #[test]
    fn relational_op_evaluate_and_tokenize_with_hand_built_children() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mgr_alloc = &mut NameAllocator::new();
        let mgr = new_var_manager(mgr_alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        // `RelationalOp::new` picks its own operand type (`Float` or `Int`) at random,
        // independent of the (always-bool) output range, so the hand-built children
        // below have to match *whatever it actually picked*, not an assumed type.
        let literal_matching =
            |state: &mut GeneratorState<'_>, in_type: &VariableType, v: i32| match in_type.base_type() {
                Type::Int => {
                    let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
                    r.get_min().set_int(v);
                    r.get_max().set_int(v);
                    Expression::Int(IntLiteral::new_random(state, &r.as_const_access()))
                }
                Type::Float => Expression::Float(FloatLiteral::new_custom(v as f32)),
                _ => unreachable!("RelationalOp's own operand type is always Float or Int"),
            };

        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        let mut lt = RelationalOp::new(RelationalOpKind::LessThan, &mut state, &bool_range.as_const_access());
        let in_type = lt.in_type.clone();
        lt.left_expr = Some(Box::new(literal_matching(&mut state, &in_type, 3)));
        lt.right_expr = Some(Box::new(literal_matching(&mut state, &in_type, 5)));
        lt.evaluate(&mgr, &mut ctx);
        assert!(lt.get_value().as_bool_at(0));

        let mut gt = RelationalOp::new(RelationalOpKind::GreaterThan, &mut state, &bool_range.as_const_access());
        let in_type = gt.in_type.clone();
        gt.left_expr = Some(Box::new(literal_matching(&mut state, &in_type, 3)));
        gt.right_expr = Some(Box::new(literal_matching(&mut state, &in_type, 5)));
        gt.evaluate(&mgr, &mut ctx);
        assert!(!gt.get_value().as_bool_at(0));

        let mut stream = TokenStream::new();
        lt.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens()[1], Token::CmpLt);
    }

    #[test]
    fn relational_op_get_weight_requires_the_comparison_ops_flag() {
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);

        let disabled_params = ProgramParameters::default();
        let state_disabled = new_state_with_budget(&disabled_params, &shader_params, &mut random);
        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        assert_eq!(
            RelationalOp::get_weight(
                RelationalOpKind::LessThan,
                &state_disabled,
                &bool_range.as_const_access()
            ),
            0.0
        );

        let mut random2 = Random::new(1);
        let enabled_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let state_enabled = new_state_with_budget(&enabled_params, &shader_params, &mut random2);
        assert_eq!(
            RelationalOp::get_weight(
                RelationalOpKind::LessThan,
                &state_enabled,
                &bool_range.as_const_access()
            ),
            1.0
        );

        // Only a bool (or void) output range is ever accepted.
        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(
            RelationalOp::get_weight(RelationalOpKind::LessThan, &state_enabled, &int_range.as_const_access()),
            0.0
        );
    }

    #[test]
    fn relational_op_less_or_equal_and_greater_or_equal_evaluate_correctly_with_hand_built_int_children() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(7);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mgr_alloc = &mut NameAllocator::new();
        let mgr = new_var_manager(mgr_alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let literal_matching =
            |state: &mut GeneratorState<'_>, in_type: &VariableType, v: i32| match in_type.base_type() {
                Type::Int => {
                    let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
                    r.get_min().set_int(v);
                    r.get_max().set_int(v);
                    Expression::Int(IntLiteral::new_random(state, &r.as_const_access()))
                }
                Type::Float => Expression::Float(FloatLiteral::new_custom(v as f32)),
                _ => unreachable!("RelationalOp's own operand type is always Float or Int"),
            };

        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));

        let mut le = RelationalOp::new(RelationalOpKind::LessOrEqual, &mut state, &bool_range.as_const_access());
        let in_type = le.in_type.clone();
        le.left_expr = Some(Box::new(literal_matching(&mut state, &in_type, 5)));
        le.right_expr = Some(Box::new(literal_matching(&mut state, &in_type, 5)));
        le.evaluate(&mgr, &mut ctx);
        assert!(le.get_value().as_bool_at(0), "5 <= 5 must be true");

        let mut ge = RelationalOp::new(
            RelationalOpKind::GreaterOrEqual,
            &mut state,
            &bool_range.as_const_access(),
        );
        let in_type = ge.in_type.clone();
        ge.left_expr = Some(Box::new(literal_matching(&mut state, &in_type, 3)));
        ge.right_expr = Some(Box::new(literal_matching(&mut state, &in_type, 5)));
        ge.evaluate(&mgr, &mut ctx);
        assert!(!ge.get_value().as_bool_at(0), "3 >= 5 must be false");

        let mut le_stream = TokenStream::new();
        le.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut le_stream);
        assert_eq!(le_stream.tokens()[1], Token::CmpLe);

        let mut ge_stream = TokenStream::new();
        ge.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut ge_stream);
        assert_eq!(ge_stream.tokens()[1], Token::CmpGe);
    }

    #[test]
    fn epsilon_add_op_adds_the_point_zero_zero_one_literal_and_tokenizes_with_plus_and_no_parens() {
        let mut op = EpsilonAddOp::wrap(Expression::Float(FloatLiteral::new_custom(2.0)));

        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        op.evaluate(&mgr, &mut ctx);
        assert!((op.get_value().as_float_at(0) - 2.001).abs() < 1e-6);

        let mut stream = TokenStream::new();
        op.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::FloatLiteral(2.0), Token::Plus, Token::FloatLiteral(0.001)]
        );
    }

    /// `BinaryOp<P,A>::createNextChild`'s own `CMP_LE`/`CMP_GE` corner-case `switch`,
    /// exercised end to end through `RelationalOp::create_next_child` - the one piece of
    /// this file that is genuinely hard to hit through `new`'s own random operand-type
    /// choice (it only fires for a float operand), so each `RelationalOp` here is built
    /// directly with its fields set rather than going through `new`, matching the style
    /// already used by `RelationalOp::in_type`-reading tests elsewhere in this file.
    #[test]
    fn relational_op_create_next_child_wires_epsilon_add_only_for_float_less_or_equal_and_greater_or_equal() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let float_type = VariableType::new_basic(Type::Float, 1);
        let int_type = VariableType::new_basic(Type::Int, 1);

        let make = |kind: RelationalOpKind, operand_type: &VariableType| RelationalOp {
            kind,
            in_type: operand_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(operand_type.clone()),
            right_value_range: ValueRange::new(operand_type.clone()),
            left_expr: None,
            right_expr: None,
        };

        let mut le = make(RelationalOpKind::LessOrEqual, &float_type);
        while le.create_next_child(&mut state, &mut mgr).is_some() {}
        assert!(
            matches!(le.right_expr.as_deref(), Some(Expression::EpsilonAdd(_))),
            "LessOrEqual wraps its right (float) operand"
        );
        assert!(
            !matches!(le.left_expr.as_deref(), Some(Expression::EpsilonAdd(_))),
            "the left operand stays untouched"
        );

        let mut ge = make(RelationalOpKind::GreaterOrEqual, &float_type);
        while ge.create_next_child(&mut state, &mut mgr).is_some() {}
        assert!(
            matches!(ge.left_expr.as_deref(), Some(Expression::EpsilonAdd(_))),
            "GreaterOrEqual wraps its left (float) operand"
        );
        assert!(
            !matches!(ge.right_expr.as_deref(), Some(Expression::EpsilonAdd(_))),
            "the right operand stays untouched"
        );

        // An int-typed operand is never wrapped - matches upstream's own
        // `m_rightValueRange.getType() == floatType` guard, which only ever accepts the
        // scalar float type.
        let mut le_int = make(RelationalOpKind::LessOrEqual, &int_type);
        while le_int.create_next_child(&mut state, &mut mgr).is_some() {}
        assert!(!matches!(le_int.right_expr.as_deref(), Some(Expression::EpsilonAdd(_))));
        assert!(!matches!(le_int.left_expr.as_deref(), Some(Expression::EpsilonAdd(_))));

        // `LessThan`/`GreaterThan` never match the switch's `CMP_LE`/`CMP_GE` cases,
        // even for a float operand.
        let mut lt = make(RelationalOpKind::LessThan, &float_type);
        while lt.create_next_child(&mut state, &mut mgr).is_some() {}
        assert!(!matches!(lt.right_expr.as_deref(), Some(Expression::EpsilonAdd(_))));
        assert!(!matches!(lt.left_expr.as_deref(), Some(Expression::EpsilonAdd(_))));
    }

    #[test]
    fn paren_op_delegates_evaluate_get_value_and_tokenize_to_its_child() {
        let type_ = VariableType::new_basic(Type::Float, 1);
        let mut paren = ParenOp::new(ValueRange::new(type_));
        paren.set_child(Expression::Float(FloatLiteral::new_custom(3.5)));

        let mut alloc = NameAllocator::new();
        let mgr = VariableManager::new(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        paren.evaluate(&mgr, &mut ctx); // No-op for a literal child - just confirm it does not panic.
        assert_eq!(paren.get_value(&mgr, &mut ctx).as_float_at(0), 3.5);

        let mut stream = TokenStream::new();
        paren.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::LeftParen, Token::FloatLiteral(3.5), Token::RightParen]
        );
    }

    #[test]
    #[should_panic(expected = "child not set")]
    fn paren_op_panics_if_evaluated_before_a_child_is_set() {
        let type_ = VariableType::new_basic(Type::Float, 1);
        let mut paren = ParenOp::new(ValueRange::new(type_));
        let mut alloc = NameAllocator::new();
        let mgr = VariableManager::new(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);
        paren.evaluate(&mgr, &mut ctx);
    }

    #[test]
    fn paren_op_create_next_child_builds_exactly_one_child_then_reports_done() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut paren = ParenOp::new(ValueRange::new(VariableType::new_basic(Type::Int, 1)));
        assert!(paren.create_next_child(&mut state, &mut mgr).is_some());
        // A second call reports no more children, matching upstream's own `if (m_child)
        // return nullptr;`.
        assert!(paren.create_next_child(&mut state, &mut mgr).is_none());
    }

    #[test]
    fn paren_op_get_weight_respects_the_expression_depth_budget() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_expression_depth: 3,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let type_ = VariableType::new_basic(Type::Int, 1);
        let range = ValueRange::new(type_.clone());

        // getConservativeValueExprDepth(Int scalar) == 2 (one node for ctor, one for
        // value), so requiredDepth = 1 + 2 = 3; at depth 0, 0 + 3 <= 3 holds.
        assert_eq!(ParenOp::get_weight(&state, &range.as_const_access()), 1.0);

        state.set_expression_depth(1);
        // 1 + 3 = 4 > 3, so the budget is exceeded.
        assert_eq!(ParenOp::get_weight(&state, &range.as_const_access()), 0.0);

        state.set_expression_depth(0);
        let void_r = ValueRange::new(VariableType::new_basic(Type::Void, 1));
        // Void path: depth(0) + 2 <= 3 holds, so unusedValueWeight.
        assert_eq!(
            ParenOp::get_weight(&state, &void_r.as_const_access()),
            UNUSED_VALUE_WEIGHT
        );
    }

    #[test]
    fn expression_enum_covers_variable_read_write_and_paren_variants_too() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(55);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(0);
        range.get_max().set_int(5);
        let mut read_expr =
            Expression::VariableRead(VariableRead::new_random(&mut state, &mut mgr, &range.as_const_access()));

        let mut paren = ParenOp::new(ValueRange::new(VariableType::new_basic(Type::Float, 1)));
        paren.set_child(Expression::Float(FloatLiteral::new_custom(9.0)));
        let mut paren_expr = Expression::Paren(paren);

        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        read_expr.evaluate(&mgr, &mut ctx);
        assert!((0..=5).contains(&read_expr.get_value(&mgr, &mut ctx).as_int_at(0)));

        paren_expr.evaluate(&mgr, &mut ctx);
        assert_eq!(paren_expr.get_value(&mgr, &mut ctx).as_float_at(0), 9.0);
    }

    /// Builds `ivec2(a, b)` with fully deterministic components, bypassing
    /// `ConstructorOp::new`'s own random range slicing by setting its (private, but
    /// visible to this same file's `mod tests`) `input_expressions` field directly - in
    /// reverse order, matching `ConstructorOp`'s own "built in reverse" convention (see
    /// its own doc comment): output component 0 comes from the *last* element here.
    fn int_vec2_literal_child(state: &mut GeneratorState<'_>, a: i32, b: i32) -> Expression {
        let int_point = |state: &mut GeneratorState<'_>, v: i32| {
            let mut r = ValueRange::new(VariableType::new_basic(Type::Int, 1));
            r.get_min().set_int(v);
            r.get_max().set_int(v);
            Expression::Int(IntLiteral::new_random(state, &r.as_const_access()))
        };
        Expression::Constructor(ConstructorOp {
            value_range: ValueRange::new(VariableType::new_basic(Type::Int, 2)),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            input_value_ranges: Vec::new(),
            input_expressions: vec![int_point(state, b), int_point(state, a)],
        })
    }

    #[test]
    fn swizzle_op_constructor_picks_distinct_in_bounds_source_indices_and_a_valid_component_count() {
        let program_params = ProgramParameters {
            use_swizzle: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();

        for seed in 0..50 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

            let out_type = VariableType::new_basic(Type::Float, 3);
            let range = ValueRange::new(out_type.clone());
            let op = SwizzleOp::new(&mut state, &range.as_const_access());

            assert!(op.num_input_elements >= out_type.num_elements().max(2), "seed {seed}");
            assert!(op.num_input_elements <= 4, "seed {seed}");

            let num_output = out_type.num_elements() as usize;
            let used = &op.swizzle[..num_output];
            let mut sorted = used.to_vec();
            sorted.sort_unstable();
            sorted.dedup();
            assert_eq!(
                sorted.len(),
                used.len(),
                "seed {seed}: swizzle indices must be distinct"
            );
            for &idx in used {
                assert!(
                    (idx as i32) < op.num_input_elements,
                    "seed {seed}: index {idx} out of bounds"
                );
            }
            for &idx in &op.swizzle[num_output..] {
                assert_eq!(idx, 0, "seed {seed}: unused slots must stay 0");
            }
        }
    }

    #[test]
    fn swizzle_op_get_weight_respects_use_swizzle_precedence_type_and_depth_budget() {
        let shader_params = ShaderParameters {
            max_expression_depth: 5,
            ..ShaderParameters::default()
        };
        let float_vec_range = ValueRange::new(VariableType::new_basic(Type::Float, 2));

        let disabled_params = ProgramParameters::default();
        let mut random = Random::new(1);
        let state = new_state_with_budget(&disabled_params, &shader_params, &mut random);
        assert_eq!(SwizzleOp::get_weight(&state, &float_vec_range.as_const_access()), 0.0);

        let enabled_params = ProgramParameters {
            use_swizzle: true,
            ..ProgramParameters::default()
        };
        let mut random2 = Random::new(1);
        let mut state2 = new_state_with_budget(&enabled_params, &shader_params, &mut random2);
        assert_eq!(SwizzleOp::get_weight(&state2, &float_vec_range.as_const_access()), 1.0);

        // Precedence too low.
        state2.push_precedence(1);
        assert_eq!(SwizzleOp::get_weight(&state2, &float_vec_range.as_const_access()), 0.0);
        state2.pop_precedence();

        // `Void` is rejected (upstream's own "\todo Void support").
        let void_range = ValueRange::new(VariableType::new_basic(Type::Void, 1));
        assert_eq!(SwizzleOp::get_weight(&state2, &void_range.as_const_access()), 0.0);

        // Not enough depth budget left (needs Swizzle + Constructor + Values, i.e. >= 3).
        state2.set_expression_depth(3);
        assert_eq!(SwizzleOp::get_weight(&state2, &float_vec_range.as_const_access()), 0.0);
    }

    #[test]
    fn swizzle_op_evaluates_and_tokenizes_a_hand_built_child_correctly() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        // "child.yx" where child is ivec2(7, 9): output.x = input[1] = 9, output.y =
        // input[0] = 7 - built directly (bypassing the constructor's own random
        // index choice) to pin down an exact expected result.
        let mut swizzle = SwizzleOp {
            out_value_range: ValueRange::new(VariableType::new_basic(Type::Int, 2)),
            num_input_elements: 2,
            swizzle: [1, 0, 0, 0],
            child: Some(Box::new(int_vec2_literal_child(&mut state, 7, 9))),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        };

        swizzle.evaluate(&mgr, &mut ctx);
        let value = swizzle.get_value();
        // `value` is itself a vec2, so reading component `i` needs `.component(i)`
        // first - `as_int_at(lane)` alone reads SIMD lane `lane` of component 0, not
        // "component `lane`" (a one-time gotcha worth keeping on record: this test's
        // own first draft read `value.as_int_at(0)`/`as_int_at(1)` directly and got
        // "component 0, lane 0" and "component 0, lane 1" instead - both legitimately 9,
        // since every lane holds the same broadcast value - which looked exactly like a
        // genuine `SwizzleOp::evaluate` bug until traced back to the test itself).
        assert_eq!(value.component(0).as_int_at(0), 9);
        assert_eq!(value.component(1).as_int_at(0), 7);

        let mut stream = TokenStream::new();
        swizzle.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(*stream.tokens().last().unwrap(), Token::Identifier("yx".to_string()));
        assert_eq!(stream.tokens()[stream.tokens().len() - 2], Token::Dot);
    }

    #[test]
    fn swizzle_op_create_next_child_builds_exactly_one_child_then_reports_done() {
        let program_params = ProgramParameters {
            use_swizzle: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(3);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let out_range = ValueRange::new(VariableType::new_basic(Type::Int, 2));
        let mut swizzle = SwizzleOp::new(&mut state, &out_range.as_const_access());

        assert!(swizzle.child.is_none());
        assert!(swizzle.create_next_child(&mut state, &mut mgr).is_some());
        assert!(swizzle.child.is_some());
        assert!(swizzle.create_next_child(&mut state, &mut mgr).is_none());
    }

    /// Hand-verifies `computeEqualityValueRange<IsEqual>`'s own branches directly, for
    /// both kinds and both the int and float overloads: a destination range that must
    /// always be `true` forces every drawn `a`/`b` combination to satisfy `kind`'s own
    /// equality test, and the mirror for `false` - the same style
    /// `relational_op_compute_value_range_keeps_the_promised_ordering` uses.
    #[test]
    fn equality_comparison_op_compute_value_range_keeps_the_promised_equality() {
        for seed in 0..50 {
            let mut rnd = Random::new(seed);
            for kind in [EqualityOpKind::Equal, EqualityOpKind::NotEqual] {
                let (a_min, a_max, b_min, b_max) = compute_equality_value_range_int(kind, &mut rnd, true, true);
                for &a in &[a_min, a_max] {
                    for &b in &[b_min, b_max] {
                        let result = if kind.is_equal() { a == b } else { a != b };
                        assert!(result, "seed {seed} always-true a={a} b={b}");
                    }
                }

                let (a_min, a_max, b_min, b_max) = compute_equality_value_range_int(kind, &mut rnd, false, false);
                for &a in &[a_min, a_max] {
                    for &b in &[b_min, b_max] {
                        let result = if kind.is_equal() { a == b } else { a != b };
                        assert!(!result, "seed {seed} always-false a={a} b={b}");
                    }
                }

                let (a_min, a_max, b_min, b_max) = compute_equality_value_range_float(kind, &mut rnd, false, true);
                assert!(a_min <= a_max && b_min <= b_max, "seed {seed}");
            }
        }
    }

    #[test]
    fn equality_comparison_op_get_weight_requires_the_comparison_ops_flag_and_bool_or_void_type() {
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);

        let disabled_params = ProgramParameters::default();
        let state_disabled = new_state_with_budget(&disabled_params, &shader_params, &mut random);
        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        assert_eq!(
            EqualityComparisonOp::get_weight(EqualityOpKind::Equal, &state_disabled, &bool_range.as_const_access()),
            0.0
        );

        let mut random2 = Random::new(1);
        let enabled_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let state_enabled = new_state_with_budget(&enabled_params, &shader_params, &mut random2);
        assert_eq!(
            EqualityComparisonOp::get_weight(EqualityOpKind::Equal, &state_enabled, &bool_range.as_const_access()),
            1.0
        );
        assert_eq!(
            EqualityComparisonOp::get_weight(EqualityOpKind::NotEqual, &state_enabled, &bool_range.as_const_access()),
            1.0
        );

        // Only a bool (or void) output range is ever accepted.
        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        assert_eq!(
            EqualityComparisonOp::get_weight(EqualityOpKind::Equal, &state_enabled, &int_range.as_const_access()),
            0.0
        );
    }

    #[test]
    fn equality_comparison_op_evaluates_per_component_and_combines_with_and_or() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let in_type = VariableType::new_basic(Type::Int, 2);

        // left=(3,5), right=(3,9): component 0 equal, component 1 differs.
        let mut eq = EqualityComparisonOp {
            kind: EqualityOpKind::Equal,
            in_type: in_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(in_type.clone()),
            right_value_range: ValueRange::new(in_type.clone()),
            left_expr: Some(Box::new(int_vec2_literal_child(&mut state, 3, 5))),
            right_expr: Some(Box::new(int_vec2_literal_child(&mut state, 3, 9))),
        };
        eq.evaluate(&mgr, &mut ctx);
        // `Equal` combines per-component results with `&&` - one differing component
        // makes the whole comparison false.
        assert!(!eq.get_value().as_bool_at(0));

        let mut ne = EqualityComparisonOp {
            kind: EqualityOpKind::NotEqual,
            in_type: in_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(in_type.clone()),
            right_value_range: ValueRange::new(in_type.clone()),
            left_expr: Some(Box::new(int_vec2_literal_child(&mut state, 3, 5))),
            right_expr: Some(Box::new(int_vec2_literal_child(&mut state, 3, 9))),
        };
        ne.evaluate(&mgr, &mut ctx);
        // `NotEqual` combines with `||` - one differing component makes it true.
        assert!(ne.get_value().as_bool_at(0));

        let mut stream = TokenStream::new();
        eq.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert!(stream.tokens().contains(&Token::CmpEq));

        let mut ne_stream = TokenStream::new();
        ne.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut ne_stream);
        assert!(ne_stream.tokens().contains(&Token::CmpNe));
    }

    #[test]
    fn equality_comparison_op_create_next_child_builds_right_then_left_then_reports_done() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(2);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let bool_range = ValueRange::new(VariableType::new_basic(Type::Bool, 1));
        let mut eq = EqualityComparisonOp::new(EqualityOpKind::Equal, &mut state, &bool_range.as_const_access());

        assert!(eq.in_type.num_elements() >= 1 && eq.in_type.num_elements() <= 4);

        assert!(eq.right_expr.is_none());
        assert!(eq.create_next_child(&mut state, &mut mgr).is_some());
        assert!(eq.right_expr.is_some());
        assert!(eq.left_expr.is_none());
        assert!(eq.create_next_child(&mut state, &mut mgr).is_some());
        assert!(eq.left_expr.is_some());
        assert!(eq.create_next_child(&mut state, &mut mgr).is_none());
    }

    #[test]
    fn custom_abs_op_evaluate_takes_the_absolute_value() {
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let mut abs_neg = CustomAbsOp::wrap(Expression::Float(FloatLiteral::new_custom(-2.5)));
        abs_neg.evaluate(&mgr, &mut ctx);
        assert_eq!(abs_neg.get_value().as_float_at(0), 2.5);

        let mut abs_pos = CustomAbsOp::wrap(Expression::Float(FloatLiteral::new_custom(2.5)));
        abs_pos.evaluate(&mgr, &mut ctx);
        assert_eq!(abs_pos.get_value().as_float_at(0), 2.5);

        let mut stream = TokenStream::new();
        abs_neg.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens()[0], Token::identifier("abs"));
        assert!(stream.tokens().contains(&Token::LeftParen));
        assert!(stream.tokens().contains(&Token::RightParen));
    }

    #[test]
    fn custom_sub_and_less_than_op_evaluate_hand_computed_values() {
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        // 5.0 - 3.0 == 2.0
        let mut sub = CustomSubOp::new(
            Expression::Float(FloatLiteral::new_custom(5.0)),
            Expression::Float(FloatLiteral::new_custom(3.0)),
        );
        sub.evaluate(&mgr, &mut ctx);
        assert_eq!(sub.get_value().as_float_at(0), 2.0);

        // 0.5 < 1.0 is true, 1.0 < 0.5 is false.
        let mut lt_true = CustomLessThanOp::new(
            Expression::Float(FloatLiteral::new_custom(0.5)),
            Expression::Float(FloatLiteral::new_custom(1.0)),
        );
        lt_true.evaluate(&mgr, &mut ctx);
        assert!(lt_true.get_value().as_bool_at(0));

        let mut lt_false = CustomLessThanOp::new(
            Expression::Float(FloatLiteral::new_custom(1.0)),
            Expression::Float(FloatLiteral::new_custom(0.5)),
        );
        lt_false.evaluate(&mgr, &mut ctx);
        assert!(!lt_false.get_value().as_bool_at(0));

        let mut sub_stream = TokenStream::new();
        sub.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut sub_stream);
        assert!(sub_stream.tokens().contains(&Token::Minus));

        let mut lt_stream = TokenStream::new();
        lt_true.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut lt_stream);
        assert!(lt_stream.tokens().contains(&Token::CmpLt));
    }

    /// Directly constructs an `EqualityComparisonOp` with both children already set
    /// (bypassing the first two `create_next_child` calls, matching the technique
    /// `relational_op_create_next_child_wires_epsilon_add_only_for_float_less_or_equal_
    /// and_greater_or_equal` already uses to force a deterministic operand type) and
    /// checks the `CMP_EQ` rewrite fires *only* for `Equal` over an exactly float-scalar
    /// `in_type` - matching upstream's own `m_leftValueRange.getType() == floatType`
    /// exact-match guard, not merely "is float".
    #[test]
    fn equality_comparison_op_create_next_child_rewrites_only_equal_over_float_scalar() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(3);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let float_type = VariableType::new_basic(Type::Float, 1);
        let int_type = VariableType::new_basic(Type::Int, 1);
        let float_vec_type = VariableType::new_basic(Type::Float, 2);

        let make = |kind: EqualityOpKind, in_type: &VariableType| EqualityComparisonOp {
            kind,
            in_type: in_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(in_type.clone()),
            right_value_range: ValueRange::new(in_type.clone()),
            left_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(1.0)))),
            right_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(1.0)))),
        };

        // `Equal` + exactly float scalar: fires. The right child becomes `true` and the
        // left becomes a `ParenOp` wrapping the epsilon-corrected comparison.
        let mut eq_float = make(EqualityOpKind::Equal, &float_type);
        assert!(eq_float.create_next_child(&mut state, &mut mgr).is_none());
        assert!(matches!(eq_float.right_expr.as_deref(), Some(Expression::Bool(_))));
        assert!(matches!(eq_float.left_expr.as_deref(), Some(Expression::Paren(_))));

        // `NotEqual` + float scalar: `CMP_NE` never matches the upstream switch, so the
        // original literal children survive untouched.
        let mut ne_float = make(EqualityOpKind::NotEqual, &float_type);
        assert!(ne_float.create_next_child(&mut state, &mut mgr).is_none());
        assert!(matches!(ne_float.right_expr.as_deref(), Some(Expression::Float(_))));
        assert!(matches!(ne_float.left_expr.as_deref(), Some(Expression::Float(_))));

        // `Equal` + int scalar: fails the exact `floatType` match, untouched.
        let mut eq_int = make(EqualityOpKind::Equal, &int_type);
        assert!(eq_int.create_next_child(&mut state, &mut mgr).is_none());
        assert!(matches!(eq_int.right_expr.as_deref(), Some(Expression::Float(_))));

        // `Equal` + float *vector* (2 elements): fails the exact `(TYPE_FLOAT, 1)` match
        // too - only an exact scalar-float `in_type` fires the rewrite.
        let mut eq_float_vec = make(EqualityOpKind::Equal, &float_vec_type);
        assert!(eq_float_vec.create_next_child(&mut state, &mut mgr).is_none());
        assert!(matches!(eq_float_vec.right_expr.as_deref(), Some(Expression::Float(_))));
    }

    /// End-to-end: the rewritten tree still evaluates to the correct equality result,
    /// both when the two floats really are equal and when they are not - hand-computed
    /// per upstream's own replacement shape `((abs(lhs - (rhs)) < epsilon) == true)`.
    #[test]
    fn equality_comparison_op_evaluates_correctly_through_the_cmp_eq_rewrite() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(4);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let float_type = VariableType::new_basic(Type::Float, 1);
        let make = |a: f32, b: f32| EqualityComparisonOp {
            kind: EqualityOpKind::Equal,
            in_type: float_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(float_type.clone()),
            right_value_range: ValueRange::new(float_type.clone()),
            left_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(a)))),
            right_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(b)))),
        };

        // 2.0 == 2.0: |2.0 - 2.0| == 0.0 < 0.001, so the rewritten tree reports `true`.
        let mut eq_equal = make(2.0, 2.0);
        assert!(eq_equal.create_next_child(&mut state, &mut mgr).is_none());
        eq_equal.evaluate(&mgr, &mut ctx);
        assert!(eq_equal.get_value().as_bool_at(0));

        // 2.0 vs 2.1: |2.0 - 2.1| == 0.1, not < 0.001, so `false`.
        let mut eq_unequal = make(2.0, 2.1);
        assert!(eq_unequal.create_next_child(&mut state, &mut mgr).is_none());
        eq_unequal.evaluate(&mgr, &mut ctx);
        assert!(!eq_unequal.get_value().as_bool_at(0));
    }

    #[test]
    fn custom_abs_op_wraps_a_child_as_abs_and_tokenizes_with_function_call_syntax() {
        let mut op = CustomAbsOp::wrap(Expression::Float(FloatLiteral::new_custom(-3.5)));

        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        op.evaluate(&mgr, &mut ctx);
        assert!((op.get_value().as_float_at(0) - 3.5).abs() < 1e-6, "abs(-3.5) == 3.5");

        let mut stream = TokenStream::new();
        op.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[
                Token::identifier("abs"),
                Token::LeftParen,
                Token::FloatLiteral(-3.5),
                Token::RightParen
            ]
        );
    }

    #[test]
    fn custom_sub_op_subtracts_and_tokenizes_with_minus_and_no_parens() {
        let mut op = CustomSubOp::new(
            Expression::Float(FloatLiteral::new_custom(5.0)),
            Expression::Float(FloatLiteral::new_custom(2.0)),
        );

        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        op.evaluate(&mgr, &mut ctx);
        assert!((op.get_value().as_float_at(0) - 3.0).abs() < 1e-6, "5.0 - 2.0 == 3.0");

        let mut stream = TokenStream::new();
        op.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::FloatLiteral(5.0), Token::Minus, Token::FloatLiteral(2.0)]
        );
    }

    #[test]
    fn custom_less_than_op_compares_floats_and_tokenizes_with_cmp_lt() {
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let mut lt = CustomLessThanOp::new(
            Expression::Float(FloatLiteral::new_custom(1.0)),
            Expression::Float(FloatLiteral::new_custom(2.0)),
        );
        lt.evaluate(&mgr, &mut ctx);
        assert!(lt.get_value().as_bool_at(0), "1.0 < 2.0");

        let mut ge = CustomLessThanOp::new(
            Expression::Float(FloatLiteral::new_custom(3.0)),
            Expression::Float(FloatLiteral::new_custom(2.0)),
        );
        ge.evaluate(&mgr, &mut ctx);
        assert!(!ge.get_value().as_bool_at(0), "3.0 is not < 2.0");

        let mut stream = TokenStream::new();
        lt.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(
            stream.tokens(),
            &[Token::FloatLiteral(1.0), Token::CmpLt, Token::FloatLiteral(2.0)]
        );
    }

    /// `EqualityComparisonOp::create_next_child`'s own `CMP_EQ` corner-case rewrite
    /// (`CustomAbsOp`/`CustomSubOp`/`CustomLessThanOp`), exercised end to end: each
    /// `EqualityComparisonOp` is built directly with its fields set (same style as
    /// `relational_op_create_next_child_wires_epsilon_add_only_for_float_less_or_equal_and_greater_or_equal`
    /// above), since hitting the scalar-float `Equal` case through `new`'s own random
    /// operand-type/width choice is not reliable.
    #[test]
    fn equality_comparison_op_create_next_child_rewrites_equal_float_scalar_into_the_epsilon_corrected_tree() {
        let program_params = ProgramParameters {
            use_comparison_ops: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(3);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let float_type = VariableType::new_basic(Type::Float, 1);
        let vec_type = VariableType::new_basic(Type::Float, 2);

        let make = |kind: EqualityOpKind, operand_type: &VariableType, lhs: f32, rhs: f32| EqualityComparisonOp {
            kind,
            in_type: operand_type.clone(),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            left_value_range: ValueRange::new(operand_type.clone()),
            right_value_range: ValueRange::new(operand_type.clone()),
            left_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(lhs)))),
            right_expr: Some(Box::new(Expression::Float(FloatLiteral::new_custom(rhs)))),
        };

        // Within epsilon (0.001): abs(1.0 - 1.0001) == 0.0001 < 0.001.
        let mut close = make(EqualityOpKind::Equal, &float_type, 1.0, 1.0001);
        assert!(close.create_next_child(&mut state, &mut mgr).is_none());
        assert!(
            matches!(close.left_expr.as_deref(), Some(Expression::Paren(_))),
            "left_expr is rewritten to the paren-wrapped comparison"
        );
        assert!(
            matches!(close.right_expr.as_deref(), Some(Expression::Bool(_))),
            "right_expr is rewritten to the bool(true) literal"
        );
        close.evaluate(&mgr, &mut ctx);
        assert!(close.get_value().as_bool_at(0), "0.0001 is within the 0.001 epsilon");

        let mut close_stream = TokenStream::new();
        close.tokenize(&mgr, Version::Version100, ShaderType::Vertex, &mut close_stream);
        // `(abs(lhs - (rhs)) < 0.001) == true` - exactly one `ParenOp` (`parenOperation`,
        // wrapping the `<` comparison) plus the inner one around the original
        // right-hand side (`parenRight`); nothing wraps the top-level equality itself,
        // confirmed by tracing `ParenOp`/`CustomAbsOp`/`CustomSubOp`/`CustomLessThanOp`'s
        // own `tokenize` bodies rather than trusting upstream's own comment at the call
        // site literally (that comment shows a doubled leading paren,
        // `"((abs(lhs-rhs) < epsilon) == true)"`, which is informal grouping for a
        // reader, not a literal token count - nothing in the real `switch` case builds a
        // second, outer `ParenOp`).
        assert_eq!(
            close_stream.tokens(),
            &[
                Token::LeftParen,
                Token::identifier("abs"),
                Token::LeftParen,
                Token::FloatLiteral(1.0),
                Token::Minus,
                Token::LeftParen,
                Token::FloatLiteral(1.0001),
                Token::RightParen,
                Token::RightParen,
                Token::CmpLt,
                Token::FloatLiteral(0.001),
                Token::RightParen,
                Token::CmpEq,
                Token::BoolLiteral(true),
            ]
        );

        // Outside epsilon: abs(1.0 - 1.1) == 0.1 >= 0.001.
        let mut far = make(EqualityOpKind::Equal, &float_type, 1.0, 1.1);
        assert!(far.create_next_child(&mut state, &mut mgr).is_none());
        far.evaluate(&mgr, &mut ctx);
        assert!(!far.get_value().as_bool_at(0), "0.1 is outside the 0.001 epsilon");

        // `NotEqual` never matches the switch's `CMP_EQ` case, even for a scalar float.
        let mut ne = make(EqualityOpKind::NotEqual, &float_type, 1.0, 1.0);
        assert!(ne.create_next_child(&mut state, &mut mgr).is_none());
        assert!(
            matches!(ne.left_expr.as_deref(), Some(Expression::Float(_))),
            "NotEqual's left operand is left untouched"
        );
        assert!(
            matches!(ne.right_expr.as_deref(), Some(Expression::Float(_))),
            "NotEqual's right operand is left untouched"
        );

        // A vector operand is never rewritten either, even for `Equal` - matches
        // upstream's exact-type guard (`VariableType(TYPE_FLOAT, 1)`, not just "float").
        let mut vec_eq = make(EqualityOpKind::Equal, &vec_type, 1.0, 1.0);
        assert!(vec_eq.create_next_child(&mut state, &mut mgr).is_none());
        assert!(
            matches!(vec_eq.left_expr.as_deref(), Some(Expression::Float(_))),
            "a vector operand is left untouched"
        );
    }

    fn vec4_out_range() -> ValueRange {
        let mut r = ValueRange::new(VariableType::new_basic(Type::Float, 4));
        for ndx in 0..4 {
            let mut access = r.as_access();
            let mut comp = access.component(ndx);
            comp.get_min().set_float(0.0);
            comp.get_max().set_float(1.0);
        }
        r
    }

    #[test]
    fn tex_lookup_constructor_picks_a_2d_kind_and_allocates_a_uniform_sampler_when_only_2d_enabled() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            use_texture_2d: true,
            use_texture_cube: false,
            ..ShaderParameters::default()
        };
        let range = vec4_out_range();

        for seed in 0..20 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut alloc = NameAllocator::new();
            let mut mgr = new_var_manager(&mut alloc);

            let tex = TexLookup::new(&mut state, &mut mgr, &range.as_const_access());
            assert_eq!(tex.kind.sampler_base_type(), Type::Sampler2D, "seed {seed}");
            assert_eq!(
                mgr.get_variable(tex.sampler).get_storage(),
                Storage::Uniform,
                "seed {seed}"
            );
            assert_eq!(
                *mgr.get_variable(tex.sampler).get_type(),
                VariableType::new_basic(Type::Sampler2D, 1),
                "seed {seed}"
            );
        }
    }

    #[test]
    fn tex_lookup_constructor_reuses_an_existing_sampler_instead_of_always_allocating() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            use_texture_2d: true,
            use_texture_cube: false,
            max_samplers: 1,
            ..ShaderParameters::default()
        };
        let range = vec4_out_range();

        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        // `max_samplers == 1`, so once one sampler exists, `can_alloc_sampler` is false
        // and every further `TexLookup` must reuse the existing one.
        let first = TexLookup::new(&mut state, &mut mgr, &range.as_const_access());
        for seed in 0..20 {
            let mut random = Random::new(seed + 100);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let tex = TexLookup::new(&mut state, &mut mgr, &range.as_const_access());
            assert_eq!(tex.sampler, first.sampler, "seed {seed}");
        }
    }

    #[test]
    fn tex_lookup_get_weight_respects_base_weight_depth_budget_and_output_range() {
        let shader_params = ShaderParameters {
            tex_lookup_base_weight: 1.0,
            max_expression_depth: 5,
            ..ShaderParameters::default()
        };
        let range = vec4_out_range();

        let disabled_params = ProgramParameters::default();
        let disabled_shader_params = ShaderParameters {
            tex_lookup_base_weight: 0.0,
            ..shader_params.clone()
        };
        let mut random = Random::new(1);
        let state = new_state_with_budget(&disabled_params, &disabled_shader_params, &mut random);
        assert_eq!(TexLookup::get_weight(&state, &range.as_const_access()), 0.0);

        let program_params = ProgramParameters::default();
        let mut random2 = Random::new(1);
        let mut state2 = new_state_with_budget(&program_params, &shader_params, &mut random2);
        assert_eq!(TexLookup::get_weight(&state2, &range.as_const_access()), 1.0);

        // Not enough depth budget (needs Lookup + Constructor + Values, i.e. >= 3).
        state2.set_expression_depth(3);
        assert_eq!(TexLookup::get_weight(&state2, &range.as_const_access()), 0.0);
        state2.set_expression_depth(0);

        // CONST_EXPR/NO_VAR_ALLOCATION both disqualify it.
        state2.push_expression_flags(CONST_EXPR);
        assert_eq!(TexLookup::get_weight(&state2, &range.as_const_access()), 0.0);
        state2.pop_expression_flags();

        // Only an exactly-vec4 range asking for (a superset of) [0,1]^4 is accepted.
        let int_range = ValueRange::new(VariableType::new_basic(Type::Int, 4));
        assert_eq!(TexLookup::get_weight(&state2, &int_range.as_const_access()), 0.0);

        let mut narrower = ValueRange::new(VariableType::new_basic(Type::Float, 4));
        for ndx in 0..4 {
            let mut access = narrower.as_access();
            let mut comp = access.component(ndx);
            comp.get_min().set_float(0.25);
            comp.get_max().set_float(0.75);
        }
        assert_eq!(
            TexLookup::get_weight(&state2, &narrower.as_const_access()),
            0.0,
            "a range that isn't a superset of [0,1]^4 must be rejected"
        );
    }

    #[test]
    fn tex_lookup_create_next_child_builds_lod_before_coord_when_the_kind_has_one() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            use_texture_2d: true,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let sampler = mgr.allocate(VariableType::new_basic(Type::Sampler2D, 1));
        mgr.set_storage(sampler, Storage::Uniform);

        let mut tex = TexLookup {
            kind: TexLookupKind::Texture2DLod,
            sampler,
            coord_expr: None,
            lod_bias_expr: None,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        };

        assert!(tex.lod_bias_expr.is_none());
        assert!(tex.create_next_child(&mut state, &mut mgr).is_some());
        assert!(tex.lod_bias_expr.is_some(), "lod must be built first for a *Lod kind");
        assert!(tex.coord_expr.is_none());
        assert!(tex.create_next_child(&mut state, &mut mgr).is_some());
        assert!(tex.coord_expr.is_some());
        assert!(tex.create_next_child(&mut state, &mut mgr).is_none());
    }

    #[test]
    fn tex_lookup_create_next_child_builds_only_coord_when_the_kind_has_no_lod() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            use_texture_2d: true,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let sampler = mgr.allocate(VariableType::new_basic(Type::Sampler2D, 1));
        mgr.set_storage(sampler, Storage::Uniform);

        let mut tex = TexLookup {
            kind: TexLookupKind::Texture2D,
            sampler,
            coord_expr: None,
            lod_bias_expr: None,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        };

        assert!(tex.create_next_child(&mut state, &mut mgr).is_some());
        assert!(tex.coord_expr.is_some());
        assert!(
            tex.lod_bias_expr.is_none(),
            "a non-Lod kind never builds a lod/bias child"
        );
        assert!(tex.create_next_child(&mut state, &mut mgr).is_none());
    }

    fn solid_color_2d_texture(color: [f32; 4]) -> crate::tcu::texture_2d::Texture2D {
        use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut texture = crate::tcu::texture_2d::Texture2D::new(format, 1, 1);
        texture.alloc_level(0);
        texture.level_mut(0).set_pixel(color, 0, 0, 0);
        texture
    }

    fn nearest_clamp_sampler() -> crate::tcu::pixel::Sampler {
        use crate::tcu::pixel::{CompareMode, FilterMode, WrapMode};
        crate::tcu::pixel::Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        }
    }

    #[test]
    fn tex_lookup_evaluate_samples_the_bound_texture_and_tokenize_emits_the_right_function_name() {
        use crate::rsg::samplers::Sampler2D;

        let texture = solid_color_2d_texture([0.25, 0.5, 0.75, 1.0]);
        let rsg_sampler = Sampler2D::new(&texture, nearest_clamp_sampler());
        let mut samplers_2d: Sampler2DMap = HashMap::new();
        samplers_2d.insert(0, rsg_sampler);
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&samplers_2d, &empty_cube);

        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let sampler_type = VariableType::new_basic(Type::Sampler2D, 1);
        let sampler = mgr.allocate(sampler_type.clone());
        mgr.set_storage(sampler, Storage::Uniform);
        // Bind this sampler variable to index 0 of `samplers_2d` above.
        ctx.get_value(sampler, &sampler_type).set_int_at(0, 0);

        // `vec2(0.5, 0.5)` built directly (same "set `ConstructorOp`'s own private
        // `input_expressions` field by hand, in reverse order" trick
        // `int_vec2_literal_child` elsewhere in this file uses) - bypasses
        // `create_random`'s dispatch entirely, so this is not exposed to the
        // `VariableRead`-has-no-concrete-value gap documented elsewhere in this file.
        let coord_expr = Expression::Constructor(ConstructorOp {
            value_range: ValueRange::new(VariableType::new_basic(Type::Float, 2)),
            value: ValueStorage::new(EXEC_VEC_WIDTH),
            input_value_ranges: Vec::new(),
            input_expressions: vec![
                Expression::Float(FloatLiteral::new_custom(0.5)),
                Expression::Float(FloatLiteral::new_custom(0.5)),
            ],
        });

        let mut tex = TexLookup {
            kind: TexLookupKind::Texture2D,
            sampler,
            coord_expr: Some(Box::new(coord_expr)),
            lod_bias_expr: None,
            value: ValueStorage::new(EXEC_VEC_WIDTH),
        };

        tex.evaluate(&mgr, &mut ctx);
        let value = tex.get_value();
        assert!((value.component(0).as_float_at(0) - 0.25).abs() < 0.02);
        assert!((value.component(1).as_float_at(0) - 0.5).abs() < 0.02);
        assert!((value.component(2).as_float_at(0) - 0.75).abs() < 0.02);
        assert!((value.component(3).as_float_at(0) - 1.0).abs() < 0.02);

        let mut es3_stream = TokenStream::new();
        tex.tokenize(&mgr, Version::Version300, ShaderType::Fragment, &mut es3_stream);
        assert_eq!(es3_stream.tokens()[0], Token::Identifier("texture".to_string()));

        let mut es2_stream = TokenStream::new();
        tex.tokenize(&mgr, Version::Version100, ShaderType::Fragment, &mut es2_stream);
        assert_eq!(es2_stream.tokens()[0], Token::Identifier("texture2D".to_string()));
    }
}
