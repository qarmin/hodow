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
// Modifications: rewritten in Rust for hodow_cts; see `mod.rs`. `RectangleTest` and what it inherits for `PBORectangleTest` and `VariedRectangleTest` is `RectangleTest` here, created per `iterate` so the members that change during a run are plain fields.

use super::pack::{
    Element, F32Uint248Rev, Unpack, clamp_signed_value, clamp_unsigned_value, get_bits, get_real_bit_precision,
    order_components_float, order_components_int, order_components_uint, pack_float_32_unsigned_int_24_8_rev,
    pack_normalized, pack_packed, pack_unsigned_int_5_9_9_9_rev, pack_unsigned_int_10f_11f_11f_rev,
    pack_unsigned_int_24_8, packed_layout, unpack_for_type,
};
use super::{
    ComponentFormat, FLAG_COMPRESSED, FLAG_REQ_RBO, FloatPixel, GRADIENT_HEIGHT, GRADIENT_WIDTH, InternalFormat, Kind,
    PackedPixelsBufferProperties, PixelFormat, PixelType, Sampler, TypeStorage,
};
use crate::generated::khr_packed_pixels_tables::{CORE_FORMATS, CORE_INTERNALFORMATS, CORE_TYPES, CORE_VALID_FORMATS};
use crate::glu::{self, Context};
use crate::glw::{self, GLenum};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `InputOutputOperation`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Operation {
    OutputGetTexImage,
    OutputReadPixels,
    InputTexImage,
}

const DEFAULT_FILL_VALUE: u8 = 0xaa;

/// `getPixelFormat`
fn get_pixel_format(format: GLenum) -> Result<&'static PixelFormat, TestError> {
    CORE_FORMATS
        .iter()
        .find(|candidate| candidate.format == format)
        .ok_or_else(|| TestError::Fail("Unsuported format.".to_string()))
}

/// `getPixelType`
fn get_pixel_type(type_: GLenum) -> Result<&'static PixelType, TestError> {
    CORE_TYPES
        .iter()
        .find(|candidate| candidate.type_ == type_)
        .ok_or_else(|| TestError::Fail("Unsuported type.".to_string()))
}

/// `getCanonicalFormat`
fn get_canonical_format(
    internalformat: &InternalFormat,
    format: GLenum,
    type_: GLenum,
) -> Option<&'static super::EnumFormats> {
    CORE_VALID_FORMATS.iter().find(|candidate| {
        candidate.internalformat == internalformat.sized_format
            && candidate.format == format
            && candidate.type_ == type_
    })
}

/// `getSampler`
fn get_sampler(type_: &PixelType, format: &PixelFormat) -> Sampler {
    match type_.storage {
        TypeStorage::Float => Sampler::Float,
        TypeStorage::Unsigned => {
            if format.component_format == ComponentFormat::ColorInteger
                || format.component_format == ComponentFormat::Stencil
            {
                Sampler::Uint
            } else {
                Sampler::Unorm
            }
        }
        TypeStorage::Signed => {
            if format.component_format == ComponentFormat::ColorInteger {
                Sampler::Int
            } else {
                Sampler::Norm
            }
        }
    }
}

/// `isUnsizedFormat`
fn is_unsized_format(format: GLenum) -> bool {
    [
        glw::GL_RGBA,
        glw::GL_RGB,
        glw::GL_LUMINANCE,
        glw::GL_LUMINANCE_ALPHA,
        glw::GL_ALPHA,
    ]
    .contains(&format)
}

/// `swapBytes` - reverses the bytes of every element of `type_size` bytes.
fn swap_bytes(type_size: i32, data_buffer: &mut [u8]) -> Result<(), TestError> {
    match type_size {
        1 => {} // no swapping
        2 => {
            for pair in data_buffer.chunks_exact_mut(2) {
                pair.reverse();
            }
        }
        // typeSize is 2 x 32bit, behaves the same this time
        4 | 8 => {
            for word in data_buffer.chunks_exact_mut(4) {
                word.reverse();
            }
        }
        _ => return Err(TestError::Fail("Invalid size for swapBytes".to_string())),
    }
    Ok(())
}

/// `stripBuffer` - extracts pixel data from a buffer with specific pixel store configuration into a flat buffer. `None` is upstream's `false`.
fn strip_buffer(props: &PackedPixelsBufferProperties, original_buffer: &[u8], validate: bool) -> Option<Vec<u8>> {
    let new_buffer_size = props.element_size * props.elements_in_row_no_align * GRADIENT_HEIGHT;
    if new_buffer_size == 0 {
        return None;
    }
    let mut new_buffer = vec![0u8; usize::try_from(new_buffer_size).ok()?];

    let skip_bottom =
        ((props.skip_images * props.row_count + props.skip_rows) * props.elements_in_row) * props.element_size;
    let skip_top = (props.row_count - GRADIENT_HEIGHT - props.skip_rows) * props.elements_in_row * props.element_size;
    let skip_left = props.skip_pixels * props.elements_in_group * props.element_size;
    let skip_right =
        (props.elements_in_row - GRADIENT_WIDTH * props.elements_in_group) * props.element_size - skip_left;
    let copy = GRADIENT_WIDTH * props.elements_in_group * props.element_size;
    let skip_align = (props.elements_in_row - props.elements_in_row_no_align) * props.element_size;

    // A byte outside the buffer is a failed strip, where upstream reads past the end.
    let at = |index: i32| -> Option<u8> {
        usize::try_from(index)
            .ok()
            .and_then(|index| original_buffer.get(index).copied())
    };

    if validate {
        for i in 0..skip_bottom {
            if at(i)? != DEFAULT_FILL_VALUE {
                return None;
            }
        }
    }

    let mut index_src = skip_bottom;
    let mut index_dst = 0;
    for _ in 0..GRADIENT_HEIGHT {
        if validate {
            for i in 0..skip_left {
                if at(index_src + i)? != DEFAULT_FILL_VALUE {
                    return None;
                }
            }
        }
        index_src += skip_left;

        for k in 0..copy {
            new_buffer[(index_dst + k) as usize] = at(index_src + k)?;
        }
        index_src += copy;
        index_dst += copy;

        if validate {
            for i in skip_align..skip_right {
                if at(index_src + i)? != DEFAULT_FILL_VALUE {
                    return None;
                }
            }
        }
        index_src += skip_right;
    }

    if validate {
        for i in 0..skip_top {
            if at(index_src + i)? != DEFAULT_FILL_VALUE {
                return None;
            }
        }
    }
    Some(new_buffer)
}

/// `makeBuffer<Type>`
fn make_buffer<T: Element>(
    gradient: &[u8],
    format: &PixelFormat,
    sampler_is_int_uint_float: i32,
    element_count: usize,
    component_count: usize,
    type_: GLenum,
) -> Vec<FloatPixel> {
    let mut result = Vec::with_capacity(element_count);
    for i in 0..element_count {
        let mut values = [0.0f32; 4];
        let mut values_int = [0i32; 4];
        let mut values_uint = [0u32; 4];
        for j in 0..component_count {
            let source = T::get(&gradient[(component_count * i + j) * T::SIZE..]);
            match sampler_is_int_uint_float {
                1 => values_int[j] = source.to_i32(),
                2 => values_uint[j] = source.to_u32(),
                3 => values[j] = pack_normalized(type_, source),
                _ => {}
            }
        }
        result.push(match sampler_is_int_uint_float {
            1 => order_components_int(values_int, format),
            2 => order_components_uint(values_uint, format),
            3 => order_components_float(values, format),
            _ => FloatPixel::default(),
        });
    }
    result
}

/// `makeBufferPackedInt` / `Uint` / `Float` for the types `packed_layout` knows: `element_size` bytes per word.
fn make_buffer_packed(
    gradient: &[u8],
    format: &PixelFormat,
    sampler_is_int_uint_float: i32,
    element_count: usize,
    element_size: usize,
    layout: &[super::pack::PackedField],
) -> Vec<FloatPixel> {
    (0..element_count)
        .map(|i| {
            let word = &gradient[i * element_size..];
            let value = match element_size {
                1 => u32::from(u8::get(word)),
                2 => u32::from(u16::get(word)),
                _ => u32::get(word),
            };
            let (floats, uints, ints) = pack_packed(layout, value);
            match sampler_is_int_uint_float {
                1 => order_components_int(ints, format),
                2 => order_components_uint(uints, format),
                3 => order_components_float(floats, format),
                _ => FloatPixel::default(),
            }
        })
        .collect()
}

/// `makeBufferPackedFloat` for the types that only have a float flavour.
fn make_buffer_packed_float<T: Element>(
    gradient: &[u8],
    format: &PixelFormat,
    element_count: usize,
    pack: impl Fn(T) -> [f32; 4],
) -> Vec<FloatPixel> {
    (0..element_count)
        .map(|i| order_components_float(pack(T::get(&gradient[i * T::SIZE..])), format))
        .collect()
}

/// `getFloatBuffer`
fn get_float_buffer(
    gradient: &[u8],
    sampler_is_int_uint_float: i32,
    format: &PixelFormat,
    type_: &PixelType,
    element_count: usize,
) -> Result<Vec<FloatPixel>, TestError> {
    let component_count = format.components as usize;
    let sampler = sampler_is_int_uint_float;
    Ok(match type_.type_ {
        glw::GL_UNSIGNED_BYTE => {
            make_buffer::<u8>(gradient, format, sampler, element_count, component_count, type_.type_)
        }
        glw::GL_BYTE => make_buffer::<i8>(gradient, format, sampler, element_count, component_count, type_.type_),
        glw::GL_UNSIGNED_SHORT | glw::GL_HALF_FLOAT => {
            make_buffer::<u16>(gradient, format, sampler, element_count, component_count, type_.type_)
        }
        glw::GL_SHORT => make_buffer::<i16>(gradient, format, sampler, element_count, component_count, type_.type_),
        glw::GL_UNSIGNED_INT => {
            make_buffer::<u32>(gradient, format, sampler, element_count, component_count, type_.type_)
        }
        glw::GL_INT => make_buffer::<i32>(gradient, format, sampler, element_count, component_count, type_.type_),
        glw::GL_FLOAT => make_buffer::<f32>(gradient, format, sampler, element_count, component_count, type_.type_),
        glw::GL_UNSIGNED_INT_24_8 => {
            make_buffer_packed_float::<u32>(gradient, format, element_count, pack_unsigned_int_24_8)
        }
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => {
            make_buffer_packed_float::<u32>(gradient, format, element_count, pack_unsigned_int_10f_11f_11f_rev)
        }
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => {
            make_buffer_packed_float::<u32>(gradient, format, element_count, pack_unsigned_int_5_9_9_9_rev)
        }
        glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => make_buffer_packed_float::<F32Uint248Rev>(
            gradient,
            format,
            element_count,
            pack_float_32_unsigned_int_24_8_rev,
        ),
        other => {
            let layout = packed_layout(other).ok_or_else(|| TestError::Fail("Unsuported type".to_string()))?;
            make_buffer_packed(gradient, format, sampler, element_count, type_.size as usize, layout)
        }
    })
}

/// `RectangleTest`
pub struct RectangleTest<'a> {
    context: &'a Context,
    internal_format: InternalFormat,
    use_pbo: bool,
    texture_target: GLenum,
    initial_pack_properties: PackedPixelsBufferProperties,
    initial_unpack_properties: PackedPixelsBufferProperties,
    gradient: Vec<u8>,
    input_format: PixelFormat,
    input_type: PixelType,
    copy_internal_format: InternalFormat,
    pack_properties: PackedPixelsBufferProperties,
    unpack_properties: PackedPixelsBufferProperties,
    output_buffer: Vec<u8>,
}

/// `RectangleTest::iterate`, `VariedRectangleTest::iterate`
pub fn iterate(
    context: &Context,
    internal_format: &InternalFormat,
    input_format: &PixelFormat,
    kind: Kind,
) -> TestOutcome {
    let mut test = RectangleTest {
        context,
        internal_format: *internal_format,
        use_pbo: kind == Kind::Pbo,
        texture_target: glw::GL_TEXTURE_2D,
        initial_pack_properties: PackedPixelsBufferProperties::default(),
        initial_unpack_properties: PackedPixelsBufferProperties::default(),
        gradient: Vec::new(),
        input_format: *input_format,
        input_type: CORE_TYPES[0],
        copy_internal_format: *internal_format,
        pack_properties: PackedPixelsBufferProperties::default(),
        unpack_properties: PackedPixelsBufferProperties::default(),
        output_buffer: Vec::new(),
    };

    let pass = if kind == Kind::Varied {
        test.iterate_varied()?
    } else {
        test.reset_initial_storage_modes();
        test.test_all_formats_and_types()?
    };
    Ok(if pass {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

impl RectangleTest<'_> {
    /// `resetInitialStorageModes`
    fn reset_initial_storage_modes(&mut self) {
        for properties in [&mut self.initial_pack_properties, &mut self.initial_unpack_properties] {
            properties.skip_pixels = 0;
            properties.skip_rows = 0;
            properties.row_length = 0;
            properties.alignment = 4;
            properties.row_count = 0;
            properties.skip_images = 0;
            properties.lsb_first = 0;
            properties.swap_bytes = 0;
        }
    }

    /// `applyInitialStorageModes`
    fn apply_initial_storage_modes(&mut self) {
        let gl = self.context.gl();
        let up = self.initial_unpack_properties;
        let pp = self.initial_pack_properties;

        self.unpack_properties = up;
        self.pack_properties = pp;

        // SAFETY: plain state setters.
        unsafe {
            gl.pixel_storei(glw::GL_PACK_ROW_LENGTH, pp.row_length);
            gl.pixel_storei(glw::GL_PACK_SKIP_ROWS, pp.skip_rows);
            gl.pixel_storei(glw::GL_PACK_SKIP_PIXELS, pp.skip_pixels);
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, pp.alignment);

            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, up.row_length);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, up.skip_rows);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, up.skip_pixels);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, up.alignment);
            gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, up.row_count);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, up.skip_images);

            gl.pixel_storei(glw::GL_PACK_IMAGE_HEIGHT, pp.row_count);
            gl.pixel_storei(glw::GL_PACK_SKIP_IMAGES, pp.skip_images);
            gl.pixel_storei(glw::GL_PACK_SWAP_BYTES, pp.swap_bytes);
            gl.pixel_storei(glw::GL_PACK_LSB_FIRST, pp.lsb_first);
            gl.pixel_storei(glw::GL_UNPACK_SWAP_BYTES, up.swap_bytes);
            gl.pixel_storei(glw::GL_UNPACK_LSB_FIRST, up.lsb_first);
        }
    }

    /// `createGradient`
    fn create_gradient(&mut self) -> Result<(), TestError> {
        match unpack_for_type(self.input_type.type_)? {
            Unpack::U8(unpack) => self.make_gradient::<u8>(unpack),
            Unpack::I8(unpack) => self.make_gradient::<i8>(unpack),
            Unpack::U16(unpack) => self.make_gradient::<u16>(unpack),
            Unpack::I16(unpack) => self.make_gradient::<i16>(unpack),
            Unpack::U32(unpack) => self.make_gradient::<u32>(unpack),
            Unpack::I32(unpack) => self.make_gradient::<i32>(unpack),
            Unpack::F32(unpack) => self.make_gradient::<f32>(unpack),
            Unpack::Pair(unpack) => self.make_gradient::<F32Uint248Rev>(unpack),
        }
        Ok(())
    }

    /// `makeGradient<Type>`
    fn make_gradient<T: Element>(&mut self, unpack: fn(f32) -> T) {
        // number of elements in a group
        let mut elements_in_group = self.input_format.components;
        if self.input_type.special {
            elements_in_group = 1;
        }

        let mut row_count = self.unpack_properties.row_count;
        if row_count == 0 {
            row_count = GRADIENT_HEIGHT + self.unpack_properties.skip_rows;
        }

        // number of groups in the row
        let mut row_length = self.unpack_properties.row_length;
        if row_length == 0 {
            row_length = GRADIENT_WIDTH + self.unpack_properties.skip_pixels;
        }

        let element_size = self.input_type.size;

        // row size (in elements)
        let elements_in_row_no_align = elements_in_group * row_length;
        let mut elements_in_row = elements_in_row_no_align;
        if element_size < self.unpack_properties.alignment {
            let alignment = self.unpack_properties.alignment;
            elements_in_row = (alignment as f32
                * (((element_size * elements_in_group * row_length) as f32) / (alignment as f32)).ceil())
                as i32
                / element_size;
        }

        if self.texture_target == glw::GL_TEXTURE_2D {
            self.unpack_properties.skip_images = 0;
        }

        // "depth" will be 1 + skipped image layers. We still want to work on a 2D-ish image later.
        let depth = 1 + self.unpack_properties.skip_images;

        self.unpack_properties.elements_in_group = elements_in_group;
        self.unpack_properties.row_count = row_count;
        self.unpack_properties.row_length = row_length;
        self.unpack_properties.element_size = element_size;
        self.unpack_properties.elements_in_row_no_align = elements_in_row_no_align;
        self.unpack_properties.elements_in_row = elements_in_row;
        self.unpack_properties.images_count = depth;

        // element size * elements in row * number of rows * number of 2d images
        let buffer_size = (element_size * elements_in_row * row_count * depth) as usize;
        self.gradient.clear();
        self.gradient.resize(buffer_size, 0);

        let data_to_skip = (self.unpack_properties.skip_images * row_count * elements_in_row) as usize;
        let mut index = data_to_skip;

        let default_value = unpack(0.5);
        for element in 0..data_to_skip {
            default_value.put(&mut self.gradient[element * T::SIZE..]);
        }

        let up = self.unpack_properties;
        for k in up.skip_images..depth {
            for j in 0..row_count {
                for i in 0..elements_in_row {
                    let x = i / elements_in_group;
                    let value = if k == depth - 1
                        && up.skip_rows <= j
                        && j < up.skip_rows + GRADIENT_HEIGHT
                        && up.skip_pixels <= x
                        && x < up.skip_pixels + GRADIENT_WIDTH
                    {
                        let mut value = (x - up.skip_pixels) as f32 / GRADIENT_WIDTH as f32;
                        let channel = i - elements_in_group * x;
                        value *= 1.0 - 0.25 * channel as f32;
                        unpack(value)
                    } else {
                        default_value
                    };
                    value.put(&mut self.gradient[index * T::SIZE..]);
                    index += 1;
                }
            }
        }
    }

    /// `isFormatValid` - desktop branch. `checkInput` and `checkOutput` only steer the ES branch and are not parameters.
    fn is_format_valid(
        &self,
        format: &PixelFormat,
        type_: &PixelType,
        internalformat: &InternalFormat,
        operation: Operation,
    ) -> bool {
        let context_info = &self.context.context_info;
        let is_depth_or_stencil =
            |f: GLenum| f == glw::GL_DEPTH_STENCIL || f == glw::GL_STENCIL_INDEX || f == glw::GL_DEPTH_COMPONENT;

        if format.format == glw::GL_DEPTH_STENCIL
            && type_.type_ != glw::GL_UNSIGNED_INT_24_8
            && type_.type_ != glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV
        {
            return false;
        }

        if format.component_format == ComponentFormat::ColorInteger
            && (type_.type_ == glw::GL_FLOAT || type_.type_ == glw::GL_HALF_FLOAT)
        {
            return false;
        }

        if is_depth_or_stencil(internalformat.base_format) != is_depth_or_stencil(format.format) {
            return false;
        }

        if operation == Operation::InputTexImage {
            if format.format == glw::GL_STENCIL_INDEX || internalformat.base_format == glw::GL_STENCIL_INDEX {
                return false;
            }

            if (format.format == glw::GL_DEPTH_COMPONENT || format.format == glw::GL_DEPTH_STENCIL)
                && !(internalformat.base_format == glw::GL_DEPTH_STENCIL
                    || internalformat.base_format == glw::GL_DEPTH_COMPONENT)
            {
                return false;
            }
        } else if operation == Operation::OutputGetTexImage {
            if format.format == glw::GL_STENCIL_INDEX
                && ((internalformat.base_format != glw::GL_STENCIL_INDEX
                    && internalformat.base_format != glw::GL_DEPTH_STENCIL)
                    || !context_info.is_extension_supported("GL_ARB_texture_stencil8"))
            {
                return false;
            }

            if format.format == glw::GL_DEPTH_STENCIL && internalformat.base_format != glw::GL_DEPTH_STENCIL {
                return false;
            }
        } else if operation == Operation::OutputReadPixels {
            if format.format == glw::GL_DEPTH_STENCIL && internalformat.base_format != glw::GL_DEPTH_STENCIL {
                return false;
            }

            if format.format == glw::GL_DEPTH_COMPONENT
                && internalformat.base_format != glw::GL_DEPTH_STENCIL
                && internalformat.base_format != glw::GL_DEPTH_COMPONENT
            {
                return false;
            }

            if format.format == glw::GL_STENCIL_INDEX
                && internalformat.base_format != glw::GL_DEPTH_STENCIL
                && internalformat.base_format != glw::GL_STENCIL_INDEX
            {
                return false;
            }
        }

        if type_.special {
            let valid = CORE_VALID_FORMATS
                .iter()
                .any(|candidate| candidate.format == format.format && candidate.type_ == type_.type_);
            if !valid {
                return false;
            }
        }

        if format.component_format == ComponentFormat::ColorInteger
            && !(internalformat.sampler == Sampler::Int || internalformat.sampler == Sampler::Uint)
        {
            return false;
        }

        if format.component_format != ComponentFormat::ColorInteger
            && (internalformat.sampler == Sampler::Int || internalformat.sampler == Sampler::Uint)
        {
            return false;
        }

        if self.texture_target == glw::GL_TEXTURE_3D
            && (internalformat.base_format == glw::GL_DEPTH_COMPONENT
                || internalformat.base_format == glw::GL_DEPTH_STENCIL
                || internalformat.sized_format == glw::GL_COMPRESSED_RED_RGTC1
                || internalformat.sized_format == glw::GL_COMPRESSED_SIGNED_RED_RGTC1
                || internalformat.sized_format == glw::GL_COMPRESSED_RG_RGTC2
                || internalformat.sized_format == glw::GL_COMPRESSED_SIGNED_RG_RGTC2)
        {
            return false;
        }

        true
    }

    /// `isCopyValid` - desktop branch: core GL is less restricted than ES and returns before the ES checks.
    fn is_copy_valid(
        &self,
        copy_internal_format: &InternalFormat,
        internal_format: &InternalFormat,
    ) -> Result<bool, TestError> {
        // check if copy between two internal formats is allowed
        let b1 = get_pixel_format(internal_format.format)?.components;
        let b2 = get_pixel_format(copy_internal_format.format)?.components;
        if b2 > b1 {
            return Ok(false);
        }

        // Check that the types can be converted in CopyTexImage.
        let copy_sampler = copy_internal_format.sampler;
        let sampler = internal_format.sampler;
        if (copy_sampler == Sampler::Uint && sampler != Sampler::Uint)
            || (copy_sampler == Sampler::Int && sampler != Sampler::Int)
            || ((copy_sampler == Sampler::Float || sampler == Sampler::Unorm || copy_sampler == Sampler::Norm)
                && !(copy_sampler == Sampler::Float || sampler == Sampler::Unorm || sampler == Sampler::Norm))
        {
            return Ok(false);
        }

        if (copy_internal_format.format == glw::GL_DEPTH_COMPONENT && internal_format.format != glw::GL_DEPTH_COMPONENT)
            || (copy_internal_format.format == glw::GL_DEPTH_STENCIL && internal_format.format != glw::GL_DEPTH_STENCIL)
            || (copy_internal_format.format == glw::GL_ALPHA && internal_format.format != glw::GL_ALPHA)
            || (copy_internal_format.format == glw::GL_LUMINANCE && internal_format.format != glw::GL_LUMINANCE)
            || (copy_internal_format.format == glw::GL_LUMINANCE_ALPHA
                && internal_format.format != glw::GL_LUMINANCE_ALPHA)
        {
            return Ok(false);
        }
        Ok(true)
    }

    /// `isFBOImageAttachValid` - desktop branch
    fn is_fbo_image_attach_valid(&self, internalformat: &InternalFormat, format: GLenum) -> bool {
        if format == glw::GL_DEPTH_STENCIL
            && internalformat.sized_format != glw::GL_DEPTH24_STENCIL8
            && internalformat.sized_format != glw::GL_DEPTH32F_STENCIL8
        {
            // We can't make a complete DEPTH_STENCIL attachment with a texture that does not have both DEPTH and STENCIL components.
            return false;
        }

        let color_renderable_formats = [
            glw::GL_RGBA32F,
            glw::GL_RGBA32I,
            glw::GL_RGBA32UI,
            glw::GL_RGBA16,
            glw::GL_RGBA16F,
            glw::GL_RGBA16I,
            glw::GL_RGBA16UI,
            glw::GL_RGBA8,
            glw::GL_RGBA8I,
            glw::GL_RGBA8UI,
            glw::GL_SRGB8_ALPHA8,
            glw::GL_RGB10_A2,
            glw::GL_RGB10_A2UI,
            glw::GL_RGB5_A1,
            glw::GL_RGBA4,
            glw::GL_R11F_G11F_B10F,
            glw::GL_RGB565,
            glw::GL_RG32F,
            glw::GL_RG32I,
            glw::GL_RG32UI,
            glw::GL_RG16,
            glw::GL_RG16F,
            glw::GL_RG16I,
            glw::GL_RG16UI,
            glw::GL_RG8,
            glw::GL_RG8I,
            glw::GL_RG8UI,
            glw::GL_R32F,
            glw::GL_R32I,
            glw::GL_R32UI,
            glw::GL_R16F,
            glw::GL_R16I,
            glw::GL_R16UI,
            glw::GL_R16,
            glw::GL_R8,
            glw::GL_R8I,
            glw::GL_R8UI,
        ];
        if color_renderable_formats.contains(&internalformat.sized_format) {
            return true;
        }

        let ds_renderable_formats = [
            glw::GL_DEPTH_COMPONENT32F,
            glw::GL_DEPTH_COMPONENT24,
            glw::GL_DEPTH_COMPONENT16,
            glw::GL_DEPTH32F_STENCIL8,
            glw::GL_DEPTH24_STENCIL8,
        ];
        ds_renderable_formats.contains(&internalformat.sized_format)
    }

    /// `doRead`
    fn do_read(&mut self, texture: glw::GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let fbo = glu::Framebuffer::new(gl);

        // SAFETY: the framebuffer is the guard's own.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get()) };
        glu::expect_no_error(gl, "glBindFramebuffer")?;

        let valid_image_attach = self.is_fbo_image_attach_valid(&self.internal_format, self.input_format.format);

        // SAFETY: attaches the texture the caller made.
        let status = unsafe {
            if self.texture_target == glw::GL_TEXTURE_2D {
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    self.input_format.attachment,
                    glw::GL_TEXTURE_2D,
                    texture,
                    0,
                );
            } else {
                gl.framebuffer_texture_3d(
                    glw::GL_FRAMEBUFFER,
                    self.input_format.attachment,
                    glw::GL_TEXTURE_3D,
                    texture,
                    0,
                    0,
                );
            }
            gl.check_framebuffer_status(glw::GL_FRAMEBUFFER)
        };

        let mut result = true;
        if status == glw::GL_FRAMEBUFFER_COMPLETE {
            result &= self.read_pixels(false)?;
            result &= self.do_copy()?;
        } else if valid_image_attach {
            log::info!(
                "FBO is not complete but expected complete with sizedFormat: {}",
                self.internal_format.name
            );
            result = false;
        }

        Ok(result)
    }

    /// `readPixels`
    fn read_pixels(&mut self, is_copy: bool) -> Result<bool, TestError> {
        let mut result = true;

        // for each output format
        for output_format in &CORE_FORMATS {
            // for each output type
            for output_type in &CORE_TYPES {
                if is_copy {
                    // continue when input format,type != canonical format,type and output format,type != canonical format,type
                    if output_format.format != self.copy_internal_format.format
                        || output_type.type_ != self.copy_internal_format.type_
                    {
                        // invalid output format and type - skipping case
                        continue;
                    }
                } else if (self.input_format.format != self.internal_format.format
                    || self.input_type.type_ != self.internal_format.type_)
                    && (output_format.format != self.internal_format.format
                        || output_type.type_ != self.internal_format.type_)
                {
                    // invalid output format and type - skipping case
                    continue;
                }

                result &= self.read_pixels_inner(output_format, output_type, is_copy)?;
            }
        }
        Ok(result)
    }

    /// `readPixelsInner`
    fn read_pixels_inner(
        &mut self,
        output_format: &PixelFormat,
        output_type: &PixelType,
        is_copy: bool,
    ) -> Result<bool, TestError> {
        let copy_stage = "Copy stage: ";
        let stage = if is_copy { copy_stage } else { "" };

        let readerror = self.read_output_data(output_format, output_type, Operation::OutputReadPixels)?;

        if self.output_buffer.is_empty() {
            log::info!("No buffer allocated");
            return Ok(false);
        }

        // Check if output format is valid
        let internal_format = if is_copy {
            self.copy_internal_format
        } else {
            self.internal_format
        };
        let mut output_format_valid = self.is_format_valid(
            output_format,
            output_type,
            &internal_format,
            Operation::OutputReadPixels,
        );

        // Even if this is a valid glReadPixels format, we can't read non-existant components
        if output_format_valid
            && output_format.format == glw::GL_DEPTH_STENCIL
            && self.input_format.format != glw::GL_DEPTH_STENCIL
        {
            output_format_valid = false;
        }

        if output_format_valid {
            if readerror != glw::GL_NO_ERROR {
                log::info!(
                    "{stage}Valid format used but glReadPixels failed for input = [{}, {:#x}] output = [{}, {:#x}]",
                    self.input_format.name,
                    self.input_type.type_,
                    output_format.name,
                    output_type.type_
                );
                return Ok(false);
            }

            // compare output gradient to input gradient
            if !self.compare(&self.gradient, &self.output_buffer, output_format, output_type, is_copy)? {
                log::info!(
                    "{stage}Gradient comparison failed during ReadPixels for input = [{}, {:#x}] output = [{}, {:#x}]",
                    self.input_format.name,
                    self.input_type.type_,
                    output_format.name,
                    output_type.type_
                );
                return Ok(false);
            }
        } else if readerror == glw::GL_NO_ERROR {
            log::info!(
                "{stage}Invalid format used but glReadPixels succeeded for input = [{}, {:#x}] output = [{}, {:#x}]",
                self.input_format.name,
                self.input_type.type_,
                output_format.name,
                output_type.type_
            );
            return Ok(false);
        }
        Ok(true)
    }

    /// `readOutputData`
    fn read_output_data(
        &mut self,
        output_format: &PixelFormat,
        output_type: &PixelType,
        operation: Operation,
    ) -> Result<GLenum, TestError> {
        // If using PBOs buffer object for GL_PIXEL_PACK_BUFFER must be bound and not allocated before calling when using PBOs
        let gl = self.context.gl();

        let props = &mut self.pack_properties;

        props.element_size = output_type.size;
        props.elements_in_group = if output_type.special {
            1
        } else {
            output_format.components
        };
        props.row_length = if props.row_length == 0 {
            GRADIENT_WIDTH + props.skip_pixels
        } else {
            props.row_length
        };
        props.elements_in_row_no_align = props.elements_in_group * props.row_length;
        props.elements_in_row = props.elements_in_row_no_align;

        if operation == Operation::OutputReadPixels || self.texture_target == glw::GL_TEXTURE_2D {
            props.skip_images = 0;
        }

        if props.row_count == 0 {
            props.row_count = GRADIENT_HEIGHT + props.skip_rows;
        }

        props.images_count = props.skip_images + 1;

        if props.element_size < props.alignment {
            props.elements_in_row = (props.alignment as f32
                * ((props.element_size * props.elements_in_group * props.row_length) as f32 / props.alignment as f32)
                    .ceil()) as i32
                / props.element_size;
        }

        let buffer_size =
            props.element_size * props.elements_in_row * props.row_count * props.images_count * (props.skip_images + 1);

        // The output buffer allocated should be initialized to a known value. After a pack operation, any extra memory allocated for skipping should be verified to be the original known value, untouched by the GL.
        self.output_buffer.clear();
        self.output_buffer.resize(buffer_size as usize, DEFAULT_FILL_VALUE);

        let pack_pbo = self.use_pbo.then(|| glu::Buffer::new(gl));
        if let Some(pack_pbo) = &pack_pbo {
            // SAFETY: the buffer is the guard's own and `output_buffer` outlives the upload.
            unsafe {
                gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, pack_pbo.get());
                gl.buffer_data(
                    glw::GL_PIXEL_PACK_BUFFER,
                    buffer_size as isize,
                    self.output_buffer.as_ptr().cast(),
                    glw::GL_STATIC_READ,
                );
            }
        }

        let mut read_error = glw::GL_NO_ERROR;
        // With a PBO bound the pointer is an offset into it; otherwise it is the output buffer, which holds `buffer_size` bytes.
        let destination: *mut std::ffi::c_void = if self.use_pbo {
            std::ptr::null_mut()
        } else {
            self.output_buffer.as_mut_ptr().cast()
        };
        // SAFETY: see `destination`; the format and type are ones the test enumerates.
        unsafe {
            match operation {
                Operation::OutputGetTexImage => gl.get_tex_image(
                    self.texture_target,
                    0,
                    output_format.format,
                    output_type.type_,
                    destination,
                ),
                Operation::OutputReadPixels => {
                    if self.input_format.attachment != glw::GL_DEPTH_ATTACHMENT
                        && self.input_format.attachment != glw::GL_DEPTH_STENCIL_ATTACHMENT
                        && self.input_format.attachment != glw::GL_STENCIL_ATTACHMENT
                    {
                        gl.read_buffer(self.input_format.attachment);
                    }
                    read_error = gl.get_error();
                    if read_error == glw::GL_NO_ERROR {
                        gl.read_pixels(
                            0,
                            0,
                            GRADIENT_WIDTH,
                            GRADIENT_HEIGHT,
                            output_format.format,
                            output_type.type_,
                            destination,
                        );
                    }
                }
                Operation::InputTexImage => {}
            }
        }

        if read_error == glw::GL_NO_ERROR {
            // SAFETY: glGetError needs nothing but a current context.
            read_error = unsafe { gl.get_error() };
        }

        if pack_pbo.is_some() {
            if read_error == glw::GL_NO_ERROR {
                // SAFETY: the mapped range is `buffer_size` bytes of the pack buffer, copied into `output_buffer`, which is as large.
                unsafe {
                    let mapped_data =
                        gl.map_buffer_range(glw::GL_PIXEL_PACK_BUFFER, 0, buffer_size as isize, glw::GL_MAP_READ_BIT);
                    if mapped_data.is_null() {
                        return Ok(glw::GL_INVALID_INDEX);
                    }
                    std::ptr::copy_nonoverlapping(
                        mapped_data.cast::<u8>(),
                        self.output_buffer.as_mut_ptr(),
                        buffer_size as usize,
                    );
                    gl.unmap_buffer(glw::GL_PIXEL_PACK_BUFFER);
                }
            }
            // SAFETY: unbinds; the guard deletes the buffer.
            unsafe { gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, 0) };
        }

        if self.pack_properties.swap_bytes != 0 && read_error == glw::GL_NO_ERROR {
            swap_bytes(output_type.size, &mut self.output_buffer)?;
        }

        Ok(read_error)
    }

    /// `doCopy`
    fn do_copy(&mut self) -> Result<bool, TestError> {
        let mut result = true;

        if self.input_format.format == self.internal_format.format
            && self.input_type.type_ == self.internal_format.type_
        {
            for copy_internal_format in &CORE_INTERNALFORMATS {
                self.copy_internal_format = *copy_internal_format;
                result &= self.do_copy_inner()?;
            }
        }
        Ok(result)
    }

    /// `doCopyInner`
    fn do_copy_inner(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result = true;

        let copy_internal_format = self.copy_internal_format;
        let copy_format_enum = get_canonical_format(
            &copy_internal_format,
            copy_internal_format.format,
            copy_internal_format.type_,
        );

        if let Some(copy_format_enum) = copy_format_enum {
            let valid_copy = self.is_copy_valid(&copy_internal_format, &self.internal_format)?;

            let texture2 = glu::Texture::new(gl);
            // Target is always GL_TEXTURE_2D
            // SAFETY: the texture is the guard's own.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture2.get()) };

            // CopyTexImage to copy_internalformat (GL converts, but PixelStore is ignored)
            // SAFETY: a copy from the read framebuffer into the bound texture.
            let error = unsafe {
                let _ = gl.get_error();
                gl.copy_tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    copy_internal_format.sized_format,
                    0,
                    0,
                    GRADIENT_WIDTH,
                    GRADIENT_HEIGHT,
                    0,
                );
                gl.get_error()
            };

            // if this combination of copy_internalformat,internalformat is invalid
            if !valid_copy {
                // expect error and continue
                if error == glw::GL_NO_ERROR {
                    log::info!("Invalid format used but glCopyTexImage2D succeeded");
                    result = false;
                }
            } else if error != glw::GL_NO_ERROR {
                log::info!("Valid format used but glCopyTexImage2D failed");
                result = false;
            } else {
                // if GetTexImage is supported we call the inner function only as no loop needed
                let output_format = get_pixel_format(copy_format_enum.format)?;
                let output_type = get_pixel_type(copy_format_enum.type_)?;
                result &= self.get_tex_image_inner(output_format, output_type)?;

                let mut orginal_fbo_id: glw::GLint = 0;
                // SAFETY: one GLint out.
                unsafe { gl.get_integerv(glw::GL_DRAW_FRAMEBUFFER_BINDING, &mut orginal_fbo_id) };
                glu::expect_no_error(gl, "getIntegerv")?;

                let fbo = glu::Framebuffer::new(gl);
                // SAFETY: the framebuffer is the guard's own.
                unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get()) };

                let valid_image_attach = self.is_fbo_image_attach_valid(&copy_internal_format, copy_format_enum.format);

                // attach copy_internalformat texture to FBO. Target is always GL_TEXTURE_2D
                let copy_format = get_pixel_format(copy_format_enum.format)?;
                // SAFETY: attaches the texture made above.
                unsafe {
                    gl.framebuffer_texture_2d(
                        glw::GL_FRAMEBUFFER,
                        copy_format.attachment,
                        glw::GL_TEXTURE_2D,
                        texture2.get(),
                        0,
                    )
                };
                glu::expect_no_error(gl, "glFramebufferTexture2D")?;

                // SAFETY: a status query.
                let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
                glu::expect_no_error(gl, "glCheckFramebufferStatus")?;

                // if an unsized sizedFormat was given, then implementation chosen copy format destination might be different than what's expected; we cannot continue checking since ReadPixels might not choose a compatible format, also the format may not be renderable as expected
                if is_unsized_format(copy_internal_format.sized_format) {
                    result &= true;
                } else if status == glw::GL_FRAMEBUFFER_COMPLETE {
                    if valid_image_attach {
                        result &= self.read_pixels(true)?;
                    } else {
                        log::info!(
                            "Copy FBO is complete but expected incomplete with sizedFormat {}, attachement {}",
                            copy_internal_format.name,
                            copy_format.attachment
                        );
                        result = false;
                    }
                } else if valid_image_attach {
                    log::info!(
                        "Copy FBO is not complete but expected complete with sizedFormat {}, attachement {}",
                        copy_internal_format.name,
                        copy_format.attachment
                    );
                    result = false;
                }

                // bind original FBO
                // SAFETY: restores the binding queried above; the guard deletes the framebuffer.
                unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, orginal_fbo_id as u32) };
            }
        }
        Ok(result)
    }

    /// `compare` - compares the reference gradient data to the output data
    fn compare(
        &self,
        gradient: &[u8],
        data: &[u8],
        output_format: &PixelFormat,
        output_type: &PixelType,
        is_copy: bool,
    ) -> Result<bool, TestError> {
        let mut iformat_sampler = self.internal_format.sampler;
        let output_sampler = get_sampler(output_type, output_format);
        let input_sampler = get_sampler(&self.input_type, &self.input_format);

        if is_copy {
            iformat_sampler = self.copy_internal_format.sampler;
        }

        let sampler_is_int_uint_float = match self.internal_format.sampler {
            Sampler::Int => 1,  // 1: INT
            Sampler::Uint => 2, // 2: UINT
            _ => 3,             // 3: FLOAT/UNORM/NORM
        };

        let Some(gradient_strip) = strip_buffer(&self.unpack_properties, gradient, false) else {
            return Ok(false);
        };
        let Some(data_strip) = strip_buffer(&self.pack_properties, data, true) else {
            return Ok(false);
        };

        if gradient_strip.is_empty() || data_strip.is_empty() {
            return Ok(false);
        }

        let element_count = (GRADIENT_WIDTH * GRADIENT_HEIGHT) as usize;
        let input_buffer = get_float_buffer(
            &gradient_strip,
            sampler_is_int_uint_float,
            &self.input_format,
            &self.input_type,
            element_count,
        )?;
        let output_buffer = get_float_buffer(
            &data_strip,
            sampler_is_int_uint_float,
            output_format,
            output_type,
            element_count,
        )?;

        let input_bit_table = get_bits(&self.input_type, &self.input_format);
        let output_bit_table = get_bits(output_type, output_format);

        let internalformat_bit_table = self.internal_format.bits;
        let copy_format_bit_table = self.copy_internal_format.bits;

        for i in 0..element_count {
            for j in 0..6 {
                let bit1 = get_real_bit_precision(input_bit_table[j], input_sampler == Sampler::Float);
                let mut bit2 = get_real_bit_precision(output_bit_table[j], output_sampler == Sampler::Float);
                let mut bit3 = get_real_bit_precision(internalformat_bit_table[j], iformat_sampler == Sampler::Float);

                if bit1 >= bit3 && input_sampler == Sampler::Unorm && self.internal_format.sampler == Sampler::Norm {
                    bit3 -= 1;
                }

                if bit2 <= bit3 && output_sampler == Sampler::Norm && self.internal_format.sampler == Sampler::Unorm {
                    bit2 -= 1;
                }

                if (self.internal_format.flags & FLAG_REQ_RBO) == 0
                    && bit3 > 8
                    && self.internal_format.sampler != Sampler::Uint
                    && self.internal_format.sampler != Sampler::Int
                {
                    // If this internalFormat is not a required format there is no requirement that the implementation uses exactly the bit width requested. For example, it may substitute RGB10 for RGB12. The implementation can't make subtitutions for integer formats.
                    bit3 = 8;
                }

                let mut bitdiff = bit1.min(bit2).min(bit3);
                if is_copy {
                    bitdiff = bitdiff.min(copy_format_bit_table[j]);
                }

                if bitdiff > 0 {
                    if sampler_is_int_uint_float == 1 {
                        let mut input_value = input_buffer[i].i[j];
                        let output_value = output_buffer[i].i[j];

                        if input_sampler == Sampler::Uint {
                            // If input data was unsigned, it should be clamped to fit into internal format positive range (otherwise it may wrap and yield negative internalformat values)
                            input_value = clamp_unsigned_value(bit3 - 1, input_value as u32) as i32;
                        }

                        input_value = clamp_signed_value(bit3, input_value);

                        if is_copy {
                            input_value = clamp_signed_value(copy_format_bit_table[j], input_value);
                        }

                        if output_sampler == Sampler::Uint {
                            input_value = clamp_unsigned_value(bit2, input_value as u32) as i32;
                        } else {
                            input_value = clamp_signed_value(bit2, input_value);
                        }

                        if input_value != output_value {
                            log::info!(
                                "Integer comparison: {i}, {j}, {}: {input_value} == {output_value}: not equal.",
                                18 * i + j
                            );
                            return Ok(false);
                        }
                    } else if sampler_is_int_uint_float == 2 {
                        let mut input_value = input_buffer[i].ui[j];
                        let output_value = output_buffer[i].ui[j];

                        input_value = clamp_unsigned_value(bit3, input_value);

                        if is_copy {
                            input_value = clamp_unsigned_value(copy_format_bit_table[j], input_value);
                        }

                        if output_sampler == Sampler::Uint {
                            input_value = clamp_unsigned_value(bit2, input_value);
                        } else if output_sampler == Sampler::Int {
                            input_value = clamp_unsigned_value(bit2 - 1, input_value);
                        }

                        if input_value != output_value {
                            log::info!(
                                "Integer comparison: {i}, {j}, {}: {input_value} == {output_value}: not equal.",
                                18 * i + j + 6
                            );
                            return Ok(false);
                        }
                    } else {
                        let mut input_value = input_buffer[i].f[j];
                        let output_value = output_buffer[i].f[j];

                        let mut epsilon;
                        if output_sampler == Sampler::Unorm || output_sampler == Sampler::Norm {
                            // Check if format is UNORM/NORM which needs different precision since it implies a int->float conversion.
                            epsilon = 1.0 / (((1i64 << (bitdiff - 1)) as f32) - 1.0);
                        } else if (input_sampler == Sampler::Float) != (output_sampler == Sampler::Float) {
                            // Allow for rounding in either direction for float->int conversions.
                            epsilon = 1.0 / (((1i64 << (bitdiff - 1)) as f32) - 1.0);
                        } else {
                            epsilon = 1.0 / (((1i64 << bitdiff) as f32) - 1.0);
                        }

                        if input_sampler == Sampler::Float || output_sampler == Sampler::Float {
                            // According to GL spec the precision requirement of floating-point values is 1 part in 10^5.
                            epsilon = epsilon.max(0.00001);
                        }

                        if (self.internal_format.flags & FLAG_COMPRESSED) != 0 {
                            epsilon = epsilon.max(0.1);
                        }

                        // Clamp input value to range of output
                        if iformat_sampler == Sampler::Unorm || output_sampler == Sampler::Unorm {
                            input_value = input_value.clamp(0.0, 1.0);
                        } else if iformat_sampler == Sampler::Norm || output_sampler == Sampler::Norm {
                            input_value = input_value.clamp(-1.0, 1.0);
                        }

                        // Compare the input and output
                        if (input_value - output_value).abs() > epsilon {
                            log::info!(
                                "Non-integer comparison: {i}, {j}, {}, {epsilon}: {input_value} == {output_value}: not equal.",
                                18 * i + j + 12
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        }
        Ok(true)
    }

    /// `getTexImage`
    fn get_tex_image(&mut self) -> Result<bool, TestError> {
        // for each output format
        for output_format in &CORE_FORMATS {
            // for each output type
            for output_type in &CORE_TYPES {
                if (self.input_format.format != self.internal_format.format
                    || self.input_type.type_ != self.internal_format.type_)
                    && (output_format.format != self.internal_format.format
                        || output_type.type_ != self.internal_format.type_)
                {
                    continue;
                }

                if !self.get_tex_image_inner(output_format, output_type)? {
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    /// `getTexImageInner`
    fn get_tex_image_inner(&mut self, output_format: &PixelFormat, output_type: &PixelType) -> Result<bool, TestError> {
        let output_format_valid = self.is_format_valid(
            output_format,
            output_type,
            &self.internal_format,
            Operation::OutputGetTexImage,
        );

        let error = self.read_output_data(output_format, output_type, Operation::OutputGetTexImage)?;

        if !output_format_valid {
            if error != 0 {
                return Ok(true);
            }

            log::info!("Expected error but got no GL error");
            return Ok(false);
        } else if error != 0 {
            log::info!("Error during glGetTexImage");
            return Ok(false);
        }

        // compare output gradient to input gradient
        if self.compare(&self.gradient, &self.output_buffer, output_format, output_type, false)? {
            return Ok(true);
        }

        log::info!(
            "Gradient comparison failed during GetTexImage for input = [{}, {:#x}] output = [{}, {:#x}]",
            self.input_format.name,
            self.input_type.type_,
            output_format.name,
            output_type.type_
        );
        Ok(false)
    }

    /// `testAllFormatsAndTypes`
    fn test_all_formats_and_types(&mut self) -> Result<bool, TestError> {
        debug_assert!(self.texture_target == glw::GL_TEXTURE_2D || self.texture_target == glw::GL_TEXTURE_3D);

        let gl = self.context.gl();
        let mut result = true;

        // SAFETY: a clear of the bound framebuffer.
        unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

        for input_type in &CORE_TYPES {
            self.input_type = *input_type;

            self.apply_initial_storage_modes();

            // Create input gradient in format,type, with appropriate range
            self.create_gradient()?;

            if self.gradient.is_empty() {
                return Err(TestError::Fail("Could not create gradient.".to_string()));
            }

            if self.unpack_properties.swap_bytes != 0 {
                swap_bytes(self.input_type.size, &mut self.gradient)?;
            }

            let texture = glu::Texture::new(gl);
            // SAFETY: the texture is the guard's own.
            unsafe { gl.bind_texture(self.texture_target, texture.get()) };
            glu::expect_no_error(gl, "glBindTexture")?;

            // SAFETY: `gradient` holds the whole unpack rectangle the pixel store state describes.
            unsafe {
                if self.texture_target == glw::GL_TEXTURE_3D {
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_3D,
                        0,
                        self.internal_format.sized_format as i32,
                        GRADIENT_WIDTH,
                        GRADIENT_HEIGHT,
                        1,
                        0,
                        self.input_format.format,
                        self.input_type.type_,
                        self.gradient.as_ptr().cast(),
                    );
                } else {
                    gl.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        self.internal_format.sized_format as i32,
                        GRADIENT_WIDTH,
                        GRADIENT_HEIGHT,
                        0,
                        self.input_format.format,
                        self.input_type.type_,
                        self.gradient.as_ptr().cast(),
                    );
                }
            }

            if self.unpack_properties.swap_bytes != 0 {
                swap_bytes(self.input_type.size, &mut self.gradient)?;
            }

            // SAFETY: glGetError needs nothing but a current context.
            let error = unsafe { gl.get_error() };

            if self.is_format_valid(
                &self.input_format,
                &self.input_type,
                &self.internal_format,
                Operation::InputTexImage,
            ) {
                if error == glw::GL_NO_ERROR {
                    result &= self.get_tex_image()?;
                    result &= self.do_read(texture.get())?;
                } else {
                    log::info!("Valid format used but glTexImage2D/3D failed");
                    result = false;
                }
            } else if error == glw::GL_NO_ERROR {
                log::info!("Invalid format used but glTexImage2D/3D succeeded");
                result = false;
            }
        }

        Ok(result)
    }

    /// `VariedRectangleTest::iterate` - every storage mode on its own, each with the whole format and type sweep.
    fn iterate_varied(&mut self) -> Result<bool, TestError> {
        const IMAGE_WIDTH_1: i32 = 10;
        const IMAGE_WIDTH_2: i32 = 15;
        const IMAGE_HEIGHT_1: i32 = 10;
        const IMAGE_HEIGHT_2: i32 = 15;

        let common_cases: [(GLenum, i32); 32] = [
            (glw::GL_UNPACK_ROW_LENGTH, 0),
            (glw::GL_UNPACK_ROW_LENGTH, IMAGE_WIDTH_1),
            (glw::GL_UNPACK_ROW_LENGTH, IMAGE_WIDTH_2),
            (glw::GL_UNPACK_SKIP_ROWS, 0),
            (glw::GL_UNPACK_SKIP_ROWS, 1),
            (glw::GL_UNPACK_SKIP_ROWS, 2),
            (glw::GL_UNPACK_SKIP_PIXELS, 0),
            (glw::GL_UNPACK_SKIP_PIXELS, 1),
            (glw::GL_UNPACK_SKIP_PIXELS, 2),
            (glw::GL_UNPACK_ALIGNMENT, 1),
            (glw::GL_UNPACK_ALIGNMENT, 2),
            (glw::GL_UNPACK_ALIGNMENT, 4),
            (glw::GL_UNPACK_ALIGNMENT, 8),
            (glw::GL_UNPACK_IMAGE_HEIGHT, 0),
            (glw::GL_UNPACK_IMAGE_HEIGHT, IMAGE_HEIGHT_1),
            (glw::GL_UNPACK_IMAGE_HEIGHT, IMAGE_HEIGHT_2),
            (glw::GL_UNPACK_SKIP_IMAGES, 0),
            (glw::GL_UNPACK_SKIP_IMAGES, 1),
            (glw::GL_UNPACK_SKIP_IMAGES, 2),
            (glw::GL_PACK_ROW_LENGTH, 0),
            (glw::GL_PACK_ROW_LENGTH, IMAGE_WIDTH_1),
            (glw::GL_PACK_ROW_LENGTH, IMAGE_WIDTH_2),
            (glw::GL_PACK_SKIP_ROWS, 0),
            (glw::GL_PACK_SKIP_ROWS, 1),
            (glw::GL_PACK_SKIP_ROWS, 2),
            (glw::GL_PACK_SKIP_PIXELS, 0),
            (glw::GL_PACK_SKIP_PIXELS, 1),
            (glw::GL_PACK_SKIP_PIXELS, 2),
            (glw::GL_PACK_ALIGNMENT, 1),
            (glw::GL_PACK_ALIGNMENT, 2),
            (glw::GL_PACK_ALIGNMENT, 4),
            (glw::GL_PACK_ALIGNMENT, 8),
        ];

        let core_cases: [(GLenum, i32); 14] = [
            (glw::GL_UNPACK_SWAP_BYTES, i32::from(glw::FALSE)),
            (glw::GL_UNPACK_SWAP_BYTES, i32::from(glw::TRUE)),
            (glw::GL_UNPACK_LSB_FIRST, i32::from(glw::FALSE)),
            (glw::GL_UNPACK_LSB_FIRST, i32::from(glw::TRUE)),
            (glw::GL_PACK_SWAP_BYTES, i32::from(glw::FALSE)),
            (glw::GL_PACK_SWAP_BYTES, i32::from(glw::TRUE)),
            (glw::GL_PACK_LSB_FIRST, i32::from(glw::FALSE)),
            (glw::GL_PACK_LSB_FIRST, i32::from(glw::TRUE)),
            (glw::GL_PACK_IMAGE_HEIGHT, 0),
            (glw::GL_PACK_IMAGE_HEIGHT, IMAGE_HEIGHT_1),
            (glw::GL_PACK_IMAGE_HEIGHT, IMAGE_HEIGHT_2),
            (glw::GL_PACK_SKIP_IMAGES, 0),
            (glw::GL_PACK_SKIP_IMAGES, 1),
            (glw::GL_PACK_SKIP_IMAGES, 2),
        ];

        let test_modes: Vec<(GLenum, i32)> = common_cases.iter().chain(core_cases.iter()).copied().collect();

        for (parameter, value) in test_modes {
            self.reset_initial_storage_modes();

            // `*(currentCase->property) = value`
            let up = &mut self.initial_unpack_properties;
            let pp = &mut self.initial_pack_properties;
            match parameter {
                glw::GL_UNPACK_ROW_LENGTH => up.row_length = value,
                glw::GL_UNPACK_SKIP_ROWS => up.skip_rows = value,
                glw::GL_UNPACK_SKIP_PIXELS => up.skip_pixels = value,
                glw::GL_UNPACK_ALIGNMENT => up.alignment = value,
                glw::GL_UNPACK_IMAGE_HEIGHT => up.row_count = value,
                glw::GL_UNPACK_SKIP_IMAGES => up.skip_images = value,
                glw::GL_PACK_ROW_LENGTH => pp.row_length = value,
                glw::GL_PACK_SKIP_ROWS => pp.skip_rows = value,
                glw::GL_PACK_SKIP_PIXELS => pp.skip_pixels = value,
                glw::GL_PACK_ALIGNMENT => pp.alignment = value,
                glw::GL_UNPACK_SWAP_BYTES => up.swap_bytes = value,
                glw::GL_UNPACK_LSB_FIRST => up.lsb_first = value,
                glw::GL_PACK_SWAP_BYTES => pp.swap_bytes = value,
                glw::GL_PACK_LSB_FIRST => pp.lsb_first = value,
                glw::GL_PACK_IMAGE_HEIGHT => pp.row_count = value,
                glw::GL_PACK_SKIP_IMAGES => pp.skip_images = value,
                _ => return Err(TestError::Fail("Unknown mode name".to_string())),
            }

            // for some parameters an additional parameter needs to be set
            if parameter == glw::GL_PACK_SKIP_ROWS {
                self.initial_pack_properties.row_count = GRADIENT_HEIGHT + value;
            } else if parameter == glw::GL_PACK_SKIP_PIXELS {
                self.initial_pack_properties.row_length = GRADIENT_WIDTH + value;
            } else if parameter == glw::GL_UNPACK_SKIP_ROWS {
                self.initial_unpack_properties.row_count = GRADIENT_HEIGHT + value;
            } else if parameter == glw::GL_UNPACK_SKIP_PIXELS {
                self.initial_unpack_properties.row_length = GRADIENT_WIDTH + value;
            }

            self.texture_target = glw::GL_TEXTURE_2D;
            if parameter == glw::GL_PACK_IMAGE_HEIGHT
                || parameter == glw::GL_PACK_SKIP_IMAGES
                || parameter == glw::GL_UNPACK_IMAGE_HEIGHT
                || parameter == glw::GL_UNPACK_SKIP_IMAGES
            {
                self.texture_target = glw::GL_TEXTURE_3D;
            }

            if !self.test_all_formats_and_types()? {
                log::info!("Case for: {parameter:#x} = {value} failed.");
                return Ok(false);
            }
        }
        Ok(true)
    }
}
