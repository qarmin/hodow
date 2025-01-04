// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrRenderState.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `rrRenderState.hpp` is ported in
// full now, field for field: the per-fragment state (`TestFunc`/`StencilOp`/
// `BlendMode`/`StencilState`/`BlendState`/`FragmentOperationState`) that was here
// first, plus the rasterisation/viewport/line/point/restart state
// (`RasterizationState`/`ViewportState`/`LineState`/`PointState`/`RestartState`) and
// the top-level `RenderState` itself that `rr::renderer::Renderer` needs - added once
// that module existed to call them. This doc comment used to say only the
// per-fragment half was here; it was not updated when the rest landed.

/// `rr::TestFunc`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TestFunc {
    Never,
    Always,
    Less,
    LEqual,
    Greater,
    GEqual,
    Equal,
    NotEqual,
}

/// `rr::StencilOp`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum StencilOp {
    Keep,
    Zero,
    Replace,
    /// Increment with saturation.
    Incr,
    /// Decrement with saturation.
    Decr,
    IncrWrap,
    DecrWrap,
    Invert,
}

/// `rr::BlendMode`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BlendMode {
    /// No blending.
    None,
    /// Standard blending.
    Standard,
    /// Advanced blending, as defined in `GL_KHR_blend_equation_advanced`.
    Advanced,
}

/// `rr::BlendEquationAdvanced`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BlendEquationAdvanced {
    Multiply,
    Screen,
    Overlay,
    Darken,
    Lighten,
    ColorDodge,
    ColorBurn,
    HardLight,
    SoftLight,
    Difference,
    Exclusion,
    HslHue,
    HslSaturation,
    HslColor,
    HslLuminosity,
}

/// `rr::BlendEquation`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BlendEquation {
    Add,
    Subtract,
    ReverseSubtract,
    Min,
    Max,
}

/// `rr::BlendFunc`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BlendFunc {
    Zero,
    One,
    SrcColor,
    OneMinusSrcColor,
    DstColor,
    OneMinusDstColor,
    SrcAlpha,
    OneMinusSrcAlpha,
    DstAlpha,
    OneMinusDstAlpha,
    ConstantColor,
    OneMinusConstantColor,
    ConstantAlpha,
    OneMinusConstantAlpha,
    SrcAlphaSaturate,
    Src1Color,
    OneMinusSrc1Color,
    Src1Alpha,
    OneMinusSrc1Alpha,
}

/// `rr::FaceType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FaceType {
    Front = 0,
    Back = 1,
}

/// `rr::StencilState`
#[derive(Debug, Clone, Copy)]
pub struct StencilState {
    pub func: TestFunc,
    pub reference: i32,
    pub comp_mask: u32,
    pub s_fail: StencilOp,
    pub dp_fail: StencilOp,
    pub dp_pass: StencilOp,
    pub write_mask: u32,
}

impl Default for StencilState {
    fn default() -> Self {
        Self {
            func: TestFunc::Always,
            reference: 0,
            comp_mask: !0,
            s_fail: StencilOp::Keep,
            dp_fail: StencilOp::Keep,
            dp_pass: StencilOp::Keep,
            write_mask: !0,
        }
    }
}

/// `rr::BlendState`
#[derive(Debug, Clone, Copy)]
pub struct BlendState {
    pub equation: BlendEquation,
    pub src_func: BlendFunc,
    pub dst_func: BlendFunc,
}

impl Default for BlendState {
    fn default() -> Self {
        Self {
            equation: BlendEquation::Add,
            src_func: BlendFunc::One,
            dst_func: BlendFunc::Zero,
        }
    }
}

/// `rr::WindowRectangle`
#[derive(Debug, Clone, Copy)]
pub struct WindowRectangle {
    pub left: i32,
    pub bottom: i32,
    pub width: i32,
    pub height: i32,
}

/// `rr::FragmentOperationState`
#[derive(Debug, Clone, Copy)]
pub struct FragmentOperationState {
    pub scissor_test_enabled: bool,
    pub scissor_rectangle: WindowRectangle,

    pub stencil_test_enabled: bool,
    /// Indexed with `FaceType::Front` and `FaceType::Back`.
    pub stencil_states: [StencilState; 2],

    pub depth_test_enabled: bool,
    pub depth_func: TestFunc,
    pub depth_mask: bool,

    /// `EXT_depth_bounds_test`. No ES case enables it and `rr::FragmentProcessor`
    /// asserts on it; the field is here so the struct still matches the C++.
    pub depth_bounds_test_enabled: bool,
    pub min_depth_bound: f32,
    pub max_depth_bound: f32,

    pub blend_mode: BlendMode,

    pub blend_rgb_state: BlendState,
    pub blend_a_state: BlendState,
    /// Components should be in range [0, 1].
    pub blend_color: [f32; 4],

    /// `blendEquationAdvaced` - upstream defaults this to a `_LAST` sentinel meaning
    /// "none set"; `None` is that sentinel here, and `execute_advanced_blend` asserts it
    /// is `Some` because it is only ever called when `blend_mode == Advanced`.
    pub blend_equation_advanced: Option<BlendEquationAdvanced>,

    pub srgb_enabled: bool,

    /// `depthClampEnabled` - not consulted by `FragmentProcessor` (upstream applies
    /// depth clamping in the rasterizer/renderer, before the fragment-ops stage this
    /// crate ported first); kept so the struct matches the C++ for `Renderer`'s use.
    pub depth_clamp_enabled: bool,

    pub polygon_offset_enabled: bool,
    pub polygon_offset_factor: f32,
    pub polygon_offset_units: f32,

    pub color_mask: [bool; 4],

    pub num_stencil_bits: i32,
}

impl Default for FragmentOperationState {
    fn default() -> Self {
        Self {
            scissor_test_enabled: false,
            scissor_rectangle: WindowRectangle {
                left: 0,
                bottom: 0,
                width: 1,
                height: 1,
            },
            stencil_test_enabled: false,
            stencil_states: [StencilState::default(); 2],
            depth_test_enabled: false,
            depth_func: TestFunc::Less,
            depth_mask: true,
            depth_bounds_test_enabled: false,
            min_depth_bound: 0.0,
            max_depth_bound: 1.0,
            blend_mode: BlendMode::None,
            blend_rgb_state: BlendState::default(),
            blend_a_state: BlendState::default(),
            blend_color: [0.0; 4],
            blend_equation_advanced: None,
            srgb_enabled: true,
            depth_clamp_enabled: false,
            polygon_offset_enabled: false,
            polygon_offset_factor: 0.0,
            polygon_offset_units: 0.0,
            color_mask: [true; 4],
            num_stencil_bits: 8,
        }
    }
}

/// `rr::HorizontalFill`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum HorizontalFill {
    Left,
    Right,
}

/// `rr::VerticalFill`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum VerticalFill {
    Top,
    Bottom,
}

/// `rr::Winding`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Winding {
    /// Counter-clockwise winding.
    Ccw = 0,
    /// Clockwise winding.
    Cw,
}

/// `rr::CullMode`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CullMode {
    None,
    Back,
    Front,
    FrontAndBack,
}

/// `rr::ViewportOrientation`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ViewportOrientation {
    /// Corresponds to GL.
    LowerLeft = 0,
    /// Corresponds to Vulkan.
    UpperLeft,
}

/// `rr::RasterizationState`
#[derive(Debug, Clone, Copy)]
pub struct RasterizationState {
    pub winding: Winding,
    pub horizontal_fill: HorizontalFill,
    pub vertical_fill: VerticalFill,
    /// `VIEWPORTORIENTATION_LAST` upstream ("unset" sentinel) is `None` here.
    pub viewport_orientation: Option<ViewportOrientation>,
}

impl Default for RasterizationState {
    fn default() -> Self {
        Self {
            winding: Winding::Ccw,
            horizontal_fill: HorizontalFill::Left,
            vertical_fill: VerticalFill::Bottom,
            viewport_orientation: None,
        }
    }
}

/// `rr::PointState`
#[derive(Debug, Clone, Copy)]
pub struct PointState {
    pub point_size: f32,
}

impl Default for PointState {
    fn default() -> Self {
        Self { point_size: 1.0 }
    }
}

/// `rr::LineState`
#[derive(Debug, Clone, Copy)]
pub struct LineState {
    pub line_width: f32,
}

impl Default for LineState {
    fn default() -> Self {
        Self { line_width: 1.0 }
    }
}

/// `rr::ViewportState`
#[derive(Debug, Clone, Copy)]
pub struct ViewportState {
    pub rect: WindowRectangle,
    pub zn: f32,
    pub zf: f32,
}

impl ViewportState {
    /// `ViewportState(const WindowRectangle&)`
    pub fn new(rect: WindowRectangle) -> Self {
        Self { rect, zn: 0.0, zf: 1.0 }
    }

    /// `ViewportState(const rr::MultisampleConstPixelBufferAccess&)` - narrowed to
    /// "a render target of this width/height", since `MultisamplePixelBufferAccess`
    /// itself is not ported (see `rr::mod` doc).
    pub fn from_target_size(width: i32, height: i32) -> Self {
        Self::new(WindowRectangle {
            left: 0,
            bottom: 0,
            width,
            height,
        })
    }
}

/// `rr::RestartState`
#[derive(Debug, Clone, Copy)]
pub struct RestartState {
    pub enabled: bool,
    pub restart_index: u32,
}

impl Default for RestartState {
    fn default() -> Self {
        Self {
            enabled: false,
            restart_index: 0xFFFF_FFFF,
        }
    }
}

/// `rr::ProvokingVertex` in the constructor that upstream defaults to
/// `PROVOKINGVERTEX_LAST` ("not yet decided" - the renderer picks it from the API
/// convention being emulated before the first draw). `None` is that sentinel.
pub type ProvokingVertexConvention = Option<super::defs::ProvokingVertex>;

/// `rr::RenderState` - rasterizer configuration for one draw call.
#[derive(Debug, Clone, Copy)]
pub struct RenderState {
    pub cull_mode: CullMode,
    pub provoking_vertex_convention: ProvokingVertexConvention,
    pub rasterization: RasterizationState,
    pub frag_ops: FragmentOperationState,
    pub point: PointState,
    pub viewport: ViewportState,
    pub line: LineState,
    pub restart: RestartState,
    pub viewport_orientation: ViewportOrientation,
    pub subpixel_bits: i32,
}

impl RenderState {
    pub const DEFAULT_SUBPIXEL_BITS: i32 = 8;

    pub fn new(viewport: ViewportState, subpixel_bits: i32) -> Self {
        Self::with_orientation_and_cull(viewport, subpixel_bits, ViewportOrientation::LowerLeft, CullMode::None)
    }

    pub fn with_orientation_and_cull(
        viewport: ViewportState,
        subpixel_bits: i32,
        viewport_orientation: ViewportOrientation,
        cull_mode: CullMode,
    ) -> Self {
        let rasterization = RasterizationState {
            viewport_orientation: Some(viewport_orientation),
            ..RasterizationState::default()
        };
        Self {
            cull_mode,
            provoking_vertex_convention: None,
            rasterization,
            frag_ops: FragmentOperationState::default(),
            point: PointState::default(),
            viewport,
            line: LineState::default(),
            restart: RestartState::default(),
            viewport_orientation,
            subpixel_bits,
        }
    }
}
