// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderTextureFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `.invalid` sub-group comes from `invalid_texture_functions.test`. `vertex`/
// `fragment` are `ShaderTextureFunctionCase`/`gls::ShaderRenderCase`-driven: each renders
// a textured quad once through the real driver and once through a from-scratch host
// texture-sampling reference (`tcu::pixel::sample_2d_mipmap`/`sample_cube_mipmap`), the
// same "host computes, GL renders, `fuzzyCompare`" shape every other `shaders.*` group in
// this port already uses - `gls::shader_render_case`'s own header used to say
// `TextureBinding` was deliberately not ported for exactly this reason ("the
// texture-upload helpers this tree does not have"); this file is what closes that gap,
// scoped to what ES 2.0's `texture2D`/`textureCube` lookups need (2D and cube, `REPEAT`
// wrap, `LINEAR`/`LINEAR_MIPMAP_NEAREST` filtering - no 3D/array/shadow/gather, which is
// what the ES 3.x sibling would additionally need and is not attempted here).

use std::sync::OnceLock;

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec, viewport_size};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;
use crate::tcu::matrix::Mat4;
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, CubeFace, FilterMode, PixelBufferAccess, Sampler, TextureLevel, WrapMode,
    get_cube_array_face_index, get_cube_face_coords, sample_2d_mipmap, sample_cube_mipmap,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec4;

/// `Function` - `FUNCTION_TEXTURELOD3`/`FUNCTION_TEXTUREPROJLOD3` do not exist upstream;
/// they are folded into `TextureLod`/`TextureProjLod3` here exactly as upstream's own
/// six-value enum has them.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Function {
    Texture,
    TextureProj,
    TextureProj3,
    TextureLod,
    TextureProjLod,
    TextureProjLod3,
}

impl Function {
    /// `functionHasProj`
    fn has_proj(self) -> bool {
        matches!(
            self,
            Self::TextureProj | Self::TextureProj3 | Self::TextureProjLod | Self::TextureProjLod3
        )
    }

    /// `functionHasLod`
    fn has_lod(self) -> bool {
        matches!(self, Self::TextureLod | Self::TextureProjLod | Self::TextureProjLod3)
    }

    /// The projective divide upstream picks by `function == FUNCTION_TEXTUREPROJ3`: the
    /// `vec3`-coordinate forms divide by `z`, the `vec4` forms (proj by a homogeneous `w`)
    /// divide by `w`.
    fn proj_by_z(self) -> bool {
        matches!(self, Self::TextureProj3 | Self::TextureProjLod3)
    }

    /// `funcExt` in `initShaderSources`.
    fn glsl_suffix(self) -> &'static str {
        match self {
            Self::Texture => "",
            Self::TextureProj | Self::TextureProj3 => "Proj",
            Self::TextureLod => "Lod",
            Self::TextureProjLod | Self::TextureProjLod3 => "ProjLod",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexKind {
    Tex2D,
    Cube,
}

/// `TextureSpec`, narrowed to the two RGBA8/`REPEAT` shapes this file's cases use -
/// `format`/`dataType`/wrap mode never vary, so those upstream fields are not carried.
#[derive(Clone, Copy)]
struct TextureSpec {
    kind: TexKind,
    size: u32,
    num_levels: u32,
    min_filter: GLint,
}

const TEX_2D: TextureSpec = TextureSpec {
    kind: TexKind::Tex2D,
    size: 256,
    num_levels: 1,
    min_filter: glw::GL_LINEAR as GLint,
};
const TEX_2D_MIPMAP: TextureSpec = TextureSpec {
    kind: TexKind::Tex2D,
    size: 256,
    num_levels: 9,
    min_filter: glw::GL_LINEAR_MIPMAP_NEAREST as GLint,
};
const TEX_CUBE: TextureSpec = TextureSpec {
    kind: TexKind::Cube,
    size: 256,
    num_levels: 1,
    min_filter: glw::GL_LINEAR as GLint,
};
const TEX_CUBE_MIPMAP: TextureSpec = TextureSpec {
    kind: TexKind::Cube,
    size: 256,
    num_levels: 9,
    min_filter: glw::GL_LINEAR_MIPMAP_NEAREST as GLint,
};

/// `TextureLookupSpec`
#[derive(Clone, Copy)]
struct LookupSpec {
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
}

/// `TexFuncCaseSpec` - transcribed straight off upstream's `CASE_SPEC` tables.
struct CaseSpec {
    name: &'static str,
    lookup: LookupSpec,
    tex: TextureSpec,
}

const fn lookup(
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
) -> LookupSpec {
    LookupSpec {
        function,
        min_coord,
        max_coord,
        use_bias,
        min_lod_bias,
        max_lod_bias,
    }
}

const VERTEX_CASES: &[CaseSpec] = &[
    CaseSpec {
        name: "texture2d",
        lookup: lookup(
            Function::Texture,
            [-0.2, -0.4, 0.0, 0.0],
            [1.5, 2.3, 0.0, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D,
    },
    CaseSpec {
        name: "texture2dproj_vec3",
        lookup: lookup(
            Function::TextureProj3,
            [-0.3, -0.6, 1.5, 0.0],
            [2.25, 3.45, 1.5, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D,
    },
    CaseSpec {
        name: "texture2dproj_vec4",
        lookup: lookup(
            Function::TextureProj,
            [-0.3, -0.6, 0.0, 1.5],
            [2.25, 3.45, 0.0, 1.5],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D,
    },
    CaseSpec {
        name: "texture2dlod",
        lookup: lookup(
            Function::TextureLod,
            [-0.2, -0.4, 0.0, 0.0],
            [1.5, 2.3, 0.0, 0.0],
            false,
            -1.0,
            9.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dprojlod_vec3",
        lookup: lookup(
            Function::TextureProjLod3,
            [-0.3, -0.6, 1.5, 0.0],
            [2.25, 3.45, 1.5, 0.0],
            false,
            -1.0,
            9.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dprojlod_vec4",
        lookup: lookup(
            Function::TextureProjLod,
            [-0.3, -0.6, 0.0, 1.5],
            [2.25, 3.45, 0.0, 1.5],
            false,
            -1.0,
            9.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texturecube",
        lookup: lookup(
            Function::Texture,
            [-1.0, -1.0, 1.01, 0.0],
            [1.0, 1.0, 1.01, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_CUBE,
    },
    CaseSpec {
        name: "texturecubelod",
        lookup: lookup(
            Function::TextureLod,
            [-1.0, -1.0, 1.01, 0.0],
            [1.0, 1.0, 1.01, 0.0],
            false,
            -1.0,
            9.0,
        ),
        tex: TEX_CUBE_MIPMAP,
    },
];

const FRAGMENT_CASES: &[CaseSpec] = &[
    CaseSpec {
        name: "texture2d",
        lookup: lookup(
            Function::Texture,
            [-0.2, -0.4, 0.0, 0.0],
            [1.5, 2.3, 0.0, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2d_bias",
        lookup: lookup(
            Function::Texture,
            [-0.2, -0.4, 0.0, 0.0],
            [1.5, 2.3, 0.0, 0.0],
            true,
            -2.0,
            2.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dproj_vec3",
        lookup: lookup(
            Function::TextureProj3,
            [-0.3, -0.6, 1.5, 0.0],
            [2.25, 3.45, 1.5, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dproj_vec4",
        lookup: lookup(
            Function::TextureProj,
            [-0.3, -0.6, 0.0, 1.5],
            [2.25, 3.45, 0.0, 1.5],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dproj_vec3_bias",
        lookup: lookup(
            Function::TextureProj3,
            [-0.3, -0.6, 1.5, 0.0],
            [2.25, 3.45, 1.5, 0.0],
            true,
            -2.0,
            2.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texture2dproj_vec4_bias",
        lookup: lookup(
            Function::TextureProj,
            [-0.3, -0.6, 0.0, 1.5],
            [2.25, 3.45, 0.0, 1.5],
            true,
            -2.0,
            2.0,
        ),
        tex: TEX_2D_MIPMAP,
    },
    CaseSpec {
        name: "texturecube",
        lookup: lookup(
            Function::Texture,
            [-1.0, -1.0, 1.01, 0.0],
            [1.0, 1.0, 1.01, 0.0],
            false,
            0.0,
            0.0,
        ),
        tex: TEX_CUBE_MIPMAP,
    },
    CaseSpec {
        name: "texturecube_bias",
        lookup: lookup(
            Function::Texture,
            [-1.0, -1.0, -1.01, 0.0],
            [1.0, 1.0, -1.01, 0.0],
            true,
            -2.0,
            2.0,
        ),
        tex: TEX_CUBE_MIPMAP,
    },
];

/// `fillWithGrid`, generalised over the depth slice a cube face's fill lands on (a 2D
/// texture always fills slice 0).
fn fill_with_grid(
    access: &mut PixelBufferAccess<'_>,
    depth: u32,
    cell_size: u32,
    color_even: [f32; 4],
    color_odd: [f32; 4],
) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let parity = ((x / cell_size) % 2) ^ ((y / cell_size) % 2);
            access.set_pixel(if parity != 0 { color_odd } else { color_even }, x, y, depth);
        }
    }
}

/// `texCubeSwz` - which two of `(fA, fB)` land in each of a face's four channels.
fn cube_swizzle(face: CubeFace) -> [usize; 4] {
    match face {
        CubeFace::NegativeX => [0, 0, 1, 1],
        CubeFace::PositiveX => [1, 1, 0, 0],
        CubeFace::NegativeY => [0, 1, 0, 1],
        CubeFace::PositiveY => [1, 0, 1, 0],
        CubeFace::NegativeZ => [0, 1, 1, 0],
        CubeFace::PositiveZ => [1, 0, 0, 1],
    }
}

const CUBE_FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `ShaderTextureFunctionCase::initTexture`'s mip-pyramid construction - a checkerboard
/// per level, its cell size and colour pair narrowing towards a single colour as the
/// level index approaches the top. Built once, with no GL context at all: the same
/// pixel data is later both read back by `evaluate` (the CPU reference) and uploaded to a
/// real GL texture object (`upload_texture`), which is what keeps the two renders
/// comparable. `fmtInfo.valueMin`/`valueMax` are `[0,0,0,0]`/`[1,1,1,1]` for plain
/// `UNORM_INT8` RGBA (`getTextureFormatInfo`'s default case), so `cBias`/`cScale` collapse
/// to `0`/`1` and are not carried here.
fn build_texture_levels(tex: TextureSpec) -> Vec<TextureLevel> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let base_cell_size = tex.size / 4;
    let denom = (tex.num_levels - 1).max(1) as f32;
    let c_step = 1.0 / denom;

    (0..tex.num_levels)
        .map(|level| {
            let f_a = level as f32 * c_step;
            let f_b = 1.0 - f_a;
            let size_at_level = (tex.size >> level).max(1);
            let cell_size = (base_cell_size >> level).max(1);

            let depth = if tex.kind == TexKind::Cube { 6 } else { 1 };
            let mut tex_level = TextureLevel::new(format, size_at_level, size_at_level, depth)
                .expect("texture_functions: RGBA8 is always a writable, sized format");

            match tex.kind {
                TexKind::Tex2D => {
                    let color_a = [f_a, f_b, f_a, f_b];
                    let color_b = [f_b, f_a, f_b, f_a];
                    fill_with_grid(&mut tex_level.get_access(), 0, cell_size, color_a, color_b);
                }
                TexKind::Cube => {
                    for face in CUBE_FACES {
                        let swz = cube_swizzle(face);
                        let f = [f_a, f_b];
                        let color_a: [f32; 4] = std::array::from_fn(|c| f[swz[c]]);
                        let color_b: [f32; 4] = std::array::from_fn(|c| f[1 - swz[c]]);
                        let slice = get_cube_array_face_index(face);
                        fill_with_grid(&mut tex_level.get_access(), slice, cell_size, color_a, color_b);
                    }
                }
            }

            tex_level
        })
        .collect()
}

/// Uploads `levels` (built by `build_texture_levels`) into a fresh GL texture object,
/// one `glTexImage2D` per level (and per cube face) - never `glGenerateMipmap`, which
/// would box-filter a continuous gradient instead of reproducing this test's own
/// hand-built checkerboard pyramid, silently breaking the very comparison this relies on.
fn upload_texture(gl: &glw::Functions, tex: TextureSpec, levels: &[TextureLevel]) -> GLuint {
    let target = match tex.kind {
        TexKind::Tex2D => glw::GL_TEXTURE_2D,
        TexKind::Cube => glw::GL_TEXTURE_CUBE_MAP,
    };

    let mut texture: GLuint = 0;
    // SAFETY: one object is asked for and one `GLuint` of output is given; every call
    // below targets that same, just-bound object.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(target, texture);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, tex.min_filter);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as GLint);

        for (level_ndx, level) in levels.iter().enumerate() {
            let [size, _, _] = level.size();
            let data = level.data();
            let face_bytes = size as usize * size as usize * 4;

            match tex.kind {
                TexKind::Tex2D => {
                    gl.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        level_ndx as GLint,
                        glw::GL_RGBA as GLint,
                        size as GLint,
                        size as GLint,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast(),
                    );
                }
                TexKind::Cube => {
                    for face_ndx in 0..6usize {
                        let face_data = &data[face_ndx * face_bytes..(face_ndx + 1) * face_bytes];
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face_ndx as u32,
                            level_ndx as GLint,
                            glw::GL_RGBA as GLint,
                            size as GLint,
                            size as GLint,
                            0,
                            glw::GL_RGBA,
                            glw::GL_UNSIGNED_BYTE,
                            face_data.as_ptr().cast(),
                        );
                    }
                }
            }
        }

        gl.bind_texture(target, 0);
    }

    texture
}

/// `computeLodFromDerivates(LODMODE_EXACT, dudx, 0.0, 0.0, dvdy)`.
fn compute_lod_exact(dudx: f32, dvdy: f32) -> f32 {
    dudx.abs().max(dvdy.abs()).log2()
}

/// `ShaderTextureFunctionCase::initTexture`'s two `computeLodFromDerivates` call sites.
fn compute_lod(lookup: &LookupSpec, tex: TextureSpec, viewport: (f32, f32)) -> f32 {
    let use_proj = lookup.function.has_proj() && !lookup.function.has_lod();
    let proj = if use_proj {
        let divisor = if lookup.function.proj_by_z() {
            lookup.min_coord[2]
        } else {
            lookup.min_coord[3]
        };
        1.0 / divisor
    } else {
        1.0
    };

    match tex.kind {
        TexKind::Tex2D => {
            let dudx = (lookup.max_coord[0] - lookup.min_coord[0]) * proj * tex.size as f32 / viewport.0;
            let dvdy = (lookup.max_coord[1] - lookup.min_coord[1]) * proj * tex.size as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
        TexKind::Cube => {
            let scaled = |c: [f32; 4]| [c[0] * proj, c[1] * proj, c[2] * proj];
            let (_, c00) = get_cube_face_coords(scaled(lookup.min_coord));
            let (_, c10) = get_cube_face_coords(scaled([
                lookup.max_coord[0],
                lookup.min_coord[1],
                lookup.min_coord[2],
                0.0,
            ]));
            let (_, c01) = get_cube_face_coords(scaled([
                lookup.min_coord[0],
                lookup.max_coord[1],
                lookup.min_coord[2],
                0.0,
            ]));
            let dudx = (c10[0] - c00[0]) * tex.size as f32 / viewport.0;
            let dvdy = (c01[1] - c00[1]) * tex.size as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
    }
}

/// `ShaderTextureFunctionCase`
struct ShaderTextureFunctionCase {
    name: String,
    lookup: LookupSpec,
    tex: TextureSpec,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
    user_attrib_transforms: Vec<Mat4>,
    levels: Vec<TextureLevel>,
    lod: OnceLock<f32>,
    gl_texture: OnceLock<GLuint>,
}

/// `s.x, 0, 0, b.x / 0, s.y, 0, b.y / ...` - `ShaderTextureFunctionCase::init`'s two
/// `m_userAttribTransforms` entries, both diagonal-plus-bias matrices built straight off
/// the lookup's own coordinate/lod-bias range.
fn coord_transform(min_coord: [f32; 4], max_coord: [f32; 4]) -> Mat4 {
    let s: [f32; 4] = std::array::from_fn(|i| max_coord[i] - min_coord[i]);
    let b = min_coord;

    let mut m = Mat4::zero();
    m.set(0, 0, s[0]);
    m.set(0, 3, b[0]);
    m.set(1, 1, s[1]);
    m.set(1, 3, b[1]);
    m.set(2, 0, s[2] / 2.0);
    m.set(2, 1, -s[2] / 2.0);
    m.set(2, 3, s[2] / 2.0 + b[2]);
    m.set(3, 0, -s[3] / 2.0);
    m.set(3, 1, s[3] / 2.0);
    m.set(3, 3, s[3] / 2.0 + b[3]);
    m
}

fn lod_transform(min_lod_bias: f32, max_lod_bias: f32) -> Mat4 {
    let mut m = Mat4::zero();
    let s = max_lod_bias - min_lod_bias;
    m.set(0, 0, s / 2.0);
    m.set(0, 1, s / 2.0);
    m.set(0, 3, min_lod_bias);
    m
}

impl ShaderTextureFunctionCase {
    fn new(case: &CaseSpec, is_vertex_case: bool) -> Self {
        let lookup = case.lookup;
        let tex = case.tex;

        let mut user_attrib_transforms = vec![coord_transform(lookup.min_coord, lookup.max_coord)];
        if lookup.function.has_lod() || lookup.use_bias {
            user_attrib_transforms.push(lod_transform(lookup.min_lod_bias, lookup.max_lod_bias));
        }

        let (vert_src, frag_src) = build_shader_sources(lookup, tex.kind, is_vertex_case);

        Self {
            name: case.name.to_string(),
            lookup,
            tex,
            is_vertex_case,
            vert_src,
            frag_src,
            user_attrib_transforms,
            levels: build_texture_levels(tex),
            lod: OnceLock::new(),
            gl_texture: OnceLock::new(),
        }
    }
}

impl ShaderRenderCaseSpec for ShaderTextureFunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn user_attrib_transforms(&self) -> Vec<Mat4> {
        self.user_attrib_transforms.clone()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.is_vertex_case {
            let gl = context.gl();
            let mut units: GLint = 0;
            // SAFETY: `units` is a valid destination for one `GLint`.
            unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &mut units) };
            if units < 1 {
                return Err(TestError::NotSupported(
                    "Vertex shader texture access is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn setup_uniforms(&self, context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
        let gl = context.gl();

        self.lod.get_or_init(|| {
            let size = viewport_size(context);
            compute_lod(&self.lookup, self.tex, (size.x() as f32, size.y() as f32))
        });

        let texture = *self
            .gl_texture
            .get_or_init(|| upload_texture(gl, self.tex, &self.levels));
        let target = match self.tex.kind {
            TexKind::Tex2D => glw::GL_TEXTURE_2D,
            TexKind::Cube => glw::GL_TEXTURE_CUBE_MAP,
        };

        let name = std::ffi::CString::new("u_sampler").expect("no interior NUL");
        // SAFETY: a NUL-terminated name and a program this case built.
        let loc = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
        // SAFETY: `texture` is this case's own object for `target`; `loc` is checked.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(target, texture);
            if loc != -1 {
                gl.uniform_1i(loc, 0);
            }
        }
        Ok(())
    }

    fn cleanup(&self, context: &Context) {
        if let Some(&texture) = self.gl_texture.get() {
            let gl = context.gl();
            // SAFETY: `texture` is this case's own, deleted at most once.
            unsafe { gl.delete_textures(1, &texture) };
        }
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        let lod_base = self.lod.get().copied().unwrap_or(0.0);
        let in0 = ctx.in_[0];
        let in1 = ctx.in_[1];

        let (s, t) = if self.lookup.function.has_proj() {
            let divisor = if self.lookup.function.proj_by_z() {
                in0.z()
            } else {
                in0.w()
            };
            (in0.x() / divisor, in0.y() / divisor)
        } else {
            (in0.x(), in0.y())
        };

        let lod = if self.lookup.function.has_lod() {
            in1.x()
        } else if self.lookup.use_bias {
            lod_base + in1.x()
        } else {
            lod_base
        };

        let levels: Vec<ConstPixelBufferAccess<'_>> = self.levels.iter().map(TextureLevel::get_const_access).collect();
        let sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter: FilterMode::Linear,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };

        let color = match self.tex.kind {
            TexKind::Tex2D => sample_2d_mipmap(&levels, &sampler, s, t, lod),
            TexKind::Cube => sample_cube_mipmap(&levels, &sampler, s, t, in0.z(), lod),
        };
        ctx.color = Vec4::from_array(color);
    }
}

/// `ShaderTextureFunctionCase::initShaderSources`
fn build_shader_sources(lookup: LookupSpec, tex_kind: TexKind, is_vertex_case: bool) -> (String, String) {
    let function = lookup.function;
    let is_proj = function.has_proj();
    let is_2d_proj4 =
        tex_kind == TexKind::Tex2D && matches!(function, Function::TextureProj | Function::TextureProjLod);
    let has_lod_bias = function.has_lod() || lookup.use_bias;
    let tex_coord_comps = if tex_kind == TexKind::Tex2D { 2 } else { 3 };
    let extra_coord_comps = if is_proj { if is_2d_proj4 { 2 } else { 1 } } else { 0 };
    let coord_type = format!("vec{}", tex_coord_comps + extra_coord_comps);
    let sampler_type = match tex_kind {
        TexKind::Tex2D => "sampler2D",
        TexKind::Cube => "samplerCube",
    };
    let base_func_name = match tex_kind {
        TexKind::Tex2D => "texture2D",
        TexKind::Cube => "textureCube",
    };
    let func_ext = function.glsl_suffix();

    let mut vert = String::new();
    let mut frag = String::new();

    vert.push_str("attribute highp vec4 a_position;\n");
    vert.push_str(&format!("attribute mediump {coord_type} a_in0;\n"));
    if has_lod_bias {
        vert.push_str("attribute mediump float a_in1;\n");
    }

    if is_vertex_case {
        vert.push_str("varying mediump vec4 v_color;\n");
        frag.push_str("varying mediump vec4 v_color;\n");
    } else {
        vert.push_str(&format!("varying mediump {coord_type} v_texCoord;\n"));
        frag.push_str(&format!("varying mediump {coord_type} v_texCoord;\n"));
        if has_lod_bias {
            vert.push_str("varying mediump float v_lodBias;\n");
            frag.push_str("varying mediump float v_lodBias;\n");
        }
    }

    if is_vertex_case {
        vert.push_str(&format!("uniform lowp {sampler_type} u_sampler;\n"));
    } else {
        frag.push_str(&format!("uniform lowp {sampler_type} u_sampler;\n"));
    }

    vert.push_str("\nvoid main()\n{\n\tgl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    let tex_coord = if is_vertex_case { "a_in0" } else { "v_texCoord" };
    let lod_bias = if is_vertex_case { "a_in1" } else { "v_lodBias" };
    let mut op = format!("{base_func_name}{func_ext}(u_sampler, {tex_coord}");
    if function.has_lod() || lookup.use_bias {
        op.push_str(&format!(", {lod_bias}"));
    }
    op.push_str(");\n");

    if is_vertex_case {
        vert.push_str("\tv_color = ");
        vert.push_str(&op);
        frag.push_str("\tgl_FragColor = v_color;\n");
    } else {
        frag.push_str("\tgl_FragColor = ");
        frag.push_str(&op);
        vert.push_str("\tv_texCoord = a_in0;\n");
        if has_lod_bias {
            vert.push_str("\tv_lodBias = a_in1;\n");
        }
    }

    vert.push_str("}\n");
    frag.push_str("}\n");

    (vert, frag)
}

fn create_case_group(parent: &mut TestCaseGroup, group_name: &str, cases: &[CaseSpec], is_vertex: bool) {
    let mut group = TestCaseGroup::new(group_name);
    for case in cases {
        group.add_child(
            Box::new(ShaderRenderCase::new(ShaderTextureFunctionCase::new(case, is_vertex))) as Box<dyn TestCase>,
        );
    }
    parent.add_child(group);
}

/// `ShaderTextureFunctionTests::init`, restricted to the shader-library cases plus the
/// `vertex`/`fragment` lookup cases this file now ports.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_functions");
    create_case_group(&mut group, "vertex", VERTEX_CASES, true);
    create_case_group(&mut group, "fragment", FRAGMENT_CASES, false);
    group.add_child(create_group("invalid", &lib::gles2_invalid_texture_functions::ROOT));

    group
}
