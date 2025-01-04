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
