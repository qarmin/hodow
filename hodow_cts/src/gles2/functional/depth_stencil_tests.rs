// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDepthStencilTests.cpp
//   modules/gles3/functional/es3fDepthStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One port for both roots, unlike the blend tests next door: upstream's es2f and es3f
// copies of this file are identical apart from the header, the namespace and the one
// line that picks the `QuadRenderer`'s GLSL version, so `create_tests` takes that as a
// parameter rather than the file being duplicated. `diff` the two upstream files before
// changing anything here - if they ever grow apart, this has to split.
//
// The verdict needs no rasterised reference. The case paints a 4x4 grid of stencil
// values with scissored clears and a 4x4x3 grid of depth values with depth-only quads,
// draws one full-viewport quad under the depth/stencil state being tested, and then
// *visualises* the resulting buffers by drawing quads that only pass where the depth or
// stencil value is in a given band, each writing one colour channel. The comparison is
// `tcu::pixelThresholdCompare` against the same sequence run through
// `rr::FragmentProcessor` on the host.

use crate::gls::fragment_op_util::{
    IntegerQuad, Quad, QuadRenderer, QuadRendererGlslVersion, ReferenceQuadRenderer, get_multisample_access,
};
use crate::glu::{self, ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLbitfield, GLenum};
use crate::rr::render_state::{BlendMode, FaceType, FragmentOperationState, StencilState, WindowRectangle};
use crate::sglr::reference_utils::{map_gl_stencil_op, map_gl_test_func};
use crate::tcu::Surface;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel, clear, clear_stencil};
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

const VIEWPORT_WIDTH: i32 = 4 * 3 * 4;
const VIEWPORT_HEIGHT: i32 = 4 * 12;

const NUM_RANDOM_CASES: usize = 25;
const NUM_RANDOM_SUB_CASES: usize = 10;

fn face_ndx(face: FaceType) -> usize {
    face as usize
}

fn other_face(face: FaceType) -> FaceType {
    if face == FaceType::Front {
        FaceType::Back
    } else {
        FaceType::Front
    }
}

/// `DepthStencilCaseUtil::StencilParams`
#[derive(Debug, Clone, Copy, Default)]
struct StencilParams {
    function: GLenum,
    reference: i32,
    compare_mask: u32,
    stencil_fail_op: GLenum,
    depth_fail_op: GLenum,
    depth_pass_op: GLenum,
    write_mask: u32,
}

/// `DepthStencilCaseUtil::DepthStencilParams`
#[derive(Debug, Clone, Copy)]
struct DepthStencilParams {
    /// Quad visible face.
    visible_face: FaceType,
    stencil_test_enabled: bool,
    stencil: [StencilParams; 2],
    depth_test_enabled: bool,
    depth_func: GLenum,
    depth: f32,
    depth_write_mask: bool,
}

impl Default for DepthStencilParams {
    fn default() -> Self {
        Self {
            // Upstream's default is `FACETYPE_LAST`; every case sets this before use.
            visible_face: FaceType::Front,
            stencil_test_enabled: false,
            stencil: [StencilParams::default(); 2],
            depth_test_enabled: false,
            depth_func: 0,
            depth: 0.0,
            depth_write_mask: false,
        }
    }
}

/// `DepthStencilCaseUtil::ClearCommand`
///
/// \note No depth here - don't use clears for setting depth values; use quad rendering
/// instead. Cleared depths are in [0, 1] to begin with, whereas rendered depths are
/// given in [-1, 1] and then mapped to [0, 1]; this discrepancy could cause precision
/// issues in depth tests.
#[derive(Debug, Clone, Copy)]
struct ClearCommand {
    rect: WindowRectangle,
    buffers: GLbitfield,
    color: [f32; 4],
    stencil: i32,
}

/// `DepthStencilCaseUtil::RenderCommand`
#[derive(Debug, Clone, Copy)]
struct RenderCommand {
    params: DepthStencilParams,
    rect: WindowRectangle,
    color: [f32; 4],
    color_mask: [bool; 4],
}

impl Default for RenderCommand {
    fn default() -> Self {
        Self {
            params: DepthStencilParams::default(),
            rect: WindowRectangle {
                left: 0,
                bottom: 0,
                width: 0,
                height: 0,
            },
            color: [0.0; 4],
            color_mask: [false; 4],
        }
    }
}

/// `DepthStencilCaseUtil::RefRenderCommand`
struct RefRenderCommand {
    quad: IntegerQuad,
    state: FragmentOperationState,
}

/// `DepthStencilCaseUtil::TestRenderTarget`
#[derive(Debug, Clone, Copy)]
struct TestRenderTarget {
    width: i32,
    height: i32,
    depth_bits: i32,
    stencil_bits: i32,
}

/// `DepthStencilCaseUtil::getStencilTestValues`
fn get_stencil_test_values(stencil_bits: i32, num_values: usize) -> Vec<i32> {
    let mut values = vec![0i32; num_values];
    let num_lowest = num_values / 2;
    let num_highest = num_values - num_lowest;
    let max_val = (1 << stencil_bits) - 1;

    for (ndx, v) in values.iter_mut().enumerate().take(num_lowest) {
        *v = ndx as i32;
    }

    for ndx in 0..num_highest {
        values[num_values - ndx - 1] = max_val - ndx as i32;
    }

    values
}

/// `DepthStencilCaseUtil::generateBaseClearAndDepthCommands`
///
/// `None` is upstream's `throw tcu::NotSupportedError("Too small render target")`.
fn generate_base_clear_and_depth_commands(
    target: &TestRenderTarget,
) -> Option<(Vec<ClearCommand>, Vec<RenderCommand>)> {
    let num_l0_cells_x = 4;
    let num_l0_cells_y = 4;
    let num_l1_cells_x = 3;
    let num_l1_cells_y = 1;
    let cell_l0_width = target.width / num_l0_cells_x;
    let cell_l0_height = target.height / num_l0_cells_y;
    let cell_l1_width = cell_l0_width / num_l1_cells_x;
    let cell_l1_height = cell_l0_height / num_l1_cells_y;

    if cell_l0_width <= 0 || cell_l1_width <= 0 || cell_l0_height <= 0 || cell_l1_height <= 0 {
        return None;
    }

    let mut clear_commands = Vec::new();
    let mut render_commands = Vec::new();

    // Fullscreen clear to black.
    clear_commands.push(ClearCommand {
        rect: WindowRectangle {
            left: 0,
            bottom: 0,
            width: target.width,
            height: target.height,
        },
        buffers: glw::GL_COLOR_BUFFER_BIT,
        color: [0.0, 0.0, 0.0, 1.0],
        stencil: 0,
    });

    // Compute stencil values: numL0CellsX*numL0CellsY combinations of lowest and highest bits.
    let stencil_values = get_stencil_test_values(target.stencil_bits, (num_l0_cells_x * num_l0_cells_y) as usize);

    // Compute depth values
    let depth_values: Vec<f32> = {
        let num_values = num_l1_cells_x * num_l1_cells_y;
        let depth_step = 2.0 / (num_values - 1) as f32;
        (0..num_values).map(|ndx| -1.0 + depth_step * ndx as f32).collect()
    };

    for y0 in 0..num_l0_cells_y {
        for x0 in 0..num_l0_cells_x {
            let stencil_value = stencil_values[(y0 * num_l0_cells_x + x0) as usize];

            for y1 in 0..num_l1_cells_y {
                for x1 in 0..num_l1_cells_x {
                    let x = x0 * cell_l0_width + x1 * cell_l1_width;
                    let y = y0 * cell_l0_height + y1 * cell_l1_height;
                    let cell_l1_rect = WindowRectangle {
                        left: x,
                        bottom: y,
                        width: cell_l1_width,
                        height: cell_l1_height,
                    };

                    clear_commands.push(ClearCommand {
                        rect: cell_l1_rect,
                        buffers: glw::GL_STENCIL_BUFFER_BIT,
                        color: [0.0; 4],
                        stencil: stencil_value,
                    });

                    let mut render_cmd = RenderCommand::default();
                    render_cmd.params.visible_face = FaceType::Front;
                    render_cmd.params.depth = depth_values[(y1 * num_l1_cells_x + x1) as usize];
                    render_cmd.params.depth_test_enabled = true;
                    render_cmd.params.depth_func = glw::GL_ALWAYS;
                    render_cmd.params.depth_write_mask = true;
                    render_cmd.color_mask = [false; 4];
                    render_cmd.rect = cell_l1_rect;

                    render_commands.push(render_cmd);
                }
            }
        }
    }

    Some((clear_commands, render_commands))
}

/// `DepthStencilCaseUtil::generateDepthVisualizeCommands`
fn generate_depth_visualize_commands(target: &TestRenderTarget, commands: &mut Vec<RenderCommand>) {
    const EPSILON: f32 = -0.05;
    const DEPTH_STEPS: [f32; 5] = [-1.0, -0.5, 0.0, 0.5, 1.0];
    let num_steps = DEPTH_STEPS.len();
    let color_step = 1.0 / (num_steps - 1) as f32;

    for (ndx, &depth_step) in DEPTH_STEPS.iter().enumerate() {
        let mut cmd = RenderCommand::default();

        cmd.params.visible_face = FaceType::Front;
        cmd.rect = WindowRectangle {
            left: 0,
            bottom: 0,
            width: target.width,
            height: target.height,
        };
        cmd.color = [0.0, 0.0, color_step * ndx as f32, 0.0];
        cmd.color_mask = [false, false, true, false];
        cmd.params.depth = depth_step + EPSILON;
        cmd.params.depth_test_enabled = true;
        cmd.params.depth_func = glw::GL_LESS;
        cmd.params.depth_write_mask = false;

        commands.push(cmd);
    }
}

/// `DepthStencilCaseUtil::generateStencilVisualizeCommands`
fn generate_stencil_visualize_commands(target: &TestRenderTarget, commands: &mut Vec<RenderCommand>) {
    const NUM_VALUES: usize = 4 * 4;
    // 0 is reserved for non-matching.
    let color_step = 1.0 / NUM_VALUES as f32;
    let stencil_values = get_stencil_test_values(target.stencil_bits, NUM_VALUES);

    for (ndx, &stencil_value) in stencil_values.iter().enumerate() {
        let mut cmd = RenderCommand::default();

        cmd.params.visible_face = FaceType::Front;
        cmd.rect = WindowRectangle {
            left: 0,
            bottom: 0,
            width: target.width,
            height: target.height,
        };
        cmd.color = [0.0, color_step * (ndx + 1) as f32, 0.0, 0.0];
        cmd.color_mask = [false, true, false, false];
        cmd.params.stencil_test_enabled = true;

        let front = StencilParams {
            function: glw::GL_EQUAL,
            reference: stencil_value,
            compare_mask: !0,
            stencil_fail_op: glw::GL_KEEP,
            depth_fail_op: glw::GL_KEEP,
            depth_pass_op: glw::GL_KEEP,
            write_mask: 0,
        };
        cmd.params.stencil[face_ndx(FaceType::Front)] = front;
        cmd.params.stencil[face_ndx(FaceType::Back)] = front;

        commands.push(cmd);
    }
}

/// `DepthStencilCaseUtil::translateStencilState`
fn translate_stencil_state(src: &StencilParams) -> StencilState {
    StencilState {
        func: map_gl_test_func(src.function).expect("a compare function from this file's own tables"),
        reference: src.reference,
        comp_mask: src.compare_mask,
        s_fail: map_gl_stencil_op(src.stencil_fail_op).expect("a stencil op from this file's own tables"),
        dp_fail: map_gl_stencil_op(src.depth_fail_op).expect("a stencil op from this file's own tables"),
        dp_pass: map_gl_stencil_op(src.depth_pass_op).expect("a stencil op from this file's own tables"),
        write_mask: src.write_mask,
    }
}

/// `DepthStencilCaseUtil::translateCommand`
fn translate_command(src: &RenderCommand, render_target: &TestRenderTarget) -> RefRenderCommand {
    const FAR: f32 = 1.0;
    const NEAR: f32 = 0.0;
    let has_depth = render_target.depth_bits > 0;
    let has_stencil = render_target.stencil_bits > 0;
    let is_front_facing = src.params.visible_face == FaceType::Front;

    let mut quad = IntegerQuad {
        pos_a: [
            if is_front_facing {
                src.rect.left
            } else {
                src.rect.left + src.rect.width - 1
            },
            src.rect.bottom,
        ],
        pos_b: [
            if is_front_facing {
                src.rect.left + src.rect.width - 1
            } else {
                src.rect.left
            },
            src.rect.bottom + src.rect.height - 1,
        ],
        color: [[0.0; 4]; 4],
        color1: [[0.0; 4]; 4],
        depth: [0.0; 4],
    };
    quad.color = [src.color; 4];
    quad.depth = [((FAR - NEAR) / 2.0) * src.params.depth + (NEAR + FAR) / 2.0; 4];

    let mut state = FragmentOperationState {
        color_mask: src.color_mask,
        scissor_test_enabled: false,
        stencil_test_enabled: has_stencil && src.params.stencil_test_enabled,
        depth_test_enabled: has_depth && src.params.depth_test_enabled,
        blend_mode: BlendMode::None,
        num_stencil_bits: render_target.stencil_bits,
        ..FragmentOperationState::default()
    };

    if state.depth_test_enabled {
        state.depth_func =
            map_gl_test_func(src.params.depth_func).expect("a compare function from this file's own tables");
        state.depth_mask = src.params.depth_write_mask;
    }

    if state.stencil_test_enabled {
        state.stencil_states[face_ndx(FaceType::Back)] =
            translate_stencil_state(&src.params.stencil[face_ndx(FaceType::Back)]);
        state.stencil_states[face_ndx(FaceType::Front)] =
            translate_stencil_state(&src.params.stencil[face_ndx(FaceType::Front)]);
    }

    RefRenderCommand { quad, state }
}

/// `DepthStencilCaseUtil::render(const vector<ClearCommand>&, int, int)`
fn render_clears(gl: &glw::Functions, clears: &[ClearCommand], viewport_x: i32, viewport_y: i32) {
    // SAFETY: plain clear state on a current context.
    unsafe {
        gl.enable(glw::GL_SCISSOR_TEST);

        for clear_cmd in clears {
            if clear_cmd.buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
                gl.clear_color(
                    clear_cmd.color[0],
                    clear_cmd.color[1],
                    clear_cmd.color[2],
                    clear_cmd.color[3],
                );
            }
            if clear_cmd.buffers & glw::GL_STENCIL_BUFFER_BIT != 0 {
                gl.clear_stencil(clear_cmd.stencil);
            }

            gl.scissor(
                clear_cmd.rect.left + viewport_x,
                clear_cmd.rect.bottom + viewport_y,
                clear_cmd.rect.width,
                clear_cmd.rect.height,
            );
            gl.clear(clear_cmd.buffers);
        }

        gl.disable(glw::GL_SCISSOR_TEST);
    }
}

/// `DepthStencilCaseUtil::render(QuadRenderer&, const RenderCommand&, int, int)`
fn render_command(
    gl: &glw::Functions,
    renderer: &QuadRenderer<'_>,
    command: &RenderCommand,
    viewport_x: i32,
    viewport_y: i32,
) {
    // SAFETY: plain depth/stencil/colour-mask state on a current context.
    unsafe {
        if command.params.stencil_test_enabled {
            gl.enable(glw::GL_STENCIL_TEST);

            for face in [FaceType::Front, FaceType::Back] {
                let gl_face = if face == FaceType::Back {
                    glw::GL_BACK
                } else {
                    glw::GL_FRONT
                };
                let s_params = &command.params.stencil[face_ndx(face)];

                gl.stencil_func_separate(gl_face, s_params.function, s_params.reference, s_params.compare_mask);
                gl.stencil_op_separate(
                    gl_face,
                    s_params.stencil_fail_op,
                    s_params.depth_fail_op,
                    s_params.depth_pass_op,
                );
                gl.stencil_mask_separate(gl_face, s_params.write_mask);
            }
        } else {
            gl.disable(glw::GL_STENCIL_TEST);
        }

        if command.params.depth_test_enabled {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(command.params.depth_func);
            gl.depth_mask(if command.params.depth_write_mask {
                glw::TRUE
            } else {
                glw::FALSE
            });
        } else {
            gl.disable(glw::GL_DEPTH_TEST);
        }

        let mask = command.color_mask.map(|m| if m { glw::TRUE } else { glw::FALSE });
        gl.color_mask(mask[0], mask[1], mask[2], mask[3]);
        gl.viewport(
            command.rect.left + viewport_x,
            command.rect.bottom + viewport_y,
            command.rect.width,
            command.rect.height,
        );
    }

    let is_front_facing = command.params.visible_face == FaceType::Front;
    let quad = Quad {
        pos_a: [if is_front_facing { -1.0 } else { 1.0 }, -1.0],
        pos_b: [if is_front_facing { 1.0 } else { -1.0 }, 1.0],
        color: [command.color; 4],
        color1: [[0.0; 4]; 4],
        depth: [command.params.depth; 4],
    };

    renderer.render(gl, &quad);
}

/// `DepthStencilCaseUtil::renderReference`
fn render_reference(
    clears: &[ClearCommand],
    dst_color: &mut PixelBufferAccess<'_>,
    dst_stencil: &mut PixelBufferAccess<'_>,
    stencil_bits: i32,
) {
    for clear_cmd in clears {
        if clear_cmd.buffers & glw::GL_COLOR_BUFFER_BIT != 0 {
            let mut region = dst_color.get_subregion(
                clear_cmd.rect.left as u32,
                clear_cmd.rect.bottom as u32,
                0,
                clear_cmd.rect.width as u32,
                clear_cmd.rect.height as u32,
                1,
            );
            clear(&mut region, clear_cmd.color);
        }

        if clear_cmd.buffers & glw::GL_STENCIL_BUFFER_BIT != 0 && stencil_bits > 0 {
            let masked_val = clear_cmd.stencil & ((1 << stencil_bits) - 1);
            let mut region = dst_stencil.get_subregion(
                clear_cmd.rect.left as u32,
                clear_cmd.rect.bottom as u32,
                0,
                clear_cmd.rect.width as u32,
                clear_cmd.rect.height as u32,
                1,
            );
            clear_stencil(&mut region, masked_val as u32);
        }
    }
}

/// `DepthStencilCase::init` + `iterate`, the latter looped over the case's parameter
/// sets where upstream returns `CONTINUE` and is re-entered.
fn depth_stencil_case(
    case: &mut ApiCase<'_>,
    name_hash: u32,
    cases: &[DepthStencilParams],
    glsl_version: QuadRendererGlslVersion,
) {
    let target = case.context().render_target();

    // Compute render target.
    let viewport_w = target.width.min(VIEWPORT_WIDTH);
    let viewport_h = target.height.min(VIEWPORT_HEIGHT);
    let render_target = TestRenderTarget {
        width: viewport_w,
        height: viewport_h,
        depth_bits: target.depth_bits,
        stencil_bits: target.stencil_bits,
    };

    // Compute base clears & visualization commands.
    let Some((base_clears, base_depth_renders)) = generate_base_clear_and_depth_commands(&render_target) else {
        case.not_supported("Too small render target".to_string());
        return;
    };
    let mut visualize_commands = Vec::new();
    generate_depth_visualize_commands(&render_target, &mut visualize_commands);
    generate_stencil_visualize_commands(&render_target, &mut visualize_commands);

    // Translate to ref commands.
    let ref_base_depth_renders: Vec<RefRenderCommand> = base_depth_renders
        .iter()
        .map(|cmd| translate_command(cmd, &render_target))
        .collect();
    let ref_visualize_commands: Vec<RefRenderCommand> = visualize_commands
        .iter()
        .map(|cmd| translate_command(cmd, &render_target))
        .collect();

    let gl = case.gl();
    let renderer = match QuadRenderer::new(gl, glsl_version) {
        Ok(renderer) => renderer,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };
    let mut ref_color_buffer = Surface::new(viewport_w, viewport_h);
    let depth_format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);
    let stencil_format = TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT32);
    let (Ok(mut ref_depth_buffer), Ok(mut ref_stencil_buffer)) = (
        TextureLevel::new(depth_format, viewport_w as u32, viewport_h as u32, 1),
        TextureLevel::new(stencil_format, viewport_w as u32, viewport_h as u32, 1),
    ) else {
        case.fail(
            "Could not allocate the reference depth/stencil buffers".to_string(),
            "Fail",
        );
        return;
    };
    let mut ref_renderer = ReferenceQuadRenderer::new();

    let threshold = target.pixel_format().get_color_threshold();

    for (iter_ndx, iter_params) in cases.iter().enumerate() {
        let mut rnd = Random::new(name_hash ^ de_int32_hash(iter_ndx as i32));
        let viewport_x = rnd.get_int(0, target.width - render_target.width);
        let viewport_y = rnd.get_int(0, target.height - render_target.height);
        let mut rendered_img = Surface::new(render_target.width, render_target.height);

        // Fill in test command for this iteration.
        let test_cmd = RenderCommand {
            params: *iter_params,
            rect: WindowRectangle {
                left: 0,
                bottom: 0,
                width: render_target.width,
                height: render_target.height,
            },
            color: [1.0, 0.0, 0.0, 1.0],
            color_mask: [true; 4],
        };

        if iter_ndx == 0 {
            log::debug!("Channels:\n  RED: passing pixels\n  GREEN: stencil values\n  BLUE: depth values");
        }
        if cases.len() > 1 {
            log::debug!("Iteration {iter_ndx}...");
        }

        // Submit render commands to GL.

        // Base clears.
        render_clears(gl, &base_clears, viewport_x, viewport_y);

        // Base depths.
        for cmd in &base_depth_renders {
            render_command(gl, &renderer, cmd, viewport_x, viewport_y);
        }

        // Test command.
        render_command(gl, &renderer, &test_cmd, viewport_x, viewport_y);

        // Visualization commands.
        for cmd in &visualize_commands {
            render_command(gl, &renderer, cmd, viewport_x, viewport_y);
        }

        // Re-enable all write masks.
        // SAFETY: plain write-mask state on a current context.
        unsafe {
            gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
            gl.depth_mask(glw::TRUE);
            gl.stencil_mask(!0);

            // Ask GPU to start rendering.
            gl.flush();
        }

        // Render reference while GPU is doing work.
        {
            let ref_test_cmd = translate_command(&test_cmd, &render_target);

            // Base clears.
            render_reference(
                &base_clears,
                &mut ref_color_buffer.get_access(),
                &mut ref_stencil_buffer.get_access(),
                render_target.stencil_bits,
            );

            // Base depths, the test command, then the visualization commands.
            for cmd in ref_base_depth_renders
                .iter()
                .chain(std::iter::once(&ref_test_cmd))
                .chain(ref_visualize_commands.iter())
            {
                ref_renderer.render(
                    &mut get_multisample_access(ref_color_buffer.get_access()),
                    Some(&mut get_multisample_access(ref_depth_buffer.get_access())),
                    Some(&mut get_multisample_access(ref_stencil_buffer.get_access())),
                    &cmd.quad,
                    &cmd.state,
                );
            }
        }

        // Read rendered image.
        if let Err(e) = glu::pixel_transfer::read_pixels(
            &case.context().render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        ) {
            case.fail(e.to_string(), "Fail");
            return;
        }

        // Compare to reference.
        let compare_ok = pixel_threshold_compare(&ref_color_buffer, &rendered_img, threshold).ok;
        log::debug!("{}", if compare_ok { "  Passed." } else { "  FAILED!" });
        if !compare_ok {
            case.fail("Image comparison failed".to_string(), "Image comparison failed");
            return;
        }
    }
}

/// `randomDepthStencilState`
fn random_depth_stencil_state(rnd: &mut Random) -> DepthStencilParams {
    const STENCIL_TEST_PROBABILITY: f32 = 0.8;
    const DEPTH_TEST_PROBABILITY: f32 = 0.7;

    const COMPARE_FUNCS: [GLenum; 8] = [
        glw::GL_NEVER,
        glw::GL_ALWAYS,
        glw::GL_LESS,
        glw::GL_LEQUAL,
        glw::GL_EQUAL,
        glw::GL_GEQUAL,
        glw::GL_GREATER,
        glw::GL_NOTEQUAL,
    ];
    const STENCIL_OPS: [GLenum; 8] = [
        glw::GL_KEEP,
        glw::GL_ZERO,
        glw::GL_REPLACE,
        glw::GL_INCR,
        glw::GL_DECR,
        glw::GL_INVERT,
        glw::GL_INCR_WRAP,
        glw::GL_DECR_WRAP,
    ];
    const DEPTH_VALUES: [f32; 11] = [-1.0, -0.8, -0.6, -0.4, -0.2, 0.0, 0.2, 0.4, 0.6, 0.8, 1.0];

    let mut params = DepthStencilParams::default();

    params.visible_face = if rnd.get_bool() {
        FaceType::Front
    } else {
        FaceType::Back
    };
    params.stencil_test_enabled = rnd.get_float() < STENCIL_TEST_PROBABILITY;
    params.depth_test_enabled = !params.stencil_test_enabled || (rnd.get_float() < DEPTH_TEST_PROBABILITY);

    if params.stencil_test_enabled {
        for ndx in 0..2 {
            params.stencil[ndx].function = *rnd.choose(&COMPARE_FUNCS);
            params.stencil[ndx].reference = rnd.get_int(-2, 260);
            params.stencil[ndx].compare_mask = rnd.get_uint32();
            params.stencil[ndx].stencil_fail_op = *rnd.choose(&STENCIL_OPS);
            params.stencil[ndx].depth_fail_op = *rnd.choose(&STENCIL_OPS);
            params.stencil[ndx].depth_pass_op = *rnd.choose(&STENCIL_OPS);
            params.stencil[ndx].write_mask = rnd.get_uint32();
        }
    }

    if params.depth_test_enabled {
        params.depth_func = *rnd.choose(&COMPARE_FUNCS);
        params.depth = *rnd.choose(&DEPTH_VALUES);
        params.depth_write_mask = rnd.get_bool();
    }

    params
}

fn add_depth_stencil_case(
    group: &mut TestCaseGroup,
    name: impl Into<String>,
    cases: Vec<DepthStencilParams>,
    glsl_version: QuadRendererGlslVersion,
) {
    let name = name.into();
    let name_hash = de_string_hash(&name);
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        depth_stencil_case(case, name_hash, &cases, glsl_version)
    });
}

struct NamedEnum {
    name: &'static str,
    value: GLenum,
}

const COMPARE_FUNCS: [NamedEnum; 8] = [
    NamedEnum {
        name: "never",
        value: glw::GL_NEVER,
    },
    NamedEnum {
        name: "always",
        value: glw::GL_ALWAYS,
    },
    NamedEnum {
        name: "less",
        value: glw::GL_LESS,
    },
    NamedEnum {
        name: "lequal",
        value: glw::GL_LEQUAL,
    },
    NamedEnum {
        name: "equal",
        value: glw::GL_EQUAL,
    },
    NamedEnum {
        name: "gequal",
        value: glw::GL_GEQUAL,
    },
    NamedEnum {
        name: "greater",
        value: glw::GL_GREATER,
    },
    NamedEnum {
        name: "notequal",
        value: glw::GL_NOTEQUAL,
    },
];

const STENCIL_OPS: [NamedEnum; 8] = [
    NamedEnum {
        name: "keep",
        value: glw::GL_KEEP,
    },
    NamedEnum {
        name: "zero",
        value: glw::GL_ZERO,
    },
    NamedEnum {
        name: "replace",
        value: glw::GL_REPLACE,
    },
    NamedEnum {
        name: "incr",
        value: glw::GL_INCR,
    },
    NamedEnum {
        name: "decr",
        value: glw::GL_DECR,
    },
    NamedEnum {
        name: "invert",
        value: glw::GL_INVERT,
    },
    NamedEnum {
        name: "incr_wrap",
        value: glw::GL_INCR_WRAP,
    },
    NamedEnum {
        name: "decr_wrap",
        value: glw::GL_DECR_WRAP,
    },
];

/// The stencil state of the face the quad does *not* show, which upstream sets to the
/// same "replace everything through a zero compare mask" everywhere.
const NOT_VISIBLE_STENCIL: StencilParams = StencilParams {
    function: glw::GL_ALWAYS,
    reference: 0,
    compare_mask: 0,
    stencil_fail_op: glw::GL_REPLACE,
    depth_fail_op: glw::GL_REPLACE,
    depth_pass_op: glw::GL_REPLACE,
    write_mask: !0,
};

struct FunctionCase {
    visible_face: FaceType,
    s_fail: GLenum,
    d_fail: GLenum,
    d_pass: GLenum,
    stencil_ref: i32,
    compare_mask: u32,
    write_mask: u32,
    depth: f32,
}

const FUNCTION_CASES: [FunctionCase; 4] = [
    FunctionCase {
        visible_face: FaceType::Back,
        s_fail: glw::GL_DECR,
        d_fail: glw::GL_INCR,
        d_pass: glw::GL_INVERT,
        stencil_ref: 4,
        compare_mask: !0,
        write_mask: !0,
        depth: -0.7,
    },
    FunctionCase {
        visible_face: FaceType::Front,
        s_fail: glw::GL_DECR,
        d_fail: glw::GL_INCR,
        d_pass: glw::GL_INVERT,
        stencil_ref: 2,
        compare_mask: !0,
        write_mask: !0,
        depth: 0.0,
    },
    FunctionCase {
        visible_face: FaceType::Back,
        s_fail: glw::GL_DECR,
        d_fail: glw::GL_INCR,
        d_pass: glw::GL_INVERT,
        stencil_ref: 1,
        compare_mask: !0,
        write_mask: !0,
        depth: 0.2,
    },
    FunctionCase {
        visible_face: FaceType::Front,
        s_fail: glw::GL_DECR_WRAP,
        d_fail: glw::GL_INVERT,
        d_pass: glw::GL_REPLACE,
        stencil_ref: 4,
        compare_mask: !0,
        write_mask: !0,
        depth: 1.0,
    },
];

struct OpCombinationCase {
    visible_face: FaceType,
    func: GLenum,
    reference: i32,
    compare_mask: u32,
    write_mask: u32,
}

const OP_COMBINATION_CASES: [OpCombinationCase; 4] = [
    OpCombinationCase {
        visible_face: FaceType::Back,
        func: glw::GL_LESS,
        reference: 4,
        compare_mask: !0,
        write_mask: !0,
    },
    OpCombinationCase {
        visible_face: FaceType::Front,
        func: glw::GL_GREATER,
        reference: 2,
        compare_mask: !0,
        write_mask: !0,
    },
    OpCombinationCase {
        visible_face: FaceType::Back,
        func: glw::GL_EQUAL,
        reference: 3,
        compare_mask: !2,
        write_mask: !0,
    },
    OpCombinationCase {
        visible_face: FaceType::Front,
        func: glw::GL_NOTEQUAL,
        reference: 1,
        compare_mask: !0,
        write_mask: !1,
    },
];

/// The front/back stencil state the whole `write_mask` group shares.
fn write_mask_base_params() -> DepthStencilParams {
    let mut params = DepthStencilParams {
        depth_func: glw::GL_LEQUAL,
        depth: 0.0,
        depth_test_enabled: true,
        stencil_test_enabled: true,
        ..DepthStencilParams::default()
    };

    params.stencil[face_ndx(FaceType::Front)] = StencilParams {
        function: glw::GL_NOTEQUAL,
        reference: 1,
        stencil_fail_op: glw::GL_INVERT,
        depth_fail_op: glw::GL_INCR,
        depth_pass_op: glw::GL_DECR,
        compare_mask: !0,
        write_mask: !0,
    };
    params.stencil[face_ndx(FaceType::Back)] = StencilParams {
        function: glw::GL_ALWAYS,
        reference: 0,
        stencil_fail_op: glw::GL_REPLACE,
        depth_fail_op: glw::GL_INVERT,
        depth_pass_op: glw::GL_INCR,
        compare_mask: !0,
        write_mask: !0,
    };

    params
}

/// `DepthStencilTests::init`
pub fn create_tests(glsl_version: QuadRendererGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_stencil");

    // All combinations of depth stencil functions.
    {
        let mut functions_group = TestCaseGroup::new("stencil_depth_funcs");

        // One extra index of each, past the end of the table: the test disabled. That
        // is what `needless_range_loop`'s suggestion would silently drop.
        #[allow(clippy::needless_range_loop)]
        for stencil_func in 0..=COMPARE_FUNCS.len() {
            for depth_func in 0..=COMPARE_FUNCS.len() {
                let has_stencil_func = stencil_func < COMPARE_FUNCS.len();
                let has_depth_func = depth_func < COMPARE_FUNCS.len();

                let mut name = String::new();
                if has_stencil_func {
                    name += &format!("stencil_{}_", COMPARE_FUNCS[stencil_func].name);
                } else {
                    name += "no_stencil_";
                }
                if has_depth_func {
                    name += &format!("depth_{}", COMPARE_FUNCS[depth_func].name);
                } else {
                    name += "no_depth";
                }

                let mut params = DepthStencilParams {
                    depth_func: if has_depth_func {
                        COMPARE_FUNCS[depth_func].value
                    } else {
                        0
                    },
                    depth_test_enabled: has_depth_func,
                    depth_write_mask: true,
                    stencil_test_enabled: has_stencil_func,
                    ..DepthStencilParams::default()
                };

                let mut cases = Vec::new();
                for function_case in &FUNCTION_CASES {
                    let visible = function_case.visible_face;
                    let not_visible = other_face(visible);

                    params.depth = function_case.depth;
                    params.visible_face = visible;

                    params.stencil[face_ndx(visible)] = StencilParams {
                        function: if has_stencil_func {
                            COMPARE_FUNCS[stencil_func].value
                        } else {
                            0
                        },
                        reference: function_case.stencil_ref,
                        stencil_fail_op: function_case.s_fail,
                        depth_fail_op: function_case.d_fail,
                        depth_pass_op: function_case.d_pass,
                        compare_mask: function_case.compare_mask,
                        write_mask: function_case.write_mask,
                    };
                    params.stencil[face_ndx(not_visible)] = NOT_VISIBLE_STENCIL;

                    cases.push(params);
                }

                add_depth_stencil_case(&mut functions_group, name, cases, glsl_version);
            }
        }

        group.add_child(functions_group);
    }

    // All combinations of stencil ops.
    {
        let mut op_combination_group = TestCaseGroup::new("stencil_ops");

        for s_fail in &STENCIL_OPS {
            for d_fail in &STENCIL_OPS {
                for d_pass in &STENCIL_OPS {
                    let name = format!("{}_{}_{}", s_fail.name, d_fail.name, d_pass.name);

                    let mut params = DepthStencilParams {
                        depth_func: glw::GL_LEQUAL,
                        depth: 0.0,
                        depth_test_enabled: true,
                        depth_write_mask: true,
                        stencil_test_enabled: true,
                        ..DepthStencilParams::default()
                    };

                    let mut cases = Vec::new();
                    for op_case in &OP_COMBINATION_CASES {
                        let visible = op_case.visible_face;
                        let not_visible = other_face(visible);

                        params.visible_face = visible;
                        params.stencil[face_ndx(visible)] = StencilParams {
                            function: op_case.func,
                            reference: op_case.reference,
                            stencil_fail_op: s_fail.value,
                            depth_fail_op: d_fail.value,
                            depth_pass_op: d_pass.value,
                            compare_mask: op_case.compare_mask,
                            write_mask: op_case.write_mask,
                        };
                        params.stencil[face_ndx(not_visible)] = NOT_VISIBLE_STENCIL;

                        cases.push(params);
                    }

                    add_depth_stencil_case(&mut op_combination_group, name, cases, glsl_version);
                }
            }
        }

        group.add_child(op_combination_group);
    }

    // Write masks
    {
        let mut write_mask_group = TestCaseGroup::new("write_mask");

        // Depth mask
        {
            let mut params = write_mask_base_params();
            let mut cases = Vec::new();

            for (visible_face, depth_write_mask) in [
                (FaceType::Front, true),
                (FaceType::Front, false),
                (FaceType::Back, true),
                (FaceType::Back, false),
            ] {
                params.visible_face = visible_face;
                params.depth_write_mask = depth_write_mask;
                cases.push(params);
            }

            add_depth_stencil_case(&mut write_mask_group, "depth", cases, glsl_version);
        }

        // Stencil write masks.
        {
            const STENCIL_WMASK_CASES: [(FaceType, u32, u32); 8] = [
                (FaceType::Front, !0, 0),
                (FaceType::Front, 0, !0),
                (FaceType::Front, 0xf, 0xf0),
                (FaceType::Front, 0x2, 0x4),
                (FaceType::Back, 0, !0),
                (FaceType::Back, !0, 0),
                (FaceType::Back, 0xf0, 0xf),
                (FaceType::Back, 0x4, 0x2),
            ];

            let mut params = write_mask_base_params();
            params.depth_write_mask = true;

            let mut cases = Vec::new();
            for (visible_face, front_write_mask, back_write_mask) in STENCIL_WMASK_CASES {
                params.visible_face = visible_face;
                params.stencil[face_ndx(FaceType::Front)].write_mask = front_write_mask;
                params.stencil[face_ndx(FaceType::Back)].write_mask = back_write_mask;
                cases.push(params);
            }

            add_depth_stencil_case(&mut write_mask_group, "stencil", cases, glsl_version);
        }

        // Depth & stencil write masks.
        {
            const DEPTH_STENCIL_WMASK_CASES: [(bool, FaceType, u32, u32); 12] = [
                (false, FaceType::Front, !0, 0),
                (false, FaceType::Front, 0, !0),
                (false, FaceType::Front, 0xf, 0xf0),
                (true, FaceType::Front, !0, 0),
                (true, FaceType::Front, 0, !0),
                (true, FaceType::Front, 0xf, 0xf0),
                (false, FaceType::Back, 0, !0),
                (false, FaceType::Back, !0, 0),
                (false, FaceType::Back, 0xf0, 0xf),
                (true, FaceType::Back, 0, !0),
                (true, FaceType::Back, !0, 0),
                (true, FaceType::Back, 0xf0, 0xf),
            ];

            let mut params = write_mask_base_params();
            params.depth_write_mask = true;

            let mut cases = Vec::new();
            for (depth_write_mask, visible_face, front_write_mask, back_write_mask) in DEPTH_STENCIL_WMASK_CASES {
                params.depth_write_mask = depth_write_mask;
                params.visible_face = visible_face;
                params.stencil[face_ndx(FaceType::Front)].write_mask = front_write_mask;
                params.stencil[face_ndx(FaceType::Back)].write_mask = back_write_mask;
                cases.push(params);
            }

            add_depth_stencil_case(&mut write_mask_group, "both", cases, glsl_version);
        }

        group.add_child(write_mask_group);
    }

    // Randomized cases
    {
        let mut random_group = TestCaseGroup::new("random");

        for case_ndx in 0..NUM_RANDOM_CASES {
            // `m_testCtx.getCommandLine().getBaseSeed()` - deqp's default base seed is 0.
            let mut rnd = Random::new(de_int32_hash(case_ndx as i32) ^ de_int32_hash(0));
            let sub_cases: Vec<DepthStencilParams> = (0..NUM_RANDOM_SUB_CASES)
                .map(|_| random_depth_stencil_state(&mut rnd))
                .collect();

            add_depth_stencil_case(&mut random_group, case_ndx.to_string(), sub_cases, glsl_version);
        }

        group.add_child(random_group);
    }

    group
}
