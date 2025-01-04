// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureSpecificationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
// The whole `texture.specification` group is ported (it only holds cube map array cases).
//
// Narrowing: upstream drives a GLES context and an `sglr::ReferenceContext` with the same
// calls and fuzzy-compares the two renders. `sglr` has no cube map array, so the reference
// here is the host-side level data each case builds anyway (the exact bytes it uploads, or
// that a sub-image upload overwrites), sampled nearest through `TextureCubeArrayView` for the
// level a `levelSize` quad minifies to. Rendering uses the raw GL quad program of
// `texture_format_tests` instead of `TextureCubeArrayShader`; the 4D coordinate carries the
// layer where upstream's shader reads `u_layer`. The fuzzy comparison and its 0.02 threshold
// are kept, and levels of 2x2 and smaller are skipped as upstream does. A format whose host
// level cannot be written (`TextureLevel::new` refuses it) is NotSupported with the reason.

use super::texture_format_tests::{cube_array_quad_program, cube_face_from_ndx, sample_cube_array_reference};
use crate::glu::texture_test_util::get_sampler_type;
use crate::glu::texture_test_util_surface::{compute_quad_tex_coord_cube, fill_with_component_gradients_old};
use crate::glu::texture_util::{TransferFormat, get_transfer_format, map_gl_internal_format};
use crate::glu::{self, ApiCase, Buffer, TestCaseGroup, Texture, VertexArray, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{
    FilterMode, PixelBufferAccess, Sampler, TextureFormatInfo, TextureLevel, fill_with_grid, get_texture_format_info,
};
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::{ChannelOrder, ChannelType, Random, TextureFormat, de_string_hash};

const VIEWPORT_WIDTH: i32 = 256;
const VIEWPORT_HEIGHT: i32 = 256;

const TARGET: GLenum = glw::GL_TEXTURE_CUBE_MAP_ARRAY;

/// `maxLevelCount`
fn max_level_count(size: i32) -> i32 {
    (size as u32).ilog2() as i32 + 1
}

/// `randomVector<4>`
fn random_vector(rnd: &mut Random, min_val: [f32; 4], max_val: [f32; 4]) -> [f32; 4] {
    let mut res = [0.0f32; 4];
    for ndx in 0..4 {
        res[ndx] = rnd.get_float_range(min_val[ndx], max_val[ndx]);
    }
    res
}

/// Depth cases: "we are interested in the behavior near [-2, 2], map it to visible range [0, 1]"
const DEPTH_GRADIENT_MIN: [f32; 4] = [-1.5, -2.0, 1.7, -1.5];
const DEPTH_GRADIENT_MAX: [f32; 4] = [2.0, 1.5, -1.0, 2.0];

#[derive(Clone, Copy)]
struct Unpack {
    image_height: i32,
    row_length: i32,
    skip_images: i32,
    skip_rows: i32,
    skip_pixels: i32,
    alignment: i32,
    offset: i32,
}

#[derive(Clone, Copy)]
struct SubBox {
    x: i32,
    y: i32,
    z: i32,
    w: i32,
    h: i32,
    d: i32,
}

#[derive(Clone, Copy)]
enum Kind {
    /// `BasicTexImageCubeArrayCase`
    Image,
    /// `BasicTexStorageCubeArrayCase`
    Storage,
    /// `TexImageCubeArrayBufferCase`
    ImagePbo(Unpack),
    /// `TexSubImageCubeArrayBufferCase`
    SubImagePbo(SubBox, Unpack),
    /// `TexImageCubeArrayDepthCase`
    DepthImage,
    /// `TexSubImageCubeArrayDepthCase`
    DepthSubImage,
    /// `TexImageCubeArrayDepthBufferCase`
    DepthImagePbo,
}

impl Kind {
    fn is_depth(self) -> bool {
        matches!(self, Kind::DepthImage | Kind::DepthSubImage | Kind::DepthImagePbo)
    }
}

struct Params {
    name: String,
    internal_format: GLenum,
    tex_format: TextureFormat,
    info: TextureFormatInfo,
    transfer: TransferFormat,
    size: i32,
    depth: i32,
    num_levels: i32,
}

fn new_level(p: &Params, w: i32, h: i32, d: i32) -> Result<TextureLevel, String> {
    TextureLevel::new(p.tex_format, w as u32, h as u32, d as u32)
        .map_err(|e| format!("host-side reference level cannot be written: {e}"))
}

fn scaled_grid_colors(info: &TextureFormatInfo) -> ([f32; 4], [f32; 4]) {
    let scale: [f32; 4] = std::array::from_fn(|c| info.value_max[c] - info.value_min[c]);
    let bias = info.value_min;
    let color_a: [f32; 4] = std::array::from_fn(|c| [1.0f32, 0.0, 0.0, 1.0][c] * scale[c] + bias[c]);
    let color_b: [f32; 4] = std::array::from_fn(|c| [0.0f32, 1.0, 0.0, 1.0][c] * scale[c] + bias[c]);
    (color_a, color_b)
}

/// Copies a `w x h x d` box of texels from the start of `src` into `dst` at (x, y, z); both are
/// tightly packed levels of one format.
fn copy_box(dst: &mut TextureLevel, src: &TextureLevel, x: i32, y: i32, z: i32) {
    let ps = dst.format().pixel_size().expect("checked in TextureLevel::new") as usize;
    let [dw, dh, _] = dst.size();
    let [sw, sh, sd] = src.size();
    let (dw, dh) = (dw as usize, dh as usize);
    let (sw, sh, sd) = (sw as usize, sh as usize, sd as usize);
    for k in 0..sd {
        for j in 0..sh {
            let s_off = (k * sh + j) * sw * ps;
            let d_off = (((z as usize + k) * dh + (y as usize + j)) * dw + x as usize) * ps;
            let row = &src.data()[s_off..s_off + sw * ps];
            dst.data_mut()[d_off..d_off + sw * ps].copy_from_slice(row);
        }
    }
}

fn align(value: i32, alignment: i32) -> i32 {
    (value + alignment - 1) / alignment * alignment
}

/// Sets the six `GL_UNPACK_*` parameters.
fn set_unpack(gl: &glw::Functions, u: &Unpack) {
    // SAFETY: plain state setters.
    unsafe {
        gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, u.image_height);
        gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, u.row_length);
        gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, u.skip_images);
        gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, u.skip_rows);
        gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, u.skip_pixels);
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, u.alignment);
    }
}

fn reset_unpack(gl: &glw::Functions) {
    set_unpack(
        gl,
        &Unpack {
            image_height: 0,
            row_length: 0,
            skip_images: 0,
            skip_rows: 0,
            skip_pixels: 0,
            alignment: 4,
            offset: 0,
        },
    );
    // SAFETY: unbinding.
    unsafe { gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0) };
}

/// Uploads `data` through a new pixel unpack buffer and leaves it bound.
fn upload_pbo<'gl>(gl: &'gl glw::Functions, data: &[u8]) -> Buffer<'gl> {
    let buf = Buffer::new(gl);
    // SAFETY: `data` outlives the call; the driver copies it.
    unsafe {
        gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, buf.get());
        gl.buffer_data(
            glw::GL_PIXEL_UNPACK_BUFFER,
            data.len() as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
    buf
}

/// `createTexture` of every case; returns the host-side image of each level.
fn create_texture(kind: Kind, gl: &glw::Functions, p: &Params) -> Result<Vec<TextureLevel>, String> {
    let ps = p.tex_format.pixel_size().ok_or_else(|| "no pixel size".to_string())? as i32;
    let fmt = p.transfer.format;
    let dtype = p.transfer.data_type;
    let mut levels = Vec::new();
    let mut rnd = Random::new(de_string_hash(&p.name));

    match kind {
        Kind::Image | Kind::Storage => {
            // SAFETY: plain state setter / storage allocation.
            unsafe {
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
                if matches!(kind, Kind::Storage) {
                    gl.tex_storage_3d(TARGET, p.num_levels, p.internal_format, p.size, p.size, p.depth);
                }
            }
            for ndx in 0..p.num_levels {
                let level_w = (p.size >> ndx).max(1);
                let g_min = random_vector(&mut rnd, p.info.value_min, p.info.value_max);
                let g_max = random_vector(&mut rnd, p.info.value_min, p.info.value_max);
                let mut level = new_level(p, level_w, level_w, p.depth)?;
                fill_with_component_gradients_old(&mut level.get_access(), g_min, g_max);
                // SAFETY: the level's bytes outlive the call.
                unsafe {
                    if matches!(kind, Kind::Storage) {
                        gl.tex_sub_image_3d(
                            TARGET,
                            ndx,
                            0,
                            0,
                            0,
                            level_w,
                            level_w,
                            p.depth,
                            fmt,
                            dtype,
                            level.data().as_ptr().cast(),
                        );
                    } else {
                        gl.tex_image_3d(
                            TARGET,
                            ndx,
                            p.internal_format as i32,
                            level_w,
                            level_w,
                            p.depth,
                            0,
                            fmt,
                            dtype,
                            level.data().as_ptr().cast(),
                        );
                    }
                }
                levels.push(level);
            }
        }
        Kind::ImagePbo(u) => {
            let row_length = if u.row_length > 0 { u.row_length } else { p.size };
            let row_pitch = align(row_length * ps, u.alignment);
            let image_height = if u.image_height > 0 { u.image_height } else { p.size };
            let slice_pitch = image_height * row_pitch;
            let (color_a, color_b) = scaled_grid_colors(&p.info);

            let mut data = vec![0u8; (slice_pitch * (p.depth + u.skip_images) + u.offset) as usize];
            {
                let start =
                    (u.skip_images * slice_pitch + u.skip_rows * row_pitch + u.skip_pixels * ps + u.offset) as usize;
                let mut access = PixelBufferAccess::new_with_pitch(
                    p.tex_format,
                    [p.size as u32, p.size as u32, p.depth as u32],
                    [ps as usize, row_pitch as usize, slice_pitch as usize],
                    &mut data[start..],
                );
                fill_with_grid(&mut access, 4, color_a, color_b);
            }
            let mut level = new_level(p, p.size, p.size, p.depth)?;
            fill_with_grid(&mut level.get_access(), 4, color_a, color_b);

            let _buf = upload_pbo(gl, &data);
            set_unpack(gl, &u);
            // SAFETY: the offset is into the bound unpack buffer, as upstream.
            unsafe {
                gl.tex_image_3d(
                    TARGET,
                    0,
                    p.internal_format as i32,
                    p.size,
                    p.size,
                    p.depth,
                    0,
                    fmt,
                    dtype,
                    u.offset as usize as *const std::ffi::c_void,
                );
            }
            levels.push(level);
        }
        Kind::SubImagePbo(b, u) => {
            // Fill with gradient.
            let mut level = new_level(p, p.size, p.size, p.depth)?;
            {
                let row_pitch = align(ps * p.size, 4);
                let slice_pitch = row_pitch * p.size;
                let mut data = vec![0u8; (slice_pitch * p.depth) as usize];
                {
                    let mut access = PixelBufferAccess::new_with_pitch(
                        p.tex_format,
                        [p.size as u32, p.size as u32, p.depth as u32],
                        [ps as usize, row_pitch as usize, slice_pitch as usize],
                        &mut data,
                    );
                    fill_with_component_gradients_old(&mut access, p.info.value_min, p.info.value_max);
                }
                fill_with_component_gradients_old(&mut level.get_access(), p.info.value_min, p.info.value_max);
                // SAFETY: default unpack state (alignment 4) matches the pitch built above.
                unsafe {
                    gl.tex_image_3d(
                        TARGET,
                        0,
                        p.internal_format as i32,
                        p.size,
                        p.size,
                        p.depth,
                        0,
                        fmt,
                        dtype,
                        data.as_ptr().cast(),
                    );
                }
            }

            // Fill data with grid.
            let row_length = if u.row_length > 0 { u.row_length } else { b.w };
            let row_pitch = align(row_length * ps, u.alignment);
            let image_height = if u.image_height > 0 { u.image_height } else { b.h };
            let slice_pitch = image_height * row_pitch;
            let (color_a, color_b) = scaled_grid_colors(&p.info);

            let mut data = vec![0u8; (slice_pitch * (p.depth + u.skip_images) + u.offset) as usize];
            {
                let start =
                    (u.skip_images * slice_pitch + u.skip_rows * row_pitch + u.skip_pixels * ps + u.offset) as usize;
                let mut access = PixelBufferAccess::new_with_pitch(
                    p.tex_format,
                    [b.w as u32, b.h as u32, b.d as u32],
                    [ps as usize, row_pitch as usize, slice_pitch as usize],
                    &mut data[start..],
                );
                fill_with_grid(&mut access, 4, color_a, color_b);
            }
            let mut grid = new_level(p, b.w, b.h, b.d)?;
            fill_with_grid(&mut grid.get_access(), 4, color_a, color_b);
            copy_box(&mut level, &grid, b.x, b.y, b.z);

            let _buf = upload_pbo(gl, &data);
            set_unpack(gl, &u);
            // SAFETY: the offset is into the bound unpack buffer, as upstream.
            unsafe {
                gl.tex_sub_image_3d(
                    TARGET,
                    0,
                    b.x,
                    b.y,
                    b.z,
                    b.w,
                    b.h,
                    b.d,
                    fmt,
                    dtype,
                    u.offset as isize as *const std::ffi::c_void,
                );
            }
            levels.push(level);
        }
        Kind::DepthImage | Kind::DepthSubImage => {
            // SAFETY: plain state setter.
            unsafe { gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1) };

            // First specify full texture.
            for ndx in 0..p.num_levels {
                let level_w = (p.size >> ndx).max(1);
                let mut level = new_level(p, level_w, level_w, p.depth)?;
                fill_with_component_gradients_old(&mut level.get_access(), DEPTH_GRADIENT_MIN, DEPTH_GRADIENT_MAX);
                // SAFETY: the level's bytes outlive the call.
                unsafe {
                    gl.tex_image_3d(
                        TARGET,
                        ndx,
                        p.internal_format as i32,
                        level_w,
                        level_w,
                        p.depth,
                        0,
                        fmt,
                        dtype,
                        level.data().as_ptr().cast(),
                    );
                }
                levels.push(level);
            }

            if matches!(kind, Kind::DepthSubImage) {
                // Re-specify parts of each level.
                for ndx in 0..p.num_levels {
                    let level_w = (p.size >> ndx).max(1);

                    let w = rnd.get_int(1, level_w);
                    let h = rnd.get_int(1, level_w);
                    let d = rnd.get_int(1, p.depth);
                    let x = rnd.get_int(0, level_w - w);
                    let y = rnd.get_int(0, level_w - h);
                    let z = rnd.get_int(0, p.depth - d);

                    let cell_size = rnd.get_int(2, 16);

                    let mut grid = new_level(p, w, h, d)?;
                    fill_with_grid(
                        &mut grid.get_access(),
                        cell_size as u32,
                        DEPTH_GRADIENT_MAX,
                        DEPTH_GRADIENT_MIN,
                    );

                    // SAFETY: the grid's bytes outlive the call.
                    unsafe {
                        gl.tex_sub_image_3d(TARGET, ndx, x, y, z, w, h, d, fmt, dtype, grid.data().as_ptr().cast());
                    }
                    copy_box(&mut levels[ndx as usize], &grid, x, y, z);
                }
            }
        }
        Kind::DepthImagePbo => {
            let row_length = p.size;
            let alignment = 4;
            let row_pitch = align(row_length * ps, alignment);
            let image_height = p.size;
            let slice_pitch = image_height * row_pitch;

            let mut data = vec![0u8; (slice_pitch * p.depth) as usize];
            {
                let mut access = PixelBufferAccess::new_with_pitch(
                    p.tex_format,
                    [p.size as u32, p.size as u32, p.depth as u32],
                    [ps as usize, row_pitch as usize, slice_pitch as usize],
                    &mut data,
                );
                fill_with_component_gradients_old(&mut access, DEPTH_GRADIENT_MIN, DEPTH_GRADIENT_MAX);
            }
            let mut level = new_level(p, p.size, p.size, p.depth)?;
            fill_with_component_gradients_old(&mut level.get_access(), DEPTH_GRADIENT_MIN, DEPTH_GRADIENT_MAX);

            let buf = upload_pbo(gl, &data);
            set_unpack(
                gl,
                &Unpack {
                    image_height,
                    row_length,
                    skip_images: 0,
                    skip_rows: 0,
                    skip_pixels: 0,
                    alignment,
                    offset: 0,
                },
            );
            // SAFETY: a null pointer is offset 0 into the bound unpack buffer.
            unsafe {
                gl.tex_image_3d(
                    TARGET,
                    0,
                    p.internal_format as i32,
                    p.size,
                    p.size,
                    p.depth,
                    0,
                    fmt,
                    dtype,
                    std::ptr::null(),
                );
            }
            drop(buf);
            levels.push(level);
        }
    }
    Ok(levels)
}

/// `TextureSpecCase::iterate` + `TextureCubeArraySpecCase::verifyTexture`
fn run_case(
    case: &mut ApiCase<'_>,
    name: &str,
    internal_format: GLenum,
    size: i32,
    depth: i32,
    num_levels: i32,
    kind: Kind,
) {
    let context = case.context();
    let gl = case.gl();

    // `checkExtensionSupport`
    let supports_es32 = context.context_type().supports(3, 2);
    if !supports_es32
        && !context
            .context_info
            .is_extension_supported("GL_EXT_texture_cube_map_array")
    {
        case.not_supported("Extension not supported");
        return;
    }

    let render_target = context.render_target();
    if render_target.width < VIEWPORT_WIDTH || render_target.height < VIEWPORT_HEIGHT {
        case.not_supported("Too small viewport");
        return;
    }

    let Some(tex_format) = map_gl_internal_format(internal_format) else {
        case.fail(format!("unmapped format 0x{internal_format:04X}"), "unmapped format");
        return;
    };
    let transfer = match get_transfer_format(tex_format) {
        Ok(transfer) => transfer,
        Err(e) => {
            case.not_supported(format!("no GL transfer format for the reference level: {e}"));
            return;
        }
    };
    let mut info = get_texture_format_info(tex_format);
    if kind.is_depth() {
        info.look_up_bias = [0.25, 0.0, 0.0, 1.0];
        info.look_up_scale = [0.5, 1.0, 1.0, 0.0];
    }

    // Viewport placement, `rnd.getInt(0, renderTarget - size)` on the 256x256 region.
    let mut rnd = Random::new(de_string_hash(name));
    let width = render_target.width.min(VIEWPORT_WIDTH);
    let height = render_target.height.min(VIEWPORT_HEIGHT);
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    let sampler_type = get_sampler_type(tex_format);
    let program = cube_array_quad_program(context, sampler_type);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_id = program.program();

    let (look_up_scale, look_up_bias) = (info.look_up_scale, info.look_up_bias);
    let params = Params {
        name: name.to_string(),
        internal_format,
        tex_format,
        info,
        transfer,
        size,
        depth,
        num_levels,
    };

    let texture = Texture::new(gl);
    let vao = VertexArray::new(gl);
    // SAFETY: names this case owns.
    unsafe {
        gl.clear_color(0.125, 0.25, 0.5, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(TARGET, texture.get());
        gl.bind_vertex_array(vao.get());
    }

    reset_unpack(gl);
    let mut levels = match create_texture(kind, gl, &params) {
        Ok(levels) => levels,
        Err(reason) => {
            reset_unpack(gl);
            case.not_supported(reason);
            return;
        }
    };
    reset_unpack(gl);
    case.expect_no_error("createTexture");

    // `depthValueFloatClampCopy`: the reference context clamps a float depth on upload.
    if matches!(
        (tex_format.order, tex_format.type_),
        (ChannelOrder::D, ChannelType::FLOAT) | (ChannelOrder::DS, ChannelType::FLOAT_UNSIGNED_INT_24_8_REV)
    ) {
        for level in &mut levels {
            let mut access = level.get_access();
            let [w, h, d] = access.size();
            for z in 0..d {
                for y in 0..h {
                    for x in 0..w {
                        let depth = access.get_pix_depth(x, y, z);
                        access.set_pix_depth(depth.clamp(0.0, 1.0), x, y, z);
                    }
                }
            }
        }
    }

    // Set state.
    // SAFETY: plain texture parameter setters on the bound texture.
    unsafe {
        gl.tex_parameteri(
            TARGET,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );
        gl.tex_parameteri(TARGET, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(TARGET, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(TARGET, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(TARGET, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(TARGET, glw::GL_TEXTURE_MAX_LEVEL, num_levels - 1);
    }

    let mut sampler = Sampler::clamp_to_edge(FilterMode::Nearest);
    sampler.seamless_cube_map = true;
    sampler.normalized_coords = true;

    let positions: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
    let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    for layer_face_ndx in 0..depth {
        let layer_ndx = layer_face_ndx / 6;
        let face = cube_face_from_ndx(layer_face_ndx % 6);

        let cube = compute_quad_tex_coord_cube(face);
        let tex_coord: [f32; 16] = std::array::from_fn(|i| {
            if i % 4 == 3 {
                layer_ndx as f32
            } else {
                cube[(i / 4) * 3 + i % 4]
            }
        });

        for level_ndx in 0..num_levels {
            let level_size = (size >> level_ndx).max(1);

            if level_size <= 2 {
                continue; // Fuzzy compare doesn't work for images this small.
            }

            // SAFETY: plain state setters and uniform writes on the program that linked.
            unsafe {
                gl.viewport(vp_x, vp_y, level_size, level_size);
                gl.use_program(program_id);
                gl.uniform_1i(gl.get_uniform_location(program_id, c"u_sampler".as_ptr()), 0);
                gl.uniform_4f(
                    gl.get_uniform_location(program_id, c"u_colorScale".as_ptr()),
                    look_up_scale[0],
                    look_up_scale[1],
                    look_up_scale[2],
                    look_up_scale[3],
                );
                gl.uniform_4f(
                    gl.get_uniform_location(program_id, c"u_colorBias".as_ptr()),
                    look_up_bias[0],
                    look_up_bias[1],
                    look_up_bias[2],
                    look_up_bias[3],
                );
            }

            let bindings = [
                glu::va::float("a_position", 2, 4, 0, positions.as_flattened()),
                glu::va::float("a_texCoord", 4, 4, 0, &tex_coord),
            ];
            if let Err(e) = glu::draw(
                &context.render_context,
                program_id,
                &bindings,
                &glu::pr::triangles(&quad_indices),
            ) {
                case.fail(e.to_string(), "Draw failed");
                return;
            }

            let mut result = Surface::new(level_size, level_size);
            if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut result.get_access()) {
                case.fail(e.to_string(), "glReadPixels() failed");
                return;
            }

            let mut reference = Surface::new(level_size, level_size);
            {
                let mut reference_access = SurfaceAccess::new(&mut reference, render_target.pixel_format());
                sample_cube_array_reference(
                    &mut reference_access,
                    levels[level_ndx as usize].get_const_access().into_effective_depth(),
                    &tex_coord,
                    &sampler,
                    look_up_scale,
                    look_up_bias,
                );
            }

            let threshold = 0.02f32;
            let is_face_ok =
                fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), threshold).unwrap_or(false);
            if !is_face_ok {
                case.fail(
                    format!("Layer-face {layer_face_ndx}, Level {level_ndx}: image comparison failed"),
                    "Image comparison failed",
                );
                return;
            }
        }
    }

    case.expect_no_error("texture specification case");
}

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    internal_format: GLenum,
    size: i32,
    depth: i32,
    num_levels: i32,
    kind: Kind,
) {
    let seed_name = name.clone();
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        run_case(case, &seed_name, internal_format, size, depth, num_levels, kind)
    });
}

const COLOR_FORMATS: &[(&str, GLenum)] = &[
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

const DEPTH_STENCIL_FORMATS: &[(&str, GLenum)] = &[
    ("depth_component32f", glw::GL_DEPTH_COMPONENT32F),
    ("depth_component24", glw::GL_DEPTH_COMPONENT24),
    ("depth_component16", glw::GL_DEPTH_COMPONENT16),
    ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8),
    ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
];

fn plain_unpack(alignment: i32) -> Unpack {
    Unpack {
        image_height: 0,
        row_length: 0,
        skip_images: 0,
        skip_rows: 0,
        skip_pixels: 0,
        alignment,
        offset: 0,
    }
}

fn basic_teximage3d_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("basic_teximage3d");
    for &(fmt_name, format) in COLOR_FORMATS {
        let size = 64;
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            size,
            6,
            max_level_count(size),
            Kind::Image,
        );
    }
    group
}

fn teximage3d_pbo_group() -> TestCaseGroup {
    // name, size, depth, imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment, offset
    #[allow(clippy::type_complexity)]
    const PARAMETER_CASES: [(&str, i32, i32, i32, i32, i32, i32, i32, i32, i32); 7] = [
        ("rgb8_offset", 23, 6, 0, 0, 0, 0, 0, 1, 67),
        ("rgb8_alignment", 23, 6, 0, 0, 0, 0, 0, 2, 0),
        ("rgb8_image_height", 23, 6, 26, 0, 0, 0, 0, 4, 0),
        ("rgb8_row_length", 23, 6, 0, 27, 0, 0, 0, 4, 0),
        ("rgb8_skip_images", 23, 6, 0, 0, 3, 0, 0, 4, 0),
        ("rgb8_skip_rows", 23, 6, 26, 0, 0, 3, 0, 4, 0),
        ("rgb8_skip_pixels", 23, 6, 0, 25, 0, 0, 2, 4, 0),
    ];

    let mut group = TestCaseGroup::new("teximage3d_pbo");
    for &(fmt_name, format) in COLOR_FORMATS {
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            20,
            6,
            1,
            Kind::ImagePbo(plain_unpack(4)),
        );
    }
    for (name, size, depth, image_height, row_length, skip_images, skip_rows, skip_pixels, alignment, offset) in
        PARAMETER_CASES
    {
        let unpack = Unpack {
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
            offset,
        };
        add_case(
            &mut group,
            format!("{name}_cube_array"),
            glw::GL_RGB8,
            size,
            depth,
            1,
            Kind::ImagePbo(unpack),
        );
    }
    group
}

fn teximage3d_depth_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("teximage3d_depth");
    for &(fmt_name, format) in DEPTH_STENCIL_FORMATS {
        let size = 64;
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            size,
            6,
            max_level_count(size),
            Kind::DepthImage,
        );
    }
    group
}

fn teximage3d_depth_pbo_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("teximage3d_depth_pbo");
    for &(fmt_name, format) in DEPTH_STENCIL_FORMATS {
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            64,
            6,
            1,
            Kind::DepthImagePbo,
        );
    }
    group
}

fn texsubimage3d_pbo_group() -> TestCaseGroup {
    // name, imageHeight, rowLength, skipImages, skipRows, skipPixels, alignment, offset
    // (size 26, depth 12, sub box 1,2,1 23x19x8 for every row)
    #[allow(clippy::type_complexity)]
    const PARAM_CASES: [(&str, i32, i32, i32, i32, i32, i32, i32); 6] = [
        ("rgb8_offset", 0, 0, 0, 0, 0, 4, 67),
        ("rgb8_image_height", 26, 0, 0, 0, 0, 4, 0),
        ("rgb8_row_length", 0, 27, 0, 0, 0, 4, 0),
        ("rgb8_skip_images", 0, 0, 3, 0, 0, 4, 0),
        ("rgb8_skip_rows", 22, 0, 0, 3, 0, 4, 0),
        ("rgb8_skip_pixels", 0, 25, 0, 0, 2, 4, 0),
    ];

    let mut group = TestCaseGroup::new("texsubimage3d_pbo");
    for &(fmt_name, format) in COLOR_FORMATS {
        let sub = SubBox {
            x: 1,
            y: 2,
            z: 0,
            w: 23,
            h: 19,
            d: 8,
        };
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            26,
            12,
            1,
            Kind::SubImagePbo(sub, plain_unpack(4)),
        );
    }
    for (name, image_height, row_length, skip_images, skip_rows, skip_pixels, alignment, offset) in PARAM_CASES {
        let sub = SubBox {
            x: 1,
            y: 2,
            z: 1,
            w: 23,
            h: 19,
            d: 8,
        };
        let unpack = Unpack {
            image_height,
            row_length,
            skip_images,
            skip_rows,
            skip_pixels,
            alignment,
            offset,
        };
        add_case(
            &mut group,
            format!("{name}_cube_array"),
            glw::GL_RGB8,
            26,
            12,
            1,
            Kind::SubImagePbo(sub, unpack),
        );
    }
    group
}

fn texsubimage3d_depth_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texsubimage3d_depth");
    for &(fmt_name, format) in DEPTH_STENCIL_FORMATS {
        let size = 57;
        add_case(
            &mut group,
            format!("{fmt_name}_cube_array"),
            format,
            size,
            6,
            max_level_count(size),
            Kind::DepthSubImage,
        );
    }
    group
}

fn texstorage3d_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texstorage3d");

    // All formats (the depth/stencil ones too, upstream's own comment notwithstanding).
    let mut format_group = TestCaseGroup::new("format");
    for &(fmt_name, format) in COLOR_FORMATS.iter().chain(DEPTH_STENCIL_FORMATS.iter()) {
        let size = 57;
        add_case(
            &mut format_group,
            format!("{fmt_name}_cube_array"),
            format,
            size,
            6,
            max_level_count(size),
            Kind::Storage,
        );
    }
    group.add_child(format_group);

    // Sizes.
    const SIZES: [(i32, i32, i32); 7] = [
        (1, 6, 1),
        (2, 6, 2),
        (32, 6, 3),
        (64, 6, 4),
        (57, 12, 1),
        (57, 12, 2),
        (57, 12, 6),
    ];
    let mut size_group = TestCaseGroup::new("size");
    for (size, layers, levels) in SIZES {
        let name = format!("cube_array_{size}x{size}x{layers}_{levels}_levels");
        add_case(
            &mut size_group,
            name,
            glw::GL_RGBA8,
            size,
            layers,
            levels,
            Kind::Storage,
        );
    }
    group.add_child(size_group);
    group
}

/// `TextureSpecificationTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("specification");
    group.add_child(basic_teximage3d_group());
    group.add_child(teximage3d_pbo_group());
    group.add_child(teximage3d_depth_group());
    group.add_child(teximage3d_depth_pbo_group());
    group.add_child(texsubimage3d_pbo_group());
    group.add_child(texsubimage3d_depth_group());
    group.add_child(texstorage3d_group());
    group
}
