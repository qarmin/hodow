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
