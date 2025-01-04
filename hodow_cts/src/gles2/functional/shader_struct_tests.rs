// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderStructTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every shader source is the upstream `LineStream()` verbatim, one `&str` per line; the
// `${...}` placeholders are the same ones `createStructCase` fills in.

use crate::gls::brick_texture::{BrickGlTexture, sample_brick};
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderEvalFunc, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{GLfloat, GLint, GLuint};
use crate::tcu::vector::{Vec2, Vec3, Vec4};
use crate::tcu::{StringTemplate, TestError};

/// `SetupUniformsFunc`
type SetupUniformsFn = fn(&Context, GLuint, Vec4) -> Result<(), TestError>;

/// `gles2::Functional::ShaderStructCase`
struct ShaderStructCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    eval_func: ShaderEvalFunc,
    setup_uniforms: Option<SetupUniformsFn>,
    brick: Option<BrickGlTexture>,
}

impl ShaderRenderCaseSpec for ShaderStructCaseSpec {
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
        (self.eval_func)(ctx)
    }

    /// `ShaderStructCase::setupUniforms`
    fn setup_uniforms(&self, context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
        if let Some(setup) = self.setup_uniforms {
            setup(context, program, const_coords)?;
        }
        match &self.brick {
            Some(brick) => brick.bind(context, program, "ut_brick"),
            None => Ok(()),
        }
    }

    fn cleanup(&self, context: &Context) {
        if let Some(brick) = &self.brick {
            brick.cleanup(context);
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.brick.is_some() && self.is_vertex_case {
            let mut units: GLint = 0;
            // SAFETY: `units` is a valid destination for one `GLint`.
            unsafe {
                context
                    .gl()
                    .get_integerv(crate::glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &mut units)
            };
            if units == 0 {
                return Err(TestError::NotSupported(
                    "Vertex shader texture access not supported".to_string(),
                ));
            }
        }
        Ok(())
    }
}

/// The `defaultVertSrc` a fragment case pairs with.
const DEFAULT_VERT_SRC: &str = "attribute highp vec4 a_position;\n\
    attribute highp vec4 a_coords;\n\
    varying mediump vec4 v_coords;\n\n\
    void main (void)\n\
    {\n\
    \x20   v_coords = a_coords;\n\
    \x20   gl_Position = a_position;\n\
    }\n";

/// The `defaultFragSrc` a vertex case pairs with.
const DEFAULT_FRAG_SRC: &str = "varying mediump vec4 v_color;\n\n\
    void main (void)\n\
    {\n\
    \x20   gl_FragColor = v_color;\n\
    }\n";

/// `LineStream()` - no indent, one newline per line.
fn line_stream(lines: &[&str]) -> String {
    lines.iter().map(|line| format!("{line}\n")).collect()
}

/// `createStructCase`
fn create_struct_case(
    name: &str,
    is_vertex_case: bool,
    eval_func: ShaderEvalFunc,
    setup_uniforms: Option<SetupUniformsFn>,
    shader_src: &[&str],
    additional_params: &[(&str, &str)],
    uses_texture: bool,
) -> Box<dyn TestCase> {
    // Fill in specialization parameters.
    let mut sp_params: Vec<(&str, String)> = if is_vertex_case {
        vec![
            (
                "DECLARATIONS",
                "attribute highp vec4 a_position;\nattribute highp vec4 a_coords;\nvarying mediump vec4 v_color;"
                    .to_string(),
            ),
            ("COORDS", "a_coords".to_string()),
            ("DST", "v_color".to_string()),
            ("ASSIGN_POS", "gl_Position = a_position;".to_string()),
        ]
    } else {
        vec![
            ("DECLARATIONS", "varying mediump vec4 v_coords;".to_string()),
            ("COORDS", "v_coords".to_string()),
            ("DST", "gl_FragColor".to_string()),
            ("ASSIGN_POS", String::new()),
        ]
    };
    sp_params.extend(additional_params.iter().map(|&(key, value)| (key, value.to_string())));

    let specialized = StringTemplate::new(line_stream(shader_src))
        .specialize(&sp_params)
        .expect("every placeholder has a value");

    let (vert_src, frag_src) = if is_vertex_case {
        (specialized, DEFAULT_FRAG_SRC.to_string())
    } else {
        (DEFAULT_VERT_SRC.to_string(), specialized)
    };

    Box::new(ShaderRenderCase::new(ShaderStructCaseSpec {
        name: name.to_string(),
        vert_src,
        frag_src,
        is_vertex_case,
        eval_func,
        setup_uniforms,
        brick: uses_texture.then(BrickGlTexture::new),
    }))
}

// The evaluators. Upstream writes each one inline in its `EVAL_FUNC_BODY`; most are the
// same handful of swizzles, so they are named after what they compute.

fn write_xyz(c: &mut ShaderEvalContext, v: Vec3) {
    c.color.m_data[..3].copy_from_slice(&v.m_data);
}

fn eval_coords_012(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([0, 1, 2]));
}
fn eval_coords_321(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([3, 2, 1]));
}
fn eval_coords_120(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([1, 2, 0]));
}
fn eval_coords_210(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([2, 1, 0]));
}
fn eval_coords_203(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([2, 0, 3]));
}
fn eval_coords_023(c: &mut ShaderEvalContext) {
    write_xyz(c, c.coords.swizzle([0, 2, 3]));
}
fn eval_coords_blend(c: &mut ShaderEvalContext) {
    write_xyz(c, (c.coords.swizzle([0, 1, 2]) + c.coords.swizzle([1, 2, 3])) * 0.5);
}
fn eval_white(c: &mut ShaderEvalContext) {
    write_xyz(c, Vec3::new(1.0, 1.0, 1.0));
}

fn eval_const_coords_012(c: &mut ShaderEvalContext) {
    write_xyz(c, c.const_coords.swizzle([0, 1, 2]));
}
fn eval_const_coords_321(c: &mut ShaderEvalContext) {
    write_xyz(c, c.const_coords.swizzle([3, 2, 1]));
}
fn eval_const_coords_120(c: &mut ShaderEvalContext) {
    write_xyz(c, c.const_coords.swizzle([1, 2, 0]));
}
fn eval_const_coords_210(c: &mut ShaderEvalContext) {
    write_xyz(c, c.const_coords.swizzle([2, 1, 0]));
}
fn eval_const_coords_203(c: &mut ShaderEvalContext) {
    write_xyz(c, c.const_coords.swizzle([2, 0, 3]));
}
fn eval_const_coords_blend(c: &mut ShaderEvalContext) {
    write_xyz(
        c,
        (c.const_coords.swizzle([0, 1, 2]) + c.const_coords.swizzle([1, 2, 3])) * 0.5,
    );
}

/// `basic_equal` and `nested_equal` - only the two members the shader perturbs by 0.5 can
/// still compare equal, and only where the floor of the coordinate does not move.
fn eval_struct_equal(c: &mut ShaderEvalContext) {
    if c.coords[0].floor() == (c.coords[0] + 0.5).floor() {
        c.color[0] = 1.0;
    }
    if c.coords[1].floor() == (c.coords[1] + 0.5).floor() {
        c.color[1] = 1.0;
    }
}

/// `basic_not_equal` and `nested_not_equal` - the mirror, plus the member that always differs.
fn eval_struct_not_equal(c: &mut ShaderEvalContext) {
    if c.coords[0].floor() != (c.coords[0] + 0.5).floor() {
        c.color[0] = 1.0;
    }
    if c.coords[1].floor() != (c.coords[1] + 0.5).floor() {
        c.color[1] = 1.0;
    }
    c.color[2] = 1.0;
}

/// `equal` of the uniform group
fn eval_uniform_equal(c: &mut ShaderEvalContext) {
    c.color[0] = 1.0;
    c.color[1] = 0.0;
    if (c.coords[1] + 1.0).floor() == 1.1f32.floor() {
        c.color[2] = 1.0;
    }
}

/// `not_equal` of the uniform group
fn eval_uniform_not_equal(c: &mut ShaderEvalContext) {
    c.color[0] = 0.0;
    c.color[1] = 1.0;
    if (c.coords[1] + 1.0).floor() != 1.1f32.floor() {
        c.color[2] = 1.0;
    }
}

// `setUniform` - upstream's overload set, one function per uniform type.

fn uniform_location(context: &Context, program: GLuint, name: &str) -> GLint {
    let cname = std::ffi::CString::new(name).expect("no interior NUL");
    // SAFETY: a NUL-terminated name and a program this case built.
    unsafe { context.gl().get_uniform_location(program, cname.as_ptr()) }
}

fn set_uniform_float(context: &Context, program: GLuint, name: &str, value: f32) {
    let loc = uniform_location(context, program, name);
    // SAFETY: a location this program reported, and the matching setter for its type.
    unsafe { context.gl().uniform_1f(loc, value) };
}

fn set_uniform_int(context: &Context, program: GLuint, name: &str, value: i32) {
    let loc = uniform_location(context, program, name);
    // SAFETY: as above.
    unsafe { context.gl().uniform_1i(loc, value) };
}

fn set_uniform_vec2(context: &Context, program: GLuint, name: &str, value: Vec2) {
    let loc = uniform_location(context, program, name);
    // SAFETY: the pointer covers the two floats the setter reads.
    unsafe { context.gl().uniform_2fv(loc, 1, value.m_data.as_ptr()) };
}

fn set_uniform_vec3(context: &Context, program: GLuint, name: &str, value: Vec3) {
    let loc = uniform_location(context, program, name);
    // SAFETY: the pointer covers the three floats the setter reads.
    unsafe { context.gl().uniform_3fv(loc, 1, value.m_data.as_ptr()) };
}

fn set_uniform_float_array(context: &Context, program: GLuint, name: &str, values: &[GLfloat]) {
    let loc = uniform_location(context, program, name);
    // SAFETY: the count matches the slice the pointer comes from.
    unsafe { context.gl().uniform_1fv(loc, values.len() as i32, values.as_ptr()) };
}

fn set_uniform_vec2_array(context: &Context, program: GLuint, name: &str, values: &[Vec2]) {
    let flat: Vec<GLfloat> = values.iter().flat_map(|v| v.m_data).collect();
    let loc = uniform_location(context, program, name);
    // SAFETY: the count matches the flattened slice the pointer comes from.
    unsafe { context.gl().uniform_2fv(loc, values.len() as i32, flat.as_ptr()) };
}

/// `basic`
const LOCAL_BASIC: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, vec3(0.0), ui_one);",
    "    s.b = ${COORDS}.yzw;",
    "    ${DST} = vec4(s.a, s.b.x, s.b.y, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested`
const LOCAL_NESTED: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, T(0, vec2(0.0)), ui_one);",
    "    s.b = T(ui_zero, ${COORDS}.yz);",
    "    ${DST} = vec4(s.a, s.b.b, s.b.a + s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `array_member`
const LOCAL_ARRAY_MEMBER: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump float    b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s;",
    "    s.a = ${COORDS}.w;",
    "    s.c = ui_one;",
    "    s.b[0] = ${COORDS}.z;",
    "    s.b[1] = ${COORDS}.y;",
    "    s.b[2] = ${COORDS}.x;",
    "    ${DST} = vec4(s.a, s.b[0], s.b[1], s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `array_member_dynamic_index`
const LOCAL_ARRAY_MEMBER_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump float    b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s;",
    "    s.a = ${COORDS}.w;",
    "    s.c = ui_one;",
    "    s.b[0] = ${COORDS}.z;",
    "    s.b[1] = ${COORDS}.y;",
    "    s.b[2] = ${COORDS}.x;",
    "    ${DST} = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `struct_array`
const LOCAL_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[3];",
    "    s[0] = S(${COORDS}.x, ui_zero);",
    "    s[1].a = ${COORDS}.y;",
    "    s[1].b = ui_one;",
    "    s[2] = S(${COORDS}.z, ui_two);",
    "    ${DST} = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `struct_array_dynamic_index`
const LOCAL_STRUCT_ARRAY_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[3];",
    "    s[0] = S(${COORDS}.x, ui_zero);",
    "    s[1].a = ${COORDS}.y;",
    "    s[1].b = ui_one;",
    "    s[2] = S(${COORDS}.z, ui_two);",
    "    ${DST} = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_struct_array`
const LOCAL_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[2];",
    "",
    "    // S[0]",
    "    s[0].a         = ${COORDS}.x;",
    "    s[0].b[0].a    = uf_half;",
    "    s[0].b[0].b[0] = ${COORDS}.xy;",
    "    s[0].b[0].b[1] = ${COORDS}.zw;",
    "    s[0].b[1].a    = uf_third;",
    "    s[0].b[1].b[0] = ${COORDS}.zw;",
    "    s[0].b[1].b[1] = ${COORDS}.xy;",
    "    s[0].b[2].a    = uf_fourth;",
    "    s[0].b[2].b[0] = ${COORDS}.xz;",
    "    s[0].b[2].b[1] = ${COORDS}.yw;",
    "    s[0].c         = ui_zero;",
    "",
    "    // S[1]",
    "    s[1].a         = ${COORDS}.w;",
    "    s[1].b[0].a    = uf_two;",
    "    s[1].b[0].b[0] = ${COORDS}.xx;",
    "    s[1].b[0].b[1] = ${COORDS}.yy;",
    "    s[1].b[1].a    = uf_three;",
    "    s[1].b[1].b[0] = ${COORDS}.zz;",
    "    s[1].b[1].b[1] = ${COORDS}.ww;",
    "    s[1].b[2].a    = uf_four;",
    "    s[1].b[2].b[0] = ${COORDS}.yx;",
    "    s[1].b[2].b[1] = ${COORDS}.wz;",
    "    s[1].c         = ui_one;",
    "",
    "    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5",
    "    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4",
    "    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333",
    "    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0",
    "    ${DST} = vec4(r, g, b, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_struct_array_dynamic_index`
const LOCAL_NESTED_STRUCT_ARRAY_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[2];",
    "",
    "    // S[0]",
    "    s[0].a         = ${COORDS}.x;",
    "    s[0].b[0].a    = uf_half;",
    "    s[0].b[0].b[0] = ${COORDS}.xy;",
    "    s[0].b[0].b[1] = ${COORDS}.zw;",
    "    s[0].b[1].a    = uf_third;",
    "    s[0].b[1].b[0] = ${COORDS}.zw;",
    "    s[0].b[1].b[1] = ${COORDS}.xy;",
    "    s[0].b[2].a    = uf_fourth;",
    "    s[0].b[2].b[0] = ${COORDS}.xz;",
    "    s[0].b[2].b[1] = ${COORDS}.yw;",
    "    s[0].c         = ui_zero;",
    "",
    "    // S[1]",
    "    s[1].a         = ${COORDS}.w;",
    "    s[1].b[0].a    = uf_two;",
    "    s[1].b[0].b[0] = ${COORDS}.xx;",
    "    s[1].b[0].b[1] = ${COORDS}.yy;",
    "    s[1].b[1].a    = uf_three;",
    "    s[1].b[1].b[0] = ${COORDS}.zz;",
    "    s[1].b[1].b[1] = ${COORDS}.ww;",
    "    s[1].b[2].a    = uf_four;",
    "    s[1].b[2].b[0] = ${COORDS}.yx;",
    "    s[1].b[2].b[1] = ${COORDS}.wz;",
    "    s[1].c         = ui_one;",
    "",
    "    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5",
    "    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4",
    "    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333",
    "    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0",
    "    ${DST} = vec4(r, g, b, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `parameter`
const LOCAL_PARAMETER: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "mediump vec4 myFunc (S s)",
    "{",
    "    return vec4(s.a, s.b.x, s.b.y, s.c);",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, vec3(0.0), ui_one);",
    "    s.b = ${COORDS}.yzw;",
    "    ${DST} = myFunc(s);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `parameter_nested`
const LOCAL_PARAMETER_NESTED: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "mediump vec4 myFunc (S s)",
    "{",
    "    return vec4(s.a, s.b.b, s.b.a + s.c);",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, T(0, vec2(0.0)), ui_one);",
    "    s.b = T(ui_zero, ${COORDS}.yz);",
    "    ${DST} = myFunc(s);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `return`
const LOCAL_RETURN: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "S myFunc (void)",
    "{",
    "    S s = S(${COORDS}.x, vec3(0.0), ui_one);",
    "    s.b = ${COORDS}.yzw;",
    "    return s;",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s = myFunc();",
    "    ${DST} = vec4(s.a, s.b.x, s.b.y, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `return_nested`
const LOCAL_RETURN_NESTED: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "S myFunc (void)",
    "{",
    "    S s = S(${COORDS}.x, T(0, vec2(0.0)), ui_one);",
    "    s.b = T(ui_zero, ${COORDS}.yz);",
    "    return s;",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s = myFunc();",
    "    ${DST} = vec4(s.a, s.b.b, s.b.a + s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `conditional_assignment`
const LOCAL_CONDITIONAL_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform mediump float uf_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, ${COORDS}.yzw, ui_zero);",
    "    if (uf_one > 0.0)",
    "        s = S(${COORDS}.w, ${COORDS}.zyx, ui_one);",
    "    ${DST} = vec4(s.a, s.b.xy, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `loop_assignment`
const LOCAL_LOOP_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, ${COORDS}.yzw, ui_zero);",
    "    for (int i = 0; i < 3; i++)",
    "    {",
    "        if (i == 1)",
    "            s = S(${COORDS}.w, ${COORDS}.zyx, ui_one);",
    "    }",
    "    ${DST} = vec4(s.a, s.b.xy, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `dynamic_loop_assignment`
const LOCAL_DYNAMIC_LOOP_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_three;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, ${COORDS}.yzw, ui_zero);",
    "    for (int i = 0; i < ui_three; i++)",
    "    {",
    "        if (i == ui_one)",
    "            s = S(${COORDS}.w, ${COORDS}.zyx, ui_one);",
    "    }",
    "    ${DST} = vec4(s.a, s.b.xy, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_conditional_assignment`
const LOCAL_NESTED_CONDITIONAL_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform mediump float uf_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, T(ui_one, ${COORDS}.yz), ui_one);",
    "    if (uf_one > 0.0)",
    "        s.b = T(ui_zero, ${COORDS}.zw);",
    "    ${DST} = vec4(s.a, s.b.b, s.c - s.b.a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_loop_assignment`
const LOCAL_NESTED_LOOP_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform mediump float uf_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, T(ui_one, ${COORDS}.yz), ui_one);",
    "    for (int i = 0; i < 3; i++)",
    "    {",
    "        if (i == 1)",
    "            s.b = T(ui_zero, ${COORDS}.zw);",
    "    }",
    "    ${DST} = vec4(s.a, s.b.b, s.c - s.b.a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_dynamic_loop_assignment`
const LOCAL_NESTED_DYNAMIC_LOOP_ASSIGNMENT: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_three;",
    "uniform mediump float uf_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s = S(${COORDS}.x, T(ui_one, ${COORDS}.yz), ui_one);",
    "    for (int i = 0; i < ui_three; i++)",
    "    {",
    "        if (i == ui_one)",
    "            s.b = T(ui_zero, ${COORDS}.zw);",
    "    }",
    "    ${DST} = vec4(s.a, s.b.b, s.c - s.b.a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `loop_struct_array`
const LOCAL_LOOP_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[3];",
    "    s[0] = S(${COORDS}.x, ui_zero);",
    "    s[1].a = ${COORDS}.y;",
    "    s[1].b = -ui_one;",
    "    s[2] = S(${COORDS}.z, ui_two);",
    "",
    "    mediump float rgb[3];",
    "    int alpha = 0;",
    "    for (int i = 0; i < 3; i++)",
    "    {",
    "        rgb[i] = s[2-i].a;",
    "        alpha += s[i].b;",
    "    }",
    "    ${DST} = vec4(rgb[0], rgb[1], rgb[2], alpha);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `loop_nested_struct_array`
const LOCAL_LOOP_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "uniform mediump float uf_sixth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[2];",
    "",
    "    // S[0]",
    "    s[0].a         = ${COORDS}.x;",
    "    s[0].b[0].a    = uf_half;",
    "    s[0].b[0].b[0] = ${COORDS}.yx;",
    "    s[0].b[0].b[1] = ${COORDS}.zx;",
    "    s[0].b[1].a    = uf_third;",
    "    s[0].b[1].b[0] = ${COORDS}.yy;",
    "    s[0].b[1].b[1] = ${COORDS}.wy;",
    "    s[0].b[2].a    = uf_fourth;",
    "    s[0].b[2].b[0] = ${COORDS}.zx;",
    "    s[0].b[2].b[1] = ${COORDS}.zy;",
    "    s[0].c         = ui_zero;",
    "",
    "    // S[1]",
    "    s[1].a         = ${COORDS}.w;",
    "    s[1].b[0].a    = uf_two;",
    "    s[1].b[0].b[0] = ${COORDS}.zx;",
    "    s[1].b[0].b[1] = ${COORDS}.zy;",
    "    s[1].b[1].a    = uf_three;",
    "    s[1].b[1].b[0] = ${COORDS}.zz;",
    "    s[1].b[1].b[1] = ${COORDS}.ww;",
    "    s[1].b[2].a    = uf_four;",
    "    s[1].b[2].b[0] = ${COORDS}.yx;",
    "    s[1].b[2].b[1] = ${COORDS}.wz;",
    "    s[1].c         = ui_one;",
    "",
    "    mediump float r = 0.0; // (x*3 + y*3) / 6.0",
    "    mediump float g = 0.0; // (y*3 + z*3) / 6.0",
    "    mediump float b = 0.0; // (z*3 + w*3) / 6.0",
    "    mediump float a = 1.0;",
    "    for (int i = 0; i < 2; i++)",
    "    {",
    "        for (int j = 0; j < 3; j++)",
    "        {",
    "            r += s[0].b[j].b[i].y;",
    "            g += s[i].b[j].b[0].x;",
    "            b += s[i].b[j].b[1].x;",
    "            a *= s[i].b[j].a;",
    "        }",
    "    }",
    "    ${DST} = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `dynamic_loop_struct_array`
const LOCAL_DYNAMIC_LOOP_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform int ui_three;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[3];",
    "    s[0] = S(${COORDS}.x, ui_zero);",
    "    s[1].a = ${COORDS}.y;",
    "    s[1].b = -ui_one;",
    "    s[2] = S(${COORDS}.z, ui_two);",
    "",
    "    mediump float rgb[3];",
    "    int alpha = 0;",
    "    for (int i = 0; i < ui_three; i++)",
    "    {",
    "        rgb[i] = s[2-i].a;",
    "        alpha += s[i].b;",
    "    }",
    "    ${DST} = vec4(rgb[0], rgb[1], rgb[2], alpha);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `dynamic_loop_nested_struct_array`
const LOCAL_DYNAMIC_LOOP_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform int ui_three;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "uniform mediump float uf_sixth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S s[2];",
    "",
    "    // S[0]",
    "    s[0].a         = ${COORDS}.x;",
    "    s[0].b[0].a    = uf_half;",
    "    s[0].b[0].b[0] = ${COORDS}.yx;",
    "    s[0].b[0].b[1] = ${COORDS}.zx;",
    "    s[0].b[1].a    = uf_third;",
    "    s[0].b[1].b[0] = ${COORDS}.yy;",
    "    s[0].b[1].b[1] = ${COORDS}.wy;",
    "    s[0].b[2].a    = uf_fourth;",
    "    s[0].b[2].b[0] = ${COORDS}.zx;",
    "    s[0].b[2].b[1] = ${COORDS}.zy;",
    "    s[0].c         = ui_zero;",
    "",
    "    // S[1]",
    "    s[1].a         = ${COORDS}.w;",
    "    s[1].b[0].a    = uf_two;",
    "    s[1].b[0].b[0] = ${COORDS}.zx;",
    "    s[1].b[0].b[1] = ${COORDS}.zy;",
    "    s[1].b[1].a    = uf_three;",
    "    s[1].b[1].b[0] = ${COORDS}.zz;",
    "    s[1].b[1].b[1] = ${COORDS}.ww;",
    "    s[1].b[2].a    = uf_four;",
    "    s[1].b[2].b[0] = ${COORDS}.yx;",
    "    s[1].b[2].b[1] = ${COORDS}.wz;",
    "    s[1].c         = ui_one;",
    "",
    "    mediump float r = 0.0; // (x*3 + y*3) / 6.0",
    "    mediump float g = 0.0; // (y*3 + z*3) / 6.0",
    "    mediump float b = 0.0; // (z*3 + w*3) / 6.0",
    "    mediump float a = 1.0;",
    "    for (int i = 0; i < ui_two; i++)",
    "    {",
    "        for (int j = 0; j < ui_three; j++)",
    "        {",
    "            r += s[0].b[j].b[i].y;",
    "            g += s[i].b[j].b[0].x;",
    "            b += s[i].b[j].b[1].x;",
    "            a *= s[i].b[j].a;",
    "        }",
    "    }",
    "    ${DST} = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `basic_equal`
const LOCAL_BASIC_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S a = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y), 2.3), ui_one);",
    "    S b = S(floor(${COORDS}.x+0.5), vec3(0.0, floor(${COORDS}.y), 2.3), ui_one);",
    "    S c = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y+0.5), 2.3), ui_one);",
    "    S d = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y), 2.3), ui_two);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a == b) ${DST}.x = 1.0;",
    "    if (a == c) ${DST}.y = 1.0;",
    "    if (a == d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

/// `basic_not_equal`
const LOCAL_BASIC_NOT_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S a = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y), 2.3), ui_one);",
    "    S b = S(floor(${COORDS}.x+0.5), vec3(0.0, floor(${COORDS}.y), 2.3), ui_one);",
    "    S c = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y+0.5), 2.3), ui_one);",
    "    S d = S(floor(${COORDS}.x), vec3(0.0, floor(${COORDS}.y), 2.3), ui_two);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a != b) ${DST}.x = 1.0;",
    "    if (a != c) ${DST}.y = 1.0;",
    "    if (a != d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_equal`
const LOCAL_NESTED_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct T {",
    "    mediump vec3    a;",
    "    int                b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S a = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_one), 1);",
    "    S b = S(floor(${COORDS}.x+0.5), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_one), 1);",
    "    S c = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y+0.5), 2.3), ui_one), 1);",
    "    S d = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_two), 1);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a == b) ${DST}.x = 1.0;",
    "    if (a == c) ${DST}.y = 1.0;",
    "    if (a == d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_not_equal`
const LOCAL_NESTED_NOT_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct T {",
    "    mediump vec3    a;",
    "    int                b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "",
    "void main (void)",
    "{",
    "    S a = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_one), 1);",
    "    S b = S(floor(${COORDS}.x+0.5), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_one), 1);",
    "    S c = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y+0.5), 2.3), ui_one), 1);",
    "    S d = S(floor(${COORDS}.x), T(vec3(0.0, floor(${COORDS}.y), 2.3), ui_two), 1);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a != b) ${DST}.x = 1.0;",
    "    if (a != c) ${DST}.y = 1.0;",
    "    if (a != d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

/// `inoutSrc`
const SHARED_INOUTSRC: &[&str] = &[
    "${DECLARATIONS}",
    "",
    "struct S {",
    "    ${PRECISION} vec3 red;",
    "    ${PRECISION} vec3 blue;",
    "};",
    "",
    "void modify (inout S s)",
    "{",
    "    s.red += vec3(0.5, 0.0, 0.0);",
    "    s.blue += vec3(0.0, 0.0, 0.5);",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s;",
    "    s.red = vec3(0.5, 0.0, 0.0);",
    "    s.blue = vec3(0.0, 0.0, 0.5);",
    "    modify(s);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (s.red == vec3(1.0, 0.0, 0.0) && s.blue == vec3(0.0, 0.0, 1.0))",
    "        ${DST} = vec4(1.0, 1.0, 1.0, 1.0);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `outSrc`
const SHARED_OUTSRC: &[&str] = &[
    "${DECLARATIONS}",
    "",
    "struct S {",
    "    ${PRECISION} vec3 red;",
    "    ${PRECISION} vec3 blue;",
    "};",
    "",
    "void modify (out S s)",
    "{",
    "    s.red = vec3(1.0, 0.0, 0.0);",
    "    s.blue = vec3(0.0, 0.0, 1.0);",
    "}",
    "",
    "void main (void)",
    "{",
    "    S s;",
    "    modify(s);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (s.red == vec3(1.0, 0.0, 0.0) && s.blue == vec3(0.0, 0.0, 1.0))",
    "        ${DST} = vec4(1.0, 1.0, 1.0, 1.0);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `basic`
const UNIFORM_BASIC: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s.a, s.b.x, s.b.y, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested`
const UNIFORM_NESTED: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct T {",
    "    int                a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s.a, s.b.b, s.b.a + s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `array_member`
const UNIFORM_ARRAY_MEMBER: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump float    b[3];",
    "    int                c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s.a, s.b[0], s.b[1], s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `array_member_dynamic_index`
const UNIFORM_ARRAY_MEMBER_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump float    b[3];",
    "    int                c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `struct_array`
const UNIFORM_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "uniform S s[3];",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `struct_array_dynamic_index`
const UNIFORM_STRUCT_ARRAY_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "uniform S s[3];",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_struct_array`
const UNIFORM_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "uniform S s[2];",
    "",
    "void main (void)",
    "{",
    "    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5",
    "    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4",
    "    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333",
    "    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0",
    "    ${DST} = vec4(r, g, b, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `nested_struct_array_dynamic_index`
const UNIFORM_NESTED_STRUCT_ARRAY_DYNAMIC_INDEX: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "uniform S s[2];",
    "",
    "void main (void)",
    "{",
    "    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5",
    "    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4",
    "    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333",
    "    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0",
    "    ${DST} = vec4(r, g, b, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `loop_struct_array`
const UNIFORM_LOOP_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "uniform S s[3];",
    "",
    "void main (void)",
    "{",
    "    mediump float rgb[3];",
    "    int alpha = 0;",
    "    for (int i = 0; i < 3; i++)",
    "    {",
    "        rgb[i] = s[2-i].a;",
    "        alpha += s[i].b;",
    "    }",
    "    ${DST} = vec4(rgb[0], rgb[1], rgb[2], alpha);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `loop_nested_struct_array`
const UNIFORM_LOOP_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "uniform mediump float uf_sixth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "uniform S s[2];",
    "",
    "void main (void)",
    "{",
    "    mediump float r = 0.0; // (x*3 + y*3) / 6.0",
    "    mediump float g = 0.0; // (y*3 + z*3) / 6.0",
    "    mediump float b = 0.0; // (z*3 + w*3) / 6.0",
    "    mediump float a = 1.0;",
    "    for (int i = 0; i < 2; i++)",
    "    {",
    "        for (int j = 0; j < 3; j++)",
    "        {",
    "            r += s[0].b[j].b[i].y;",
    "            g += s[i].b[j].b[0].x;",
    "            b += s[i].b[j].b[1].x;",
    "            a *= s[i].b[j].a;",
    "        }",
    "    }",
    "    ${DST} = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `dynamic_loop_struct_array`
const UNIFORM_DYNAMIC_LOOP_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform int ui_three;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump int        b;",
    "};",
    "uniform S s[3];",
    "",
    "void main (void)",
    "{",
    "    mediump float rgb[3];",
    "    int alpha = 0;",
    "    for (int i = 0; i < ui_three; i++)",
    "    {",
    "        rgb[i] = s[2-i].a;",
    "        alpha += s[i].b;",
    "    }",
    "    ${DST} = vec4(rgb[0], rgb[1], rgb[2], alpha);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `dynamic_loop_nested_struct_array`
const UNIFORM_DYNAMIC_LOOP_NESTED_STRUCT_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "uniform int ui_two;",
    "uniform int ui_three;",
    "uniform mediump float uf_two;",
    "uniform mediump float uf_three;",
    "uniform mediump float uf_four;",
    "uniform mediump float uf_half;",
    "uniform mediump float uf_third;",
    "uniform mediump float uf_fourth;",
    "uniform mediump float uf_sixth;",
    "",
    "struct T {",
    "    mediump float    a;",
    "    mediump vec2    b[2];",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b[3];",
    "    int                c;",
    "};",
    "uniform S s[2];",
    "",
    "void main (void)",
    "{",
    "    mediump float r = 0.0; // (x*3 + y*3) / 6.0",
    "    mediump float g = 0.0; // (y*3 + z*3) / 6.0",
    "    mediump float b = 0.0; // (z*3 + w*3) / 6.0",
    "    mediump float a = 1.0;",
    "    for (int i = 0; i < ui_two; i++)",
    "    {",
    "        for (int j = 0; j < ui_three; j++)",
    "        {",
    "            r += s[0].b[j].b[i].y;",
    "            g += s[i].b[j].b[0].x;",
    "            b += s[i].b[j].b[1].x;",
    "            a *= s[i].b[j].a;",
    "        }",
    "    }",
    "    ${DST} = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);",
    "    ${ASSIGN_POS}",
    "}",
];

/// `equal`
const UNIFORM_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform mediump float uf_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "uniform S a;",
    "uniform S b;",
    "uniform S c;",
    "",
    "void main (void)",
    "{",
    "    S d = S(uf_one, vec3(0.0, floor(${COORDS}.y+1.0), 2.0), ui_two);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a == b) ${DST}.x = 1.0;",
    "    if (a == c) ${DST}.y = 1.0;",
    "    if (a == d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

/// `not_equal`
const UNIFORM_NOT_EQUAL: &[&str] = &[
    "${DECLARATIONS}",
    "uniform mediump float uf_one;",
    "uniform int ui_two;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    int                c;",
    "};",
    "uniform S a;",
    "uniform S b;",
    "uniform S c;",
    "",
    "void main (void)",
    "{",
    "    S d = S(uf_one, vec3(0.0, floor(${COORDS}.y+1.0), 2.0), ui_two);",
    "    ${DST} = vec4(0.0, 0.0, 0.0, 1.0);",
    "    if (a != b) ${DST}.x = 1.0;",
    "    if (a != c) ${DST}.y = 1.0;",
    "    if (a != d) ${DST}.z = 1.0;",
    "    ${ASSIGN_POS}",
    "}",
];

// The uniform-group `SET_UNIFORMS_BODY` blocks.

fn setup_basic(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s.a", const_coords.x());
    set_uniform_vec3(context, program, "s.b", const_coords.swizzle([1, 2, 3]));
    set_uniform_int(context, program, "s.c", 1);
    Ok(())
}

fn setup_nested(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s.a", const_coords.x());
    set_uniform_int(context, program, "s.b.a", 0);
    set_uniform_vec2(context, program, "s.b.b", const_coords.swizzle([1, 2]));
    set_uniform_int(context, program, "s.c", 1);
    Ok(())
}

fn setup_array_member(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s.a", const_coords.w());
    set_uniform_int(context, program, "s.c", 1);

    let b = [const_coords.z(), const_coords.y(), const_coords.x()];
    set_uniform_float_array(context, program, "s.b", &b);
    Ok(())
}

fn setup_struct_array(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s[0].a", const_coords.x());
    set_uniform_int(context, program, "s[0].b", 0);
    set_uniform_float(context, program, "s[1].a", const_coords.y());
    set_uniform_int(context, program, "s[1].b", 1);
    set_uniform_float(context, program, "s[2].a", const_coords.z());
    set_uniform_int(context, program, "s[2].b", 2);
    Ok(())
}

/// The same array with `s[1].b` negative, which is what makes the loop cases skip an entry.
fn setup_loop_struct_array(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s[0].a", const_coords.x());
    set_uniform_int(context, program, "s[0].b", 0);
    set_uniform_float(context, program, "s[1].a", const_coords.y());
    set_uniform_int(context, program, "s[1].b", -1);
    set_uniform_float(context, program, "s[2].a", const_coords.z());
    set_uniform_int(context, program, "s[2].b", 2);
    Ok(())
}

fn setup_nested_struct_array(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s[0].a", const_coords.x());
    set_uniform_float(context, program, "s[0].b[0].a", 0.5);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[0].b",
        &[const_coords.swizzle([0, 1]), const_coords.swizzle([2, 3])],
    );
    set_uniform_float(context, program, "s[0].b[1].a", 1.0 / 3.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[1].b",
        &[const_coords.swizzle([2, 3]), const_coords.swizzle([0, 1])],
    );
    set_uniform_float(context, program, "s[0].b[2].a", 1.0 / 4.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[2].b",
        &[const_coords.swizzle([0, 2]), const_coords.swizzle([1, 3])],
    );
    set_uniform_int(context, program, "s[0].c", 0);

    set_uniform_float(context, program, "s[1].a", const_coords.w());
    set_uniform_float(context, program, "s[1].b[0].a", 2.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[0].b",
        &[const_coords.swizzle([0, 0]), const_coords.swizzle([1, 1])],
    );
    set_uniform_float(context, program, "s[1].b[1].a", 3.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[1].b",
        &[const_coords.swizzle([2, 2]), const_coords.swizzle([3, 3])],
    );
    set_uniform_float(context, program, "s[1].b[2].a", 4.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[2].b",
        &[const_coords.swizzle([1, 0]), const_coords.swizzle([3, 2])],
    );
    set_uniform_int(context, program, "s[1].c", 1);
    Ok(())
}

fn setup_loop_nested_struct_array(context: &Context, program: GLuint, const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s[0].a", const_coords.x());
    set_uniform_float(context, program, "s[0].b[0].a", 0.5);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[0].b",
        &[const_coords.swizzle([1, 0]), const_coords.swizzle([2, 0])],
    );
    set_uniform_float(context, program, "s[0].b[1].a", 1.0 / 3.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[1].b",
        &[const_coords.swizzle([1, 1]), const_coords.swizzle([3, 1])],
    );
    set_uniform_float(context, program, "s[0].b[2].a", 1.0 / 4.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[0].b[2].b",
        &[const_coords.swizzle([2, 1]), const_coords.swizzle([2, 1])],
    );
    set_uniform_int(context, program, "s[0].c", 0);

    set_uniform_float(context, program, "s[1].a", const_coords.w());
    set_uniform_float(context, program, "s[1].b[0].a", 2.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[0].b",
        &[const_coords.swizzle([2, 0]), const_coords.swizzle([2, 1])],
    );
    set_uniform_float(context, program, "s[1].b[1].a", 3.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[1].b",
        &[const_coords.swizzle([2, 2]), const_coords.swizzle([3, 3])],
    );
    set_uniform_float(context, program, "s[1].b[2].a", 4.0);
    set_uniform_vec2_array(
        context,
        program,
        "s[1].b[2].b",
        &[const_coords.swizzle([1, 0]), const_coords.swizzle([3, 2])],
    );
    set_uniform_int(context, program, "s[1].c", 1);
    Ok(())
}

/// `equal` and `not_equal` - `c` differs from `a` and `b` in one component only.
fn setup_equality(context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
    for name in ["a", "b", "c"] {
        set_uniform_float(context, program, &format!("{name}.a"), 1.0);
        let b = if name == "c" {
            Vec3::new(0.0, 1.1, 2.0)
        } else {
            Vec3::new(0.0, 1.0, 2.0)
        };
        set_uniform_vec3(context, program, &format!("{name}.b"), b);
        set_uniform_int(context, program, &format!("{name}.c"), 2);
    }
    Ok(())
}

/// `sampler`
const UNIFORM_SAMPLER: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    sampler2D        c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(texture2D(s.c, ${COORDS}.xy * s.b.xy + s.b.z).rgb, s.a);",
    "    ${ASSIGN_POS}",
    "}",
];

fn setup_sampler(context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s.a", 1.0);
    set_uniform_vec3(context, program, "s.b", Vec3::new(0.25, 0.25, 0.5));
    set_uniform_int(context, program, "s.c", 0);
    Ok(())
}

/// `sampler_nested`
const UNIFORM_SAMPLER_NESTED: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_zero;",
    "uniform int ui_one;",
    "",
    "struct T {",
    "    sampler2D        a;",
    "    mediump vec2    b;",
    "};",
    "struct S {",
    "    mediump float    a;",
    "    T                b;",
    "    int                c;",
    "};",
    "uniform S s;",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(texture2D(s.b.a, ${COORDS}.xy * s.b.b + s.a).rgb, s.c);",
    "    ${ASSIGN_POS}",
    "}",
];

fn setup_sampler_nested(context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s.a", 0.5);
    set_uniform_int(context, program, "s.b.a", 0);
    set_uniform_vec2(context, program, "s.b.b", Vec2::new(0.25, 0.25));
    set_uniform_int(context, program, "s.c", 1);
    Ok(())
}

/// `sampler_array`
const UNIFORM_SAMPLER_ARRAY: &[&str] = &[
    "${DECLARATIONS}",
    "uniform int ui_one;",
    "",
    "struct S {",
    "    mediump float    a;",
    "    mediump vec3    b;",
    "    sampler2D        c;",
    "};",
    "uniform S s[2];",
    "",
    "void main (void)",
    "{",
    "    ${DST} = vec4(texture2D(s[1].c, ${COORDS}.xy * s[0].b.xy + s[1].b.z).rgb, s[0].a);",
    "    ${ASSIGN_POS}",
    "}",
];

fn setup_sampler_array(context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_float(context, program, "s[0].a", 1.0);
    set_uniform_vec3(context, program, "s[0].b", Vec3::new(0.25, 0.25, 0.25));
    set_uniform_int(context, program, "s[0].c", 1);
    set_uniform_float(context, program, "s[1].a", 0.0);
    set_uniform_vec3(context, program, "s[1].b", Vec3::new(0.5, 0.5, 0.5));
    set_uniform_int(context, program, "s[1].c", 0);
    Ok(())
}

/// `sampler_in_function_arg`
const UNIFORM_SAMPLER_IN_FUNCTION_ARG: &[&str] = &[
    "${DECLARATIONS}",
    "",
    "struct S {",
    "    sampler2D        source;",
    "};",
    "",
    "mediump vec4 fun(S s) {",
    "    return texture2D(s.source, vec2(0.5));",
    "}",
    "",
    "uniform S s;",
    "void main (void)",
    "{",
    "    ${DST} = fun(s);",
    "    ${ASSIGN_POS}",
    "}",
];

fn setup_sampler_in_function_arg(context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
    set_uniform_int(context, program, "s.source", 0);
    Ok(())
}

/// `sampler_in_array_function_arg`
const UNIFORM_SAMPLER_IN_ARRAY_FUNCTION_ARG: &[&str] = &[
    "${DECLARATIONS}",
    "",
    "struct S {",
    "    sampler2D        source;",
    "};",
    "",
    "mediump vec4 fun(S s[2]) {",
    "    return texture2D(s[0].source, vec2(0.5));",
    "}",
    "",
    "uniform S s[2];",
    "void main (void)",
    "{",
    "    ${DST} = fun(s);",
    "    ${ASSIGN_POS}",
    "}",
];

fn setup_sampler_in_array_function_arg(
    context: &Context,
    program: GLuint,
    _const_coords: Vec4,
) -> Result<(), TestError> {
    set_uniform_int(context, program, "s[0].source", 0);
    Ok(())
}

/// `c.color.xyz() = c.texture2D(TEXTURE_BRICK, c.coords.swizzle(0, 1) * 0.25f + 0.5f).swizzle(0, 1, 2)`
fn eval_brick_coords(c: &mut ShaderEvalContext) {
    let t = sample_brick(c.coords[0] * 0.25 + 0.5, c.coords[1] * 0.25 + 0.5);
    write_xyz(c, t.swizzle([0, 1, 2]));
}

/// `c.color.xyz() = c.texture2D(TEXTURE_BRICK, tcu::Vec2(0.5f, 0.5f)).swizzle(0, 1, 2)`
fn eval_brick_center(c: &mut ShaderEvalContext) {
    let t = sample_brick(0.5, 0.5);
    write_xyz(c, t.swizzle([0, 1, 2]));
}

/// One `LOCAL_STRUCT_CASE` / `UNIFORM_STRUCT_CASE` row: both the vertex and the fragment
/// case come from it.
struct StructCase {
    name: &'static str,
    shader_src: &'static [&'static str],
    eval_func: ShaderEvalFunc,
    setup_uniforms: Option<SetupUniformsFn>,
    additional_params: &'static [(&'static str, &'static str)],
    uses_texture: bool,
}

const fn local(name: &'static str, shader_src: &'static [&'static str], eval_func: ShaderEvalFunc) -> StructCase {
    StructCase {
        name,
        shader_src,
        eval_func,
        setup_uniforms: None,
        additional_params: &[],
        uses_texture: false,
    }
}

const fn local_parameterized(
    name: &'static str,
    shader_src: &'static [&'static str],
    eval_func: ShaderEvalFunc,
    additional_params: &'static [(&'static str, &'static str)],
) -> StructCase {
    StructCase {
        name,
        shader_src,
        eval_func,
        setup_uniforms: None,
        additional_params,
        uses_texture: false,
    }
}

const fn uniform(
    name: &'static str,
    shader_src: &'static [&'static str],
    eval_func: ShaderEvalFunc,
    setup_uniforms: SetupUniformsFn,
) -> StructCase {
    StructCase {
        name,
        shader_src,
        eval_func,
        setup_uniforms: Some(setup_uniforms),
        additional_params: &[],
        uses_texture: false,
    }
}

const fn uniform_tex(
    name: &'static str,
    shader_src: &'static [&'static str],
    eval_func: ShaderEvalFunc,
    setup_uniforms: SetupUniformsFn,
) -> StructCase {
    StructCase {
        name,
        shader_src,
        eval_func,
        setup_uniforms: Some(setup_uniforms),
        additional_params: &[],
        uses_texture: true,
    }
}

const LOWP: &[(&str, &str)] = &[("PRECISION", "lowp")];
const MEDIUMP: &[(&str, &str)] = &[("PRECISION", "mediump")];
const HIGHP: &[(&str, &str)] = &[("PRECISION", "highp")];

/// `LocalStructTests::init`
const LOCAL_CASES: &[StructCase] = &[
    local("basic", LOCAL_BASIC, eval_coords_012),
    local("nested", LOCAL_NESTED, eval_coords_012),
    local("array_member", LOCAL_ARRAY_MEMBER, eval_coords_321),
    local(
        "array_member_dynamic_index",
        LOCAL_ARRAY_MEMBER_DYNAMIC_INDEX,
        eval_coords_120,
    ),
    local("struct_array", LOCAL_STRUCT_ARRAY, eval_coords_210),
    local(
        "struct_array_dynamic_index",
        LOCAL_STRUCT_ARRAY_DYNAMIC_INDEX,
        eval_coords_210,
    ),
    local("nested_struct_array", LOCAL_NESTED_STRUCT_ARRAY, eval_coords_203),
    local(
        "nested_struct_array_dynamic_index",
        LOCAL_NESTED_STRUCT_ARRAY_DYNAMIC_INDEX,
        eval_coords_203,
    ),
    local("parameter", LOCAL_PARAMETER, eval_coords_012),
    local_parameterized("parameter_inout_lowp", SHARED_INOUTSRC, eval_white, LOWP),
    local_parameterized("parameter_inout_mediump", SHARED_INOUTSRC, eval_white, MEDIUMP),
    local_parameterized("parameter_inout_highp", SHARED_INOUTSRC, eval_white, HIGHP),
    local("parameter_nested", LOCAL_PARAMETER_NESTED, eval_coords_012),
    local_parameterized("parameter_out_lowp", SHARED_OUTSRC, eval_white, LOWP),
    local_parameterized("parameter_out_mediump", SHARED_OUTSRC, eval_white, MEDIUMP),
    local_parameterized("parameter_out_highp", SHARED_OUTSRC, eval_white, HIGHP),
    local("return", LOCAL_RETURN, eval_coords_012),
    local("return_nested", LOCAL_RETURN_NESTED, eval_coords_012),
    local("conditional_assignment", LOCAL_CONDITIONAL_ASSIGNMENT, eval_coords_321),
    local("loop_assignment", LOCAL_LOOP_ASSIGNMENT, eval_coords_321),
    local(
        "dynamic_loop_assignment",
        LOCAL_DYNAMIC_LOOP_ASSIGNMENT,
        eval_coords_321,
    ),
    local(
        "nested_conditional_assignment",
        LOCAL_NESTED_CONDITIONAL_ASSIGNMENT,
        eval_coords_023,
    ),
    local("nested_loop_assignment", LOCAL_NESTED_LOOP_ASSIGNMENT, eval_coords_023),
    local(
        "nested_dynamic_loop_assignment",
        LOCAL_NESTED_DYNAMIC_LOOP_ASSIGNMENT,
        eval_coords_023,
    ),
    local("loop_struct_array", LOCAL_LOOP_STRUCT_ARRAY, eval_coords_210),
    local(
        "loop_nested_struct_array",
        LOCAL_LOOP_NESTED_STRUCT_ARRAY,
        eval_coords_blend,
    ),
    local(
        "dynamic_loop_struct_array",
        LOCAL_DYNAMIC_LOOP_STRUCT_ARRAY,
        eval_coords_210,
    ),
    local(
        "dynamic_loop_nested_struct_array",
        LOCAL_DYNAMIC_LOOP_NESTED_STRUCT_ARRAY,
        eval_coords_blend,
    ),
    local("basic_equal", LOCAL_BASIC_EQUAL, eval_struct_equal),
    local("basic_not_equal", LOCAL_BASIC_NOT_EQUAL, eval_struct_not_equal),
    local("nested_equal", LOCAL_NESTED_EQUAL, eval_struct_equal),
    local("nested_not_equal", LOCAL_NESTED_NOT_EQUAL, eval_struct_not_equal),
];

/// `UniformStructTests::init`.
const UNIFORM_CASES: &[StructCase] = &[
    uniform("basic", UNIFORM_BASIC, eval_const_coords_012, setup_basic),
    uniform("nested", UNIFORM_NESTED, eval_const_coords_012, setup_nested),
    uniform(
        "array_member",
        UNIFORM_ARRAY_MEMBER,
        eval_const_coords_321,
        setup_array_member,
    ),
    uniform(
        "array_member_dynamic_index",
        UNIFORM_ARRAY_MEMBER_DYNAMIC_INDEX,
        eval_const_coords_120,
        setup_array_member,
    ),
    uniform(
        "struct_array",
        UNIFORM_STRUCT_ARRAY,
        eval_const_coords_210,
        setup_struct_array,
    ),
    uniform(
        "struct_array_dynamic_index",
        UNIFORM_STRUCT_ARRAY_DYNAMIC_INDEX,
        eval_const_coords_210,
        setup_struct_array,
    ),
    uniform(
        "nested_struct_array",
        UNIFORM_NESTED_STRUCT_ARRAY,
        eval_const_coords_203,
        setup_nested_struct_array,
    ),
    uniform(
        "nested_struct_array_dynamic_index",
        UNIFORM_NESTED_STRUCT_ARRAY_DYNAMIC_INDEX,
        eval_const_coords_203,
        setup_nested_struct_array,
    ),
    uniform(
        "loop_struct_array",
        UNIFORM_LOOP_STRUCT_ARRAY,
        eval_const_coords_210,
        setup_loop_struct_array,
    ),
    uniform(
        "loop_nested_struct_array",
        UNIFORM_LOOP_NESTED_STRUCT_ARRAY,
        eval_const_coords_blend,
        setup_loop_nested_struct_array,
    ),
    uniform(
        "dynamic_loop_struct_array",
        UNIFORM_DYNAMIC_LOOP_STRUCT_ARRAY,
        eval_const_coords_210,
        setup_loop_struct_array,
    ),
    uniform(
        "dynamic_loop_nested_struct_array",
        UNIFORM_DYNAMIC_LOOP_NESTED_STRUCT_ARRAY,
        eval_const_coords_blend,
        setup_loop_nested_struct_array,
    ),
    uniform_tex("sampler", UNIFORM_SAMPLER, eval_brick_coords, setup_sampler),
    uniform_tex(
        "sampler_nested",
        UNIFORM_SAMPLER_NESTED,
        eval_brick_coords,
        setup_sampler_nested,
    ),
    uniform_tex(
        "sampler_array",
        UNIFORM_SAMPLER_ARRAY,
        eval_brick_coords,
        setup_sampler_array,
    ),
    uniform_tex(
        "sampler_in_function_arg",
        UNIFORM_SAMPLER_IN_FUNCTION_ARG,
        eval_brick_center,
        setup_sampler_in_function_arg,
    ),
    uniform_tex(
        "sampler_in_array_function_arg",
        UNIFORM_SAMPLER_IN_ARRAY_FUNCTION_ARG,
        eval_brick_center,
        setup_sampler_in_array_function_arg,
    ),
    uniform("equal", UNIFORM_EQUAL, eval_uniform_equal, setup_equality),
    uniform("not_equal", UNIFORM_NOT_EQUAL, eval_uniform_not_equal, setup_equality),
];

fn add_cases(group: &mut TestCaseGroup, cases: &'static [StructCase]) {
    for case in cases {
        for is_vertex_case in [true, false] {
            let suffix = if is_vertex_case { "vertex" } else { "fragment" };
            group.add_child(create_struct_case(
                &format!("{}_{suffix}", case.name),
                is_vertex_case,
                case.eval_func,
                case.setup_uniforms,
                case.shader_src,
                case.additional_params,
                case.uses_texture,
            ));
        }
    }
}

/// `ShaderStructTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("struct");

    let mut local_group = TestCaseGroup::new("local");
    add_cases(&mut local_group, LOCAL_CASES);
    group.add_child(local_group);

    let mut uniform_group = TestCaseGroup::new("uniform");
    add_cases(&mut uniform_group, UNIFORM_CASES);
    group.add_child(uniform_group);

    group
}
