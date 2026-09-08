// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluPixelTransfer.hpp / .cpp  (glu::readPixels)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::render_context::RenderContext;
use crate::glu::texture_util::get_transfer_format;
use crate::glw;
use crate::tcu::TestError;
use crate::tcu::pixel::PixelBufferAccess;

/// `getTransferAlignment` - what `GL_PACK_ALIGNMENT` has to be for a tightly packed
/// run of this format not to be padded.
fn get_transfer_alignment(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() { pixel_size.min(8) as i32 } else { 1 }
}

/// `glu::readPixels` - reads the framebuffer into `dst`, whose stride must be the
/// default stride for its format.
pub fn read_pixels(context: &RenderContext, x: i32, y: i32, dst: &mut PixelBufferAccess<'_>) -> Result<(), TestError> {
    let gl = context.functions();

    let format = dst.format();
    let pixel_size = format.pixel_size().ok_or_else(|| TestError::InternalError(format!("pixel size of {:?}", format.type_)))?;
    let [width, height, depth] = dst.size();
    if depth != 1 || dst.pitch()[1] != pixel_size as usize * width as usize {
        return Err(TestError::InternalError("glu::readPixels needs a tightly packed 2D destination".to_string()));
    }
    let transfer = get_transfer_format(format)?;

    // SAFETY: the destination is `width * height * pixelSize` bytes of writable
    // storage, which is exactly what the requested transfer format makes GL write.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, get_transfer_alignment(pixel_size));
        gl.read_pixels(x, y, width as i32, height as i32, transfer.format, transfer.data_type, dst.raw_mut().as_mut_ptr().cast());
    }
    Ok(())
}
