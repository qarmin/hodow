// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcPackedPixelsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported - the group is registered by the KHR-GL roots only, so `isContextTypeES` is always false: the ES tables (`esInternalformats`, `esFormats`, `esTypes`, `esValidFormats`, the two extension tables) and every ES branch of `isFormatValid`, `isCopyValid`, `isFBOImageAttachValid`, `readOutputData` and `getCanonicalFormat` are left out. The desktop tables are generated from the C++ by `scripts/gen_khr_packed_pixels_tables.py` (`generated::khr_packed_pixels_tables`). `RectangleTest` and its two subclasses are one `RectangleTestCase` with a `Kind`; the members that change while a case runs live in `rectangle::RectangleTest`, created by `iterate`. The debug counters (`m_countReadPixels` and friends, only printed under `LOG_PACKED_PIXELS_STATISTICS`) are not carried over.

pub mod pack;
mod rectangle;

use crate::generated::khr_packed_pixels_tables::{CORE_FORMATS, CORE_INTERNALFORMATS};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{TestOutcome, TestStatus};

pub const GRADIENT_WIDTH: i32 = 7;
pub const GRADIENT_HEIGHT: i32 = 3;

/// `InternalFormatSamplerType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Sampler {
    Unorm,
    Norm,
    Uint,
    Int,
    Float,
}

/// `ComponentFormat`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ComponentFormat {
    Stencil,
    Depth,
    DepthStencil,
    Color,
    ColorInteger,
}

/// `TypeStorage`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum TypeStorage {
    Unsigned,
    Signed,
    Float,
}

/// `InternalFormatFlag`
pub const FLAG_PACKED: u32 = 1;
pub const FLAG_COMPRESSED: u32 = 2;
pub const FLAG_REQ_RBO_GL42: u32 = 4;
pub const FLAG_REQ_RBO_ES30: u32 = 8;
pub const FLAG_REQ_RBO: u32 = FLAG_REQ_RBO_GL42 | FLAG_REQ_RBO_ES30;

/// `PixelType`; `bits` is the `InternalFormatBits` array: red, green, blue, alpha, intensity, luminance, depth, stencil, exponent.
#[derive(Clone, Copy)]
pub struct PixelType {
    pub type_: GLenum,
    pub size: i32,
    pub storage: TypeStorage,
    pub special: bool,
    pub reversed: bool,
    pub bits: [i32; 9],
    pub clamp: bool,
}

/// `PixelFormat`; `component_order` is zero based element order, -1 for N/A, in the same order as `PixelType::bits`.
#[derive(Clone, Copy)]
pub struct PixelFormat {
    pub name: &'static str,
    pub format: GLenum,
    pub components: i32,
    pub component_format: ComponentFormat,
    pub attachment: GLenum,
    pub component_order: [i32; 9],
}

/// `InternalFormat`, with the case name `PackedPixelsTests::init` derives from `sizedFormat`.
#[derive(Clone, Copy)]
pub struct InternalFormat {
    pub name: &'static str,
    pub sized_format: GLenum,
    pub base_format: GLenum,
    pub format: GLenum,
    pub type_: GLenum,
    pub sampler: Sampler,
    pub bits: [i32; 9],
    pub flags: u32,
}

/// `EnumFormats`
pub struct EnumFormats {
    pub internalformat: GLenum,
    pub format: GLenum,
    pub type_: GLenum,
    pub size: i32,
    pub renderable: bool,
}

/// `FloatPixel` - holds both float and integer pixel data, in the order r, g, b, a, d, s. Upstream reads it as an array of 18 four-byte slots: the six ints, the six uints, the six floats.
#[derive(Clone, Copy, Default)]
pub struct FloatPixel {
    pub i: [i32; 6],
    pub ui: [u32; 6],
    pub f: [f32; 6],
}

/// `PackedPixelsBufferProperties`
#[derive(Clone, Copy, Default)]
pub struct PackedPixelsBufferProperties {
    pub elements_in_group: i32,
    pub row_length: i32,
    pub alignment: i32,
    pub element_size: i32,
    pub elements_in_row: i32,
    pub elements_in_row_no_align: i32,
    pub row_count: i32,
    pub images_count: i32,
    pub skip_pixels: i32,
    pub skip_rows: i32,
    pub skip_images: i32,
    pub swap_bytes: i32,
    pub lsb_first: i32,
}

/// Which of `RectangleTest`, `PBORectangleTest` and `VariedRectangleTest` a case is.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    Rectangle,
    Pbo,
    Varied,
}

/// `RectangleTest` and its two subclasses
struct RectangleTestCase {
    name: String,
    internal_format: &'static InternalFormat,
    input_format: &'static PixelFormat,
    kind: Kind,
}

impl TestCase for RectangleTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        rectangle::iterate(context, self.internal_format, self.input_format, self.kind)
    }
}

/// `InitialValuesTest`
struct InitialValuesTest;

impl TestCase for InitialValuesTest {
    fn name(&self) -> &str {
        "initial_values"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut result = true;

        let common_int_modes: [GLenum; 8] = [
            glw::GL_UNPACK_ROW_LENGTH,
            glw::GL_UNPACK_SKIP_ROWS,
            glw::GL_UNPACK_SKIP_PIXELS,
            glw::GL_UNPACK_IMAGE_HEIGHT,
            glw::GL_UNPACK_SKIP_IMAGES,
            glw::GL_PACK_ROW_LENGTH,
            glw::GL_PACK_SKIP_ROWS,
            glw::GL_PACK_SKIP_PIXELS,
        ];

        // SAFETY: one GLint (or GLboolean) out per call.
        unsafe {
            // check if following eight storage modes are 0
            let mut i: glw::GLint = 1;
            for mode in common_int_modes {
                gl.get_integerv(mode, &mut i);
                result &= i == 0;
            }

            // check if following two storage modes are 4
            gl.get_integerv(glw::GL_UNPACK_ALIGNMENT, &mut i);
            result &= i == 4;
            gl.get_integerv(glw::GL_PACK_ALIGNMENT, &mut i);
            result &= i == 4;

            // check storage modes available only in core GL: the four boolean modes are false
            let mut b: glw::GLboolean = glw::TRUE;
            for mode in [
                glw::GL_UNPACK_SWAP_BYTES,
                glw::GL_UNPACK_LSB_FIRST,
                glw::GL_PACK_SWAP_BYTES,
                glw::GL_PACK_LSB_FIRST,
            ] {
                gl.get_booleanv(mode, &mut b);
                result &= b == glw::FALSE;
            }

            // check if following two modes are 0
            gl.get_integerv(glw::GL_PACK_IMAGE_HEIGHT, &mut i);
            result &= i == 0;
            gl.get_integerv(glw::GL_PACK_SKIP_IMAGES, &mut i);
            result &= i == 0;

            // make sure that no pack/unpack buffers are bound
            gl.get_integerv(glw::GL_PIXEL_PACK_BUFFER_BINDING, &mut i);
            result &= i == 0;
            gl.get_integerv(glw::GL_PIXEL_UNPACK_BUFFER_BINDING, &mut i);
            result &= i == 0;
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `PackedPixelsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("packed_pixels");

    let mut rectangle_group = TestCaseGroup::new("rectangle");
    rectangle_group.add_child(Box::new(InitialValuesTest) as Box<dyn TestCase>);
    let mut pbo_rectangle_group = TestCaseGroup::new("pbo_rectangle");
    let mut varied_rectangle_group = TestCaseGroup::new("varied_rectangle");

    for internal_format in &CORE_INTERNALFORMATS {
        // addRectangleTests<T>
        for (target, kind) in [
            (&mut rectangle_group, Kind::Rectangle),
            (&mut pbo_rectangle_group, Kind::Pbo),
            (&mut varied_rectangle_group, Kind::Varied),
        ] {
            for input_format in &CORE_FORMATS {
                target.add_child(Box::new(RectangleTestCase {
                    name: format!("{}_format_{}", internal_format.name, input_format.name),
                    internal_format,
                    input_format,
                    kind,
                }) as Box<dyn TestCase>);
            }
        }
    }

    group.add_child(rectangle_group);
    group.add_child(pbo_rectangle_group);
    group.add_child(varied_rectangle_group);
    group
}
