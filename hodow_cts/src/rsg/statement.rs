// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgStatement.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **All five upstream `Statement` kinds are now ported**: `ExpressionStatement`/
// `AssignStatement`/`DeclarationStatement` (see the history below - these were ported
// in an earlier pass, before the statement stack existed at all) plus `BlockStatement`/
// `ConditionalStatement`, the two upstream explicitly built the statement stack for.
// `IfStatement`/`ForLoopStatement`/`WhileStatement`/`DoWhileStatement` stay unported -
// they are only ever sketched as comments in `rsgStatement.hpp`, with no `.cpp` body
// anywhere in `framework/randomshaders/`, confirmed unimplemented upstream too, not a
// gap this port left.
//
// ## The statement stack: `StatementArena`/`StatementId`, not a `Vec<Statement*>`
//
// Upstream's statement stack (`GeneratorState::m_statementStack`, a
// `std::vector<Statement*>*`) is a vector of *non-owning* raw pointers into whichever
// `Statement` actually owns each node - `FunctionGenerator::generate`'s own loop owns
// the vector and pushes/pops it directly, while `BlockStatement`/`ConditionalStatement`
// read *through* `GeneratorState`'s pointer to the very same vector to answer "what's
// above me" (`isCurrentTopStatementBlock`/`ConditionalStatement::isElseBlockRequired`).
// Two live routes to the same mutable data, same shape `rsg::variable_manager`'s own
// top doc comment and `rsg::generator_state`'s own top doc comment both already
// diagnosed and fixed once - this is the real "statement stack" instance both of those
// comments predicted and deferred.
//
// The fix carries over the same arena/handle technique `rsg::variable_manager`
// established for `Variable`/`ValueEntry`: `StatementArena` owns every `Statement` node
// in one `Vec<Statement>`, `StatementId` is an opaque index into it (mirroring
// `VariableId`/`ValueEntryId` exactly), `BlockStatement`/`ConditionalStatement` hold
// `StatementId`s rather than owning pointers for their children, and the statement
// stack itself becomes a plain `&[StatementId]` - an **explicit extra parameter**
// threaded alongside `&mut GeneratorState`/`&mut VariableManager`, exactly the rule
// `rsg::generator_state`'s own top doc comment lays out for whoever eventually needs
// this. Nobody owns a second mutable alias to the arena: the one driver loop that
// actually builds a tree (`statement_generator::drive_to_completion`, or any future
// caller shaped like it) owns the `Vec<StatementId>` stack *by value* and the
// `StatementArena` *by value* (or `&mut`), and every read of an ancestor goes through
// that same arena - there is no second owner for the aliasing problem to reappear
// against.
//
// This also resolves the aliasing problem `BlockStatement`/`ConditionalStatement::
// createNextChild` would otherwise hit on the Rust side for an unrelated reason: a
// method taking `&mut self` *and* `&mut StatementArena` cannot exist when `self` is
// itself borrowed out of that same arena (`arena.get_mut(id)` already holds the
// arena mutably for as long as the returned `&mut Statement` is alive). `create_next_
// child`/`tokenize`/`execute` below are therefore free functions taking `(arena, id,
// ...)` rather than methods on `Statement` - every read/write of `self`'s own fields is
// a short, non-overlapping borrow (`arena.get(id)` or `arena.get_mut(id)`, used and
// dropped immediately), never held open across a nested call that might touch a
// *different* id in the same arena. `BlockStatement::new`/`get_weight` and
// `ConditionalStatement::new`/`get_weight` stay ordinary associated functions - neither
// needs `&self` sourced from the arena (construction happens before a node has an id at
// all, and `get_weight` only ever reads a *different* id's ancestor chain, never its own
// not-yet-existing one).
//
// ## `is_current_top_statement_block`/`is_else_block_required`
//
// `isCurrentTopStatementBlock` is `dynamic_cast<const BlockStatement*>(stack.back())
// != nullptr` - ported as `arena.kind_of(*stack.last()) == StatementVariant::Block`.
// Called only from `BlockStatement::get_weight`/`DeclarationStatement::get_weight`,
// both reached through `statement_generator::choose_statement_kind` while `stack`'s own
// top entry is still the *container* about to receive a new child (the main
// loop/`drive_to_completion` hasn't pushed the new child yet at this point) - so "is the
// current top of stack a Block" really means "is whoever is about to receive this new
// child a Block", exactly the question upstream's own comment ("Low probability for
// anonymous blocks") answers.
//
// `ConditionalStatement::isElseBlockRequired` walks from `stack`'s own top entry's
// *parent* (`stack[len-2]`) upward, at each level checking "is this ancestor a
// `ConditionalStatement` whose `m_trueStatement` is exactly the previous level, and
// does it also have an `m_falseStatement`" - the classic dangling-else disambiguation:
// a bare (unbraced) `if` nested directly as another `if`'s true-branch must generate
// its own `else`, or the printed `else` that follows will bind to the *inner* `if`
// instead of the intended outer one. The walk stops at the first non-`Conditional`
// ancestor (a `BlockStatement` wrapping disambiguates on its own) or the bottom of the
// stack. Ported as `is_else_block_required` below, using `StatementId` equality in
// place of pointer identity - exactly the same substitution `rsg::variable_manager`'s
// own `VariableId`/`ValueEntryId` already made.
//
// ## `BlockStatement`/`ConditionalStatement::createNextChild`
//
// Both are ported faithfully against the real `.cpp` bodies (not summarized from the
// header): `BlockStatement` picks `m_numChildrenToCreate` once (`init`, folded into
// `new` since upstream's only other constructor is private and never reached by
// `chooseStatement`'s dispatch table) and creates one new child per call via
// `statement_generator::create_statement` until that count is reached, then pops its
// own `VariableScope`. `ConditionalStatement::createNextChild` is a three-phase state
// machine driven entirely by which of `m_trueStatement`/`m_falseStatement` are still
// `None` - first (maybe) the false/else branch (under its own `ValueScope`, pushed only
// if `isElseBlockRequired` or a coin flip says so), then always the true branch (a
// *fresh* `ValueScope`, discarding whatever the false branch's scope held - upstream's
// own `m_conditionalScope.clear()` right after `popValueScope()`, which this port
// reproduces by simply pushing a brand new `ValueScope::new()` each time rather than
// taking the popped one back out and clearing it in place - functionally identical,
// since nothing ever reads the popped scope's contents in between), then the random
// boolean condition expression itself, generated one level deeper than its own
// `createNextChild` call (`initial_depth = 1`, matching upstream's own `generator.
// generate(range, 1)`).
//
// ## `BlockStatement`'s own children: stored forward, read back in *reverse*
//
// **A confirmed, faithfully-ported upstream idiom, not a bug fixed here** -
// `BlockStatement::tokenize`/`execute` both iterate `m_children` via `rbegin()`/
// `rend()`, printing/executing the *last*-created child first and the *first*-created
// child last. This looked backwards on first read, but it is not an isolated slip:
// the identical "append forward, read in reverse" shape recurs across this same
// upstream directory with no shared helper tying them together - `rsgShader.cpp`'s own
// `m_globalStatements`, `rsgVariableManager.cpp`'s value-scope-stack searches, and (an
// earlier case this port already found and documented) `rsgExpression.cpp`'s own
// `ConstructorOp::m_inputExpressions`, where upstream's own comment ("Created in
// reverse order!") confirms the reversal is deliberate there. `BlockStatement`/
// `rsgShader.cpp` carry no equivalent comment explaining *why*, so this port does not
// assume either "deliberate" or "bug" and instead does what this project's own standing
// rule requires for a confirmed-real, unexplained upstream oddity: port it exactly,
// document it here, and let a `QUIRKS.md` entry wait until something that actually
// consumes a generated shader's statement order is affected by it (nothing does yet -
// no `BlockStatement` tree is wired into any real `dEQP-GLES*` case). Ported as a plain
// `.iter().rev()` in both `tokenize` and `execute` below; a dedicated unit test
// (`block_statement_tokenizes_and_executes_children_in_reverse_of_their_own_creation_
// order`) hand-confirms the exact reversal with three distinguishable children.
//
// ## What is still NOT ported
//
// `rsg::utils`'s three remaining `Shader`-dependent functions (`addNewUniforms`/
// `computeUnifiedUniforms`/`computeUniformValues`), `rsgShader`/`rsgShaderGenerator`/
// `rsgProgramGenerator`/`rsgFunctionGenerator`/`rsgProgramExecutor` - `FunctionGenerator::
// generate`'s own loop (the thing `statement_generator::drive_to_completion` mirrors,
// not ports) is the one remaining piece needed to turn this into a wired, real driver;
// everything it needs from *this* file is already here.

use super::execution_context::{EXEC_VEC_WIDTH, ExecMaskStorage, ExecutionContext, assign_masked};
use super::expression::Expression;
use super::expression_generator::generate_expression;
use super::generator_state::{CONST_EXPR, GeneratorState};
use super::parameters::Version;
use super::statement_generator;
use super::token::{Token, TokenStream};
use super::variable::{ShaderType, Storage};
use super::variable_manager::{ValueScope, VariableId, VariableManager, VariableScope};
use super::variable_type::{Type, VariableType};
use super::variable_value::{ConstValueRangeAccess, ValueRange, ValueStorage};

/// Opaque handle into `StatementArena`'s own `Statement` arena - see this module's top
/// doc comment for why this replaces upstream's `Statement*`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct StatementId(usize);

/// Owns every `Statement` node in one tree (and, once `BlockStatement::createNextChild`
/// runs more than once, every subtree created so far) - see this module's top doc
/// comment for why this replaces upstream's individually-`new`-allocated, owning-pointer
/// tree.
#[derive(Default)]
pub struct StatementArena {
    nodes: Vec<Statement>,
}

/// Which of the five `Statement` kinds a given node is - a cheap, `Copy`, arena-free
/// value, used so `create_next_child`/the `is_*` helpers below never hold a live borrow
/// of `arena` across a later `arena.get_mut` call (see this module's top doc comment).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum StatementVariant {
    Expression,
    Assign,
    Declaration,
    Block,
    Conditional,
}

impl StatementArena {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn insert(&mut self, statement: Statement) -> StatementId {
        let id = StatementId(self.nodes.len());
        self.nodes.push(statement);
        id
    }

    pub fn get(&self, id: StatementId) -> &Statement {
        &self.nodes[id.0]
    }

    pub fn get_mut(&mut self, id: StatementId) -> &mut Statement {
        &mut self.nodes[id.0]
    }

    fn variant_of(&self, id: StatementId) -> StatementVariant {
        match self.get(id) {
            Statement::Expression(_) => StatementVariant::Expression,
            Statement::Assign(_) => StatementVariant::Assign,
            Statement::Declaration(_) => StatementVariant::Declaration,
            Statement::Block(_) => StatementVariant::Block,
            Statement::Conditional(_) => StatementVariant::Conditional,
        }
    }
}

/// `rsg::Statement` - see this module's own top doc comment for the current scope (all
/// five upstream kinds, modelled as an enum over them exactly like
/// `rsg::expression::Expression` already does - the full upstream kind list is small
/// and known, so a plain `match` replaces virtual dispatch with no `Box<dyn Trait>`
/// needed).
pub enum Statement {
    Expression(ExpressionStatement),
    Assign(AssignStatement),
    Declaration(DeclarationStatement),
    Block(BlockStatement),
    Conditional(ConditionalStatement),
}

/// `isCurrentTopStatementBlock` (file-local upstream) - see this module's top doc
/// comment for exactly what "current top" means at the point this is ever called.
fn is_current_top_statement_block(arena: &StatementArena, stack: &[StatementId]) -> bool {
    let top = *stack
        .last()
        .expect("is_current_top_statement_block: stack must not be empty");
    arena.variant_of(top) == StatementVariant::Block
}

fn is_block_statement(arena: &StatementArena, id: StatementId) -> bool {
    arena.variant_of(id) == StatementVariant::Block
}

fn is_conditional_statement(arena: &StatementArena, id: StatementId) -> bool {
    arena.variant_of(id) == StatementVariant::Conditional
}

/// `ConditionalStatement::isElseBlockRequired` - see this module's top doc comment for
/// the dangling-else reasoning. `stack`'s own top entry is the `ConditionalStatement`
/// asking the question (`this` upstream); the walk starts at its *parent*.
fn is_else_block_required(arena: &StatementArena, stack: &[StatementId]) -> bool {
    let mut cur_child_id = *stack.last().expect("is_else_block_required: stack must not be empty");
    let mut cur_ndx = stack.len() as isize - 2;

    while cur_ndx >= 0 {
        let cur_parent_id = stack[cur_ndx as usize];
        let (true_statement, false_statement) = match arena.get(cur_parent_id) {
            Statement::Conditional(c) => (c.true_statement, c.false_statement),
            _ => break, // Not a conditional statement - can end search here.
        };

        if true_statement == Some(cur_child_id) && false_statement.is_some() {
            return true; // Else block is mandatory.
        }

        cur_child_id = cur_parent_id;
        cur_ndx -= 1;
    }

    false
}

/// `Statement::createNextChild` dispatch - see this module's top doc comment for why
/// this is a free function rather than a method. `stack`'s own top entry is the node
/// whose `createNextChild` is conceptually running (unchanged by this call - the
/// caller, e.g. `statement_generator::drive_to_completion`, pushes the returned id
/// itself before the next call).
pub fn create_next_child(
    arena: &mut StatementArena,
    stack: &[StatementId],
    state: &mut GeneratorState<'_>,
    var_manager: &mut VariableManager<'_>,
) -> Option<StatementId> {
    let self_id = *stack.last().expect("create_next_child: stack must not be empty");

    match arena.variant_of(self_id) {
        // `DE_UNREF(state); return nullptr;` upstream, for all three.
        StatementVariant::Expression | StatementVariant::Assign | StatementVariant::Declaration => None,

        StatementVariant::Block => {
            let (len, num_to_create) = match arena.get(self_id) {
                Statement::Block(b) => (b.children.len() as i32, b.num_children_to_create),
                _ => unreachable!(),
            };

            if len < num_to_create {
                let child_id = statement_generator::create_statement(arena, stack, state, var_manager);
                match arena.get_mut(self_id) {
                    Statement::Block(b) => b.children.push(child_id),
                    _ => unreachable!(),
                }
                Some(child_id)
            } else {
                var_manager.pop_variable_scope();
                None
            }
        }

        StatementVariant::Conditional => {
            let (has_false, has_true) = match arena.get(self_id) {
                Statement::Conditional(c) => (c.false_statement.is_some(), c.true_statement.is_some()),
                _ => unreachable!(),
            };

            if !has_false && !has_true && (is_else_block_required(arena, stack) || state.get_random().get_bool()) {
                var_manager.push_value_scope(ValueScope::new());
                let child_id = statement_generator::create_statement(arena, stack, state, var_manager);
                match arena.get_mut(self_id) {
                    Statement::Conditional(c) => c.false_statement = Some(child_id),
                    _ => unreachable!(),
                }
                Some(child_id)
            } else if !has_true {
                if has_false {
                    var_manager.pop_value_scope();
                }
                var_manager.push_value_scope(ValueScope::new());
                let child_id = statement_generator::create_statement(arena, stack, state, var_manager);
                match arena.get_mut(self_id) {
                    Statement::Conditional(c) => c.true_statement = Some(child_id),
                    _ => unreachable!(),
                }
                Some(child_id)
            } else {
                var_manager.pop_value_scope();

                let mut range = ValueRange::new(VariableType::scalar_type(Type::Bool));
                range.get_min().set_bool(false);
                range.get_max().set_bool(true);
                let condition = generate_expression(state, var_manager, &range.as_const_access(), 1);

                match arena.get_mut(self_id) {
                    Statement::Conditional(c) => c.condition = Some(condition),
                    _ => unreachable!(),
                }
                None
            }
        }
    }
}

/// `Statement::tokenize` dispatch - see this module's top doc comment for why this is a
/// free function. Pure reads throughout, so (unlike `execute` below) recursive calls
/// never need more than one more shared borrow of `arena`.
pub fn tokenize(
    arena: &StatementArena,
    id: StatementId,
    var_manager: &VariableManager<'_>,
    version: Version,
    shader_type: ShaderType,
    stream: &mut TokenStream,
) {
    match arena.get(id) {
        Statement::Expression(e) => e.tokenize(var_manager, version, shader_type, stream),
        Statement::Assign(a) => a.tokenize(var_manager, version, shader_type, stream),
        Statement::Declaration(d) => d.tokenize(var_manager, version, shader_type, stream),

        Statement::Block(b) => {
            stream.push(Token::LeftBrace);
            stream.push(Token::Newline);
            stream.push(Token::IndentInc);

            // See this module's top doc comment: reversed relative to creation order,
            // matching upstream's own `rbegin()`/`rend()`.
            for &child_id in b.children.iter().rev() {
                tokenize(arena, child_id, var_manager, version, shader_type, stream);
            }

            stream.push(Token::IndentDec);
            stream.push(Token::RightBrace);
            stream.push(Token::Newline);
        }

        Statement::Conditional(c) => {
            let condition = c
                .condition
                .as_ref()
                .expect("ConditionalStatement::tokenize: condition must be set");
            let true_id = c
                .true_statement
                .expect("ConditionalStatement::tokenize: true statement must be set");
            let false_id = c.false_statement;

            stream.push(Token::If);
            stream.push(Token::LeftParen);
            condition.tokenize(var_manager, version, shader_type, stream);
            stream.push(Token::RightParen);
            stream.push(Token::Newline);

            if !is_block_statement(arena, true_id) {
                stream.push(Token::IndentInc);
                tokenize(arena, true_id, var_manager, version, shader_type, stream);
                stream.push(Token::IndentDec);
            } else {
                tokenize(arena, true_id, var_manager, version, shader_type, stream);
            }

            if let Some(false_id) = false_id {
                stream.push(Token::Else);

                if is_conditional_statement(arena, false_id) {
                    tokenize(arena, false_id, var_manager, version, shader_type, stream);
                } else if is_block_statement(arena, false_id) {
                    stream.push(Token::Newline);
                    tokenize(arena, false_id, var_manager, version, shader_type, stream);
                } else {
                    stream.push(Token::Newline);
                    stream.push(Token::IndentInc);
                    tokenize(arena, false_id, var_manager, version, shader_type, stream);
                    stream.push(Token::IndentDec);
                }
            }
        }
    }
}

/// `Statement::execute` dispatch - see this module's top doc comment for why this is a
/// free function. Unlike `tokenize`, every leaf kind's own `execute` needs `&mut self`,
/// so each step below takes the narrowest possible borrow of `arena` and drops it
/// before any recursive call, exactly the discipline `create_next_child` already
/// establishes.
pub fn execute(
    arena: &mut StatementArena,
    id: StatementId,
    var_manager: &VariableManager<'_>,
    ctx: &mut ExecutionContext<'_>,
) {
    match arena.variant_of(id) {
        StatementVariant::Expression | StatementVariant::Assign | StatementVariant::Declaration => {
            match arena.get_mut(id) {
                Statement::Expression(e) => e.execute(var_manager, ctx),
                Statement::Assign(a) => a.execute(var_manager, ctx),
                Statement::Declaration(d) => d.execute(var_manager, ctx),
                _ => unreachable!(),
            }
        }

        StatementVariant::Block => {
            let children = match arena.get(id) {
                Statement::Block(b) => b.children.clone(),
                _ => unreachable!(),
            };
            // See this module's top doc comment: reversed relative to creation order.
            for child_id in children.into_iter().rev() {
                execute(arena, child_id, var_manager, ctx);
            }
        }

        StatementVariant::Conditional => {
            match arena.get_mut(id) {
                Statement::Conditional(c) => {
                    let condition = c
                        .condition
                        .as_mut()
                        .expect("ConditionalStatement::execute: condition must be set");
                    condition.evaluate(var_manager, ctx);
                }
                _ => unreachable!(),
            }

            // Snapshot the condition's resulting mask into owned storage first - `ctx`
            // cannot be borrowed for the source (`Expression::get_value`) and later
            // mutated (`and_execution_mask`) at the same time, the same pattern every
            // other `execute`/`evaluate` with two live `ctx` accesses already needs in
            // this port (see `AssignStatement::execute`'s own doc comment).
            let mut true_mask = ExecMaskStorage::new(true);
            {
                let src = match arena.get(id) {
                    Statement::Conditional(c) => c
                        .condition
                        .as_ref()
                        .expect("ConditionalStatement::execute: condition must be set")
                        .get_value(var_manager, ctx)
                        .value(),
                    _ => unreachable!(),
                };
                true_mask.get_value().assign_from(&src);
            }

            let (true_id, false_id) = match arena.get(id) {
                Statement::Conditional(c) => (
                    c.true_statement
                        .expect("ConditionalStatement::execute: true statement must be set"),
                    c.false_statement,
                ),
                _ => unreachable!(),
            };

            ctx.and_execution_mask(&true_mask.get_value_const());
            execute(arena, true_id, var_manager, ctx);
            ctx.pop_execution_mask();

            if let Some(false_id) = false_id {
                let mut false_mask = ExecMaskStorage::new(true);
                {
                    let mut v = false_mask.get_value();
                    let true_mask_const = true_mask.get_value_const();
                    for i in 0..EXEC_VEC_WIDTH {
                        v.set_bool_at(i, !true_mask_const.as_bool_at(i));
                    }
                }

                ctx.and_execution_mask(&false_mask.get_value_const());
                execute(arena, false_id, var_manager, ctx);
                ctx.pop_execution_mask();
            }
        }
    }
}

/// `rsg::ExpressionStatement` - a single `Expression` generated through a `Void` value
/// range (i.e. "whatever expression the generator feels like, used for its side effects
/// alone"), executed for those side effects and tokenized as `<expr>;\n`.
pub struct ExpressionStatement {
    expression: Expression,
}

impl ExpressionStatement {
    /// `ExpressionStatement::ExpressionStatement(GeneratorState&)` - upstream builds a
    /// fresh `ExpressionGenerator` and calls its two-argument `generate` overload
    /// (`initialDepth` defaulting to `0`, confirmed by reading the real default
    /// argument in `rsgExpressionGenerator.hpp`), exactly `generate_expression`'s own
    /// `initial_depth: 0` call shape here.
    pub fn new(state: &mut GeneratorState<'_>, var_manager: &mut VariableManager<'_>) -> Self {
        let void_range = ValueRange::new(VariableType::new_basic(Type::Void, 1));
        let expression = generate_expression(state, var_manager, &void_range.as_const_access(), 0);
        Self { expression }
    }

    /// `ExpressionStatement::getWeight` - a constant upstream (`DE_UNREF(state); return
    /// 1.0f;`).
    pub fn get_weight(_state: &GeneratorState<'_>) -> f32 {
        1.0
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.expression.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::Semicolon);
        stream.push(Token::Newline);
    }

    pub fn execute(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.expression.evaluate(var_manager, ctx);
    }
}

/// `rsg::AssignStatement` - "Used for generating mandatory assignments (shader outputs,
/// function outputs). Normally assignment is handled inside `ExpressionStatement` where
/// generator may choose to generate `AssignOp` expression" (upstream's own comment,
/// carried over verbatim since it is the whole reason this kind exists as a *separate*
/// thing from `rsg::expression::AssignOp`). Deliberately **not** part of
/// `chooseStatement`'s weighted dispatch table - confirmed by reading it, this kind is
/// only ever constructed directly by whatever needs a guaranteed assignment, never
/// picked at random the way `BlockStatement`/`ExpressionStatement`/
/// `DeclarationStatement`/`ConditionalStatement` are.
pub struct AssignStatement {
    variable: VariableId,
    value_expr: Expression,
}

impl AssignStatement {
    /// `AssignStatement::AssignStatement(const Variable*, Expression*)` - takes an
    /// already-built expression directly rather than generating one.
    pub fn from_expression(variable: VariableId, value_expr: Expression) -> Self {
        Self { variable, value_expr }
    }

    /// `AssignStatement::AssignStatement(GeneratorState&, const Variable*,
    /// ConstValueRangeAccess)` - `initialDepth = 1` matches upstream's own call
    /// (`generator.generate(valueRange, 1)`), one level deeper than
    /// `ExpressionStatement`'s `0` since this expression is itself nested inside the
    /// assignment.
    pub fn new_random(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        variable: VariableId,
        value_range: &ConstValueRangeAccess<'_>,
    ) -> Self {
        let value_expr = generate_expression(state, var_manager, value_range, 1);
        Self { variable, value_expr }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        stream.push(Token::identifier(var_manager.get_variable(self.variable).get_name()));
        stream.push(Token::Equal);
        self.value_expr.tokenize(var_manager, version, shader_type, stream);
        stream.push(Token::Semicolon);
        stream.push(Token::Newline);
    }

    /// `AssignStatement::execute` - `assignMasked(execCtx.getValue(m_variable),
    /// m_valueExpr->getValue(), execCtx.getExecutionMask())`. The rvalue and the
    /// execution mask are snapshotted into owned storage first, exactly like
    /// `rsg::expression::AssignOp::evaluate` already needs to (see that method's own
    /// doc comment): `ctx` cannot be borrowed for the source value (via `Expression::
    /// get_value`) and the destination value (via `ExecutionContext::get_value`)
    /// simultaneously.
    pub fn execute(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        self.value_expr.evaluate(var_manager, ctx);

        let type_ = var_manager.get_variable(self.variable).get_type().clone();

        let mut value_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
        {
            let src = self.value_expr.get_value(var_manager, ctx).value();
            value_storage.get_value(&type_).assign_from(&src);
        }

        let mut mask_storage = ExecMaskStorage::new(true);
        {
            let mask_src = ctx.get_execution_mask().value();
            mask_storage.get_value().assign_from(&mask_src);
        }

        let src_access = value_storage.get_value_const(&type_);
        let dst = ctx.get_value(self.variable, &type_);
        assign_masked(dst, &src_access, &mask_storage.get_value_const());
    }
}

/// `canDeclareVariable` (file-local upstream) - only a `Local`-storage variable can ever
/// be offered as a random declaration candidate (a `Const`/`Uniform`/`ShaderIn`/...
/// variable is declared elsewhere, as a shader parameter/global, not via a plain local
/// declaration statement).
fn can_declare_variable(var_manager: &VariableManager<'_>, variable: VariableId) -> bool {
    var_manager.get_variable(variable).get_storage() == Storage::Local
}

/// `hasDeclarableVars` (file-local upstream).
fn has_declarable_vars(var_manager: &VariableManager<'_>) -> bool {
    var_manager
        .get_live_variables()
        .iter()
        .any(|&v| can_declare_variable(var_manager, v))
}

/// `rsg::DeclarationStatement` - declares one variable, with an optional initializer.
pub struct DeclarationStatement {
    variable: VariableId,
    expression: Option<Expression>,
}

impl DeclarationStatement {
    /// `DeclarationStatement::DeclarationStatement(GeneratorState&, Variable* = nullptr)` -
    /// `variable: None` stands in for upstream's `nullptr` default (pick a random
    /// declarable live variable instead of using a caller-supplied one).
    pub fn new(
        state: &mut GeneratorState<'_>,
        var_manager: &mut VariableManager<'_>,
        variable: Option<VariableId>,
    ) -> Self {
        let variable = match variable {
            Some(v) => v,
            None => {
                let candidates: Vec<VariableId> = var_manager
                    .get_live_variables()
                    .iter()
                    .copied()
                    .filter(|&v| can_declare_variable(var_manager, v))
                    .collect();
                *state.get_random().choose(&candidates)
            }
        };

        // Take a copy of the value range *before* `declare_variable` below, which
        // removes the value entry - matching upstream's own comment ("Declare (removes
        // value entry)") and its own call order exactly.
        let value_range = var_manager
            .get_value(variable)
            .map(|entry| ValueRange::from_access(&entry.get_value_range_const()));

        let storage = var_manager.get_variable(variable).get_storage();
        let create_initializer = match storage {
            Storage::Const => {
                debug_assert!(value_range.is_some(), "a Const variable must already have a value");
                true
            }
            Storage::Local => value_range.is_some(),
            _ => false,
        };

        let expression = if create_initializer {
            let value_range = value_range.expect("create_initializer is only true when a value range exists");
            var_manager.declare_variable(variable);

            let is_const = storage == Storage::Const;
            if is_const {
                state.push_expression_flags(state.get_expression_flags() | CONST_EXPR);
            }
            let expr = generate_expression(state, var_manager, &value_range.as_const_access(), 1);
            if is_const {
                state.pop_expression_flags();
            }
            Some(expr)
        } else {
            var_manager.declare_variable(variable);
            None
        };

        Self { variable, expression }
    }

    /// `DeclarationStatement::getWeight` - needs `isCurrentTopStatementBlock`, so (like
    /// `BlockStatement::get_weight`) takes `arena`/`stack` explicitly.
    pub fn get_weight(
        state: &GeneratorState<'_>,
        var_manager: &VariableManager<'_>,
        arena: &StatementArena,
        stack: &[StatementId],
    ) -> f32 {
        if !has_declarable_vars(var_manager) {
            return 0.0;
        }
        if !is_current_top_statement_block(arena, stack) {
            return 0.0;
        }
        // `ProgramParameters::declaration_statement_base_weight` is `bool` upstream
        // (see `rsg::parameters`' own doc comment for the quirk) - read back as the
        // float weight `true`/`false` round-trip to, matching upstream's own
        // (accidental) `bool -> float` conversion exactly.
        if state.get_program_parameters().declaration_statement_base_weight {
            1.0
        } else {
            0.0
        }
    }

    pub fn tokenize(
        &self,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        var_manager
            .get_variable(self.variable)
            .tokenize_declaration(version, shader_type, stream);

        if let Some(expr) = &self.expression {
            stream.push(Token::Equal);
            expr.tokenize(var_manager, version, shader_type, stream);
        }

        stream.push(Token::Semicolon);
        stream.push(Token::Newline);
    }

    /// `DeclarationStatement::execute` - `execCtx.getValue(m_variable) = m_expression->
    /// getValue().value();`. The initializer's value is snapshotted into owned storage
    /// first, the same shape every other `execute`/`evaluate` with two live `ctx`
    /// accesses already needs in this port (see `AssignStatement::execute`'s own doc
    /// comment) - `ctx` cannot be borrowed for the source (via `Expression::get_value`)
    /// and the destination (via `ExecutionContext::get_value`) at the same time.
    pub fn execute(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        if let Some(expr) = &mut self.expression {
            expr.evaluate(var_manager, ctx);

            let type_ = var_manager.get_variable(self.variable).get_type().clone();

            let mut value_storage = ValueStorage::with_type(EXEC_VEC_WIDTH, &type_);
            {
                let src = expr.get_value(var_manager, ctx).value();
                value_storage.get_value(&type_).assign_from(&src);
            }

            let src_access = value_storage.get_value_const(&type_).value();
            ctx.get_value(self.variable, &type_).assign_from(&src_access);
        }
    }
}

/// `rsg::BlockStatement` - see this module's top doc comment for the arena-based
/// `children`/`VariableScope` design and the confirmed-faithful reverse read-back order.
pub struct BlockStatement {
    num_children_to_create: i32,
    children: Vec<StatementId>,
}

impl BlockStatement {
    /// `BlockStatement::BlockStatement(void)` - upstream's own private default
    /// constructor (`m_numChildrenToCreate(0)`, no scope pushed), used for
    /// `Function::m_functionBlock`'s member-default-init. This port has no equivalent
    /// *need* for that C++-only requirement (see `rsg::function_generator`'s own top doc
    /// comment for why `Function`'s own `body: Vec<StatementId>` needed no type change
    /// at all), but `rsg::shader_generator`'s own passthrough path (`genVertexPassthrough`/
    /// `genFragmentPassthrough`) is a second, genuine caller: it appends children
    /// directly via `add_child` without ever going through the random `createNextChild`
    /// dispatch, exactly mirroring upstream's own "mutate the still-default-constructed
    /// `m_functionBlock` directly" shape in that same code path.
    pub fn new_empty() -> Self {
        Self {
            num_children_to_create: 0,
            children: Vec::new(),
        }
    }

    /// `BlockStatement::BlockStatement(GeneratorState&)`, which immediately calls
    /// `init` - folded into one constructor here since upstream's only other
    /// constructor (`BlockStatement(void)`, see `new_empty` above) is never reached by
    /// `chooseStatement`'s dispatch table, the only caller needing the *randomized*
    /// shape.
    pub fn new(state: &mut GeneratorState<'_>, var_manager: &mut VariableManager<'_>) -> Self {
        // `state.get_shader_parameters()` is bound to a local first: calling it as an
        // argument expression while `state.get_random()` already holds `state` mutably
        // (as the method-call receiver) is two overlapping borrows of `state` and does
        // not borrow-check.
        let max_children = state.get_shader_parameters().max_statements_per_block;
        let num_children_to_create = state.get_random().get_int(0, max_children);
        var_manager.push_variable_scope(VariableScope::new());
        Self {
            num_children_to_create,
            children: Vec::new(),
        }
    }

    /// `BlockStatement::getWeight` - see this module's top doc comment for exactly what
    /// "current top of stack" means at this call site.
    pub fn get_weight(state: &GeneratorState<'_>, arena: &StatementArena, stack: &[StatementId]) -> f32 {
        if stack.len() as i32 + 1 < state.get_shader_parameters().max_statement_depth {
            if is_current_top_statement_block(arena, stack) {
                0.2 // Low probability for anonymous blocks.
            } else {
                1.0
            }
        } else {
            0.0
        }
    }

    /// Test-only accessor for `children` - `statement_generator`'s own test module is a
    /// sibling of this one (both are direct children of `rsg`), so it cannot reach the
    /// private `children` field directly the way this file's own tests can.
    #[cfg(test)]
    pub(crate) fn get_children_for_test(&self) -> &[StatementId] {
        &self.children
    }

    /// `BlockStatement::addChild` - appends a child built *outside* the normal
    /// `createNextChild` random-dispatch path. Upstream's own body is a plain
    /// `push_back` wrapped in a `try`/`catch` that deletes the (now-orphaned) owning
    /// pointer and rethrows on allocation failure - a C++-specific exception-safety
    /// concern with no Rust equivalent (`Vec::push`'s own reallocation failure aborts
    /// the process rather than unwinding into caller-visible cleanup code, and
    /// `StatementId` is `Copy`, not an owning handle, so there is nothing to leak
    /// either way). `rsg::function_generator::FunctionGenerator::generate` is the one
    /// real caller this port has so far, for exactly upstream's own reason: "generating
    /// mandatory assignments" (see `AssignStatement`'s own doc comment) appends directly
    /// to a function body's root block without going through weighted random choice.
    pub fn add_child(&mut self, statement_id: StatementId) {
        self.children.push(statement_id);
    }
}

/// `rsg::ConditionalStatement` - see this module's top doc comment for the three-phase
/// `createNextChild` state machine and the dangling-else `is_else_block_required` check.
pub struct ConditionalStatement {
    condition: Option<Expression>,
    true_statement: Option<StatementId>,
    false_statement: Option<StatementId>,
}

impl ConditionalStatement {
    /// `ConditionalStatement::ConditionalStatement(GeneratorState&)` - trivial upstream,
    /// every field starts empty/null; all the real work happens in `createNextChild`.
    /// Upstream's own `m_conditionalScope` field has no equivalent here - see this
    /// module's top doc comment for why a fresh `ValueScope::new()` at each push site
    /// is functionally identical to upstream's reused-then-cleared field.
    pub fn new() -> Self {
        Self {
            condition: None,
            true_statement: None,
            false_statement: None,
        }
    }

    /// `ConditionalStatement::getWeight` - does not need `isCurrentTopStatementBlock`,
    /// only the plain stack *depth*, so (unlike `BlockStatement`/`DeclarationStatement`)
    /// this needs no `arena` parameter at all.
    pub fn get_weight(state: &GeneratorState<'_>, stack: &[StatementId]) -> f32 {
        if !state.get_program_parameters().use_conditionals {
            return 0.0;
        }
        let available_levels = state.get_shader_parameters().max_statement_depth - stack.len() as i32;
        if available_levels > 1 { 1.0 } else { 0.0 }
    }
}

impl Default for ConditionalStatement {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use super::*;
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::{ProgramParameters, ShaderParameters};
    use crate::rsg::samplers::{Sampler2DMap, SamplerCubeMap};
    use crate::tcu::random::Random;

    fn new_state_with_budget<'a>(
        program_params: &'a ProgramParameters,
        shader_params: &'a ShaderParameters,
        random: &'a mut Random,
    ) -> GeneratorState<'a> {
        let mut state = GeneratorState::new(program_params, random);
        state.set_shader_parameters(shader_params);
        state
    }

    fn new_var_manager(alloc: &mut NameAllocator) -> VariableManager<'_> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    fn empty_ctx<'a>(empty_2d: &'a Sampler2DMap<'a>, empty_cube: &'a SamplerCubeMap<'a>) -> ExecutionContext<'a> {
        ExecutionContext::new(empty_2d, empty_cube)
    }

    #[test]
    fn expression_statement_get_weight_is_always_one() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let state = new_state_with_budget(&program_params, &shader_params, &mut random);
        assert_eq!(ExpressionStatement::get_weight(&state), 1.0);
    }

    #[test]
    fn expression_statement_builds_executes_and_tokenizes_without_panicking() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut alloc = NameAllocator::new();
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();

        for seed in 0..20 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);
            let mut ctx = empty_ctx(&empty_2d, &empty_cube);

            let mut arena = StatementArena::new();
            let id = arena.insert(Statement::Expression(ExpressionStatement::new(&mut state, &mut mgr)));
            assert!(
                create_next_child(&mut arena, &[id], &mut state, &mut mgr).is_none(),
                "seed {seed}"
            );

            execute(&mut arena, id, &mgr, &mut ctx);

            let mut stream = TokenStream::new();
            tokenize(&arena, id, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
            assert!(!stream.is_empty(), "seed {seed}");
            assert_eq!(*stream.tokens().last().unwrap(), Token::Newline, "seed {seed}");
            assert_eq!(
                stream.tokens()[stream.tokens().len() - 2],
                Token::Semicolon,
                "seed {seed}"
            );
        }
    }

    #[test]
    fn assign_statement_from_expression_writes_through_to_the_variable_and_tokenizes() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = empty_ctx(&empty_2d, &empty_cube);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let variable = mgr.allocate(int_type.clone());
        mgr.set_storage(variable, Storage::Local);

        let mut point_range = ValueRange::new(int_type);
        point_range.get_min().set_int(42);
        point_range.get_max().set_int(42);
        let literal = Expression::Int(crate::rsg::expression::IntLiteral::new_random(
            &mut new_state_with_budget(&program_params, &shader_params, &mut random),
            &point_range.as_const_access(),
        ));

        let stmt = AssignStatement::from_expression(variable, literal);
        let mut arena = StatementArena::new();
        let id = arena.insert(Statement::Assign(stmt));
        execute(&mut arena, id, &mgr, &mut ctx);

        let var_type = mgr.get_variable(variable).get_type().clone();
        assert_eq!(ctx.get_value(variable, &var_type).as_int_at(0), 42);

        let mut stream = TokenStream::new();
        tokenize(&arena, id, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert_eq!(stream.tokens()[1], Token::Equal);
        assert_eq!(*stream.tokens().last().unwrap(), Token::Newline);
    }

    /// **Deliberately not asserted: that the generated value actually lies within the
    /// requested range.** Same gap `generate_expression_builds_a_fully_resolved_tree...`
    /// (`rsg::expression_generator`) and `ConstructorOp`'s own scalar-conversions test
    /// (`rsg::expression`) already document: `generate_expression`'s dispatcher can pick
    /// a `VariableRead` of a freshly-allocated variable that nothing in this standalone
    /// test ever assigns a concrete value to, so it evaluates to `ExecutionContext`'s
    /// untouched default rather than a value actually drawn from the requested range -
    /// a promise only the real shader generator's `computeUniformValues` keeps.
    #[test]
    fn assign_statement_new_random_builds_and_executes_without_panicking() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut alloc = NameAllocator::new();
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();

        for seed in 0..20 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);
            let mut ctx = empty_ctx(&empty_2d, &empty_cube);

            let int_type = VariableType::new_basic(Type::Int, 1);
            let variable = mgr.allocate(int_type.clone());
            mgr.set_storage(variable, Storage::Local);

            let mut range = ValueRange::new(int_type.clone());
            range.get_min().set_int(-5);
            range.get_max().set_int(5);

            let stmt = AssignStatement::new_random(&mut state, &mut mgr, variable, &range.as_const_access());
            let mut arena = StatementArena::new();
            let id = arena.insert(Statement::Assign(stmt));
            execute(&mut arena, id, &mgr, &mut ctx);

            let _ = ctx.get_value(variable, &int_type).as_int_at(0); // Must not panic.
        }
    }

    #[test]
    fn declaration_statement_const_variable_always_creates_an_initializer() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let variable = mgr.allocate(int_type.clone());
        mgr.set_storage(variable, Storage::Const);

        let mut point_range = ValueRange::new(int_type);
        point_range.get_min().set_int(7);
        point_range.get_max().set_int(7);
        mgr.set_value(variable, &point_range.as_const_access());

        let stmt = DeclarationStatement::new(&mut state, &mut mgr, Some(variable));
        assert!(
            stmt.expression.is_some(),
            "a Const variable must always get an initializer"
        );

        let mut arena = StatementArena::new();
        let id = arena.insert(Statement::Declaration(stmt));
        let mut stream = TokenStream::new();
        tokenize(&arena, id, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert!(stream.tokens().contains(&Token::Const));
        assert!(
            stream.tokens().contains(&Token::Equal),
            "an initializer must be tokenized"
        );
    }

    #[test]
    fn declaration_statement_of_a_freshly_allocated_local_variable_always_creates_an_initializer() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = empty_ctx(&empty_2d, &empty_cube);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let variable = mgr.allocate(int_type.clone());
        mgr.set_storage(variable, Storage::Local);

        let stmt = DeclarationStatement::new(&mut state, &mut mgr, Some(variable));
        assert!(
            stmt.expression.is_some(),
            "a freshly allocated variable always has a [0, 0] value entry"
        );

        let mut arena = StatementArena::new();
        let id = arena.insert(Statement::Declaration(stmt));
        execute(&mut arena, id, &mgr, &mut ctx);
        let _ = ctx.get_value(variable, &int_type).as_int_at(0); // Must not panic.

        let mut stream = TokenStream::new();
        tokenize(&arena, id, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
        assert!(stream.tokens().contains(&Token::Equal));
        assert_eq!(*stream.tokens().last().unwrap(), Token::Newline);
        assert_eq!(stream.tokens()[stream.tokens().len() - 2], Token::Semicolon);
    }

    #[test]
    fn declaration_statement_execute_writes_the_initializer_through_to_the_variable() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = empty_ctx(&empty_2d, &empty_cube);

        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let variable = mgr.allocate(int_type.clone());
        mgr.set_storage(variable, Storage::Local);

        let mut point_range = ValueRange::new(int_type);
        point_range.get_min().set_int(99);
        point_range.get_max().set_int(99);
        let literal = Expression::Int(crate::rsg::expression::IntLiteral::new_random(
            &mut state,
            &point_range.as_const_access(),
        ));

        let stmt = DeclarationStatement {
            variable,
            expression: Some(literal),
        };
        let mut arena = StatementArena::new();
        let id = arena.insert(Statement::Declaration(stmt));
        execute(&mut arena, id, &mgr, &mut ctx);

        let int_type = VariableType::new_basic(Type::Int, 1);
        assert_eq!(ctx.get_value(variable, &int_type).as_int_at(0), 99);
    }

    #[test]
    fn declaration_statement_picks_a_random_live_declarable_variable_when_none_given() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut alloc = NameAllocator::new();

        for seed in 0..20 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);

            let int_type = VariableType::new_basic(Type::Int, 1);
            let candidates: Vec<VariableId> = (0..3)
                .map(|_| {
                    let v = mgr.allocate(int_type.clone());
                    mgr.set_storage(v, Storage::Local);
                    v
                })
                .collect();

            let stmt = DeclarationStatement::new(&mut state, &mut mgr, None);
            assert!(candidates.contains(&stmt.variable), "seed {seed}");
        }
    }

    #[test]
    fn declaration_statement_get_weight_requires_declarable_vars_and_a_block_container() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let mut arena = StatementArena::new();
        let block_id = arena.insert(Statement::Block(BlockStatement {
            num_children_to_create: 0,
            children: Vec::new(),
        }));
        let cond_id = arena.insert(Statement::Conditional(ConditionalStatement::new()));

        // No declarable variables at all yet - zero regardless of container.
        assert_eq!(DeclarationStatement::get_weight(&state, &mgr, &arena, &[block_id]), 0.0);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let variable = mgr.allocate(int_type);
        mgr.set_storage(variable, Storage::Local);

        // A declarable variable exists, but the container on top of the stack is not a
        // Block - must still be zero.
        assert_eq!(DeclarationStatement::get_weight(&state, &mgr, &arena, &[cond_id]), 0.0);

        // Container is a Block and a declarable variable exists - matches the (quirky,
        // `bool`-typed) base weight, `true` here per `ProgramParameters::default()`.
        assert_eq!(DeclarationStatement::get_weight(&state, &mgr, &arena, &[block_id]), 1.0);
    }

    #[test]
    fn block_statement_new_pushes_a_variable_scope_and_picks_a_child_count_in_range() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_statements_per_block: 4,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();

        for seed in 0..30 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);

            let block = BlockStatement::new(&mut state, &mut mgr);
            assert!((0..=4).contains(&block.num_children_to_create), "seed {seed}");

            // `new` pushed its own scope - popping it must succeed exactly once more
            // than the one `new_var_manager` itself pushed.
            mgr.pop_variable_scope();
            mgr.pop_variable_scope();
        }
    }

    #[test]
    fn block_statement_get_weight_depth_budget_and_anonymous_block_discount() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters {
            max_statement_depth: 3,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);
        let state = new_state_with_budget(&program_params, &shader_params, &mut random);

        let mut arena = StatementArena::new();
        let block_id = arena.insert(Statement::Block(BlockStatement {
            num_children_to_create: 0,
            children: Vec::new(),
        }));
        let cond_id = arena.insert(Statement::Conditional(ConditionalStatement::new()));

        // stack.len() == 1, 1 + 1 == 2 < 3: within budget. Top is a Block -> discount.
        assert_eq!(BlockStatement::get_weight(&state, &arena, &[block_id]), 0.2);
        // Top is a Conditional -> full weight.
        assert_eq!(BlockStatement::get_weight(&state, &arena, &[cond_id]), 1.0);

        // stack.len() == 2, 2 + 1 == 3 < 3 is false: budget exhausted.
        assert_eq!(BlockStatement::get_weight(&state, &arena, &[block_id, cond_id]), 0.0);
    }

    #[test]
    fn conditional_statement_get_weight_respects_use_conditionals_and_depth() {
        let mut program_params = ProgramParameters {
            use_conditionals: false,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters {
            max_statement_depth: 3,
            ..ShaderParameters::default()
        };
        let mut random = Random::new(1);

        {
            let state = new_state_with_budget(&program_params, &shader_params, &mut random);
            // `useConditionals` off -> always zero, regardless of depth.
            assert_eq!(ConditionalStatement::get_weight(&state, &[]), 0.0);
        }

        program_params.use_conditionals = true;
        let state = new_state_with_budget(&program_params, &shader_params, &mut random);

        // stack.len() == 0: availableLevels = 3 - 0 = 3 > 1 -> 1.0.
        assert_eq!(ConditionalStatement::get_weight(&state, &[]), 1.0);
        // stack.len() == 2: availableLevels = 3 - 2 = 1, not > 1 -> 0.0.
        let dummy_stack = [StatementId(0), StatementId(1)];
        assert_eq!(ConditionalStatement::get_weight(&state, &dummy_stack), 0.0);
    }

    /// Hand-built 3-level ancestry (`outer` Conditional -> `inner` Conditional, placed
    /// as `outer`'s *true* branch, with `outer` already carrying a false/else branch),
    /// confirming the dangling-else forcing rule directly against upstream's own
    /// algorithm rather than relying on random dispatch to happen to produce this
    /// shape.
    #[test]
    fn is_else_block_required_true_only_when_child_is_the_true_branch_of_a_parent_with_an_else() {
        let mut arena = StatementArena::new();

        let dummy_false = arena.insert(Statement::Block(BlockStatement {
            num_children_to_create: 0,
            children: Vec::new(),
        }));
        let inner = arena.insert(Statement::Conditional(ConditionalStatement::new()));

        let mut outer_with_else = ConditionalStatement::new();
        outer_with_else.true_statement = Some(inner);
        outer_with_else.false_statement = Some(dummy_false);
        let outer_with_else_id = arena.insert(Statement::Conditional(outer_with_else));

        // Stack: [outer (with else), inner]. `inner` is outer's true branch and outer
        // has a false branch too -> mandatory else.
        assert!(is_else_block_required(&arena, &[outer_with_else_id, inner]));

        let mut outer_no_else = ConditionalStatement::new();
        outer_no_else.true_statement = Some(inner);
        let outer_no_else_id = arena.insert(Statement::Conditional(outer_no_else));

        // Same shape, but outer has no else branch -> not mandatory.
        assert!(!is_else_block_required(&arena, &[outer_no_else_id, inner]));

        // `inner` is the *false* branch of its parent, not the true one -> not mandatory,
        // even though the parent does have a false branch (itself).
        let mut outer_inner_is_false = ConditionalStatement::new();
        outer_inner_is_false.false_statement = Some(inner);
        let outer_inner_is_false_id = arena.insert(Statement::Conditional(outer_inner_is_false));
        assert!(!is_else_block_required(&arena, &[outer_inner_is_false_id, inner]));

        // A Block directly above `inner` stops the search immediately, regardless of
        // what is further up - even if a Conditional two levels up would otherwise say
        // "mandatory".
        let block_parent = arena.insert(Statement::Block(BlockStatement {
            num_children_to_create: 0,
            children: Vec::new(),
        }));
        assert!(!is_else_block_required(
            &arena,
            &[outer_with_else_id, block_parent, inner]
        ));
    }

    #[test]
    fn is_current_top_statement_block_matches_the_arena_discriminant() {
        let mut arena = StatementArena::new();
        let block_id = arena.insert(Statement::Block(BlockStatement {
            num_children_to_create: 0,
            children: Vec::new(),
        }));
        let cond_id = arena.insert(Statement::Conditional(ConditionalStatement::new()));

        assert!(is_current_top_statement_block(&arena, &[cond_id, block_id]));
        assert!(!is_current_top_statement_block(&arena, &[block_id, cond_id]));
    }

    /// Hand-built three-child block (three `AssignStatement`s, each to a distinct
    /// variable with a distinct literal value), confirming both `tokenize` and
    /// `execute` visit them in *reverse* of their own stored (= creation) order - see
    /// this module's top doc comment for why this reversal is faithfully ported rather
    /// than "fixed".
    #[test]
    fn block_statement_tokenizes_and_executes_children_in_reverse_of_their_own_creation_order() {
        let program_params = ProgramParameters::default();
        let shader_params = ShaderParameters::default();
        let mut random = Random::new(1);
        let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = empty_ctx(&empty_2d, &empty_cube);

        let int_type = VariableType::new_basic(Type::Int, 1);
        let var_a = mgr.allocate_named(int_type.clone(), Storage::Local, "a");
        let var_b = mgr.allocate_named(int_type.clone(), Storage::Local, "b");

        let int_literal = |state: &mut GeneratorState<'_>, value: i32| {
            let mut point_range = ValueRange::new(VariableType::new_basic(Type::Int, 1));
            point_range.get_min().set_int(value);
            point_range.get_max().set_int(value);
            Expression::Int(crate::rsg::expression::IntLiteral::new_random(
                state,
                &point_range.as_const_access(),
            ))
        };

        // Both statements write to `var_a`: whichever one actually executes *last*
        // (in real time) wins. If execution order matched naive stored order (A then
        // B) the final value would be B's (20); the real, reverse order means A's
        // value (10) is written last and wins.
        let mut arena = StatementArena::new();

        let literal_a = int_literal(&mut state, 10);
        let assign_a = arena.insert(Statement::Assign(AssignStatement::from_expression(var_a, literal_a)));

        let literal_b = int_literal(&mut state, 20);
        let assign_b = arena.insert(Statement::Assign(AssignStatement::from_expression(var_a, literal_b)));

        // A third, harmless statement to a different variable, just to widen the
        // ordering check beyond two elements.
        let literal_c = int_literal(&mut state, 99);
        let assign_c = arena.insert(Statement::Assign(AssignStatement::from_expression(var_b, literal_c)));

        let block = BlockStatement {
            num_children_to_create: 3,
            children: vec![assign_a, assign_b, assign_c],
        };
        let block_id = arena.insert(Statement::Block(block));

        execute(&mut arena, block_id, &mgr, &mut ctx);
        // Stored order is [A, B, C]; reversed execution runs C, then B, then A - A
        // writes last, so `var_a` ends up holding A's value (10), not B's (20).
        assert_eq!(ctx.get_value(var_a, &int_type).as_int_at(0), 10);
        assert_eq!(ctx.get_value(var_b, &int_type).as_int_at(0), 99);

        let mut stream = TokenStream::new();
        tokenize(
            &arena,
            block_id,
            &mgr,
            Version::Version100,
            ShaderType::Vertex,
            &mut stream,
        );

        // Find the token-stream index of each assignment's own target-variable
        // identifier token, to confirm C's identifier appears before B's, which
        // appears before A's - the reverse of stored/creation order.
        let name_a = mgr.get_variable(var_a).get_name().to_string();
        let name_b = mgr.get_variable(var_b).get_name().to_string();
        let tokens = stream.tokens();
        let ident_positions: Vec<usize> = tokens
            .iter()
            .enumerate()
            .filter(|(_, t)| matches!(t, Token::Identifier(s) if *s == name_a || *s == name_b))
            .map(|(i, _)| i)
            .collect();
        // Three assignments to identifiers: C(b), B(a), A(a), in that printed order.
        assert_eq!(
            ident_positions.len(),
            3,
            "expected exactly 3 identifier tokens, got {tokens:?}"
        );
        let order: Vec<&str> = ident_positions
            .iter()
            .map(|&i| match &tokens[i] {
                Token::Identifier(s) if *s == name_a => "a",
                Token::Identifier(s) if *s == name_b => "b",
                _ => unreachable!(),
            })
            .collect();
        assert_eq!(
            order,
            vec!["b", "a", "a"],
            "C(b) then B(a) then A(a), the reverse of stored order"
        );
    }

    /// End-to-end: drive a `BlockStatement` root to completion via
    /// `statement_generator::drive_to_completion` and confirm the whole mechanism
    /// (statement-stack depth bookkeeping, `BlockStatement`/`ConditionalStatement`
    /// construction, tokenize/execute recursion) runs to completion without panicking
    /// or ever exceeding the configured depth budget - the same `DE_ASSERT((int)
    /// statementStack.size() <= maxStatementDepth)` invariant upstream's own
    /// `FunctionGenerator::generate` loop asserts, re-derived here by hand since this
    /// port has no `FunctionGenerator` of its own yet to assert it yet.
    #[test]
    fn drive_to_completion_never_exceeds_the_configured_statement_depth_budget() {
        let program_params = ProgramParameters {
            use_conditionals: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters {
            max_statement_depth: 3,
            max_statements_per_block: 3,
            max_expression_depth: 3,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();

        for seed in 0..50 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);
            let mut arena = StatementArena::new();

            let root = arena.insert(Statement::Block(BlockStatement::new(&mut state, &mut mgr)));

            // Re-implements `drive_to_completion`'s own loop here (rather than just
            // calling it) so the depth invariant can be asserted at every step.
            let mut stack = vec![root];
            while !stack.is_empty() {
                assert!(
                    stack.len() as i32 <= shader_params.max_statement_depth,
                    "seed {seed}: stack {stack:?} exceeded depth budget"
                );
                match create_next_child(&mut arena, &stack, &mut state, &mut mgr) {
                    Some(child_id) => stack.push(child_id),
                    None => {
                        stack.pop();
                    }
                }
            }

            let mut ctx = empty_ctx(&empty_2d, &empty_cube);
            execute(&mut arena, root, &mgr, &mut ctx);

            let mut stream = TokenStream::new();
            tokenize(&arena, root, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
            assert!(!stream.is_empty(), "seed {seed}");

            // Brace-balance sanity check on the tokenized output: every nested Block
            // must open and close.
            let opens = stream.tokens().iter().filter(|t| **t == Token::LeftBrace).count();
            let closes = stream.tokens().iter().filter(|t| **t == Token::RightBrace).count();
            assert_eq!(opens, closes, "seed {seed}: unbalanced braces");
            assert!(
                opens >= 1,
                "seed {seed}: root block itself must tokenize at least one brace pair"
            );
        }
    }

    /// Same driver, routed through the real `statement_generator::drive_to_completion`
    /// helper (rather than this file's own re-implementation above) - confirms the
    /// public entry point itself works end-to-end, across enough seeds to very likely
    /// exercise at least one `ConditionalStatement` (via `use_conditionals: true`).
    #[test]
    fn public_drive_to_completion_runs_many_seeds_without_panicking() {
        let program_params = ProgramParameters {
            use_conditionals: true,
            ..ProgramParameters::default()
        };
        let shader_params = ShaderParameters {
            max_statement_depth: 4,
            max_statements_per_block: 4,
            max_expression_depth: 3,
            ..ShaderParameters::default()
        };
        let mut alloc = NameAllocator::new();

        for seed in 0..50 {
            let mut random = Random::new(seed);
            let mut state = new_state_with_budget(&program_params, &shader_params, &mut random);
            let mut mgr = new_var_manager(&mut alloc);
            let mut arena = StatementArena::new();

            let root = arena.insert(Statement::Block(BlockStatement::new(&mut state, &mut mgr)));
            statement_generator::drive_to_completion(&mut arena, root, &mut state, &mut mgr);

            let mut stream = TokenStream::new();
            tokenize(&arena, root, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);
            assert!(!stream.is_empty(), "seed {seed}");
        }
    }
}
