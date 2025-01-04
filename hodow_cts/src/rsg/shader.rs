// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgShader.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **Scope of this file, deliberately narrow**: the `Shader`/`Function`/`ShaderInput`
// *data model* and its plain accessors, plus the two methods (`tokenize`/`execute`)
// that walk that data without generating anything new - never `rsgShaderGenerator`'s
// own randomized-construction algorithm, `rsgProgramGenerator`, or
// `rsgFunctionGenerator`. Those stay for a future integration session once this and
// the sibling statement-stack work have both landed, per this effort's own standing
// plan (see `rsg/mod.rs`'s own top doc comment).
//
// **`Function::m_functionBlock` (a `BlockStatement`, embedded by value upstream) has no
// real translation here yet.** `BlockStatement` itself landed in a sibling stream of
// this same effort (see `rsg::statement`'s own top doc comment for its arena-based
// design), merged in afterward - `Function::body`/`Shader::global_statements` were
// updated at that point from a plain `Vec<Statement>` to `Vec<StatementId>` against the
// `Shader`'s own `statement_arena` (the same `StatementArena` every `BlockStatement`
// uses), so they at least share one consistent storage model with the rest of `rsg`
// now. They are still **not** a drop-in for the real `BlockStatement`: each is a flat,
// brace-less sequence tokenized/executed in forward (declaration) order with no scope
// of its own and no weighted, statement-stack-aware random child-creation protocol -
// upstream's real `m_functionBlock` has both. Replace `Function::body`'s type with a
// single root `StatementId` pointing at a real `Statement::Block` once a future
// integration session threads the statement stack through `Shader`/`ShaderGenerator`,
// rather than extending this flat-`Vec` shape further.
//
// **`Shader::allocateFunction` is declared in `rsgShader.hpp` but never defined
// anywhere in `framework/randomshaders/`** (grepped the whole directory) - the same
// "declared, never defined" dead-API shape `rsg::variable`'s own doc comment already
// found for `Variable::isWritable`. A direct consequence, also confirmed by grep: since
// `allocateFunction` is the *only* thing upstream ever offers to populate `m_functions`,
// and it has no body, `m_functions` can never hold anything in any real upstream build -
// `Shader::tokenize`'s/`execute`'s own loop over it is reachable code that can never
// iterate more than zero times today. Not ported here either, for the same reason: there
// is no body to port, and guessing one (e.g. `Vec::push` plus a fresh default `Function`)
// would not be a port of upstream behaviour at all. `Shader::functions` stays as a field
// (for data-model fidelity and so `tokenize`/`execute` have something real to iterate
// over once a future session gives it a genuine populator) with a read-only accessor
// only.
//
// **`ShaderInput` reuses the already-ported `rsg::variable_value::ValueRange`** rather
// than hand-rolling the two `Vec<Scalar>` fields (`m_min`/`m_max`) upstream's own
// constructor manually copies a `ConstValueRangeAccess` into - `ValueRange::from_access`
// already performs exactly that copy (see its own doc comment in `variable_value.rs`),
// so this is a genuine simplification (same stored bytes, no behaviour change), not a
// deviation.
//
// **`ShaderInput`/`Shader`'s global scope store `VariableId` handles, not `&Variable`
// pointers** - the same `VariableManager`-owned-arena translation every other module in
// this cluster already uses (see `rsg::variable_manager`'s own top doc comment).
// Resolving a name or a storage class back out of one needs an explicit
// `&VariableManager` parameter, which is why `Shader::get_outputs`/the three
// `Shader`-dependent `rsg::utils` functions all take one - the same explicit-threading
// convention `rsg::generator_state`'s own top doc comment lays out for `Shader` itself
// (not stored inside `GeneratorState`, passed alongside it).
//
// **`Shader::tokenize` needs no `&mut GeneratorState`** despite upstream taking a
// non-`const` `GeneratorState&`: the one thing it actually reads off `state` is
// `getProgramParameters().version` (a `const`-reachable getter even in upstream), and
// the one thing it reads off `state.getShader()` is `getType()` - which, called from
// `Shader::tokenize` itself, is always just `self.get_type()` (upstream's `state`
// parameter only ever points back at the very `Shader` whose own method is running), so
// no second reference to `self` through `state` is needed at all, and the aliasing
// problem `rsg::generator_state`'s own top doc comment warns about never arises here.

use super::execution_context::ExecutionContext;
use super::generator_state::GeneratorState;
use super::parameters::Version;
use super::statement::{StatementArena, StatementId};
use super::token::{Token, TokenStream};
use super::variable::{ShaderType, Storage, Variable};
use super::variable_manager::{VariableId, VariableManager, VariableScope};
use super::variable_type::VariableType;
use super::variable_value::{ConstValueRangeAccess, ValueRange, ValueRangeAccess};

/// `rsg::ShaderInput` - one shader-level input or uniform: which `Variable` it is, and
/// the value range the generator promised to keep it within. See this module's own top
/// doc comment for why this holds a `VariableId` plus an owned `ValueRange`, not
/// upstream's `const Variable*` plus two raw `Vec<Scalar>`.
///
/// **Also stores its own `name: String`, added once `rsg::shader_generator`/
/// `rsg::program_generator` existed as real callers** - upstream's `const Variable*`
/// gives `getVariable()->getName()` "for free" (the pointer stays valid and resolvable
/// without any manager), but this port's `VariableId` only resolves against the
/// *specific* `VariableManager` that allocated it (see `rsg::shader_generator`'s own top
/// doc comment on why `outputs` is a `(VariableType, String, ValueRange)` triple rather
/// than a `&[ShaderInput]` for exactly this reason). `ProgramGenerator::generate`'s own
/// real call shape needs a *finished* shader's own `ShaderInput`s' names *after* that
/// shader's own `VariableManager` has already gone out of scope (it feeds the fragment
/// shader's inputs as the vertex shader's own `outputs`) - without storing the name here
/// too, that information would be unrecoverable at that point. The `VariableId` field
/// stays (nothing in this port has removed the need to resolve type/storage against the
/// *producing* manager while it is still alive, e.g. inside `rsg::shader_generator::
/// generate`'s own "Declare live global variables" block), so this is an addition, not a
/// replacement.
pub struct ShaderInput {
    variable: VariableId,
    name: String,
    value_range: ValueRange,
}

impl ShaderInput {
    /// `ShaderInput::ShaderInput(const Variable*, ConstValueRangeAccess)` - copies
    /// `value_range` into its own storage via `ValueRange::from_access` (see this
    /// module's own top doc comment), plus an explicit `name` (see this struct's own
    /// doc comment for why).
    pub fn new(variable: VariableId, name: impl Into<String>, value_range: &ConstValueRangeAccess<'_>) -> Self {
        Self {
            variable,
            name: name.into(),
            value_range: ValueRange::from_access(value_range),
        }
    }

    pub fn get_variable(&self) -> VariableId {
        self.variable
    }

    pub fn get_name(&self) -> &str {
        &self.name
    }

    pub fn get_value_range(&self) -> ConstValueRangeAccess<'_> {
        self.value_range.as_const_access()
    }

    pub fn get_value_range_mut(&mut self) -> ValueRangeAccess<'_> {
        self.value_range.as_access()
    }
}

/// `rsg::Function` - see this module's own top doc comment for why `body` is a plain
/// `Vec<StatementId>` (into the owning `Shader`'s own `StatementArena`, passed
/// explicitly to `tokenize`/`execute` below) standing in for upstream's `BlockStatement
/// m_functionBlock`.
pub struct Function {
    name: String,
    parameters: Vec<VariableId>,
    return_type: VariableType,
    body: Vec<StatementId>,
}

impl Function {
    /// `Function::Function(const char *name)`
    pub fn new(name: impl Into<String>) -> Self {
        Self {
            name: name.into(),
            parameters: Vec::new(),
            return_type: VariableType::default(),
            body: Vec::new(),
        }
    }

    pub fn get_name(&self) -> &str {
        &self.name
    }

    pub fn get_return_type(&self) -> &VariableType {
        &self.return_type
    }

    pub fn set_return_type(&mut self, type_: VariableType) {
        self.return_type = type_;
    }

    /// `Function::addParameter`
    pub fn add_parameter(&mut self, variable: VariableId) {
        self.parameters.push(variable);
    }

    pub fn get_parameters(&self) -> &[VariableId] {
        &self.parameters
    }

    /// `Function::getBody` - see this module's own top doc comment: a plain
    /// `Vec<StatementId>`, not the real `BlockStatement` upstream returns here.
    pub fn get_body(&self) -> &[StatementId] {
        &self.body
    }

    pub fn get_body_mut(&mut self) -> &mut Vec<StatementId> {
        &mut self.body
    }

    /// `Function::tokenize` - return type, name, parenthesised parameter declarations
    /// (comma-separated, each via `Variable::tokenize_declaration`), then the body's
    /// own statements in forward order (see this module's own top doc comment on why
    /// this is not `BlockStatement::tokenize`, which would additionally wrap them in
    /// braces and indentation). `arena` is the owning `Shader`'s own `StatementArena` -
    /// `Function` itself stores only `StatementId`s, never statements.
    pub fn tokenize(
        &self,
        arena: &StatementArena,
        var_manager: &VariableManager<'_>,
        version: Version,
        shader_type: ShaderType,
        stream: &mut TokenStream,
    ) {
        self.return_type.tokenize_short_type(stream);

        debug_assert!(!self.name.is_empty());
        stream.push(Token::identifier(self.name.clone()));

        stream.push(Token::LeftParen);
        for (ndx, param) in self.parameters.iter().enumerate() {
            if ndx != 0 {
                stream.push(Token::Comma);
            }
            var_manager
                .get_variable(*param)
                .tokenize_declaration(version, shader_type, stream);
        }
        stream.push(Token::RightParen);
        stream.push(Token::Newline);

        for &id in &self.body {
            super::statement::tokenize(arena, id, var_manager, version, shader_type, stream);
        }
    }

    /// `Function::getBody().execute(execCtx)` as called from `Shader::execute` - see
    /// this module's own top doc comment on why there is no real `BlockStatement` to
    /// delegate to. `arena` is the owning `Shader`'s own `StatementArena`.
    pub fn execute(
        &mut self,
        arena: &mut StatementArena,
        var_manager: &VariableManager<'_>,
        ctx: &mut ExecutionContext<'_>,
    ) {
        for &id in &self.body {
            super::statement::execute(arena, id, var_manager, ctx);
        }
    }
}

impl Default for Function {
    /// `Function::Function(void)` - an empty name, matching upstream's own default
    /// `std::string` construction (`debug_assert!(!self.name.is_empty())` in
    /// `tokenize` means this value must be renamed via nothing this port offers yet
    /// before it is ever tokenized, exactly like upstream's own `DE_ASSERT(m_name !=
    /// "")`).
    fn default() -> Self {
        Self::new(String::new())
    }
}

/// `rsg::Shader` - see this module's own top doc comment for the overall scope and for
/// why `functions`/the function body shape are what they are.
pub struct Shader {
    type_: ShaderType,

    global_scope: VariableScope,
    global_statements: Vec<StatementId>,
    statement_arena: StatementArena,

    inputs: Vec<ShaderInput>,
    uniforms: Vec<ShaderInput>,

    functions: Vec<Function>,
    main_function: Function,

    source: String,

    /// The generator's variable arena, kept so the `VariableId`s above stay resolvable
    /// after generation (upstream's `Variable*` stay valid for as long as the shader).
    #[allow(clippy::vec_box)]
    variables: Vec<Box<Variable>>,
}

/// Every mutable `Shader` field `rsg::shader_generator`/`rsg::function_generator` need at
/// once, borrowed out together via `Shader::fields_mut` - see that method's own doc
/// comment for why this exists at all rather than a handful of separate accessor calls.
pub struct ShaderFieldsMut<'a> {
    pub global_scope: &'a mut VariableScope,
    pub global_statements: &'a mut Vec<StatementId>,
    pub statement_arena: &'a mut StatementArena,
    pub inputs: &'a mut Vec<ShaderInput>,
    pub uniforms: &'a mut Vec<ShaderInput>,
    pub main_function: &'a mut Function,
}

impl Shader {
    /// `Shader::Shader(Type)` - `m_mainFunction("main")`, matching upstream's own
    /// member-initializer-list construction exactly.
    pub fn new(type_: ShaderType) -> Self {
        Self {
            type_,
            global_scope: VariableScope::new(),
            global_statements: Vec::new(),
            statement_arena: StatementArena::new(),
            inputs: Vec::new(),
            uniforms: Vec::new(),
            functions: Vec::new(),
            main_function: Function::new("main"),
            source: String::new(),
            variables: Vec::new(),
        }
    }

    /// Stores the arena of the `VariableManager` that generated this shader.
    #[allow(clippy::vec_box)]
    pub fn set_variables(&mut self, variables: Vec<Box<Variable>>) {
        self.variables = variables;
    }

    /// Hands the arena out, for `VariableManager::from_variables`; leaves the shader without one.
    #[allow(clippy::vec_box)]
    pub fn take_variables(&mut self) -> Vec<Box<Variable>> {
        std::mem::take(&mut self.variables)
    }

    /// The single `StatementArena` this `Shader` and every one of its `Function`s
    /// (including `main`) share - every `StatementId` stored in `global_statements` or
    /// any `Function::body` is only valid against this arena.
    pub fn statement_arena_mut(&mut self) -> &mut StatementArena {
        &mut self.statement_arena
    }

    pub fn statement_arena(&self) -> &StatementArena {
        &self.statement_arena
    }

    pub fn get_type(&self) -> ShaderType {
        self.type_
    }

    pub fn get_source(&self) -> &str {
        &self.source
    }

    pub fn set_source(&mut self, source: impl Into<String>) {
        self.source = source.into();
    }

    pub fn get_main(&self) -> &Function {
        &self.main_function
    }

    pub fn get_main_mut(&mut self) -> &mut Function {
        &mut self.main_function
    }

    pub fn get_global_scope(&self) -> &VariableScope {
        &self.global_scope
    }

    pub fn get_global_scope_mut(&mut self) -> &mut VariableScope {
        &mut self.global_scope
    }

    pub fn get_global_statements(&self) -> &[StatementId] {
        &self.global_statements
    }

    pub fn get_global_statements_mut(&mut self) -> &mut Vec<StatementId> {
        &mut self.global_statements
    }

    pub fn get_inputs(&self) -> &[ShaderInput] {
        &self.inputs
    }

    pub fn get_inputs_mut(&mut self) -> &mut Vec<ShaderInput> {
        &mut self.inputs
    }

    pub fn get_uniforms(&self) -> &[ShaderInput] {
        &self.uniforms
    }

    pub fn get_uniforms_mut(&mut self) -> &mut Vec<ShaderInput> {
        &mut self.uniforms
    }

    /// Read-only: see this module's own top doc comment for why nothing here can
    /// populate `functions` (upstream's own `allocateFunction` is dead, unimplemented
    /// API).
    pub fn get_functions(&self) -> &[Function] {
        &self.functions
    }

    /// Splits `self` into every field `rsg::shader_generator`/`rsg::function_generator`
    /// need *simultaneously* - e.g. a function body's own root `BlockStatement` lives in
    /// `statement_arena` while the `StatementId` naming it is stored on `main_function`,
    /// so building one requires both at once. A free function outside this `impl` block
    /// cannot get that by calling `get_main_mut()` and `statement_arena_mut()` as two
    /// separate top-level calls on the same `&mut Shader` - each accessor method's
    /// signature conservatively borrows *all* of `*self` for as long as its returned
    /// reference lives (Rust does not look inside a called method's body to see that it
    /// only touches one field), so the two borrows would overlap and fail to
    /// borrow-check even though the underlying fields are genuinely disjoint. Returning
    /// every needed field from *one* method call, via direct field-projection
    /// expressions (`&mut self.main_function`, not `self.get_main_mut()`), is the
    /// standard fix: the borrow checker *does* understand that `&mut self.a` and
    /// `&mut self.b` are disjoint when both appear as literal field paths in the same
    /// expression, which is exactly what `Shader::execute`'s own existing body already
    /// relies on (`self.main_function.execute(&mut self.statement_arena, ...)`).
    pub fn fields_mut(&mut self) -> ShaderFieldsMut<'_> {
        ShaderFieldsMut {
            global_scope: &mut self.global_scope,
            global_statements: &mut self.global_statements,
            statement_arena: &mut self.statement_arena,
            inputs: &mut self.inputs,
            uniforms: &mut self.uniforms,
            main_function: &mut self.main_function,
        }
    }

    /// `Shader::getOutputs` - upstream fills a `std::vector<const Variable*>` out
    /// parameter; this returns the matching `VariableId`s instead; a caller wanting the
    /// `Variable`s themselves resolves each through the same `var_manager` it already
    /// had to pass in.
    pub fn get_outputs(&self, var_manager: &VariableManager<'_>) -> Vec<VariableId> {
        self.global_scope
            .get_declared_variables()
            .iter()
            .copied()
            .filter(|&id| var_manager.get_variable(id).get_storage() == Storage::ShaderOut)
            .collect()
    }

    /// `Shader::tokenize` - see this module's own top doc comment for why this needs
    /// only a shared `&GeneratorState`, and why the two `Vec`s below are walked in
    /// reverse (matching upstream's own `for (ndx = size()-1; ndx >= 0; ndx--)`
    /// exactly, not reasoned about further - the loop direction only matters once
    /// something actually populates these lists in the order a future `ShaderGenerator`
    /// port will build them in).
    pub fn tokenize(&self, var_manager: &VariableManager<'_>, state: &GeneratorState<'_>, stream: &mut TokenStream) {
        let version = state.get_program_parameters().version;
        let shader_type = self.type_;

        // Add default precision for float in fragment shaders. \todo [pyry] Proper
        // precision handling - upstream's own `\todo`, carried over unfixed.
        if shader_type == ShaderType::Fragment {
            stream
                .push(Token::Precision)
                .push(Token::MediumPrecision)
                .push(Token::Float)
                .push(Token::Semicolon)
                .push(Token::Newline);
        }

        // Tokenize global declaration statements.
        for &id in self.global_statements.iter().rev() {
            super::statement::tokenize(&self.statement_arena, id, var_manager, version, shader_type, stream);
        }

        // Tokenize all (non-main) functions.
        for func in self.functions.iter().rev() {
            stream.push(Token::Newline);
            func.tokenize(&self.statement_arena, var_manager, version, shader_type, stream);
        }

        // Tokenize main.
        stream.push(Token::Newline);
        self.main_function
            .tokenize(&self.statement_arena, var_manager, version, shader_type, stream);
    }

    /// `Shader::execute` - global statements (in the same reverse order `tokenize`
    /// uses, matching upstream's own `rbegin()`/`rend()`), then the main function's
    /// body.
    pub fn execute(&mut self, var_manager: &VariableManager<'_>, ctx: &mut ExecutionContext<'_>) {
        for &id in self.global_statements.iter().rev() {
            super::statement::execute(&mut self.statement_arena, id, var_manager, ctx);
        }

        self.main_function.execute(&mut self.statement_arena, var_manager, ctx);
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use super::*;
    use crate::rsg::execution_context::EXEC_VEC_WIDTH;
    use crate::rsg::expression::{Expression, IntLiteral};
    use crate::rsg::name_allocator::NameAllocator;
    use crate::rsg::parameters::ProgramParameters;
    use crate::rsg::samplers::{Sampler2DMap, SamplerCubeMap};
    use crate::rsg::statement::{AssignStatement, Statement};
    use crate::rsg::token::Token;
    use crate::rsg::variable_manager::ValueScope;
    use crate::rsg::variable_type::Type;
    use crate::tcu::random::Random;

    fn new_var_manager(alloc: &mut NameAllocator) -> VariableManager<'_> {
        let mut mgr = VariableManager::new(alloc);
        mgr.push_variable_scope(VariableScope::new());
        mgr.push_value_scope(ValueScope::new());
        mgr
    }

    /// A point-range (min == max) `IntLiteral`, so its evaluated/tokenized value is
    /// deterministic regardless of the RNG seed - the same trick `rsg::statement`'s own
    /// tests already use.
    fn literal_int(value: i32) -> Expression {
        let type_ = VariableType::new_basic(Type::Int, 1);
        let mut range = ValueRange::new(type_);
        range.get_min().set_int(value);
        range.get_max().set_int(value);

        let params = ProgramParameters::default();
        let mut random = Random::new(1);
        let mut state = GeneratorState::new(&params, &mut random);
        Expression::Int(IntLiteral::new_random(&mut state, &range.as_const_access()))
    }

    #[test]
    fn shader_input_new_copies_the_value_range_and_remembers_its_variable() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let int_type = VariableType::new_basic(Type::Int, 1);
        let var = mgr.allocate_named(int_type.clone(), Storage::Uniform, "u_count");

        let mut range = ValueRange::new(int_type);
        range.get_min().set_int(1);
        range.get_max().set_int(5);

        let input = ShaderInput::new(var, "u_count", &range.as_const_access());
        assert_eq!(input.get_variable(), var);
        assert_eq!(input.get_name(), "u_count");
        assert_eq!(input.get_value_range().get_min().as_int(), 1);
        assert_eq!(input.get_value_range().get_max().as_int(), 5);
    }

    #[test]
    fn new_shader_has_a_main_function_named_main_and_empty_lists() {
        let shader = Shader::new(ShaderType::Vertex);
        assert_eq!(shader.get_type(), ShaderType::Vertex);
        assert_eq!(shader.get_main().get_name(), "main");
        assert!(shader.get_source().is_empty());
        assert!(shader.get_inputs().is_empty());
        assert!(shader.get_uniforms().is_empty());
        assert!(shader.get_functions().is_empty());
        assert!(shader.get_global_statements().is_empty());
        assert!(shader.get_global_scope().get_declared_variables().is_empty());
    }

    #[test]
    fn set_source_and_get_source_round_trip() {
        let mut shader = Shader::new(ShaderType::Fragment);
        shader.set_source("void main() {}");
        assert_eq!(shader.get_source(), "void main() {}");
    }

    #[test]
    fn get_outputs_filters_declared_variables_by_shader_out_storage() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let out_var = mgr.allocate_named(VariableType::new_basic(Type::Float, 4), Storage::ShaderOut, "o_color");
        let local_var = mgr.allocate_named(VariableType::new_basic(Type::Int, 1), Storage::Local, "n");
        mgr.declare_variable(out_var);
        mgr.declare_variable(local_var);
        let global_scope = mgr.pop_variable_scope();
        let _ = mgr.pop_value_scope();

        let mut shader = Shader::new(ShaderType::Vertex);
        *shader.get_global_scope_mut() = global_scope;

        let outputs = shader.get_outputs(&mgr);
        assert_eq!(outputs, vec![out_var]);
    }

    #[test]
    fn function_tokenize_emits_return_type_name_parenthesised_parameters_and_body() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);

        let a = mgr.allocate_named(VariableType::new_basic(Type::Float, 1), Storage::ParameterIn, "a");
        let b = mgr.allocate_named(VariableType::new_basic(Type::Float, 1), Storage::ParameterIn, "b");

        let mut func = Function::new("foo");
        func.set_return_type(VariableType::new_basic(Type::Float, 1));
        func.add_parameter(a);
        func.add_parameter(b);
        assert_eq!(func.get_parameters(), &[a, b]);

        let arena = StatementArena::new();
        let mut stream = TokenStream::new();
        func.tokenize(&arena, &mgr, Version::Version100, ShaderType::Vertex, &mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::Float,
                Token::identifier("foo"),
                Token::LeftParen,
                Token::In,
                Token::Float,
                Token::identifier("a"),
                Token::Comma,
                Token::In,
                Token::Float,
                Token::identifier("b"),
                Token::RightParen,
                Token::Newline,
            ]
        );
    }

    #[test]
    fn function_default_has_an_empty_name_matching_the_upstream_default_constructor() {
        let func = Function::default();
        assert_eq!(func.get_name(), "");
        assert_eq!(*func.get_return_type(), VariableType::default());
        assert!(func.get_parameters().is_empty());
        assert!(func.get_body().is_empty());
    }

    #[test]
    fn shader_tokenize_of_an_empty_vertex_shader_is_just_the_main_function_signature() {
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let shader = Shader::new(ShaderType::Vertex);

        let params = crate::rsg::parameters::ProgramParameters::default();
        let mut random = Random::new(1);
        let state = GeneratorState::new(&params, &mut random);

        let mut stream = TokenStream::new();
        shader.tokenize(&mgr, &state, &mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::Newline,
                Token::Void,
                Token::identifier("main"),
                Token::LeftParen,
                Token::RightParen,
                Token::Newline
            ]
        );
    }

    #[test]
    fn shader_tokenize_of_a_fragment_shader_adds_the_default_float_precision_line_first() {
        let mut alloc = NameAllocator::new();
        let mgr = new_var_manager(&mut alloc);
        let shader = Shader::new(ShaderType::Fragment);

        let params = crate::rsg::parameters::ProgramParameters::default();
        let mut random = Random::new(1);
        let state = GeneratorState::new(&params, &mut random);

        let mut stream = TokenStream::new();
        shader.tokenize(&mgr, &state, &mut stream);

        assert_eq!(
            stream.tokens(),
            &[
                Token::Precision,
                Token::MediumPrecision,
                Token::Float,
                Token::Semicolon,
                Token::Newline,
                Token::Newline,
                Token::Void,
                Token::identifier("main"),
                Token::LeftParen,
                Token::RightParen,
                Token::Newline,
            ]
        );
    }

    #[test]
    fn shader_execute_runs_global_statements_in_reverse_push_order_then_main() {
        let mut alloc = NameAllocator::new();
        let mut mgr = new_var_manager(&mut alloc);
        let empty_2d: Sampler2DMap = HashMap::new();
        let empty_cube: SamplerCubeMap = HashMap::new();
        let mut ctx = ExecutionContext::new(&empty_2d, &empty_cube);

        let var = mgr.allocate(VariableType::new_basic(Type::Int, 1));
        mgr.set_storage(var, Storage::Local);

        let mut shader = Shader::new(ShaderType::Vertex);
        // Pushed first, so - matching upstream's own `rbegin()`/`rend()` reverse walk -
        // this is the *last* one to run and therefore wins.
        let first_id = shader
            .statement_arena_mut()
            .insert(Statement::Assign(AssignStatement::from_expression(var, literal_int(1))));
        shader.get_global_statements_mut().push(first_id);
        // Pushed second, runs first, gets immediately overwritten.
        let second_id = shader
            .statement_arena_mut()
            .insert(Statement::Assign(AssignStatement::from_expression(var, literal_int(2))));
        shader.get_global_statements_mut().push(second_id);

        shader.execute(&mgr, &mut ctx);

        let var_type = mgr.get_variable(var).get_type().clone();
        for lane in 0..EXEC_VEC_WIDTH {
            assert_eq!(ctx.get_value(var, &var_type).as_int_at(lane), 1);
        }

        // The main function body runs after every global statement and overrides it.
        let main_id = shader
            .statement_arena_mut()
            .insert(Statement::Assign(AssignStatement::from_expression(
                var,
                literal_int(99),
            )));
        shader.get_main_mut().get_body_mut().push(main_id);
        shader.execute(&mgr, &mut ctx);
        for lane in 0..EXEC_VEC_WIDTH {
            assert_eq!(ctx.get_value(var, &var_type).as_int_at(lane), 99);
        }
    }
}
