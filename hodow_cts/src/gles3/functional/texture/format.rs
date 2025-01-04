// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureFormatTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The per-face / per-layer / per-slice
// `iterate()` state machines are plain loops with the same viewport seeds and the same
// overall verdict.
//
// The four `etc1_*` cases (`Texture2DFileCase`/`TextureCubeFileCase`) live in `etc1_cases`, fed from
// `glu::etc1` instead of the test-data archive.

use vulkanalia::vk;

use crate::gles3::functional::texture::etc1_cases::etc1_format_cases;
use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_2d_array::Texture2DArray;
use crate::glu::texture_3d::Texture3D;
use crate::glu::texture_cube::{ALL_FACES, TextureCube};
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, TextureType, compute_quad_tex_coord_2d, compute_quad_tex_coord_2d_array,
    compute_quad_tex_coord_3d, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    compare_images, compute_quad_tex_coord_cube, fill_with_component_gradients_old, make_reference_params,
    sample_texture_2d_array_to_surface, sample_texture_2d_to_surface, sample_texture_3d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, get_texture_format_info};
use crate::tcu::random::Random;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::texture::TextureFormat;
use crate::tcu::vector::{Vec2, Vec3, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};
use crate::vk::compressed_formats::{get_block_height, get_block_size_in_bytes, get_block_width};

/// The upstream `tcu::CubeFace` order, which is also the order its random data is drawn in.
const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `checkSupport`
fn check_format_support(context: &Context, internal_format: u32) -> Result<(), TestError> {
    let info = &context.context_info;
    if internal_format == glw::GL_SR8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_R8") {
        return Err(TestError::NotSupported(
            "GL_EXT_texture_sRGB_R8 is not supported.".to_string(),
        ));
    }
    if internal_format == glw::GL_SRG8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_RG8") {
        return Err(TestError::NotSupported(
            "GL_EXT_texture_sRGB_RG8 is not supported.".to_string(),
        ));
    }
    Ok(())
}

fn gradient_params(tex_type: TextureType, format: TextureFormat) -> Result<ReferenceParams, TestError> {
    let spec = get_texture_format_info(format);
    let mut params = make_reference_params(
        tex_type,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_NEAREST,
        glw::GL_NEAREST,
        LodMode::Exact,
    )?;
    params.base.sampler_type = get_sampler_type(format);
    params.base.color_scale = Vec4::from_array(spec.look_up_scale);
    params.base.color_bias = Vec4::from_array(spec.look_up_bias);
    Ok(params)
}

fn set_nearest_clamp_state(context: &Context, target: u32) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }
    glu::expect_no_error(gl, "Set texturing state")
}

fn verdict(is_ok: bool) -> TestOutcome {
    if is_ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Image comparison failed"))
    }
}

#[derive(Clone, Copy)]
enum Kind {
    Tex2D { width: i32, height: i32 },
    Cube { size: i32 },
    Array { width: i32, height: i32, num_layers: i32 },
    Tex3D { width: i32, height: i32, depth: i32 },
}

/// `Texture2DFormatCase`/`TextureCubeFormatCase`/`Texture2DArrayFormatCase`/
/// `Texture3DFormatCase`; `data_type == 0` means `format` is a sized internal format.
struct FormatCase {
    name: String,
    format: u32,
    data_type: u32,
    kind: Kind,
}

impl FormatCase {
    fn iterate_2d(&self, context: &Context, width: i32, height: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DFormatCase::init`
        let mut texture = if self.data_type != 0 {
            Texture2D::new(render_ctx, self.format, self.data_type, width as u32, height as u32)?
        } else {
            Texture2D::new_sized(render_ctx, self.format, width as u32, height as u32)?
        };
        let spec = get_texture_format_info(texture.ref_texture().format());
        texture.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = texture.ref_texture_mut().level_mut(0);
            fill_with_component_gradients_old(&mut level0, spec.value_min, spec.value_max);
        }

        // `Texture2DFormatCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let viewport = RandomViewport::new(&render_target, width, height, de_string_hash(&self.name));
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
        let render_params = gradient_params(TextureType::Texture2D, texture.ref_texture().format())?;
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            texture.upload()?;
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
        }
        set_nearest_clamp_state(context, glw::GL_TEXTURE_2D)?;

        renderer.render_quad(0, &tex_coord, &render_params.base)?;
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
        glu::expect_no_error(gl, "glReadPixels()")?;

        let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
        sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

        verdict(compare_images(&reference_frame, &rendered_frame, threshold).ok)
    }

    fn iterate_cube(&self, context: &Context, size: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `TextureCubeFormatCase::init`
        let mut texture = if self.data_type != 0 {
            TextureCube::new(render_ctx, self.format, self.data_type, size as u32)?
        } else {
            TextureCube::new_sized(render_ctx, self.format, size as u32)?
        };
        let spec = get_texture_format_info(texture.ref_texture().format());

        // Fill level 0.
        texture.ref_texture_mut().alloc_level(0);
        let swz = |v: [f32; 4], s: [usize; 4]| [v[s[0]], v[s[1]], v[s[2]], v[s[3]]];
        for (face_ndx, &face) in FACES.iter().enumerate() {
            let (g_min, g_max) = match face_ndx {
                0 => (swz(spec.value_min, [0, 1, 2, 3]), swz(spec.value_max, [0, 1, 2, 3])),
                1 => (swz(spec.value_min, [2, 1, 0, 3]), swz(spec.value_max, [2, 1, 0, 3])),
                2 => (swz(spec.value_min, [1, 2, 0, 3]), swz(spec.value_max, [1, 2, 0, 3])),
                3 => (swz(spec.value_max, [0, 1, 2, 3]), swz(spec.value_min, [0, 1, 2, 3])),
                4 => (swz(spec.value_max, [2, 1, 0, 3]), swz(spec.value_min, [2, 1, 0, 3])),
                _ => (swz(spec.value_max, [1, 2, 0, 3]), swz(spec.value_min, [1, 2, 0, 3])),
            };
            let mut level = texture.ref_texture_mut().face_level_mut(face, 0);
            fill_with_component_gradients_old(&mut level, g_min, g_max);
        }

        // Upload texture data to GL.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut is_ok = true;

        for (face_ndx, &face) in FACES.iter().enumerate() {
            let viewport = RandomViewport::new(
                &render_target,
                size,
                size,
                de_string_hash(&self.name).wrapping_add(face_ndx as u32),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let mut render_params = gradient_params(TextureType::Cube, texture.ref_texture().format())?;
            render_params.sampler.seamless_cube_map = true;
            let tex_coord = compute_quad_tex_coord_cube(face);

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
            }
            set_nearest_clamp_state(context, glw::GL_TEXTURE_CUBE_MAP)?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
            glu::expect_no_error(gl, "glReadPixels()")?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_cube_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                is_ok = false;
            }
        }

        verdict(is_ok)
    }

    fn iterate_2d_array(&self, context: &Context, width: i32, height: i32, num_layers: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DArrayFormatCase::init`
        let mut texture = if self.data_type != 0 {
            Texture2DArray::new(
                render_ctx,
                self.format,
                self.data_type,
                width as u32,
                height as u32,
                num_layers as u32,
            )?
        } else {
            Texture2DArray::new_sized(render_ctx, self.format, width as u32, height as u32, num_layers as u32)?
        };
        let spec = get_texture_format_info(texture.ref_texture().format());

        // Fill level 0.
        texture.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = texture.ref_texture_mut().level_mut(0);
            fill_with_component_gradients_old(&mut level0, spec.value_min, spec.value_max);
        }

        // Upload texture data to GL.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut is_ok = true;

        // `Texture2DArrayFormatCase::testLayer`, once per layer.
        for layer_ndx in 0..num_layers {
            let viewport = RandomViewport::new(&render_target, width, height, de_string_hash(&self.name));
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let render_params = gradient_params(TextureType::Texture2DArray, texture.ref_texture().format())?;
            let tex_coord = compute_quad_tex_coord_2d_array(layer_ndx, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.gl_texture());
            }
            set_nearest_clamp_state(context, glw::GL_TEXTURE_2D_ARRAY)?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_2d_array_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                is_ok = false;
            }
        }

        verdict(is_ok)
    }

    fn iterate_3d(&self, context: &Context, width: i32, height: i32, depth: i32) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture3DFormatCase::init`
        let mut texture = if self.data_type != 0 {
            Texture3D::new(
                render_ctx,
                self.format,
                self.data_type,
                width as u32,
                height as u32,
                depth as u32,
            )?
        } else {
            Texture3D::new_sized(render_ctx, self.format, width as u32, height as u32, depth as u32)?
        };
        let spec = get_texture_format_info(texture.ref_texture().format());

        // Fill level 0.
        texture.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = texture.ref_texture_mut().level_mut(0);
            fill_with_component_gradients_old(&mut level0, spec.value_min, spec.value_max);
        }

        // Upload texture data to GL.
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut is_ok = true;

        // `Texture3DFormatCase::testSlice`, once per slice.
        for slice_ndx in 0..depth {
            let viewport = RandomViewport::new(&render_target, width, height, de_string_hash(&self.name));
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let r = (slice_ndx as f32 + 0.5) / depth as f32;
            let render_params = gradient_params(TextureType::Texture3D, texture.ref_texture().format())?;
            let tex_coord = compute_quad_tex_coord_3d(Vec3::new(0.0, 0.0, r), Vec3::new(1.0, 1.0, r), [0, 1, 2]);

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_3D, texture.gl_texture());
            }
            set_nearest_clamp_state(context, glw::GL_TEXTURE_3D)?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_3d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                is_ok = false;
            }
        }

        verdict(is_ok)
    }
}

impl TestCase for FormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::Tex2D { width, height } => self.iterate_2d(context, width, height),
            Kind::Cube { size } => self.iterate_cube(context, size),
            Kind::Array {
                width,
                height,
                num_layers,
            } => self.iterate_2d_array(context, width, height, num_layers),
            Kind::Tex3D { width, height, depth } => self.iterate_3d(context, width, height, depth),
        }
    }
}

fn compressed_data_size(format: vk::Format, width: i32, height: i32) -> usize {
    (width as u32).div_ceil(get_block_width(format)) as usize
        * (height as u32).div_ceil(get_block_height(format)) as usize
        * get_block_size_in_bytes(format) as usize
}

/// `Compressed2DFormatCase`/`CompressedCubeFormatCase`: random bytes, so any content is valid.
struct CompressedCase {
    name: String,
    format: vk::Format,
    cube: bool,
    random_seed: u32,
    width: i32,
    height: i32,
}

impl TestCase for CompressedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let mut rnd = Random::new(self.random_seed);
        let data_size = compressed_data_size(self.format, self.width, self.height);
        let random_bytes =
            |rnd: &mut Random| -> Vec<u8> { (0..data_size).map(|_| (rnd.get_uint32() & 0xff) as u8).collect() };

        if !self.cube {
            // `Compressed2DFormatCase::init`
            let data = random_bytes(&mut rnd);
            let texture = Texture2D::new_compressed(
                render_ctx,
                &context.context_info,
                self.format,
                self.width as u32,
                self.height as u32,
                &[data.as_slice()],
            )?;
            // SAFETY: a current context; `texture` outlives the upload.
            unsafe { texture.upload_compressed()? };

            let viewport = RandomViewport::new(
                &render_target,
                texture.ref_texture().width() as i32,
                texture.ref_texture().height() as i32,
                de_string_hash(&self.name),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let render_params = gradient_params(TextureType::Texture2D, texture.ref_texture().format())?;
            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            }
            set_nearest_clamp_state(context, glw::GL_TEXTURE_2D)?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            return verdict(compare_images(&reference_frame, &rendered_frame, threshold).ok);
        }

        // `CompressedCubeFormatCase::init`: faces are drawn in upstream's `tcu::CubeFace`
        // order, `TextureCube::new_compressed` takes them in `ALL_FACES` order.
        let face_data: Vec<Vec<u8>> = (0..FACES.len()).map(|_| random_bytes(&mut rnd)).collect();
        let level: [&[u8]; 6] = std::array::from_fn(|i| {
            let upstream_ndx = FACES
                .iter()
                .position(|&f| f == ALL_FACES[i])
                .expect("every face is in FACES");
            face_data[upstream_ndx].as_slice()
        });
        let texture = TextureCube::new_compressed(
            render_ctx,
            &context.context_info,
            self.format,
            self.width as u32,
            &[level],
        )?;
        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload_compressed()? };

        let size = texture.ref_texture().size() as i32;
        let mut is_ok = true;

        for (face_ndx, &face) in FACES.iter().enumerate() {
            let viewport = RandomViewport::new(
                &render_target,
                size,
                size,
                de_string_hash(&self.name).wrapping_add(face_ndx as u32),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let mut render_params = gradient_params(TextureType::Cube, texture.ref_texture().format())?;
            render_params.sampler.seamless_cube_map = true;
            let tex_coord = compute_quad_tex_coord_cube(face);

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
            }
            set_nearest_clamp_state(context, glw::GL_TEXTURE_CUBE_MAP)?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_cube_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                is_ok = false;
            }
        }

        verdict(is_ok)
    }
}

/// `TextureFormatTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("format");
    let mut unsized_group = TestCaseGroup::new("unsized");
    let mut sized_group = TestCaseGroup::new("sized");
    let mut compressed_group = TestCaseGroup::new("compressed");
    let mut sized_2d_group = TestCaseGroup::new("2d");
    let mut sized_cube_group = TestCaseGroup::new("cube");
    let mut sized_2d_array_group = TestCaseGroup::new("2d_array");
    let mut sized_3d_group = TestCaseGroup::new("3d");

    const TEX_FORMATS: [(&str, u32, u32); 8] = [
        ("alpha", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("luminance", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        ("luminance_alpha", glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_BYTE),
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
    let boxed = |name: String, format: u32, data_type: u32, kind: Kind| {
        Box::new(FormatCase {
            name,
            format,
            data_type,
            kind,
        }) as Box<dyn TestCase>
    };

    for &(name_base, format, data_type) in &TEX_FORMATS {
        unsized_group.add_child(boxed(
            format!("{name_base}_2d_pot"),
            format,
            data_type,
            Kind::Tex2D {
                width: 128,
                height: 128,
            },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_2d_npot"),
            format,
            data_type,
            Kind::Tex2D { width: 63, height: 112 },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_cube_pot"),
            format,
            data_type,
            Kind::Cube { size: 64 },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_cube_npot"),
            format,
            data_type,
            Kind::Cube { size: 57 },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_2d_array_pot"),
            format,
            data_type,
            Kind::Array {
                width: 64,
                height: 64,
                num_layers: 8,
            },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_2d_array_npot"),
            format,
            data_type,
            Kind::Array {
                width: 63,
                height: 57,
                num_layers: 7,
            },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_3d_pot"),
            format,
            data_type,
            Kind::Tex3D {
                width: 8,
                height: 32,
                depth: 16,
            },
        ));
        unsized_group.add_child(boxed(
            format!("{name_base}_3d_npot"),
            format,
            data_type,
            Kind::Tex3D {
                width: 11,
                height: 31,
                depth: 7,
            },
        ));
    }

    const SIZED_COLOR_FORMATS: [(&str, u32); 51] = [
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
        ("srgb_r8", glw::GL_SR8_EXT),
        ("srgb_rg8", glw::GL_SRG8_EXT),
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

    // Depth and stencil formats: 2D, cube and 2D array only (no 3D depth texture).
    const SIZED_DEPTH_STENCIL_FORMATS: [(&str, u32); 5] = [
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F),
        ("depth_component24", glw::GL_DEPTH_COMPONENT24),
        ("depth_component16", glw::GL_DEPTH_COMPONENT16),
        ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8),
        ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
    ];

    for (format_ndx, &(name_base, internal_format)) in SIZED_COLOR_FORMATS
        .iter()
        .chain(SIZED_DEPTH_STENCIL_FORMATS.iter())
        .enumerate()
    {
        let has_3d = format_ndx < SIZED_COLOR_FORMATS.len();

        sized_2d_group.add_child(boxed(
            format!("{name_base}_pot"),
            internal_format,
            0,
            Kind::Tex2D {
                width: 128,
                height: 128,
            },
        ));
        sized_2d_group.add_child(boxed(
            format!("{name_base}_npot"),
            internal_format,
            0,
            Kind::Tex2D { width: 63, height: 112 },
        ));
        sized_cube_group.add_child(boxed(
            format!("{name_base}_pot"),
            internal_format,
            0,
            Kind::Cube { size: 64 },
        ));
        sized_cube_group.add_child(boxed(
            format!("{name_base}_npot"),
            internal_format,
            0,
            Kind::Cube { size: 57 },
        ));
        sized_2d_array_group.add_child(boxed(
            format!("{name_base}_pot"),
            internal_format,
            0,
            Kind::Array {
                width: 64,
                height: 64,
                num_layers: 8,
            },
        ));
        sized_2d_array_group.add_child(boxed(
            format!("{name_base}_npot"),
            internal_format,
            0,
            Kind::Array {
                width: 63,
                height: 57,
                num_layers: 7,
            },
        ));
        if has_3d {
            sized_3d_group.add_child(boxed(
                format!("{name_base}_pot"),
                internal_format,
                0,
                Kind::Tex3D {
                    width: 8,
                    height: 32,
                    depth: 16,
                },
            ));
            sized_3d_group.add_child(boxed(
                format!("{name_base}_npot"),
                internal_format,
                0,
                Kind::Tex3D {
                    width: 11,
                    height: 31,
                    depth: 7,
                },
            ));
        }
    }

    // ETC-1 compressed formats.
    for case in etc1_format_cases(GlslVersion::Es300, Precision::HighP, false) {
        compressed_group.add_child(case);
    }

    // ETC-2 and EAC compressed formats.
    const ETC2_FORMATS: [(&str, vk::Format); 10] = [
        ("eac_r11", vk::Format::EAC_R11_UNORM_BLOCK),
        ("eac_signed_r11", vk::Format::EAC_R11_SNORM_BLOCK),
        ("eac_rg11", vk::Format::EAC_R11G11_UNORM_BLOCK),
        ("eac_signed_rg11", vk::Format::EAC_R11G11_SNORM_BLOCK),
        ("etc2_rgb8", vk::Format::ETC2_R8G8B8_UNORM_BLOCK),
        ("etc2_srgb8", vk::Format::ETC2_R8G8B8_SRGB_BLOCK),
        ("etc2_rgb8_punchthrough_alpha1", vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK),
        ("etc2_srgb8_punchthrough_alpha1", vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK),
        ("etc2_eac_rgba8", vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK),
        ("etc2_eac_srgb8_alpha8", vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK),
    ];

    for &(name_base, format) in &ETC2_FORMATS {
        let case = |name: String, cube: bool, width: i32, height: i32| {
            Box::new(CompressedCase {
                name,
                format,
                cube,
                random_seed: 1,
                width,
                height,
            }) as Box<dyn TestCase>
        };
        compressed_group.add_child(case(format!("{name_base}_2d_pot"), false, 128, 64));
        compressed_group.add_child(case(format!("{name_base}_cube_pot"), true, 64, 64));
        compressed_group.add_child(case(format!("{name_base}_2d_npot"), false, 51, 65));
        compressed_group.add_child(case(format!("{name_base}_cube_npot"), true, 51, 51));
    }

    sized_group.add_child(sized_2d_group);
    sized_group.add_child(sized_cube_group);
    sized_group.add_child(sized_2d_array_group);
    sized_group.add_child(sized_3d_group);
    group.add_child(unsized_group);
    group.add_child(sized_group);
    group.add_child(compressed_group);
    group
}
