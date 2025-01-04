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
