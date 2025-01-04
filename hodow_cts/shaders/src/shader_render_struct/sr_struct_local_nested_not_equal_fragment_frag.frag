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
