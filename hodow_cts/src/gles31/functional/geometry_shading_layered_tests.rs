// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fGeometryShaderTests.cpp  (LayeredRenderCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// `LayeredRenderCase` renders into every layer of a layered texture with a geometry
// shader and then samples each layer back through a plain fragment shader, so it needs no
// `sglr` machinery. Upstream's one `iterate()` per layer (`CONTINUE`) is a loop here.
// `TARGET_1D_ARRAY` is not ported: it is unreachable (desktop GL only) and no case uses it.

use std::mem::size_of_val;

use crate::gles31::functional::geometry_shading_tests::{check_support, specialize_shader};
use crate::glu::{
    self, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, Texture,
    VertexArray,
};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum LayeredTarget {
    Cube,
    Texture3D,
    Texture2DArray,
    Texture2DMsArray,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum LayeredTest {
    /// draw to default layer
    DefaultLayer,
    /// draw to single layer
    SingleLayer,
    /// draw all layers
    AllLayers,
    /// draw different content to different layers
    DifferentLayers,
    /// draw to all layers, one invocation per layer
    InvocationPerLayer,
    /// draw to all layers, multiple invocations write to multiple layers
    MultipleLayersPerInvocation,
    /// draw to all layers, verify gl_Layer fragment input
    LayerId,
    /// draw primitive with vertices in different layers, check which layer it was drawn to
    LayerProvokingVertex,
}

impl LayeredTarget {
    /// `getTargetLayers`
    fn layers(self) -> i32 {
        match self {
            Self::Cube => 6,
            Self::Texture3D | Self::Texture2DArray => 4,
            Self::Texture2DMsArray => 2,
        }
    }

    /// `getTargetTextureTarget`
    fn texture_target(self) -> GLenum {
        match self {
            Self::Cube => glw::GL_TEXTURE_CUBE_MAP,
            Self::Texture3D => glw::GL_TEXTURE_3D,
            Self::Texture2DArray => glw::GL_TEXTURE_2D_ARRAY,
            Self::Texture2DMsArray => glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        }
    }

    /// `getTargetDimensions`
    fn dimensions(self) -> [i32; 3] {
        match self {
            Self::Cube => [64, 64, 0],
            Self::Texture3D => [64, 64, 4],
            Self::Texture2DArray => [64, 64, 4],
            Self::Texture2DMsArray => [64, 64, 2],
        }
    }

    /// `getResolveDimensions`
    fn resolve_dimensions(self) -> [i32; 2] {
        [64, 64]
    }
}

/// `LayeredRenderCase`
struct LayeredRenderCase {
    name: String,
    target: LayeredTarget,
    test: LayeredTest,
}

const WHITE: [f32; 4] = [1.0, 1.0, 1.0, 1.0];
const COLORS: [[f32; 4]; 6] = [
    [1.0, 1.0, 1.0, 1.0],
    [1.0, 0.0, 0.0, 1.0],
    [0.0, 1.0, 0.0, 1.0],
    [0.0, 0.0, 1.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
    [1.0, 0.0, 1.0, 1.0],
];

impl LayeredRenderCase {
    fn num_layers(&self) -> i32 {
        self.target.layers()
    }

    fn target_layer(&self) -> i32 {
        self.num_layers() / 2
    }

    /// `genFragmentSource`
    fn frag_source(&self, context: &Context) -> String {
        let fragment_layer_id_shader = "${GLSL_VERSION_DECL}\n\
            ${GLSL_EXT_GEOMETRY_SHADER}\
            layout(location = 0) out mediump vec4 fragColor;\n\
            void main (void)\n\
            {\n\
            \tfragColor = vec4(((gl_Layer % 2) == 1) ? 1.0 : 0.5,\n\
            \t                 (((gl_Layer / 2) % 2) == 1) ? 1.0 : 0.5,\n\
            \t                 (gl_Layer == 0) ? 1.0 : 0.0,\n\
            \t                 1.0);\n\
            }\n";

        if self.test != LayeredTest::LayerId {
            specialize_shader(super::geometry_shading_tests::COMMON_FRAGMENT_SOURCE, context)
        } else {
            specialize_shader(fragment_layer_id_shader, context)
        }
    }

    /// `genGeometrySource`
    fn geometry_source(&self, context: &Context) -> String {
        let num_layers = self.num_layers();
        // TEST_DIFFERENT_LAYERS: draw 0 quad to first layer, 1 to second, etc.
        // TEST_ALL_LAYERS: draw 1 quad to all layers
        // TEST_MULTIPLE_LAYERS_PER_INVOCATION: draw 1 triangle to "current layer" and 1 triangle to another layer
        // else: draw 1 quad to some single layer
        let max_vertices = match self.test {
            LayeredTest::DifferentLayers => (2 + num_layers - 1) * num_layers,
            LayeredTest::AllLayers | LayeredTest::LayerId => num_layers * 4,
            LayeredTest::MultipleLayersPerInvocation | LayeredTest::LayerProvokingVertex => 6,
            _ => 4,
        };

        let mut buf = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}");

        if matches!(
            self.test,
            LayeredTest::InvocationPerLayer | LayeredTest::MultipleLayersPerInvocation
        ) {
            buf.push_str(&format!("layout(points, invocations={num_layers}) in;\n"));
        } else {
            buf.push_str("layout(points) in;\n");
        }

        buf.push_str(&format!(
            "layout(triangle_strip, max_vertices = {max_vertices}) out;\n\
             out highp vec4 v_frag_FragColor;\n\
             \n\
             void main (void)\n\
             {{\n"
        ));

        let quad = |layer_expr: Option<&str>, color_expr: &str| -> String {
            let mut s = String::new();
            for position in [
                "vec4(-1.0, -1.0, 0.0, 1.0)",
                "vec4(-1.0,  1.0, 0.0, 1.0)",
                "vec4( 0.0, -1.0, 0.0, 1.0)",
                "vec4( 0.0,  1.0, 0.0, 1.0)",
            ] {
                s.push_str(&format!("    gl_Position = {position};\n"));
                if let Some(layer) = layer_expr {
                    s.push_str(&format!("    gl_Layer = {layer};\n"));
                }
                s.push_str(&format!("    v_frag_FragColor = {color_expr};\n    EmitVertex();\n\n"));
            }
            s
        };

        let color_table = "    const highp vec4 white   = vec4(1.0, 1.0, 1.0, 1.0);\n\
            \x20   const highp vec4 red     = vec4(1.0, 0.0, 0.0, 1.0);\n\
            \x20   const highp vec4 green   = vec4(0.0, 1.0, 0.0, 1.0);\n\
            \x20   const highp vec4 blue    = vec4(0.0, 0.0, 1.0, 1.0);\n\
            \x20   const highp vec4 yellow  = vec4(1.0, 1.0, 0.0, 1.0);\n\
            \x20   const highp vec4 magenta = vec4(1.0, 0.0, 1.0, 1.0);\n\
            \x20   const highp vec4 colors[6] = vec4[6](white, red, green, blue, yellow, magenta);\n";

        match self.test {
            LayeredTest::DefaultLayer => {
                buf.push_str("    const highp vec4 white = vec4(1.0, 1.0, 1.0, 1.0);\n\n");
                buf.push_str(quad(None, "white").trim_end_matches("\n\n"));
                buf.push('\n');
            }
            LayeredTest::SingleLayer => {
                buf.push_str("    const highp vec4 white = vec4(1.0, 1.0, 1.0, 1.0);\n\n");
                buf.push_str(quad(Some(&self.target_layer().to_string()), "white").trim_end_matches("\n\n"));
                buf.push('\n');
            }
            LayeredTest::AllLayers | LayeredTest::LayerId => {
                buf.push_str(color_table);
                buf.push_str(&format!(
                    "\n    for (mediump int layerNdx = 0; layerNdx < {num_layers}; ++layerNdx)\n    {{\n"
                ));
                for (position, last) in [
                    ("vec4(-1.0, -1.0, 0.0, 1.0)", false),
                    ("vec4(-1.0,  1.0, 0.0, 1.0)", false),
                    ("vec4( 0.0, -1.0, 0.0, 1.0)", false),
                    ("vec4( 0.0,  1.0, 0.0, 1.0)", true),
                ] {
                    buf.push_str(&format!(
                        "        gl_Position = {position};\n        gl_Layer = layerNdx;\n        v_frag_FragColor = colors[layerNdx];\n        EmitVertex();\n{}",
                        if last { "        EndPrimitive();\n" } else { "\n" }
                    ));
                }
                buf.push_str("    }\n");
            }
            LayeredTest::DifferentLayers => {
                buf.push_str(&format!(
                    "    const highp vec4 white = vec4(1.0, 1.0, 1.0, 1.0);\n\n\
                     \x20   for (mediump int layerNdx = 0; layerNdx < {num_layers}; ++layerNdx)\n\
                     \x20   {{\n\
                     \x20       for (mediump int colNdx = 0; colNdx <= layerNdx; ++colNdx)\n\
                     \x20       {{\n\
                     \x20           highp float posX = float(colNdx) / float({num_layers}) * 2.0 - 1.0;\n\n\
                     \x20           gl_Position = vec4(posX,  1.0, 0.0, 1.0);\n\
                     \x20           gl_Layer = layerNdx;\n\
                     \x20           v_frag_FragColor = white;\n\
                     \x20           EmitVertex();\n\n\
                     \x20           gl_Position = vec4(posX, -1.0, 0.0, 1.0);\n\
                     \x20           gl_Layer = layerNdx;\n\
                     \x20           v_frag_FragColor = white;\n\
                     \x20           EmitVertex();\n\
                     \x20       }}\n\
                     \x20       EndPrimitive();\n\
                     \x20   }}\n"
                ));
            }
            LayeredTest::InvocationPerLayer => {
                buf.push_str(color_table);
                buf.push('\n');
                for (position, last) in [
                    ("vec4(-1.0, -1.0, 0.0, 1.0)", false),
                    ("vec4(-1.0,  1.0, 0.0, 1.0)", false),
                    ("vec4( 0.0, -1.0, 0.0, 1.0)", false),
                    ("vec4( 0.0,  1.0, 0.0, 1.0)", true),
                ] {
                    buf.push_str(&format!(
                        "    gl_Position = {position};\n    gl_Layer = gl_InvocationID;\n    v_frag_FragColor = colors[gl_InvocationID];\n    EmitVertex();\n{}",
                        if last { "    EndPrimitive();\n" } else { "\n" }
                    ));
                }
            }
            LayeredTest::MultipleLayersPerInvocation => {
                buf.push_str(&format!(
                    "    const highp vec4 white = vec4(1.0, 1.0, 1.0, 1.0);\n\
                     \n\
                     \x20   mediump int layerA = gl_InvocationID;\n\
                     \x20   mediump int layerB = (gl_InvocationID + 1) % {num_layers};\n\
                     \x20   highp float aEnd = float(layerA) / float({num_layers}) * 2.0 - 1.0;\n\
                     \x20   highp float bEnd = float(layerB) / float({num_layers}) * 2.0 - 1.0;\n\
                     \n\
                     \x20   gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerA;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerA;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4(aEnd, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerA;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   EndPrimitive();\n\
                     \n\
                     \x20   gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerB;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4(bEnd,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerB;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4(bEnd, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = layerB;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   EndPrimitive();\n"
                ));
            }
            LayeredTest::LayerProvokingVertex => {
                buf.push_str(
                    "    const highp vec4 white = vec4(1.0, 1.0, 1.0, 1.0);\n\n\
                     \x20   gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 0;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 1;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 1;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   EndPrimitive();\n\n\
                     \x20   gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 0;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4( 0.0, -1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 1;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n\n\
                     \x20   gl_Position = vec4( 0.0,  1.0, 0.0, 1.0);\n\
                     \x20   gl_Layer = 1;\n\
                     \x20   v_frag_FragColor = white;\n\
                     \x20   EmitVertex();\n",
                );
            }
        }

        buf.push_str("}\n");

        specialize_shader(&buf, context)
    }

    /// `genSamplerFragmentSource`
    fn sampler_fragment_source(&self, context: &Context) -> String {
        let [res_x, res_y] = self.target.resolve_dimensions();
        let mut buf = String::from("${GLSL_VERSION_DECL}\n");
        if self.target == LayeredTarget::Texture2DMsArray {
            buf.push_str("${GLSL_OES_TEXTURE_STORAGE_MULTISAMPLE}");
        }
        buf.push_str("layout(location = 0) out mediump vec4 fragColor;\n");

        buf.push_str(match self.target {
            LayeredTarget::Cube => "uniform highp samplerCube u_sampler;\n",
            LayeredTarget::Texture3D => "uniform highp sampler3D u_sampler;\n",
            LayeredTarget::Texture2DArray => "uniform highp sampler2DArray u_sampler;\n",
            LayeredTarget::Texture2DMsArray => "uniform highp sampler2DMSArray u_sampler;\n",
        });

        buf.push_str("uniform highp int u_layer;\nvoid main (void)\n{\n");

        match self.target {
            LayeredTarget::Cube => buf.push_str(&format!(
                "    highp vec2 facepos = 2.0 * gl_FragCoord.xy / vec2(ivec2({res_x}, {res_y})) - vec2(1.0, 1.0);\n\
                 \x20   if (u_layer == 0)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(1.0, -facepos.y, -facepos.x), 0.0);\n\
                 \x20   else if (u_layer == 1)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(-1.0, -facepos.y, facepos.x), 0.0);\n\
                 \x20   else if (u_layer == 2)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(facepos.x, 1.0, facepos.y), 0.0);\n\
                 \x20   else if (u_layer == 3)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(facepos.x, -1.0, -facepos.y), 0.0);\n\
                 \x20   else if (u_layer == 4)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(facepos.x, -facepos.y, 1.0), 0.0);\n\
                 \x20   else if (u_layer == 5)\n\
                 \x20       fragColor = textureLod(u_sampler, vec3(-facepos.x, -facepos.y, -1.0), 0.0);\n\
                 \x20   else\n\
                 \x20       fragColor = vec4(1.0, 0.0, 1.0, 1.0);\n"
            )),
            LayeredTarget::Texture3D | LayeredTarget::Texture2DArray | LayeredTarget::Texture2DMsArray => buf.push_str(
                "    highp ivec2 screenpos = ivec2(floor(gl_FragCoord.xy));\n\
                 \x20   fragColor = texelFetch(u_sampler, ivec3(screenpos, u_layer), 0);\n",
            ),
        }

        buf.push_str("}\n");
        specialize_shader(&buf, context)
    }

    /// `verifyImageSingleColoredRow`
    fn verify_image_single_colored_row(layer: &Surface, row_width_ratio: f32, bar_color: [f32; 4]) -> bool {
        let bar_length = (row_width_ratio * layer.get_width() as f32) as i32;
        let bar_length_threshold = 1;
        let threshold = 8;
        let ref_color = [
            (bar_color[0] * 255.0 + 0.5) as i32,
            (bar_color[1] * 255.0 + 0.5) as i32,
            (bar_color[2] * 255.0 + 0.5) as i32,
        ];

        let mut all_pixels_ok = true;

        for y in 0..layer.get_height() {
            for x in 0..layer.get_width() {
                let color = layer.get_pixel(x, y);
                let is_black =
                    color.get_red() <= threshold || color.get_green() <= threshold || color.get_blue() <= threshold;
                let is_color = (color.get_red() - ref_color[0]).abs() < threshold
                    && (color.get_green() - ref_color[1]).abs() < threshold
                    && (color.get_blue() - ref_color[2]).abs() < threshold;

                let is_ok = if x <= bar_length - bar_length_threshold {
                    is_color
                } else if x >= bar_length + bar_length_threshold {
                    is_black
                } else {
                    is_color || is_black
                };

                all_pixels_ok &= is_ok;
            }
        }

        all_pixels_ok
    }

    /// `verifyEmptyImage`
    fn verify_empty_image(layer: &Surface) -> bool {
        // Expect black
        let threshold = 8;

        for y in 0..layer.get_height() {
            for x in 0..layer.get_width() {
                let color = layer.get_pixel(x, y);
                let is_black =
                    color.get_red() <= threshold || color.get_green() <= threshold || color.get_blue() <= threshold;

                if !is_black {
                    return false;
                }
            }
        }

        true
    }

    /// `verifyProvokingVertexLayers`
    fn verify_provoking_vertex_layers(layer0: &Surface, layer1: &Surface) -> bool {
        let layer0_empty = Self::verify_empty_image(layer0);
        let layer1_empty = Self::verify_empty_image(layer1);

        // Both images could contain something if the quad triangles get assigned to different layers.
        // Expecting non-empty layers, or non-empty layer.
        !(layer0_empty && layer1_empty)
    }

    /// `verifyLayerContent`
    fn verify_layer_content(&self, layer: &Surface, layer_ndx: i32, provoking_vertex: GLenum) -> bool {
        match self.test {
            LayeredTest::DefaultLayer => {
                if layer_ndx == 0 {
                    Self::verify_image_single_colored_row(layer, 0.5, WHITE)
                } else {
                    Self::verify_empty_image(layer)
                }
            }
            LayeredTest::SingleLayer => {
                if layer_ndx == self.target_layer() {
                    Self::verify_image_single_colored_row(layer, 0.5, WHITE)
                } else {
                    Self::verify_empty_image(layer)
                }
            }
            LayeredTest::AllLayers | LayeredTest::InvocationPerLayer => {
                Self::verify_image_single_colored_row(layer, 0.5, COLORS[layer_ndx as usize])
            }
            LayeredTest::DifferentLayers | LayeredTest::MultipleLayersPerInvocation => {
                if layer_ndx == 0 {
                    Self::verify_empty_image(layer)
                } else {
                    Self::verify_image_single_colored_row(layer, layer_ndx as f32 / self.num_layers() as f32, WHITE)
                }
            }
            LayeredTest::LayerId => {
                let layer_color = [
                    if layer_ndx % 2 == 1 { 1.0 } else { 0.5 },
                    if (layer_ndx / 2) % 2 == 1 { 1.0 } else { 0.5 },
                    if layer_ndx == 0 { 1.0 } else { 0.0 },
                    1.0,
                ];
                Self::verify_image_single_colored_row(layer, 0.5, layer_color)
            }
            LayeredTest::LayerProvokingVertex => {
                if provoking_vertex == glw::GL_FIRST_VERTEX_CONVENTION {
                    if layer_ndx == 0 {
                        Self::verify_image_single_colored_row(layer, 0.5, WHITE)
                    } else {
                        Self::verify_empty_image(layer)
                    }
                } else if provoking_vertex == glw::GL_LAST_VERTEX_CONVENTION {
                    if layer_ndx == 1 {
                        Self::verify_image_single_colored_row(layer, 0.5, WHITE)
                    } else {
                        Self::verify_empty_image(layer)
                    }
                } else {
                    false
                }
            }
        }
    }
}

/// `LayeredRenderCase::sampleTextureLayer`
#[allow(clippy::too_many_arguments)]
fn sample_texture_layer(
    context: &Context,
    sampler_shader: &ShaderProgram<'_>,
    sampler_loc: GLint,
    layer_loc: GLint,
    texture_target: GLenum,
    texture: GLuint,
    resolve_dimensions: [i32; 2],
    layer: i32,
) -> Result<Surface, TestError> {
    let gl = context.gl();
    let mut dst = Surface::new(resolve_dimensions[0], resolve_dimensions[1]);

    let fullscreen_quad: [f32; 16] = [
        -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
    ];

    // SAFETY: NUL-terminated name against a linked program.
    let position_loc = unsafe { gl.get_attrib_location(sampler_shader.program(), c"a_position".as_ptr()) } as GLuint;
    let vao = VertexArray::new(gl);
    let buf = Buffer::new(gl);

    // SAFETY: plain state setting.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, resolve_dimensions[0], resolve_dimensions[1]);
    }
    glu::expect_no_error(gl, "clear")?;

    // SAFETY: a buffer name this call generated and an array that outlives the upload.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buf.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(&fullscreen_quad) as GLsizeiptr,
            fullscreen_quad.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "buf")?;

    // SAFETY: the vertex array and buffer set up above.
    unsafe {
        gl.bind_vertex_array(vao.get());
        gl.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(position_loc);
    }
    glu::expect_no_error(gl, "setup attribs")?;

    // SAFETY: the texture the case owns.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(texture_target, texture);
    }
    glu::expect_no_error(gl, "bind texture")?;

    // SAFETY: a linked program and the uniform locations queried from it.
    unsafe {
        gl.use_program(sampler_shader.program());
        gl.uniform_1i(layer_loc, layer);
        gl.uniform_1i(sampler_loc, 0);
    }
    glu::expect_no_error(gl, "setup program")?;

    // SAFETY: draws the quad set up above.
    unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
    glu::expect_no_error(gl, "draw")?;

    // SAFETY: unbinding.
    unsafe {
        gl.use_program(0);
        gl.bind_vertex_array(0);
    }
    glu::expect_no_error(gl, "clean")?;

    glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
    Ok(dst)
}

impl TestCase for LayeredRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !check_support(context) {
            return Err(TestError::NotSupported(
                "Tests require GL_EXT_geometry_shader extension or higher context version.".to_string(),
            ));
        }

        let support_es32 = context.context_type().supports(3, 2);
        if self.target == LayeredTarget::Texture2DMsArray
            && !(support_es32
                && context
                    .context_info
                    .is_extension_supported("GL_OES_texture_storage_multisample_2d_array"))
        {
            return Err(TestError::NotSupported(
                "Test requires OES_texture_storage_multisample_2d_array extension or higher context version."
                    .to_string(),
            ));
        }

        let resolve_dimensions = self.target.resolve_dimensions();
        let render_target = context.render_target();
        if render_target.width < resolve_dimensions[0] || render_target.height < resolve_dimensions[1] {
            return Err(TestError::NotSupported(format!(
                "Render target size must be at least {}x{}",
                resolve_dimensions[0], resolve_dimensions[1]
            )));
        }

        Ok(())
    }

    /// `LayeredRenderCase::init` and every `iterate()` round, run back to back.
    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let gl = context.gl();
        let tex_size = self.target.dimensions();
        let texture_target = self.target.texture_target();
        let num_layers = self.num_layers();
        let resolve_dimensions = self.target.resolve_dimensions();

        // initTexture
        let texture = Texture::new(gl);
        // SAFETY: a texture name this case generated; null pixel data allocates storage only.
        unsafe {
            match self.target {
                LayeredTarget::Cube => {
                    gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.get());
                    for face in [
                        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                    ] {
                        gl.tex_image_2d(
                            face,
                            0,
                            glw::GL_RGBA8 as i32,
                            tex_size[0],
                            tex_size[1],
                            0,
                            glw::GL_RGBA,
                            glw::GL_UNSIGNED_BYTE,
                            std::ptr::null(),
                        );
                    }
                }
                LayeredTarget::Texture3D | LayeredTarget::Texture2DArray => {
                    gl.bind_texture(texture_target, texture.get());
                    gl.tex_image_3d(
                        texture_target,
                        0,
                        glw::GL_RGBA8 as i32,
                        tex_size[0],
                        tex_size[1],
                        tex_size[2],
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        std::ptr::null(),
                    );
                }
                LayeredTarget::Texture2DMsArray => {
                    let num_samples = 2;
                    let mut max_samples = 0;
                    gl.get_integerv(glw::GL_MAX_COLOR_TEXTURE_SAMPLES, &mut max_samples);

                    if num_samples > max_samples {
                        return Err(TestError::NotSupported(format!(
                            "Test requires {num_samples} color texture samples."
                        )));
                    }

                    gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, texture.get());
                    gl.tex_storage_3d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                        num_samples,
                        glw::GL_RGBA8,
                        tex_size[0],
                        tex_size[1],
                        tex_size[2],
                        glw::TRUE,
                    );
                }
            }
        }
        glu::expect_no_error(gl, "tex image")?;

        // Multisample textures don't use filters
        if texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
            // SAFETY: the texture bound above.
            unsafe {
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as i32);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as i32);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_WRAP_R, glw::GL_REPEAT as i32);
            }
            glu::expect_no_error(gl, "tex filter")?;
        }

        // initFbo
        let fbo = Framebuffer::new(gl);
        // SAFETY: names this case generated.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        }
        glu::expect_no_error(gl, "setup fbo")?;

        // initRenderShader
        let position_vertex = "${GLSL_VERSION_DECL}\n\
            void main (void)\n\
            {\n\
            \tgl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n\
            }\n";
        let render_shader = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, specialize_shader(position_vertex, context))
                .with(ShaderType::Fragment, self.frag_source(context))
                .with(ShaderType::Geometry, self.geometry_source(context)),
        );
        if !render_shader.is_ok() {
            return Err(TestError::Fail("failed to build render shader".to_string()));
        }

        // initSamplerShader
        let sampler_vertex = "${GLSL_VERSION_DECL}\n\
            in highp vec4 a_position;\n\
            void main (void)\n\
            {\n\
            \tgl_Position = a_position;\n\
            }\n";
        let sampler_shader = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, specialize_shader(sampler_vertex, context))
                .with(ShaderType::Fragment, self.sampler_fragment_source(context)),
        );
        if !sampler_shader.is_ok() {
            return Err(TestError::Fail("failed to build sampler shader".to_string()));
        }

        // SAFETY: NUL-terminated names against the program just built.
        let (sampler_loc, layer_loc) = unsafe {
            (
                gl.get_uniform_location(sampler_shader.program(), c"u_sampler".as_ptr()),
                gl.get_uniform_location(sampler_shader.program(), c"u_layer".as_ptr()),
            )
        };
        if sampler_loc == -1 {
            return Err(TestError::Fail("u_sampler uniform location = -1".to_string()));
        }
        if layer_loc == -1 {
            return Err(TestError::Fail("u_layer uniform location = -1".to_string()));
        }

        // iteration 1
        let mut provoking_vertex: GLenum = 0;
        if self.test == LayeredTest::LayerProvokingVertex {
            // which layer the implementation claims to render to
            let mut state: GLint = 0;
            // SAFETY: one integer of output.
            unsafe { gl.get_integerv(glw::GL_LAYER_PROVOKING_VERTEX, &mut state) };
            glu::expect_no_error(gl, "getInteger(GL_LAYER_PROVOKING_VERTEX)")?;

            provoking_vertex = state as GLenum;
            let ok = provoking_vertex == glw::GL_FIRST_VERTEX_CONVENTION
                || provoking_vertex == glw::GL_LAST_VERTEX_CONVENTION
                || provoking_vertex == glw::GL_UNDEFINED_VERTEX;
            if !ok {
                return Ok(TestStatus::fail("got unexpected provoking vertex value"));
            }
        }

        // renderToTexture
        {
            let vao = VertexArray::new(gl);

            // SAFETY: the framebuffer, program and vertex array this case owns.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.viewport(0, 0, tex_size[0], tex_size[1]);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                gl.bind_vertex_array(vao.get());
                gl.use_program(render_shader.program());
                gl.draw_arrays(glw::GL_POINTS, 0, 1);
                gl.use_program(0);
                gl.bind_vertex_array(0);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            }
            glu::expect_no_error(gl, "render")?;
        }

        let sample = |layer: i32| {
            sample_texture_layer(
                context,
                &sampler_shader,
                sampler_loc,
                layer_loc,
                texture_target,
                texture.get(),
                resolve_dimensions,
                layer,
            )
        };

        let mut all_layers_ok = true;

        if self.test == LayeredTest::LayerProvokingVertex && provoking_vertex == glw::GL_UNDEFINED_VERTEX {
            // Verification requires information from another layers, layers not independent
            let layer0 = sample(0)?;
            let layer1 = sample(1)?;

            all_layers_ok &= Self::verify_provoking_vertex_layers(&layer0, &layer1);

            // Other layers empty
            for layer_ndx in 2..num_layers {
                let layer = sample(layer_ndx)?;
                all_layers_ok &= Self::verify_empty_image(&layer);
            }
        } else {
            // Layers independent
            for layer_ndx in 0..num_layers {
                let layer = sample(layer_ndx)?;
                all_layers_ok &= self.verify_layer_content(&layer, layer_ndx, provoking_vertex);
            }
        }

        if all_layers_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Detected invalid layer content"))
        }
    }
}

const LAYER_TARGETS: [(LayeredTarget, &str); 4] = [
    (LayeredTarget::Cube, "cubemap"),
    (LayeredTarget::Texture3D, "3d"),
    (LayeredTarget::Texture2DArray, "2d_array"),
    (LayeredTarget::Texture2DMsArray, "2d_multisample_array"),
];

/// The `layered` group of `GeometryShaderTests::init`.
pub fn create_layered_group() -> TestCaseGroup {
    const TESTS: [(LayeredTest, &str); 6] = [
        (LayeredTest::DefaultLayer, "render_with_default_layer_"),
        (LayeredTest::SingleLayer, "render_to_one_"),
        (LayeredTest::AllLayers, "render_to_all_"),
        (LayeredTest::DifferentLayers, "render_different_to_"),
        (LayeredTest::LayerId, "fragment_layer_"),
        (LayeredTest::LayerProvokingVertex, "layer_provoking_vertex_"),
    ];

    let mut group = TestCaseGroup::new("layered");

    for (test, prefix) in TESTS {
        for (target, target_name) in LAYER_TARGETS {
            group.add_child(Box::new(LayeredRenderCase {
                name: format!("{prefix}{target_name}"),
                target,
                test,
            }) as Box<dyn TestCase>);
        }
    }

    group
}

/// The `LayeredRenderCase` members of the `instanced` group: `invocation_per_layer_*` and
/// `multiple_layers_per_invocation_*`.
pub fn add_instanced_layered_cases(group: &mut TestCaseGroup) {
    // invocation per layer
    for (target, target_name) in LAYER_TARGETS {
        group.add_child(Box::new(LayeredRenderCase {
            name: format!("invocation_per_layer_{target_name}"),
            target,
            test: LayeredTest::InvocationPerLayer,
        }) as Box<dyn TestCase>);
    }

    // multiple layers per invocation
    for (target, target_name) in LAYER_TARGETS {
        group.add_child(Box::new(LayeredRenderCase {
            name: format!("multiple_layers_per_invocation_{target_name}"),
            target,
            test: LayeredTest::MultipleLayersPerInvocation,
        }) as Box<dyn TestCase>);
    }
}
