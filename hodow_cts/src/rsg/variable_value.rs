// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/randomshaders/rsgVariableValue.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// **`VariableValue` is now ported too** (added once `rsg::variable` existed - its own
// header turned out to be a genuine leaf despite the `.cpp` needing `GeneratorState`/
// `Shader` for one unrelated method, found by checking *which methods* use the heavier
// includes rather than stopping at the file-level include list). Holds a borrowed
// `&'a Variable` rather than upstream's `const Variable*` - a plain Rust reference is
// the direct, safe translation for a pointer this port never needs to rebind or store
// past the borrow's own lifetime.
//
// **`Stride` is a runtime field (`usize`), not a const generic.** Upstream's
// `StridedValueAccess<int Stride>`/`ValueStorage<int Stride>` are templates so the
// compiler can specialise the Stride==1 case away entirely; nothing in this port's own
// consumers demands compile-time specialisation, so a runtime field is the plainer
// translation per this project's own established `rr::primitive_types` precedent
// (replacing a compile-time `PrimitiveTypeTraits<T>` dispatch with a runtime one once
// nothing forces the compile-time shape).
// `rsg::execution_context` is the `Stride == 64` consumer (`ValueStorage::with_type(EXEC_VEC_WIDTH, ...)`).
//
// **Every access type here owns its `VariableType` by value (a clone), rather than
// borrowing one with a lifetime.** Upstream's `getType()` returns a `const
// VariableType&` upstream can freely hand out because `VariableType::getElementType`
// returns a reference to either a function-local `static` (for a vector/sampler's
// scalar component type) or to `m_elementType` (an owned field, for an array). This
// port's own `rsg::variable_type::VariableType::element_type()` deliberately returns by
// value instead (that module's own doc comment explains why: nothing here needs the
// C++ static-storage-duration trick) - which means a Rust `component()`/`array_element()`
// that recurses into the *result* of `element_type()` has no borrow to hand back at all.
// Cloning the type into each access is the direct fix: `VariableType` is cheap (the
// same reasoning that module's own doc comment already gives for returning it by value
// in the first place), and every access here is a short-lived transient object, never
// stored past the expression that builds it.
//
// **`Scalar` is a bit-pattern newtype around `i32`, not a C `union`.** Upstream's
// `union Scalar { int intVal; float floatVal; bool boolVal; }` relies on C++'s
// "read whichever member you want, your problem" unions, including a genuine latent
// UB spot this port does not reproduce: `Scalar(bool v) : boolVal(v) {}` only
// initialises the one-byte `bool` member, leaving the union's other three bytes
// indeterminate, so two bit-exact-compared `Scalar(true)` values are not actually
// guaranteed equal by the C++ standard (only by what a real compiler happens to do).
// This port's `Scalar(i32)` always holds a fully-defined 4-byte pattern (`0`/`1` for a
// bool), which is strictly *more* defined than upstream, not a narrowing - nothing here
// could observe the difference since nothing here ever relied on the UB either.
//
// **Not ported, and - unlike most other "not yet" notes in this cluster - genuinely
// never going to need to be**: `Scalar::as<T>()`'s generic form and
// `StridedValueAccess::operator=(const tcu::Vector<float, Size>&)`. `rsgExpression` (including `ConstructorOp`'s scalar-conversion path and `TexLookup`, the two
// plausible callers) needs neither - confirmed by grepping the whole `framework/randomshaders/`
// tree for real call sites, not just this port's own code. `ConstructorOp`'s
// `convert_exec_value` (`rsg::expression`) reproduces `convertExecValue`'s generic
// template entirely through an explicit 9-way `(src_type, dst_type)` match over
// `as_float_at`/`as_int_at`/`as_bool_at`, never needing `Scalar::as<T>()`'s own
// genericity - the concrete per-type accessors this file already has were always
// enough. `TexLookup::evaluate` (`rsgExpression.cpp`'s own body, read in full) assigns
// its sampled `tcu::Vec4` through a plain `for comp in 0..4: dst.component(comp).
// asFloat(i) = p[comp]` loop, never through the `Vector<float, Size>` operator either -
// and that operator has **no call site anywhere in `framework/randomshaders/` at all**,
// in any file, confirmed by grep (`StridedValueAccess::operator=(const tcu::Vector<float,
// Size>&)` is declared and defined in `rsgVariableValue.hpp` and never once invoked) -
// the same "declared, never called" dead-upstream-API shape this project has already
// found repeatedly elsewhere (`Variable::isWritable`, `Shader::allocateFunction`), just
// with the defining and the non-calling both inside the same header this time. Its own
// narrow upstream bug (unconditionally looping `for comp in 0..4` regardless of `Size`,
// so a `Size < 4` vector assignment would read past its own data) is therefore moot:
// there is no live call site anywhere upstream for a faithful port to reproduce that bug
// against.
//
// **`StridedValueAccess::asFloat(int)`/`asInt(int)`/`asBool(int)`/`asScalar(int)`'s
// mutable, reference-returning overloads were initially missed** - only the read-only
// `ConstStridedValueAccess` side of the indexed family was ported, because nothing at
// the time needed to *write* through a `Stride > 1` access. `rsg::execution_context`
// (ported later, `EXEC_VEC_WIDTH == 64`) is that first real consumer
// (`set_float_at`/`set_int_at`/`set_bool_at`/`set_scalar_at`, added alongside it) -
// exactly the gap this module's own "Stride is a runtime field" note above predicted
// would eventually need filling in.

use super::variable_type::VariableType;

/// `rsg::Scalar` - see this module's own top doc comment for why this is a bit-pattern
/// newtype rather than a C-style union.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Scalar(i32);

impl Scalar {
    pub fn zero() -> Self {
        Scalar(0)
    }

    pub fn from_float(v: f32) -> Self {
        Scalar(v.to_bits() as i32)
    }

    pub fn from_int(v: i32) -> Self {
        Scalar(v)
    }

    pub fn from_bool(v: bool) -> Self {
        Scalar(v as i32)
    }

    pub fn as_float(self) -> f32 {
        f32::from_bits(self.0 as u32)
    }

    pub fn as_int(self) -> i32 {
        self.0
    }

    pub fn as_bool(self) -> bool {
        self.0 != 0
    }

    /// `Scalar::min<float>` - the bit pattern `0xff800000`, negative infinity.
    pub fn min_float() -> Self {
        Scalar(0xff800000u32 as i32)
    }
    /// `Scalar::max<float>` - the bit pattern `0x7f800000`, positive infinity.
    pub fn max_float() -> Self {
        Scalar(0x7f800000u32 as i32)
    }
    pub fn min_int() -> Self {
        Scalar(i32::MIN)
    }
    pub fn max_int() -> Self {
        Scalar(i32::MAX)
    }
    pub fn min_bool() -> Self {
        Scalar::from_bool(false)
    }
    pub fn max_bool() -> Self {
        Scalar::from_bool(true)
    }
}

/// `rsg::StridedValueRead<Stride>` - a read-only (type, value-slice, stride) triple,
/// used only to carry a source value into `StridedValueAccess::assign_from` (the
/// `operator=(const StridedValueRead<SrcStride>&)` upstream overload).
pub struct StridedValueRead<'a> {
    type_: VariableType,
    value: &'a [Scalar],
    stride: usize,
}

/// `rsg::ConstStridedValueAccess<Stride>` - read-only access to a scalar value of
/// `type_`, laid out with `stride` scalars between logical components (`stride == 1` is
/// the plain, non-interleaved case every current caller uses). `value` is a slice from
/// the component's own base offset to the *end* of the underlying storage, not sized
/// exactly to this component - re-slicing (`component`/`array_element`/`member`) only
/// ever moves the start forward, mirroring upstream's raw-pointer-plus-trust-the-type
/// shape while still getting Rust's own bounds checking on every actual element read.
/// See this module's top doc comment for why `type_` is an owned clone, not a borrow.
#[derive(Clone)]
pub struct ConstStridedValueAccess<'a> {
    type_: VariableType,
    value: &'a [Scalar],
    stride: usize,
}

impl<'a> ConstStridedValueAccess<'a> {
    pub fn new(type_: VariableType, value: &'a [Scalar], stride: usize) -> Self {
        Self { type_, value, stride }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn component(&self, comp_ndx: i32) -> ConstStridedValueAccess<'a> {
        ConstStridedValueAccess::new(
            self.type_.element_type(),
            &self.value[self.stride * comp_ndx as usize..],
            self.stride,
        )
    }

    pub fn array_element(&self, element_ndx: i32) -> ConstStridedValueAccess<'a> {
        let offset = self.type_.element_scalar_offset(element_ndx) as usize;
        ConstStridedValueAccess::new(
            self.type_.element_type(),
            &self.value[self.stride * offset..],
            self.stride,
        )
    }

    pub fn member(&self, member_ndx: i32) -> ConstStridedValueAccess<'a> {
        let offset = self.type_.member_scalar_offset(member_ndx) as usize;
        let member_type = self.type_.members()[member_ndx as usize].get_type().clone();
        ConstStridedValueAccess::new(member_type, &self.value[self.stride * offset..], self.stride)
    }

    pub fn as_float(&self) -> f32 {
        debug_assert_eq!(self.stride, 1);
        self.value[0].as_float()
    }
    pub fn as_int(&self) -> i32 {
        debug_assert_eq!(self.stride, 1);
        self.value[0].as_int()
    }
    pub fn as_bool(&self) -> bool {
        debug_assert_eq!(self.stride, 1);
        self.value[0].as_bool()
    }
    pub fn as_scalar(&self) -> Scalar {
        debug_assert_eq!(self.stride, 1);
        self.value[0]
    }

    pub fn as_float_at(&self, ndx: usize) -> f32 {
        debug_assert!(ndx < self.stride);
        self.value[ndx].as_float()
    }
    pub fn as_int_at(&self, ndx: usize) -> i32 {
        debug_assert!(ndx < self.stride);
        self.value[ndx].as_int()
    }
    pub fn as_bool_at(&self, ndx: usize) -> bool {
        debug_assert!(ndx < self.stride);
        self.value[ndx].as_bool()
    }
    pub fn as_scalar_at(&self, ndx: usize) -> Scalar {
        debug_assert!(ndx < self.stride);
        self.value[ndx]
    }

    /// `ConstStridedValueAccess::value` - for assignment: `b = a.value()`.
    pub fn value(&self) -> StridedValueRead<'a> {
        StridedValueRead {
            type_: self.type_.clone(),
            value: self.value,
            stride: self.stride,
        }
    }
}

/// `rsg::StridedValueAccess<Stride>` - the read-write sibling of
/// `ConstStridedValueAccess`.
pub struct StridedValueAccess<'a> {
    type_: VariableType,
    value: &'a mut [Scalar],
    stride: usize,
}

impl<'a> StridedValueAccess<'a> {
    pub fn new(type_: VariableType, value: &'a mut [Scalar], stride: usize) -> Self {
        Self { type_, value, stride }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    fn as_const(&self) -> ConstStridedValueAccess<'_> {
        ConstStridedValueAccess {
            type_: self.type_.clone(),
            value: self.value,
            stride: self.stride,
        }
    }

    /// `operator ConstStridedValueAccess<Stride>` - upstream's implicit base-class
    /// slice. Takes `self` *by value*, not `&self`, and for a real reason, not style:
    /// `self.value: &'a mut [Scalar]` can only be reborrowed as `&'_ [Scalar]` bounded
    /// by however long `&self` itself is borrowed for (any shared method call shortens
    /// it), so a hypothetical `as_const(&self) -> ConstStridedValueAccess<'a>` cannot
    /// compile - the full original `'a` is only recoverable by consuming `self`
    /// entirely. Needed once `rsg::expression`'s `VariableRead::get_value` had to
    /// convert `ExecutionContext::get_value`'s freshly-returned, owned
    /// `StridedValueAccess<'c>` down to the `ConstStridedValueAccess<'c>`
    /// `Expression::getValue` returns, keeping the same lifetime `'c`.
    pub fn into_const(self) -> ConstStridedValueAccess<'a> {
        ConstStridedValueAccess {
            type_: self.type_,
            value: self.value,
            stride: self.stride,
        }
    }

    pub fn component(&mut self, comp_ndx: i32) -> StridedValueAccess<'_> {
        let elem_type = self.type_.element_type();
        StridedValueAccess::new(
            elem_type,
            &mut self.value[self.stride * comp_ndx as usize..],
            self.stride,
        )
    }

    pub fn array_element(&mut self, element_ndx: i32) -> StridedValueAccess<'_> {
        let offset = self.type_.element_scalar_offset(element_ndx) as usize;
        let elem_type = self.type_.element_type();
        StridedValueAccess::new(elem_type, &mut self.value[self.stride * offset..], self.stride)
    }

    pub fn member(&mut self, member_ndx: i32) -> StridedValueAccess<'_> {
        let offset = self.type_.member_scalar_offset(member_ndx) as usize;
        let member_type = self.type_.members()[member_ndx as usize].get_type().clone();
        StridedValueAccess::new(member_type, &mut self.value[self.stride * offset..], self.stride)
    }

    pub fn as_float(&self) -> f32 {
        self.as_const().as_float()
    }
    pub fn as_int(&self) -> i32 {
        self.as_const().as_int()
    }
    pub fn as_bool(&self) -> bool {
        self.as_const().as_bool()
    }
    pub fn as_scalar(&self) -> Scalar {
        self.as_const().as_scalar()
    }

    pub fn as_float_at(&self, ndx: usize) -> f32 {
        self.as_const().as_float_at(ndx)
    }
    pub fn as_int_at(&self, ndx: usize) -> i32 {
        self.as_const().as_int_at(ndx)
    }
    pub fn as_bool_at(&self, ndx: usize) -> bool {
        self.as_const().as_bool_at(ndx)
    }
    pub fn as_scalar_at(&self, ndx: usize) -> Scalar {
        self.as_const().as_scalar_at(ndx)
    }

    pub fn set_float(&mut self, v: f32) {
        debug_assert_eq!(self.stride, 1);
        self.value[0] = Scalar::from_float(v);
    }
    pub fn set_int(&mut self, v: i32) {
        debug_assert_eq!(self.stride, 1);
        self.value[0] = Scalar::from_int(v);
    }
    pub fn set_bool(&mut self, v: bool) {
        debug_assert_eq!(self.stride, 1);
        self.value[0] = Scalar::from_bool(v);
    }
    pub fn set_scalar(&mut self, v: Scalar) {
        debug_assert_eq!(self.stride, 1);
        self.value[0] = v;
    }

    /// `StridedValueAccess::asFloat(int ndx)` (the mutable, reference-returning
    /// overload) - this port's `rsg::execution_context` (`EXEC_VEC_WIDTH == 64`) is the
    /// first real consumer of a `stride > 1` mutation, which is why these indexed
    /// setters were not ported alongside the rest of this file originally (see this
    /// module's own top doc comment).
    pub fn set_float_at(&mut self, ndx: usize, v: f32) {
        debug_assert!(ndx < self.stride);
        self.value[ndx] = Scalar::from_float(v);
    }
    pub fn set_int_at(&mut self, ndx: usize, v: i32) {
        debug_assert!(ndx < self.stride);
        self.value[ndx] = Scalar::from_int(v);
    }
    pub fn set_bool_at(&mut self, ndx: usize, v: bool) {
        debug_assert!(ndx < self.stride);
        self.value[ndx] = Scalar::from_bool(v);
    }
    pub fn set_scalar_at(&mut self, ndx: usize, v: Scalar) {
        debug_assert!(ndx < self.stride);
        self.value[ndx] = v;
    }

    /// `StridedValueAccess::operator=(const StridedValueRead<SrcStride>&)` - copies a
    /// same-stride source element-for-element, or broadcasts a `stride == 1` source
    /// across every one of this access's own strided slots (upstream's
    /// `DE_STATIC_ASSERT(SrcStride == Stride || SrcStride == 1)`).
    pub fn assign_from(&mut self, src: &StridedValueRead<'_>) {
        debug_assert!(src.stride == self.stride || src.stride == 1);
        debug_assert!(self.type_ == src.type_);

        let scalar_size = self.type_.scalar_size() as usize;
        if scalar_size == 0 {
            return; // A void value range is sometimes copied - matches upstream.
        }

        if self.stride == src.stride {
            self.value[..scalar_size * self.stride].copy_from_slice(&src.value[..scalar_size * self.stride]);
        } else {
            for scalar_ndx in 0..scalar_size {
                let v = src.value[scalar_ndx];
                for s in &mut self.value[scalar_ndx * self.stride..(scalar_ndx + 1) * self.stride] {
                    *s = v;
                }
            }
        }
    }
}

/// `rsg::ConstValueAccess`/`rsg::ValueAccess` - the `Stride == 1` case every current
/// caller of this file uses (upstream's own `typedef`s of the same two names).
pub type ConstValueAccess<'a> = ConstStridedValueAccess<'a>;
pub type ValueAccess<'a> = StridedValueAccess<'a>;

/// `rsg::ConstValueRangeAccess` - read-only access to a `(min, max)` bound pair per
/// scalar component of `type_`.
pub struct ConstValueRangeAccess<'a> {
    type_: VariableType,
    min: &'a [Scalar],
    max: &'a [Scalar],
}

impl<'a> ConstValueRangeAccess<'a> {
    pub fn new(type_: VariableType, min: &'a [Scalar], max: &'a [Scalar]) -> Self {
        Self { type_, min, max }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn get_min(&self) -> ConstValueAccess<'a> {
        ConstValueAccess::new(self.type_.clone(), self.min, 1)
    }
    pub fn get_max(&self) -> ConstValueAccess<'a> {
        ConstValueAccess::new(self.type_.clone(), self.max, 1)
    }

    pub fn component(&self, comp_ndx: i32) -> ConstValueRangeAccess<'a> {
        let i = comp_ndx as usize;
        ConstValueRangeAccess::new(self.type_.element_type(), &self.min[i..], &self.max[i..])
    }

    pub fn array_element(&self, element_ndx: i32) -> ConstValueRangeAccess<'a> {
        let offset = self.type_.element_scalar_offset(element_ndx) as usize;
        ConstValueRangeAccess::new(self.type_.element_type(), &self.min[offset..], &self.max[offset..])
    }

    pub fn member(&self, member_ndx: i32) -> ConstValueRangeAccess<'a> {
        let offset = self.type_.member_scalar_offset(member_ndx) as usize;
        let member_type = self.type_.members()[member_ndx as usize].get_type().clone();
        ConstValueRangeAccess::new(member_type, &self.min[offset..], &self.max[offset..])
    }

    /// `ConstValueRangeAccess::intersects`
    pub fn intersects(&self, other: &ConstValueRangeAccess<'_>) -> bool {
        compare_value_ranges_all_true(self, other, &CompareIntersection)
    }
    /// `ConstValueRangeAccess::isSubsetOf`
    pub fn is_subset_of(&self, other: &ConstValueRangeAccess<'_>) -> bool {
        compare_value_ranges_all_true(self, other, &CompareIsSubsetOf)
    }
    /// `ConstValueRangeAccess::isSupersetOf`
    pub fn is_superset_of(&self, other: &ConstValueRangeAccess<'_>) -> bool {
        other.is_subset_of(self)
    }
}

/// `rsg::ValueRangeAccess` - the read-write sibling of `ConstValueRangeAccess`.
pub struct ValueRangeAccess<'a> {
    type_: VariableType,
    min: &'a mut [Scalar],
    max: &'a mut [Scalar],
}

impl<'a> ValueRangeAccess<'a> {
    pub fn new(type_: VariableType, min: &'a mut [Scalar], max: &'a mut [Scalar]) -> Self {
        Self { type_, min, max }
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn as_const(&self) -> ConstValueRangeAccess<'_> {
        ConstValueRangeAccess::new(self.type_.clone(), self.min, self.max)
    }

    pub fn get_min(&mut self) -> ValueAccess<'_> {
        ValueAccess::new(self.type_.clone(), self.min, 1)
    }
    pub fn get_max(&mut self) -> ValueAccess<'_> {
        ValueAccess::new(self.type_.clone(), self.max, 1)
    }

    pub fn component(&mut self, comp_ndx: i32) -> ValueRangeAccess<'_> {
        let elem_type = self.type_.element_type();
        let i = comp_ndx as usize;
        ValueRangeAccess::new(elem_type, &mut self.min[i..], &mut self.max[i..])
    }

    pub fn array_element(&mut self, element_ndx: i32) -> ValueRangeAccess<'_> {
        let offset = self.type_.element_scalar_offset(element_ndx) as usize;
        let elem_type = self.type_.element_type();
        ValueRangeAccess::new(elem_type, &mut self.min[offset..], &mut self.max[offset..])
    }

    pub fn member(&mut self, member_ndx: i32) -> ValueRangeAccess<'_> {
        let offset = self.type_.member_scalar_offset(member_ndx) as usize;
        let member_type = self.type_.members()[member_ndx as usize].get_type().clone();
        ValueRangeAccess::new(member_type, &mut self.min[offset..], &mut self.max[offset..])
    }
}

trait RangeCompareOp {
    fn cmp_float(&self, a_min: f32, a_max: f32, b_min: f32, b_max: f32) -> bool;
    fn cmp_int(&self, a_min: i32, a_max: i32, b_min: i32, b_max: i32) -> bool;
    fn cmp_bool(&self, a_min: bool, a_max: bool, b_min: bool, b_max: bool) -> bool {
        self.cmp_int(a_min as i32, a_max as i32, b_min as i32, b_max as i32)
    }
}

struct CompareIntersection;
impl RangeCompareOp for CompareIntersection {
    fn cmp_float(&self, a_min: f32, a_max: f32, b_min: f32, b_max: f32) -> bool {
        a_min <= b_max && b_min <= a_max
    }
    fn cmp_int(&self, a_min: i32, a_max: i32, b_min: i32, b_max: i32) -> bool {
        a_min <= b_max && b_min <= a_max
    }
}

struct CompareIsSubsetOf;
impl RangeCompareOp for CompareIsSubsetOf {
    fn cmp_float(&self, a_min: f32, a_max: f32, b_min: f32, b_max: f32) -> bool {
        (b_min..=b_max).contains(&a_min) && (b_min..=b_max).contains(&a_max)
    }
    fn cmp_int(&self, a_min: i32, a_max: i32, b_min: i32, b_max: i32) -> bool {
        (b_min..=b_max).contains(&a_min) && (b_min..=b_max).contains(&a_max)
    }
}

/// `compareValueRangesAllTrue<CompareOp>` - recurses through `a`'s own type tree
/// (struct members, array elements, then per-component scalars), applying `op` to every
/// leaf component's `(min, max)` pair from both sides; `true` only if every leaf agrees.
fn compare_value_ranges_all_true(
    a: &ConstValueRangeAccess<'_>,
    b: &ConstValueRangeAccess<'_>,
    op: &dyn RangeCompareOp,
) -> bool {
    debug_assert!(*a.get_type() == *b.get_type());

    if a.get_type().is_struct() {
        (0..a.get_type().members().len() as i32)
            .all(|ndx| compare_value_ranges_all_true(&a.member(ndx), &b.member(ndx), op))
    } else if a.get_type().is_array() {
        (0..a.get_type().num_elements())
            .all(|ndx| compare_value_ranges_all_true(&a.array_element(ndx), &b.array_element(ndx), op))
    } else {
        use super::variable_type::Type;
        let num_elements = a.get_type().num_elements();
        match a.get_type().base_type() {
            Type::Float => (0..num_elements).all(|ndx| {
                let ac = a.component(ndx);
                let bc = b.component(ndx);
                op.cmp_float(
                    ac.get_min().as_float(),
                    ac.get_max().as_float(),
                    bc.get_min().as_float(),
                    bc.get_max().as_float(),
                )
            }),
            Type::Int | Type::Sampler2D | Type::SamplerCube => (0..num_elements).all(|ndx| {
                let ac = a.component(ndx);
                let bc = b.component(ndx);
                op.cmp_int(
                    ac.get_min().as_int(),
                    ac.get_max().as_int(),
                    bc.get_min().as_int(),
                    bc.get_max().as_int(),
                )
            }),
            Type::Bool => (0..num_elements).all(|ndx| {
                let ac = a.component(ndx);
                let bc = b.component(ndx);
                op.cmp_bool(
                    ac.get_min().as_bool(),
                    ac.get_max().as_bool(),
                    bc.get_min().as_bool(),
                    bc.get_max().as_bool(),
                )
            }),
            _ => unreachable!("not a leaf scalar/vector base type"),
        }
    }
}

/// `rsg::ValueRange` - an owned `(min, max)` bound pair for every scalar component of
/// `type_`.
pub struct ValueRange {
    type_: VariableType,
    min: Vec<Scalar>,
    max: Vec<Scalar>,
}

impl ValueRange {
    /// `ValueRange(const VariableType&)` - unbounded in neither direction; every scalar
    /// starts at `Scalar::zero()` (upstream's `std::vector<Scalar>` default-constructs
    /// each `Scalar` through its own `intVal(0)` default, matching this port's own
    /// `Scalar::zero()`).
    pub fn new(type_: VariableType) -> Self {
        let n = type_.scalar_size() as usize;
        Self {
            min: vec![Scalar::zero(); n],
            max: vec![Scalar::zero(); n],
            type_,
        }
    }

    /// `ValueRange(const VariableType&, const ConstValueAccess&, const ConstValueAccess&)`
    pub fn from_min_max(type_: VariableType, min_val: &ConstValueAccess<'_>, max_val: &ConstValueAccess<'_>) -> Self {
        let mut range = Self::new(type_);
        let min_read = min_val.value();
        let max_read = max_val.value();
        range.get_min().assign_from(&min_read);
        range.get_max().assign_from(&max_read);
        range
    }

    /// `ValueRange(ConstValueRangeAccess)`
    pub fn from_access(other: &ConstValueRangeAccess<'_>) -> Self {
        let mut range = Self::new(other.get_type().clone());
        let min_read = other.get_min().value();
        let max_read = other.get_max().value();
        range.get_min().assign_from(&min_read);
        range.get_max().assign_from(&max_read);
        range
    }

    pub fn get_type(&self) -> &VariableType {
        &self.type_
    }

    pub fn get_min(&mut self) -> ValueAccess<'_> {
        ValueAccess::new(self.type_.clone(), &mut self.min, 1)
    }
    pub fn get_max(&mut self) -> ValueAccess<'_> {
        ValueAccess::new(self.type_.clone(), &mut self.max, 1)
    }
    pub fn get_min_const(&self) -> ConstValueAccess<'_> {
        ConstValueAccess::new(self.type_.clone(), &self.min, 1)
    }
    pub fn get_max_const(&self) -> ConstValueAccess<'_> {
        ConstValueAccess::new(self.type_.clone(), &self.max, 1)
    }

    pub fn as_access(&mut self) -> ValueRangeAccess<'_> {
        ValueRangeAccess::new(self.type_.clone(), &mut self.min, &mut self.max)
    }
    pub fn as_const_access(&self) -> ConstValueRangeAccess<'_> {
        ConstValueRangeAccess::new(self.type_.clone(), &self.min, &self.max)
    }

    /// `ValueRange::computeIntersection` (the `ValueRangeAccess` destination overload) -
    /// the array-of-arguments shape (`dst`/`a`/`b`) upstream uses so a nested recursive
    /// call can write into a `component`/`member`/`arrayElement` sub-access of a larger
    /// destination, not just a whole top-level `ValueRange`.
    pub fn compute_intersection_into(
        mut dst: ValueRangeAccess<'_>,
        a: &ConstValueRangeAccess<'_>,
        b: &ConstValueRangeAccess<'_>,
    ) {
        debug_assert!(*dst.get_type() == *a.get_type() && *dst.get_type() == *b.get_type());

        if a.get_type().is_struct() {
            for ndx in 0..a.get_type().members().len() as i32 {
                Self::compute_intersection_into(dst.member(ndx), &a.member(ndx), &b.member(ndx));
            }
        } else if a.get_type().is_array() {
            for ndx in 0..a.get_type().num_elements() {
                Self::compute_intersection_into(dst.array_element(ndx), &a.array_element(ndx), &b.array_element(ndx));
            }
        } else {
            use super::variable_type::Type;
            let num_elements = a.get_type().num_elements();
            match a.get_type().base_type() {
                Type::Float => {
                    for ndx in 0..num_elements {
                        let ac = a.component(ndx);
                        let bc = b.component(ndx);
                        let (a_min, a_max) = (ac.get_min().as_float(), ac.get_max().as_float());
                        let (b_min, b_max) = (bc.get_min().as_float(), bc.get_max().as_float());
                        let mut dc = dst.component(ndx);
                        dc.get_min().set_float(a_min.max(b_min));
                        dc.get_max().set_float(a_max.min(b_max));
                    }
                }
                Type::Int | Type::Sampler2D | Type::SamplerCube => {
                    for ndx in 0..num_elements {
                        let ac = a.component(ndx);
                        let bc = b.component(ndx);
                        let (a_min, a_max) = (ac.get_min().as_int(), ac.get_max().as_int());
                        let (b_min, b_max) = (bc.get_min().as_int(), bc.get_max().as_int());
                        let mut dc = dst.component(ndx);
                        dc.get_min().set_int(a_min.max(b_min));
                        dc.get_max().set_int(a_max.min(b_max));
                    }
                }
                Type::Bool => {
                    for ndx in 0..num_elements {
                        let ac = a.component(ndx);
                        let bc = b.component(ndx);
                        let (a_min, a_max) = (ac.get_min().as_bool(), ac.get_max().as_bool());
                        let (b_min, b_max) = (bc.get_min().as_bool(), bc.get_max().as_bool());
                        let mut dc = dst.component(ndx);
                        dc.get_min().set_bool(a_min || b_min);
                        dc.get_max().set_bool(a_max && b_max);
                    }
                }
                _ => unreachable!("not a leaf scalar/vector base type"),
            }
        }
    }

    /// `ValueRange::computeIntersection` (the `ValueRange&` destination overload).
    pub fn compute_intersection(dst: &mut ValueRange, a: &ConstValueRangeAccess<'_>, b: &ConstValueRangeAccess<'_>) {
        Self::compute_intersection_into(dst.as_access(), a, b);
    }
}

/// `rsg::ValueStorage<Stride>` - owned backing storage for a `type_`-shaped value,
/// `stride` scalars between logical components (see this module's top doc comment for
/// why `Stride` is a runtime field here).
pub struct ValueStorage {
    stride: usize,
    value: Vec<Scalar>,
}

impl ValueStorage {
    pub fn new(stride: usize) -> Self {
        Self {
            stride,
            value: Vec::new(),
        }
    }

    pub fn with_type(stride: usize, type_: &VariableType) -> Self {
        let mut storage = Self::new(stride);
        storage.set_storage(type_);
        storage
    }

    pub fn set_storage(&mut self, type_: &VariableType) {
        self.value = vec![Scalar::zero(); type_.scalar_size() as usize * self.stride];
    }

    pub fn get_value(&mut self, type_: &VariableType) -> StridedValueAccess<'_> {
        StridedValueAccess::new(type_.clone(), &mut self.value, self.stride)
    }
    pub fn get_value_const(&self, type_: &VariableType) -> ConstStridedValueAccess<'_> {
        ConstStridedValueAccess::new(type_.clone(), &self.value, self.stride)
    }
}

/// `rsg::VariableValue` - a `Variable`'s own runtime value, storage sized from its
/// type (always `Stride == 1`, matching upstream's `ValueStorage<1> m_storage`).
pub struct VariableValue<'a> {
    variable: &'a super::variable::Variable,
    storage: ValueStorage,
}

impl<'a> VariableValue<'a> {
    pub fn new(variable: &'a super::variable::Variable) -> Self {
        let storage = ValueStorage::with_type(1, variable.get_type());
        Self { variable, storage }
    }

    pub fn get_variable(&self) -> &'a super::variable::Variable {
        self.variable
    }

    pub fn get_value(&mut self) -> ValueAccess<'_> {
        self.storage.get_value(self.variable.get_type())
    }
    pub fn get_value_const(&self) -> ConstValueAccess<'_> {
        self.storage.get_value_const(self.variable.get_type())
    }
}

/// `VariableValue::VariableValue(const VariableValue&)` / `operator=` - both upstream
/// copy paths collapse into one `Clone` impl, since nothing here distinguishes
/// "copy-construct into fresh storage" from "copy-assign into existing storage" the way
/// C++ does.
impl<'a> Clone for VariableValue<'a> {
    fn clone(&self) -> Self {
        let mut copy = VariableValue::new(self.variable);
        let src = self.get_value_const().value();
        copy.get_value().assign_from(&src);
        copy
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rsg::variable::{Storage, Variable};
    use crate::rsg::variable_type::{Member, Type};

    #[test]
    fn scalar_round_trips_through_every_constructor() {
        assert_eq!(Scalar::from_float(1.5).as_float(), 1.5);
        assert_eq!(Scalar::from_int(-7).as_int(), -7);
        assert!(Scalar::from_bool(true).as_bool());
        assert!(!Scalar::from_bool(false).as_bool());
    }

    #[test]
    fn scalar_min_max_match_the_hand_computed_bit_patterns() {
        assert_eq!(Scalar::min_float().as_float(), f32::NEG_INFINITY);
        assert_eq!(Scalar::max_float().as_float(), f32::INFINITY);
        assert_eq!(Scalar::min_int().as_int(), i32::MIN);
        assert_eq!(Scalar::max_int().as_int(), i32::MAX);
        assert!(!Scalar::min_bool().as_bool());
        assert!(Scalar::max_bool().as_bool());
    }

    #[test]
    fn strided_value_access_reads_back_each_vector_component() {
        let type_ = VariableType::new_basic(Type::Float, 3);
        let mut storage = ValueStorage::with_type(1, &type_);
        {
            let mut v = storage.get_value(&type_);
            v.component(0).set_float(1.0);
            v.component(1).set_float(2.0);
            v.component(2).set_float(3.0);
        }
        let v = storage.get_value_const(&type_);
        assert_eq!(v.component(0).as_float(), 1.0);
        assert_eq!(v.component(1).as_float(), 2.0);
        assert_eq!(v.component(2).as_float(), 3.0);
    }

    #[test]
    fn assign_from_copies_a_same_stride_value_wholesale() {
        let type_ = VariableType::new_basic(Type::Float, 2);
        let mut src_storage = ValueStorage::with_type(1, &type_);
        src_storage.get_value(&type_).component(0).set_float(5.0);
        src_storage.get_value(&type_).component(1).set_float(6.0);

        let mut dst_storage = ValueStorage::with_type(1, &type_);
        let src_read = src_storage.get_value_const(&type_).value();
        dst_storage.get_value(&type_).assign_from(&src_read);

        let dst = dst_storage.get_value_const(&type_);
        assert_eq!(dst.component(0).as_float(), 5.0);
        assert_eq!(dst.component(1).as_float(), 6.0);
    }

    #[test]
    fn value_range_intersects_and_subset_for_a_scalar_float() {
        let type_ = VariableType::new_basic(Type::Float, 1);
        let mut a = ValueRange::new(type_.clone());
        a.get_min().set_float(0.0);
        a.get_max().set_float(10.0);

        let mut b = ValueRange::new(type_.clone());
        b.get_min().set_float(5.0);
        b.get_max().set_float(15.0);

        let mut c = ValueRange::new(type_.clone());
        c.get_min().set_float(20.0);
        c.get_max().set_float(30.0);

        assert!(a.as_const_access().intersects(&b.as_const_access()));
        assert!(!a.as_const_access().intersects(&c.as_const_access()));

        let mut sub = ValueRange::new(type_);
        sub.get_min().set_float(2.0);
        sub.get_max().set_float(8.0);
        assert!(sub.as_const_access().is_subset_of(&a.as_const_access()));
        assert!(!a.as_const_access().is_subset_of(&sub.as_const_access()));
        assert!(a.as_const_access().is_superset_of(&sub.as_const_access()));
    }

    #[test]
    fn compute_intersection_clamps_each_bound_the_tighter_way() {
        let type_ = VariableType::new_basic(Type::Int, 1);
        let mut a = ValueRange::new(type_.clone());
        a.get_min().set_int(0);
        a.get_max().set_int(10);

        let mut b = ValueRange::new(type_.clone());
        b.get_min().set_int(5);
        b.get_max().set_int(20);

        let mut dst = ValueRange::new(type_);
        ValueRange::compute_intersection(&mut dst, &a.as_const_access(), &b.as_const_access());

        assert_eq!(dst.get_min_const().as_int(), 5); // max(0, 5)
        assert_eq!(dst.get_max_const().as_int(), 10); // min(10, 20)
    }

    #[test]
    fn value_range_recurses_through_struct_members() {
        let mut struct_type = VariableType::new_struct("S");
        struct_type
            .members_mut()
            .push(Member::new(VariableType::new_basic(Type::Float, 1), "x"));
        struct_type
            .members_mut()
            .push(Member::new(VariableType::new_basic(Type::Int, 1), "y"));

        let mut a = ValueRange::new(struct_type.clone());
        a.as_access().member(0).get_min().set_float(0.0);
        a.as_access().member(0).get_max().set_float(1.0);
        a.as_access().member(1).get_min().set_int(0);
        a.as_access().member(1).get_max().set_int(1);

        let mut b = ValueRange::new(struct_type.clone());
        b.as_access().member(0).get_min().set_float(0.5);
        b.as_access().member(0).get_max().set_float(2.0);
        b.as_access().member(1).get_min().set_int(5);
        b.as_access().member(1).get_max().set_int(6);

        // `x` ranges overlap ([0,1] vs [0.5,2]) but `y` ranges do not ([0,1] vs [5,6]) -
        // the whole struct must report "does not intersect" since every leaf has to
        // agree.
        assert!(!a.as_const_access().intersects(&b.as_const_access()));

        let mut c = ValueRange::new(struct_type);
        c.as_access().member(0).get_min().set_float(0.5);
        c.as_access().member(0).get_max().set_float(0.8);
        c.as_access().member(1).get_min().set_int(0);
        c.as_access().member(1).get_max().set_int(1);
        assert!(a.as_const_access().intersects(&c.as_const_access()));
    }

    #[test]
    fn variable_value_storage_is_sized_from_the_variables_own_type() {
        let variable = Variable::new(VariableType::new_basic(Type::Float, 2), Storage::Local, "v");
        let mut value = VariableValue::new(&variable);
        value.get_value().component(0).set_float(1.5);
        value.get_value().component(1).set_float(2.5);

        assert_eq!(value.get_value_const().component(0).as_float(), 1.5);
        assert_eq!(value.get_value_const().component(1).as_float(), 2.5);
        assert_eq!(value.get_variable().get_name(), "v");
    }

    #[test]
    fn variable_value_clone_copies_the_stored_scalars_independently() {
        let variable = Variable::new(VariableType::new_basic(Type::Int, 1), Storage::Local, "n");
        let mut original = VariableValue::new(&variable);
        original.get_value().set_int(42);

        let mut copy = original.clone();
        assert_eq!(copy.get_value_const().as_int(), 42);

        // Independent storage: mutating the copy must not change the original.
        copy.get_value().set_int(7);
        assert_eq!(copy.get_value_const().as_int(), 7);
        assert_eq!(original.get_value_const().as_int(), 42);
    }
}
