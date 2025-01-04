// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderAlgorithmTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `SHADER_OP_CASE` macro declares a local struct per case whose only member
// is the evaluator, then registers the vertex and the fragment variant of it; here the
// evaluator is a `fn(&mut ShaderEvalContext)` in the case spec and the two variants come
// off the same `create_expression_case`, which is what the macro does.
//
// `image_to_grayscale` stays commented out, as it is upstream: it samples `ut_brick`,
// which is a texture from the test archive, and this binary reads no files.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{TestCase, TestCaseGroup};
use crate::tcu::StringTemplate;

/// `gles2::Functional::ShaderAlgorithmCase`
struct ShaderAlgorithmCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    eval_func: fn(&mut ShaderEvalContext),
}

impl ShaderRenderCaseSpec for ShaderAlgorithmCaseSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        (self.eval_func)(ctx);
    }
}

/// `createExpressionCase`
fn create_expression_case(
    case_name: &str,
    is_vertex_case: bool,
    eval_func: fn(&mut ShaderEvalContext),
    shader_body: &[&str],
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();

    vtx.push_str("attribute highp vec4 a_position;\n");
    vtx.push_str("attribute ${PRECISION} vec4 a_unitCoords;\n");

    if is_vertex_case {
        vtx.push_str("varying mediump vec3 v_color;\n");
        frag.push_str("varying mediump vec3 v_color;\n");
    } else {
        vtx.push_str("varying mediump vec4 v_coords;\n");
        frag.push_str("varying mediump vec4 v_coords;\n");
    }

    // op << "uniform mediump sampler2D ut_brick;\n";

    vtx.push('\n');
    vtx.push_str("void main()\n");
    vtx.push_str("{\n");
    vtx.push_str("    gl_Position = a_position;\n");

    frag.push('\n');
    frag.push_str("void main()\n");
    frag.push_str("{\n");

    // Write matrix.
    {
        let op = if is_vertex_case { &mut vtx } else { &mut frag };

        if is_vertex_case {
            op.push_str("    ${PRECISION} vec4 coords = a_unitCoords;\n");
        } else {
            op.push_str("    ${PRECISION} vec4 coords = v_coords;\n");
        }

        op.push_str("    ${PRECISION} vec3 res = vec3(0.0);\n");
        // `LineStream(1)`: one tab of indent per line, each newline-terminated.
        for line in shader_body {
            op.push('\t');
            op.push_str(line);
            op.push('\n');
        }
    }

    if is_vertex_case {
        vtx.push_str("    v_color = res;\n");
        frag.push_str("    gl_FragColor = vec4(v_color, 1.0);\n");
    } else {
        vtx.push_str("    v_coords = a_unitCoords;\n");
        frag.push_str("    gl_FragColor = vec4(res, 1.0);\n");
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    // Fill in shader templates.
    let params: [(&str, String); 1] = [("PRECISION", "mediump".to_string())];
    let vertex_shader_source = StringTemplate::new(vtx)
        .specialize(&params)
        .expect("PRECISION is the only placeholder");
    let fragment_shader_source = StringTemplate::new(frag)
        .specialize(&params)
        .expect("PRECISION is the only placeholder");

    Box::new(ShaderRenderCase::new(ShaderAlgorithmCaseSpec {
        name: case_name.to_string(),
        vert_src: vertex_shader_source,
        frag_src: fragment_shader_source,
        is_vertex_case,
        eval_func,
    }))
}

/// `hsl_to_rgb`'s shader body
const HSL_TO_RGB_BODY: &[&str] = &[
    "mediump float H = coords.x, S = coords.y, L = coords.z;",
    "mediump float v = (L <= 0.5) ? (L * (1.0 + S)) : (L + S - L * S);",
    "res = vec3(L); // default to gray",
    "if (v > 0.0)",
    "{",
    "    mediump float m = L + L - v;",
    "    mediump float sv = (v - m) / v;",
    "    H *= 6.0;",
    "    mediump int sextant = int(H);",
    "    mediump float fract = H - float(sextant);",
    "    mediump float vsf = v * sv * fract;",
    "    mediump float mid1 = m + vsf;",
    "    mediump float mid2 = m - vsf;",
    "    if (sextant == 0)      res = vec3(v, mid1, m);",
    "    else if (sextant == 1) res = vec3(mid2, v, m);",
    "    else if (sextant == 2) res = vec3(m, v, mid1);",
    "    else if (sextant == 3) res = vec3(m, mid2, v);",
    "    else if (sextant == 4) res = vec3(mid1, m, v);",
    "    else                   res = vec3(v, m, mid2);",
    "}",
];

/// `hsl_to_rgb`'s `EVAL_FUNC_BODY`
fn eval_hsl_to_rgb(c: &mut ShaderEvalContext) {
    let mut h = c.unit_coords.x();
    let s = c.unit_coords.y();
    let l = c.unit_coords.z();
    let mut rgb = [l, l, l];
    let v = if l <= 0.5 { l * (1.0 + s) } else { l + s - l * s };

    if v > 0.0 {
        let m = l + l - v;
        let sv = (v - m) / v;
        h *= 6.0;
        #[expect(
            clippy::cast_possible_truncation,
            reason = "upstream's `int(H)`, over a unit-coordinate H scaled by 6"
        )]
        let sextant = h as i32;
        let fract = h - sextant as f32;
        let vsf = v * sv * fract;
        let mid1 = m + vsf;
        let mid2 = m - vsf;
        rgb = match sextant {
            0 => [v, mid1, m],
            1 => [mid2, v, m],
            2 => [m, v, mid1],
            3 => [m, mid2, v],
            4 => [mid1, m, v],
            _ => [v, m, mid2],
        };
    }

    c.color.m_data[..3].copy_from_slice(&rgb);
}

/// `rgb_to_hsl`'s shader body
const RGB_TO_HSL_BODY: &[&str] = &[
    "mediump float r = coords.x, g = coords.y, b = coords.z;",
    "mediump float minVal = min(min(r, g), b);",
    "mediump float maxVal = max(max(r, g), b);",
    "mediump float L = (minVal + maxVal) * 0.5;",
    "if (minVal == maxVal)",
    "    res = vec3(0.0, 0.0, L);",
    "else",
    "{",
    "    mediump float H;",
    "    mediump float S;",
    "    if (L < 0.5)",
    "        S = (maxVal - minVal) / (maxVal + minVal);",
    "    else",
    "        S = (maxVal - minVal) / (2.0 - maxVal - minVal);",
    "",
    "    mediump float ooDiff = 1.0 / (maxVal - minVal);",
    "    if (r == maxVal)      H = (g - b) * ooDiff;",
    "    else if (g == maxVal) H = 2.0 + (b - r) * ooDiff;",
    "    else                  H = 4.0 + (r - g) * ooDiff;",
    "    H /= 6.0;",
    "",
    "    res = vec3(H, S, L);",
    "}",
];

/// `rgb_to_hsl`'s `EVAL_FUNC_BODY`
fn eval_rgb_to_hsl(c: &mut ShaderEvalContext) {
    let r = c.unit_coords.x();
    let g = c.unit_coords.y();
    let b = c.unit_coords.z();
    let min_val = r.min(g).min(b);
    let max_val = r.max(g).max(b);
    let l = (min_val + max_val) * 0.5;

    let hsl = if min_val == max_val {
        [0.0, 0.0, l]
    } else {
        let s = if l < 0.5 {
            (max_val - min_val) / (max_val + min_val)
        } else {
            (max_val - min_val) / (2.0 - max_val - min_val)
        };

        let oo_diff = 1.0 / (max_val - min_val);
        let mut h = if r == max_val {
            (g - b) * oo_diff
        } else if g == max_val {
            (b - r).mul_add(oo_diff, 2.0)
        } else {
            (r - g).mul_add(oo_diff, 4.0)
        };
        h /= 6.0;

        [h, s, l]
    };

    c.color.m_data[..3].copy_from_slice(&hsl);
}

/// `ShaderAlgorithmTests::init`
pub fn create_tests() -> TestCaseGroup {
    // TestCaseGroup* colorGroup = new TestCaseGroup(m_testCtx, "color", "Miscellaneous color related algorithm tests.");
    // addChild(colorGroup);
    let mut group = TestCaseGroup::new("algorithm");

    for (name, eval_func, body) in [
        (
            "hsl_to_rgb",
            eval_hsl_to_rgb as fn(&mut ShaderEvalContext),
            HSL_TO_RGB_BODY,
        ),
        (
            "rgb_to_hsl",
            eval_rgb_to_hsl as fn(&mut ShaderEvalContext),
            RGB_TO_HSL_BODY,
        ),
    ] {
        group.add_child(create_expression_case(&format!("{name}_vertex"), true, eval_func, body));
        group.add_child(create_expression_case(
            &format!("{name}_fragment"),
            false,
            eval_func,
            body,
        ));
    }

    group
}
