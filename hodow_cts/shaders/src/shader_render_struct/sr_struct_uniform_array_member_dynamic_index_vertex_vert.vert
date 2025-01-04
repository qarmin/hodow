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
