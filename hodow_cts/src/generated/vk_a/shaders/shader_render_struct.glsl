#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, vec3(0.0), ui_one);
    s.b = a_coords.yzw;
    v_color = vec4(s.a, s.b.x, s.b.y, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = v_color;
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_coords;

void main (void)
{
    v_coords = a_coords;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, vec3(0.0), ui_one);
    s.b = v_coords.yzw;
    o_color = vec4(s.a, s.b.x, s.b.y, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, a_coords.yz);
    v_color = vec4(s.a, s.b.b, s.b.a + s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, v_coords.yz);
    o_color = vec4(s.a, s.b.b, s.b.a + s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};

void main (void)
{
    S s;
    s.a = a_coords.w;
    s.c = ui_one;
    s.b[0] = a_coords.z;
    s.b[1] = a_coords.y;
    s.b[2] = a_coords.x;
    v_color = vec4(s.a, s.b[0], s.b[1], s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};

void main (void)
{
    S s;
    s.a = v_coords.w;
    s.c = ui_one;
    s.b[0] = v_coords.z;
    s.b[1] = v_coords.y;
    s.b[2] = v_coords.x;
    o_color = vec4(s.a, s.b[0], s.b[1], s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};

void main (void)
{
    S s;
    s.a = a_coords.w;
    s.c = ui_one;
    s.b[0] = a_coords.z;
    s.b[1] = a_coords.y;
    s.b[2] = a_coords.x;
    v_color = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};

void main (void)
{
    S s;
    s.a = v_coords.w;
    s.c = ui_one;
    s.b[0] = v_coords.z;
    s.b[1] = v_coords.y;
    s.b[2] = v_coords.x;
    o_color = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(a_coords.x, ui_zero);
    s[1].a = a_coords.y;
    s[1].b = ui_one;
    s[2] = S(a_coords.z, ui_two);
    v_color = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(v_coords.x, ui_zero);
    s[1].a = v_coords.y;
    s[1].b = ui_one;
    s[2] = S(v_coords.z, ui_two);
    o_color = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(a_coords.x, ui_zero);
    s[1].a = a_coords.y;
    s[1].b = ui_one;
    s[2] = S(a_coords.z, ui_two);
    v_color = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(v_coords.x, ui_zero);
    s[1].a = v_coords.y;
    s[1].b = ui_one;
    s[2] = S(v_coords.z, ui_two);
    o_color = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = a_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = a_coords.xy;
    s[0].b[0].b[1] = a_coords.zw;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = a_coords.zw;
    s[0].b[1].b[1] = a_coords.xy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = a_coords.xz;
    s[0].b[2].b[1] = a_coords.yw;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = a_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = a_coords.xx;
    s[1].b[0].b[1] = a_coords.yy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = a_coords.zz;
    s[1].b[1].b[1] = a_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = a_coords.yx;
    s[1].b[2].b[1] = a_coords.wz;
    s[1].c         = ui_one;

    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4
    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333
    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0
    v_color = vec4(r, g, b, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = v_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = v_coords.xy;
    s[0].b[0].b[1] = v_coords.zw;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = v_coords.zw;
    s[0].b[1].b[1] = v_coords.xy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = v_coords.xz;
    s[0].b[2].b[1] = v_coords.yw;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = v_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = v_coords.xx;
    s[1].b[0].b[1] = v_coords.yy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = v_coords.zz;
    s[1].b[1].b[1] = v_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = v_coords.yx;
    s[1].b[2].b[1] = v_coords.wz;
    s[1].c         = ui_one;

    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4
    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333
    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0
    o_color = vec4(r, g, b, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = a_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = a_coords.xy;
    s[0].b[0].b[1] = a_coords.zw;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = a_coords.zw;
    s[0].b[1].b[1] = a_coords.xy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = a_coords.xz;
    s[0].b[2].b[1] = a_coords.yw;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = a_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = a_coords.xx;
    s[1].b[0].b[1] = a_coords.yy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = a_coords.zz;
    s[1].b[1].b[1] = a_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = a_coords.yx;
    s[1].b[2].b[1] = a_coords.wz;
    s[1].c         = ui_one;

    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4
    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333
    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0
    v_color = vec4(r, g, b, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = v_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = v_coords.xy;
    s[0].b[0].b[1] = v_coords.zw;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = v_coords.zw;
    s[0].b[1].b[1] = v_coords.xy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = v_coords.xz;
    s[0].b[2].b[1] = v_coords.yw;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = v_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = v_coords.xx;
    s[1].b[0].b[1] = v_coords.yy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = v_coords.zz;
    s[1].b[1].b[1] = v_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = v_coords.yx;
    s[1].b[2].b[1] = v_coords.wz;
    s[1].c         = ui_one;

    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4
    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333
    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0
    o_color = vec4(r, g, b, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

mediump vec4 myFunc (S s)
{
    return vec4(s.a, s.b.x, s.b.y, s.c);
}

void main (void)
{
    S s = S(a_coords.x, vec3(0.0), ui_one);
    s.b = a_coords.yzw;
    v_color = myFunc(s);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

mediump vec4 myFunc (S s)
{
    return vec4(s.a, s.b.x, s.b.y, s.c);
}

void main (void)
{
    S s = S(v_coords.x, vec3(0.0), ui_one);
    s.b = v_coords.yzw;
    o_color = myFunc(s);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

mediump vec4 myFunc (S s)
{
    return vec4(s.a, s.b.b, s.b.a + s.c);
}

void main (void)
{
    S s = S(a_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, a_coords.yz);
    v_color = myFunc(s);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

mediump vec4 myFunc (S s)
{
    return vec4(s.a, s.b.b, s.b.a + s.c);
}

void main (void)
{
    S s = S(v_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, v_coords.yz);
    o_color = myFunc(s);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

S myFunc (void)
{
    S s = S(a_coords.x, vec3(0.0), ui_one);
    s.b = a_coords.yzw;
    return s;
}

void main (void)
{
    S s = myFunc();
    v_color = vec4(s.a, s.b.x, s.b.y, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

S myFunc (void)
{
    S s = S(v_coords.x, vec3(0.0), ui_one);
    s.b = v_coords.yzw;
    return s;
}

void main (void)
{
    S s = myFunc();
    o_color = vec4(s.a, s.b.x, s.b.y, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

S myFunc (void)
{
    S s = S(a_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, a_coords.yz);
    return s;
}

void main (void)
{
    S s = myFunc();
    v_color = vec4(s.a, s.b.b, s.b.a + s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

S myFunc (void)
{
    S s = S(v_coords.x, T(0, vec2(0.0)), ui_one);
    s.b = T(ui_zero, v_coords.yz);
    return s;
}

void main (void)
{
    S s = myFunc();
    o_color = vec4(s.a, s.b.b, s.b.a + s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, a_coords.yzw, ui_zero);
    if (uf_one > 0.0)
        s = S(a_coords.w, a_coords.zyx, ui_one);
    v_color = vec4(s.a, s.b.xy, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, v_coords.yzw, ui_zero);
    if (uf_one > 0.0)
        s = S(v_coords.w, v_coords.zyx, ui_one);
    o_color = vec4(s.a, s.b.xy, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, a_coords.yzw, ui_zero);
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
            s = S(a_coords.w, a_coords.zyx, ui_one);
    }
    v_color = vec4(s.a, s.b.xy, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, v_coords.yzw, ui_zero);
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
            s = S(v_coords.w, v_coords.zyx, ui_one);
    }
    o_color = vec4(s.a, s.b.xy, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_three; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, a_coords.yzw, ui_zero);
    for (int i = 0; i < ui_three; i++)
    {
        if (i == ui_one)
            s = S(a_coords.w, a_coords.zyx, ui_one);
    }
    v_color = vec4(s.a, s.b.xy, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_three; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, v_coords.yzw, ui_zero);
    for (int i = 0; i < ui_three; i++)
    {
        if (i == ui_one)
            s = S(v_coords.w, v_coords.zyx, ui_one);
    }
    o_color = vec4(s.a, s.b.xy, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, T(ui_one, a_coords.yz), ui_one);
    if (uf_one > 0.0)
        s.b = T(ui_zero, a_coords.zw);
    v_color = vec4(s.a, s.b.b, s.c - s.b.a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, T(ui_one, v_coords.yz), ui_one);
    if (uf_one > 0.0)
        s.b = T(ui_zero, v_coords.zw);
    o_color = vec4(s.a, s.b.b, s.c - s.b.a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, T(ui_one, a_coords.yz), ui_one);
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
            s.b = T(ui_zero, a_coords.zw);
    }
    v_color = vec4(s.a, s.b.b, s.c - s.b.a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, T(ui_one, v_coords.yz), ui_one);
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
            s.b = T(ui_zero, v_coords.zw);
    }
    o_color = vec4(s.a, s.b.b, s.c - s.b.a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_three; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(a_coords.x, T(ui_one, a_coords.yz), ui_one);
    for (int i = 0; i < ui_three; i++)
    {
        if (i == ui_one)
            s.b = T(ui_zero, a_coords.zw);
    }
    v_color = vec4(s.a, s.b.b, s.c - s.b.a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_three; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S s = S(v_coords.x, T(ui_one, v_coords.yz), ui_one);
    for (int i = 0; i < ui_three; i++)
    {
        if (i == ui_one)
            s.b = T(ui_zero, v_coords.zw);
    }
    o_color = vec4(s.a, s.b.b, s.c - s.b.a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(a_coords.x, ui_zero);
    s[1].a = a_coords.y;
    s[1].b = -ui_one;
    s[2] = S(a_coords.z, ui_two);

    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < 3; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    v_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(v_coords.x, ui_zero);
    s[1].a = v_coords.y;
    s[1].b = -ui_one;
    s[2] = S(v_coords.z, ui_two);

    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < 3; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    o_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = a_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = a_coords.yx;
    s[0].b[0].b[1] = a_coords.zx;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = a_coords.yy;
    s[0].b[1].b[1] = a_coords.wy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = a_coords.zx;
    s[0].b[2].b[1] = a_coords.zy;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = a_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = a_coords.zx;
    s[1].b[0].b[1] = a_coords.zy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = a_coords.zz;
    s[1].b[1].b[1] = a_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = a_coords.yx;
    s[1].b[2].b[1] = a_coords.wz;
    s[1].c         = ui_one;

    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    v_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    // S[0]
    s[0].a         = v_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = v_coords.yx;
    s[0].b[0].b[1] = v_coords.zx;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = v_coords.yy;
    s[0].b[1].b[1] = v_coords.wy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = v_coords.zx;
    s[0].b[2].b[1] = v_coords.zy;
    s[0].c         = ui_zero;

    // S[1]
    s[1].a         = v_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = v_coords.zx;
    s[1].b[0].b[1] = v_coords.zy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = v_coords.zz;
    s[1].b[1].b[1] = v_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = v_coords.yx;
    s[1].b[2].b[1] = v_coords.wz;
    s[1].c         = ui_one;

    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    o_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(a_coords.x, ui_zero);
    s[1].a = a_coords.y;
    s[1].b = -ui_one;
    s[2] = S(a_coords.z, ui_two);

    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < ui_three; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    v_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };

struct S {
    mediump float    a;
    mediump int        b;
};

void main (void)
{
    S s[3];
    s[0] = S(v_coords.x, ui_zero);
    s[1].a = v_coords.y;
    s[1].b = -ui_one;
    s[2] = S(v_coords.z, ui_two);

    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < ui_three; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    o_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_two; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_three; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_four; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_half; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_third; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 10) uniform buffer10 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    s[0].a         = a_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = a_coords.yx;
    s[0].b[0].b[1] = a_coords.zx;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = a_coords.yy;
    s[0].b[1].b[1] = a_coords.wy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = a_coords.zx;
    s[0].b[2].b[1] = a_coords.zy;
    s[0].c         = ui_zero;

    s[1].a         = a_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = a_coords.zx;
    s[1].b[0].b[1] = a_coords.zy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = a_coords.zz;
    s[1].b[1].b[1] = a_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = a_coords.yx;
    s[1].b[2].b[1] = a_coords.wz;
    s[1].c         = ui_one;

    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < ui_two; i++)
    {
        for (int j = 0; j < ui_three; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    v_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_two; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_three; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_four; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_half; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_third; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 10) uniform buffer10 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};

void main (void)
{
    S s[2];

    s[0].a         = v_coords.x;
    s[0].b[0].a    = uf_half;
    s[0].b[0].b[0] = v_coords.yx;
    s[0].b[0].b[1] = v_coords.zx;
    s[0].b[1].a    = uf_third;
    s[0].b[1].b[0] = v_coords.yy;
    s[0].b[1].b[1] = v_coords.wy;
    s[0].b[2].a    = uf_fourth;
    s[0].b[2].b[0] = v_coords.zx;
    s[0].b[2].b[1] = v_coords.zy;
    s[0].c         = ui_zero;

    s[1].a         = v_coords.w;
    s[1].b[0].a    = uf_two;
    s[1].b[0].b[0] = v_coords.zx;
    s[1].b[0].b[1] = v_coords.zy;
    s[1].b[1].a    = uf_three;
    s[1].b[1].b[0] = v_coords.zz;
    s[1].b[1].b[1] = v_coords.ww;
    s[1].b[2].a    = uf_four;
    s[1].b[2].b[0] = v_coords.yx;
    s[1].b[2].b[1] = v_coords.wz;
    s[1].c         = ui_one;

    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < ui_two; i++)
    {
        for (int j = 0; j < ui_three; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    o_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S a = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y), 2.3), ui_one);
    S b = S(floor(a_coords.x+0.5), vec3(0.0, floor(a_coords.y), 2.3), ui_one);
    S c = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y+0.5), 2.3), ui_one);
    S d = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y), 2.3), ui_two);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) v_color.x = 1.0;
    if (a == c) v_color.y = 1.0;
    if (a == d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S a = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y), 2.3), ui_one);
    S b = S(floor(v_coords.x+0.5), vec3(0.0, floor(v_coords.y), 2.3), ui_one);
    S c = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y+0.5), 2.3), ui_one);
    S d = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y), 2.3), ui_two);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) o_color.x = 1.0;
    if (a == c) o_color.y = 1.0;
    if (a == d) o_color.z = 1.0;
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S a = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y), 2.3), ui_one);
    S b = S(floor(a_coords.x+0.5), vec3(0.0, floor(a_coords.y), 2.3), ui_one);
    S c = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y+0.5), 2.3), ui_one);
    S d = S(floor(a_coords.x), vec3(0.0, floor(a_coords.y), 2.3), ui_two);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) v_color.x = 1.0;
    if (a != c) v_color.y = 1.0;
    if (a != d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};

void main (void)
{
    S a = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y), 2.3), ui_one);
    S b = S(floor(v_coords.x+0.5), vec3(0.0, floor(v_coords.y), 2.3), ui_one);
    S c = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y+0.5), 2.3), ui_one);
    S d = S(floor(v_coords.x), vec3(0.0, floor(v_coords.y), 2.3), ui_two);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) o_color.x = 1.0;
    if (a != c) o_color.y = 1.0;
    if (a != d) o_color.z = 1.0;
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct T {
    mediump vec3    a;
    int                b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S a = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y), 2.3), ui_one), 1);
    S b = S(floor(a_coords.x+0.5), T(vec3(0.0, floor(a_coords.y), 2.3), ui_one), 1);
    S c = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y+0.5), 2.3), ui_one), 1);
    S d = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y), 2.3), ui_two), 1);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) v_color.x = 1.0;
    if (a == c) v_color.y = 1.0;
    if (a == d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct T {
    mediump vec3    a;
    int                b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S a = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y), 2.3), ui_one), 1);
    S b = S(floor(v_coords.x+0.5), T(vec3(0.0, floor(v_coords.y), 2.3), ui_one), 1);
    S c = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y+0.5), 2.3), ui_one), 1);
    S d = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y), 2.3), ui_two), 1);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) o_color.x = 1.0;
    if (a == c) o_color.y = 1.0;
    if (a == d) o_color.z = 1.0;
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct T {
    mediump vec3    a;
    int                b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S a = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y), 2.3), ui_one), 1);
    S b = S(floor(a_coords.x+0.5), T(vec3(0.0, floor(a_coords.y), 2.3), ui_one), 1);
    S c = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y+0.5), 2.3), ui_one), 1);
    S d = S(floor(a_coords.x), T(vec3(0.0, floor(a_coords.y), 2.3), ui_two), 1);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) v_color.x = 1.0;
    if (a != c) v_color.y = 1.0;
    if (a != d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct T {
    mediump vec3    a;
    int                b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};

void main (void)
{
    S a = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y), 2.3), ui_one), 1);
    S b = S(floor(v_coords.x+0.5), T(vec3(0.0, floor(v_coords.y), 2.3), ui_one), 1);
    S c = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y+0.5), 2.3), ui_one), 1);
    S d = S(floor(v_coords.x), T(vec3(0.0, floor(v_coords.y), 2.3), ui_two), 1);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) o_color.x = 1.0;
    if (a != c) o_color.y = 1.0;
    if (a != d) o_color.z = 1.0;
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 1) uniform buffer1 { S s; };

void main (void)
{
    v_color = vec4(s.a, s.b.x, s.b.y, s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 1) uniform buffer1 { S s; };

void main (void)
{
    o_color = vec4(s.a, s.b.x, s.b.y, s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S s; };

void main (void)
{
    v_color = vec4(s.a, s.b.b, s.b.a + s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };

struct T {
    int                a;
    mediump vec2    b;
};
struct S {
    mediump float    a;
    T                b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S s; };

void main (void)
{
    o_color = vec4(s.a, s.b.b, s.b.a + s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};
layout (std140, set = 0, binding = 1) uniform buffer1 { S s; };

void main (void)
{
    v_color = vec4(s.a, s.b[0], s.b[1], s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_one; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};
layout (std140, set = 0, binding = 1) uniform buffer1 { S s; };

void main (void)
{
    o_color = vec4(s.a, s.b[0], s.b[1], s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s; };

void main (void)
{
    v_color = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump float    b[3];
    int                c;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s; };

void main (void)
{
    o_color = vec4(s.b[ui_one], s.b[ui_zero], s.b[ui_two], s.c);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    v_color = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    o_color = vec4(s[2].a, s[1].a, s[0].a, s[2].b - s[1].b + s[0].b);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    v_color = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    o_color = vec4(s[ui_two].a, s[ui_one].a, s[ui_zero].a, s[ui_two].b - s[ui_one].b + s[ui_zero].b);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 0) uniform buffer0 { S s[2]; };

void main (void)
{
    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4
    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333
    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0
    v_color = vec4(r, g, b, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 0) uniform buffer0 { S s[2]; };

void main (void)
{
    mediump float r = (s[0].b[1].b[0].x + s[1].b[2].b[1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[1].b[0].b[0].y * s[0].b[2].a * s[1].b[2].a; // x * 0.25 * 4
    mediump float b = (s[0].b[2].b[1].y + s[0].b[1].b[0].y + s[1].a) * s[0].b[1].a; // (w + w + w) * 0.333
    mediump float a = float(s[0].c) + s[1].b[2].a - s[1].b[1].a; // 0 + 4.0 - 3.0
    o_color = vec4(r, g, b, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (set = 0, binding = 3) uniform buffer3 { S s[2]; };

void main (void)
{
    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4
    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333
    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0
    v_color = vec4(r, g, b, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (set = 0, binding = 3) uniform buffer3 { S s[2]; };

void main (void)
{
    mediump float r = (s[0].b[ui_one].b[ui_one-1].x + s[ui_one].b[ui_two].b[ui_zero+1].y) * s[0].b[0].a; // (z + z) * 0.5
    mediump float g = s[ui_two-1].b[ui_two-2].b[ui_zero].y * s[0].b[ui_two].a * s[ui_one].b[2].a; // x * 0.25 * 4
    mediump float b = (s[ui_zero].b[ui_one+1].b[1].y + s[0].b[ui_one*ui_one].b[0].y + s[ui_one].a) * s[0].b[ui_two-ui_one].a; // (w + w + w) * 0.333
    mediump float a = float(s[ui_zero].c) + s[ui_one-ui_zero].b[ui_two].a - s[ui_zero+ui_one].b[ui_two-ui_one].a; // 0 + 4.0 - 3.0
    o_color = vec4(r, g, b, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < 3; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    v_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 3) uniform buffer3 { S s[3]; };

void main (void)
{
    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < 3; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    o_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 10) uniform buffer10 { S s[2]; };

void main (void)
{
    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    v_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { mediump float uf_two; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_three; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_four; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_half; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_third; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 10) uniform buffer10 { S s[2]; };

void main (void)
{
    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    o_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 4) uniform buffer4 { S s[3]; };

void main (void)
{
    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < ui_three; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    v_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };

struct S {
    mediump float    a;
    mediump int        b;
};
layout (std140, set = 0, binding = 4) uniform buffer4 { S s[3]; };

void main (void)
{
    mediump float rgb[3];
    int alpha = 0;
    for (int i = 0; i < ui_three; i++)
    {
        rgb[i] = s[2-i].a;
        alpha += s[i].b;
    }
    o_color = vec4(rgb[0], rgb[1], rgb[2], alpha);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_two; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_three; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_four; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_half; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_third; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 10) uniform buffer10 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 11) uniform buffer11 { S s[2]; };

void main (void)
{
    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < ui_two; i++)
    {
        for (int j = 0; j < ui_three; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    v_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { int ui_zero; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_one; };
layout (std140, set = 0, binding = 2) uniform buffer2 { int ui_two; };
layout (std140, set = 0, binding = 3) uniform buffer3 { int ui_three; };
layout (std140, set = 0, binding = 4) uniform buffer4 { mediump float uf_two; };
layout (std140, set = 0, binding = 5) uniform buffer5 { mediump float uf_three; };
layout (std140, set = 0, binding = 6) uniform buffer6 { mediump float uf_four; };
layout (std140, set = 0, binding = 7) uniform buffer7 { mediump float uf_half; };
layout (std140, set = 0, binding = 8) uniform buffer8 { mediump float uf_third; };
layout (std140, set = 0, binding = 9) uniform buffer9 { mediump float uf_fourth; };
layout (std140, set = 0, binding = 10) uniform buffer10 { mediump float uf_sixth; };

struct T {
    mediump float    a;
    mediump vec2    b[2];
};
struct S {
    mediump float    a;
    T                b[3];
    int                c;
};
layout (std140, set = 0, binding = 11) uniform buffer11 { S s[2]; };

void main (void)
{
    mediump float r = 0.0; // (x*3 + y*3) / 6.0
    mediump float g = 0.0; // (y*3 + z*3) / 6.0
    mediump float b = 0.0; // (z*3 + w*3) / 6.0
    mediump float a = 1.0;
    for (int i = 0; i < ui_two; i++)
    {
        for (int j = 0; j < ui_three; j++)
        {
            r += s[0].b[j].b[i].y;
            g += s[i].b[j].b[0].x;
            b += s[i].b[j].b[1].x;
            a *= s[i].b[j].a;
        }
    }
    o_color = vec4(r*uf_sixth, g*uf_sixth, b*uf_sixth, a);
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { mediump float uf_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S a; };
layout (std140, set = 0, binding = 3) uniform buffer3 { S b; };
layout (std140, set = 0, binding = 4) uniform buffer4 { S c; };

void main (void)
{
    S d = S(uf_one, vec3(0.0, floor(a_coords.y+1.0), 2.0), ui_two);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) v_color.x = 1.0;
    if (a == c) v_color.y = 1.0;
    if (a == d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { mediump float uf_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S a; };
layout (std140, set = 0, binding = 3) uniform buffer3 { S b; };
layout (std140, set = 0, binding = 4) uniform buffer4 { S c; };

void main (void)
{
    S d = S(uf_one, vec3(0.0, floor(v_coords.y+1.0), 2.0), ui_two);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a == b) o_color.x = 1.0;
    if (a == c) o_color.y = 1.0;
    if (a == d) o_color.z = 1.0;
    
}
#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { mediump float uf_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S a; };
layout (std140, set = 0, binding = 3) uniform buffer3 { S b; };
layout (std140, set = 0, binding = 4) uniform buffer4 { S c; };

void main (void)
{
    S d = S(uf_one, vec3(0.0, floor(a_coords.y+1.0), 2.0), ui_two);
    v_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) v_color.x = 1.0;
    if (a != c) v_color.y = 1.0;
    if (a != d) v_color.z = 1.0;
    gl_Position = a_position;
}
#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout (std140, set = 0, binding = 0) uniform buffer0 { mediump float uf_one; };
layout (std140, set = 0, binding = 1) uniform buffer1 { int ui_two; };

struct S {
    mediump float    a;
    mediump vec3    b;
    int                c;
};
layout (std140, set = 0, binding = 2) uniform buffer2 { S a; };
layout (std140, set = 0, binding = 3) uniform buffer3 { S b; };
layout (std140, set = 0, binding = 4) uniform buffer4 { S c; };

void main (void)
{
    S d = S(uf_one, vec3(0.0, floor(v_coords.y+1.0), 2.0), ui_two);
    o_color = vec4(0.0, 0.0, 0.0, 1.0);
    if (a != b) o_color.x = 1.0;
    if (a != c) o_color.y = 1.0;
    if (a != d) o_color.z = 1.0;
    
}
