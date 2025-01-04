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
