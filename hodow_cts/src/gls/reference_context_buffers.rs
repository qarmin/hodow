// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrReferenceContext.cpp (ReferenceContextBuffers)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// What a test case does with `sglr::ReferenceContextBuffers` + `sglr::ReferenceContext`
// to get a software context shaped like the real render target. Narrowed: always single
// sample (`ReferenceContext::new` has no multisample buffer layout) and no stencil buffer.

use crate::glu::Context;
use crate::glw;
use crate::sglr::reference_context::ReferenceContext;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TextureFormat};

/// `toTextureFormat(PixelFormat)`
pub fn color_format(context: &Context) -> Result<TextureFormat, TestError> {
    let rt = context.render_target();
    let bits = (rt.red_bits, rt.green_bits, rt.blue_bits, rt.alpha_bits);
    let (order, type_) = match bits {
        (8, 8, 8, 8) => (ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        (8, 8, 8, 0) => (ChannelOrder::RGB, ChannelType::UNORM_INT8),
        (4, 4, 4, 4) => (ChannelOrder::RGBA, ChannelType::UNORM_SHORT_4444),
        (5, 5, 5, 1) => (ChannelOrder::RGBA, ChannelType::UNORM_SHORT_5551),
        (5, 6, 5, 0) => (ChannelOrder::RGB, ChannelType::UNORM_SHORT_565),
        _ => {
            return Err(TestError::NotSupported(format!(
                "no reference colour format for render target {bits:?}"
            )));
        }
    };
    Ok(TextureFormat::new(order, type_))
}

/// `getDepthFormat(int depthBits)`
pub fn depth_format(depth_bits: i32) -> Result<TextureFormat, TestError> {
    let type_ = match depth_bits {
        8 => ChannelType::UNORM_INT8,
        16 => ChannelType::UNORM_INT16,
        24 => ChannelType::UNORM_INT24,
        32 => ChannelType::FLOAT,
        _ => {
            return Err(TestError::NotSupported(format!(
                "no reference depth format for {depth_bits} bits"
            )));
        }
    };
    Ok(TextureFormat::new(ChannelOrder::D, type_))
}

/// `ReferenceContextBuffers(pixelFormat, depthBits, 0, width, height, 1)` handed to a
/// default-limits `ReferenceContext`.
pub fn create_reference_context(
    context: &Context,
    width: i32,
    height: i32,
    depth_bits: i32,
) -> Result<ReferenceContext, TestError> {
    let color = TextureLevel::new(color_format(context)?, width as u32, height as u32, 1)?;
    let depth = if depth_bits > 0 {
        Some(TextureLevel::new(
            depth_format(depth_bits)?,
            width as u32,
            height as u32,
            1,
        )?)
    } else {
        None
    };
    let mut ref_ctx = ReferenceContext::new(16, color, depth, 8);
    ref_ctx.set_max_texture_image_units(
        context
            .context_info
            .get_int(context.gl(), glw::GL_MAX_TEXTURE_IMAGE_UNITS)
            .max(16) as usize,
    );
    Ok(ref_ctx)
}

/// The stencil plane `ReferenceContextBuffers` allocates from `renderTarget.getStencilBits()`.
fn with_render_target_stencil(
    context: &Context,
    ctx: ReferenceContext,
    width: i32,
    height: i32,
) -> Result<ReferenceContext, TestError> {
    if context.render_target().stencil_bits <= 0 {
        return Ok(ctx);
    }
    let format = TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8);
    Ok(ctx.with_stencil_buffer(TextureLevel::new(format, width as u32, height as u32, 1)?))
}

/// `create_reference_context` with the render target's stencil bits, for the tests whose upstream
/// `ReferenceContextBuffers` is built with `getStencilBits()` instead of 0.
pub fn create_reference_context_with_stencil(
    context: &Context,
    width: i32,
    height: i32,
    depth_bits: i32,
) -> Result<ReferenceContext, TestError> {
    let ctx = create_reference_context(context, width, height, depth_bits)?;
    with_render_target_stencil(context, ctx, width, height)
}

/// `ReferenceContextBuffers(PixelFormat(8, 8, 8, alphaBits ? 8 : 0), depthBits, 0, width, height)` -
/// the shape the FBO tests use, which fixes the reference colour buffer at 8 bits per channel
/// whatever the real render target has.
pub fn create_reference_context_rgb8(
    context: &Context,
    width: i32,
    height: i32,
    depth_bits: i32,
) -> Result<ReferenceContext, TestError> {
    let order = if context.render_target().alpha_bits > 0 {
        ChannelOrder::RGBA
    } else {
        ChannelOrder::RGB
    };
    let color = TextureLevel::new(
        TextureFormat::new(order, ChannelType::UNORM_INT8),
        width as u32,
        height as u32,
        1,
    )?;
    let depth = if depth_bits > 0 {
        Some(TextureLevel::new(
            depth_format(depth_bits)?,
            width as u32,
            height as u32,
            1,
        )?)
    } else {
        None
    };
    let mut ref_ctx = ReferenceContext::new(16, color, depth, 8);
    ref_ctx.set_max_texture_image_units(
        context
            .context_info
            .get_int(context.gl(), glw::GL_MAX_TEXTURE_IMAGE_UNITS)
            .max(16) as usize,
    );
    with_render_target_stencil(context, ref_ctx, width, height)
}
