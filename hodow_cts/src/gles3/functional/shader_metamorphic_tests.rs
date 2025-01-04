// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderMetamorphicTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2018 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream reads the GraphicsFuzz shaders out of the
// test archive (`graphicsfuzz/...`); they are copied verbatim into `hodow_cts/data/graphicsfuzz/`
// (with their LICENSE) and `include_str!`d, so the binary needs no data files at run time.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

/// `Box<dyn TestCase>`, which `add_child` needs (it does not unsize a `Box<Concrete>` itself).
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

const MAX_RENDER_WIDTH: i32 = 256;
const MAX_RENDER_HEIGHT: i32 = 256;

type SanityCheckFunc = fn(&ConstPixelBufferAccess<'_>) -> bool;

const VERTEX_SHADER: &str = include_str!("../../../data/graphicsfuzz/vertexShader.glsl");

/// `ShaderMetamorphicVariant`: renders a recipient shader and a variant of it and compares
/// the images; each fragment shader is rendered a second time to catch non-determinism.
struct ShaderMetamorphicVariant {
    name: &'static str,
    recipient_src: &'static str,
    variant_src: &'static str,
    sanity_check: SanityCheckFunc,
}

/// `ShaderMetamorphicVariant::render`
fn render(context: &Context, img: &mut Surface, vertex_src: &str, fragment_src: &str) -> Result<(), TestError> {
    let gl = context.gl();

    // Positions, shared between shaders
    const POSITIONS: [f32; 8] = [
        -1.0, 1.0, // top-left
        -1.0, -1.0, // bottom-left
        1.0, -1.0, // bottom-right
        1.0, 1.0, // top-right
    ];

    const INDICES: [u16; 6] = [
        0, 1, 2, // bottom-left triangle
        0, 3, 2, // top-right triangle
    ];

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_src, fragment_src));
    if !program.is_ok() {
        return Err(TestError::InternalError("Compile failed".to_string()));
    }

    // Set uniforms expected in GraphicsFuzz generated programs
    // SAFETY: a program this function built; every location is checked before use.
    unsafe {
        gl.use_program(program.program());
        // Uniform: injectionSwitch
        let loc = gl.get_uniform_location(program.program(), c"injectionSwitch".as_ptr());
        if loc != -1 {
            gl.uniform_2f(loc, 0.0, 1.0);
        }
        // Uniform: resolution
        let loc = gl.get_uniform_location(program.program(), c"resolution".as_ptr());
        if loc != -1 {
            gl.uniform_2f(loc, img.get_width() as f32, img.get_height() as f32);
        }
        // Uniform: mouse
        let loc = gl.get_uniform_location(program.program(), c"mouse".as_ptr());
        if loc != -1 {
            gl.uniform_2f(loc, 0.0, 0.0);
        }
        // Uniform: time
        let loc = gl.get_uniform_location(program.program(), c"time".as_ptr());
        if loc != -1 {
            gl.uniform_1f(loc, 0.0);
        }
    }

    let pos_binding = glu::va::float("coord2d", 2, 6, 0, &POSITIONS);
    glu::draw(
        &context.render_context,
        program.program(),
        &[pos_binding],
        &glu::pr::triangles(&INDICES),
    )?;
    glu::read_pixels(&context.render_context, 0, 0, &mut img.get_access())?;
    glu::expect_no_error(gl, "Draw")
}

/// `ShaderMetamorphicVariant::checkNondet`
fn check_nondet(context: &Context, ref_img: &Surface, vertex_src: &str, fragment_src: &str) -> Result<(), TestError> {
    let mut img = Surface::new(ref_img.get_width(), ref_img.get_height());

    render(context, &mut img, vertex_src, fragment_src)?;
    if !pixel_threshold_compare(&img, ref_img, RGBA::new(0, 0, 0, 0)).ok {
        return Err(TestError::Fail("Nondeterministic rendering".to_string()));
    }
    Ok(())
}

impl TestCase for ShaderMetamorphicVariant {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_target = context.render_target();
        let threshold = RGBA::new(1, 1, 1, 1) + render_target.pixel_format().get_color_threshold();
        let width = render_target.width.min(MAX_RENDER_WIDTH);
        let height = render_target.height.min(MAX_RENDER_HEIGHT);
        let mut recipient_img = Surface::new(width, height);
        let mut variant_img = Surface::new(width, height);

        render(context, &mut recipient_img, VERTEX_SHADER, self.recipient_src)?;
        render(context, &mut variant_img, VERTEX_SHADER, self.variant_src)?;

        check_nondet(context, &recipient_img, VERTEX_SHADER, self.recipient_src)?;
        check_nondet(context, &variant_img, VERTEX_SHADER, self.variant_src)?;

        if !(self.sanity_check)(&recipient_img.get_const_access()) {
            return Err(TestError::Fail("Quick check fails on recipient".to_string()));
        }

        let is_ok = pixel_threshold_compare(&recipient_img, &variant_img, threshold).ok;
        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

/// `SanityPixel` - a reference pixel (relative position and colour) for quick checking.
struct SanityPixel {
    x_relative: f32,
    y_relative: f32,
    rgba: [f32; 4],
}

/// `sanityComparePixels`
fn sanity_compare_pixels(img: &ConstPixelBufferAccess<'_>, sanity_pixels: &[SanityPixel]) -> bool {
    let threshold = [0.01f32; 4];
    let [width, height, _] = img.size();

    for san_pix in sanity_pixels {
        let x = (width as f32 * san_pix.x_relative) as u32;
        let y = (height as f32 * san_pix.y_relative) as u32;
        let rgba = img.get_pixel(x, y, 0);
        for j in 0..4 {
            if (rgba[j] - san_pix.rgba[j]).abs() >= threshold[j] {
                return false;
            }
        }
    }
    true
}

/// `sanityCheck_synthetic`
fn sanity_check_synthetic(img: &ConstPixelBufferAccess<'_>) -> bool {
    sanity_compare_pixels(
        img,
        &[SanityPixel {
            x_relative: 0.5,
            y_relative: 0.5,
            rgba: [0.0, 1.0, 1.0, 1.0],
        }],
    )
}

/// `sanityCheck_bubblesort_flag`
fn sanity_check_bubblesort_flag(img: &ConstPixelBufferAccess<'_>) -> bool {
    sanity_compare_pixels(
        img,
        &[
            SanityPixel {
                x_relative: 0.25,
                y_relative: 0.25,
                rgba: [0.1, 0.6, 1.0, 1.0],
            },
            SanityPixel {
                x_relative: 0.25,
                y_relative: 0.75,
                rgba: [1.0, 0.5, 0.1, 1.0],
            },
            SanityPixel {
                x_relative: 0.75,
                y_relative: 0.25,
                rgba: [0.6, 1.0, 0.1, 1.0],
            },
            SanityPixel {
                x_relative: 0.75,
                y_relative: 0.75,
                rgba: [0.5, 0.1, 1.0, 1.0],
            },
        ],
    )
}

/// `ShaderMetamorphicShaderset::init` for one set of variants.
fn shaderset(
    name: &str,
    recipient_src: &'static str,
    variants: &[(&'static str, &'static str)],
    sanity_check: SanityCheckFunc,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &(variant_name, variant_src) in variants {
        group.add_child(boxed(ShaderMetamorphicVariant {
            name: variant_name,
            recipient_src,
            variant_src,
            sanity_check,
        }));
    }
    group
}

/// `ShaderMetamorphicTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("metamorphic");

    group.add_child(shaderset(
        "synthetic",
        include_str!("../../../data/graphicsfuzz/synthetic/recipient.frag"),
        &[
            (
                "variant_1",
                include_str!("../../../data/graphicsfuzz/synthetic/variant_1.frag"),
            ),
            (
                "variant_2",
                include_str!("../../../data/graphicsfuzz/synthetic/variant_2.frag"),
            ),
            (
                "variant_3",
                include_str!("../../../data/graphicsfuzz/synthetic/variant_3.frag"),
            ),
            (
                "variant_4",
                include_str!("../../../data/graphicsfuzz/synthetic/variant_4.frag"),
            ),
        ],
        sanity_check_synthetic,
    ));

    group.add_child(shaderset(
        "bubblesort_flag",
        include_str!("../../../data/graphicsfuzz/bubblesort_flag/recipient.frag"),
        &[
            (
                "variant_1",
                include_str!("../../../data/graphicsfuzz/bubblesort_flag/variant_1.frag"),
            ),
            (
                "variant_2",
                include_str!("../../../data/graphicsfuzz/bubblesort_flag/variant_2.frag"),
            ),
        ],
        sanity_check_bubblesort_flag,
    ));

    group
}
