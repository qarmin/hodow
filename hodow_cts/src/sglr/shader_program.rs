// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrShaderProgram.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `sglr::ShaderProgram` is upstream's one concrete shape of "a shader that can run on
// *either* a real GL driver or `sglr::ReferenceContext`": it carries a real GLSL
// source pair (for `sglr::GLContext`, not yet ported - see `sglr::Context`'s own
// module doc) *and* a reference-renderer implementation (`rr::VertexShader`/
// `rr::FragmentShader`), plus a set of named, runtime-settable `UniformSlot`s both
// paths read the current value of. Upstream expresses this as a C++ abstract base
// class (`ShaderProgram`) a concrete shader privately inherits, overriding
// `shadeVertices`/`shadeFragments`; Rust has no inheritance, so the base class's own
// data (the io-type arrays + uniform slots + source strings, assembled once from a
// `pdec::ShaderProgramDeclaration` builder at construction time) becomes `ShaderProgramBase`,
// which a concrete shader struct embeds and exposes through the `ShaderProgram` trait's
// two accessor methods - the same embed-a-base-struct-and-delegate shape this crate
// already uses elsewhere for "upstream base class, no Rust inheritance".
//
// Narrowed relative to upstream, both deliberately (nothing in scope needs the rest)
// and because of what this crate's own `rr::shaders` port already left out:
//  - **No geometry shader slot** - `pdec::GeometryShaderDeclaration`/`GeometrySource`
//    and `ShaderProgram::shadePrimitives` are not ported. Every upstream caller of this
//    file that is actually in scope here (`es2fDepthTests.cpp`/`es2fStencilTests.cpp`,
//    confirmed by grep) declares a plain
//    vertex+fragment pair only.
//  - **`UniformSlot`'s value union becomes a tagged `UniformValue` enum**, not a raw
//    `union` read back through whichever field the caller names regardless of which
//    was last written (what upstream's C `union` actually allows) - every real call
//    site here always reads back through the same type the uniform was declared with,
//    so a tagged enum that panics on a type mismatch catches a port bug instead of
//    silently reinterpreting four bytes, and costs nothing any real case pays.
//  - **No `rc::Texture1D`/`Texture2D`/`TextureCube`/... sampler-pointer union** -
//    `UniformSlot::sampler` is a single `Option<u32>` texture-object name instead,
//    meant to be resolved against whichever texture manager a `Context` impl owns.
//    Real sampler-uniform resolution (all five texture types `sglr::ReferenceContext`
//    backs) ended up going through `UniformSlot::value` instead - a sampler uniform's
//    stored value *is* its texture unit index, exactly as upstream's own "\note texture
//    unit is stored to value" comment on `glu::TYPE_SAMPLER_2D` describes, so
//    `ReferenceContext::resolve_sampler_uniforms` reads that rather than this field.
//    `UniformSlot::sampler` itself stays genuinely unused - kept in case some future
//    caller needs upstream's own "resolved pointer, not just a unit index" shape.

use crate::glu::shader_util::DataType;
use crate::rr::generic_vector::GenericVecType;
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};

pub mod pdec {
    //! `sglr::pdec` - the declaration-builder types `ShaderProgramDeclaration`
    //! accumulates (upstream: `operator<<`-chained value types). Rust has no
    //! `operator<<`, so chaining instead goes through consuming builder methods on
    //! `ShaderProgramDeclaration` itself (`.vertex_attribute(...)`, `.uniform(...)`, ...)
    //! that take these plain value structs - kept as separate named types rather than
    //! collapsing straight into the builder's own method arguments so a future geometry-
    //! shader addition has somewhere to land without changing every existing call site.

    use super::{DataType, GenericVecType};

    /// `pdec::VertexAttribute`
    #[derive(Debug, Clone)]
    pub struct VertexAttribute {
        pub name: String,
        pub type_: GenericVecType,
    }

    impl VertexAttribute {
        pub fn new(name: impl Into<String>, type_: GenericVecType) -> Self {
            Self {
                name: name.into(),
                type_,
            }
        }
    }

    /// `pdec::VertexToFragmentVarying` - `VARYINGFLAG_FLATSHADE` becomes the plain
    /// `flat` constructor rather than a bitflags parameter (it is upstream's only flag).
    #[derive(Debug, Clone, Copy)]
    pub struct VertexToFragmentVarying {
        pub type_: GenericVecType,
        pub flatshade: bool,
    }

    impl VertexToFragmentVarying {
        pub fn new(type_: GenericVecType) -> Self {
            Self {
                type_,
                flatshade: false,
            }
        }

        pub fn flat(type_: GenericVecType) -> Self {
            Self { type_, flatshade: true }
        }
    }

    /// `pdec::FragmentOutput`
    #[derive(Debug, Clone, Copy)]
    pub struct FragmentOutput {
        pub type_: GenericVecType,
    }

    impl FragmentOutput {
        pub fn new(type_: GenericVecType) -> Self {
            Self { type_ }
        }
    }

    /// `pdec::Uniform`
    #[derive(Debug, Clone)]
    pub struct Uniform {
        pub name: String,
        pub type_: DataType,
    }

    impl Uniform {
        pub fn new(name: impl Into<String>, type_: DataType) -> Self {
            Self {
                name: name.into(),
                type_,
            }
        }
    }

    /// `pdec::ShaderProgramDeclaration`, narrowed to vertex+fragment (see this
    /// module's top doc comment).
    #[derive(Debug, Clone, Default)]
    pub struct ShaderProgramDeclaration {
        vertex_attributes: Vec<VertexAttribute>,
        vertex_to_fragment_varyings: Vec<VertexToFragmentVarying>,
        fragment_outputs: Vec<FragmentOutput>,
        uniforms: Vec<Uniform>,
        vertex_source: String,
        fragment_source: String,
    }

    impl ShaderProgramDeclaration {
        pub fn new() -> Self {
            Self::default()
        }

        pub fn vertex_attribute(mut self, a: VertexAttribute) -> Self {
            self.vertex_attributes.push(a);
            self
        }

        pub fn vertex_to_fragment_varying(mut self, v: VertexToFragmentVarying) -> Self {
            self.vertex_to_fragment_varyings.push(v);
            self
        }

        pub fn fragment_output(mut self, o: FragmentOutput) -> Self {
            self.fragment_outputs.push(o);
            self
        }

        pub fn uniform(mut self, u: Uniform) -> Self {
            self.uniforms.push(u);
            self
        }

        pub fn vertex_source(mut self, src: impl Into<String>) -> Self {
            self.vertex_source = src.into();
            self
        }

        pub fn fragment_source(mut self, src: impl Into<String>) -> Self {
            self.fragment_source = src.into();
            self
        }

        /// `ShaderProgramDeclaration::valid` - narrowed to "both sources are
        /// non-empty and there is at least one fragment output" (upstream's
        /// `m_vertexShaderSet`/`m_fragmentShaderSet` flags track "was `<<` used at
        /// all", which a real shader source string is never empty under anyway) plus
        /// the geometry-shader cross-checks dropped, since no geometry shader exists
        /// here to check against.
        pub fn valid(&self) -> bool {
            !self.vertex_source.is_empty() && !self.fragment_source.is_empty() && !self.fragment_outputs.is_empty()
        }

        pub(super) fn vertex_attributes(&self) -> &[VertexAttribute] {
            &self.vertex_attributes
        }

        pub(super) fn vertex_to_fragment_varyings(&self) -> &[VertexToFragmentVarying] {
            &self.vertex_to_fragment_varyings
        }

        pub(super) fn fragment_outputs(&self) -> &[FragmentOutput] {
            &self.fragment_outputs
        }

        pub(super) fn uniforms(&self) -> &[Uniform] {
            &self.uniforms
        }

        pub(super) fn vertex_src(&self) -> &str {
            &self.vertex_source
        }

        pub(super) fn fragment_src(&self) -> &str {
            &self.fragment_source
        }
    }
}

/// `UniformSlot::value`'s union, narrowed to a tagged enum - see this module's top doc
/// comment for why that is a safe narrowing here (every real call site reads back
/// through the same type a uniform was declared with).
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum UniformValue {
    I32(i32),
    /// `glsFragOpInteractionCase.cpp`'s own `setUniformValue` grep-confirmed need
    /// (`ctx.uniform2iv`/`uniform3iv`, the `rsg::VariableType::TYPE_INT`/`TYPE_BOOL`
    /// path at `numElements` 2/3) - see `reference_context.rs`'s own
    /// `uniform2iv`/`uniform3iv` doc comment for the exact narrowing.
    I32Vec2([i32; 2]),
    I32Vec3([i32; 3]),
    I32Vec4([i32; 4]),
    F32(f32),
    /// Same grep-confirmed need as `I32Vec2`/`I32Vec3` above, for the
    /// `TYPE_FLOAT`/`numElements` 2/3 path (`ctx.uniform2fv`/`uniform3fv`).
    F32Vec2([f32; 2]),
    F32Vec3([f32; 3]),
    F32Vec4([f32; 4]),
    /// Row-major, same convention upstream's own doc comment states
    /// ("can be fed directly to tcu::Matrix constructor").
    Mat3([f32; 9]),
    Mat4([f32; 16]),
}

impl UniformValue {
    pub fn as_i32(&self) -> i32 {
        match self {
            Self::I32(v) => *v,
            other => panic!("uniform value is not a scalar int: {other:?}"),
        }
    }

    pub fn as_f32(&self) -> f32 {
        match self {
            Self::F32(v) => *v,
            other => panic!("uniform value is not a scalar float: {other:?}"),
        }
    }

    pub fn as_f32_vec4(&self) -> [f32; 4] {
        match self {
            Self::F32Vec4(v) => *v,
            other => panic!("uniform value is not a vec4 float: {other:?}"),
        }
    }
}

/// `sglr::UniformSlot`
#[derive(Debug, Clone)]
pub struct UniformSlot {
    pub name: String,
    pub type_: DataType,
    pub value: UniformValue,
    /// Texture-object name bound to this sampler unit - see this module's top doc
    /// comment for the narrowing from upstream's per-texture-type pointer union.
    pub sampler: Option<u32>,
}

impl UniformSlot {
    fn new(name: String, type_: DataType) -> Self {
        Self {
            name,
            type_,
            value: UniformValue::I32(0),
            sampler: None,
        }
    }
}

/// `sglr::ShaderProgram`'s base-class data (everything upstream's constructor
/// assembles from a `pdec::ShaderProgramDeclaration` before a concrete shader's own
/// `shadeVertices`/`shadeFragments` ever runs) - see this module's top doc comment for
/// why this is a struct a concrete shader embeds rather than a base class.
#[derive(Debug, Clone)]
pub struct ShaderProgramBase {
    vertex_inputs: Vec<VertexInputInfo>,
    vertex_outputs: Vec<VertexOutputInfo>,
    fragment_inputs: Vec<FragmentInputInfo>,
    fragment_outputs: Vec<FragmentOutputInfo>,
    attribute_names: Vec<String>,
    uniforms: Vec<UniformSlot>,
    vertex_source: String,
    fragment_source: String,
}

impl ShaderProgramBase {
    /// `ShaderProgram::ShaderProgram`
    pub fn new(decl: &pdec::ShaderProgramDeclaration) -> Self {
        debug_assert!(
            decl.valid(),
            "ShaderProgramDeclaration is not valid (DE_ASSERT(decl.valid()) upstream)"
        );

        let vertex_inputs = decl
            .vertex_attributes()
            .iter()
            .map(|a| VertexInputInfo { type_: Some(a.type_) })
            .collect();
        let attribute_names = decl.vertex_attributes().iter().map(|a| a.name.clone()).collect();

        // Non-geometry-shader path only (see this module's top doc comment): the
        // vertex-to-fragment varying list becomes both `VertexShader::m_outputs` and
        // `FragmentShader::m_inputs`, exactly as upstream's constructor copies one into
        // the other when `!m_hasGeometryShader`.
        let varyings: Vec<VertexOutputInfo> = decl
            .vertex_to_fragment_varyings()
            .iter()
            .map(|v| VertexOutputInfo {
                type_: Some(v.type_),
                flatshade: v.flatshade,
            })
            .collect();
        let vertex_outputs = varyings.clone();
        let fragment_inputs = varyings;

        let fragment_outputs = decl
            .fragment_outputs()
            .iter()
            .map(|o| FragmentOutputInfo { type_: Some(o.type_) })
            .collect();
        let uniforms = decl
            .uniforms()
            .iter()
            .map(|u| UniformSlot::new(u.name.clone(), u.type_))
            .collect();

        Self {
            vertex_inputs,
            vertex_outputs,
            fragment_inputs,
            fragment_outputs,
            attribute_names,
            uniforms,
            vertex_source: decl.vertex_src().to_string(),
            fragment_source: decl.fragment_src().to_string(),
        }
    }

    pub fn vertex_inputs(&self) -> &[VertexInputInfo] {
        &self.vertex_inputs
    }

    pub fn vertex_outputs(&self) -> &[VertexOutputInfo] {
        &self.vertex_outputs
    }

    pub fn fragment_inputs(&self) -> &[FragmentInputInfo] {
        &self.fragment_inputs
    }

    pub fn fragment_outputs(&self) -> &[FragmentOutputInfo] {
        &self.fragment_outputs
    }

    pub fn attribute_names(&self) -> &[String] {
        &self.attribute_names
    }

    pub fn uniforms(&self) -> &[UniformSlot] {
        &self.uniforms
    }

    pub fn uniforms_mut(&mut self) -> &mut [UniformSlot] {
        &mut self.uniforms
    }

    pub fn vertex_source(&self) -> &str {
        &self.vertex_source
    }

    pub fn fragment_source(&self) -> &str {
        &self.fragment_source
    }

    /// `ShaderProgram::getUniformByName` - panics on an unknown name, exactly as
    /// upstream's own `DE_FATAL` does: this is a shader-author error (a typo'd uniform
    /// name), not a runtime condition a caller can recover from.
    pub fn uniform_by_name(&self, name: &str) -> &UniformSlot {
        self.uniforms
            .iter()
            .find(|u| u.name == name)
            .unwrap_or_else(|| panic!("invalid uniform name, uniform not found: {name}"))
    }

    pub fn uniform_by_name_mut(&mut self, name: &str) -> &mut UniformSlot {
        self.uniforms
            .iter_mut()
            .find(|u| u.name == name)
            .unwrap_or_else(|| panic!("invalid uniform name, uniform not found: {name}"))
    }
}

/// `sglr::ShaderProgram` - a shader that both a real-driver `Context` (via its own
/// GLSL source) and a reference `Context` (via `VertexShader`/`FragmentShader`) can
/// run, with uniform values settable by name at any point between draws (`setColor`-
/// style helpers call `Context::uniform4fv`, which locates the slot via
/// `Context::get_uniform_location` and writes through `program_base_mut().uniforms_mut()`).
///
/// Object-safe: `ShaderProgram: VertexShader + FragmentShader` lets a
/// `Box<dyn ShaderProgram>` be coerced to `&dyn VertexShader`/`&dyn FragmentShader`
/// through trait-upcasting (stable since Rust 1.86, well below this project's pinned
/// toolchain) wherever a `Context` impl needs to hand the pair to `rr::Renderer`.
pub trait ShaderProgram: VertexShader + FragmentShader {
    fn program_base(&self) -> &ShaderProgramBase;
    fn program_base_mut(&mut self) -> &mut ShaderProgramBase;

    /// Called once per draw by `ReferenceContext::resolve_sampler_uniforms`, right
    /// before shading, with one `(uniform name, resolved sampler)` pair per declared
    /// sampler uniform of any type backed by one of the six texture objects this port
    /// has (`Sampler2D`/`SamplerCube`/`Sampler2DArray`/`Sampler3D`/`SamplerCubeArray`,
    /// their `IntSampler*`/`UintSampler*` counterparts, - for the four that have
    /// one - their `*Shadow` counterpart, and `SamplerBuffer`/`IntSamplerBuffer`/
    /// `UintSamplerBuffer`; see `reference_context.rs`'s own top doc
    /// comment for exactly which) - `None` when the texture unit `uniform1i` last
    /// stored for it names nothing bound,
    /// or names a texture that isn't complete (`is_complete`/`resolve_sampler`'s own
    /// completeness gate, matching upstream's own `tex->isComplete()` - every one of the
    /// mip-mappable five texture types has its own `is_complete`, and `TextureBuffer`'s
    /// own `resolve_sampler` folds the equivalent check - attached buffer exists and
    /// holds at least one whole texel - directly into itself instead, since a buffer
    /// texture has no separate completeness concept to query ahead of time).
    /// Default no-op body: a shader that declares no sampler uniform never needs to
    /// override this.
    ///
    /// `ResolvedSampler` (`reference_context.rs`) is a tagged enum over one
    /// `ResolvedSampler<Kind>` struct per texture type, each owning a clone of that
    /// texture's mip chain plus its wrap/filter state mapped into real `tcu::pixel`
    /// types, rather than handing out a pointer or name into `ReferenceContext`'s own
    /// texture storage (unlike upstream's own `UniformSlot::sampler`, a raw
    /// `rc::Texture2D*`/`TextureCube*`/... union member) - a `Box<dyn ShaderProgram>` is
    /// owned *by* `ReferenceContext` (inside `ProgramObject::Declared`), so a reference
    /// back into the same context's texture `ObjectManager` would need either unsafe raw
    /// pointers or a lifetime tied to a borrow of `self` that `shade_fragments(&self,
    /// ...)` (an immutable method, called while `ReferenceContext` itself may be
    /// mutably borrowed to drive the draw) cannot hold. A cheap clone (one `Vec<u8>` copy
    /// per mip level actually sampled) sidesteps all of that at the cost of a copy per
    /// draw - revisit with `Rc`/`Arc` sharing if a future caller's hot loop makes that
    /// cost matter.
    fn bind_samplers(&mut self, _resolved: &[(String, Option<super::reference_context::ResolvedSampler>)]) {}
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn declaration_is_valid_only_once_both_sources_and_an_output_are_set() {
        assert!(!pdec::ShaderProgramDeclaration::new().valid());
        assert!(
            !pdec::ShaderProgramDeclaration::new()
                .vertex_source("void main(){}")
                .fragment_source("void main(){}")
                .valid(),
            "no fragment output declared"
        );
        assert!(
            pdec::ShaderProgramDeclaration::new()
                .vertex_source("void main(){}")
                .fragment_source("void main(){}")
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .valid()
        );
    }

    #[test]
    fn base_assembles_attribute_names_and_uniforms_from_the_declaration() {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source("void main(){}")
            .fragment_source("void main(){}");
        let base = ShaderProgramBase::new(&decl);

        assert_eq!(base.attribute_names(), &["a_position".to_string()]);
        assert_eq!(base.vertex_inputs().len(), 1);
        assert_eq!(base.uniforms().len(), 1);
        assert_eq!(base.uniform_by_name("u_color").type_, DataType::FloatVec4);
        assert_eq!(base.uniform_by_name("u_color").value, UniformValue::I32(0));
    }

    #[test]
    fn vertex_to_fragment_varyings_become_both_vertex_outputs_and_fragment_inputs() {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::flat(GenericVecType::Int32))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source("void main(){}")
            .fragment_source("void main(){}");
        let base = ShaderProgramBase::new(&decl);

        assert_eq!(base.vertex_outputs(), base.fragment_inputs());
        assert_eq!(base.vertex_outputs()[0].type_, Some(GenericVecType::Int32));
        assert!(base.vertex_outputs()[0].flatshade);
    }

    #[test]
    #[should_panic(expected = "invalid uniform name")]
    fn uniform_by_name_panics_on_an_unknown_name() {
        let decl = pdec::ShaderProgramDeclaration::new()
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source("void main(){}")
            .fragment_source("void main(){}");
        ShaderProgramBase::new(&decl).uniform_by_name("u_nope");
    }

    #[test]
    fn uniform_by_name_mut_lets_a_set_color_style_helper_overwrite_the_value() {
        let decl = pdec::ShaderProgramDeclaration::new()
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source("void main(){}")
            .fragment_source("void main(){}");
        let mut base = ShaderProgramBase::new(&decl);

        base.uniform_by_name_mut("u_color").value = UniformValue::F32Vec4([1.0, 0.0, 0.0, 1.0]);
        assert_eq!(
            base.uniform_by_name("u_color").value.as_f32_vec4(),
            [1.0, 0.0, 0.0, 1.0]
        );
    }
}
