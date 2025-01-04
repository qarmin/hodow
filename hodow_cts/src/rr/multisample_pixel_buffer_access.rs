// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrMultisamplePixelBufferAccess.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `MultisamplePixelBufferAccess`/`MultisampleConstPixelBufferAccess` themselves are
// **not** ported as their own wrapper types - see `renderer.rs`'s own top doc comment
// for why: this port already addresses a multisample buffer through a plain
// `tcu::pixel::PixelBufferAccess`/`ConstPixelBufferAccess` with `size()[0]` playing the
// sample-index role (`as_multisample_view`'s one-line reshape, `RenderTarget::get_num_
// samples` reading `size()[0]` directly), rather than a distinct type that only exists
// upstream to keep a single-sampled access from being passed somewhere a multisampled
// one is expected. `getSubregion`/`clear`/`clearDepth`/`clearStencil` are skipped for
// the same reason: each one upstream is a single line forwarding to the un-wrapped
// `tcu::` equivalent over `access.raw()` - with no wrapper here to unwrap, a caller
// reaches `tcu::pixel::{clear, clear_depth, clear_stencil}` or
// `PixelBufferAccess::get_subregion` directly over the multisample-shaped access and
// gets upstream's exact behaviour for free.
//
// What genuinely does not exist anywhere else in this port is the actual MSAA
// *resolve* - averaging a multisampled buffer down to one value per pixel - so that
// part is ported here: `resolve_multisample_color_buffer`/`_depth_buffer`/
// `_stencil_buffer`/`_buffer` (the format-order dispatcher) and `resolve_multisample_
// pixel`. No caller exists yet (`sglr::ReferenceContext` has no
// `renderbufferStorageMultisample` entry point at all - see that file's own top doc
// comment for exactly why that is not a gap this adds, since upstream's own
// `ReferenceContext::renderbufferStorageMultisample` is itself an unimplemented
// `\todo` stub that discards `samples` and falls back to the single-sample path) -
// this is the same "build the general-purpose piece ahead of the case that will
// consume it" call `vertex_packet.rs`'s own `VertexPacketAllocator` already made, now
// that `rr::Renderer` genuinely drives a multisampled `RenderTarget` down a real
// per-sample rasterisation path (see `renderer.rs`'s top doc comment).
//
// Depth/stencil resolve reaches straight through `PixelBufferAccess::get_pix_depth`/
// `set_pix_depth`/`get_pix_stencil`/`set_pix_stencil` on the *un-split* (possibly
// combined-depth-stencil) format, rather than first narrowing through
// `tcu::pixel::get_effective_depth_stencil_access(_mut)` the way upstream's own
// `getEffectiveDepthStencilAccess` call does - those four accessors already decode/
// encode every combined format's own depth or stencil sub-field directly (confirmed by
// reading each one's own `match format.type_` arms), so there is nothing left for a
// separate "effective view" step to narrow. This sidesteps a real borrow-checker
// obstacle a literal port would hit: `get_effective_depth_stencil_access_mut`'s own
// signature requires its `&mut PixelBufferAccess` argument and the access's own
// backing-storage lifetime to be *the same* generic lifetime (so the narrowed view it
// returns can still own the full borrow) - fine for a single call, but
// `resolveMultisampleBuffer`'s `DS` case calls the depth and the stencil resolve one
// after the other against the *same* `dst`, which would need to reconstruct two
// independent effective views from one `&mut` of that shape, not something either call
// can do without consuming the other's access to the buffer. Going through the
// pixel-level accessors instead needs no such narrowing at all.
//
// Upstream's `resolveMultisampleColorBuffer`/`resolveMultisampleDepthBuffer` each special-
// case `src.getNumSamples() == 1` into a `tcu::copy` fast path purely for performance;
// the general per-sample-average loop already produces the identical result at
// `numSamples == 1` (one term summed, multiplied by `1.0 / 1`), so that branch is
// dropped here rather than duplicated - see `single_sample_resolve_is_an_exact_copy_not_
// just_an_approximation` below for the hand-verified proof this is a safe
// simplification and not a cut corner. `resolveMultisampleStencilBuffer` similarly
// special-cases `numSamples == 1` into a `tcu::copy`, but its *multisample* branch is
// already "read sample 0 and nothing else" (a stencil value cannot be meaningfully
// averaged across samples) - both branches do the exact same read, so this port has
// only ever had the one unconditional loop.

use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess};
use crate::tcu::texture::ChannelOrder;

/// `resolveMultisampleColorBuffer`
///
/// `dst` is a plain single-sampled access (`size() == [width, height, _]`); `src` is a
/// multisample-shaped access (`size() == [num_samples, width, height]`, the same
/// convention `as_multisample_view`/`RenderTarget::get_num_samples` use elsewhere in
/// `rr`). `dst`'s own width/height must match `src`'s non-sample dimensions - upstream
/// asserts this with `DE_ASSERT`; this does the same via `debug_assert_eq!`.
pub fn resolve_multisample_color_buffer(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    debug_assert_eq!(
        dst.size()[0],
        src.size()[1],
        "dst width must match src's non-sample width"
    );
    debug_assert_eq!(
        dst.size()[1],
        src.size()[2],
        "dst height must match src's non-sample height"
    );

    let num_samples = src.size()[0];
    let inv_num_samples = 1.0 / num_samples as f32;

    for y in 0..dst.size()[1] {
        for x in 0..dst.size()[0] {
            let mut sum = [0.0f32; 4];
            for s in 0..num_samples {
                let p = src.get_pixel(s, x, y);
                for c in 0..4 {
                    sum[c] += p[c];
                }
            }
            for c in sum.iter_mut() {
                *c *= inv_num_samples;
            }
            dst.set_pixel(sum, x, y, 0);
        }
    }
}

/// `resolveMultisampleDepthBuffer` - see this module's own top doc comment for why this
/// goes through `get_pix_depth`/`set_pix_depth` directly rather than first narrowing to
/// an "effective" depth-only view the way upstream's own `getEffectiveDepthStencilAccess`
/// call does; both already handle every combined depth/stencil format upstream does.
pub fn resolve_multisample_depth_buffer(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    debug_assert_eq!(
        dst.size()[0],
        src.size()[1],
        "dst width must match src's non-sample width"
    );
    debug_assert_eq!(
        dst.size()[1],
        src.size()[2],
        "dst height must match src's non-sample height"
    );

    let num_samples = src.size()[0];
    let inv_num_samples = 1.0 / num_samples as f32;

    for y in 0..dst.size()[1] {
        for x in 0..dst.size()[0] {
            let mut sum = 0.0f32;
            for s in 0..num_samples {
                sum += src.get_pix_depth(s, x, y);
            }
            dst.set_pix_depth(sum * inv_num_samples, x, y, 0);
        }
    }
}

/// `resolveMultisampleStencilBuffer` - "resolve by selecting one" (sample 0), exactly as
/// upstream's own multisample branch does; see this module's own top doc comment for why
/// there is only the one code path here instead of upstream's `numSamples == 1` split.
pub fn resolve_multisample_stencil_buffer(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    debug_assert_eq!(
        dst.size()[0],
        src.size()[1],
        "dst width must match src's non-sample width"
    );
    debug_assert_eq!(
        dst.size()[1],
        src.size()[2],
        "dst height must match src's non-sample height"
    );

    for y in 0..dst.size()[1] {
        for x in 0..dst.size()[0] {
            dst.set_pix_stencil(src.get_pix_stencil(0, x, y), x, y, 0);
        }
    }
}

/// `resolveMultisampleBuffer` - dispatches on `src`'s own format order, exactly like
/// upstream's `switch (src.raw().getFormat().order)`.
pub fn resolve_multisample_buffer(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    match src.format().order {
        ChannelOrder::D => resolve_multisample_depth_buffer(dst, src),
        ChannelOrder::S => resolve_multisample_stencil_buffer(dst, src),
        ChannelOrder::DS => {
            resolve_multisample_depth_buffer(dst, src);
            resolve_multisample_stencil_buffer(dst, src);
        }
        _ => resolve_multisample_color_buffer(dst, src),
    }
}

/// `resolveMultisamplePixel`
pub fn resolve_multisample_pixel(access: &ConstPixelBufferAccess<'_>, x: u32, y: u32) -> [f32; 4] {
    let num_samples = access.size()[0];
    let mut sum = [0.0f32; 4];
    for s in 0..num_samples {
        let p = access.get_pixel(s, x, y);
        for c in 0..4 {
            sum[c] += p[c];
        }
    }
    let inv_num_samples = 1.0 / num_samples as f32;
    for c in sum.iter_mut() {
        *c *= inv_num_samples;
    }
    sum
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelType, TextureFormat};

    /// At `num_samples == 1` the general weighted-average loop must reproduce the
    /// sample's own value bit-for-bit - a single term summed then multiplied by
    /// `1.0 / 1.0` introduces no rounding at all, which is what lets this module skip
    /// upstream's separate `tcu::copy` fast path (see the top doc comment) without that
    /// being an approximation. A lossless `FLOAT` format is used specifically so the
    /// round trip through `get_pixel`/`set_pixel` itself cannot hide a mismatch behind
    /// quantization.
    #[test]
    fn single_sample_resolve_is_an_exact_copy_not_just_an_approximation() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut src_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        src_level.get_access().set_pixel([0.3, 0.6, 0.9, 0.125], 0, 0, 0);

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_color_buffer(&mut dst_access, &src_level.get_const_access());

        assert_eq!(dst_level.get_const_access().get_pixel(0, 0, 0), [0.3, 0.6, 0.9, 0.125]);
    }

    #[test]
    fn color_buffer_resolve_averages_every_sample_per_channel() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        // 3 samples, chosen so the red-channel average (0.0 + 0.5 + 1.0) / 3 == 0.5
        // lands exactly - every other channel stays 0.0 throughout, so the same exact
        // equality covers them trivially.
        let mut src_level = TextureLevel::new(format, 3, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pixel([0.0, 0.0, 0.0, 0.0], 0, 0, 0);
            access.set_pixel([0.5, 0.0, 0.0, 0.0], 1, 0, 0);
            access.set_pixel([1.0, 0.0, 0.0, 0.0], 2, 0, 0);
        }

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_color_buffer(&mut dst_access, &src_level.get_const_access());

        assert_eq!(dst_level.get_const_access().get_pixel(0, 0, 0), [0.5, 0.0, 0.0, 0.0]);
    }

    #[test]
    fn resolve_multisample_pixel_matches_the_buffer_level_average() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut src_level = TextureLevel::new(format, 3, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pixel([0.0, 1.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.5, 1.0, 0.0, 1.0], 1, 0, 0);
            access.set_pixel([1.0, 1.0, 0.0, 1.0], 2, 0, 0);
        }

        let sum = resolve_multisample_pixel(&src_level.get_const_access(), 0, 0);
        assert_eq!(sum, [0.5, 1.0, 0.0, 1.0]);
    }

    /// Depth is a genuine per-sample average (unlike stencil below) - a plain `D`/
    /// `FLOAT` depth format keeps the arithmetic exact, so the two samples (`1.0`,
    /// `0.0`) must average to exactly `0.5`.
    #[test]
    fn depth_buffer_resolve_averages_samples() {
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
        let mut src_level = TextureLevel::new(format, 2, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pix_depth(1.0, 0, 0, 0);
            access.set_pix_depth(0.0, 1, 0, 0);
        }

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_depth_buffer(&mut dst_access, &src_level.get_const_access());

        assert_eq!(dst_level.get_const_access().get_pix_depth(0, 0, 0), 0.5);
    }

    /// Stencil is "resolve by selecting one" - sample 0's own value must land in `dst`
    /// untouched by whatever the other samples hold, proving this is not secretly an
    /// average (which would be meaningless for stencil anyway).
    #[test]
    fn stencil_buffer_resolve_picks_sample_zero_not_an_average() {
        let format = TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8);
        let mut src_level = TextureLevel::new(format, 2, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pix_stencil(42, 0, 0, 0);
            access.set_pix_stencil(99, 1, 0, 0);
        }

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_stencil_buffer(&mut dst_access, &src_level.get_const_access());

        assert_eq!(dst_level.get_const_access().get_pix_stencil(0, 0, 0), 42);
    }

    /// The dispatcher's `DS` arm must run *both* the depth and the stencil resolve
    /// against one combined buffer, each through its own un-split accessor (see this
    /// module's own top doc comment) - checked against a real combined
    /// `UNSIGNED_INT_24_8_REV` format (the variant `get_pix_depth`/`get_pix_stencil` both
    /// give an explicit, exactly-invertible arm - plain `UNSIGNED_INT_24_8`'s own
    /// `get_pix_depth` has no such arm and falls through to the generic channel decoder,
    /// a pre-existing asymmetry with its `set_pix_depth` arm that is not this module's
    /// to fix), not a pair of separate depth-only/stencil-only ones, since that is the
    /// shape the borrow-checker obstacle described there is specific to.
    #[test]
    fn combined_depth_stencil_dispatch_resolves_both_aspects() {
        let format = TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8_REV);
        let mut src_level = TextureLevel::new(format, 2, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pix_depth(1.0, 0, 0, 0);
            access.set_pix_stencil(7, 0, 0, 0);
            access.set_pix_depth(0.0, 1, 0, 0);
            access.set_pix_stencil(200, 1, 0, 0);
        }

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_buffer(&mut dst_access, &src_level.get_const_access());

        let dst_access = dst_level.get_const_access();
        // UNSIGNED_INT_24_8_REV quantizes depth to 24 bits - a (1.0 + 0.0) / 2 == 0.5
        // average lands within one quantization step of exact, nowhere near the ~4%
        // this tolerance actually allows.
        assert!(
            (dst_access.get_pix_depth(0, 0, 0) - 0.5).abs() < 1e-5,
            "got {}",
            dst_access.get_pix_depth(0, 0, 0)
        );
        assert_eq!(
            dst_access.get_pix_stencil(0, 0, 0),
            7,
            "stencil must come from sample 0, not sample 1's 200"
        );
    }

    /// `resolve_multisample_buffer` must reach the plain colour path (not the depth/
    /// stencil ones) for an ordinary, non-depth-stencil format.
    #[test]
    fn dispatch_reaches_the_color_path_for_an_rgba_format() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut src_level = TextureLevel::new(format, 2, 1, 1).unwrap();
        {
            let mut access = src_level.get_access();
            access.set_pixel([0.0, 0.0, 0.0, 0.0], 0, 0, 0);
            access.set_pixel([1.0, 0.0, 0.0, 0.0], 1, 0, 0);
        }

        let mut dst_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        let mut dst_access = dst_level.get_access();
        resolve_multisample_buffer(&mut dst_access, &src_level.get_const_access());

        assert_eq!(dst_level.get_const_access().get_pixel(0, 0, 0), [0.5, 0.0, 0.0, 0.0]);
    }
}
