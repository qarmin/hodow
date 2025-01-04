// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.cpp  (VertexArrayTest, MultiVertexArrayTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `MultiVertexArrayTest` as a registered `glu::TestCase`: it draws the same arrays through a
// real `sglr::GLContext` and a software `sglr::ReferenceContext` and compares the two images.
// Upstream's two `iterate()` calls (draw, then compare) collapse into one. `VertexArrayTest`
// is its base class and nothing else uses it, so its `init`/`deinit`/`compare` live here.
//
// Narrowings: no `tcu::TestLog`; the reference context is always single sample; a failed
// `GLU_EXPECT_NO_ERROR` is an `Err(String)` out of `ContextArrayPack::render`.

use super::array::{InputType, OutputType, Primitive, Storage, Target, Usage};
use super::context_array_pack::ContextArrayPack;
use super::gl_value::GLValue;
use super::random_array_generator::{generate_per_quad, generate_quads};
use crate::gls::reference_context_buffers::create_reference_context;
use crate::glu::{Context, TestCase};
use crate::sglr::gl_context::GLContext;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::compare_threshold;
use crate::tcu::{RGBA, Surface, TestOutcome, TestResult, TestStatus};

/// `MultiVertexArrayTest::Spec::ArraySpec`
#[derive(Debug, Clone, Copy)]
pub struct ArraySpec {
    pub input_type: InputType,
    pub output_type: OutputType,
    pub storage: Storage,
    pub usage: Usage,
    pub component_count: i32,
    pub offset: i32,
    pub stride: i32,
    pub normalize: bool,
    pub min: GLValue,
    pub max: GLValue,
}

impl ArraySpec {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        input_type: InputType,
        output_type: OutputType,
        storage: Storage,
        usage: Usage,
        component_count: i32,
        offset: i32,
        stride: i32,
        normalize: bool,
        min: GLValue,
        max: GLValue,
    ) -> Self {
        Self {
            input_type,
            output_type,
            storage,
            usage,
            component_count,
            offset,
            stride,
            normalize,
            min,
            max,
        }
    }
}

/// `MultiVertexArrayTest::Spec`
#[derive(Debug, Clone)]
pub struct Spec {
    pub primitive: Primitive,
    pub draw_count: i32,
    pub first: i32,
    pub arrays: Vec<ArraySpec>,
}

impl Spec {
    /// `Spec::Spec` - `primitive` is `PRIMITIVE_LAST` upstream until the caller sets it, which
    /// every caller does straight away.
    pub fn new(primitive: Primitive, draw_count: i32, first: i32) -> Self {
        Self {
            primitive,
            draw_count,
            first,
            arrays: Vec::new(),
        }
    }

    /// `Spec::getName`
    pub fn get_name(&self) -> String {
        let mut name = String::new();

        for (ndx, array) in self.arrays.iter().enumerate() {
            if self.arrays.len() > 1 {
                name.push_str(&format!("array{ndx}_"));
            }

            name.push_str(&format!(
                "{}_{}_{}_{}",
                array.storage.to_str(),
                array.offset,
                array.stride,
                array.input_type.to_str()
            ));

            if array.input_type != InputType::UnsignedInt2_10_10_10 && array.input_type != InputType::Int2_10_10_10 {
                name.push_str(&array.component_count.to_string());
            }

            name.push('_');
            if array.normalize {
                name.push_str("normalized_");
            }
            name.push_str(array.output_type.to_str());
            name.push('_');
            name.push_str(array.usage.to_str());
            name.push('_');
        }

        if self.first != 0 {
            name.push_str(&format!("first{}_", self.first));
        }

        match self.primitive {
            Primitive::Triangles => name.push_str("quads_"),
            Primitive::Points => name.push_str("points_"),
            _ => unreachable!("Spec::getName: unsupported primitive"),
        }

        name.push_str(&self.draw_count.to_string());
        name
    }
}

/// `MultiVertexArrayTest`
pub struct MultiVertexArrayTest {
    name: String,
    spec: Spec,
}

impl MultiVertexArrayTest {
    #[allow(clippy::new_ret_no_self)]
    pub fn new(spec: Spec, name: &str) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.to_string(),
            spec,
        })
    }

    /// `MultiVertexArrayTest::isUnalignedBufferOffsetTest`
    fn is_unaligned_buffer_offset_test(&self) -> bool {
        // Buffer offsets should be data type size aligned
        self.spec
            .arrays
            .iter()
            .any(|array| array.storage == Storage::Buffer && array.offset % Self::data_type_size(array.input_type) != 0)
    }

    /// `MultiVertexArrayTest::isUnalignedBufferStrideTest`
    fn is_unaligned_buffer_stride_test(&self) -> bool {
        // Buffer strides should be data type size aligned
        self.spec
            .arrays
            .iter()
            .any(|array| array.storage == Storage::Buffer && array.stride % Self::data_type_size(array.input_type) != 0)
    }

    fn data_type_size(input_type: InputType) -> i32 {
        let packed = matches!(input_type, InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10);
        if packed { 4 } else { input_type.size() }
    }

    fn unaligned_warning(&self) -> Option<TestStatus> {
        if self.is_unaligned_buffer_offset_test() {
            Some(TestStatus::new(
                TestResult::CompatibilityWarning,
                "Failed to draw with unaligned buffers.",
            ))
        } else if self.is_unaligned_buffer_stride_test() {
            Some(TestStatus::new(
                TestResult::CompatibilityWarning,
                "Failed to draw with unaligned stride.",
            ))
        } else {
            None
        }
    }
}

/// `VertexArrayTest::compare`
fn compare_images(reference: &Surface, screen: &Surface, max_diff: [i32; 3], num_samples: i32) -> bool {
    if num_samples > 1 {
        // \todo [mika] Improve compare when using multisampling
        return fuzzy_compare_ok(&reference.get_const_access(), &screen.get_const_access(), 1.5).unwrap_or(false);
    }

    let threshold = RGBA::new(max_diff[0], max_diff[1], max_diff[2], 255);
    let mut is_ok = true;

    for y in 0..reference.get_height() {
        for x in 0..reference.get_width() {
            let ref_pixel = reference.get_pixel(x, y);
            let screen_pixel = screen.get_pixel(x, y);
            let mut is_ok_pixel = false;

            if y == 0 || y + 1 == reference.get_height() || x == 0 || x + 1 == reference.get_width() {
                // Don't check borders since the pixel neighborhood is undefined
                continue;
            }

            // Don't do comparisons for this pixel if it belongs to a one-pixel-thin part (i.e. it doesn't have
            // similar-color neighbors in both x and y directions) in both result and reference.
            // This fixes some false negatives.
            let ref_thin = (!compare_threshold(ref_pixel, reference.get_pixel(x - 1, y), threshold)
                && !compare_threshold(ref_pixel, reference.get_pixel(x + 1, y), threshold))
                || (!compare_threshold(ref_pixel, reference.get_pixel(x, y - 1), threshold)
                    && !compare_threshold(ref_pixel, reference.get_pixel(x, y + 1), threshold));

            let screen_thin = (!compare_threshold(screen_pixel, screen.get_pixel(x - 1, y), threshold)
                && !compare_threshold(screen_pixel, screen.get_pixel(x + 1, y), threshold))
                || (!compare_threshold(screen_pixel, screen.get_pixel(x, y - 1), threshold)
                    && !compare_threshold(screen_pixel, screen.get_pixel(x, y + 1), threshold));

            if ref_thin && screen_thin {
                is_ok_pixel = true;
            } else {
                'search: for dy in -1..2 {
                    for dx in -1..2 {
                        // Check reference pixel against screen pixel
                        {
                            let screen_cmp = screen.get_pixel(x + dx, y + dy);
                            let r = (ref_pixel.get_red() - screen_cmp.get_red()).abs();
                            let g = (ref_pixel.get_green() - screen_cmp.get_green()).abs();
                            let b = (ref_pixel.get_blue() - screen_cmp.get_blue()).abs();
                            if r <= max_diff[0] && g <= max_diff[1] && b <= max_diff[2] {
                                is_ok_pixel = true;
                                break 'search;
                            }
                        }

                        // Check screen pixels against reference pixel
                        {
                            let ref_cmp = reference.get_pixel(x + dx, y + dy);
                            let r = (ref_cmp.get_red() - screen_pixel.get_red()).abs();
                            let g = (ref_cmp.get_green() - screen_pixel.get_green()).abs();
                            let b = (ref_cmp.get_blue() - screen_pixel.get_blue()).abs();
                            if r <= max_diff[0] && g <= max_diff[1] && b <= max_diff[2] {
                                is_ok_pixel = true;
                                break 'search;
                            }
                        }
                    }
                }
            }

            if !is_ok_pixel {
                is_ok = false;
            }
        }
    }

    is_ok
}

impl TestCase for MultiVertexArrayTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();
        let render_target_width = rt.width.min(512);
        let render_target_height = rt.height.min(512);

        // `VertexArrayTest::VertexArrayTest`
        let max_diff = |bits: i32| (256.0f32 * (2.0f32 / (1i32 << bits) as f32)).ceil() as i32;
        let max_diff_rgb = [max_diff(rt.red_bits), max_diff(rt.green_bits), max_diff(rt.blue_bits)];

        // `VertexArrayTest::init`
        let mut gl_ctx = GLContext::new(
            &context.render_context,
            (0, 0, render_target_width, render_target_height),
        );
        let mut rr_ctx = create_reference_context(context, render_target_width, render_target_height, 0)?;
        let mut gl_pack = ContextArrayPack::new(context.context_type(), rt.width, rt.height);
        let mut rr_pack = ContextArrayPack::new(context.context_type(), rt.width, rt.height);

        let spec = &self.spec;
        // in non-indexed draw Triangles means rectangles
        let primitive_size: i32 = if spec.primitive == Primitive::Triangles { 6 } else { 1 };
        let mut coord_scale: f32;
        let mut color_scale = 1.0f32;
        let use_vao = false;

        // Color and Coord scale
        {
            // First array is always position
            {
                let array_spec = &spec.arrays[0];
                if array_spec.input_type == InputType::UnsignedInt2_10_10_10 {
                    coord_scale = if array_spec.normalize {
                        1.0
                    } else {
                        (1.0f64 / 1024.0) as f32
                    };
                } else if array_spec.input_type == InputType::Int2_10_10_10 {
                    coord_scale = if array_spec.normalize {
                        1.0
                    } else {
                        (1.0f64 / 512.0) as f32
                    };
                } else {
                    coord_scale = if array_spec.normalize && !array_spec.input_type.is_float_type() {
                        1.0
                    } else {
                        (0.9f64 / f64::from(array_spec.max.to_float())) as f32
                    };
                }

                if matches!(
                    array_spec.output_type,
                    OutputType::Vec3
                        | OutputType::Vec4
                        | OutputType::IVec3
                        | OutputType::IVec4
                        | OutputType::UVec3
                        | OutputType::UVec4
                ) {
                    coord_scale *= 0.5;
                }
            }

            // And other arrays are color-like
            for array_spec in spec.arrays.iter().skip(1) {
                let unit = if array_spec.normalize && !array_spec.input_type.is_float_type() {
                    1.0f32
                } else {
                    (1.0f64 / f64::from(array_spec.max.to_float())) as f32
                };
                color_scale *= unit;

                if array_spec.output_type == OutputType::Vec4 {
                    color_scale *= unit;
                }
            }
        }

        // Data
        for (array_ndx, array_spec) in spec.arrays.iter().enumerate() {
            let seed = array_spec.input_type as i32
                + 10 * array_spec.output_type as i32
                + 100 * array_spec.storage as i32
                + 1000 * spec.primitive as i32
                + 10000 * array_spec.usage as i32
                + spec.draw_count
                + 12 * array_spec.component_count
                + array_spec.stride
                + array_spec.normalize as i32;
            let seed = seed as u32;

            let stride = if array_spec.stride == 0 {
                array_spec.component_count * array_spec.input_type.size()
            } else {
                array_spec.stride
            };
            let buffer_size = array_spec.offset
                + stride * (spec.draw_count * primitive_size - 1)
                + array_spec.component_count * array_spec.input_type.size();

            // Snap values to at least 3x3 grid
            let grid_size = 3.0f32 / ((rt.width.min(rt.height) - 1) as f32);

            let data: Vec<u8> = match spec.primitive {
                Primitive::Triangles => {
                    if array_ndx == 0 {
                        generate_quads(
                            seed,
                            spec.draw_count,
                            array_spec.component_count,
                            array_spec.offset,
                            array_spec.stride,
                            spec.primitive,
                            array_spec.input_type,
                            array_spec.min,
                            array_spec.max,
                            grid_size,
                        )
                    } else {
                        debug_assert_eq!(array_spec.offset, 0); // \note [jarkko] it just hasn't been implemented
                        generate_per_quad(
                            seed,
                            spec.draw_count,
                            array_spec.component_count,
                            array_spec.stride,
                            spec.primitive,
                            array_spec.input_type,
                            array_spec.min,
                            array_spec.max,
                        )
                    }
                }
                _ => unreachable!("MultiVertexArrayTest: only PRIMITIVE_TRIANGLES is generated"),
            };
            let bytes = &data[..(buffer_size as usize).min(data.len())];

            gl_pack.new_array(&mut gl_ctx, array_spec.storage);
            rr_pack.new_array(&mut rr_ctx, array_spec.storage);

            gl_pack
                .array_mut(array_ndx)
                .data(&mut gl_ctx, Target::Array, bytes, array_spec.usage);
            rr_pack
                .array_mut(array_ndx)
                .data(&mut rr_ctx, Target::Array, bytes, array_spec.usage);

            gl_pack.array_mut(array_ndx).bind(
                array_ndx as i32,
                array_spec.offset,
                array_spec.component_count,
                array_spec.input_type,
                array_spec.output_type,
                array_spec.normalize,
                array_spec.stride,
            );
            rr_pack.array_mut(array_ndx).bind(
                array_ndx as i32,
                array_spec.offset,
                array_spec.component_count,
                array_spec.input_type,
                array_spec.output_type,
                array_spec.normalize,
                array_spec.stride,
            );
        }

        let render_result = gl_pack
            .render(
                &mut gl_ctx,
                spec.primitive,
                spec.first,
                spec.draw_count * primitive_size,
                use_vao,
                coord_scale,
                color_scale,
            )
            .and_then(|()| {
                rr_pack.render(
                    &mut rr_ctx,
                    spec.primitive,
                    spec.first,
                    spec.draw_count * primitive_size,
                    use_vao,
                    coord_scale,
                    color_scale,
                )
            });

        let outcome = match render_result {
            // GL Errors are ok if the mode is not properly aligned
            Err(message) => match self.unaligned_warning() {
                Some(status) => Ok(status),
                None => Ok(TestStatus::fail(message)),
            },
            Ok(()) => {
                if compare_images(rr_pack.surface(), gl_pack.surface(), max_diff_rgb, rt.num_samples) {
                    Ok(TestStatus::pass("Pass"))
                } else {
                    match self.unaligned_warning() {
                        Some(status) => Ok(status),
                        None => Ok(TestStatus::fail("Image comparison failed.")),
                    }
                }
            }
        };

        gl_pack.destroy(&mut gl_ctx);
        rr_pack.destroy(&mut rr_ctx);
        outcome
    }
}
