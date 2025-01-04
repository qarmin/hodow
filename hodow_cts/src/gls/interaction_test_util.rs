// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsInteractionTestUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported in full (235+128 upstream lines) - the whole file is pure, host-only
// procedural generation over a `tcu::Random` (`de::Random`), with no GL/driver call or
// shared-state dependency anywhere in it. Both `dEQP-GLES3.functional.fragment_ops.random`
// (`es3fRandomFragmentOpTests.cpp`) **and its GLES2 sibling**
// (`es2fRandomFragmentOpTests.cpp`) build their randomized draw-call sequence through
// exactly this one shared file plus the already-ported `gls::fragment_op_util`
// (`QuadRenderer`/`ReferenceQuadRenderer`) - together those two are everything either
// group needs, with no `sglr::ReferenceContext` or `rsg` (random-shader-generator)
// dependency at all.
//
// **Correction, confirmed by grepping `es2fRandomFragmentOpTests.cpp` directly**: a
// prior inventory claimed the GLES2
// test file has "its own, separate, near-identical `computeRandomRenderCommands`"
// rather than sharing this one, and that porting it was an open follow-up - that claim
// was never true. `es2fRandomFragmentOpTests.cpp` itself `#include`s
// `glsInteractionTestUtil.hpp` and calls `computeRandomRenderCommands(rnd,
// glu::ApiType::es(2, 0), ...)` - the identical function this file already ports in
// full, which already branches on `apiType == glu::ApiType::es(2, 0)` internally for
// the blend-equation/-function tables (`compute_random_render_state` below,
// `es2_blend_state_stays_within_the_es2_tables` test). There was never a second,
// GLES2-only copy to port - `dEQP-GLES2.functional.fragment_ops.random` is
// infrastructure-complete here exactly like its GLES3 sibling, both (c)-class per this
// file's own task's classification, not (b).
//
// `fragment_ops.interaction` (`glsFragOpInteractionCase.cpp`) also includes this file,
// but additionally needs `rsg` (the random-shader-generator framework,
// `framework/randomshaders/`, 11514 lines - unrelated and unported) and the `sglr::Context`
// trait/`sglr::GLContext` dual-backend abstraction (also unported, see
// `sglr::ReferenceContext`'s own "What's NOT done"), so this file alone does not unlock
// that group.
//
// Narrowing: upstream's `RenderState::colorMask` is a `tcu::BVec4`; this port uses a
// plain `[bool; 4]` instead, since introducing a whole boolean vector type for this one
// field was not worth it (`tcu::vector` has no `BVec4` and nothing else needs one yet).
// `BlendState`/`StencilState`/`RenderState`'s GL-enum-typed fields (`equation`,
// `function`, ...) are kept as raw `glw::GLenum` values, exactly as upstream's own
// `RenderState` stores them - translating them into `rr::render_state`'s typed enums
// (`sglr::reference_utils::map_gl_blend_equation` and friends, already ported) is
// upstream's separate `translateState` function, which lives in the *test* file
// (`es3fRandomFragmentOpTests.cpp`), not in `glsInteractionTestUtil.cpp` itself - so it
// stays out of this port too, for whichever future session ports that test.

use super::fragment_op_util::IntegerQuad;
use crate::glu::ApiType;
use crate::glw::GLenum;
use crate::rr::render_state::WindowRectangle;
use crate::tcu::random::Random;
use crate::tcu::vector::{IVec2, Vec4};

/// `gls::InteractionTestUtil::BlendState`
#[derive(Debug, Clone, Copy, Default)]
pub struct BlendState {
    pub equation: GLenum,
    pub src_func: GLenum,
    pub dst_func: GLenum,
}

/// `gls::InteractionTestUtil::StencilState`
#[derive(Debug, Clone, Copy, Default)]
pub struct StencilState {
    pub function: GLenum,
    pub reference: i32,
    pub compare_mask: u32,
    pub stencil_fail_op: GLenum,
    pub depth_fail_op: GLenum,
    pub depth_pass_op: GLenum,
    pub write_mask: u32,
}

/// `gls::InteractionTestUtil::RenderState` - see this file's own module doc comment for
/// the `colorMask`/`BVec4` narrowing.
#[derive(Debug, Clone, Copy)]
pub struct RenderState {
    pub scissor_test_enabled: bool,
    pub scissor_rectangle: WindowRectangle,

    pub stencil_test_enabled: bool,
    /// Indexed by `rr::FaceType::Front`/`Back`, matching upstream's
    /// `stencil[rr::FACETYPE_LAST]`.
    pub stencil: [StencilState; 2],

    pub depth_test_enabled: bool,
    pub depth_func: GLenum,
    pub depth_write_mask: bool,

    pub blend_enabled: bool,
    pub blend_rgb_state: BlendState,
    pub blend_a_state: BlendState,
    pub blend_color: Vec4,

    pub dither_enabled: bool,

    pub color_mask: [bool; 4],
}

impl Default for RenderState {
    fn default() -> Self {
        Self {
            scissor_test_enabled: false,
            scissor_rectangle: WindowRectangle {
                left: 0,
                bottom: 0,
                width: 0,
                height: 0,
            },
            stencil_test_enabled: false,
            stencil: [StencilState::default(), StencilState::default()],
            depth_test_enabled: false,
            depth_func: 0,
            depth_write_mask: false,
            blend_enabled: false,
            blend_rgb_state: BlendState::default(),
            blend_a_state: BlendState::default(),
            blend_color: Vec4::splat(0.0),
            dither_enabled: false,
            color_mask: [false; 4],
        }
    }
}

/// `gls::InteractionTestUtil::RenderCommand`
#[derive(Debug, Clone, Copy)]
pub struct RenderCommand {
    pub quad: IntegerQuad,
    pub state: RenderState,
}

/// `getRandomColor` (file-local upstream helper).
fn get_random_color(rnd: &mut Random) -> Vec4 {
    const COMPONENTS: [f32; 7] = [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0];
    Vec4::new(
        *rnd.choose(&COMPONENTS),
        *rnd.choose(&COMPONENTS),
        *rnd.choose(&COMPONENTS),
        *rnd.choose(&COMPONENTS),
    )
}

/// `computeRandomRenderState`
pub fn compute_random_render_state(
    rnd: &mut Random,
    api_type: ApiType,
    target_width: i32,
    target_height: i32,
) -> RenderState {
    const SCISSOR_TEST_PROBABILITY: f32 = 0.2;
    const STENCIL_TEST_PROBABILITY: f32 = 0.4;
    const DEPTH_TEST_PROBABILITY: f32 = 0.6;
    const BLEND_PROBABILITY: f32 = 0.4;
    const DITHER_PROBABILITY: f32 = 0.5;

    const DEPTH_WRITE_PROBABILITY: f32 = 0.7;
    const COLOR_WRITE_PROBABILITY: f32 = 0.7;

    const MIN_STENCIL_VAL: i32 = -3;
    const MAX_STENCIL_VAL: i32 = 260;

    const MAX_SCISSOR_OUT_OF_BOUNDS: i32 = 10;
    const MIN_SCISSOR_SIZE: f32 = 0.7;

    use crate::glw::{
        GL_ALWAYS, GL_CONSTANT_ALPHA, GL_CONSTANT_COLOR, GL_DECR, GL_DECR_WRAP, GL_DST_ALPHA, GL_DST_COLOR, GL_EQUAL,
        GL_FUNC_ADD, GL_FUNC_REVERSE_SUBTRACT, GL_FUNC_SUBTRACT, GL_GEQUAL, GL_GREATER, GL_INCR, GL_INCR_WRAP,
        GL_INVERT, GL_KEEP, GL_LEQUAL, GL_LESS, GL_MAX, GL_MIN, GL_NEVER, GL_NOTEQUAL, GL_ONE,
        GL_ONE_MINUS_CONSTANT_ALPHA, GL_ONE_MINUS_CONSTANT_COLOR, GL_ONE_MINUS_DST_ALPHA, GL_ONE_MINUS_DST_COLOR,
        GL_ONE_MINUS_SRC_ALPHA, GL_ONE_MINUS_SRC_COLOR, GL_REPLACE, GL_SRC_ALPHA, GL_SRC_ALPHA_SATURATE, GL_SRC_COLOR,
        GL_ZERO,
    };

    const COMPARE_FUNCS: [GLenum; 8] = [
        GL_NEVER,
        GL_ALWAYS,
        GL_LESS,
        GL_LEQUAL,
        GL_EQUAL,
        GL_GEQUAL,
        GL_GREATER,
        GL_NOTEQUAL,
    ];
    const STENCIL_OPS: [GLenum; 8] = [
        GL_KEEP,
        GL_ZERO,
        GL_REPLACE,
        GL_INCR,
        GL_DECR,
        GL_INVERT,
        GL_INCR_WRAP,
        GL_DECR_WRAP,
    ];
    const BLEND_EQUATIONS: [GLenum; 5] = [GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT, GL_MIN, GL_MAX];
    const BLEND_FUNCS: [GLenum; 15] = [
        GL_ZERO,
        GL_ONE,
        GL_SRC_COLOR,
        GL_ONE_MINUS_SRC_COLOR,
        GL_DST_COLOR,
        GL_ONE_MINUS_DST_COLOR,
        GL_SRC_ALPHA,
        GL_ONE_MINUS_SRC_ALPHA,
        GL_DST_ALPHA,
        GL_ONE_MINUS_DST_ALPHA,
        GL_CONSTANT_COLOR,
        GL_ONE_MINUS_CONSTANT_COLOR,
        GL_CONSTANT_ALPHA,
        GL_ONE_MINUS_CONSTANT_ALPHA,
        GL_SRC_ALPHA_SATURATE,
    ];
    const BLEND_EQUATIONS_ES2: [GLenum; 3] = [GL_FUNC_ADD, GL_FUNC_SUBTRACT, GL_FUNC_REVERSE_SUBTRACT];
    const BLEND_FUNCS_DST_ES2: [GLenum; 14] = [
        GL_ZERO,
        GL_ONE,
        GL_SRC_COLOR,
        GL_ONE_MINUS_SRC_COLOR,
        GL_DST_COLOR,
        GL_ONE_MINUS_DST_COLOR,
        GL_SRC_ALPHA,
        GL_ONE_MINUS_SRC_ALPHA,
        GL_DST_ALPHA,
        GL_ONE_MINUS_DST_ALPHA,
        GL_CONSTANT_COLOR,
        GL_ONE_MINUS_CONSTANT_COLOR,
        GL_CONSTANT_ALPHA,
        GL_ONE_MINUS_CONSTANT_ALPHA,
    ];

    let mut state = RenderState {
        scissor_test_enabled: rnd.get_float() < SCISSOR_TEST_PROBABILITY,
        stencil_test_enabled: rnd.get_float() < STENCIL_TEST_PROBABILITY,
        depth_test_enabled: rnd.get_float() < DEPTH_TEST_PROBABILITY,
        blend_enabled: rnd.get_float() < BLEND_PROBABILITY,
        dither_enabled: rnd.get_float() < DITHER_PROBABILITY,
        ..RenderState::default()
    };

    if state.scissor_test_enabled {
        let min_scissor_w = (MIN_SCISSOR_SIZE * target_width as f32).ceil() as i32;
        let min_scissor_h = (MIN_SCISSOR_SIZE * target_height as f32).ceil() as i32;
        let max_scissor_w = target_width + 2 * MAX_SCISSOR_OUT_OF_BOUNDS;
        let max_scissor_h = target_height + 2 * MAX_SCISSOR_OUT_OF_BOUNDS;

        let scissor_w = rnd.get_int(min_scissor_w, max_scissor_w);
        let scissor_h = rnd.get_int(min_scissor_h, max_scissor_h);
        let scissor_x = rnd.get_int(
            -MAX_SCISSOR_OUT_OF_BOUNDS,
            target_width + MAX_SCISSOR_OUT_OF_BOUNDS - scissor_w,
        );
        let scissor_y = rnd.get_int(
            -MAX_SCISSOR_OUT_OF_BOUNDS,
            target_height + MAX_SCISSOR_OUT_OF_BOUNDS - scissor_h,
        );

        state.scissor_rectangle = WindowRectangle {
            left: scissor_x,
            bottom: scissor_y,
            width: scissor_w,
            height: scissor_h,
        };
    }

    if state.stencil_test_enabled {
        for ndx in 0..2 {
            state.stencil[ndx] = StencilState {
                function: *rnd.choose(&COMPARE_FUNCS),
                reference: rnd.get_int(MIN_STENCIL_VAL, MAX_STENCIL_VAL),
                compare_mask: rnd.get_uint32(),
                stencil_fail_op: *rnd.choose(&STENCIL_OPS),
                depth_fail_op: *rnd.choose(&STENCIL_OPS),
                depth_pass_op: *rnd.choose(&STENCIL_OPS),
                write_mask: rnd.get_uint32(),
            };
        }
    }

    if state.depth_test_enabled {
        state.depth_func = *rnd.choose(&COMPARE_FUNCS);
        state.depth_write_mask = rnd.get_float() < DEPTH_WRITE_PROBABILITY;
    }

    if state.blend_enabled {
        if api_type == ApiType::es(2, 0) {
            state.blend_rgb_state = BlendState {
                equation: *rnd.choose(&BLEND_EQUATIONS_ES2),
                src_func: *rnd.choose(&BLEND_FUNCS),
                dst_func: *rnd.choose(&BLEND_FUNCS_DST_ES2),
            };
            state.blend_a_state = BlendState {
                equation: *rnd.choose(&BLEND_EQUATIONS_ES2),
                src_func: *rnd.choose(&BLEND_FUNCS),
                dst_func: *rnd.choose(&BLEND_FUNCS_DST_ES2),
            };
        } else {
            state.blend_rgb_state = BlendState {
                equation: *rnd.choose(&BLEND_EQUATIONS),
                src_func: *rnd.choose(&BLEND_FUNCS),
                dst_func: *rnd.choose(&BLEND_FUNCS),
            };
            state.blend_a_state = BlendState {
                equation: *rnd.choose(&BLEND_EQUATIONS),
                src_func: *rnd.choose(&BLEND_FUNCS),
                dst_func: *rnd.choose(&BLEND_FUNCS),
            };
        }

        state.blend_color = get_random_color(rnd);
    }

    for ndx in 0..4 {
        state.color_mask[ndx] = rnd.get_float() < COLOR_WRITE_PROBABILITY;
    }

    state
}

/// `computeRandomQuad`
pub fn compute_random_quad(rnd: &mut Random, target_width: i32, target_height: i32) -> IntegerQuad {
    // In viewport coordinates. Not using depth 1.0 since clearing with 1.0 and
    // rendering with 1.0 may not be the same value.
    const DEPTH_VALUES: [f32; 8] = [0.0, 0.2, 0.4, 0.5, 0.51, 0.6, 0.8, 0.95];

    const MAX_OUT_OF_BOUNDS: i32 = 0;
    const MIN_SIZE: f32 = 0.5;

    let min_w = (MIN_SIZE * target_width as f32).ceil() as i32;
    let min_h = (MIN_SIZE * target_height as f32).ceil() as i32;
    let max_w = target_width + 2 * MAX_OUT_OF_BOUNDS;
    let max_h = target_height + 2 * MAX_OUT_OF_BOUNDS;

    let width = rnd.get_int(min_w, max_w);
    let height = rnd.get_int(min_h, max_h);
    let x = rnd.get_int(-MAX_OUT_OF_BOUNDS, target_width + MAX_OUT_OF_BOUNDS - width);
    let y = rnd.get_int(-MAX_OUT_OF_BOUNDS, target_height + MAX_OUT_OF_BOUNDS - height);

    let flip_x = rnd.get_bool();
    let flip_y = rnd.get_bool();

    let depth = *rnd.choose(&DEPTH_VALUES);

    let pos_a = IVec2::new(
        if flip_x { x + width - 1 } else { x },
        if flip_y { y + height - 1 } else { y },
    );
    let pos_b = IVec2::new(
        if flip_x { x } else { x + width - 1 },
        if flip_y { y } else { y + height - 1 },
    );

    let mut quad = IntegerQuad {
        pos_a: [pos_a.x(), pos_a.y()],
        pos_b: [pos_b.x(), pos_b.y()],
        ..IntegerQuad::default()
    };
    for c in quad.color.iter_mut() {
        let color = get_random_color(rnd);
        *c = [color.x(), color.y(), color.z(), color.w()];
    }
    quad.depth = [depth; 4];
    quad
}

/// `computeRandomRenderCommands`
pub fn compute_random_render_commands(
    rnd: &mut Random,
    api_type: ApiType,
    num_commands: usize,
    target_w: i32,
    target_h: i32,
) -> Vec<RenderCommand> {
    (0..num_commands)
        .map(|_| RenderCommand {
            state: compute_random_render_state(rnd, api_type, target_w, target_h),
            quad: compute_random_quad(rnd, target_w, target_h),
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    /// `computeRandomRenderCommands` must be deterministic in a seed - the whole point
    /// of using `tcu::Random` instead of a true RNG is that two iterations with the same
    /// seed must produce the same draw sequence (`fragment_ops.random`'s own iteration
    /// re-derives its seed from `m_seed`/`m_iterNdx` precisely so a failing iteration
    /// can be reproduced).
    #[test]
    fn same_seed_produces_identical_commands() {
        let mut rnd_a = Random::new(12345);
        let mut rnd_b = Random::new(12345);
        let cmds_a = compute_random_render_commands(&mut rnd_a, ApiType::es(2, 0), 8, 128, 128);
        let cmds_b = compute_random_render_commands(&mut rnd_b, ApiType::es(2, 0), 8, 128, 128);

        for (a, b) in cmds_a.iter().zip(cmds_b.iter()) {
            assert_eq!(a.quad.pos_a, b.quad.pos_a);
            assert_eq!(a.quad.pos_b, b.quad.pos_b);
            assert_eq!(a.quad.depth, b.quad.depth);
            assert_eq!(a.state.scissor_test_enabled, b.state.scissor_test_enabled);
            assert_eq!(a.state.blend_enabled, b.state.blend_enabled);
            assert_eq!(a.state.color_mask, b.state.color_mask);
        }
    }

    /// A different seed must (overwhelmingly likely) diverge somewhere - guards against
    /// a copy-paste bug that ignores the `Random` entirely and returns a constant
    /// sequence.
    #[test]
    fn different_seeds_diverge() {
        let mut rnd_a = Random::new(1);
        let mut rnd_b = Random::new(2);
        let cmds_a = compute_random_render_commands(&mut rnd_a, ApiType::es(2, 0), 16, 128, 128);
        let cmds_b = compute_random_render_commands(&mut rnd_b, ApiType::es(2, 0), 16, 128, 128);

        let any_different = cmds_a
            .iter()
            .zip(cmds_b.iter())
            .any(|(a, b)| a.quad.pos_a != b.quad.pos_a || a.state.blend_enabled != b.state.blend_enabled);
        assert!(any_different);
    }

    /// Every generated scissor rectangle must respect the documented size/position
    /// bounds (`minScissorSize` of the target, up to `maxScissorOutOfBounds` outside
    /// it), a hand-verifiable invariant straight from `computeRandomRenderState`'s own
    /// constants.
    #[test]
    fn scissor_rectangle_respects_its_documented_bounds() {
        let mut rnd = Random::new(42);
        let target_w = 100;
        let target_h = 100;
        let mut saw_scissor = false;

        for _ in 0..500 {
            let state = compute_random_render_state(&mut rnd, ApiType::es(3, 0), target_w, target_h);
            if !state.scissor_test_enabled {
                continue;
            }
            saw_scissor = true;
            let r = state.scissor_rectangle;
            assert!(r.width >= (0.7 * target_w as f32).ceil() as i32);
            assert!(r.height >= (0.7 * target_h as f32).ceil() as i32);
            assert!(r.left >= -10 && r.left + r.width <= target_w + 10);
            assert!(r.bottom >= -10 && r.bottom + r.height <= target_h + 10);
        }
        assert!(
            saw_scissor,
            "500 draws at a 0.2 probability must have hit the scissor-enabled branch at least once"
        );
    }

    /// `compute_random_quad`'s width/height must never go below `minSize` of the
    /// target, and the flip logic must keep `pos_a`/`pos_b` as the two opposite corners
    /// of that same rectangle regardless of which corner `flipX`/`flipY` picked as `A`.
    #[test]
    fn quad_bounds_and_flip_invariant_hold() {
        let mut rnd = Random::new(7);
        for _ in 0..200 {
            let quad = compute_random_quad(&mut rnd, 64, 64);
            let w = (quad.pos_a[0] - quad.pos_b[0]).unsigned_abs() + 1;
            let h = (quad.pos_a[1] - quad.pos_b[1]).unsigned_abs() + 1;
            assert!(w >= (0.5 * 64.0f32).ceil() as u32);
            assert!(h >= (0.5 * 64.0f32).ceil() as u32);
            assert!(quad.depth.iter().all(|&d| d == quad.depth[0]));
        }
    }

    /// ES2 blend state must only ever draw from the three-equation ES2 table and the
    /// ES2 destination-function table (which excludes `GL_SRC_ALPHA_SATURATE`) - the
    /// one behavioural difference `computeRandomRenderState` has between API versions.
    #[test]
    fn es2_blend_state_stays_within_the_es2_tables() {
        use crate::glw::{GL_FUNC_ADD, GL_FUNC_REVERSE_SUBTRACT, GL_FUNC_SUBTRACT, GL_SRC_ALPHA_SATURATE};

        let mut rnd = Random::new(99);
        for _ in 0..500 {
            let state = compute_random_render_state(&mut rnd, ApiType::es(2, 0), 64, 64);
            if !state.blend_enabled {
                continue;
            }
            for eq in [state.blend_rgb_state.equation, state.blend_a_state.equation] {
                assert!(matches!(eq, GL_FUNC_ADD | GL_FUNC_SUBTRACT | GL_FUNC_REVERSE_SUBTRACT));
            }
            assert_ne!(state.blend_rgb_state.dst_func, GL_SRC_ALPHA_SATURATE);
            assert_ne!(state.blend_a_state.dst_func, GL_SRC_ALPHA_SATURATE);
        }
    }
}
