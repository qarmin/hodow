// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsTextureTestUtil.hpp / .cpp  (gls::TextureTestUtil::ProgramLibrary,
//   gls::TextureTestUtil::TextureRenderer)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// This is the real-driver half of `glsTextureTestUtil` - `ProgramLibrary` compiles and
// caches one of upstream's ~40 texture-lookup GLSL program variants, `TextureRenderer`
// binds its uniforms and draws a textured quad through it. The host-side reference
// sampler these programs are checked against (LOD/derivative math, `sample_texture_2d`)
// is this crate's `glu::texture_test_util`, this is what the
// `texture.*` root (`dEQP-GLES{2,3}.functional.texture.{filtering,wrap,...}` - ~6500
// cases) needs on the
// real-image-production side, on top of `glu::Texture2D` for
// getting a texture onto the driver in the first place.
//
// Narrowed hard, matching this project's own convention of porting exactly what a
// first consumer needs rather than the whole upstream surface at once:
// `TextureType::Texture2D` with every `SamplerType` except the unported `FETCH_*` trio
// (`Float`/`Int`/`Uint`/`Shadow`, each with and without a LOD bias - `PROGRAM_2D_FLOAT`
// through `PROGRAM_2D_SHADOW_BIAS` upstream), `TextureType::Cube` with every
// `SamplerType` (`Float`/`Int`/`Uint`/`Shadow`, `PROGRAM_CUBE_FLOAT` through
// `PROGRAM_CUBE_SHADOW_BIAS`), `TextureType::Texture3D` with `Float`/`Int`/`Uint`
// (`PROGRAM_3D_FLOAT` through `PROGRAM_3D_UINT_BIAS` - upstream has no `PROGRAM_3D_SHADOW`
// at all, no 3D shadow sampler existing in GLSL), plus `TextureType::Texture2DArray` with
// every `SamplerType` but no bias variant (`PROGRAM_2D_ARRAY_FLOAT` through `_SHADOW` -
// upstream's own `renderQuad` asserts `!useBias` for this texture type and has no
// `PROGRAM_2D_ARRAY_*_BIAS` enumerant at all) - no cube-array/1D/buffer texture types.
// This is still the overwhelming majority of what
// `texture.filtering`/`texture.wrap`/`texture.mipmap`/`texture.shadow` actually test,
// and every other combination upstream's `Program` enum covers can be added the same
// way once a case needs it - `get_program`'s `_ => Err(...)` arm says so explicitly
// rather than silently picking the wrong shader. `RenderParams::flags` LOG_* bits have
// no meaning without upstream's own `TestLog` plumbing and are dropped already, at the
// source (`glu::texture_test_util::RenderParams`'s own narrowing).
//
// `ProgramLibrary::clear`/`TextureRenderer::clear` are not ported - nothing here holds
// a program past its own `Drop`, since `ShaderProgram<'gl>` already deletes its GL
// object on drop and `ProgramLibrary` owns every program it ever built for its own
// lifetime. Upstream's version exists only because C++ has no destructor-driven
// per-object cleanup of a `map<Program, ShaderProgram*>` for free.

use std::collections::HashMap;

use crate::glu::draw_util::{self, pr, va};
use crate::glu::render_context::{RenderContext, RenderTarget};
use crate::glu::shader_program::{ProgramSources, ShaderProgram};
use crate::glu::shader_util::Precision;
use crate::glu::texture_test_util::{RenderParams, SamplerType, TextureType};
use crate::glu::{self, GlslVersion};
use crate::glw::{self, GLuint};
use crate::tcu::Random;
use crate::tcu::defs::TestError;
use crate::tcu::string_template::StringTemplate;

/// `gls::TextureTestUtil::RandomViewport` - a viewport of up to `preferred_width` x
/// `preferred_height` pixels, placed pseudo-randomly within `render_target`. The
/// canonical port of this module's own class: several consumers (`scissor_tests.rs`,
/// both `gles2`/`gles3::functional::dithering_tests`' own `random_viewport` functions,
/// `gles31::functional::separate_shader_tests`' own) already carry an identical
/// hand-written copy, each predating this one - left as they are rather than switched
/// over, since a pure-dedup edit to an already-correct, already-diffed call site earns
/// nothing and risks a transcription slip this round has no compiler to catch. A new
/// consumer can reach for this one instead of writing a fourth copy.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct RandomViewport {
    pub x: i32,
    pub y: i32,
    pub width: i32,
    pub height: i32,
}

impl RandomViewport {
    pub fn new(render_target: &RenderTarget, preferred_width: i32, preferred_height: i32, seed: u32) -> Self {
        let width = preferred_width.min(render_target.width);
        let height = preferred_height.min(render_target.height);
        let mut rnd = Random::new(seed);
        let x = rnd.get_int(0, render_target.width - width);
        let y = rnd.get_int(0, render_target.height - height);
        Self { x, y, width, height }
    }
}

/// `gls::TextureTestUtil::Program`, narrowed per this module's top doc comment to
/// `TextureType::Texture2D` with every `SamplerType` except the unported `FETCH_*`
/// trio, `TextureType::Cube` with every `SamplerType`, `TextureType::Texture3D` with
/// `Float`/`Int`/`Uint` (no `Shadow` - upstream has no `PROGRAM_3D_SHADOW` at all),
/// plus `TextureType::Texture2DArray` with every `SamplerType` but **no bias variant at
/// all** - upstream's own `renderQuad` has a literal `DE_ASSERT(!useBias); // \todo
/// Support bias.` right where it picks a `PROGRAM_2D_ARRAY_*` spec, and there is no
/// `PROGRAM_2D_ARRAY_*_BIAS` enumerant to pick even if that assert were lifted.
/// `Int`/`Uint` need no new *reference*-side code on any of the four texture types (see
/// `exec_sample_2d`/`exec_sample_cube`/`exec_sample_3d`/`exec_sample_2d_array`'s own doc
/// comments) but do need their own GLSL sampler type here; `Cube`+`Shadow` needed
/// `tcu::pixel::sample_cube_mipmap_compare` on the reference side first (ported
/// alongside this), the cube counterpart of `Texture2DShadow`'s own
/// `sample_2d_mipmap_compare`; `Texture2DArray`+`Shadow` reuses the same
/// `sample_2d_array_mipmap_compare` its own reference-side pass already needed.
#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
pub(crate) enum Program {
    Texture2DFloat,
    Texture2DFloatBias,
    Texture2DInt,
    Texture2DIntBias,
    Texture2DUint,
    Texture2DUintBias,
    Texture2DShadow,
    Texture2DShadowBias,
    CubeFloat,
    CubeFloatBias,
    CubeInt,
    CubeIntBias,
    CubeUint,
    CubeUintBias,
    CubeShadow,
    CubeShadowBias,
    Texture3DFloat,
    Texture3DFloatBias,
    Texture3DInt,
    Texture3DIntBias,
    Texture3DUint,
    Texture3DUintBias,
    Texture2DArrayFloat,
    Texture2DArrayInt,
    Texture2DArrayUint,
    Texture2DArrayShadow,
}

impl Program {
    /// Upstream's `renderQuad`'s own `texType`/`samplerType`/`useBias` dispatch,
    /// narrowed to `TextureType::Texture2D`/`Cube`/`Texture3D`/`Texture2DArray` - any
    /// other texture type, or an array requested with a bias, is `Err`, not a silent
    /// fallback, so a case that needs it fails loudly rather than rendering with the
    /// wrong shader.
    pub(crate) fn for_params(params: &RenderParams) -> Result<Self, TestError> {
        match (params.tex_type, params.sampler_type, params.use_bias) {
            (TextureType::Texture2D, SamplerType::Float, false) => Ok(Self::Texture2DFloat),
            (TextureType::Texture2D, SamplerType::Float, true) => Ok(Self::Texture2DFloatBias),
            (TextureType::Texture2D, SamplerType::Int, false) => Ok(Self::Texture2DInt),
            (TextureType::Texture2D, SamplerType::Int, true) => Ok(Self::Texture2DIntBias),
            (TextureType::Texture2D, SamplerType::Uint, false) => Ok(Self::Texture2DUint),
            (TextureType::Texture2D, SamplerType::Uint, true) => Ok(Self::Texture2DUintBias),
            (TextureType::Texture2D, SamplerType::Shadow, false) => Ok(Self::Texture2DShadow),
            (TextureType::Texture2D, SamplerType::Shadow, true) => Ok(Self::Texture2DShadowBias),
            (TextureType::Cube, SamplerType::Float, false) => Ok(Self::CubeFloat),
            (TextureType::Cube, SamplerType::Float, true) => Ok(Self::CubeFloatBias),
            (TextureType::Cube, SamplerType::Int, false) => Ok(Self::CubeInt),
            (TextureType::Cube, SamplerType::Int, true) => Ok(Self::CubeIntBias),
            (TextureType::Cube, SamplerType::Uint, false) => Ok(Self::CubeUint),
            (TextureType::Cube, SamplerType::Uint, true) => Ok(Self::CubeUintBias),
            (TextureType::Cube, SamplerType::Shadow, false) => Ok(Self::CubeShadow),
            (TextureType::Cube, SamplerType::Shadow, true) => Ok(Self::CubeShadowBias),
            (TextureType::Texture3D, SamplerType::Float, false) => Ok(Self::Texture3DFloat),
            (TextureType::Texture3D, SamplerType::Float, true) => Ok(Self::Texture3DFloatBias),
            (TextureType::Texture3D, SamplerType::Int, false) => Ok(Self::Texture3DInt),
            (TextureType::Texture3D, SamplerType::Int, true) => Ok(Self::Texture3DIntBias),
            (TextureType::Texture3D, SamplerType::Uint, false) => Ok(Self::Texture3DUint),
            (TextureType::Texture3D, SamplerType::Uint, true) => Ok(Self::Texture3DUintBias),
            (TextureType::Texture2DArray, SamplerType::Float, false) => Ok(Self::Texture2DArrayFloat),
            (TextureType::Texture2DArray, SamplerType::Int, false) => Ok(Self::Texture2DArrayInt),
            (TextureType::Texture2DArray, SamplerType::Uint, false) => Ok(Self::Texture2DArrayUint),
            (TextureType::Texture2DArray, SamplerType::Shadow, false) => Ok(Self::Texture2DArrayShadow),
            (tex_type, sampler_type, use_bias) => Err(TestError::NotPorted(format!(
                "gls::texture_test_util::ProgramLibrary only supports TextureType::Texture2D with Float/Int/Uint/Shadow samplers, TextureType::Cube with Float/Int/Uint/Shadow, TextureType::Texture3D with Float/Int/Uint, and TextureType::Texture2DArray with Float/Int/Uint/Shadow and no bias, not ({tex_type:?}, {sampler_type:?}, use_bias={use_bias})"
            ))),
        }
    }

    /// The vertex `a_texCoord` component count upstream's own `renderQuad` derives
    /// from `texType` (`numComps`) - 2 for a plain 2D UV, 3 for a cube direction vector
    /// or a 2D-array `(s, t, layer)` triple.
    fn num_tex_coord_components(self) -> usize {
        match self {
            Self::Texture2DFloat
            | Self::Texture2DFloatBias
            | Self::Texture2DInt
            | Self::Texture2DIntBias
            | Self::Texture2DUint
            | Self::Texture2DUintBias
            | Self::Texture2DShadow
            | Self::Texture2DShadowBias => 2,
            Self::CubeFloat
            | Self::CubeFloatBias
            | Self::CubeInt
            | Self::CubeIntBias
            | Self::CubeUint
            | Self::CubeUintBias
            | Self::CubeShadow
            | Self::CubeShadowBias => 3,
            Self::Texture3DFloat
            | Self::Texture3DFloatBias
            | Self::Texture3DInt
            | Self::Texture3DIntBias
            | Self::Texture3DUint
            | Self::Texture3DUintBias => 3,
            Self::Texture2DArrayFloat
            | Self::Texture2DArrayInt
            | Self::Texture2DArrayUint
            | Self::Texture2DArrayShadow => 3,
        }
    }
}

/// `gls::TextureTestUtil::ProgramLibrary`
pub struct ProgramLibrary<'gl> {
    gl: &'gl glw::Functions,
    glsl_version: GlslVersion,
    tex_coord_precision: Precision,
    programs: HashMap<Program, ShaderProgram<'gl>>,
}

impl<'gl> ProgramLibrary<'gl> {
    pub fn new(gl: &'gl glw::Functions, glsl_version: GlslVersion, tex_coord_precision: Precision) -> Self {
        Self {
            gl,
            glsl_version,
            tex_coord_precision,
            programs: HashMap::new(),
        }
    }

    pub fn tex_coord_precision(&self) -> Precision {
        self.tex_coord_precision
    }

    /// `ProgramLibrary::getProgram` - builds and caches the program the first time it
    /// is asked for, matching upstream's own lazily-populated `m_programs` map.
    pub(crate) fn get_program(&mut self, program: Program) -> Result<&ShaderProgram<'gl>, TestError> {
        if !self.programs.contains_key(&program) {
            let built = self.build_program(program)?;
            self.programs.insert(program, built);
        }
        Ok(self.programs.get(&program).expect("just inserted above"))
    }

    fn build_program(&self, program: Program) -> Result<ShaderProgram<'gl>, TestError> {
        const VERT_SHADER_TEMPLATE: &str = "${VTX_HEADER}${VTX_IN} highp vec4 a_position;\n${VTX_IN} ${PRECISION} ${TEXCOORD_TYPE} a_texCoord;\n${VTX_OUT} ${PRECISION} ${TEXCOORD_TYPE} v_texCoord;\n\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n";
        // `u_ref` is always declared, matching upstream's own template exactly
        // (`glsTextureTestUtil.cpp`'s `fragShaderTemplate`) - an unused uniform is
        // legal GLSL, and declaring it unconditionally means `Program` doesn't need a
        // second axis just to decide whether this line is present.
        const FRAG_SHADER_TEMPLATE: &str = "${FRAG_HEADER}${FRAG_IN} ${PRECISION} ${TEXCOORD_TYPE} v_texCoord;\nuniform ${PRECISION} float u_bias;\nuniform ${PRECISION} float u_ref;\nuniform ${PRECISION} vec4 u_colorScale;\nuniform ${PRECISION} vec4 u_colorBias;\nuniform ${PRECISION} ${SAMPLER_TYPE} u_sampler;\n\nvoid main (void)\n{\n    ${FRAG_COLOR} = ${LOOKUP} * u_colorScale + u_colorBias;\n}\n";

        let (vtx_header, vtx_in, vtx_out, frag_header, frag_in, frag_color) = match self.glsl_version {
            GlslVersion::Es100 => (
                String::new(),
                "attribute",
                "varying",
                String::new(),
                "varying",
                "gl_FragColor",
            ),
            _ => (
                format!("{}\n", self.glsl_version.declaration()),
                "in",
                "out",
                format!(
                    "{}\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n",
                    self.glsl_version.declaration()
                ),
                "in",
                "dEQP_FragColor",
            ),
        };

        let tex_coord_type = if program.num_tex_coord_components() == 3 {
            "vec3"
        } else {
            "vec2"
        };

        // `sampler2D`/`isampler2D`/`usampler2D`/`sampler2DShadow` (and their `*Cube`
        // siblings) - `Int`/`Uint`/`Shadow` are all GLSL ES 3.00+ constructs (no
        // integer or shadow sampler exists in GLSL ES 1.00 at all), so these variants
        // are never built under `GlslVersion::Es100` - no test in this port's scope
        // constructs that combination (confirmed: GLES2 has no `SamplerType::Int`/
        // `Uint`/`Shadow` group), and `for_params` has no `GlslVersion` to reject it
        // against earlier.
        let sampler_type = match program {
            Program::Texture2DFloat | Program::Texture2DFloatBias => "sampler2D",
            Program::Texture2DInt | Program::Texture2DIntBias => "isampler2D",
            Program::Texture2DUint | Program::Texture2DUintBias => "usampler2D",
            Program::Texture2DShadow | Program::Texture2DShadowBias => "sampler2DShadow",
            Program::CubeFloat | Program::CubeFloatBias => "samplerCube",
            Program::CubeInt | Program::CubeIntBias => "isamplerCube",
            Program::CubeUint | Program::CubeUintBias => "usamplerCube",
            Program::CubeShadow | Program::CubeShadowBias => "samplerCubeShadow",
            Program::Texture3DFloat | Program::Texture3DFloatBias => "sampler3D",
            Program::Texture3DInt | Program::Texture3DIntBias => "isampler3D",
            Program::Texture3DUint | Program::Texture3DUintBias => "usampler3D",
            Program::Texture2DArrayFloat => "sampler2DArray",
            Program::Texture2DArrayInt => "isampler2DArray",
            Program::Texture2DArrayUint => "usampler2DArray",
            Program::Texture2DArrayShadow => "sampler2DArrayShadow",
        };

        let lookup = match (self.glsl_version, program) {
            (GlslVersion::Es100, Program::Texture2DFloat) => "texture2D(u_sampler, v_texCoord)",
            (GlslVersion::Es100, Program::Texture2DFloatBias) => "texture2D(u_sampler, v_texCoord, u_bias)",
            (GlslVersion::Es100, Program::CubeFloat) => "textureCube(u_sampler, v_texCoord)",
            (GlslVersion::Es100, Program::CubeFloatBias) => "textureCube(u_sampler, v_texCoord, u_bias)",
            (GlslVersion::Es100, other) => unreachable!(
                "ProgramLibrary::for_params never builds {other:?} under GlslVersion::Es100 (see this match's own comment)"
            ),
            (_, Program::Texture2DFloat) => "texture(u_sampler, v_texCoord)",
            (_, Program::Texture2DFloatBias) => "texture(u_sampler, v_texCoord, u_bias)",
            (_, Program::Texture2DInt) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture2DIntBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::Texture2DUint) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture2DUintBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::Texture2DShadow) => "vec4(texture(u_sampler, vec3(v_texCoord, u_ref)), 0.0, 0.0, 1.0)",
            (_, Program::Texture2DShadowBias) => {
                "vec4(texture(u_sampler, vec3(v_texCoord, u_ref), u_bias), 0.0, 0.0, 1.0)"
            }
            (_, Program::CubeFloat) => "texture(u_sampler, v_texCoord)",
            (_, Program::CubeFloatBias) => "texture(u_sampler, v_texCoord, u_bias)",
            (_, Program::CubeInt) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::CubeIntBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::CubeUint) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::CubeUintBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::CubeShadow) => "vec4(texture(u_sampler, vec4(v_texCoord, u_ref)), 0.0, 0.0, 1.0)",
            (_, Program::CubeShadowBias) => "vec4(texture(u_sampler, vec4(v_texCoord, u_ref), u_bias), 0.0, 0.0, 1.0)",
            (_, Program::Texture3DFloat) => "texture(u_sampler, v_texCoord)",
            (_, Program::Texture3DFloatBias) => "texture(u_sampler, v_texCoord, u_bias)",
            (_, Program::Texture3DInt) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture3DIntBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::Texture3DUint) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture3DUintBias) => "vec4(texture(u_sampler, v_texCoord, u_bias))",
            (_, Program::Texture2DArrayFloat) => "texture(u_sampler, v_texCoord)",
            (_, Program::Texture2DArrayInt) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture2DArrayUint) => "vec4(texture(u_sampler, v_texCoord))",
            (_, Program::Texture2DArrayShadow) => "vec4(texture(u_sampler, vec4(v_texCoord, u_ref)), 0.0, 0.0, 1.0)",
        };

        let params: Vec<(&str, String)> = vec![
            ("VTX_HEADER", vtx_header),
            ("VTX_IN", vtx_in.to_string()),
            ("VTX_OUT", vtx_out.to_string()),
            ("FRAG_HEADER", frag_header),
            ("FRAG_IN", frag_in.to_string()),
            ("FRAG_COLOR", frag_color.to_string()),
            ("PRECISION", self.tex_coord_precision.name().to_string()),
            ("TEXCOORD_TYPE", tex_coord_type.to_string()),
            ("SAMPLER_TYPE", sampler_type.to_string()),
            ("LOOKUP", lookup.to_string()),
        ];

        let vert_src = StringTemplate::new(VERT_SHADER_TEMPLATE).specialize(&params)?;
        let frag_src = StringTemplate::new(FRAG_SHADER_TEMPLATE).specialize(&params)?;

        let built = ShaderProgram::new(self.gl, &ProgramSources::vtx_frag(vert_src, frag_src));
        if !built.is_ok() {
            return Err(TestError::Fail(format!(
                "Failed to compile shader program: {:?}",
                built.build_failure_summary()
            )));
        }
        Ok(built)
    }
}

/// `gls::TextureTestUtil::TextureRenderer`
pub struct TextureRenderer<'gl> {
    render_ctx: &'gl RenderContext,
    program_library: ProgramLibrary<'gl>,
}

impl<'gl> TextureRenderer<'gl> {
    pub fn new(render_ctx: &'gl RenderContext, glsl_version: GlslVersion, tex_coord_precision: Precision) -> Self {
        Self {
            render_ctx,
            program_library: ProgramLibrary::new(render_ctx.functions(), glsl_version, tex_coord_precision),
        }
    }

    pub fn tex_coord_precision(&self) -> Precision {
        self.program_library.tex_coord_precision()
    }

    /// `TextureRenderer::renderQuad` (the `RenderParams` overload - the plain
    /// `TextureType`-only overload is a one-line caller convenience upstream and is not
    /// ported, since every Rust call site can just build a `RenderParams::new` itself).
    ///
    /// `tex_coord` is 4 vertices' worth of `(s, t)` pairs (8 floats), in the same
    /// bottom-left/top-left/bottom-right/top-right vertex order the quad itself uses -
    /// the caller's job, same as upstream's own `const float *texCoord` parameter.
    pub fn render_quad(&mut self, tex_unit: i32, tex_coord: &[f32], params: &RenderParams) -> Result<(), TestError> {
        let prog_spec = Program::for_params(params)?;
        let num_comps = prog_spec.num_tex_coord_components();
        assert_eq!(
            tex_coord.len(),
            num_comps * 4,
            "a {num_comps}-component texture coordinate quad takes {num_comps} components per vertex, 4 vertices"
        );

        let program = self.program_library.get_program(prog_spec)?;
        let prog: GLuint = program.program();
        let gl = self.render_ctx.functions();

        let w = params.w;
        #[rustfmt::skip]
        let position: [f32; 16] = [
            -w.x(), -w.x(), 0.0, w.x(),
            -w.y(),  w.y(), 0.0, w.y(),
             w.z(), -w.z(), 0.0, w.z(),
             w.w(),  w.w(), 0.0, w.w(),
        ];
        let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: `prog` was just built and checked `is_ok()` above, and every call
        // below targets this same current context.
        unsafe {
            gl.use_program(prog);
            gl.uniform_1i(gl.get_uniform_location(prog, c"u_sampler".as_ptr()), tex_unit);
            if params.use_bias {
                gl.uniform_1f(gl.get_uniform_location(prog, c"u_bias".as_ptr()), params.bias);
            }
            if matches!(params.sampler_type, SamplerType::Shadow) {
                gl.uniform_1f(gl.get_uniform_location(prog, c"u_ref".as_ptr()), params.ref_);
            }
            gl.uniform_4fv(
                gl.get_uniform_location(prog, c"u_colorScale".as_ptr()),
                1,
                params.color_scale.m_data.as_ptr(),
            );
            gl.uniform_4fv(
                gl.get_uniform_location(prog, c"u_colorBias".as_ptr()),
                1,
                params.color_bias.m_data.as_ptr(),
            );
            glu::expect_no_error(gl, "Set program state")?;
        }

        let vertex_arrays = [
            va::float("a_position", 4, 4, 0, &position),
            va::float("a_texCoord", num_comps as i32, 4, 0, tex_coord),
        ];
        draw_util::draw(self.render_ctx, prog, &vertex_arrays, &pr::triangles(&indices))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::glu::render_context::ApiType;
    use crate::glu::texture::Texture2D;
    use crate::glu::texture_test_util::{LodMode, ReferenceParams};
    use crate::tcu::pixel::{Sampler, TextureLevel};
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn render_target(width: i32, height: i32) -> RenderTarget {
        RenderTarget {
            width,
            height,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
            alpha_bits: 8,
            depth_bits: 24,
            stencil_bits: 8,
            num_samples: 0,
        }
    }

    /// `preferred_width`/`height` under the render target's own size clamp to it, and
    /// the placement stays within bounds for whatever the RNG draws - checked without
    /// pinning down the RNG's own bit-exact output, which `tcu::random`'s own tests
    /// already cover.
    #[test]
    fn random_viewport_clamps_size_and_stays_in_bounds() {
        let target = render_target(64, 48);
        for seed in 0..32u32 {
            let vp = RandomViewport::new(&target, 256, 256, seed);
            assert_eq!(
                vp.width, 64,
                "seed {seed}: preferred 256 must clamp to the target's own 64"
            );
            assert_eq!(
                vp.height, 48,
                "seed {seed}: preferred 256 must clamp to the target's own 48"
            );
            assert_eq!(vp.x, 0, "seed {seed}: a full-width viewport has exactly one valid x");
            assert_eq!(vp.y, 0, "seed {seed}: a full-height viewport has exactly one valid y");
        }
    }

    /// A viewport smaller than the target leaves room to move; every draw must land
    /// fully inside `[0, target.width - vp.width]` x `[0, target.height - vp.height]`.
    #[test]
    fn random_viewport_preferred_size_stays_within_target_bounds() {
        let target = render_target(64, 48);
        for seed in 0..64u32 {
            let vp = RandomViewport::new(&target, 16, 12, seed);
            assert_eq!(vp.width, 16);
            assert_eq!(vp.height, 12);
            assert!(
                (0..=target.width - vp.width).contains(&vp.x),
                "seed {seed}: x={} out of bounds",
                vp.x
            );
            assert!(
                (0..=target.height - vp.height).contains(&vp.y),
                "seed {seed}: y={} out of bounds",
                vp.y
            );
        }
    }

    /// Builds a tiny checkerboard `glu::Texture2D`, draws it through `TextureRenderer`
    /// at every precision/bias/GLSL-version combination this module supports, and
    /// checks the result against `glu::texture_test_util::sample_texture_2d` - the
    /// host-side reference sampler, exercised end to end
    /// against a real driver. Skips (prints, does not panic) with no
    /// live GL context, as `glu::texture::tests` do.
    #[test]
    fn render_quad_matches_the_reference_sampler_nearest() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping render_quad_matches_the_reference_sampler_nearest: no live GL context available");
            return;
        };

        let mut tex = Texture2D::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 2, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be supported");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);
            level0.set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0);
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 1, 0);
            level0.set_pixel([1.0, 1.0, 0.0, 1.0], 1, 1, 0);
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        let tex_coord: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];
        renderer
            .render_quad(0, &tex_coord, &RenderParams::new(TextureType::Texture2D))
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        // Build the expected image the same way the reference sampler would, through
        // the exact same quad corner <-> texcoord pairing as the real draw above.
        let level0 = tex.ref_texture().level(0);
        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let ref_params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_2d(&mut expected.get_access(), &[level0], tex_coord, &ref_params);

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
    }

    /// The `SamplerType::Shadow` counterpart of the test above: a `sampler2DShadow`
    /// program (`GL_TEXTURE_COMPARE_MODE = GL_COMPARE_REF_TO_TEXTURE`, matching what a
    /// real `texture.shadow.*` case sets on its depth texture) compared against
    /// `glu::texture_test_util::sample_texture_2d`'s own `SamplerType::Shadow` path -
    /// end to end through a real driver for the first time.
    #[test]
    fn render_quad_shadow_sampler_matches_the_reference_sampler() {
        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping render_quad_shadow_sampler_matches_the_reference_sampler: no live GL context available"
            );
            return;
        };

        let mut tex = Texture2D::new(&context, glw::GL_DEPTH_COMPONENT, glw::GL_UNSIGNED_SHORT, 2, 2)
            .expect("GL_DEPTH_COMPONENT/GL_UNSIGNED_SHORT must be supported");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            level0.set_pixel([0.4, 0.0, 0.0, 1.0], 1, 0, 0);
            level0.set_pixel([0.6, 0.0, 0.0, 1.0], 0, 1, 0);
            level0.set_pixel([0.8, 0.0, 0.0, 1.0], 1, 1, 0);
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as i32);
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        let tex_coord: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];
        let mut params = RenderParams::new(TextureType::Texture2D);
        params.sampler_type = SamplerType::Shadow;
        params.ref_ = 0.5;
        renderer
            .render_quad(0, &tex_coord, &params)
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let level0 = tex.ref_texture().level(0);
        let sampler = Sampler {
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::Less,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let mut ref_params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        ref_params.base.sampler_type = SamplerType::Shadow;
        ref_params.base.ref_ = 0.5;
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_2d(&mut expected.get_access(), &[level0], tex_coord, &ref_params);

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
    }

    /// The `TextureType::Cube` counterpart: a `samplerCube` program, a real
    /// `glu::texture_cube::TextureCube` with a distinct solid colour per face, and a
    /// quad whose four corners all share the same direction vector (so the result is
    /// one face's own colour everywhere) - checked against
    /// `glu::texture_test_util::sample_texture_cube`'s own reference path.
    #[test]
    fn render_quad_cube_sampler_matches_the_reference_sampler() {
        use crate::glu::texture_cube::{ALL_FACES, TextureCube};

        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping render_quad_cube_sampler_matches_the_reference_sampler: no live GL context available");
            return;
        };

        let mut tex = TextureCube::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be supported");
        let face_colors: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ];
        tex.ref_texture_mut().alloc_level(0);
        for (face, color) in ALL_FACES.into_iter().zip(face_colors) {
            let mut access = tex.ref_texture_mut().face_level_mut(face, 0);
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex.gl_texture());
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        // -Z direction at all four corners -> the whole quad samples the -Z face.
        let tex_coord: [f32; 12] = [0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, -1.0];
        renderer
            .render_quad(0, &tex_coord, &RenderParams::new(TextureType::Cube))
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let levels = [tex.ref_texture().level(0)];
        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let ref_params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_cube(&mut expected.get_access(), &levels, tex_coord, &ref_params);

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
        // Both the driver and the reference must agree it's specifically the -Z
        // face's own colour, not merely that the two happen to match each other.
        assert_eq!(actual.get_pixel(0, 0, 0), face_colors[5]);
    }

    /// The `Cube`+`Shadow` counterpart of the two tests above: a real
    /// `samplerCubeShadow` program against a `GL_TEXTURE_CUBE_MAP` depth texture with
    /// `GL_COMPARE_REF_TO_TEXTURE`, checked against
    /// `glu::texture_test_util::sample_texture_cube`'s own `SamplerType::Shadow` path
    /// (which in turn goes through `tcu::pixel::sample_cube_mipmap_compare`) - a live-driver
    /// check of the cube-shadow sampler `Program::CubeShadow` adds.
    #[test]
    fn render_quad_cube_shadow_sampler_matches_the_reference_sampler() {
        use crate::glu::texture_cube::{ALL_FACES, TextureCube};

        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping render_quad_cube_shadow_sampler_matches_the_reference_sampler: no live GL context available"
            );
            return;
        };

        let mut tex = TextureCube::new(&context, glw::GL_DEPTH_COMPONENT, glw::GL_UNSIGNED_SHORT, 2)
            .expect("GL_DEPTH_COMPONENT/GL_UNSIGNED_SHORT must be supported");
        // +X shallow (0.3), -Z deep (0.7) - same two faces the colour test above checks.
        let face_depths: [f32; 6] = [0.3, 0.5, 0.5, 0.5, 0.5, 0.7];
        tex.ref_texture_mut().alloc_level(0);
        for (face, depth) in ALL_FACES.into_iter().zip(face_depths) {
            let mut access = tex.ref_texture_mut().face_level_mut(face, 0);
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel([depth, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex.gl_texture());
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_COMPARE_FUNC,
                glw::GL_LESS as i32,
            );
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        // +X direction at all four corners -> the whole quad samples the +X face.
        let tex_coord: [f32; 12] = [1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0];
        let mut params = RenderParams::new(TextureType::Cube);
        params.sampler_type = SamplerType::Shadow;
        params.ref_ = 0.5;
        renderer
            .render_quad(0, &tex_coord, &params)
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let levels = [tex.ref_texture().level(0)];
        let sampler = Sampler {
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::Less,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let mut ref_params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);
        ref_params.base.sampler_type = SamplerType::Shadow;
        ref_params.base.ref_ = 0.5;
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_cube(&mut expected.get_access(), &levels, tex_coord, &ref_params);

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
        // +X stores 0.3; ref 0.5 < 0.3 fails -> channel 0 must be 0.0 on both sides.
        assert_eq!(actual.get_pixel(0, 0, 0)[0], 0.0);
    }

    /// The `TextureType::Texture3D` counterpart of the 2D/cube `samplerFloat` tests
    /// above: a real `sampler3D` program against a `GL_TEXTURE_3D` object with a
    /// distinct colour per depth slice, checked against
    /// `glu::texture_test_util::sample_texture_3d`'s own reference path.
    #[test]
    fn render_quad_3d_sampler_matches_the_reference_sampler() {
        use crate::glu::texture_3d::Texture3D;

        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!("skipping render_quad_3d_sampler_matches_the_reference_sampler: no live GL context available");
            return;
        };

        let mut tex = Texture3D::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 1, 1, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be supported");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // slice 0: red
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // slice 1: blue
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_3D, tex.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        // Both left corners (tex_coord order (-1,-1),(-1,1),(1,-1),(1,1)) sample
        // r=0.25 (slice 0), both right corners sample r=0.75 (slice 1).
        let tex_coord: [f32; 12] = [0.5, 0.5, 0.25, 0.5, 0.5, 0.25, 0.5, 0.5, 0.75, 0.5, 0.5, 0.75];
        renderer
            .render_quad(0, &tex_coord, &RenderParams::new(TextureType::Texture3D))
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let levels = [tex.ref_texture().level(0)];
        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let ref_params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_3d(&mut expected.get_access(), &levels, tex_coord, &ref_params);

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
        // Left column samples slice 0 (red), right column slice 1 (blue) - on both
        // the driver and the reference, not merely matching each other.
        assert_eq!(actual.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(actual.get_pixel(3, 0, 0), [0.0, 0.0, 1.0, 1.0]);
    }

    /// The `TextureType::Texture2DArray` counterpart: a real `sampler2DArray` program
    /// against a `GL_TEXTURE_2D_ARRAY` object with a distinct colour per layer, checked
    /// against `glu::texture_test_util::sample_texture_2d_array`'s own reference path.
    #[test]
    fn render_quad_2d_array_sampler_matches_the_reference_sampler() {
        use crate::glu::texture_2d_array::Texture2DArray;

        let Ok(context) = RenderContext::create(ApiType::es(3, 0), 0) else {
            eprintln!(
                "skipping render_quad_2d_array_sampler_matches_the_reference_sampler: no live GL context available"
            );
            return;
        };

        let mut tex = Texture2DArray::new(&context, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, 1, 1, 2)
            .expect("GL_RGBA/GL_UNSIGNED_BYTE must be supported");
        tex.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = tex.ref_texture_mut().level_mut(0);
            level0.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // layer 0: red
            level0.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // layer 1: blue
        }
        unsafe { tex.upload() }.expect("upload must succeed against a real driver");

        let gl = context.functions();
        unsafe {
            gl.viewport(0, 0, 4, 4);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, tex.gl_texture());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );
        }

        let mut renderer = TextureRenderer::new(&context, GlslVersion::Es300, Precision::HighP);
        // Both left corners sample layer 0, both right corners sample layer 1.
        let tex_coord: [f32; 12] = [0.5, 0.5, 0.0, 0.5, 0.5, 0.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0];
        renderer
            .render_quad(0, &tex_coord, &RenderParams::new(TextureType::Texture2DArray))
            .expect("render_quad must succeed");

        let mut result =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        glu::read_pixels(&context, 0, 0, &mut result.get_access()).expect("readPixels must succeed");

        let levels = [tex.ref_texture().level(0)];
        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
        };
        let ref_params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        let mut expected =
            TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8), 4, 4, 1).unwrap();
        crate::glu::texture_test_util::sample_texture_2d_array(
            &mut expected.get_access(),
            &levels,
            tex_coord,
            &ref_params,
        );

        let actual = result.get_const_access();
        let want = expected.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let a = actual.get_pixel(x, y, 0);
                let w = want.get_pixel(x, y, 0);
                for c in 0..4 {
                    assert!(
                        (a[c] - w[c]).abs() < 1.0 / 255.0 + 1e-6,
                        "pixel ({x},{y}) channel {c}: driver={a:?} reference={w:?}"
                    );
                }
            }
        }
        assert_eq!(actual.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(actual.get_pixel(3, 0, 0), [0.0, 0.0, 1.0, 1.0]);
    }
}
