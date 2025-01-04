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
