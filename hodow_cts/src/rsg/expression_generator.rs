// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgExpressionGenerator.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Two upstream pieces land here together, because they are two halves of one
// mechanism: `Expression::createRandom`/`createRandomLValue` (`rsgExpression.cpp`'s own
// `chooseExpression`/`s_expressionSpecs`/`s_lvalueSpecs`) and `ExpressionGenerator`
// (`rsgExpressionGenerator.hpp`/`.cpp`, 53+87 lines, the driver that walks a whole tree
// to completion via repeated `createNextChild` calls).
//
// **`create_random`'s dispatch table now covers all 30 of upstream's real
// `s_expressionSpecs` entries** (see the function's own doc comment below for the exact
// list; a previous pass here had both miscounted this as 29 and left `SwizzleOp`/
// `ParenOp`/`TexLookup` in a different relative order than upstream's own table -
// fixed, see that doc comment for the correction). `Equal`'s own `CMP_EQ` epsilon-correction corner case
// (`rsg::expression::EqualityComparisonOp`'s own doc comment) is ported too now, closing
// what used to be the last algorithm-level gap anywhere in the whole `rsgExpression`/
// `rsgBinaryOps`/`rsgBuiltinFunctions` cluster. This still does not make tree generation
// bit-reproducible against a real `deqp` run - the weighted *choice* among kinds is
// right, but plenty of individual algorithms still diverge in documented ways (every
// `Unverified`-shaped gap named across `rsg::expression`'s own doc comments) - but the
// "can only ever pick among what exists" bias this comment used to describe is gone.
// `create_random_lvalue` has no such caveat - upstream's own `s_lvalueSpecs` has
// exactly one entry (`VariableWrite`) permanently, so this one is already complete.
//
// **`ExpressionGenerator`'s explicit `Vec<Expression*>` stack became plain recursion**
// (`generate_children`) - not a style preference but the direct consequence of this
// port's own ownership shape. Upstream's stack holds non-owning raw pointers into
// whichever parent node owns each `Expression`, which is exactly the "stack of
// differently-lived nested mutable borrows" shape Rust's borrow checker cannot express
// safely (each level would need a `&mut Expression` borrowed from the previous level's
// own `Box` field, with every ancestor's borrow kept alive the whole time its
// descendant's is). Since a `ParenOp` *owns* its child by value (`Box<Expression>`),
// there is no aliasing to manage at all once the walk is expressed as recursion instead
// of an explicit stack: reading the real loop in `rsgExpressionGenerator.cpp` confirms
// it is already a textbook depth-first walk (process the stack's own top, i.e. the
// deepest unfinished node, until it reports no more children, then back up) - exactly
// what a recursive call expresses directly, with the call stack standing in for the
// `Vec`. Hand-traced against the real loop's own depth increments/decrements (the
// `DE_ASSERT(m_state.getExpressionDepth() <= maxExpressionDepth)` invariant each
// `getWeight` downstream relies on) to confirm the two are equivalent - see
// `generate_expression`'s own doc comment for the trace.

use super::builtin_functions::{BuiltinFunctionKind, BuiltinFunctionOp};
use super::expression::{
    AssignOp, BinaryOp, BinaryOpKind, BoolLiteral, ConstructorOp, EqualityComparisonOp, EqualityOpKind, Expression,
    FloatLiteral, IntLiteral, ParenOp, RelationalOp, RelationalOpKind, SwizzleOp, TexLookup, VariableRead,
    VariableWrite,
};
use super::generator_state::GeneratorState;
use super::variable_manager::VariableManager;
use super::variable_value::{ConstValueRangeAccess, ValueRange};

#[derive(Clone, Copy)]
enum ExpressionKind {
    Float,
    Int,
    Bool,
    Constructor,
    Assign,
    VariableRead,
    Mul,
    Add,
    Sub,
    LessThan,
    LessOrEqual,
    GreaterThan,
    GreaterOrEqual,
    Equal,
    NotEqual,
    Builtin(BuiltinFunctionKind),
    Swizzle,
    TexLookup,
    Paren,
}

/// `rsg::Expression::createRandom`/`chooseExpression`/`s_expressionSpecs` - **complete**,
/// all 30 of upstream's real `s_expressionSpecs` entries (re-counted directly off
/// `rsgExpression.cpp`'s own table by counting its `create<...>` entries one by one -
/// the "29" an earlier pass here claimed was a miscount), in the exact same order
/// upstream's own table lists them:
/// `FloatLiteral`/`IntLiteral`/`BoolLiteral`/`ConstructorOp`/`AssignOp`/`VariableRead`/
/// `MulOp`/`AddOp`/`SubOp`/`LessThanOp`/`LessOrEqualOp`/
/// `GreaterThanOp`/`GreaterOrEqualOp`/`EqualOp`/`NotEqualOp`/`SwizzleOp`/the 12
/// `rsgBuiltinFunctions` kinds (`Sin`/`Cos`/`Tan`/`Asin`/`Acos`/`Atan`/`Exp`/`Log`/
/// `Exp2`/`Log2`/`Sqrt`/`InvSqrt`, all ported in full - see `rsg::builtin_functions`)/
/// `ParenOp`/`TexLookup`. **The order itself does not change which items `Random::
/// choose_weighted` can ever return or with what probability** (a textbook cumulative-
/// weight walk: the same weights in any order partition `[0, weight_sum)` into the same
/// set of interval *lengths*, just assigned to different sub-ranges of it) - but it does
/// change which interval a given raw draw lands in, and this project already disclaims
/// bit-exact reproducibility against a real `deqp` run (see this module's own top doc
/// comment) regardless. Fixed anyway, for the same reason as everywhere else in this
/// port: "same operation order" is part of what keeping upstream's shape means, and a
/// `kinds`/`weights` array that silently drifts from its own doc comment's claimed order
/// is exactly the kind of staleness this effort keeps finding and correcting elsewhere.
/// (An earlier version of this array had `SwizzleOp` positioned after the 12 builtin
/// kinds instead of before them, and `TexLookup` before `ParenOp` instead of after -
/// both now match upstream's own table exactly.)
pub fn create_random(
    state: &mut GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
    value_range: &ConstValueRangeAccess<'_>,
) -> Expression {
    let kinds = [
        ExpressionKind::Float,
        ExpressionKind::Int,
        ExpressionKind::Bool,
        ExpressionKind::Constructor,
        ExpressionKind::Assign,
        ExpressionKind::VariableRead,
        ExpressionKind::Mul,
        ExpressionKind::Add,
        ExpressionKind::Sub,
        ExpressionKind::LessThan,
        ExpressionKind::LessOrEqual,
        ExpressionKind::GreaterThan,
        ExpressionKind::GreaterOrEqual,
        ExpressionKind::Equal,
        ExpressionKind::NotEqual,
        ExpressionKind::Swizzle,
        ExpressionKind::Builtin(BuiltinFunctionKind::Sin),
        ExpressionKind::Builtin(BuiltinFunctionKind::Cos),
        ExpressionKind::Builtin(BuiltinFunctionKind::Tan),
        ExpressionKind::Builtin(BuiltinFunctionKind::Asin),
        ExpressionKind::Builtin(BuiltinFunctionKind::Acos),
        ExpressionKind::Builtin(BuiltinFunctionKind::Atan),
        ExpressionKind::Builtin(BuiltinFunctionKind::Exp),
        ExpressionKind::Builtin(BuiltinFunctionKind::Log),
        ExpressionKind::Builtin(BuiltinFunctionKind::Exp2),
        ExpressionKind::Builtin(BuiltinFunctionKind::Log2),
        ExpressionKind::Builtin(BuiltinFunctionKind::Sqrt),
        ExpressionKind::Builtin(BuiltinFunctionKind::InvSqrt),
        ExpressionKind::Paren,
        ExpressionKind::TexLookup,
    ];
    let weights = [
        FloatLiteral::get_weight(state, value_range),
        IntLiteral::get_weight(state, value_range),
        BoolLiteral::get_weight(state, value_range),
        ConstructorOp::get_weight(state, value_range),
        AssignOp::get_weight(state, var_manager, value_range),
        VariableRead::get_weight(state, var_manager, value_range),
        BinaryOp::get_weight(BinaryOpKind::Mul, state, value_range),
        BinaryOp::get_weight(BinaryOpKind::Add, state, value_range),
        BinaryOp::get_weight(BinaryOpKind::Sub, state, value_range),
        RelationalOp::get_weight(RelationalOpKind::LessThan, state, value_range),
        RelationalOp::get_weight(RelationalOpKind::LessOrEqual, state, value_range),
        RelationalOp::get_weight(RelationalOpKind::GreaterThan, state, value_range),
        RelationalOp::get_weight(RelationalOpKind::GreaterOrEqual, state, value_range),
        EqualityComparisonOp::get_weight(EqualityOpKind::Equal, state, value_range),
        EqualityComparisonOp::get_weight(EqualityOpKind::NotEqual, state, value_range),
        SwizzleOp::get_weight(state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sin, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Cos, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Tan, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Asin, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Acos, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Atan, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Exp, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Log, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Exp2, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Log2, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::Sqrt, state, value_range),
        BuiltinFunctionOp::get_weight(BuiltinFunctionKind::InvSqrt, state, value_range),
        ParenOp::get_weight(state, value_range),
        TexLookup::get_weight(state, value_range),
    ];

    match *state.get_random().choose_weighted(&kinds, &weights) {
        ExpressionKind::Float => Expression::Float(FloatLiteral::new_random(state, value_range)),
        ExpressionKind::Int => Expression::Int(IntLiteral::new_random(state, value_range)),
        ExpressionKind::Bool => Expression::Bool(BoolLiteral::new_random(state, value_range)),
        ExpressionKind::Constructor => Expression::Constructor(ConstructorOp::new(state, value_range)),
        ExpressionKind::Assign => Expression::Assign(AssignOp::new(state, var_manager, value_range)),
        ExpressionKind::VariableRead => {
            Expression::VariableRead(VariableRead::new_random(state, var_manager, value_range))
        }
        ExpressionKind::Mul => Expression::Binary(BinaryOp::new(BinaryOpKind::Mul, state, value_range)),
        ExpressionKind::Add => Expression::Binary(BinaryOp::new(BinaryOpKind::Add, state, value_range)),
        ExpressionKind::Sub => Expression::Binary(BinaryOp::new(BinaryOpKind::Sub, state, value_range)),
        ExpressionKind::LessThan => {
            Expression::Relational(RelationalOp::new(RelationalOpKind::LessThan, state, value_range))
        }
        ExpressionKind::LessOrEqual => {
            Expression::Relational(RelationalOp::new(RelationalOpKind::LessOrEqual, state, value_range))
        }
        ExpressionKind::GreaterThan => {
            Expression::Relational(RelationalOp::new(RelationalOpKind::GreaterThan, state, value_range))
        }
        ExpressionKind::GreaterOrEqual => {
            Expression::Relational(RelationalOp::new(RelationalOpKind::GreaterOrEqual, state, value_range))
        }
        ExpressionKind::Equal => {
            Expression::Equality(EqualityComparisonOp::new(EqualityOpKind::Equal, state, value_range))
        }
        ExpressionKind::NotEqual => {
            Expression::Equality(EqualityComparisonOp::new(EqualityOpKind::NotEqual, state, value_range))
        }
        ExpressionKind::Builtin(kind) => Expression::Builtin(BuiltinFunctionOp::new(state, kind, value_range)),
        ExpressionKind::Swizzle => Expression::Swizzle(SwizzleOp::new(state, value_range)),
        ExpressionKind::TexLookup => Expression::TexLookup(TexLookup::new(state, var_manager, value_range)),
        ExpressionKind::Paren => Expression::Paren(ParenOp::new(ValueRange::from_access(value_range))),
    }
}

/// `rsg::Expression::createRandomLValue`/`s_lvalueSpecs` - exactly one entry upstream,
/// permanently (no other ported or unported `Expression` kind is ever an l-value), so
/// unlike `create_random` this is already complete. The single-entry
/// `choose_weighted` call is kept rather than skipped, to consume the same one random
/// draw upstream's own `chooseWeighted` always does, even with only one choice.
pub fn create_random_lvalue(
    state: &mut GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
    value_range: &ConstValueRangeAccess<'_>,
) -> Expression {
    let kinds = [()];
    let weights = [VariableWrite::get_weight(state, var_manager, value_range)];
    let _ = state.get_random().choose_weighted(&kinds, &weights);

    Expression::VariableWrite(VariableWrite::new(state, var_manager, value_range))
}

/// `rsg::ExpressionGenerator::generate` (the public, two-argument overload) - builds a
/// complete, random `Expression` tree rooted at a freshly-chosen node for `value_range`,
/// then recursively fills in every descendant via `create_next_child` until none remain.
///
/// Depth bookkeeping, traced against upstream's own loop to confirm this recursive
/// shape produces identical `GeneratorState::expressionDepth` values at every
/// `getWeight`/`createNextChild` call site: upstream sets `expressionDepth =
/// initialDepth`, creates the root (so the root's own `getWeight` sees `initialDepth`),
/// then increments once more before its loop starts (children of the root are created
/// at `initialDepth + 1`), and the loop's own increment/decrement is paired exactly
/// around each push/pop - which `generate_children` reproduces with an increment right
/// before recursing into a newly-created child and a decrement right after that
/// recursive call returns (i.e. once the *entire* subtree under that child, not just
/// the child itself, is finished - matching "pop only happens once createNextChild
/// returns `None`" exactly). The one place this recursive shape does not fall out
/// automatically is the very end: upstream's loop finishes by popping the root itself,
/// which decrements depth one final time back to `initialDepth` - `generate_children`
/// has no equivalent "pop the thing I was called with" step of its own, so
/// `generate_expression` restores `initialDepth` explicitly after `generate_children`
/// returns, rather than leave it one level too deep.
pub fn generate_expression(
    state: &mut GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
    value_range: &ConstValueRangeAccess<'_>,
    initial_depth: i32,
) -> Expression {
    state.set_expression_depth(initial_depth);
    let mut root = create_random(state, var_manager, value_range);

    state.set_expression_depth(initial_depth + 1);
    generate_children(&mut root, state, var_manager);
    state.set_expression_depth(initial_depth);

    root
}

fn generate_children(expr: &mut Expression, state: &mut GeneratorState<'_>, var_manager: &mut VariableManager<'_>) {
    while let Some(child) = expr.create_next_child(state, var_manager) {
        debug_assert!(state.get_expression_depth() <= state.get_shader_parameters().max_expression_depth);
        state.set_expression_depth(state.get_expression_depth() + 1);
        generate_children(child, state, var_manager);
        state.set_expression_depth(state.get_expression_depth() - 1);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::{ProgramParameters, ShaderParameters};
    use crate::rsg::variable_manager::{ValueScope, VariableScope};
    use crate::rsg::variable_type::{Type, VariableType};
    use crate::tcu::random::Random;

    fn new_state_and_manager<'a>(
        program_params: &'a ProgramParameters,
        shader_params: &'a ShaderParameters,
        random: &'a mut Random,
        alloc: &'a mut NameAllocator,
    ) -> (GeneratorState<'a>, VariableManager<'a>) {
        let mut state = GeneratorState::new(program_params, random);
        state.set_shader_parameters(shader_params);
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        (state, mgr)
    }

    #[test]
    fn create_random_produces_a_usable_expression_for_an_int_range() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut alloc = NameAllocator::new();
        let (mut state, mut mgr) = new_state_and_manager(&program_params, &shader_params, &mut random, &mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(-5);
        range.get_max().set_int(5);

        for _ in 0..20 {
            let expr = create_random(&mut state, &mut mgr, &range.as_const_access());
            // Whichever kind won, its own value must already be well-formed (no panic)
            // even before any `create_next_child` walk - every currently-ported kind's
            // constructor fully initializes its own value.
            match &expr {
                Expression::Int(l) => assert!((-5..=5).contains(&l.get_value().as_int_at(0))),
                Expression::VariableRead(_)
                | Expression::Paren(_)
                | Expression::Assign(_)
                | Expression::Constructor(_)
                | Expression::Binary(_)
                | Expression::Relational(_) => {} // Checked via generate_expression below instead.
                _ => panic!("an Int value_range should never pick a Float/Bool literal"),
            }
        }
    }

    #[test]
    fn create_random_lvalue_always_yields_a_variable_write() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(2);
        let mut alloc = NameAllocator::new();
        let (mut state, mut mgr) = new_state_and_manager(&program_params, &shader_params, &mut random, &mut alloc);

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 1));
        range.get_min().set_float(0.0);
        range.get_max().set_float(1.0);

        let expr = create_random_lvalue(&mut state, &mut mgr, &range.as_const_access());
        assert!(matches!(expr, Expression::VariableWrite(_)));
    }

    #[test]
    fn generate_expression_builds_a_fully_resolved_tree_and_restores_the_initial_depth() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut alloc = NameAllocator::new();

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(-3);
        range.get_max().set_int(3);

        for seed in 0..30 {
            let mut random = Random::new(seed);
            let (mut state, mut mgr) = new_state_and_manager(&program_params, &shader_params, &mut random, &mut alloc);

            let mut tree = generate_expression(&mut state, &mut mgr, &range.as_const_access(), 0);
            // The whole point of the depth bookkeeping: after a full build, depth must
            // be back at its starting point, not left one or more levels too deep.
            assert_eq!(state.get_expression_depth(), 0, "seed {seed}");

            // A fully-built tree must evaluate and report a value without panicking,
            // regardless of how deeply `ParenOp` nested itself.
            //
            // **Deliberately not asserted: that the resulting value actually lies
            // within `range`.** Found by hand-tracing a genuine failure at seed 2
            // (`int(int(-8)) - d - (-3)` evaluating to `-5`, outside `[-3, 3]`): `d` is
            // a `VariableRead` of a freshly-allocated variable that nothing in this
            // standalone tree ever assigns a concrete value to, so `ExecutionContext`
            // reads back its untouched default (`0`), not a value actually drawn from
            // whatever range `VariableManager`'s own bookkeeping tracked for it. That
            // bookkeeping is a promise the *real* generator keeps by populating every
            // declared variable's concrete value via `computeUniformValues`
            // (`rsg::utils::compute_uniform_values`, ported now, but only ever called
            // from a real `Shader`'s own uniforms - see that function's own doc
            // comment) before a shader ever executes; a lone tree built and evaluated
            // by itself, the way this test does, has no `Shader` around it to drive
            // that call in the first place. This is a gap in what this test can check,
            // not a bug in `BinaryOp`/`ConstructorOp`/`VariableRead` - each was
            // independently hand-verified against upstream's own range-splitting
            // formulas in their own dedicated unit tests, which build every child by
            // hand and so never hit this gap.
            let empty_2d: crate::rsg::samplers::Sampler2DMap = std::collections::HashMap::new();
            let empty_cube: crate::rsg::samplers::SamplerCubeMap = std::collections::HashMap::new();
            let mut ctx = crate::rsg::execution_context::ExecutionContext::new(&empty_2d, &empty_cube);
            tree.evaluate(&mgr, &mut ctx);
            let _ = tree.get_value(&mgr, &mut ctx).as_int_at(0); // Must not panic.

            let mut stream = crate::rsg::token::TokenStream::new();
            tree.tokenize(
                &mgr,
                crate::rsg::parameters::Version::Version100,
                crate::rsg::variable::ShaderType::Vertex,
                &mut stream,
            );
            assert!(!stream.is_empty(), "seed {seed}");
        }
    }

    #[test]
    fn generate_expression_never_exceeds_the_configured_depth_budget() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_expression_depth: 2,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();

        let mut range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
        range.get_min().set_int(-3);
        range.get_max().set_int(3);

        // A tight depth budget makes `ParenOp::getWeight` refuse once nesting would
        // exceed it (confirmed by `rsg::expression`'s own `paren_op_get_weight_...`
        // test) - this just confirms the generator-level invariant holds across many
        // random trees, not any one specific shape.
        for seed in 0..30 {
            let mut random = Random::new(seed);
            let (mut state, mut mgr) = new_state_and_manager(&program_params, &shader_params, &mut random, &mut alloc);
            generate_expression(&mut state, &mut mgr, &range.as_const_access(), 0);
            assert_eq!(state.get_expression_depth(), 0, "seed {seed}");
        }
    }

    /// Confirms `TexLookup` is now actually reachable from `create_random`'s weighted
    /// dispatch, not just independently constructible (`rsg::expression`'s own tests
    /// only ever build it directly) - the whole point of wiring it in. A high
    /// `tex_lookup_base_weight` with `use_texture_2d` enabled and a `vec4` range that is
    /// a superset of `[0,1]^4` makes `TexLookup::get_weight` return a large positive
    /// number, so across enough seeds at least one draw must pick it.
    #[test]
    fn create_random_can_produce_a_tex_lookup_once_its_base_weight_is_enabled() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            tex_lookup_base_weight: 1000.0,
            use_texture_2d: true,
            max_expression_depth: 5,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();

        let mut range = ValueRange::new(VariableType::new_basic(Type::Float, 4));
        for ndx in 0..4 {
            let mut access = range.as_access();
            let mut comp = access.component(ndx);
            comp.get_min().set_float(0.0);
            comp.get_max().set_float(1.0);
        }

        let mut saw_tex_lookup = false;
        for seed in 0..20 {
            let mut random = Random::new(seed);
            let (mut state, mut mgr) = new_state_and_manager(&program_params, &shader_params, &mut random, &mut alloc);
            let expr = create_random(&mut state, &mut mgr, &range.as_const_access());
            if matches!(expr, Expression::TexLookup(_)) {
                saw_tex_lookup = true;
                break;
            }
        }
        assert!(
            saw_tex_lookup,
            "TexLookup should be reachable from create_random with a high enough base weight"
        );
    }
}
