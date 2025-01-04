// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fPrimitiveBoundingBoxTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four sub-groups that need no
// analytical reference pattern: `depth` (DepthDrawCase, 8), `blit_fbo` (BlitFboCase, 3),
// `clear` (ClearCase, 9) and `call_order` (ViewportCallOrderCase, 2).
//
// Narrowing: BlitFboCase is a multi-iteration case upstream (`CONTINUE` per blit); here
// the twelve iterations run in one body and a failed iteration is recorded without
// stopping the rest. A VAO is bound everywhere (upstream binds one only on desktop GL),
// which is harmless on ES. The default framebuffer is name 0 (EGL surface).

use crate::glu::{
    self, ApiCase, Buffer, Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, ShaderType,
    TestCaseGroup, VertexArray, add_api_case,
};
use crate::glw::{self, GLint};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::{Random, de_string_hash};

type Vec4 = [f32; 4];

fn supports_es32(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

/// `boundingBoxSupported`
fn bounding_box_supported(context: &Context) -> bool {
    supports_es32(context)
        || context
            .context_info
            .is_extension_supported("GL_EXT_primitive_bounding_box")
}

fn tessellation_supported(context: &Context) -> bool {
    supports_es32(context)
        || context
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
}

/// `specializeShader`, ES half (this port never creates a desktop context).
fn specialize_shader(context: &Context, code: &str) -> String {
    let es32 = supports_es32(context);
    let (arb, geom_ps, tess_req, prim_bbox_req, bbox_name) = if es32 {
        (
            "",
            "#extension GL_EXT_geometry_point_size : require",
            "",
            "",
            "gl_BoundingBox",
        )
    } else {
        (
            "",
            "#extension GL_EXT_geometry_point_size : require",
            "#extension GL_EXT_tessellation_shader : require",
            "#extension GL_EXT_primitive_bounding_box : require",
            "gl_BoundingBoxEXT",
        )
    };
    let gpu_shader5 = if es32 {
        ""
    } else {
        "#extension GL_EXT_gpu_shader5 : require"
    };

    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
    .replace("${ARB_ES32_COMPATIBILITY_REQUIRE}", arb)
    .replace("${GEOMETRY_POINT_SIZE}", geom_ps)
    .replace("${GPU_SHADER5_REQUIRE}", gpu_shader5)
    .replace("${TESSELLATION_SHADER_REQUIRE}", tess_req)
    .replace("${PRIMITIVE_BOUNDING_BOX_REQUIRE}", prim_bbox_req)
    .replace("${PRIM_GL_BOUNDING_BOX}", bbox_name)
}

/// `getBoundingBoxFunction(...)(min, max)`
fn set_bounding_box(gl: &glw::Functions, min: Vec4, max: Vec4) {
    // SAFETY: eight scalars, on a context that passed `bounding_box_supported`.
    unsafe { gl.primitive_bounding_box(min[0], min[1], min[2], min[3], max[0], max[1], max[2], max[3]) };
}

/// `resetBoundingBox`
fn reset_bounding_box(gl: &glw::Functions) {
    set_bounding_box(gl, [-1.0, -1.0, -1.0, 1.0], [1.0, 1.0, 1.0, 1.0]);
}

fn upload_vec4s(gl: &glw::Functions, buffer: &Buffer<'_>, data: &[Vec4]) {
    // SAFETY: `data` outlives the upload and the size is its own byte length.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(data) as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
}

fn read_viewport(case: &mut ApiCase<'_>, surface: &mut Surface) -> bool {
    match glu::read_pixels(&case.context().render_context, 0, 0, &mut surface.get_access()) {
        Ok(()) => true,
        Err(e) => {
            case.fail(e.to_string(), "Image verification failed");
            false
        }
    }
}

const YELLOWISH_POS_ONLY_VERTEX_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
     in highp vec4 a_position;\n\
     out highp vec4 v_vertex_color;\n\
     void main()\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   // yellowish shade\n\
     \x20   highp float redComponent = 0.5 + float(gl_VertexID % 5) / 8.0;\n\
     \x20   v_vertex_color = vec4(redComponent, 1.0, 0.0, 1.0);\n\
     }\n";

const BASIC_COLOR_FRAGMENT_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
     in mediump vec4 v_color;\n\
     layout(location = 0) out mediump vec4 o_color;\n\
     void main()\n\
     {\n\
     \x20   o_color = v_color;\n\
     }\n";

const BASIC_COLOR_TESS_EVAL_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
     ${TESSELLATION_SHADER_REQUIRE}\n\
     ${GPU_SHADER5_REQUIRE}\n\
     layout(triangles) in;\n\
     in highp vec4 v_tess_eval_color[];\n\
     out highp vec4 v_color;\n\
     precise gl_Position;\n\
     void main()\n\
     {\n\
     \x20   gl_Position = gl_TessCoord.x * gl_in[0].gl_Position\n\
     \x20               + gl_TessCoord.y * gl_in[1].gl_Position\n\
     \x20               + gl_TessCoord.z * gl_in[2].gl_Position;\n\
     \x20   v_color = gl_TessCoord.x * v_tess_eval_color[0]\n\
     \x20           + gl_TessCoord.y * v_tess_eval_color[1]\n\
     \x20           + gl_TessCoord.z * v_tess_eval_color[2];\n\
     }\n";

fn vertex_pointer(gl: &glw::Functions, location: GLint, stride_floats: i32, offset_floats: usize) {
    // SAFETY: a buffer is bound to ARRAY_BUFFER, so the pointer is an offset into it.
    unsafe {
        gl.vertex_attrib_pointer(
            location as u32,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            stride_floats * 4,
            (offset_floats * 4) as *const std::ffi::c_void,
        );
        gl.enable_vertex_attrib_array(location as u32);
    }
}

// ---------------------------------------------------------------------------------------
// depth
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthType {
    Builtin,
    UserDefined,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BBoxState {
    Global,
    PerPrimitive,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BBoxSize {
    Equal,
    Larger,
}

const DEPTH_RENDER_AREA_SIZE: i32 = 256;
const DEPTH_NUM_LAYERS: usize = 14;
const DEPTH_GRID_SIZE: usize = 24;

struct LayerInfo {
    z_offset: f32,
    z_scale: f32,
    color1: Vec4,
    color2: Vec4,
}

fn depth_vertex_source(depth_type: DepthType, state: BBoxState) -> String {
    let has_tess = state == BBoxState::PerPrimitive;
    let mut buf = String::from(
        "${GLSL_VERSION_DECL}\nin highp vec4 a_position;\nin highp vec4 a_colorMix;\nout highp vec4 vtx_colorMix;\n",
    );

    if !has_tess && depth_type == DepthType::UserDefined {
        buf.push_str("out highp float v_fragDepth;\n");
    }
    if !has_tess {
        buf.push_str("uniform highp float u_depthBias;\nuniform highp float u_depthScale;\n");
    }

    buf.push_str("\nvoid main()\n{\n");

    if has_tess {
        buf.push_str("    gl_Position = a_position;\n");
    } else if depth_type == DepthType::UserDefined {
        buf.push_str(
            "    highp float unusedZ = a_position.z;\n\
                 highp float writtenZ = a_position.w;\n\
                 gl_Position = vec4(a_position.xy, unusedZ, 1.0);\n\
                 v_fragDepth = writtenZ * u_depthScale + u_depthBias;\n",
        );
    } else {
        buf.push_str(
            "    highp float writtenZ = a_position.w;\n\
                 gl_Position = vec4(a_position.xy, writtenZ * u_depthScale + u_depthBias, 1.0);\n",
        );
    }

    buf.push_str("    vtx_colorMix = a_colorMix;\n}\n");
    buf
}

fn depth_fragment_source(depth_type: DepthType, state: BBoxState) -> String {
    let color_mix_name = if state == BBoxState::PerPrimitive {
        "tess_eval_colorMix"
    } else {
        "vtx_colorMix"
    };
    let mut buf = format!("${{GLSL_VERSION_DECL}}\nin mediump vec4 {color_mix_name};\n");

    if depth_type == DepthType::UserDefined {
        buf.push_str("in mediump float v_fragDepth;\n");
    }

    buf.push_str(&format!(
        "layout(location = 0) out mediump vec4 o_color;\n\
         uniform highp vec4 u_color1;\n\
         uniform highp vec4 u_color2;\n\
         \n\
         void main()\n\
         {{\n\
         \x20   o_color = mix(u_color1, u_color2, {color_mix_name});\n"
    ));

    if depth_type == DepthType::UserDefined {
        buf.push_str("    gl_FragDepth = v_fragDepth * 0.5 + 0.5;\n");
    }

    buf.push_str("}\n");
    buf
}

fn depth_tess_control_source(bbox_size: BBoxSize) -> String {
    let mut buf = String::from(
        "${GLSL_VERSION_DECL}\n\
         ${ARB_ES32_COMPATIBILITY_REQUIRE}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${PRIMITIVE_BOUNDING_BOX_REQUIRE}\n\
         layout(vertices=3) out;\n\
         \n\
         uniform highp float u_depthBias;\n\
         uniform highp float u_depthScale;\n\
         \n\
         in highp vec4 vtx_colorMix[];\n\
         out highp vec4 tess_ctrl_colorMix[];\n\
         \n\
         void main()\n\
         {\n\
         \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
         \x20   tess_ctrl_colorMix[gl_InvocationID] = vtx_colorMix[0];\n\
         \n\
         \x20   gl_TessLevelOuter[0] = 2.8;\n\
         \x20   gl_TessLevelOuter[1] = 2.8;\n\
         \x20   gl_TessLevelOuter[2] = 2.8;\n\
         \x20   gl_TessLevelInner[0] = 2.8;\n\
         \n\
         \x20   // real Z stored in w component\n\
         \x20   highp vec4 minBound = vec4(min(min(vec3(gl_in[0].gl_Position.xy, gl_in[0].gl_Position.w * u_depthScale + u_depthBias),\n\
         \x20                                      vec3(gl_in[1].gl_Position.xy, gl_in[1].gl_Position.w * u_depthScale + u_depthBias)),\n\
         \x20                                  vec3(gl_in[2].gl_Position.xy, gl_in[2].gl_Position.w * u_depthScale + u_depthBias)), 1.0);\n\
         \x20   highp vec4 maxBound = vec4(max(max(vec3(gl_in[0].gl_Position.xy, gl_in[0].gl_Position.w * u_depthScale + u_depthBias),\n\
         \x20                                      vec3(gl_in[1].gl_Position.xy, gl_in[1].gl_Position.w * u_depthScale + u_depthBias)),\n\
         \x20                                  vec3(gl_in[2].gl_Position.xy, gl_in[2].gl_Position.w * u_depthScale + u_depthBias)), 1.0);\n",
    );

    if bbox_size == BBoxSize::Equal {
        buf.push_str("    ${PRIM_GL_BOUNDING_BOX}[0] = minBound;\n    ${PRIM_GL_BOUNDING_BOX}[1] = maxBound;\n");
    } else {
        buf.push_str(
            "    highp float nedPadding = mod(gl_in[0].gl_Position.z, 0.3);\n\
             \x20   highp float posPadding = mod(gl_in[1].gl_Position.z, 0.3);\n\
             \x20   ${PRIM_GL_BOUNDING_BOX}[0] = minBound - vec4(0.0, 0.0, nedPadding, 0.0);\n\
             \x20   ${PRIM_GL_BOUNDING_BOX}[1] = maxBound + vec4(0.0, 0.0, posPadding, 0.0);\n",
        );
    }

    buf.push_str("}\n");
    buf
}

fn depth_tess_eval_source(depth_type: DepthType) -> String {
    let mut buf = String::from(
        "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GPU_SHADER5_REQUIRE}\n\
         layout(triangles) in;\n\
         \n\
         in highp vec4 tess_ctrl_colorMix[];\n\
         out highp vec4 tess_eval_colorMix;\n",
    );

    if depth_type == DepthType::UserDefined {
        buf.push_str("out highp float v_fragDepth;\n");
    }

    buf.push_str(
        "uniform highp float u_depthBias;\n\
         uniform highp float u_depthScale;\n\
         \n\
         precise gl_Position;\n\
         \n\
         void main()\n\
         {\n\
         \x20   highp vec4 tessellatedPos = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;\n",
    );

    if depth_type == DepthType::UserDefined {
        buf.push_str(
            "    highp float unusedZ = tessellatedPos.z;\n\
             \x20   highp float writtenZ = tessellatedPos.w;\n\
             \x20   gl_Position = vec4(tessellatedPos.xy, unusedZ, 1.0);\n\
             \x20   v_fragDepth = writtenZ * u_depthScale + u_depthBias;\n",
        );
    } else {
        buf.push_str(
            "    highp float writtenZ = tessellatedPos.w;\n\
             \x20   gl_Position = vec4(tessellatedPos.xy, writtenZ * u_depthScale + u_depthBias, 1.0);\n",
        );
    }

    buf.push_str("    tess_eval_colorMix = tess_ctrl_colorMix[0];\n}\n");
    buf
}

/// `DepthDrawCase::generateAttributeData`
fn depth_attribute_data() -> Vec<Vec4> {
    let color1: Vec4 = [0.0, 0.0, 0.0, 0.0];
    let color2: Vec4 = [1.0, 1.0, 1.0, 1.0];
    let grid = DEPTH_GRID_SIZE;
    let mut cell_order: Vec<usize> = (0..grid * grid).collect();
    let mut rnd = Random::new(0xAB54321);
    rnd.shuffle(&mut cell_order);

    let mut data: Vec<Vec4> = vec![[0.0; 4]; grid * grid * 6 * 2];
    let g = grid as f32;
    for (ndx, &cell_ndx) in cell_order.iter().enumerate() {
        let cell_x = cell_ndx % grid;
        let cell_y = cell_ndx / grid;
        let cell_color = if (cell_x + cell_y).is_multiple_of(2) {
            color1
        } else {
            color2
        };
        let px = |dx: usize| (cell_x + dx) as f32 / g * 2.0 - 1.0;
        let py = |dy: usize| (cell_y + dy) as f32 / g * 2.0 - 1.0;
        let corners = [(0, 0), (1, 1), (0, 1), (0, 0), (1, 0), (1, 1)];

        for (vtx_ndx, &(dx, dy)) in corners.iter().enumerate() {
            data[ndx * 12 + 2 * vtx_ndx] = [px(dx), py(dy), 0.0, 0.0];
            data[ndx * 12 + 2 * vtx_ndx + 1] = cell_color;
        }

        // Fill Z with random values (fake Z)
        for vtx_ndx in 0..6 {
            data[ndx * 12 + 2 * vtx_ndx][2] = rnd.get_float_range(0.0, 1.0);
        }
        // Fill W with other random values (written Z)
        for vtx_ndx in 0..6 {
            data[ndx * 12 + 2 * vtx_ndx][3] = rnd.get_float_range(0.0, 1.0);
        }
    }
    data
}

/// `DepthDrawCase::init` + `iterate`
fn depth_draw_case(case: &mut ApiCase<'_>, depth_type: DepthType, state: BBoxState, bbox_size: BBoxSize) {
    let context = case.context();
    let gl = case.gl();

    if !bounding_box_supported(context) {
        case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
        return;
    }
    if state == BBoxState::PerPrimitive && !tessellation_supported(context) {
        case.not_supported("Test requires GL_EXT_tessellation_shader extension");
        return;
    }
    let render_target = context.render_target();
    if render_target.depth_bits == 0 {
        case.not_supported("Test requires depth buffer");
        return;
    }
    if render_target.width < DEPTH_RENDER_AREA_SIZE || render_target.height < DEPTH_RENDER_AREA_SIZE {
        case.not_supported(format!(
            "Test requires {DEPTH_RENDER_AREA_SIZE}x{DEPTH_RENDER_AREA_SIZE} viewport"
        ));
        return;
    }

    let mut sources = ProgramSources::default()
        .with(
            ShaderType::Vertex,
            specialize_shader(context, &depth_vertex_source(depth_type, state)),
        )
        .with(
            ShaderType::Fragment,
            specialize_shader(context, &depth_fragment_source(depth_type, state)),
        );
    if state == BBoxState::PerPrimitive {
        sources = sources
            .with(
                ShaderType::TessControl,
                specialize_shader(context, &depth_tess_control_source(bbox_size)),
            )
            .with(
                ShaderType::TessEvaluation,
                specialize_shader(context, &depth_tess_eval_source(depth_type)),
            );
    }
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    let vao = VertexArray::new(gl);
    // SAFETY: a VAO this case owns.
    unsafe { gl.bind_vertex_array(vao.get()) };

    let vbo = Buffer::new(gl);
    upload_vec4s(gl, &vbo, &depth_attribute_data());
    case.expect_no_error("buf upload");

    // gen layers
    let mut layers: Vec<LayerInfo> = (0..DEPTH_NUM_LAYERS)
        .map(|layer_ndx| LayerInfo {
            z_offset: (layer_ndx as f32 / DEPTH_NUM_LAYERS as f32) * 2.0 - 1.0,
            z_scale: 2.0 / DEPTH_NUM_LAYERS as f32,
            color1: if layer_ndx == 0 {
                [0.0, 1.0, 0.0, 1.0]
            } else {
                [0.0, 0.0, 1.0, 1.0]
            },
            color2: if layer_ndx == 0 {
                [1.0, 1.0, 0.0, 1.0]
            } else {
                [1.0, 0.0, 1.0, 1.0]
            },
        })
        .collect();
    Random::new(0x12345).shuffle(&mut layers);

    let has_tess = state == BBoxState::PerPrimitive;
    let program_id = program.program();
    // SAFETY: NUL-terminated names against a linked program.
    let (pos_loc, col_loc, bias_loc, scale_loc, color1_loc, color2_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_colorMix".as_ptr()),
            gl.get_uniform_location(program_id, c"u_depthBias".as_ptr()),
            gl.get_uniform_location(program_id, c"u_depthScale".as_ptr()),
            gl.get_uniform_location(program_id, c"u_color1".as_ptr()),
            gl.get_uniform_location(program_id, c"u_color2".as_ptr()),
        )
    };
    if [pos_loc, col_loc, bias_loc, scale_loc, color1_loc, color2_loc].contains(&-1) {
        case.fail(
            "TCU_CHECK: attribute or uniform not found".to_string(),
            "attribute or uniform not found",
        );
        return;
    }

    let mut rnd = Random::new(0x213237);

    // SAFETY: plain state setters.
    unsafe {
        gl.viewport(0, 0, DEPTH_RENDER_AREA_SIZE, DEPTH_RENDER_AREA_SIZE);
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear_depthf(1.0);
        gl.depth_func(glw::GL_LESS);
        gl.enable(glw::GL_DEPTH_TEST);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
    }
    case.expect_no_error("setup viewport");

    // SAFETY: the VBO is bound by `upload_vec4s`.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get()) };
    vertex_pointer(gl, pos_loc, 8, 0);
    vertex_pointer(gl, col_loc, 8, 4);
    // SAFETY: a program that linked.
    unsafe { gl.use_program(program_id) };
    case.expect_no_error("setup va");

    if has_tess {
        // SAFETY: state setter.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3) };
    }

    for layer in &layers {
        // SAFETY: locations were checked above; the colour arrays hold four floats.
        unsafe {
            gl.uniform_1f(bias_loc, layer.z_offset);
            gl.uniform_1f(scale_loc, layer.z_scale);
            gl.uniform_4fv(color1_loc, 1, layer.color1.as_ptr());
            gl.uniform_4fv(color2_loc, 1, layer.color2.as_ptr());
        }

        if state == BBoxState::Global {
            let neg_padding = if bbox_size == BBoxSize::Equal {
                0.0
            } else {
                rnd.get_float() * 0.3
            };
            let pos_padding = if bbox_size == BBoxSize::Equal {
                0.0
            } else {
                rnd.get_float() * 0.3
            };

            set_bounding_box(
                gl,
                [-1.0, -1.0, layer.z_offset - neg_padding, 1.0],
                [1.0, 1.0, layer.z_offset + layer.z_scale + pos_padding, 1.0],
            );
        }

        // SAFETY: a draw through the program and attributes set up above.
        unsafe {
            gl.draw_arrays(
                if has_tess { glw::GL_PATCHES } else { glw::GL_TRIANGLES },
                0,
                (DEPTH_GRID_SIZE * DEPTH_GRID_SIZE * 6) as i32,
            )
        };
    }

    let mut viewport = Surface::new(DEPTH_RENDER_AREA_SIZE, DEPTH_RENDER_AREA_SIZE);
    if !read_viewport(case, &mut viewport) {
        reset_bounding_box(gl);
        return;
    }
    case.expect_no_error("render and read");

    reset_bounding_box(gl);

    // `verifyImage`: expect green, yellow or a combination of these
    let mut any_error = false;
    for y in 0..viewport.get_height() {
        for x in 0..viewport.get_width() {
            let pixel = viewport.get_pixel(x, y);
            if pixel.get_green() != 255 || pixel.get_blue() != 0 {
                any_error = true;
            }
        }
    }
    if any_error {
        case.fail("Image verification failed.".to_string(), "Image verification failed");
    }
}

fn depth_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth");

    for (name, depth_type) in [
        ("builtin_depth", DepthType::Builtin),
        ("user_defined_depth", DepthType::UserDefined),
    ] {
        let mut sub = TestCaseGroup::new(name);
        for (case_name, state, bbox_size) in [
            ("global_state_bbox_equal", BBoxState::Global, BBoxSize::Equal),
            ("global_state_bbox_larger", BBoxState::Global, BBoxSize::Larger),
            ("per_primitive_bbox_equal", BBoxState::PerPrimitive, BBoxSize::Equal),
            ("per_primitive_bbox_larger", BBoxState::PerPrimitive, BBoxSize::Larger),
        ] {
            add_api_case(&mut sub, case_name, move |case: &mut ApiCase<'_>| {
                depth_draw_case(case, depth_type, state, bbox_size)
            });
        }
        group.add_child(sub);
    }

    group
}

// ---------------------------------------------------------------------------------------
// blit_fbo
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum BlitTarget {
    Default,
    Fbo,
}

const BLIT_FBO_SIZE: i32 = 256;

struct BlitArgs {
    src: [i32; 4],
    dst: [i32; 4],
    bbox_min: Vec4,
    bbox_max: Vec4,
    linear: bool,
}

/// `BlitFboCase::init`'s iteration generation.
fn blit_iterations(
    src_size: [i32; 2],
    dst_size: [i32; 2],
    default_fb_multisampled: bool,
    src: BlitTarget,
) -> Vec<BlitArgs> {
    let mut rnd = Random::new(0xABC123);
    let mut iterations = Vec::new();

    for _ in 0..12 {
        let (src_rect, dst_rect);

        if src == BlitTarget::Default && default_fb_multisampled {
            let union_size = [src_size[0].min(dst_size[0]), src_size[1].min(dst_size[1])];
            let src_width = rnd.get_int(1, union_size[0]);
            let src_height = rnd.get_int(1, union_size[1]);
            let src_x = rnd.get_int(0, union_size[0] - src_width);
            let src_y = rnd.get_int(0, union_size[1] - src_height);

            src_rect = [src_x, src_y, src_x + src_width, src_y + src_height];
            dst_rect = src_rect;
        } else {
            let src_width = rnd.get_int(1, src_size[0]);
            let src_height = rnd.get_int(1, src_size[1]);
            let src_x = rnd.get_int(0, src_size[0] - src_width);
            let src_y = rnd.get_int(0, src_size[1] - src_height);
            let dst_width = rnd.get_int(1, dst_size[0]);
            let dst_height = rnd.get_int(1, dst_size[1]);
            // allow dst go out of bounds
            let dst_x = rnd.get_int(-(dst_width / 2), dst_size[0] - (dst_width + 1) / 2);
            let dst_y = rnd.get_int(-(dst_height / 2), dst_size[1] - (dst_height + 1) / 2);

            src_rect = [src_x, src_y, src_x + src_width, src_y + src_height];
            dst_rect = [dst_x, dst_y, dst_x + dst_width, dst_y + dst_height];
        }

        let mut bbox_min = [0.0f32; 4];
        let mut bbox_max = [0.0f32; 4];
        bbox_min[0] = rnd.get_float_range(-1.1, 1.1);
        bbox_min[1] = rnd.get_float_range(-1.1, 1.1);
        bbox_min[2] = rnd.get_float_range(-1.1, 1.1);
        bbox_min[3] = rnd.get_float_range(0.9, 1.1);

        bbox_max[0] = rnd.get_float_range(-1.1, 1.1);
        bbox_max[1] = rnd.get_float_range(-1.1, 1.1);
        bbox_max[2] = rnd.get_float_range(-1.1, 1.1);
        bbox_max[3] = rnd.get_float_range(0.9, 1.1);

        for c in 0..3 {
            if bbox_min[c] / bbox_min[3] > bbox_max[c] / bbox_max[3] {
                std::mem::swap(&mut bbox_min[c], &mut bbox_max[c]);
            }
        }

        let linear = rnd.get_bool();

        iterations.push(BlitArgs {
            src: src_rect,
            dst: dst_rect,
            bbox_min,
            bbox_max,
            linear,
        });
    }

    iterations
}

/// `BlitFboCase::verifyImage`
fn blit_verify_image(case: &mut ApiCase<'_>, args: &BlitArgs, dst_size: [i32; 2], dst_fbo: u32) -> bool {
    const COLOR_THRESHOLD: i32 = 4;
    let gl = case.gl();

    // SAFETY: binds a framebuffer this case owns (or the default one).
    unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo) };
    let mut viewport = Surface::new(dst_size[0], dst_size[1]);
    if !read_viewport(case, &mut viewport) {
        return false;
    }

    let mut any_error = false;
    for y in 0..dst_size[1] {
        for x in 0..dst_size[0] {
            let color: RGBA = viewport.get_pixel(x, y);
            let inside = x >= args.dst[0] && x < args.dst[2] && y >= args.dst[1] && y < args.dst[3];
            let error = if inside {
                color.get_green() < 255 - COLOR_THRESHOLD || color.get_blue() > COLOR_THRESHOLD
            } else {
                color.get_red() > COLOR_THRESHOLD
                    || color.get_green() > COLOR_THRESHOLD
                    || color.get_blue() > COLOR_THRESHOLD
            };
            any_error |= error;
        }
    }

    if any_error {
        log::debug!("Image verification failed.");
    }
    !any_error
}

/// `BlitFboCase::init` + `iterate` (all iterations in one body).
fn blit_fbo_case(case: &mut ApiCase<'_>, src: BlitTarget, dst: BlitTarget) {
    let context = case.context();
    let gl = case.gl();
    let render_target = context.render_target();
    let default_fb_multisampled = render_target.num_samples > 1;

    if !bounding_box_supported(context) {
        case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
        return;
    }
    if dst == BlitTarget::Default && default_fb_multisampled {
        case.not_supported("Test requires non-multisampled default framebuffer");
        return;
    }

    // resources
    let src_rbo = Renderbuffer::new(gl);
    let src_fbo = Framebuffer::new(gl);
    let dst_rbo = Renderbuffer::new(gl);
    let dst_fbo = Framebuffer::new(gl);

    if src == BlitTarget::Fbo {
        // SAFETY: names this case owns.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, src_rbo.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, BLIT_FBO_SIZE, BLIT_FBO_SIZE);
        }
        case.expect_no_error("src rbo");
        // SAFETY: as above.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, src_fbo.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                src_rbo.get(),
            );
        }
        case.expect_no_error("src fbo");
    }

    if dst == BlitTarget::Fbo {
        // SAFETY: names this case owns.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, dst_rbo.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, BLIT_FBO_SIZE, BLIT_FBO_SIZE);
        }
        case.expect_no_error("dst rbo");
        // SAFETY: as above.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, dst_fbo.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                dst_rbo.get(),
            );
        }
        case.expect_no_error("dst fbo");
    }

    const VERTEX_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
         in highp vec4 a_position;\n\
         out highp vec4 v_position;\n\
         void main()\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_position = a_position;\n\
         }\n";
    const FRAGMENT_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
         in mediump vec4 v_position;\n\
         layout(location=0) out mediump vec4 dEQP_FragColor;\n\
         void main()\n\
         {\n\
         \x20   const mediump vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
         \x20   const mediump vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
         \x20   dEQP_FragColor = (step(0.1, mod(v_position.x, 0.2)) == step(0.1, mod(v_position.y, 0.2))) ? (green) : (yellow);\n\
         }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_SOURCE))
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_SOURCE));
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    let vao = VertexArray::new(gl);
    // SAFETY: a VAO this case owns.
    unsafe { gl.bind_vertex_array(vao.get()) };

    let quad_coords: [Vec4; 4] = [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let vbo = Buffer::new(gl);
    upload_vec4s(gl, &vbo, &quad_coords);
    case.expect_no_error("set buf");

    // gen iterations
    let size_of_target = |target: BlitTarget| {
        if target == BlitTarget::Default {
            [render_target.width, render_target.height]
        } else {
            [BLIT_FBO_SIZE, BLIT_FBO_SIZE]
        }
    };
    let src_size = size_of_target(src);
    let dst_size = size_of_target(dst);
    log::debug!("srcSize = {src_size:?}, dstSize = {dst_size:?}");
    let iterations = blit_iterations(src_size, dst_size, default_fb_multisampled, src);

    let src_fbo_name = if src == BlitTarget::Fbo { src_fbo.get() } else { 0 };
    let dst_fbo_name = if dst == BlitTarget::Fbo { dst_fbo.get() } else { 0 };
    let program_id = program.program();

    for (iteration, blit_cfg) in iterations.iter().enumerate() {
        // fill source with test pattern. Default fb must be filled for each iteration
        // because contents might not survive the swap
        if src == BlitTarget::Default || iteration == 0 {
            // `fillSourceWithPattern`
            // SAFETY: names owned above; the VBO is bound by `upload_vec4s`.
            let pos_location = unsafe { gl.get_attrib_location(program_id, c"a_position".as_ptr()) };
            unsafe {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, src_fbo_name);
                gl.viewport(0, 0, src_size[0], src_size[1]);
                gl.use_program(program_id);

                gl.clear_color(0.0, 0.0, 1.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            }
            vertex_pointer(gl, pos_location, 4, 0);
            // SAFETY: a draw through the pattern program.
            unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
            case.expect_no_error("draw");
        }

        log::debug!(
            "Iteration {}: bbox min {:?} max {:?}, blit src {:?} dst {:?}, filter {}",
            iteration + 1,
            blit_cfg.bbox_min,
            blit_cfg.bbox_max,
            blit_cfg.src,
            blit_cfg.dst,
            if blit_cfg.linear { "linear" } else { "nearest" }
        );

        set_bounding_box(gl, blit_cfg.bbox_min, blit_cfg.bbox_max);
        // SAFETY: framebuffers owned above (or the default).
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo_name);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, src_fbo_name);
            gl.blit_framebuffer(
                blit_cfg.src[0],
                blit_cfg.src[1],
                blit_cfg.src[2],
                blit_cfg.src[3],
                blit_cfg.dst[0],
                blit_cfg.dst[1],
                blit_cfg.dst[2],
                blit_cfg.dst[3],
                glw::GL_COLOR_BUFFER_BIT,
                if blit_cfg.linear {
                    glw::GL_LINEAR
                } else {
                    glw::GL_NEAREST
                },
            );
        }
        case.expect_no_error("blit");

        reset_bounding_box(gl);

        if !blit_verify_image(case, blit_cfg, dst_size, dst_fbo_name) {
            case.fail(
                format!("iteration {}: unexpected blit result", iteration + 1),
                "Got unexpected blit result",
            );
        }
    }

    // SAFETY: restore the default framebuffer for whatever runs next.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
}

fn blit_fbo_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("blit_fbo");

    for (name, src, dst) in [
        ("blit_default_to_fbo", BlitTarget::Default, BlitTarget::Fbo),
        ("blit_fbo_to_default", BlitTarget::Fbo, BlitTarget::Default),
        ("blit_fbo_to_fbo", BlitTarget::Fbo, BlitTarget::Fbo),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            blit_fbo_case(case, src, dst)
        });
    }

    group
}

// ---------------------------------------------------------------------------------------
// clear
// ---------------------------------------------------------------------------------------

const CLEAR_SCISSOR_CLEAR_BIT: u32 = 1 << 0;
const CLEAR_DRAW_TRIANGLE_BIT: u32 = 1 << 1;
const CLEAR_PER_PRIMITIVE_BBOX_BIT: u32 = 1 << 2;
const CLEAR_FULLSCREEN_SCISSOR_BIT: u32 = 1 << 3;

struct DrawObject {
    first_ndx: i32,
    num_vertices: i32,
}

fn clear_tess_control_source(set_bbox: bool) -> String {
    let mut buf = String::from(
        "${GLSL_VERSION_DECL}\n\
         ${ARB_ES32_COMPATIBILITY_REQUIRE}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n",
    );

    if set_bbox {
        buf.push_str("${PRIMITIVE_BOUNDING_BOX_REQUIRE}\n");
    }

    buf.push_str(
        "layout(vertices=3) out;\n\
         in highp vec4 v_vertex_color[];\n\
         out highp vec4 v_tess_eval_color[];\n\
         void main()\n\
         {\n\
         \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
         \x20   v_tess_eval_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];\n\
         \x20   gl_TessLevelOuter[0] = 2.8;\n\
         \x20   gl_TessLevelOuter[1] = 2.8;\n\
         \x20   gl_TessLevelOuter[2] = 2.8;\n\
         \x20   gl_TessLevelInner[0] = 2.8;\n",
    );

    if set_bbox {
        buf.push_str(
            "\n\
             \x20   ${PRIM_GL_BOUNDING_BOX}[0] = min(min(gl_in[0].gl_Position,\n\
             \x20                                  gl_in[1].gl_Position),\n\
             \x20                              gl_in[2].gl_Position);\n\
             \x20   ${PRIM_GL_BOUNDING_BOX}[1] = max(max(gl_in[0].gl_Position,\n\
             \x20                                  gl_in[1].gl_Position),\n\
             \x20                              gl_in[2].gl_Position);\n",
        );
    }

    buf.push_str("}\n");
    buf
}

fn tess_color_program<'gl>(context: &'gl Context, tess_control: &str) -> ShaderProgram<'gl> {
    let sources = ProgramSources::default()
        .with(
            ShaderType::Vertex,
            specialize_shader(context, YELLOWISH_POS_ONLY_VERTEX_SOURCE),
        )
        .with(
            ShaderType::Fragment,
            specialize_shader(context, BASIC_COLOR_FRAGMENT_SOURCE),
        )
        .with(ShaderType::TessControl, specialize_shader(context, tess_control))
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, BASIC_COLOR_TESS_EVAL_SOURCE),
        );
    ShaderProgram::new(context.gl(), &sources)
}

/// `ClearCase::init` + `iterate`
fn clear_case(case: &mut ApiCase<'_>, name: &str, flags: u32) {
    let scissored_clear = flags & CLEAR_SCISSOR_CLEAR_BIT != 0;
    let fullscreen_scissor = flags & CLEAR_FULLSCREEN_SCISSOR_BIT != 0;
    let draw_triangles = flags & CLEAR_DRAW_TRIANGLE_BIT != 0;
    let use_global_state = flags & CLEAR_PER_PRIMITIVE_BBOX_BIT == 0;
    let context = case.context();
    let gl = case.gl();

    if !bounding_box_supported(context) {
        case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
        return;
    }
    if draw_triangles && !tessellation_supported(context) {
        case.not_supported("Test requires GL_EXT_tessellation_shader extension");
        return;
    }

    // createVbo + createProgram
    let vbo = Buffer::new(gl);
    let mut draw_objects: Vec<DrawObject> = Vec::new();
    let mut object_vertices: Vec<Vec4> = Vec::new();
    let mut basic_program = None;
    let mut per_primitive_program = None;

    if draw_triangles {
        let num_objects = 16;
        let mut rnd = Random::new(de_string_hash(name));

        for _ in 0..num_objects {
            let num_triangles = rnd.get_int(1, 4);
            let min_x = rnd.get_float_range(-1.2, 0.8);
            let min_y = rnd.get_float_range(-1.2, 0.8);
            let max_x = min_x + rnd.get_float_range(0.2, 1.0);
            let max_y = min_y + rnd.get_float_range(0.2, 1.0);

            draw_objects.push(DrawObject {
                first_ndx: object_vertices.len() as i32,
                num_vertices: num_triangles * 3,
            });

            for _ in 0..num_triangles {
                for _ in 0..3 {
                    let pos_x = rnd.get_float_range(min_x, max_x);
                    let pos_y = rnd.get_float_range(min_y, max_y);
                    let pos_z = rnd.get_float_range(-0.7, 0.7);
                    let pos_w = rnd.get_float_range(0.9, 1.1);

                    object_vertices.push([pos_x, pos_y, pos_z, pos_w]);
                }
            }
        }

        upload_vec4s(gl, &vbo, &object_vertices);
        case.expect_no_error("buffer upload");

        let program = tess_color_program(context, &clear_tess_control_source(false));
        if !program.is_ok() {
            case.fail("shader build failed".to_string(), "shader build failed");
            return;
        }
        basic_program = Some(program);

        if !use_global_state {
            let program = tess_color_program(context, &clear_tess_control_source(true));
            if !program.is_ok() {
                case.fail("shader build failed".to_string(), "shader build failed");
                return;
            }
            per_primitive_program = Some(program);
        }
    }

    let render_target = context.render_target();
    let render_target_size = [render_target.width, render_target.height];
    let mut results: Vec<Surface> = Vec::new();

    // render with and without bbox set
    for pass_ndx in 0..2 {
        let use_bbox = pass_ndx == 1;
        let mut dst = Surface::new(render_target_size[0], render_target_size[1]);

        // `renderTo`
        let num_ops = 45;
        let yellow: Vec4 = [1.0, 1.0, 0.0, 1.0];
        let green: Vec4 = [0.0, 1.0, 0.0, 1.0];
        let mut rnd = Random::new(de_string_hash(name));
        let vao = VertexArray::new(gl);

        // always do the initial clear
        // SAFETY: plain state setters.
        unsafe {
            gl.disable(glw::GL_SCISSOR_TEST);
            gl.viewport(0, 0, render_target_size[0], render_target_size[1]);
            gl.clear_color(yellow[0], yellow[1], yellow[2], yellow[3]);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.finish();
        }

        // prepare draw
        if scissored_clear {
            // SAFETY: state setter.
            unsafe { gl.enable(glw::GL_SCISSOR_TEST) };
        }

        if draw_triangles {
            let program = if use_global_state || !use_bbox {
                basic_program.as_ref()
            } else {
                per_primitive_program.as_ref()
            };
            let Some(program) = program else {
                case.fail("program missing".to_string(), "shader build failed");
                return;
            };
            let program_handle = program.program();
            // SAFETY: NUL-terminated name against a linked program.
            let position_attrib_loc = unsafe { gl.get_attrib_location(program_handle, c"a_position".as_ptr()) };
            if position_attrib_loc == -1 {
                case.fail("TCU_CHECK: a_position not found".to_string(), "a_position not found");
                return;
            }

            // SAFETY: names owned by this case.
            unsafe {
                gl.use_program(program_handle);
                gl.bind_vertex_array(vao.get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            }
            vertex_pointer(gl, position_attrib_loc, 4, 0);
            // SAFETY: state setter.
            unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3) };
        }

        // do random scissor/clear/draw operations
        for _ in 0..num_ops {
            let draw_obj_ndx = if draw_triangles {
                rnd.get_int(0, draw_objects.len() as i32 - 1) as usize
            } else {
                0
            };
            let (vertex_start, vertex_len) = if draw_triangles {
                (
                    draw_objects[draw_obj_ndx].first_ndx,
                    draw_objects[draw_obj_ndx].num_vertices,
                )
            } else {
                (0, 0)
            };
            let mut bbox_min: Vec4;
            let mut bbox_max: Vec4;

            if draw_triangles {
                bbox_min = [1.0, 1.0, 1.0, 1.0];
                bbox_max = [-1.0, -1.0, -1.0, -1.0];

                // calc bbox
                for vertex_ndx in vertex_start..vertex_start + vertex_len {
                    for component_ndx in 0..4 {
                        let v = object_vertices[vertex_ndx as usize][component_ndx];
                        bbox_min[component_ndx] = bbox_min[component_ndx].min(v);
                        bbox_max[component_ndx] = bbox_max[component_ndx].max(v);
                    }
                }
            } else {
                // no geometry, just random something
                bbox_min = [0.0, 0.0, 0.0, 1.0];
                bbox_min[0] = rnd.get_float_range(-1.2, 1.0);
                bbox_min[1] = rnd.get_float_range(-1.2, 1.0);
                bbox_min[2] = rnd.get_float_range(-1.2, 1.0);
                bbox_max = [0.0, 0.0, 0.0, 1.0];
                bbox_max[0] = bbox_min[0] + rnd.get_float_range(0.2, 1.0);
                bbox_max[1] = bbox_min[1] + rnd.get_float_range(0.2, 1.0);
                bbox_max[2] = bbox_min[2] + rnd.get_float_range(0.2, 1.0);
            }

            if scissored_clear {
                let scissor_x = if fullscreen_scissor {
                    0
                } else {
                    rnd.get_int(0, render_target_size[0] - 1)
                };
                let scissor_y = if fullscreen_scissor {
                    0
                } else {
                    rnd.get_int(0, render_target_size[1] - 1)
                };
                let scissor_w = if fullscreen_scissor {
                    render_target_size[0]
                } else {
                    rnd.get_int(0, render_target_size[0] - scissor_x)
                };
                let scissor_h = if fullscreen_scissor {
                    render_target_size[1]
                } else {
                    rnd.get_int(0, render_target_size[1] - scissor_y)
                };

                // SAFETY: state setter.
                unsafe { gl.scissor(scissor_x, scissor_y, scissor_w, scissor_h) };
            }

            {
                // `tcu::mix(green, yellow, rnd.getFloat() * 0.4f)` - greenish
                let t = rnd.get_float() * 0.4;
                let color: Vec4 = std::array::from_fn(|c| green[c] * (1.0 - t) + yellow[c] * t);
                // SAFETY: state setter plus a clear.
                unsafe {
                    gl.clear_color(color[0], color[1], color[2], color[3]);
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                }
            }

            if use_bbox && use_global_state {
                set_bounding_box(gl, bbox_min, bbox_max);
            }

            if draw_triangles {
                // SAFETY: a draw through the program and attribute set up above.
                unsafe { gl.draw_arrays(glw::GL_PATCHES, vertex_start, vertex_len) };
            }
        }

        reset_bounding_box(gl);

        case.expect_no_error("post draw");
        if !read_viewport(case, &mut dst) {
            // SAFETY: state setter.
            unsafe { gl.disable(glw::GL_SCISSOR_TEST) };
            return;
        }
        results.push(dst);
    }

    // SAFETY: leave the scissor test off for whatever runs next.
    unsafe { gl.disable(glw::GL_SCISSOR_TEST) };

    let (without_bbox, with_bbox) = (&results[0], &results[1]);

    // `verifyImagesEqual`
    let mut images_differ = false;
    for y in 0..without_bbox.get_height() {
        for x in 0..without_bbox.get_width() {
            if without_bbox.get_pixel(x, y) != with_bbox.get_pixel(x, y) {
                images_differ = true;
            }
        }
    }
    if images_differ {
        case.fail("Image comparison failed.".to_string(), "Image comparison failed");
        return;
    }

    // `verifyImageResultValid`: allow green, yellow and any shade between
    let mut invalid = false;
    for y in 0..with_bbox.get_height() {
        for x in 0..with_bbox.get_width() {
            let pixel = with_bbox.get_pixel(x, y);
            if pixel.get_green() != 255 || pixel.get_blue() != 0 {
                invalid = true;
            }
        }
    }
    if invalid {
        case.fail("Image verification failed.".to_string(), "Result verification failed");
    }
}

fn clear_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clear");

    let cases: [(&'static str, u32); 9] = [
        ("full_clear", 0),
        ("full_clear_with_triangles", CLEAR_DRAW_TRIANGLE_BIT),
        (
            "full_clear_with_triangles_per_primitive_bbox",
            CLEAR_DRAW_TRIANGLE_BIT | CLEAR_PER_PRIMITIVE_BBOX_BIT,
        ),
        ("scissored_clear", CLEAR_SCISSOR_CLEAR_BIT),
        (
            "scissored_clear_with_triangles",
            CLEAR_SCISSOR_CLEAR_BIT | CLEAR_DRAW_TRIANGLE_BIT,
        ),
        (
            "scissored_clear_with_triangles_per_primitive_bbox",
            CLEAR_SCISSOR_CLEAR_BIT | CLEAR_DRAW_TRIANGLE_BIT | CLEAR_PER_PRIMITIVE_BBOX_BIT,
        ),
        (
            "scissored_full_clear",
            CLEAR_FULLSCREEN_SCISSOR_BIT | CLEAR_SCISSOR_CLEAR_BIT,
        ),
        (
            "scissored_full_clear_with_triangles",
            CLEAR_FULLSCREEN_SCISSOR_BIT | CLEAR_SCISSOR_CLEAR_BIT | CLEAR_DRAW_TRIANGLE_BIT,
        ),
        (
            "scissored_full_clear_with_triangles_per_primitive_bbox",
            CLEAR_FULLSCREEN_SCISSOR_BIT
                | CLEAR_SCISSOR_CLEAR_BIT
                | CLEAR_DRAW_TRIANGLE_BIT
                | CLEAR_PER_PRIMITIVE_BBOX_BIT,
        ),
    ];
    for (name, flags) in cases {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            clear_case(case, name, flags)
        });
    }

    group
}

// ---------------------------------------------------------------------------------------
// call_order
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum CallOrder {
    ViewportFirst,
    BBoxFirst,
}

fn call_order_tess_control_source() -> &'static str {
    "${GLSL_VERSION_DECL}\n\
     ${ARB_ES32_COMPATIBILITY_REQUIRE}\n\
     ${TESSELLATION_SHADER_REQUIRE}\n\
     layout(vertices=3) out;\n\
     in highp vec4 v_vertex_color[];\n\
     out highp vec4 v_tess_eval_color[];\n\
     void main()\n\
     {\n\
     \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
     \x20   v_tess_eval_color[gl_InvocationID] = v_vertex_color[gl_InvocationID];\n\
     \x20   gl_TessLevelOuter[0] = 2.8;\n\
     \x20   gl_TessLevelOuter[1] = 2.8;\n\
     \x20   gl_TessLevelOuter[2] = 2.8;\n\
     \x20   gl_TessLevelInner[0] = 2.8;\n\
     }\n"
}

/// `ViewportCallOrderCase::genVbo`
fn call_order_vbo_data() -> Vec<Vec4> {
    let grid_size = 6usize;
    let g = grid_size as f32;
    let mut data: Vec<Vec4> = vec![[0.0; 4]; grid_size * grid_size * 2 * 3];
    let mut cell_order: Vec<usize> = (0..grid_size * grid_size * 2).collect();
    let mut rnd = Random::new(0x55443322);

    // generate grid with triangles in random order
    rnd.shuffle(&mut cell_order);

    // generate grid filling the right half of the clip space: (x: 0.0, y: -1.0) .. (x: 1.0, y: 1.0)
    for (ndx, &cell_ndx) in cell_order.iter().enumerate() {
        let cell_side = cell_ndx % 2 == 0;
        let cell_x = (cell_ndx / 2) % grid_size;
        let cell_y = (cell_ndx / 2) / grid_size;
        let px = |dx: usize| (cell_x + dx) as f32 / g;
        let py = |dy: usize| ((cell_y + dy) as f32 / g) * 2.0 - 1.0;

        let corners = if cell_side {
            [(0, 0), (1, 1), (0, 1)]
        } else {
            [(0, 0), (1, 0), (1, 1)]
        };
        for (i, &(dx, dy)) in corners.iter().enumerate() {
            data[ndx * 3 + i] = [px(dx), py(dy), 0.0, 1.0];
        }
    }

    data
}

/// `ViewportCallOrderCase::verifyImage`
fn call_order_verify_image(result: &Surface) -> bool {
    let width = result.get_width() as f32;
    let inside_border = [(0.25 * width).ceil() as i32 + 1, (0.5 * width).floor() as i32 - 1];
    let outside_border = [(0.25 * width).floor() as i32 - 1, (0.5 * width).ceil() as i32 + 1];
    let mut any_error = false;

    for y in 0..result.get_height() {
        for x in 0..result.get_width() {
            // the "y" of each border vector is xmax
            let pixel = result.get_pixel(x, y);
            let inside_mesh_area = x >= inside_border[0] && x <= inside_border[1];
            let outside_mesh_area = x <= outside_border[0] && x >= outside_border[1];

            // inside mesh, allow green, yellow and any shade between
            // outside mesh, allow background (black) only
            // in the border area, allow anything
            if (inside_mesh_area && (pixel.get_green() != 255 || pixel.get_blue() != 0))
                || (outside_mesh_area && (pixel.get_red() != 0 || pixel.get_green() != 0 || pixel.get_blue() != 0))
            {
                any_error = true;
            }
        }
    }

    if any_error {
        log::debug!("Image verification failed.");
    }
    !any_error
}

/// `ViewportCallOrderCase::init` + `iterate`
fn viewport_call_order_case(case: &mut ApiCase<'_>, call_order: CallOrder) {
    let context = case.context();
    let gl = case.gl();

    if !bounding_box_supported(context) {
        case.not_supported("Test requires GL_EXT_primitive_bounding_box extension");
        return;
    }
    if !tessellation_supported(context) {
        case.not_supported("Test requires GL_EXT_tessellation_shader extension");
        return;
    }

    // resources
    let data = call_order_vbo_data();
    let vao = VertexArray::new(gl);
    // SAFETY: a VAO this case owns.
    unsafe { gl.bind_vertex_array(vao.get()) };
    let vbo = Buffer::new(gl);
    upload_vec4s(gl, &vbo, &data);
    case.expect_no_error("create vbo");

    let sources = ProgramSources::default()
        .with(
            ShaderType::Vertex,
            specialize_shader(context, YELLOWISH_POS_ONLY_VERTEX_SOURCE),
        )
        .with(
            ShaderType::Fragment,
            specialize_shader(context, BASIC_COLOR_FRAGMENT_SOURCE),
        )
        .with(
            ShaderType::TessControl,
            specialize_shader(context, call_order_tess_control_source()),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, BASIC_COLOR_TESS_EVAL_SOURCE),
        );
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("shader build failed".to_string(), "shader build failed");
        return;
    }

    let render_target = context.render_target();
    let viewport_size = [render_target.width, render_target.height];
    // SAFETY: NUL-terminated name against a linked program.
    let pos_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
    let mut result_surface = Surface::new(viewport_size[0], viewport_size[1]);

    // SAFETY: state setters.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    // set state
    for order_ndx in 0..2 {
        if (order_ndx == 0 && call_order == CallOrder::ViewportFirst)
            || (order_ndx == 1 && call_order == CallOrder::BBoxFirst)
        {
            log::debug!("Setting viewport to cover the left half of the render target.");
            // SAFETY: state setter.
            unsafe { gl.viewport(0, 0, viewport_size[0] / 2, viewport_size[1]) };
        } else {
            log::debug!("Setting bounding box to cover the right half of the clip space.");
            set_bounding_box(gl, [0.0, -1.0, -1.0, 1.0], [1.0, 1.0, 1.0, 1.0]);
        }
    }

    log::debug!("Rendering mesh covering the right half of the clip space.");

    // SAFETY: the VBO is the one just filled.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get()) };
    vertex_pointer(gl, pos_location, 4, 0);
    // SAFETY: a draw through the program that linked.
    unsafe {
        gl.use_program(program.program());
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
        gl.draw_arrays(glw::GL_PATCHES, 0, data.len() as i32);
    }
    case.expect_no_error("post-draw");

    log::debug!("Verifying image");
    let read_ok = read_viewport(case, &mut result_surface);

    reset_bounding_box(gl);

    if read_ok && !call_order_verify_image(&result_surface) {
        case.fail("Image verification failed.".to_string(), "Image verification failed");
    }
}

fn call_order_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("call_order");

    add_api_case(&mut group, "viewport_first_bbox_second", |case: &mut ApiCase<'_>| {
        viewport_call_order_case(case, CallOrder::ViewportFirst)
    });
    add_api_case(&mut group, "bbox_first_viewport_second", |case: &mut ApiCase<'_>| {
        viewport_call_order_case(case, CallOrder::BBoxFirst)
    });

    group
}

/// The `depth`, `blit_fbo`, `clear` and `call_order` sub-groups, in upstream's order.
pub fn add_groups(parent: &mut TestCaseGroup) {
    parent.add_child(depth_group());
    parent.add_child(blit_fbo_group());
    parent.add_child(clear_group());
    parent.add_child(call_order_group());
}
