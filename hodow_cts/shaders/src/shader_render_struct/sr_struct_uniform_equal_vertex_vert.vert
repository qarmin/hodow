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
