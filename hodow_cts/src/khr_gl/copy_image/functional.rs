// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cCopyImageTests.cpp
//   external/openglcts/modules/gl/gl4cCopyImageTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `iterate` runs one test case per call (CONTINUE until the list ends); here one `iterate` loops over the list and stops at the first failure, which is the same verdict. The `COPY_IMAGE_FUNCTIONAL_TEST_ENABLE_ALL_*` switches are fixed at upstream's defaults (0).

use super::tables::{get_format, get_pixel_size_for_format, get_type, texture_format_string};
use super::utils::{
    compare_pixel_memory, generate_texture, get_pixel_string, is_target_multilayer, is_target_multilevel,
    make_texture_complete, pack_pixel, prepare_texture, unpack_and_compare_pixels,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_LAYERS: u32 = 12;
const N_LEVELS: usize = 3;

/// `FunctionalTest::targetDesc`
#[derive(Clone, Copy)]
struct TargetDesc {
    target: GLenum,
    width: GLuint,
    height: GLuint,
    level: GLuint,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
}

/// `FunctionalTest::testCase`
#[derive(Clone, Copy)]
struct CaseData {
    dst: TargetDesc,
    dst_x: GLuint,
    dst_y: GLuint,
    src: TargetDesc,
    src_x: GLuint,
    src_y: GLuint,
    width: GLuint,
    height: GLuint,
}

type Levels = [Vec<u8>; N_LEVELS];

/// The object names of one test case (`m_dst_buf_name` and friends)
#[derive(Default)]
struct Resources {
    dst_buf_name: GLuint,
    dst_tex_name: GLuint,
    rb_name: GLuint,
    src_buf_name: GLuint,
    src_tex_name: GLuint,
}

impl Resources {
    /// `FunctionalTest::clean`
    fn clean(&mut self, context: &Context) {
        let gl = context.gl();
        // SAFETY: deletes names this test case created, on the current context; errors are ignored as upstream does.
        unsafe {
            gl.delete_textures(1, &self.dst_tex_name);
            gl.delete_textures(1, &self.src_tex_name);
            self.dst_tex_name = 0;
            self.src_tex_name = 0;

            if self.dst_buf_name != 0 {
                gl.delete_buffers(1, &self.dst_buf_name);
                self.dst_buf_name = 0;
            }
            if self.rb_name != 0 {
                gl.delete_renderbuffers(1, &self.rb_name);
                self.rb_name = 0;
            }
            if self.src_buf_name != 0 {
                gl.delete_buffers(1, &self.src_buf_name);
                self.src_buf_name = 0;
            }
        }
    }
}

/// `CopyImage::FunctionalTest`
pub(super) struct FunctionalTest {
    name: String,
    test_cases: Vec<CaseData>,
}

/// `getTextureTargetString` for the targets `VALID_TARGETS` lists
fn texture_target_string(target: GLenum) -> &'static str {
    match target {
        glw::GL_RENDERBUFFER => "renderbuffer",
        glw::GL_TEXTURE_1D => "texture_1d",
        glw::GL_TEXTURE_1D_ARRAY => "texture_1d_array",
        glw::GL_TEXTURE_2D => "texture_2d",
        glw::GL_TEXTURE_2D_ARRAY => "texture_2d_array",
        glw::GL_TEXTURE_2D_MULTISAMPLE => "texture_2d_multisample",
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => "texture_2d_multisample_array",
        glw::GL_TEXTURE_3D => "texture_3d",
        glw::GL_TEXTURE_CUBE_MAP => "texture_cube_map",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "texture_cube_map_array",
        glw::GL_TEXTURE_RECTANGLE => "texture_rectangle",
        _ => "null",
    }
}

/// `FunctionalTest::calculateDimmensions`: widths, heights and depths of every level
fn calculate_dimensions(
    target: GLenum,
    level: GLuint,
    width: GLuint,
    height: GLuint,
) -> ([GLuint; N_LEVELS], [GLuint; N_LEVELS], [GLuint; N_LEVELS]) {
    const DIVIDE: GLuint = 100;
    let mut factors = [0 as GLuint; N_LEVELS];
    let n_layers = if is_target_multilayer(target) { N_LAYERS } else { 1 };

    let mut factor = DIVIDE;
    for i in (0..=level as usize).rev() {
        factors[i] = factor;
        factor *= 2;
    }

    factor = DIVIDE / 2;
    for slot in factors.iter_mut().skip(level as usize + 1) {
        *slot = factor;
        factor /= 2;
    }

    let mut widths = [0; N_LEVELS];
    let mut heights = [0; N_LEVELS];
    let mut depths = [0; N_LEVELS];
    for i in 0..N_LEVELS {
        widths[i] = width * factors[i] / DIVIDE;
        heights[i] = height * factors[i] / DIVIDE;
        depths[i] = if target == glw::GL_TEXTURE_3D {
            N_LAYERS * factors[i] / DIVIDE
        } else {
            n_layers
        };
    }
    (widths, heights, depths)
}

/// `FunctionalTest::prepareDstPxls`
fn prepare_dst_pxls(desc: &TargetDesc) -> Levels {
    let n_levels = if is_target_multilevel(desc.target) { N_LEVELS } else { 1 };
    let pixel_size = get_pixel_size_for_format(desc.internal_format) as usize;
    let (widths, heights, depths) = calculate_dimensions(desc.target, desc.level, desc.width, desc.height);

    let mut out_pixels: Levels = Default::default();
    for i in 0..n_levels {
        let n_pixels = (widths[i] * heights[i] * depths[i]) as usize;
        let mut data = vec![0u8; pixel_size * n_pixels];
        for j in 0..n_pixels {
            pack_pixel(
                desc.internal_format,
                desc.type_,
                1.0,
                1.0,
                1.0,
                1.0,
                &mut data[j * pixel_size..(j + 1) * pixel_size],
            );
        }
        out_pixels[i] = data;
    }
    out_pixels
}

/// `FunctionalTest::prepareSrcPxls`
fn prepare_src_pxls(desc: &TargetDesc) -> Levels {
    let n_levels = if is_target_multilevel(desc.target) { N_LEVELS } else { 1 };
    let pixel_size = get_pixel_size_for_format(desc.internal_format) as usize;
    let (widths, heights, depths) = calculate_dimensions(desc.target, desc.level, desc.width, desc.height);

    let mut out_pixels: Levels = Default::default();
    for lvl in 0..n_levels {
        let line_size = pixel_size * widths[lvl] as usize;
        let layer_size = line_size * heights[lvl] as usize;
        let mut data = vec![0u8; layer_size * depths[lvl] as usize];

        for lay in 0..depths[lvl] {
            for y in 0..heights[lvl] {
                for x in 0..widths[lvl] {
                    let offset = lay as usize * layer_size + y as usize * line_size + x as usize * pixel_size;
                    // 255 is max ubyte. 1/15.9375 = 16/255
                    let red = x as f64 / 255.0 + y as f64 / 15.9375;
                    let green = lay as f64 / 255.0 + lvl as f64 / 15.9375;
                    let blue = 0.125;
                    let alpha = 1.0; // This value has special meaning for some internal_formats
                    pack_pixel(
                        desc.internal_format,
                        desc.type_,
                        red,
                        green,
                        blue,
                        alpha,
                        &mut data[offset..offset + pixel_size],
                    );
                }
            }
        }
        out_pixels[lvl] = data;
    }
    out_pixels
}

/// The pixels of one level, or none for a level upstream leaves null (a source made for a non-multilevel target but used for a multilevel one)
fn level_pixels(level: &[u8]) -> Option<&[u8]> {
    if level.is_empty() { None } else { Some(level) }
}

/// `FunctionalTest::prepareTexture`
fn prepare_functional_texture(
    context: &Context,
    desc: &TargetDesc,
    pixels: &Levels,
    out_buf_id: &mut GLuint,
) -> Result<GLuint, TestError> {
    let name = generate_texture(context, desc.target)?;

    if !is_target_multilevel(desc.target) {
        // depth is 12 for multilayered, 1D and 2D ignore it
        prepare_texture(
            context,
            name,
            desc.target,
            desc.internal_format,
            desc.format,
            desc.type_,
            0,
            desc.width,
            desc.height,
            N_LAYERS,
            level_pixels(&pixels[0]),
            out_buf_id,
        )?;
        make_texture_complete(context, desc.target, name, 0, 0)?;
    } else {
        let (widths, heights, depths) = calculate_dimensions(desc.target, desc.level, desc.width, desc.height);

        for level in 0..N_LEVELS {
            prepare_texture(
                context,
                name,
                desc.target,
                desc.internal_format,
                desc.format,
                desc.type_,
                level as GLuint,
                widths[level],
                heights[level],
                depths[level],
                level_pixels(&pixels[level]),
                out_buf_id,
            )?;
            make_texture_complete(context, desc.target, name, 0, 2)?;
        }
    }
    Ok(name)
}

/// `FunctionalTest::getPixels`
fn get_pixels(
    context: &Context,
    name: GLuint,
    desc: &TargetDesc,
    level: GLuint,
    out_pixels: &mut [u8],
) -> Result<(), TestError> {
    let gl = context.gl();

    // SAFETY: texture state calls on the current context; the buffer was sized for the largest level.
    unsafe { gl.bind_texture(desc.target, name) };
    glu::expect_no_error(gl, "BindTexture")?;
    // SAFETY: as above.
    unsafe {
        gl.get_tex_image(
            desc.target,
            level as GLint,
            desc.format,
            desc.type_,
            out_pixels.as_mut_ptr().cast(),
        )
    };
    glu::expect_no_error(gl, "GetTexImage")?;
    // SAFETY: as above.
    unsafe { gl.bind_texture(desc.target, 0) };
    glu::expect_no_error(gl, "BindTexture")
}

/// `FunctionalTest::compareImages`
#[allow(clippy::too_many_arguments)]
fn compare_images(
    left_desc: &TargetDesc,
    left_data: &[u8],
    left_x: GLuint,
    left_y: GLuint,
    left_layer: GLuint,
    left_level: GLuint,
    right_desc: &TargetDesc,
    right_data: &[u8],
    right_x: GLuint,
    right_y: GLuint,
    right_layer: GLuint,
    right_level: GLuint,
    region_width: GLuint,
    region_height: GLuint,
) -> bool {
    let (left_widths, left_heights, _) =
        calculate_dimensions(left_desc.target, left_desc.level, left_desc.width, left_desc.height);
    let (right_widths, right_heights, _) =
        calculate_dimensions(right_desc.target, right_desc.level, right_desc.width, right_desc.height);

    let left_height = left_heights[left_level as usize];
    let left_width = left_widths[left_level as usize];
    let right_height = right_heights[right_level as usize];
    let right_width = right_widths[right_level as usize];

    let left_pixel_size = get_pixel_size_for_format(left_desc.internal_format);
    let left_line_size = left_pixel_size * left_width;
    let left_layer_size = left_line_size * left_height;
    let right_pixel_size = get_pixel_size_for_format(right_desc.internal_format);
    let right_line_size = right_pixel_size * right_width;
    let right_layer_size = right_line_size * right_height;

    let left_layer_offset = left_layer_size * left_layer;
    let left_reg_line_offset = left_line_size * left_y;
    let left_reg_pix_offset = left_pixel_size * left_x;
    let right_layer_offset = right_layer_size * right_layer;
    let right_reg_line_offset = right_line_size * right_y;
    let right_reg_pix_offset = right_pixel_size * right_x;

    for y in 0..region_height {
        let left_line_offset = left_reg_line_offset + y * left_line_size;
        let right_line_offset = right_reg_line_offset + y * right_line_size;

        for x in 0..region_width {
            let left_pixel_offset =
                (left_layer_offset + left_line_offset + left_reg_pix_offset + x * left_pixel_size) as usize;
            let right_pixel_offset =
                (right_layer_offset + right_line_offset + right_reg_pix_offset + x * right_pixel_size) as usize;

            let left_pixel_data = &left_data[left_pixel_offset..];
            let right_pixel_data = &right_data[right_pixel_offset..];

            if !compare_pixel_memory(left_pixel_size, left_pixel_data, right_pixel_size, right_pixel_data)
                && !unpack_and_compare_pixels(
                    left_desc.format,
                    left_desc.type_,
                    left_desc.internal_format,
                    left_pixel_data,
                    right_desc.format,
                    right_desc.type_,
                    right_desc.internal_format,
                    right_pixel_data,
                )
            {
                log::info!(
                    "Not matching pixels found. Left: [{}, {}, {left_layer}] lvl:{left_level}, off: {left_pixel_offset}, data: {}. Right: [{}, {}, {right_layer}] lvl: {right_level}, off: {right_pixel_offset}, data: {}",
                    x + left_x,
                    y + left_y,
                    get_pixel_string(left_desc.internal_format, left_pixel_data),
                    x + right_x,
                    y + right_y,
                    get_pixel_string(right_desc.internal_format, right_pixel_data)
                );
                return false;
            }
        }
    }
    true
}

/// `FunctionalTest::getCleanRegions`: x, y, width, height of what the copy must not have touched
fn get_clean_regions(test_case: &CaseData, dst_level: GLuint) -> Vec<[GLuint; 4]> {
    let (dst_widths, dst_heights, _) = calculate_dimensions(
        test_case.dst.target,
        dst_level,
        test_case.dst.width,
        test_case.dst.height,
    );
    let mut regions = Vec::new();

    let reg_x = test_case.dst_x;
    let reg_y = test_case.dst_y;
    let reg_w = test_case.width;
    let reg_h = test_case.height;
    let reg_r = reg_x + reg_w;
    let reg_t = reg_y + reg_h;

    let img_w = dst_widths[dst_level as usize];
    let img_h = dst_heights[dst_level as usize];

    // Bottom row
    if reg_y != 0 {
        regions.push([0, 0, img_w, reg_y]);
    }
    // Left edge
    if reg_x != 0 {
        regions.push([0, reg_y, reg_x, reg_h]);
    }
    // Right edge
    if img_w != reg_r {
        regions.push([reg_r, reg_y, img_w - reg_r, reg_h]);
    }
    // Top row
    if img_h != reg_t {
        regions.push([0, reg_t, img_w, img_h - reg_t]);
    }
    regions
}

impl FunctionalTest {
    /// `FunctionalTest::FunctionalTest`
    pub(super) fn new(dst_format: GLenum, dst_target: GLenum, src_format: GLenum, src_target: GLenum) -> Self {
        let name = format!(
            "functional_src_target_{}_src_format_{}_dst_target_{}_dst_format_{}",
            texture_target_string(src_target),
            texture_format_string(src_format),
            texture_target_string(dst_target),
            texture_format_string(dst_format)
        );

        let mut test = Self {
            name,
            test_cases: Vec::new(),
        };
        test.prepare_test_cases(dst_format, dst_target, src_format, src_target);
        test
    }

    /// `FunctionalTest::prepareTestCases`
    fn prepare_test_cases(
        &mut self,
        dst_internal_format: GLenum,
        dst_target: GLenum,
        src_internal_format: GLenum,
        src_target: GLenum,
    ) {
        const IMAGE_DIMENSIONS: [GLuint; 2] = [7, 15];
        const REGION_DIMENSIONS: [GLuint; 2] = [1, 7];

        let dst_n_levels = if is_target_multilevel(dst_target) {
            N_LEVELS as GLuint
        } else {
            1
        };
        let src_n_levels = if is_target_multilevel(src_target) {
            N_LEVELS as GLuint
        } else {
            1
        };
        let dst_format = get_format(dst_internal_format);
        let dst_type = get_type(dst_internal_format);
        let src_format = get_format(src_internal_format);
        let src_type = get_type(src_internal_format);

        for src_level in 0..src_n_levels {
            for dst_level in 0..dst_n_levels {
                for src_image_dimension in IMAGE_DIMENSIONS {
                    for dst_image_dimension in IMAGE_DIMENSIONS {
                        for region_dimension in REGION_DIMENSIONS {
                            let mut dst_coord = [0 as GLuint; 3];
                            let dst_dim_diff = dst_image_dimension - region_dimension;
                            let mut n_dst_coords = 1;
                            let mut src_coord = [0 as GLuint; 3];
                            let src_dim_diff = src_image_dimension - region_dimension;

                            if dst_dim_diff == 1 {
                                dst_coord[1] = 1;
                                n_dst_coords = 2;
                            } else if dst_dim_diff > 1 {
                                dst_coord[1] = dst_dim_diff / 2;
                                dst_coord[2] = dst_dim_diff;
                                n_dst_coords = 3;
                            }

                            if src_dim_diff == 1 {
                                src_coord[1] = 1;
                            } else if src_dim_diff > 1 {
                                src_coord[1] = src_dim_diff / 2;
                                src_coord[2] = src_dim_diff;
                            }

                            let mut test_case = CaseData {
                                dst: TargetDesc {
                                    target: dst_target,
                                    width: dst_image_dimension,
                                    height: dst_image_dimension,
                                    level: dst_level,
                                    internal_format: dst_internal_format,
                                    format: dst_format,
                                    type_: dst_type,
                                },
                                dst_x: dst_coord[n_dst_coords - 1],
                                dst_y: dst_coord[n_dst_coords - 1],
                                src: TargetDesc {
                                    target: src_target,
                                    width: src_image_dimension,
                                    height: src_image_dimension,
                                    level: src_level,
                                    internal_format: src_internal_format,
                                    format: src_format,
                                    type_: src_type,
                                },
                                src_x: src_coord[0],
                                src_y: src_coord[0],
                                width: region_dimension,
                                height: region_dimension,
                            };
                            self.test_cases.push(test_case);

                            // Whole image, for non 7x7
                            if dst_image_dimension == src_image_dimension && IMAGE_DIMENSIONS[0] != dst_image_dimension
                            {
                                test_case.dst_x = 0;
                                test_case.dst_y = 0;
                                test_case.src_x = 0;
                                test_case.src_y = 0;
                                test_case.width = dst_image_dimension;
                                test_case.height = dst_image_dimension;
                                self.test_cases.push(test_case);
                            }
                        }
                    }
                }
            }
        }
    }

    /// `FunctionalTest::copyAndVerify`
    fn copy_and_verify(
        context: &Context,
        res: &Resources,
        test_case: &CaseData,
        dst_pixels: &Levels,
        src_pixels: &Levels,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut region_depth: GLuint = 1;
        let mut dst_layer_step: GLuint = 0;
        let is_dst_multi_layer = is_target_multilayer(test_case.dst.target);
        let is_src_multi_layer = is_target_multilayer(test_case.src.target);
        let mut src_layer_step: GLuint = 0;
        let mut n_layers: GLuint = 1;

        if is_dst_multi_layer || is_src_multi_layer {
            if is_src_multi_layer == is_dst_multi_layer {
                // Both objects are multilayered, copy all layers at once, verify at once
                region_depth = N_LAYERS;
            } else if is_dst_multi_layer {
                // Destination is multilayered, copy each layer separetly, verify at once
                n_layers = N_LAYERS;
                dst_layer_step = 1;
            } else {
                // Source is multilayered, copy and verify each layer separetly
                n_layers = N_LAYERS;
                src_layer_step = 1;
            }
        }

        let mut dst_layer: GLuint = 0;
        let mut src_layer: GLuint = 0;

        for _layer in 0..n_layers {
            // SAFETY: copies between names this test case created, on the current context.
            unsafe {
                if res.rb_name == 0 {
                    gl.copy_image_sub_data(
                        res.src_tex_name,
                        test_case.src.target,
                        test_case.src.level as GLint,
                        test_case.src_x as GLint,
                        test_case.src_y as GLint,
                        src_layer as GLint,
                        res.dst_tex_name,
                        test_case.dst.target,
                        test_case.dst.level as GLint,
                        test_case.dst_x as GLint,
                        test_case.dst_y as GLint,
                        dst_layer as GLint,
                        test_case.width as GLint,
                        test_case.height as GLint,
                        region_depth as GLint,
                    );
                } else {
                    // Copy from src to rb and from rb to dst; src and rb differ only in the target
                    gl.copy_image_sub_data(
                        res.src_tex_name,
                        glw::GL_TEXTURE_2D,
                        test_case.src.level as GLint,
                        test_case.src_x as GLint,
                        test_case.src_y as GLint,
                        src_layer as GLint,
                        res.rb_name,
                        test_case.src.target,
                        test_case.src.level as GLint,
                        test_case.src_x as GLint,
                        test_case.src_y as GLint,
                        src_layer as GLint,
                        test_case.width as GLint,
                        test_case.height as GLint,
                        region_depth as GLint,
                    );
                    gl.copy_image_sub_data(
                        res.rb_name,
                        test_case.src.target,
                        test_case.src.level as GLint,
                        test_case.src_x as GLint,
                        test_case.src_y as GLint,
                        src_layer as GLint,
                        res.dst_tex_name,
                        test_case.dst.target,
                        test_case.dst.level as GLint,
                        test_case.dst_x as GLint,
                        test_case.dst_y as GLint,
                        dst_layer as GLint,
                        test_case.width as GLint,
                        test_case.height as GLint,
                        region_depth as GLint,
                    );
                }
            }

            // SAFETY: plain error query.
            let error = unsafe { gl.get_error() };
            let mut result = false;
            if error == glw::GL_NO_ERROR {
                result = Self::verify(
                    context,
                    res,
                    test_case,
                    dst_layer,
                    dst_pixels,
                    src_layer,
                    src_pixels,
                    region_depth,
                )?;
            }

            if error != glw::GL_NO_ERROR || !result {
                log::info!(
                    "Failure. Targets src: {:#x}, dst: {:#x}. Levels src: {}, dst: {}. Dimmensions src [{}, {}], dst [{}, {}]. Region [{} x {} x {region_depth}] from [{}, {}, {src_layer}] to [{}, {}, {dst_layer}]. Format src: {:#x}, dst: {:#x}",
                    test_case.src.target,
                    test_case.dst.target,
                    test_case.src.level,
                    test_case.dst.level,
                    test_case.src.width,
                    test_case.src.height,
                    test_case.dst.width,
                    test_case.dst.height,
                    test_case.width,
                    test_case.height,
                    test_case.src_x,
                    test_case.src_y,
                    test_case.dst_x,
                    test_case.dst_y,
                    test_case.src.internal_format,
                    test_case.dst.internal_format
                );
                if error != glw::GL_NO_ERROR {
                    log::info!("Failed due to error: {}", glw::error_name(error));
                    return Err(TestError::Fail("Copy operation failed".to_string()));
                }
                return Ok(false);
            }

            dst_layer += dst_layer_step;
            src_layer += src_layer_step;
        }
        Ok(true)
    }

    /// `FunctionalTest::verify`
    #[allow(clippy::too_many_arguments)]
    fn verify(
        context: &Context,
        res: &Resources,
        test_case: &CaseData,
        dst_layer: GLuint,
        dst_pixels: &Levels,
        src_layer: GLuint,
        src_pixels: &Levels,
        depth: GLuint,
    ) -> Result<bool, TestError> {
        let is_dst_multi_level = is_target_multilevel(test_case.dst.target);
        let is_src_multi_level = is_target_multilevel(test_case.src.target);
        let dst_level = test_case.dst.level;
        let dst_pixel_size = get_pixel_size_for_format(test_case.dst.internal_format) as usize;
        let mut src_desc = test_case.src;
        let src_level = src_desc.level;
        let src_pixel_size = get_pixel_size_for_format(src_desc.internal_format) as usize;

        if res.rb_name != 0 {
            src_desc.target = glw::GL_TEXTURE_2D;
        }

        let (dst_widths, dst_heights, dst_depths) = calculate_dimensions(
            test_case.dst.target,
            dst_level,
            test_case.dst.width,
            test_case.dst.height,
        );
        let (src_widths, src_heights, src_depths) =
            calculate_dimensions(src_desc.target, src_level, src_desc.width, src_desc.height);

        // Level 0 is the biggest one.
        let mut dst_level_data =
            vec![0u8; dst_widths[0] as usize * dst_heights[0] as usize * dst_pixel_size * dst_depths[0] as usize];
        let mut src_level_data =
            vec![0u8; src_widths[0] as usize * src_heights[0] as usize * src_pixel_size * src_depths[0] as usize];

        // Check if source image was not modified
        let n_levels = if is_src_multi_level { N_LEVELS } else { 1 };
        for level in 0..n_levels {
            get_pixels(
                context,
                res.src_tex_name,
                &src_desc,
                level as GLuint,
                &mut src_level_data,
            )?;

            for layer in 0..src_depths[level] {
                if !compare_images(
                    &src_desc,
                    &src_pixels[level],
                    0,
                    0,
                    layer,
                    level as GLuint,
                    &src_desc,
                    &src_level_data,
                    0,
                    0,
                    layer,
                    level as GLuint,
                    src_widths[level],
                    src_heights[level],
                ) {
                    log::info!("CopyImageSubData modified contents of source image. Original data: left.");
                    return Ok(false);
                }
            }
        }

        // Check if contents of destination at levels != dst_level were not modified
        let n_levels = if is_dst_multi_level { N_LEVELS } else { 1 };
        for level in 0..n_levels {
            if dst_level as usize == level {
                continue;
            }

            get_pixels(
                context,
                res.dst_tex_name,
                &test_case.dst,
                level as GLuint,
                &mut dst_level_data,
            )?;

            for layer in 0..dst_depths[level] {
                if !compare_images(
                    &test_case.dst,
                    &dst_pixels[level],
                    0,
                    0,
                    layer,
                    level as GLuint,
                    &test_case.dst,
                    &dst_level_data,
                    0,
                    0,
                    layer,
                    level as GLuint,
                    dst_widths[level],
                    dst_heights[level],
                ) {
                    log::info!("CopyImageSubData modified contents of wrong mipmap level. Original data: left.");
                    return Ok(false);
                }
            }
        }

        // Check contents of modified level
        get_pixels(
            context,
            res.dst_tex_name,
            &test_case.dst,
            dst_level,
            &mut dst_level_data,
        )?;

        // Check anything after dst_layer + depth
        for layer in dst_layer + depth..dst_depths[dst_level as usize] {
            if !compare_images(
                &test_case.dst,
                &dst_pixels[dst_level as usize],
                0,
                0,
                layer,
                dst_level,
                &test_case.dst,
                &dst_level_data,
                0,
                0,
                layer,
                dst_level,
                dst_widths[dst_level as usize],
                dst_heights[dst_level as usize],
            ) {
                log::info!("CopyImageSubData modified contents of wrong layer. Original data: left.");
                return Ok(false);
            }
        }

        // Check modified layers
        for layer in 0..depth {
            // Check contents outside of copied region
            for [x, y, w, h] in get_clean_regions(test_case, dst_level) {
                if !compare_images(
                    &test_case.dst,
                    &dst_pixels[dst_level as usize],
                    x,
                    y,
                    layer + dst_layer,
                    dst_level,
                    &test_case.dst,
                    &dst_level_data,
                    x,
                    y,
                    layer + dst_layer,
                    dst_level,
                    w,
                    h,
                ) {
                    log::info!("CopyImageSubData modified contents outside of copied region. Original data: left.");
                    return Ok(false);
                }
            }

            // Check contents of copied region
            if !compare_images(
                &test_case.dst,
                &dst_level_data,
                test_case.dst_x,
                test_case.dst_y,
                layer + dst_layer,
                dst_level,
                &src_desc,
                &src_pixels[src_level as usize],
                test_case.src_x,
                test_case.src_y,
                layer + src_layer,
                src_level,
                test_case.width,
                test_case.height,
            ) {
                log::info!("CopyImageSubData stored invalid data in copied region. Destination data: left.");
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// One iteration of upstream's `iterate`, up to and including the clean-up
    fn run_test_case(context: &Context, test_case: &CaseData) -> Result<bool, TestError> {
        let mut res = Resources::default();
        let result = Self::run_with_resources(context, &mut res, test_case);
        res.clean(context);
        result
    }

    fn run_with_resources(context: &Context, res: &mut Resources, test_case: &CaseData) -> Result<bool, TestError> {
        let dst_pixels = prepare_dst_pxls(&test_case.dst);
        let src_pixels = prepare_src_pxls(&test_case.src);

        res.dst_tex_name = prepare_functional_texture(context, &test_case.dst, &dst_pixels, &mut res.dst_buf_name)?;
        if test_case.src.target == glw::GL_RENDERBUFFER {
            let mut desc = test_case.src;
            desc.target = glw::GL_TEXTURE_2D;
            res.rb_name = prepare_functional_texture(context, &test_case.src, &src_pixels, &mut res.src_buf_name)?;
            res.src_tex_name = prepare_functional_texture(context, &desc, &src_pixels, &mut res.src_buf_name)?;
        } else {
            res.src_tex_name = prepare_functional_texture(context, &test_case.src, &src_pixels, &mut res.src_buf_name)?;
        }

        Self::copy_and_verify(context, res, test_case, &dst_pixels, &src_pixels)
    }
}

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        for test_case in &self.test_cases {
            // SAFETY: pixel store state on the current context.
            unsafe {
                gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
            }
            glu::expect_no_error(gl, "PixelStorei")?;

            if !Self::run_test_case(context, test_case)? {
                log::info!("Failure. ");
                return Ok(TestStatus::fail("Fail"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}
