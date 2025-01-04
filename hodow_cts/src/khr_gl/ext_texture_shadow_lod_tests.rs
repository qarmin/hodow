// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_shadow_lod/esextcTextureShadowLodFunctionsTest.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's table of evaluation function pointers is the `Eval` enum, and the case is a `gls::ShaderRenderCaseSpec` of the Khronos flavour (`glcShaderRenderCase`).

use std::sync::OnceLock;

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec, viewport_size};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::TestError;
use crate::tcu::matrix::Mat4;
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, CubeFace, FilterMode, PixelBufferAccess, Sampler, TextureLevel, WrapMode,
    get_cube_face_coords, get_texture_format_info, sample_2d_array_mipmap, sample_2d_array_mipmap_offset,
    sample_cube_array_mipmap, sample_cube_mipmap,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Function {
    Texture,
    TextureLod,
}

impl Function {
    fn has_auto_lod(self, is_vertex_case: bool) -> bool {
        !is_vertex_case && self == Self::Texture
    }

    fn has_lod(self) -> bool {
        self == Self::TextureLod
    }

    fn base_name(self) -> &'static str {
        match self {
            Self::Texture => "texture",
            Self::TextureLod => "textureLod",
        }
    }
}

#[derive(Clone, Copy)]
struct LookupSpec {
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
    use_offset: bool,
    offset: [i32; 3],
    use_sep_ref: bool,
    min_sep_ref: f32,
    max_sep_ref: f32,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TextureType {
    CubeMap,
    CubeMapArray,
    Array2D,
}

#[derive(Clone, Copy)]
struct TextureSpec {
    type_: TextureType,
    width: u32,
    height: u32,
    depth: u32,
    num_levels: u32,
}

#[derive(Clone, Copy)]
enum Eval {
    Array2D,
    Array2DBias,
    Array2DOffset,
    Array2DOffsetBias,
    Array2DLod,
    Array2DLodOffset,
    CubeLod,
    CubeArray,
    CubeArrayBias,
    CubeArrayLod,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Flags {
    Vertex,
    Fragment,
    Both,
}

struct CaseSpec {
    name: &'static str,
    lookup: LookupSpec,
    tex: TextureSpec,
    eval: Eval,
    flags: Flags,
}

const TEX_2D_ARRAY_SHADOW: TextureSpec = TextureSpec {
    type_: TextureType::Array2D,
    width: 128,
    height: 128,
    depth: 4,
    num_levels: 1,
};
const TEX_CUBE_MIPMAP_SHADOW: TextureSpec = TextureSpec {
    type_: TextureType::CubeMap,
    width: 256,
    height: 256,
    depth: 1,
    num_levels: 9,
};
const TEX_CUBE_ARRAY_SHADOW: TextureSpec = TextureSpec {
    type_: TextureType::CubeMapArray,
    width: 128,
    height: 128,
    depth: 4,
    num_levels: 1,
};
const TEX_CUBE_ARRAY_MIPMAP_SHADOW: TextureSpec = TextureSpec {
    type_: TextureType::CubeMapArray,
    width: 128,
    height: 128,
    depth: 4,
    num_levels: 8,
};
const TEX_2D_ARRAY_MIPMAP_SHADOW: TextureSpec = TextureSpec {
    type_: TextureType::Array2D,
    width: 128,
    height: 128,
    depth: 4,
    num_levels: 8,
};

const ARRAY_MIN: [f32; 4] = [-1.2, -0.4, -0.5, 0.0];
const ARRAY_MAX: [f32; 4] = [1.5, 2.3, 3.5, 1.0];
const CUBE_ARRAY_MIN: [f32; 4] = [-1.0, -1.0, 1.01, -0.5];
const CUBE_ARRAY_MAX: [f32; 4] = [1.0, 1.0, 1.01, 3.5];
const CUBE_MIN: [f32; 4] = [-1.0, -1.0, 1.01, 0.0];
const CUBE_MAX: [f32; 4] = [1.0, 1.0, 1.01, 1.0];

#[allow(clippy::too_many_arguments)]
const fn case(
    name: &'static str,
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
    use_offset: bool,
    offset: [i32; 3],
    use_sep_ref: bool,
    min_sep_ref: f32,
    max_sep_ref: f32,
    tex: TextureSpec,
    eval: Eval,
    flags: Flags,
) -> CaseSpec {
    CaseSpec {
        name,
        lookup: LookupSpec {
            function,
            min_coord,
            max_coord,
            use_bias,
            min_lod_bias,
            max_lod_bias,
            use_offset,
            offset,
            use_sep_ref,
            min_sep_ref,
            max_sep_ref,
        },
        tex,
        eval,
        flags,
    }
}

use Flags::{Both, Fragment, Vertex};
use Function::{Texture, TextureLod};

const TEXTURE_CASES: &[CaseSpec] = &[
    case(
        "sampler2darrayshadow",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        false,
        0.0,
        0.0,
        false,
        [0; 3],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_SHADOW,
        Eval::Array2D,
        Vertex,
    ),
    case(
        "sampler2darrayshadow",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        false,
        0.0,
        0.0,
        false,
        [0; 3],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Eval::Array2D,
        Fragment,
    ),
    case(
        "sampler2darrayshadow_bias",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        true,
        -2.0,
        2.0,
        false,
        [0; 3],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Eval::Array2DBias,
        Fragment,
    ),
    case(
        "samplercubearrayshadow",
        Texture,
        CUBE_ARRAY_MIN,
        CUBE_ARRAY_MAX,
        false,
        0.0,
        0.0,
        false,
        [0; 3],
        true,
        0.0,
        1.0,
        TEX_CUBE_ARRAY_SHADOW,
        Eval::CubeArray,
        Vertex,
    ),
    case(
        "samplercubearrayshadow",
        Texture,
        CUBE_ARRAY_MIN,
        CUBE_ARRAY_MAX,
        false,
        0.0,
        0.0,
        false,
        [0; 3],
        true,
        0.0,
        1.0,
        TEX_CUBE_ARRAY_MIPMAP_SHADOW,
        Eval::CubeArray,
        Fragment,
    ),
    case(
        "samplercubearrayshadow_bias",
        Texture,
        CUBE_ARRAY_MIN,
        CUBE_ARRAY_MAX,
        true,
        -2.0,
        2.0,
        false,
        [0; 3],
        true,
        0.0,
        1.0,
        TEX_CUBE_ARRAY_MIPMAP_SHADOW,
        Eval::CubeArrayBias,
        Fragment,
    ),
];

const TEXTURE_OFFSET_CASES: &[CaseSpec] = &[
    case(
        "sampler2darrayshadow",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        false,
        0.0,
        0.0,
        true,
        [-8, 7, 0],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_SHADOW,
        Eval::Array2DOffset,
        Vertex,
    ),
    case(
        "sampler2darrayshadow",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        false,
        0.0,
        0.0,
        true,
        [7, -8, 0],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Eval::Array2DOffset,
        Fragment,
    ),
    case(
        "sampler2darrayshadow_bias",
        Texture,
        ARRAY_MIN,
        ARRAY_MAX,
        true,
        -2.0,
        2.0,
        true,
        [7, -8, 0],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Eval::Array2DOffsetBias,
        Fragment,
    ),
];

const TEXTURE_LOD_CASES: &[CaseSpec] = &[
    case(
        "sampler2darrayshadow",
        TextureLod,
        ARRAY_MIN,
        ARRAY_MAX,
        false,
        -1.0,
        8.0,
        false,
        [0; 3],
        false,
        0.0,
        0.0,
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Eval::Array2DLod,
        Both,
    ),
    case(
        "samplercubeshadow",
        TextureLod,
        CUBE_MIN,
        CUBE_MAX,
        false,
        -1.0,
        8.0,
        false,
        [0; 3],
        false,
        0.0,
        0.0,
        TEX_CUBE_MIPMAP_SHADOW,
        Eval::CubeLod,
        Both,
    ),
    case(
        "samplercubearrayshadow",
        TextureLod,
        CUBE_ARRAY_MIN,
        CUBE_ARRAY_MAX,
        false,
        -1.0,
        8.0,
        false,
        [0; 3],
        true,
        0.0,
        1.0,
        TEX_CUBE_ARRAY_MIPMAP_SHADOW,
        Eval::CubeArrayLod,
        Fragment,
    ),
];

const TEXTURE_LOD_OFFSET_CASES: &[CaseSpec] = &[case(
    "sampler2darrayshadow",
    TextureLod,
    ARRAY_MIN,
    ARRAY_MAX,
    false,
    -1.0,
    9.0,
    true,
    [-8, 7, 0],
    false,
    0.0,
    0.0,
    TEX_2D_ARRAY_MIPMAP_SHADOW,
    Eval::Array2DLodOffset,
    Both,
)];

const CUBE_FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

fn cube_swizzle(face_ndx: usize) -> [usize; 4] {
    [
        [0, 0, 1, 1],
        [1, 1, 0, 0],
        [0, 1, 0, 1],
        [1, 0, 1, 0],
        [0, 1, 1, 0],
        [1, 0, 0, 1],
    ][face_ndx]
}

fn depth_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16)
}

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

fn compute_lod_exact(dudx: f32, dvdy: f32) -> f32 {
    dudx.abs().max(dvdy.abs()).log2()
}

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

fn lod_coord_transform(lookup: &LookupSpec) -> Mat4 {
    let has_lod_bias = lookup.function.has_lod() || lookup.use_bias;
    let (s, b) = if has_lod_bias {
        (lookup.max_lod_bias - lookup.min_lod_bias, lookup.min_lod_bias)
    } else {
        (0.0, 0.0)
    };
    let (sep_ref_s, sep_ref_b) = if lookup.use_sep_ref {
        (lookup.max_sep_ref - lookup.min_sep_ref, lookup.min_sep_ref)
    } else {
        (0.0, 0.0)
    };

    let mut m = Mat4::zero();
    m.set(0, 0, s / 2.0);
    m.set(0, 1, s / 2.0);
    m.set(0, 3, b);
    m.set(1, 0, sep_ref_s / 2.0);
    m.set(1, 1, sep_ref_s / 2.0);
    m.set(1, 3, sep_ref_b);
    m
}

fn build_texture_levels(tex: TextureSpec, is_auto_lod: bool) -> Vec<TextureLevel> {
    let format = depth_format();
    let info = get_texture_format_info(format);
    let c_scale: [f32; 4] = std::array::from_fn(|i| info.value_max[i] - info.value_min[i]);
    let c_bias = info.value_min;
    let c_corner: [f32; 4] = std::array::from_fn(|i| c_bias[i] + c_scale[i] * 0.5);
    let base_cell_size = (tex.width / 4).min(tex.height / 4);

    (0..tex.num_levels)
        .map(|level| {
            let w = (tex.width >> level).max(1);
            let h = (tex.height >> level).max(1);
            let cell_size = (base_cell_size >> level).max(1);
            let last_pix = w - 1;

            let layers = match tex.type_ {
                TextureType::CubeMap => 6,
                TextureType::CubeMapArray => tex.depth * 6,
                TextureType::Array2D => tex.depth,
            };
            let mut tex_level = TextureLevel::new(format, w, h, layers).expect("a depth16 level is always writable");
            let mut access = tex_level.get_access();

            match tex.type_ {
                TextureType::Array2D => {
                    let layer_step = 1.0 / tex.depth as f32;
                    let level_step = if is_auto_lod {
                        0.0
                    } else {
                        1.0 / ((tex.num_levels - 1).max(1) * tex.depth) as f32
                    };
                    for layer in 0..tex.depth {
                        let f_a = layer as f32 * layer_step + level as f32 * level_step;
                        let f_b = 1.0 - f_a;
                        let color_a: [f32; 4] =
                            std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_a, f_b, f_a, f_b][c]);
                        let color_b: [f32; 4] =
                            std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_b, f_a, f_b, f_a][c]);
                        fill_with_grid(&mut access, layer, cell_size, color_a, color_b);
                    }
                }
                TextureType::CubeMap => {
                    let level_step = if is_auto_lod {
                        0.0
                    } else {
                        1.0 / (tex.num_levels - 1).max(1) as f32
                    };
                    let f_a = level as f32 * level_step;
                    let f = [f_a, 1.0 - f_a];
                    for (face_ndx, face) in CUBE_FACES.into_iter().enumerate() {
                        let swz = cube_swizzle(face_ndx);
                        let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[swz[c]]);
                        let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[1 - swz[c]]);
                        let slice = crate::tcu::pixel::get_cube_array_face_index(face);
                        fill_with_grid(&mut access, slice, cell_size, color_a, color_b);
                        access.set_pixel(c_corner, 0, 0, slice);
                        access.set_pixel(c_corner, 0, last_pix, slice);
                        access.set_pixel(c_corner, last_pix, 0, slice);
                        access.set_pixel(c_corner, last_pix, last_pix, slice);
                    }
                }
                TextureType::CubeMapArray => {
                    let layer_step = 1.0 / tex.depth as f32;
                    let level_step = if is_auto_lod {
                        0.0
                    } else {
                        1.0 / ((tex.num_levels - 1).max(1) * tex.depth) as f32
                    };
                    for layer in 0..tex.depth {
                        for face_ndx in 0..6usize {
                            let f_a = layer as f32 * layer_step + level as f32 * level_step;
                            let f = [f_a, 1.0 - f_a];
                            let swz = cube_swizzle(face_ndx);
                            let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[swz[c]]);
                            let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[1 - swz[c]]);

                            let layer_face_ndx = face_ndx as u32 + layer * 6;
                            fill_with_grid(&mut access, layer_face_ndx, cell_size, color_a, color_b);

                            // Upstream passes the layer, not the layer-face index, as the slice of these corner writes.
                            access.set_pixel(c_corner, 0, 0, layer);
                            access.set_pixel(c_corner, 0, last_pix, layer);
                            access.set_pixel(c_corner, last_pix, 0, layer);
                            access.set_pixel(c_corner, last_pix, last_pix, layer);
                        }
                    }
                }
            }

            tex_level
        })
        .collect()
}

fn gl_target(type_: TextureType) -> glw::GLenum {
    match type_ {
        TextureType::CubeMap => glw::GL_TEXTURE_CUBE_MAP,
        TextureType::CubeMapArray => glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        TextureType::Array2D => glw::GL_TEXTURE_2D_ARRAY,
    }
}

fn upload_texture(gl: &glw::Functions, tex: TextureSpec, levels: &[TextureLevel]) -> GLuint {
    let target = gl_target(tex.type_);
    let min_filter = if tex.num_levels > 1 {
        glw::GL_NEAREST_MIPMAP_NEAREST
    } else {
        glw::GL_NEAREST
    };
    let bytes_per_pixel = depth_format().pixel_size().expect("depth16 is a sized format") as usize;

    let mut texture: GLuint = 0;
    // SAFETY: one object is asked for and one `GLuint` of output is given; every call below targets that same, just-bound object.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(target, texture);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, min_filter as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as GLint);
        gl.tex_parameteri(
            target,
            glw::GL_TEXTURE_COMPARE_MODE,
            glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
        );
        gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint);

        for (level_ndx, level) in levels.iter().enumerate() {
            let [w, h, d] = level.size();
            let data = level.data();
            let face_bytes = w as usize * h as usize * bytes_per_pixel;

            match tex.type_ {
                TextureType::CubeMap => {
                    for face_ndx in 0..6usize {
                        let face_data = &data[face_ndx * face_bytes..(face_ndx + 1) * face_bytes];
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face_ndx as u32,
                            level_ndx as GLint,
                            glw::GL_DEPTH_COMPONENT16 as GLint,
                            w as GLint,
                            h as GLint,
                            0,
                            glw::GL_DEPTH_COMPONENT,
                            glw::GL_UNSIGNED_SHORT,
                            face_data.as_ptr().cast(),
                        );
                    }
                }
                TextureType::CubeMapArray | TextureType::Array2D => {
                    gl.tex_image_3d(
                        target,
                        level_ndx as GLint,
                        glw::GL_DEPTH_COMPONENT16 as GLint,
                        w as GLint,
                        h as GLint,
                        d as GLint,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_UNSIGNED_SHORT,
                        data.as_ptr().cast(),
                    );
                }
            }
        }

        gl.bind_texture(target, 0);
    }

    texture
}

fn compute_base_lod(lookup: &LookupSpec, tex: TextureSpec, viewport: (f32, f32)) -> f32 {
    match tex.type_ {
        TextureType::Array2D => {
            let dudx = (lookup.max_coord[0] - lookup.min_coord[0]) * tex.width as f32 / viewport.0;
            let dvdy = (lookup.max_coord[1] - lookup.min_coord[1]) * tex.height as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
        TextureType::CubeMap | TextureType::CubeMapArray => {
            let (_, c00) = get_cube_face_coords([lookup.min_coord[0], lookup.min_coord[1], lookup.min_coord[2]]);
            let (_, c10) = get_cube_face_coords([lookup.max_coord[0], lookup.min_coord[1], lookup.min_coord[2]]);
            let (_, c01) = get_cube_face_coords([lookup.min_coord[0], lookup.max_coord[1], lookup.min_coord[2]]);
            let dudx = (c10[0] - c00[0]) * tex.width as f32 / viewport.0;
            let dvdy = (c01[1] - c00[1]) * tex.height as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
    }
}

fn sampler_type_name(type_: TextureType) -> &'static str {
    match type_ {
        TextureType::CubeMap => "samplerCubeShadow",
        TextureType::CubeMapArray => "samplerCubeArrayShadow",
        TextureType::Array2D => "sampler2DArrayShadow",
    }
}

fn build_shader_sources(
    context: &Context,
    lookup: &LookupSpec,
    tex_type: TextureType,
    is_vertex_case: bool,
) -> (String, String) {
    let has_lod_bias = lookup.function.has_lod() || lookup.use_bias;
    let has_sep_shadow_ref = lookup.use_sep_ref;
    let coord_type_name = "vec4";
    let coord_prec_name = "highp";

    let context_type = context.context_type();
    let is_gl = context_type.api.desktop;
    let shader_version = context_type.glsl_version().declaration();

    let mut cube_map_array_ext = String::new();
    if tex_type == TextureType::CubeMapArray && !context_type.supports(3, 2) && !context_type.supports_core(4, 0) {
        if is_gl {
            cube_map_array_ext = "#extension GL_ARB_texture_cube_map_array : require\n".to_string();
        } else if context
            .context_info
            .is_extension_supported("GL_EXT_texture_cube_map_array")
        {
            cube_map_array_ext = "#extension GL_EXT_texture_cube_map_array : require\n".to_string();
        } else {
            cube_map_array_ext = "#extension GL_OES_texture_cube_map_array : require\n".to_string();
        }
    }

    let mut vert = String::new();
    let mut frag = String::new();

    vert.push_str(&format!(
        "{shader_version}\n#extension GL_EXT_texture_shadow_lod : require\n\n"
    ));
    vert.push_str(&cube_map_array_ext);
    vert.push_str("in highp vec4 a_position;\n");
    vert.push_str(&format!("in {coord_prec_name} {coord_type_name} a_in0;\n"));
    if has_lod_bias || has_sep_shadow_ref {
        vert.push_str(&format!("in {coord_prec_name} vec4 a_in1;\n"));
    }

    frag.push_str(&format!(
        "{shader_version}\n#extension GL_EXT_texture_shadow_lod : require\n\n"
    ));
    frag.push_str(&cube_map_array_ext);
    frag.push_str("out mediump vec4 o_color;\n");

    if is_vertex_case {
        vert.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vert.push_str(&format!("out {coord_prec_name} {coord_type_name} v_texCoord;\n"));
        frag.push_str(&format!("in {coord_prec_name} {coord_type_name} v_texCoord;\n"));

        if has_lod_bias || has_sep_shadow_ref {
            vert.push_str(&format!("out {coord_prec_name} vec4 v_lodShadowRef;\n"));
            frag.push_str(&format!("in {coord_prec_name} vec4 v_lodShadowRef;\n"));
        }
    }

    let uniforms = format!(
        "uniform highp {} u_sampler;\nuniform highp vec4 u_scale;\nuniform highp vec4 u_bias;\n",
        sampler_type_name(tex_type)
    );
    if is_vertex_case {
        vert.push_str(&uniforms);
    } else {
        frag.push_str(&uniforms);
    }

    vert.push_str("\nvoid main()\n{\n\tgl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    let mut op = String::new();
    {
        let tex_coord = if is_vertex_case { "a_in0" } else { "v_texCoord" };
        let lod_bias = if is_vertex_case { "a_in1" } else { "v_lodShadowRef" };

        op.push_str(&format!("vec4({}", lookup.function.base_name()));
        if lookup.use_offset {
            op.push_str("Offset");
        }
        op.push_str("(u_sampler, ");
        op.push_str(tex_coord);

        if lookup.use_sep_ref {
            op.push_str(&format!(", {lod_bias}.y"));
        }
        if lookup.function.has_lod() {
            op.push_str(&format!(", {lod_bias}.x"));
        }
        if lookup.use_offset {
            op.push_str(&format!(", ivec2({}, {})", lookup.offset[0], lookup.offset[1]));
        }
        if lookup.use_bias {
            op.push_str(&format!(", {lod_bias}.x"));
        }
        op.push_str("), 0.0, 0.0, 1.0);\n");
    }

    if is_vertex_case {
        vert.push_str("\tv_color = ");
        vert.push_str(&op);
        frag.push_str("\to_color = v_color;\n");
    } else {
        frag.push_str("\to_color = ");
        frag.push_str(&op);
        vert.push_str("\tv_texCoord = a_in0;\n");
        if has_lod_bias || has_sep_shadow_ref {
            vert.push_str("\tv_lodShadowRef = a_in1;\n");
        }
    }

    vert.push_str("}\n");
    frag.push_str("}\n");

    (vert, frag)
}

struct TextureShadowLodTestCase {
    name: String,
    lookup: LookupSpec,
    tex: TextureSpec,
    eval: Eval,
    is_vertex_case: bool,
    is_auto_lod: bool,
    user_attrib_transforms: Vec<Mat4>,
    sources: OnceLock<(String, String)>,
    levels: OnceLock<Vec<TextureLevel>>,
    lod: OnceLock<f32>,
    gl_texture: OnceLock<GLuint>,
}

impl TextureShadowLodTestCase {
    fn new(name: String, case: &CaseSpec, is_vertex_case: bool) -> Self {
        let lookup = case.lookup;
        let mut user_attrib_transforms = vec![coord_transform(lookup.min_coord, lookup.max_coord)];
        if lookup.function.has_lod() || lookup.use_bias || lookup.use_sep_ref {
            user_attrib_transforms.push(lod_coord_transform(&lookup));
        }

        Self {
            name,
            lookup,
            tex: case.tex,
            eval: case.eval,
            is_vertex_case,
            is_auto_lod: lookup.function.has_auto_lod(is_vertex_case),
            user_attrib_transforms,
            sources: OnceLock::new(),
            levels: OnceLock::new(),
            lod: OnceLock::new(),
            gl_texture: OnceLock::new(),
        }
    }

    fn levels(&self) -> &[TextureLevel] {
        self.levels
            .get_or_init(|| build_texture_levels(self.tex, self.is_auto_lod))
    }

    fn level_accesses(&self) -> Vec<ConstPixelBufferAccess<'_>> {
        self.levels().iter().map(TextureLevel::get_const_access).collect()
    }
}

fn compare_less(ref_: f32, depth: f32) -> f32 {
    if ref_.clamp(0.0, 1.0) < depth.clamp(0.0, 1.0) {
        1.0
    } else {
        0.0
    }
}

impl ShaderRenderCaseSpec for TextureShadowLodTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        match self.sources.get() {
            Some((vert, frag)) => (vert, frag),
            None => ("", ""),
        }
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn khronos(&self) -> bool {
        true
    }

    fn user_attrib_transforms(&self) -> Vec<Mat4> {
        self.user_attrib_transforms.clone()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let info = &context.context_info;
        if !info.is_extension_supported("GL_EXT_texture_shadow_lod") {
            return Err(TestError::NotSupported(
                "EXT_texture_shadow_lod is not supported on the platform".to_string(),
            ));
        }

        let context_type = context.context_type();
        if context_type.api.desktop {
            if !context_type.supports_core(2, 0) {
                return Err(TestError::NotSupported(
                    "EXT_texture_shadow_lod is not supported due to minimum GL version requirements".to_string(),
                ));
            }
            if self.tex.type_ == TextureType::CubeMapArray
                && !context_type.supports_core(4, 0)
                && !info.is_extension_supported("GL_ARB_texture_cube_map_array")
            {
                return Err(TestError::NotSupported(
                    "ARB_texture_cube_map_array is required for this configuration and is not available.".to_string(),
                ));
            }
        } else {
            if !context_type.supports(3, 0) {
                return Err(TestError::NotSupported(
                    "EXT_texture_shadow_lod is not supported due to minimum ES version requirements".to_string(),
                ));
            }
            if self.tex.type_ == TextureType::CubeMapArray
                && !context_type.supports(3, 2)
                && !(context_type.supports(3, 1)
                    && (info.is_extension_supported("GL_OES_texture_cube_map_array")
                        || info.is_extension_supported("GL_EXT_texture_cube_map_array")))
            {
                return Err(TestError::NotSupported(
                    "GL_OES_texture_cube_map_array or GL_EXT_texture_cube_map_array is required for this configuration and is not available.".to_string(),
                ));
            }
        }

        self.sources
            .get_or_init(|| build_shader_sources(context, &self.lookup, self.tex.type_, self.is_vertex_case));
        Ok(())
    }

    fn setup_uniforms(&self, context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
        let gl = context.gl();

        self.lod.get_or_init(|| {
            let size = viewport_size(context);
            compute_base_lod(&self.lookup, self.tex, (size.x() as f32, size.y() as f32))
        });

        let texture = *self
            .gl_texture
            .get_or_init(|| upload_texture(gl, self.tex, self.levels()));
        let target = gl_target(self.tex.type_);
        let info = get_texture_format_info(depth_format());

        let sampler_name = std::ffi::CString::new("u_sampler").expect("no interior NUL");
        let scale_name = std::ffi::CString::new("u_scale").expect("no interior NUL");
        let bias_name = std::ffi::CString::new("u_bias").expect("no interior NUL");

        // SAFETY: NUL-terminated names and a program this case built; `texture` is this case's own object for `target`, and a location of -1 is ignored by the glUniform calls.
        unsafe {
            let sampler_loc = gl.get_uniform_location(program, sampler_name.as_ptr());
            let scale_loc = gl.get_uniform_location(program, scale_name.as_ptr());
            let bias_loc = gl.get_uniform_location(program, bias_name.as_ptr());

            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(target, texture);
            gl.uniform_1i(sampler_loc, 0);
            gl.uniform_4fv(scale_loc, 1, info.look_up_scale.as_ptr());
            gl.uniform_4fv(bias_loc, 1, info.look_up_bias.as_ptr());
        }
        Ok(())
    }

    fn cleanup(&self, context: &Context) {
        if let Some(&texture) = self.gl_texture.get() {
            // SAFETY: `texture` is this case's own, deleted at most once.
            unsafe { context.gl().delete_textures(1, &texture) };
        }
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        let in0 = ctx.in_[0];
        let in1 = ctx.in_[1];
        let base_lod = self.lod.get().copied().unwrap_or(0.0);
        let levels = self.level_accesses();
        let sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };
        let offset = [self.lookup.offset[0], self.lookup.offset[1]];

        let result = match self.eval {
            Eval::Array2D | Eval::Array2DBias | Eval::Array2DLod => {
                let lod = match self.eval {
                    Eval::Array2D => base_lod,
                    Eval::Array2DBias => base_lod + in1.x(),
                    _ => in1.x(),
                };
                let depth = sample_2d_array_mipmap(&levels, &sampler, in0.x(), in0.y(), in0.z(), lod)[0];
                compare_less(in0.w(), depth)
            }
            Eval::Array2DOffset | Eval::Array2DOffsetBias | Eval::Array2DLodOffset => {
                let lod = match self.eval {
                    Eval::Array2DOffset => base_lod,
                    Eval::Array2DOffsetBias => base_lod + in1.x(),
                    _ => in1.x(),
                };
                let depth = sample_2d_array_mipmap_offset(&levels, &sampler, in0.x(), in0.y(), in0.z(), lod, offset)[0];
                compare_less(in0.w(), depth)
            }
            Eval::CubeLod => {
                let depth = sample_cube_mipmap(&levels, &sampler, in0.x(), in0.y(), in0.z(), in1.x())[0];
                compare_less(in0.w(), depth)
            }
            Eval::CubeArray | Eval::CubeArrayBias | Eval::CubeArrayLod => {
                let lod = match self.eval {
                    Eval::CubeArray => base_lod,
                    Eval::CubeArrayBias => base_lod + in1.x(),
                    _ => in1.x(),
                };
                let depth = sample_cube_array_mipmap(&levels, &sampler, in0.x(), in0.y(), in0.z(), in0.w(), lod)[0];
                compare_less(in1.y(), depth)
            }
        };

        ctx.color = Vec4::new(result, 0.0, 0.0, 1.0);
    }
}

fn create_case_group(parent: &mut TestCaseGroup, group_name: &str, cases: &[CaseSpec]) {
    let mut group = TestCaseGroup::new(group_name);
    for case in cases {
        if matches!(case.flags, Vertex | Both) {
            let inner = TextureShadowLodTestCase::new(format!("{}_vertex", case.name), case, true);
            group.add_child(Box::new(ShaderRenderCase::new(inner)) as Box<dyn TestCase>);
        }
        if matches!(case.flags, Fragment | Both) {
            let inner = TextureShadowLodTestCase::new(format!("{}_fragment", case.name), case, false);
            group.add_child(Box::new(ShaderRenderCase::new(inner)) as Box<dyn TestCase>);
        }
    }
    parent.add_child(group);
}

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ext_texture_shadow_lod");
    create_case_group(&mut group, "texture", TEXTURE_CASES);
    create_case_group(&mut group, "textureoffset", TEXTURE_OFFSET_CASES);
    create_case_group(&mut group, "texturelod", TEXTURE_LOD_CASES);
    create_case_group(&mut group, "texturelodoffset", TEXTURE_LOD_OFFSET_CASES);
    group
}
