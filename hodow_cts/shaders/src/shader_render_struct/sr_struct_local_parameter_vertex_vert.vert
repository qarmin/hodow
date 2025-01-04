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
