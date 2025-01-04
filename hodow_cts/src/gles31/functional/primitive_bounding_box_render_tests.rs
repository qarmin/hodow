// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fPrimitiveBoundingBoxTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `BBoxRenderCase` and `GridRenderCase`:
// the `triangles` sub-group (3 state-set methods x pipeline configs x usage configs).
// `BBoxRenderCase` is a trait (`Pattern`) plus the shared `run_bbox_case` loop, so the
// line and point cases can be added as further `Pattern` implementations. Upstream's
// multi-iteration `CONTINUE` becomes a loop over the twelve iterations in one body; a
// failed iteration is recorded and the loop carries on, like the C++ does.
//
// Deviation: the colour attachment texture of the FBO variant is kept alive for the whole
// case instead of being deleted right after attaching (upstream deletes it; the attachment
// keeps the object alive either way).

use std::sync::Arc;

use super::primitive_bounding_box_line_tests::LinePattern;
use super::primitive_bounding_box_point_tests::PointPattern;
use crate::glu::{
    self, ApiCase, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, Texture,
    VertexArray,
};
use crate::glw;
use crate::tcu::surface::Surface;
use crate::tcu::{Random, TestOutcome, TestResult, TestStatus};

/// What a `verify_render_result` raises instead of a failure: upstream's QualityWarning and
/// CompatibilityWarning, which `ApiCase` has no way to express.
pub type Warning = Option<(TestResult, &'static str)>;

pub type Vec4 = [f32; 4];

pub const FLAG_RENDERTARGET_DEFAULT: u32 = 1 << 0;
pub const FLAG_RENDERTARGET_FBO: u32 = 1 << 1;
pub const FLAG_BBOXSIZE_EQUAL: u32 = 1 << 2;
pub const FLAG_BBOXSIZE_LARGER: u32 = 1 << 3;
pub const FLAG_BBOXSIZE_SMALLER: u32 = 1 << 4;
pub const FLAG_TESSELLATION: u32 = 1 << 5;
pub const FLAG_GEOMETRY: u32 = 1 << 6;
pub const FLAG_SET_BBOX_STATE: u32 = 1 << 7;
pub const FLAG_SET_BBOX_OUTPUT: u32 = 1 << 8;
pub const FLAG_PER_PRIMITIVE_BBOX: u32 = 1 << 9;

const RENDER_TARGET_MIN_SIZE: i32 = 256;
const FBO_SIZE: i32 = 512;
const MIN_VIEWPORT_SIZE: i32 = 256;
const MAX_VIEWPORT_SIZE: i32 = 512;

const VA_POS_VEC_NDX: usize = 0;
const VA_COL_VEC_NDX: usize = 1;
pub const VA_NUM_ATTRIB_VECS: usize = 2;

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BBoxSizeKind {
    Equal,
    Larger,
    Smaller,
}

/// The `const` members `BBoxRenderCase`'s constructor derives from its flags.
#[derive(Clone, Copy)]
pub struct Common {
    pub render_to_fbo: bool,
    pub bbox_size: BBoxSizeKind,
    pub has_tessellation_stage: bool,
    pub has_geometry_stage: bool,
    pub use_global_state: bool,
    pub calc_per_primitive_bbox: bool,
    pub num_iterations: i32,
}

impl Common {
    pub fn new(num_iterations: i32, flags: u32) -> Self {
        Self {
            render_to_fbo: flags & FLAG_RENDERTARGET_DEFAULT == 0,
            bbox_size: if flags & FLAG_BBOXSIZE_EQUAL != 0 {
                BBoxSizeKind::Equal
            } else if flags & FLAG_BBOXSIZE_SMALLER != 0 {
                BBoxSizeKind::Smaller
            } else {
                BBoxSizeKind::Larger
            },
            has_tessellation_stage: flags & FLAG_TESSELLATION != 0,
            has_geometry_stage: flags & FLAG_GEOMETRY != 0,
            use_global_state: flags & FLAG_SET_BBOX_STATE != 0,
            calc_per_primitive_bbox: flags & FLAG_PER_PRIMITIVE_BBOX != 0,
            num_iterations,
        }
    }

    /// The `"geo_"` infix the varyings carry when a geometry stage sits behind them.
    pub fn geo_infix(&self) -> &'static str {
        if self.has_geometry_stage { "geo_" } else { "" }
    }
}

#[derive(Clone, Copy)]
pub struct IterationConfig {
    pub viewport_pos: [i32; 2],
    pub viewport_size: [i32; 2],
    pub pattern_pos: [f32; 2],
    pub pattern_size: [f32; 2],
    pub bbox_min: Vec4,
    pub bbox_max: Vec4,
}

pub struct ProjectedBBox {
    pub min: [f32; 3],
    pub max: [f32; 3],
}

/// `projectBoundingBox`
pub fn project_bounding_box(bbox_min: Vec4, bbox_max: Vec4) -> ProjectedBBox {
    let w_min = 0.0f32.max(bbox_min[3]); // clamp to w=0 as extension requires
    let w_max = 0.0f32.max(bbox_max[3]);
    let mut ret = ProjectedBBox {
        min: [0.0; 3],
        max: [0.0; 3],
    };

    for c in 0..3 {
        ret.min[c] = (bbox_min[c] / w_min).min(bbox_min[c] / w_max);
        ret.max[c] = (bbox_max[c] / w_min).max(bbox_max[c] / w_max);
    }
    ret
}

/// `getViewportBoundingBoxArea`
pub fn get_viewport_bounding_box_area(bbox: &ProjectedBBox, viewport_size: [i32; 2], size: f32) -> [i32; 4] {
    let vertex_box = [
        (bbox.min[0] * 0.5 + 0.5) * viewport_size[0] as f32,
        (bbox.min[1] * 0.5 + 0.5) * viewport_size[1] as f32,
        (bbox.max[0] * 0.5 + 0.5) * viewport_size[0] as f32,
        (bbox.max[1] * 0.5 + 0.5) * viewport_size[1] as f32,
    ];

    [
        (vertex_box[0] - size / 2.0).floor() as i32,
        (vertex_box[1] - size / 2.0).floor() as i32,
        (vertex_box[2] + size / 2.0).ceil() as i32,
        (vertex_box[3] + size / 2.0).ceil() as i32,
    ]
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AabbRoundDirection {
    Inwards,
    Outwards,
}

/// `BBoxRenderCase::getViewportPatternArea`
pub fn get_viewport_pattern_area(
    pattern_pos: [f32; 2],
    pattern_size: [f32; 2],
    viewport_size: [i32; 2],
    round_dir: AabbRoundDirection,
) -> [i32; 4] {
    let half_pixel = 0.5f32;
    let vertex_box = [
        (pattern_pos[0] * 0.5 + 0.5) * viewport_size[0] as f32,
        (pattern_pos[1] * 0.5 + 0.5) * viewport_size[1] as f32,
        ((pattern_pos[0] + pattern_size[0]) * 0.5 + 0.5) * viewport_size[0] as f32,
        ((pattern_pos[1] + pattern_size[1]) * 0.5 + 0.5) * viewport_size[1] as f32,
    ];

    if round_dir == AabbRoundDirection::Inwards {
        [
            (vertex_box[0] + half_pixel).ceil() as i32,
            (vertex_box[1] + half_pixel).ceil() as i32,
            (vertex_box[2] - half_pixel).floor() as i32,
            (vertex_box[3] - half_pixel).floor() as i32,
        ]
    } else {
        [
            (vertex_box[0] - half_pixel).floor() as i32,
            (vertex_box[1] - half_pixel).floor() as i32,
            (vertex_box[2] + half_pixel).ceil() as i32,
            (vertex_box[3] + half_pixel).ceil() as i32,
        ]
    }
}

#[derive(Clone, Copy)]
pub enum ShaderFunction {
    MirrorX,
    MirrorY,
    InsideBBox,
}

/// `BBoxRenderCase::genShaderFunction`
pub fn gen_shader_function(func: ShaderFunction) -> &'static str {
    match func {
        ShaderFunction::MirrorX => {
            "vec4 mirrorX(in highp vec4 p)\n\
             {\n\
             \x20   highp vec2 patternOffset = u_posScale.xy;\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   highp vec2 patternCenter = patternOffset + patternScale * 0.5;\n\
             \x20   return vec4(2.0 * patternCenter.x - p.x, p.y, p.z, p.w);\n\
             }\n"
        }
        ShaderFunction::MirrorY => {
            "vec4 mirrorY(in highp vec4 p)\n\
             {\n\
             \x20   highp vec2 patternOffset = u_posScale.xy;\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   highp vec2 patternCenter = patternOffset + patternScale * 0.5;\n\
             \x20   return vec4(p.x, 2.0 * patternCenter.y - p.y, p.z, p.w);\n\
             }\n"
        }
        ShaderFunction::InsideBBox => {
            "uniform highp ivec2 u_viewportPos;\n\
             uniform highp ivec2 u_viewportSize;\n\
             flat in highp float v_bbox_expansionSize;\n\
             flat in highp vec3 v_bbox_clipMin;\n\
             flat in highp vec3 v_bbox_clipMax;\n\
             \n\
             bool fragmentInsideTheBBox(in highp float depth)\n\
             {\n\
             \x20   highp vec4 wc = vec4(floor((v_bbox_clipMin.x * 0.5 + 0.5) * float(u_viewportSize.x) - v_bbox_expansionSize/2.0),\n\
             \x20                        floor((v_bbox_clipMin.y * 0.5 + 0.5) * float(u_viewportSize.y) - v_bbox_expansionSize/2.0),\n\
             \x20                        ceil((v_bbox_clipMax.x * 0.5 + 0.5) * float(u_viewportSize.x) + v_bbox_expansionSize/2.0),\n\
             \x20                        ceil((v_bbox_clipMax.y * 0.5 + 0.5) * float(u_viewportSize.y) + v_bbox_expansionSize/2.0));\n\
             \x20   if (gl_FragCoord.x < float(u_viewportPos.x) + wc.x || gl_FragCoord.x > float(u_viewportPos.x) + wc.z ||\n\
             \x20       gl_FragCoord.y < float(u_viewportPos.y) + wc.y || gl_FragCoord.y > float(u_viewportPos.y) + wc.w)\n\
             \x20       return false;\n\
             \x20   const highp float dEpsilon = 0.001;\n\
             \x20   if (depth*2.0-1.0 < v_bbox_clipMin.z - dEpsilon || depth*2.0-1.0 > v_bbox_clipMax.z + dEpsilon)\n\
             \x20       return false;\n\
             \x20   return true;\n\
             }\n"
        }
    }
}

pub fn supports_es32(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

pub fn bounding_box_supported(context: &Context) -> bool {
    supports_es32(context)
        || context
            .context_info
            .is_extension_supported("GL_EXT_primitive_bounding_box")
}

/// `specializeShader`, ES half.
pub fn specialize_shader(context: &Context, code: &str) -> String {
    let es32 = supports_es32(context);
    let (geometry_require, tess_require, prim_bbox_require, bbox_name, gpu_shader5) = if es32 {
        ("", "", "", "gl_BoundingBox", "")
    } else {
        (
            "#extension GL_EXT_geometry_shader : require",
            "#extension GL_EXT_tessellation_shader : require",
            "#extension GL_EXT_primitive_bounding_box : require",
            "gl_BoundingBoxEXT",
            "#extension GL_EXT_gpu_shader5 : require",
        )
    };

    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
    .replace("${ARB_ES32_COMPATIBILITY_REQUIRE}", "")
    .replace("${GEOMETRY_SHADER_REQUIRE}", geometry_require)
    .replace(
        "${GEOMETRY_POINT_SIZE}",
        "#extension GL_EXT_geometry_point_size : require",
    )
    .replace("${GPU_SHADER5_REQUIRE}", gpu_shader5)
    .replace("${TESSELLATION_SHADER_REQUIRE}", tess_require)
    .replace(
        "${TESSELLATION_POINT_SIZE_REQUIRE}",
        "#extension GL_EXT_tessellation_point_size : require",
    )
    .replace("${PRIMITIVE_BOUNDING_BOX_REQUIRE}", prim_bbox_require)
    .replace("${PRIM_GL_BOUNDING_BOX}", bbox_name)
}

pub fn set_bounding_box(gl: &glw::Functions, min: Vec4, max: Vec4) {
    // SAFETY: eight scalars, on a context that passed `bounding_box_supported`.
    unsafe { gl.primitive_bounding_box(min[0], min[1], min[2], min[3], max[0], max[1], max[2], max[3]) };
}

pub fn reset_bounding_box(gl: &glw::Functions) {
    set_bounding_box(gl, [-1.0, -1.0, -1.0, 1.0], [1.0, 1.0, 1.0, 1.0]);
}

/// What `BBoxRenderCase::init` creates.
pub struct Resources<'gl> {
    pub program: ShaderProgram<'gl>,
    pub vbo: Buffer<'gl>,
    pub fbo: Option<Framebuffer<'gl>>,
    _color_attachment: Option<Texture<'gl>>,
    _vao: VertexArray<'gl>,
}

/// `BBoxRenderCase`'s pure-virtual half plus the two case-specific `init` hooks.
pub trait Pattern: Send + Sync {
    /// The `NotSupported` checks a subclass's `init` adds before `BBoxRenderCase::init`.
    fn check_support(&self, _case: &mut ApiCase<'_>, _common: &Common) -> bool {
        true
    }

    fn gen_vertex_source(&self, common: &Common) -> String;
    fn gen_fragment_source(&self, common: &Common) -> String;
    fn gen_tessellation_control_source(&self, common: &Common) -> String;
    fn gen_tessellation_evaluation_source(&self, common: &Common) -> String;
    fn gen_geometry_source(&self, common: &Common) -> String;

    fn generate_config(&self, common: &Common, iteration: i32, render_target_size: [i32; 2]) -> IterationConfig;
    fn get_attribute_data(&self) -> Vec<Vec4>;

    /// Returns false when the case already failed and the iteration cannot go on.
    fn render_test_pattern(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
    ) -> bool;
    fn verify_render_result(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
        warning: &mut Warning,
    );
}

/// `BBoxRenderCase::generateRandomConfig`
pub fn generate_random_config(common: &Common, seed: u32, render_target_size: [i32; 2]) -> IterationConfig {
    let mut rnd = Random::new(seed);

    // viewport config
    let viewport_size = [
        rnd.get_int(MIN_VIEWPORT_SIZE, render_target_size[0].min(MAX_VIEWPORT_SIZE)),
        rnd.get_int(MIN_VIEWPORT_SIZE, render_target_size[1].min(MAX_VIEWPORT_SIZE)),
    ];
    let viewport_pos = [
        rnd.get_int(0, render_target_size[0] - viewport_size[0]),
        rnd.get_int(0, render_target_size[1] - viewport_size[1]),
    ];

    // pattern location inside viewport
    let pattern_size = [rnd.get_float_range(0.4, 1.4), rnd.get_float_range(0.4, 1.4)];
    let pattern_pos = [
        rnd.get_float_range(-1.0, 1.0 - pattern_size[0]),
        rnd.get_float_range(-1.0, 1.0 - pattern_size[1]),
    ];

    // accurate bounding box
    let mut bbox_min = [pattern_pos[0], pattern_pos[1], 0.0, 1.0];
    let mut bbox_max = [
        pattern_pos[0] + pattern_size[0],
        pattern_pos[1] + pattern_size[1],
        0.0,
        1.0,
    ];

    if common.bbox_size == BBoxSizeKind::Larger {
        // increase bbox size
        bbox_min[0] -= rnd.get_float() * 0.5;
        bbox_min[1] -= rnd.get_float() * 0.5;
        bbox_min[2] -= rnd.get_float() * 0.5;

        bbox_max[0] += rnd.get_float() * 0.5;
        bbox_max[1] += rnd.get_float() * 0.5;
        bbox_max[2] += rnd.get_float() * 0.5;
    } else if common.bbox_size == BBoxSizeKind::Smaller {
        // reduce bbox size
        bbox_min[0] += rnd.get_float() * 0.4 * pattern_size[0];
        bbox_min[1] += rnd.get_float() * 0.4 * pattern_size[1];

        bbox_max[0] -= rnd.get_float() * 0.4 * pattern_size[0];
        bbox_max[1] -= rnd.get_float() * 0.4 * pattern_size[1];
    }

    IterationConfig {
        viewport_pos,
        viewport_size,
        pattern_pos,
        pattern_size,
        bbox_min,
        bbox_max,
    }
}

/// `BBoxRenderCase::setupRender`. False when a `TCU_CHECK` fired.
pub fn setup_render(case: &mut ApiCase<'_>, common: &Common, res: &Resources<'_>, config: &IterationConfig) -> bool {
    let gl = case.gl();
    let program = res.program.program();
    // SAFETY: NUL-terminated names against a linked program.
    let (pos_location, col_location, pos_scale_location) = unsafe {
        (
            gl.get_attrib_location(program, c"a_position".as_ptr()),
            gl.get_attrib_location(program, c"a_color".as_ptr()),
            gl.get_uniform_location(program, c"u_posScale".as_ptr()),
        )
    };

    if pos_location == -1 || col_location == -1 || pos_scale_location == -1 {
        case.fail(
            "TCU_CHECK: a_position, a_color or u_posScale not found".to_string(),
            "attribute or uniform not found",
        );
        return false;
    }

    log::debug!(
        "Setting viewport to (x: {}, y: {}, w: {}, h: {}); vertex coordinates x: [{}, {}] y: [{}, {}]",
        config.viewport_pos[0],
        config.viewport_pos[1],
        config.viewport_size[0],
        config.viewport_size[1],
        config.pattern_pos[0],
        config.pattern_pos[0] + config.pattern_size[0],
        config.pattern_pos[1],
        config.pattern_pos[1] + config.pattern_size[1]
    );

    if !common.calc_per_primitive_bbox {
        log::debug!(
            "Setting primitive bounding box to {:?} .. {:?}",
            config.bbox_min,
            config.bbox_max
        );
    }

    if common.use_global_state {
        set_bounding_box(gl, config.bbox_min, config.bbox_max);
    } else {
        // state is overriden by the tessellation output, set bbox to invisible area to imitiate dirty state left by application
        set_bounding_box(gl, [-2.0, -2.0, 0.0, 1.0], [-1.7, -1.7, 0.0, 1.0]);
    }

    let stride = (VA_NUM_ATTRIB_VECS * 4 * 4) as i32;
    // SAFETY: names owned by `res`; the attribute offsets are inside one interleaved vertex.
    unsafe {
        if let Some(fbo) = &res.fbo {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
        }

        gl.viewport(
            config.viewport_pos[0],
            config.viewport_pos[1],
            config.viewport_size[0],
            config.viewport_size[1],
        );
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.vbo.get());

        gl.vertex_attrib_pointer(
            pos_location as u32,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            stride,
            (4 * VA_POS_VEC_NDX * 4) as *const std::ffi::c_void,
        );
        gl.vertex_attrib_pointer(
            col_location as u32,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            stride,
            (4 * VA_COL_VEC_NDX * 4) as *const std::ffi::c_void,
        );
        gl.enable_vertex_attrib_array(pos_location as u32);
        gl.enable_vertex_attrib_array(col_location as u32);
        gl.use_program(program);
        gl.uniform_4f(
            pos_scale_location,
            config.pattern_pos[0],
            config.pattern_pos[1],
            config.pattern_size[0],
            config.pattern_size[1],
        );

        let bbox_min_pos = gl.get_uniform_location(program, c"u_primitiveBBoxMin".as_ptr());
        let bbox_max_pos = gl.get_uniform_location(program, c"u_primitiveBBoxMax".as_ptr());
        gl.uniform_4f(
            bbox_min_pos,
            config.bbox_min[0],
            config.bbox_min[1],
            config.bbox_min[2],
            config.bbox_min[3],
        );
        gl.uniform_4f(
            bbox_max_pos,
            config.bbox_max[0],
            config.bbox_max[1],
            config.bbox_max[2],
            config.bbox_max[3],
        );

        gl.uniform_2i(
            gl.get_uniform_location(program, c"u_viewportPos".as_ptr()),
            config.viewport_pos[0],
            config.viewport_pos[1],
        );
        gl.uniform_2i(
            gl.get_uniform_location(program, c"u_viewportSize".as_ptr()),
            config.viewport_size[0],
            config.viewport_size[1],
        );
    }

    case.expect_no_error("setup");
    true
}

/// `BBoxRenderCase::init` (after the subclass's own checks).
fn init_resources<'gl>(
    case: &mut ApiCase<'_>,
    context: &'gl Context,
    common: &Common,
    pattern: &dyn Pattern,
) -> Option<Resources<'gl>> {
    let gl = context.gl();

    if !bounding_box_supported(context) {
        case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
        return None;
    }
    if common.has_tessellation_stage
        && !supports_es32(context)
        && !context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
    {
        case.not_supported("Test requires GL_EXT_tessellation_shader extension");
        return None;
    }
    if common.has_geometry_stage
        && !supports_es32(context)
        && !context.context_info.is_extension_supported("GL_EXT_geometry_shader")
    {
        case.not_supported("Test requires GL_EXT_geometry_shader extension");
        return None;
    }
    if !pattern.check_support(case, common) {
        return None;
    }

    let mut sources = ProgramSources::default()
        .with(
            ShaderType::Vertex,
            specialize_shader(context, &pattern.gen_vertex_source(common)),
        )
        .with(
            ShaderType::Fragment,
            specialize_shader(context, &pattern.gen_fragment_source(common)),
        );
    if common.has_tessellation_stage {
        sources = sources
            .with(
                ShaderType::TessControl,
                specialize_shader(context, &pattern.gen_tessellation_control_source(common)),
            )
            .with(
                ShaderType::TessEvaluation,
                specialize_shader(context, &pattern.gen_tessellation_evaluation_source(common)),
            );
    }
    if common.has_geometry_stage {
        sources = sources.with(
            ShaderType::Geometry,
            specialize_shader(context, &pattern.gen_geometry_source(common)),
        );
    }

    let program = ShaderProgram::new(gl, &sources);
    case.expect_no_error("build program");
    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return None;
    }

    let mut fbo = None;
    let mut color_attachment = None;
    if common.render_to_fbo {
        let texture = Texture::new(gl);
        let framebuffer = Framebuffer::new(gl);
        // SAFETY: names this case owns.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, FBO_SIZE, FBO_SIZE);
        }
        case.expect_no_error("gen tex");

        // SAFETY: as above.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer.get());
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture.get(),
                0,
            );
        }
        case.expect_no_error("attach");

        // unbind to prevent texture name deletion from removing it from current fbo attachments
        // SAFETY: binds the default framebuffer.
        unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0) };

        color_attachment = Some(texture);
        fbo = Some(framebuffer);
    }

    let vao = VertexArray::new(gl);
    // SAFETY: a VAO this case owns.
    unsafe { gl.bind_vertex_array(vao.get()) };

    let data = pattern.get_attribute_data();
    let vbo = Buffer::new(gl);
    // SAFETY: `data` outlives the upload; the size is its byte length.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(data.as_slice()) as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
    case.expect_no_error("create vbo");

    reset_bounding_box(gl);

    Some(Resources {
        program,
        vbo,
        fbo,
        _color_attachment: color_attachment,
        _vao: vao,
    })
}

/// `BBoxRenderCase::init` + the `iterate` loop.
fn run_bbox_case(case: &mut ApiCase<'_>, common: &Common, pattern: &dyn Pattern, warning: &mut Warning) {
    let context = case.context();
    let gl = case.gl();

    let Some(res) = init_resources(case, context, common, pattern) else {
        return;
    };

    let render_target = context.render_target();
    let render_target_size = if common.render_to_fbo {
        [FBO_SIZE, FBO_SIZE]
    } else {
        [render_target.width, render_target.height]
    };
    if !common.render_to_fbo
        && (render_target_size[0] < RENDER_TARGET_MIN_SIZE || render_target_size[1] < RENDER_TARGET_MIN_SIZE)
    {
        case.not_supported(format!(
            "Test requires {RENDER_TARGET_MIN_SIZE}x{RENDER_TARGET_MIN_SIZE} default framebuffer"
        ));
        return;
    }

    for iteration in 0..common.num_iterations {
        log::debug!("Iteration {}/{}", iteration + 1, common.num_iterations);
        let config = pattern.generate_config(common, iteration, render_target_size);

        if !pattern.render_test_pattern(case, common, &res, &config) {
            break;
        }
        pattern.verify_render_result(case, common, &res, &config, warning);
    }

    reset_bounding_box(gl);
    // SAFETY: back to the default framebuffer for whatever runs next.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
}

/// Reads the iteration's viewport back, from the case's FBO when it has one.
pub fn read_viewport(case: &mut ApiCase<'_>, res: &Resources<'_>, config: &IterationConfig) -> Option<Surface> {
    let gl = case.gl();
    let mut surface = Surface::new(config.viewport_size[0], config.viewport_size[1]);

    if let Some(fbo) = &res.fbo {
        // SAFETY: the case's own framebuffer.
        unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.get()) };
    }
    match glu::read_pixels(
        &case.context().render_context,
        config.viewport_pos[0],
        config.viewport_pos[1],
        &mut surface.get_access(),
    ) {
        Ok(()) => Some(surface),
        Err(e) => {
            case.fail(e.to_string(), "Image verification failed");
            None
        }
    }
}

// ---------------------------------------------------------------------------------------
// GridRenderCase
// ---------------------------------------------------------------------------------------

struct GridPattern {
    grid_size: usize,
}

impl Pattern for GridPattern {
    fn gen_vertex_source(&self, c: &Common) -> String {
        let geo = c.geo_infix();
        let mut buf = String::from(
            "${GLSL_VERSION_DECL}\n\
             in highp vec4 a_position;\n\
             in highp vec4 a_color;\n\
             out highp vec4 vtx_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n",
        );
        if !c.has_tessellation_stage {
            buf.push_str(&format!(
                "uniform highp vec4 u_primitiveBBoxMin;\n\
                 uniform highp vec4 u_primitiveBBoxMax;\n\
                 \n\
                 flat out highp float v_{geo}bbox_expansionSize;\n\
                 flat out highp vec3 v_{geo}bbox_clipMin;\n\
                 flat out highp vec3 v_{geo}bbox_clipMax;\n\
                 \n"
            ));
        }

        buf.push_str(
            "void main()\n\
             {\n\
             \x20   highp vec2 patternOffset = u_posScale.xy;\n\
             \x20   highp vec2 patternScale = u_posScale.zw;\n\
             \x20   gl_Position = vec4(a_position.xy * patternScale + patternOffset, a_position.z, a_position.w);\n\
             \x20   vtx_color = a_color;\n",
        );

        if !c.has_tessellation_stage {
            buf.push_str(&format!(
                "\n\
                 \x20   v_{geo}bbox_expansionSize = 0.0;\n\
                 \x20   v_{geo}bbox_clipMin =\n\
                 \x20       min(vec3(u_primitiveBBoxMin.x, u_primitiveBBoxMin.y, u_primitiveBBoxMin.z) / u_primitiveBBoxMin.w,\n\
                 \x20           vec3(u_primitiveBBoxMin.x, u_primitiveBBoxMin.y, u_primitiveBBoxMin.z) / u_primitiveBBoxMax.w);\n\
                 \x20   v_{geo}bbox_clipMax =\n\
                 \x20       min(vec3(u_primitiveBBoxMax.x, u_primitiveBBoxMax.y, u_primitiveBBoxMax.z) / u_primitiveBBoxMin.w,\n\
                 \x20           vec3(u_primitiveBBoxMax.x, u_primitiveBBoxMax.y, u_primitiveBBoxMax.z) / u_primitiveBBoxMax.w);\n"
            ));
        }

        buf.push_str("}\n");
        buf
    }

    fn gen_fragment_source(&self, c: &Common) -> String {
        let color_input_name = if c.has_geometry_stage {
            "geo_color"
        } else if c.has_tessellation_stage {
            "tess_color"
        } else {
            "vtx_color"
        };

        format!(
            "${{GLSL_VERSION_DECL}}\n\
             in mediump vec4 {color_input_name};\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             {}\n\
             void main()\n\
             {{\n\
             \x20   mediump vec4 baseColor = {color_input_name};\n\
             \x20   mediump float blueChannel;\n\
             \x20   if (fragmentInsideTheBBox(gl_FragCoord.z))\n\
             \x20       blueChannel = 0.0;\n\
             \x20   else\n\
             \x20       blueChannel = 1.0;\n\
             \x20   o_color = vec4(baseColor.r, baseColor.g, blueChannel, baseColor.a);\n\
             }}\n",
            gen_shader_function(ShaderFunction::InsideBBox)
        )
    }

    fn gen_tessellation_control_source(&self, c: &Common) -> String {
        let mut buf = String::from(
            "${GLSL_VERSION_DECL}\n\
             ${ARB_ES32_COMPATIBILITY_REQUIRE}\n\
             ${TESSELLATION_SHADER_REQUIRE}\n\
             ${PRIMITIVE_BOUNDING_BOX_REQUIRE}\n\
             layout(vertices=3) out;\n\
             \n\
             in highp vec4 vtx_color[];\n\
             out highp vec4 tess_ctrl_color[];\n\
             uniform highp float u_tessellationLevel;\n\
             uniform highp vec4 u_posScale;\n",
        );

        if !c.calc_per_primitive_bbox {
            buf.push_str("uniform highp vec4 u_primitiveBBoxMin;\nuniform highp vec4 u_primitiveBBoxMax;\n");
        }

        buf.push_str("patch out highp float vp_bbox_expansionSize;\npatch out highp vec3 vp_bbox_clipMin;\npatch out highp vec3 vp_bbox_clipMax;\n");

        if c.calc_per_primitive_bbox {
            buf.push('\n');
            if c.has_geometry_stage {
                buf.push_str(gen_shader_function(ShaderFunction::MirrorX));
            }
            buf.push_str(gen_shader_function(ShaderFunction::MirrorY));

            buf.push_str(&format!(
                "vec4 transformVec(in highp vec4 p)\n\
                 {{\n\
                 \x20   return {};\n\
                 }}\n",
                if c.has_geometry_stage {
                    "mirrorX(mirrorY(p))"
                } else {
                    "mirrorY(p)"
                }
            ));
        }

        buf.push_str(
            "\n\
             void main()\n\
             {\n\
             \x20   // convert to nonsensical coordinates, just in case\n\
             \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position.wzxy;\n\
             \x20   tess_ctrl_color[gl_InvocationID] = vtx_color[gl_InvocationID];\n\
             \n\
             \x20   gl_TessLevelOuter[0] = u_tessellationLevel;\n\
             \x20   gl_TessLevelOuter[1] = u_tessellationLevel;\n\
             \x20   gl_TessLevelOuter[2] = u_tessellationLevel;\n\
             \x20   gl_TessLevelInner[0] = u_tessellationLevel;\n",
        );

        if c.calc_per_primitive_bbox {
            buf.push_str(
                "\n\
                 \x20   highp vec4 bboxMin = min(min(transformVec(gl_in[0].gl_Position),\n\
                 \x20                                transformVec(gl_in[1].gl_Position)),\n\
                 \x20                            transformVec(gl_in[2].gl_Position));\n\
                 \x20   highp vec4 bboxMax = max(max(transformVec(gl_in[0].gl_Position),\n\
                 \x20                                transformVec(gl_in[1].gl_Position)),\n\
                 \x20                            transformVec(gl_in[2].gl_Position));\n",
            );
        } else {
            buf.push_str(
                "\n\
                 \x20   highp vec4 bboxMin = u_primitiveBBoxMin;\n\
                 \x20   highp vec4 bboxMax = u_primitiveBBoxMax;\n",
            );
        }

        if !c.use_global_state {
            buf.push_str(
                "\n\
                 \x20   ${PRIM_GL_BOUNDING_BOX}[0] = bboxMin;\n\
                 \x20   ${PRIM_GL_BOUNDING_BOX}[1] = bboxMax;\n",
            );
        }

        buf.push_str(
            "    vp_bbox_expansionSize = 0.0;\n\
             \x20   vp_bbox_clipMin = min(vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMin.x, bboxMin.y, bboxMin.z) / bboxMax.w);\n\
             \x20   vp_bbox_clipMax = max(vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMin.w,\n\
             \x20                         vec3(bboxMax.x, bboxMax.y, bboxMax.z) / bboxMax.w);\n\
             }\n",
        );
        buf
    }

    fn gen_tessellation_evaluation_source(&self, c: &Common) -> String {
        let geo = c.geo_infix();
        format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{TESSELLATION_SHADER_REQUIRE}}\n\
             ${{GPU_SHADER5_REQUIRE}}\n\
             layout(triangles) in;\n\
             \n\
             in highp vec4 tess_ctrl_color[];\n\
             out highp vec4 tess_color;\n\
             uniform highp vec4 u_posScale;\n\
             patch in highp float vp_bbox_expansionSize;\n\
             patch in highp vec3 vp_bbox_clipMin;\n\
             patch in highp vec3 vp_bbox_clipMax;\n\
             flat out highp float v_{geo}bbox_expansionSize;\n\
             flat out highp vec3 v_{geo}bbox_clipMin;\n\
             flat out highp vec3 v_{geo}bbox_clipMax;\n\
             \n\
             precise gl_Position;\n\
             \n\
             {}void main()\n\
             {{\n\
             \x20   // non-trivial tessellation evaluation shader, convert from nonsensical coords, flip vertically\n\
             \x20   gl_Position = mirrorY(gl_TessCoord.x * gl_in[0].gl_Position.zwyx +\n\
             \x20                         gl_TessCoord.y * gl_in[1].gl_Position.zwyx +\n\
             \x20                         gl_TessCoord.z * gl_in[2].gl_Position.zwyx);\n\
             \x20   tess_color = tess_ctrl_color[0];\n\
             \x20   v_{geo}bbox_expansionSize = vp_bbox_expansionSize;\n\
             \x20   v_{geo}bbox_clipMin = vp_bbox_clipMin;\n\
             \x20   v_{geo}bbox_clipMax = vp_bbox_clipMax;\n\
             }}\n",
            gen_shader_function(ShaderFunction::MirrorY)
        )
    }

    fn gen_geometry_source(&self, c: &Common) -> String {
        let color_input_name = if c.has_tessellation_stage {
            "tess_color"
        } else {
            "vtx_color"
        };

        format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{GEOMETRY_SHADER_REQUIRE}}\n\
             layout(triangles) in;\n\
             layout(max_vertices=9, triangle_strip) out;\n\
             \n\
             in highp vec4 {color_input_name}[3];\n\
             out highp vec4 geo_color;\n\
             uniform highp vec4 u_posScale;\n\
             \n\
             flat in highp float v_geo_bbox_expansionSize[3];\n\
             flat in highp vec3 v_geo_bbox_clipMin[3];\n\
             flat in highp vec3 v_geo_bbox_clipMax[3];\n\
             flat out highp vec3 v_bbox_clipMin;\n\
             flat out highp vec3 v_bbox_clipMax;\n\
             flat out highp float v_bbox_expansionSize;\n\
             {}\n\
             void setVisualizationVaryings()\n\
             {{\n\
             \x20   v_bbox_expansionSize = v_geo_bbox_expansionSize[0];\n\
             \x20   v_bbox_clipMin = v_geo_bbox_clipMin[0];\n\
             \x20   v_bbox_clipMax = v_geo_bbox_clipMax[0];\n\
             }}\n\
             void main()\n\
             {{\n\
             \x20   // Non-trivial geometry shader: 1-to-3 amplification, mirror horizontally\n\
             \x20   highp vec4 p0 = mirrorX(gl_in[0].gl_Position);\n\
             \x20   highp vec4 p1 = mirrorX(gl_in[1].gl_Position);\n\
             \x20   highp vec4 p2 = mirrorX(gl_in[2].gl_Position);\n\
             \x20   highp vec4 pCentroid = vec4((p0.xyz + p1.xyz + p2.xyz) / 3.0, 1.0);\n\
             \x20   highp vec4 triangleColor = {color_input_name}[0];\n\
             \n\
             \x20   gl_Position = p0; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = p1; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = pCentroid; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   EndPrimitive();\n\
             \n\
             \x20   gl_Position = p1; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = p2; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = pCentroid; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   EndPrimitive();\n\
             \n\
             \x20   gl_Position = p2; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = p0; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   gl_Position = pCentroid; geo_color = triangleColor; setVisualizationVaryings(); EmitVertex();\n\
             \x20   EndPrimitive();\n\
             }}\n",
            gen_shader_function(ShaderFunction::MirrorX)
        )
    }

    fn generate_config(&self, common: &Common, iteration: i32, render_target_size: [i32; 2]) -> IterationConfig {
        generate_random_config(common, 0xDEDEDEu32.wrapping_mul(iteration as u32), render_target_size)
    }

    fn get_attribute_data(&self) -> Vec<Vec4> {
        let green: Vec4 = [0.0, 1.0, 0.0, 1.0];
        let yellow: Vec4 = [1.0, 1.0, 0.0, 1.0];
        let grid = self.grid_size;
        let g = grid as f32;
        let mut cell_order: Vec<usize> = (0..grid * grid).collect();
        let mut rnd = Random::new(0xDE56789);

        // generate grid with cells in random order
        rnd.shuffle(&mut cell_order);

        let mut data: Vec<Vec4> = vec![[0.0; 4]; grid * grid * 6 * 2];
        for (ndx, &cell_ndx) in cell_order.iter().enumerate() {
            let cell_x = cell_ndx % grid;
            let cell_y = cell_ndx / grid;
            let cell_color = if (cell_x + cell_y).is_multiple_of(2) {
                green
            } else {
                yellow
            };
            let corners = [(0, 0), (1, 1), (0, 1), (0, 0), (1, 0), (1, 1)];

            for (v, &(dx, dy)) in corners.iter().enumerate() {
                data[(ndx * 6 + v) * VA_NUM_ATTRIB_VECS + VA_POS_VEC_NDX] =
                    [(cell_x + dx) as f32 / g, (cell_y + dy) as f32 / g, 0.0, 1.0];
                data[(ndx * 6 + v) * VA_NUM_ATTRIB_VECS + VA_COL_VEC_NDX] = cell_color;
            }
        }
        data
    }

    fn render_test_pattern(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
    ) -> bool {
        let gl = case.gl();

        if !setup_render(case, common, res, config) {
            return false;
        }

        if common.has_tessellation_stage {
            // SAFETY: NUL-terminated name against a linked program.
            let tess_level_pos =
                unsafe { gl.get_uniform_location(res.program.program(), c"u_tessellationLevel".as_ptr()) };
            let tess_level = 2.8f32; // will be rounded up

            if tess_level_pos == -1 {
                case.fail(
                    "TCU_CHECK: u_tessellationLevel not found".to_string(),
                    "uniform not found",
                );
                return false;
            }

            log::debug!("u_tessellationLevel = {tess_level}");

            // SAFETY: a location of the bound program.
            unsafe {
                gl.uniform_1f(tess_level_pos, tess_level);
                gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            }
            case.expect_no_error("patch param");
        }

        log::debug!("Rendering grid.");

        // SAFETY: a draw through the program and attributes set up by `setup_render`.
        unsafe {
            gl.draw_arrays(
                if common.has_tessellation_stage {
                    glw::GL_PATCHES
                } else {
                    glw::GL_TRIANGLES
                },
                0,
                (self.grid_size * self.grid_size * 6) as i32,
            );
        }
        case.expect_no_error("draw");
        true
    }

    fn verify_render_result(
        &self,
        case: &mut ApiCase<'_>,
        common: &Common,
        res: &Resources<'_>,
        config: &IterationConfig,
        _warning: &mut Warning,
    ) {
        let projected = project_bounding_box(config.bbox_min, config.bbox_max);
        let viewport_bbox_area = get_viewport_bounding_box_area(&projected, config.viewport_size, 0.0);
        let outer = get_viewport_pattern_area(
            config.pattern_pos,
            config.pattern_size,
            config.viewport_size,
            AabbRoundDirection::Outwards,
        );
        let inner = get_viewport_pattern_area(
            config.pattern_pos,
            config.pattern_size,
            config.viewport_size,
            AabbRoundDirection::Inwards,
        );

        if !common.calc_per_primitive_bbox {
            log::debug!(
                "Projected bounding box (clip space): {:?}..{:?}; in viewport coordinates {viewport_bbox_area:?}",
                projected.min,
                projected.max
            );
        }

        let Some(viewport_surface) = read_viewport(case, res, config) else {
            return;
        };

        let mut any_error = false;
        for y in viewport_bbox_area[1].max(0)..viewport_bbox_area[3].min(config.viewport_size[1]) {
            for x in viewport_bbox_area[0].max(0)..viewport_bbox_area[2].min(config.viewport_size[0]) {
                let pixel = viewport_surface.get_pixel(x, y);
                let outside_grid = x < outer[0] || y < outer[1] || x > outer[2] || y > outer[3];
                let inside_grid = x > inner[0] && y > inner[1] && x < inner[2] && y < inner[3];

                let mut error = false;
                if outside_grid {
                    // expect black
                    if pixel.get_red() != 0 || pixel.get_green() != 0 || pixel.get_blue() != 0 {
                        error = true;
                    }
                } else if inside_grid {
                    // expect green, yellow or a combination of these
                    if pixel.get_green() != 255 || pixel.get_blue() != 0 {
                        error = true;
                    }
                }
                // boundary, allow anything

                any_error |= error;
            }
        }

        if any_error {
            case.fail("Image verification failed.".to_string(), "Image verification failed");
        }
    }
}

/// One registered bounding-box render case.
struct BBoxTestCase {
    name: String,
    common: Common,
    pattern: Arc<dyn Pattern>,
}

impl glu::TestCase for BBoxTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut case = ApiCase::new(context);
        let mut warning: Warning = None;
        run_bbox_case(&mut case, &self.common, self.pattern.as_ref(), &mut warning);

        let outcome = case.finish();
        if let (Ok(status), Some((result, description))) = (&outcome, warning)
            && status.code() == TestResult::Pass
        {
            return Ok(TestStatus::new(result, description));
        }
        outcome
    }
}

fn add_bbox_case(group: &mut TestCaseGroup, name: &str, num_iterations: i32, flags: u32, pattern: Arc<dyn Pattern>) {
    group.add_child(Box::new(BBoxTestCase {
        name: name.to_string(),
        common: Common::new(num_iterations, flags),
        pattern,
    }) as Box<dyn glu::TestCase>);
}

// ---------------------------------------------------------------------------------------
// registration
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveRenderType {
    Triangle,
    Line { wide: bool },
    Point { wide: bool },
}

/// The `triangles` (and later line/point) groups of `PrimitiveBoundingBoxTests::init`.
pub fn add_groups(parent: &mut TestCaseGroup) {
    const STATE_SET_METHODS: [(&str, u32); 3] = [
        ("global_state", FLAG_SET_BBOX_STATE),
        ("tessellation_set_per_draw", FLAG_SET_BBOX_OUTPUT),
        (
            "tessellation_set_per_primitive",
            FLAG_SET_BBOX_OUTPUT | FLAG_PER_PRIMITIVE_BBOX,
        ),
    ];
    const PIPELINE_CONFIGS: [(&str, u32); 4] = [
        ("vertex_fragment", 0),
        ("vertex_tessellation_fragment", FLAG_TESSELLATION),
        ("vertex_geometry_fragment", FLAG_GEOMETRY),
        (
            "vertex_tessellation_geometry_fragment",
            FLAG_TESSELLATION | FLAG_GEOMETRY,
        ),
    ];
    // (name, flags, invalid flags, required flags)
    const USAGE_CONFIGS: [(&str, u32, u32, u32); 8] = [
        (
            "default_framebuffer_bbox_equal",
            FLAG_RENDERTARGET_DEFAULT | FLAG_BBOXSIZE_EQUAL,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "default_framebuffer_bbox_larger",
            FLAG_RENDERTARGET_DEFAULT | FLAG_BBOXSIZE_LARGER,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "default_framebuffer_bbox_smaller",
            FLAG_RENDERTARGET_DEFAULT | FLAG_BBOXSIZE_SMALLER,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "fbo_bbox_equal",
            FLAG_RENDERTARGET_FBO | FLAG_BBOXSIZE_EQUAL,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "fbo_bbox_larger",
            FLAG_RENDERTARGET_FBO | FLAG_BBOXSIZE_LARGER,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "fbo_bbox_smaller",
            FLAG_RENDERTARGET_FBO | FLAG_BBOXSIZE_SMALLER,
            FLAG_PER_PRIMITIVE_BBOX,
            0,
        ),
        (
            "default_framebuffer",
            FLAG_RENDERTARGET_DEFAULT | FLAG_BBOXSIZE_EQUAL,
            0,
            FLAG_PER_PRIMITIVE_BBOX,
        ),
        (
            "fbo",
            FLAG_RENDERTARGET_FBO | FLAG_BBOXSIZE_EQUAL,
            0,
            FLAG_PER_PRIMITIVE_BBOX,
        ),
    ];
    const PRIMITIVE_TYPES: [(&str, PrimitiveRenderType, u32); 5] = [
        ("triangles", PrimitiveRenderType::Triangle, 0),
        ("lines", PrimitiveRenderType::Line { wide: false }, 0),
        ("points", PrimitiveRenderType::Point { wide: false }, 0),
        ("wide_lines", PrimitiveRenderType::Line { wide: true }, 0),
        ("wide_points", PrimitiveRenderType::Point { wide: true }, 0),
    ];

    for (primitive_name, primitive_type, primitive_flags) in PRIMITIVE_TYPES {
        let mut primitive_group = TestCaseGroup::new(primitive_name);

        for (method_name, method_flags) in STATE_SET_METHODS {
            let mut method_group = TestCaseGroup::new(method_name);

            for (pipeline_name, stage_flags) in PIPELINE_CONFIGS {
                if method_flags & FLAG_SET_BBOX_OUTPUT != 0 && stage_flags & FLAG_TESSELLATION == 0 {
                    // invalid config combination
                    continue;
                }

                let mut pipeline_group = TestCaseGroup::new(pipeline_name);

                for (usage_name, usage_flags, invalid_flags, required_flags) in USAGE_CONFIGS {
                    let flags = primitive_flags | method_flags | stage_flags | usage_flags;

                    if invalid_flags != 0 && flags & invalid_flags != 0 {
                        continue;
                    }
                    if required_flags != 0 && flags & required_flags == 0 {
                        continue;
                    }

                    match primitive_type {
                        PrimitiveRenderType::Triangle => add_bbox_case(
                            &mut pipeline_group,
                            usage_name,
                            12,
                            flags,
                            Arc::new(GridPattern { grid_size: 24 }),
                        ),
                        PrimitiveRenderType::Line { wide } => add_bbox_case(
                            &mut pipeline_group,
                            usage_name,
                            12,
                            flags,
                            Arc::new(LinePattern::new(wide)),
                        ),
                        PrimitiveRenderType::Point { wide } => add_bbox_case(
                            &mut pipeline_group,
                            usage_name,
                            12,
                            flags,
                            Arc::new(PointPattern::new(wide)),
                        ),
                    }
                }

                method_group.add_child(pipeline_group);
            }

            primitive_group.add_child(method_group);
        }

        parent.add_child(primitive_group);
    }
}
