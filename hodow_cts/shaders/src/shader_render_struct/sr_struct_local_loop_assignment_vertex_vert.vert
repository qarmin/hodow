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
