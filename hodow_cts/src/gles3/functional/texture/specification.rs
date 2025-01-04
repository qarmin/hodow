// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureSpecificationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The 2D and cube cases of the ES 3.0 file are the
// ES 2.0 port's (`gles2::functional::texture::specification`) with sized internal formats and the
// ES 3.0 verification (`es3: true`: `GL_TEXTURE_MAX_LEVEL`, no small-level skip in 2D, cropped
// float comparison for cube maps); the shaders are the ES 1.00 ones, which an ES 3.0 context
// accepts and which sample the same way for these float-sampled formats.
//
// Ported: `basic_teximage2d`, `random_teximage2d`, `teximage2d_align`, `teximage2d_unpack_params`,
// `teximage2d_depth`, `basic_texsubimage2d`, `texsubimage2d_empty_tex`, `texsubimage2d_align`,
// `texsubimage2d_unpack_params` and `texsubimage2d_depth`, all on every colour format upstream lists (float and integer ones
// render through `spec_shaders`, whose samplers follow the format's channel class).
//
// The 3D / 2D array cases that need only `glTexImage3D` (`basic_teximage3d`, `teximage3d_unpack_params`,
// `teximage3d_depth`) are ported too.
//
// `glTexSubImage3D` (`basic_texsubimage3d`, `texsubimage3d_unpack_params`, `texsubimage3d_depth`) and `glTexStorage2D/3D`
// (`texstorage2d.{format,size}`, `texstorage3d.{format,size}`) are ported as well.
//
// `texstorage2d.base_level` lives in `storage_base_level.rs`.
//
// `basic_copyteximage2d` / `basic_copytexsubimage2d` are ported (sglr gained `copy_tex_image_2d` / `copy_tex_sub_image_2d`).
//
// The PBO groups (`teximage2d_pbo`, `texsubimage2d_pbo`, `teximage3d_pbo`, `texsubimage3d_pbo`, the two `*_depth_pbo`) go through
// the sglr `*_pbo` entry points; `pbo_bounds_2d` leaves upstream's own read-back comparison to the shared GL-vs-reference one.

use crate::gles2::functional::texture::specification::{
    Spec, TextureType, make_es3_case, make_es3_sized_case, make_es3_sized_case_3d,
};
use crate::glu::{TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::Random;

/// (name, internal format) of the sized formats the ported groups use, with their transfer format.
struct SizedFormat {
    internal_format: u32,
    format: u32,
    data_type: u32,
}

const R8: SizedFormat = SizedFormat {
    internal_format: glw::GL_R8,
    format: glw::GL_RED,
    data_type: glw::GL_UNSIGNED_BYTE,
};
const RGBA4: SizedFormat = SizedFormat {
    internal_format: glw::GL_RGBA4,
    format: glw::GL_RGBA,
    data_type: glw::GL_UNSIGNED_SHORT_4_4_4_4,
};
const RGB8: SizedFormat = SizedFormat {
    internal_format: glw::GL_RGB8,
    format: glw::GL_RGB,
    data_type: glw::GL_UNSIGNED_BYTE,
};
const RGBA8: SizedFormat = SizedFormat {
    internal_format: glw::GL_RGBA8,
    format: glw::GL_RGBA,
    data_type: glw::GL_UNSIGNED_BYTE,
};

/// `depthStencilFormats`
const DEPTH_STENCIL_FORMATS: [(&str, u32); 5] = [
    ("depth_component32f", glw::GL_DEPTH_COMPONENT32F),
    ("depth_component24", glw::GL_DEPTH_COMPONENT24),
    ("depth_component16", glw::GL_DEPTH_COMPONENT16),
    ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8),
    ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
];

/// `colorFormats`
const COLOR_FORMATS: [(&str, u32); 49] = [
    ("rgba32f", glw::GL_RGBA32F),
    ("rgba32i", glw::GL_RGBA32I),
    ("rgba32ui", glw::GL_RGBA32UI),
    ("rgba16f", glw::GL_RGBA16F),
    ("rgba16i", glw::GL_RGBA16I),
    ("rgba16ui", glw::GL_RGBA16UI),
    ("rgba8", glw::GL_RGBA8),
    ("rgba8i", glw::GL_RGBA8I),
    ("rgba8ui", glw::GL_RGBA8UI),
    ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8),
    ("rgb10_a2", glw::GL_RGB10_A2),
    ("rgb10_a2ui", glw::GL_RGB10_A2UI),
    ("rgba4", glw::GL_RGBA4),
    ("rgb5_a1", glw::GL_RGB5_A1),
    ("rgba8_snorm", glw::GL_RGBA8_SNORM),
    ("rgb8", glw::GL_RGB8),
    ("rgb565", glw::GL_RGB565),
    ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F),
    ("rgb32f", glw::GL_RGB32F),
    ("rgb32i", glw::GL_RGB32I),
    ("rgb32ui", glw::GL_RGB32UI),
    ("rgb16f", glw::GL_RGB16F),
    ("rgb16i", glw::GL_RGB16I),
    ("rgb16ui", glw::GL_RGB16UI),
    ("rgb8_snorm", glw::GL_RGB8_SNORM),
    ("rgb8i", glw::GL_RGB8I),
    ("rgb8ui", glw::GL_RGB8UI),
    ("srgb8", glw::GL_SRGB8),
    ("rgb9_e5", glw::GL_RGB9_E5),
    ("rg32f", glw::GL_RG32F),
    ("rg32i", glw::GL_RG32I),
    ("rg32ui", glw::GL_RG32UI),
    ("rg16f", glw::GL_RG16F),
    ("rg16i", glw::GL_RG16I),
    ("rg16ui", glw::GL_RG16UI),
    ("rg8", glw::GL_RG8),
    ("rg8i", glw::GL_RG8I),
    ("rg8ui", glw::GL_RG8UI),
    ("rg8_snorm", glw::GL_RG8_SNORM),
    ("r32f", glw::GL_R32F),
    ("r32i", glw::GL_R32I),
    ("r32ui", glw::GL_R32UI),
    ("r16f", glw::GL_R16F),
    ("r16i", glw::GL_R16I),
    ("r16ui", glw::GL_R16UI),
    ("r8", glw::GL_R8),
    ("r8i", glw::GL_R8I),
    ("r8ui", glw::GL_R8UI),
    ("r8_snorm", glw::GL_R8_SNORM),
];

/// `maxLevelCount(width, height)`: floor(log2(max)) + 1, as the ES 3.0 test file's own helper.
fn max_level_count_2d(width: i32, height: i32) -> i32 {
    31 - (width.max(height) as u32).leading_zeros() as i32 + 1
}

/// `TextureSpecificationTests::init`
pub fn create_tests() -> TestCaseGroup {
    // (name, format, data type) of `unsizedFormats`: internal format is the format itself.
    const UNSIZED_FORMATS: [(&str, u32, u32); 8] = [
        ("alpha_unsigned_byte", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("luminance_unsigned_byte", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        (
            "luminance_alpha_unsigned_byte",
            glw::GL_LUMINANCE_ALPHA,
            glw::GL_UNSIGNED_BYTE,
        ),
        ("rgb_unsigned_short_5_6_5", glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
        ("rgb_unsigned_byte", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        (
            "rgba_unsigned_short_4_4_4_4",
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
        ),
        (
            "rgba_unsigned_short_5_5_5_1",
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
        ),
        ("rgba_unsigned_byte", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    ];

    let sized = |name: String,
                 tex_type: TextureType,
                 f: &SizedFormat,
                 mipmaps: bool,
                 width: i32,
                 height: i32,
                 spec: Spec|
     -> Box<dyn TestCase> {
        make_es3_case(
            name,
            tex_type,
            f.internal_format,
            f.format,
            f.data_type,
            mipmaps,
            width,
            height,
            spec,
        )
    };

    let mut group = TestCaseGroup::new("specification");

    // Basic TexImage2D usage.
    {
        let mut basic_tex_image_group = TestCaseGroup::new("basic_teximage2d");
        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            basic_tex_image_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                internal_format,
                true,
                64,
                128,
                Spec::BasicTexImage,
            ));
            basic_tex_image_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                internal_format,
                true,
                64,
                64,
                Spec::BasicTexImage,
            ));
        }
        group.add_child(basic_tex_image_group);
    }

    // Randomized TexImage2D order.
    {
        let mut random_tex_image_group = TestCaseGroup::new("random_teximage2d");
        let mut rnd = Random::new(9);

        // 2D cases.
        for ndx in 0..10 {
            let format_ndx = rnd.get_int(0, COLOR_FORMATS.len() as i32 - 1) as usize;
            let width = 1 << rnd.get_int(2, 8);
            let height = 1 << rnd.get_int(2, 8);
            random_tex_image_group.add_child(make_es3_sized_case(
                format!("2d_{ndx}"),
                TextureType::Tex2D,
                COLOR_FORMATS[format_ndx].1,
                true,
                width,
                height,
                Spec::RandomOrderTexImage,
            ));
        }

        // Cubemap cases.
        for ndx in 0..10 {
            let format_ndx = rnd.get_int(0, COLOR_FORMATS.len() as i32 - 1) as usize;
            let size = 1 << rnd.get_int(2, 8);
            random_tex_image_group.add_child(make_es3_sized_case(
                format!("cube_{ndx}"),
                TextureType::Cube,
                COLOR_FORMATS[format_ndx].1,
                true,
                size,
                size,
                Spec::RandomOrderTexImage,
            ));
        }
        group.add_child(random_tex_image_group);
    }

    // TexImage2D unpack alignment.
    {
        let mut align_group = TestCaseGroup::new("teximage2d_align");

        align_group.add_child(sized(
            "2d_r8_4_8".to_string(),
            TextureType::Tex2D,
            &R8,
            true,
            4,
            8,
            Spec::TexImageAlign { alignment: 8 },
        ));
        for (name, f, width, height) in [
            ("r8_63", &R8, 63, 30),
            ("rgba4_51", &RGBA4, 51, 30),
            ("rgb8_39", &RGB8, 39, 43),
            ("rgba8_47", &RGBA8, 47, 27),
        ] {
            for alignment in [1, 2, 4, 8] {
                align_group.add_child(sized(
                    format!("2d_{name}_{alignment}"),
                    TextureType::Tex2D,
                    f,
                    false,
                    width,
                    height,
                    Spec::TexImageAlign { alignment },
                ));
            }
        }

        align_group.add_child(sized(
            "cube_r8_4_8".to_string(),
            TextureType::Cube,
            &R8,
            true,
            4,
            4,
            Spec::TexImageAlign { alignment: 8 },
        ));
        for (name, f, size) in [
            ("r8_63", &R8, 63),
            ("rgba4_51", &RGBA4, 51),
            ("rgb8_39", &RGB8, 39),
            ("rgba8_47", &RGBA8, 47),
        ] {
            for alignment in [1, 2, 4, 8] {
                align_group.add_child(sized(
                    format!("cube_{name}_{alignment}"),
                    TextureType::Cube,
                    f,
                    false,
                    size,
                    size,
                    Spec::TexImageAlign { alignment },
                ));
            }
        }
        group.add_child(align_group);
    }

    // glTexImage2D() unpack parameter cases.
    {
        let mut param_group = TestCaseGroup::new("teximage2d_unpack_params");

        // (name, format, width, height, rowLength, skipRows, skipPixels, alignment); `rgba32f_complex` follows below.
        #[allow(clippy::type_complexity)]
        let cases: [(&str, &SizedFormat, i32, i32, i32, i32, i32, i32); 12] = [
            ("rgb8_alignment", &RGB8, 31, 30, 0, 0, 0, 2),
            ("rgb8_row_length", &RGB8, 31, 30, 50, 0, 0, 4),
            ("rgb8_skip_rows", &RGB8, 31, 30, 0, 3, 0, 4),
            ("rgb8_skip_pixels", &RGB8, 31, 30, 36, 0, 5, 4),
            ("r8_complex1", &R8, 31, 30, 64, 1, 3, 1),
            ("r8_complex2", &R8, 31, 30, 64, 1, 3, 2),
            ("r8_complex3", &R8, 31, 30, 64, 1, 3, 4),
            ("r8_complex4", &R8, 31, 30, 64, 1, 3, 8),
            ("rgba8_complex1", &RGBA8, 56, 61, 69, 0, 0, 8),
            ("rgba8_complex2", &RGBA8, 56, 61, 69, 0, 7, 8),
            ("rgba8_complex3", &RGBA8, 56, 61, 69, 3, 0, 8),
            ("rgba8_complex4", &RGBA8, 56, 61, 69, 3, 7, 8),
        ];

        for &(name, f, width, height, row_length, skip_rows, skip_pixels, alignment) in &cases {
            param_group.add_child(sized(
                name.to_string(),
                TextureType::Tex2D,
                f,
                false,
                width,
                height,
                Spec::TexImageParams {
                    row_length,
                    skip_rows,
                    skip_pixels,
                    alignment,
                },
            ));
        }
        param_group.add_child(make_es3_sized_case(
            "rgba32f_complex".to_string(),
            TextureType::Tex2D,
            glw::GL_RGBA32F,
            false,
            19,
            10,
            Spec::TexImageParams {
                row_length: 27,
                skip_rows: 1,
                skip_pixels: 7,
                alignment: 8,
            },
        ));
        group.add_child(param_group);
    }

    // glTexImage2D() depth cases.
    {
        let mut shadow_2d_group = TestCaseGroup::new("teximage2d_depth");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_2d_group.add_child(make_es3_sized_case(
                name.to_string(),
                TextureType::Tex2D,
                internal_format,
                true,
                64,
                128,
                Spec::Depth,
            ));
        }
        group.add_child(shadow_2d_group);
    }

    // Basic TexSubImage2D usage.
    {
        let mut basic_tex_sub_image_group = TestCaseGroup::new("basic_texsubimage2d");
        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            basic_tex_sub_image_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                internal_format,
                true,
                64,
                128,
                Spec::BasicTexSubImage,
            ));
            basic_tex_sub_image_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                internal_format,
                true,
                64,
                64,
                Spec::BasicTexSubImage,
            ));
        }
        group.add_child(basic_tex_sub_image_group);
    }

    // TexSubImage2D to empty texture.
    {
        let mut tex_sub_image_empty_tex_group = TestCaseGroup::new("texsubimage2d_empty_tex");
        for &(fmt_name, format, data_type) in &UNSIZED_FORMATS {
            tex_sub_image_empty_tex_group.add_child(make_es3_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                format,
                format,
                data_type,
                true,
                64,
                32,
                Spec::TexSubImageEmptyTex,
            ));
            tex_sub_image_empty_tex_group.add_child(make_es3_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                format,
                format,
                data_type,
                true,
                32,
                32,
                Spec::TexSubImageEmptyTex,
            ));
        }
        group.add_child(tex_sub_image_empty_tex_group);
    }

    // TexSubImage2D alignment cases.
    {
        let mut align_group = TestCaseGroup::new("texsubimage2d_align");

        // (name stem, format, subX, subY, subW, subH)
        let align_cases: [(&str, &SizedFormat, i32, i32, i32, i32); 5] = [
            ("r8_1", &R8, 13, 17, 1, 6),
            ("r8_63", &R8, 1, 9, 63, 30),
            ("rgba4_51", &RGBA4, 7, 29, 51, 30),
            ("rgb8_39", &RGB8, 11, 8, 39, 43),
            ("rgba8_47", &RGBA8, 10, 1, 47, 27),
        ];

        for (prefix, tex_type) in [("2d", TextureType::Tex2D), ("cube", TextureType::Cube)] {
            for &(stem, f, sub_x, sub_y, sub_w, sub_h) in &align_cases {
                for alignment in [1, 2, 4, 8] {
                    align_group.add_child(sized(
                        format!("{prefix}_{stem}_{alignment}"),
                        tex_type,
                        f,
                        false,
                        64,
                        64,
                        Spec::TexSubImageAlign {
                            sub_x,
                            sub_y,
                            sub_w,
                            sub_h,
                            alignment,
                        },
                    ));
                }
            }
        }
        group.add_child(align_group);
    }

    // glTexSubImage2D() pixel transfer mode cases.
    {
        let mut param_group = TestCaseGroup::new("texsubimage2d_unpack_params");

        // (name, internal format, width, height, subX, subY, subW, subH, rowLength, skipRows, skipPixels, alignment)
        #[allow(clippy::type_complexity)]
        const CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 13] = [
            ("rgb8_alignment", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 0, 0, 0, 2),
            ("rgb8_row_length", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 50, 0, 0, 4),
            ("rgb8_skip_rows", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 0, 3, 0, 4),
            ("rgb8_skip_pixels", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 36, 0, 5, 4),
            ("r8_complex1", glw::GL_R8, 54, 60, 11, 7, 31, 30, 64, 1, 3, 1),
            ("r8_complex2", glw::GL_R8, 54, 60, 11, 7, 31, 30, 64, 1, 3, 2),
            ("r8_complex3", glw::GL_R8, 54, 60, 11, 7, 31, 30, 64, 1, 3, 4),
            ("r8_complex4", glw::GL_R8, 54, 60, 11, 7, 31, 30, 64, 1, 3, 8),
            ("rgba8_complex1", glw::GL_RGBA8, 92, 84, 13, 19, 56, 61, 69, 0, 0, 8),
            ("rgba8_complex2", glw::GL_RGBA8, 92, 84, 13, 19, 56, 61, 69, 0, 7, 8),
            ("rgba8_complex3", glw::GL_RGBA8, 92, 84, 13, 19, 56, 61, 69, 3, 0, 8),
            ("rgba8_complex4", glw::GL_RGBA8, 92, 84, 13, 19, 56, 61, 69, 3, 7, 8),
            ("rgba32f_complex", glw::GL_RGBA32F, 92, 84, 13, 19, 56, 61, 69, 3, 7, 8),
        ];

        for &(
            name,
            internal_format,
            width,
            height,
            sub_x,
            sub_y,
            sub_w,
            sub_h,
            row_length,
            skip_rows,
            skip_pixels,
            alignment,
        ) in &CASES
        {
            param_group.add_child(make_es3_sized_case(
                name.to_string(),
                TextureType::Tex2D,
                internal_format,
                false,
                width,
                height,
                Spec::TexSubImageParams {
                    sub_x,
                    sub_y,
                    sub_w,
                    sub_h,
                    row_length,
                    skip_rows,
                    skip_pixels,
                    alignment,
                },
            ));
        }
        group.add_child(param_group);
    }

    // glTexSubImage2D() depth cases.
    {
        let mut shadow_2d_group = TestCaseGroup::new("texsubimage2d_depth");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_2d_group.add_child(make_es3_sized_case(
                name.to_string(),
                TextureType::Tex2D,
                internal_format,
                true,
                64,
                32,
                Spec::SubDepth,
            ));
        }
        group.add_child(shadow_2d_group);
    }

    // Basic TexImage3D usage.
    {
        let mut basic_tex_image_group = TestCaseGroup::new("basic_teximage3d");
        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            // The array's "levels" constant is passed as its layer count upstream.
            basic_tex_image_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_2d_array"),
                TextureType::Array,
                internal_format,
                true,
                57,
                44,
                5,
                Spec::BasicTexImage3d,
            ));
            basic_tex_image_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_3d"),
                TextureType::ThreeD,
                internal_format,
                true,
                63,
                29,
                11,
                Spec::BasicTexImage3d,
            ));
        }
        group.add_child(basic_tex_image_group);
    }

    // glTexImage3D() unpack params cases.
    {
        let mut param_group = TestCaseGroup::new("teximage3d_unpack_params");

        // (name, internal format, width, height, depth, imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment)
        #[allow(clippy::type_complexity)]
        const CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 14] = [
            ("rgb8_image_height", glw::GL_RGB8, 23, 19, 8, 26, 0, 0, 0, 0, 4),
            ("rgb8_row_length", glw::GL_RGB8, 23, 19, 8, 0, 27, 0, 0, 0, 4),
            ("rgb8_skip_images", glw::GL_RGB8, 23, 19, 8, 0, 0, 3, 0, 0, 4),
            ("rgb8_skip_rows", glw::GL_RGB8, 23, 19, 8, 22, 0, 0, 3, 0, 4),
            ("rgb8_skip_pixels", glw::GL_RGB8, 23, 19, 8, 0, 25, 0, 0, 2, 4),
            ("r8_complex1", glw::GL_R8, 13, 17, 11, 23, 15, 2, 3, 1, 1),
            ("r8_complex2", glw::GL_R8, 13, 17, 11, 23, 15, 2, 3, 1, 2),
            ("r8_complex3", glw::GL_R8, 13, 17, 11, 23, 15, 2, 3, 1, 4),
            ("r8_complex4", glw::GL_R8, 13, 17, 11, 23, 15, 2, 3, 1, 8),
            ("rgba8_complex1", glw::GL_RGBA8, 11, 20, 8, 25, 14, 0, 0, 0, 8),
            ("rgba8_complex2", glw::GL_RGBA8, 11, 20, 8, 25, 14, 0, 2, 0, 8),
            ("rgba8_complex3", glw::GL_RGBA8, 11, 20, 8, 25, 14, 0, 0, 3, 8),
            ("rgba8_complex4", glw::GL_RGBA8, 11, 20, 8, 25, 14, 0, 2, 3, 8),
            ("rgba32f_complex", glw::GL_RGBA32F, 11, 20, 8, 25, 14, 0, 2, 3, 8),
        ];

        for &(
            name,
            internal_format,
            width,
            height,
            depth,
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
        ) in &CASES
        {
            param_group.add_child(make_es3_sized_case_3d(
                name.to_string(),
                TextureType::ThreeD,
                internal_format,
                false,
                width,
                height,
                depth,
                Spec::TexImage3dParams {
                    image_height,
                    row_length,
                    skip_images,
                    skip_rows,
                    skip_pixels,
                    alignment,
                },
            ));
        }
        group.add_child(param_group);
    }

    // glTexImage3D() depth cases.
    {
        let mut shadow_3d_group = TestCaseGroup::new("teximage3d_depth");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_3d_group.add_child(make_es3_sized_case_3d(
                format!("{name}_2d_array"),
                TextureType::Array,
                internal_format,
                true,
                32,
                64,
                8,
                Spec::ArrayDepth,
            ));
        }
        group.add_child(shadow_3d_group);
    }

    // Basic glCopyTexImage2D() and glCopyTexSubImage2D() cases (unsized formats, GL_UNSIGNED_BYTE).
    {
        const COPY_FORMATS: [(&str, u32); 5] = [
            ("alpha", glw::GL_ALPHA),
            ("luminance", glw::GL_LUMINANCE),
            ("luminance_alpha", glw::GL_LUMINANCE_ALPHA),
            ("rgb", glw::GL_RGB),
            ("rgba", glw::GL_RGBA),
        ];

        for (group_name, spec) in [
            ("basic_copyteximage2d", Spec::CopyTexImage),
            ("basic_copytexsubimage2d", Spec::CopyTexSubImage),
        ] {
            let mut copy_group = TestCaseGroup::new(group_name);
            for &(fmt_name, format) in &COPY_FORMATS {
                copy_group.add_child(make_es3_case(
                    format!("2d_{fmt_name}"),
                    TextureType::Tex2D,
                    format,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    true,
                    128,
                    64,
                    spec,
                ));
            }
            for &(fmt_name, format) in &COPY_FORMATS {
                copy_group.add_child(make_es3_case(
                    format!("cube_{fmt_name}"),
                    TextureType::Cube,
                    format,
                    format,
                    glw::GL_UNSIGNED_BYTE,
                    true,
                    64,
                    64,
                    spec,
                ));
            }
            group.add_child(copy_group);
        }
    }

    // Basic TexSubImage3D usage.
    {
        let mut basic_tex_sub_image_group = TestCaseGroup::new("basic_texsubimage3d");
        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            basic_tex_sub_image_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_3d"),
                TextureType::ThreeD,
                internal_format,
                true,
                32,
                64,
                8,
                Spec::BasicTexSubImage3d,
            ));
        }
        group.add_child(basic_tex_sub_image_group);
    }

    // glTexSubImage3D() unpack params cases.
    {
        let mut param_group = TestCaseGroup::new("texsubimage3d_unpack_params");

        // (name, internal format, width, height, depth, subX, subY, subZ, subW, subH, subD,
        //  imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment)
        #[rustfmt::skip]
        #[allow(clippy::type_complexity)]
        const CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 14] = [
            ("rgb8_image_height", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 26, 0, 0, 0, 0, 4),
            ("rgb8_row_length", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 27, 0, 0, 0, 4),
            ("rgb8_skip_images", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 0, 3, 0, 0, 4),
            ("rgb8_skip_rows", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 22, 0, 0, 3, 0, 4),
            ("rgb8_skip_pixels", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 25, 0, 0, 2, 4),
            ("r8_complex1", glw::GL_R8, 15, 20, 11, 1, 1, 0, 13, 17, 11, 23, 15, 2, 3, 1, 1),
            ("r8_complex2", glw::GL_R8, 15, 20, 11, 1, 1, 0, 13, 17, 11, 23, 15, 2, 3, 1, 2),
            ("r8_complex3", glw::GL_R8, 15, 20, 11, 1, 1, 0, 13, 17, 11, 23, 15, 2, 3, 1, 4),
            ("r8_complex4", glw::GL_R8, 15, 20, 11, 1, 1, 0, 13, 17, 11, 23, 15, 2, 3, 1, 8),
            ("rgba8_complex1", glw::GL_RGBA8, 15, 25, 10, 0, 5, 1, 11, 20, 8, 25, 14, 0, 0, 0, 8),
            ("rgba8_complex2", glw::GL_RGBA8, 15, 25, 10, 0, 5, 1, 11, 20, 8, 25, 14, 0, 2, 0, 8),
            ("rgba8_complex3", glw::GL_RGBA8, 15, 25, 10, 0, 5, 1, 11, 20, 8, 25, 14, 0, 0, 3, 8),
            ("rgba8_complex4", glw::GL_RGBA8, 15, 25, 10, 0, 5, 1, 11, 20, 8, 25, 14, 0, 2, 3, 8),
            ("rgba32f_complex", glw::GL_RGBA32F, 15, 25, 10, 0, 5, 1, 11, 20, 8, 25, 14, 0, 2, 3, 8),
        ];

        for &(
            name,
            internal_format,
            width,
            height,
            depth,
            sub_x,
            sub_y,
            sub_z,
            sub_w,
            sub_h,
            sub_d,
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
        ) in &CASES
        {
            param_group.add_child(make_es3_sized_case_3d(
                name.to_string(),
                TextureType::ThreeD,
                internal_format,
                false,
                width,
                height,
                depth,
                Spec::TexSubImage3dParams {
                    sub_x,
                    sub_y,
                    sub_z,
                    sub_w,
                    sub_h,
                    sub_d,
                    image_height,
                    row_length,
                    skip_images,
                    skip_rows,
                    skip_pixels,
                    alignment,
                },
            ));
        }
        group.add_child(param_group);
    }

    // glTexSubImage3D() depth cases.
    {
        let mut shadow_3d_group = TestCaseGroup::new("texsubimage3d_depth");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_3d_group.add_child(make_es3_sized_case_3d(
                format!("{name}_2d_array"),
                TextureType::Array,
                internal_format,
                true,
                57,
                44,
                5,
                Spec::SubArrayDepth,
            ));
        }
        group.add_child(shadow_3d_group);
    }

    // glTexStorage2D() cases.
    {
        let mut tex_storage_group = TestCaseGroup::new("texstorage2d");
        let mut format_group = TestCaseGroup::new("format");

        let all_formats = COLOR_FORMATS.iter().chain(DEPTH_STENCIL_FORMATS.iter());
        for &(fmt_name, internal_format) in all_formats {
            let (tex_2d_width, tex_2d_height, cube_size) = (117, 97, 57);
            let tex_2d_levels = max_level_count_2d(tex_2d_width, tex_2d_height);
            let cube_levels = max_level_count_2d(cube_size, cube_size);
            format_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                internal_format,
                true,
                tex_2d_width,
                tex_2d_height,
                Spec::TexStorage { levels: tex_2d_levels },
            ));
            format_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                internal_format,
                true,
                cube_size,
                cube_size,
                Spec::TexStorage { levels: cube_levels },
            ));
        }
        tex_storage_group.add_child(format_group);

        // (width, height, levels)
        const TEX_2D_SIZES: [(i32, i32, i32); 7] = [
            (1, 1, 1),
            (2, 2, 2),
            (64, 32, 7),
            (32, 64, 4),
            (57, 63, 1),
            (57, 63, 2),
            (57, 63, 6),
        ];
        // (size, levels)
        const CUBE_SIZES: [(i32, i32); 7] = [(1, 1), (2, 2), (57, 1), (57, 2), (57, 6), (64, 4), (64, 7)];

        let mut size_group = TestCaseGroup::new("size");
        for &(width, height, levels) in &TEX_2D_SIZES {
            size_group.add_child(make_es3_sized_case(
                format!("2d_{width}x{height}_{levels}_levels"),
                TextureType::Tex2D,
                glw::GL_RGBA8,
                true,
                width,
                height,
                Spec::TexStorage { levels },
            ));
        }
        for &(size, levels) in &CUBE_SIZES {
            size_group.add_child(make_es3_sized_case(
                format!("cube_{size}x{size}_{levels}_levels"),
                TextureType::Cube,
                glw::GL_RGBA8,
                true,
                size,
                size,
                Spec::TexStorage { levels },
            ));
        }
        tex_storage_group.add_child(size_group);
        tex_storage_group.add_child(super::storage_base_level::create_base_level_tests());
        group.add_child(tex_storage_group);
    }

    // glTexStorage3D() cases.
    {
        let mut tex_storage_group = TestCaseGroup::new("texstorage3d");
        let mut format_group = TestCaseGroup::new("format");

        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            let (array_w, array_h, array_layers) = (57, 13, 7);
            let array_levels = max_level_count_2d(array_w, array_h);
            let (w_3d, h_3d, d_3d) = (59, 37, 11);
            let levels_3d = max_level_count_2d(w_3d, h_3d).max(max_level_count_2d(1, d_3d));
            format_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_2d_array"),
                TextureType::Array,
                internal_format,
                true,
                array_w,
                array_h,
                array_layers,
                Spec::TexStorage { levels: array_levels },
            ));
            format_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_3d"),
                TextureType::ThreeD,
                internal_format,
                true,
                w_3d,
                h_3d,
                d_3d,
                Spec::TexStorage { levels: levels_3d },
            ));
        }

        // Depth/stencil formats (only 2D texture array is supported).
        for &(fmt_name, internal_format) in &DEPTH_STENCIL_FORMATS {
            let (array_w, array_h, array_layers) = (57, 13, 7);
            let array_levels = max_level_count_2d(array_w, array_h);
            format_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_2d_array"),
                TextureType::Array,
                internal_format,
                true,
                array_w,
                array_h,
                array_layers,
                Spec::TexStorage { levels: array_levels },
            ));
        }
        tex_storage_group.add_child(format_group);

        // (width, height, layers, levels)
        const TEX_2D_ARRAY_SIZES: [(i32, i32, i32, i32); 7] = [
            (1, 1, 1, 1),
            (2, 2, 2, 2),
            (64, 32, 3, 7),
            (32, 64, 3, 4),
            (57, 63, 5, 1),
            (57, 63, 5, 2),
            (57, 63, 5, 6),
        ];
        // (width, height, depth, levels)
        const TEX_3D_SIZES: [(i32, i32, i32, i32); 8] = [
            (1, 1, 1, 1),
            (2, 2, 2, 2),
            (64, 32, 16, 7),
            (32, 64, 16, 4),
            (32, 16, 64, 4),
            (57, 63, 11, 1),
            (57, 63, 11, 2),
            (57, 63, 11, 6),
        ];

        let mut size_group = TestCaseGroup::new("size");
        for &(width, height, layers, levels) in &TEX_2D_ARRAY_SIZES {
            size_group.add_child(make_es3_sized_case_3d(
                format!("2d_array_{width}x{height}x{layers}_{levels}_levels"),
                TextureType::Array,
                glw::GL_RGBA8,
                true,
                width,
                height,
                layers,
                Spec::TexStorage { levels },
            ));
        }
        for &(width, height, depth, levels) in &TEX_3D_SIZES {
            size_group.add_child(make_es3_sized_case_3d(
                format!("3d_{width}x{height}x{depth}_{levels}_levels"),
                TextureType::ThreeD,
                glw::GL_RGBA8,
                true,
                width,
                height,
                depth,
                Spec::TexStorage { levels },
            ));
        }
        tex_storage_group.add_child(size_group);
        group.add_child(tex_storage_group);
    }

    // glTexImage2D() PBO cases.
    {
        let mut pbo_group = TestCaseGroup::new("teximage2d_pbo");

        // (name, internal format, width, height, rowLength, skipRows, skipPixels, alignment, offset)
        #[allow(clippy::type_complexity)]
        const PARAMETER_CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32); 5] = [
            ("rgb8_offset", glw::GL_RGB8, 31, 30, 0, 0, 0, 4, 67),
            ("rgb8_alignment", glw::GL_RGB8, 31, 30, 0, 0, 0, 2, 0),
            ("rgb8_row_length", glw::GL_RGB8, 31, 30, 50, 0, 0, 4, 0),
            ("rgb8_skip_rows", glw::GL_RGB8, 31, 30, 0, 3, 0, 4, 0),
            ("rgb8_skip_pixels", glw::GL_RGB8, 31, 30, 36, 0, 5, 4, 0),
        ];

        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            let spec = Spec::PboTexImage {
                row_length: 0,
                skip_rows: 0,
                skip_pixels: 0,
                alignment: 4,
                offset: 0,
            };
            pbo_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                internal_format,
                false,
                65,
                37,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                internal_format,
                false,
                64,
                64,
                spec,
            ));
        }
        for &(name, internal_format, width, height, row_length, skip_rows, skip_pixels, alignment, offset) in
            &PARAMETER_CASES
        {
            let spec = Spec::PboTexImage {
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            };
            pbo_group.add_child(make_es3_sized_case(
                format!("{name}_2d"),
                TextureType::Tex2D,
                internal_format,
                false,
                width,
                height,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case(
                format!("{name}_cube"),
                TextureType::Cube,
                internal_format,
                false,
                width,
                width,
                spec,
            ));
        }
        group.add_child(pbo_group);
    }

    // glTexImage2D() depth cases with pbo.
    {
        let mut shadow_2d_group = TestCaseGroup::new("teximage2d_depth_pbo");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_2d_group.add_child(make_es3_sized_case(
                name.to_string(),
                TextureType::Tex2D,
                internal_format,
                false,
                64,
                128,
                Spec::PboDepth,
            ));
        }
        group.add_child(shadow_2d_group);
    }

    // glTexSubImage2D() PBO cases.
    {
        let mut pbo_group = TestCaseGroup::new("texsubimage2d_pbo");

        // (name, internal format, width, height, subX, subY, subW, subH, rowLength, skipRows, skipPixels, alignment, offset)
        #[allow(clippy::type_complexity)]
        const PARAM_CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 5] = [
            ("rgb8_offset", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 0, 0, 0, 4, 67),
            ("rgb8_alignment", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 0, 0, 0, 2, 0),
            ("rgb8_row_length", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 50, 0, 0, 4, 0),
            ("rgb8_skip_rows", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 0, 3, 0, 4, 0),
            ("rgb8_skip_pixels", glw::GL_RGB8, 54, 60, 11, 7, 31, 30, 36, 0, 5, 4, 0),
        ];

        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            let spec = Spec::PboTexSubImage {
                sub_x: 11,
                sub_y: 7,
                sub_w: 31,
                sub_h: 30,
                row_length: 0,
                skip_rows: 0,
                skip_pixels: 0,
                alignment: 4,
                offset: 0,
            };
            pbo_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_2d"),
                TextureType::Tex2D,
                internal_format,
                false,
                54,
                60,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case(
                format!("{fmt_name}_cube"),
                TextureType::Cube,
                internal_format,
                false,
                64,
                64,
                spec,
            ));
        }
        for &(
            name,
            internal_format,
            width,
            height,
            sub_x,
            sub_y,
            sub_w,
            sub_h,
            row_length,
            skip_rows,
            skip_pixels,
            alignment,
            offset,
        ) in &PARAM_CASES
        {
            let spec = Spec::PboTexSubImage {
                sub_x,
                sub_y,
                sub_w,
                sub_h,
                row_length,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            };
            pbo_group.add_child(make_es3_sized_case(
                format!("{name}_2d"),
                TextureType::Tex2D,
                internal_format,
                false,
                width,
                height,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case(
                format!("{name}_cube"),
                TextureType::Cube,
                internal_format,
                false,
                width,
                width,
                spec,
            ));
        }

        // This test makes sure the last bits from the PBO data can be read without errors.
        pbo_group.add_child(make_es3_case(
            "pbo_bounds_2d".to_string(),
            TextureType::Tex2D,
            glw::GL_RGBA,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            false,
            4,
            4,
            Spec::CopyFromPbo,
        ));
        group.add_child(pbo_group);
    }

    // glTexImage3D() PBO cases.
    {
        let mut pbo_group = TestCaseGroup::new("teximage3d_pbo");

        // (name, internal format, width, height, depth, imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment, offset)
        #[allow(clippy::type_complexity)]
        const PARAMETER_CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 7] = [
            ("rgb8_offset", glw::GL_RGB8, 23, 19, 8, 0, 0, 0, 0, 0, 1, 67),
            ("rgb8_alignment", glw::GL_RGB8, 23, 19, 8, 0, 0, 0, 0, 0, 2, 0),
            ("rgb8_image_height", glw::GL_RGB8, 23, 19, 8, 26, 0, 0, 0, 0, 4, 0),
            ("rgb8_row_length", glw::GL_RGB8, 23, 19, 8, 0, 27, 0, 0, 0, 4, 0),
            ("rgb8_skip_images", glw::GL_RGB8, 23, 19, 8, 0, 0, 3, 0, 0, 4, 0),
            ("rgb8_skip_rows", glw::GL_RGB8, 23, 19, 8, 22, 0, 0, 3, 0, 4, 0),
            ("rgb8_skip_pixels", glw::GL_RGB8, 23, 19, 8, 0, 25, 0, 0, 2, 4, 0),
        ];

        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            let spec = Spec::PboTexImage3d {
                image_height: 0,
                row_length: 0,
                skip_images: 0,
                skip_rows: 0,
                skip_pixels: 0,
                alignment: 4,
                offset: 0,
            };
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_2d_array"),
                TextureType::Array,
                internal_format,
                false,
                11,
                20,
                8,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_3d"),
                TextureType::ThreeD,
                internal_format,
                false,
                11,
                20,
                8,
                spec,
            ));
        }
        // Upstream passes (width, depth, height) to constructors taking (width, height, depth/layers); kept as is.
        for &(
            name,
            internal_format,
            width,
            height,
            depth,
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
            offset,
        ) in &PARAMETER_CASES
        {
            let spec = Spec::PboTexImage3d {
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            };
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{name}_2d_array"),
                TextureType::Array,
                internal_format,
                false,
                width,
                depth,
                height,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{name}_3d"),
                TextureType::ThreeD,
                internal_format,
                false,
                width,
                depth,
                height,
                spec,
            ));
        }
        group.add_child(pbo_group);
    }

    // glTexImage3D() depth cases with pbo.
    {
        let mut shadow_3d_group = TestCaseGroup::new("teximage3d_depth_pbo");
        for &(name, internal_format) in &DEPTH_STENCIL_FORMATS {
            shadow_3d_group.add_child(make_es3_sized_case_3d(
                format!("{name}_2d_array"),
                TextureType::Array,
                internal_format,
                false,
                32,
                64,
                8,
                Spec::PboArrayDepth,
            ));
        }
        group.add_child(shadow_3d_group);
    }

    // glTexSubImage3D() PBO cases.
    {
        let mut pbo_group = TestCaseGroup::new("texsubimage3d_pbo");

        // (name, internal format, width, height, depth, subX, subY, subZ, subW, subH, subD,
        //  imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment, offset)
        #[rustfmt::skip]
        #[allow(clippy::type_complexity)]
        const PARAM_CASES: [(&str, u32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32); 6] = [
            ("rgb8_offset", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 0, 0, 0, 0, 4, 67),
            ("rgb8_image_height", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 26, 0, 0, 0, 0, 4, 0),
            ("rgb8_row_length", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 27, 0, 0, 0, 4, 0),
            ("rgb8_skip_images", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 0, 3, 0, 0, 4, 0),
            ("rgb8_skip_rows", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 22, 0, 0, 3, 0, 4, 0),
            ("rgb8_skip_pixels", glw::GL_RGB8, 26, 25, 10, 1, 2, 1, 23, 19, 8, 0, 25, 0, 0, 2, 4, 0),
        ];

        for &(fmt_name, internal_format) in &COLOR_FORMATS {
            let spec = Spec::PboTexSubImage3d {
                sub_x: 1,
                sub_y: 2,
                sub_z: 0,
                sub_w: 23,
                sub_h: 19,
                sub_d: 8,
                image_height: 0,
                row_length: 0,
                skip_images: 0,
                skip_rows: 0,
                skip_pixels: 0,
                alignment: 4,
                offset: 0,
            };
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_2d_array"),
                TextureType::Array,
                internal_format,
                false,
                26,
                25,
                10,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{fmt_name}_3d"),
                TextureType::ThreeD,
                internal_format,
                false,
                26,
                25,
                10,
                spec,
            ));
        }
        for &(
            name,
            internal_format,
            width,
            height,
            depth,
            sub_x,
            sub_y,
            sub_z,
            sub_w,
            sub_h,
            sub_d,
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
            offset,
        ) in &PARAM_CASES
        {
            let spec = Spec::PboTexSubImage3d {
                sub_x,
                sub_y,
                sub_z,
                sub_w,
                sub_h,
                sub_d,
                image_height,
                row_length,
                skip_images,
                skip_rows,
                skip_pixels,
                alignment,
                offset,
            };
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{name}_2d_array"),
                TextureType::Array,
                internal_format,
                false,
                width,
                height,
                depth,
                spec,
            ));
            pbo_group.add_child(make_es3_sized_case_3d(
                format!("{name}_3d"),
                TextureType::ThreeD,
                internal_format,
                false,
                width,
                height,
                depth,
                spec,
            ));
        }
        group.add_child(pbo_group);
    }

    group
}
